# Contributing to Hassbian-scripts

Everybody is invited and welcome to contribute to Hassbian-scripts.

The process is straight-forward.
 - Read [How to get faster PR reviews](https://github.com/kubernetes/community/blob/master/contributors/guide/pull-requests.md#best-practices-for-faster-reviews) by Kubernetes (but skip step 0)
 - Fork the Hassbian-scripts [git repository](https://github.com/home-assistant/hassbian-scripts).
 - Add a new branch to your fork with a name that describes what you are implementing.
 - Add or change the code.
 - Ensure tests work.
 - Ensure tests work. _Finding out during review that this does not work, will **not** result in a good review._
 - Create a Pull Request against the [**dev**](https://github.com/home-assistant/hassbian-scripts/tree/dev) branch of Hassbian-scripts.

## Pull Requests for new scripts.
All new scripts must meet the following criteria to be considered to be reviewed:
- Stickler-Ci should report no errors. (this is an automated review process based on [shellcheck](https://github.com/koalaman/shellcheck))
- The Script must be tested with success locally, see [testing your code](#testing-your-code) for tips on how to test.
- Every script should have a validation at the end, see [validation](#validation) for tips.
- You **must** add [documentation](#documentation) to the `/docs` for the script.

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
Remember that it is people that are reviewing your PR, people that most likely don't share your mindset.
A good description of what the PR does, will certanly help during the review prosess.

### Comments
Your PR will most likely get comments during the review process, this is _not_ to criticise your work.
But feedback on how your PR can better match our "standards", you should have a look at existing scripts in the [repo](https://github.com/home-assistant/hassbian-scripts/tree/dev/package/opt/hassbian/suites).
If some comments are unclear to you, use the thread under that comment to get clarification, or drop a line in the **#devs_hassbian** channel over at [Discord](https://discord.gg/c5DvZ4e). We want to help you help us getting Hassbian-scripts better.

### More info
For more information about contributions in the different sections of the project have a look at the [contribution documentation](https://home-assistant.github.io/hassbian-scripts/contribute).
