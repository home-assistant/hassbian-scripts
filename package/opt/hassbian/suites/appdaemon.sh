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
if [ "$ACCEPT" != "true" ]; then
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
[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
