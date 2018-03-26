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
  echo "This scripts downloads new scripts directly from the dev branch on github."
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
  curl https://api.github.com/repos/home-assistant/hassbian-scripts/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -

  # Setting package name
  HASSBIAN_PACKAGE=$(echo hassbian*.deb)

  echo "Installing latest release"
  sudo apt install -y /tmp/"$HASSBIAN_PACKAGE"

  echo "Cleanup"
  rm "$HASSBIAN_PACKAGE"
fi
echo
echo "Upgrade is now done."
echo
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
