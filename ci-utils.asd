
(defsystem "ci-utils"
  :description "A set of tools for using CI platforms"
  :version "1.0.0"
  :author "Neil Lindquist <NeilLindquist5@gmail.com>"
  :license "MIT"
  :depends-on ("ci-utils-features")
  :pathname "src"
  :serial t
  :components ((:file "ci-utils"))
  :in-order-to ((test-op (test-op "ci-utils/test"))))

(defsystem "ci-utils/coveralls"
  :description "A set of tools for using CI platforms"
  :version "1.0.0"
  :author "Neil Lindquist <NeilLindquist5@gmail.com>"
  :license "MIT"
  :defsystem-depends-on ("ci-utils-features")
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
               "fiveam"
               "split-sequence")
  :pathname "t"
  :components ((:file "tests"))
  :perform (test-op (o c) (symbol-call '#:fiveam '#:run! '(:user-tests
                                                           :noncoveralls-tests))))

(defsystem "ci-utils/utils"
  :description "Extra utilities for CI-Utils roswell scripts"
  :license "MIT"
  :depends-on ("ci-utils")
  :pathname "src"
  :serial t
  :components ((:file "utils")))

