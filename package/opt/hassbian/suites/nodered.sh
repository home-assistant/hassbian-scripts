#!/bin/bash
function nodered-show-short-info {
  echo "Install and configure Node-RED."
}

function nodered-show-long-info {
  echo "Install and configure Node-RED"
  echo "This will allow you to setup automation in Home Assistant visually."
}

function nodered-show-copyright-info {
  echo "Copyright(c) 2018 Jocelyn Chen <https://github.com/cxlwill>"
}

function nodered-install-package {
echo "Preparing system, and adding dependencies......"
sudo apt update
sudo apt -y upgrade
node=$(which node)
if [ -z "${node}" ]; then #Installing NodeJS if not already installed.
  printf "Downloading and installing NodeJS...\\n"
  curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
  apt install -y nodejs
fi

echo "Installing Node-RED for Home Assistant"
sudo npm install -g --unsafe-perm node-red
cd ~/.node-red
npm install node-red-contrib-home-assistant

echo "Enabling Node-RED service"
sudo wget https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/nodered.service -O /lib/systemd/system/nodered.service
sudo wget https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/node-red-start -O /usr/bin/node-red-start
sudo wget https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/node-red-stop -O /usr/bin/node-red-stop
sudo chmod +x /usr/bin/node-red-st*
sudo systemctl daemon-reload
sudo systemctl enable nodered.service

echo "Starting Node-RED service"
sudo systemctl start nodered.service
sleep 2 #Node-red needs seconds to launch or Installation Check would fail

ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

echo "Checking the installation..."
validation=$(pgrep -x node-red)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done...\\e[0m"
  echo "Your Node-RED installation is running at $ip_address:1880"
  echo "You can use node-red-start/stop launch or stop service easily."
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo -e "\\e[31mExit..."
  echo
  return 1
fi
return 0
}


[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"

