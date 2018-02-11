## Description
This script adds an cron job to auto update you the WAN IP address for the defined domain.
Before running this script you should already have an Duck DNS account, during the installation you will be asked to supply your domain name and the token for your account.

## Installation
```
$ sudo hassbian-config install duckdns
```

## Additional info
Running as: `homeassistant`  

If you choose to aslo generate SSL certificates with this you would need to add this under `http:` to your `configuration.yaml`
```
  ssl_certificate: /home/homeassistant/dehydrated/certs/YOURDOMAIN.duckdns.org/fullchain.pem
  ssl_key: /home/homeassistant/dehydrated/certs/YOURDOMAIN.duckdns.org/privkey.pem
  base_url: YOURDOMAIN.duckdns.org:PORTNUMBER
```

***
This script was originally contributed by [@Ludeeus](https://github.com/ludeeus).
