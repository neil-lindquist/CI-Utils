;; various systems that load code that errors, warns, etc for making
;; sure they cause CI tests to fail

(defsystem ci-utils-test-systems
  :depends-on ()
  :components ((:file "test-system")))

(defsystem ci-utils-test-systems/dep-error
  :depends-on (ci-utils-test-systems/missing-system)
  :components ())


(defsystem ci-utils-test-systems/compile-error
  :depends-on (ci-utils-test-systems)
  :components ((:file "test-system-compile-error")))

(defsystem ci-utils-test-systems/compile-warn
  :depends-on (ci-utils-test-systems)
  :components ((:file "test-system-compile-warn")))

(defsystem ci-utils-test-systems/dep-compile-error
  :depends-on (ci-utils-test-systems/compile-error)
  :components ())


(defsystem ci-utils-test-systems/load-error
  :depends-on (ci-utils-test-systems)
  :components ((:file "test-system-load-error")))

(defsystem ci-utils-test-systems/load-warn
  :depends-on (ci-utils-test-systems)
  :components ((:file "test-system-load-warn")))

(defsystem ci-utils-test-systems/dep-load-error
  :depends-on (ci-utils-test-systems/load-error)
  :components ())

