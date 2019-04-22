#!/bin/bash
# Helper script for using LE certificates with Webterminal (shellinabox)
if [ -d "/etc/letsencrypt/live" ]; then
  CERTDIR="/etc/letsencrypt/live/"
elif [ -d "/home/homeassistant/dehydrated/certs" ]; then
  CERTDIR="/home/homeassistant/dehydrated/certs/"
else
  CERTDIR=""
fi
DOMAIN=$(ls "$CERTDIR")
cat "$CERTDIR$DOMAIN/fullchain.pem" "$CERTDIR$DOMAIN/privkey.pem" > /var/lib/shellinabox/certificate-"$DOMAIN".pem
chown shellinabox:shellinabox -R /var/lib/shellinabox/
service shellinabox reload
service shellinabox stop
service shellinabox start
exit 0
