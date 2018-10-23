# Hassbian-scripts

These are the scripts used in the [Hassbian][hassbian] image.
The scripts in this repository where made to be used with the Hassbian image
and the included Home Assistant instance.

## The included scripts

The following scripts are currently included. You can view the documentation
below for usage and instructions.

<!--- When adding stuff here, please keep it alphabetical --->

- [hassbian-config](/docs/hassbian_config.md)
  - [AppDaemon](/docs/appdaemon.md)
  - [Cloud9](/docs/cloud9.md)
  - [Duck DNS](/docs/duckdns.md)
  - [Hassbian](/docs/hassbian.md)
  - [Home Assistant](/docs/homeassistant.md)
  - [Homebridge](/docs/homebridge.md)
  - [HUE](/docs/hue.md)
  - [LibCEC](/docs/libcec.md)
  - [MariaDB](/docs/mariadb.md)
  - [Monitor](/docs/monitor.md)
  - [Mosquitto](/docs/mosquitto.md)
  - [PostgreSQL](/docs/postgresql.md)
  - [MS SQL](/docs/mssql.md)
  - [RaZberry](/docs/razberry.md)
  - [Samba](/docs/samba.md)
  - [Trådfri](/docs/tradfri.md)
  - [Webterminal](/docs/webterminal.md)
  - [Zigbee2mqtt](/docs/zigbee2mqtt.md)
- [Changelog][changelog]

***

## Raspbian Jessie

If this package is used with a Debian Jessie based distribution then you need
to uncomment the source repositories in  `/etc/apt/sources.list`

```text
# Uncomment line below then 'apt-get update' to enable 'apt-get source'
deb-src http://archive.raspbian.org/raspbian/ jessie main contrib non-free rpi
```

<!--- Links --->
[changelog]: https://github.com/home-assistant/hassbian-scripts/releases
[hassbian]: https://github.com/home-assistant/pi-gen
