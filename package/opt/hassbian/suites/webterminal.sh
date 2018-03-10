#!/bin/bash
function webterminal-show-short-info {
  echo "Installs an websevice terminal."
}

function webterminal-show-long-info {
  echo "Installs an websevice terminal to control your installation."
}

function webterminal-show-copyright-info {
	echo "Original concept by Ludeeus <https://github.com/ludeeus>"
}

function webterminal-install-package {
if [ "$ACCEPT" == "true" ]; then # True if `-y` flag is used.
  if [ -d "/etc/letsencrypt/live" ] || [ -d "/home/homeassistant/dehydrated/certs" ]; then
    SSL="Y"
  else
    SSL="N"
  fi
else
  echo ""
  echo -n "Do you use SSL (https) with Home Assistant? [N/y] : "
  read -r SSL
  if [ ! "$SSL" ]; then
      SSL="N"
  fi
fi

echo "Installing packages."
sudo apt-get install -y openssl shellinabox
echo "Changing config."
if [ "$SSL" == "y" ] || [ "$SSL" == "Y" ]; then
  echo "No need to change default configuration, skipping this step..."
  echo "Checking cert directory..."
  if [ -d "/etc/letsencrypt/live" ]; then
    CERTDIR="/etc/letsencrypt/live/"
  elif [ -d "/home/homeassistant/dehydrated/certs" ]; then
    CERTDIR="/home/homeassistant/dehydrated/certs/"
  else
    CERTDIR=""
  fi
  echo "Setting cert fullchain location..."
  FULLCHAIN=$(find "$CERTDIR" -type f | grep fullchain)
  echo "Setting cert privkey location..."
  PRIVKEY=$(find "$CERTDIR" -type f | grep privkey)
  DOMAIN=$(ls "$CERTDIR")
  echo "Merging files and adding to correct dir..."
  cat "$FULLCHAIN" "$PRIVKEY" > /var/lib/shellinabox/certificate-"$DOMAIN".pem
  chown shellinabox:shellinabox -R /var/lib/shellinabox/
  echo "Adding crong job to copy certs..."
  (crontab -l ; echo "5 1 1 * * bash /opt/hassbian/suites/files/webterminalsslhelper.sh >/dev/null 2>&1")| crontab -
else
  sed -i 's/--no-beep/--no-beep --disable-ssl/g' /etc/default/shellinabox
fi

echo "Reloading and starting the service."
service shellinabox reload
service shellinabox restart

ip_address=$(ifconfig | grep "inet.*broadcast" | grep -v 0.0.0.0 | awk '{print $2}')

if [ "$SSL" == "y" ] || [ "$SSL" == "Y" ]; then
  PROTOCOL="https"
else
  PROTOCOL="http"
fi

echo "Checking the installation..."
validation=$(pgrep -f shellinaboxd)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "You can now access the web terminal here: $PROTOCOL://$ip_address:4200"
  echo "You can also add this to your Home-Assistant config in an 'panel_iframe'"
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo -e "\\e[31mAborting..."
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
