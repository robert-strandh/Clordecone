(cl:in-package #:clordecone)

(define-command :continue (stream condition)
  (debugger-invoke-restart 'continue stream condition))

(define-command :c (stream condition)
  (debugger-invoke-restart 'continue stream condition))
