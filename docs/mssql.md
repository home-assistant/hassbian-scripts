## Description
This script installs the tools needed to connect to a MS SQL databse and it's dependencies for use with the recorder component in Home Assistant. No database or database user is created during this setup and will need to be created manually.

## Installation
```
$ sudo hassbian-config install mssql
```

## Upgrade
No script avaiable, maybe you could write one?  
If so, add an PR here when you are done:  
[homeassistant/hassbian-scripts](https://github.com/home-assistant/hassbian-scripts/pulls)

## Additional info
Example for creating database:
```
$ sudo mysql -u root -p
$ CREATE DATABASE homeassistant;
$ CREATE USER 'homeassistantuser' IDENTIFIED BY 'password';
$ GRANT ALL PRIVILEGES ON homeassistant.* TO 'homeassistantuser';
$ FLUSH PRIVILEGES;
$ exit
```

***
This script was originally contributed by [@Landrash](https://github.com/Landrash).
