#!/bin/bash

function libcec-show-short-info {
    echo "libcec install script for Hassbian"
}

function libcec-show-long-info {
	echo "Installs the libcec package for controlling CEC devices from this Pi"
}

function libcec-show-copyright-info {
    echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.im/Landrash>"
}

function libcec-install-package {
libcec-show-short-info
libcec-show-copyright-info

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
   exit 1
fi

echo "Running apt-get preparation"
apt-get update
apt-get install -y cmake libudev-dev libxrandr-dev python-dev swig

echo "Changing to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Creating source directory"
mkdir -p /srv/homeassistant/src
chown -R homeassistant:homeassistant /srv/homeassistant/src

echo "Cloning Pulse-Eight platform"
cd /srv/homeassistant/src
git clone https://github.com/Pulse-Eight/platform.git
chown homeassistant:homeassistant platform

echo "Building Pulse-Eight platform"
mkdir platform/build
cd platform/build
cmake ..
make
EOF

echo "Installing Pulse-Eight platform"
cd /srv/homeassistant/src/platform/build
sudo make install

echo "Changing back to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Cloning Pulse-Eight libcec"
cd /srv/homeassistant/src
git clone https://github.com/Pulse-Eight/libcec.git

echo "Building Pulse-Eight platform"
chown homeassistant:homeassistant libcec
mkdir libcec/build
cd libcec/build
cmake -DRPI_INCLUDE_DIR=/opt/vc/include -DRPI_LIB_DIR=/opt/vc/lib ..
make -j4
EOF

echo "Installing Pulse-Eight libcec"
cd /srv/homeassistant/src/libcec/build
sudo make install
sudo ldconfig

echo "Linking libcec to venv site packages"
sudo -u homeassistant ln -s /usr/local/lib/python3.*/site-packages/cec /srv/homeassistant/lib/python3.*/site-packages/

echo
echo "Installation done."
echo
echo "If you have issues with this script, please contact @Landrash on gitter.im"
echo
echo "To continue have a look at https://home-assistant.io/components/hdmi_cec/"
echo "It's recomended that you restart your Pi before continuing with testing libcec."
echo
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config install instead"
