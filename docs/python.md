# Pyhton

It is not recomended running this script.  
**It is recomended to download and install the newest
[Hassbian image][hassbian-image] instead of running this.**  

This script will upgrade Python to the latest stable version.\
It will also create a new virtual environment to be used for Home Assistant.\
_This upgrade takes long time to finish, on an Raspberry Pi 3
this took about 1 hour._

## Upgrade

```bash
sudo hassbian-config upgrade python
```

## Additional info

If you have installed additional components directly to `/srv/homeassistant/`
like `libcec` thoese will need to be reinstalled.

***

This script was originally contributed by [@Ludeeus][ludeeus].
With inspiration from [blog.ceard.tech][blog].

<!--- Links --->
[blog]: https://blog.ceard.tech/2017/12/upgrading-python-virtual-environment.html
[hassbian-image]: https://github.com/home-assistant/pi-gen/releases/latest
[ludeeus]: https://github.com/ludeeus
