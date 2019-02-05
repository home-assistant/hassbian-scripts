#!/bin/bash
function cloud9-show-short-info {
  printf "Cloud9 script for Hassbian.\\n"
}

function cloud9-show-long-info {
  printf "Cloud9 script for Hassbian.\\n"
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
  echo "Creating workspace for Cloud9."
  mkdir -p /home/homeassistant/c9workspace/.c9
  echo "Create default config."
  echo '{"projecttree": {"@showhidden": false,"@hiddenFilePattern": ".*,.n*,*c9*,.b*,.p*,.w*,*.db"}}' | tee /home/homeassistant/c9workspace/.c9/user.settings
  echo "Symlinking /home/homeassistant/.homeassistant to the workspace."
  ln -s /home/homeassistant/.homeassistant/ /home/homeassistant/c9workspace/homeassistant
EOF

echo "Copying Cloud9 service file..."
cp /opt/hassbian/suites/files/cloud9.service /etc/systemd/system/cloud9@homeassistant.service

echo "Enabling Cloud9 service..."
systemctl enable cloud9@homeassistant.service
sync

echo "Starting Cloud9 service..."
systemctl start cloud9@homeassistant.service

echo "Checking the installation..."
sleep 15
validation=$(pgrep -f cloud9)
if [ ! -z "${validation}" ]; then
  echo "Using fallback installation."
  echo "Installing npm"
  apt install -y npm

  cd /opt/c9sdk || exit 1
  npm install

  echo "Checking the installation..."
  sleep 15
fi

validation=$(pgrep -f cloud9)
if [ -z "${validation}" ]; then
  ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')
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
sleep 15
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
rm -R /home/homeassistant/c9workspace

printf "\\e[32mRemoval done..\\e[0m\\n"
}
[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
