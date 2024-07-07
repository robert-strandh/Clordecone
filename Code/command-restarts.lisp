(cl:in-package #:clordecone)

(defun restart-max-name-length (restarts)
  (flet ((name-length (restart) (length (string (restart-name restart)))))
    (if restarts (reduce #'max (mapcar #'name-length restarts)) 0)))

(define-command :restarts (stream condition)
  (let ((restarts (compute-restarts condition)))
    (cond (restarts
           (format stream "~&;; Available restarts:~%")
           (loop with max-name-length = (restart-max-name-length restarts)
                 for i from 0
                 for restart in restarts
                 for report = (handler-case (princ-to-string restart)
                                (error () "#<error while reporting restart>"))
                 for restart-name = (or (restart-name restart) "")
                 do (format stream ";; ~2,' D: [~vA] ~A~%"
                            i max-name-length restart-name report)))
          (t (format stream "~&;; No available restarts.~%")))))
