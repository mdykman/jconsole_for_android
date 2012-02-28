3 : 0''
if. IFJ6 do.
  require '~system/extras/migrate/gl2.ijs'
else.
  require 'gui/gtkwd'
end.
''
)
require '~addons/math/lapack/lapack.ijs'
require '~addons/math/lapack/dgeev.ijs'

coclass 'eigenpic'
coinsert 'jgl2'

dgeev_z_=: dgeev_jlapack_

BLUE=: 0 0 255
RED=: 255 0 0
WHITE=: 255 255 255
BLACK=: 0 0 0

FORECOLOR=: BLACK
BACKCOLOR=: WHITE
AXISCOLOR=: BLUE
EIGENCOLOR=: RED

XMARGIN=: 0.07
YMARGIN=: 0.07
TICMAJOR=: 0.01
TICMINOR=: 0.007

MATCHAR=: MATDEFAULT=: '4 3 1 5 % 2'
MATRIX=: 2 2$ ". MATCHAR

IFSPOKES=: 1
SPOKES=: 60

SYSNAME=: 'Eigenpicture'

3 : 0''
if. IFWINCE do.
  FONTSIZE=: 40
  FONTNAME=: 'Tahoma '
else.
  FONTSIZE=: 24
  FONTNAME=: 'Arial '
end.
)


deb=: #~ (+. 1: |. (> </\))@(' '&~:)

dist=: +/ &. (*:"_)

info=: wdinfo @ (SYSNAME&;)

int01=: i.@>: % ]

iscomplex=: -.@(-: +)
isnumeric=: 3!:0 e. 1 4 8 16 64 128"_

log10=: 10&^.
mp=: +/ . *

fp=: x:^:_1

pow10=: 10&^

rnd=: [ * [: <. 0.5"_ + %~
rnd0=: <.@:+&0.5
rnddn=: [ * [: <. %~
rndup=: [ * [: >. %~
rndint=: <.@(0.5&+)

setcolor=: glbrush @ glrgb

tolist=: }.@;@:((10{a.)&,@,@":&.>)
tomatrix=: (_2 {. 1 1 , $) $ ,
tominus=: '-'&(I. @(e.&'_')@]})
unitvec=: % dist

wdpclose=: [: wd ::empty 'psel '&,@(,&';pclose')

addLF=: tominus @ }. @ , @ (LF&,.) @ ":
cleanit=: 3 : 0
1e_7 cleanit y
:
if. 16 ~: 3!:0 y do.
  y * x <: |y
else.
  j./"1 y * x <: | y=. +.y
end.
)
getfontsize=: 13 : '{.1{._1 -.~ _1 ". y'
setfontsize=: 4 : 0
b=. ~: /\ y='"'
nam=. b#y
txt=. ;:(-.b)#y	
ndx=. 1 i.~ ([: *./ e.&'0123456789.') &> txt
nam, ; ,&' ' &.> (<fmt x) ndx } txt
)
calc=: 3 : 0

RIM=: spokes SPOKES

'LV EV RV'=: cleanit each dgeev MATRIX

IFCOMPLEX=: iscomplex RV

if. IFCOMPLEX=0 do.
  RV=: {.@+. RV
  rv=. (,-) |:RV
  RIM=: rv, RIM
end.

END=: RIM + MATRIX mp"2 1 RIM
WID=: >. >./ | , END
)
spokes=: 3 : 0
|: 2 1 o./ o. +: }: int01 y
)
EPD=: 0 : 0
pc epd closeok;
xywh 0 0 200 200;cc g isigraph ws_border rightmove bottommove;
pas 0 0;
rem form end;
)
epd_close=: 3 : 0
wd'pclose'
)
epd_g_mmove=: 3 : 0
'x y w h'=. 4 {. 0 ". sysdata
y=. h - y
rim=. unitvec (x,y) - -: w,h
end=. rim + MATRIX mp rim
j=. (MX,MY) + rim * X1,Y1
pts=. flipypos 2 4$(MX,MY), j, j, (MX,MY) + end * X1,Y1
glsel 'g'
setcolor BACKCOLOR
glpen 2 0
drawpin LASTPTS
setcolor EIGENCOLOR
glpen 2 0
drawpin pts
drawpic''
glpaint ''
LASTPTS=: pts
)
epd_g_paint=: epdraw
epd_cancel_button=: epd_close
epdraw=: 3 : 0

if. opened=. 0=wdisparent 'epd' do.
  wd EPD
  wd 'pn *',SYSNAME
  wdfit''
end.
wd'pshow'

wd 'psel epd'
glsel 'g'
'x y w h'=. 0 ". wd 'qchildxywhx g'
CX=: CY=: w <. h

OFF=: -: (w-CX), h-CY

glrgb BACKCOLOR
glbrush''
glrect 0 0,w,h

