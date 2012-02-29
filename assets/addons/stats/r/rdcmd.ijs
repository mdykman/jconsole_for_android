3 : 0''
if. IFJ6 do.
  script_z_ '~system/main/files.ijs'
  script_z_ '~system/main/strings.ijs'
  script_z_ '~system/packages/misc/task.ijs'
else.
  require 'task'
end.
''
)
NB. init

coclass 'prdcmd'
NB. init

NB. path to R binary (change as appropriate):
RBINX=: '/usr/bin/R'
RBINW=: '"c:\program files\r\r-2.4.1\bin\r.exe"'
RBIN=: IFUNIX pick RBINW;RBINX

NB. =========================================================
NB. create
NB.
NB. defines RCMD to run R CMD BATCH ...
NB.
NB. R options:
NB. --vanilla =
NB.   --no-save --no-environ --no-site-file --no-init-file --no-restore
NB. --quiet = no initial R blurb
NB. --slave = no extra messages
NB. --gui=gnome - for interactive use
create=: 3 : 0
makezfns''
opt=. ' CMD BATCH --quiet --slave --vanilla '
RCMD=: RBIN,opt,'"',RIN,'" "',ROUT,'"'
)

destroy=: codestroy
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
NB. cmd

p=. jpath '~temp/'
q=. '/' (I.p='\') } p
RIN=: q,'r.in'
ROUT=: q,'r.out'
RPDF=: q,'r.pdf'
RRES=: q,'r.res'

NB. =========================================================
NB. add these to any command
NB. e.g.
NB. RHDR=: 'options(echo=FALSE)'  - to suppress inputs
RHDR=: ''
RFTR=: LF

NB. =========================================================
NB. cmd - run R command with no return
cmd=: 3 : 0
ferase RIN;ROUT;RRES
RIN fwrite~ (addLF RHDR),(fixcmd y),RFTR
if. IFUNIX do.
  2!:1 RCMD
else.
  spawn_jtask_ RCMD
end.
)

NB. =========================================================
NB. cmdr - run command with return result
NB.
NB. either explicitly sink to RRES in the command, or else
NB. the command is wrapped in a sink to RRES.
cmdr=: 3 : 0
if. 1 e. 'RRES' E. y do.
  y=. y rplc 'RRES';RRES
else.
  y=. 'sink("',RRES,'")',LF,'print.eval=TRUE',LF,y,LF,'sink()'
end.
cmd y
fread RRES
)

NB. =========================================================
NB. cmds - run R command, return session
cmds=: 3 : 0
cmd y
fread ROUT
)

NB. =========================================================
NB. cmdp - run command with plot (to pdf)
cmdp=: 3 : 0
cmd 'pdf(file="',RPDF,'")',LF,y
)

NB. =========================================================
NB. cmdps - run command with plot (to pdf), return session
cmdps=: 3 : 0
cmdp y
fread ROUT
)
NB. zfns
NB.
NB. interactive cover functions, defined by makezfns,
NB. e.g. Rcmd calls cmd in instance locale
NB.
NB. commands:
NB. Rcmd - command, no return
NB. Rcmdp - command, plot to pdf
NB. Rcmdps - command, plot to pdf, return session
NB. Rcmdr - command, return result
NB. Rcmds - command, return session

NB. =========================================================
ZFNS=: 0 : 0
cmd
cmdp
cmdps
cmdr
cmds
)

NB. =========================================================
makezfn=: 4 : 0
smoutput ('R',y,'_z_')=: 3 : (y,'_',x,'_ y')
EMPTY
)

NB. =========================================================
makezfns=: 3 : 0
(> coname'') & makezfn ;._2 ZFNS
)
