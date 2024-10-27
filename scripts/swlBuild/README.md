Welcome to the SWL build system.

It is recommended to run the meta builds in the following order:

swl-build
swl-base

+swl-ice
  xorg-tools
  xorg
  icewm
  *nm-applet
  *xfce4-terminal
  *firefox

++swl-tools
  *openvpn : openvpn.blfs libcap-ng.swl openvpn.swl
  *qemu-spice : spice-protocol.swl spice.blfs orc.swl spice.swl usbredir.blfs \
       usbredir.swl spice-gtk.blfs spice-gtk.swl qemu-spice.blfs
  *virt-manager : virt-manager.blfs virt-manager.swl libvirt.blfs libvirt.swl \
        libvirt-glib.swl osinfo-db-tools.blfs osinfo-db-tools.swl libosinfo.blfs \
        libosinfo.swl libvirt-python.swl virt-manager.blfs dnsmasq.swl \
        dmidecode.swl netcat.swl



*isolated build
+final build after all packages complete for list
++no meta build