glrgb FORECOLOR
glbrush''
glpen 1 0
gltextcolor ''
drawframe WID * _1 _1 2 2
genpic WID * _1 _1 2 2

if. opened do. wd'pshow' end.

drawpic''
)

ABOUT=: 0 : 0
An eigenpicture for a 2x2 matrix M is constructed as follows:

A set of spokes is drawn from the origin to a unit circle centered
on the origin.

For each spoke, draw an additional line equal to the the matrix
product of M with the position on the unit circle. If a spoke
happens to be an eigenvector, the additional line will be colinear with
the original.

Note that if you negate the matrix, the directions of these
additional lines are reversed.

In the drawings, the eigenvectors are shown in blue, and the value
corresponding to the current mouse direction is shown in red.

In the case of a double eigenvector, the two blue lines are superimposed.

In the case of complex eigenvectors, there is no spoke with a colinear
matrix product, and hence no blue line.
)
drawlines=: 3 : 0
y=. tomatrix y
gllines OFF movepos~ flipypos (y scalepos X1,Y1) movepos MX,MY
)
drawpin=: 3 : 0
y=. tomatrix y
f=. (,&2 2) @: <: @: (_2&{.)
gllines OFF movepos~ y
glellipse OFF moverect~ f"1 y
)

drawpic=: 3 : 0
setcolor FORECOLOR
glpen 1 0
drawpin FOREPIN
if. #AXISPIN do.
  setcolor AXISCOLOR
  glpen 2 0
  drawpin AXISPIN
end.
)
genpic=: 3 : 0

'x y w h'=. y

X1=: (CX * 1 - +:XMARGIN) % w
MX=: - CX * x % w

Y1=: (CY * 1 - +:YMARGIN) % h
MY=: - CY * y % h

