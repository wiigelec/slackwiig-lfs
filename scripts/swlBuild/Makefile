
###################################################################
#
#
#
###################################################################


### CONFIG VARIABLES ###
build-blfs = /usr/src/slackwiig-lfs/scripts/build-blfs
blfs_build_dir = /usr/src/slackwiig-lfs/scripts/swlBuild/build.blfs
swl_build_dir = /usr/src/slackwiig-lfs/scripts/swlBuild/build.swl
qt_init = /usr/src/slackwiig-lfs/scripts/init/qt-init
kf_init = /usr/src/slackwiig-lfs/scripts/init/kf-init


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


gnome : gnome-desktop.blfs


kde : kde-frameworks.blfs kde-plasma.blfs


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
# COMBO PACKAGE BUILDS
###################################################################


openvpn : openvpn.blfs libcap-ng.swl openvpn.swl


qemu-spice : spice-protocol.swl spice.blfs orc.swl spice.swl usbredir.blfs \
       usbredir.swl spice-gtk.blfs spice-gtk.swl qemu-spice.blfs


virt-manager : virt-manager.blfs virt-manager.swl libvirt.blfs libvirt.swl \
	libvirt-glib.swl osinfo-db-tools.blfs osinfo-db-tools.swl libosinfo.blfs \
	libosinfo.swl libvirt-python.swl virt-manager.blfs dnsmasq.swl \
	dmidecode.swl netcat.swl


swl-tools-misc : swl-tools-misc.blfs ufw.blfs ufw.swl irssi.swl


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


openvpn.blfs : 
	$(build-blfs) $(blfs_build_dir)/openvpn.blfs


spice.blfs : 
	$(build-blfs) $(blfs_build_dir)/spice.blfs


usbredir.blfs : 
	$(build-blfs) $(blfs_build_dir)/usbredir.blfs


spice-gtk.blfs : 
	$(build-blfs) $(blfs_build_dir)/spice-gtk.blfs


qemu-spice.blfs : 
	$(build-blfs) $(blfs_build_dir)/qemu-spice.blfs


virt-manager.blfs : 
	$(build-blfs) $(blfs_build_dir)/virt-manager.blfs


libvirt.blfs : 
	$(build-blfs) $(blfs_build_dir)/libvirt.blfs


libosinfo.blfs : 
	$(build-blfs) $(blfs_build_dir)/libosinfo.blfs


osinfo-db-tools.blfs : 
	$(build-blfs) $(blfs_build_dir)/osinfo-db-tools.blfs


swl-tools-misc.blfs : 
	$(build-blfs) $(blfs_build_dir)/swl-tools-misc.blfs


ufw.blfs : 
	$(build-blfs) $(blfs_build_dir)/ufw.blfs


qt6.blfs : 
	$(build-blfs) $(blfs_build_dir)/qt6.blfs


webkitgtk.blfs : 
	$(build-blfs) $(blfs_build_dir)/webkitgtk.blfs


gnome-desktop.blfs : 
	$(build-blfs) $(blfs_build_dir)/gnome-desktop.blfs


kde-frameworks.blfs : 
	$(build-blfs) $(blfs_build_dir)/kde-frameworks.blfs


kde-plasma.blfs:
	$(build-blfs) $(blfs_build_dir)/kde-plasma.blfs


###################################################################
# SWL BUILDS
###################################################################


pkgtools.swl :
	$(swl_build_dir)/pkgtools.swlBuild


kernel-firmware.swl :
	$(swl_build_dir)/kernel-firmware.swlBuild


openvpn.swl :
	$(swl_build_dir)/openvpn.swlBuild


libcap-ng.swl :
	$(swl_build_dir)/libcap-ng.swlBuild


qemu-spice.swl : 


spice.swl :
	$(swl_build_dir)/spice.swlBuild


spice-protocol.swl :
	$(swl_build_dir)/spice-protocol.swlBuild


orc.swl :
	$(swl_build_dir)/orc.swlBuild


usbredir.swl :
	$(swl_build_dir)/usbredir.swlBuild


spice-gtk.swl :
	$(swl_build_dir)/spice-gtk.swlBuild


virt-manager.swl :
	$(swl_build_dir)/virt-manager.swlBuild


libvirt.swl :
	$(swl_build_dir)/libvirt.swlBuild


libvirt-glib.swl :
	$(swl_build_dir)/libvirt-glib.swlBuild


osinfo-db-tools.swl :
	$(swl_build_dir)/osinfo-db-tools.swlBuild


libosinfo.swl :
	$(swl_build_dir)/libosinfo.swlBuild


libvirt-python.swl :
	$(swl_build_dir)/libvirt-python.swlBuild


dnsmasq.swl :
	$(swl_build_dir)/dnsmasq.swlBuild


dmidecode.swl :
	$(swl_build_dir)/dmidecode.swlBuild


netcat.swl :
	$(swl_build_dir)/netcat.swlBuild


ufw.swl :
	$(swl_build_dir)/ufw.swlBuild


irssi.swl :
	$(swl_build_dir)/irssi.swlBuild

