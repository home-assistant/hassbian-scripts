_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Zigbee2mqtt

This script installs the [Zigbee2mqtt bridge][zigbee2mqtt].
After installation some further configuration is required. Instructions can be found [here][zigbee2mqttdocs].

## Installation

```bash
sudo hassbian-config install zigbee2mqtt
```

## Upgrade

No script available, maybe you could write one?
If so, add an PR here when you are done:
[homeassistant/hassbian-scripts][repo]

## Additional info

Description | Command/value
:--- | :---
Running as: | pi
Configuration file: | /opt/zigbee2mqtt/data/configuration.yaml
Start service: | `sudo systemctl start zigbee2mqtt.service`
Stop service: | `sudo systemctl stop zigbee2mqtt.service`
Restart service: | `sudo systemctl restart zigbee2mqtt.service`
Service status: | `sudo systemctl status zigbee2mqtt.service`

***

This install script was originally contributed by [@Landrash][landrash]

<!--- Links --->
[zigbee2mqtt]: https://github.com/Koenkk/zigbee2mqtt/
[zigbee2mqttdocs]: https://github.com/Koenkk/zigbee2mqtt/wiki/Running-the-bridge#3-configuring
[landrash]: https://github.com/landrash
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
