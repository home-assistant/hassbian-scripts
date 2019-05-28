_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Samba

After this script has been run, the configuration directory used by
Home Assistant is available over Samba and can be accessed from example
Windows to edit with your favorite editor.

## Installation

```bash
sudo hassbian-config install samba
```

## Upgrade

No script available, maybe you could write one?  
If so, add an PR here when you are done:  
[homeassistant/hassbian-scripts][repo]

## Additional info

Description | Command/value
:--- | :---
Running as: | root
Configuration file: | /etc/samba/smb.conf
Start service: | `sudo systemctl start smbd.service`
Stop service: | `sudo systemctl stop smbd.service`  
Restart service: | `sudo systemctl restart smbd.service`
Service status: | `sudo systemctl status smbd.service`

***

This script was originally contributed by [@Landrash][landrash].

<!--- Links --->
[landrash]: https://github.com/Landrash
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
