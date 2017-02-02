## Hassbian-scripts

These are the scripts used in the [HASSbian](https://github.com/home-assistant/pi-gen) image.
The scripts in this repository where made to be used with the HASSbian image and the included Home Assistant instance.
On first boot these scripts are cloned to the `pi` users home directory and placed at `/home/pi/hassbian-scripts`.

To update the scripts after install, run the following command from inside the script directory.
``` shell
git pull
```
  
  
## The included scripts
The following scripts are currently included. You can view the documentation below for usage and instructions.

### Install Home Assistant *(install_homeassistant.sh)*
This is a copy of the installation script run during first boot of your Raspberry Pi.
This script is downloaded when the HASSbian image is built and is shipped on the Hassbian image.
Usually this script is not run after installation but could be used with some modifications to reinstall Home Assistant.

This script was originally contributed by [@Landrash](https://github.com/landrash).

### Install Mosquitto *(install_mosquitto.sh)*
This script installs the MQTT Mosquitto server. Repository from the Mosquitto project is added to package system and the official packages for Debain are installed.
Additionally, this script helps you create your first MQTT user that can be used with Home Assistant.

Script is run with as the `pi` user with the following command. Normal runtime for this script is about 10 minutes.

```
sudo ./hassbian-scripts/install_mosquitto.sh
```
After this script has been run, add MQTT to your `configuration.yaml` file as usual.

This script was originally contributed by [@dale3h](https://github.com/dale3h) and has been modified by [@Landrash](https://github.com/Landrash).
  
### Install CEC support *(install_libcec.sh)*
This script installs libcec and it dependencies.Further more this script symlinks the system wide packages to the Home Assistant venv so they can be used with Home Assistant.

Script is run as the `pi` user with the following command. Normal runtime for this script is about 10 minutes.
```
sudo ./hassbian-scripts/install_libcec.sh
```
After this script has been run, add CEC to your `configuration.yaml` file as usual.

This script was originally contributed by [@Landrash](https://github.com/Landrash).
  
  
### Install OpenZWave *(install_openzwave.sh)*
This script compiles OpenZWave, installs OZWCP(open-zwave-control-panel) and symlinks the library and the OpenZWave configuration directory for easy usage.

Script is run with as the `pi` user with the following command. Normal runtime for this scripts is about 90 minutes.
```
sudo ./hassbian-scripts/install_openzwave.sh
```
After this script has been run, add ZWave to your `configuration.yaml` file as usual.

This script was originally contributed by [@dale3h](https://github.com/dale3h) and has been modified by [@Landrash](https://github.com/Landrash).

### Share configuration with Samba *(install_samba.sh)*
This script installs samba and it dependencies. It also set up a share for Home Assistant's configuration. **This is potentially unsafe and generally not recommended.**

Script is run as the `pi` user with the following command. Normal runtime for this script is about 5 minutes.
```
sudo ./hassbian-scripts/install_samba.sh
```
After this script has been run, the configuration directory used by Home Assistant is available over Samba and can be accessed from example Windows to edit with your favorite editor.

This script was originally contributed by [@Landrash](https://github.com/Landrash).
