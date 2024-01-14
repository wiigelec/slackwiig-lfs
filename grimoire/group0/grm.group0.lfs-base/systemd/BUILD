unset CFLAGS
unset CXXFLAGS
unset CPPFLAGS
unset LDFLAGS
#!/bin/bash
set +h
set -e



PREV_SEC=${SECONDS}
      
ROOT=/

SCRIPT_ROOT=jhalfs

SRC_DIR=${ROOT}sources

VERSION=254
PKG_DEST=${SRC_DIR}/872-systemd

PACKAGE=systemd-254.tar.gz
cd $SRC_DIR
PKGDIR=$(tar -tf $PACKAGE | head -n1 | sed 's@^./@@;s@/.*@@')
export PKGDIR VERSION PKG_DEST

if [ -d "$PKGDIR" ]; then rm -rf $PKGDIR; fi
if [ -d "$PKG_DEST" ]; then rm -rf $PKG_DEST; fi
if [ -d "${PKGDIR%-*}-build" ]; then  rm -rf ${PKGDIR%-*}-build; fi

echo "KB: $(du -skx --exclude=lost+found --exclude=var/lib --exclude=$SCRIPT_ROOT $ROOT)"


tar -xf $PACKAGE
cd $PKGDIR

export MAKEFLAGS="-j$(nproc)"
SECONDS=${PREV_SEC}

# Start of LFS book script
sed -i -e 's/GROUP="render"/GROUP="video"/' \
       -e 's/GROUP="sgx", //' rules.d/50-udev-default.rules.in
mkdir -p build
cd       build

meson setup \
      --prefix=/usr                 \
      --buildtype=release           \
      -Ddefault-dnssec=no           \
      -Dfirstboot=false             \
      -Dinstall-tests=false         \
      -Dldconfig=false              \
      -Dsysusers=false              \
      -Drpmmacrosdir=no             \
      -Dhomed=false                 \
      -Duserdb=false                \
      -Dman=false                   \
      -Dmode=release                \
      -Dpamconfdir=no               \
      -Ddev-kvm-mode=0660           \
      -Ddocdir=/usr/share/doc/systemd-254 \
      ..
ninja
