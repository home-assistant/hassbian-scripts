#!/bin/bash

function mariadb-show-short-info {
    echo "MariaDB install script for Hassbian"
}

function mariadb-show-long-info {
	echo "Installs the MariaDB database engine and dependecies for use with the recorder in Home Assistant"
}

function mariadb-show-copyright-info {
    echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>"
}

function mariadb-install-package {
mariadb-show-short-info
mariadb-show-copyright-info

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
   return 1
fi

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

echo
echo "Installation done."
echo
echo "No database or database user is created during this setup and will need to be created manually."
echo
echo "To continue have a look at https://home-assistant.io/components/recorder/"
echo
echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
