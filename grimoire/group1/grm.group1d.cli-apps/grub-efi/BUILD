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
export JH_PKG_DIR=grub-efi
SRC_DIR=${JH_SRC_ARCHIVE}${JH_SRC_SUBDIRS:+/${JH_PKG_DIR}}
BUILD_DIR=${JH_BUILD_ROOT}${JH_BUILD_SUBDIRS:+/${JH_PKG_DIR}}
mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

cd $SRC_DIR
PACKAGE=grub-2.06.tar.xz
if [[ ! -f $PACKAGE ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE" "$PACKAGE"
  else
    wget -T 30 -t 5 "https://ftp.gnu.org/gnu/grub/grub-2.06.tar.xz"
  fi
fi
echo "cf0fd928b1e5479c8108ee52cb114363  $PACKAGE" | md5sum -c -

PATCH=grub-2.06-upstream_fixes-1.patch
if [[ ! -f $PATCH ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PATCH" ] ; then
    cp "$JH_SRC_ARCHIVE/$PATCH" "$PATCH"
  else
    wget -T 30 -t 5 "https://www.linuxfromscratch.org/patches/blfs/12.0/grub-2.06-upstream_fixes-1.patch"
  fi
fi
[ "$SRC_DIR" != "$BUILD_DIR" ] && ln -sf "$SRC_DIR/$PATCH" "$BUILD_DIR"

PACKAGE1=unifont-15.0.06.pcf.gz
if [[ ! -f $PACKAGE1 ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE1" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE1" "$PACKAGE1"
  else
    wget -T 30 -t 5 "https://unifoundry.com/pub/unifont/unifont-15.0.06/font-builds/unifont-15.0.06.pcf.gz"
  fi
fi
echo "94ff8cb4d5674cd2f38b00cede5e06d5  $PACKAGE1" | md5sum -c -
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


PATH=$PATH:/usr/sbin
mkdir -pv /usr/share/fonts/unifont
gunzip -c ../unifont-15.0.06.pcf.gz > /usr/share/fonts/unifont/unifont.pcf

for libdir in /lib /usr/lib $(find /opt -name lib); do
  find $libdir -name \*.la           \
             ! -path \*ImageMagick\* \
               -delete
done

unset {C,CPP,CXX,LD}FLAGS
patch -Np1 -i ../grub-2.06-upstream_fixes-1.patch
case $(uname -m) in i?86 )
    tar xf ../gcc-13.2.0.tar.xz
    mkdir gcc-13.2.0/build
    pushd gcc-13.2.0/build
        ../configure --prefix=$PWD/../../x86_64-gcc \
                     --target=x86_64-linux-gnu      \
                     --with-system-zlib             \
                     --enable-languages=c,c++       \
                     --with-ld=/usr/bin/ld
        /usr/bin/make all-gcc
	/usr/bin/make install-gcc
    popd
    export TARGET_CC=$PWD/x86_64-gcc/bin/x86_64-linux-gnu-gcc
esac
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --disable-efiemu     \
            --enable-grub-mkfont \
            --with-platform=efi  \
            --target=x86_64      \
            --disable-werror
unset TARGET_CC
/usr/bin/make
