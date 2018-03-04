#!/bin/bash

function python-show-short-info {
  echo "Upgrades python3 and virtual environment to the newest version."
}

function python-show-long-info {
  echo "Upgrades python3 and virtual environment to the newest version."
}

function python-show-copyright-info {
  echo "This script was originally contributed by Ludeeus <https://github.com/ludeeus>."
}

function python-upgrade-package {
python-show-short-info
python-show-copyright-info
PYTHONVERSION=$(curl -s https://www.python.org/downloads/source/ | grep "Latest Python 3 Release" | cut -d "<" -f 3 | awk -F ' ' '{print $NF}')

echo "Installing Python $PYTHONVERSION"
apt-get -y update
apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev
apt-get install libtcmalloc-minimal4
export LD_PRELOAD="/usr/lib/libtcmalloc_minimal.so.4"
cd /tmp || return 1
wget https://www.python.org/ftp/python/"$PYTHONVERSION"/Python-"$PYTHONVERSION".tar.xz
tar xf Python-"$PYTHONVERSION".tar.xz
cd Python-"$PYTHONVERSION" || return 1
./configure --enable-optimizations
make
apt -y autoremove
cd  || return 1
rm -r /tmp/Python-"$PYTHONVERSION"
rm /tmp/Python-"$PYTHONVERSION".tar.xz
echo "Done"

echo "Stopping Home Assistant."
systemctl stop home-assistant@homeassistant.service

echo "Backing up previous virutal enviorment."
mv /srv/homeassistant /srv/homeassistant_old
sudo -u homeassistant -H /bin/bash << EOF
source /srv/homeassistant/bin/activate
pip3 freeze —local > /tmp/requirements.txt
deactivate
EOF

echo "Creating new virutal enviorment using Python $PYTHONVERSION"
python3.6 -m venv /srv/homeassistant
sudo chown homeassistant:homeassistant /srv/homeassistant
sudo mv /srv/homeassistant_old/hassbian /srv/homeassistant/hassbian
sudo apt-get install python3-pip python3-dev
sudo pip3 install --upgrade virtualenv
sudo -u homeassistant -H /bin/bash << EOF
source /srv/homeassistant/bin/activate
pip3 install -r /tmp/requirements.txt
pip3 install --upgrade homeassistant
deactivate
EOF
mv /home/homeassistant/.homeassistant/deps /home/homeassistant/.homeassistant/deps_old

echo "Starting Home Assistant."
sudo curl -o /etc/systemd/system/home-assistant@homeassistant.service https://raw.githubusercontent.com/home-assistant/hassbian-scripts/dev/package/etc/systemd/system/home-assistant%40homeassistant.service
sudo systemctl enable home-assistant@homeassistant.service
sudo systemctl daemon-reload
sudo systemctl start home-assistant@homeassistant.service

echo "Checking the installation..."
validation=$(sudo -u homeassistant -H /bin/bash << EOF | grep Version | awk '{print $2}'
source /srv/homeassistant/bin/activate
python -V
EOF
)
if [ "$validation" == "Python $PYTHONVERSION" ]; then
  echo
  echo -e "\\e[3231mUpgrade done..\\e[0m"
  echo
else
  echo
  echo -e "\\e[31mUpgrade failed..."
  echo -e "\\e[31mReverting..."
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
