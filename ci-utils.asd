
(defsystem "ci-utils"
  :description "A set of tools for using CI platforms"
  :version "0.0.0"
  :author "Neil Lindquist <NeilLindquist5@gmail.com>"
  :licence "MIT"
  :components ((:file "ci-utils"))
  :in-order-to ((test-op (test-op "ci-utils/test"))))

(defsystem "ci-utils/test"
  :description "Test for CI-Utils"
  :author "Neil Lindquist <NeilLindquist5@gmail.com>"
  :licence "MIT"
  :licence "MIT"
  :depends-on ("ci-utils"
               "fiveam")
  :components ((:file "tests"))
  :perform (test-op (o c) (symbol-call '#:fiveam '#:run! :user-tests)))
