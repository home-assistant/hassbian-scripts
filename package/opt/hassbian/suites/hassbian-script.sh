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
echo "Changing to temporary folder"
cd /tmp || exit

echo "Downloading newest release"
curl https://api.github.com/repos/home-assistant/hassbian-scripts/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -

# Setting package name
HASSBIAN_PACKAGE=$(echo hassbian*.deb)

echo "Installing newest release"
sudo apt install -y /tmp/"$HASSBIAN_PACKAGE"

echo "Cleanup"
rm "$HASSBIAN_PACKAGE"

echo
echo "Upgrade is now done."
echo
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
