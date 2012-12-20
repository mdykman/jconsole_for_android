NB. draw

NB. =========================================================
NB. background
drawback=: 3 : 0
glbrush glrgb FACE
glrect 0 0,GWH
glpen 1 0 [ glrgb 0 0 0
glpixel GRID * > ,{ i. each >. GWH % GRID
)

NB. =========================================================
drawcontrols=: 3 : 0
CCX=: makeccx''
cns=. CPS
cap=. (({."1 CONTROLS) i. CLS) { (5 {"1 CONTROLS),<0
ids=. IDS
ndx=. /: (i.#CCX) e. SELECT
fns=. 'draw'&, each ndx { CLS
dat=. ndx { ids,.STY,.cns,.cap,.<"1 CCX
r=. ''
for_d. dat do.
  (>d_index{fns)~d
end.
)

NB. =========================================================
NB. foreground
NB.
NB. y.=0 initial, 1 update
drawforeground=: 3 : 0
colors=. RED,:BLUE

NB. ---------------------------------------------------------
if. #SELECT do.
  ccs=. SELECT { CCX
  for_i. SELECT do.
    clr=. i ~: {. SELECT
    glrgb clr { colors
    glpen 3 0
    glbrushnull''
    glrect i_index { ccs
  end.
end.

NB. ---------------------------------------------------------
if. #BOX do.
  glrgb {. colors
  glpen 2 0
  glbrushnull''
  glrect BOX
end.

NB. ---------------------------------------------------------
if. ORDER do.
  glpen 1 0 [ glbrush glrgb FACE
  glrgb 0 0 0
  glfont 'bold' changefont GFONT
  for_i. CCX do.
    xy=. _4 + 2 {. i
    tx=. ": i_index
    glrect xy,0 1+glqextent tx
    gltextxy xy
    gltext tx
  end.
end.
)

NB. =========================================================
drawform=: 3 : 0
drawinit''
drawsize 0
wd 'pshow'
)

NB. =========================================================
drawinit=: 3 : 0
NB. minform''
wd 'pc form'
wd 'xywh 0 0 100 100;cc s static;setshow s 0'
wd 'cc g isigraph nopas;'
HWNDP=: wd 'qhwndp'
HWNDG=: wd 'qhwndc g'
wd 'pn "',((*#PCN) pick PID;PCN),'"'
wd MNU
wd SBR
wd TBR
wd 'setxywhx g 0 0 ',":GWH
wd 'pas 0 0'
)

NB. =========================================================
drawpaint=: 3 : 0
form_g_paint''
glpaint''
if. # SELECT do.
  selectdesign''
  wd 'set id *', ({.SELECT) pick IDS
  wd 'set pos *',": ({.SELECT) { CCS
  wd 'psel ',HWNDP
end.
)

NB. =========================================================
NB. y is 1 if resize
drawsize=: 3 : 0
makeccx''
fwh=. MINWH >. PAS + >./ +/"2 [ _2 [\"1 CCX
if. y *. fwh -: FWH do. return. end.
FWH=: fwh
wh=. _2 {. 0 ". wd 'qchildxywhx s'
fx=. 0 ". wd 'qformx'
wd 'setxywhx s 0 0 ',":FWH
wd 'pmovex ',":fx + 0 0,FWH - wh
)

NB. =========================================================
form_g_paint=: 3 : 0
glsel HWNDG
glclear''
glfont GFONT
glcursor IDC_ARROW
drawsize 1
drawback''
drawcontrols''
drawforeground''
glcursor CURSOR
)
