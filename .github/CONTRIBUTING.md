# Contributing to Hassbian-scripts

Everybody is invited and welcome to contribute to Hassbian-scripts.

The process is straight-forward.
 - Read [How to get faster PR reviews](https://github.com/kubernetes/community/blob/master/contributors/guide/pull-requests.md#best-practices-for-faster-reviews) by Kubernetes (but skip step 0)
 - Fork the Hassbian-scripts [git repository](https://github.com/home-assistant/hassbian-scripts).
 - Add or change the code.
 - Ensure tests work.
 - Ensure tests work.
 - Create a Pull Request against the [**dev**](https://github.com/home-assistant/hassbian-scripts/tree/dev) branch of Hassbian-scripts.

## Pull Requests for new scripts.
All new script must have meet the following criteria to even be reviewed:
- Stickler-Ci should report no errors. (this is an automated review process based on [shellcheck](https://github.com/koalaman/shellcheck)
- The Script must be tested with success locally, see [testing your code](#testing-your-code) for tips on how to test.
- Every script should have an validation at the end, se [validation](#validation) for tips.
- You **must** add [documentation](#documentation) to the /docs for the script.

## Structure of the hassbian-scripts
The scripts in Hassbian-scripts are referred to as suites, these suites are bash scripts with an `.sh` file extension.
Each suite is buildt up of functions, and every script should have at least these functions:
 - suite-show-short-info, this info will be printed at the start when the script runs and is also used by `hassbian-config show`.
	- This will typically include an short description of the suit.
 - suite-show-long-info, this info will be printed at the start when the script runs and is also used by `hassbian-config show suite`.
	- This will typically include an longer description of the suit, and it's features.
 - suite-show-copyright-info, this info will be printed at the start when the script runs and is also used by `hassbian-config show suite`.
	- This will typically include the name/username and a link to github of the person writing the script.
 - suite-install-package and or suite-upgrade-package, this is where the magic happen, this is where you include your script.

## Spesial notations about install/upgrade functions
### User inputs
If your script require user inputs, they should be at the top of the function.
And if possible have an option to use `-y` flag, to set default values and omit the input.
Example:
```bash
function suite-install-package {
suite-show-long-info
suite-show-copyright-info

if [ "$ACCEPT" == "true" ]; then #This will be true if the suite is run with `-y`
  SUITE_USERNAME="pi"
else
  echo ""
  echo "Please take a moment to setup the suite."
  echo -n "Enter a username of your choosing: "
  read -r SUITE_USERNAME
  if [ ! "$SUITE_USERNAME" ]; then
      SUITE_USERNAME="pi" #Sets default if blank input is given.
  fi
  echo ""
  echo
fi
```

### Validation.
There are multiple ways of validating if the script was successful, these are some examples:

**Service**  
This will check if there is a service with the name `shellinaboxd` running.
```bash
validation=$(pgrep -f shellinaboxd)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "You can now access the web terminal here: http://$ip_address:4200"
  echo "You can also add this to your Home-Assistant config in an 'panel_iframe'"
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo -e "\\e[31mAborting..."
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
```

**pip package**  
This will check if the pip package `cython` is installed in the virtual evniorment.
```bash
echo "Checking the installation..."
validation=$(sudo -u homeassistant -H /bin/bash << EOF | grep Version | awk '{print $2}'
source /srv/homeassistant/bin/activate
pip3 show cython
EOF
)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "To continue have a look at https://home-assistant.io/components/tradfri/"
  echo "It's recomended that you restart your Tradfri Gateway before continuing."
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo -e "\\e[31mAborting..."
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
```

**Command line tool**  
This will check if `psql` is a valid command.
```bash
validation=$(which psql)
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "No database or database user is created during this setup and will need to be created manually."
  echo
  echo "To continue have a look at https://home-assistant.io/components/recorder/"
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo -e "\\e[31mAborting..."
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
```

**Config change**  
This example will check the value, if blank it will print "Installation Failed"  
```bash
validation=$(getcap /usr/bin/python3.5 | awk -F'= ' '{print $NF}')
if [ ! -z "${validation}" ]; then
  echo
  echo -e "\\e[32mInstallation done..\\e[0m"
  echo
  echo "To continue have a look at https://home-assistant.io/components/emulated_hue/"
  echo
else
  echo
  echo -e "\\e[31mInstallation failed..."
  echo -e "\\e[31mAborting..."
  echo -e "\\e[0mIf you have issues with this script, please say something in the #devs_hassbian channel on Discord."
  echo
  return 1
fi
return 0
```

## Testing your code
Testing the code can be done in the folowing steps:
1. Make sure you have the newest version from dev. `sudo hassbian-config upgrade hassbian-script-dev`
2. Put your `suite.sh` file in the `/opt/hassbian/suites/` directory.
3. Run test with `sudo hassbian-config install suite` and/or `sudo hassbian-config upgrade suite`
	- If you added support for `-y` test this to.


## Documentation
First create a new `suite.md` file in the /docs directory in your fork.
There can never be too much documentation, the file should have a minimum of:
- Description
- Installation and/or upgrade line/lines
- Who made the script.

It should also contains if possible:
- Log location
- Configuration location.
- Service commands
- Defaults
	- username
	- password
	- port

When the `suite.md` is finished, add it as an link in the README.md
