
###################################################################
#
#
#
###################################################################

build-blfs = /usr/src/slackwiig-lfs/scripts/build-blfs
swl-base-blfs = /usr/src/slackwiig-lfs/scripts/swlBuild/swl-base/swl-base.blfs
kernel-firmware-swlbuild = /usr/src/slackwiig-lfs/scripts/swlBuild/swl-base/kernel-firmware.swlBuild



all : swl-base-blfs kernel-firmware

swl-base-blfs : 
	$(build-blfs) $(swl-base-blfs)

kernel-firmware : 
	$(kernel-firmware-swlbuild)
