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

VERSION=5.2.15
PKG_DEST=${SRC_DIR}/833-bash

PACKAGE=bash-5.2.15.tar.gz
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
./configure --prefix=/usr             \
            --without-bash-malloc     \
            --with-installed-readline \
            --docdir=/usr/share/doc/bash-5.2.15
/usr/bin/make
# chown -Rv tester . >> $TEST_LOG 2>&1 || true
# su -s /usr/bin/expect tester << EOF >> $TEST_LOG 2>&1 || true
# set timeout -1
# spawn /usr/bin/make -k tests
# expect eof
# lassign [wait] _ _ _ value
# exit $value
# EOF
