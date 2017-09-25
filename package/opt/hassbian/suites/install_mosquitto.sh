#!/bin/bash

function mosquitto-show-short-info {
    echo "Mosquitto Installer for Hassbian"
}

function mosquitto-show-long-info {
	echo "Installs the Mosquitto package for setting up a local MQTT server"
}

function mosquitto-show-copyright-info {
    echo "Copyright(c) 2016 Dale Higgs <https://github.com/dale3h>"
    echo "Modified by Landrash for use with Hassbian."
}

function mosquitto-install-package {
mosquitto-show-short-info
mosquitto-show-copyright-info

if [ "$(id -u)" != "0" ]; then
echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
return 1
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
wget -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -

echo "Adding repository"
cd /etc/apt/sources.list.d
wget http://repo.mosquitto.org/debian/mosquitto-stretch.list

echo "Installing mosquitto"
apt-get update
apt install -y mosquitto mosquitto-clients


if [[ $? > 0 ]]
then
   echo "First try failed, adding dependencies and trying again."
   echo "This is an workaround and will be omited once it's fixed upstream."
   echo "Downloading dependencies"
   cd
   wget http://ftp.se.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_armhf.deb
   wget http://ftp.se.debian.org/debian/pool/main/libw/libwebsockets/libwebsockets3_1.2.2-1_armhf.deb

   echo "Installing dependencies"
   sudo dpkg -i libssl1.0.0_1.0.1t-1+deb8u6_armhf.deb
   sudo dpkg -i libwebsockets3_1.2.2-1_armhf.deb

   echo "Cleanup dependencies"
   rm libssl1.0.0_1.0.1t-1+deb8u6_armhf.deb
   rm libwebsockets3_1.2.2-1_armhf.deb
   
   echo "Retrying installation of mosquitto"
   apt install -y mosquitto mosquitto-clients
else
    echo ""
fi

echo "Writing default configuration"
cd /etc/mosquitto
mv mosquitto.conf mosquitto.conf.backup
cp /opt/hassbian/suites/files/mosquitto.conf /etc/mosquitto/mosquitto.conf
chown mosquitto:mosquitto mosquitto.conf

echo "Initializing password file"
touch pwfile
chown mosquitto:mosquitto pwfile
chmod 0600 pwfile

echo
echo "Please take a moment to setup your first MQTT user"
echo "If no choice is made a default account will be created"
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
systemctl enable mosquitto.service
systemctl restart mosquitto.service


ip_address=$(ifconfig | awk -F':' '/inet addr/&&!/127.0.0.1/{split($2,_," ");print _[1]}')

echo
echo "Installation done!"
echo
echo "Your MQTT broker is running at $ip_address:1883 or if prefered hassbian.local"
echo
echo "To continue have a look at https://home-assistant.io/docs/mqtt/"
echo
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo "Original script by @dale3h"
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config install instead"
