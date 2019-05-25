_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# RaZberry

This script disables Bluetooth for the use of a RaZberry with Hassbian.
Code is adapted from the Razberry install script found at
[razberry.z-wave.me][razberry]. This will disable the use of Bluetooth and
Bluetooth Low Energy devices.

## Installation

```bash
sudo hassbian-config install razberry
```

## Upgrade

No script available, maybe you could write one?  
If so, add an PR here when you are done:  
[homeassistant/hassbian-scripts][repo]

***

This script was originally contributed by [@Landrash][landrash].

<!--- Links --->
[landrash]: https://github.com/Landrash
[razberry]: http://razberry.z-wave.me/install
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
