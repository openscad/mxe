# This file is part of MXE.
# See index.html for further information.

PKG             := double-conversion
$(PKG)_WEBSITE  := https://github.com/google/double-conversion/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.2.0
$(PKG)_CHECKSUM := 3dbcdf186ad092a8b71228a5962009b5c96abde9a315257a3452eb988414ea3b
$(PKG)_GH_CONF  := google/double-conversion/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_TESTING=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
