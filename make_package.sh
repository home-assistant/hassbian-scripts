#!/bin/bash

OWNER=$(whoami)
VERSION=$(grep version  -i package/DEBIAN/control | cut -d ":" -f2 | tr -d [:space:])
PACKAGE=$(grep package  -i package/DEBIAN/control | cut -d ":" -f2 | tr -d [:space:])
PACKAGENAME="${PACKAGE}_${VERSION}.deb"

if [ -f $PACKAGENAME ]; then
	echo "Previous package exists. Deleting"
	rm $PACKAGENAME
fi

echo "Building package $PACKAGE version $VERSION"
sudo chown -R root:root package
dpkg-deb --build package
mv package.deb $PACKAGENAME
echo "Renaming package to $PACKAGENAME"
sudo chown -R $OWNER:$OWNER package
sudo chown $OWNER:$OWNER $PACKAGENAME
