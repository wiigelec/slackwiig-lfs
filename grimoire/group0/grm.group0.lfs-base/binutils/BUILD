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

VERSION=2.41
PKG_DEST=${SRC_DIR}/816-binutils

PACKAGE=binutils-2.41.tar.xz
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
mkdir -v build
cd       build
../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib
/usr/bin/make tooldir=/usr
# /usr/bin/make -k check >> $TEST_LOG 2>&1 || true
# grep '^FAIL:' $(find -name '*.log') >> $TEST_LOG 2>&1 || true
