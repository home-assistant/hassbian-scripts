#!/bin/bash
function home-assistant-show-short-info {
    echo "Home Assistant upgrade script for Hassbian"
}

function home-assistant-show-long-info {
    echo "Upgrade the Home Assistant installation on this system"
}

function home-assistant-show-copyright-info {
    echo "Original concept by Landrash <https://github.com/Landrash>"
    echo "Modyfied by Ludeeus <https://github.im/Ludeeus>"
}

function home-assistant-upgrade-package {
home-assistant-show-short-info
home-assistant-show-copyright-info


echo "Stopping Home Assistant"
systemctl stop home-assistant@homeassistant.service

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing latest version of Home Assistant"
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
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
return 0
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && home-assistant-upgrade-package
