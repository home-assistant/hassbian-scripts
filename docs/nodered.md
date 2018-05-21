## Description
Node-RED is a programming tool for wiring together hardware devices, APIs and online services in new and interesting ways.

*This suite can't be installed on Raspberry Pi Zero*  

## Installation
```bash
$ sudo hassbian-config install nodered
```

## Additional info
Running as: `pi`
Default workspace: `/home/pi/.node-red`    
Default port: `1880`  
Start service: `sudo systemctl start nodered.service`  or `node-red-start`
Stop service: `sudo systemctl stop nodered.service`  or `node-red-stop`
Restart service: `sudo systemctl restart nodered.service`  
Service status: `sudo systemctl status nodered.service`

***
This script was originally contributed by [@cxlwill](https://github.com/cxlwill).


