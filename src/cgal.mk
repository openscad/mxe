# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cgal
$(PKG)_WEBSITE  := https://www.cgal.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6.2.1
$(PKG)_CHECKSUM := 8e7ce1e30e8ffcb3e69d153c3a561bb1f38bbb4becd8e6544cbaa0fb2889af62
$(PKG)_GH_CONF  := CGAL/cgal/releases, v
$(PKG)_SUBDIR   := CGAL-$($(PKG)_VERSION)
$(PKG)_FILE     := CGAL-$($(PKG)_VERSION)-library.tar.xz
$(PKG)_URL      := https://github.com/CGAL/cgal/releases/download/v$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc boost gmp mpfr qt6-qtbase

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
        -DCGAL_INSTALL_CMAKE_DIR:STRING="lib/CGAL" \
        -DCGAL_INSTALL_INC_DIR:STRING="include" \
        -DCGAL_INSTALL_DOC_DIR:STRING="share/doc/CGAL-$($(PKG)_VERSION)" \
        -DCGAL_INSTALL_BIN_DIR:STRING="bin" \
        -DCGAL_Boost_USE_STATIC_LIBS:BOOL=$(CMAKE_STATIC_BOOL) \
        -DWITH_OpenGL:BOOL=ON \
        -DWITH_ZLIB:BOOL=ON \
        -C'$(PWD)/src/cgal-TryRunResults.cmake'

    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
