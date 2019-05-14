_Scripts used in the Hassbian image._

***

[HOME](/) | [SUITES](/suites) | [**HASSBIAN-CONFIG (CLI)**](/cli) | [CONTRIBUTE](/contribute)

***

[**CLI**](/cli/cli) | [HELPER FUNCTIONS](/cli/helpers)

***

# CLI Usage

```bash
hassbian-config [command] [suite] [options]
```

## command

command | alias | description
-- | -- | --
install |  | Install a [suite].
upgrade |  | Upgrade a [suite].
remove |  | Remove a [suite].
show |  | To see available [suite] for install/upgrade.
log |  | Displays an log of the last operation.
share-log |  | Generates an hastebin link of the last operation.
show-installed |  | Generates a list of installed suites.
--version | -V | Prints the version of hassbian-config.
--help | -H | Displays information similar to this list.

## suite

All suites can be found [here](/suites)

## option (flags)

option | alias | description
-- | -- | --
--accept | -Y | Accept defaults on scripts that allows this.
--force | -F | Force run an script, this is useful if you need to reinstall a package.
--debug | -D | This will output every command to the console.
--beta | -B | This will install the current beta version if implemented.
--dev |  | This will install the current development version if implemented.