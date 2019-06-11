_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Hassbian manager

Hassbian manager is a web UI tool that can help you manage your suites.

When installed the WEB UI are running on port `9999`

## Installation

```bash
sudo hassbian-config install manager
```

## Upgrade

```bash
sudo hassbian-config upgrade manager
```

## Remove

```bash
sudo hassbian-config remove manager
```

## Additional info

Description | Command/value
:--- | :---
Running as: | homeassistant
Default user: | `pi`
Default password: | `raspberry`
Port: | `9999`
Start service: | `sudo systemctl start hassbian-manager@homeassistant.service`
Stop service: | `sudo systemctl stop hassbian-manager@homeassistant.service`
Restart service: | `sudo systemctl restart hassbian-manager@homeassistant.service`
Service status: | `sudo systemctl status hassbian-manager@homeassistant.service`

***

The script was originally contributed by [@Ludeeus][ludeeus].

<!--- Links --->
[ludeeus]: https://github.com/ludeeus
