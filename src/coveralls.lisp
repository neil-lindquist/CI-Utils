(uiop:define-package :ci-utils/coveralls
  (:use :cl
        :ci-utils)
  (:export #:with-coveralls
           #:coverage-excluded))

(in-package :ci-utils/coveralls)


(defmacro with-coveralls (exclude &rest body)
  "Wraps the body with the `coveralls:with-coveralls` macro if coveralls is enabled"
  #+coveralls `(coveralls:with-coveralls (:exclude ,exclude)
                 ,@body)
  #-coveralls`(progn
                ; Need to manually load the local repository when not using coveralls
                (ci-utils:load-project-systems)
                ,@body))

(defun coverage-excluded ()
  "Gets the contents of the COVERAGE_EXCLUDED environemental variable as a list
   of path strings"
  ; Copied from Eitaro Fukamachi's run-prove under the MIT license
  ; https://github.com/fukamachi/prove/blob/master/roswell/run-prove.ros
  ; See NOTICE.md for a copy of the license text
  (split-sequence:split-sequence #\:
                                 (or (uiop:getenv "COVERAGE_EXCLUDE") "")
                                 :remove-empty-subseqs t))
