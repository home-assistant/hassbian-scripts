#!/bin/bash

echo
echo "Samba install script for Hassbian"
echo "Copyright(c) 2017 Fredrik Lindqvist <https://github.im/Landrash>"
echo

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo. Use \"sudo ${0} ${*}\"" 1>&2
   exit 1
fi

echo "Running apt-get preparation"
apt-get update
apt-get install samba

echo "Adding homeassistant Samba user"
sudo smbpasswd -a homeassistant -n

echo "Adding shared folder for Home Assistant configuration directory"
cd /etc/samba/
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

ip_address=$(ifconfig | awk -F':' '/inet addr/&&!/127.0.0.1/{split($2,_," ");print _[1]}')

echo
echo "Installation done."
echo
echo "If you have issues with this script, please contact @Landrash on gitter.im"
echo
echo "Configuration is now available as a Samba share at \\\\$ip_address\homeassistant"
echo
