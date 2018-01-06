## Hassbian-scripts

These are the scripts used in the [HASSbian](https://github.com/home-assistant/pi-gen) image.
The scripts in this repository where made to be used with the HASSbian image and the included Home Assistant instance.  

## The included scripts
The following scripts are currently included. You can view the documentation below for usage and instructions.

### hassbian-config (hassbian-config)
This command is a package handler for the Hassbian scripts. All interactions for installing software should be handled through this command. Running the individual scripts to install software will no longer work as expected.

#### Usage
The hassbian-config command is invoked with:
```bash
hassbian-config *command* *suite*
```
where command is one of:
- `install`
- `upgrade`
- `show`

##### install
The install command takes one argument and will attempt to install the indicated suite of software.
Generally, this means that the invocation of `hassbian-config` should be run as root, with:
`sudo hassbian-config install *suite*`
##### upgrade
The install command takes one argument and will attempt to install the indicated suite of software.
Generally, this means that the invocation of `hassbian-config` should be run as root, with:
`sudo hassbian-config upgrade *suite*`
##### show
The show command can be run without arguments, and lists all available suites which can be installed or with a *suite* name as argument and shows information about the suite .

## Installer script components
All scripts listed below are helper scripts for the `hassbian-config` command, and shouldn't be run directly.  The documentation has been kept for explanatory purposes only.

### Install Hue *(install_hue.sh)*
Configures the Python executable to allow usage of low numbered port numbers for use with Amazon Echo, Google Home and Mycroft.ai.

This script was originally contributed by [@Landrash](https://github.com/landrash).


### Install Home Assistant *(install_homeassistant.sh)*
This is a copy of the installation script run during first boot of your Raspberry Pi.
Usually this script is not run after installation but could be used with some modifications to reinstall Home Assistant.

This script was originally contributed by [@Landrash](https://github.com/landrash).

### Install databases
The following scripts are meant for use with the [recorder](https://home-assistant.io/components/recorder/) component in Home Assistant and install databases and/or tools required for using them.

#### Install MariaDB *(install_mariadb.sh)*
This script installs MariaDB and it's dependencies for use with the [recorder](https://home-assistant.io/components/recorder/) component in Home Assistant.
No database or database user is created during this setup and will need to be created manually.

##### Example for creating database  
```$ sudo mysql -u root -p```  
```$ CREATE DATABASE homeassistant;```  
```$ CREATE USER 'homeassistantuser' IDENTIFIED BY 'password';```  
```$ GRANT ALL PRIVILEGES ON homeassistant.* TO 'homeassistantuser';```  
```$ FLUSH PRIVILEGES;```
```$ exit ```

This script was originally contributed by [@Landrash](https://github.com/landrash).

#### Install PostgreSQL *(install_postgresql.sh)*
This script installs PostgreSQL and it's dependencies for use with the [recorder](https://home-assistant.io/components/recorder/) component in Home Assistant.
No database or database user is created during this setup and will need to be created manually.

This script was originally contributed by [@Landrash](https://github.com/landrash).

#### Install MS SQL *(install_mssql.sh)*
This script installs the tools needed to connect to a MS SQL databse and it's dependencies for use with the [recorder](https://home-assistant.io/components/recorder/) component in Home Assistant.
No database or database user is created during this setup and will need to be created manually.

This script was originally contributed by [@Landrash](https://github.com/landrash).

### Share configuration with Samba *(install_samba.sh)*
This script installs samba and it dependencies. It also set up a share for Home Assistant's configuration. **This is potentially unsafe and generally not recommended.**

Script is run as the `pi` user with the following command. Normal runtime for this script is about 5 minutes.
```
sudo hassbian-config install samba
```
After this script has been run, the configuration directory used by Home Assistant is available over Samba and can be accessed from example Windows to edit with your favorite editor.

This script was originally contributed by [@Landrash](https://github.com/Landrash).

### Install Trådfri Gateway Support *(install_tradfri.sh)*
This script installs the dependencies for discovering and using a IKEA Trådfri Gateway with Home Assistant. It's recommended to restart your Trådfri Gateway after this install has been done.

Script is run as the `pi` user with the following command. Normal runtime for this script is about 5 minutes.
```
sudo hassbian-config install tradfri
```
This script was originally contributed by [@Landrash](https://github.com/Landrash).

### Install Mosquitto *(install_mosquitto.sh)*
**This script was broken since packages are not available for Debian Stretch, but we have implemented an workaround that make sure this will run as intended on HASSbian Stretch.** This script installs the MQTT Mosquitto server. Repository from the Mosquitto project is added to package system and the official packages for Debian are installed.
Additionally, this script helps you create your first MQTT user that can be used with Home Assistant.


Script is run as the `pi` user with the following command. Normal runtime for this script is about 10 minutes.
```
sudo hassbian-config install mosquitto
```

This script was originally contributed by [@dale3h](https://github.com/dale3h) and has been modified by [@Landrash](https://github.com/Landrash).

### Install CEC support *(install_libcec.sh)*
**This scipt is currently brooken upstream since it currently doesn't build properly for Python >3.4** This script installs libcec and it dependencies. Further more this script symlinks the system wide packages to the Home Assistant venv so they can be used with Home Assistant.

Script is run as the `pi` user with the following command. Normal runtime for this script is about 10 minutes.
```
sudo hassbian-config install libcec
```
After this script has been run, add CEC to your `configuration.yaml` file as usual.

This script was originally contributed by [@Landrash](https://github.com/Landrash).

### Install Duck DNS auto renewal *(install_duckdns.sh)*
This script adds an cron job to auto update you the WAN IP address for the defined domain.
Before running this script you should already have an Duck DNS account, during the installation you will be asked to supply your domain name and the token for your account.
```
sudo hassbian-config install duckdns
```
This script was originally contributed by [@Ludeeus](https://github.com/Ludeeus).

### Install an web terminal for easy access to ssh in an web browser *(install_webterminal.sh)*
This script installs an web terminal called 'shellinabox' to you system that give you SSH access in you web browser.

Script is run as the `pi` user with the following command:
```
sudo hassbian-config install webterminal
```
Example config for Home-Assistant:
```yaml
panel_iframe:
  terminal:
    title: 'Terminal'
    icon: mdi:console
    url: 'http://192.168.1.2:4200'
```
This script was originally contributed by [@Ludeeus](https://github.com/Ludeeus).

### Install RaZberry *(install_razberry.sh)*
This script disables Bluetooth for the use of a RaZberry with Hassbian.
Code is adapted from the Razberry install script found at http://razberry.z-wave.me/install.
This will disable the use of Bluetooth and Bluetooth Low Energy devices.
```
sudo hassbian-config install razberry
```
This script was originally contributed by [@Landrash](https://github.com/Landrash).


## Upgrade script components

### Upgrade your Home Assistant installation *(uppgrade_home-assistant.sh)*
This script will automate the process of upgrading your Home Assistant to the newest version.
```
sudo hassbian-config upgrade home-assistant
```
This script was originally contributed by [@Ludeeus](https://github.com/Ludeeus).

### Upgrade your HASSbian installation *(uppgrade_hassbian.sh)*
This script will update the base OS on the system.
```
sudo hassbian-config upgrade hassbian
```
This script was originally contributed by [@Landrash](https://github.com/Landrash).

### Upgrade HASSbian-scripts *(uppgrade_hassbian-script.sh)*
This will download and install the newest published version of HASSBian-scripts.
```
sudo hassbian-config upgrade hassbian-script
```
This script was originally contributed by [@Ludeeus](https://github.com/Ludeeus).

### Upgrade HASSbian-scripts from dev branch *(uppgrade_hassbian-script-dev.sh)*
This will download and install the newest additions to the dev branch of HASSbian-Scripts.
_Note that this is intended on people who like living on the 'bleeding edge', it is not recommended using this in a production setup._
```
sudo hassbian-config upgrade hassbian-script
```
This script was originally contributed by [@Ludeeus](https://github.com/Ludeeus).

## Raspbian Jessie
If this package is used with a Debian Jessie based distrbution then you need to uncomment the source repositores in  `/etc/apt/sources.list`

```text
# Uncomment line below then 'apt-get update' to enable 'apt-get source'
deb-src http://archive.raspbian.org/raspbian/ jessie main contrib non-free rpi
```
