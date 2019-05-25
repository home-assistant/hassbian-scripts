_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [SUITES](/hassbian-scripts/suites) | [**HASSBIAN-CONFIG (CLI)**](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

[CLI](/hassbian-scripts/cli/cli) | [**HELPER FUNCTIONS**](/hassbian-scripts/cli/helpers)

***

# Helper functions

_These functions can be used in suites to simplify the code used in that suite._

<!--- When adding stuff here, please keep it alphabetical --->

- ['hassbian.developer.test.package'](#hassbiandevelopertestpackage)
- ['hassbian.developer.test.pr'](#hassbiandevelopertestpr)
- ['hassbian.info.general.all_suites'](#hassbianinfogeneralall_suites)
- ['hassbian.info.general.help'](#hassbianinfogeneralhelp)
- ['hassbian.info.general.ipaddress'](#hassbianinfogeneralipaddress)
- ['hassbian.info.general.isntalled_suites'](#hassbianinfogeneralisntalled_suites)
- ['hassbian.info.general.python.location'](#hassbianinfogeneralpythonlocation)
- ['hassbian.info.general.rootcheck'](#hassbianinfogeneralrootcheck)
- ['hassbian.info.general.systeminfo'](#hassbianinfogeneralsysteminfo)
- ['hassbian.info.general.usage'](#hassbianinfogeneralusage)
- ['hassbian.info.version.hassbian_config.installed'](#hassbianinfoversionhassbian_configinstalled)
- ['hassbian.info.version.hassbian_config.remote'](#hassbianinfoversionhassbian_configremote)
- ['hassbian.info.version.homeassistant.github'](#hassbianinfoversionhomeassistantgithub)
- ['hassbian.info.version.homeassistant.installed'](#hassbianinfoversionhomeassistantinstalled)
- ['hassbian.info.version.homeassistant.pypi'](#hassbianinfoversionhomeassistantpypi)
- ['hassbian.info.version.homeassistant.python'](#hassbianinfoversionhomeassistantpython)
- ['hassbian.info.version.osreleasename'](#hassbianinfoversionosreleasename)
- ['hassbian.info.version.python'](#hassbianinfoversionpython)
- ['hassbian.input.bool'](#hassbianinputbool)
- ['hassbian.input.info'](#hassbianinputinfo)
- ['hassbian.input.text'](#hassbianinputtext)
- ['hassbian.log.share'](#hassbianlogshare)
- ['hassbian.log.show'](#hassbianlogshow)
- ['hassbian.suite.action'](#hassbiansuiteaction)
- ['hassbian.suite.action.execute'](#hassbiansuiteactionexecute)
- ['hassbian.suite.helper.action.failed'](#hassbiansuitehelperactionfailed)
- ['hassbian.suite.helper.action.success'](#hassbiansuitehelperactionsuccess)
- ['hassbian.suite.helper.blockcheck'](#hassbiansuitehelperblockcheck)
- ['hassbian.suite.helper.exist'](#hassbiansuitehelperexist)
- ['hassbian.suite.helper.install.apt'](#hassbiansuitehelperinstallapt)
- ['hassbian.suite.helper.install.node'](#hassbiansuitehelperinstallnode)
- ['hassbian.suite.helper.install.pip'](#hassbiansuitehelperinstallpip)
- ['hassbian.suite.helper.manifest'](#hassbiansuitehelpermanifest)
- ['hassbian.suite.helper.pizerocheck'](#hassbiansuitehelperpizerocheck)
- ['hassbian.suite.info.installed'](#hassbiansuiteinfoinstalled)
- ['hassbian.suite.info.print'](#hassbiansuiteinfoprint)
- ['hassbian.suite.verify.pgrep'](#hassbiansuiteverifypgrep)
- ['hassbian.suite.verify.service'](#hassbiansuiteverifyservice)
- ['hassbian.workaround.check'](#hassbianworkaroundcheck)
- ['hassbian.workaround.pip.typeerror'](#hassbianworkaroundpiptypeerror)


## hassbian.developer.test.package

Run the included test suite.

## hassbian.developer.test.pr

Install a specific PR for testing.

## hassbian.info.general.all_suites

List all suites.

## hassbian.info.general.help

Print help to the console.

## hassbian.info.general.ipaddress

Get the local IP address.

## hassbian.info.general.isntalled_suites

Check if a suite is installed.

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

Put the logfile on hastebin and print the url.

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

Check if pizero and if the suite can be run.

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
