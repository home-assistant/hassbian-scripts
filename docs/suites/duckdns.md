_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Duck DNS

This script adds a cron job which auto updates the WAN IP address for the
defined domain.  
Before running this script you should already have a
[Duck DNS account][duckdns]. During the installation you will be asked to
supply your domain name and the token for your account.

## Installation

```bash
sudo hassbian-config install duckdns
```

# Remove
```bash
sudo hassbian-config remove duckdns
```

## Additional info

Running as: `homeassistant`  

If you choose to also generate SSL certificates with this you would need to
add this under `http:` to your `configuration.yaml`

```yaml
  ssl_certificate: /home/homeassistant/dehydrated/certs/YOURDOMAIN.duckdns.org/fullchain.pem
  ssl_key: /home/homeassistant/dehydrated/certs/YOURDOMAIN.duckdns.org/privkey.pem
  base_url: YOURDOMAIN.duckdns.org:PORTNUMBER
```

Keep in mind that after you added the ssl keys to your config and restarted Home Assistant, your installation won't be available through http anymore but then only through https.

***

This script was originally contributed by [@Ludeeus][ludeeus].

<!--- Links --->
[duckdns]: http://www.duckdns.org
[ludeeus]: https://github.com/ludeeus
