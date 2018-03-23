## Description
Cloud9 IDE is an online integrated development environment. It supports hundreds of programming languages.

## Installation
```bash
$ sudo hassbian-config install cloud9
```

## Upgrade
```bash
$ sudo hassbian-config upgrade cloud9
```

## Additional info
Running as: `homeassistant`
Default workspace: `/home/homeassistant/.homeassistant/`    
Default port: `8181`  
Start service: `sudo systemctl start cloud9@homeassistant.service`  
Stop service: `sudo systemctl stop cloud9@homeassistant.service`  
Restart service: `sudo systemctl restart cloud9@homeassistant.service`  
Service status: `sudo systemctl status cloud9@homeassistant.service`

***
The installation script was originally contributed by [@Ludeeus](https://github.com/ludeeus).
The upgrade scripts was originally contributed by [@Ludeeus](https://github.com/ludeeus).
