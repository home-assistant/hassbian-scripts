_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [**SUITES**](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [CONTRIBUTE](/hassbian-scripts/contribute)

***

# hassbian-config

This command is a package handler for the Hassbian scripts.
All interactions for installing software should be handled
through this command.  
_Running the individual scripts to install
software will no longer work as expected._

## Usage

The hassbian-config command is invoked with:

```bash
hassbian-config *command* *suite* *flag(optional)*
```

where `*command*` is one of:

Command | Description
:--- | :---
`install` | Use this to install an suite.
`upgrade` | Use this to upgrade an installed suite.
`show` | This will show you all available suites.
`log` | This will show you the log of last hassbian-config operation.
`share-log` | This will generate an hastebin link of the last hassbian-config operation.
`show-installed` | Generates a list of installed suites.

**Optional flags:**

Flag | Alt. flag | Description
:--- | :--- | :---
`--accept` | `-Y` | This will accept defaults on scripts that allow this.
`--force` | `-F` | This will force run an script. This is useful if you need to reinstall a package.
`--debug` | `-D` | This will output every comand to the console.
`--beta` |`-B` |  This will install the current beta version if implemented.
`--dev` | | This will install the current development version if implemented.

**Other available commands:**

Command | Alt. command | Description
:--- | :--- | :---
`--version` | - `-V` | This will show you the installed version of `hassbian-config`.
`--help` | - `-H` | Shows help for the tool, with all available commands.

## Installation

This package is pre-installed on the [Hassbian image][hassbian-image].  
This package *can* be used with Raspbian lite but it's not recommended.

```bash
curl https://api.github.com/repos/home-assistant/hassbian-scripts/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -
sudo apt install -y ./hassbian*
```

## Upgrade

```bash
sudo hassbian-config upgrade hassbian-script
```

## Upgrade to dev branch

```bash
sudo hassbian-config upgrade hassbian-script --dev
```

<!--- Links --->
[hassbian-image]: https://github.com/home-assistant/pi-gen/releases
