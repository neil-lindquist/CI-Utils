(uiop:define-package :ci-utils
  (:use :cl)
  (:export #:cip
           #:platform
           #:build-dir
           #:build-id
           #:pull-request-p
           #:branch
           #:commit-id))

(in-package :ci-utils)

(defun cip ()
  "Whether lisp is running on a CI platform."
  #+ci t
  #-ci nil)

(defun platform ()
  "Returns the current CI platform.  When on a non-ci platform, nil is returned.
The following is the symbols for supported platforms

|      Platform       |       Symbol Name      |
|:-------------------:|:----------------------:|
|      Travis CI      |      `:TRAVIS-CI`      |
|      Circle CI      |      `:CIRCLECI`      |
|      Appveyor       |      `:APPVEYOR`       |
|      GitLab CI      |      `:GITLAB-CI`      |
| Bitbucket Pipelines | `:BITBUCKET-PIPELINES` |
|   Azure Pipelines   |   `:AZURE-PIPELINES`   |
|    Github Actions   |    `:GITHUB-ACTIONS`   |
| unknown ci systems  |      `:UNKNOWN-CI`     |
"
  #+travis-ci :travis-ci
  #+circleci :circleci
  #+appveyor :appveyor
  #+gitlab-ci :gitlab-ci
  #+bitbucket-pipelines :bitbucket-pipelines
  #+azure-pipelines :azure-pipelines
  #+github-actions :github-actions
  #+unknown-ci :unknown-ci
  #-ci nil)

(defun build-dir ()
  "Returns the directory that the code was copied into.  When not on a known CI
   platform, the current working directory is returned."
  #+travis-ci (uiop:getenv "TRAVIS_BUILD_DIR")
  #+circleci (uiop:getenv "CIRCLE_WORKING_DIRECTORY")
  #+appveyor (string-upcase (uiop:getenv "APPVEYOR_BUILD_FOLDER") :end 1)
  #+gitlab-ci (uiop:getenv "CI_PROJECT_DIR")
  #+bitbucket-pipelines (uiop:getenv "BITBUCKET_CLONE_DIR")
  #+azure-pipelines (uiop:getenv "BUILD_SOURCESDIRECTORY")
  #+github-actions (uiop:getenv "GITHUB_WORKSPACE")
  #+(or (not ci) unknown-ci) (uiop:getcwd))

(defun build-id ()
  "Returns the build id for the given platform. `NIL` is returned on unsupported
   platforms."
  #+travis-ci (uiop:getenv "TRAVIS_JOB_ID")
  #+circleci (uiop:getenv "CIRCLE_BUILD_NUM")
  #+appveyor (uiop:getenv "APPVEYOR_JOB_ID")
  #+gitlab-ci (uiop:getenv "CI_BUILD_ID")
  #+bitbucket-pipelines (uiop:getenv "BITBUCKET_BUILD_NUMBER")
  #+azure-pipelines (uiop:getenv "BUILD_BUILDID")
  #+github-actions (if (pull-request-p) ; Based on the coveralls action
                     (commit-id)
                     (concatenate 'string (commit-id) "-PR-" (pull-request-p)))
  #+(or (not ci) unknown-ci) nil)

(defun pull-request-p ()
  "Returns whether the build is for a pull/merge request.  Unknown and non-ci
   platforms are considered to not be pull requests.  A string containing the
   pull request number is returned for pull requests"
  #+travis-ci (unless (string= "false" (uiop:getenv "TRAVIS_PULL_REQUEST"))
                (uiop:getenvp "TRAVIS_PULL_REQUEST"))
  #+circleci (uiop:getenvp "CIRCLE_PULL_REQUESTS")
  #+appveyor (uiop:getenvp "APPVEYOR_PULL_REQUEST_NUMBER")
  #+gitlab-ci (uiop:getenvp "CI_MERGE_REQUEST_ID")
  #+bitbucket-pipelines (uiop:getenvp "BITBUCKET_PR_ID")
  #+azure-pipelines (uiop:getenvp "SYSTEM_PULLREQUEST_PULLREQUESTID")
  #+github-actions (when (string= "pull_request" (uiop:getenvp "GITHUB_EVENT_NAME"))
                     (let ((ref-name (uiop:getenv "GITHUB_REF")))
                       (subseq ref-name 10 (- (length ref-name) 6))))
  #+(or (not ci) unknown-ci) nil)

(defun branch ()
  "Returns the name of the branch the build is from, or `NIL` for unknown and
   non-ci platforms."
  #+travis-ci (uiop:getenvp "TRAVIS_BRANCH")
  #+circleci (uiop:getenvp "CIRCLE_BRANCH")
  #+appveyor (uiop:getenvp "APPVEYOR_REPO_BRANCH")
  #+gitlab-ci (uiop:getenvp "CI_COMMIT_REF_NAME")
  #+bitbucket-pipelines (or (uiop:getenvp "BITBUCKET_BRANCH")
                            (uiop:getenvp "BITBUCKET_TAG"))
  #+azure-pipelines (uiop:getenvp "BUILD_SOURCEBRANCHNAME")
  #+github-actions (subseq (uiop:getenv "GITHUB_REF") 11)
  #+(or (not ci) unknown-ci) nil)

(defun commit-id ()
  "Returns the ID of the current commit.  For git projects, this is the commit's
   SHA. `NIL` is returned on unsupported platforms."
  #+travis-ci (uiop:getenv "TRAVIS-COMMIT")
  #+circleci (uiop:getenv "CIRCLE-SHA1")
  #+appveyor (uiop:getenv "APPVEYOR_REPO_COMMIT")
  #+gitlab-ci (uiop:getenv "CI_COMMIT_SHA")
  #+bitbucket-pipelines (uiop:getenv "BITBUCKET_COMMIT")
  #+azure-pipelines (uiop:getenv "BUILD_SOURCEVERSION")
  #+github-actions (uiop:getenv "GITHUB_SHA")
  #+(or (not ci) unknown-ci) nil)
