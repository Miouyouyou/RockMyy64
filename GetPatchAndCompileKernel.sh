export ARCH=arm64

if [ -z ${CROSS_COMPILE+x} ]; then
	export CROSS_COMPILE=aarch64-linux-gnu-
fi


export KERNEL_GIT_URL='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'

if [ -z ${MAKEOPTS+x} ]; then
	export MAKEOPTS=-j16
fi

export KERNEL_SERIES=v5.6
export KERNEL_BRANCH=v5.6
export LOCALVERSION=-RockMyy64-Frosty
export MALI_VERSION=r19p0-01rel0
export MALI_BASE_URL=https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-midgard-gpu

export GITHUB_REPO=Miouyouyou/RockMyy64
export GIT_BRANCH=master

export DTB_FILES="
rk3399-evb.dtb
rk3399-ficus.dtb
rk3399-firefly.dtb
rk3399-gru-bob.dtb
rk3399-gru-kevin.dtb
rk3399-gru-scarlet-inx.dtb
rk3399-gru-scarlet-kd.dtb
rk3399-hugsun-x99.dtb
rk3399-khadas-edge-captain.dtb
rk3399-khadas-edge.dtb
rk3399-khadas-edge-v.dtb
rk3399-leez-p710.dtb
rk3399-nanopc-t4.dtb
rk3399-nanopi-m4.dtb
rk3399-nanopi-neo4.dtb
rk3399-orangepi.dtb
rk3399pro-rock-pi-n10.dtb
rk3399-puma-haikou.dtb
rk3399-rock960.dtb
rk3399-rock-pi-4.dtb
rk3399-rockpro64.dtb
rk3399-rockpro64-v2.dtb
rk3399-roc-pc.dtb
rk3399-roc-pc-mezzanine.dtb
rk3399-sapphire.dtb
rk3399-sapphire-excavator.dtb
"

export PATCHES_DIR=patches
export KERNEL_PATCHES_DIR=$PATCHES_DIR/kernel/$KERNEL_SERIES
export KERNEL_PATCHES_DTS_DIR=$KERNEL_PATCHES_DIR/DTS
export KERNEL_PATCHES_VPU_DIR=$KERNEL_PATCHES_DIR/VPU
export MALI_PATCHES_DIR=$PATCHES_DIR/Midgard/$MALI_VERSION
export KERNEL_DOCUMENTATION_PATCHES_DIR=$KERNEL_PATCHES_DIR/Documentation
export CONFIG_FILE_PATH=config/$KERNEL_SERIES/config-latest

export BASE_FILES_URL=https://raw.githubusercontent.com/$GITHUB_REPO/$GIT_BRANCH
export KERNEL_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_PATCHES_DIR
export KERNEL_DTS_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_PATCHES_DTS_DIR
export KERNEL_VPU_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_PATCHES_VPU_DIR
export KERNEL_DOCUMENTATION_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_DOCUMENTATION_PATCHES_DIR
export MALI_PATCHES_DIR_URL=$BASE_FILES_URL/$MALI_PATCHES_DIR
export CONFIG_FILE_URL=$BASE_FILES_URL/config/$KERNEL_SERIES/config-latest

export KERNEL_PATCHES="
0001-drivers-staging-fusb30x-Another-version-of-fusb302.patch
0002-soc-friendlyelec-Add-board-info-driver.patch
0003-mali-power-fix.patch
0004-kernel-dma-remap-Allocate-2M-blocks-instead-of-256K-.patch
0005-drivers-mmc-core-Make-Rock-Pi-and-NanoPC-boot-again.patch
0006-drivers-mfd-Use-syscore-to-poweroff-when-using-RK808.patch
"

export KERNEL_DTS_PATCHES="
0001-arm64-dts-rk3399-rockpro64-Doubling-RXD-DWMAC.patch
0002-arm64-dts-rk3399-nanopc-t4-Enable-i2c7-and-uart4.patch
0003-arm64-dtsi-rockchip-rk3399-Resolve-issues-with-MTU-h.patch
0004-arm64-dtsi-rockchip-rk3399-opp-Add-support-for-1.5-G.patch
0005-arm64-dtsi-rockchip-rk3399-Fine-tune-the-power-drawn.patch
"

