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

VERSION=13.2.0
PKG_DEST=${SRC_DIR}/825-gcc

PACKAGE=gcc-13.2.0.tar.xz
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
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac
mkdir -v build
cd       build
../configure --prefix=/usr            \
             LD=ld                    \
             --enable-languages=c,c++ \
             --enable-default-pie     \
             --enable-default-ssp     \
             --disable-multilib       \
             --disable-bootstrap      \
             --disable-fixincludes    \
             --with-system-zlib
/usr/bin/make
# ulimit -s 32768 >> $TEST_LOG 2>&1 || true
# chown -Rv tester . >> $TEST_LOG 2>&1 || true
# su tester -c "PATH=$PATH /usr/bin/make -k check" >> $TEST_LOG 2>&1 || true
# ../contrib/test_summary >> $TEST_LOG 2>&1 || true
