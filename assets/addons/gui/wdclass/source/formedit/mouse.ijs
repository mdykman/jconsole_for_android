NB. mouse

WAITM=: 0.15     NB. movement
WAITD=: 0.5      NB. doubleclick
j=. IDC_SIZENWSE,IDC_SIZENS,IDC_SIZENESW,IDC_SIZEWE
IDCSET=: j,IDC_SIZENWSE,IDC_SIZENS,IDC_SIZENESW,IDC_SIZEWE

NB. =========================================================
gfocus=: 3 : 0
wd 'setfocus g'
)

NB. =========================================================
form_g_mbldbl=: 3 : 0
if. MOUSEIGNORE do. return. end.
if. ORDER do. return. end.
DOWN=: ''
SELECT=: hittest mousepos''
if. #SELECT do.
  SELECT=: , {. SELECT
  drawpaint''
  if. ifctrlkey'' do.
    selectcode''
  else.
    wcontrol_run''
  end.
else.
  wparent_run''
end.
design_enable ''
)

NB. =========================================================
form_g_mbldown=: 3 : 0
if. MOUSEIGNORE do. return. end.
if. ORDER do. order_select'' return. end.
pos=. mousepos''
time=. sessiontime''
if. (DOWN -: pos) *. WAITD > time - MOUSETIME do.
  return.
end.
MOUSETIME=: time
DOWN=: pos
sel=. hittest DOWN

NB. ---------------------------------------------------------
if. (#sel) *. ifctrlkey'' do.
  SELECT=: sel
  selectcode'' return.
end.

NB. ---------------------------------------------------------
if. CURSOR e. IDCSET do.
  capture CAPSIZE,,topixels SELECT { CCS
else.
  dombldown sel
end.

NB. ---------------------------------------------------------
gfocus''
drawpaint''
design_enable ''
)

NB. =========================================================
dombldown=: 3 : 0
sel=. y

NB. ---------------------------------------------------------
if. isempty sel do.
  SELECT=: $0
  capture CAPSELECT return.
end.

NB. ---------------------------------------------------------
if. LOCK do.
  SELECT=: sel return.
end.

NB. ---------------------------------------------------------
if. isempty SELECT do.
  SELECT=: sel
  mbsetcursor'' return.
end.

NB. ---------------------------------------------------------
if. sel e. SELECT do.
  if. ifshiftkey'' do.
    SELECT=: SELECT -. sel
  else.
    SELECT=: SELECT /: SELECT ~: {. sel
    CURSOR=: IDC_CROSS
  end.
  return.
end.

NB. ---------------------------------------------------------
if. ifshiftkey'' do.
  SELECT=: SELECT, sel
else.
  SELECT=: sel
  mbsetcursor''
end.
)

NB. =========================================================
mbsetcursor=: 3 : 0
if. (-.LOCK) *. #SELECT do.
  if. CURSOR e. IDCSET do.
    capture CAPSIZE,,SELECT { CCS
  else.
    CURSOR=: IDC_CROSS
  end.
end.
)

NB. =========================================================
form_g_mblup=: 3 : 0
if. MOUSEIGNORE do. return. end.
if. ORDER do. return. end.
if. ''-:DOWN do. return. end.
UP=: mousepos''
dif=. UP - DOWN
oldcap=. CAPTURE
capture CAPNONE
cursor IDC_ARROW
select. oldcap
case. CAPSELECT do.
  box=. (UP <. DOWN), | dif
  SELECT=: boxtest box
case. CAPMOVE do.
  if. WAITM < (sessiontime'') - MOUSETIME do.
    c=. SELECT { CCS
    c=. 0 >. c +"1 [ (tounits dif), 0 0
    CCS=: c SELECT } CCS
  end.
case. CAPSIZE do.
  c=. SELECT { CCS
  d=. sizediff tounits dif
  c=. 0 >. c +"1 d
  CCS=: c SELECT } CCS
end.
drawpaint''
design_enable ''
bufsnap''
)

NB. =========================================================
NB. form_g_mmove
form_g_mmove=: 3 : 0
if. MOUSEIGNORE do. return. end.
if. ORDER do. return. end.
if. 0=#SELECT do. return. end.
time=. sessiontime''

NB. ---------------------------------------------------------
if. CAPTURE do.
  pos=. mousepos''
  ccs=. topixels ({.SELECT) { CCS
  select. CAPTURE
  case. CAPMOVE do.
    c=. ccs + (pos-DOWN), 0 0
  case. CAPSIZE do.
    c=. ccs + 0 0, pos-DOWN
  end.
  selectdesign''
  wd 'set pos *',": tocoordsxywh1 c
  wd 'setupdate pos'
  glsel HWNDG

NB. ---------------------------------------------------------
elseif. #SELECT do.
  if. CURSOR = IDC_CROSS do.
    capture CAPMOVE,,SELECT { CCX
  else.
    p=. (mousepos '') sizetest ({.SELECT) { CCX
NB. nonce only support increasing size:
    if. p e. 3 4 5 do.
      cursor p { IDCSET
      IDCDIR=: p
    else.
      cursor IDC_ARROW
    end.
  end.
  glpaint''
end.
)

NB. =========================================================
NB. calculate size difference
sizediff=: 3 : 0
'x y'=. y
select. IDCDIR
case. 0 do. x,y,-x,y
case. 1 do. 0,y,0,-y
case. 2 do. 0,y,x,-y
case. 3 do. 0 0,x,0
case. 4 do. 0 0,x,y
case. 5 do. 0 0 0,y
case. 6 do. x,0,(-x),y
case. 7 do. x,0,(-x),0
end.
)

NB. =========================================================
NB. return _1 if none or 0...7 clockwise from NW
sizetest=: 4 : 0
'mx my'=. x
'px py pw ph'=. y
ty=. (my > py-6) *. (my < py+6)
by=. (my > ph+py-6) *. (my < ph+py+6)
nx=. (ty,by) i. 1
if. (mx > px-6) *. (mx < px+6) do.
  nx { 0 6 7
elseif. (mx > pw+px-6) *. (mx < pw+px+6) do.
  nx { 2 4 3
elseif. do.
  nx { 1 5 _1
end.
)
