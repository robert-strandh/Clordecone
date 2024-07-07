(cl:in-package #:clordecone)

(define-command :report (stream condition &optional (level *debug-level*))
  (format stream "~&;; Debugger level ~D entered on ~S:~%"
          level (type-of condition))
  (handler-case (let* ((report (princ-to-string condition))
                       (lines (split-sequence:split-sequence
                               #\Newline report :remove-empty-subseqs t)))
                  (format stream "~&~{;; ~A~%~}" lines))
    (error () (format stream "~&;; #<error while reporting condition>~%"))))
