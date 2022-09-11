ifneq ($(DIST),centos7)
RPM_SPEC_FILES := i3.spec
endif
NO_ARCHIVE := 1

DEBIAN_BUILD_DIRS := debian-pkg/debian
SOURCE_COPY_IN := source-debian-copy-in

source-debian-copy-in: VERSION = $(shell cat $(ORIG_SRC)/version)
source-debian-copy-in: ORIG_FILE = $(CHROOT_DIR)/$(DIST_SRC)/i3-wm_$(VERSION).orig.tar.xz
source-debian-copy-in: SRC_FILE  = $(ORIG_SRC)/i3-$(VERSION).tar.xz
source-debian-copy-in:
	mkdir -p "$(CHROOT_DIR)/$(DIST_SRC)/debian/patches"
	$(ORIG_SRC)/debian-quilt $(ORIG_SRC)/series-debian.conf $(CHROOT_DIR)/$(DIST_SRC)/debian/patches
	cp -p $(SRC_FILE) $(ORIG_FILE)
	tar jxvf $(SRC_FILE) -C $(CHROOT_DIR)/$(DIST_SRC)/debian-pkg --strip-components=1

# vim: ft=make
