
(uiop:define-package :tests
  (:use :cl
        :ci-utils
        :fiveam))
(in-package :tests)


(test :travis-tests
  #+cmu (format t "features = ~S~%" *features*)
  (is-true (member :travis-ci *features*))
  (is-false (member :circleci *features*))
  (is (eq :travis-ci (platform)))
  (is (string= (uiop:getenv "TRAVIS_BRANCH") (branch)))
  (is (eq (not (null (uiop:getenvp "TRAVIS_PULL_REQUEST_BRANCH")))
          (is-pr))))

(test :circleci-tests
  (is-true (member :circleci *features*))
  (is-false (member :travis-ci *features*))
  (is (eq :circleci (platform)))
  (is (string= (uiop:getenv "CIRCLE_BRANCH") (branch)))
  (is (eq (not (null (uiop:getenvp "CIRCLE_PULL_REQUEST")))
          (is-pr))))

(test :appveyor-tests
  (is-true (member :appveyor *features*))
  (is-false (member :circleci *features*))
  (is (eq :appveyor (platform)))
  (is (string= (uiop:getenv "APPVEYOR_REPO_BRANCH") (branch)))
  (is (eq (not (null (uiop:getenvp "APPVEYOR_PULL_REQUEST_NUMBER")))
          (is-pr))))

(test :user-tests
  (is-true (member :not-ci *features*))
  (is-false (member :ci *features*))
  (is-false (member :unknown-ci *features*))
  (is-false (member :travis-ci *features*))

  (signals unknown-ci-platform (platform))
  (signals unknown-ci-platform (build-dir))
  (is-false (is-pr))
  (signals unknown-ci-platform (branch)))


(test :coveralls-tests
  (is-true (member :coveralls *features*))
  (is (equal '("t" "test-launcher.txt") (ci-utils/coveralls:coverage-excluded))))

(test :noncoveralls-tests
  (is-false (member :coveralls *features*)))

(def-suite* :base-tests
  :description "The base tests.  These tests will fail on a non-CI platform")

(test *features*
  (is-true (member :ci *features*))
  (is-false (member :not-ci *features*))
  (is-false (member :unknown-ci *features*)))

(test build-dir
  (is (equal (uiop:getcwd) (truename (build-dir)))))

(test load-project-systems
  ; mainly just check that they don't crash
  (load-project-systems)
  (load-project-systems :force t)

  ;ensure re-adding the system doesn't spam features
  (is (= 1 (count (platform) *features*))))
