
(uiop:define-package :tests
  (:use :cl
        :ci-utils
        :fiveam))
(in-package :tests)


(test :travis-tests
  (is-true (member :travis-ci *features*))
  (is (eq :travis-ci (service)))
  (is (string= (uiop:getenv "TRAVIS_BUILD_DIR") (build-dir))))


(test :user-tests
  (is-true (member :not-ci *features*))
  (signals unknown-ci-platform (service))
  (signals unknown-ci-platform (build-dir)))

(def-suite* :base-tests
  :description "The base tests.  These tests will fail on a non-CI platform")

(test load-project-systems
  (load-project-systems)
  (load-project-systems :force t)

  ;ensure re-adding the system doesn't spam features
  (is (= 1 (count (service) *features*))))
