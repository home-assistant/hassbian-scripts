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
apt-get install -y libtool autoconf

echo "Changing to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Creating source directory"
mkdir -p /srv/homeassistant/src
chown -R homeassistant:homeassistant /srv/homeassistant/src

echo "Cloning modified tinydtls library"
cd /srv/homeassistant/src
git clone --depth 1 https://git.fslab.de/jkonra2m/tinydtls.git
cd tinydtls
cp configure.in configure.ac
autoreconf
./configure --with-ecc --without-debug
cd cython

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installingmodified tinydtls library"
python3 setup.py install

echo "Deactivating virtualenv"
deactivate


echo "Cloning modified lib-coap library"
cd /srv/homeassistant/src
git clone https://github.com/chrysn/aiocoap
cd aiocoap
git reset --hard 3286f48f0b949901c8b5c04c0719dc54ab63d431

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing modified lib-coap library"
python3 -m pip install .

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
