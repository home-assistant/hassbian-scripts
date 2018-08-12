#!/bin/bash
function cloud9-show-short-info {
  printf "Cloud9 install script for Hassbian.\\n"
}

function cloud9-show-long-info {
  printf "Installs Cloud9 SDK onto this system.\\n"
  printf "Cloud9 SDK is an webservice IDE that makes it easy to manage your configuration files.\\n"
}

function cloud9-show-copyright-info {
  printf "This script was originally contributed by Ludeeus <https://github.com/ludeeus>.\\n"
}

function cloud9-install-package {
node=$(which node)
if [ -z "${node}" ]; then #Installing NodeJS if not already installed.
  printf "Downloading and installing NodeJS...\\n"
  curl -sL https://deb.nodesource.com/setup_9.x | bash -
  apt install -y nodejs
fi

echo "Creating installation directory..."
mkdir /opt/c9sdk
chown homeassistant:homeassistant /opt/c9sdk

echo "Changing to the homeassistant user"
sudo -u homeassistant -H /bin/bash << EOF
  printf "Downloading and installing Cloud9 SDK...\\n"
  git clone git://github.com/c9/core.git /opt/c9sdk
  bash /opt/c9sdk/scripts/install-sdk.sh
  echo '{"projecttree": {"@showhidden": true,"@hiddenFilePattern": ".n*,*c9*,.b*,.p*,.w*,*.db"}}' | tee /home/homeassistant/.c9/user.settings
  mkdir /home/homeassistant/c9workspace
  ln -s /home/homeassistant/.homeassistant/ /home/homeassistant/c9workspace
  mv /home/homeassistant/.homeassistant /home/homeassistant/homeassistant
EOF

echo "Copying Cloud9 service file..."
cp /opt/hassbian/suites/files/cloud9.service /etc/systemd/system/cloud9@homeassistant.service

echo "Enabling Cloud9 service..."
systemctl enable cloud9@homeassistant.service
sync

echo "Starting Cloud9 service..."
systemctl start cloud9@homeassistant.service

echo "Checking the installation..."
ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')
validation=$(pgrep -f cloud9)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done.\\e[0m"
  echo "Your Cloud9 IDE is now avaiable at http://$ip_address:8181"
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo
    return 1
fi
return 0
}

function cloud9-upgrade-package {
printf "Stopping Cloud9 service...\\n"
systemctl stop cloud9@homeassistant.service
sudo -u homeassistant -H /bin/bash << EOF
  printf "Downloading and installing newest version of Cloud9 SDK...\\n"
  git clone git://github.com/c9/core.git /opt/c9sdk
  bash /opt/c9sdk/scripts/install-sdk.sh
EOF

printf "Starting Cloud9 service...\\n"
systemctl start cloud9@homeassistant.service

echo "Checking the installation..."
validation=$(pgrep -f cloud9)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mUpgrade done.\\e[0m"
  echo
else
  echo
  echo -e "\\e[31mUpgrade failed..."
  echo
    return 1
fi
return 0
}

function cloud9-remove-package {
printf "Removing Cloud9 IDE...\\n"
systemctl stop cloud9@homeassistant.service
systemctl disable cloud9@homeassistant.service
rm /etc/systemd/system/cloud9@homeassistant.service
sync
bash /opt/c9sdk/scripts/uninstall-c9.sh
rm -R /opt/c9sdk

printf "\\e[32mRemoval done..\\e[0m\\n"
}
[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
