(cl:in-package #:clordecone)

(defun debugger-invoke-restart (name stream condition)
  (let ((restart (find-restart name condition)))
    (if restart
        (invoke-restart-interactively restart)
        (format stream "~&;; There is no active ~A restart.~%" name))))
