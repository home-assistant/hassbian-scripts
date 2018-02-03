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
touch /home/homeassistant/appdaemon/apps.yaml

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

if [ -f "/usr/sbin/samba" ]; then
	read -p "Do you want to add samba share for AppDaemon configuration? [N/y] : " SAMBA
	if [ "$SAMBA" == "y" ] || [ "$SAMBA" == "Y" ]; then
		echo "Adding configuration to samba..."
		echo "[appdaemon]" | tee -a /etc/samba/smb.conf
		echo "path = /home/homeassistant/appdaemon" | tee -a /etc/samba/smb.conf
		echo "writeable = yes" | tee -a /etc/samba/smb.conf
		echo "guest ok = yes" | tee -a /etc/samba/smb.conf
		echo "create mask = 0644" | tee -a /etc/samba/smb.conf
		echo "directory mask = 0755" | tee -a /etc/samba/smb.conf
		echo "force user = homeassistant" | tee -a /etc/samba/smb.conf
		echo "" | tee -a /etc/samba/smb.conf
		echo "Restarting Samba service"
		sudo systemctl restart smbd.service
	fi
fi


echo 
echo "Installation done."
echo
echo "You may find the appdaemon configuration files in:"
echo "/home/homeassistant/appdaemon"
echo "To continue have a look at http://appdaemon.readthedocs.io/en/latest/"
echo
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
return 0
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && appdaemon-install-package
