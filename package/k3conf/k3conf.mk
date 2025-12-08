################################################################################
#
# k3conf
#
################################################################################

K3CONF_VERSION = v0.4
K3CONF_SITE = https://git.ti.com/git/k3conf/k3conf.git
K3CONF_SITE_METHOD = git
K3CONF_LICENSE = BSD-3-Clause
K3CONF_LICENSE_FILES = LICENSE


K3CONF_CONF_OPTS = -DCMAKE_BUILD_TYPE=Release

$(eval $(cmake-package))
