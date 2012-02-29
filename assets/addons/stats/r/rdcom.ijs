3 : 0''
if. IFJ6 do.
  script_z_ '~system/main/strings.ijs'
end.
''
)
NB. init

coclass 'prdcom'
NB. init

NB. =========================================================
create=: 3 : 0
makezfns''
wd 'pc jdcom'
HWNDP=: wd 'qhwndp'
wd 'cc w oleautomation:StatConnectorSrv.StatConnector.1'
wd 'olemethod w base Init "R"'
wd 'olemethod w base EvaluateNoReturn *',RDEF_exec
)

NB. =========================================================
destroy=: 3 : 0
wd ::] 'psel jdcom;pclose'
codestroy''
)

NB. util

EMPTY=: i.0 0

NB. =========================================================
addLF=: 3 : 0
y, (0<#y) # LF -. {: y
)

NB. =========================================================
NB. replace NB. by #
fixcmd=: 3 : 0
y rplc 'NB.';'#'
)
NB. init
NB.
NB. dcom commands are sent one by one
NB. could also write to file and source from file

NB. =========================================================
cutcmd=: 3 : 0
if. L. y do. y return. end.
cmd=. fixcmd y
cmd=. <;._2 toJ cmd,LF
cmd=. cmd #~ '#' ~: {.&> cmd
cmd -. a:
)

NB. =========================================================
NB. cmd - run command with no return
cmd=: 3 : 0
wd 'psel ',HWNDP
for_c. cutcmd y do.
  wd 'olemethod w base EvaluateNoReturn *',>c
end.
)

NB. =========================================================
NB. cmdr - run command with return
NB. note: each sentence must have a valid return
cmdr=: 3 : 0
wd 'psel ',HWNDP
r=. ''
for_c. cutcmd y do.
  r=. r,LF,wd 'olemethod w base Evaluate *',>c
end.
}. r
)

NB. =========================================================
NB. cmdr - run command with extended return
cmdx=: 3 : 0
res=. cmdr 'exec("',y,'")'
res #~ (+./\ *. +./\.) res ~: LF
)

NB. =========================================================
NB. get - not yet supported
get=: 3 : 0
wd 'psel ',HWNDP
wd 'olemethod w base GetSymbol ',y
)

NB. =========================================================
NB. set - not yet supported
set=: 4 : 0
wd 'psel ',HWNDP
wd 'olemethod w base SetSymbol ',x,' ',y
)

NB. =========================================================
NB. exec - execute R command, return printed result
RDEF_exec=: 0 : 0
exec <- function(sourceText)
{
  sourceConn <- textConnection(sourceText, open="r")
  resultConn <- textConnection("resultText", open="w")
  on.exit(function() {sink();close(resultConn);close(sourceConn)})
  sink(resultConn)
  source(file=sourceConn,local=FALSE,echo=FALSE,print.eval=TRUE)
  sink()
  res <- paste(resultText, collapse="\n", sep="")
  close(resultConn)
  close(sourceConn)
  on.exit(NULL)
  return(res)
}
)
NB. zfns
NB.
NB. interactive cover functions, defined by makezfns,
NB. e.g. Rcmd calls cmd in instance locale
NB.
NB. commands:
NB. Rcmd - command, no return
NB. Rcmdr - command, return result
NB. Rcmdx - command, with extended return

NB. =========================================================
ZFNS=: 0 : 0
cmd
cmdr
cmdx
)

NB. =========================================================
makezfn=: 4 : 0
('R',y,'_z_')=: 3 : (y,'_',x,'_ y')
EMPTY
)

NB. =========================================================
makezfns=: 3 : 0
(> coname'') & makezfn ;._2 ZFNS
)
