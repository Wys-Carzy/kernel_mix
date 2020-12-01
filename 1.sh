#!/bin/bash
release=$(date +%Y""%m""%d)
releasewithbar=$(date +%Y"/"%m"/"%d)
maintainer=Psychotic
customkernel=HavocKernel
name=MiMix
romversion=EAS
ToolchainName=GCC
androidversion=Ten
#ZIP Process
zipProcess() { 
	rm -rf AnyKernel3/zImage
	rm -rf AnyKernel3/*.zip
	rm -rf AnyKernel3/device.prop
	export zipfile="${customkernel}-${name}-${release}-${ToolchainName}-${androidversion}-${romversion}"
	
	cd /home/psychotic/Desktop/Haovc
	cp out/arch/arm64/boot/Image.gz-dtb AnyKernel3/zImage
	echo "maintainer=${maintainer}" >> AnyKernel3/device.prop
	echo "customkernel=${customkernel}" >> AnyKernel3/device.prop
	echo "name=${name}" >> AnyKernel3/device.prop
	echo "variant=Prime-Pro" >> AnyKernel3/device.prop
	echo "releasewithbar=${releasewithbar}" >> AnyKernel3/device.prop
	echo "ToolchainName=${ToolchainName}" >> AnyKernel3/device.prop
	echo "romversion=${romversion}" >> AnyKernel3/device.prop
	echo "androidversion=${androidversion}" >> AnyKernel3/device.prop
			
	cd AnyKernel3
	zip -r9 ${zipfile}.zip * -x README.md ${zipfile}.zip 
	#echo "ZIP Process succeed"
	echo -e "\033[31m ZIP Process succeed \033[0m"
}
#End

#Build
#make clean
#make mrproper
rm -rf out/arch/arm64/boot/Image.gz-dtb
rm -rf out/arch/arm64/boot/Image
rm -rf out/arch/arm64/boot/Image.gz
export CROSS_COMPILE_ARM32="/home/psychotic/Desktop/Toolchain/arter97_gcc/arm32-gcc-master/bin/arm-eabi-"
export CROSS_COMPILE="/home/psychotic/Desktop/Toolchain/arter97_gcc/arm64-gcc-master/bin/aarch64-elf-"
export ARCH=arm64
make O=out lithium_defconfig
START=$(date +"%s")
make O=out -j$(nproc --all)
END=$(date +"%s")
BUILDTIME=$((${END} - ${START}))
if [ -f out/arch/arm64/boot/Image.gz-dtb ] || [ -f out/arch/arm64/boot/Image.lzma-dtb ] || [ -f out/arch/arm64/boot/Image.bz2-dtb ] || [ -f out/arch/arm64/boot/Image.xz-dtb ] || [ -f out/arch/arm64/boot/Image.lzo-dtb ] || [ -f out/arch/arm64/boot/Image.lz4-dtb ]
	then
		#echo "Build succeed ZIP Process"
		echo -e "\033[31m Build succeed ZIP Process \033[0m"
		echo -e "\033[31m Build Time:$((${BUILDTIME} / 60))m$((${BUILDTIME} % 60))s \033[0m"
		zipProcess
	else
		#echo " Build failed"
		echo -e "\033[31m Build failed \033[0m"
	fi
#End
