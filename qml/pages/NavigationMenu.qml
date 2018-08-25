/**
 * Copyright (C) 2018 Willem-Jan de Hoog
 *
 * License: MIT
 */


import QtQuick 2.2
import Sailfish.Silica 1.0

import "../Util.js" as Util

Page {

    property bool popOnExit: true
    property int selectedMenuItem: -1
    property int _currentIndex: -1
    property bool _started: false

    ListModel {
        id: menuModel
    }

    Component.onCompleted: {
        /*if(!app.playing_as_attached_page.value)
            menuModel.append({hutspotMenuItem: Util.HutspotMenuItem.ShowPlayingPage,
                              name: qsTr("Playing"),
                              icon: "image://theme/icon-m-music"
                             })*/
        menuModel.append({hutspotMenuItem: Util.HutspotMenuItem.ShowNewReleasePage,
                          name: qsTr("New Releases"),
                          icon: "image://theme/icon-m-health"
                         })
        menuModel.append({hutspotMenuItem: Util.HutspotMenuItem.ShowMyStuffPage,
                          name: qsTr("My Stuff"),
                          icon: "image://theme/icon-m-person" // -events
                         })
        menuModel.append({hutspotMenuItem: Util.HutspotMenuItem.ShowTopStuffPage,
                          name: qsTr("Top Stuff"),
                          icon: "image://theme/icon-m-like"
                         })
        menuModel.append({hutspotMenuItem: Util.HutspotMenuItem.ShowGenreMoodPage,
                          name: qsTr("Genre & Mood"),
                          icon: "image://hutspot-icons/compass"
                         })
        menuModel.append({hutspotMenuItem: Util.HutspotMenuItem.ShowSearchPage,
                          name: qsTr("Search"),
                          icon: "image://theme/icon-m-search"
                         })
        menuModel.append({hutspotMenuItem: Util.HutspotMenuItem.ShowDevicesPage,
                          name: qsTr("Devices"),
                          icon: "image://theme/icon-m-accessory-speaker"
                         })
        menuModel.append({hutspotMenuItem: Util.HutspotMenuItem.ShowSettingsPage,
                          name: qsTr("Settings"),
                          icon: "image://theme/icon-m-developer-mode"
                         })
        menuModel.append({hutspotMenuItem: Util.HutspotMenuItem.ShowAboutPage,
                          name: qsTr("About"),
                          icon: "image://theme/icon-m-about"
                         })
    }

    SilicaListView {
         anchors.fill: parent
         model: menuModel

         header: PageHeader {
             title: qsTr("Menu")
         }

         delegate: ListItem {
             width: parent.width - 2*Theme.paddingLarge
             x: Theme.paddingLarge

             Image {
                 id: image
                 width: Theme.iconSizeMedium
                 height: width
                 anchors.left: parent.left
                 anchors.verticalCenter: parent.verticalCenter
                 fillMode: Image.PreserveAspectFit
                 source: model.icon
             }

             Label {
                 anchors.left: image.right
                 anchors.leftMargin: Theme.paddingLarge
                 anchors.right: parent.right
                 anchors.verticalCenter: parent.verticalCenter
                 color: _currentIndex === index ? Theme.highlightColor : Theme.primaryColor
                 text: model.name
             }

             onPressed: _currentIndex = index
             onReleased:  _currentIndex = 0
             onClicked: {
                 selectedMenuItem = model.hutspotMenuItem
                 closeIt()
             }

         }
         VerticalScrollDecorator {}
    }

    function closeIt() {
        // we want the dialog to be removed from the page stack before
        // the caller acts.
        if(popOnExit)
            pageStack.popAttached(undefined, PageStackAction.Immediate)
        app.doSelectedMenuItem(selectedMenuItem)
    }

    onStatusChanged: {
        // if no action restore attached page
        if(status === PageStatus.Inactive
           && selectedMenuItem === -1
           && _started
           && popOnExit)
            app.setPlayingAsAttachedPage()
        _started = true
    }
}