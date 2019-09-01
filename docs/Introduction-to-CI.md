---
layout: page
title: Introduction to CI Testing
meta-description: A primer for testing Common Lisp libraries on Cloud CI platforms
---

Continuous Integration (CI) is the method of running tests, building binaries, and similar task after most committed modifications of a codebase, usually on a cloud platform or internal server for the project.
This allows a project to ensure its tests are run regularly, and makes it obvious whenever the a change causes tests to break.
Other tasks, such as building binaries or updating documentation can reduce the workload of developers while still maintaining those artifacts.
The approach of continuous integration offers benefits to any project that has a series of steps taken after most (or specific types of) changes to the codebase.
This introduction focuses more on running tests since that is the use case for most projects; however, the ideas and most of the tooling generalizes to other tasks.


A quick note on styling, because uppercase I and lowercase L can look similar, the abbreviations CI and CL can look similar.
To address this, a convention is used that both letters in these acronyms should always be the same case (i.e. CI means Continuous Integration, while Cl will never be used).


Technically, the phrase "Continuous Integration" originally referred to integrating each developer's working copy of a codebase into the master copy on a regular basis to ensure that integrating the various changes doesn't become a monumental task.
However, the phrase continuous integration more often used to describe automating scripts to run after changes to a codebase, and is used as such in this document and project.
Some people use terms like "Continuous Deployment" and "Continuous Testing", especially if they want to emphasize a particular action that's taken (e.g. deployment and testing respectively).


### Configuration Basics

The rise of continuous integration tools for small and medium sized projects has been part of the rise of cloud computing and software as a service.
There are a variety of cloud platforms that provide CI services; however, they all follow similar ideas for configuration and usage.
The main method for configuring these platforms is to include a [YAML](https://yaml.org/) configuration file in the root directory of the repository named `.platform.yml` (i.e. `.travis.yml`).
Some platforms have a different naming convention, or allow custom names.
You can find example configuration files for most of CI-Util's supported platforms in its [config-examples](https://github.com/neil-lindquist/CI-Utils/tree/master/config-examples) directory.

The term "build" is used to describe the entire set of scripts and actions that are run after a commit.
Each build consists of a set of "jobs".
The jobs divide the scripts and actions between separate containers.
When running tests, each job will run the tests for one system configuration, such as a combination of lisp implementation and operating system.
If any of the commands in a job fails (by having a non-zero return value), the entire job is marked as a failure and terminated.
Similarly, if any jobs fail, the entire build is marked as a failure.
This propagation of failures helps make it easy to determine if everything was successful.

There are a couple of ways to keep an eye on the status of your builds.
First, email notifications can be enabled, so that the results of builds are sent to one or more addresses.
Usually, the frequency can be adjusted so that emails are only sent if the build fails, or if there is a change in the build's status.
How notifications are configured and the types of notifications that are supported vary between platforms.
The second main method to monitor build statuses is through badges on the repository's webpage or in it's README.
For example, consider the live badge for CI-Utils on Travis CI: [![Travis Build Status](https://img.shields.io/travis/neil-lindquist/ci-utils.svg?logo=Travis)](https://travis-ci.org/neil-lindquist/CI-Utils), which hopefully tells you that the last build on Travis CI for CI-Utils passed.
These badges are primarily used to show the status of tests, since they provide a convenient way to show people looking at the repository that there are tests that are run regularly, and whether those tests are passing.

Some commits don't contain changes that require a new CI build.
There are two major ways to tell CI platforms that the commit shouldn't be build.
The first is to limit the branches and tags that CI should be run for, often specific jobs can be disabled outside specific branches/tags.
This is specified in the configuration file, and varies significantly between platforms.
Branch and tag limitations are primarily for limiting actions like building binaries or deploying documentation, which shouldn't happen on every commit.
The second is to skip CI for a specific commit.
To skip building on every platform, add `[skip ci]` to the commit's message.
Alternatively, if CI should be skipped on only some platforms, most platforms obey `[skip <platform>]` in the commit message.
