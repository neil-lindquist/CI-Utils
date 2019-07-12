
(defsystem "ci-utils-features"
  :description "An internal system that loads the features before loading the rest of the systems"
  :author "Neil Lindquist <NeilLindquist5@gmail.com>"
  :license "MIT"
  :pathname "src"
  :components ((:file "features")))
