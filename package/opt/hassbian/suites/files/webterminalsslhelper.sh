#!/bin/bash
# Helper script for using LE certificates with Webterminal (shellinabox)
if [ -d "/etc/letsencrypt/live" ]; then
  CERTDIR="/etc/letsencrypt/live/"
elif [ -d "/home/homeassistant/dehydrated/certs" ]; then
  CERTDIR="/home/homeassistant/dehydrated/certs/"
else
  CERTDIR=""
fi
FULLCHAIN=$(find "$CERTDIR" -type f | grep fullchain)
PRIVKEY=$(find "$CERTDIR" -type f | grep privkey)
DOMAIN=$(ls "$CERTDIR")
cat $FULLCHAIN $PRIVKEY > /var/lib/shellinabox/certificate-"$DOMAIN".pem
chown shellinabox:shellinabox -R /var/lib/shellinabox/
service shellinabox restart
exit 0
