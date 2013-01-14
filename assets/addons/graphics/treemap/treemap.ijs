NB. init

require 'gtkwd'

3 : 0''
if. IFJ6 do.
script_z_ '~system\main\gl2.ijs'
script_z_ '~system\main\pack.ijs'
else.
require 'pack'
end.
''
)

coclass 'ptreemap'
NB. init

coinsert 'jgl2'

NB. =========================================================
create=: 3 : 0
if. #y do.
  locP=: boxopen y
else.
  locP=: COCREATOR
end.
EMPTY
)

NB. =========================================================
destroy=: 3 : 0
try.
  glsel Hwndc
  capture 0
catch. end.
codestroy''
)

NB. =========================================================
NB. show map
show=: 3 : 0
if. 0=#locP do. NB. needed for setnames
  locP=: COCREATOR
end.
setnames y
initevents''
drawinit''
initmisc''
setrxywh getxywhx''
refresh''
)

NB. =========================================================
NB. paint event handler
paint=: 3 : 0
xywh=. getxywhx ''
if. Rxywh -: xywh do. return. end.
setrxywh xywh
showitn''
)

NB. =========================================================
setrxywh=: 3 : 0
'Rx Ry Rw Rh'=: Rxywh=: y
)

NB. =========================================================
initxywh=: 3 : 0
'Sx Sy Sw Sh'=: Sxywh=: Rxywh + Roff * 1 1 _1 _1
)
NB. util

EMPTY=: i.0 0
SPARSETYPE=: 1024 2048 4096 8192 16384 32768

