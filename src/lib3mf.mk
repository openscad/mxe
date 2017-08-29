# This file is part of MXE.
# See index.html for further information.

PKG             := lib3mf
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := git
$(PKG)_CHECKSUM := 85c4992137837ef77ee0d0bfe2e2f1653f36dc1358e313b4c91313dde237d770
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/t-paul/lib3mf/archive/openscad-build/lib3mf-openscad-build.tar.gz
$(PKG)_SUBDIR   := lib3mf-openscad-build
$(PKG)_DEPS     := gcc

define $(PKG)_BUILD
    mkdir '$(1).build'
    echo -e '#pragma GCC system_header\n#define VS_VERSION_INFO 1\n#define IDC_STATIC (-1)\n#include <winresrc.h>' > '$(1).build/winres.h'
    cd '$(1).build' && '$(TARGET)-cmake' -DLIB3MF_TESTS=FALSE -DLIB3MF_BUILD_TYPE=STATIC '$(1)'
    $(MAKE) -C '$(1).build' -j '$(JOBS)'
    $(MAKE) -C '$(1).build' -j 1 install
endef
