NB. events - set up form events
NB.
NB. initevents
NB.
NB. requires:
NB.   locP     parent form locale
NB.   ID       optional map control id
NB.   PID      optional parent form id
NB.   Hwndc    optional map control handle
NB.
NB. defines:
NB.   LOC
NB.   tmaphandler parent event handler
NB.   isigraph event handlers

NB. =========================================================
NB. form events
NB. other events are: hover
EVENTS=: ;: 'mbldown mbrdown mmove paint'

NB. =========================================================
initevents=: 3 : 0

NB. ---------------------------------------------------------
if. 3=nameclass__locP <ID,'_tmaphandler' do.
  makehandler ID,'_tmaphandler__locP'
else.
  tmaphandler=: 1:
end.

NB. ---------------------------------------------------------
if. 0=#LOC do. LOC=: ID end.

NB. ---------------------------------------------------------
if. 0=Hwndc do.
  Hwndc=: wdqhwndc ID
end.

if. 0 = #PID do.
  if. IFQT do.
    PID=: wdgetparentid Hwndc
  else.
    fms=. <;._2;._2 wdqpx''
    act=. 0 ". &> 4 {"1 fms
    fms=. fms \: (act=0),.act
    ndx=. (2 {"1 fms) i. locP
    PID=: 0 pick ndx { fms
  end.
end.

NB. ---------------------------------------------------------
NB. create default event handlers
if. 0=nameclass__locP <LOC do.
  if. (coname'') -: (LOC,'__locP')~ do.
    f=. (<PID,'_',ID,'_') ,each EVENTS
    m=. _1 = nameclass__locP f
    if. 1 e. m do.
      t=. (m#EVENTS) ,each <'__',LOC,LF
      t=. ;(m#f) ,each (<'=: ') ,each t
      cocurrent locP
      0!:100 t
    end.
  end.
end.

NB. ---------------------------------------------------------
0
)

NB. =========================================================
NB. makehandler v make tmaphandler
makehandler=: 3 : 0
a=. 'r=. ',y,' y',LF
a=. a,'if. 0 e. $r do. 1 else. {.,r end.'
tmaphandler=: 3 : a
EMPTY
)
