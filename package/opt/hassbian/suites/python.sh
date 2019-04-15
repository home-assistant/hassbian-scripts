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

PYTHONVERSION=$(curl -s https://www.python.org/downloads/source/ | grep "Latest Python 3 Release" | cut -d "<" -f 3 | awk -F ' ' '{print $NF}')

echo "Checking current version..."
currenthapyversion
hapyversion=$"$CURRENTHAPYVERSION"

if [ "$hapyversion" == "$PYTHONVERSION" ]; then
  echo "Python is already the highest stable version.."
  return 0
fi

isinstalled=$(which "python${PYTHONVERSION:0:3}")
if [ ! -z "${isinstalled}" ]; then
  currentversion$("python${PYTHONVERSION:0:3} -V")
  if [[ "${currentversion:6}" != "$PYTHONVERSION" ]]; then
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
  fi
fi
echo "Stopping Home Assistant."
systemctl stop home-assistant@homeassistant.service

echo "Backing up previous virutal enviorment."
mv /srv/homeassistant /srv/homeassistant_"$hapyversion"

echo "Creating new virutal environment using Python $PYTHONVERSION"
python"${PYTHONVERSION:: -2}" -m venv /srv/homeassistant
mv /srv/homeassistant_"$hapyversion"/hassbian /srv/homeassistant/hassbian
chown homeassistant:homeassistant -R /srv/homeassistant
apt install python3-pip python3-dev
pip"${PYTHONVERSION:: -2}" install --upgrade virtualenv
sudo -u homeassistant -H /bin/bash << EOF
source /srv/homeassistant/bin/activate
pip3 install --upgrade setuptools wheel
pip3 install --upgrade homeassistant
deactivate
EOF
mv /home/homeassistant/.homeassistant/deps /home/homeassistant/.homeassistant/deps_"$hapyversion"

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
  echo "First time Home Assistant starts it will take a long time. This is normal."
  echo "You can run 'sudo journalctl -u home-assistant@homeassistant.service -f' to see the live service log."
  echo
else
  echo
  echo -e "\\e[31mUpgrade failed..."
  echo -e "\\e[31mReverting..."
  systemctl stop home-assistant@homeassistant.service
  rm -R /srv/homeassistant
  mv /srv/homeassistant_"$hapyversion" /srv/homeassistant
  systemctl start home-assistant@homeassistant.service
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
