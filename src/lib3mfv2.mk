# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lib3mfv2
$(PKG)_WEBSITE  := http://3mf.io/
$(PKG)_DESCR    := lib3mf is an implementation of the 3D Manufacturing Format file standard
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.5.0
$(PKG)_CHECKSUM := 66772c95359d70012a3e97c3aadfb40564cc2cbcf8a5d4bc64d8144c4cb20fb2
$(PKG)_GH_CONF  := 3MFConsortium/lib3mf/releases,v
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
