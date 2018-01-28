#!/bin/bash
function hassbian-show-short-info {
    echo "Home Assistant upgrade script for Hassbian"
}

function hassbian-show-long-info {
    echo "Upgrade the base OS installation on this system"
}

function hassbian-show-copyright-info {
    echo "Original concept by Ludeeus <https://github.im/Ludeeus>"
    echo "Modyfied by Landrash <https://github.com/Landrash>"
}

function hassbian-upgrade-package {
hassbian-show-short-info
hassbian-show-copyright-info

echo "Updating package list"
sudo apt update

echo "Upgrading base operating system"
sudo apt upgrade -y

echo
echo "Uppgrade complete."
echo
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
echo "Note that you may need to reboot the raspberry Pi for some updates to take effect."
echo
read -p "Would you like to reboot your raspberry Pi now? (y/n)?" choice
case "$choice" in
  y|Y ) sudo reboot;;
  n|N ) echo;;
  * ) echo "invalid";;
esac
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && hassbian-upgrade-package
