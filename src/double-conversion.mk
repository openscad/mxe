# This file is part of MXE.
# See index.html for further information.

PKG             := double-conversion
$(PKG)_WEBSITE  := https://github.com/google/double-conversion/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.1.5
$(PKG)_CHECKSUM := a63ecb93182134ba4293fd5f22d6e08ca417caafa244afaa751cbfddf6415b13
$(PKG)_GH_CONF  := google/double-conversion/tags, v
$(PKG)_DEPS     :=

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_TESTING=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
