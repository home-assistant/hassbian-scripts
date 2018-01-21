## Hassbian-scripts
These are the scripts used in the [HASSbian](https://github.com/home-assistant/pi-gen) image.
The scripts in this repository where made to be used with the HASSbian image and the included Home Assistant instance.  


## The included scripts
The following scripts are currently included. You can view the documentation below for usage and instructions.
<!--- When adding stuff here, please keep it alphabetical --->
### [hassbian-config](/docs/hassbian_config.md)
* [Duck DNS](/docs/duckdns.md)
* [HASSbian](/docs/hassbian.md)
* [Home Assistant](/docs/homeassistant.md)
* [Homebridge](/docs/homebridge.md)
* [HUE](/docs/hue.md)
* [LibCEC](/docs/libcec.md)
* [Mosquitto](/docs/mosquitto.md)
* [RaZberry ](/docs/razberry.md)
* [Samba](/docs/samba.md)
* [Trådfri](/docs/tradfri.md)
* [Webterminal](/docs/Webterminal.md)
* **Database scripts**
  * [MariaDB](/docs/mariadb.md)
  * [MS SQL](/docs/mssql.md)
  * [PostgreSQL](/docs/postgresql.md)
### [Changelog](CHANGELOG.md)

***
## Raspbian Jessie
If this package is used with a Debian Jessie based distrbution then you need to uncomment the source repositores in  `/etc/apt/sources.list`

```text
# Uncomment line below then 'apt-get update' to enable 'apt-get source'
deb-src http://archive.raspbian.org/raspbian/ jessie main contrib non-free rpi
```
