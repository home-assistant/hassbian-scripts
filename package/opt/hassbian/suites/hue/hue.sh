#!/bin/bash

function hue-show-short-info {
  echo "Echo/Mycroft Emulated Hue install script for Hassbian."
}

function hue-show-long-info {
  echo "Configures the Python executable to allow usage of low numbered"
  echo "ports for use with Amazon Echo or Mycroft.ai."
}

function hue-show-copyright-info {
  echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>."
}

function hue-install-package {
echo "Setting permissions for Python."
PYTHONVER=$(echo /usr/lib/*python* | awk -F/ '{print $NF}')
setcap 'cap_net_bind_service=+ep' /usr/bin/"$PYTHONVER"

echo "Checking the installation..."
validation=$(getcap /usr/bin/"$PYTHONVER" | awk -F'= ' '{print $NF}')
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "To continue have a look at https://home-assistant.io/components/emulated_hue/"
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
