#!/bin/bash
function hassbian-script-show-short-info {
    echo "Hassbian-Script upgrade script for Hassbian"
}

function hassbian-script-show-long-info {
    echo "Upgrade hassbian-scripts"
}

function hassbian-script-show-copyright-info {
    echo "Original concept by Ludeeus <https://github.com/ludeeus>"
}

function hassbian-script-upgrade-package {
hassbian-script-show-short-info
hassbian-script-show-copyright-info

echo "Changing to temporary folder"
cd /tmp

echo "Downloading newest release"
curl https://api.github.com/repos/home-assistant/hassbian-scripts/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -

# Setting package name
HASSBIAN_PACKAGE=$(ls | grep 'hassbian*')

echo "Installing newest release"
sudo apt install -y /tmp/$HASSBIAN_PACKAGE

echo "Cleanup"
rm $HASSBIAN_PACKAGE

echo
echo "Uppgrade is now done."
echo
echo
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
return 0
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && hassbian-script-upgrade-package
