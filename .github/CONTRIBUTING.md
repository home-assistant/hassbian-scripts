# Contributing to Hassbian-scripts

Everybody is invited and welcome to contribute to Hassbian-scripts.

The process is straight-forward.
 - Read [How to get faster PR reviews](https://github.com/kubernetes/community/blob/master/contributors/guide/pull-requests.md#best-practices-for-faster-reviews) by Kubernetes (but skip step 0)
 - Fork the Hassbian-scripts [git repository](https://github.com/home-assistant/hassbian-scripts).
 - Add a new branch to your fork with a name that describe what you are implementing.
 - Add or change the code.
 - Ensure tests work.
 - Ensure tests work. _Finding out during review that this does not work, will **not** result in a good review._
 - Create a Pull Request against the [**dev**](https://github.com/home-assistant/hassbian-scripts/tree/dev) branch of Hassbian-scripts.

## Pull Requests for new scripts.
All new script must have meet the following criteria to even be reviewed:
- Stickler-Ci should report no errors. (this is an automated review process based on [shellcheck](https://github.com/koalaman/shellcheck)
- The Script must be tested with success locally, see [testing your code](#testing-your-code) for tips on how to test.
- Every script should have an validation at the end, se [validation](#validation) for tips.
- You **must** add [documentation](#documentation) to the /docs for the script.

### PR Naming
Create a good name for your PR, this will be used in the changelog.
**Good names**  
- Suite: Added support for feature X.
- Hassbian-config: Added function X.
- New install script for suite.
- Suite: Fixed typo in function X.
- Suite docs: Added more information about suite.

**Bad names**  
- Updated suite.sh
- Fixed typo.

### Description in the PR
Remember that it is people that are reviewing your PR, pepole that most likly don't share your mindset.
A good description of what the PR does, will certanly help during the review prosess.

### Comments
Your PR will most likly get comments during the review prosess, this is _not_ to criticise your work.
But feeback on how your PR can better match our "standards", you should have a look at exsiting scripts in the [repo](https://github.com/home-assistant/hassbian-scripts/tree/dev/package/opt/hassbian/suites).
If some comments are unclear to you, use the thread under that comment to get clarification, or drop a line in the #devs_hassbian channel over at [Discord](https://discord.gg/c5DvZ4e), we want to help you help us getting Hassbian-scripts better.

## Structure of the hassbian-scripts
The scripts in Hassbian-scripts are referred to as suites, these suites are bash scripts with an `.sh` file extension.
Each suite is built up of functions, and every script should have at least these functions:
 - suite-show-short-info.
  - This info will be printed at the start when the script runs and is also used by `hassbian-config show`.
	- This will typically include a short description of the suit.
 - suite-show-long-info.
  - This info will be printed when running `hassbian-config show suite`.
	- This will typically include a longer description of the suit, and it's features.
 - suite-show-copyright-info.
  - This info will be printed at the start when the script runs and is also used by `hassbian-config show suite`.
	- This will typically include the name/username and a link to github of the person writing the script.
 - suite-install-package and or suite-upgrade-package, this is where the magic happens, this is where you include your script.

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
This will check if the pip package `cython` is installed in the virtual environment.
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
  echo "It's recommended that you restart your Tradfri Gateway before continuing."
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

This line should only be printed it the validation fails.
`"If you have issues with this script, please say something in the #devs_hassbian channel on Discord."`

## Testing your code
Testing the code can be done in the folowing steps:
1. Make sure you have the newest version from the upstream dev. branch. `sudo hassbian-config upgrade hassbian-script-dev`
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
- Service commands (start, stop, restart, status)
- Defaults:
	- username
	- password
	- port

When the `suite.md` is finished, add it as an link in the README.md
