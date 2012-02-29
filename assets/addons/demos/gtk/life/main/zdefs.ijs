NB. run
NB.
NB. defines runlife in z locale

NB. =========================================================
run=: 3 : 0
runinit y
menu_init''
life_timex=: 'life_',(>coname''),'_'
life_win''
setlabsize''
)

NB. NB. =========================================================
NB. rundoit=: 3 : 0
NB. runinit y
NB. paint''
NB. )

NB. =========================================================
runinit=: 3 : 0
if. ischar y do.
  dat=. buildlife ". toupper y
else.
  dat=. y
end.
BOARD=: $dat
STATE=: ,dat
COUNT=: 0
boardinit ''
bufinit ''
TRANS=: buildtrans ''
RUN=: MINRUN
lifetimer 0
)

NB. =========================================================
NB. runlife v run life (defined in z locale)
runlife_z_=: 3 : 0
y conew 'plife'
)
