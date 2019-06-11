_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# LibCEC

**This script is currently broken upstream since it currently doesn't build properly for Python >3.4**
This script installs libcec and it dependencies. Further more this script symlinks the system wide packages to the Home Assistant venv so they can be used with Home Assistant.

## Installation

```bash
sudo hassbian-config install libcec
```

## Upgrade

No script available, maybe you could write one?  
If so, add an PR here when you are done:  
[homeassistant/hassbian-scripts][repo]

## Additional info

Running as: `homeassistant`  
For more information about this, se the [component page][component]

***

The installation script was originally contributed by [@Landrash][landrash].

<!--- Links --->
[component]: https://home-assistant.io/components/hdmi_cec/
[landrash]: https://github.com/landrash
[repo]: https://github.com/home-assistant/hassbian-scripts/pulls
