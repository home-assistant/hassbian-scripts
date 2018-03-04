## Description
This script will upgrade Python to the latest stable version.  
It will also create a new virtual environment to be used for Home Assistant.  
_This upgrade takes loong time to finish._

## Upgrade
```
$ sudo hassbian-config upgrade python
```

## Additional info
If you have installed additional components directly to `/srv/homeassistant/` like `libcec` thoese will need to be reinstalled.

***
This script was originally contributed by [@Ludeeus](https://github.com/ludeeus).
With inspiration from: [blog.ceard.tech](https://blog.ceard.tech/2017/12/upgrading-python-virtual-environment.html)
