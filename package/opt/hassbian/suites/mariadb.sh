#!/bin/bash

function mariadb-show-short-info {
  echo "MariaDB install script for Hassbian."
}

function mariadb-show-long-info {
  echo "Installs the MariaDB database engine and dependecies for use with the recorder component in Home Assistant."
}

function mariadb-show-copyright-info {
  echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>."
}

function mariadb-install-package {
echo "Running apt-get preparation"
apt-get update
apt-get install -y mariadb-server libmariadbclient-dev

echo "Changing to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing dependencies for MariaDB"
pip3 install mysqlclient

echo "Deactivating virtualenv"
deactivate
EOF


echo "Checking the installation..."
validation=$(which mariadb)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "No database or database user is created during this setup and will need to be created manually."
  echo
  echo "To continue have a look at https://home-assistant.io/components/recorder/"
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
