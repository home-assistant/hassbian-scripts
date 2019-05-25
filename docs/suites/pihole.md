_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Pi-hole

This script downloads and runs the [Pi-Hole][pihole] install script from https://pi-hole.net/ .
## Installation

```bash
sudo hassbian-config install pihole
```

## Upgrade

Upgrades are handled by the Pi-hole software

## Additional info

Description | Command/value
:--- | :---
Running as: | pihole
Start service: | `sudo systemctl start pihole-FTL.service `
Stop service: | `sudo systemctl stop pihole-FTL.service`
Restart service: | `sudo systemctl restart pihole-FTL.service`
Service status: | `sudo systemctl status pihole-FTL.service`

***

This install script was originally contributed by [@Landrash][landrash]

<!--- Links --->
[landrash]: https://github.com/landrash
[pihole]: https://pi-hole.net/
