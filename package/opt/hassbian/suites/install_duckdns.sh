#!/bin/bash
function duckdns-show-short-info {
echo -e "Setup for Duck DNS auto renewal."
}

function duckdns-show-long-info {
echo -e "This script adds an cron job to auto uppdate you the WAN IP address for the defined domain."
}

function duckdns-show-copyright-info {
	echo "Original concept by Ludeeus <https://github.com/ludeeus>"
}

function duckdns-install-package {
duckdns-show-long-info
duckdns-show-copyright-info

echo
echo "Please take a moment to setup autorenewal of duckdns."
echo "If no choice is made the installation will exit."
echo
echo "(if your domain is 'example.duckdns.org' type example)"
echo -n "Domain: "
read domain
if [ ! "$domain" ]; then
  exit
fi

echo -n "Token: "
read token
echo
if [ ! "$token" ]; then
  exit
fi

echo "Changing back to homeassistant user..."
sudo -u homeassistant -H /bin/bash << EOF
cd

echo "Creating duckdns folder..."
mkdir duckdns
cd duckdns

echo "Creating a script file to be used by cron."
echo "echo url='https://www.duckdns.org/update?domains=$domain&token=$token&ip=' | curl -k -o ~/duckdns/duck.log -K -" > duck.sh

echo "Setting premissions..."
chmod 700 duck.sh

echo "Creating cron job..."
(crontab -l ; echo "*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1")| crontab -

echo "Changing back to root user..."
EOF

echo "Restarting cron service..."
sudo systemctl restart cron.service

echo
echo "Installation done."
echo
echo "If you have issues with this script, please say something in the #Hassbian channel on Discord."
echo
return 0
}

# Make this script function as it always has if run standalone, rather than issue a warning and do nothing.
[[ $0 == "$BASH_SOURCE" ]] && duckdns-install-package