citemize=: ,:^:(2 > #@$)
index=: #@[ (| - =) i.
rounddint=: [: (- 0 , }:) ([: <. 0.5 + +/\)
roundint=: <.@:+&0.5

NB. =========================================================
getxywhx=: 0 0,glqwh

NB. =========================================================
gridfocus=: 3 : 0
if. IFUNIX >: ID -: sysfocus__locP do.
  wd 'setfocus ',ID
end.
)

NB. =========================================================
NB. inrect v test rectangles for hit
NB. form: pos inrect rects
NB. returns success flag
inrect=: 4 : 0
if. 0 = # y do. 0 return. end.
'px py'=. x
'x y w h'=. |: y
1 e. (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
)

NB. =========================================================
NB. inrectx v get index of hit in rectangles
NB. form: pos inrectx rects
inrectx=: 4 : 0
if. 0 = #y do. 0 return. end.
'px py'=. x
'x y w h'=. |: y
1 i.~ (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
)

NB. =========================================================
ispk=: 3 : 0
select. L. y
case. 0 do. 0
case. 1 do.
  if. 2 ~: {:$y do. 0 return. end.
  1 < >./ #@$ each y
case. do. 1
end.
)

NB. =========================================================
NB. readloc
NB.
NB. locale readloc namelist
readloc=: 4 : 0
nms=. y
if. 0 = L. nms do.
  nms=. ;: toupper nms
end.
nms=. nms -. <,LF
cnm=. nms ,each <'__x'
msk=. 0 = 4!:0 cnm
nms=. msk # nms
cnm=. msk # cnm
res=. nms
spx=. I. (3!:0@". &> cnm) e. SPARSETYPE
if. #spx do.
  for_s. spx do.
    (s{nms)=: ". > s{cnm
  end.
  spx=. <<<spx
  cnm=. spx{cnm
  nms=. spx{nms
end.
(nms)=: ". each cnm
res
)

NB. =========================================================
NB. define namelist or package from creator:
setnamesx=: 3 : 0
if. 0=#y do. return. end.
if. L. y do.
  unpack y
else.
  locP readloc y
end.
)

setnames=: setnamesx

NB. =========================================================
NB. shrinkrect
NB.
NB. form: rect shrinkrect xywh
shrinkrect=: 4 : 0
x + , 1 _1 * +/\ _2 [\ 4 $ y
)

NB. =========================================================
rectindex=: 3 : 0
'px py'=. y
m=. (px >: Tx) *. (px <: Tx + Tw) *. (py >: Ty) *. py <: Ty + Th
m index 1
)

NB. =========================================================
tmindex=: 3 : 0
(rectindex y) { Sort,_1
)

NB. =========================================================
unpack=: 3 : 0
if. 0 e. $y do. '' return. end.
y=. citemize y
nms=. toupper each {."1 y
(nms)=: {:"1 y
nms
)
NB. color

3 : 0 ''
if. IFJAVA do.
  COLOR_BTNFACE=: 236 233 216
else.
  COLOR_BTNFACE=: wdqcolor 15
end.
)

AQUA=: 0 255 255
BLACK=: 0 0 0
BLUE=: 0 0 255
BLUESEL=: 51 102 204
BROWN=: 165 42 42
CORAL=: 255 127 80
DARKGRAY=: 169 169 169
DARKSLATEGRAY=: 47 79 79
FUCHSIA=: 255 0 255
DIMGRAY=: 105 105 105
GRAY=: 128 128 128
GREEN=: 0 128 0
LIGHTSEAGREEN=: 32 178 170
OLIVE=: 128 128 0
PALEYELLOW=: 255 255 205
PURPLE=: 128 0 128
RED=: 255 0 0
SILVER=: 192 192 192
TAN=: 210 180 140
TEAL=: 0 128 128
WHITE=: 255 255 255
YELLOW=: 255 255 0

NB. =========================================================
NB. standard colors
STDCLR=: _3[\BLUE,RED,GREEN,PURPLE,FUCHSIA,OLIVE,TEAL,YELLOW,TAN,AQUA,BROWN,GRAY
NB. defs

Bxm=: 3
Bym=: 3
Boxoff=: 2 2

Hdef=: ''     NB. hover definition
Hndx=: _1     NB. hover index
Hwndc=: ''
Roff=: 0

BackColor=: COLOR_BTNFACE
BoxColor=: DARKSLATEGRAY ,: 255 255 255
EdgeColor=: DARKSLATEGRAY

NB. opts

DATA=: ''
LABEL=: ''
NOTE=: ''
FONT=: IFUNIX pick 'Arial 10';'"Bitstream Vera Sans" 10'
COLORS=: STDCLR
COLOR=: ''
GRIDCOLOR=: DIMGRAY
GRIDSHOW=: 1
ID=: 'tm'
PID=: ''
LOC=: ID

NB. =========================================================
OPTIONS=: <;._2 (0 : 0)
COLOR
COLORS
GRIDCOLOR
GRIDSHOW
DATA
FONT
ID
LABEL
LOC
NOTE
PID
)
NB. draw

NB. =========================================================
NB. drawbox
drawbox=: 3 : 0
'pxy txt'=. y
txt=. txt, LF
glfont FONT
w=. >./ glqextentw txt
h=. {: glqextent 'X'
txt=. <;._2 txt
wid=. w + +: Bxm
hit=. (h*#txt) + +: Bym
pxy=. pxy <. (Sw,Sh) - wid,hit
box=. pxy,wid,hit
res=. box, glqpixels box
glbrush glrgb 1 { BoxColor
glpen 1 0 [ glrgb 0 { BoxColor
glrect box
pos=. pxy + Bxm,Bym
step=. 0,h
for_t. txt do.
  gltextxy pos
  gltext >t
  pos=. pos + step
end.
res
)

NB. =========================================================
drawmap=: 3 : 0
drawinit''
drawback''
drawpos''
glpaint''
)

NB. =========================================================
drawback=: 3 : 0
glbrush glrgb BackColor
glpen 1 0
glrect Sxywh
)

NB. =========================================================
drawinit=: 3 : 0
glsel Hwndc
glclear''
glcursor IDC_ARROW
Txywh=: i.0 4
Hdef=: ''
Hndx=: _1
)
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
NB. hover
NB.
NB. Hdef  - hover definition
NB. Hndx  - hover index

NB. =========================================================
clearhover=: 3 : 0
if. #Hdef do.
  glpixels Hdef
  glpaint''
  Hdef=: ''
  Hndx=: _1
end.
)

NB. =========================================================
NB. showhover
showhover=: 3 : 0
if. Hndx = y do. return. end.
clearhover''
Hndx=: y
hover Hndx { Sort,_1
)

NB. =========================================================
NB. hover event handler
NB. Index is location of mouse in source data, or _1 if not in window
hover=: 3 : 0
Index=: y
if. 1 = tmaphandler 'hover' do.
  hoverx''
end.
)

NB. =========================================================
hoverx=: 3 : 0
if. _1 = Hndx do. return. end.
showhoverdo ''
glpaint''
)

NB. =========================================================
showhoverdo=: 3 : 0
txt=. Hndx pick Note
'x y w h'=. Hndx { Txywh
pos=. (x,y) + Boxoff <. w,h
Hdef=: drawbox pos ; txt
)

NB. misc

