(in-package #:clordecone)

(defun read-eval-print-command (stream condition)
  (format stream "~&[~D] Debug> "*debug-level*)
  (let* ((thing (read stream)))
    (multiple-value-bind (values actual-thing)
        (typecase thing
          (keyword (run-debugger-command thing stream condition))
          (integer (run-debugger-command :restart stream condition thing))
          (t (run-debugger-command :eval stream condition thing)))
      (unless actual-thing (setf actual-thing thing))
      (prog1 values
        (shiftf /// // / values)
        (shiftf *** ** * (first values))
        (shiftf +++ ++ + actual-thing)))))

(defun debugger (condition &optional (stream *debug-io*))
  (let ((*debug-level* (1+ *debug-level*)))
    (run-debugger-command :report stream condition)
    (format stream "~&;; Type :HELP for available commands.~%")
    (loop (read-eval-print-command stream condition))))
