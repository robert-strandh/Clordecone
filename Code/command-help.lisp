(cl:in-package #:clordecone)

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
