(cl:in-package #:clordecone)

(defmacro define-command (name (stream condition &rest arguments) &body body)
  (check-type name keyword)
  (let ((command-var (gensym "COMMAND"))
        (arguments-var (gensym "ARGUMENTS")))
    (multiple-value-bind (real-body declarations documentation)
        (alexandria:parse-body body :documentation t)
      `(defmethod run-debugger-command
           ((,command-var (eql ,name)) ,stream ,condition &rest ,arguments-var)
         ,@(when documentation `(,documentation))
         ,@declarations
         (destructuring-bind ,arguments ,arguments-var ,@real-body)))))
