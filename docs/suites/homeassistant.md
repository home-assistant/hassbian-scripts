_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Home Assistant

This is a copy of the installation script run during first
boot of your Raspberry Pi with the [Hassbian image][hassbian-image]  
And an easy way to upgrade Home Assistant to the newest version.

## Installation

_**NB!: This is installed by Hassbian, and should not be run additionally**_

```bash
sudo hassbian-config install homeassistant
```

## Upgrade

```bash
sudo hassbian-config upgrade homeassistant
```

## Upgrade to beta channel

```bash
sudo hassbian-config upgrade homeassistant --beta
```

## Upgrade to dev branch

```bash
sudo hassbian-config upgrade homeassistant --dev
```

## Upgrade to to a specific version

```bash
sudo hassbian-config upgrade homeassistant=0.65.6
```

## Additional info

Description | Command/value
:--- | :---
Running as: | homeassistant
Configuration dir: | /home/homeassistant/.homeassistant/
Start service: | `sudo systemctl start home-assistant@homeassistant.service`
Stop service: | `sudo systemctl stop home-assistant@homeassistant.service`
Restart service: | `sudo systemctl restart home-assistant@homeassistant.service`
Service status: | `sudo systemctl status home-assistant@homeassistant.service`

Enter the virtual environment where Home Assistant is installed as `homeassistant`:

```bash
sudo su -s /bin/bash homeassistant
source /srv/homeassistant/bin/activate
```

When you are done, type `exit` to return to the `pi` user.

## Included bash aliases

### For the user `pi`

Alias | Command
:--- | :---
halog | `sudo journalctl -f -u home-assistant@homeassistant.service`
harestart | `sudo systemctl restart home-assistant@homeassistant.service`
hashell | `sudo su -s /bin/bash homeassistant`
hastart | `sudo systemctl start home-assistant@homeassistant.service`
hastatus | `sudo systemctl status home-assistant@homeassistant.service`
hastop | `sudo systemctl stop home-assistant@homeassistant.service`

### For the user `homeassistant`

Alias | Command
:--- | :---
hacheckconf | `source /srv/homeassistant/bin/activate;hass --script check_config`
hapyshell | `source /srv/homeassistant/bin/activate;cd ~/.homeassistant`

***

The installation script was originally contributed by [@Landrash][landrash].  
The upgrade script was originally contributed by [@Ludeeus][ludeeus].

<!--- Links --->
[hassbian-image]: https://github.com/home-assistant/pi-gen/releases/latest
[landrash]: https://github.com/landrash
[ludeeus]: https://github.com/ludeeus
