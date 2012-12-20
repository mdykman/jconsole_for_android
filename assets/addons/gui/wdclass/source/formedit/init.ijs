NB. init

require 'droidwd gtkwd bmp regex general/misc/font'

coclass 'jformedit'

coinsert 'jgl2 jijs'

FORMSIZES_j_=: 48 12 60 12 11
IDCDIR=: 0

NB. =========================================================
create=: 3 : 0

copybuffer=: ''

NB. ---------------------------------------------------------
NB. initialize GSCALE etc.
if. GSCALE=0 do.
  wd 'pc gscale;xywh 0 0 200 200;cc g static'
  wd^:(-.IFJ6) 'pshow;pshow sw_hide'
  s=. 2 { 0 ". wd 'qchildxywh g'
  x=. 2 { 0 ". wd 'qchildxywhx g'
  wd 'pclose'
  GSCALE_jformedit_=: x % s
  topixels_jformedit_=: roundint @ (*&GSCALE) f.
  tounits_jformedit_=: roundint @ (%&GSCALE) f.
  GWH_jformedit_=: 2 {. 0 ". wd 'qm' NB. screen size in pixels
  XYWH_jformedit_=: '0 0 ',": <.GWH % GSCALE NB. corresponding xywh
end.

if. isempty y do.
  id=. qsmact ''
  FNAME=: id2name id
  if. '.ijx' -: _4 {. FNAME do.
    info 'Open a script window before running Form Edit'
    destroy''
    return.
  end.
  smsel id
  smsave ''
else.
  FNAME=: y
  smopen FNAME
end.
if. 0 = file_init'' do. destroy'' end.
)

NB. =========================================================
create_show=: 3 : 0

wd DESIGN
wd 'pn "Design - ',PID,'"'
wdfit''
nd=. 'undo redo center minus plus size space touch'
wd 3 |. ; ' 0;setenable '&, each ;: nd
selectdesign=: wd bind ('psel ',wd 'qhwndp')

drawform''
selectdesign''
wd 'ptop'
wd 'pshow'

getformsizes''
geteditheight''
bufsnap ''
)

NB. =========================================================
destroy=: 3 : 0
try.
  selectform''
  wd 'pclose'
catch. end.
try.
  selectdesign''
  wd 'pclose'
catch. end.
codestroy''
)
