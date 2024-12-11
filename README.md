# TI Buildroot external tree

Buildroot is a tool/build framework that simplifies and automates the process of
building complete Linux systems for embedded devices. It simplifies the process
of building a cross-compiled toolchain, a root filesystem, a Linux kernel,
and a bootloader. This repository is a Buildroot `BR2_EXTERNAL` tree
dedicated to supporting TI's SITARA platforms.

The use of an external tree, such as buildroot-external-TI, allows for
customization and extension of Buildroot without modifying the original
Buildroot source. Upstream Buildroot also contains pre-defined
configurations for SITARA platforms, but they use the upstream versions
of U-Boot and Linux, while the configurations in this `BR2_EXTERNAL`
tree uses the versions provided and supported by TI.

## Available configurations

This `BR2_EXTERNAL` tree provides two Buildroot configurations:

1. `ti_release_am62x_sk_defconfig` for Linux
2. `ti_release_am62x_sk_rt_defconfig` for RT-Linux.

It supports following variants of AM62x EVM:
- [SK-AM62](https://www.ti.com/tool/SK-AM62)
- [SK-AM62B](https://www.ti.com/tool/SK-AM62B)
- [SK-AM62B-P1](https://www.ti.com/tool/SK-AM62B-P1)

It builds and packages following main components:
- [ti-u-boot](https://git.ti.com/cgit/ti-u-boot/ti-u-boot/)
- [ti-linux-kernel](https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/)
- [optee](https://github.com/OP-TEE/optee_os)
- [TF-A](https://github.com/ARM-software/arm-trusted-firmware)
- [ti-linux-firmware](https://git.ti.com/cgit/processor-firmware/ti-linux-firmware)
- [busybox](https://git.busybox.net/busybox/)

## Pre-built SD card images

Pre-built buildroot SD card images are available at:

- [PROCESSOR-SDK-AM62X](https://www.ti.com/tool/PROCESSOR-SDK-AM62X)

## Building Buildroot from source

### Pre-requisites

To use Buildroot, a Linux distribution must be installed on your workstation.
Any reasonably recent Linux distribution (Ubuntu, Debian, Fedora, Redhat,
OpenSuse, etc.) is suitable.

Additionally, a small set of packages must be installed
[Buildroot manual System requirements
section](https://buildroot.org/downloads/manual/manual.html#requirement).

For Debian/Ubuntu distributions, the necessary packages can be installed with
the following command:

```bash
$ sudo apt install debianutils sed make binutils build-essential gcc g++ bash patch gzip bzip2 perl tar cpio unzip rsync file bc git findutils wget
```

Optional dependencies are available for enabling Buildroot features such as
interface configuration, legal information and documentation. For detailed
information refer
[corresponding manual section](https://buildroot.org/downloads/manual/manual.html#requirement-optional).

### Steps to build the SD card image

- Clone the Buildroot repository to local machine.

```bash
$ git clone -b 2024.05.3 https://github.com/buildroot/buildroot
```

- Clone the `BR2_EXTERNAL` tree:

```bash
$ git clone -b 10.01.10.04 https://github.com/TexasInstruments/buildroot-external-TI.git
```

- The directories for `buildroot` and `buildroot-external-ti` are now located
side-by-side.

### Configure and build

- Go to the Buildroot directory:

```bash
$ cd buildroot/
```

- Configure Buildroot to use the external tree by setting the BR2_EXTERNAL environment
variable. This tells Buildroot to include the configurations and packages from
the external tree during the build process. To configure the system for build,
choose any of the *defconfigs*  provided in this `BR2_EXTERNAL` tree. For example:

```bash
# For AM62X Linux
$ make BR2_EXTERNAL=../buildroot-external-TI ti_release_am62x_sk_defconfig

# For AM62X RT-Linux
$ make BR2_EXTERNAL=../buildroot-external-TI ti_release_am62x_sk_rt_defconfig
```

- To further customize the Buildroot configuration, run `make menuconfig`. This
step is optional but useful if you need to make specific adjustments.

- Build the SD card image for SDK 10.1

```bash
buildroot/ $ make TI_K3_BOOT_FIRMWARE_VERSION=10.01.10
```

- This process compiles the necessary components and creates the root filesystem,
kernel, and bootloader. The build process can take some time, depending on your
system's resources and the complexity of the configuration.

## Flashing and booting the SD card image

- The Buildroot configurations generate a compressed ready-to-use SD card image,
available as `output/images/sdcard.img`.

- Flash the image on a SD card:

```bash
buildroot/ $ sudo dd if=output/images/sdcard.img of=/dev/sdX
```

Replace /dev/sdX with the appropriate device identifier for your SD card.

- Tools like [balena-ethcer](https://etcher.balena.io/) can also be used to flash
the SD card image.

- Insert the SD card in SD card slot and power on the board. The system will start,
with the console on UART. You can log-in as `root` with no password.

# Going further

* [PROCESSOR-SDK-AM62X](https://www.ti.com/tool/PROCESSOR-SDK-AM62X#overview)

# References

* [Buildroot](https://buildroot.org/)
* [Buildroot reference manual](https://buildroot.org/downloads/manual/manual.html)
* [Buildroot system development training course](https://bootlin.com/training/buildroot/)

# Technical support

Visit [E2E](https://e2e.ti.com/support/processors/) for Technical support.
