Clordecone is a portable "debugger" for Common Lisp, using text-only
command lines for interaction.  I put "debugger" in quotation marks,
because that is how it is referred to in the Common Lisp standard, but
all it does is to allow the user to examine active restarts and invoke
one of those restarts interactively.  It has none of the features that
would be part of a real debugger such as setting breakpoints, single
stepping, examining the call stack, or accessing the value of local
variables.

This code is an extraction of the portable debugger written by Michał
"phoe" Herda as part of the Portable Condition System that he wrote as
a support for his book "The Common Lisp Condition System.
