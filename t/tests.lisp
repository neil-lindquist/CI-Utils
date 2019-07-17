
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
          (pull-request-p))))

(test :circleci-tests
  (is-true (member :circleci *features*))
  (is-false (member :travis-ci *features*))
  (is (eq :circleci (platform)))
  (is (string= (uiop:getenv "CIRCLE_BRANCH") (branch)))
  (is (eq (not (null (uiop:getenvp "CIRCLE_PULL_REQUEST")))
          (pull-request-p))))

(test :appveyor-tests
  (is-true (member :appveyor *features*))
  (is-false (member :circleci *features*))
  (is (eq :appveyor (platform)))
  (is (string= (uiop:getenv "APPVEYOR_REPO_BRANCH") (branch)))
  (is (eq (not (null (uiop:getenvp "APPVEYOR_PULL_REQUEST_NUMBER")))
          (pull-request-p))))

(test :gitlab-ci-tests
  (is-true (member :gitlab-ci *features*))
  (is-false (member :circleci *features*))
  (is (eq :gitlab-ci (platform)))
  (is (string= (uiop:getenv "CI_COMMIT_REF_NAME") (branch)))
  (is (eq (not (null (uiop:getenvp "CI_MERGE_REQUEST_ID")))
          (pull-request-p))))

(test :user-tests
  (is-false (member :ci *features*))
  (is-false (member :unknown-ci *features*))
  (is-false (member :travis-ci *features*))

  (is-false (cip))
  (is-false (platform))
  (is (equal (uiop:getcwd) (build-dir)))
  (is-false (pull-request-p))
  (is-false (branch)))


(test :coveralls-tests
  (is-true (member :coveralls *features*))
  (is (equal '("t" "test-launcher.txt") (ci-utils/coveralls:coverage-excluded)))
  (is-true (ci-utils/coveralls:coverallsp)))

(test :noncoveralls-tests
  (is-false (member :coveralls *features*))
  (is-false (ci-utils/coveralls:coverallsp)))

(def-suite* :base-tests
  :description "The base tests.  These tests will fail on a non-CI platform")

(test *features*
  (is-true (member :ci *features*))
  (is-false (member :unknown-ci *features*)))

(test predicates
  (is-true (cip)))

(test build-dir
  (is (equal (uiop:getcwd) (truename (build-dir)))))
