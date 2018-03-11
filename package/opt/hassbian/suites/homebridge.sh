#!/bin/bash
function homebridge-show-short-info {
  echo "Installs and configure Homebridge for Home Assistant."
}

function homebridge-show-long-info {
  echo "Installs and configure Homebridge for Home Assistant"
    echo "This will allow you to use HomeKit enabled devices to control Home Assistant."
}

function homebridge-show-copyright-info {
    echo "Original concept by Ludeeus <https://github.com/ludeeus>"
    echo "Disclaimer: Some parts of this script is inspired by Dale Higgs <https://github.com/dale3h>"
}

function homebridge-install-package {
if [ "$ACCEPT" == "true" ]; then
  HOMEASSISTANT_URL="http://127.0.0.1:8123"
  HOMEASSISTANT_PASSWORD=""
else
  echo ""
  echo "Please take a moment to setup the Homebridge configuration..."
  echo ""
  echo "Example: https://home.duckdns.org:8123"
  echo -n "Enter your Home Assistant URL and port: "
  read -r HOMEASSISTANT_URL
  if [ ! "$HOMEASSISTANT_URL" ]; then
      HOMEASSISTANT_URL="http://127.0.0.1:8123"
  fi
  echo ""
  echo ""
  echo -n "Enter your Home Assistant API password: "
  read -s -r HOMEASSISTANT_PASSWORD
  echo
fi

if [ "$ACCEPT" != "true" ]; then
  if [ -f "/usr/sbin/samba" ]; then
    echo -n "Do you want to add Samba share for Homebridge configuration? [N/y] : "
    read -r SAMBA
  fi
fi

echo "Preparing system, and adding dependencies..."
sudo apt update
sudo apt -y upgrade
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install -y nodejs
sudo apt install -y libavahi-compat-libdnssd-dev

echo "Installing Homebridge for Home Assistant..."
sudo npm install -g --unsafe-perm homebridge hap-nodejs node-gyp
sudo npm install -g homebridge-homeassistant

echo "Adding homebridge user, and creating config file..."
sudo useradd --system --create-home homebridge
sudo mkdir /home/homebridge/.homebridge
sudo touch /home/homebridge/.homebridge/config.json
HOMEBRIDGE_PIN=$(printf "%03d-%02d-%03d" $((RANDOM % 999)) $((RANDOM % 99)) $((RANDOM % 999)))
HOMEBRIDGE_USERNAME=$(hexdump -n3 -e'/3 "00:60:2F" 3/1 ":%02X"' /dev/random)
HOMEBRIDGE_PORT=$( printf "57%03d" $((RANDOM % 999)))
cat > /home/homebridge/.homebridge/config.json <<EOF
{
  "bridge": {
    "name": "Homebridge",
    "username": "${HOMEBRIDGE_USERNAME}",
    "port": ${HOMEBRIDGE_PORT},
    "pin": "${HOMEBRIDGE_PIN}"
  },
  "description": "This is an example configuration file for Homebridge that includes the Home Assistant plugin.",
  "accessories": [
  ],
  "platforms": [
    {
      "platform": "HomeAssistant",
      "name": "HomeAssistant",
      "host": "${HOMEASSISTANT_URL}",
      "password": "${HOMEASSISTANT_PASSWORD}",
      "supported_types": ["automation", "binary_sensor", "climate", "cover", "device_tracker", "fan", "group", "input_boolean", "light", "lock", "media_player", "remote", "scene", "script", "sensor", "switch", "vacuum"],
      "default_visibility": "hidden"
    }
  ]
}
EOF
sudo chown -R homebridge /home/homebridge

echo "Creating system startup file."
cat > /etc/systemd/system/homebridge.service <<EOF
[Unit]
Description=Node.js HomeKit Server

After=syslog.target network-online.target

[Service]
Type=simple
User=homebridge
ExecStart=/usr/bin/homebridge
Restart=on-failure
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

echo "Enabling and starting service."
sudo systemctl daemon-reload
sudo systemctl enable homebridge.service
sudo systemctl start homebridge.service

if [ "$SAMBA" == "y" ] || [ "$SAMBA" == "Y" ]; then
    echo "Adding configuration to Samba..."
    sudo smbpasswd -a homebridge -n
    echo "[homebridge]" | tee -a /etc/samba/smb.conf
    echo "path = /home/homebridge/.homebridge" | tee -a /etc/samba/smb.conf
    echo "writeable = yes" | tee -a /etc/samba/smb.conf
    echo "guest ok = yes" | tee -a /etc/samba/smb.conf
    echo "create mask = 0644" | tee -a /etc/samba/smb.conf
    echo "directory mask = 0755" | tee -a /etc/samba/smb.conf
    echo "force user = homebridge" | tee -a /etc/samba/smb.conf
    echo "" | tee -a /etc/samba/smb.conf
    echo "Restarting Samba service"
    sudo systemctl restart smbd.service
fi

echo "Checking the installation..."
validation=$(pgrep -f homebridge)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done.\\e[0m"
  echo
  echo "Homebridge is now running and you can add it to your"
  echo "HomeKit app on your iOS device, when you are asked for a pin"
  echo "use this: '$HOMEBRIDGE_PIN'"
  echo "For more information see this repo:"
  echo "https://github.com/home-assistant/homebridge-homeassistant#customization"
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
