/**
 * Copyright (C) 2017 Willem-Jan de Hoog
 *
 * License: MIT
 */


import QtQuick 2.0
import Sailfish.Silica 1.0

import "../components"
import "../Spotify.js" as Spotify

Page {
    id: searchPage
    objectName: "SearchPage"

    property int searchInType: 0
    property bool showBusy: false
    property string searchString: ""

    allowedOrientations: Orientation.All

    ListModel {
        id: searchModel
    }

    SilicaListView {
        id: listView
        model: searchModel
        anchors.fill: parent
        anchors.topMargin: 0

        header: Column {
            id: lvColumn

            width: parent.width - 2*Theme.paddingMedium
            x: Theme.paddingMedium
            anchors.bottomMargin: Theme.paddingLarge
            spacing: Theme.paddingLarge

            PageHeader {
                id: pHeader
                width: parent.width
                title: qsTr("Search")
                BusyIndicator {
                    id: busyThingy
                    parent: pHeader.extraContent
                    anchors.left: parent.left
                    running: showBusy;
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }

            SearchField {
                id: searchField
                width: parent.width
                placeholderText: qsTr("Search text")
                Binding {
                    target: searchPage
                    property: "searchString"
                    value: searchField.text.toLowerCase().trim()
                }
                EnterKey.onClicked: refresh()
            }

        }

        section.property: "type"
        section.delegate : Component {
            id: sectionHeading
            Item {
                width: parent.width - 2*Theme.paddingMedium
                x: Theme.paddingMedium
                height: childrenRect.height

                Text {
                    width: parent.width
                    text: {
                        switch(section) {
                        case "0": return qsTr("Albums")
                        case "1": return qsTr("Artists")
                        case "2": return qsTr("Playlists")
                        case "3": return qsTr("Tracks")
                        }
                    }
                    font.bold: true
                    font.pixelSize: Theme.fontSizeMedium
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignRight
                }
            }
        }

        delegate: ListItem {
            id: delegate
            width: parent.width - 2*Theme.paddingMedium
            height: searchResultListItem.height
            x: Theme.paddingMedium
            contentHeight: childrenRect.height

            SearchResultListItem {
                id: searchResultListItem
            }

            //onClicked: app.loadStation(model.id, Shoutcast.createInfo(model), tuneinBase)
        }

        VerticalScrollDecorator {}

        Label {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            visible: parent.count == 0
            text: qsTr("Nothing found")
            color: Theme.secondaryColor
        }

    }

    function refresh() {
        var i;
        if(searchString === "")
            return
        showBusy = true
        searchModel.clear()
        Spotify.search(searchString, ['album', 'artist', 'playlist', 'track'], {}, function(data, error) {
            if(data) {
                try {
                    // albums
                    for(i=0;i<data.albums.items.length;i++) {
                        searchModel.append({type: 0,
                                            name: data.albums.items[i].name,
                                            album: data.albums.items[i]})
                    }

                    // artists
                    for(i=0;i<data.artists.items.length;i++) {
                        searchModel.append({type: 1,
                                            name: data.artists.items[i].name,
                                            artist: data.artists.items[i]})
                    }

                    // playlists
                    for(i=0;i<data.playlists.items.length;i++) {
                        searchModel.append({type: 2,
                                            name: data.playlists.items[i].name,
                                            playlist: data.playlists.items[i]})
                    }

                    // tracks
                    for(i=0;i<data.tracks.items.length;i++) {
                        searchModel.append({type: 3,
                                            name: data.tracks.items[i].name,
                                            track: data.tracks.items[i]})
                    }

                } catch (err) {
                    console.log(err)
                }
            } else {
                console.log("Search for: " + searchString + " returned no results.")
            }
            showBusy = false
        })
    }

}
