There are a variety of CI platforms available today, so projects need to decide which platform or platforms to use.
I strongly recommend that, at least for tests, the CI scripts are run on as many Common Lisp implementations as possible, and on OSX and Windows in addition to Linux, to improve the portability of your project.
My basic recommendation for which CI platform to use is Travis CI for Linux and OSX and Appveyor for Windows.
These platforms are well documented and are commonly used platforms for open source projects.

Currently, CI-Utils supports 6 CI platforms, all of which have cloud hosting and free plans for open source software.
A brief description of each is listed below for comparison purposes.
If there is another platform that you are interested in, please raise a pull request or issue and we can work through adding support and documentation.

| Platform | OS | Supported Repository Hosts |
| -------- | -- | -------------------------- |
| [Travis CI](#travis-ci) | Linux, OSX | Github |
| [Appveyor](#appveyor) | Windows | Github, Bitbucket, Gitlab, Azure Repos, and more |
| [CircleCI](#circleci) | Linux, OSX (paid only) | Github, Bitbucket |
| [Azure Pipelines](#azure-pipelines) | Linux, OSX, Windows | Github, Bitbucket, Azure Repos, and more |
| [Gitlab CI](#gitlab-ci) | Linux | Gitlab, Github, Bitbucket, and more |
| [Bitbucket Pipelines](#bitbucket-pipelines) | Linux | Bitbucket |


### Travis CI
Travis CI is one of the oldest cloud hosted CI platforms, and thus is well documented and has plenty of examples.
Unfortunately, only Github repositories are supported.
Additionally, Travis only supports Linux and OSX, with OSX builds usually being slower due to a combination of limits on parallel jobs and homebrew needing to update a number of packages every time.
Notably, Travis allows 5 Linux jobs and 2 OSX jobs to be run in parallel.
Support for Windows is being developed; however, when tested, none of the Windows jobs were actually run.

Travis is free for public repositories.
Private repositories require payment (with a free trial).
Additionally, Travis CI Enterprise provides an option for self hosting, as well as other quality of life benefits.

### Appveyor
Appveyor is another popular CI platform, with a focus Windows.
It's oriented for development of native Windows code, but supports non-C/C++ projects just fine.
Support for Linux jobs is documented; however, when tested it immediately failed to create the folder for the build.
Appveyor supports a variety of repository hosts, allowing it to fit in many workflows.
Finally, Appveyor offers self hosting to all users.

Appveyor is free for public repositories and a single private repository.
Paid accounts provide unlimited private repositories and running jobs in parallel.

### CircleCI
CircleCI is designed for performance and effective management of computing resources.
Additionally, it provides the ability to run a single job multiple times in parallel.
This allows a test suite, or other work load, to be parallelized, either manually using the `CIRCLE_NODE_TOTAL` and `CIRCLE_NODE_INDEX` environmental variables or their `circleci tests split` command.

CircleCI provides a free plan with 1 Linux container for private projects as well as 4 Linux containers and 1 OSX container for public projects.
Note that parallel jobs use multiple containers (i.e. 2x parallelism results in each job using 2 containers).
Additionally, there are paid plans for increased numbers of containers, and a self hosted server.

### Azure Pipelines
Azure Pipelines is the CI service of Microsoft's Azure cloud computing offerings.
Azure pipelines is the only one of these platforms that successfully supports all three major operating systems.
Additionally, it is designed to integrate well with other Azure services.
Azure Pipelines offers both cloud hosted and self hosted servers.

Azure pipelines provides a free plan with 1 job at a time and up to 1,800 minutes per month for private projects, and 10 jobs in parallel for open source projects.
There are also paid plans that allow for running more jobs in parallel and more build time.


### Gitlab CI
Gitlab provides a CI platform right out of the box for both cloud hosted and self hosted instances of Gitlab, including [gitlab.common-lisp.net](https://gitlab.common-lisp.net).
Interestingly, Gitlab CI also allows, and even encourages, use of it's CI system for repositories not hosted in Gitlab, although this does involve a lightweight mirror of the repository.

The only limitation of Gitlab's free account for CI purposes is a limit of 2,000 minutes per month when using the cloud hosted instance, and no restrictions for self hosted instances.

### Bitbucket Pipelines
Bitbucket pipelines is Bitbucket's CI offering.
It doesn't provide any notable features compared to other platforms, but may be convenient for projects hosted on Bitbucket.

The free plan only provides 50 minutes, although users with an academic email are able to get 500 minutes for free.
Additionally, non-profit charities can apply for a community subscription that also provides 500 CI minutes.
