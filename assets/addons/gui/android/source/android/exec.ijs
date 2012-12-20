NB. exec
NB.
NB. globals and verbs in ja
NB. system calls point to ja
NB.
NB. inputx     - for calling immex from event
NB. logged     - if 1, log type 3 output to session
NB. inputs     - set to 1 by immexs
NB.
NB. ifxlog     - set to 1 to log input/output for debugging
NB. xlog       - execution log
NB.
NB. is single logged noun enough?
NB.   - set by immexd
NB.   - set by any 3 output
NB.   - unset by call to input

inputx=: ''
logged=: 0
inputs=: 0
active=: 1

ifxlog=: 0
xlog=: ''

NB. =========================================================
termAppend=: 0:     NB. WIP

NB. =========================================================
NB. run sentence y in next immediate execution
NB. sentence is not logged to output
immex=: 3 : 0
logged=: 0
inputs=: 0
inputline=: y
inputready=: 1
)

NB. =========================================================
NB. run sentence y in next immediate execution
NB. sentence is logged to output
immexd=: 3 : 0
logged=: 1
inputs=: 0
inputline=: y
inputready=: 1
)

NB. =========================================================
NB. run sentence y in next immediate execution
NB. sentence is not logged to output
NB. LF not written to session
immexs=: 3 : 0
logged=: 0
inputs=: 1
inputline=: y
inputready=: 1
)

NB. =========================================================
NB. JE calls for input, y is prompt
input=: 3 : 0
termAppend prompt=: y
inputready=: 0
inputs=: 0
logged=: 0
'' return.   NB. not implemented
NB. while. 1 do.
NB.   whilst. gtk_events_pending'' do.
NB.     gtk_main_iteration''
NB.   end.
NB.   if. inputready do. break. end.
NB. end.
NB. if. ifxlog do. xlog=: xlog,<0;inputline end.
NB. inputline
)

NB. =========================================================
NB. y output string
NB. x output types
NB.  MTYOFM   1 formatted result array
NB.  MTYOER   2 error
NB.  MTYOLOG  3 log
NB.  MTYOSYS  4 system assertion failure
NB.  MTYOEXIT 5 exit - not used
NB.  MTYOFILE 6 output 1!:2[2
output=: 4 : 0
if. -.active do. return. end.
if. ifxlog do. xlog=: xlog,<x;y end.
if. 3~:x do.
  termAppend y
else.
  if. inputs do. return. end.
  if. logged do.
    termAppend y
  else.
    logged=: 1
    termAppend LF
  end.
end.
)

NB. prevent crash when loading from JHS
3 : 0''
if. -.IFJHS do.
  input_jfe_=: input_ja_
  output_jfe_=: output_ja_
end.
''
)

NB. =========================================================
runimmex0=: 3 : 0
if. #y do.
  inputx_ja_=: y
  immex_ja_ '0!:100 inputx_ja_'
end.
)

NB. =========================================================
runimmex1=: 3 : 0
if. #y do.
  inputx_ja_=: y
  immex_ja_ '0!:101 inputx_ja_'
end.
)
