# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := tbb
$(PKG)_WEBSITE  := https://www.threadingbuildingblocks.org
$(PKG)_DESCR    := oneAPI Threading Building Blocks
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2021.11.0
$(PKG)_CHECKSUM := 782ce0cab62df9ea125cdea253a50534862b563f1d85d4cda7ad4e77550ac363
$(PKG)_GH_CONF  := oneapi-src/oneTBB/tags,v
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc

$(PKG)_DEPS_$(BUILD) :=
$(PKG)_OO_DEPS_$(BUILD) := $(MXE_CONF_PKGS)

define $(PKG)_BUILD
    # build and install the library
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DTBB_STRICT=OFF \
        -DTBB_BUILD_SHARED=$(CMAKE_SHARED_BOOL) \
        -DTBB_BUILD_STATIC=$(CMAKE_STATIC_BOOL) \
        -DTBB_BUILD_TESTS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # compile test 
    '$(TARGET)-g++' -W -Wall \
        '$(SOURCE_DIR)/examples/test_all/fibonacci/fibonacci.cpp' \
        -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        `'$(TARGET)-pkg-config' $(PKG) --cflags --libs`
endef
