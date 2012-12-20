NB. file

NB. =========================================================
file_init=: 3 : 0
dat=. file_read FNAME
if. dat -: _1 do.
  info 'Unable to read: ',>FNAME
  0 return.
end.
nms=. a: -.~ {."1 dat
select. #nms
case. 0 do. newform ''
case. 1 do. openform 0 pick nms
case. do. pickform nms
end.
1
)

NB. =========================================================
NB. file_read
NB. returns a boxed table where odd rows are form definitions
NB. (which may be empty)
NB. column 0 is the form name
NB. column 1 is the file data
NB. return _1 if fail
file_read=: 3 : 0
smsel y
smsave ''
dat=. freads y
if. dat -: _1 do. return. end.
file_read1 dat
)

NB. =========================================================
file_read1=: 3 : 0
dat=. y
if. 0 = # dat do. i.0 2 return. end.
msk=. (LF,RFE,LF) E. dat
if. 0 = +/ msk do. ,: '';<dat return. end.
hdr=. msk i. 1
f=. [: </\ (LF,')',LF)&E.
msk=. f each msk <;.1 dat
msk=. _2 |. (hdr#0),;msk
ndx=. 1 + msk i: 1
ftr=. ndx }. dat
dax=. msk <;.2 dat
(; pairform each dax), '';ftr
)

NB. =========================================================
NB. open form
openform=: 3 : 0
PID=: y
fdata=. file_read FNAME
if. fdata -: _1 do.
  info 'Unable to read: ',>FNAME
  0 return.
end.
ndx=. ({."1 fdata) i. <PID
dat=. (<ndx;1) pick fdata
txt=. {:"1 fdata
dat=. a: -.~ <;._2 dat
ndx=. 1 i.~ (deb each dat) = <RFE
PFE=: tolist ndx }. dat
dat=. dlb each ndx {. dat
dat=. dat -. a:
PDF=: deb (i.&'=' {. ]) 0 pick dat
dat=. }. dat
dat=. (, ';'"_ -. {:) each dat

msk=. (<'menu') = 4 {. each dat
MNU=: readmenudef getmenudef ; (msk # dat) ,each LF
dat=. (-. msk) # dat

msk=. (<'sbar') = 4 {. each dat
SBR=: readstatusdef getstatusdef ; (msk # dat) ,each LF
dat=. (-. msk) # dat

msk=. (<'tbar') = 4 {. each dat
TBR=: readtoolbardef gettoolbardef ; (msk # dat) ,each LF
dat=. (-. msk) # dat

msk=. (<'xywh') = 4 {. each dat
dat=. <;._2 each dat
child=. msk # dat
parent=. (-. msk) # dat

NB. ---------------------------------------------------------
NB. get parent definitions:
pdf=. 0 pick parent
PST=: (1 + # 'pc ',PID) }. 0 pick pdf
PCN=: deldblquote 3 }. 1 pick pdf, a:
pop=. ';' cutopen 1 pick parent, a:
ndx=. I. (<'pas ') = 4 {. each pop
if. #ndx do.
  PAS=: 2 {. 0 ". 4 }. ({.ndx) pick pop
  pop=. (<<<ndx) { pop
else.
  PAS=: 6 6
end.
ndx=. I. (<'pmove ') = 6 {. each pop
if. #ndx do.
  PMV=: 4 {. 0 ". 6 }. ({.ndx) pick pop
  pop=. (<<<ndx) { pop
else.
  PMV=: $0
end.
POP=: pop

NB. ---------------------------------------------------------
NB. get child definitions:
NB. control definitons:
NB. CCS=: 0 4$0  NB. control positions
NB. CLS=: ''     NB. classes
NB. CPS=: ''     NB. captions (or ocx name)
NB. IDS=: ''     NB. ids
NB. STY=: ''     NB. styles

cx=. deb each 0 pick each child
cc=. deb each 1 pick each child
cn=. debs each 2 pick each child ,each <<''

msk=. (3 {. each cc) e. <'cc '
msk=. msk *. (3 {. each cn) e. 'cn ';'   '

if. 0 e. msk do.
  msg=. tolist ([: ; ,&';' each) each msk # child
  info 'Ignoring invalid child definition: ', msg
  cc=. msk # cc
  cn=. msk # cn
  cx=. msk # cx
end.

if. #cc do.
  CCS=: 0 ". &> 5 }. each cx
  cc=. 3 }. each cc
  ndx=. cc i. &> ' '
  IDS=: ndx {. each cc
  cc=. (ndx + 1) }.each cc
  ndx=. cc i. &> ' '
  CLS=: ndx {. each cc
  STY=: ws_add each (ndx + 1) }.each cc
  CPS=: deldblquote each 3 }. each cn

NB. fix ocx:
  ndx=. I. 'ocx:'&-: &> 4 {.each CLS
  if. #ndx do.
    txt=. 4 }.each ndx { CLS
    CPS=: txt ndx } CPS
    CLS=: (<'ocx') ndx } CLS
  end.
end.

NB. ---------------------------------------------------------
create_show ''
)

NB. =========================================================
pairform=: 3 : 0
dat=. <;.2 y
msk=. 1 |. (<'pc ') = 3 {.each dat
msk=. msk *. (1: e. '0 : 0'&E.) &> dat
if. 0 = +/msk do.
  (<''),.y;''
else.
  ndx=. msk i: 1
  hdr=. ndx {. dat
  ftr=. ndx }. dat
  nam=. 1 pick ;: 1 pick ftr
  ('';;hdr) ,: nam;;ftr
end.
)

NB. =========================================================
saveform=: 3 : 0
frm=. form_read''
fdata=. file_read FNAME
if. fdata -: _1 do.
  frm fwrite jpath '~temp/formedit.ijs'
  msg=. 'Unable to access file ',>FNAME
  msg=. msg,LF,LF,'Form written to file: ',jpath '~temp/formedit.ijs'
  info msg
  destroy'' return.
end.
ndx=. ({."1 fdata) i. <PID
if. ndx = #fdata do.
  fdata=. fdata, PID;frm
else.
  fdata=. (<frm) (<ndx;1) } fdata
end.
dat=. ; {:"1 fdata
NB. TODO integrate with ide
FNAME fwrite~ toHOST dat
return.
smopen FNAME
old=. smread''
if. 0[ -. old -: dat do.
  loc=. id2loc name2id FNAME
  if. checkreadonly__loc'' do. return. end.
  smwrite dat
  smsave ''
end.
)
