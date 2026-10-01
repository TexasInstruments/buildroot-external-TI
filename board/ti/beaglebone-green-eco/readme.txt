BeagleBone Green Eco - TI Release Buildroot Configuration
==========================================================

Board: BeagleBone Green Eco (BBGECO)
SoC:   Texas Instruments AM335x (Cortex-A8, ARMv7, 1GHz)
RAM:   512MB DDR3L
Flash: 4GB eMMC + microSD slot

This configuration targets the TI SDK-based build for the BeagleBone
Green Eco board using TI's upstream ti-linux-kernel and ti-u-boot.

Boot flow
---------
SD card (or eMMC):
  Partition 1 (FAT, 16M):  MLO + u-boot.img + zImage + DTB + uEnv.txt
  Partition 2 (ext4, 512M): rootfs

Build
-----
  make BR2_EXTERNAL=../buildroot-external-TI \
       ti_release_beaglebone_green_eco_defconfig
  make

Flash to SD card
----------------
  dd if=output/images/tisdk-buildroot-sdcard-image.img of=/dev/sdX bs=4M status=progress

Serial console
--------------
  UART0 via the debug USB/FTDI header, 115200 8N1.

Notes
-----
- AM335x has no PowerVR GPU; GPU packages (ti-img-rogue-*) are not
  included.
- Ethernet (eth0) is configured for DHCP on boot.
- Dropbear SSH is enabled; empty root password allowed (-B flag).
- Kernel source: https://git.ti.com/git/ti-linux-kernel/ti-linux-kernel.git
- U-Boot source: https://git.ti.com/git/ti-u-boot/ti-u-boot.git
