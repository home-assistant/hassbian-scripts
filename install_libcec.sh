#!/bin/bash

echo
echo "libcec install script for Hassbian"
echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.im/Landrash>"
echo

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root or use \"sudo ${0} ${*}\"" 1>&2
   exit 1
fi

echo "Running apt-get preparation"
apt-get update
apt-get install -y install cmake libudev-dev libxrandr-dev python-dev swig

echo "Changing to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Creating source directory"
mkdir -p /srv/homeassistant/src
chown -R homeassistant:homeassistant /srv/homeassistant/src

echo "Cloning Pulse-Eight platform"
cd /srv/homeassistant/src
git clone git clone https://github.com/Pulse-Eight/platform.git
chown homeassistant:homeassistant platform

echo "Building Pulse-Eight platform"
mkdir platform/build
cd platform/build
cmake ..
make
EOF

echo "Installing Pulse-Eight platform"
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
sudo make install
sudo ldconfig

echo "Installation done."
echo
echo "To continue have a look at https://home-assistant.io/components/hdmi_cec/"
echo
