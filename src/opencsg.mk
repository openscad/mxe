# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := opencsg
$(PKG)_WEBSITE  := http://www.opencsg.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.8.2
$(PKG)_CHECKSUM := 5ac5df73b1ad3340dd6705ff90e009f1a946bb9536c21c2263a6f974265664c0
$(PKG)_SUBDIR   := OpenCSG-$($(PKG)_VERSION)
$(PKG)_FILE     := OpenCSG-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://www.opencsg.org/$($(PKG)_FILE)
$(PKG)_DEPS     := cc freeglut glew qt6-qtbase

$(PKG)_QT_DIR   := qt6

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://www.opencsg.org/#download' | \
    grep 'OpenCSG-' | \
    $(SED) -n 's,.*OpenCSG-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    # BUILD_EXAMPLE uses hardcoded ../freeglut/include/GL/glut.h path
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' -DBUILD_EXAMPLE=OFF '$(SOURCE_DIR)'
    '$(TARGET)-cmake' --build '$(BUILD_DIR)' --config Release --target install
endef
