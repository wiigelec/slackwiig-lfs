unset CFLAGS
unset CXXFLAGS
unset CPPFLAGS
unset LDFLAGS
#!/bin/bash
set -e
# Variables coming from configuration
export JH_PACK_INSTALL=""
export JH_SRC_ARCHIVE="/sources"
export JH_SRC_SUBDIRS=""
export JH_BUILD_ROOT="/sources"
export JH_BUILD_SUBDIRS="y"
export JH_KEEP_FILES=""
unset CFLAGS
unset CXXFLAGS
unset LDFLAGS
export MAKEFLAGS="-j$(nproc)"
unset NINJAJOBS
unset MAKELEVEL
unset MAKE_TERMOUT
unset MAKE_TERMERR
if [ -r /etc/profile ]; then source /etc/profile; fi
# End of environment
export JH_PKG_DIR=glib2
SRC_DIR=${JH_SRC_ARCHIVE}${JH_SRC_SUBDIRS:+/${JH_PKG_DIR}}
BUILD_DIR=${JH_BUILD_ROOT}${JH_BUILD_SUBDIRS:+/${JH_PKG_DIR}}
mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

cd $SRC_DIR
PACKAGE=glib-2.76.4.tar.xz
if [[ ! -f $PACKAGE ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE" "$PACKAGE"
  else
    wget -T 30 -t 5 "https://download.gnome.org/sources/glib/2.76/glib-2.76.4.tar.xz"
  fi
fi
echo "b0df5864ec08248e79c13f71a717aa03  $PACKAGE" | md5sum -c -

PATCH=glib-skip_warnings-1.patch
if [[ ! -f $PATCH ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PATCH" ] ; then
    cp "$JH_SRC_ARCHIVE/$PATCH" "$PATCH"
  else
    wget -T 30 -t 5 "https://www.linuxfromscratch.org/patches/blfs/12.0/glib-skip_warnings-1.patch"
  fi
fi
[ "$SRC_DIR" != "$BUILD_DIR" ] && ln -sf "$SRC_DIR/$PATCH" "$BUILD_DIR"

cd $BUILD_DIR
find . -maxdepth 1 -mindepth 1 -type d | xargs sudo rm -rf

case $PACKAGE in
  *.tar.gz|*.tar.bz2|*.tar.xz|*.tgz|*.tar.lzma)
     tar -xvf $SRC_DIR/$PACKAGE > unpacked
     JH_UNPACKDIR=`grep '[^./]\+' unpacked | head -n1 | sed 's@^\./@@;s@/.*@@'`
     ;;
  *.tar.lz)
     bsdtar -xvf $SRC_DIR/$PACKAGE 2> unpacked
     JH_UNPACKDIR=`head -n1 unpacked | cut  -d" " -f2 | sed 's@^\./@@;s@/.*@@'`
     ;;
  *.zip)
     zipinfo -1 $SRC_DIR/$PACKAGE > unpacked
     JH_UNPACKDIR="$(sed 's@/.*@@' unpacked | uniq )"
     if test $(wc -w <<< $JH_UNPACKDIR) -eq 1; then
       unzip $SRC_DIR/$PACKAGE
     else
       JH_UNPACKDIR=${PACKAGE%.zip}
       unzip -d $JH_UNPACKDIR $SRC_DIR/$PACKAGE
     fi
     ;;
  *)
     JH_UNPACKDIR=$JH_PKG_DIR-build
     mkdir $JH_UNPACKDIR
     cp $SRC_DIR/$PACKAGE $JH_UNPACKDIR
     ADDITIONAL="$(find . -mindepth 1 -maxdepth 1 -type l)"
     if [ -n "$ADDITIONAL" ]; then
         cp $ADDITIONAL $JH_UNPACKDIR
     fi
     ;;
esac
export JH_UNPACKDIR
cd $JH_UNPACKDIR

patch -Np1 -i ../glib-skip_warnings-1.patch

PATH=$PATH:/usr/sbin
if [ -e /usr/include/glib-2.0 ]; then
    rm -rf /usr/include/glib-2.0.old
    mv -vf /usr/include/glib-2.0{,.old}
fi

mkdir build
cd    build

meson setup ..            \
      --prefix=/usr       \
      --buildtype=release \
      -Dman=true
ninja

PATH=$PATH:/usr/sbin
