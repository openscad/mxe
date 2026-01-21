# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lib3mf
$(PKG)_WEBSITE  := http://3mf.io/
$(PKG)_DESCR    := lib3mf
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4.1
$(PKG)_CHECKSUM := 081dea66ddd1b958644bfac0fe9a580e63726061459efce5190a10161082f8f7
$(PKG)_GH_CONF  := 3MFConsortium/lib3mf/tags,v,,version
$(PKG)_DEPS     := cc libzip zlib

define $(PKG)_BUILD
    # build and install the library
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
      -DLIB3MF_TESTS=OFF \
      -DUSE_INCLUDED_ZLIB=OFF \
      -DUSE_INCLUDED_LIBZIP=OFF

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
