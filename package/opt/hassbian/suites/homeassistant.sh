#!/bin/bash
function homeassistant-show-short-info {
    echo "Home Assistant install script for Hassbian"
}

function homeassistant-show-long-info {
    echo "Installs the base homeassistant package onto this system."
}

function homeassistant-show-copyright-info {
    echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>"
}

function homeassistant-install-package {
homeassistant-show-short-info
homeassistant-show-copyright-info

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Creating Home Assistant venv"
python3 -m venv /srv/homeassistant

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing latest version of Home Assistant"
pip3 install setuptools wheel
pip3 install homeassistant

echo "Deactivating virtualenv"
deactivate
EOF

echo "Enabling Home Assistant service"
systemctl enable home-assistant@homeassistant.service
sync

echo "Disabling the Home Assistant install script"
systemctl disable install_homeassistant
systemctl daemon-reload

echo "Starting Home Assistant"
systemctl start home-assistant@homeassistant.service

ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

echo
echo "Installation done."
echo
echo "Your Home Assistant installation is running at $ip_address:8123 or if prefered http://hassbian.local:8123"
echo
echo "To continue have a look at https://home-assistant.io/getting-started/configuration/"
echo
echo "If this script failed then this Raspberry Pi most likely did not have a fully functioning internet connection."
echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
echo
return 0
}

function homeassistant-upgrade-package {
homeassistant-show-short-info
homeassistant-show-copyright-info

echo "Checking current version"
pypiversion=$(curl -s https://pypi.python.org/pypi/homeassistant/json | grep '"version":' | awk -F'"' '{print $4}')

sudo -u homeassistant -H /bin/bash << EOF | grep Version|awk '{print $2'}|while read version; do if [[ ${pypiversion} == ${version} ]]; then echo "You already have the latest version: $version";exit 1;fi;done
source /srv/homeassistant/bin/activate
pip3 show homeassistant
EOF

if [[ $? == 1 ]]; then
        echo "Stopping upgrade"
        exit 1
fi

echo "Stopping Home Assistant"
systemctl stop home-assistant@homeassistant.service

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing latest version of Home Assistant"
pip3 install --upgrade setuptools wheel
pip3 install --upgrade homeassistant

echo "Deactivating virtualenv"
deactivate
EOF

echo "Restarting Home Assistant"
systemctl start home-assistant@homeassistant.service

echo
echo "Uppgrade complete."
echo
echo "Note that it may take some time to start up after an upgrade."
echo
echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
