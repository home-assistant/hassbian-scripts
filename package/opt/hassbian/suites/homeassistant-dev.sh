#!/bin/bash
function homeassistant-dev-show-short-info {
    echo "Home Assistant developement branch install script for Hassbian"
}

function homeassistant-dev-show-long-info {
    echo "Installs Home Assistant from the developement branch from github onto this system."
}

function homeassistant-dev-show-copyright-info {
    echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>"
}

function homeassistant-dev-install-package {
homeassistant-dev-show-short-info
homeassistant-dev-show-copyright-info

echo "Stoping Home Assistant"
systemctl stop home-assistant@homeassistant.service
sync

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Creating Home Assistant venv"
python3 -m venv /srv/homeassistant

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing latest version of Home Assistant"
pip3 install git+https://github.com/home-assistant/home-assistant@dev

echo "Deactivating virtualenv"
deactivate
EOF

echo "Enabling Home Assistant service"
systemctl enable home-assistant@homeassistant.service
sync

echo "Starting Home Assistant"
systemctl start home-assistant@homeassistant.service

ip_address=$(ifconfig | awk -F':' '/inet addr/&&!/127.0.0.1/{split($2,_," ");print _[1]}')

echo
echo "Installation done."
echo
echo "Your Home Assistant development branch installation is running at $ip_address:8123 or if prefered http://hassbian.local:8123"
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
