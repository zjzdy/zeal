TEMPLATE = app

QT += gui gui-private widgets sql
CONFIG += c++11

webengine {
    QT += webenginewidgets
    DEFINES += USE_WEBENGINE
} else {
    QT += webkitwidgets
}

# TODO: Obtain version number from Git tags
VERSION = $$(ZEAL_VERSION)
isEmpty(VERSION) {
    VERSION = 0.0.0
}
DEFINES += ZEAL_VERSION=\\\"$${VERSION}\\\"

SOURCES += \
    main.cpp

include(core/core.pri)
include(registry/registry.pri)
include(ui/ui.pri)
include(3rdparty/qxtglobalshortcut/qxtglobalshortcut.pri)

RESOURCES += \
    zeal.qrc

!msvc:LIBS += -lz -L/usr/lib

win32:RC_ICONS = zeal.ico
msvc:QMAKE_LIBS += user32.lib
macx:ICON = zeal.icns

DESTDIR = $$BUILD_ROOT/bin

unix:!macx {
    TARGET = zeal
    isEmpty(PREFIX): PREFIX = /usr
    target.path = $$PREFIX/bin
    INSTALLS = target

    appicons16.files=appicons/16/*
    appicons24.files=appicons/24/*
    appicons32.files=appicons/32/*
    appicons64.files=appicons/64/*
    appicons128.files=appicons/128/*

    appicons16.path=$$PREFIX/share/icons/hicolor/16x16/apps
    appicons24.path=$$PREFIX/share/icons/hicolor/24x24/apps
    appicons32.path=$$PREFIX/share/icons/hicolor/32x32/apps
    appicons64.path=$$PREFIX/share/icons/hicolor/64x64/apps
    appicons128.path=$$PREFIX/share/icons/hicolor/128x128/apps

    desktop.files=zeal.desktop
    desktop.path=$$PREFIX/share/applications

    INSTALLS += appicons16 appicons24 appicons32 appicons64 appicons128 desktop
}

if(win32|macx): TARGET = Zeal

# Keep build directory organised
MOC_DIR = $$BUILD_ROOT/.moc
OBJECTS_DIR = $$BUILD_ROOT/.obj
RCC_DIR = $$BUILD_ROOT/.rcc
UI_DIR = $$BUILD_ROOT/.ui
