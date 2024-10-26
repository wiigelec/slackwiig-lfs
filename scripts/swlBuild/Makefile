
###################################################################
#
#
#
###################################################################


### CONFIG VARIABLES ###
build-blfs = /usr/src/slackwiig-lfs/scripts/build-blfs
blfs_build_dir = /usr/src/slackwiig-lfs/scripts/swlBuild/build.blfs
swl_build_dir = /usr/src/slackwiig-lfs/scripts/swlBuild/build.swl


### DEFAUT TARGET ###
all : 
	cat README.md


###################################################################
# META BUILDS
###################################################################


swl-build : pkgtools.swl swl-build.blfs 


swl-base : swl-base.blfs kernel-firmware.swl


swl-ice : swl-ice.blfs


swl-tools : 



###################################################################
# BLFS META BUILDS
###################################################################


swl-build.blfs : 
	$(build-blfs) $(blfs_build_dir)/swl-build.blfs


swl-base.blfs : 
	$(build-blfs) $(blfs_build_dir)/swl-base.blfs


swl-ice.blfs : 
	$(build-blfs) $(blfs_build_dir)/swl-ice.blfs


###################################################################
# BLFS PACKAGE BUILDS
###################################################################


xorg-tools.blfs : 
	$(build-blfs) $(blfs_build_dir)/xorg-tools.blfs


xorg.blfs : 
	$(build-blfs) $(blfs_build_dir)/xorg.blfs


icewm.blfs : 
	$(build-blfs) $(blfs_build_dir)/icewm.blfs


nm-applet.blfs : 
	$(build-blfs) $(blfs_build_dir)/nm-applet.blfs


xfce4-terminal.blfs : 
	$(build-blfs) $(blfs_build_dir)/xfce4-terminal.blfs


firefox.blfs : 
	$(build-blfs) $(blfs_build_dir)/firefox.blfs


lightdm.blfs : 
	$(build-blfs) $(blfs_build_dir)/lightdm.blfs


xscreensaver.blfs : 
	$(build-blfs) $(blfs_build_dir)/xscreensaver.blfs


###################################################################
# SWL BUILDS
###################################################################


pkgtools.swl :
	$(swl_build_dir)/pkgtools.swlBuild


kernel-firmware.swl :
	$(swl_build_dir)/kernel-firmware.swlBuild