export KERNEL_VPU_PATCHES="
0001-media-uapi-hevc-Add-scaling-matrix-control.patch
0002-media-uapi-hevc-Add-segment-address-field.patch
0003-RFC-media-uapi-h264-Add-DPB-entry-field-reference-fl.patch
0004-RFC-media-hantro-Fix-H264-decoding-of-field-encoded-.patch
0005-WIP-media-hantro-rk3399-mpeg2-src_fmt.patch
0006-WIP-media-hantro-g1-mpeg2-src_fmt.patch
0007-WIP-media-hantro-vp8-src_fmt.patch
0008-media-H264-support-for-Hantro-G1-and-RK3399.patch
0009-include-media-hevc-ctrls-Recopy-of-jernejsk-modifica.patch
"

#0003-RFC-media-uapi-h264-Add-DPB-entry-field-reference-fl.patch
#0004-RFC-media-hantro-Fix-H264-decoding-of-field-encoded-.patch
#0005-WIP-media-hantro-rk3399-mpeg2-src_fmt.patch
#0006-WIP-media-hantro-g1-mpeg2-src_fmt.patch
#0007-WIP-media-hantro-vp8-src_fmt.patch
#0008-media-H264-support-for-Hantro-G1-and-RK3399.patch

export KERNEL_DOCUMENTATION_PATCHES="
"

export MALI_PATCHES="
0001-Mali-midgard-r19p0-fixes-for-4.13-kernels.patch
0004-Don-t-be-TOO-severe-when-looking-for-the-IRQ-names.patch
0005-Added-the-new-compatible-list-mainly-used-by-Rockchi.patch
0006-gpu-arm-Midgard-setup_timer-timer_setup.patch
0007-drivers-gpu-Arm-Midgard-Replace-ACCESS_ONCE-by-READ_.patch
0008-gpu-arm-midgard-Remove-sys_close-references.patch
0009-GPU-ARM-Midgard-Adapt-to-the-new-mmap-call-checks.patch
0010-GPU-Mali-Midgard-remove-rcu_read_lock-references.patch
0011-mali-kbase-v4.20-to-v5.0-rc2-changes.patch
0012-Integrate-52791eeec1d9f4a7e7fe08aaba0b1553149d93bc-c.patch
"

# -- Helper functions

die_on_error() {
	if [ ! $? = 0 ]; then
		echo $1
		exit 1
	fi
}

download_patches() {
	base_url=$1
	patches=${@:2}
	for patch in $patches; do
		wget $base_url/$patch ||
		{ echo "Could not download $patch"; exit 1; }
	done
}

download_and_apply_patches() {
	base_url=$1
	patches=${@:2}
	download_patches $base_url $patches
	git apply $patches
	die_on_error "Could not apply the downloaded patches"
	rm $patches
}

copy_and_apply_patches() {
	patch_base_dir=$1
	patches=${@:2}

	apply_dir=$PWD
	cd $patch_base_dir
	cp $patches $apply_dir ||
	{ echo "Could not copy $patch"; exit 1; }
	cd $apply_dir
	git apply $patches
	die_on_error "Could not apply the copied patches"
	rm $patches
}

# Get the kernel

# If we haven't already clone the Linux Kernel tree, clone it and move
# into the linux folder created during the cloning.
if [ ! -d "linux" ]; then
  git clone --depth 1 --branch $KERNEL_BRANCH $KERNEL_GIT_URL linux
  die_on_error "Could not git the kernel"
fi
cd linux
export SRC_DIR=$PWD

