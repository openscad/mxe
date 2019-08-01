# This file is part of MXE.
# See index.html for further information.

PKG             := double-conversion
$(PKG)_WEBSITE  := https://github.com/google/double-conversion/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.1.1
$(PKG)_CHECKSUM := c49a6b3fa9c917f827b156c8e0799ece88ae50440487a99fc2f284cfd357a5b9
$(PKG)_GH_CONF  := google/double-conversion/tags, v
$(PKG)_DEPS     :=

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_TESTING=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
