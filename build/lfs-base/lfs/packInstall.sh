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
case $(uname -m) in
  x86_64) local ARCH=amd64 ;;
  *) local ARCH=i386 ;;
esac
local ARCHIVE_NAME=$(dirname ${PKGDIR})/${PACKAGE}-${VERSION}-${ARCH}-swl121.txz

pushd $PKG_DEST
rm -fv ./usr/share/info/dir  # recommended since this directory is already there
                             # on the system

# pkg lookup
#echo "debug:pkg lookup"
#echo "debug: grep \"^$PACKAGE  \" /var/lib/swl/pkg-versions-121.jhalfs"
local swl_pkg=$(grep "^$PACKAGE  " /var/lib/swl/pkg-versions-121.jhalfs)
if [[ ! -z $swl_pkg ]]; then
	#echo "debug:swl_pkg ($swl_pkg) found"
	swl_pkg=${swl_pkg/  /-}
	swl_pkg=$(dirname ${PKGDIR})/${swl_pkg}-${ARCH}-swl121.txz
	ARCHIVE_NAME=$swl_pkg
#else
#	echo "debug:swl_pkg ($ARCHIVE_NAME) not found"
fi

# Convert to lower case
ARCHIVE_NAME=$(echo "$ARCHIVE_NAME" | sed 's/./\L&/g')
#echo "ARCHIVE_NAME: $ARCHIVE_NAME"

# Building the binary package
#echo "debug:makepkg"
makepkg -l y -c n ".$ARCHIVE_NAME"

# Installing it on LFS
installpkg ".$ARCHIVE_NAME"

# Storing the package (recommended).
cp ".$ARCHIVE_NAME" /var/lib/swl/packages

popd                         # Since the $PKG_DEST directory is destroyed
                             # immediately after the return of the function,
                             # getting back to $PKGDIR is important...
}
