(uiop:define-package :ci-utils
  (:use :cl)
  (:export #:cip
           #:platform
           #:build-dir
           #:branch
           #:pull-request-p))

(in-package :ci-utils)

(defun cip ()
  "Whether lisp is running on a CI platform."
  #+ci t
  #-ci nil)

(defun platform ()
  "Returns the current CI platform.  When on a non-ci platform, nil is returned."
  #+travis-ci :travis-ci
  #+circleci :circleci
  #+appveyor :appveyor
  #+gitlab-ci :gitlab-ci
  #+bitbucket-pipelines :bitbucket-pipelines
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
  #+(or (not ci) unknown-ci) (uiop:getcwd))


(defun pull-request-p ()
  "Returns whether the build is for a pull/merge request.  Unknown and non-ci
   platforms are considered to not be pull requests."
  #+travis-ci (not (string= "false" (uiop:getenv "TRAVIS_PULL_REQUEST")))
  #+circleci (not (null (uiop:getenvp "CIRCLE_PULL_REQUESTS")))
  #+appveyor (not (null (uiop:getenvp "APPVEYOR_PULL_REQUEST_NUMBER")))
  #+gitlab-ci (not (null (uiop:getenvp "CI_MERGE_REQUEST_ID")))
  #+bitbucket-pipelines (not (null (uiop:getenvp "BITBUCKET_PR_ID")))
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
  #+(or (not ci) unknown-ci) nil)
