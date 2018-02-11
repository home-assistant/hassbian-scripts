## Description
After this script has been run, the configuration directory used by Home Assistant is available over Samba and can be accessed from example Windows to edit with your favorite editor.

## Installation
```
$ sudo hassbian-config install samba
```

## Upgrade
No script avaiable, maybe you could write one?  
If so, add an PR here when you are done:  
[homeassistant/hassbian-scripts](https://github.com/home-assistant/hassbian-scripts/pulls)

## Additional info
Running as: `root`  
Configuration file: `/etc/samba/smb.conf`  
Start service: `sudo systemctl start smbd.service`  
Stop service: `sudo systemctl stop smbd.service`  
Restart service: `sudo systemctl restart smbd.service`  
Service status: `sudo systemctl status smbd.service`

***
This script was originally contributed by [@Landrash](https://github.com/Landrash).
