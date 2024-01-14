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

VERSION=9.3
PKG_DEST=${SRC_DIR}/854-coreutils

PACKAGE=coreutils-9.3.tar.xz
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
patch -Np1 -i ../coreutils-9.3-i18n-1.patch
autoreconf -fiv
FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime
/usr/bin/make
# /usr/bin/make -k NON_ROOT_USERNAME=tester check-root >> $TEST_LOG 2>&1 || true
# groupadd -g 102 dummy -U tester >> $TEST_LOG 2>&1 || true
# chown -Rv tester .  >> $TEST_LOG 2>&1 || true
# su tester -c "PATH=$PATH /usr/bin/make -k RUN_EXPENSIVE_TESTS=yes check" >> $TEST_LOG 2>&1 || true
# groupdel dummy >> $TEST_LOG 2>&1 || true
