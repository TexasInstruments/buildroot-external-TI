Texas Instuments SK-AM62P Test and Development Board

Description
===========

This configuration will build a complete image for the TI SK-AM62P
board using TI sources: https://www.ti.com/tool/SK-AM62P-LP.

How to Build
============

Select the default configuration for the target:

For non-RT linux build
$ make ti_release_am62p_sk_defconfig

For RT linux build
$ make ti_release_am62p_sk_rt_defconfig

Optional: modify the configuration:

$ make menuconfig

IMPORTANT: make sure to use the tiboot3 firmware that match with the TI
K3 SoC boot ROM (tiboot3-am62px-{gp/hs-fs/hs}-*.bin) used on the board.

HS-FS should be the default for all TI AM6x devices.

Build:

$ make

To copy the resulting output image file to an SD card use dd:

$ dd if=output/images/sdcard.img of=/dev/sdX bs=1M

How to Run
==========

Insert the SD card into the SK-AM62P board, and power it up through the
USB Type-C connector. The system should come up. You can use a
micro-USB cable to connect to the connector labeled UART to
communicate with the board.
