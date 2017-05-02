#!/bin/bash

function tellstick-show-short-info {
        echo "Tellstick install script for Hassbian"
}

function tellstick-show-long-info {
        echo "Installs the Tellstick package for controling and using a Tellstick"
        echo "connected to the Pi."
}

function tellstick-show-copyright-info {
        echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.im/Landrash>"
}

function tellstick-install-package {
tellstick-show-short-info
tellstick-show-copyright-info

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
   return 1
fi

echo "Adding repository"
sh -c 'echo "deb http://download.telldus.com/debian/ stable main" > /etc/apt/sources.list.d/tellstick.list'
apt-key adv --fetch-keys http://download.telldus.se/debian/telldus-public.key

echo "Installing tellstick software"
apt-get update
apt-get install -y telldus-core libftdi1

echo
echo "Installation done."
echo
echo "If you have issues with this script, please contact @Landrash on gitter.im"
echo
echo "To continue have a look at https://home-assistant.io/components/tellstick/"
echo "It's recomended that you restart your Pi before continuing."
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config install instead"
