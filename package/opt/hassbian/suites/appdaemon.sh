#!/bin/bash
function appdaemon-show-short-info {
  echo "AppDaemon install script for Hassbian."
}

function appdaemon-show-long-info {
  echo "Installs AppDaemon in a separate Venv onto this system."
}

function appdaemon-show-copyright-info {
  echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>."
}

function appdaemon-install-package {
if [ "$ACCEPT" != "true" ]; then
  if [ -f "/usr/sbin/samba" ]; then
    echo -n "Do you want to add Samba share for AppDaemon configuration? [N/y] : "
    read -r SAMBA
  fi
  echo -n "Enter your Home Assistant API password: "
  read -s -r HOMEASSISTANT_PASSWORD
  printf "\\n"
else
  HOMEASSISTANT_PASSWORD=""
fi

echo "Checking python version to use..."
PYTHONVER=$(echo /usr/local/lib/*python* | awk -F/ '{print $NF}')
echo "Using $PYTHONVER..."

echo "Creating directory for AppDaemon Venv"
mkdir /srv/appdaemon
chown -R homeassistant:homeassistant /srv/appdaemon

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Creating AppDaemon venv"
$PYTHONVER -m venv /srv/appdaemon

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
if [ ! -z "${HOMEASSISTANT_PASSWORD}" ]; then
    sed -i 's/#ha_key:/ha_key: $HOMEASSISTANT_PASSWORD/g' /home/homeassistant/appdaemon/appdaemon.yaml
fi

echo "Deactivating virtualenv"
deactivate
EOF

echo "Copying AppDaemon service file"
cp /opt/hassbian/suites/files/appdaemon.service /etc/systemd/system/appdaemon@homeassistant.service

echo "Enabling AppDaemon service"
systemctl enable appdaemon@homeassistant.service
sync

echo "Starting AppDaemon service"
systemctl start appdaemon@homeassistant.service

if [ "$SAMBA" == "y" ] || [ "$SAMBA" == "Y" ]; then
  echo "Adding configuration to Samba..."
  echo "[appdaemon]" | tee -a /etc/samba/smb.conf
  echo "path = /home/homeassistant/appdaemon" | tee -a /etc/samba/smb.conf
  echo "writeable = yes" | tee -a /etc/samba/smb.conf
  echo "guest ok = yes" | tee -a /etc/samba/smb.conf
  echo "create mask = 0644" | tee -a /etc/samba/smb.conf
  echo "directory mask = 0755" | tee -a /etc/samba/smb.conf
  echo "force user = homeassistant" | tee -a /etc/samba/smb.conf
  echo "" | tee -a /etc/samba/smb.conf
  echo "Restarting Samba service"
  systemctl restart smbd.service
fi

echo "Checking the installation..."
validation=$(pgrep -f appdaemon)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "You will find the AppDaemon configuration files in:"
  echo "/home/homeassistant/appdaemon"
  echo
  echo "To continue have a look at http://appdaemon.readthedocs.io/en/latest/"
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo
  return 1
fi
return 0
}

function appdaemon-upgrade-package {
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
validation=$(pgrep -f appdaemon)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mUpgrade done..\\e[0m"
  echo
  echo "To continue have a look at http://appdaemon.readthedocs.io/en/latest/"
  echo
else
  echo
  echo -e "\\e[31mUpgrade failed..."
  echo
  return 1
fi
return 0
}
[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
