(in-package #:clordecone)

(define-command :abort (stream condition)
  (debugger-invoke-restart 'abort stream condition))

(define-command :q (stream condition)
  (debugger-invoke-restart 'abort stream condition))

(define-command :continue (stream condition)
  (debugger-invoke-restart 'continue stream condition))

(define-command :c (stream condition)
  (debugger-invoke-restart 'continue stream condition))

(defvar *help-hooks* '())

(define-command :help (stream condition)
  (format stream
          ";; The code of the Clordecone debugger is an extracted~@
           ;; version of debugger written by Michał \"phoe\" Herda~@
           ;; as part of his Portable Condition System.~@
           ;;~@
           ;; The debugger read-eval-print loop supports the~@
           ;; standard REPL variables:~@
           ;;   *   **   ***   +   ++   +++   /   //   ///   -~@
           ;;~@
           ;; Available debugger commands:~@
           ;;  :HELP              Show this text.~@
           ;;  :EVAL <form>       Evaluate a form typed after the :EVAL command.~@
           ;;  :REPORT            Report the condition the debugger was invoked with.~@
           ;;  :CONDITION         Return the condition the debugger was invoked with.~@
           ;;  :RESTARTS          Print available restarts.~@
           ;;  :RESTART <n>, <n>  Invoke a restart with the given number.")
  (when (find-restart 'abort condition)
    (format stream "~&;;  :ABORT, :Q         Invoke an ABORT restart.~%"))
  (when (find-restart 'continue condition)
    (format stream "~&;;  :CONTINUE, :C      Invoke a CONTINUE restart.~%"))
  (dolist (hook *help-hooks*)
    (funcall hook condition stream))
  (format stream ";;~@
                  ;; Any non-keyword non-integer form is evaluated.~%"))

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

(defun standard-debugger (condition &optional (stream *debug-io*))
  "Implements the standard debugger."
  (let ((*debug-level* (1+ *debug-level*)))
    (run-debugger-command :report stream condition)
    (format stream "~&;; Type :HELP for available commands.~%")
    (loop (read-eval-print-command stream condition))))
