(cl:in-package #:asdf-user)

(defsystem "clordecone"
  :depends-on ("alexandria" "split-sequence")
  :serial t
  :components
  ((:file "packages")
   (:file "run-debugger-command")
   (:file "define-command")
   (:file "debug-level")
   (:file "command-eval")
   (:file "command-report")
   (:file "command-condition")
   (:file "command-restarts")
   (:file "command-restart")
   (:file "debugger-invoke-restart")
   (:file "debugger")))
