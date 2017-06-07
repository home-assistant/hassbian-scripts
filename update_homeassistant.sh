#!/bin/sh
echo
echo "Home Assistant update script for Hassbian"
echo "Created by Kent Calero <https://kentcalero.com>"
echo "Update steps taken from  <https://home-assistant.io/getting-started/hassbian-common-tasks>"
echo "Portions of this script were borrowed from the Home Assistant install script for Hassbian by Fredrik Lindqvist Copyright(c) 2017  <https://github.im/Landrash>"
echo

echo "Stopping Home Assistant Service"
sudo systemctl stop home-assistant@homeassistant.service

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo " Update to latest version of Home Assistant"
pip3 install --upgrade homeassistant

echo "Deactivating virtualenv"
deactivate
EOF

echo "Changing to the pi user"
sudo -u pi -H /bin/bash << EOF

echo "Starting Home Assistant Service"
sudo systemctl start home-assistant@homeassistant.service
