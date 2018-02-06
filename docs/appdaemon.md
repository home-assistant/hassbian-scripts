## Description
This Installs AppDaemon in a separate Venv onto this system.  
For more information about AppDaemon see the [documentation.](http://appdaemon.readthedocs.io/en/latest/)

## Installation
```
$ sudo hassbian-config install appdaemon
```

## Upgrade
```
$ sudo hassbian-config upgrade appdaemon
```

## Additional info
Running as: `homeassistant`  
Configuration dir: `/home/homeassistant/appdaemon/`  
Start service: `sudo systemctl start appdaemon@homeassistant.service`  
Stop service: `sudo systemctl stop appdaemon@homeassistant.service`  
Restart service: `sudo systemctl restart appdaemon@homeassistant.service`  
Service status: `sudo systemctl status appdaemon@homeassistant.service`  
Enter the virtual environment where AppDaemon is installed as `homeassistant`:
```
sudo su -s /bin/bash homeassistant
source /srv/homeassistant/bin/activate
```
When you are done, type `exit` to return to the `pi` user.

***
The installation script was originally contributed by [@Landrash](https://github.com/landrash).  
The upgrade script was originally contributed by [@Ludeeus](https://github.com/ludeeus).
