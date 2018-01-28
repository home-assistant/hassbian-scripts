#!/bin/bash
function hassbian-script-dev-show-short-info {
    echo "Uppdates scripts from the dev branch."
}

function hassbian-script-dev-show-long-info {
    echo "This scripts downloads new scripts directly from the dev branch on github."
    echo "you can use this to be on the 'bleeding edge of the development of Hassbian.'"
    echo "This is not recomended for daily use."
}

function hassbian-script-dev-show-copyright-info {
	echo "Original concept by Ludeeus <https://github.com/Ludeeus>"
}

function hassbian-script-dev-upgrade-package {
hassbian-script-dev-show-short-info
hassbian-script-dev-show-copyright-info

echo "Creation and changing in to temporary folder."
cd
sudo mkdir /tmp/hassbian_config_update
cd /tmp/hassbian_config_update

echo "Downloading new scripts from github."
curl -L https://api.github.com/repos/home-assistant/hassbian-scripts/tarball| sudo tar xz --strip=1

echo "Moving scripts to the correct folder."
yes | sudo cp -rf /tmp/hassbian_config_update/package/usr/local/bin/hassbian-config /usr/local/bin/hassbian-config
yes | sudo cp -rf /tmp/hassbian_config_update/package/opt/hassbian/suites/* /opt/hassbian/suites/

echo "Removing the temporary folder."
cd
sudo rm -r /tmp/hassbian_config_update

echo
echo "Upgrade is done."
echo
echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
