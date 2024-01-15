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
export JH_PKG_DIR=mutt
SRC_DIR=${JH_SRC_ARCHIVE}${JH_SRC_SUBDIRS:+/${JH_PKG_DIR}}
BUILD_DIR=${JH_BUILD_ROOT}${JH_BUILD_SUBDIRS:+/${JH_PKG_DIR}}
mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

cd $SRC_DIR
PACKAGE=mutt-2.2.11.tar.gz
if [[ ! -f $PACKAGE ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE" "$PACKAGE"
  else
    wget -T 30 -t 5 "https://bitbucket.org/mutt/mutt/downloads/mutt-2.2.11.tar.gz"
  fi
fi
echo "0c3691cff3fd0471bfcad2bd8ad84949  $PACKAGE" | md5sum -c -

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
groupadd -g 34 mail
chgrp -v mail /var/mail

sed  -e 's/ -with_backspaces//' \
     -e 's/elinks/links/'       \
     -e 's/-no-numbering -no-references//' \
     -i doc/Makefile.in
./configure --prefix=/usr                            \
            --sysconfdir=/etc                        \
            --with-docdir=/usr/share/doc/mutt-2.2.11 \
            --with-ssl                               \
            --enable-external-dotlock                \
            --enable-pop                             \
            --enable-imap                            \
            --enable-hcache                          \
            --enable-sidebar
/usr/bin/make

PATH=$PATH:/usr/sbin
