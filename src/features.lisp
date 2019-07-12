;;; Push the new features

#. (pushnew (if (uiop:getenvp "CI")
              :ci
              :not-ci)
            *features*)

#. #+ci (pushnew (cond
                   ((uiop:getenvp "TRAVIS") :travis-ci)
                   ((uiop:getenvp "CIRCLECI") :circleci)
                   ((uiop:getenvp "APPVEYOR") :appveyor)
                   ((uiop:getenvp "GITLAB_CI") :gitlab-ci)
                   (t :unknown-ci))
                 *features*)
