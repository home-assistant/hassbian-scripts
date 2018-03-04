## Description
This script will upgrade Python to the latest stable version.
It will also create a new virtuel enviorment to be used for Home Assistant.

## Upgrade
```
$ sudo hassbian-config upgrade python
```

## Additional info
If you have installed additional components directly to `/srv/homeassistant/` like `libcec` thoese will need to be reinstalled.

***
This script was originally contributed by [@Ludeeus](https://github.com/ludeeus).
