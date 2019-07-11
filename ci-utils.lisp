(uiop:define-package :ci-utils
  (:use :cl)
  (:export #:service
           #:build-dir

           #:unknown-ci-platform

           #:load-project-systems))

(in-package :ci-utils)

; set platform feature
(pushnew (cond
           ((uiop:getenvp "TRAVIS") :travis-ci)
           (t :not-ci))
         *features*)

#-not-ci (pushnew :ci *features*)

(define-condition unknown-ci-platform ()
  ()
  (:report "Not running on a known CI platform"))

(defun service ()
  "Returns the CI service being used."
  #+travis-ci :travis-ci
  #+not-ci (error 'unknown-ci-platform))

(defun build-dir ()
  "Returns the directory that the code was copied into"
  #+travis-ci (uiop:getenv "TRAVIS_BUILD_DIR")
  #+not-ci (restart-case (error 'unknown-ci-platform)
             (use-value (value) value)))



; This loop is a derived from code in Eitaro Fukamachi's cl-coveralls
; Used under the BSD 2-Clause License
; https://github.com/fukamachi/cl-coveralls/blob/master/src/cl-coveralls.lisp
; See NOTICES.md for a copy of the license
(defun load-project-systems (&key force)
  "Loads the root project in each asd file in the build directory."
  (loop for file in (uiop:directory-files
                      (uiop:ensure-directory-pathname
                        (build-dir)))
      when (string= (pathname-type file) "asd")
        do (let ((system-name (pathname-name file)))
             #+quicklisp(if (asdf:component-loaded-p system-name)
                          (asdf:load-system system-name :force force)
                          (ql:quickload system-name))
             #-quicklisp (asdf:load-system system-name :force force))))
