;;; Push the new features

(when (or (uiop:getenvp "CI")
          (uiop:getenv "TF_BUILD") ;special case for azure pipelines
          (uiop:getenvp "GITHUB_ACTIONS")) ;special case for github actions
  (pushnew :ci *features*)
  (pushnew (cond
             ((uiop:getenvp "TRAVIS") :travis-ci)
             ((uiop:getenvp "CIRCLECI") :circleci)
             ((uiop:getenvp "APPVEYOR") :appveyor)
             ((uiop:getenvp "GITLAB_CI") :gitlab-ci)
             ((uiop:getenvp "BITBUCKET_BUILD_NUMBER") :bitbucket-pipelines)
             ((string-equal "true" (uiop:getenv "TF_BUILD")) :azure-pipelines)
             ((uiop:getenvp "GITHUB_ACTIONS") :github-actions)
             (t :unknown-ci))
           *features*))

(when (uiop:getenvp "COVERALLS")
  (pushnew :coveralls *features*))
