#!/bin/bash
function hassbian-script-show-short-info {
    echo "Hassbian-script upgrade script for Hassbian"
}

function hassbian-script-show-long-info {
    echo "Upgrade hassbian-scripts"
}

function hassbian-script-show-copyright-info {
    echo "Original concept by Ludeeus <https://github.com/ludeeus>"
}

function hassbian-script-upgrade-package {

if [ "$DEV" == "true"  ]; then
  echo "This script downloads new scripts directly from the dev branch on Github."
  echo "you can use this to be on the 'bleeding edge of the development of Hassbian.'"
  echo "This is not recommended for daily use."
  echo -n "Are you really sure you want to continue? [N/y] : "
  read -r RESPONSE
  if [ "$RESPONSE" == "y" ] || [ "$RESPONSE" == "Y" ]; then
    RESPONSE="Y"
  else
    echo "Exiting..."
    return 0
  fi
  echo "Creating and changing in to a temporary folder."
  cd || exit
  sudo mkdir /tmp/hassbian_config_update
  cd /tmp/hassbian_config_update || exit

  echo "Downloading new scripts from github."
  curl -L https://api.github.com/repos/home-assistant/hassbian-scripts/tarball| sudo tar xz --strip=1

  echo "Moving scripts to the install folder."
  yes | sudo cp -rf /tmp/hassbian_config_update/package/usr/local/bin/hassbian-config /usr/local/bin/hassbian-config
  yes | sudo cp -rf /tmp/hassbian_config_update/package/opt/hassbian/suites/* /opt/hassbian/suites/

  echo "Removing the temporary folder."
  cd || exit
  sudo rm -r /tmp/hassbian_config_update
else
  echo "Changing to a temporary folder"
  cd /tmp || exit

  echo "Downloading latest release"
  if [ "$BETA" == "true"  ]; then
    echo "Checking if there is an prerelease available..."
    prerelease=$(curl https://api.github.com/repos/home-assistant/hassbian-scripts/releases | grep '"prerelease": true')
    if [ ! -z "${prerelease}" ]; then
      echo "Prerelease found..."
      curl https://api.github.com/repos/home-assistant/hassbian-scripts/releases | grep "browser_download_url.*deb" | head -1 | cut -d : -f 2,3 | tr -d \" | wget -qi -
    else
      echo "Prerelease not found..."
      echo "Downloading latest stable version..."
      curl https://api.github.com/repos/home-assistant/hassbian-scripts/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -
    fi
  else
    curl https://api.github.com/repos/home-assistant/hassbian-scripts/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -
  fi

  HASSBIAN_PACKAGE=$(echo hassbian*.deb)

  echo "Installing latest release"
  downloadedversion=$(echo "$HASSBIAN_PACKAGE" | awk -F'_' '{print $2}' | cut -d . -f 1,2,3)
  currentversion=$(hassbian-config -V)
  if [[ "$currentversion" > "$downloadedversion" ]]; then
    apt install -y /tmp/"$HASSBIAN_PACKAGE" --allow-downgrades
  else
    apt install -y /tmp/"$HASSBIAN_PACKAGE" --reinstall
  fi
  echo "Cleanup"
  rm "$HASSBIAN_PACKAGE"
fi
echo
echo "Upgrade is now done."
echo
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
