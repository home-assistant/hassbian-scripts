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

```sql
sudo mysql -u root -p
CREATE DATABASE homeassistant;
CREATE USER 'homeassistantuser' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON homeassistant.* TO 'homeassistantuser';
FLUSH PRIVILEGES;
exit
```

***

The installation script was originally contributed by [@Landrash][landrash].

<!--- Links --->
[landrash]: https://github.com/landrash
[recorder]: https://www.home-assistant.io/components/recorder
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
