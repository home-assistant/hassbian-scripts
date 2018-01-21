## Description
This command is a package handler for the Hassbian scripts. All interactions for installing software should be handled through this command. Running the individual scripts to install software will no longer work as expected.

#### Usage
The hassbian-config command is invoked with:
```bash
hassbian-config *command* *suite*
```
where command is one of:
- `install`
- `upgrade`
- `show`
- `log`
- `share-log`

## Installation
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
