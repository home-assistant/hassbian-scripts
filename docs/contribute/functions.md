_Scripts used in the Hassbian image._

***

[HOME](/hassbian-scripts/) | [SUITES](/hassbian-scripts/suites) | [HASSBIAN-CONFIG (CLI)](/hassbian-scripts/cli) | [**CONTRIBUTE**](/hassbian-scripts/contribute)

***

[SUITES](/hassbian-scripts/contribute/suites) | [**FUNCTIONS**](/hassbian-scripts/contribute/functions)

***

When adding new functions you should place that function in a logical place. Familiarize yourself with the current structure and choose a name and location that make sense.

A function should contain the following:

- The function name
- A comment inside the function that describe what it does.
- A comment inside the function with a usage example.

If the function fail to do what it should do it should return 1.

If the function require a variable to be passed to it, it can be excluded from tests by adding it [here](https://github.com/home-assistant/hassbian-scripts/blob/dev/package/opt/hassbian/helpers/developer) under the 'hassbian.developer.test.package' function under the "TESTING HASSBIAN-CONFIG FUNCTIONS" section.
