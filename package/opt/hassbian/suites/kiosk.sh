#!/bin/bash

function hue-show-short-info {
    echo "Kiosk mode for attached touchscreen"
}

function hue-show-long-info {
    echo "Configures Chromium autostart and points to localhost:8123"
}

function hue-show-copyright-info {
    echo "Copyright(c) 2018 Ardeus <https://github.com/ardeus-ua>"
}

function kiosk-install-package {
kiosk-show-short-info
kiosk-show-copyright-info

apt-get update
apt-get --no-install-recommends install xserver-xorg xserver-xorg-video-fbdev xinit pciutils xinput xfonts-100dpi xfonts-75dpi xfonts-scalable
apt-get -y --force-yes install screen checkinstall xterm xdotool x11-xserver-utils unclutter chromium-browser x11vnc expect

# Set up x11vnc
mkdir /home/pi/scripts
cp /opt/hassbian/suites/files/setX11vncPass /home/pi/scripts/setX11vncPass
chmod +x /home/pi/scripts/setX11vncPass

sudo -u pi /home/pi/setX11vncPass raspberry
if [ ! -f /home/pi/.vnc/passwd ]; then
  echo "/home/pi/.vnc/passwd was not created. Trying again."
  sudo -u pi /home/pi/scripts/setX11vncPass raspberry
  if [ ! -f /home/pi/.vnc/passwd ]; then
    echo "/home/pi/.vnc/passwd was not created again. Giving up."
    echo "Failed to set a VNC password. Aborting build."
    exit 1
  fi
fi

apt-get clean
apt-get autoremove -y

cp /opt/hassbian/suites/files/kiosk /home/pi/scripts/kiosk
chmod +x /home/pi/scripts/kiosk
echo "sudo -u pi startx /home/pi/scripts/kiosk &" >> /etc/rc.local

echo
echo "Installation done."
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
