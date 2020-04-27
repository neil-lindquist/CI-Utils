(uiop:define-package :ci-utils/utils
  (:use :cl)
  (:export #:quickload #:with-fail-on-errors #:without-asdf-bad-system))

(in-package :ci-utils/utils)

(defmacro with-fail-on-errors ((&key (code 123)) &body body)
  "print a stack trace and then exit with CODE when BODY signals
  any error"
  `(handler-bind ((error (lambda (&optional e)
                           (format t "caught error ~s~%~a~%" e e)
                           (uiop:print-condition-backtrace
                            e :stream *standard-output*)
                           (finish-output)
                           (uiop:quit ,code))))
     (progn ,@body)))

(defmacro without-asdf-bad-system (() &body body)
  "run BODY, with ASDF:BAD-SYSTEM-NAME condition muffled if it exists"
  `(handler-bind (#+asdf3.2 (asdf:bad-SYSTEM-NAME
                              (function MUFFLE-WARNING)))
     (progn ,@body)))

(defun quickload (systems &rest keys
                  &key (fail-on-error t) (ignore-bad-systems t)
                  &allow-other-keys)
  (remf keys :fail-on-error)
  (remf keys :ignore-bad-systems)
  (flet ((ibs ()
           (if ignore-bad-systems
               (without-asdf-bad-system ()
                 (apply #'ql:quickload systems keys))
               (apply #'ql:quickload systems keys))))
    (if fail-on-error
        (with-fail-on-errors (:code (if (numberp fail-on-error)
                                        fail-on-error
                                        123))
          (ibs))
        (ibs))))
