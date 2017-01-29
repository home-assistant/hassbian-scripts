## Hassbian-scripts

These are the scripts used in the [HASSbian](https://github.com/home-assistant/pi-gen) image.

### Install OpenZWave
This script compiles OpenZWave, installs OZWCP(open-zwave-control-panel) and add symlinks the library and the OpenZWave configuration directory for easy usage.

Script is run with as the `pi` user with the following command. Normal runtime for this scripts is about 90 minutes.
```
sudo ./hassbian-scripts/install_openzwave.sh
```
After this script has been run, add ZWave to your `configuration.yaml` file as usual.

This script was originaly contributed by [@Dale3h](https://github.com/dale3h) but has been modified by [@Landrash](https://github.com/Landrash).

### Install Mosquitto
This script install the MQTT Mosquitto server. Repository from the Mosquitto project is added to package system and the offical packges for Debain is installed. Futher more this script helps you create your first MQTT user that can be used with Home Assistant.

Script is run with as the `pi` user with the following command. Normal runtime for this scripts are about 10 minutes.
```
sudo ./hassbian-scripts/install_mosquitto.sh
```
This script was originaly contributed by [@Dale3h](https://github.com/dale3h) but has been modified by [@Landrash](https://github.com/Landrash).

### Install Home Assistant
Copy of the installation script run on first boot of your Raspberry Pi. Usually not run after this but could be used with some minor modifications to reinstall Home Assistant.
