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
export JH_PKG_DIR=linux-pam
SRC_DIR=${JH_SRC_ARCHIVE}${JH_SRC_SUBDIRS:+/${JH_PKG_DIR}}
BUILD_DIR=${JH_BUILD_ROOT}${JH_BUILD_SUBDIRS:+/${JH_PKG_DIR}}
mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

cd $SRC_DIR
PACKAGE=Linux-PAM-1.5.3.tar.xz
if [[ ! -f $PACKAGE ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE" "$PACKAGE"
  else
    wget -T 30 -t 5 "https://github.com/linux-pam/linux-pam/releases/download/v1.5.3/Linux-PAM-1.5.3.tar.xz"
  fi
fi
echo "a913bd5fbf9edeafaacf3eb1eb86fd83  $PACKAGE" | md5sum -c -

PACKAGE1=Linux-PAM-1.5.3-docs.tar.xz
if [[ ! -f $PACKAGE1 ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE1" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE1" "$PACKAGE1"
  else
    wget -T 30 -t 5 "https://github.com/linux-pam/linux-pam/releases/download/v1.5.3/Linux-PAM-1.5.3-docs.tar.xz"
  fi
fi
echo "c3771fdc447be78b4c1756b875235965  $PACKAGE1" | md5sum -c -
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

tar -xf ../Linux-PAM-1.5.3-docs.tar.xz --strip-components=1
./configure --prefix=/usr                        \
            --sbindir=/usr/sbin                  \
            --sysconfdir=/etc                    \
            --libdir=/usr/lib                    \
            --enable-securedir=/usr/lib/security \
            --docdir=/usr/share/doc/Linux-PAM-1.5.3
/usr/bin/make

PATH=$PATH:/usr/sbin
install -v -m755 -d /etc/pam.d

cat > /etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF

#make -k check || true

PATH=$PATH:/usr/sbin
rm -fv /etc/pam.d/other
