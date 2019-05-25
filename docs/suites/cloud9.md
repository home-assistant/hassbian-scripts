_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Cloud9

Cloud9 SDK is an webservice IDE that makes it easy to manage your configuration files.  
**This suite can't be installed on Raspberry Pi Zero**

## Installation

```bash
sudo hassbian-config install cloud9
```

## Upgrade

```bash
sudo hassbian-config upgrade cloud9
```

## Remove

```bash
sudo hassbian-config remove cloud9
```

## Additional info

Description | Command/value
:--- | :---
Running as: | homeassistant
Default workspace: | /home/homeassistant/c9workspace/
Default port: | 8181
Default user: | `pi`
Default password: | `raspberry`
Start service: | `sudo systemctl start cloud9@homeassistant.service`
Stop service: | `sudo systemctl stop cloud9@homeassistant.service`
Restart service: | `sudo systemctl restart cloud9@homeassistant.service`
Service status: | `sudo systemctl status cloud9@homeassistant.service`

***

This script was originally contributed by [@Ludeeus][ludeeus].

<!--- Links --->
[ludeeus]: https://github.com/ludeeus
