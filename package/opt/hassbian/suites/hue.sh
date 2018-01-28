#!/bin/bash

function hue-show-short-info {
    echo "Echo/Home/Mycroft Emulated Hue install script for Hassbian."
}

function hue-show-long-info {
    echo "Configures the Python executable to allow usage of low numbered"
    echo "ports for use with Amazon Echo, Google Home and Mycroft.ai."
}

function hue-show-copyright-info {
    echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>"
}

function hue-install-package {
hue-show-short-info
hue-show-copyright-info

echo "Setting permissions for Python"
if [ -d "/usr/lib/python3.5" ]; then
    echo "Setting permissions for Python 3.5"
    sudo setcap 'cap_net_bind_service=+ep' /usr/bin/python3.5
    else
    echo "Setting permissions for Python 3.4"
    sudo setcap 'cap_net_bind_service=+ep' /usr/bin/python3.4
fi

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
    return 1
fi

echo
echo "Installation done."
echo
echo "To continue have a look at https://home-assistant.io/components/emulated_hue/"
echo
echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
