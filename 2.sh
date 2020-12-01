# Zip Process - Start
zippackage() {
if ! [ "${defconfig}" == "" ]
then
if [ -f arch/${ARCH}/boot/Image.gz ] || [ -f arch/${ARCH}/boot/Image.lzma ] || [ -f arch/${ARCH}/boot/Image.bz2 ] || [ -f arch/${ARCH}/boot/Image.xz ] || [ -f arch/${ARCH}/boot/Image.lzo ] || [ -f arch/${ARCH}/boot/Image.lz4 ]
	then
		echo "${x} - Ziping ${customkernel}"

		zipdirout="zip-creator-out"
		rm -rf ${zipdirout}
		mkdir ${zipdirout}

		cp -r zip-creator/base/* ${zipdirout}/

		if [ "${compressedimage}" == "${bldyel}ON${txtrst}" ];
		then

			if [ -f arch/${ARCH}/boot/Image.gz-dtb ]; then
				cp arch/${ARCH}/boot/Image.gz-dtb ${zipdirout}/zImage

			elif [ -f arch/${ARCH}/boot/Image.lzma-dtb ]; then
				cp arch/${ARCH}/boot/Image.lzma-dtb ${zipdirout}/zImage

			elif [ -f arch/${ARCH}/boot/Image.bz2-dtb ]; then
				cp arch/${ARCH}/boot/Image.bz2-dtb ${zipdirout}/zImage

			elif [ -f arch/${ARCH}/boot/Image.xz-dtb ]; then
				cp arch/${ARCH}/boot/Image.xz-dtb ${zipdirout}/zImage

			elif [ -f arch/${ARCH}/boot/Image.lzo-dtb ]; then
				cp arch/${ARCH}/boot/Image.lzo-dtb ${zipdirout}/zImage

			elif [ -f arch/${ARCH}/boot/Image.lz4-dtb ]; then
				cp arch/${ARCH}/boot/Image.lz4-dtb ${zipdirout}/zImage

			fi

		else
			cp arch/${ARCH}/boot/Image ${zipdirout}/zImage
	
		fi

		echo "maintainer=${maintainer}" >> ${zipdirout}/device.prop
		echo "customkernel=${customkernel}" >> ${zipdirout}/device.prop
		echo "name=${name}" >> ${zipdirout}/device.prop
		echo "variant=${variant}" >> ${zipdirout}/device.prop
		echo "release=${release}" >> ${zipdirout}/device.prop
		echo "releasewithbar=${releasewithbar}" >> ${zipdirout}/device.prop
		echo "ToolchainName=${ToolchainName}" >> ${zipdirout}/device.prop
		echo "romversion=${romversion}" >> ${zipdirout}/device.prop
		echo "androidversion=${androidversion}" >> ${zipdirout}/device.prop
        sed -i "/supported.versions=/i device.name1=${name}\ndevice.name2=${name1}\ndevice.name3=${name2}\ndevice.name4=${name3}\ndevice.name5=${name4}" ${zipdirout}/anykernel.sh

		cd ${zipdirout}
		rm -rf modules
		rm README.md
		rm LICENSE
		zip -r ${zipfile} * -x .gitignore &> /dev/null
		cd ..

		cp ${zipdirout}/${zipfile} zip-creator/
		rm -rf ${zipdirout}

		zippackagecheck="${_d}"
	else
		ops
	fi
else
	ops
fi
clear
}
# Zip Process - End
