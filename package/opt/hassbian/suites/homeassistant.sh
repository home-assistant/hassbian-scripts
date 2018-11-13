#!/bin/bash
function homeassistant-show-short-info {
  echo "Home Assistant install script for Hassbian."
}

function homeassistant-show-long-info {
  echo "Installs the base homeassistant package onto this system."
}

function homeassistant-show-copyright-info {
  echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>."
}

function homeassistant-install-package {
echo "Setting correct premissions"
chown homeassistant:homeassistant -R /srv/homeassistant

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Creating Home Assistant venv"
python3 -m venv /srv/homeassistant

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing latest version of Home Assistant"
python3 -m pip install setuptools wheel
python3 -m pip install homeassistant

echo "Deactivating virtualenv"
deactivate
EOF

echo "Enabling Home Assistant service"
systemctl enable home-assistant@homeassistant.service
sync

echo "Disabling the Home Assistant install script"
systemctl disable install_homeassistant
systemctl daemon-reload

echo "Starting Home Assistant"
systemctl start home-assistant@homeassistant.service

ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

echo "Checking the installation..."
validation=$(pgrep -x hass)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo "Your Home Assistant installation is running at $ip_address:8123 or if preferred http://hassbian.local:8123"
  echo "To continue have a look at https://home-assistant.io/getting-started/configuration/"
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

function homeassistant-upgrade-package {
if [ "$DEV" == "true"  ]; then
  echo "This script downloads Home Assistant directly from the dev branch on Github."
  echo "you can use this to be on the 'bleeding edge of the development of Home Assistant.'"
  echo "This is not recommended for daily use."
  echo -n "Are you really sure you want to continue? [N/y] : "
  read -r RESPONSE
  if [ "$RESPONSE" == "y" ] || [ "$RESPONSE" == "Y" ]; then
    RESPONSE="Y"
  else
    echo "Exiting..."
    return 0
  fi
else
  echo "Checking current version"
  if [ "$BETA" == "true"  ]; then
  newversion=$(curl -s https://api.github.com/repos/home-assistant/home-assistant/releases | grep tag_name | head -1 | awk -F'"' '{print $4}')
  elif [ ! -z "${VERSIONNUMBER}" ]; then
    verify=$(curl -s https://pypi.org/pypi/homeassistant/"$VERSIONNUMBER"/json)
    if [[ "$verify" = *"Not Found"* ]]; then
      echo "Version $VERSIONNUMBER not found..."
      echo "Exiting..."
      return 0
    else
      newversion="$VERSIONNUMBER"
    fi
  else
    newversion=$(curl -s https://api.github.com/repos/home-assistant/home-assistant/releases/latest | grep tag_name | awk -F'"' '{print $4}')
  fi
  sudo -u homeassistant -H /bin/bash << EOF | grep Version | awk '{print $2}'|while read -r version; do if [[ "${newversion}" == "${version}" ]]; then echo "You already have version: $version";exit 1;fi;done
  source /srv/homeassistant/bin/activate
  python3 -m pip show homeassistant
EOF

  if [[ $? == 1 ]]; then
    echo "Stopping upgrade"
    exit 1
  fi
fi

echo "Setting correct premissions"
chown homeassistant:homeassistant -R /srv/homeassistant

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Upgrading Home Assistant"
python3 -m pip install --upgrade setuptools wheel
if [ "$DEV" == "true" ]; then
  python3 -m pip install git+https://github.com/home-assistant/home-assistant@dev
elif [ "$BETA" == "true" ]; then
  python3 -m pip install --upgrade --pre homeassistant
else
  python3 -m pip install --upgrade homeassistant=="$newversion"
fi

echo "Deactivating virtualenv"
deactivate
EOF

if [ "$FORCE" != "true"  ]; then
  current_version=$(cat /home/homeassistant/.homeassistant/.HA_VERSION)
  config_check=$(sudo -u homeassistant -H /bin/bash << EOF
  source /srv/homeassistant/bin/activate
  hass --script check_config -c /home/homeassistant/.homeassistant/
EOF
  )
  config_check_lines=$(echo "$config_check" | wc -l)
  if (( config_check_lines > 2 ));then
    if [ "$ACCEPT" != "true" ]; then
      echo -n "Config check failed for new version, do you want to revert? [Y/n] : "
      read -r RESPONSE
      if [ ! "$RESPONSE" ]; then
        RESPONSE="Y"
      fi
    else
      RESPONSE="Y"
    fi
    if [ "$RESPONSE" == "y" ] || [ "$RESPONSE" == "Y" ]; then
      sudo -u homeassistant -H /bin/bash << EOF
      source /srv/homeassistant/bin/activate
      python3 -m pip install --upgrade homeassistant=="$current_version"
      deactivate
EOF
    fi
  fi
fi

echo "Restarting Home Assistant"
systemctl restart home-assistant@homeassistant.service

echo "Checking the installation..."
validation=$(pgrep -x hass)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mUpgrade script completed..\\e[0m"
  echo "Note that it may take some time to start up after an upgrade."
  echo
else
  echo
  echo -e "\\e[31mUpgrade failed..."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
