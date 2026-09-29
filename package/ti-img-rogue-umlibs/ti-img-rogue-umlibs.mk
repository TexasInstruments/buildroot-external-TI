################################################################################
#
# ti-img-rogue-umlibs - PowerVR Rogue GPU userspace libraries
#
################################################################################

# Package metadata
# Pinned commit is on branch linuxws/scarthgap/k6.12/25.2.6850647
# Must match the ti-img-rogue-driver (KM) version/branch being used.
TI_IMG_ROGUE_UMLIBS_VERSION = a59e0e6b92dfee7aad046b839cf6ae644355b89d

TI_IMG_ROGUE_UMLIBS_SITE = https://git.ti.com/git/graphics/ti-img-rogue-umlibs.git
TI_IMG_ROGUE_UMLIBS_SITE_METHOD = git

# Proprietary TI binary redistribution license (see LICENSE)
TI_IMG_ROGUE_UMLIBS_LICENSE = proprietary
TI_IMG_ROGUE_UMLIBS_LICENSE_FILES = LICENSE

# Must be paired with a matching ti-img-rogue-driver (KM) build
TI_IMG_ROGUE_UMLIBS_DEPENDENCIES = ti-img-rogue-driver

################################################################################
# Install instructions
################################################################################

# No compilation - this repo ships pre-built binaries. The root Makefile's
# "install" target just copies
# targetfs/$(TARGET_PRODUCT)/$(WINDOW_SYSTEM)/$(BUILD)/{etc,usr,lib}
# into DESTDIR.
ifeq ($(BR2_PACKAGE_TI_IMG_ROGUE_UMLIBS_DEBUG),y)
	PVR_UMLIBS_BUILD = debug
else
	PVR_UMLIBS_BUILD = release
endif

define TI_IMG_ROGUE_UMLIBS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) \
		DESTDIR=$(TARGET_DIR) \
		TARGET_PRODUCT=am62_linux \
		WINDOW_SYSTEM=lws-generic \
		BUILD=$(PVR_UMLIBS_BUILD) \
		install
endef

$(eval $(generic-package))
