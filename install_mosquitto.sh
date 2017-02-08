#!/bin/bash

function mosquitto-show-short-info {
    echo "Mosquitto Installer for Hassbian"
}

function mosquitto-show-long-info {
	echo "Installs the Mosquitto package for setting up a local MQTT server"
}

function mosquitto-show-copyright-info {
    echo "Copyright(c) 2016 Dale Higgs <https://gitter.im/dale3h>"
    echo "Modified by Landrash for use with Hassbian."
}

function mosquitto-install-package {
mosquitto-show-short-info
mosquitto-show-copyright-info

if [ "$(id -u)" != "0" ]; then
echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
exit 1
fi

echo "Adding mosquitto user"
adduser mosquitto --system --group

echo "Creating pid file"
touch /var/run/mosquitto.pid
chown mosquitto:mosquitto /var/run/mosquitto.pid

echo "Creating data directory"
mkdir -p /var/lib/mosquitto
chown mosquitto:mosquitto /var/lib/mosquitto

echo "Installing repository key"
cd /srv/homeassistant/src
wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
apt-key add mosquitto-repo.gpg.key
rm mosquitto-repo.gpg.key

echo "Adding repository"
cd /etc/apt/sources.list.d
wget http://repo.mosquitto.org/debian/mosquitto-jessie.list

echo "Installing mosquitto"
apt-get update
apt-cache search mosquitto
apt-get install -y mosquitto mosquitto-clients

echo "Writing default configuration"
cd /etc/mosquitto
mv mosquitto.conf mosquitto.conf.backup
cp /home/pi/hassbian-scripts/files/mosquitto.conf /etc/mosquitto/mosquitto.conf
chown mosquitto:mosquitto mosquitto.conf

echo "Initializing password file"
touch pwfile
chown mosquitto:mosquitto pwfile
chmod 0600 pwfile

echo
echo "Please take a moment to setup your first MQTT user"
echo

echo -n "Username: "
read mqtt_username
if [ ! "$mqtt_username" ]; then
  mqtt_username=pi
fi

echo -n "Password: "
read -s mqtt_password
echo
if [ ! "$mqtt_password" ]; then
  mqtt_password=raspberry
fi

echo "Creating password entry for user $mqtt_username"
mosquitto_passwd -b pwfile "$mqtt_username" "$mqtt_password"

echo "Restarting Mosquitto service"
systemctl restart mosquitto.service

ip_address=$(ifconfig | awk -F':' '/inet addr/&&!/127.0.0.1/{split($2,_," ");print _[1]}')

echo
echo "Installation done!"
echo
echo "Your MQTT broker is running at $ip_address:1883"
echo
echo "If you have issues with this script, please contact @Landrash on gitter.im"
echo "Original script by @dale3h on gitter.im"
echo
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config install instead"
