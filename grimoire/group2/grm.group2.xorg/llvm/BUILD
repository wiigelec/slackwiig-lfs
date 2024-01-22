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
export JH_PKG_DIR=llvm
SRC_DIR=${JH_SRC_ARCHIVE}${JH_SRC_SUBDIRS:+/${JH_PKG_DIR}}
BUILD_DIR=${JH_BUILD_ROOT}${JH_BUILD_SUBDIRS:+/${JH_PKG_DIR}}
mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

cd $SRC_DIR
PACKAGE=llvm-16.0.5.src.tar.xz
if [[ ! -f $PACKAGE ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE" "$PACKAGE"
  else
    wget -T 30 -t 5 "https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.5/llvm-16.0.5.src.tar.xz"
  fi
fi
echo "d9185fc007c32aea27a6de3c7c1eb90d  $PACKAGE" | md5sum -c -

PACKAGE1=llvm-cmake.src.tar.xz
if [[ ! -f $PACKAGE1 ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE1" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE1" "$PACKAGE1"
  else
    wget -T 30 -t 5 "https://anduin.linuxfromscratch.org/BLFS/llvm/llvm-cmake.src.tar.xz"
  fi
fi
echo "356a1aff675d281d7c76165269d33bd5  $PACKAGE1" | md5sum -c -
[ "$SRC_DIR" != "$BUILD_DIR" ] && ln -sf "$SRC_DIR/$PACKAGE1" "$BUILD_DIR"

PACKAGE1=llvm-third-party.src.tar.xz
if [[ ! -f $PACKAGE1 ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE1" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE1" "$PACKAGE1"
  else
    wget -T 30 -t 5 "https://anduin.linuxfromscratch.org/BLFS/llvm/llvm-third-party.src.tar.xz"
  fi
fi
echo "8b506e49e5fa4c41186ba8ba7da5af82  $PACKAGE1" | md5sum -c -
[ "$SRC_DIR" != "$BUILD_DIR" ] && ln -sf "$SRC_DIR/$PACKAGE1" "$BUILD_DIR"

PACKAGE1=clang-16.0.5.src.tar.xz
if [[ ! -f $PACKAGE1 ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE1" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE1" "$PACKAGE1"
  else
    wget -T 30 -t 5 "https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.5/clang-16.0.5.src.tar.xz"
  fi
fi
echo "cb3e79db62c4c3b78cfcdebe66b00268  $PACKAGE1" | md5sum -c -
[ "$SRC_DIR" != "$BUILD_DIR" ] && ln -sf "$SRC_DIR/$PACKAGE1" "$BUILD_DIR"

PATCH=clang-16.0.5-enable_default_ssp-1.patch
if [[ ! -f $PATCH ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PATCH" ] ; then
    cp "$JH_SRC_ARCHIVE/$PATCH" "$PATCH"
  else
    wget -T 30 -t 5 "https://www.linuxfromscratch.org/patches/blfs/12.0/clang-16.0.5-enable_default_ssp-1.patch"
  fi
fi
[ "$SRC_DIR" != "$BUILD_DIR" ] && ln -sf "$SRC_DIR/$PATCH" "$BUILD_DIR"

PACKAGE1=compiler-rt-16.0.5.src.tar.xz
if [[ ! -f $PACKAGE1 ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE1" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE1" "$PACKAGE1"
  else
    wget -T 30 -t 5 "https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.5/compiler-rt-16.0.5.src.tar.xz"
  fi
fi
echo "3061b4cb0b2428a32b4fb5db540fe66c  $PACKAGE1" | md5sum -c -
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

tar -xf ../llvm-cmake.src.tar.xz
tar -xf ../llvm-third-party.src.tar.xz
sed '/LLVM_COMMON_CMAKE_UTILS/s@../cmake@llvm-cmake.src@'          \
    -i CMakeLists.txt
sed '/LLVM_THIRD_PARTY_DIR/s@../third-party@llvm-third-party.src@' \
    -i cmake/modules/HandleLLVMOptions.cmake
tar -xf ../clang-16.0.5.src.tar.xz -C tools
mv tools/clang-16.0.5.src tools/clang
tar -xf ../compiler-rt-16.0.5.src.tar.xz -C projects
mv projects/compiler-rt-16.0.5.src projects/compiler-rt
grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/'
patch -Np2 -d tools/clang <../clang-16.0.5-enable_default_ssp-1.patch
sed 's/clang_dfsan/& -fno-stack-protector/' \
    -i projects/compiler-rt/test/dfsan/origin_unaligned_memtrans.c
mkdir -v build
cd       build

CC=gcc CXX=g++                                  \
cmake -DCMAKE_INSTALL_PREFIX=/usr               \
      -DLLVM_ENABLE_FFI=ON                      \
      -DCMAKE_BUILD_TYPE=Release                \
      -DLLVM_BUILD_LLVM_DYLIB=ON                \
      -DLLVM_LINK_LLVM_DYLIB=ON                 \
      -DLLVM_ENABLE_RTTI=ON                     \
      -DLLVM_TARGETS_TO_BUILD="host;AMDGPU;BPF" \
      -DLLVM_BINUTILS_INCDIR=/usr/include       \
      -DLLVM_INCLUDE_BENCHMARKS=OFF             \
      -DCLANG_DEFAULT_PIE_ON_LINUX=ON           \
      -Wno-dev -G Ninja ..
ninja
#cmake -DLLVM_BUILD_DOCS=ON            \
#      -DLLVM_ENABLE_SPHINX=ON         \
#      -DSPHINX_WARNINGS_AS_ERRORS=OFF \
#      -Wno-dev -G Ninja ..
#ninja docs-llvm-html  docs-llvm-man
#ninja docs-clang-html docs-clang-man
#systemctl   --user start dbus || true
#systemd-run --user --pty -d -G -p LimitCORE=0 ninja check-all || true

PATH=$PATH:/usr/sbin
