## Description
This command is a package handler for the Hassbian scripts. All interactions for installing software should be handled through this command. Running the individual scripts to install software will no longer work as expected.

#### Usage
The hassbian-config command is invoked with:
```bash
hassbian-config *command* *suite* *flag(optional)*
```
where command is one of:
- `install` Use this to isntall an suite.
- `upgrade` Use this to upgrade an installed suite.
- `show` This will show you all available suites.
- `log` This will show you the log of last hassbian-config operation.
- `share-log` This will generate an hastebin link of the last hassbian-config operation.

optional flags:
- `-y` This will accept defaults on scripts that allow this.
- `-f` This will force run an script, usefull is you try to install something a second time.

## Installation
This package is installed in the [HASSbian image](https://github.com/home-assistant/pi-gen/releases), so you do not need to install it there.
This will probably work on other distros also, but testing will only be done on HASSBian, therefor no support will be given if you choose to install it elsewhere.
```
$ curl https://api.github.com/repos/home-assistant/hassbian-scripts/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -
$ sudo apt install -y ./hassbian*
```


## Upgrade
```
$ sudo hassbian-config upgrade hassbian-script
```

## Upgrade to dev branch
```
$ sudo hassbian-config upgrade hassbian-script-dev
```
