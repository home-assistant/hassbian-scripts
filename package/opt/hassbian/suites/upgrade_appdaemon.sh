#!/bin/bash
function appdaemon-show-short-info {
    echo "AppDaemon upgrade script for Hassbian."
}

function appdaemon-show-long-info {
    echo "Upgrades AppDaemon on this system."
}

function appdaemon-show-copyright-info {
    echo "Contributed by Joakim Sørensen <https://github.com/Ludeeus>"
	echo "Based on the install script contributed by Fredrik Lindqvist <https://github.com/Landrash>."
}

function appdaemon-upgrade-package {
appdaemon-show-short-info
appdaemon-show-copyright-info

echo "Stopping AppDaemon service..."
systemctl stop appdaemon@homeassistant.service

echo "Changing to the homeassistant user..."
sudo -u homeassistant -H /bin/bash << EOF

echo "Changing to AppDaemon venv..."
source /srv/appdaemon/bin/activate

echo "Installing latest version of AppDaemon..."
pip3 install wheel
pip3 install --upgrade appdaemon


echo "Deactivating virtualenv..."
deactivate
EOF

echo "Starting AppDaemon service..."
systemctl start appdaemon@homeassistant.service

echo "Checking the installation..."
validation=$(ps -ef | grep -v grep | grep appdaemon | wc -l)
if [ "$validation" != "0" ]; then
	echo
	echo -e "\e[32mUppgrade done..\e[0m"
	echo
	echo "To continue have a look at http://appdaemon.readthedocs.io/en/latest/"
	echo
	echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
	echo
else
	echo -e "\e[31mInstallation failed..."
	echo -e "\e[31mAborting..."
	echo -e "\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
	return 1
fi
return 0
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && appdaemon-upgrade-package
