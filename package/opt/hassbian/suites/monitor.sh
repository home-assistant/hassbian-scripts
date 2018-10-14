#!/bin/bash
function monitor-show-short-info {
  echo "Setup for Monitor. Bluetooth-based passive presence detection."
}

function monitor-show-long-info {
  echo "This script installs Monitor a script for Bluetooth-based passive presence detection."
  echo "The Mosquitto suite will also be installed since it's a dependency for Monitor."
  echo "This script also optionaly installs a service that can be enabled to run Monitor."
}

function monitor-show-copyright-info {
  echo "Original concept by Landrash <https://github.com/landrash>."
}

function monitor-install-package {
echo -n "Installing Mosquitto package: "

echo "Checking the installation..."
validation=$(pgrep -f mosquitto)
if [ ! -z "${validation}" ]; then
  echo "Existing Mosquitto install detected. Skipping install of Mosquitto."
else
  echo "Installing Mosquitto"
hassbian-config install mosquitto accept
fi

echo "Creating Monitor folder..."
mkdir /opt/monitor || exit
cd /opt || exit

echo "Cloning Monitor git repository"
git clone git://github.com/andrewjfreyer/monitor

echo "Running interactive setup"
cd /opt/monitor || exit
bash /opt/monitor/monitor.sh

echo "Checking the installation..."
if [ ! -f /opt/monitor/monitor.sh ]; then
  validation=""
else
  validation="ok"
fi

if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo -e "Update of mqtt_preferences is required found at /opt/monitor/mqtt_prefences"
  echo -e "Some further configuration is required and details can be found here https://github.com/andrewjfreyer/monitor#getting-started "
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
