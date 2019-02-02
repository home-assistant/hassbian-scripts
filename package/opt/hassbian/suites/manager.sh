#!/bin/bash
function manager-show-short-info {
  echo "Hassbian manager script."
}

function manager-show-long-info {
  echo "Hassbian manager is a web UI tool that can help you manage your suites."
}

function manager-show-copyright-info {
  echo "Original concept by Ludeeus <https://github.com/ludeeus>."
}

function manager-install-package {

echo "Installing latest version of Hassbian manager"
python3 -m pip install setuptools wheel
python3 -m pip install pyhassbian


echo "Enabling Hassbian manager service"
cp /opt/hassbian/suites/files/hassbian-manager@homeassistant.service /etc/systemd/system/hassbian-manager@homeassistant.service
systemctl enable hassbian-manager@homeassistant.service
sync

echo "Starting Hassbian manager"
systemctl start hassbian-manager@homeassistant.service

ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

echo "Checking the installation..."
validation=$(pgrep -x pyhassbian)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo "Hassbian manager installation is running at $ip_address:9999 or if preferred http://hassbian.local:9999"
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

function manager-upgrade-package {
echo "Upgrading Hassbian manager"
python3 -m pip install --upgrade pyhassbian

echo "Restarting Hassbian manager"
systemctl start hassbian-manager@homeassistant.service

echo "Checking the installation..."
validation=$(pgrep -x pyhassbian)
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

function manager-remove-package {
printf "Removing Hassbian manager...\\n"
systemctl stop hassbian-manager@homeassistant.service
systemctl disable hassbian-manager@homeassistant.service
rm /etc/systemd/system/hassbian-manager@homeassistant.service
sync

echo "Removing Hassbian manager"
python3 -m pip uninstall pyhassbian

printf "\\e[32mRemoval done..\\e[0m\\n"
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
