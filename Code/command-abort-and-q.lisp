(cl:in-package #:clordecone)

(define-command :abort (stream condition)
  (debugger-invoke-restart 'abort stream condition))

(define-command :q (stream condition)
  (debugger-invoke-restart 'abort stream condition))
