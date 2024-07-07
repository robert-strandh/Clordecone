(cl:in-package #:clordecone)

(define-command :restart (stream condition &optional n)
  (let* ((n (or n (read stream)))
         (restart (nth n (compute-restarts condition))))
    (if restart
        (invoke-restart-interactively restart)
        (format stream "~&;; There is no restart with number ~D.~%" n))))
