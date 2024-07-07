(cl:in-package #:clordecone)

(define-command :condition (stream condition)
  (run-debugger-command :eval stream condition condition))
