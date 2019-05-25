_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# AppDaemon

This Installs AppDaemon in a separate Venv onto this system.  
For more information about AppDaemon see the [documentation.][appdaemon-docs]

## Installation

```bash
sudo hassbian-config install appdaemon
```

## Upgrade

```bash
sudo hassbian-config upgrade appdaemon
```

## Additional info

Description | Command/value
:--- | :---
Running as: | homeassistant
Configuration dir: | /home/homeassistant/appdaemon/
Start service: | `sudo systemctl start appdaemon@homeassistant.service`
Stop service: | `sudo systemctl stop appdaemon@homeassistant.service`
Restart service: | `sudo systemctl restart appdaemon@homeassistant.service`
Service status: | `sudo systemctl status appdaemon@homeassistant.service`

Enter the virtual environment where AppDaemon is installed as `homeassistant`:

```bash
sudo su -s /bin/bash homeassistant
source /srv/appdaemon/bin/activate
```

When you are done, type `exit` to return to the `pi` user.

To manually start AppDaemon, enter the AppDaemon virtual environment as
described above, and then type this to start it:

```bash
appdaemon -c /home/homeassistant/appdaemon/
```

***

The installation script was originally contributed by [@Landrash][landrash].  
The upgrade script was originally contributed by [@Ludeeus][ludeeus].

<!--- Links --->
[appdaemon-docs]: http://appdaemon.readthedocs.io/en/latest/
[landrash]: https://github.com/landrash
[ludeeus]: https://github.com/ludeeus
