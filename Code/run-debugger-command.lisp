(cl:in-package #:clordecone)

(defgeneric run-debugger-command (command stream condition &rest arguments))

(defmethod run-debugger-command (command stream condition &rest arguments)
  (declare (ignore arguments))
  (format stream
          "~&;; ~S is not a recognized command.~@
           ;; Type :HELP for available commands.~%"
          command))
