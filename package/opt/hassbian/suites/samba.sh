#!/bin/bash

function samba-show-short-info {
  echo "Samba install script for Hassbian."
}

function samba-show-long-info {
  echo "Installs the samba package for sharing the Hassbian configuration files."
  echo "over the network."
}

function samba-show-copyright-info {
  echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.com/Landrash>."
}

function samba-install-package {
echo "Running apt-get preparation"
apt-get update
apt-get install -y samba

echo "Adding homeassistant Samba user"
sudo smbpasswd -a homeassistant -n

echo "Adding shared folder for Home Assistant configuration directory"
cd /etc/samba/ || exit
sudo patch <<'EOF'
--- smb.conf 2017-02-02 20:29:42.383603738 +0000
+++ smb_ha.conf 2017-02-02 20:37:12.418960977 +0000
@@ -252,3 +252,11 @@
 # to the drivers directory for these users to have write rights in it
 ;   write list = root, @lpadmin

+[homeassistant]
+path = /home/homeassistant/.homeassistant
+writeable = yes
+guest ok = yes
+create mask = 0644
+directory mask = 0755
+force user = homeassistant
+
EOF


echo "Restarting Samba service"
sudo systemctl restart smbd.service

ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

echo "Checking the installation..."
validation=$(pgrep -x smbd)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "Configuration is now available as a Samba share at \\\\$ip_address\\homeassistant"
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
