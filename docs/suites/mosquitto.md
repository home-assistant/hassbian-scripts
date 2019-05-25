_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Mosquitto

This script installs the MQTT Mosquitto server. Repository from the Mosquitto
project is added to package system and the official packages for Debian are
installed. Additionally, this script helps you create your first MQTT user
that can be used with Home Assistant.
*This suite can't be installed on Raspberry Pi Zero*

## Installation

```bash
sudo hassbian-config install mosquitto
```

## Upgrade

No script available, maybe you could write one?  
If so, add an PR here when you are done:  
[homeassistant/hassbian-scripts][repo]

## Additional info

Description | Command/value
:--- | :---
Running as: | root
Default username: | pi
Default password: | raspberry
Default port: | 1883
Configuration file: | /etc/mosquitto/mosquitto.conf
Start service: | `sudo systemctl start mosquitto.service`
Stop service: | `sudo systemctl stop mosquitto.service`
Restart service: | `sudo systemctl restart mosquitto.service`
Service status: | `sudo systemctl status mosquitto.service`

***

This script was originally contributed by [@dale3h][dale3h] and has been
modified by [@Landrash][landrash].

<!--- Links --->
[dale3h]: https://github.com/dale3h
[landrash]: https://github.com/landrash
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
