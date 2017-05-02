#!/bin/bash

function openzwave-pip-show-short-info {
    echo "Open Z-Wave Installer using pip for Hassbian"
}

function openzwave-pip-show-long-info {
	echo "Installs the Open Z-wave package using pip packagese for setting up your zwave network"
}

function openzwave-pip-show-copyright-info {
    echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.im/Landrash>"
}

function openzwave-pip-install-package {
openzwave-pip-show-short-info
openzwave-pip-show-copyright-info

echo
echo 

if [ "$(id -u)" != "0" ]; then
echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
return 1
fi

echo "Running apt-get preparation"
apt-get update
apt-get upgrade -y
apt-get install -y --force-yes -y make libudev-dev g++ libyaml-dev

echo "Changing to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Activating virtualenv"
source /srv/homeassistant/bin/activate

# echo "Installing pip dependencies"
# pip3 install cython wheel six
# pip3 install 'PyDispatcher>=2.0.5'

echo "Installing Python OpenZWave"
pip3 install python_openzwave

echo "Deactivating virtualenv"
deactivate
EOF

echo "Linking Home Assistant OpenZWave config directory"
cd /home/homeassistant/.homeassistant
sudo -u homeassistant ln -sd /srv/homeassistant/lib/python3.*/site-packages/python_openzwave/ozw_config
chown -R homeassistant:homeassistant /home/homeassistant/.homeassistant

echo
echo "Installation done."
echo
echo "If you have issues with this script, please contact @Landrash on gitter.im"
echo
echo "To continue have a look at https://home-assistant.io/components/zwave/"
echo
echo "It's recomended that you set the optional config parameter for zwave."
echo "to config_path: ozw_config ."
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config install instead"
