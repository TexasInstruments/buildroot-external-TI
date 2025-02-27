################################################################################
#
# ti-lvlg-demo
#
################################################################################

TI_LVGL_DEMO_VERSION = v11.00.05.02
TI_LVGL_DEMO_SITE = https://github.com/texasinstruments/ti-lvgl-demo.git
TI_LVGL_DEMO_SITE_METHOD = git
TI_LVGL_DEMO_GIT_SUBMODULES = YES
TI_LVGL_DEMO_DEPENDENCIES = libdrm mosquitto alsa-utils
TI_LVGL_DEMO_SUBDIR = lv_port_linux
TI_LVGL_DEMO_LICENSE = MIT
TI_LVGL_DEMO_LICENSE_FILES = LICENSE

TI_LVGL_DEMO_CONF_OPTS += \
	-S=$(@D)/$(TI_LVGL_DEMO_SUBDIR) \
	-DCMAKE_CXX_FLAGS=-O3 \
	-DCMAKE_C_FLAGS=-O3 \
	-DCMAKE_C_FLAGS=-I$(STAGING_DIR)/usr/include/libdrm \
	-DCMAKE_BUILD_TYPE=Release

define TI_LVGL_DEMO_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/$(TI_LVGL_DEMO_SUBDIR)/bin/lvglsim $(TARGET_DIR)/usr/bin
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/
	cp -r $(@D)/$(TI_LVGL_DEMO_SUBDIR)/lvgl/lib/* $(TARGET_DIR)/usr/lib/
	$(INSTALL) -d $(TARGET_DIR)/usr/share/ti-lvgl-demo/assets/
	cp -r $(@D)/$(TI_LVGL_DEMO_SUBDIR)/lvgl/demos/high_res/assets/* $(TARGET_DIR)/usr/share/ti-lvgl-demo/assets/
	$(INSTALL) -d $(TARGET_DIR)/usr/share/ti-lvgl-demo/slides/
	cp -r $(@D)/$(TI_LVGL_DEMO_SUBDIR)/lvgl/demos/high_res/slides/* $(TARGET_DIR)/usr/share/ti-lvgl-demo/slides/
	$(INSTALL) -d $(TARGET_DIR)/usr/share/ti-lvgl-demo/cert/
	cp -r $(@D)/$(TI_LVGL_DEMO_SUBDIR)/certs/* $(TARGET_DIR)/usr/share/ti-lvgl-demo/cert/
endef

$(eval $(cmake-package))
