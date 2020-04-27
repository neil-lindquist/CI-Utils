(defpackage :ci-utils-test-system-load-error
  (:use :cl))
(in-package :ci-utils-test-system-load-error)

(error "load failed!")

