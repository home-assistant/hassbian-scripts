_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Custom component store

Custom component store is a web UI tool that can help you manage your custom components.

![overview](https://camo.githubusercontent.com/b01a7e30e5c8d5938eed8091ec23ad9b4dc84cfe/68747470733a2f2f692e6962622e636f2f42737a714c58722f64656d6f2e676966)

When installed the WEB UI are running on port `8120`

## Installation

```bash
sudo hassbian-config install custom-component-store
```

## Upgrade

```bash
sudo hassbian-config upgrade custom-component-store
```

## Remove

```bash
sudo hassbian-config remove custom-component-store
```

## Additional info

Description | Command/value
:--- | :---
Running as: | homeassistant
Default user: | `pi`
Default password: | `raspberry`
Port: | `8120`
Start service: | `sudo systemctl start custom-component-store@homeassistant.service`
Stop service: | `sudo systemctl stop custom-component-store@homeassistant.service`
Restart service: | `sudo systemctl restart custom-component-store@homeassistant.service`
Service status: | `sudo systemctl status custom-component-store@homeassistant.service`

***

The script was originally contributed by [@Ludeeus][ludeeus].

<!--- Links --->
[ludeeus]: https://github.com/ludeeus
