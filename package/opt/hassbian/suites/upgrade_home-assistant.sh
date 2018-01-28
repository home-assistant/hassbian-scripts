#!/bin/bash
function home-assistant-show-short-info {
    echo "Home Assistant upgrade script for Hassbian"
}

function home-assistant-show-long-info {
    echo "Upgrade the Home Assistant installation on this system"
}

function home-assistant-show-copyright-info {
    echo "Original concept by Landrash <https://github.com/Landrash>"
    echo "Modyfied by Ludeeus <https://github.im/Ludeeus>"
}

function home-assistant-upgrade-package {
home-assistant-show-short-info
home-assistant-show-copyright-info

echo "Checking current version"

function jsonValue() {
        KEY=$1
        num=$2
        awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}

versiongit=$(curl -s -X GET https://api.github.com/repos/home-assistant/home-assistant/releases/latest | jsonValue tag_name 1|sed -e 's/^[[:space:]]*//')

sudo -u homeassistant -H /bin/bash << EOF | grep Version|awk '{print $2'}|while read version; do if [[ ${versiongit} == ${version} ]]; then echo "You already have the latest version: $version";exit 1;fi;done
source /srv/homeassistant/bin/activate
pip3 show homeassistant
EOF

if [[ $? == 1 ]]; then
        echo "Stopping upgrade"
        exit 1
fi

echo "Stopping Home Assistant"
systemctl stop home-assistant@homeassistant.service

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF

echo "Changing to Home Assistant venv"
source /srv/homeassistant/bin/activate

echo "Installing latest version of Home Assistant"
pip3 install --upgrade setuptools wheel
pip3 install --upgrade homeassistant

echo "Deactivating virtualenv"
deactivate
EOF

echo "Restarting Home Assistant"
systemctl start home-assistant@homeassistant.service

echo
echo "Uppgrade complete."
echo
echo "Note that it may take some time to start up after an upgrade."
echo
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
return 0
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && home-assistant-upgrade-package
