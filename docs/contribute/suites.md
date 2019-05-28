_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [SUITES](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [**CONTRIBUTE**](/hassbian-scripts/contribute)

***

[**SUITES**](/hassbian-scripts/contribute/suites) | [FUNCTIONS](/hassbian-scripts/contribute/functions)

***

# Suites

So you want to contribute a suite to our collection, AWSEOME!

Here you will find some info to help you along the way.

To get inspiration you can have a look at the ["template suite"](https://github.com/home-assistant/hassbian-scripts/tree/dev/package/opt/hassbian/suites/template)

When creating a new suite it is a good idea to reuse the template suite.

## Table of content

- [Directory structure](#directory-structure)
- [Manifest](#manifest)
- [Validation](#validation)
- [User inputs](#user-inputs)

# Directory structure

- All suites are located in dedicated directories under 'package/opt/hassbian/suites/'.
- All suites must have a manifest file.
- All suites must have at least one of these action files:
  - install
  - upgrade
  - remove
- If your suite require extra files (servicefile, cronjob and so on), those goes in a `files` sub-directory under your suite.

**Example:**

_From '/package/opt/hassbian/suites/template'_

```text
files/template.service
install
manifest
remove
upgrade
```

# Manifest

Each suite has a manifest file with information about the suite.
This file needs to be valid JSON.

## Key: name

The name of the suite.

## Key: author

Your GitHuub username and link you your GitHub user profile.

## Key: short_description

A short description of what the suite does.

## Key: long_description

A longer description of what the suite does.

## Key: unattended

A bool to indicate that this is fully unattended.

## Key: blocked

A bool to indicate that this is is blocked on some distros.

## Key: blocked_releasename

Which distro that has the block.

## Key: blocked_messages

A  message to the user if it's blocked.

# Validation

All suites must validate that the suite action completed. This validation should be at the end of the action files.

**Example:**

```bash
  validation=$(hassbian.suite.verify.service template.service)
  if [ "$validation" == "0" ]; then
    hassbian.suite.helper.action.success
  else
    hassbian.suite.helper.action.failed
    return 1
  fi
  return 0
```

# User inputs

If your script require user inputs, they should be at the top of the function. And if possible have an option to use `--accept` (`-Y`) flag, to set default values and omit the input. Example:

```bash
  if [ "$HASSBIAN_RUNTIME_ACCEPT" = true ]; then
    username='pi'
    password='raspberry'
  else
    hassbian.input.info "Please take the time to setup your account"
    username=$(hassbian.input.text "Username:")
    password=$(hassbian.input.text "Password:")
    if [ "$username" == "0" ]; then
      username='pi'
    fi
    if [ "$password" == "0" ]; then
      password='raspberry'
    fi
  fi
```
