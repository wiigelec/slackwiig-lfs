# function for packing and installing a tree. We only have access
# to variables PKGDIR and PKG_DEST
# Other variables can be passed on the command line, or in the environment

packInstall() {

# A proposed implementation for versions and package names.
local PCKGVRS=$(basename $PKGDIR)
local TGTPKG=$(basename $PKG_DEST)
local PACKAGE=$(echo ${TGTPKG} | sed 's/^[0-9]\{3,4\}-//' |
           sed 's/^[0-9]\{2\}-//')
# version is only accessible from PKGDIR name. Since the format of the
# name is not normalized, several hacks are necessary...
case $PCKGVRS in
  expect*|tcl*) local VERSION=$(echo $PCKGVRS | sed 's/^[^0-9]*//') ;;
  vim*|unzip*) local VERSION=$(echo $PCKGVRS | sed 's/^[^0-9]*\([0-9]\)\([0-9]\)/\1.\2/') ;;
  tidy*) local VERSION=$(echo $PCKGVRS | sed 's/^[^0-9]*\([0-9]*\)/\1cvs/') ;;
  docbook-xml) local VERSION=4.5 ;;
  *) local VERSION=$(echo ${PCKGVRS} | sed 's/^.*[-_]\([0-9]\)/\1/' |
                   sed 's/_/./g');;
# the last sed above is because some package managers do not want a '_'
# in version.
esac
local ARCHIVE_NAME=$(dirname ${PKGDIR})/${PACKAGE}-${VERSION}-x86_64-jsw01.txz
case $(uname -m) in
  x86_64) local ARCH=amd64 ;;
  *) local ARCH=i386 ;;
esac

pushd $PKG_DEST
rm -fv ./usr/share/info/dir  # recommended since this directory is already there
                             # on the system

# Strip
set +e
for i in $(find ./usr/lib -type f -name \*.so*) \
    $(find ./usr/lib -type f -name \*.a)                 \
    $(find ./usr/{bin,sbin,libexec} -type f); do
        strip --strip-unneeded $i
done
find ./usr/lib ./usr/libexec -name \*.la -delete
set -e
	
# Building the binary package
makepkg -l y -c n "../$ARCHIVE_NAME"

# Installing it on LFS
#installpkg $ARCHIVE_NAME

# Storing the package (recommended).
mv -v "../$ARCHIVE_NAME" /var/lib/packages

popd                         # Since the $PKG_DEST directory is destroyed
                             # immediately after the return of the function,
                             # getting back to $PKGDIR is important...
}
