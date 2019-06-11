_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Webterminal

This script installs a web terminal called 'shellinabox' to your system that
gives you SSH access in your web browser.

## Installation

```bash
sudo hassbian-config install webterminal
```

## Upgrade

No script available. Maybe you could write one?  
If so, add a PR here when you are done:  
[homeassistant/hassbian-scripts][repo]

## Additional info

Description | Command/value
:--- | :---
Running as: | root
Default port: | 4200
Configuration file: | /etc/default/shellinabox
Start service: | `sudo systemctl start shellinabox.service`
Stop service: | `sudo systemctl stop shellinabox.service`
Restart service: |`sudo systemctl restart shellinabox.service`
Service status: |`sudo systemctl status shellinabox.service`

Example config for Home-Assistant:

```yaml
panel_iframe:
  web_terminal:
    title: 'Web terminal'
    icon: mdi:console
    url: 'http://192.168.1.2:4200'
```

### Notes for SSL

If you enable the use of existing Let's Encrypt certificates, you need to open
ports in your firewall to use them.

If SSL is used, the panel_iframe has to use the same domain name as the one
issued with your certificate.

```yaml
panel_iframe:
  web_terminal:
    title: 'Web terminal'
    icon: mdi:console
    url: 'https://yourdomain.duckdns.org:4200'
```

***

This script was originally contributed by [@Ludeeus][ludeeus].

<!--- Links --->
[ludeeus]: https://github.com/ludeeus
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
