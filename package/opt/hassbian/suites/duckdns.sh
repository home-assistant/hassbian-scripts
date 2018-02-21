#!/bin/bash
function duckdns-show-short-info {
  echo "Setup for Duck DNS auto renewal, and generates SSL certificate."
}

function duckdns-show-long-info {
  echo "This script adds an cron job to auto uppdate you the WAN IP address for the defined domain."
  echo "This script can also generate SSL certificate for https with Let’s Encrypt."
}

function duckdns-show-copyright-info {
  echo "Original concept by Ludeeus <https://github.com/ludeeus>."
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
read -r domain
if [ ! "$domain" ]; then
  exit
fi
if [[ $domain = *"duckdns"* ]]; then
  domain=$(echo "$domain" | cut -d\. -f1)
fi
if [[ $domain = *"//"* ]]; then
  domain=$(echo "$domain" | cut -d/ -f3)
fi


echo -n "Token: "
read -r token
echo
if [ ! "$token" ]; then
  exit
fi
echo -n "Do you want to generate certificates to use SSL(https)? [N/y] : "
read -r SSL_RESPONSE

echo "Changing to homeassistant user..."
sudo -u homeassistant -H /bin/bash << EOF
cd

if [ "$SSL_RESPONSE" == "y" ] || [ "$SSL_RESPONSE" == "Y" ]; then
  git clone https://github.com/lukas2511/dehydrated.git
  cd dehydrated  || exit
  echo $domain".duckdns.org" | tee domains.txt
  echo "CHALLENGETYPE='dns-01'" | tee -a config
  echo "HOOK='./hook.sh'" | tee -a config
  curl -so ./hook.sh https://raw.githubusercontent.com/home-assistant/hassbian-scripts/dev/package/opt/hassbian/suites/files/ssl_hook.sh
  sed -i 's/myhome/'$domain'/g' ./hook.sh
  sed -i 's/your-duckdns-token/'$token'/g' ./hook.sh
  chmod 755 hook.sh
  ./dehydrated --register  --accept-terms
  ./dehydrated -c
fi

echo "Creating duckdns folder..."
cd /home/homeassistant || exit
mkdir duckdns
cd duckdns || exit

echo "Creating a script file to be used by cron."
echo "echo url='https://www.duckdns.org/update?domains=$domain&token=$token&ip=' | curl -k -o ~/duckdns/duck.log -K -" > duck.sh

echo "Setting premissions..."
chmod 700 duck.sh

echo "Creating cron job..."
(crontab -l ; echo "*/5 * * * * /home/homeassistant/duckdns/duck.sh >/dev/null 2>&1")| crontab -
if [ "$SSL_RESPONSE" == "y" ] || [ "$SSL_RESPONSE" == "Y" ]; then
(crontab -l ; echo "0 1 1 * * /home/homeassistant/dehydrated/dehydrated -c")| crontab -
fi

echo "Changing to root user..."
EOF

echo "Restarting cron service..."
sudo systemctl restart cron.service

echo "Checking the installation..."
if [ "$SSL_RESPONSE" == "y" ] || [ "$SSL_RESPONSE" == "Y" ]; then
  certvalidation=$(find /home/homeassistant/dehydrated/certs/"$domain".duckdns.org/ -maxdepth 1 -type f | sort | grep privkey)
else
  certvalidation="ok"
fi
if [ ! -f /home/homeassistant/duckdns/duck.sh ]; then
  dnsvalidation=""
else
  dnsvalidation="ok"
fi

if [ ! -z "${certvalidation}" ] && [ ! -z "${dnsvalidation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  if [ "$SSL_RESPONSE" == "y" ] || [ "$SSL_RESPONSE" == "Y" ]; then
  echo "Remember to update your configuration.yaml to take advantage of SSL!"
  echo "Documentation for this can be found here <https://home-assistant.io/components/http/>."
  echo
  fi
else
  echo -e "\\e[31mInstallation failed..."
  echo -e "\\e[31mAborting..."
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
