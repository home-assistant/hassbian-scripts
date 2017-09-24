#!/bin/bash
function appdaemon-show-short-info {
    echo "AppDaemon install script for Hassbian"
}

function appdaemon-show-long-info {
    echo "Installs AppDaemon in a separate Venv onto this system."
}

function appdaemon-show-copyright-info {
    echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>"
}

function appdaemon-install-package {
appdaemon-show-short-info
appdaemon-show-copyright-info

echo "Creating directory for AppDaemon Venv"
sudo mkdir /srv/appdaemon
sudo chown -R homeassistant:homeassistant /srv/appdaemon 

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Creating AppDaemon venv"
python3 -m venv /srv/appdaemon

echo "Changing to AppDaemon venv"
source /srv/appdaemon/bin/activate

echo "Creating directory for AppDaemon configuration file"
mkdir /home/homeassistant/appdaemon
mkdir /home/homeassistant/appdaemon/apps

echo "Installing latest version of AppDaemon"
pip3 install wheel
pip3 install appdaemon

echo "Copying AppDaemon config file"
cp /opt/hassbian/suites/files/appdaemon.conf /home/homeassistant/appdaemon/appdaemon.yaml

echo "Deactivating virtualenv"
deactivate
EOF

echo "Copying AppDaemon service file"
sudo cp /opt/hassbian/suites/files/appdaemon.service /etc/systemd/system/appdaemon@homeassistant.service

echo "Enabling AppDaemon service"
systemctl enable appdaemon@homeassistant.service
sync

echo "Starting AppDaemon service"
systemctl start appdaemon@homeassistant.service

echo 
echo "Installation done."
echo
echo "To continue have a look at http://appdaemon.readthedocs.io/en/latest/"
echo
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
return 0
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && homeassistant-install-package
