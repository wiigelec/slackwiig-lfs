
###################################################################
#
#
#
###################################################################


### CONFIG VARIABLES ###
build-blfs = /usr/src/slackwiig-lfs/scripts/build-blfs
blfs_build_dir = ./build.build
swl_build_dir = ./build.swl


### DEFAUT TARGET ###
all : 
	cat README.md


###################################################################
# META BUILDS
###################################################################


swl-build : pkgtools.swl swl-build.blfs 


swl-base : swl-base.blfs kernel-firmware.swl


swl-ice : 


swl-tools : 



###################################################################
# BLFS BUILDS
###################################################################


swl-build.blfs : 
	$(build-blfs) $(blfs_build_dir)/swl-build.blfs


swl-base.blfs : 
	$(build-blfs) $(blfs_build_dir)/swl-base.blfs



###################################################################
# SWL BUILDS
###################################################################


pkgtools.swl :
	$(swl_build_dir)/pkgtools.swlBuild


kernel-firmware.swl :
	$(swl_build_dir)/kernel-firmware.swlBuild

