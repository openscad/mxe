# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := onetbb
$(PKG)_WEBSITE  := https://github.com/uxlfoundation/oneTBB
$(PKG)_DESCR    := oneAPI Threading Building Blocks
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2023.1.0
$(PKG)_CHECKSUM := 191288b52e1e6b17198000b64d77d194bb65e791be46ebc606e9b091781e2070
$(PKG)_GH_CONF  := uxlfoundation/oneTBB/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    # build and install the library
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DTBB_STRICT=OFF \
        -DTBB_TEST=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # compile test
    '$(TARGET)-g++' -W -Wall \
        '$(SOURCE_DIR)/examples/test_all/fibonacci/fibonacci.cpp' \
        -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        `'$(TARGET)-pkg-config' tbb --cflags --libs`
endef
