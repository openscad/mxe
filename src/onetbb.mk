# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := onetbb
$(PKG)_WEBSITE  := https://github.com/uxlfoundation/oneTBB
$(PKG)_DESCR    := oneAPI Threading Building Blocks
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2022.2.0
$(PKG)_CHECKSUM := f0f78001c8c8edb4bddc3d4c5ee7428d56ae313254158ad1eec49eced57f6a5b
$(PKG)_GH_CONF  := uxlfoundation/oneTBB/releases,v
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
