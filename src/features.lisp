;;; Push the new features

(let ((ci (uiop:getenvp "CI")))
  (pushnew (if ci
             :ci
             :not-ci)
           *features*)
  (when ci
      (pushnew (cond
                 ((uiop:getenvp "TRAVIS") :travis-ci)
                 ((uiop:getenvp "CIRCLECI") :circleci)
                 ((uiop:getenvp "APPVEYOR") :appveyor)
                 ((uiop:getenvp "GITLAB_CI") :gitlab-ci)
                 (t :unknown-ci))
               *features*)))
