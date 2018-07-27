# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = hutspot

CONFIG += sailfishapp

SOURCES += \
    src/o2/o0baseauth.cpp \
    src/o2/o0settingsstore.cpp \
    src/o2/o2.cpp \
    src/o2/o2reply.cpp \
    src/o2/o2replyserver.cpp \
    src/o2/o2spotify.cpp \
    src/o2/o2simplecrypt.cpp \
    src/spotify.cpp \
    src/hutspot.cpp

DISTFILES += \
    qml/cover/CoverPage.qml \
    translations/*.ts \
    qml/pages/Search.qml \
    qml/components/SearchResultListItem.qml \
    qml/pages/MyStuff.qml \
    qml/pages/Album.qml \
    qml/pages/Playlist.qml \
    qml/pages/Artist.qml \
    icons/256x256/hutspot.png \
    rpm/hutspot.yaml \
    rpm/hutspot.spec \
    rpm/hutspot.changes.in \
    rpm/hutspot.changes.run.in \
    hutspot.desktop \
    qml/hutspot.qml \
    qml/components/ArtistPicker.qml \
    qml/pages/TopStuff.qml \
    qml/pages/Devices.qml \
    qml/components/Librespot.qml \
    qml/components/MetaInfoPanel.qml \
    qml/components/SearchResultContextMenu.qml \
    qml/components/AlbumTrackContextMenu.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
#TRANSLATIONS += translations/hutspot-de.ts

HEADERS += \
    src/o2/o0abstractstore.h \
    src/o2/o0baseauth.h \
    src/o2/o0export.h \
    src/o2/o0globals.h \
    src/o2/o0requestparameter.h \
    src/o2/o0settingsstore.h \
    src/o2/o0simplecrypt.h \
    src/o2/o2.h \
    src/o2/o2reply.h \
    src/o2/o2replyserver.h \
    src/o2/o2spotify.h \
    src/spotify.h \
    src/IconProvider.h

#QMAKE_LFLAGS += -lavahi-client -lavahi-common
