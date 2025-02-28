#!/bin/sh -x

dtb_file=""

while [ $# -gt 0 ]; do
	case "$1" in
		-d)
			# Check if the next argument exists and is not another flag
			if [ -n "$2" ] && [ "${2#-}" = "$2" ]; then
				dtb_file="$2"
				shift
			else
				echo "Error: Missing or invalid filename after -d flag"
				exit 1
			fi
			;;
		*)
			;;
	esac
	shift
done

if [ -n "$dtb_file" ]; then
	echo "dtb file provided : $dtb_file"
else
	echo "No dtb file provided with -d flag"
	exit 1
fi

mkdir -p $TARGET_DIR/boot/dtb/ti
mkdir -p $TARGET_DIR/lib/firmware/ti-connectivity

cp $BINARIES_DIR/Image $TARGET_DIR/boot
cp $BINARIES_DIR/$dtb_file $TARGET_DIR/boot/dtb/ti
cp $BUILD_DIR/linux-*/arch/arm64/boot/dts/ti/k3-am62l3-evm-dsi-rpi-7inch-panel.dtbo $TARGET_DIR/boot/dtb/ti
mv $BINARIES_DIR/tiboot3-am62lx-hs-fs-evm.bin $BINARIES_DIR/tiboot3.bin
cp $BUILD_DIR/ti-k3-boot-firmware-*/ti-connectivity/* $TARGET_DIR/lib/firmware/ti-connectivity/
cp $BR2_EXTERNAL_TI_PATH/board/ti/am62lx-evm/uEnv.txt $BINARIES_DIR/uEnv.txt
