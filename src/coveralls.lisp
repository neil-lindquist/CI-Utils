(uiop:define-package :ci-utils/coveralls
  (:use :cl
        :ci-utils)
  (:export #:coverallsp
           #:with-coveralls
           #:coverage-excluded))

(in-package :ci-utils/coveralls)


(defun coverallsp ()
  "Whether the current systems has the `COVERALLS` environmental variable set"
  #+coveralls t
  #-coveralls nil)

(defmacro with-coveralls (exclude &body body)
  "Wraps the body with the `coveralls:with-coveralls` macro if coveralls is enabled"
  (declare (ignorable exclude))
  #+coveralls `(coveralls:with-coveralls (:exclude ,exclude)
                 ,@body)
  #-coveralls `(progn
                 ,@body))

(defun coverage-excluded ()
  "Gets the contents of the COVERAGE_EXCLUDED environemental variable as a list
   of path strings"
  ; Copied from Eitaro Fukamachi's run-prove under the MIT license
  ; https://github.com/fukamachi/prove/blob/master/roswell/run-prove.ros
  ; See NOTICE.md for a copy of the license text
  (split-sequence:split-sequence #\:
                                 (or (uiop:getenvp "COVERAGE_EXCLUDE") "")
                                 :remove-empty-subseqs t))
