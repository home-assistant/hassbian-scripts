#!/bin/bash
function homebridge-show-short-info {
    echo "Removes Homebridge from this system."
}

function homebridge-show-long-info {
    echo "Removes Homebridge from this system."
}

function homebridge-show-copyright-info {
    echo "Original concept by Ludeeus <https://github.com/ludeeus>."
}

function homebridge-install-package {
    echo "The installation of homebrige has been deprecated in favor of the 'homekit' component."
    echo "To remove homebridge from this system run 'sudo hassbian-config remove homebridge.'"
}

function homebridge-remove-package {
    echo "Starting removal of Homebridge."

    echo "Removing service."
    systemctl stop homebridge.service
    systemctl disable homebridge.service
    rm /etc/systemd/system/homebridge.service
    systemctl daemon-reload

    echo "Removing the homebridge user."
    deluser --remove-home homebridge

    echo "Removing homebridge."
    npm remove -g homebridge-homeassistant
    npm remove -g --unsafe-perm homebridge hap-nodejs node-gyp

    return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
