## Description
It is not recomended running this script.\
**It is recomended to download and install the newest [Hassbian image](https://github.com/home-assistant/pi-gen/releases/latest) instead of running this.**\
This script will upgrade Python to the latest stable version.\
It will also create a new virtual environment to be used for Home Assistant.\
_This upgrade takes long time to finish._\
_This prosess takes about a hour on an Raspberry Pi 3_
_There are issues with 3.7.x and Home Assistant, this script has an limit of version 3.6.6_

## Upgrade
```
$ sudo hassbian-config upgrade python
```

## Additional info
If you have installed additional components directly to `/srv/homeassistant/` like `libcec` thoese will need to be reinstalled.

***
This script was originally contributed by [@Ludeeus](https://github.com/ludeeus).
With inspiration from: [blog.ceard.tech](https://blog.ceard.tech/2017/12/upgrading-python-virtual-environment.html)
