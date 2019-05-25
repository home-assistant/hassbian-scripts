_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# PostgreSQL

This script installs PostgreSQL and its dependencies for use with the
[recorder][recorder] component in Home Assistant. No database or database user
is created during this setup and will need to be created manually.

## Installation

```bash
sudo hassbian-config install postgresql
```

## Upgrade

No script available. Maybe you could write one?  
If so, add a PR here when you are done:  
[homeassistant/hassbian-scripts][repo]

## Additional info

Example of how to create the database:

```bash
sudo -s -u postgres
createuser homeassistant
createdb -O homeassistant homeassistant
```

Example configuration
```yaml
recorder:
  db_url: postgresql://@/homeassistant #Connects to Postgresql via Unix socket, allowed by default
```

***

The installation script was originally contributed by [@Landrash][landrash].

<!--- Links --->
[landrash]: https://github.com/landrash
[recorder]: https://www.home-assistant.io/components/recorder
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
