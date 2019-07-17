(uiop:define-package :ci-utils
  (:use :cl)
  (:export #:cip
           #:platform
           #:build-dir
           #:branch
           #:is-pr

           #:unknown-ci-platform

           #:load-project-systems))

(in-package :ci-utils)


(define-condition unknown-ci-platform ()
  ()
  (:report "Not running on a known CI platform"))

(defun cip ()
  "Whether lisp is running on a CI platform."
  #+ci t
  #-ci nil)

(defun platform ()
  "Returns the current CI platform."
  #+travis-ci :travis-ci
  #+circleci :circleci
  #+appveyor :appveyor
  #+gitlab-ci :gitlab-ci
  #+(or not-ci unknown-ci) (error 'unknown-ci-platform))

(defun build-dir ()
  "Returns the directory that the code was copied into"
  #+travis-ci (uiop:getenv "TRAVIS_BUILD_DIR")
  #+circleci (uiop:getenv "CIRCLE_WORKING_DIRECTORY")
  #+appveyor (string-upcase (uiop:getenv "APPVEYOR_BUILD_FOLDER") :end 1)
  #+gitlab-ci (uiop:getenv "CI_PROJECT_DIR")
  #+(or not-ci unknown-ci) (restart-case (error 'unknown-ci-platform)
                             (use-value (value) value)
                             (use-cwd () (uiop:getcwd))))


(defun is-pr ()
  "Returns whether the build is for a pull/merge request"
  #+travis-ci (not (string= "false" (uiop:getenv "TRAVIS_PULL_REQUEST")))
  #+circleci (not (null (uiop:getenvp "CIRCLE_PULL_REQUESTS")))
  #+appveyor (not (null (uiop:getenvp "APPVEYOR_PULL_REQUEST_NUMBER")))
  #+gitlab-ci (not (null (uiop:getenvp "CI_MERGE_REQUEST_ID")))
  #+(or not-ci unknown-ci) nil)

(defun branch ()
  "Returns the name of the branch the build is from."
  #+travis-ci (uiop:getenv "TRAVIS_BRANCH")
  #+circleci (uiop:getenv "CIRCLE_BRANCH")
  #+appveyor (uiop:getenv "APPVEYOR_REPO_BRANCH")
  #+gitlab-ci (uiop:getenv "CI_COMMIT_REF_NAME")
  #+(or not-ci unknown-ci) (error 'unknown-ci-platform))


(defun load-project-systems (&key force)
  "Loads the root project in each asd file in the build directory."
  ; Derived from Eitaro Fukamachi's cl-coveralls under the BSD 2-Clause License
  ; https://github.com/fukamachi/cl-coveralls/blob/master/src/cl-coveralls.lisp
  ; See NOTICES.md for a copy of the license
  (loop for file in (uiop:directory-files
                      (uiop:ensure-directory-pathname
                        (build-dir)))
      when (string= (pathname-type file) "asd")
        do (let ((system-name (pathname-name file)))
             #+quicklisp(if (asdf:component-loaded-p system-name)
                          (asdf:load-system system-name :force force)
                          (ql:quickload system-name))
             #-quicklisp (asdf:load-system system-name :force force))))
