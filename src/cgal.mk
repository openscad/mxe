# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cgal
$(PKG)_WEBSITE  := https://www.cgal.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.2
$(PKG)_CHECKSUM := 4daa32c14b78391725836d0975906c2d265885c4a6d83d6e1662ff90bf321dcb
# using / in tag name means we have to set SUBDIR, FILE, URL
$(PKG)_GH_CONF  := CGAL/cgal/tags, v
$(PKG)_SUBDIR   := CGAL-$($(PKG)_VERSION)
$(PKG)_FILE     := CGAL-$($(PKG)_VERSION)-library.tar.xz
$(PKG)_URL      := https://github.com/CGAL/cgal/releases/download/v$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc boost gmp mpfr qtbase

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
        -DCGAL_INSTALL_CMAKE_DIR:STRING="lib/CGAL" \
        -DCGAL_INSTALL_INC_DIR:STRING="include" \
        -DCGAL_INSTALL_DOC_DIR:STRING="share/doc/CGAL-$($(PKG)_VERSION)" \
        -DCGAL_INSTALL_BIN_DIR:STRING="bin" \
        -DCGAL_Boost_USE_STATIC_LIBS:BOOL=$(CMAKE_STATIC_BOOL) \
        -DWITH_OpenGL:BOOL=ON \
        -DWITH_ZLIB:BOOL=ON

    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # compile test
    '$(TARGET)-g++' \
        -W -Wall -Werror \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        '-I$(PREFIX)/$(TARGET)/include' \
        '-L$(PREFIX)/$(TARGET)/lib' \
        -lgmp
endef
