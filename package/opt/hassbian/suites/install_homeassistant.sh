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

ip_address=$(ifconfig | awk -F':' '/inet addr/&&!/127.0.0.1/{split($2,_," ");print _[1]}')

echo 
echo "Installation done."
echo
echo "Your Home Assistant installation is running at $ip_address:8123 or if prefered http://hassbian.local:8123"
echo
echo "To continue have a look at https://home-assistant.io/getting-started/configuration/"
echo
echo "If this script failed then this Raspberry Pi most likely did not have a fully functioning internet connection."
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
return 0
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && homeassistant-install-package
