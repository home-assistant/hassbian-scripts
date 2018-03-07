#!/bin/bash
function python-show-short-info {
  echo "Upgrades python3 and virtual environment to the newest stable version."
}

function python-show-long-info {
  echo "Upgrades python3 and virtual environment to the newest stable version."
}

function python-show-copyright-info {
  echo "This script was originally contributed by Ludeeus <https://github.com/ludeeus>."
}

function python-upgrade-package {
python-show-short-info
python-show-copyright-info

if [ "$FORCE" == "" ]; then
  printf "\\n\\n"
  echo "This script will change a lot on your pi."
  echo "DO NOT run this if you absolutely have to."
  echo "You can force run the upgrade script like this:"
  echo "sudo hassbian-config upgrade python --force"
  return 0
fi

printf "\\n\\n"
echo "It is NOT recomended to run this."
echo -n "Are you really sure you want to run this script? [N/y]: "
read -r RESPONSE
if [ "$RESPONSE" == "y" ] || [ "$RESPONSE" == "Y" ]; then
  RESPONSE="Y"
else
  return 0
fi

PYTHONVERSION=$(curl -s https://www.python.org/downloads/source/ | grep "Latest Python 3 Release" | cut -d "<" -f 3 | awk -F ' ' '{print $NF}')

echo "Checking current version..."
currentpython=$(sudo -u homeassistant -H /bin/bash << EOF | awk -F ' ' '{print $NF}'
source /srv/homeassistant/bin/activate
python -V
EOF
)

if [ "$currentpython" == "$PYTHONVERSION" ]; then
  echo "Python is already the highest stable version.."
  return 0
fi
echo "Upgrading to Python $PYTHONVERSION"
apt-get -y update
apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev
apt-get install libtcmalloc-minimal4
export LD_PRELOAD="/usr/lib/libtcmalloc_minimal.so.4"
cd /tmp || return 1
wget https://www.python.org/ftp/python/"$PYTHONVERSION"/Python-"$PYTHONVERSION".tar.xz
tar xf Python-"$PYTHONVERSION".tar.xz
cd Python-"$PYTHONVERSION" || return 1
./configure
make altinstall
apt -y autoremove
cd  || return 1
rm -r /tmp/Python-"$PYTHONVERSION"
rm /tmp/Python-"$PYTHONVERSION".tar.xz
echo "Done"

echo "Stopping Home Assistant."
systemctl stop home-assistant@homeassistant.service

echo "Backing up previous virutal enviorment."
sudo -u homeassistant -H /bin/bash << EOF
source /srv/homeassistant/bin/activate
pip3 freeze —local > /tmp/requirements.txt
deactivate
EOF
mv /srv/homeassistant /srv/homeassistant_"$currentpython"

echo "Creating new virutal environment using Python $PYTHONVERSION"
python"${PYTHONVERSION:: -2}" -m venv /srv/homeassistant
mv /srv/homeassistant_"$currentpython"/hassbian /srv/homeassistant/hassbian
chown homeassistant:homeassistant -R /srv/homeassistant
apt install python3-pip python3-dev
pip"${PYTHONVERSION:: -2}" install --upgrade virtualenv
sudo -u homeassistant -H /bin/bash << EOF
source /srv/homeassistant/bin/activate
pip3 install --upgrade setuptools wheel
pip3 install -r /tmp/requirements.txt
pip3 install --upgrade homeassistant
deactivate
EOF
mv /home/homeassistant/.homeassistant/deps /home/homeassistant/.homeassistant/deps_"$currentpython"

echo "Starting Home Assistant."
systemctl start home-assistant@homeassistant.service

echo "Checking the installation..."
validation=$(sudo -u homeassistant -H /bin/bash << EOF | awk -F ' ' '{print $NF}'
source /srv/homeassistant/bin/activate
python -V
EOF
)
if [ "$validation" == "$PYTHONVERSION" ]; then
  echo
  echo -e "\\e[32mUpgrade done..\\e[0m"
  echo "First time Home Assistant starts, it will use a long time. This is normal."
  echo
else
  echo
  echo -e "\\e[31mUpgrade failed..."
  echo -e "\\e[31mReverting..."
  systemctl stop home-assistant@homeassistant.service
  rm -R /srv/homeassistant
  mv /srv/homeassistant_"$currentpython" /srv/homeassistant
  systemctl start home-assistant@homeassistant.service
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
