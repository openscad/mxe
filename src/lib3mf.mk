# This file is part of MXE.
# See index.html for further information.

PKG             := lib3mf
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.8.1
$(PKG)_CHECKSUM := 207dd142c9ca86a4fb1a4b2baadbdf579f35e03f9b8bf5c02dae027da5ae9d17
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/3MFConsortium/lib3mf/archive/refs/tags/v$($(PKG)_VERSION).tar.gz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_DEPS     := gcc

define $(PKG)_BUILD
    mkdir '$(1).build'
    echo -e '#pragma GCC system_header\n#define VS_VERSION_INFO 1\n#define IDC_STATIC (-1)\n#include <winresrc.h>' > '$(1).build/winres.h'
    cd '$(1).build' && '$(TARGET)-cmake' -DLIB3MF_TESTS=FALSE -DLIB3MF_BUILD_TYPE=STATIC '$(1)'
    $(MAKE) -C '$(1).build' -j '$(JOBS)'
    $(MAKE) -C '$(1).build' -j 1 install
endef
