OPM-parser jenkins build scripts:
--------------------------------

[B]build-opm-parser.sh[/B]:
This is a helper script which contains functions for building,
testing and cloning opm-parser and its dependencies.

[B]build.sh[/B]:
This script will build dependencies, then build opm-parser and execute its tests.
It is intended for post-merge builds of the master branch.

[B]build-pr.sh[/B]:
This script will build dependencies, then build opm-parser and execute its tests.
It inspects the $ghbPrBuildComment environmental variable to obtain a pull request
to use for opm-common (defaults to master) and then builds $sha1 of opm-parser.

It is intended for pre-merge builds of pull requests.

You specify a given pull request to use for opm-common through the trigger.
The trigger line needs to contain opm-common=<pull request number>.
