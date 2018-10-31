#!/bin/bash
function fail2ban-show-short-info {
  echo "Setup for fail2ban service."
}

function fail2ban-show-long-info {
  echo "This script installs the fail2ban service."
  echo "Some further configuration is required after installation."
}

function fail2ban-show-copyright-info {
  echo "Original concept by Landrash <https://github.com/landrash>."
}

function fail2ban-install-package {
echo "Installing fail2ban package"
apt install -y fail2ban

FAIL2BANFILTER="/etc/fail2ban/filter.d/ha.conf"
FAIL2BANJAIL="/etc/fail2ban/jail.d/ha.conf"

echo "Creating configuration files"
if [ -f $FAIL2BANFILTER ] ; then
    echo "Configuration file exists. Skipping.."
else

echo "[INCLUDES]
before = common.conf

[Definition]
failregex = ^%(__prefix_line)s.*Login attempt or request with invalid authentication from <HOST>.*$
ignoreregex =" > "$FAIL2BANFILTER"

fi

if [ -f $FAIL2BANJAIL ] ; then
    echo "Configuration file exists. Skipping.."
else

echo "[DEFAULT]
# Email config
sender = email@address.com
destemail = email@address.com

# Action %(action_mwl)s will ban the IP and send an email notification including whois data and log entries.
action = %(action_mwl)s

[ha]
enabled = true
filter = ha
logpath = /home/homeassistant/.homeassistant/home-assistant.log

# 3600 seconds = 1 hour
bantime = 3600
#bantime = 30 # during testing it is useful to have a short ban interval, comment out this line later

# Maximum amount of login attempts before IP is blocked
maxretry = 3" > "$FAIL2BANJAIL"
fi

echo "Restarting fail2ban service"
systemctl restart fail2ban

echo "Checking the installation..."
validation=$(which fail2ban-client)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done.\\e[0m"
  echo
  echo "To continue have a look at https://www.home-assistant.io/cookbook/fail2ban/"
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
