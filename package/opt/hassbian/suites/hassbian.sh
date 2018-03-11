#!/bin/bash
function hassbian-show-short-info {
  echo "Upgrade the base OS installation on this system."
}

function hassbian-show-long-info {
  echo "Upgrade the base OS installation on this system."
}

function hassbian-show-copyright-info {
  echo "Original concept by Ludeeus <https://github.com/Ludeeus>."
  echo "Modified by Landrash <https://github.com/Landrash>."
}

function hassbian-upgrade-package {
echo "Updating package list"
sudo apt update

echo "Upgrading base operating system"
sudo apt upgrade -y

echo
echo "Upgrade complete."
echo
echo "Note that you may need to reboot the raspberry Pi for some updates to take effect."
echo
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
