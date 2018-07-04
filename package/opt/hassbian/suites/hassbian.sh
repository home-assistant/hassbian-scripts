#!/bin/bash
function hassbian-show-short-info {
  echo "Upgrade the base OS installation on this system."
}

function hassbian-show-long-info {
  echo "Upgrade the base OS installation on this system."
}

function hassbian-show-copyright-info {
  echo "Original concept by Landrash <https://github.com/Landrash>."
  echo "Modified by Toast <https://gitlab.com/swe_toast>."
}

function hassbian-remove-package {
  echo "This will remove the automated parts of this package if you have that activated."
  if [ -f /etc/hassbian-config/notification ]; then
    rm /etc/hassbian-config/notification
  fi
  if [ -f /etc/cron.daily/hassbian-automated-upgrade ]; then
    rm /etc/cron.daily/hassbian-automated-upgrade
  fi
  echo "Removal of the automated parts of this package is done."
}

function pushover_message () {
  pushover_username=$(grep 'pushover_username' /etc/hassbian-config/notification | awk -F' ' '{print $2}')
  pushover_token=$(grep 'pushover_token' /etc/hassbian-config/notification | awk -F' ' '{print $2}')
  curl -s \
    --form-string "token=$pushover_token" \
    --form-string "user=$pushover_username" \
    --form-string "message=The following device will be updated: $(cat /etc/hostname), $count pending packages will be updated here is the packagelist $packagelist" \
      https://api.pushover.net/1/messages.json
}

function pushbullet_message () {
  pushbullet_token=$(grep 'pushbullet_token' /etc/hassbian-config/notification | awk -F' ' '{print $2}')
  message="$count pending packages will be updated here is the packagelist $packagelist"
  title="The following device will be updated: $(cat /etc/hostname)"
  curl -u "$pushbullet_token": https://api.pushbullet.com/v2/pushes -d type=note -d title="$title" -d body="$message"
}

function check_kernel () {
  check_version=$(sudo JUST_CHECK=1 UPDATE_SELF=0 rpi-update | grep -c "Your firmware is already up to date")
  if [[ "$check_version" -eq 0 ]]; then
    kernel_check_update
  fi 
}

function kernel_check_update () {
  service home-assistant@homeassistant stop
  sleep 30
  rpi-update
  sleep 10
  touch /var/run/reboot-required
}

function upgrade_process () {
  apt-get -qq update
  packagelist=$(apt list --upgradable | cut -d' ' -f1-2)
  pkglist=$(apt-get -su --assume-yes dist-upgrade)
  pending=$(echo "$pkglist" | grep -oE "[0-9]+ upgraded, [0-9]+ newly installed, [0-9]+ to remove and [0-9]+ not upgraded\\.")
  upgraded=$(echo "$pending" | grep -oE "[0-9]+ upgraded" | cut -d' ' -f1)
  installed=$(echo "$pending" | grep -oE "[0-9]+ newly installed" | cut -d' ' -f1)
  removed=$(echo "$pending" | grep -oE "[0-9]+ to remove" | cut -d' ' -f1)
  count=$(( upgraded + installed + removed ))
  apt-get dist-upgrade -qq -y --assume-yes
  apt-get autoremove -qq -y
  apt-get autoclean -qq -y
  apt-get -qq -y purge "$(/usr/bin/dpkg -l | /bin/grep "^rc" | /usr/bin/awk '{print $2}')"
  if [ -f /etc/hassbian-config/notification ]; then
  	send_notification
	fi
}

function check_reboot () {
if [ -f /var/run/reboot-required ]; then
  sleep 300
  execute_reboot
  exit 1
fi 
}

function execute_reboot {
  if [[ "$FORCE" != "true" ]]; then
    echo -n "A reboot is required for this to finish, do you want to do that now [y/N]? "
    read -r REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      reboot
    else
    	echo "Automatic reboot aborted, remenber to do this manually bu running 'sudo reboot'"
    fi
  fi 
}

function check_packages () {
  if [[ "$count" -eq "0" ]]; then
    echo "No available updates on the following device: $(cat /etc/hostname)"
  else
    printf "$count available updates on the following device: $(cat /etc/hostname)\\nHere is the package list\\n $packagelist\\n"
    upgrade_process
    sleep 10
  fi 
}

function send_notification {
  echo "Sending pusbullet notification."
  pushbullet=$(grep 'use_pushbullet' /etc/hassbian-config/notification | awk -F' ' '{print $2}')
  pushover=$(grep 'use_pushover' /etc/hassbian-config/notification | awk -F' ' '{print $2}')
  if [[ "$count" -ge "1" ]]; then
    if [ "$pushbullet" == "true" ];then
      pushbullet_message
    fi
    if [ "$pushover" == "true" ];then
      pushover_message
    fi
  fi
}

function hassbian-upgrade-package {
if [[ "$FORCE" != "true" ]]; then
  if [ ! -f /etc/cron.daily/hassbian-automated-upgrade ]; then
    echo -n "Do you want to enable automatic upgrades[y/N]? "
    read -r REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "hassbian-config upgrade hassbian --force" | tee -a /etc/cron.daily/hassbian-automated-upgrade > /dev/null 2>&1
      echo -n "Do you want to enable pushbullet/pushover notification when it run [y/N]? "
      read -r REPLY
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [ ! -d /etc/hassbian-config ]; then
        mkdir /etc/hassbian-config
        fi
        if [ -f /etc/hassbian-config/notification ]; then
          echo -n "Do you want to keep existing configuration [y/N]? "
          read -r REPLY
          if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Using previosly defined configuration for notifications."
            else
            rm /etc/hassbian-config/notification
            echo -n "Which provider do you use[pushbullet/pushover/both]? "
            read -r REPLY
            if [[ $REPLY == "pushbullet" ]]; then
              echo "use_pushbullet: true" >> /etc/hassbian-config/notification
              echo -n "Pushbullet token? "
              read -r REPLY
              echo "pushbullet_token: $REPLY" >> /etc/hassbian-config/notification
            elif [[ $REPLY == "pushover" ]]; then
              echo "use_pushover: true" >> /etc/hassbian-config/notification
              echo -n "Pushover username? "
              read -r REPLY
              echo "pushover_username: $REPLY" >> /etc/hassbian-config/notification
              echo -n "Pushover token? "
              read -r REPLY
              echo "pushover_token: $REPLY" >> /etc/hassbian-config/notification
            elif [[ $REPLY == "both" ]]; then
              echo "use_pushbullet: true" >> /etc/hassbian-config/notification
              echo -n "Pushbullet token? "
              read -r REPLY
              echo "pushbullet_token: $REPLY" >> /etc/hassbian-config/notification
              echo "use_pushover: true" >> /etc/hassbian-config/notification
              echo -n "Pushover username? "
              read -r REPLY
              echo "pushover_username: $REPLY" >> /etc/hassbian-config/notification
              echo -n "Pushover token? "
              read -r REPLY
              echo "pushover_token: $REPLY" >> /etc/hassbian-config/notification
            else
              echo "Selected provider is not supported."
            fi
          fi
        fi
      fi
    fi
  fi
fi

check_kernel
check_packages
check_reboot

echo
echo "Upgrade complete."
echo
return 0
}

[[ "$_" == "$0" ]] && echo "hassbian-config helper script; do not run directly, use hassbian-config instead"
