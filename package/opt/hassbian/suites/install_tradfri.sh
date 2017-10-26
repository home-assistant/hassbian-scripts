#!/bin/bash

function tradfri-show-short-info {
    echo "Tradfri install script for Hassbian"
}

function tradfri-show-long-info {
	echo "Installs the libraries needed to controll IKEA Tradfri devices from this Pi."
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

echo "Activating to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing dependencies for Tradfri."
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install cython

echo "Deactivating virtualenv"
deactivate
EOF

echo
echo "Installation done."
echo
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
echo "To continue have a look at https://home-assistant.io/components/tradfri/"
echo "It's recomended that you restart your Tradfri Gateway before continuing."
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config install instead"
