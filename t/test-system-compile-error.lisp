(defpackage :ci-utils-test-system-compile-error
  (:use :cl))
(in-package :ci-utils-test-system-compile-error)

(eval-when (:compile-toplevel)
  (error "compilation failed!"))

