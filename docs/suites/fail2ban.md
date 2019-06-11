_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Fail2Ban

This script installs the fail2ban service.
Some further configuration is required after installation. More information [here](https://www.home-assistant.io/cookbook/fail2ban/).

## Installation

```bash
sudo hassbian-config install fail2ban
```

## Upgrade

There's nothing to upgrade.

## Additional info

Description | Command/value
:--- | :---
Running as: | root
Configuration file: | /etc/fail2ban/filter.d/ha.conf
Configuration file: | /etc/fail2ban/jail.d/ha.conf
Start service: | `sudo systemctl start fail2ban.service`
Stop service: | `sudo systemctl stop fail2ban.service`
Restart service: | `sudo systemctl restart fail2ban.service`
Service status: | `sudo systemctl status fail2ban.service`

***

This install script was originally contributed by [@Landrash][landrash]

<!--- Links --->
[landrash]: https://github.com/landrash
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
