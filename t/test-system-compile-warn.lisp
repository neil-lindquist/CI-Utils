(defpackage :ci-utils-test-system-compile-warn
  (:use :cl))
(in-package :ci-utils-test-system-compile-warn)

(eval-when (:compile-toplevel)
  (warn "compilation warning!"))

