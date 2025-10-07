FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg file://0001-USXGMII-Fix-Validated-on-board-to-board-setup-ZCU102.patch"
KERNEL_FEATURES:append = " bsp.cfg"
