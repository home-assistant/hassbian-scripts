#!/bin/bash

function hue-show-short-info {
  echo "Echo/Home/Mycroft Emulated Hue install script for Hassbian."
}

function hue-show-long-info {
  echo "Configures the Python executable to allow usage of low numbered"
  echo "ports for use with Amazon Echo, Google Home and Mycroft.ai."
}

function hue-show-copyright-info {
  echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>."
}

function hue-install-package {
hue-show-short-info
hue-show-copyright-info

echo "Setting permissions for Python."
PYTHONVER=$(echo /usr/lib/*python* | awk -F/ '{print $NF}')
sudo setcap 'cap_net_bind_service=+ep' /usr/bin/"$PYTHONVER"

echo "Checking the installation..."
validation=$(getcap /usr/bin/"$PYTHONVER" | awk -F'= ' '{print $NF}')
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\e[32mInstallation done..\e[0m"
  echo
  echo "To continue have a look at https://home-assistant.io/components/emulated_hue/"
  echo
else
  echo -e "\e[31mInstallation failed..."
  echo -e "\e[31mAborting..."
  echo -e "\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
