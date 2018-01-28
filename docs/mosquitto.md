## Description
This script installs the MQTT Mosquitto server. Repository from the Mosquitto project is added to package system and the official packages for Debian are installed. Additionally, this script helps you create your first MQTT user that can be used with Home Assistant.

## Installation
```
$ sudo hassbian-config install mosquitto
```

## Upgrade
No script avaiable, maybe you could write one?  
If so, add an PR here when you are done:  
[homeassistant/hassbian-scripts](https://github.com/home-assistant/hassbian-scripts/pulls)

## Additional info
Running as: `root`  
Default username: `pi`  
Default password: `raspberry`  
Default port: `1883`  
Configuration file: `/etc/mosquitto/mosquitto.conf`  
Start service: `sudo systemctl start mosquitto.service`  
Stop service: `sudo systemctl stop mosquitto.service`  
Restart service: `sudo systemctl restart mosquitto.service`  
Service status: `sudo systemctl status mosquitto.service`

***
This script was originally contributed by [@dale3h](https://github.com/dale3h) and has been modified by  [@Landrash](https://github.com/Landrash).
