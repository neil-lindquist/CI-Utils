(defpackage :ci-utils-test-system-compile-warn
  (:use :cl))
(in-package :ci-utils-test-system-compile-warn)

(format t "loading~%")
(eval-when (:compile-toplevel)
  (format t "compiling~%")
  (warn "compilation warning!"))

