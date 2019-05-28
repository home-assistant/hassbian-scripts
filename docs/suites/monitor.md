_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Monitor

This script installs the Monitor script by [andrewjfreyer][andrewjfreyer].
TL;DR: Bluetooth-based passive presence detection of beacons, cell phones, and any other bluetooth device. The system is useful for mqtt-based home automation.
This script requires that the Mosquitto suite is already installed.
After mqtt setting will need to be set configured and some customisation is required. Instructions can be found [here](https://github.com/andrewjfreyer/monitor#getting-started)

## Installation

```bash
sudo hassbian-config install monitor
```

## Upgrade

No script available, maybe you could write one?  
If so, add an PR here when you are done:  
[homeassistant/hassbian-scripts][repo]

## Additional info

Description | Command/value
:--- | :---
Running as: | root
Configuration file: | /opt/monitor/address_blacklist
Configuration file: | /opt/monitor/known_beacon_addresses  
Configuration file: | /opt/monitor/known_static_addresses
Configuration file: | /opt/monitor/mqtt_preferences    
Start service: | `sudo systemctl start monitor.service`
Stop service: | `sudo systemctl stop monitor.service`
Restart service: | `sudo systemctl restart monitor.service`
Service status: | `sudo systemctl status monitor.service`

***

This install script was originally contributed by [@Landrash][landrash]

<!--- Links --->
[andrewjfreyer]: https://github.com/andrewjfreyer
[landrash]: https://github.com/landrash
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
