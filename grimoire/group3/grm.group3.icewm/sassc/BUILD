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
export JH_PKG_DIR=sassc
SRC_DIR=${JH_SRC_ARCHIVE}${JH_SRC_SUBDIRS:+/${JH_PKG_DIR}}
BUILD_DIR=${JH_BUILD_ROOT}${JH_BUILD_SUBDIRS:+/${JH_PKG_DIR}}
mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

cd $SRC_DIR
PACKAGE=sassc-3.6.2.tar.gz
if [[ ! -f $PACKAGE ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE" "$PACKAGE"
  else
    wget -T 30 -t 5 "https://github.com/sass/sassc/archive/3.6.2/sassc-3.6.2.tar.gz"
  fi
fi
echo "4c3b06ce2979f2a9f0a35093e501d8bb  $PACKAGE" | md5sum -c -

PACKAGE1=libsass-3.6.5.tar.gz
if [[ ! -f $PACKAGE1 ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE1" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE1" "$PACKAGE1"
  else
    wget -T 30 -t 5 "https://github.com/sass/libsass/archive/3.6.5/libsass-3.6.5.tar.gz"
  fi
fi
echo "c49765b9b3824dcd4a7423225ca28bad  $PACKAGE1" | md5sum -c -
[ "$SRC_DIR" != "$BUILD_DIR" ] && ln -sf "$SRC_DIR/$PACKAGE1" "$BUILD_DIR"

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

tar -xf ../libsass-3.6.5.tar.gz
pushd libsass-3.6.5

autoreconf -fi

./configure --prefix=/usr --disable-static
/usr/bin/make

PATH=$PATH:/usr/sbin
