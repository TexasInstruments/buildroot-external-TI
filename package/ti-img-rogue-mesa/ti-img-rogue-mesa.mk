################################################################################
#
# ti-img-rogue-mesa
#
################################################################################

TI_IMG_ROGUE_MESA_VERSION = 0cb5bad52580f156b02125f4c7121ca7198e1489
TI_IMG_ROGUE_MESA_SITE = https://github.com/TexasInstruments/mesa.git
TI_IMG_ROGUE_MESA_SITE_METHOD = git
TI_IMG_ROGUE_MESA_LICENSE = MIT
TI_IMG_ROGUE_MESA_LICENSE_FILES = docs/license.rst
TI_IMG_ROGUE_MESA_INSTALL_STAGING = YES

TI_IMG_ROGUE_MESA_DEPENDENCIES = \
	host-bison host-flex host-python-mako host-python-pyyaml \
	expat libdrm zlib ti-img-rogue-umlibs

TI_IMG_ROGUE_MESA_PLATFORMS =

ifeq ($(BR2_PACKAGE_WAYLAND),y)
TI_IMG_ROGUE_MESA_DEPENDENCIES += wayland wayland-protocols
TI_IMG_ROGUE_MESA_PLATFORMS += wayland
endif

TI_IMG_ROGUE_MESA_CONF_OPTS = \
	-Dplatforms=$(subst $(space),$(comma),$(TI_IMG_ROGUE_MESA_PLATFORMS)) \
	-Degl=enabled \
	-Dgbm=enabled \
	-Dgles1=enabled \
	-Dgles2=enabled \
	-Dopengl=true \
	-Dglx=disabled \
	-Dgallium-drivers=pvr \
	-Dgallium-pvr-alias=tidss \
	-Dvulkan-drivers=pvr \
	-Dimagination-srv=true \
	-Dxmlconfig=enabled \
	-Dllvm=disabled \
	-Dshared-glapi=enabled

TI_IMG_ROGUE_MESA_PROVIDES = libegl libgbm libgles

$(eval $(meson-package))
