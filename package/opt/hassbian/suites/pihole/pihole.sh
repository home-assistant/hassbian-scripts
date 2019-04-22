#!/bin/bash
function pihole-show-short-info {
  echo "Downloads and runs the Pi-hole install script."
}

function pihole-show-long-info {
  echo "This script downloads and runs the Pi-hole install script"
  echo "All credit for the install script goes to the Pi-hole authors."
}

function pihole-show-copyright-info {
  echo "Original concept by Landrash <https://github.com/landrash>."
}

function pihole-install-package {
echo -n "Downloading Pi-hole install script: "
mkdir /tmp/pihole || exit
cd /tmp/pihole || exit
wget -O basic-install.sh https://install.pi-hole.net

echo "Running interactive setup"
cd /tmp/pihole || exit
chmod +x /tmp/pihole/basic-install.sh || exit
bash /tmp/pihole/basic-install.sh

echo "Checking the installation..."
ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

echo "Checking the installation..."
validation=$(pgrep -f pihole)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done.\\e[0m"
  echo
  echo "Your Pi-Hole instance is running at $ip_address or if preferred hassbian.local"
  echo
  else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
