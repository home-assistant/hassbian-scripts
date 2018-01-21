## Description
This is a copy of the installation script run during first boot of your Raspberry Pi with the [Hassbian image](https://github.com/home-assistant/pi-gen/releases/latest)  
And an easy way to upgrade Home Assistant to the newest version.

## Installation
_**NB!: This is installed by Hassbian, and should not be run additionally**_
```
$ sudo hassbian-config install homeassistant
```

## Upgrade
```
$ sudo hassbian-config upgrade home-assistant
```

## Additional info
Running as: `homeassistant`  
Configuration dir: `/home/homeassistant/.homeassistant/`  
Start service: `sudo systemctl start home-assistant@homeassistant.service`  
Stop service: `sudo systemctl stop home-assistant@homeassistant.service`  
Restart service: `sudo systemctl restart home-assistant@homeassistant.service`  
Service status: `sudo systemctl status home-assistant@homeassistant.service`

***
The installation script was originally contributed by [@Landrash](https://github.com/landrash).  
The upgrade scripts was originally contributed by [@Ludeeus](https://github.com/ludeeus).
