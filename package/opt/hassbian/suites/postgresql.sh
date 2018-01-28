#!/bin/bash

function postgresql-show-short-info {
    echo "PostgreSQL install script for Hassbian"
}

function postgresql-show-long-info {
	echo "Installs the PostgreSQL database engine and dependecies for use with the recorder in Home Assistant"
}

function postgresql-show-copyright-info {
    echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>"
}

function postgresql-install-package {
postgresql-show-short-info
postgresql-show-copyright-info

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
   return 1
fi

echo "Running apt-get preparation"
apt-get update
apt-get install -y postgresql-server-dev-9.6


echo "Changing to homeassistant user"
sudo -u homeassistant -H /bin/bash <<EOF

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing dependencies for PostgreSQL"
pip3 install psycopg2

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
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
