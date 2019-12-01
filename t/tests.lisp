
(uiop:define-package :tests
  (:use :cl
        :ci-utils
        :fiveam))
(in-package :tests)


(test :travis-tests
  (is-true (member :travis-ci *features*))
  (is-false (member :circleci *features*))
  (is (eq :travis-ci (platform)))
  (is (string= (uiop:getenv "TRAVIS_BRANCH") (branch)))
  (is (eq (uiop:getenvp "TRAVIS_PULL_REQUEST_BRANCH")
          (pull-request-p))))

(test :circleci-tests
  (is-true (member :circleci *features*))
  (is-false (member :travis-ci *features*))
  (is (eq :circleci (platform)))
  (is (string= (uiop:getenv "CIRCLE_BRANCH") (branch)))
  (is (eq (uiop:getenvp "CIRCLE_PULL_REQUEST")
          (pull-request-p))))

(test :appveyor-tests
  (is-true (member :appveyor *features*))
  (is-false (member :circleci *features*))
  (is (eq :appveyor (platform)))
  (is (string= (uiop:getenv "APPVEYOR_REPO_BRANCH") (branch)))
  (is (eq (uiop:getenvp "APPVEYOR_PULL_REQUEST_NUMBER")
          (pull-request-p))))

(test :gitlab-ci-tests
  (is-true (member :gitlab-ci *features*))
  (is-false (member :circleci *features*))
  (is (eq :gitlab-ci (platform)))
  (is (string= (uiop:getenv "CI_COMMIT_REF_NAME") (branch)))
  (is (eq (uiop:getenvp "CI_MERGE_REQUEST_ID")
          (pull-request-p))))

(test :bitbucket-pipelines-tests
  (is-true (member :bitbucket-pipelines *features*))
  (is-false (member :circleci *features*))
  (is (eq :bitbucket-pipelines (platform)))
  (is (string= (uiop:getenv "BITBUCKET_BRANCH") (branch)))
  (is (eq (uiop:getenvp "BITBUCKET_PR_ID")
          (pull-request-p))))

(test :azure-pipelines-tests
  (is-true (member :azure-pipelines *features*))
  (is-false (member :circleci *features*))
  (is (eq :azure-pipelines (platform)))
  (is (string= (uiop:getenv "BUILD_SOURCEBRANCHNAME") (branch)))
  (is (eq (uiop:getenvp "SYSTEM_PULLREQUEST_PULLREQUESTID")
          (pull-request-p))))

(test :github-actions-tests
  (is-true (member :github-actions *features*))
  (is-false (member :circleci *features*))
  (is (eq :github-actions  (platform)))
  (is (string= (subseq (uiop:getenv "GITHUB_REF") 11) (branch)))
  (is (eq (string= "pull_request" (uiop:getenvp "GITHUB_EVENT_NAME"))
          (pull-request-p))))

(test :base-tests
  (is-true (member :ci *features*))
  (is-false (member :unknown-ci *features*))
  (is-true (cip))
  (is (equal (uiop:getcwd) (truename (build-dir)))))


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