rim=. (RIM *"1 X1,Y1) +"1 MX,MY
rimpts=. flipypos (MX,MY) ,"1 rim

pts=. (END *"1 X1,Y1) +"1 MX,MY
endpts=. flipypos rim ,"1 pts

if. IFCOMPLEX do.
  FOREPIN=: rimpts,endpts
  AXISPIN=: i.0 0
else.
  FOREPIN=: (4}.rimpts), (4}.endpts)
  AXISPIN=: (4{.rimpts), (4{.endpts)
end.

)
flipypos=: 3 : 0
ry=. $y
(ry $ 0, CY) + y * ry $ 1 _1
)
movepos=: [ + $@[ $ ]
moverect=: 13 : 'x + ($x)$y,0 0'
scalepos=: [ * $@[ $ ]
scalerect=: 4 : 0
new=. y * old=. 2 3{x
((2{.x)+-:old-new),new
)
drawframe=: 3 : 0

'x y w h'=. y

fsize=. FONTSIZE * CY % 1000
font=. FONTNAME,": fsize
'bx tx'=. rndint CX * (,-.) XMARGIN-TICMAJOR
'by ty'=. rndint CY * (,-.) YMARGIN-TICMAJOR
gllines OFF movepos~ bx,by,bx,ty,tx,ty,tx,by,bx,by
'minor pos'=. gettics x,x+w

len=. >: (1+minor) * <: #pos
mark=. len $(1,minor)#rndint CX * TICMAJOR, TICMINOR

x=. bx + (tx-bx) * int01 len - 1
gllines OFF movepos~x ,. by ,. x ,. by+mark
gllines OFF movepos~x ,. ty ,. x ,. ty-mark
x=. bx + (tx-bx) * int01 (#pos) - 1
labs=. tominus@": each pos
glfont font
off=. <. -: {."1 glqextent &> labs
p=. OFF movepos~ (x-off) ,. ty + CY * TICMAJOR
labs (gltext@>@[ gltextxy)"0 1 p
'minor pos'=. gettics y,y+h

len=. >: (1+minor) * <: #pos
mark=. len $(1,minor)#rndint CY * TICMAJOR, TICMINOR

y=. by + (ty-by) * int01 len - 1
gllines OFF movepos~bx ,. y ,. (bx+mark) ,. y
gllines OFF movepos~tx ,. y ,. (tx-mark) ,. y
y=. (by - fsize%2) + (ty-by) * int01 (#pos) - 1
labs=. tominus@": each |. pos
glfont font
off=. {."1 glqextent &> labs
p=. OFF movepos~ (bx-off + CX*TICMAJOR) ,. y

labs (gltext@>@[ gltextxy)"0 1 p
)
gettics=: 3 : 0

def=. 9

'min max'=. y

wid=. max-min

t=. 0.5 1 2 5 10 20 * pow10 <: <. log10 wid
ndx=. +/ def < wid%t

step=. ndx { t
min=. step rnddn min
pos=. min+step*i.>:>.(max-min)%step

max=. 3 + '5' e. ": step
minor=. (1,max) {~ max <: <. 40 % #pos

minor;pos
)
EP=: 0 : 0
pc ep;
menupop "Examples";
menu default "&Default" "" "" "";
menusep;
menu onezero "&Zero Eigenvalue" "" "" "";
menusep;
menu double "&Double Eigenvalue" "" "" "";
menusep;
menu complex "&Complex Eigenvalues (1)" "" "" "";
menusep;
menu complex2 "C&omplex Eigenvalues (2)" "" "" "";
menupopz;
menupop "Help";
menu about "&About" "" "" "";
menupopz;
xywh 9 21 146 14;cc mat edit ws_border es_autohscroll rightmove;
xywh 10 38 115 35;cc matrix static rightmove;
xywh 133 55 47 13;cc negate button leftmove rightmove;cn "Negate";
xywh 6 10 180 70;cc g0 groupbox rightmove;cn "Matrix";
xywh 9 104 110 30;cc ev1 static rightscale;
xywh 9 142 110 30;cc ev2 static rightscale;
xywh 6 87 120 90;cc g1 groupbox rightscale;cn "Eigenvalues";
xywh 138 104 110 30;cc rv1 static leftscale rightmove;
xywh 138 142 110 30;cc rv2 static leftscale rightmove;
xywh 133 87 120 90;cc g2 groupbox leftscale rightmove;cn "Eigenvectors";
xywh 200 16 47 13;cc run button leftmove rightmove;cn "Run";
pas 4 4;
rem form end;
)
iflapackavail=: 3 : 0
if. UNAME-:'Linux' do. 1 return. end.
try.
  fexist deb dll_jlapack_ -. '"'
catch.
  0
end.
)
ep_run=: 3 : 0

if. -. iflapackavail'' do.
  info 'Demo requires LAPACK'
  return.
end.

wdpclose 'ep'
wdpclose 'epd'

epinit''
wd EP
wd 'pn *',SYSNAME
wd 'set mat *',":,MATCHAR
wd 'set matrix *', addLF MATRIX
wd 'setfont mat ',FIXFONT
wd 'setfont matrix ',FIXFONT
wd 'set ev1;set ev2;set rv1;set rv2'
wd 'setfont ev1 ',FIXFONT
wd 'setfont ev2 ',FIXFONT
wd 'setfont rv1 ',FIXFONT
wd 'setfont rv2 ',FIXFONT
wd 'pshow'
)
ep_close=: 3 : 0
try. wd 'psel epd;pclose' catch. end.
wd 'psel ep;pclose'
)
ep_about_button=: 3 : 0
'About' wdview '';(topara ABOUT);1
)
ep_complex_button=: 3 : 0
MATRIX=: 2 2 $ ". MATCHAR=: '-1 2 _1 1'
epdoit''
)
ep_complex2_button=: 3 : 0
MATRIX=: 2 2 $ ". MATCHAR=: '-3 2 _1 1'
epdoit''
)
ep_default_button=: 3 : 0
MATRIX=: 2 2$ ". MATCHAR=: MATDEFAULT
epdoit''
)
ep_double_button=: 3 : 0
MATRIX=: 2 2 $ ". MATCHAR=: '(4-%:3), 1 _3, 4+%:3'
epdoit''
)
ep_negate_button=: 3 : 0
MATCHAR=: mat
if. '-' = {. MATCHAR do.
  MATCHAR=: }.MATCHAR
else.
  MATCHAR=: '-',MATCHAR
end.
MATRIX=: 2 2$ ". MATCHAR
epdoit''
)
ep_onezero_button=: 3 : 0
MATRIX=: 2 2$ ". MATCHAR=: '1 _1 _1 1'
epdoit''
)
ep_run_button=: 3 : 0
x=. ,@". :: 0: mat
if. (4~:$x) +. 0=isnumeric x do.
  info 'Invalid matrix definition'
else.
  if. iscomplex x do.
    info 'Matrix should be real'
  else.
    MATCHAR=: deb mat
    MATRIX=: 2 2$ x
    epdoit''
  end.
end.
)
ep_mat_button=: ep_run_button
ep_cancel=: ep_cancel_button=: ep_close
epdoit=: 3 : 0
calc''
wd 'set mat *',":,MATCHAR
wd 'set matrix *', addLF MATRIX
'x1 y1 x2 y2'=. tominus@": each , RV
'e1 e2'=. tominus@": each , EV
wd 'set rv1 *',x1,LF,x2
wd 'set ev1 *', e1
wd 'set rv2 *', y1,LF,y2
wd 'set ev2 *', e2
epdraw''
glpaint''
)
epinit=: 3 : 0
LASTPTS=: i.0 0
SPOKES=: 2 * >. -: SPOKES
)
ep_run''
