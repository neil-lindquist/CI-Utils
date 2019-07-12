
(defsystem "ci-utils"
  :description "A set of tools for using CI platforms"
  :version "0.0.0"
  :author "Neil Lindquist <NeilLindquist5@gmail.com>"
  :license "MIT"
  :pathname "src"
  :serial t
  :components ((:file "features")
               (:file "ci-utils"))
  :in-order-to ((test-op (test-op "ci-utils/test"))))

(defsystem "ci-utils/coveralls"
  :description "A set of tools for using CI platforms"
  :version "0.0.0"
  :author "Neil Lindquist <NeilLindquist5@gmail.com>"
  :license "MIT"
  :defsystem-depends-on ("ci-utils")
  :depends-on ("ci-utils"
               (:feature :coveralls "cl-coveralls")
               "split-sequence")
  :pathname "src"
  :serial t
  :components ((:file "coveralls")))


(defsystem "ci-utils/test"
  :description "Test for CI-Utils"
  :author "Neil Lindquist <NeilLindquist5@gmail.com>"
  :license "MIT"
  :depends-on ("ci-utils"
               "ci-utils/coveralls"
               "fiveam")
  :pathname "t"
  :components ((:file "tests"))
  :perform (test-op (o c) (symbol-call '#:fiveam '#:run! :user-tests)))
