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
- `show`

##### install
The install command takes one argument and will attempt to install the indicated suite of software.
Generally, this means that the invocation of `hassbian-config` should be run as root, with:
`sudo hassbian-config install *suite*`
##### show
The show command can be run without arguments, and lists all available suites which can be installed or with a *suite* name as argument and shows information about the suite .

## Installer script components
All scripts listed below are helper scripts for the `hassbian-config` command, and shouldn't be run directly.  The documentation has been kept for explanatory purposes only.

### Install Home Assistant *(install_homeassistant.sh)*
This is a copy of the installation script run during first boot of your Raspberry Pi.
Usually this script is not run after installation but could be used with some modifications to reinstall Home Assistant.

This script was originally contributed by [@Landrash](https://github.com/landrash).

### Install Mosquitto *(install_mosquitto.sh)*
This script installs the MQTT Mosquitto server. Repository from the Mosquitto project is added to package system and the official packages for Debain are installed.
Additionally, this script helps you create your first MQTT user that can be used with Home Assistant.


Script is run as the `pi` user with the following command. Normal runtime for this script is about 10 minutes.
```
sudo hassbian-config install mosquitto
```

This script was originally contributed by [@dale3h](https://github.com/dale3h) and has been modified by [@Landrash](https://github.com/Landrash).
  
### Install CEC support *(install_libcec.sh)*
This script installs libcec and it dependencies.Further more this script symlinks the system wide packages to the Home Assistant venv so they can be used with Home Assistant.

Script is run as the `pi` user with the following command. Normal runtime for this script is about 10 minutes.
```
sudo hassbian-config install ibcec
```
After this script has been run, add CEC to your `configuration.yaml` file as usual.

This script was originally contributed by [@Landrash](https://github.com/Landrash).

### Install OpenZWave-pip *(install_openzwave-pip.sh)*
This script installs Python_OpenZWae and symlinks the OpenZWave configuration directory for easy usage.

Script is run with as the `pi` user with the following command. Normal runtime for this scripts is about 15 minutes.
```
sudo hassbian-config install openzwave-pip
```
After this script has been run, add ZWave to your `configuration.yaml` file as usual.

This script was originally contributed by [@Landrash](https://github.com/Landrash).

### Install OpenZWave *(install_openzwave.sh)*
This script compiles OpenZWave, installs OZWCP(open-zwave-control-panel) and symlinks the library and the OpenZWave configuration directory for easy usage.

Script is run with as the `pi` user with the following command. Normal runtime for this scripts is about 90 minutes.
```
sudo hassbian-config install openzwave
```
After this script has been run, add ZWave to your `configuration.yaml` file as usual.

This script was originally contributed by [@dale3h](https://github.com/dale3h) and has been modified by [@Landrash](https://github.com/Landrash).

### Share configuration with Samba *(install_samba.sh)*
This script installs samba and it dependencies. It also set up a share for Home Assistant's configuration. **This is potentially unsafe and generally not recommended.**

Script is run as the `pi` user with the following command. Normal runtime for this script is about 5 minutes.
```
sudo hassbian-config install samba
```
After this script has been run, the configuration directory used by Home Assistant is available over Samba and can be accessed from example Windows to edit with your favorite editor.

This script was originally contributed by [@Landrash](https://github.com/Landrash).
