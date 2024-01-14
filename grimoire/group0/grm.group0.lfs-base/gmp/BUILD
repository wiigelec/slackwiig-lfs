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

VERSION=6.3.0
PKG_DEST=${SRC_DIR}/817-gmp

PACKAGE=gmp-6.3.0.tar.xz
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
./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.3.0
/usr/bin/make
/usr/bin/make html
# /usr/bin/make -k check 2>&1 | tee gmp-check-log >> $TEST_LOG 2>&1 || true
# awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log >> $TEST_LOG 2>&1 || true
