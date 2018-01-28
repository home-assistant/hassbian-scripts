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
<<<<<<< HEAD
apt-get install -y cython3 dh-autoreconf
=======
apt-get install -y dh-autoreconf
>>>>>>> pr/1

echo "Changing to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Activating to Home Assistant venv"
source /srv/homeassistant/bin/activate

<<<<<<< HEAD
echo "Cloning modified tinydtls library to a temporary folder."
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install cython
cd
cd /tmp/
git clone --depth 1 https://git.fslab.de/jkonra2m/tinydtls.git
cd tinydtls
cp configure.in configure.ac
rm configure.in
autoreconf
./configure --with-ecc --without-debug
cd cython
python3 setup.py install
cd ../..

echo "Cloning modified lib-coap library"
git clone https://github.com/chrysn/aiocoap
cd aiocoap
git reset --hard 3286f48f0b949901c8b5c04c0719dc54ab63d431
python3 -m pip install .
=======
echo "Installing dependencies for Tradfri."
python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install cython
>>>>>>> pr/1

echo "Deactivating virtualenv"
deactivate
EOF

echo "Cleanup..."
sudo rm -R /tmp/tinydtls
sudo rm -R /tmp/aiocoap

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
