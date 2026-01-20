# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qt6-qscintilla2
$(PKG)_WEBSITE  := https://www.riverbankcomputing.com/software/qscintilla/intro
$(PKG)_DESCR    := QScintilla2-Qt6
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.14.1
$(PKG)_CHECKSUM := dfe13c6acc9d85dfcba76ccc8061e71a223957a6c02f3c343b30a9d43a4cdd4d
$(PKG)_SUBDIR   := QScintilla_src-$($(PKG)_VERSION)
$(PKG)_FILE     := QScintilla_src-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://www.riverbankcomputing.com/static/Downloads/QScintilla/$($(PKG)_VERSION)/$($(PKG)_FILE)

$(PKG)_DEPS     := cc qt6-qtbase qt6-qt5compat

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://www.riverbankcomputing.com/software/qscintilla/download' | \
    grep QScintilla_src | \
    head -n 1 | \
    $(SED) -n 's,.*QScintilla_src-\([0-9][^>]*\)\.tar.*,\1,p'
endef

define $(PKG)_BUILD
    cd '$(1)/src' && '$(PREFIX)/$(TARGET)/qt6/bin/qmake6' QT+=core5compat qscintilla.pro \
        $(if $(BUILD_STATIC),CONFIG+=staticlib)
    $(MAKE) -C '$(1)/src' -j '$(JOBS)'
    $(MAKE) -C '$(1)/src' -j '$(JOBS)' install
endef
