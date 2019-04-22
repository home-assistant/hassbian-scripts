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
    devbranch="-dev"
  else
    echo "Exiting..."
    return 0
  fi
fi

OSRELEASE=$(lsb_release -cs)

echo "Updating apt information..."
echo "deb [trusted=yes] https://gitlab.com/hassbian/repository$devbranch/raw/master $OSRELEASE main" | tee /etc/apt/sources.list.d/hassbian.list
apt update

echo "Checking installed version..."
current_version=$(apt list hassbian-scripts | tail -1 | awk -F'[' '{print $NF}' |  awk -F']' '{print $1}')
if [ "$current_version" != "installed" ]; then
  echo "Removing old version of hassbian-scripts..."
  apt purge -y hassbian-scripts
  apt clean

  echo "Installing newest version of hassbian-scripts..."
  echo "deb [trusted=yes] https://gitlab.com/hassbian/repository$devbranch/raw/master $OSRELEASE main" | tee /etc/apt/sources.list.d/hassbian.list
  apt update
  apt install -y hassbian-scripts
else
  echo "Installed version is up to date, exiting..."
  return 0
fi
systemctl daemon-reload

echo
echo "Upgrade is now done."
echo
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
