#!/bin/bash
function duckdns-show-short-info {
echo -e "Setup for Duck DNS auto renewal, and generates SSL certificate."
}

function duckdns-show-long-info {
echo -e "This script adds an cron job to auto uppdate you the WAN IP address for the defined domain."
echo -e "This script could also generate SSL certificate for https with  Let’s Encrypt."
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
read -p "Do you want to generate certificates to use SSL(https)? [N/y] : " SSL_RESPONSE

echo "Changing to homeassistant user..."
sudo -u homeassistant -H /bin/bash << EOF
cd

if [ "$SSL_RESPONSE" == "y" ] || [ "$SSL_RESPONSE" == "Y" ]; then
	git clone https://github.com/lukas2511/dehydrated.git
	cd dehydrated
	echo $domain".duckdns.org" | tee domains.txt
	echo "CHALLENGETYPE='dns-01'" | tee -a config
	echo "HOOK='./hook.sh'" | tee -a config
	curl -o ./hook.sh https://raw.githubusercontent.com/home-assistant/hassbian-scripts/dev/package/opt/hassbian/suites/files/ssl_hook.sh
	sed -i 's/myhome/'$domain'/g' ./hook.sh
	sed -i 's/your-duckdns-token/'$token'/g' ./hook.sh
	chmod 755 hook.sh
	./dehydrated --register  --accept-terms
	./dehydrated -c
fi

echo "Creating duckdns folder..."
mkdir duckdns
cd duckdns

echo "Creating a script file to be used by cron."
echo "echo url='https://www.duckdns.org/update?domains=$domain&token=$token&ip=' | curl -k -o ~/duckdns/duck.log -K -" > duck.sh

echo "Setting premissions..."
chmod 700 duck.sh

echo "Creating cron job..."
(crontab -l ; echo "*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1")| crontab -
if [ "$SSL_RESPONSE" == "y" ] || [ "$SSL_RESPONSE" == "Y" ]; then
(crontab -l ; echo "0 1 1 * * /home/homeassistant/dehydrated/dehydrated -c")| crontab -
fi

echo "Changing to root user..."
EOF

echo "Restarting cron service..."
sudo systemctl restart cron.service

echo
echo "Installation done."
echo
if [ "$SSL_RESPONSE" == "y" ] || [ "$SSL_RESPONSE" == "Y" ]; then
echo "Remember to update your configuration.yaml to take advantage of SSL!"
echo "Documentation for this can be found here <https://home-assistant.io/components/http/>."
fi
echo
echo "If you have issues with this script, please say something in the #devs_hassbian channel on Discord."
echo
return 0
}

[[ $_ == $0 ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
