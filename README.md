## CI-Utils

CI-Utils is a set of utilities for working on continuous integration platforms.

### Usage

If the `CI` environmental variable is set, then `:ci` is added to `*features*`.
Otherwise, `:not-ci` is added.
In addition, the following platforms are recognized and supported.
If `CI` is set but the platform is unknown, then `:unknown-ci` is added to `*features*`.

| Platform  |  Feature   | Tested |
|:---------:|:----------:|:------:|
| Travis CI | :travis-ci | [![Build Status](https://travis-ci.org/neil-lindquist/CI-Utils.svg?branch=master)](https://travis-ci.org/neil-lindquist/CI-Utils) |
| Circle CI | :circle-ci | [![CircleCI](https://circleci.com/gh/neil-lindquist/CI-Utils.svg?style=svg)](https://circleci.com/gh/neil-lindquist/CI-Utils) |
| Appveyor  | :appveyor  | [![Build status](https://ci.appveyor.com/api/projects/status/mm1swvm28hpp2oc5/branch/master?svg=true)](https://ci.appveyor.com/project/neil-lindquist/ci-utils/branch/master) |
| GitLab CI | :gitlab-ci |   No   |
