require 'gui/gtkwd pack general/misc/font'

coclass 'jzgrid'
coinsert 'jgl2'
create=: 3 : 0
if. #y do.
  locP=: boxopen y
else.
  locP=: COCREATOR
end.
EMPTY
)
destroy=: 3 : 0
try.
  glsel GRIDHWNDC
  capture 0
catch. end.
codestroy''
)
ALPHA=: a. {~ (a.i.'A') + i.26
BOXEMPTY=: <''
EMPTY=: i.0 0
BOXTYPE=: 32
SPARSETYPE=: 1024 2048 4096 8192 16384 32768
CHARTYPE=: 2 131072
kbBS=: GDK_BackSpace_jgtk_
kbLF=: GDK_Linefeed_jgtk_
kbENTER=: GDK_Return_jgtk_
kbPUP=: GDK_Page_Up_jgtk_
kbPDOWN=: GDK_Page_Down_jgtk_
kbEND=: GDK_End_jgtk_
kbHOME=: GDK_Home_jgtk_
kbLEFT=: GDK_Left_jgtk_
kbUP=: GDK_Up_jgtk_
kbRIGHT=: GDK_Right_jgtk_
kbDOWN=: GDK_Down_jgtk_
kbESC=: GDK_Escape_jgtk_
kbINS=: GDK_Insert_jgtk_
kbDEL=: GDK_Delete_jgtk_
NonAlfaNum=: (GDK_F1_jgtk_ + i.12), GDK_BackSpace_jgtk_, GDK_Tab_jgtk_, GDK_Linefeed_jgtk_, GDK_Clear_jgtk_, GDK_Return_jgtk_
NonAlfaNum=: NonAlfaNum, GDK_Pause_jgtk_, GDK_Scroll_Lock_jgtk_, GDK_Sys_Req_jgtk_, GDK_Escape_jgtk_, GDK_Delete_jgtk_
NonAlfaNum=: NonAlfaNum, GDK_Home_jgtk_, GDK_Left_jgtk_, GDK_Up_jgtk_, GDK_Right_jgtk_, GDK_Down_jgtk_
NonAlfaNum=: NonAlfaNum, GDK_Prior_jgtk_, GDK_Page_Up_jgtk_, GDK_Next_jgtk_, GDK_Page_Down_jgtk_, GDK_End_jgtk_
NonAlfaNum=: NonAlfaNum, GDK_Begin_jgtk_, GDK_Insert_jgtk_, GDK_Menu_jgtk_, GDK_Num_Lock_jgtk_, GDK_Shift_L_jgtk_
NonAlfaNum=: NonAlfaNum, GDK_Shift_R_jgtk_, GDK_Control_L_jgtk_, GDK_Control_R_jgtk_, GDK_Caps_Lock_jgtk_, GDK_Shift_Lock_jgtk_
NonAlfaNum=: NonAlfaNum, GDK_Meta_L_jgtk_, GDK_Meta_R_jgtk_, GDK_Alt_L_jgtk_, GDK_Alt_R_jgtk_, GDK_Super_L_jgtk_
NonAlfaNum=: NonAlfaNum, GDK_Super_R_jgtk_, GDK_Hyper_L_jgtk_, GDK_Hyper_R_jgtk_
alfndx=: 3 & u:
assign=: 4 : '".x,''=:y'''
boxitem=: ,`(<"_1) @. (0=L.)
boxstrings=: ,`(<"_1) @. (2=3!:0)
citemize=: ,:^:(2 > #@$)
colorinv=: 255&-
distint=: [: (- 0 , }:) [: <. 0.5 + +/\
flips=: ]
fmt=: 8!:0
if=: ^:
index=: #@[ (| - =) i.
intersect=: e. # [
is1color=: 3 = */ @ $
isboxed=: 0 < L.
ischar=: 3!:0 e. CHARTYPE"_
isnum=: [: -. 3!:0 e. (CHARTYPE,BOXTYPE)"_
isextended=: 3!:0 e. 64 128"_
isempty=: 0 e. $
isinteger=: (-: <.) :: 0:
is1integer=: ({. -: <.) :: 0:
isscalar=: 0 = #@$
issparse=: (1[3$.]) :: 0:
join=: ,.&.>/
lfp=: #;.1
parens=: '('"_ , ": , ')'"_
partition=: 1 , [: -. }. -:"_1 }:
rank=: #@$
reshape=: $,
rounddown=: [ * [: <. %~
roundint=: <.@:+&0.5
rots=: ]
sortfns=: /:`\: @.
stretch=: [ $ ] , ($ ,: @ {:)
takeboxed=: {. !. BOXEMPTY
tolist=: }. @ ; @: (LF&, @ , @ ": each)
tomatrix=: (_2 {. 1 1 , $) $ ,
tominus=: '-'&(I. @(e.&'_')@]})
towords=: ;: inverse
qextenth=: {: @ glqextent
qextentw=: {. @ glqextent
qextentwv=: glqextentw @ ; @: (,each&LF)
qextentwm=: $ $ qextentwv@,
qextentw16=: qextentw @ utf8
qextentW=: 3 : 0
glfont y
glqextent 'W'
)
amendx=: 2 : 0
:
if. m >: #y do.
  x m } (m+1) {.!.n y
else.
  x m } y
end.
)
ascii2utf8=: 3 : 0
y=. a. i. y
y=. y #~ 1 j. 127 < y
c=. y {~ ndx=. I. 127 < y
n=. 192 128 +"1 [ 0 64 #: c
a. {~ n (ndx +/ 0 1) } y
)
capture=: 3 : 0
glcapture Capture=: y
)
dimsum=: 4 : 0
s=. 1 x}$y
r=. (#$y) - x
s reshape +/"r y
)
dimtotal=: 4 : 0
r=. (#$y) - x
y ,"(r-0 1) +/"r y
)
fits=: 4 : 0
'tot wid'=. y
sum=. +/ wid
if. (0 = +/x) +. tot <: sum do. wid return. end.
scl=. (#wid) stretch x
distint wid + (tot - +/wid) * scl % +/ scl
)
fmt01=: 3 : 0
dat=. ":!.9 y
'-' (I. dat='_') } dat
)
fmtndx=: 3 : 0
if. GridVirtualMode do.
  y - each Cy,Cx
else.
  y
end.
)
fontscale=: 4 : 0
(roundint x*getfontsize y) setfontsize y
)
getcellfont=: 3 : 0
if. #$CellFont do.
  ((<y) { CellFont) pick CellFonts
else.
  CellFont pick CellFonts
end.
)
getindex=: 4 : 0
if. #$y do. x { y else. y end.
)
getspans=: 3 : 0
getspans1 "1 +./\ (1,}.~:}:)"1 y
)
getspans1=: 3 : 0
len=. #;.1 y
(len # I.y),:len # len
)
getalpha=: 3 : 0
<"1 (26 #. ^:_1 y) { ALPHA
)
getxywhx=: 0 0,glqwh
gpixel=: 3 : 0
glcmds ,4 2024 ,"1 y
)
gridfocus=: 3 : 0
if. IFUNIX >: GRIDID -: sysfocus__locV do.
  wd 'setfocus ',GRIDID
end.
)
info=: 3 : 0
wdinfo 'Grid';y
)
inint=: 4 : 0
(x >: {.y) *. x <: +/ y
)
inrect=: 4 : 0
if. 0 = # y do. 0 return. end.
'px py'=. x
'x y w h'=. |: y
1 e. (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
)
inrectx=: 4 : 0
if. 0 = #y do. 0 return. end.
'px py'=. x
'x y w h'=. |: y
1 i.~ (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
)
ispk=: 3 : 0
select. L. y
case. 0 do. 0
case. 1 do.
  if. 2 ~: {:$y do. 0 return. end.
  1 < >./ #@$ each y
case. do. 1
end.
)
makepattern=: 4 : 0
pat=. 1 1 0
step=. # pat
len=. pat i. 0
off=. - <. -: len
cnt=. >. y % step
px=. off + step * i.cnt
pr=. px + len
(x+0>.px);x+pr<.y
)
makedots=: 3 : 0
'w h'=. 0 >. y
x=. h # i.w
y=. (w*h) $ i.h
m=. 2 | x + y
(m#x),.m#y
)
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
runbegin=: 1: , }. ~: }:
setnamesx=: 3 : 0
if. L. y do.
  unpack y
else.
  locP readloc y
end.
)

setnames=: setnamesx
shrinkrect=: 4 : 0
x + , 1 _1 * +/\ _2 [\ 4 $ y
)
stretch=: [ $ ] , ($ ,: @ {:)
sumtomax=: 4 : 0
+/\ ^:_1 x <. +/\ y
)
unpack=: 3 : 0
if. 0 e. $y do. '' return. end.
y=. citemize y
nms=. toupper each {."1 y
(nms)=: {:"1 y
nms
)
leftarrow=: 3 : 0
'w h p'=. y
m=. (|.,}.) <:/~ i.p
m=. h {. (1 - p + >. -: h + 1) {. m
w {."1 (- <. -: p + w) {."1 m
)
uparrow=: 3 : 0
'w h p'=. y
|: leftarrow h,w,p
)
makearrowsLR=: 3 : 0
'whp c'=. y
c=. _2 [\ 256 #. _3[\,c
a=. (leftarrow whp) {"2 1 c
b=. |."1 a
wh=. 2{.whp
(wh,"1 ,"2 a) ; wh ,"1 ,"2 b
)
makearrowsUD=: 3 : 0
'whp c'=. y
c=. _2 [\ 256 #. _3[\,c
a=. (uparrow whp) {"2 1 c
b=. |."2 a
wh=. 2{.whp
(wh,"1 ,"2 a) ; wh ,"1 ,"2 b
)
clipfmt=: 3 : 0
if. 0 e. $y do. '' return. end.
t=. 3!:0 y
if. 2=t do.
  y=. ,y,"1 CRLF
elseif. 32<:t do.
  y=. ,&TAB @ ": &.>y
  y=. ;,&CRLF@}: &.><@;"1 y
elseif. 1 do.
  y=. ;,&CRLF @ ": &.><"1 y
  y=. '-' ((# i.@#)y='_') } y
  y=. TAB ((# i.@#)y=' ') } y
end.
y
)
clipunfmt=: 3 : 0
if. 0 e. $y do. 0 0 $ a: return. end.
(<;._2~ e.&(9 10{a.));.2 y,LF -. {:y=. toJ y
)
WDCOLORSDEF=: 0&".;._2 (0 : 0)
212 208 200
  0 128 128
  0  84 227
122 150 223
255 255 255
255 255 255
  0   0   0
  0   0   0
  0   0   0
255 255 255
212 208 200
212 208 200
128 128 128
 49 106 197
255 255 255
236 233 216
172 168 153
172 168 153
  0   0   0
216 228 248
255 255 255
113 111 100
241 239 226
  0   0   0
255 255 225
)
WDCOLORS=: <;._2 (0 : 0)
COLOR_SCROLLBAR
COLOR_BACKGROUND
COLOR_ACTIVECAPTION
COLOR_INACTIVECAPTION
COLOR_MENU
COLOR_WINDOW
COLOR_WINDOWFRAME
COLOR_MENUTEXT
COLOR_WINDOWTEXT
COLOR_CAPTIONTEXT
COLOR_ACTIVEBORDER
COLOR_INACTIVEBORDER
COLOR_APPWORKSPACE
COLOR_HIGHLIGHT
COLOR_HIGHLIGHTTEXT
COLOR_BTNFACE
COLOR_BTNSHADOW
COLOR_GRAYTEXT
COLOR_BTNTEXT
COLOR_INACTIVECAPTIONTEXT
COLOR_BTNHIGHLIGHT
COLOR_3DDKSHADOW
COLOR_3DLIGHT
COLOR_INFOTEXT
COLOR_INFOBK
)

(WDCOLORS)=: WDCOLORSDEF

COLORBACK=: COLOR_BTNFACE

BLACK=: 0 0 0
BLUE=: 0 0 255
BLUESEL=: 51 102 204
CORAL=: 255 127 80
DARKSLATEGRAY=: 47 79 79
DARKGRAY=: 169 169 169
LIGHTSEAGREEN=: 32 178 170
PALEYELLOW=: 255 255 205
RED=: 255 0 0
SILVER=: 192 192 192
WHITE=: 255 255 255
state=: 3 : 0
s=. (> , ': '"_ , 5!:5)"0
CellData=. $ CellData
CellDFmt=. $ CellDFmt
Scrollrc=. Scrollr,Scrollc
n=. 'CellData CellDFmt'
n=. n,' CELLMARK'
n=. n,' Cxyst Cxyst'
n=. n,' FmtMax Slack MaxSRows MaxSCols'
n=. n,' MaxDataRows MaxDataCols'
n=. n,' Scrollrc'
s ;: n
)
coclass 'jzgrid'
show=: 3 : 0
if. 0=#locP do.
  locP=: COCREATOR
end.
setnames y
initevents''
drawinit''
setrxywh getxywhx''
refresh''
)
paint=: 3 : 0
xywh=. getxywhx ''
inc=. 1 e. (Rw,Rh) < _2 {. xywh
setrxywh xywh
State=: State * State e. StateResize
ShowMark=: 0
showitn inc { 3 5
)
setrxywh=: 3 : 0
'Rx Ry Rw Rh'=: Rxywh=: y
)
initxywh=: 3 : 0
'Sx Sy Sw Sh'=: Sxywh=: Rxywh + Roff * 1 1 _1 _1
Gx=: Sx
Gy=: Sy
Gxy=: Gx,Gy
)
iLET=: 0
iRIGHT=: 1
iCENTER=: 2

GridZinc=: 1.1
MaxNdx=: 1e9
Cx=: Cy=: ''
CellDP=: ''
SortIndex=: ''

locP=: ''
NaN=: __

NoShow=: 0

'Scw Sch'=: 2 {. 0 ". wd :: ('800 600'"_) 'qm'
Roff=: 0
Hier=: 0
Sparse=: 0
Sparse0=: <''
Cube=: 0
CMx=: 8
CMy=: 6
NewMark=: 0
Show=: 0
ShowMark=: 1
Ebufmax=: 50

Mouseup=: ''
Mousetime=: 0
Mousewait=: 0.2
Mousetol=: 2
VSlack=: 5
Slack=: 0

SBh=: SBv=: 0
HdrColWid=: HdrRowWid=: ''
HdrColPad=: 0
HdrRowPad=: 0
CBSize=: 13
CBDots=: 0 2 5 8 11 14 16 ,: 1 4 7 10 13 15 17
MinTh=: 50
MinTw=: 25
MinScrollv=: 1000
MaxScrollr=: MaxScrollc=: 0
Scrollr=: Scrollc=: 0
HDRFONT=: PROFONT
CELLFONTS=: PROFONT;FIXFONT
CELLFONT=: 0
j=. COLOR_BTNTEXT,COLOR_BTNFACE,COLOR_BTNSHADOW,COLOR_BTNHIGHLIGHT
GRIDBUTTONCOLOR=: j,COLOR_3DDKSHADOW,COLOR_3DLIGHT
AXISNAMES=: ''
AXISLABELS=: ''
AXISORDER=: ''
j=. WHITE,BLUESEL,WHITE,LIGHTSEAGREEN,WHITE,CORAL
c0=. BLACK,PALEYELLOW,j
c1=. BLACK,WHITE,j
CELLCOLORS=: c0,:c1

CELLALIGN=: 2
CELLALIGNV=: 0
CELLCOLORDEF=: ,.0 1
CELLCOLOR=: $0
CELLDATA=: i.0 0
CELLDRAW=: i.0 0
CELLEDIT=: 1
CELLHIGH=: 0
CELLMARK=: $0
CELLMARKER=: 1
CELLMASK=: 0
CELLMASKCOLOR=: ''
CELLOVERFLOW=: 0
CELLRANGE=: ''
CELLITEMS=: ''
CELLTYPE=: 0
CELLFMT=: ''
COLAUTOFIT=: 1
COLSCALE=: ''
COLWIDTH=: 0
COLRESIZE=: 0
COLMINWIDTH=: 20
COLTOTAL=: 0
GRIDBACKCOLOR=: COLORBACK
GRIDCOLOR=: SILVER,BLACK,WHITE,DARKGRAY,DARKSLATEGRAY
GRIDEXTERN=: ''
GRIDZOOM=: 1
GRIDFLIP=: 0
GRIDMARGIN=: 4 6 2 0
GRIDWINDOW=: 0
GRIDID=: 'grid'
GRIDHWNDC=: ''
GRIDPID=: ''
GRIDLOC=: ''

GRIDBORDER=: 0
GRIDESCCANCEL=: 0
GRIDFORMEVENTS=: 0
GRIDLINES=: 1 1
GRIDSBMINWIDTH=: 0
GRIDSORT=: 0
GRIDROWMODE=: 0
GRIDVIRTUALMODE=: 0
HDRCOLOR=: (3 4 5 { GRIDBUTTONCOLOR),BLACK
HDRCOL=: ''
HDRCOLALIGN=: 1
HDRCOLMERGE=: ''
HDRCOLTOTAL=: 'Total'
HDRROW=: ''
HDRROWALIGN=: 1
HDRROWMERGE=: ''
HDRROWTOTAL=: 'Total'
HDRTOP=: ''
HDRTOPALIGN=: 1
HDRSTYLE=: 1
LVLCOL=: ''
LVLCOLTOP=: 0
LVLCOLLEN=: 1
LVLCOLID=: ''
LVLCOLMASK=: ''
LVLCOLSORTDIR=: 0
LVLCOLSORTROW=: ''
LVLROW=: ''
LVLROWTOP=: 0
LVLROWLEN=: 1
LVLROWID=: ''
LVLROWMASK=: ''
LVLROWSORTDIR=: 0
LVLROWSORTCOL=: ''
MENUCOLOR=: COLOR_MENUTEXT,COLOR_MENU,COLOR_HIGHLIGHTTEXT,COLOR_HIGHLIGHT
ROWTOTAL=: 0
ROWMINHEIGHT=: 10
OPTIONS=: <;._2 (0 : 0)
AXISLABELS
AXISNAMES
AXISORDER
CELLALIGN
CELLALIGNV
CELLCOLOR
CELLCOLORS
CELLDATA
CELLDRAW
CELLEDIT
CELLFMT
CELLFONT
CELLFONTS
CELLHIGH
CELLITEMS
CELLMARK
CELLMARKER
CELLMASK
CELLMASKCOLOR
CELLOVERFLOW
CELLRANGE
CELLTYPE
COLAUTOFIT
COLMINWIDTH
COLRESIZE
COLSCALE
COLTOTAL
COLWIDTH
GRIDBACKCOLOR
GRIDBORDER
GRIDBUTTONCOLOR
GRIDCOLOR
GRIDESCCANCEL
GRIDEXTERN
GRIDFLIP
GRIDHWNDC
GRIDID
GRIDPID
GRIDLINES
GRIDLOC
GRIDMARGIN
GRIDROWMODE
GRIDSBMINWIDTH
GRIDSORT
GRIDVIRTUALMODE
GRIDWINDOW
GRIDZOOM
HDRCOL
HDRCOLALIGN
HDRCOLMERGE
HDRCOLOR
HDRCOLTOTAL
HDRFONT
HDRROW
HDRROWALIGN
HDRROWMERGE
HDRROWTOTAL
HDRSTYLE
HDRTOP
HDRTOPALIGN
LVLCOL
LVLCOLTOP
LVLCOLLEN
LVLCOLID
LVLCOLMASK
LVLCOLSORTDIR
LVLCOLSORTROW
LVLROW
LVLROWTOP
LVLROWLEN
LVLROWID
LVLROWMASK
LVLROWSORTDIR
LVLROWSORTCOL
ROWMINHEIGHT
ROWTOTAL
)
initcell=: 3 : 0

'rws cls'=. rots Crws,Ccls
if. 0 = #cc=. CELLCOLOR do.
  cc=. CELLCOLORDEF
end.
if. 1 = */ $ cc do.
  CellColor=: {. cc
else.
  CellColor=: rws $ cls $"1 tomatrix cc
end.
if. 1 = */ $ CELLEDIT do.
  CellEdit=: {. CELLEDIT
else.
  CellEdit=: rws $ cls $"1 tomatrix CELLEDIT
end.
if. 1 = */ $ CELLFONT do.
  CellFont=: {. CELLFONT
else.
  CellFont=: rws $ cls $"1 tomatrix CELLFONT
end.
if. 0 -: CELLHIGH do.
  CellHigh=: 0
else.
  CellHigh=: rws $ cls $"1 tomatrix CELLHIGH
end.
if. 0 -: CELLOVERFLOW do.
  CellOverFlow=: 0
else.
  CellOverFlow=: rws $ cls $"1 tomatrix CELLOVERFLOW
end.
if. 0 -: CELLMASK do.
  CellMask=: 0
else.
  CellMask=: rws $ cls $"1 tomatrix CELLMASK
  CellMaskColor=: CELLMASKCOLOR,(0=#CELLMASKCOLOR)#{.GridBackColor
end.
if. 1 = */ $ CELLTYPE do.
  if. CELLTYPE do.
    CellType=: (rws,cls) $ CELLTYPE
  else.
    CellType=: 0
  end.
else.
  CellType=: rws $ cls $"1 tomatrix CELLTYPE
end.
if. 0 -: CellType do.
  if. 1 = */ $ CELLALIGN do.
    CellAlign=: {. , CELLALIGN
  else.
    CellAlign=: rws $ cls $"1 tomatrix CELLALIGN
  end.
else.
  if. 1 = */ $ CELLALIGN do.
    if. CELLALIGN = 0 do.
      CellAlign=: 0
    else.
      CellAlign=: (-.iscombo CellType) * (rws,cls) $ CELLALIGN
    end.
  else.
    CellAlign=: (-.iscombo CellType) * rws $ cls $"1 tomatrix CELLALIGN
  end.
end.
cf=. CELLFMT
if. #cf do.
  select. 3!:0 cf
  case. 2 do.
    cf=. <;._1 ',' , cf
  case. 32 do.
    cf=. ":each cf
  end.
  select. #$cf
  case. 1 do.
    if. 1 = #cf do.
      cf=. {. cf
    else.
      cf=. cls $ cf
    end.
  case. 2 do.
    cf=. rws $ cls $"1 cf
  end.
end.
CellFmt=: cf
EMPTY
)
j=. 'mbldbl mbldown mblup mbmdown mbmdbl mbmup mbrdbl mbrdown mbrup mmove mwheel'
EVENTS=: ;: j,' char copy focus focuslost paint paste print undo'
initevents=: 3 : 0

if. #GRIDPID do.
  pid=. GRIDPID
else.
  pid=. getparentid locP
end.
GridPid=: pid
if. 3=nameclass__locP <GRIDID,'_gridhandler' do.
  makehandler GRIDID,'_gridhandler__locP'
else.
  gridhandler=: 1:
end.
if. 0=#GRIDLOC do. GRIDLOC=: GRIDID end.
if. 0=#GRIDHWNDC do.
  GRIDHWNDC=: wd 'qhwndc ',GRIDID
end.
if. GRIDFORMEVENTS do.
  locV=: locP
  if. 0=nameclass__locP <GRIDLOC do.
    if. (coname'') -: (GRIDLOC,'__locP')~ do.
      f=. (<pid,'_',GRIDID,'_') ,each EVENTS
      m=. _1 = nameclass__locP f
      if. 1 e. m do.
        t=. (m#EVENTS) ,each <'__',GRIDLOC,LF
        t=. ;(m#f) ,each (<'=: ') ,each t
        cocurrent locP
        0!:100 t
      end.
    end.
  end.
else.
  locV=: coname''
  glsel GRIDHWNDC
  wd 'setlocale ',GRIDID,' ',>locV
  f=. (<pid,'_',GRIDID,'_') ,each EVENTS
  t=. ;f ,each (<'=: ') ,each EVENTS ,each LF
  0!:100 t
end.
0
)
getparentid=: 3 : 0
fms=. <;._2;._2 wd 'qpx'
act=. 0 ". &> 4 {"1 fms
fms=. fms \: (act=0),.act
ndx=. (2 {"1 fms) i. y
0 pick ndx { fms
)
makehandler=: 3 : 0
a=. 'r=. ',y,' y',LF
a=. a,'if. 0 e. $r do. 1 else. {.,r end.'
gridhandler=: 3 : a
EMPTY
)
initextents=: 3 : 0
glfont HdrFont
HdrRowHex=: qextentwm HdrRow
HdrTopHex=: qextentwm HdrTop
HdrCellWid=: qextentwm HdrCol
SBHit=: GRIDSBMINWIDTH >. HdrHit + My
if. #CELLITEMS do.
  r=. i.0 0
  for_f. CellFonts do.
    glfont >f
    r=. r,(>./ @: qextentwv) &> CELLITEMS
  end.
  CellItemsHex=: r
end.
if. #HdrRowMerge do.
  if. Cube do.
    'Hrmbgn Hrmlen'=: ARspan
  else.
    'Hrmbgn Hrmlen'=: 0 2 |: getspans HdrRowMerge { |: HdrRow
  end.
else.
  Hrmbgn=: Hrmlen=: ''
end.

gethdrcolwid''
)
gethdrcolwid=: 3 : 0
if. 0=#HdrCol do.
  Hcmbgn=: Hcmlen=: ''
  HdrColWid=: ({:$HdrCol)$0
else.
  if. #HdrColMerge do.
    if. Cube do.
      'Hcmbgn Hcmlen'=: ACspan
    else.
      'Hcmbgn Hcmlen'=: 0 2 |: getspans HdrColMerge { HdrCol
    end.
    HdrColWid=: >./ (>. (HdrColMerge { HdrCellWid) % Hcmlen) HdrColMerge } HdrCellWid
  else.
    Hcmbgn=: Hcmlen=: ''
    HdrColWid=: >./ HdrCellWid
  end.
end.
HdrColWid=: HdrColWid + HdrColPad
EMPTY
)
initflip=: 3 : 0
if. GRIDFLIP do.
  flips=: |:
  rots=: |.
  ColScale=: ''
  ColWidth=: 0
  ColAutoFit=: 1
else.
  flips=: ]
  rots=: ]
  ColScale=: COLSCALE
  ColWidth=: COLWIDTH
  ColAutoFit=: COLAUTOFIT
end.
)
flip=: 3 : 0

if. Cube do. flipcube'' return. end.

GRIDFLIP=: -. GRIDFLIP
initflip''
'Scrollr Scrollc'=: Scrollc,Scrollr
if. 4 = #CELLMARK do.
  CELLMARK=: 1 0 3 2 { CELLMARK
else.
  CELLMARK=: |. CELLMARK
end.

'Crws Ccls'=: Ccls,Crws
if. GridVirtualMode do.
  showit 4 return.
end.
if. GRIDFLIP *. COLAUTOFIT=0 do.
  showit 4 return.
end.
HdrTop=: |: HdrTop
HdrTopHex=: |: HdrTopHex
hr=. |: HdrCol
hra=. |: HdrColAlign
hrm=. HdrColMerge
hrx=. |: HdrCellWid
hrmb=. Hcmbgn
hrml=. Hcmlen
if. 0=#HdrColWid do.
  gethdrcolwid''
end.
hrw=. HdrColWid
HdrCol=: |:HdrRow
HdrColAlign=: |: HdrRowAlign
HdrColMerge=: HdrRowMerge
HdrCellWid=: |: HdrRowHex
Hcmbgn=: Hrmbgn
Hcmlen=: Hrmlen
if. 0=#HdrRowWid do.
  gethdrcolwid''
else.
  HdrColWid=: HdrRowWid
end.
HdrRow=: hr
HdrRowAlign=: hra
HdrRowMerge=: hrm
HdrRowHex=: hrx
Hrmbgn=: hrmb
Hrmlen=: hrml
HdrRowWid=: hrw
Hc=: {:$HdrRow
Hr=: #HdrCol
if. ColAutoFit do.
  getcellwid''
end.
getcellhit''
showit 1
)
initheader=: 3 : 0

HdrCol=: 8 u: each gethdrcol HDRCOL
HdrRow=: 8 u: each gethdrrow HDRROW
if. GRIDFLIP do.
  hc=. HdrCol
  HdrCol=: |: HdrRow
  HdrRow=: |: hc
  HdrColAlign=: (#HdrCol) $ Ccls $"1 tomatrix HDRROWALIGN
  HdrRowAlign=: Crws $ ({:$HdrRow) $"1 tomatrix HDRCOLALIGN
  HdrColMerge=: I. HDRROWMERGE
  HdrRowMerge=: I. HDRCOLMERGE
  if. #HDRTOP do.
    HdrTop=: ((#HdrCol),{:$HdrRow) takeboxed |: tomatrix boxopen HDRTOP
    HdrTopAlign=: (#HdrTop) $ (({:$HdrTop)) $"1 |: tomatrix HDRTOPALIGN
  else.
    HdrTop=: ''
  end.
else.
  HdrColAlign=: (#HdrCol) $ Ccls $"1 tomatrix HDRCOLALIGN
  HdrRowAlign=: Crws $ ({:$HdrRow) $"1 tomatrix HDRROWALIGN
  HdrColMerge=: I. HDRCOLMERGE
  HdrRowMerge=: I. HDRROWMERGE
  if. #HDRTOP do.
    HdrTop=: ((#HdrCol),{:$HdrRow) takeboxed tomatrix boxopen HDRTOP
    HdrTopAlign=: (#HdrTop) $ (({:$HdrTop)) $"1 tomatrix HDRTOPALIGN
  else.
    HdrTop=: ''
  end.
end.

if. Cube do.
  HdrRowMerge=: }: i.#0 pick AXISORDER
  HdrColMerge=: }: i.#1 pick AXISORDER
end.
Hc=: {:$HdrRow
Hr=: #HdrCol
)
gethdrcol=: 3 : 0
hc=. y
if. GridVirtualMode do.
  len=. >: Cs - Cx
else.
  len=. >: Cs - Cx
end.
if. 0 = #hc do.
  i.0,len
elseif. 1 = */$hc do.
  ndx=. Cx + i. len
  if. isinteger hc do.
    ,: ": each ({.hc) + ndx
  elseif. 'A' = hc do.
    ,: getalpha ndx
  elseif. do.
    (1,len) $ ,boxopen hc
  end.
elseif. do.
  len {."1 tomatrix boxxopen hc
end.
)
gethdrrow=: 3 : 0
hr=. y
if. GridVirtualMode do.
  len=. >: Ct - Cy
else.
  len=. >: Ct - Cy
end.
if. 0 = #hr do.
  hr=. i.len, 0
elseif. 1 = */$hr do.
  ndx=. Cy + i. len
  if. isinteger hr do.
    ,. ": each ({.hr) + ndx
  elseif. 'A' = hr do.
    ,. getalpha ndx
  elseif. do.
    (len,1) $ ,boxopen hr
  end.
  if. #SortIndex do.
    SortIndex { hr
  end.
elseif. do.
  len {. ,. boxxopen hr
end.
)
initmisc=: 3 : 0

if. 0=#GRIDEXTERN do.
  drawextern=: ]
else.
  drawextern=: GRIDEXTERN~
end.
Cube=: 0 < #AXISNAMES
Hier=: 0 < (#LVLCOL) + #LVLROW
gw=. 4 {. GRIDWINDOW
Roff=: GridWindow=: gw + 0 0,2{.gw
GridVirtualMode=: GRIDVIRTUALMODE
if. GridVirtualMode do.
  Slack=: VSlack
  GridSort=: 0 0
else.
  Slack=: 0
  if. Cube do.
    GridSort=: (#$CELLDATA) $ GRIDSORT
  else.
    GridSort=: 2$GRIDSORT
  end.
end.
ButtonColor=: 6 3 $ GRIDBUTTONCOLOR
GridBackColor=: 2 3 $ GRIDBACKCOLOR
GridColor=: 5 3 $ GRIDCOLOR
MenuColor=: 4 3 $ MENUCOLOR
ColResize=: COLRESIZE *. COLAUTOFIT=0
a=. _6 [\ ,24 $"1 CELLCOLORS
CellColorFore=: 3 {."1 a
CellColorBack=: 3 }."1 a
if. 6=$HDRCOLOR do.
  HdrColor=: _3 [\ HDRCOLOR,(colorinv HDRCOLOR), HDRCOLOR
else.
  HdrColor=: 6 3 $ HDRCOLOR
end.

OffColor=: 0 { HdrColor
OnColor=: <. 4 %~ +/ 3 1 * 1 2 { ButtonColor
GridLines=: 2 $ GRIDLINES
CellFonts=: , boxxopen CELLFONTS

ColWidth=: COLWIDTH
RowHeight=: 0
HdrFont=: HDRFONT
glfont HdrFont
HdrHit=: qextenth 'X'
'Mx Mw My Mh'=: GRIDMARGIN
Mx2=: +:Mx
My2=: +:My
'w h'=. <./ qextentW &> CellFonts
MinW=: w + Mw + Mx2
MinH=: h + My2
)
initrange=: 3 : 0
if. -. GridVirtualMode do. return. end.
if. #CELLRANGE do.
  Txyst=: 0 0,2 {. CELLRANGE <. MaxNdx
else.
  Txyst=: 0 0, 2 # MaxNdx
end.
'Tx Ty Ts Tt'=: Txyst
'Cx Cy Cs Ct'=: Cxyst=: Txyst
Twh=: 1 + (Ts - Tx),Tt - Ty
)
showit=: 3 : 0
showitn y
glpaint''
)
showitn=: 3 : 0
select. Show >. {. y,0
fcase. 5 do.
  initmisc''
  inithier''
  initflip''
  initzoom''
  initrange''
  initcube''
fcase. 4 do.
  if. GridVirtualMode > Hier do.
    getdata'' return.
  end.
fcase. 3 do.
  initxywh ''
  initaxes''
  initdata''
  initcell''
  initheader''
  initextents''
fcase. 2 do.
  getfmt ''
  getextent''
fcase. 1 do.
  initsizes''
end.

Show=: 0
if. ShowMark do.
  if. showmark'' do. return. end.
else.
  if. showscroll'' do. return. end.
end.
ShowMark=: 1
if. NoShow do.
  NoShow=: 0 return.
end.
drawgrid''
if. NewMark do.
  mark ''
  NewMark=: 0
end.

1
)
showitempty=: 3 : 0
Crws=: Ccls=: 0
Hc=: Hr=: Hx=: Hy=: Hw=: Hh=: 0
VSxywh=: HSxywh=: Gxywh=: 0 0 0 0
Vcx=: Vcy=: 0
drawinit''
glpaint''
)
refresh=: showit bind 5
initsizes=: 3 : 0

RowHeights=: ((Hr$HdrHit), Crws$CellHit) + My2
if. ColAutoFit do.
  wid=. (>./HdrTopHex,HdrRowHex+HdrRowPad), HdrColWid >. CellWid
  wid=. ColWidth >. wid + Mw + Mx2
else.
  wid=. (Hc + Ccls) $ ColWidth
end.
colwid=. ColMinWidth >. wid
Hw=: +/ Hcw=: Hc {. colwid
Hh=: +/ Hrh=: Hr {. RowHeights
Hx=: }: +/\ Gx, Hcw
Hy=: }: +/\ Gy, Hrh
Hwh=: Hw,Hh
datacolwid=. Hc }. colwid
if. GridVirtualMode do.
  sv=. Trws > Crws
  sh=. Tcls > Ccls
else.
  sv=. sh=. 0
end.
if. sv +. Sh <: +/ RowHeights do.
  SBv=: 1
  if. #ColScale do.
    ColWidths=: Hcw,ColScale fits (Sw-1+Hw+SBHit);datacolwid
  else.
    ColWidths=: colwid
  end.
  SBh=: sh +. Sw <: SBHit + +/ ColWidths
else.
  if. #ColScale do.
    ColWidths=: Hcw,ColScale fits (Sw-1+Hw);datacolwid
  else.
    ColWidths=: colwid
  end.
  if. sh +. Sw <: +/ ColWidths do.
    SBh=: 1
    SBv=: sv +. Sh <: SBHit + +/ RowHeights
    if. SBv *. #ColScale do.
      ColWidths=: Hcw,ColScale fits (Sw-1+Hw+SBHit);datacolwid
    end.
  else.
    SBv=: SBh=: 0
  end.
end.
Gw=: Sw - SBv * SBHit
Gh=: Sh - SBh * SBHit
Gxywh=: Gx,Gy,Gw,Gh

ch=. 0 >. Gh - Hh
cw=. 0 >. Gw - Hw

Dw=: Hc }. ColWidths
Dh=: Hr }. RowHeights

MaxDataRows=: >. ch % <./ Dh
MaxDataCols=: >. cw % <./ Dw
mr=. (ch >: +/\. Dh ) i. 1
mc=. (cw >: +/\. Dw ) i. 1

if. GridVirtualMode do.
  if. Trws < MaxNdx do.
    MaxScrollr=: Trws + mr - #Dh
  else.
    MaxScrollr=: MaxScrollr >. MinScrollv >. +: Scrollr
  end.
  if. Tcls < MaxNdx do.
    MaxScrollc=: Tcls + mc - #Dw
  else.
    MaxScrollc=: MaxScrollc >. MinScrollv >. +: Scrollc
  end.
else.
  MaxScrollr=: mr
  MaxScrollc=: mc
end.
ScrollrInc=: 1 >. <. MaxScrollr % 100
ScrollcInc=: 1 >. <. MaxScrollc % 100
Scrollr=: Scrollr <. MaxScrollr
Scrollc=: Scrollc <. MaxScrollc
)
j=. <;._2 (0 : 0)
Normal normal
Edit edit
Select select
HSlider horizontal slider
VSlider vertical slider
CResize column resize
RResize row resize
Check checkbox clicked
Combo combobox clicked
ACombo axis combobox clicked
XCombo external combobox clicked
AMove axis move
)

('i' ,each (j i.&> ' ') {.each j)=: i.#j
iCombos=: iCombo;iACombo;iXCombo

State=: 0
StateResize=: iEdit,iSelect,iCheck,;iCombos
StateRowMark=: iNormal,iCheck,iCombo
redo=: 3 : 0
if. State = iEdit do.
  editredo''
end.
)
undo=: 3 : 0
if. State = iEdit do.
  editundo''
end.
)
initzoom=: 3 : 0
if. GRIDZOOM ~: 1 do.
  HdrFont=: GRIDZOOM fontscale HdrFont
  CellFonts=: GRIDZOOM fontscale each CellFonts
  Mx=: roundint GRIDZOOM * Mx
  My=: roundint GRIDZOOM * My
  Mw=: roundint GRIDZOOM * Mw
  ColWidth=: roundint GRIDZOOM * ColWidth
  RowHeight=: roundint GRIDZOOM * RowHeight
end.
ColMinWidth=: MinW >. roundint GRIDZOOM * COLMINWIDTH
RowMinHeight=: MinH >. roundint GRIDZOOM * ROWMINHEIGHT
MaxSCols=: >. Scw % ColMinWidth
MaxSRows=: >. Sch % RowMinHeight
)
zoomin=: 3 : 0
GRIDZOOM=: GRIDZOOM * GridZinc
refresh''
)
zoomout=: 3 : 0
GRIDZOOM=: GRIDZOOM % GridZinc
refresh''
)
zoomrestore=: 3 : 0
GRIDZOOM=: 1
refresh''
)
coclass 'jzgrid'
char=: 3 : 0
select. State
case. iEdit do.
  if. editchar '' do. return. end.
case. iCombo do.
  if. bcchar '' do. return. end.
case. iACombo do. return.
end.
State=: 0
m=. 0 ". sysmodifiers__locV
key sysdata__locV;(m e. 2 3);m e. 1 3
)
keyx=: 3 : 0

d=. alfndx {. Char
m=. Shift + +: Ctrl
if. (d > 32) *. d -.@e. NonAlfaNum do.
  if. #CELLMARK do.
    pos=. rots 2 {. CELLMARK
    if. iseditable pos do.
      CELLMARK=: 2 {. CELLMARK
      edit 1;Char;pos
    end.
  end.
  return.
end.
select. d

case. kbENTER do.
  movenext''
case. 32 do.
  movexall m
case. kbLEFT ; kbUP ; kbRIGHT ; kbDOWN do.
  d=. ((kbLEFT,kbUP,kbRIGHT,kbDOWN) i. d) { 0 _1, _1 0, 0 1,: 1 0
  select. m
  case. 0 do.
    moveby d
  case. 1 do.
    movexby d
  case. 2 do.
    moveedge d
  case. 3 do.
  end.
case. kbPUP ; kbPDOWN do.
  select. m
  case. 0 do.
    moveby 0 ,~ Srws * (d=kbPDOWN) { _1 1
  case. 2 do.
    moveby 0 , Scls * (d=kbPDOWN) { _1 1
  end.
case. kbEND do.
  select. m
  case. 0 do.
    if. _ > Ccls do.
      moveto ({.CELLMARK), <: Ccls
    end.
  case. 2 do.
    if. _ > Crws + Ccls do.
      moveto <: Crws,Ccls
    end.
  end.

case. kbHOME do.
  select. m
  case. 0 do.
    moveto ({.CELLMARK), 0
  case. 2 do.
    moveto 0 0
  end.
case. kbDEL do.
  if. m e. 0 2 do.
    delete''
  end.
case. kbESC do.
  if. GRIDESCCANCEL do.
    fn=. GridPid,'_cancel__locP'
    if. 3=4!:0<fn do.
      fn~'' return.
    end.
  end.

end.

showit''
)
cut=: ]
copy=: 3 : 0
a=. readmark''
select. #a
case. 2 do.
  t=. readfmt a
case. 4 do.
  'b e'=. _2 [\ a
  xy=. b <. e
  t=. readfmt xy (+ i.) each 1 + (b >. e) - xy
case. do.
  t=. ''
end.
wdclipwrite clipfmt flips t
)
delete=: 3 : 0
a=. readmark''

select. #a
case. 0 do.
  return.
case. 2 do.
  xy=. a
  wh=. 1 1
case. 4 do.
  'b e'=. _2 [\ a
  xy=. b <. e
  wh=. 1 + (b >. e) - xy
end.
old=. readblock xy,wh
typ=. readblocktype xy,wh
dat=. getdelete old;typ
dat change xy
refresh''
)
getdelete=: 3 : 0

'old typ'=. y

shp=. $old
if. isnum old do.
  shp $ 0 return.
end.
typ=. ,typ
old=. boxxopen ,old
num=. isnum &> old
new=. ($old) $ <''
ndx=. I. num *. typ = 0
new=. (<0) ndx } new

ndx=. I. typ e. 100 101
new=. (<0) ndx } new

ndx=. I. (typ>:200) *. typ<300
new=. (ndx { old) ndx } new

shp $ new
)
paste=: 3 : 0
new=. clipunfmt wdclipread''
a=. readmark''
select. #a
case. 0 do.
  return.
case. 2 do.
  xy=. a
  wh=. ($new) <. (Crws,Ccls) - xy
  new=. wh {. new
case. 4 do.
  'b e'=. _2 [\ a
  xy=. b <. e
  wh=. 1 + (b >. e) - xy
  if. -. *./ (wh = $new) +. wh = 1 do.
    info 'Clipboard does not match selected area' return.
  end.
  new=. ({.wh) $ ({:wh) $"1 new
end.
old=. readblock xy,wh
typ=. readblocktype xy,wh
'rc dat'=. validate old;new;typ
if. rc do. return. end.
dat change xy
refresh''
)
f=. [: NaN&". e.&'-_.0123456789' # ]
valfix=: ]`f @. (2:=3!:0) f.
validate=: 3 : 0

'old new typ'=. y

shp=. $new
if. isnum old do.
  if. isnum new do.
    0;new
  else.
    val=. ,valfix &> boxxopen new
    if. rc=. NaN e. val do.
      info 'Not numeric: ',": (val i. NaN) pick new
    end.
    rc;<shp$val
  end.
  return.
end.
typ=. ,typ
old=. boxxopen ,old
new=. boxxopen ,new
if. #ndx=. I. typ=0 do.
  if. #ind=. ndx #~ isnum &> ndx { old do.
    val=. valfix &> ind { new
    if. NaN e. val do.
      info 'Not numeric: ',": ((val i. NaN){ind) pick new
      1;'' return.
    end.
    new=. (<&> val) ind } new
  end.
end.
if. #ndx=. I. typ e. 100 101 do.
  val=. valfix &> ndx { new
  if. 0 e. val e. 0 1 do.
    info 'Not boolean: ',": (((val e. 0 1) i. 0){ndx) pick new
    1;'' return.
  end.
  new=. (<&> val) ndx } new
end.
if. #ndx=. I. (typ>:200) *. typ<300 do.
  val=. ndx { new
  msk=. (typ-200) } val&e. &> CELLITEMS
  if. 0 e. msk do.
    info 'Not in selection: ',": ((msk i. 0){ndx) pick new
    1;'' return.
  end.
end.
if. #ndx=. I. (typ>:300) *. typ<400 do.
  dtp=. (typ-300) { 3!:0 &> CELLITEMS
  msk=. dtp = 3!:0 &> ndx { new
  if. 0 e. msk do.
    info 'Incorrect type: ',": ((msk i. 0){ndx) pick new
    1;'' return.
  end.
end.
0;<shp $ new
)
coclass 'jzgrid'
BCx=: 4
BCy=: 1
bcinit=: 3 : 0

if. 0 -: CellType do. 0 return. end.
Bcell=: y
Btype=: (<Bcell) { CellType
Bfont=: getcellfont y
if. -. iscombo Btype do. 0 return. end.
State=: iCombo

Bcap=: 0
Bmove=: 0
Blist=: (100|Btype) pick CELLITEMS
Blen=: #Blist

'row col'=. (rots Bcell) - Scrollr,Scrollc
txt=. readcell Bcell
Bpos=: Blist i. <txt

glfont Bfont
hit=. qextenth 'X'
wid=. >./ qextentwv Blist
Bhext=: hit

wid=. wid + +: BCx
bit=. (Blen * hit) + 1 + +: BCy
'x y w h'=. (Hw+col{Vcx),(Hh+row{Vcy),1+(col{Vcw),row{Vch
wid=. w >. wid
Bhit=: h - 2
x=. Hw >. x - 0 >. wid + x - Sw
w=. wid <. Sw - x
below=. Sh - y + h - 1

if. below >: bit do.
  y=. y + h - 1
  bh=. bit
  Brws=: Blen
else.
  above=. y - Hh
  if. above >: bit do.
    y=. y - bit
    bh=. bit
    Brws=: Blen
  else.
    max=. above >. below
    Brws=: <. (max - +: BCy) % hit
    bh=. (Brws * hit) + 1 + +: BCy
    if. above > below do.
      y=. y - bh
    else.
      y=. y + h - 1
    end.
  end.
end.

'Bx By Bw Bh'=: Bxywh=: x,y,w,bh
Bxy=: (x + BCx),.(y + BCy) + hit * i.Brws
Bcap=: Bpos <. Blen - Brws
showit''
bcshow 0
)
bcinitaxis=: 3 : 0
sel=. y
State=: iACombo
rect=. sel { ATrect
Bdim=: sel { 2 pick AXISORDER
pos=. cubegetindex Bdim
list=. Bdim pick AXISLABELS
bcinitrest list;pos;rect
)
BCx=: 4
BCy=: 1
bcinitextern=: 3 : 0
State=: iXCombo
'list pos rect verb'=. y
bcxcombo=: verb~
bcinitrest list;pos;rect
)
bcinitrest=: 3 : 0
'Blist Bpos Brect'=: y

Bfont=: HdrFont
Blen=: #Blist
Bcap=: 0
Bmove=: 0

glfont Bfont
hit=. qextenth 'X'
wid=. >./ qextentwv Blist
Bhext=: hit
wid=. wid + +: BCx
bit=. (Blen * hit) + 1 + +: BCy
'x y w h'=. Brect
wid=. w >. wid
Bhit=: h - 2
x=. 0 >. x - 0 >. wid + x - Sw
w=. wid <. Sw - x
below=. Sh - y + h - 1

if. below >: bit do.
  y=. y + h - 1
  bh=. bit
  Brws=: Blen
else.
  above=. y
  if. above >: bit do.
    y=. y - bit
    bh=. bit
    Brws=: Blen
  else.
    Brws=: <. (below - +: BCy) % hit
    bh=. (Brws * hit) + 1 + +: BCy
    y=. y + h - 1
  end.
end.

'Bx By Bw Bh'=: Bxywh=: x,y,w,bh
Bxy=: (x + BCx),.(y + BCy) + hit * i.Brws
Bcap=: Bpos <. Blen - Brws
showit''
bcshow 0
)
bcchar=: 3 : 0
select. alfndx {. sysdata__locV
case. kbENTER do.
  1 [ bcfini 1
case. kbESC do.
  1 [ bcfini 0
case. do.
  0 [ bcshow 1
end.
)
bcfini=: 3 : 0
old=. State
State=: 0
Show=: 0
if. y do.
  select. old
  case. iCombo do.
    Show=: 2
    txt=. <Bpos pick Blist
    txt change Bcell
  case. iACombo do.
    Show=: 5
    cubeputindex Bdim,Bpos
  case. iXCombo do.
    bcxcombo Bpos return.
  end.
end.
showit''
y
)
bcmouse=: 3 : 0
2 {. 0 ". sysdata__locV
)
bcmbldown=: 3 : 0
pos=. bcmouse ''
if. pos inrect BSxywh do.
  Bmove=: 1
  Pos=: (1{BSSxywh), {: pos
elseif. pos inrect Bxywh do.
  Bmove=: 0
  Bpos=: Bcap + bcrow {:pos
  bcfini 1
elseif. do.
  bcfini 0
end.
)
bcmblup=: 3 : 0
Bmove=: 0
)
bcrow=: 3 : 0
y=. y - By + BCy + 1
0 >. (<:Brws) <. <. y % Bhext
)
bcmmove=: 3 : 0
pos=. bcmouse ''
if. Bmove do.
  new=. ({.Pos) + {: pos - Pos
  'mx my mw mh'=. 1 { BSBxywh
  'sx sy sw sh'=. BSSxywh
  sy=. my >. (my+mh-sh) <. new
  BSSxywh=: sx,sy,sw,sh
  Bcap=: <. 0.5 + (Blen - Brws) * (sy - my) % mh-sh
  bcshow 1
elseif. (pos inrect Bxywh) > pos inrect BSxywh do.
  bp=. Bcap + bcrow {:pos
  if. Bpos ~: bp do.
    Bpos=: bp
    bcshow 1
  end.
end.
)
bcinitscroll=: 3 : 0
if. Brws = Blen do.
  BSxywh=: ''
  BCs=: 0 return.
end.

BCs=: Bhit
x=. Bx + Bw - BCs
y=. By + 1
r=. Bx + Bw - 2
w=. r - x
h=. Bh

hit=. BCs
BSxywh=: x,y,w,h
'BSx BSy BSw BSh'=: BSxywh

top=. x,y,w,BCs
mid=. x,(y+BCs+1),w,h-5++:BCs
bot=. x,(y+h-BCs+3),w,BCs
BSBxywh=: top,mid,:bot
glbrush glrgb 1 { ButtonColor
glpen 1 0 [ glrgb 3 { ButtonColor
glrect x,y,(BCs-1),h-2
glbrush glrgb 3 { ButtonColor
glpen 1 0
glrect (x+1),(y+hit+1),(hit-2),h-4++:hit
glpen 1 0 [ glrgb 1 { ButtonColor
glpixel (x,y+hit+1) +"1 makedots (hit-1),h-4++:hit
glpen 1 0 [ glrgb 4 { ButtonColor
gllines (x-1),y,(x-1),By + h - 1
gllines r,y,r,By + h - 1
gllines x,(y+hit),r,(By+1+hit)
gllines x,(y+h - hit + 4),r,(y+h - hit + 4)
gllines x,(y+h-3),r,(y+h-3)
w=. <. 0.25 * _2 + hit
x=. <: x + >.-: hit - +:w
y=. By + 1 + <. -: hit - w
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon x,(y+w),(x+w),y,(x++:w),y+w
y=. y + h - BCs + 1
glpolygon x,y,(x+w),(y+w),(x++:w),y
)
bcsetscroll=: 3 : 0
'x y w h'=. 1 { BSBxywh
hit=. BCs >. <. h * Brws % Blen
top=. (h - hit) * Bcap % Blen - Brws
BSSxywh=: x,(y+top),w,hit
)
bcshowscroll=: 3 : 0

'x y w h'=. BSSxywh
x1=. x+1
r=. x + w
s=. y + h

glpen 1 0 [ glbrush glrgb 1 { ButtonColor
glrect BSSxywh

glpen 1 0 [ glrgb 3 { ButtonColor
gllines x1,(y+1),x1,s-1
gllines x1,(y+1),(r-1),y+1

glpen 1 0 [ glrgb 2 { ButtonColor
gllines (r-1),(y+1),(r-1),s
gllines x1,(s-1),r,s-1

glpen 1 0 [ glrgb 4 { ButtonColor
gllines x,s,r,s

)
bcshow=: 3 : 0
redraw=. y

glbrush glrgb 1 { MenuColor
glpen 1 0 [ glrgb 0 0 0
glrect Bxywh
bcinitscroll''
glfont Bfont
glrgb 0 { MenuColor
glpen 1 0
gltextcolor ''

txt=. > (Bcap + i. Brws) { Blist
txt (gltext@[ gltextxy)"1 Bxy
ndx=. Bpos - Bcap
if. (ndx >: 0) *. ndx < Brws do.
  'x y'=. ndx { Bxy
  glbrush glrgb 3 { MenuColor
  glpen 1 0
  glrect (x+1-BCx),y,(Bw - BCs + 2),Bhit-2
  glrgb 2 { MenuColor
  gltextcolor''
  gltextxy ndx { Bxy
  gltext ,ndx{txt
end.
if. Brws < Blen do.
  if. redraw=0 do.
    bcsetscroll''
  end.
  bcshowscroll''
end.

glpaint''
)
coclass 'jzgrid'
initdatax=: 3 : 0
if. Cube do.
  cubegetmatrix ''
  'rws cls'=. $CellData
elseif. Hier do.
  hiergetdata ''
  'rws cls'=. $CellData
elseif. do.
  s=. $CELLDATA
  select. #s
  case. 0 do.
    CELLDATA=: 1 1 $CELLDATA
    'rws cls'=. 1
  case. 1 = #s do.
    cls=. s
    if. L. CELLDATA do.
      CELLDATA=: ,. each boxstrings each CELLDATA
      rws=. # 0 pick CELLDATA
    elseif. 0 = cls do.
      CELLDATA=: i.0 0
      rws=. 0
    elseif. do.
      CELLDATA=: tomatrix CELLDATA
      rws=. 1
    end.
  case. do.
    'rws cls'=. s
  end.
  CellData=: CELLDATA
end.

Cshape=: $CellData
'Crws Ccls'=: rots rws,cls
if. GridVirtualMode do.
  Ct=: Cy + rws - 1
  Cs=: Cx + cls - 1
  Cxyst=: Cx,Cy,Cs,Ct
  'Tcls Trws'=: rots Twh
else.
  'Cx Cy Cs Ct'=: Cxyst=: 0 0,<:cls,rws
  'Tx Ty Ts Tt'=: Txyst=: Cxyst
  Tcls=: Ccls
  Trws=: Crws
end.
if. #CELLMARK do.
  CELLMARK=: CELLMARK <. (#CELLMARK) $ <:Trws,Tcls
end.

0
)
initdata=: initdatax
changex=: 3 : 0
Value writeblock Cell
)
getextent=: 3 : 0

if. (#CellDFmtM) +. #$CellFont do.
  dat=. ,CellDFmt
  cft=. ($dat) $ ,CellFont
  wid=. hit=. ($dat) $ 0

  for_c. ~.cft do.
    glfont c pick CellFonts
    ndx=. I. c=cft
    wid=. (qextentwv ndx { dat) ndx } wid
    hit=. (qextenth 'X') ndx } hit
  end.

  if. #CellDFmtM do.
    CellHexM=: (#CellDFmtM) $ <''
    cfx=. CellDFmtM { cft
    for_c. ~.cfx do.
      glfont c pick CellFonts
      ndx=. I. c=cfx
      sel=. ndx { CellDFmtL
      wdx=. glqextentw each sel
      CellHexM=: wdx ndx } CellHexM
      wdx=. >./ &> wdx
      wid=. wdx (ndx{CellDFmtM) } wid
      htx=. (qextenth 'X') * +/ &> LF =each sel
      hit=. htx (ndx{CellDFmtM) } hit
    end.
  else.
    CellHexM=: ''
  end.

  wid=. Fshape$wid
  hit=. Fshape$hit
  CellVex=: hit
  getcellhit''
else.
  glfont CellFont pick CellFonts
  wid=. qextentwm CellDFmt
  CellHit=: CellVex=: qextenth 'X'
end.
if. -. 0 -: CellType do.
  msk=. iscombo CellType
  if. 1 (e.,) msk do.
      min=. msk * (msk * 100|CellType) { CellHit + CellFont { CellItemsHex
      wid=. wid >. min
  end.
end.
CellHex=: wid
getcellwid''
)
getcellhit=: 3 : 0
if. GRIDFLIP do.
  CellHit=: >./ CellVex
else.
  CellHit=: >./"1 CellVex
end.
)
getcellwid=: 3 : 0
if. GRIDFLIP do.
  CellWid=: >./"1 CellHex
else.
  if. 0 < #$CellOverFlow do.
    CellWid=: >./ CellHex * -. CellOverFlow
  else.
    CellWid=: >./ CellHex
  end.
end.
)
getdata=: 3 : 0
get getblockindex''
1
)
getblockindex=: 3 : 0
w=. >: Ts - Cx
h=. >: Tt - Cy
mrws=. MinTh >. (+:MaxSRows) >. MaxSRows + +:Slack
mcls=. MinTw >. (+:MaxSCols) >. MaxSCols + +:Slack
if. GRIDFLIP do. 'mrws mcls'=. mcls,mrws end.
rws=. Cy + i. mrws <. h
cls=. Cx + i. mcls <. w

rws;cls
)
set=: 3 : 0
setnames y
showit 3
)
getx=: set
readcell=: 3 : '0 pick ,readblock y,1 1'
readblock=: 3 : 0
'row col rws cls'=. y
row=. row - Cy
col=. col - Cx
if. (1=#Cshape) *. L. CellData do.
  (<row+i.rws) {each (col+i.cls) { CellData
else.
  (<(row+i.rws);col+i.cls) { CellData
end.
)
readblocktype=: 3 : 0
'row col rws cls'=. y
if. CellType -: 0 do.
  (rws,cls) $ 0
else.
  row=. row - Cy
  col=. col - Cx
  (<(row+i.rws);col+i.cls) { CellType
end.
)
readedit=: 3 : 0
txt=. readcell y
if. ischar txt do.
  if. 1 < #$txt do.
    flatn txt
  end.
else.
  fmt01 txt
end.
)
readfmt=: 3 : 0
(<fmtndx y) { CellDFmt
)
ischeck=: 3 : 0
y e. 100 101
)
iscombo=: 3 : 0
(200 <: y) *. y <: 399
)
iscombolist=: 3 : 0
(200 <: y) *. y <: 299
)
iscombodrop=: 3 : 0
(300 <: y) *. y <: 399
)
writecell=: 4 : 0
if. Cube do. x writecube y return. end.
'row col'=. y - Cy,Cx
ndx=. <row;col
new=. x
if. L. CELLDATA do.
  if. 1=#Cshape do.
    dat=. col pick CELLDATA
    if. L. dat do.
      dat=. (boxopen new) row } dat
    else.
      dat=. new row } dat
    end.
    CELLDATA=: (<dat) col } CELLDATA
  else.
    CELLDATA=: (boxopen new) (<row,col) } CELLDATA
  end.
else.
  CELLDATA=: new (<row,col) } CELLDATA
end.
CellData=: CELLDATA
EMPTY
)
writeblock=: 4 : 0
if. Cube do. x writecube y return. end.
'row col'=. y - Cy,Cx
new=. x
if. ischar new do. new=. <new end.
new=. tomatrix new
rwx=. row + i.#new
clx=. col + i.{:$new
if. (1=#$new) *. L.new do.
  if. 1=#Cshape do.
    new writecol each rwx&; each clx return.
  elseif. L.CELLDATA do.
    new=. |: boxitem &> new
  elseif. do.
    new=. |: > new
  end.
else.
  select. 1 = (L.CELLDATA),L.new
  case. 0 1 do.
    new=. > new
  case. 1 0 do.
    new=. <&> new
  end.
end.
ndx=. <rwx;clx
CELLDATA=: new ndx } CELLDATA
CellData=: CELLDATA
EMPTY
)
writecol=: 4 : 0
new=. x
'rwx col'=. y
dat=. col pick CELLDATA
if. L. dat do.
  dat=. (boxopen new) rwx } dat
else.
  dat=. new rwx } dat
end.
CELLDATA=: (<dat) col } CELLDATA
EMPTY
)
writecube=: 4 : 0
new=. tomatrix x
'row col'=. y - Cy,Cx
rwx=. row + i.#new
clx=. col + i.{:$new
ndx=. <rwx;clx
CellData=: new ndx } CellData
cubesetmatrix''
)
coclass 'jzgrid'
drawarrow=: 4 : 0
's px py'=. y
if. s do.
  addhover px,py,2{x
  glpixels px,py,s{x
else.
  p=. px,py,s{x
  subhover 4 {. p
  glpixels p
end.
)
drawleftarrow=: 3 : 'LeftArrow drawarrow y'
drawrightarrow=: 3 : 'RightArrow drawarrow y'
drawuparrow=: 3 : 'UpArrow drawarrow y'
drawdownarrow=: 3 : 'DownArrow drawarrow y'
drawatt=: 3 : 0

if. # $ CellAlign do.
  Valn=: , flips Vrndx { CellAlign
else.
  Valn=: CellAlign
end.
if. (GRIDFLIP=0) *. 0 < # $ CellOverFlow do.
  Vcof=: flips Vrndx { CellOverFlow
else.
  Vcof=: 0
end.
if. #$CellFont do.
  Vfnt=: , flips Vrndx { CellFont
else.
  Vfnt=: CellFont
end.
if. 0 -: CellMask do.
  Vmsk=: 0
else.
  Vmsk=: , flips Vrndx { CellMask
end.
if. 0 -: CellType do.
  Vtyp=: 0
else.
  if. # $ CellType do.
    Vtyp=: , flips Vrndx { CellType
  else.
    Vtyp=: Vlen $ CellType
  end.
end.
ndx=. < rots Cyndx;Cxndx
Vdat=: , flips ndx { CellDFmt
Vhex=: , flips ndx { CellHex
if. #$ CellVex do.
  Vvex=: , flips ndx { CellVex
else.
  Vvex=: CellVex
end.
if. #CellDFmtM do.
  'r c'=. >ndx
  ndx=. , flips (r*{:Fshape)+/c
  msk=. CellDFmtM e. ndx
  Vfm=: ndx i. msk # CellDFmtM
  Vhm=: msk # CellHexM
  Vfl=: msk # CellDFmtL
else.
  Vfm=: ''
end.
EMPTY

)
drawbackground=: 3 : 0

glbrush glrgb 1 { GridBackColor
if. GRIDBORDER do.
  glrgb 1 { GridColor
  glpen 1 0
else.
  glpen 0 0
end.
glrect Sxywh

if. SBv +: SBh do. return. end.
if. SBh do.
  if. SBv do.
    h=. Sh
  else.
    h=. Vh
  end.
  w=. Sw
else.
  h=. Sh
  w=. Vw
end.
glbrush glrgb 0 { GridBackColor
glpen 0 0
glrect Gx,Gy,w,h

)
drawcellback=: 3 : 0

clr=. Vclr { CellColorBack
rec=. _1 _1 2 2 +"1 Vrect
r=. 6 2078 ,"1 rec
Gclr=: 5 2032 ,"1 clr
Gbuf=: <"1 r,.Gclr,.2 2004 4 2022 0 0 6 2031 ,"1 rec
)
drawcellmask=: 3 : 0
if. 0 -: CellMask do. return. end.
glbrush glrgb CellMaskColor
glpen 1 0
glrect 0 0 1 1 +"1 (-.Vmsk) # Vrect
)
drawhdrback=: 3 : 0
if. 0 = Hc + Hr do. return. end.
glbrush glrgb 0 { HdrColor
glpen 0 0
glrect Gxy, 1 + Hwh + (+/Vcw), 0
glrect Gxy, 1 + Hwh + 0,+/Vch
)
drawcellagain=: 3 : 0
ndx=. y
aln=. ndx { Valn
ext=. ndx { Vhex
clr=. Vclr
if. #$clr do.
  clr=. ndx { clr
end.

'row col'=. (0,Vcls) #: ndx
x=. Hw + col{Vcx
y=. Hh + row{Vcy
w=. col{Vcw
h=. row{Vch

glrgb clr { CellColorBack
glbrush''
glrgb 0 { GridColor
glpen 1 0
glrect x,y,,1+w,h

txt=. ndx pick Vdat
x=. x + Mx + (aln=0) + aln * (-Mx) + -: w + ext
y=. y + My
gltextxy Gxy + x,.y
gltext txt
)
drawcellover=: 3 : 0
if. 0 = # $ Vcof do. return. end.
r=. ''
for_i. I. +./"1 Vcof do.
  r=. r, drawcellover1 i
end.
msk=. # &> r { Vdat
if. 0 = +/ msk do. return. end.
drawcellagain &> (0 < msk) # r
)

drawcellover1=: 3 : 0
row=. y
ndx=. I. row { Vcof
rdx=. row * Vcls
ind=. ndx + rdx
txt=. ind { Vdat
len=. qextentwv txt
if. 0 e. len do.
  msk=. len > 0
  if. 0 = +/msk do. return. end.
  ind=. msk # ind
  ndx=. msk # ndx
  len=. msk # len
  txt=. msk # txt
end.
aln=. ind { Valn
bgn=. Mx + (ndx { Vcx) + (aln=0) + >. aln * (ndx{Vcmw) - -: len
x=. 0 >. <: +/ Vcx <:/ bgn
r=. Vcls <. +/ Vcx </ bgn + Mx + len
if. r <: x + 1 do. '' return. end.
y=. row { Vcy
vx=. x { Vcx
vr=. r { Vcx
rec=. 1 + vx,.y,._3 +(vr-vx),.row { Vch
txt=. alfndx each txt
len=. 2 + # &> txt
pos=. 4 2056 ,"1 (bgn ,. y+My) ,"1 len,.2038

if. #$Vclr do.
  c=. 5 2032 ,"1 (ind{Vclr) { CellColorBack
  glcmds ,c,.2 2004 4 2022 0 0 6 2031 ,"1 rec
  c=. 5 2032 ,"1 (ind{Vclr) { CellColorFore
  glcmds ; (<"1 c ,. pos) ,each txt
else.
  glrgb Vclr { CellColorBack
  glpen 0 0
  glbrush''
  glrect rec
  glrgb Vclr { CellColorFore
  gltextcolor''
  glcmds ; (<"1 pos) ,each txt
end.
rdx + ndx -.~ I. 0 < +/\ ((i.Vcls) e. x) - (i.Vcls) e. r
)
drawcelltext=: 3 : 0

x=. (Vlen $ Mx + }:Vcx) + Valn=0
s=. x + >. Valn * (Vlen $ Vcmw) - -: Vhex
y=. (Vcls # My + }:Vcy) + CELLALIGNV * (Vcls # Vcmh) - -: Vvex
pos=. Hwh +"1 s,.y
clr=. Vclr { CellColorFore
pcf=. 5 2032 ,"1 clr,"1 [ 2 2040
dat=. alfndx each Vdat
len=. 2 + # &> dat
p=. <"1 [ pcf ,. 4 2056 ,"1 pos ,"1 len,.2038
p=. p ,each dat
p=. Gbuf ,each p ,each <2 2079
if. #$ Vfnt do.
  fnt=. ~.Vfnt
  p=. Vfnt <@; /. p
  for_f. fnt do.
    glfont f pick CellFonts
    glcmds f_index pick p
  end.
else.
  glfont Vfnt pick CellFonts
  glcmds ;p
end.
if. 0=#Vfm do. return. end.
x=. Vfm { x
y=. Vfm { y
aln=. Vfm getindex Valn
vex=. Vfm getindex Vvex
cmh=. Vfm { Vcls # Vcmh
cmw=. Vfm { Vlen $ Vcmw
rws=. # &> Vhm
msk=. ;rws {.each 1
pcf=. (Vfm { Gbuf) ,each <"1 Vfm { pcf
x=. (rws # x) + >. (rws # aln) * (rws # cmw) - -: ; Vhm
x=. msk <;.1 x
y=. y + each vex * each (i.%[) each rws
pos=. (Hwh) +"1 >. ; x ,.each y
dat=. ; <;._2 each Vfl
dat=. alfndx each dat
len=. 2 + # &> dat
p=. 4 2056 ,"1 pos ,"1 len,.2038
p=. (<"1 p) ,each dat
p=. msk <@; ;.1 p
p=. pcf ,each p ,each <2 2079
if. #$ Vfnt do.
  vfnt=. Vfm { Vfnt
  fnt=. ~.vfnt
  p=. vfnt <@; /. p
  for_f. fnt do.
    glfont f pick CellFonts
    glcmds f_index pick p
  end.
else.
  glfont Vfnt pick CellFonts
  glcmds ; p
end.
)
drawcheckbox=: 3 : 0
ndx=. I. Vtyp e. 100 101
if. 0 = #ndx do. return. end.
vrec=. ndx { Vrect
r=. 2 2004 4 2022 0 0 6 2031 ,"1 vrec
glcmds ,(ndx { Gclr),.r
t=. CBSize
'x y w h'=. |: vrec
x=. x + <.-:w-t
y=. y + <.-:h-t
xy=. x,.y
ck=. xy #~ '1' e. &> ndx { Vdat
msk=. 100 = ndx { Vtyp
if. 1 e. msk do.
  glbrush glrgb 3 { ButtonColor
  glrgb 4 { GridColor
  glpen 1 0
  glrect msk # xy,"1 t,t
end.
msk=. 101 = ndx { Vtyp
if. 1 e. msk do.
  x=. msk # x
  y=. msk # y
  xy=. msk # xy
  r=. x + t - 2
  s=. y + t - 2

  glbrush glrgb 3 { ButtonColor
  glpen 1 0
  glrect xy,"1 t,t

  glrgb 2 { ButtonColor
  glpen 1 0
  gllines x,.y,.(r+1),.y
  gllines x,.y,.x,.s + 1

  glrgb 4 { ButtonColor
  glpen 1 0
  gllines 1 + xy,.x,.s-2
  gllines 1 + xy,.(r-2),.y

  glrgb 5 { ButtonColor
  glpen 1 0
  gllines r,.(y+1),.r,.s-1
  gllines (x+1),.s,.(r+1),.s

end.
glrgb 0 { ButtonColor
glpen 1 0
r=. 3 4 5 6 7 8 9
s=. 5 6 7 6 5 4 3
gllines (ck,.ck) +"1/ r,.s,.r,.s + 3
)
drawcolor=: 3 : 0

if. # $ CellColor do.
  Vclr=: 4 * , flips Vrndx { CellColor
else.
  Vclr=: Vlen $ 4 * CellColor
end.
if. -. 0 -: CellHigh do.
  Vclr=: Vclr + +: , flips Vrndx { CellHigh
end.
if. GRIDROWMODE *. (0 < #CELLMARK) *. State e. StateRowMark do.
  r=. ({. CELLMARK) - Scrollr
  if. (r >: 0) *. r < Vrws do.
    ndx=. (Vcls * r) + i. Vcls
    Vclr=: (1 + ndx { Vclr) ndx } Vclr
  end.
else.
  if. 4 = #CELLMARK do.
    'mark markx'=. _2 [\ CELLMARK
    if. -. mark -: markx do.
      rc=. mark <. markx
      'r c'=. rc - Scrollrc
      's t'=. 1 + (mark >. markx) - rc
      r=. r + i. s
      c=. c + i. t
      r=. r #~ (r >: 0) *. r < Vrws
      c=. c #~ (c >: 0) *. c < Vcls
      ndx=. , (Vcls * r) +/ c
      ndx=. ndx -. Vcls #. markx - Scrollrc
      Vclr=: (1 + ndx { Vclr) ndx } Vclr
    end.
  end.
end.

1
)
drawcombobox=: 3 : 0
ndx=. I. iscombo Vtyp
if. 0 = #ndx do. return. end.
drawcombobox1 ndx { Vrect
)
drawcombobox1=: 3 : 0
'x y w h'=. |: y
r=. x + w
s=. y + h - 1
x=. r - h

glbrush glrgb 1 { ButtonColor
glpen 1 0 [ glrgb 5 { ButtonColor
glrect x,.y,.h,.h

glpen 1 0 [ glrgb 3 { ButtonColor
gllines (x+1),.y,.r,.y
gllines 1 + x,.y,.x,.s-1

glpen 1 0 [ glrgb 4 { ButtonColor
gllines (x+1),.s,.r,.s
gllines (r-1),.(y+1),.(r-1),.s

w=. <. 0.25 * _2 + {. h
xy=. (x + >.-: h - +:w),.y + <. -: h - w

glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon (6$"1 xy) +"1/ 0 0,w,w,+:w,0
)
drawcontrols=: 3 : 0
if. Vtyp -: 0 do. return. end.
drawcheckbox''
drawcombobox''
)
drawcube=: 3 : 0
if. -. Cube do. return. end.
glbrush glrgb 1 { GridBackColor
glpen 1 0
if. Sy do.
  glrect 0 0,Rw,Sy
end.
glrect 0,(Sy+Sh),Rw,Rh-Sy+Sh
glrect (Sx+Sw),0,(Rw-Sx+Sw),Rh
glpen 1 0 [ glrgb 0 0 0
gllines (*a)-~a=. 0 0,Rw,0,Rw,Rh,0,Rh,0 0
glbrush glrgb 0 { HdrColor
glpen 1 0 [ glrgb 3 { GridColor
glrect AXrect

'px py pw ph'=. |: AXrect
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.(px+pw-2),.py
gllines 1 + px,.py,.px,.py+ph-2
glpen 1 0 [ glrgb 3 { GridColor
gltextcolor glrgb 1 { HdrColor
nms=. (;3{.AXISORDER) { AXISNAMES
pos=. (Mx,My) +"1 [ 2 {."1 AXrect
glfont HdrFont
for_i. i.#nms do.
  gltextxy i{pos
  gltext i pick nms
end.
if. 0 = #sel=. 2 pick AXISORDER do. return. end.
nms=. (cubegetindex sel) {&> sel { AXISLABELS
pos=. ((Mw + Mx2) + (0 {"1 ASrect) + sel { Axwid),.1 {"1 ASrect
glbrush glrgb 1 { MenuColor
glrect ATrect
for_i. i.#nms do.
  gltextxy (Mx,My) + i{pos
  gltext i pick nms
end.
)
drawgrid=: 3 : 0

drawinit''
drawclip''
drawpos''
drawatt''
drawcolor''

drawbackground''

cells=. Vrws *. Vcls

if. cells do.
  drawcellback''
  drawcelltext''
  drawcelllines''
  drawcellover''
  drawcontrols''
  drawcellmask''
end.

drawhdrback''
drawhdrlight''
drawhdrcol''
drawhdrrow''
drawhdrtop''
drawhdrshadow''

if. cells do.
  drawmark''
end.

drawcube''
drawscrollback''
drawborder''
drawscrollbutton''

drawhier''
drawextern''
drawsort''
drawhover''
)
drawclip=: 3 : 0
Sclip=: '' return.
if. Sxywh -: Rxywh do.
  Sclip=: ''
else.
  Sclip=: 6 2078,Sxywh
end.
)
drawinit=: 3 : 0
glsel GRIDHWNDC
glclear''
glcursor IDC_ARROW
HvRects=: i.0 4
HvOns=: ''
)
drawhdrcol=: 3 : 0
if. 0 = (#HdrCol) * #Vxndx do. return. end.
for_i. i.#HdrCol do.
  drawhdrcolrow i
end.
)
drawhdrcolrow=: 3 : 0
row=. y

py=. row { Hy
ph=. row { Hrh
if. row e. HdrColMerge do.
  ndx=. <(HdrColMerge i.row);Vxndx
  bgn=. ndx { Hcmbgn
  msk=. ~:bgn
  bgn=. msk # bgn
  len=. msk # ndx { Hcmlen
  ind=. ({.bgn) + i. +/len
  ndx=. <row;bgn
  nms=. ndx { HdrCol
  aln=. ndx { HdrColAlign
  ext=. ndx { HdrCellWid
  wid=. ind { Dw
  vw=. (<:+/\len) { +/\ wid
  cw=. (-: vw - 0,}:vw) - Mx
  off=. - +/ (({.Vxndx)-{.bgn) {. wid
  pr=. Gx + Hw + off + 0,vw
else.
  ndx=. <row;Vxndx
  nms=. ndx { HdrCol
  aln=. ndx { HdrColAlign
  ext=. ndx { HdrCellWid
  pr=. Hw + Vcx
  cw=. Vcmw
end.

px=. }: pr

pos=. (Mx,My) +"1 (px + (>. aln * cw - -:ext) + aln { 1 0 _1),.py
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.px,.py + ph-1
gllines 1 + px,.py,.px,.py + ph-1

glpen 1 0 [ glrgb 3 { GridColor
gllines pr,.py,.pr,.py + ph
p=. ((Mx,My) +"1 px,.py),.0 >. ((}.pr) - 3 + px),.ph-1
p=. 6 2078 ,"1 p
glfont HdrFont
gltextcolor glrgb 1 { HdrColor

s=. alfndx each nms
len=. 2 + # &> s
p=. <"1 [ p,. 4 2056 ,"1 pos ,"1 len,.2038
glcmds ; p ,each s ,each <2 2079
)
drawhdrrow=: 3 : 0
if. 0 = (#HdrRow) * #Vyndx do. return. end.
for_i. i.{:$HdrRow do.
  drawhdrrowcol i
end.
)
drawhdrrowcol=: 3 : 0
col=. y
px=. col { Hx
pw=. col { Hcw
cw=. (-: col { Hcw) - Mx
if. col e. HdrRowMerge do.
  ndx=. <(HdrRowMerge i.col);Vyndx
  bgn=. ndx { Hrmbgn
  msk=. ~:bgn
  bgn=. msk # bgn
  len=. msk # ndx { Hrmlen
  ind=. ({.bgn) + i. +/len
  ndx=. <bgn;col
  nms=. ndx { HdrRow
  aln=. ndx { HdrRowAlign
  ext=. ndx { HdrRowHex
  hit=. ind { Dh
  vh=. (<:+/\len) { +/\ hit
  vb=. (<:+/\len) { hit
  ch=. -: vh - vb + 0,}:vh
  off=. - +/ (({.Vyndx)-{.bgn) {. hit
  ps=. Gy + Hh + off + 0,vh
  py=. }: ps
  pyc=. py
else.
  ndx=. <Vyndx;col
  nms=. ndx { HdrRow
  aln=. ndx { HdrRowAlign
  ext=. ndx { HdrRowHex
  ps=. Hh + Vcy
  py=. }: ps
  pyc=. py + Vcmh - -: HdrHit
end.

pos=. (Mx,My) +"1 <. (px + aln * cw - -:ext),.pyc
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.(px+pw-1),.py
glpen 1 0 [ glrgb 3 { GridColor
gllines px,.ps,.(px+pw),.ps
glfont HdrFont
gltextcolor glrgb 1 { HdrColor

s=. alfndx each nms
len=. 2 + # &> s
p=. <"1 [ 4 2056 ,"1 pos ,"1 len,.2038
glcmds ; p ,each s
)
drawhdrtop=: 3 : 0

if. 0 = Hc + Hr do. return. end.

glbrush glrgb 0 { HdrColor
glpen 0 0
glrect Gxy, 1 + Hwh

glrgb 2 { GridColor
glpen 1 0

pr=. }.Hx,Gx+Hw
ps=. }.Hy,Gy+Hh
ph=. {. Hrh
x=. (Hc * Hr) $ Hx
y=. Hc # Hy
r=. <: (Hc * Hr) $ pr
s=. <: Hc # ps
pos=. (Hc * HDRSTYLE=2) }. x,.y,.r,.y
pos=. pos,x,.y,.x,.s
gllines 1 + pos
if. #HdrTop do.

  'rws cls'=. $HdrTop
  nms=. ,HdrTop
  aln=. ,HdrTopAlign
  ext=. ,HdrTopHex
  p=. ((Mx,My) +"1 x,.y),.0 >. (r - 3 + x),.ph-1
  p=. 6 2078 ,"1 p
  px=. (x + Mx) + aln * (<.-:r - x + ext) - Mx
  py=. cls # My + Hy
  pos=. px,.py

  s=. alfndx each nms
  len=. 2 + # &> s
  p=. <"1 [ p,. 4 2056 ,"1 pos ,"1 len,.2038
  glcmds ; p ,each s ,each <2 2079

end.

)
drawhier=: 3 : 0
if. -. Hier do. return. end.
drawhierinit''
drawhierrow''
drawhiercol''
)
drawhierinit=: 3 : 0
glfont HdrFont
glbrush glrgb 1 { GridBackColor
glpen 0 0
glrect 0 0,Sw,Lh
LvlHit=: My2 + HdrHit
if. LvlCol *: LvlRow do.
  LvlCx=: Sw * LvlRow return.
end.
LvlDivider=: 1
lm=. +: LCMx + {.ArrowHbox
rm=. (+:LCMx) + 1 + {.ArrowVbox
Sw2=. -: Sw
rlen=. LvlHit + +/ LCMx + Mx2 + qextentwv (LVLROWTOP { LVLROWID) 0 } LRWalks
clen=. LvlHit + +/ LCMx + Mx2 + qextentwv (LVLCOLTOP { LVLCOLID) 0 } LCWalks
b=. Sw2 >: (lm + rlen), rm + clen
if. *./ b do.
  LvlCx=: <. Sw2
elseif. Sw >: lm + rlen + rm + clen do.
  LvlCx=: ({.b) pick (lm + rlen);Sw - rm + clen
elseif. do.
  LvlCx=: lm + <. (Sw - lm + rm) * rlen % rlen + clen
  LvlDivider=: 0
end.
)
drawhiercol=: 3 : 0
if. -.LvlCol do. return. end.

if. LvlRow do.
  glbrush glrgb 1 { GridBackColor
  glpen 0 0
  glrect LvlCx,0,Sw,Lh
  if. LvlDivider do. glpen 1 0 [ glrgb 4 { GridColor
    gllines LvlCx,My2,LvlCx,Lh+1-My2
  end.
end.

'w h'=. ArrowVbox
x=. Sw - 1 + LCMx + w
y=. >. -: Lh - +: h
lon=. LCend > LCbgn
ron=. LCend < <:#LCnms
LCArect=: x,.(y+0,h-1),.(>:w,w),.h
drawuparrow lon,2 {. {. LCArect
drawdownarrow ron,2 {. {: LCArect
walks=. (LVLCOLTOP { LVLCOLID) 0 } LCWalks
avail=. x - LvlCx + LvlHit + LCMx * #walks
ext=. Mx2 + qextentwv walks
if. avail < +/ext do.
  ext=. <. ext * avail % +/ext
end.
wid=. ext + (#ext) {. LvlHit
LCWrect=: (LvlCx + +/\LCMx+0,}:wid),.LCMy,.>:wid,.LvlHit
glbrush glrgb OffColor
glpen 1 0 [ glrgb 3 { GridColor
glrect LCWrect
'px py pw ph'=. |: LCWrect
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.(px+pw-2),.py
gllines 1 + px,.py,.px,.py+ph-2
glbrush glrgb OnColor
glpen 1 0 [ glrgb 4 { GridColor
glrect LCWalkn{LCWrect
pos=. (Mx,My) +"1 [ 2 {."1 LCWrect
for_w. walks do.
  glclip w_index{LCWrect
  gltextxy w_index{pos
  gltext >w
end.
glclipreset''
x=. ({.ext) + {.{.LCWrect
w=. <. 0.25 * LvlHit + 1
xy=. (x + 1 + >.-: LvlHit - +:w),.LCMy + <. -: LvlHit - w
LCLrect=: (x+1),LCMy,LvlHit,>:LvlHit
glbrush glrgb 1 { GridBackColor
glpen 0 0
glrect LCLrect + 1 1 _2 _2
glpen 1 0 [ glrgb ((0<LCWalkn){4 3) { GridColor
gllines (x+2),(LCMy+1),(x+2),LCMy+LvlHit
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon (6$"1 xy) +"1/ 0 0,w,w,+:w,0
LCrect=: LCWrect,LCArect
EMPTY
)
drawhierrow=: 3 : 0
if. -.LvlRow do. return. end.

'w h'=. ArrowHbox

lon=. LRend > LRbgn
ron=. LRend < <:#LRnms
LRArect=: (LCMx+0,w-1),"0 1 (<.LCMy+-:LvlHit-h),w,h
drawleftarrow lon,2 {. {. LRArect
drawrightarrow ron,2 {. {: LRArect
x=. LCMx + +: w
walks=. (LVLROWTOP { LVLROWID) 0 } LRWalks
avail=. LvlCx - x + LvlHit + LCMx * #walks
ext=. Mx2 + qextentwv walks
if. avail < +/ext do.
  ext=. <. ext * avail % +/ext
end.
wid=. ext + (#ext) {. LvlHit
LRWrect=: (x + +/\LCMx+0,}:wid),.LCMy,.>:wid,.LvlHit
glbrush glrgb OffColor
glpen 1 0 [ glrgb 3 { GridColor
glrect LRWrect

'px py pw ph'=. |: LRWrect
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.(px+pw-2),.py
gllines 1 + px,.py,.px,.py+ph-2
glbrush glrgb OnColor
glpen 1 0 [ glrgb 4 { GridColor
glrect LRWalkn{LRWrect

pos=. (Mx,My) +"1 [ 2 {."1 LRWrect
for_w. walks do.
  glclip w_index{LRWrect
  gltextxy w_index{pos
  gltext >w
end.
glclipreset''
x=. ({.ext) + {.{.LRWrect
w=. <. 0.25 * LvlHit + 1
xy=. (x + 1 + >.-: LvlHit - +:w),.LCMy + <. -: LvlHit - w
LRLrect=: (x+1),LCMy,LvlHit,>:LvlHit
glbrush glrgb 1 { GridBackColor
glpen 0 0
glrect LRLrect + 1 1 _2 _2
glpen 1 0 [ glrgb ((0<LRWalkn){4 3) { GridColor
gllines (x+2),(LCMy+1),(x+2),LCMy+LvlHit
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon (6$"1 xy) +"1/ 0 0,w,w,+:w,0
LRrect=: LRWrect,LRArect
EMPTY
)
HvRect=: ''
HvRects=: i.0 4
HvOff=: ''
HvOns=: ''
addhover=: 3 : 0
HvOns=: HvOns,<y
HvRects=: HvRects,4{.y
)
clearhover=: 3 : 0
if. #HvRect do.
  glpixels HvOff
  glpaint''
  HvRect=: ''
end.
)
drawhover=: 3 : 0
if. #HvRect do.
  HvRect=: HvRect intersect HvRects
  if. #HvRect do.
    glpixels (HvRects i. HvRect) pick HvOns
  else.
    glpixels HvOff
  end.
  glpaint''
end.
)
sethover=: 3 : 0
if. HvRect -: y do. return. end.
clearhover''
HvRect=: y
HvOff=: y, glqpixels y
glpixels (HvRects i. y) pick HvOns
glpaint''
)
subhover=: 3 : 0
if. y -: HvRect do.
  clearhover''
end.
msk=. -. HvRects e. ,:y
HvOns=: msk # HvOns
HvRects=: msk # HvRects
)
drawborder=: 3 : 0
if. SBv *. SBh do.
  r=. <:+/ 0 2 { VSxywh
  s=. <:+/ 1 3 { HSxywh
elseif. SBv do.
  r=. <:+/ 0 2 { VSxywh
  s=. <:+/ 1 3 { VSxywh
elseif. SBh do.
  r=. <:+/ 0 2 { HSxywh
  s=. <:+/ 1 3 { HSxywh
elseif. 1 do.
  r=. Gx + Hw + +/Vcw
  s=. Gy + Hh + +/Vch
end.
select. HDRSTYLE
case. 1 do.
  glpen 1 0 [ glrgb 1 { GridColor
  gllines Gx,Gy,r,Gy,r,s,Gx,s,Gx,Gy
case. 2 do.
  glpen 1 0 [ glrgb 2 { GridColor
  gllines Gx,Gy,r,Gy
end.
if. GRIDBORDER do.
  glpen 1 0 [ glrgb 1 { GridColor
  glbrushnull''
  glrect Rxywh
end.
)
drawcelllines=: 3 : 0
glrgb 0 { GridColor
glpen 1 0
x=. Gx + +/\ Hw, Vcw
y=. Gy + +/\ Hh, Vch
h=. ({.GridLines) # ({.x),.y,.({:x),.y
v=. ({:GridLines) # x,.({.y),.x,.{:y
gllines v,h
)
drawhdrlight=: 3 : 0
glrgb 2 { GridColor
glpen 1 0
wid=. Hw + {:Vcx
hit=. Hh + {:Vcy
gllines 1 + (HDRSTYLE=2) }. Gx,.Hy,.(wid-1),.Hy
gllines 1 + Hx,.Gy,.Hx,.hit-1
)
drawhdrshadow=: 3 : 0
if. HDRSTYLE=2 do. return. end.
glrgb 3 { GridColor
glpen 1 0
wid=. Hw + {:Vcx
hit=. Hh + {:Vcy
x=. Hx,Gx + Hw
y=. Hy,Gy + Hh
gllines Gx,.y,.wid,.y
gllines x,.Gy,.x,.hit
)
drawmark=: 3 : 0

if. (State e. iEdit,iCombo) +. (0 = #CELLMARK) +. GRIDROWMODE >: CELLMARKER do. return. end.

'mark markx'=. _2 [\ 4 $ CELLMARK

rc=. mark <. markx
hw=. (mark >. markx) - rc

rc=. rc - Scrollrc
br=. rc + hw

if. 1 e. br < 0 do. return. end.
if. 1 e. rc >: Vrws,Vcls do. return. end.

'r c'=. rc
's t'=. 1 + rc + hw

x=. <: Hw + (c>.0) { Vcx
p=. <: Hw + (t<.Vcls) { Vcx

y=. <: Hh + (r>.0) { Vcy
q=. <: Hh + (s<.Vrws) { Vcy
if. State = iCheck do.
  glrgb 4 { GridColor
  glpen 1 0

  ndx=. Vcls #. rc
  'x y w h'=. |: ndx { Vrect
  t=. CBSize
  x=. _2 + x + <.-:w-t
  y=. _2 + y + <.-:h-t
  q=. y + t + 3
  p=. x + t + 3
  cbd=. CBDots
  'px pr'=. x + cbd
  'py ps'=. y + cbd
  gllines px,.y,.pr,.y
  gllines px,.q,.pr,.q
  gllines x,.py,.x,.ps
  gllines p,.py,.p,.ps
else.
  glbrush glrgb 4 { GridColor
  glpen 1 0
  if. c >: 0 do.
    glrect x,y,3,q-y
  end.
  if. r >: 0 do.
    glrect x,y,(p-x),3
  end.
  if. t <: Vcls do.
    glrect p,y,3,3+q-y
  end.
  if. s <: Vrws do.
    glrect x,q,(3+p-x),3
  end.

end.
)
drawpos=: 3 : 0

Gxs=: Gxy,Gxy
Gxs1=: Gxs + 1
Scrollrc=: Scrollr,Scrollc

if. GRIDFLIP do.
  cc=. Scrollc - Cy
  cr=. Scrollr - Cx
  fc=. Scrollc - Cy
  fr=. Scrollr - Cx
else.
  cc=. Scrollc - Cx
  cr=. Scrollr - Cy
  fc=. Scrollc - Cx
  fr=. Scrollr - Cy
end.
if. GridVirtualMode do.
  cc=. fc
  cr=. fr
end.
dr=. MaxDataRows <. Crws - fr
dc=. MaxDataCols <. Ccls - fc
Srws=: (Gh >: Hh + +/\ (cr + i.dr) { Dh) i. 0
Scls=: (Gw >: Hw + +/\ (cc + i.dc) { Dw) i. 0
Vrws=: Srws + Crws > Srws + cr
Vcls=: Scls + Ccls > Scls + cc
Vlen=: Vrws * Vcls
Vxndx=: cc + i. Vcls
Vyndx=: cr + i. Vrws
Vrndx=: < rots Vyndx;Vxndx
Vcw=: Vxndx { Dw
Vch=: Vyndx { Dh
Vcx=: +/\Gx,Vcw
Vcy=: +/\Gy,Vch
Vcmw=: (-: Vcw) - Mx
Vcmh=: (-: Vch) - My
Vw=: Hw + +/Vcw
Vh=: Gh <. Hh + +/Vch
Vxywh=: Gxywh <. Gx,Gy,<:Vw,Vh
x=. Vlen $ }:Vcx
y=. Vcls # }:Vcy
w=. Vlen $ Vcw
h=. Vcls # Vch
Vrect=: ((Hwh+1) +"1 x,.y),.<:w,.h
Cxndx=: fc + i. Vcls
Cyndx=: fr + i. Vrws
)
drawscrollback=: 3 : 0

VSxywh=: HSxywh=: ''

if. SBv +: SBh do. return. end.
if. SBv *. SBh do.
  glbrush glrgb 1 { GridBackColor
  glpen 0 0
  glrect (Gx+Gw),(Gy+Gh),2$SBHit
end.

drawscrollh 1
drawscrollv 1
)
drawscrollbutton=: 3 : 0

if. SBv +: SBh do. return. end.

if. SBh do.

  'x y w t'=. HSxywh
  y1=. y + 1
  xm=. x + t

  glbrush glrgb 3 { ButtonColor
  glpen 1 0
  glrect (xm+1),y1,(w-1++:t),t-2
  glpen 1 0 [ glrgb 1 { ButtonColor

  if. -.IFWINCE do.
    gpixel ((xm+1),y1) +"1 makedots (w-1++:t),t-2
  end.

  'x y w h'=. HSSxywh
  x1=. x + 1
  y1=. y + 1
  r=. x + w
  s=. y + h

  glbrush glrgb 1 { ButtonColor
  glpen 1 0
  glrect HSSxywh
  glpen 1 0 [ glrgb 3 { ButtonColor
  gllines x1,y1,(r-1),y1
  gllines x1,y1,x1,s-1
  glpen 1 0 [ glrgb 2 { ButtonColor
  gllines x1,(s-1),r,s-1
  gllines (r-1),y1,(r-1),s-1
  glpen 1 0 [ glrgb 4 { ButtonColor
  gllines r,y,r,s
end.
if. SBv do.

  'x y t h'=. VSxywh
  x1=. x + 1
  ym=. y + t

  glbrush glrgb 3 { ButtonColor
  glpen 1 0
  glrect x1,(ym+1),(t-2),h-1++:t
  glpen 1 0 [ glrgb 1 { ButtonColor
  if. -.IFWINCE do.
    gpixel (x1,ym+1) +"1 makedots (t-2),h-1++:t
  end.

  'x y w h'=. VSSxywh
  x1=. x + 1
  y1=. y + 1
  r=. x + w
  s=. y + h
  glpen 1 0 [ glbrush glrgb 1 { ButtonColor
  glrect VSSxywh
  glpen 1 0 [ glrgb 3 { ButtonColor
  gllines x1,y1,x1,s-1
  gllines x1,y1,(r-1),y1
  glpen 1 0 [ glrgb 2 { ButtonColor
  gllines (r-1),y1,(r-1),s
  gllines x1,(s-1),r,s-1
  glpen 1 0 [ glrgb 4 { ButtonColor
  gllines x,s,r,s
end.
)
drawscrollh=: 3 : 0

if. -. SBh do. return. end.

redraw=. y

t=. SBHit
if. SBv do.
  y=. Sy + Sh - t
else.
  y=. Gy + Vh
end.
x=. Gx
w=. Sw - SBv * SBHit
s=. y + t - 1

HSxywh=: x,y,w,t
HSBxywh=: (x,y,t,t),((x+t+1),y,(w-+:t+1),t),:(x+w-t),y,t,t

x1=. x + 1
x2=. x + 2
y1=. y + 1
y2=. y + 2
xm=. x+t
xw=. x+w-t
glbrush glrgb 1 { ButtonColor
glpen 1 0 [ glrgb 0 { GridColor
glrect x,y,w,t
glpen 1 0 [ glrgb 3 { ButtonColor
gllines x2,y2,(xm-1),y2
gllines x2,y2,x2,s
gllines (xw+1),y2,(x+w-1),y2
gllines (xw+1),y2,(xw+1),s
glpen 1 0 [ glrgb 2 { ButtonColor
gllines (xm-1),y2,(xm-1),s
gllines x2,(s-1),xm,s-1
gllines (x+w-2),y2,(x+w-2),s
gllines (xw+1),(s-1),(x+w-2),s-1
glpen 1 0 [ glrgb 4 { ButtonColor
gllines xm,y1,xm,s
gllines (x+w-1),y1,(x+w-1),s
if. redraw > State = iHSlider do.
  h1=. w - +: t + 1
  cls=. Scls <. Tcls - 1
  len=. t >. <. h1 * cls % Tcls
  top=. (h1 - len) * Scrollc % MaxScrollc
  xt=. xm + top + 1
  HSSxywh=: roundint xt,y1,len,(s-y1)
end.
h=. <. 0.25 * _2 + t
x=. x + <. -: t - h
y=. y + >.-: t - +:h
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon (x+h),y,x,(y+h),(x+h),y++:h
x=. x + w - t
glpolygon x,y,(x+h),(y+h),x,y++:h
)
drawscrollv=: 3 : 0

if. -. SBv do. return. end.

redraw=. y

t=. SBHit
if. SBh do.
  x=. Sx + Sw - t
else.
  x=. Gx + Vw
end.
y=. Gy
h=. Sh - SBh * SBHit
r=. x + t - 1

VSxywh=: x,y,t,h
VSBxywh=: (x,y,t,t),(x,(y+t+1),t,h-+:t+1),:x,(y+h-t),t,t

x1=. x + 1
x2=. x + 2
y1=. y + 1
y2=. y + 2
ym=. y + t
yh=. y + h - t
glbrush glrgb 1 { ButtonColor
glpen 1 0 [ glrgb 0 { GridColor
glrect x,y,t,h
glpen 1 0 [ glrgb 3 { ButtonColor
gllines x2,y2,x2,ym-1
gllines x2,y2,r,y2
gllines x2,(yh+1),x2,y+h-1
gllines x2,(yh+1),r,(yh+1)
glpen 1 0 [ glrgb 2 { ButtonColor
gllines x2,(ym-1),r,(ym-1)
gllines (r-1),y2,(r-1),ym
gllines x2,(y+h-2),r,(y+h-2)
gllines (r-1),(yh+1),(r-1),(y+h-2)
glpen 1 0 [ glrgb 4 { ButtonColor
gllines x1,ym,r,ym
gllines x1,(y+h-1),r,y+h-1
if. redraw > State = iVSlider do.
  h1=. h - +: t + 1
  rws=. Srws <. Trws - 1
  len=. t >. <. h1 * rws % Trws
  top=. (h1 - len) * Scrollr % MaxScrollr
  yt=. ym + top + 1
  VSSxywh=: roundint x1,yt,(r-x1),len
end.
w=. <. 0.25 * _2 + t
x=. x + >.-: t - +:w
y=. y + 1 + <. -: t - w
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon x,(y+w),(x+w),y,(x++:w),y+w
y=. y + h - t + 1
glpolygon x,y,(x+w),(y+w),(x++:w),y
)

readsize=: 3 : 0
'rw rh'=. _2 {. Roff
th=. rh + +/ RowHeights
tw=. rw + +/ ColWidths
if. 0=#y do. tw,th return. end.
'mw mh'=. y
sv=. sh=. 0
if. mh <: th do.
  sv=. 1
  sh=. mw <: SBHit + tw
elseif. mw <: tw do.
  sh=. 1
  sv=. mh <: SBHit + th
end.
tw=. mw <. tw + sv * SBHit
th=. mh <. th + sh * SBHit
(2{.Roff) + tw,th
)
drawsort=: 3 : 0
if. -. Hier do. return. end.

if. #LVLCOLSORTROW do.
  row=. LVLCOLSORTROW - Scrollr
  if. row e. i.Srws do.
    px=. Hw - 2 + SortArrowSize
    hh=. Hh + My + >.-: HdrHit
    py=. hh + row{Vcy
    glbrush glrgb SortArrowColor
    glpolygon (LVLCOLSORTDIR{SortArrowLR) + 6 $ px,py
  end.
end.

if. #LVLROWSORTCOL do.
  col=. LVLROWSORTCOL - Scrollc
  if. col e. i.Scls do.
    py=. Gy + Hh - SortArrowSize + -: My + HdrHit
    px=. Hw + ((col+1){Vcx) - SortArrowSize
    glbrush glrgb SortArrowColor
    glpolygon (LVLROWSORTDIR{SortArrowUD) + 6 $ px,py
  end.
end.


)
coclass 'jzgrid'
editx=: 3 : 0
showmark''

Eoldtext=: Text
State=: iEdit
'row col'=. (rots Cell) - Scrollr, Scrollc
ndx=. Vcls #. row,col
editmlinit ''
ind=. (4 rounddown ndx { Vclr) + i.4
EFclr=: ind { CellColorFore
EBclr=: ind { CellColorBack
if. # $ Valn do.
  Ealn=: ndx { Valn
else.-
  Ealn=: Valn
end.
Efont=: getcellfont Cell
if. Eml do.
  glfont Efont
  hit=. (2 * My) + qextenth 'X'
else.
  hit=. row{Vch
end.
Exywh=: (Hw+col{Vcx),(Hh+row{Vcy),1+(col{Vcw),hit
'Ex Ey Ew Eh'=: Exywh
Ecw=: Ew - 2 * Mx
Egw=: Hw + +/Vcw
Emw=: Egw - Hw + 2 * Mx
Epos=: # Text
Esel=: 0
Ecap=: 0
Emx=: Mx
Ebuf=: ,<Text;Ecap;Epos;Esel
Ebufndx=: 0
Capture=: 0
showit''
editshow''
)
editdelsel=: 3 : 0
editsnap''
'b e'=. /:~ Epos + 0, Esel
Text=: (b {. Text), e }. Text
Ecap=: Ecap + 0 <. Esel
Epos=: b
Esel=: 0
)
editgelsel=: 3 : 0
'b e'=. /:~ Epos + 0, Esel
b }. e {. Text
)
editstate=: 3 : 0
s=. (> , ': '"_ , 5!:5)"0
n=. 'Ecap Epos Esel Text'
s ;: n
)
iscelledit=: 3 : 0
if. 0 = # $ CellEdit do. CellEdit return. end.
(<y) { CellEdit
)
iseditable=: 3 : 0
if. CellEdit -: 0 do. 0 return. end.
if. -. CellEdit -: 1 do.
  if. -. (<y) { CellEdit do. 0 return. end.
end.
if. -. 0 -: CellType do.
  typ=. (<y) { CellType
  if. (ischeck typ) +. iscombolist typ do. 0 return. end.
end.
1
)
editsnap=: 3 : 0
Ebuf=: ~. (Text;Ecap;Epos;Esel) ; Ebuf
Ebuf=: (Ebufmax <. #Ebuf) {. Ebuf
Ebufndx=: 0
)
editredo=: 3 : 0
if. Ebufndx > 0 do.
  Ebufndx=: Ebufndx - 1
  'Text Ecap Epos Esel'=: Ebufndx pick Ebuf
  editshow 0
end.
)
editundo=: 3 : 0
if. Ebufndx < <: #Ebuf do.
  Ebufndx=: Ebufndx + 1
  'Text Ecap Epos Esel'=: Ebufndx pick Ebuf
  editshow 0
end.
)
kbEXIT1=: kbENTER,kbEND,kbHOME,kbLEFT,kbRIGHT,kbUP,kbDOWN
editchar=: editcharx=: 3 : 0

c=. sysdata__locV
d=. alfndx {. c
m=. 0 ". sysmodifiers__locV
if. d > 31 do.
  if. m e. 2 3 do. return. end.
  editdelsel''
  Text=: (Epos {. Text), (ucp c), Epos }. Text
  Epos=: Epos + 1
  editmlnew''
  editshow'' return.
end.
if. Type = 1 do.
  if. d e. kbEXIT1 do.
    editfini 2 return.
  end.
end.
Textold=. Text

select. d

case. kbBS do.
  if. Esel do.
    editdelsel ''
  else.
    if. m e. 2 3 do.
      Text=: Epos }. Text
      Epos=: 0
    else.
      Text=: (_1 }. Epos {. Text), Epos }. Text
      Epos=: 0 >. <: Epos
    end.
  end.
case. kbLF do.
  if. 0 = editmlsplit (Epos{.Text);Epos}.Text do. return. end.
case. kbENTER do.
  editfini 2 return.
case. kbESC do.
  editfini 0 return.
case. kbEND do.
  if. m e. 1 3 do.
    Esel=: Epos + (0 <. Esel) - # Text
  else.
    Esel=: 0
  end.
  Epos=: # Text
case. kbHOME do.
  if. m e. 1 3 do.
    Esel=: Epos + 0 >. Esel
  else.
    Esel=: 0
  end.
  Epos=: 0
case. kbLEFT do.
  select. m
  case. 0 do.
    Esel=: 0
    Epos=: 0 >. <: Epos
    Ecap=: Ecap <. Epos
  case. 1 do.
    Esel=: Esel + Epos > 0
    Epos=: 0 >. <: Epos
    Ecap=: Ecap <. Epos
  case. 2 do.
    Ecap=: Esel=: Epos=: 0
  case. 3 do.
    Esel=: Epos + 0 >. Esel
    Ecap=: Epos=: 0
  end.
case. kbRIGHT do.
  select. m
  case. 0 do.
    Esel=: 0
    Epos=: (# Text) <. >: Epos
  case. 1 do.
    Esel=: Esel - Epos < # Text
    Epos=: (# Text) <. >: Epos
  case. 2 do.
    Esel=: 0
    Epos=: # Text
  case. 3 do.
    Esel=: Epos + (0 <. Esel) - # Text
    Epos=: # Text
  end.
case. kbDEL do.
  if. Esel do.
    editdelsel''
  else.
    select. m
    case. 0 do.
      Text=: (Epos {. Text), 1 }. Epos }. Text
    case. 2 do.
      Text=: Epos {. Text
    end.
  end.
end.
editshow -. Text -: Textold
)
editcopy=: 3 : 0
wdclipwrite editgetsel''
)
editcut=: 3 : 0
wdclipwrite editgetsel''
editdelsel''
editshow''
)
editpaste=: 3 : 0
editdelsel''
Text=: (Epos {. Text),(ucp wdclipread''),Epos }. Text
editshow''
)
editfini=: 3 : 0
if. y do.
  'rc val'=. editvalidate''
  select. rc
  case. 0 do.
    val change Cell
    Show=: 2
  case. 2 do. return.
  end.
end.
glcaret 0 0 0 0
glcursor IDC_ARROW
State=: 0
if. y=2 do.
  0
else.
  showit''
end.
)
editvalidate=: 3 : 0

editmlfini''

old=. readcell Cell

if. ischar old do.
  txt=. utf8 Text
  (old -: txt);txt return.
end.

val=. {. NaN ". 1 u: Text

if. val = NaN do.
  info 'Not a number: ',Text
  2;'' return.
end.

if. isinteger old do.
  if. isinteger val do.
    val=. <. val
  end.
end.

(old-:val);val
)
editmouse=: 3 : 0

'x y w h l r ctrl shift middle xbutton1 xbutton2 wheel'=. 0 ". sysdata__locV

if. (x < Ex) +. x > Ex + Ew do. 1 return. end.
if. (y < Ey) +. y > Ey + Eh do. 1 return. end.

x=. x - Ex + Emx

txt=. Ecap }. Text
len=. # txt
wid=. qextentw16 txt
ndx=. >. x * len % wid

if. ndx <: 0 do. 0 0 return. end.
if. ndx >: len do. 0, len return. end.

act=. qextentw16 ndx {. txt
prv=. qextentw16 (ndx-1) {. txt
while. (prv > x) *. ndx > 0 do.
  act=. prv
  ndx=. ndx - 1
  prv=. qextentw16 (ndx-1) {. txt
end.

nxt=. qextentw16 (ndx+1) {. txt
while. (nxt <: x) *. ndx < # txt do.
  act=. nxt
  ndx=. ndx + 1
  nxt=. qextentw16 (ndx+1) {. txt
end.

0, ndx + Ecap
)
editmbldbl=: 3 : 0
Epos=: # Text
Esel=: -Epos
editshow 0
)
editmbldown=: 3 : 0
'rc pos'=. editmouse ''
if. rc do. editfini 1 return. end.
Epos=: pos
Esel=: 0
capture 1
editshow 0
)
editmblup=: 3 : 0
capture 0
)
editmmove=: 3 : 0
if. Capture do.
  'rc pos'=. editmouse ''
  if. rc do. 1 return. end.
  Esel=: pos - Epos
  editshow 0
end.
)
EMLchars=: '/\|$#@~!%^&*+;:,.<>?'
editmlfini=: 3 : 0
if. -. Eml do. return. end.
Text=: }. LF (I. Text = Emld) } Text
Eml=: 0
)
editmlinit=: 3 : 0
if. 2 = #$Text do.
  Eml=: 1
  Text=: }. ,LF,.Text
else.
  Eml=: LF e. Text
end.
if. Eml do.
  Emld=: {. EMLchars -. Text
  if. Emld = ' ' do.
    info 'Cannot edit this multiline cell - no suitable line delimiter.'
    State=: 0 return.
  end.
  Text=: Emld, Emld (I. Text = LF) } Text
end.
)
editmlnew=: 3 : 0
if. -. Eml do. return. end.
if. Emld = {. Text do. return. end.
if. 0 = #Text do. Eml=: 0 return. end.
new=. {. Text
Text=: new (I. Text = Emld) } Text
Emld=: new
)
editmlsplit=: 3 : 0
'bgn end'=. y
bgn0=. (-' ' = {:bgn) }. bgn
end0=. (' ' = {.end) }. end
if. Eml do.
  Text=: bgn0,Emld,end0
  1 return.
end.
Emld=: {. EMLchars -. bgn, end
if. Emld = ' ' do.
  info 'Cannot create this multiline cell - no suitable line delimiter.'
  Text=: bgn,end
  0 return.
end.
Text=: Emld,bgn0,Emld,end0
Eml=: 1
)
editfit=: 3 : 0
if. Ecw >: Elen do.
  Ecap=: 0 return.
end.
if. Emw >: Elen do.
  pad=. Elen - Ecw
  Ecw=: Elen
  Ew=: Ecw + 2 * Mx
  Ex=: Hw >. Ex - <. -: pad
  Ex=: Ex - 0 >. (Ex + Ew) - Egw + 1
  Exywh=: Ex,Ey,Ew,Eh
  Ecap=: 0 return.
end.
if. Ecw >: qextentw16 Ecap }. Epos {. Text
do. return.
end.
while. 1 do.
  Ecap=: >: Ecap
  if. Ecw >: qextentw16 Ecap }. Epos {. Text
  do. return.
  end.
end.
)
editemx=: 3 : 0
select. Ealn
case. 1 do.
  Emx=: Mx + -: 0 >. Ecw - Elen
case. 2 do.
  Emx=: Mx + 0 >. Ecw - Elen
end.
)
editshow=: 3 : 0
glcursor IDC_IBEAM
glbrush glrgb {. EBclr
glfont Efont
glrgb {. EFclr
glpen 1 0
gltextcolor ''
Elen=: qextentw16 Text
editfit''
editemx''
glclipreset''
glclip Exywh
glrect Exywh
txt=. Ecap }. Text
pos=. Epos - Ecap
sel=. Esel + 0 >. Ecap - Epos + Esel
gltextxy (Ex,Ey) + Emx,My
gltext utf8 txt
if. sel do.
  b=. <./ pos + 0,sel
  n=. | sel
  x=. qextentw16 b {. txt
  s=. qextentw16 (b + n) {. txt
  w=. (s-x) <. Ew - 1 + x + Emx
  glbrush glrgb 1 { EBclr
  glrect (x + Ex + Emx),Ey,(s-x),Eh
  gltextcolor glrgb 1 { EFclr
  gltextxy (x + Ex + Emx),Ey + My
  gltext utf8 n {. b }. txt
end.
wid=. Emx + qextentw16 pos {. txt
glcaret (Ex+wid),(Ey+My2),1,Eh-4*My
glpaint''

if. y do. editsnap'' end.
1
)
coclass 'jzgrid'
change=: 4 : 0
Value=: x
Cell=: y
if. gridhandler 'change' do.
  changex''
  gridhandler 'changed'
end.
)
click=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. gridhandler 'click' do.
  clickx''
end.
)
dblclick=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. gridhandler 'dblclick' do.
  dblclickx''
end.
)
rclick=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. gridhandler 'rclick' do.
  rclickx''
end.
)
rdblclick=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. gridhandler 'rdblclick' do.
  rdblclickx''
end.
)
edit=: 3 : 0
'Type Text Cell'=: y
Text=: ucp Text
if. gridhandler 'edit' do.
  editx ''
end.
)
focus=: 3 : 0
gridhandler 'focus'
)
focuslost=: 3 : 0
gridhandler 'focuslost'
)
focusx=: focuslostx=: ]
get=: 3 : 0
'Rws Cls'=: y
if. gridhandler 'get' do.
  getx ''
end.
)
gridsort=: 3 : 0
'Row Col Dim'=: y
if. gridhandler 'gridsort' do.
  gridsortx''
end.
)
key=: 3 : 0
'Char Ctrl Shift'=: y
if. gridhandler 'key' do.
  keyx ''
end.
)
mark=: 3 : 0
gridhandler 'mark'
)
runclick=: click
runrclick=: rclick
coclass 'jzgrid'
flat=: 3 : 0

if. 0 = L. y do. fmt y return. end.
if. 1 = L. y do.
  rnk=. #@$ S:0 y
  num=. -. (3!:0 S:0 y) e. CHARTYPE
  if. 2 > >./ rnk + num do. fmt y return. end.
  dat=. ,y
  ndx=. I. num *. rnk=1
  dat=. (": each ndx { dat) ndx } dat
else.
  dat=. ,y
  ndx=. I. 0 < L. S:_1 dat
  if. #ndx do.
    dat=. (": each ndx { dat) ndx } dat
  end.
  rnk=. #@$ S:0 dat
end.
ndx=. I. rnk < 2
dat=. (fmt ndx { dat) ndx } dat
ndx=. I. rnk = 2
dat=. (flat2 each ndx { dat) ndx } dat
ndx=. I. rnk > 2
dat=. (flatn each ndx { dat) ndx } dat

($y) $ dat
)
flat2=: }. @ , @ (LF&,.) @ ":
flatn=: 3 : 0
dat=. 1 1}. _1 _1}. ": < ": y
}: (,|."1 [ 1,.-. *./\"1 |."1 dat=' ')#,dat,.LF
)
getfmt=: 3 : 0
CellDFmtM=: ''
if. #CellFmt do.
  getfmtd''
else.
  getfmtm''
end.
CellDFmt=: 8 u: each CellDFmt
Fshape=: $CellDFmt
)
fmtd=: 4 : 0
if. Sparse do.
  x fmts y
else.
  x fmt y
end.
)
getfmtd=: 3 : 0
if. 1 = rank CellData do.
  CellDFmt=: getfmtdv ''
else.
  CellDFmt=: getfmtdm ''
end.
EMPTY
)
getfmtdm=: 3 : 0
if. 0 e. $CellData do. CellData return. end.
if. 2 = #$CellFmt do.
  CellFmt fmt each CellData
else.
  CellFmt fmtd CellData
end.
)
getfmtdv=: 3 : 0
select. #$CellFmt

case. 0 do.
  {. |: CellFmt fmt &> CellData
case. 1 do.
  {. |: CellFmt fmt &> CellData
case. 2 do.
  fm=. ('';1) <@,;.1 CellFmt
  {. |: fm fmt each CellData
end.

)
getfmtm=: 3 : 0

if. 0 e. $CellData do.
  CellDFmt=: CellData return.
end.

if. 1 = rank CellData do.
  CellDFmt=: {. |: flat &> CellData
else.
  CellDFmt=: flat CellData
end.

if. -. LF e. ;CellDFmt do. EMPTY return. end.

ndx=. I. LF e.S:0 CellDFmt
ind=. <"1 ($CellDFmt) #: ndx
if. 1 e. 0 ~: , ind getindex CellType do.
  info 'Only text cell types may have more than one line.'
  CellDFmt=: CellDFmt -. each LF return.
end.
if. 1 e. 0 ~: , ind getindex CellOverFlow do.
  info 'LF not permitted in overflow cells.'
  CellDFmt=: CellDFmt -. each LF return.
end.
CellDFmtM=: ndx
CellDFmtL=: (, ind { CellDFmt) ,each LF
top=. (CellDFmtL i.&> LF) {.each CellDFmtL
CellDFmt=: top ind } CellDFmt
EMPTY
)
fmtn=: 4 : 0
y=. ,. y
rws=. # y
val=. ('';1) <;.1 y
spcs=. <;._1 ';',x -. ' '
if. 1 e. b=. 'r' e. &> spcs do.
  ix=. spcs {~ ind=. I. b
  ndx=. i.&'r' &> ix
  len=. 0 ". &> ndx {. each ix
  spcs=. ((>:ndx) }. each ix) ind } spcs
  spcs=. spcs #~ len ind } >:b
end.

fm=. spcs
r=. (rws,0) $ ''
while. #val do.

  fm=. fm,(0=#fm)#spcs
  spc=. >{.fm
  fm=. }.fm
  if. 'x' = {.spc do.
    w=. {. (0 ". }.spc), 1
    r=. r ,"1 w # ' ' continue.
  end.

  dat=. , >{.val
  val=. }.val
  num=. spc -. 'bcmz'

  if. #num do.
    'wid dec'=. 0 1 #: {. 0 ". num
  else.
    if. dat -: <. dat do.
      dec=. 0
    else.
      dec=. 0.1 * >./ +/ * (10 ^ -i.9) |/ dat
    end.
    wid=. 0
  end.
  neg=. I. dat < 0
  min=. I. dat = __
  pin=. I. dat = _

  res=. dec ": &.> | dat

  if. 'c' e. spc do.
    msk=. (-wid){.(|. wid$1j1 1 1),(3+(10*dec)+*dec)$1
    exp=. #!.','~ ({.&msk)@-@#
    res=. exp &.> res
  end.

  if. 'b' e. spc do.
    res=. (<'') (I. 0=dat) } res
  end.

  if. 'z' e. spc do.
    res=. (-wid){.!.'0' &.> ,res
    res=. > ('-'&, @ }. &.> neg { res) neg } res
  else.
    res=. ('-' ,each neg { res) neg } res
    res=. (-wid){.!.' ' &> res
  end.

  r=. r ,. >res
end.
)

fmts=: 4 : 0
if. 2 > # 2 $. y do.
  x fmt y
else.
  ndx=. 4 $. y
  res=. ($y) $ Sparse0
  if. #ndx do.
    (x fmt 5$.y) (<"1 ndx) } res
  end.
end.
)
coclass 'jzgrid'
gridpinfo=: wdinfo @ ('Grid'&;)
gridpdefs=: 3 : 0
r=. gridpdefaults''

if. 2 < #$CELLDATA do.
  gridpdefs_cube''
  r=. r, ;:'AXISNAMES AXISLABELS AXISORDER COLMINWIDTH'
end.

if. 0=#y do. return. end.

locD=: {:y
def=. > {.y
if. (L. def) *. 2 = #$def do.
  r, unpack def return.
end.
if. (ischar def) *. 1 < #def do.
  r, locD readloc def return.
end.
if. 2 < #$CELLDATA do.
  nms=. ;: 'AXISNAMES AXISLABELS AXISORDER'
  if. #def do.
    ((#def){.nms)=: def
  end.
else.
  'HDRROW HDRCOL'=: 2 $ def
  r=. r, ;:'HDRROW HDRCOL'
end.

r
)
gridpdefaults=: 3 : 0
if. isboxed CELLDATA do.
  typ=. 3!:0 &> CELLDATA
  rnk=. #@$ &> CELLDATA
  CELLFONT=: (1 e. ,rnk > 1) +. 1 e. ,typ e. BOXTYPE
  CELLALIGN=: +: -. (rnk=1) +. typ e. BOXTYPE,CHARTYPE
else.
  CELLALIGN=: 2
end.
CELLEDIT=: 0
nms=. ;: 'CELLALIGN CELLDATA CELLEDIT CELLFONT'
)
gridpdefs_cube=: 3 : 0
rnk=. #$CELLDATA
AXISNAMES=: 'Dim'&, each ": each i.rnk
AXISLABELS=: (": each @ i.) each $CELLDATA
select. rnk
case. 3 do. s=. 0 1;2;''
case. 4 do. s=. 0 1;2 3;''
case. do. s=. (2{.m);(_2{.m);2}._2}.m=. i.rnk
end.
AXISORDER=: s
COLMINWIDTH=: 50
)
MinGrid=: 120 0
gridp=: 3 : 0
'' gridp y
:
a=. conew 'jzgrid'
x gridpshow__a y
)
gridpshow=: 4 : 0
CELLDATA=: y
cube=. 2 < #$CELLDATA
defs=. towords gridpdefs x
wd GRIDP
destroy=: gridpdestroy
formx=. 0 ". wd 'qformx'
wh=. _2 {. getxywhx''
grid=: '' conew 'jzgrid'
wd 'pshow;'
show__grid defs
twh=. MinGrid >. readsize__grid wh
del=. 0 <. twh - wh
if. -. IFJAVA do.
  wd 'setxywhx grid 0 0 ',":wh + del
end.
wd 'pmovex ',":formx + 0 0,0 <. del+1+5*IFJAVA
)
GRIDP=: 0 : 0
pc gridp;pn "Grid";
xywh 0 0 400 300;cc grid isigraph ws_border rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
gridpdestroy=: 3 : 0
wd 'pclose'
destroy__grid''
codestroy''
)
gridp_close=: gridp_cancel=: gridpdestroy
coclass 'jzgrid'
axmbldown=: 3 : 0
if. State = iACombo do.
  bcfini 0 return.
end.
if. y inrect ATrect do.
  bcinitaxis y inrectx ATrect
else.
  ndx=. y inrectx AXrect
  State=: iAMove
  capture 7,ndx{AXrect
  Pos=: ndx,Mxy
end.
)
axmblup=: 3 : 0
State=: 0
capture 0
m=. _1 ^ '0' = {. sysmodifiers__locV
'pos mx my'=. Pos
'rws cls sel slx'=. old=. AXISORDER
dim=. pos { rws,cls,sel
'px py'=. y
if. py > Sy+Sh do.
  px=. px - mx - {. pos{AXrect
  msk=. pos ~: i.#rws
  rws=. msk # rws
  pxs=. msk # {."1 ARrect
  ndx=. pxs I. px
  cls=. cls -. dim
  if. 0=#cls do.
    cls=. m {. rws
    rws=. m }. rws
    ndx=. ndx <. #rws
  end.
  rws=. (ndx{.rws),dim,ndx}.rws
  sel=. sel -. dim
elseif. px > Sx+Sw do.
  py=. py - my - 1 { pos{AXrect
  pos=. pos - #rws
  msk=. pos ~: i.#cls
  cls=. msk # cls
  pys=. msk # 1 {"1 ACrect
  ndx=. pys I. py
  rws=. rws -. dim
  if. 0=#rws do.
    rws=. m {. cls
    cls=. m }. cls
    ndx=. ndx <. #cls
  end.
  cls=. (ndx{.cls),dim,ndx}.cls
  sel=. sel -. dim
elseif. py <: Axhit + 5 do.
  px=. px - mx - {. pos{AXrect
  pos=. pos - #rws,cls
  msk=. pos ~: i.#sel
  sel=. msk # sel
  pxs=. msk # {."1 ASrect
  ndx=. pxs I. px
  cls=. cls -. dim
  rws=. rws -. dim
  if. 0=#cls do.
    cls=. m {. sel
    sel=. m }. sel
    ndx=. ndx <. #sel
  end.
  if. 0=#rws do.
    rws=. m {. sel
    sel=. m }. sel
    ndx=. ndx <. #sel
  end.
  sel=. (ndx{.sel),dim,ndx}.sel
end.
new=. rws;cls;sel;slx
if. -. old -: new do.
  AXISORDER=: new
  refresh''
end.
)
mbldbl=: 3 : 0

mouseset''
if. State = iEdit do.
  if. editmbldbl '' do. return. end.
end.

State=: 0
if. Mxy inrect VSxywh do.
  vsmbldown Mxy return.
elseif. Mxy inrect HSxywh do.
  hsmbldown Mxy return.
elseif. Mxy inrect Vxywh do.
  dblclick mousepos ''
elseif. do.
  dblclick _1
end.
)
dblclickx=: 3 : 0

pos=. Row, Col
scr=. Row - Scrollr
scc=. Col - Scrollc

if. (scr e. i.Vrws) *. scc e. i.Vcls do.
  cell=. rots pos
  if. -. iseditable cell do. return. end.
  if. -. (scr e. i.Srws) *. scc e. i.Scls do.
    ShowMark=: 0
    moveto pos
    showit''
  end.
  txt=. readedit cell
  edit 2;txt;cell

end.
)
mbldown=: 3 : 0
gridfocus''
mouseset''
select. State
case. iEdit do.
  if. editmbldown '' do. return. end.
case. iCombos do.
  if. bcmbldown '' do. return. end.
end.

State=: 0
if. Mxy inrect VSxywh do.
  vsmbldown Mxy
elseif. Mxy inrect HSxywh do.
  hsmbldown Mxy
elseif. Mxy inrect AXrect do.
  axmbldown Mxy
elseif. Ctrl < Mxy inrect LCrect do.
  lcmbldown Mxy
elseif. Ctrl < Mxy inrect LRrect do.
  lrmbldown Mxy
elseif. Mxy inrect Vxywh do.
  runclick mousepos''
elseif. do.
  click _1
end.
)
clickx=: 3 : 0

pos=. Row, Col
scr=. Row - Scrollr
scc=. Col - Scrollc
if. *./ 0 <: pos do.

  if. 0 -: Vtyp do.
    typ=. 0
  else.
    typ=. (Vcls #. scr,scc) { Vtyp
  end.

  r=. moveto pos

  if. ischeck typ do.
    ndx=. rots pos
    new=. -. readcell ndx
    new change ndx
    State=: iCheck
    Show=: 2
    r=. 1
  else.
    if. iscombo typ do.
      if. (scr{Vch) > (Hw+(scc+1){Vcx) - {.Mxy do.
        bcinit rots pos return.
      end.
    end.
    if. -.GRIDROWMODE do.
      State=: iSelect
      Mousetime=: 6!:1 ''
    end.
  end.

  if. r do. showit'' end.
  return.
end.
if. ColResize *. Row e. - 1 + i. Hr do.
  mx=. {. Mxy
  dif=. | (mx - Gx + Hw) - +/\ Vcw
  min=. (i. <./) dif
  if. Mousetol >: min { dif do.
    glcursor IDC_SIZEWE
    capture 5
    ResizeX=: min + Hc
    ResizeP=: mx
    State=: iCResize
  end.
  return.
end.
if. mbgridsort '' do. return. end.
)
mblup=: 3 : 0
select. State
case. iEdit do.
  editmblup''
case. iSelect do.
  State=: 0
case. iHSlider do.
  hsmblup''
case. iVSlider do.
  vsmblup''
case. iCResize do.
  colresize''
case. iRResize do.
  rowresize''
case. iCombos do.
  bcmblup''
case. iAMove do.
  axmblup mousexy''
end.
)
mbmdbl=: 3 : 0
mouseset''
if. Mxy inrect Vxywh do.
  mdblclick mousepos ''
end.
)
mbmdown=: 3 : 0
gridfocus''
mouseset''
if. Mxy inrect Vxywh do.
  mclick mousepos ''
end.
)
mbmup=: 3 : 0
EMPTY
)
mdblclickx=: 3 : 0
EMPTY
)

mclickx=: 3 : 0
EMPTY
)
mouserc=: 3 : 0
'x y'=. 2 {. 0 ". sysdata__locV
col=. Hc -~ <: (x >: Hx,Hw+Vcx) i. 0
row=. Hr -~ <: (y >: Hy,Hh+Vcy) i. 0
row, col
)
mousexy=: 3 : '2 {. 0 ". sysdata__locV'
mouseset=: 3 : 0
Mxy=: 2 {. a=. 0 ". sysdata__locV
'Ctrl Shift'=: 6 7 { a
)
mousepos=: 3 : 0
'x y w h l r ctrl shift middle xbutton1 xbutton2 wheel'=. 0 ". sysdata__locV

xp=. Hx,Hw+Vcx
col=. <: (x >: xp) i. 0
x=. (x - col{xp) % -/(col+1 0){xp
col=. col - Hc
col=. col + Scrollc * col >: 0

yp=. Hy,Hh+Vcy
row=. <: (y >: yp) i. 0
y=. (y - row{yp) % -/(row+1 0){yp
row=. row - Hr
row=. row + Scrollr * row >: 0

x, y, row, col, ctrl, shift
)
mmove=: 3 : 0

select. State
case. iEdit do.
  if. editmmove '' do. return. end.
case. iSelect do.
  'row col'=. mouserc ''
  if. -. (row e. i.Srws) *. col e. i.Scls do.
    if. (Mousewait + Mousetime) > 6!:1 '' do. return. end.
  end.
  row=. 0 >. (Scrollr + row) <. <:Trws
  col=. 0 >. (Scrollc + col) <. <:Tcls
  Mousetime=: 6!:1''
  if. movexto row,col do. showit'' end.
case. iCombos do.
  if. bcmmove '' do. return. end.
case. iHSlider do.
  hsmmove '' return.
case. iVSlider do.
  vsmmove '' return.
case. do.
  xy=. mousexy''
  if. xy inrect HvRects do.
    sethover (xy inrectx HvRects) { HvRects
  else.
    clearhover''
  end.
end.
)
rowresize=: ]
colresize=: 3 : 0
'x y'=. mousexy ''
COLWIDTH=: (Hc + Ccls) $ COLWIDTH
new=. (x-ResizeP) + ResizeX { COLWIDTH
COLWIDTH=: new ResizeX } COLWIDTH
State=: 0
capture 0
glcursor IDC_ARROW
refresh''
)
mbrdbl=: 3 : 0
mouseset''
if. Mxy inrect Vxywh do.
  rdblclick mousepos ''
end.
)
mbrdown=: 3 : 0
gridfocus''
mouseset''
if. Mxy inrect Vxywh do.
  rclick mousepos ''
end.
)
mbrup=: 3 : 0
EMPTY
)
rdblclickx=: 3 : 0
EMPTY
)

rclickx=: 3 : 0
EMPTY
)

hsmbldown=: 3 : 0
pos=. {. y
if. pos inint 0 2 { HSSxywh do.
  State=: iHSlider
  capture 1
  Pos=: ({.HSSxywh), pos, pos return.
elseif. pos inint 0 2 { 0 { HSBxywh do.
  Scrollc=: Scrollc - 1
elseif. pos inint 0 2 { 1 { HSBxywh do.
  if. pos < {. HSSxywh do.
    Scrollc=: Scrollc + 1 - Scls
  else.
    Scrollc=: Scrollc + Scls - 1
  end.
elseif. pos inint 0 2 { 2 { HSBxywh do.
  Scrollc=: Scrollc + 1
end.
Scrollc=: 0 >. Scrollc <. MaxScrollc
ShowMark=: 0
showit 0
)
hsmblup=: 3 : 0
State=: 0
capture 0
hsmscroll''
)
hsmmove=: 3 : 0
'x y'=. mousexy ''
'mx my mw mh'=. 1 { HSBxywh
'sx sy sw sh'=. HSSxywh
sx=. mx >. (({.Pos) + x - 1 { Pos) <. mx + mw - sw
HSSxywh=: sx 0 } HSSxywh
if. IFWINCE do.
  drawscrollbutton''
  glpaint''
else.
  hsmscroll''
end.
)
hsmscroll=: 3 : 0
'mx my mw mh'=. 1 { HSBxywh
'sx sy sw sh'=. HSSxywh
pos=. (sx - mx) % mw - sw
os=. Scrollc
if. pos=1 do.
  Scrollc=: MaxScrollc
else.
  cs=. MaxScrollc <. <. 0.5 + pos * Tcls - Scls
  if. cs ~: Scrollc do.
    if. sx >: 2 { Pos do.
      Scrollc=: cs >. Scrollc
    else.
      Scrollc=: cs <. Scrollc
    end.
    Pos=. sx 2 } Pos
  end.
end.
if. os = Scrollc do.
  drawscrollbutton''
  glpaint''
else.
  ShowMark=: 0
  showit''
end.
)
vsmbldown=: 3 : 0
pos=. {: y
if. pos inint 1 3 { VSSxywh do.
  capture 1
  State=: iVSlider
  Pos=: (1{VSSxywh), pos, pos return.
elseif. pos inint 1 3 { 0 { VSBxywh do.
  Scrollr=: Scrollr - 1
elseif. pos inint 1 3 { 1 { VSBxywh do.
  if. pos < 1 { VSSxywh do.
    Scrollr=: Scrollr + 1 - Srws
  else.
    Scrollr=: Scrollr + Srws - 1
  end.
elseif. pos inint 1 3 { 2 { VSBxywh do.
  Scrollr=: Scrollr + 1
end.
Scrollr=: 0 >. Scrollr <. MaxScrollr
ShowMark=: 0
showit 0
)
vsmblup=: 3 : 0
State=: 0
capture 0
vsmscroll''
)
vsmmove=: 3 : 0
'x y'=. mousexy ''
'mx my mw mh'=. 1 { VSBxywh
'sx sy sw sh'=. VSSxywh
sy=. my >. (({.Pos) + y - 1 { Pos) <. my + mh - sh
VSSxywh=: sy 1 } VSSxywh
if. IFWINCE do.
  drawscrollbutton''
  glpaint''
else.
  vsmscroll''
end.
)
vsmscroll=: 3 : 0
'mx my mw mh'=. 1 { VSBxywh
'sx sy sw sh'=. VSSxywh
pos=. (sy - my) % mh - sh
os=. Scrollr
if. pos=1 do.
  Scrollr=: MaxScrollr
else.
  cs=. MaxScrollr <. <. 0.5 + pos * Trws - Srws
  if. cs ~: Scrollr do.
    if. sy >: 2 { Pos do.
      Scrollr=: cs >. Scrollr
    else.
      Scrollr=: cs <. Scrollr
    end.
    Pos=. sy 2 } Pos
  end.
end.
if. os = Scrollr do.
  drawscrollbutton''
  glpaint''
else.
  ShowMark=: 0
  showit''
end.
)
mbgridsort=: 3 : 0
if. GRIDFLIP do. 0 return. end.
ndx=. (Col,Row) i. _1
if. ndx = 2 do. 0 return. end.
if. -. ndx{GridSort do. 0 return. end.
if. (Cube = 0) *. ndx = 0 do. 0 return. end.
pos=. ((Row - Scrollr) e. i.Vrws),(Col - Scrollc) e. i.Vcls
if. -. ndx{pos do. 0 return. end.
if. Cube do.
  ndx=. {: ndx pick AXISORDER
end.
gridsort Row,Col,ndx
1
)
mwheel=: 3 : 0
Scrollr=: Scrollr - {: 0 ". sysdata__locV
Scrollr=: 0 >. Scrollr <. MaxScrollr
ShowMark=: 0
showit 0
)
coclass 'jzgrid'
getmark=: 3 : 0
2 {. CELLMARK,Scrollr,Scrollc
)
moveby=: 3 : 0
moveto 0 >. (<: Trws,Tcls) <. y + getmark''
)
movexto=: 3 : 0
select. #CELLMARK
case. 0 do.
  old=. ''
  CELLMARK=: y,y
case. 2 do.
  old=. CELLMARK
  CELLMARK=: y,old
case. 4 do.
  old=. 2 {. CELLMARK
  CELLMARK=: y, 2 }. CELLMARK
end.
NewMark=: -. old -: y
)
movexby=: 3 : 0
movexto 0 >. (<: Trws,Tcls) <. y + getmark''
)
movexall=: 3 : 0
m=. y
'x y r s'=. 4 {. CELLMARK,CELLMARK
select. m
case. 1 do.
  CELLMARK=: x,0,r,<:Tcls
case. 2 do.
  CELLMARK=: 0,y,(<:Trws),s
case. 3 do.
  CELLMARK=: 0 0,<:Trws,Tcls
end.
)
writemark=: 3 : 0
if. GRIDFLIP do.
  CELLMARK=: ((#y) {. 1 0 3 2) { y
else.
  CELLMARK=: y
end.
)
moveedge=: 3 : 0
'row col'=. getmark''
select. y
case. 0 _1 do. col=. 0
case. 0 1 do. col=. <:Tcls
case. _1 0 do. row=. 0
case. 1 0 do. row=. <:Trws
end.
moveto row,col
)
movenext=: 3 : 0
'row col'=. getmark''
if. 1 < Crws do.
  row=. (<:Trws) <. row + 1
else.
  col=. (<:Tcls) <. col + 1
end.
moveto row,col
)
movepage=: 3 : 0
ShowMark=: 0
Scrollr=: 0 >. MaxScrollr <. Scrollr + 0 { y
Scrollc=: 0 >. MaxScrollc <. Scrollc + 1 { y
)
movetocell=: 3 : 0
if. #CELLMARK do.
  old=. 2 {. CELLMARK
else.
  old=. ''
end.
CELLMARK=: y
NewMark=: -. old -: y
)
moveto=: movetocell
readmark=: 3 : 0
if. GRIDFLIP do.
  ((#CELLMARK) {. 1 0 3 2) { CELLMARK
else.
  CELLMARK
end.
)
writemark=: 3 : 0
if. GRIDFLIP do.
  CELLMARK=: ((#y) {. 1 0 3 2) { y
else.
  CELLMARK=: y
end.
)
showmark=: 3 : 0

if. 0 e. Crws,Ccls do. CELLMARK=: $0 end.
if. 0 = #CELLMARK do. showscroll'' return. end.
'r c'=. 2 {. CELLMARK
Scrollr=: r <. Scrollr
Scrollc=: c <. Scrollc
if. showscrollmin'' do. 1 return. end.
if. GridVirtualMode do.
  'tx ty'=. rots Cx,Cy
else.
  tx=. ty=. 0
end.

hit=. ((<:#Dh) <. r - ty + i. 1 + r - Scrollr) { Dh
Scrollr=: Scrollr >. r - 0 i:~ (Gh - Hh) < +/\ hit

wid=. ((<:#Dw) <. c - tx + i. 1 + c - Scrollc) { Dw
Scrollc=: Scrollc >. c - 0 i:~ (Gw - Hw) < +/\ wid

showscrollmax''
)
showscroll=: 3 : 0
if. showscrollmin'' do. 1 return. end.
showscrollmax''
)
showscrollmin=: 3 : 0
new=. 0
'sr sc'=. rots Scrollr,Scrollc
if. sr < Cy do.
  new=. 1
  Cy=: 0 >. sr - {.Slack
end.
if. sc < Cx do.
  new=. 1
  Cx=: 0 >. sc - {.Slack
end.

showscrollnew new
)
showscrollmax=: 3 : 0

new=. 0
'sr sc'=. rots Scrollr,Scrollc
'mt ms'=. rots <: (Scrollr + MaxDataRows),Scrollc + MaxDataCols

if. Ct < Tt <. mt do.
  new=. 1
  Cy=: Cy >. sr - {.Slack
end.

if. Cs < Ts <. ms do.
  new=. 1
  Cx=: Cx >. sc - {:Slack
end.

showscrollnew new
)
showscrollnew=: 3 : 0
if. y do.
  showit 4
end.
y
)

coclass 'jzgrid'
gridsortx=: 3 : 0
if. Cube do.
  gridsortcube''
else.
  gridsorttable''
end.
)
gridsortcube=: 3 : 0

rnk=. #$CELLDATA

if. 0=#SortIndex do. SortIndex=: rnk$a: end.

ndx=. cubegetindex i.rnk
ind=. (Row,Col) i. _1
'sid bal'=. ind |. 2 {. AXISORDER
sdm=. {:sid
ndx=. 0 sid } ndx
psx=. (bal{$CELLDATA) #: (-.ind) { Row,Col
ndx=. psx bal } ndx
ndx=. <(<<'') sdm} <&> ndx
dat=. ndx { CELLDATA

srt=. /: dat
if. srt -: i.#dat do. srt=. \: dat end.
cubeputindex sdm,srt i. cubegetindex sdm
AXISLABELS=: (<srt{sdm pick AXISLABELS) sdm } AXISLABELS
CELLDATA=: srt{"(rnk-sdm) CELLDATA
if. 0=#old=. sdm pick SortIndex do.
  new=. srt
else.
  new=. srt{old
end.
SortIndex=: (<new) sdm } SortIndex
refresh''
)
SORTNOUNS=: <;._2 (0 : 0)
CellHex
CELLCOLOR
CELLEDIT
CELLFONT
CELLOVERFLOW
CELLMASK
CELLTYPE
CELLALIGN
HDRROW
HDRROWALIGN
)
gridsorttable=: 3 : 0
if. 0=#SortIndex do.
  SortIndex=: i.Crws
end.
if. #CELLDRAW do.
  if. 1=#$CELLDRAW do.
    col=. Col pick CELLDRAW
  else.
    col=. Col {"1 CELLDRAW
  end.
else.
  if. 1=#Cshape do.
    col=. Col pick CELLDATA
  else.
    col=. Col {"1 CELLDATA
  end.
end.
ndx=. /: col
if. ndx -: i.#ndx do. ndx=. \: col end.
if. #CELLDRAW do.
  if. 1=#$CELLDRAW do.
    CELLDRAW=: (<ndx) { each CELLDRAW
  else.
    CELLDRAW=: ndx { CELLDRAW
  end.
end.

if. 1=#Cshape do.
  CELLDATA=: (<ndx) { each CELLDATA
else.
  CELLDATA=: ndx { CELLDATA
end.
SortIndex=: ndx { SortIndex

(<ndx) gridsortmat &> SORTNOUNS

if. #CELLMARK do.
  CELLMARK=: 2 {. (ndx i. 0 { CELLMARK) 0 } CELLMARK
end.

refresh''
)
gridsortmat=: 4 : 0
val=. ". y
if. 2 > #$val do. 0 return. end.
(y)=: x { Crws $ val
1
)
coclass 'jzgrid'
initcube=: 3 : 0
if. -. Cube do. return. end.
cubevalid''
cubedefs''
cubeextents''
)
cubeputindex=: 3 : 0
new=. y, 3 pick AXISORDER
new=. new #~ ~:{."1 new
AXISORDER=: (<new) 3} AXISORDER
)
cubegetindex=: 3 : 0
'dim slx'=. |: 3 pick AXISORDER
(dim i. y) { slx,0
)
cubespan=: 3 : 0
len=. */ y
r=. s=. i.0,len
t=. {:y
y=. }:y
while. #y do.
  p=. {:y
  y=. }:y
  r=. (t#t*i.len%t),r
  s=. t,s
  t=. p*t
end.
r;s
)
cubevalid=: 3 : 0
rnk=. #$CELLDATA
if. 2 > rnk do.
  info 'Data is not a cube'
  0 return.
end.
AXISORDER=: 1 #each AXISORDER
select. #AXISORDER
case. 4 do.
  slx=. 3 pick AXISORDER
  if. 1 = #$slx do.
    dim=. 2 pick AXISORDER
    if. (#slx) ~: #dim do.
      info 'Slice selections and indices do not match'
      0 return.
    end.
    AXISORDER=: (<dim,.slx) 3} AXISORDER
  else.
    'dim slx'=. |: 3 pick AXISORDER
  end.
  if. 0 e. dim e. i.rnk do.
    info 'Slice axes do not match data'
    0 return.
  end.
  if. 0 e. slx e. &> }:@i: each dim{$CELLDATA do.
    info 'Slice indices do not match data'
    0 return.
  end.
case. 3 do.
  AXISORDER=: AXISORDER,<i.0 2
case. 2 do.
  AXISORDER=: AXISORDER,($0);i.0 2
case. do.
  info 'AXISORDER has invalid shape: ',":$AXISORDER
  0 return.
end.
1
)
flipcube=: 3 : 0
AXISORDER=: (1 0{AXISORDER),2}.AXISORDER
refresh''
)
initaxes=: 3 : 0
if. Cube do.
  ACrect=: Acxrect +"1 (Sx+Sw),0 0 0
  ARrect=: Arxrect +"1 [ 0,(Sy+Sh),0 0
  ASrect=: Asxrect
  AXrect=: ARrect,ACrect,ASrect
  ATrect=: Atxrect
else.
  AXrect=: ATrect=: ''
end.
)
cubegetmatrix=: 3 : 0
'rws cls sel slx'=. AXISORDER
shp=. $CELLDATA
dat=. (sel,rws,cls) |: CELLDATA
dat=. ((sel{shp),(*/rws{shp),*/cls{shp) reshape dat
CellData=: (<cubegetindex sel) { dat
)
cubesetmatrix=: 3 : 0
'rws cls sel slx'=. AXISORDER
shp=. $CELLDATA
dat=. ((rws{shp),cls{shp) reshape CellData
dat=. (/: rws,cls) |: dat
if. #sel do.
  ndx=. <(<&>cubegetindex sel) sel } (#shp) $ <a:
  dat=. dat ndx } CELLDATA
end.
CELLDATA=: dat
)
cubedefs=: 3 : 0
GRIDBORDER=: 1
GRIDFLIP=: 0
GRIDROWMODE=: 0
rws=. (0 pick AXISORDER) { AXISLABELS
HDRROW=: >,{ rws
ARspan=: cubespan # &> rws
cls=. (1 pick AXISORDER) { AXISLABELS
HDRCOL=: |:>,{ cls
ACspan=: cubespan # &> cls
)
cubeextents=: 3 : 0
'rws cls sel slx'=. AXISORDER
glfont HdrFont
sx=. Mw + Mx2
rw=. sx + >./qextentwv cls { AXISNAMES
rwm=. rw + +:CMx
sy=. My2
rh=. sy + HdrHit
rhm=. rh + +:CMy
rhm0=. rhm * 0 < #sel
Roff=: GridWindow + 0,rhm0,rwm,rhm+rhm0
Axhit=: rhm
Axwid=: qextentwv AXISNAMES
Axwids=: >./ &> qextentwv each AXISLABELS
wid=. sx + rws { Axwid
Arxrect=: (+/\CMx,}:wid),.CMy,.>:wid,.rh
cy=. +/\ }: (Axhit * 0<#sel),(#cls)$rh
Acxrect=: CMx,.cy,"0 1 >:rw,rh
if. #sel do.
  wid0=. sx + sel { Axwid
  wid1=. Mx2 + sel { Axwids
  wid=. wid0 + wid1
  Asxrect=: (+/\CMx+0,}:wid),.CMy,.>:wid,.rh
  Atxrect=: (wid0 + +/\CMx+0,}:wid),.CMy,.>:wid1,.rh
else.
  Asxrect=: Atxrect=: i.0 4
end.
)
coclass 'jzgrid'
LCbgn=: 0
LCend=: 0

LCWalks=: ,<''
LCWalkx=: 0
LCWalkn=: 0
LCndx=: ''
SLCndx=: ''

LRbgn=: 0
LRend=: 0
LRWalks=: <''
LRWalkx=: 0
LRWalkn=: 0
LRndx=: ''
SLRndx=: ''
LRrect=: LCrect=: i.0 4
inithier=: 3 : 0
if. -. Hier do. return. end.
CELLEDIT=: 0
LvlCol=: 0 < #LVLCOL
LvlRow=: 0 < #LVLROW
Sparse=: issparse CELLDATA
hiervalid''
hierdefs''
hierinit''
hiersort''
hierextents''
hierdata''
)
hierinit=: 3 : 0
if. LvlCol do. lcinit'' end.
if. LvlRow do. lrinit'' end.
)
lcinit=: 3 : 0
LCnms=: LVLCOLTOP }. LVLCOL
LCids=: LVLCOLTOP }. LVLCOLID
LCmsk=: LVLCOLTOP }. LVLCOLMASK
LCndx=: i. each #&> LCnms
if. LVLCOLLEN do.
  LCend=: (<: #LVLCOL) <. LCbgn + LVLCOLLEN-1
  LVLCOLLEN=: 0
end.
)
lcreset=: 3 : 0
LCbgn=: LCend=: 0
LCWalks=: ,<''
LCWalkx=: 0
LCWalkn=: 0
lcinit''
)
lrinit=: 3 : 0
LRnms=: LVLROWTOP }. LVLROW
LRids=: LVLROWTOP }. LVLROWID
LRmsk=: LVLROWTOP }. LVLROWMASK
LRndx=: i. each #&> LRnms
if. LVLROWLEN do.
  LRend=: (<:#LVLROW) <. LRbgn + LVLROWLEN-1
  LVLROWLEN=: 0
end.
)
lrreset=: 3 : 0
LRbgn=: LRend=: 0
LRWalks=: ,<''
LRWalkx=: 0
LRWalkn=: 0
lrinit''
)
getlvlcls=: 3 : 0
if. #LVLCOL do.
  I. LVLROWSORTCOL = <: +/\ LCend { LCmsk
else.
  ,LVLROWSORTCOL
end.
)
getlvlrws=: 3 : 0
if. #LVLROW do.
  I. LVLCOLSORTROW = <: +/\ LRend { LRmsk
else.
  ,LVLCOLSORTROW
end.
)
resetsortcol=: 3 : 0
LVLCOLSORTROW=: ''
LVLCOLSORTDIR=: 0
)
resetsortrow=: 3 : 0
LVLROWSORTCOL=: ''
LVLROWSORTDIR=: 0
)
selmaskndx=: 3 : 0
'ndx row sel msk'=. y
if. sel-:1 do. ndx return. end.
ind=. sel i. 1
inx=. row + i.#ndx
off=. <: ind {"1 +/\"1 inx { msk
ndx + off
)
statehier=: 3 : 0
s=. (> , ': '"_ , 5!:5)"0
n=. ''
if. LvlCol do.
  n=. n,' LCbgn LCend LCWalks LCWalkx LCWalkn'
  n=. n,' LCnms LCids LCmsk LCndx SLCndx'
end.
if. LvlRow do.
  n=. n,' LRbgn LRend LRWalks LRWalkx LRWalkn'
  n=. n,' LRnms LRids LRmsk LRndx SLRndx'
end.
s ;: n
)
hierdata=: 3 : 0
CellDataX=: CELLDATA
if. LvlCol do. hiercol'' end.
if. LvlRow do. hierrow'' end.
CELLRANGE=: <: |. $CellDataX
EMPTY
)
hiercol=: 3 : 0

dat=. (_1 pick LCndx) {"1 CellDataX
msk=. SLCmsk
nms=. SLCnms
sel=. 1
if. LCWalkn do.
  scn=. <: +/\"1 msk
  sel=. (LCWalkn{LCWalkx) = (<:LCWalkn){scn
  dat=. sel #"1 dat
  msk=. sel #"1 msk
  msk=. 1 (0)}"1 msk
  ndx=. <@~."1 sel #"1 scn
  nms=. ndx {each nms
end.
if. LCend < <:#nms do.
  dat=. (LCend { msk) +/;.1 &. |: dat
end.
nms=. LCbgn }. (LCend+1) {. nms
msk=. LCbgn }. (LCend+1) {. msk
msk=. ({:msk) #"1 msk
SLCMsel=: sel
SLCMmsk=: msk
SLCMnms=: nms
HdrColX=: (<@lfp"1 msk) #&> nms
HDRCOLMERGE=: -. (-#nms) {. 1
if. COLTOTAL do.
  dat=. dat,.+/"1 dat
  HdrColX=: HdrColX,.(#HdrColX){.HDRCOLTOTAL;''
end.
CellDataX=: dat
EMPTY
)
hierrow=: 3 : 0

dat=. (_1 pick LRndx) { CellDataX
msk=. SLRmsk
nms=. SLRnms
sel=. 1
if. LRWalkn do.
  scn=. <: +/\"1 msk
  sel=. (LRWalkn{LRWalkx) = (<:LRWalkn){scn
  dat=. sel # dat
  msk=. sel #"1 msk
  msk=. 1 (0)}"1 msk
  ndx=. <@~."1 sel #"1 scn
  nms=. ndx {each nms
end.
if. LRend < <:#nms do.
  dat=. (LRend { msk) +/;.1 dat
end.
nms=. LRbgn }. (LRend+1) {. nms
msk=. LRbgn }. (LRend+1) {. msk
msk=. ({:msk) #"1 msk
SLRMsel=: sel
SLRMmsk=: msk
SLRMnms=: nms
SLRndx=: (LRend - LRbgn) pick LRndx
HdrRowX=: |: (<@lfp"1 msk) #&> nms
HDRROWMERGE=: -. (-#nms) {. 1
if. ROWTOTAL do.
  dat=. dat,+/dat
  HdrRowX=: HdrRowX,({:$HdrRowX){.HDRROWTOTAL;''
end.
CellDataX=: dat
EMPTY
)
hierarrows=: 3 : 0
hit=. HdrHit + My2
ArrowColor=: 144 144 144,:80 80 80
ArrowRad=: 7
ArrowHbox=: 11,hit
ArrowVbox=: hit,11
ArrowSep=: 3
clr=. GridBackColor,"1 ArrowColor
clr=. clr,(2{ButtonColor),{:ArrowColor
'LeftArrow RightArrow'=: makearrowsLR (ArrowHbox,ArrowRad);clr
'UpArrow DownArrow'=: makearrowsUD (ArrowVbox,ArrowRad);clr
SortArrowSize=: 4
SortArrowLR=: SortArrowSize * 0 0 1 _1 1 1,:0 _1 1 0 0 1
SortArrowUD=: SortArrowSize * 0 0 _1 1 1 1,:_1 0 1 0 0 1
SortArrowColor=: 92 92 92
)
hierdefs=: 3 : 0
hierarrows''
runclick=: clickhier
GRIDBORDER=: 1
GRIDFLIP=: 0
GRIDROWMODE=: 0
if. Sparse do.
  GridVirtualMode=: 1
end.
EMPTY
)
clickhier=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. Ctrl < LvlCol *. Row < 0 do.
  lcwalk''
elseif. Ctrl < LvlRow *. Col < 0 do.
  lrwalk''
elseif. Ctrl *. _1 e. Row,Col do.
  mbhiersort ''
elseif. do.
  click y
end.
)
lcmbldown=: 3 : 0
if. y inrect LCLrect do.
  bcinitextern LVLCOLID;LVLCOLTOP;({.LCWrect);'lcsettop'
elseif. y inrect LCWrect do.
  lcwalkpos y inrectx LCWrect
elseif. y inrect LCArect do.
  lclevel y inrectx LCArect
end.
)
lrmbldown=: 3 : 0
if. y inrect LRLrect do.
  bcinitextern LVLROWID;LVLROWTOP;({.LRWrect);'lrsettop'
elseif. y inrect LRWrect do.
  lrwalkpos y inrectx LRWrect
elseif. y inrect LRArect do.
  lrlevel y inrectx LRArect
end.
)
mbhiersort=: 3 : 0
ndx=. (Row,Col) i. _1
if. *./ 0 > Row,Col do.
  hiersortreset''
  refresh'' return.
end.
if. ndx do.
  if. Row -: LVLCOLSORTROW do.
    LVLCOLSORTDIR=: -. LVLCOLSORTDIR
  else.
    LVLCOLSORTROW=: Row
  end.
else.
  if. Col -: LVLROWSORTCOL do.
    LVLROWSORTDIR=: -. LVLROWSORTDIR
  else.
    LVLROWSORTCOL=: Col
  end.
end.
hiersort''
refresh''
)
hierextents=: 3 : 0
if. -. LvlCol +. LvlRow do. return. end.
LCMx=: 6
LCMy=: 4
glfont HdrFont
hit=. qextenth 'X'
Lh=: hit + My2 + +:LCMy
Roff=: GridWindow + 0,Lh,0,Lh
)
hiergetdatax=: 3 : 0
CellData=: CellDataX
if. Sparse do.
  'Rws Cls'=: getblockindex''
  CellData=: Rws { Cls {"1 CellDataX
  HDRCOL=: Cls {"1 HdrColX
  HDRROW=: Rws { HdrRowX
else.
  CellData=: CellDataX
  if. LvlCol do.
    HDRCOL=: HdrColX
  end.
  if. LvlRow do.
    HDRROW=: HdrRowX
  end.
end.
1
)
hiergetdata=: hiergetdatax
lclevel=: 3 : 0
old=. LCend
if. y do.
  LCend=: (<:#LCnms) <. >:LCend
else.
  LCend=: LCbgn >. <: LCend
end.
if. old=LCend do. return. end.
resetsortrow''
refresh''
)
lctoplevel=: 3 : 0
if. y do.
  lvl=. (<:#LVLCOL) <. >:LVLCOLTOP
else.
  lvl=. 0 >. <:LVLCOLTOP
end.
lcsettop lvl
)
lcsettop=: 3 : 0
if. y ~: LVLCOLTOP do.
  resetsortrow''
end.
LVLCOLTOP=: y
lcreset''
refresh''
)
lrlevel=: 3 : 0
old=. LRend
if. y do.
  LRend=: (<:#LRnms) <. >:LRend
else.
  LRend=: LRbgn >. <: LRend
end.
if. old=LRend do. return. end.
resetsortcol''
refresh''
)
lrtoplevel=: 3 : 0
if. y do.
  lvl=. (<:#LVLROW) <. >:LVLROWTOP
else.
  lvl=. 0 >. <:LVLROWTOP
end.
lrsettop lvl
)
lrsettop=: 3 : 0
if. y ~: LVLROWTOP do.
  resetsortcol''
end.
LVLROWTOP=: y
lrreset''
refresh''
)
hiersort=: 3 : 0
LCsortrow=: LVLCOLSORTROW
LRsortcol=: LVLROWSORTCOL
if. LvlCol do.
  hiersortcol''
end.
if. LvlRow do.
  hiersortrow''
end.
)
hiersortcol=: 3 : 0
if. 0=#LCsortrow do.
  LCWalkx=: (/: each (#LCWalkx){.LCndx) i.&> LCWalkx
  LCndx=: i. each #&> LCnms
  SLCmsk=: LCmsk
  SLCnms=: LCnms
  SLCndx=: (LCend - LCbgn) pick LCndx
  LVLCOLSORTDIR=: 0
  return.
end.
dir=. LVLCOLSORTDIR
rws=. getlvlrws LCsortrow
val=. +/rws{CELLDATA
masks=. LCmsk
rws=. #masks
len=. {:$masks
ind=. len$0
sgn=. _1 ^ dir
sorts=. ''
for_i. i.rws do.
  msk=. i{masks
  if. 0 e. msk do.
    cnt=. #;.1 msk
    ndx=. dir sortfns (sgn*msk#ind),.msk +/;.1 val
    ind=. cnt # /:ndx
    inx=. /:ind
    masks=. (inx{i{masks) i} masks
  else.
    ndx=. dir sortfns (sgn*ind),.val
    ind=. /:ndx
    inx=. ndx
  end.
  sorts=. sorts,<ndx
end.
walkx=. }. LCWalkx
wln=. #walkx
walkx=. (/: each wln{.LCndx) i.&> walkx
walkx=. (wln{.sorts) i.&> walkx
LCWalkx=: 0,walkx
LCndx=: sorts
SLCndx=: (LCend - LCbgn) pick LCndx
SLCmsk=: masks
SLCnms=: sorts {each LCnms
LRsortcol=: SLCndx i. LRsortcol
EMPTY
)

hiersortreset=: 3 : 0
LVLCOLSORTROW=: LVLROWSORTCOL=: ''
LVLCOLSORTDIR=: LVLROWSORTDIR=: 0
)
hiersortrow=: 3 : 0
if. 0=#LRsortcol do.
  LRWalkx=: (/: each (#LRWalkx){.LRndx) i.&> LRWalkx
  LRndx=: i. each #&> LRnms
  SLRmsk=: LRmsk
  SLRnms=: LRnms
  SLRndx=: (LRend - LRbgn) pick LRndx
  LVLROWSORTDIR=: 0
  return.
end.
dir=. LVLROWSORTDIR
cls=. getlvlcls LVLROWSORTCOL
val=. +/"1 cls{"1 CELLDATA
masks=. LRmsk
rws=. #masks
len=. {:$masks
ind=. len$0
sgn=. _1 ^ dir
sorts=. ''
for_i. i.rws do.
  msk=. i{masks
  if. 0 e. msk do.
    cnt=. #;.1 msk
    ndx=. dir sortfns (sgn*msk#ind),.msk +/;.1 val
    ind=. cnt # /:ndx
    inx=. /:ind
    masks=. (inx{i{masks) i} masks
  else.
    ndx=. dir sortfns (sgn*ind),.val
    ind=. /:ndx
    inx=. ndx
  end.
  sorts=. sorts,<ndx
end.
walkx=. }. LRWalkx
wln=. #walkx
walkx=. (/: each wln{.LRndx) i.&> walkx
walkx=. (wln{.sorts) i.&> walkx
LRWalkx=: 0,walkx
LRndx=: sorts
SLRndx=: (LRend - LRbgn) pick LRndx
SLRmsk=: masks
SLRnms=: sorts {each LRnms
LCsortrow=: SLRndx i. LCsortrow
EMPTY
)

hiervalid=: 3 : 0

'r c'=. $CELLDATA

if. LvlCol do.
  if. (#LVLCOLMASK)=<:#LVLCOL do.
    LVLCOLMASK=: LVLCOLMASK,1
  end.
  msg=. hiervalid1 c;LVLCOL;LVLCOLID;LVLCOLMASK;LVLCOLTOP
  if. #msg do.
    info 'Column levels: ',msg
    0 return.
  end.
end.

if. LvlRow do.
  if. (#LVLROWMASK)=<:#LVLROW do.
    LVLROWMASK=: LVLROWMASK,1
  end.
  msg=. hiervalid1 r;LVLROW;LVLROWID;LVLROWMASK;LVLROWTOP
  if. #msg do.
    info 'Row levels: ',msg
    0 return.
  end.
end.

1
)
hiervalid1=: 3 : 0
'len col id msk top'=. y
'r c'=. 2 {. $msk
lr=. #col
lcs=. # &> col
if. len ~: c do.
  'levels do not match data' return.
end.
if. lr ~: #id do.
  'identifiers do not match names' return.
end.
if. lr ~: r do.
  'names do not match mask' return.
end.
if. -. lcs -: +/"1 msk do.
  'names do not match mask' return.
end.
if. -. top e. i.lr do.
  'top index is out of range' return.
end.
''
)
lcwalk=: 3 : 0
row=. Row - (Row = _1) *. LCend = <:#LCnms
col=. Col
if. -. row e. <:-i.>: LCend-LCbgn do. 0 return. end.
if. -. col e. i.({:$CellData)-COLTOTAL do. 0 return. end.
oldwalks=. LCWalks
oldwalkx=. LCWalkx
msk=. (row+1) }. SLCMmsk
nms=. (row+1) }. SLCMnms
ndx=. col {"1 <:+/\"1 msk
nms=. ndx {&> nms
ndx=. selmaskndx ndx;LCWalkn;SLCMsel;LVLCOLMASK
LCWalks=: ((LCbgn+1){.LCWalks),nms
LCWalkx=: ((LCbgn+1){.LCWalkx),ndx
LCWalkn=: LCbgn=: LCend=: LCbgn + #nms
if. LCWalkx -: (#LCWalkx) {.!._1 oldwalkx do.
  LCWalkx=: oldwalkx
  LCWalks=: oldwalks
end.
resetsortrow''
refresh''
1
)
lcwalkpos=: 3 : 0
LCWalkn=: LCbgn=: LCend=: y
refresh''
)
lrwalk=: 3 : 0
row=. Col - (Col = _1) *. LRend = <:#LRnms
col=. Row
if. -. row e. <:-i.>: LRend-LRbgn do. 0 return. end.
if. -. col e. i.(#CellData)-ROWTOTAL do. 0 return. end.
oldwalks=. LRWalks
oldwalkx=. LRWalkx
msk=. (row+1) }. SLRMmsk
nms=. (row+1) }. SLRMnms
ndx=. col {"1 <:+/\"1 msk
nms=. ndx {&> nms
ndx=. selmaskndx ndx;LRWalkn;SLRMsel;LVLROWMASK
LRWalks=: ((LRbgn+1){.LRWalks),nms
LRWalkx=: ((LRbgn+1){.LRWalkx),ndx
LRWalkn=: LRbgn=: LRend=: LRbgn + #nms
if. LRWalkx -: (#LRWalkx) {.!._1 oldwalkx do.
  LRWalkx=: oldwalkx
  LRWalks=: oldwalks
end.
resetsortcol''
refresh''
1
)
lrwalkpos=: 3 : 0
LRWalkn=: LRbgn=: LRend=: y
refresh''
)