# Check if the tree is patched
if [ ! -e "PATCHED" ]; then
	# If not, cleanup, apply the patches, commit and mark the tree as
	# patched

	# Remove all untracked files. These are residues from failed runs
	git clean -fdx &&
	# Rewind modified files to their initial state.
	git checkout -- .

	# Download, prepare and copy the Mali Kernel-Space drivers.
	# Some TGZ are AWFULLY packaged with everything having 0777 rights.

	#wget "$MALI_BASE_URL/TX011-SW-99002-$MALI_VERSION.tgz" &&
	#tar zxvf TX011-SW-99002-$MALI_VERSION.tgz &&
	#cd TX011-SW-99002-$MALI_VERSION &&
	#find . -type 'f' -exec chmod 0644 {} ';' && # Every file   should have -rw-r--r-- rights
	#find . -type 'd' -exec chmod 0755 {} ';' && # Every folder should have drwxr-xr-x rights
	#find . -name 'sconscript' -exec rm {} ';' && # Remove sconscript files. Useless.
	#cd driver/product/kernel &&
	#cp -r drivers/gpu/arm  $SRC_DIR/drivers/gpu/ && # Copy the Midgard code
	#cd $SRC_DIR &&
	#rm -r TX011-SW-99002-$MALI_VERSION TX011-SW-99002-$MALI_VERSION.tgz

	# Download and apply the various kernel and Mali kernel-space driver patches
	if [ ! -d "../patches" ]; then
		download_and_apply_patches $KERNEL_PATCHES_DIR_URL $KERNEL_PATCHES
		download_and_apply_patches $KERNEL_DTS_PATCHES_DIR_URL $KERNEL_DTS_PATCHES
		#download_and_apply_patches $KERNEL_DOCUMENTATION_PATCHES_DIR_URL $KERNEL_DOCUMENTATION_PATCHES
		#download_and_apply_patches $MALI_PATCHES_DIR_URL $MALI_PATCHES
		download_and_apply_patches $KERNEL_VPU_PATCHES_DIR_URL $KERNEL_VPU_PATCHES
	else
		copy_and_apply_patches ../$KERNEL_PATCHES_DIR $KERNEL_PATCHES
		copy_and_apply_patches ../$KERNEL_PATCHES_DTS_DIR $KERNEL_DTS_PATCHES
		#copy_and_apply_patches ../$KERNEL_DOCUMENTATION_PATCHES_DIR $KERNEL_DOCUMENTATION_PATCHES
		#copy_and_apply_patches ../$MALI_PATCHES_DIR $MALI_PATCHES
		copy_and_apply_patches ../$KERNEL_PATCHES_VPU_DIR $KERNEL_VPU_PATCHES
	fi


	# Cleanup, get the configuration file and mark the tree as patched
	echo $LOCALVERSION > PATCHED &&
	git add . &&
	git commit -m "Apply ALL THE PATCHES !"
fi

# Download a .config file if none present
if [ ! -e ".config" ]; then
	make mrproper
	if [ ! -f "../$CONFIG_FILE_PATH" ]; then
		wget -O .config $CONFIG_FILE_URL
	else
		cp "../$CONFIG_FILE_PATH" .config
	fi
	die_on_error "Could not get the configuration file..."
fi

if [ -z ${MAKE_CONFIG+x} ]; then
  export MAKE_CONFIG=oldconfig
fi

if [ ! -z ${APPLYONLY+x} ]; then
  exit
fi

make $MAKE_CONFIG
make Image.gz dtbs modules $MAKEOPTS
die_on_error "Compilation failed"

if [ -z ${DONT_INSTALL_IN_TMP+x} ]; then
	# Kernel compiled
	# This will just copy the kernel files and libraries in /tmp
	# This part is only useful if you're cross-compiling the kernel, of course
	export INSTALL_MOD_PATH=/tmp/RockMyyX-Build
	export INSTALL_PATH=$INSTALL_MOD_PATH/boot
	export INSTALL_HDR_PATH=$INSTALL_MOD_PATH/usr
	mkdir -p $INSTALL_MOD_PATH $INSTALL_PATH $INSTALL_HDR_PATH
	make modules_install &&
	make dtbs_install &&
	make install &&
	make INSTALL_HDR_PATH=$INSTALL_HDR_PATH headers_install && # This command IGNORES predefined variables
	cp arch/arm64/boot/Image $INSTALL_PATH
fi


