# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=HavocKernel
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=MiMix
device.name2=Mi Mix
device.name3=MIMix
device.name4=lithium
device.name5=Lithium
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;


# add floppy script
mount -o rw,remount -t auto /vendor > /dev/null;
mount -o rw,remount -t auto /system > /dev/null;
insert_line /vendor/etc/init/hw/init.qcom.rc "import /vendor/etc/init/hw/init.floppy.rc" before "import /vendor/etc/init/hw/init.qcom.power.rc" "import /vendor/etc/init/hw/init.floppy.rc";
cp -a /tmp/anykernel/patch/* /vendor/etc/init/hw/
set_perm_recursive 0 0 755 644 /vendor/etc/init/hw/*;


# begin ramdisk changes

# end ramdisk changes

write_boot;
## end install

