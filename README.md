## CI-Utils

[![Travis Status](https://img.shields.io/travis/neil-lindquist/ci-utils.svg?logo=Travis)](https://travis-ci.org/neil-lindquist/CI-Utils)
[![CircleCI Status](https://img.shields.io/circleci/build/github/neil-lindquist/CI-Utils.svg?logo=CircleCI)](https://circleci.com/gh/neil-lindquist/CI-Utils)
[![Appveyor Status](https://ci.appveyor.com/api/projects/status/mm1swvm28hpp2oc5/branch/master?svg=true)](https://ci.appveyor.com/project/neil-lindquist/ci-utils/branch/master)
[![Gitlab CI Status](https://img.shields.io/gitlab/pipeline/neil-lindquist/CI-Utils.svg?logo=Gitlab)](https://gitlab.com/neil-lindquist/CI-Utils/pipelines)
[![Bitbucket pipelines status](https://img.shields.io/bitbucket/pipelines/nlindqu1/ci-utils?logo=bitbucket)](https://bitbucket.org/nlindqu1/ci-utils/addon/pipelines/home#!/)
[![Azure Pipelines Status](https://img.shields.io/azure-devops/build/archer1mail/archer1mail/1?logo=Azure%20Pipelines)](https://dev.azure.com/archer1mail/archer1mail/_build?definitionId=1&_a=summary)
[![Github Actions Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fneil-lindquist%2Fci-utils%2Fbadge&style=flat&label=build)](https://actions-badge.atrox.dev/neil-lindquist/ci-utils/goto)

[![Coveralls coverage](https://img.shields.io/coveralls/github/neil-lindquist/CI-Utils?logo=coveralls)](https://coveralls.io/github/neil-lindquist/CI-Utils)

CI-Utils is a set of utilities and examples for working on continuous integration platforms, including a run script for the Fiveam test library.

### Example CI Configurations
Example configurations for the CI platforms supported by CI-Utils can be found in the [`config-examples`](https://github.com/neil-lindquist/CI-Utils/tree/master/config-examples) directory.
These examples are intended to jump start using CI to test Common Lisp projects.
Basic usage should just require replacing `foo` with the name of the system, possibly adjusting the testing framework, and moving the file (or directory in a few cases) to the project root.


### Installation
If you are using Roswell, run `ros install ci-utils`.
This will download the code where ASDF can find it and place `run-fiveam` in the roswell bin directory.
If you are not using Roswell, either run `(ql:quickload :ci-utils)` or manually download the contents of this repository somewhere that ASDF can find it.

### Usage

See [neil-lindquist.github.io/CI-Utils/API](https://neil-lindquist.github.io/CI-Utils/API) for documentation of the API.

#### run-fiveam

The `run-fiveam` Roswell script is designed to make running Fiveam tests simple.
It has the form `run-fiveam [options] <tests and suites>`.
The test and suite names are read as symbols after loading any requested systems.
The `--quicklisp <system>` and `-l <system>` options load a system using quicklisp.
Note that any root systems in the project directory are automatically loaded.
The `--exclude <path>` and `-e <path>` options mark a path for exclusion when measuring code coverage.
Additionally, there are two environmental variables that directly affect run-fiveam.
`COVERALLS` enables measuring code coverage using [cl-coveralls](https://github.com/fukamachi/cl-coveralls/).
`COVERAGE_EXCLUDE` is a colon separated list of paths to exclude from code coverage measurements, in addition to those passed as arguments.
See `run-fiveam --help` for more information.

#### Platform Features

CI-Utils adds a few values to `*FEATURES*` that describe the current platform.
First, `:CI` is added if the `CI` environmental variable is set or the system is otherwise recognized as a known CI platform.
Known CI platforms have their name added (listed in the table below).
If `CI` is set but the system is not a recognized CI platform, then `:UNKNOWN-CI` is added.
Finally, if the `COVERALLS` environmental variable is set, then `:COVERALLS` is added.

| Platform  |  Symbol Name |
|:---------:|:------------:|
| Travis CI | `:TRAVIS-CI` |
| Circle CI | `:CIRCLE-CI` |
| Appveyor  | `:APPVEYOR`  |
| GitLab CI | `:GITLAB-CI` |
| Bitbucket Pipelines | `:BITBUCKET-PIPELINES` |
|   Azure Pipelines   |   `:AZURE-PIPELINES`   |
|    Github Actions   |    `:GITHUB-ACTIONS`   |
