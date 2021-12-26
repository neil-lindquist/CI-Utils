(defpackage :ci-utils-test-system
  (:use :cl)
  (:export #:return-nil #:return-t #:return-x #:return-not-x))
(in-package :ci-utils-test-system)

(defun return-nil ()
  nil)

(defun return-t ()
  t)

(defun return-x (x)
  x)

(defun return-not-x (x)
  (not x))
