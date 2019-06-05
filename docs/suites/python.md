_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# Python

This script will upgrade Python and Home Assistant to the latest stable version.\
It will also create a new virtual environment to be used for Home Assistant.\
_This upgrade takes long time to finish, on an Raspberry Pi 3
this takes about 1 hour._

## Upgrade

```bash
sudo hassbian-config upgrade python
```

## Additional info

If you have installed additional packages directly to `/srv/homeassistant/`
like `libcec` those will need to be reinstalled.

***

This script was originally contributed by [@Ludeeus][ludeeus].
With inspiration from [blog.ceard.tech][blog].

<!--- Links --->
[blog]: https://blog.ceard.tech/2017/12/upgrading-python-virtual-environment.html
[ludeeus]: https://github.com/ludeeus
