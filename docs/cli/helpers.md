_Scripts used in the Hassbian image._

***

[HOME](/) | [SUITES](/suites) | [**HASSBIAN-CONFIG (CLI)**](/cli) | [CONTRIBUTE](/contribute)

***

[CLI](/cli/cli) | [**HELPER FUNCTIONS**](/cli/helpers)

***

# Helper functions

_These functions can be used in suites to simplify the code used in that suite._

<!--- When adding stuff here, please keep it alphabetical --->

- ['hassbian.developer.test.package'](#hassbian.developer.test.package)
- ['hassbian.developer.test.pr'](#hassbian.developer.test.pr)
- ['hassbian.info.general.all_suites'](#hassbian.info.general.all_suites)
- ['hassbian.info.general.help'](#hassbian.info.general.help)
- ['hassbian.info.general.ipaddress'](#hassbian.info.general.ipaddress)
- ['hassbian.info.general.isntalled_suites'](#hassbian.info.general.isntalled_suites)
- ['hassbian.info.general.python.location'](#hassbian.info.general.python.location)
- ['hassbian.info.general.rootcheck'](#hassbian.info.general.rootcheck)
- ['hassbian.info.general.systeminfo'](#hassbian.info.general.systeminfo)
- ['hassbian.info.general.usage'](#hassbian.info.general.usage)
- ['hassbian.info.version.hassbian_config.installed'](#hassbian.info.version.hassbian_config.installed)
- ['hassbian.info.version.hassbian_config.remote'](#hassbian.info.version.hassbian_config.remote)
- ['hassbian.info.version.homeassistant.github'](#hassbian.info.version.homeassistant.github)
- ['hassbian.info.version.homeassistant.installed'](#hassbian.info.version.homeassistant.installed)
- ['hassbian.info.version.homeassistant.pypi'](#hassbian.info.version.homeassistant.pypi)
- ['hassbian.info.version.homeassistant.python'](#hassbian.info.version.homeassistant.python)
- ['hassbian.info.version.osreleasename'](#hassbian.info.version.osreleasename)
- ['hassbian.info.version.python'](#hassbian.info.version.python)
- ['hassbian.input.bool'](#hassbian.input.bool)
- ['hassbian.input.info'](#hassbian.input.info)
- ['hassbian.input.text'](#hassbian.input.text)
- ['hassbian.log.share'](#hassbian.log.share)
- ['hassbian.log.show'](#hassbian.log.show)
- ['hassbian.suite.action'](#hassbian.suite.action)
- ['hassbian.suite.action.execute'](#hassbian.suite.action.execute)
- ['hassbian.suite.helper.action.failed'](#hassbian.suite.helper.action.failed)
- ['hassbian.suite.helper.action.success'](#hassbian.suite.helper.action.success)
- ['hassbian.suite.helper.blockcheck'](#hassbian.suite.helper.blockcheck)
- ['hassbian.suite.helper.exist'](#hassbian.suite.helper.exist)
- ['hassbian.suite.helper.install.apt'](#hassbian.suite.helper.install.apt)
- ['hassbian.suite.helper.install.node'](#hassbian.suite.helper.install.node)
- ['hassbian.suite.helper.install.pip'](#hassbian.suite.helper.install.pip)
- ['hassbian.suite.helper.manifest'](#hassbian.suite.helper.manifest)
- ['hassbian.suite.helper.pizerocheck'](#hassbian.suite.helper.pizerocheck)
- ['hassbian.suite.info.installed'](#hassbian.suite.info.installed)
- ['hassbian.suite.info.print'](#hassbian.suite.info.print)
- ['hassbian.suite.verify.pgrep'](#hassbian.suite.verify.pgrep)
- ['hassbian.suite.verify.service'](#hassbian.suite.verify.service)
- ['hassbian.workaround.check'](#hassbian.workaround.check)
- ['hassbian.workaround.pip.typeerror'](#hassbian.workaround.pip.typeerror)


## hassbian.developer.test.package

Run the included test suite.

## hassbian.developer.test.pr

Install a spesific PR for testing.

## hassbian.info.general.all_suites

List all suites.

## hassbian.info.general.help

Print help to the console.

## hassbian.info.general.ipaddress

Get the local IP address.

## hassbian.info.general.isntalled_suites

Check is a suite is installed.

## hassbian.info.general.python.location

Get the full path of python.

## hassbian.info.general.rootcheck

Check if hassbian-config is run as root.

## hassbian.info.general.systeminfo

Print system information to the console.

## hassbian.info.general.usage

Print usage information to the console.

## hassbian.info.version.hassbian_config.installed

Get the installed version of hassbian-config.

## hassbian.info.version.hassbian_config.remote

Get the newest version number of hassbian-config.

## hassbian.info.version.homeassistant.github

Get the newest version number of homeassistant from github.

## hassbian.info.version.homeassistant.installed

Get the newest version number of the installed homeassistant.

## hassbian.info.version.homeassistant.pypi

Get the newest version number of homeassistant from pypi.

## hassbian.info.version.homeassistant.python

Get the version of python from HA's venv.

## hassbian.info.version.osreleasename

Get the OS releasename.

## hassbian.info.version.python

Get the version of the newest installed python package.

## hassbian.input.bool

GUI inputbox for bools, usage:

```text
hassbian.input.bool "Are you sure?"
```

## hassbian.input.info

GUI infobox, usage:

```text
hassbian.input.info "This will do stuff."
```

## hassbian.input.text

GUI inputbox for text, usage:

```text
hassbian.input.text "What is your name?"
```

## hassbian.log.share

Put the logfile on hastebin and print the url to it.

## hassbian.log.show

Show the logfile in the console

## hassbian.suite.action

Run actions (install/upgrade/remove) on a suite.

## hassbian.suite.action.execute

Execute the action from `hassbian.suite.action`

## hassbian.suite.helper.action.failed

Prints a failed message in the console.

## hassbian.suite.helper.action.success

Prints a success message in the console.

## hassbian.suite.helper.blockcheck

Check if we can run this suite.

## hassbian.suite.helper.exist

Check if the suite exist.

## hassbian.suite.helper.install.apt

Install apt packages, usage:

```text
hassbian.suite.helper.install.apt pkg1 pkg2
```

## hassbian.suite.helper.install.node

Install nodeJS

## hassbian.suite.helper.install.pip

Install pip packages in HA's venv, usage:

```text
hassbian.suite.helper.install.pip pkg1 pkg2
```

## hassbian.suite.helper.manifest

Get information form a suite's manifest file, usage:

```text
hassbian.suite.helper.manifest suitename manifest_key
```

## hassbian.suite.helper.pizerocheck

Check if pizero and if teh suite can be run.

## hassbian.suite.info.installed

Check if a suite is installed.

## hassbian.suite.info.print

Print information to the console.

## hassbian.suite.verify.pgrep

Verify a service using pgrep, usage:

```text
hassbian.suite.verify.pgrep hass
```

## hassbian.suite.verify.service

Verify a service using systemd, usage:

```text
hassbian.suite.verify.service home-assistant@homeassistant.service
```

## hassbian.workaround.check

Check the logfile for known issues, and execute workaround for that issue.

## hassbian.workaround.pip.typeerror

Execute workaround for the pypi typeerror issue.