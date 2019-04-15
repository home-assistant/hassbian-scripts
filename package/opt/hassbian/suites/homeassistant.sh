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

function python-migration {
  # Implemented to cope with the announced D-Day of Python 3.5
  # To track if this allready have been run, we create a file to hold that "state"
  # /srv/homeassistant/hassbian/pythonmigration with HAVENV=pythonversion as the content.

  force="$1"
  readonly pythonmigrationfile='/srv/homeassistant/hassbian/pythonmigration'
  readonly targetpythonversion='3.7'
  readonly haversionwithrequirement='0.98.0'

  # Get the current python version HA is running under.
  currenthapyversion

  # Check if the file exist
  if [ ! -f "$pythonmigrationfile" ]; then
    # file does not exist, let's create it.
    echo "HAVENV=$CURRENTHAPYVERSION" > "$pythonmigrationfile"
  fi

  # Checks to see if migration is needed.
  pyversion=$(grep "HAVENV" $pythonmigrationfile | awk -F'=' '{print $2}')
  if [[ "${pyversion:0:3}" == "$targetpythonversion" ]]; then
    # Migration not needed.
    return 0
  fi

  if [[ "${CURRENTHAPYVERSION:0:3}" == "$targetpythonversion" ]]; then
    # Migration not needed.
    echo "HAVENV=$CURRENTHAPYVERSION" > "$pythonmigrationfile"
    return 0
  fi

  # Check if migration is needed for the newest HA version.
  newversion=$(curl -s https://api.github.com/repos/home-assistant/home-assistant/releases/latest | grep tag_name | awk -F'"' '{print $4}')
  if [[ "$newversion" < "$haversionwithrequirement" ]]; then
    # Migration not yet needed, store the current version.
    echo "HAVENV=$CURRENTHAPYVERSION" > "$pythonmigrationfile"
    echo
    echo "A migration of your python virtual enviorment for Home Assistant will be needed."
    echo "This will take about 1 hour on a raspberry pi 3."
    echo "When version $haversionwithrequirement is live you will not have a choise."
    echo
    if [ "$force" != "true" ]; then
      echo -n "Do you want to start this migration now? [N/y] : "
      read -r RESPONSE
      if [ "$RESPONSE" == "y" ] || [ "$RESPONSE" == "Y" ]; then
        # shellcheck disable=SC1091
        source /opt/hassbian/suites/python.sh
        python-upgrade-package

        # Quit when execution is done.
        exit 0
      fi
    fi
  else
    # If we get here a migration is needed.
    echo "
#
# MIGRATION IN PROGRESS
# THIS WILL TAKE A LONG TIME, IT IS IMPORTANT THAT YOU DO NOT INTERRUPT THIS
#
#
#
# AFTER THIS MIGRATION YOUR HOME ASSISTANT INSTANCE WILL BE RUNNING UNDER PYTHON $targetpythonversion
#"
    sleep 20
    # shellcheck disable=SC1091
    source /opt/hassbian/suites/python.sh
    python-upgrade-package

    # Quit when execution is done.
    exit 0
  fi

}

function homeassistant-install-package {

# Check if migration is needed.
python-migration true

newestinstalledpython

echo "Setting correct premissions"
chown homeassistant:homeassistant -R /srv/homeassistant

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

  echo "Creating Home Assistant venv"
  python"${INSTALLEDPYTHON::-2}" -m venv /srv/homeassistant

  echo "Changing to Home Assistant venv"
  source /srv/homeassistant/bin/activate

  echo "Installing latest version of Home Assistant"
  python -m pip install setuptools wheel
  python -m pip install homeassistant

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
# Check if migration is needed.
python-migration

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
python -m pip install --upgrade setuptools wheel
if [ "$DEV" == "true" ]; then
  python -m pip install git+https://github.com/home-assistant/home-assistant@dev
elif [ "$BETA" == "true" ]; then
  python -m pip install --upgrade --pre homeassistant
else
  python -m pip install --upgrade homeassistant=="$newversion"
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
      echo "$config_check"
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
      python -m pip install --upgrade homeassistant=="$current_version"
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
