#!/bin/bash
function homeassistant-upgrade-show-short-info {
    echo "Home Assistant upgrade script for Hassbian"
}

function homeassistant-upgrade-show-long-info {
    echo "Upgrade the base homeassistant package onto this system."
}

function homeassistant-upgrade-show-copyright-info {
    echo "Original consept by Landrash <https://github.com/Landrash>"
    echo "Modyfied by Ludeeus <https://github.im/Ludeeus>"
}

function homeassistant-upgrade-package {
homeassistant-upgrade-show-short-info
homeassistant-upgrade-show-copyright-info


echo "Stopping Home Assistant"
systemctl stop home-assistant@homeassistant.service

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Creating Home Assistant venv"
python3 -m venv /srv/homeassistant

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing latest version of Home Assistant"
pip3 install --upgrade homeassistant

echo "Deactivating virtualenv"
deactivate
EOF

echo "Starting Home Assistant"
systemctl start home-assistant@homeassistant.service

echo
echo "Uppgrade is now done."
echo "Note that sometimes it takes a while to start up after an upgrade."
echo
echo
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
return 0
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && homeassistant-upgrade-package
