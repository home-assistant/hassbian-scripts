## Hassbian-scripts

These are the scripts used in the [HASSbian](https://github.com/home-assistant/pi-gen) image.
The scripts in this repository where made to be used with the HASSbian image and the included Home Assistant instance.  

### hassbian-config (hassbian-config)
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

## The included scripts
The following scripts are currently included. You can view the documentation below for usage and instructions.

* [Homebridge](/docs/homebridge.md)
