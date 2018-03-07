#!/bin/bash

function mosquitto-show-short-info {
  echo "Mosquitto Installer for Hassbian."
}

function mosquitto-show-long-info {
  echo "Installs the Mosquitto package for setting up a local MQTT server."
}

function mosquitto-show-copyright-info {
  echo "Copyright(c) 2016 Dale Higgs <https://github.com/dale3h>."
  echo "Modified by Landrash for use with Hassbian."
}

function mosquitto-install-package {
mosquitto-show-short-info
mosquitto-show-copyright-info

if [ "$ACCEPT" == "true" ]; then
  mqtt_username=pi
  mqtt_password=raspberry
else
  echo
  echo "Please take a moment to setup your first MQTT user"
  echo

  echo -n "Username: "
  read -r mqtt_username
  if [ ! "$mqtt_username" ]; then
    mqtt_username=pi
  fi

  echo -n "Password: "
  read -s -r mqtt_password
  echo
  if [ ! "$mqtt_password" ]; then
    mqtt_password=raspberry
  fi
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
OS_VERSION=$(lsb_release -cs)
if [ ! -f /etc/apt/sources.list.d/mosquitto-"$OS_VERSION".list ]
then
  sudo curl -o /etc/apt/sources.list.d/mosquitto-"$OS_VERSION".list http://repo.mosquitto.org/debian/mosquitto-"$OS_VERSION".list
else
  echo "Already present, skipping..."
fi


echo "Installing mosquitto"
apt-get update
apt-cache search mosquitto
apt-get install -y mosquitto mosquitto-clients

echo "Writing default configuration"
cd /etc/mosquitto || exit
mv mosquitto.conf mosquitto.conf.backup
cp /opt/hassbian/suites/files/mosquitto.conf /etc/mosquitto/mosquitto.conf
chown mosquitto:mosquitto mosquitto.conf

echo "Initializing password file"
touch pwfile
chown mosquitto:mosquitto pwfile
chmod 0600 pwfile

echo "Creating password entry for user $mqtt_username"
mosquitto_passwd -b pwfile "$mqtt_username" "$mqtt_password"

echo "Restarting Mosquitto service"
systemctl restart mosquitto.service

ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

echo "Checking the installation..."
validation=$(pgrep -f mosquitto)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done.\\e[0m"
  echo
  echo "Your MQTT broker is running at $ip_address:1883 or if preferred hassbian.local:1883"
  echo ""
  echo "To continue have a look at https://home-assistant.io/docs/mqtt/"
  echo "For more information see this repo:"
  echo "https://github.com/home-assistant/homebridge-homeassistant#customization"
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo -e "\\e[31mAborting..."
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
