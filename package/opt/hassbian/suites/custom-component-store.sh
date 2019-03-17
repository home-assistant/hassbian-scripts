#!/bin/bash
function custom-component-store-show-short-info {
  echo "Custom component store script."
}

function custom-component-store-show-long-info {
  echo "Custom component store is a web UI tool that can help you manage your custom components."
}

function custom-component-store-show-copyright-info {
  echo "Original concept by Ludeeus <https://github.com/ludeeus>."
}

function custom-component-store-install-package {

if [ "$ACCEPT" == "true" ]; then
  username=pi
  password=raspberry
else
  echo
  echo "Please take a moment to setup your the user account"
  echo

  echo -n "Username: "
  read -r username
  if [ ! "$username" ]; then
    username=pi
  fi

  echo -n "Password: "
  read -s -r password
  echo
  if [ ! "$password" ]; then
    password=raspberry
  fi
fi

echo "Installing latest version of Custom component store"
python3 -m pip install componentstore

echo "Enabling Custom component store service"
cp /opt/hassbian/suites/files/custom-component-store@homeassistant.service /etc/systemd/system/custom-component-store@homeassistant.service

sed -i "s,%%USERNAME%%,${username},g" /etc/systemd/system/custom-component-store@homeassistant.service
sed -i "s,%%PASSWORD%%,${password},g" /etc/systemd/system/custom-component-store@homeassistant.service

systemctl enable custom-component-store@homeassistant.service
sync

echo "Starting Custom component storer"
systemctl start custom-component-store@homeassistant.service

echo "Starting cleanup"
cd || exit 1
rm -R /tmp/custom-component-store

ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

echo "Checking the installation..."
validation=$(pgrep -x componentstore)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo "Custom component store installation is running at $ip_address:8120 or if preferred http://hassbian.local:8120"
  echo
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo
  return 1
fi
return 0
}

function custom-component-store-upgrade-package {
echo "Upgrading Custom component store"
python3 -m pip install --upgrade componentstore

echo "Restarting Custom component store"
systemctl start custom-component-store@homeassistant.service

echo "Checking the installation..."
validation=$(pgrep -x componentstore)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mUpgrade script completed..\\e[0m"
  echo
else
  echo
  echo -e "\\e[31mUpgrade failed..."
  echo
  return 1
fi
return 0
}

function custom-component-store-remove-package {
printf "Removing Custom component store...\\n"
systemctl stop custom-component-store@homeassistant.service
systemctl disable custom-component-store@homeassistant.service
rm /etc/systemd/system/custom-component-store@homeassistant.service
sync


python3 -m pip uninstall --yes componentstore


printf "\\e[32mRemoval done..\\e[0m\\n"
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"