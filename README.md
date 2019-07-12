## CI-Utils

CI-Utils is a set of utilities for working on continuous integration platforms.

If the `CI` environmental variable is set, then `:ci` is added to `*features*`.
Otherwise, `:not-ci` is added.
In addition, the following platforms are recognized and supported.
If `CI` is set but the platform is unknown, then `:unknown-ci` is added to `*features*`.
|-----------|------------|--------|
| Platform  |  Feature   | Tested |
| Travis CI | :travis-ci | [![Build Status](https://travis-ci.org/neil-lindquist/CI-Utils.svg?branch=master)](https://travis-ci.org/neil-lindquist/CI-Utils) |
| Circle CI | :circle-ci |   No   |
| Appveyor  | :appveyor  |   No   |
| GitLab CI | :gitlab-ci |   No   |