NB. =========================================================
initmisc=: 3 : 0
len=. $DATA
Colors=: _3 [\ ,COLORS
if. 0=#COLOR do.
  Color=: len $ i.#Colors
else.
  Color=: len $ COLOR
end.
Sort=: \: DATA
Data=: Sort{DATA
assert. 0 <: {: Data
Label=: Sort{LABEL
Color=: Sort{Color
if. len = #NOTE do.
  IfNote=: 1
  Note=: Sort{NOTE
else.
  IfNote=: 0
  Note=: ''
end.
)
NB. mouse

NB. =========================================================
click=: 3 : 0
'Mx My Index Ctrl Shift'=: y
tmaphandler 'click'
)

NB. =========================================================
rclick=: 3 : 0
'Mx My Index Ctrl Shift'=: y
tmaphandler 'rclick'
)

NB. =========================================================
NB. mousexy
NB.
NB. returns xy position of mouse
mousexy=: 3 : '2 {. 0 ". sysdata__locP'

NB. =========================================================
NB. mousext
NB.
mousext=: 3 : '0 1 6 7 { 0 ". sysdata__locP'

NB. =========================================================
mbldown=: 3 : 0
'x y ctrl shift'=. mousext ''
ndx=. tmindex x,y
click x,y,ndx,ctrl,shift
)

NB. =========================================================
mbrdown=: 3 : 0
'x y ctrl shift'=. mousext ''
ndx=. tmindex x,y
rclick x,y,ndx,ctrl,shift
)

NB. =========================================================
mmove=: 3 : 0
xy=. mousexy''
if. xy inrect Sxywh do.
  showhover rectindex xy
else.
  clearhover''
end.
)

NB. =========================================================
rclick=: 3 : 0
'Mx My Index Ctrl Shift'=: y
tmaphandler 'rclick'
)
NB. pos

NB. =========================================================
drawpos=: 3 : 0
xy=. Rx,Ry
wh=. Rw,Rh
off=. Boxoff + Bxm,Bym
glfont FONT
row=. 0, {: glqextent 'X'
dat=. rounddint (*/wh) * Data % +/ Data
clr=. Color
lab=. Label
if. GRIDSHOW do.
  glpen 1 0 [ glrgb GRIDCOLOR
  pen=. ]
else.
  pen=. glpen
end.
while. #dat do.
  b=. >/ wh
  a=. b { wh
  s=. *: +/\ dat
  p=. (>.%) s % dat * *: a
  len=. 1 + p i. <./ p
  rec=. len {. dat
  wid=. roundint (+/rec) % a
  hit=. rounddint a * rec % +/ rec
  if. b do.
    y=. ({:xy) + 0,+/\}:hit
    rect=. ({.xy),.y,.1+wid,.hit
  else.
    x=. ({.xy) + 0,+/\}:hit
    rect=. x,.({:xy),.1+hit,.wid
  end.
  Txywh=: Txywh,rect
  for_r. rect do.
    glbrush glrgb (r_index{clr) { Colors
    pen 1 0
    glrect r
    pos=. off + 2 {. r
    for_t. <;._1 LF,>r_index{lab do.
      gltextxy pos
      gltext >t
      pos=. pos + row
    end.
  end.
  wh=. wh - wid * b ~: 0 1
  xy=. xy + wid * b ~: 0 1
  dat=. len }. dat
  clr=. len }. clr
  lab=. len }. lab
end.
'Tx Ty Tw Th'=: |: Txywh
EMPTY
)

NB. show

NB. =========================================================
showit=: 3 : 0
showitn y
glpaint''
)

NB. =========================================================
NB. showitn
showitn=: 3 : 0
initxywh ''
drawmap''
)

NB. =========================================================
refresh=: showit
NB. tmap
NB.
NB. defines treemap utility
NB.
NB. for nonce, only monadic use

require 'gtkwd'

TMAP=: 0 : 0
pc tmap;pn "Treemap";
xywh 0 0 300 200;cc tm isigraph ws_border rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
tmapdestroy=: 3 : 0
wd 'pclose'
destroy__tm''
codestroy''
)

NB. =========================================================
tmap_close=: tmap_cancel=: tmapdestroy

NB. =========================================================
treemap_z_=: 3 : 0
tmap_ptreemap_ y
:
(x;coname'') tmap_ptreemap_ y
)

NB. =========================================================
tmap=: 3 : 0
'' tmap y
:
a=. conew 'ptreemap'
x tmapshow__a y
)

NB. =========================================================
tmapshow=: 4 : 0
DATA=: y
LABEL=: NOTE=: 8!:0 DATA
wd TMAP
destroy=: tmapdestroy
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
tm=: '' conew 'ptreemap'
show__tm pack 'DATA LABEL NOTE'
wd 'pshow;'
evtloop^:(-.IFJ6)''
)
