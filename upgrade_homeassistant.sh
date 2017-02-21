#!/bin/bash

echo
echo "Home Assistant upgrade script for Hassbian"
echo "Copyright(c) 2017 Mario Limonciello <superm1@ubuntu.com>"

if [ "$(id -u)" != "0" ]; then
echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
exit 1
fi

echo "Stopping home assistant"
sudo systemctl stop home-assistant@homeassistant.service

echo "Changing to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Activating virtualenv"
source /srv/homeassistant/bin/activate

echo "Upgrading home assistant"
pip3 install --upgrade homeassistant

echo "Deactivating virtualenv"
deactivate
EOF

echo "Starting home assistant"
sudo systemctl start home-assistant@homeassistant.service
