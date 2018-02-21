#!/bin/bash

function tradfri-show-short-info {
    echo "Tradfri install script for Hassbian"
}

function tradfri-show-long-info {
	echo "Installs the libraries needed to control IKEA Tradfri devices from this Pi."
}

function tradfri-show-copyright-info {
    echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>"
}

function tradfri-install-package {
tradfri-show-short-info
tradfri-show-copyright-info

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
   return 1
fi

echo "Running apt-get preparation"
apt-get update
apt-get install -y dh-autoreconf

echo "Changing to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Activating Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing dependencies for Tradfri."
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install cython

echo "Deactivating virtualenv"
deactivate
EOF

echo "Checking the installation..."
validation=$(sudo -u homeassistant -H /bin/bash << EOF | grep Version | awk '{print $2}'
source /srv/homeassistant/bin/activate
pip3 show cython
EOF
)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "To continue have a look at https://home-assistant.io/components/tradfri/"
  echo "It's recomended that you restart your Tradfri Gateway before continuing."
  echo
else
  echo -e "\\e[31mInstallation failed..."
  echo -e "\\e[31mAborting..."
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
