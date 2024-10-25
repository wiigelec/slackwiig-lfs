
###################################################################
#
#
#
###################################################################

build-blfs = /usr/src/slackwiig-lfs/scripts/build-blfs
swl-build-blfs = /usr/src/slackwiig-lfs/scripts/swlBuild/swl-build/swl-build.blfs
pkgtools-swlbuild = /usr/src/slackwiig-lfs/scripts/swlBuild/swl-build/pkgtools.swlBuild



all : swl-build-blfs pkgtools

swl-build-blfs : 
	$(build-blfs) $(swl-build-blfs)

pkgtools : 
	$(pkgtools-swlbuild)
