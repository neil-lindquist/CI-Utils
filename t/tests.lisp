
(uiop:define-package :tests
  (:use :cl
        :ci-utils
        :fiveam))
(in-package :tests)


(test :travis-tests
  #+cmu (format t "features = ~S~%" *features*)
  (is-true (member :travis-ci *features*))
  (is-false (member :circleci *features*))
  (is (eq :travis-ci (service)))
  (is (string= (uiop:getenv "TRAVIS_BUILD_DIR") (build-dir))))

(test :circleci-tests
  (is-true (member :circleci *features*))
  (is-false (member :travis-ci *features*))
  (is (eq :circleci (service)))
  (is (string= (uiop:getenv "CIRCLE_WORKING_DIRECTORY") (build-dir))))

(test :appveyor-tests
  (is-true (member :appveyor *features*))
  (is-false (member :circleci *features*))
  (is (eq :appveyor (service)))
  (is (string= (uiop:getenv "APPVEYOR_BUILD_FOLDER") (build-dir))))

(test :user-tests
  (is-true (member :not-ci *features*))
  (is-false (member :ci *features*))
  (signals unknown-ci-platform (service))
  (signals unknown-ci-platform (build-dir)))


(test :coveralls-tests
  (is-true (member :coveralls *features*))
  (is (equal '("tests" "test-launcher.txt") (coverage-excluded))))

(test :noncoveralls-tests
  (is-false (member :coveralls *features*)))

(def-suite* :base-tests
  :description "The base tests.  These tests will fail on a non-CI platform")

(test load-project-systems
  (is-true (member :ci *features*))
  (is-false (member :not-ci *features*))
  (is-false (member :unknown-ci *features*))

  (load-project-systems)
  (load-project-systems :force t)

  ;ensure re-adding the system doesn't spam features
  (is (= 1 (count (service) *features*))))
