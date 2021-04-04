(defpackage :ci-utils-test-system-load-warn
  (:use :cl))
(in-package :ci-utils-test-system-load-warn)

(warn "load-time warning!")

