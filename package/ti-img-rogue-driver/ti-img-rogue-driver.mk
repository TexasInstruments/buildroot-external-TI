################################################################################
#
# ti-img-rogue-driver - PowerVR Rogue GPU kernel module
#
################################################################################

# Package metadata
# Pinned commit is on branch linuxws/scarthgap/k6.12/25.2.6850647
TI_IMG_ROGUE_DRIVER_VERSION = 	50e14e425cbac240b2da93fac0cfcc987a4959c3

# Source repository
TI_IMG_ROGUE_DRIVER_SITE = https://git.ti.com/git/graphics/ti-img-rogue-driver.git
TI_IMG_ROGUE_DRIVER_SITE_METHOD = git

# License information (Dual MIT/GPLv2)
TI_IMG_ROGUE_DRIVER_LICENSE = MIT,GPL-2.0
TI_IMG_ROGUE_DRIVER_LICENSE_FILES = MIT-COPYING GPL-COPYING

# Only dependency is the kernel itself
TI_IMG_ROGUE_DRIVER_DEPENDENCIES = linux

################################################################################
# Build instructions
################################################################################

# Determine build type
ifeq ($(BR2_PACKAGE_TI_IMG_ROGUE_DRIVER_DEBUG),y)
	PVR_BUILD = debug
else
	PVR_BUILD = release
endif

PVR_BUILD_DIR = am62_linux
PVR_WS = lws-generic

# $(LINUX_MAKE_FLAGS) supplies ARCH/CROSS_COMPILE matched to how the
# kernel itself was built. The root Makefile requires PVR_BUILD_DIR to be
# set; it invokes build/linux/$(PVR_BUILD_DIR)/Makefile, which generates
# config_kernel.mk/.h and invokes kbuild itself, producing
# binary_$(PVR_BUILD_DIR)_$(PVR_WS)_$(PVR_BUILD)/ as build output.
TI_IMG_ROGUE_DRIVER_MAKE_OPTS = \
	$(LINUX_MAKE_FLAGS) \
	KERNELDIR=$(LINUX_DIR) \
	BUILD=$(PVR_BUILD) \
	PVR_BUILD_DIR=$(PVR_BUILD_DIR) \
	WINDOW_SYSTEM=$(PVR_WS)

define TI_IMG_ROGUE_DRIVER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TI_IMG_ROGUE_DRIVER_MAKE_OPTS)
endef

# The kbuild directory referenced here only exists after BUILD_CMDS has run.
define TI_IMG_ROGUE_DRIVER_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(LINUX_DIR) \
		M=$(@D)/binary_$(PVR_BUILD_DIR)_$(PVR_WS)_$(PVR_BUILD)/target_aarch64/kbuild \
		INSTALL_MOD_PATH=$(TARGET_DIR) \
		modules_install
endef

$(eval $(generic-package))
