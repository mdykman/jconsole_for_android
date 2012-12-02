coclass 'jzplot'
require 'graphics/afm'
require 'graphics/color/colortab'

3 : 0''
if. -.IFJ6 do.
  if. 0~:4!:0<'IFJAVA' do. IFJAVA=: 0 end.
  if. 0 ~: 4!:0 <'JHSOUTPUT' do. JHSOUTPUT=: 'canvas' end.
  if. 0 ~: 4!:0 <'CONSOLEOUTPUT' do. CONSOLEOUTPUT=: (UNAME-:'Android'){::'cairo';'android' end.
  if. 0 ~: 4!:0 <'GTKOUTPUT' do. GTKOUTPUT=: 'gtk' end.
  if. 0 ~: 4!:0 <'IFTESTPLOTJHS' do. IFTESTPLOTJHS_z_=: 0 end.
  if. IFTESTPLOTJHS +. IFJHS do.
    if. 0 < #1!:0 jpath '~addons/gui/gtk/gtk.ijs' do.
      require 'gui/gtk'
    end.
  elseif. IFGTK do.
    require 'graphics/bmp'
    require 'gui/gtk graphics/gl2'
    if. 0[ GTKOUTPUT -: 'isi' do.
      require 'gtkwd'
    end.
    coinsert 'jgl2'
  elseif. (UNAME -: 'Android') do.
    if. 0 < #1!:0 jpath '~addons/gui/android/android.ijs' do.
      require 'droidwd gui/android'
      coinsert 'jgl2 jni jaresu'
    else.
      if. CONSOLEOUTPUT-:'android' do. CONSOLEOUTPUT=: 'pdf' end.
    end.
  elseif. do.
    if. 0 < #1!:0 jpath '~addons/gui/gtk/gtk.ijs' do.
      require 'gui/gtk'
    end.
    if. (UNAME -: 'Linux') *: (0 -: 2!:5 'DISPLAY') do.
      if. 0 < #1!:0 jpath '~addons/graphics/gl2/gl2.ijs' do.
        require 'graphics/gl2'
        coinsert 'jgl2'
      end.
      if. 0 < #1!:0 jpath '~addons/graphics/bmp/bmp.ijs' do.
        require 'graphics/bmp'
      end.
    end.
  end.
  coinsert 'jafm'
else.
  require 'graphics/bmp'
  require 'graphics/color/hues'
  require 'dll strings unicode'
  require 'gui/gtk'
  coinsert 'jafm jgl2'
end.
''
)

jniImport ::0: (0 : 0)
android.content.Context
android.view.View
android.view.View$OnTouchListener
android.view.Window
)
NOAXES=: 'axes 0;boxed 0;frame 0;grids 0;labels 0;tics 0;'
NOFRAME=: 'axes 1;frame 0'

KEYWORDS=: 'noaxes';'noframe'
EMPTY=: i.0 0
alfndx=: 3 & u:
assign=: 4 : '".x,''=:y'''
average=: +/ % #
blockcount=: [: {. }:@$ , 1:
boxrows=: >@(,.&.>/)@:(;/&.>)
cile=: $@] $ ((* <.@:% #@]) /:@/:@,)
citemize=: ,:^:(2 > #@$)
cleanz=: * | >: 1e_10"_
cmatch=: (#@[) $ citemize@]
cross=: +/ .* (3 3 3$0 0 0 0 0 _1 0 1 0 0 0 1 0 0 0 _1 0 0 0 _1 0 1 0 0 0 0 0)&(+/ .*)
cutxyz=: <"2@(0 1&|:)
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
det=: -/ .*
dim0=: ]`({."1) @. (2=#&$)
dim1=: ]`{. @. (2=#&$)
dist=: +/&.(*:"_)
dlb=: }.~ =&' ' i. 0:
dquote=: '"'&,@(,&'"')
dquoted=: 2+./\0,2|+/\@(=&'"')
drange=: {:-{.
each=: &.>
extbmp=: , ((0 < #) *. [: -. '.'"_ e. ]) # '.bmp'"_
extemf=: , ((0 < #) *. [: -. '.'"_ e. ]) # '.emf'"_
extjpf=: , ((0 < #) *. [: -. '.'"_ e. ]) # '.jpf'"_
findprefixes=: +./"1 @: ([ = (#@>@[) {.each ])"0 1
first=: >@{.
firstin=: e. {.@# [
firstones=: > 0: , }:
firstword=: {.~ i.&' '
fit01=: ((- <./@,) % (>./ - <./)@,) : ((] - {.@[) % -~/@[)
fitin=: {.@[ + ({: - {.)@[ * ((- <./@,) % (>./ - <./)@,)@]
fix=: _1&".
has=: [: +./ (e.~ boxopen f.)
head=: {.~ i.&' '
hostcmd=: [: 2!:0 '(' , ,&' || true)&'
index=: [ ((#@[ = ]) { ] , _1:) i.
int01=: i.@>: % ]
intersect=: e. # [
inxb=: <:@(+/\) i. i.@(+/)
isboxed=: 0 < L.
ischar=: 3!:0 e. 2 131072"_
is1color=: 3 = */ @ $
iscomplexdata=: 3!:0 e. 16 16384"_
iscounter=: -: |@<.
isempty=: 0 e. $
isinteger=: -: <.
islinear=: *./@(= {.)@(}. - }:)
islocale=: {. @ (e. 18!:1 @ 1:)
lastone=: </\ &. |.
lastones=: > }. , 0:
log10=: 10&^.
lsfit=: {:@] %. {.@] ^/ i.@>:@[
matsize=: _2 {. 1 1 , $
mp=: +/ . *
nc=: 4!:0
packs=: (, ,&< ".) &>
pdefs=: 3 : '0 $ ({."1 y)=: {:"1 y'
pbuf=: 3 : 'buf=: buf,,y,"1 LF'
pforms=: 3 : 0
if. 0=# z=. <;._2;._2 @ wd 'qpx' do. z=. 0 6$<'' end.
z
)
pick=: >@{
pickf=: 2 : 'u @ > @ (n&{)'
pow10=: 10&^
scale01=: (% {:) @: (0: , +/\)
splits=: i.&' ' ({.;}.@}.) ]
nthword=: +/\@(> 0 , }:)@(~:&' ')@] i. >:@[
partition=: 1 , [: -. }: -:"_1 }.
rank=: #@$
rank01=: 2 > [: # $
rfd=: *&1r180p1
rnd=: [ * [: <. 0.5"_ + %~
rndint=: <.@:+&0.5
rnddn=: [ * [: <. %~
rndup=: [ * [: >. %~
signal=: 13!:8&12
tail=: }.~ >:@(i.&' ')
tolist=: }.@;@:((10{a.)&,@,@":&.>)
tominus=: '-' & (([: I. ] e. '_'"_)})
towords=: ;: ^: _1
u2a=: (1 u: 7 u: ]) :: ]
unitvec=: % dist
zero=: * | >: 1e_10"_

sin=: 1&o.
cos=: 2&o.
boxarg=: 3 : 0
ws=. 8 9 10 13 32 44{a.
del=. 34 127{a.
dat=. ' ',y
b=. (dat e. ws) > ~:/\ dat e. del
dat=. (<'') -.~ b <;._1 dat
dat -. each <del
)

boxascii=: ]
check_epsreader=: 3 : 0
check_reader y
)
check_pdfreader=: 3 : 0
check_reader y
)
check_reader=: 3 : 0
ndx=. 1 i.~ ' -' E. y
flexist ndx {. y
)
comma2blank=: 3 : 0
' ' (I. y=',') } y
)
chop=: 3 : 0
y chop~ (' ',LF) {~ LF e. ,y
:
if. 2>#$y
do.
  (<'') -.~ (y e.x) <;._2 y=. y,{.x
else.
  |: &.> y -. {: y=. (*./y e.x) <;._2 |: y=. y,"1 [ 2${.x
end.
)
cubicspline=: 3 : 0
diff=. }.-}:
'x y'=. y
h=. diff x
k=. diff y
w=. 3 * diff k % *: h
n=. +:(2}.x)-_2}.x
sm=. ,~_2+#x
m=. sm$}.,(sm+0 1){.(}:h),.n,.}.h
c=. 0,w %. m
a=. }:y
b=. (k%h) - h * ((+:c) + }.c,0) % 3
d=. (diff c,0) % 3 * h
(}:x);a,.b,.c,.d
)
interspline=: 4 : 0
'i m'=. x
n=. <: +/ i <:/ y
(n{m) p. y-n{i
)

cut=: 4 : 'a: -.~ (y e.x) <;._2 y=. y,{.x'
cutopen=: 3 : 0
y cutopen~ (' ',LF) {~ LF e. ,y
:
if. L. y do. y return. end.
if. 1 < #$y do. <"_1 y return. end.
(<'') -.~ (y e.x) <;._2 y=. y,{.x
)
dictget=: 4 : 0
(({."1 y) i. x) { ({:"1 y),<''
)
facenormal=: 4 : 0
norm=. x * unitvec (}:cross&(-/)}.) 3{.y
norm + (+/y) % #y
)
getangle=: arctan@% + o.@(] < 0:)
ifjwplot=: 3 : 0
('plot' -: PForm) *. 'jwplot' -: > coname''
)
ifparent=: 3 : 0
(<y) e. 1 {"1 pforms''
)
ifplotf=: 3 : 0
2 e. 3!:0 (S:0) _1 pick y
)
info=: 3 : 0
sminfo@('Plot'&;) :: smoutput y
)
interp01=: 3 : 0
y=. y * <: #x
b=. x {~ <.y
t=. x {~ >.y
k=. y - <.y
(t*k) + b*-.k
)
keyarg=: 3 : 0
dat=. ;: tolower y
msk=. dat e. KeyOpts
({. &> msk # dat), ;(-.msk) # dat
)
maxmask=: 4 : 0
rem=. y-x
if. 0 >: rem do. 1
elseif. rem <: x do.
  1 ,~ (<:y)$((rndint x%rem)$1),0
elseif. 1 do.
  1 ,~ (<:y)$1,(rndint rem%x)$0
end.
)
mfv=: 4 : 0
if. 2>#$y do.
  ];._2 y,x #~ x ~: _1{.x,y
else.
  y
end.
)
ncile=: 4 : 0
min=. <./,y
max=. >./,y
step=. }: min+(max-min)*(i.>:x)%x
<: +/ step <:/ y
)
plenfrom=: 4 : 0
x {.each (0,+/\}:x) }.each <y
)
pfmt=: 3 : 0
dat=. ": 0.0001 round y
txt=. ,dat
($dat) $ '-' (I. txt='_') } txt
)
pfmtjs=: 1&$: : (4 : 0)
dat=. 0.0001 round y
txt=. , dat=. commasep@(('('&,)@(,&')')^:x)@":"1 dat
($dat) $ '-' (I. txt='_') } txt
)

commasep=: 3 : 0
',' (I. y=' ') } y
)
qchop=: 3 : 0
q=. dquoted y
s=. ' '=y
qs=. q*.s
y=. DEL (inxb qs)}y
dltb@unquot@((DEL,' ')&charsub)@deb each chop y
)
query=: 4 : 0
x ((wdquery 'Plot'&;) :: (1: smoutput)) y
)
range=: 3 : 0
'x y n'=. 3{.y,1
s=. _1^y<x
x+s*n*i.>:<.n%~|y-x
)
rotxy=: 4 : 0
rot=. 2 2$ 1 1 _1 1 * 0 1 1 0 { 2 1 o. x
rot +/ . * "2 1 y
)
smooth=: (cubicspline@:(,:~ i.@#) interspline i.&.(4&*)@#)"1
steps=: {. + (1&{ - {.) * (i.@>: % ])@{:
unquot=: 3 : 0
'" ' charsub y
)
selectpid=: 3 : 0
if. 0~: (0&". ::]) PIdhwnd do.
  glsel PIdhwnd
elseif. #PId do.
  glsel PId
end.
)
gtkwidget_event=: androidwidget_event=: 4 : 0
evt=. >@{.y
syshandler=. PForm, '_handler'
sysevent=. PForm,'_',PId,'_', evt
sysdefault=. PForm, '_default'
if. 1=#y do.
  wdd=. ;: 'syshandler sysevent sysdefault'
elseif. 2=#y do.
  sysdata=. ": >1{y
  wdd=. ;: 'syshandler sysevent sysdefault sysdata'
elseif. 3=#y do.
  sysdata=. ": >1{y
  sysmodifiers=. ": >2{y
  wdd=. ;: 'syshandler sysevent sysdefault sysdata sysmodifiers'
end.
wdqdata=. (wdd ,. ".&.>wdd)
evthandler wdqdata
0
)
rectcenter=: 2&{. + -:@(2 3&{)
angle2=: [: r.^:_1 *@(j./)"1
g0=. }:"1
g1=. (1 2&{ - 0 0&{)"2
g2=. 0: < -/"1 @: ({. * |. @: {:)"2
facing=: g2 @: g1 @: g0 f.
boxrs2wh=: 3 : 0
a=. 2 {."1 y
b=. 2 }."1 y
(a <. b) ,"1 >: | a - b
)

boxwh2rs=: 3 : 0
a=. 2 {."1 y
b=. 2 }."1 y
a,"1 a + b
)
colorxy=: 4 : 0
x=. (i. >: x) % x
x=. x * <: #y
b=. y {~ <.x
t=. y {~ >.x
k=. x - <.x
<. 0.5 + 255 * (t*k) + b*-.k
)
fonargs=: 2 : 0
v (, (u&.>)`(u"0/&.>/)@.(<:@#))@(<^:(-.@*@L.)) y
:
x v (, (u&.>)`(u"0/&.>/)@.(<:@#))@(<^:(-.@*@L.)) y
)
getbandcolor=: 3 : 0
ndx=. y - <./ y
ndx=. <. 0.5 + ndx * (<:#BANDCOLOR) % >./ ndx
ndx { BANDCOLOR
)
getitemcolor=: 3 : 0
y $ DataNdx |. ITEMCOLOR
)
getsquarebox=: 3 : 0
'x y w h'=. y
min=. w <. h
x=. x + <. -: w - min
y=. y + <. -: h - min
x,y,min,min
)
getpieframes=: 3 : 0
'Fx Fy Fw Fh'=: Fxywh=: Lxywh
'Gx Gy Gw Gh'=: Gxywh=: Lxywh
)
grays=: 3 : 0
3#"0 [ 255<. <. (256&% * i.@>:) y
)
linepattern1=: 4 : 0
len=. - -/ y
n=. rndint (%: +/ *: len) % +/ x
if. n=0 do. y
else.
  j=. +/\ 0 , , n # ,: x
  |: ({.y) + len */ (}: % {:) j
end.
)
linepattern2=: 4 : 0
len=. - -/ y
n=. rndint (%: +/ *: len) % +/ x
if. n=0 do. y
else.
  j=. +/\ 0 , , n # ,: x
  |: ({.y) + len */ (% {:) }: j
end.
)
linepattern=: 4 : 0
nap=. ,`[@.('' -: ])`]@.('' -: [)
x=. > x
y=. _2 [\ y
if. x -: 1 0 do.
  <. 2 ,\ y
else.
  a=. ; 2 < @ (x&linepattern1) \ }: y
  <. _2 ,\ a nap x linepattern2 _2 {. y
end.
)
logcheck=: 4 : 0
if. x do. if. 1 e. 0 >: ,y do.
    signal 'Log argument to plot must be positive'
    signal 'plot error' end.
end.
y
)
numcheck=: 3 : 0
if. (ischar y) +: 0 e. $y do. y return. end.
if. ischar y
do. signal 'data should be numeric'
else. signal 'no data to plot'
end.
)
project=: 3 : 0
dat=. }:"1 (y,.1) mp Tfm
dist=. ViewDist-{:"1 dat
((ViewDist*}:"1 dat)%dist),.dist
)
rectoverlap1=: 4 : 0
'lx ly lw lh'=. x
'rx ry rw rh'=. y
((lx>:rx+rw)+.rx>:lx+lw) +: (ry<:ly-lh)+.ly<:ry-rh
)
rectoverlaps=: 3 : 0
'x y w h'=. |: y
xr=. x+w
yt=. y+h
((x>1|.xr)+.xr<1|.x) +: (yt>1|.y)+.y<1|.yt
)
setbox=: 3 : 0
Plot=: Plot,Ndx;0;'draw';'';'';BACKCOLOR;'';y;0
)
setbrush=: [: ';grgb '&, ": , ';gbrush'"_
setdxywh=: 3 : 0
'Dx Dy Dw Dh'=: Dxywh=: y
Gxywh=: Fxywh=: Lxywh=: y
)
setsubdxywh=: 3 : 0
setdxywh Sxywh makepos_xywh y
)
popsxywh=: 3 : 0
if. #SSxywh do.
  'm x s'=. {: SSxywh
  SSxywh=: }: SSxywh
  'Sx Sy Sw Sh'=: Sxywh=: s
  Mxywh=: m
  Mndx=: x
end.
)
pushsxywh=: 3 : 0
SSxywh=: SSxywh, Mxywh;Mndx;Sxywh
'mat win'=. y
'Sx Sy Sw Sh'=: Sxywh=: win
Mxywh=: mat
Mndx=: 0
)
setoutput=: 3 : 0
Poutput=: y
setsizes''
)
setgxywh=: 3 : 0
'Gx Gy Gw Gh'=: Gxywh=: y
)
setlxywh=: 3 : 0
'Lx Ly Lw Lh'=: Lxywh=: y
)
setpxywh=: 3 : 0
if. isempty Pxywh do. IPxywh=: y end.
'Px Py Pw Ph'=: Pxywh=: y
'Sx Sy Sw Sh'=: Sxywh=: y
'Dx Dy Dw Dh'=: Dxywh=: y
Mxywh=: i.0 0
Mndx=: 0
SSxywh=: i.0 3
)
setp=: 3 : 0
Plot=: Plot,Ndx;y
)
showboxes=: 3 : 0
a=. 'Pxywh','Dxywh','Oxywh','Lxywh','Fxywh','Gxywh',:'Kxywh'
b=. Pxywh,Dxywh,Oxywh,Lxywh,Fxywh,Gxywh,:Kxywh
b=. b ,. +/ "2 [ _2 ([\) "1 b
r=. a; b
(- 0 = +/Kxywh) }. each r
)
shownouns=: 3 : 0
rnd=. <.@:+&0.5&.(%&0.0001)
cat=. ,&,.&.|:
x=. (>:>./# &> y) {. each y
f=. ]`rnd @. (e.&8 @ (3!:0))
y=. ":@f@". each y
r=. x cat each y
> ,&.>/ r
)
showplot=: 3 : 0
hdr=. ;:'order type item value style fit pen brush pos'
itm=. tolower each }. each (;2 {"1 Plot) { ItemNames
dat=. itm 2 }"0 1 Plot
stk=. hdr,dat
tc=. 31&<.@$ {.!.'.' ({.~ 30&<.@$)
tc@": &.>stk
)

viewplot=: 3 : 'wdview boxascii showplot y'
showopts=: 3 : 0
shownounds DefOpts
)
showstate=: 3 : 0
(showboxes''),showopts''
)
shrinksquare=: 4 : 0
x + y * 1 1 _2 _2
)
shrinkrect=: 4 : 0
x + , 1 _1 * +/\ _2 [\ 4 $ y
)
stellate=: 4 : 0 "2
norm=. x * unitvec (}:cross&(-/)}.) 3{.y
norm=. norm + (+/y) % #y
2 (norm&,)\y,{.y
)
surfacerev=: 10&$: : (4 : 0)
'r z'=. |: y
ix=. i. x+2
'x y'=. 0 1 |: r */ +. r. ix * 2p1%x
x,"0 1 y,"0 z
)
straddle=: 3 : 0
y*1.1*(y<0),y>:0
)
c=. (}: ,:"1 }.)"2
d=. (}. ,:"1 }:)"2
tiles=: (c@}: ,"2 d@}.) f.
tilesum=: (1,:2 2)&(+/@,;._3)
". toupper COLORTABLE
STDCLR=: _3[\BLUE,RED,GREEN,PURPLE,FUCHSIA,OLIVE,TEAL,YELLOW,TAN,AQUA,BROWN,GRAY
CLR16=: RED,BLUE,GREEN,AQUA,FUCHSIA,LIME,YELLOW,BROWN,TEAL,MAROON,NAVY,OLIVE,SILVER,GRAY,BLACK,:WHITE
RBCLR=: 64 colorxy 1 0 0,:0.5 0 0.5
RGCLR=: 64 colorxy 0 0.5 0.5, 0 0.75 0 ,: 1 0 0
RGBCLR=: 64 colorxy |."1 #:7|3^i.6
BGCLR=: 64 colorxy 0.25 0.95 0.3 ,: 0.25 0.25 1
GRAYSCALE=: 1 (3&#)\ <. 0.5 + 255 * 0.01 * i.101
flexist=: 1:@(1!:4)@< :: 0:
flread=: 1!:1 @ <
flwrite=: (1!:2 <) :: _1:
flwrites=: (toHOST@[ 1!:2 <@]) :: _1:
flwritenew=: 4 : 0
dat=. ,x
if. -. dat -: flread :: 0: y do. dat flwrite y end.
EMPTY
)
fitframexy=: 3 : 0
s=. $y
(s $ Fx,Fy) + y * s $ Fw,Fh
)
fitgrafx=: 3 : 0
Gx + Gw * y
)
fitgrafxy=: 3 : 0
s=. $y
(s $ Gx,Gy) + y * s $ Gw,Gh
)
fitgrafxywh=: 3 : 0
s=. $y
(s $ Gx,Gy,0 0) + y * s $ Gw,Gh
)
fitgrafxy3d=: 3 : 0
Min3d=: Min3d <. <./y
Max3d=: Max3d >. >./y
fitgrafxy3d1 y
)
fitgrafy=: 3 : 0
Gy + Gh * y
)
fit3d=: 3 : 0
pos=. fitxyz y
pos=. }:"1 project pos
fitgrafxy3d1 pos
)
fitgrafxy3d1=: 3 : 0
(Gx,Gy) +"1 (y -"1 Min3d)*"1 (Gw,Gh) % Max3d-Min3d
)
flipyarc=: 3 : 0
y=. _8[\,y
c=. Ch - (+/"1 [ 1 3{"1 y) ,. 5 7{"1 y
($y) $ ,c 1 5 7}"1 y
)
flipxy=: 3 : 0
s=. $y
(s $ 0, Ch) + y * s $ 1 _1
)
flipyrect=: 3 : 0
y=. _4 [\, y
c=. Ch - +/"1 [ 1 3{"1 y
($y) $ ,c 1}"0 1 y
)
get01x=: 3 : '(y - XMin) % XMax-XMin'
get01y=: 3 : '(y - YMin) % YMax-YMin'
getgrafx=: fitgrafx @ get01x
getgrafy=: fitgrafy @ get01y
getgrafmat=: 3 : 0
'x y'=. 2 {. y { Data
,"2 (getgrafx x) ,."1 citemize getgrafy y
)
getgrafxy=: 3 : 0
'x y'=. 2 {. y { Data
(getgrafx x) ; getgrafy y
)
movepos=: [ + $@[ $ ]
scalepos=: [ * $@[ $ ]
text2utf8=: 3 : 0
if. isutf8 y do. y return. end.
if. 131072 = 3!:0 y do. utf8 y return. end.
val=. a. i. y
msk=. 127 < val
uni=. 192 128 +"1 [ 0 64 #: msk # val
val=. val #~ 1 j. msk
ndx=. I. 127 < val
a. {~ uni (ndx +/ 0 1) } val
)
text2ascii8=: 3 : 0
if. isutf8 y do.
  1 u: ucp y
else.
  y
end.
)
baserep=: (&#.) (^:_1)
linsert=: 2&$: : ([: +/\ {.@] , [ # (}. - }:)@] % [)
round=: [ * [: <. 0.5 + %~
rounddown=: [ * [: <. %~
roundint=: <.@:+&0.5
roundup=: [ * [: >. %~
clean=: 1e_10&$: : (4 : 0)
if. L. y do.
  x clean each y
else.
  if. (3!:0 y) e. 16 16384 do.
    j./"1 y * x <: | y=. +.y
  else.
    y * x <: |y
  end.
end.
)
colsum=: 4 : 0
nub=. ~. key=. x{"1 y
nub /:~ nub x}"_1 1 key +//. y
)
groupndx=: [: <: I. + e.~
randomize=: 3 : 0
([ 9!:1) >:<.0.8*0 60 60 24 31#.0 0 0 0 _1+|.<.}.6!:0 ''
)
range=: 3 : 0
'x y n'=. 3{.y,1
s=. _1^y<x
x+s*n*i.>:<.n%~|y-x
)
recur=: 4 : 'r*+/\y%r=.*/\1,x$~<:#y'
roundbanker=: 4 : 0
rd=. <. d=. 0.5 + y % x
x * rd - (rd = d) > 0 = 2 | d
)
rounddist=: 4 : 0
($y) $ x * (- 0 , }:) <. 0.5 + +/\ y % x
)
steps=: {. + (1&{ - {.) * (i.@>: % ])@{:
coclass 'jzplot'
create=: pdreset
destroy=: codestroy
FontScale=: 1
FontSizeMin=: 0
MaxAxisInt=: 0.9
MaxData=: _
PCmd=: ''
Data=: ''
PForm=: 'plot'
Ch=: Cw=: 0
PId=: 'gs'
PIdhwnd=: 0
Plot=: i. 0 0
PFormhwnd=: 0[''
Poutput=: _1
Printer=: 0
PReset=: 0
PText=: ''
PTop=: 0
PShow=: 0
Pxywh=: ''
PStyle=: ''
TypeRest=: ''
('i',each ;: 'LEFT CENTER RIGHT')=: i. 3
j=. ;: 'ISI EPS GTK PDF CANVAS CAIRO ANDROID'
('i' ,each j)=: i.#j
j=. 'i' ,each cutopen toupper 0 : 0
background
border
box
frame
gd
key
rule
subtitle
text
title
xaxis
xcaption
xgrid
xlabel
xtics
yaxis
ycaption
ygrid
ylabel
ytics
y2caption
y2label
y2tics
zaxis
zcaption
zgrid
zlabel
ztics
data
)

ItemNames=: j
(ItemNames)=: i.#ItemNames
readplotdefaults=: 3 : 0
MyPlotDefaults=: flread :: (''"_) jpath '~config/plotdefs.ijs'
)
setplotdefaults=: 3 : 0
select. y
fcase. 'plot' do.
  COLOR=: ''
  IfBar=: IfPie=: 0
  Ndx=: 1
  PCmd=: i.0 0
  PForm=: 'plot'
  Pxywh=: ''
  Types=: ''
fcase. 'new' do.
  IfInit=: 0
  IfMulti=: 0
  0!:100 PlotDefaults
  0!:100 MyPlotDefaults
  ((<'Y2') ,each AxisOpts)=: ". each 'Y' ,each AxisOpts
fcase. do.
  CLEAR=: 1
  BrushColor=: 255 255 255
  Data=: Frame=: Rule=: Text=: ''
  DataRep=: 1
  DimType=: 2
  Gcmd0=: i.0 0
  Gcmd1=: i.0 0
  Opts=: <i.0 0
  Pen=: 1 0
  PenColor=: 0 0 0
  PText=: i. 0 0
  XDiv=: YDiv=: Y2Div=: ZDiv=: 0
  XMax=: YMax=: Y2Max=: ZMax=: Max3d=: __
  XMin=: YMin=: Y2Min=: ZMin=: Min3d=: _
end.
if. -.IFJ6 do.
  if. -. IFTESTPLOTJHS +. IFJHS +. IFGTK do.
    if. 'Android'-:UNAME do.
      r=. 'OUTPUT=: ''android'''
    elseif. ('gtk' -: CONSOLEOUTPUT) *. (3 = 4!:0 <'gtkinit_jgtk_') *. (UNAME -: 'Linux') *: (0 -: 2!:5 'DISPLAY') do.
      if. 0[ 'isi' -: GTKOUTPUT do.
        r=. 'OUTPUT=: ''isi'''
      else.
        r=. 'OUTPUT=: ''gtk'''
      end.
    elseif. (('cairo' -: CONSOLEOUTPUT) +. ('gtk' -: CONSOLEOUTPUT)) *. 3 = 4!:0 <'gtkinit_jgtk_' do.
      r=. 'OUTPUT=: ''cairo'''
    elseif. do.
      r=. 'OUTPUT=: ''pdf'''
    end.
  end.
end.
EMPTY
)
opts=. ;: ;._2 (0 : 0)
ASPECT N
AXES V
AXISCOLOR X
BACKCOLOR X
BANDCOLOR Y
BARWIDTH N
BORDER N
BORDERSIZE N
BOXED N
CAPTIONCOLOR X
CAPTIONFONT F
CLEAR N
COLOR Y
CONTOURLEVELS N
EDGECOLOR X
EDGESIZE N
FONTSCALE N
FONTSIZEMIN N
FORECOLOR X
FRAME N
FRAMEBACKCOLOR X
FRAMESTYLE C
GRAPHBACKCOLOR X
GRIDCOLOR X
GRIDS V
GRIDPATTERN V
GUIDESIZE N
ITEMCOLOR Y
KEY A
KEYCOLOR Y
KEYFONT F
KEYMARKERS S
KEYPOS K
KEYSTYLE K
KEYTITLE M
LABELCOLOR X
LABELFONT F
LABELS V
MARKERS S
MARKERSIZE N
MESH N
ORIENTATION N
OUTPUT C
PENPATTERN W
PENSIZE N
PENSTYLE V
PIEPERCENT N
PLOTCAPTION C
POLAR N
PRINTMARGIN V
PRINTWINDOW C
PSHOW C
RTIC V
RULECOLOR X
RULESIZE N
SEPARATOR C
SHOWBOXES N
ORIGINXLABEL N
SINGTOLER N
SUBTITLE D
SUBTITLECOLOR X
SUBTITLEFONT F
SUBTITLESTYLE C
SYMBOLCOLOR X
SYMBOLFONT F
SYMBOLS C
TEXTCOLOR X
TEXTFONT F
TICMAJOR N
TICMINOR N
TICS V
TICSTYLE C
TITLE D
TITLECOLOR X
TITLEFONT F
TITLESTYLE C
TYPE B
VIEWCENTER V
VIEWPOINT V
VIEWSIZE V
VIEWUP V
VISIBLE N
XCAPTION C
XCAPTIONSTYLE C
XGRIDPATTERN V
XFUNCRES N
XINT N
XLABEL A
XLABELSTYLE C
XLOG N
XRANGE V
XGROUP V
XTIC V
XTICPOS V
Y2AXIS C
YCAPTION C
YCAPTIONSTYLE C
YGRIDPATTERN V
YFUNCRES N
YINT N
YLABEL A
YLABELSTYLE C
YLOG N
YRANGE V
YTIC V
YTICPOS V
Y2CAPTION C
Y2CAPTIONSTYLE C
Y2LABEL A
Y2LABELSTYLE C
Y2LOG N
Y2RANGE V
YGROUP V
Y2TIC V
Y2TICPOS V
ZCAPTIONSTYLE C
ZGRIDPATTERN V
ZINT N
ZLABEL A
ZLABELSTYLE C
ZLOG N
ZRANGE V
ZGROUP V
ZTIC V
ZTICPOS V
)

DefOpts=: {."1 opts
DefOptx=: ,>{:"1 opts

j=. {.&> DefOpts
AxisOpts=: }. each DefOpts #~ j e. 'X'
AxisCmds=: DefOpts #~ j e. 'XYZ'
PlotOpts=: <;._2 (0 : 0)
FONTSCALE
FONTSIZEMIN
KEY
KEYCOLOR
KEYFONT
KEYPOS
KEYSTYLE
KEYTITLE
SUBTITLE
SUBTITLECOLOR
SUBTITLEFONT
SUBTITLESTYLE
TITLE
TITLECOLOR
TITLEFONT
TITLESTYLE
VIEWCENTER
VIEWPOINT
VIEWSIZE
VIEWUP
VISIBLE
)
FontOpts=: <;._2 (0 : 0)
CAPTIONFONT
FONTSCALE
FONTSIZEMIN
KEYFONT
LABELFONT
SUBTITLEFONT
TITLEFONT
)
PDefNames=: <;._2 (0 : 0)
Data
DataRep
DimData
DimType
Frame
Gcmd0
Gcmd1
Opts
Rule
Text
Types
TypeMsk
YAxes
Y2Msk
ASPECT
AXES
CAPTIONFONT
FRAME
FRAMESTYLE
GRIDS
LABELFONT
LABELS
PIEPERCENT
RTIC
TICMAJOR
TICMINOR
TICS
TICSTYLE
TYPE
XCAPTION
XCAPTIONSTYLE
XINT
XLABEL
XLABELSTYLE
XLOG
XRANGE
XTIC
XTICPOS
Y2AXIS
YCAPTION
YCAPTIONSTYLE
YINT
YLABEL
YLABELSTYLE
YLOG
YRANGE
YTIC
YTICPOS
Y2CAPTION
Y2CAPTIONSTYLE
Y2LABEL
Y2LABELSTYLE
Y2LOG
Y2RANGE
YGROUP
Y2TIC
Y2TICPOS
ZCAPTIONSTYLE
ZINT
ZLABEL
ZLABELSTYLE
ZLOG
ZRANGE
ZGROUP
ZTIC
ZTICPOS
)

('p' ,each PDefNames)=: i.#PDefNames
PlotfNames=: <;._2 (0 : 0)
SINGTOLER
XFUNCRES
YFUNCRES
)
plotconvertstringtogerund_z_=: 3 : 0"0 _ 0
if. +./ ((,'y');'y.') e. ;: >y do.
  {. ''`(13 : (>y) f.)
else.
  {. ''`(13 : ('(' , (>y) , ') y') f.)
end.
:
if. +./ ((,'y');'y.') e. ;: >y do.
  {. ''`(13 : (>y) f.)
else.
  {. ''`(13 : ('x (' , (>y) , ') y') f.)
end.
)
plotdefverbm=: 4 : 0
locale=. x
if. 32 ~: 3!:0 gerund=. y do.
  boxs=. <@('`'"_^:(-.@*@#));._1@('`'&,) y
  specs=. (<@;;.1~ (1&(0}))@(*. |.!.0)@:(#@$@>)) boxs
  gerund=. plotconvertstringtogerund__locale specs
end.
locale ,&< gerund
)
plotdefverbd=: 4 : 0
locale=. x
if. 32 ~: 3!:0 gerund=. y do.
  boxs=. <@('`'"_^:(-.@*@#));._1@('`'&,) y
  specs=. (<@;;.1~ (1&(0}))@(*. |.!.0)@:(#@$@>)) boxs
  gerund=. '' plotconvertstringtogerund__locale specs
end.
locale ,&< gerund
)
plotsubd=: 3 : 0"1
(PlotfNames)=: PlotfDefs
origlocale=: 0 {:: > {: y
gerund=. 1 {:: > {: y
res=. 0$a:
if. 2 = #y do.
  y=. boxopen"1^:(3:<{:@$) 0 {:: y
  pfmody=: ]`(^.) @. XLOG
  pfmodz=: ]`(^.@:(0&>.)) @. YLOG
  for_n. gerund do.
    plotf_userverb_z_=: (; # (((%~,[) #) ($,) ]) (n`:6))
    d=. plotfn y
    if. (1 < #d) *. 0 = #YRANGE do.
      mtone1=. (<./@:((i.&0@:(2&(<:/\)) >. i.&0@:(2&(>:/\)))"1))@(1&{::)"1 d
      mtonen=. (>./@:((i:&0@:(0&,)@:(2&(<:/\)) <. i:&0@:(0&,)@:(2&(>:/\)))"1))@(1&{::)"1 d
      quintiles=. ((((+ {.)~ i.&1@:<: [) , ((-~ {:)~ i:&1@:>: [)) %&(1.01 >. SINGTOLER)@({:-{.))@(0&{::)"1 d
      intvl=. 0 _,."1 -~/\"1 (> 2{"1 d) {"0 1 (0 ,. {:@$@> 1{"1 d) ,"0 (mtone1,.mtonen) <.&.(1 _1&*"1) quintiles
      extremes=. (<./&.:(1 _1&*"1)) ; intvl <@:(((<./"1^:2 , >./"1^:2);.0 (1)&{::)"2 1) d
      allextremes=. (<./&.:(1 _1&*"1)) ; <@:((<./"1^:2 , >./"1^:2)@:(1&{::)"1) d
      if. allextremes >&(-~/) 2 * extremes do.
        oor=. (<extremes) +./@(<:/"1@:(<:"1 0))&.> 1{"1 d
        oormsk=. (2{"1 d) +:/@(*. (*./\ ,: *./\.))&.> oor
        d=. oormsk #"1&.>"0 1 (2){."1 d
      end.
    end.
    res=. res , < 2 {."1 d
  end.
else.
  x=. boxopen"1^:(3:<{:@$) 0 {:: y
  y=. boxopen"1^:(3:<{:@$) 1 {:: y
  pfmodx=: ]`(^.) @. XLOG
  pfmody=: ]`(^.) @. YLOG
  pfmodz=: ]`(^.) @. ZLOG
  for_n. gerund do.
    plotf_userverb_z_=: ([ ; ] ; (n`:6)"0 _)
    res=. res , < x plotfn y
  end.
end.
res
)
plotfn=: 3 : 0
if. 0 = L. y do.
  y=. ,:^:(2-#$y) y
  y=. (pfmody 2 {."1 y) ,"1 (2) }."1 y
  if. 0 = #yrange=. XRANGE do. yrange=. 0 1{"0 _1 (<./ ,: >./) y end.
  if. 0 = #sres=. XFUNCRES do. sres=. 2 * 2 { Dxywh end.
  pfresy=: (| -/ yrange) % sres
  ; <@plotfiy y
else.
  plotf_userverb__origlocale&> ,y
end.
:
x=. <@(pfmodx^:_1)@:steps@(pfmodx@(2&{.) , {.@(,&25)@(2&}.))"1^:(0:=L.) x
y=. <@(pfmody^:_1)@:steps@(pfmody@(2&{.) , {.@(,&25)@(2&}.))"1^:(0:=L.) y
; x plotf_userverb__origlocale&.>/ y
)
plotfiy=: 3 : 0 ("1)
if. 0 < 2 { y,0 do.
  (plotf_userverb__origlocale pfmody^:_1 steps y) , <0 0
else.
  pfrngz=: $ 0
  pfrngy=: 2 {. y
  plotfintvl (2 {. y),100
end.
)
plotfintvl=: 3 : 0"1
if. pfresy > -~/ 2 {. y do.
  'y res'=. plotf_userverb__origlocale pfmody^:_1 (2 {. y)
  (-. +./ res e. _ __) # (<@,"0 y) ,. (<"2@:|:@,: res) ,. 0 1;1 0
  return.
end.
'yvals zvals'=. plotf_userverb__origlocale pfmody^:_1 yscrn=. steps y
if. 0 = #pfrngz do.
  if. 0 = #pfrngz=: YRANGE do.
    pfrngz=: -~/ pfmodz (({~ , ({~ _1&-)) <.@(0.1&*)@#) /:~ ,zvals
  end.
  if. 0 = #sres=. YFUNCRES do. sres=. 2 * 3 { Dxywh end.
  pfresz=: pfrngz % sres
end.
if. 0.000001 < (-~ % 0.001&>.@|@[)/ 2 {. yvals do.
  intsize=. 2 -~/\ yvals
  'ylo zlo'=. plotf_userverb__origlocale ({.pfrngy) >. yvals - (,~ {.) 0.01 * intsize
  'yhi zhi'=. plotf_userverb__origlocale ({:pfrngy) <. yvals + (, {:) 0.01 * intsize
  secant=. (zhi-zlo) %"1 yhi-ylo
  fwdproj=. ({."1 zvals) ,"0 1 (}:"1 zvals) + (}:"1 secant) *"1 intsize
  bakproj=. ({:"1 zvals) ,~"0 1 (}."1 zvals) - (}."1 secant) *"1 intsize
  'intst inten'=. (+. (+. 1 _1&(|."0 1))@:|.) (+./ (zvals e. _ __)) +."1 +./"2 (| (bakproj,:fwdproj) -"2&:pfmodz zvals) > pfresz
  intervals=. (I. 2 </\ 0 , intst) ,. (I. 2 >/\ inten , 0)
  unsubint=. ,.@((-~ >:)/\)"1 (#~ ~:/"1) _2 ]\ 0 , (,intervals) , #yvals
  subres=. (unsubint <;.0 yvals) ,. (unsubint <@|:;.0 |: zvals) ,. <0 0
  if. #intervals do.
    subres=. /:~ subres , ; <@plotfintvl (intervals { yscrn) ,. +: >: -~/"1 intervals
  end.
  splitpoints=. _2 +./\ |.!.1 , , > 2{"1 subres
  merge=. ,@(1&((2 # (,}.)"1&.>/"1`'')`(<@(0 _1&{)@;);.1))@|:
  subres=. splitpoints merge;.1 subres
else.
  noninf=. -. +./ zvals e. _ __
  subres=. ,: (noninf#yvals) ; (noninf#"1 zvals) ; 0 0
end.
subres
)
plotshow=: 3 : 0
gtk_window_present_with_time_jgtk_ ((0&". ::]) PFormhwnd),GDK_CURRENT_TIME_jgtk_
selectpid''
gpinit''
make ''
gtk_show 1
)
PDFScale=: 0.5
Sizes=: ([:<i.&' '{.]);._2 (0 : 0)
KeyLen     key length
KeyPen     key pensize
MinMTic    minimum minor Tic distance
MinPie     minimum pie radius
MinTic     minimum major Tic distance
MKx        keybox x-margins
MKy        keybox y-margins
MLxy       labelbox margins (i.e. initial labelbox offset from drawbox)
MGxy       drawbox margins (i.e. initial grafbox offset from framebox)
MPie       pie label margin
MPieTic    pie tic size
MXlabel    xlabel margin (offset from bottom axis or frame)
MYlabel    ylabel margin (offset from left axis or frame)
MTitle     title margins (above and below)
MSubTitle  title margins (above and below)
MXCaption  X caption (above and below)
MYCaption  Y caption (left and right)
)

DefSizes=: 25 2 50 50 50 6 4 3 4 10 6 2 3 6 4 3 3
setsizes=: 3 : 0
s=. PDFScale ^ Poutput e. iEPS,iPDF,iCANVAS,iCAIRO
(Sizes)=: DefSizes * s
MarkerScale=: s
)
all=. 0 : 0
ASPECT=: 0
AXES=: 0
AXISCOLOR=: BLACK
BACKCOLOR=: WHITE
BANDCOLOR=: RGCLR
BARWIDTH=: 0.75
BORDER=: 0
BORDERSIZE=: 8
BOXED=: 1
CAPTIONCOLOR=: BLACK
CLEAR=: 1
CONTOURLEVELS=: 20
EDGECOLOR=: BLACK
EDGESIZE=: 1
FORECOLOR=: BLACK
FONTSCALE=: 0.75
FONTSIZEMIN=: 11
FRAME=: 1
FRAMEBACKCOLOR=: ''
FRAMESTYLE=: ''
GRAPHBACKCOLOR=: ''
GRIDCOLOR=: SILVER
GRIDPATTERN=: 1 0 0
GRIDS=: 1
GUIDESIZE=: 0.5
ITEMCOLOR=: STDCLR
KEY=: ''
KEYCOLOR=: ''
KEYMARKERS=: ''
KEYPOS=: ''
KEYSTYLE=: ''
KEYTITLE=: ''
LABELCOLOR=: BLACK
LABELS=: 1
MARKERS=: ''
MARKERSIZE=: 1
MESH=: 1
ORIENTATION=: 2
ORIGINXLABEL=: 0
PENPATTERN=: 1 0;12 6;2 4;12 6 2 4;12 6 2 4 2 4
PENSIZE=: 1
PENSTYLE=: 0
PIEPERCENT=: 0
PLOTCAPTION=: 'Plot'
POLAR=: 0
PRINTMARGIN=: 1440
PRINTWINDOW=: ''
PSHOW=: ''
RTIC=: ''
RULECOLOR=: BLACK
RULESIZE=: 1
SEPARATOR=: '|'
SHOWBOXES=: 0
SINGTOLER=: 10
SUBTITLE=: ''
SUBTITLECOLOR=: BLACK
SUBTITLESTYLE=: ''
SYMBOLCOLOR=: BLACK
SYMBOLS=: '■▲▼♣♦♥♠'
TEXTCOLOR=: BLACK
TICMAJOR=: 7
TICMINOR=: 4
TICS=: 1
TICSTYLE=: ''
TITLE=: ''
TITLECOLOR=: BLACK
TITLESTYLE=: ''
TYPE=: ''
VIEWCENTER=: 0 0 0
VIEWPOINT=: 1.6 _2.4 1.5
VIEWSIZE=: 1 1 0.5
VIEWUP=: 0 0 1
VISIBLE=: 1
XCAPTION=: ''
XCAPTIONSTYLE=: ''
XFUNCRES=: ''
XGRIDPATTERN=: 3 5
XINT=: ''
XLABEL=: ''
XLABELSTYLE=: ''
XLOG=: 0
XRANGE=: ''
XGROUP=: ''
XTIC=: ''
XTICPOS=: ''
Y2AXIS=: '0'
YCAPTION=: ''
YCAPTIONSTYLE=: ''
YFUNCRES=: ''
YGRIDPATTERN=: 3 5
YINT=: ''
YLABEL=: ''
YLABELSTYLE=: ''
YLOG=: 0
YRANGE=: ''
YGROUP=: ''
YTIC=: ''
YTICPOS=: ''
Y2CAPTION=: ''
Y2CAPTIONSTYLE=: ''
Y2LABEL=: ''
Y2LABELSTYLE=: ''
Y2LOG=: 0
Y2RANGE=: ''
Y2TIC=: ''
Y2TICPOS=: ''
ZCAPTIONSTYLE=: ''
ZGRIDPATTERN=: 3 5
ZINT=: ''
ZLABEL=: ''
ZLABELSTYLE=: ''
ZLOG=: 0
ZRANGE=: ''
ZGROUP=: ''
ZTIC=: ''
ZTICPOS=: ''
)
w32=. 0 : 0
CAPTIONFONT=: 'Arial 13'
KEYFONT=: 'Arial 9'
LABELFONT=: 'Arial 9'
SYMBOLFONT=: 'Arial 9'
TEXTFONT=: 'Arial 13'
SUBTITLEFONT=: 'Arial 14'
TITLEFONT=: 'Arial 15'
)

unx=. 0 : 0
CAPTIONFONT=: 'Sans 13'
KEYFONT=: 'Sans 10'
LABELFONT=: 'Sans 10'
SYMBOLFONT=: 'Monospace 10'
TEXTFONT=: 'Sans 13'
SUBTITLEFONT=: 'Sans 14'
TITLEFONT=: 'Sans 15'
)

all=. all, IFWIN pick unx;w32
PlotDefaults=: 3 : 0 all
if. -.IFJ6 do.
  if. IFTESTPLOTJHS +. IFJHS do.
    r=. 'OUTPUT=: JHSOUTPUT'
  elseif. IFGTK do.
    if. 0[ 'isi' -: GTKOUTPUT do.
      r=. 'OUTPUT=: ''isi'''
    else.
      r=. 'OUTPUT=: ''gtk'''
    end.
  elseif. 'Android'-:UNAME do.
    r=. 'OUTPUT=: ''android'''
  elseif. do.
    r=. 'OUTPUT=: CONSOLEOUTPUT'
  end.
else.
  if. IFCONSOLE do.
    if. UNAME -: 'Linux' do.
      r=. 'OUTPUT=: ''gtk'''
    else.
      r=. 'OUTPUT=: ''pdf'''
    end.
  else.
    r=. 'OUTPUT=: ''isi'''
  end.
end.
y,r,LF
)
TextTypes=: ;: 'text textc textr'
PlotTypes2d=: <;._2 (0 : 0)
area
bar
contour
density
dot
errorbar
fbar
fbarv
hilo
hist
line
marker
pie
poly
point
radar
sbar
sbarv
stick
symbol
)
PlotTypes3d=: <;._2 (0 : 0)
dot
line
poly
stick
surface
wire
)
j=. ;: 'contour density'
PlotData2d=: PlotTypes2d -. j
PlotData3d=: PlotTypes3d, j
PlotTypes=: ~. PlotTypes2d,PlotTypes3d

LineTypes=: ;:'dot errorbar hist line marker point poly radar stick symbol'
BarTypes=: ;:'bar fbar fbarv hist sbar sbarv'
PieTypes=: 'pie';'radar'
FrameTypes=: 'contour';'density'

BandTypes=: 'density';'surface';'wire'
SumXTypes=: ''
SumYTypes=: ;: 'fbar fbarv sbar sbarv'
SumZTypes=: ''
plot=: 3 : 0
'' plot y
:
opt=. x
dat=. y
if. #opt do.
  ndx=. opt i.';'
  first=. deb ndx{.opt
  ind=. <./ first i.', '
  if. (<ind {. first) e. PlotTypes do.
    opt=. 'type ',opt
  end.
end.

pd 'reset'
pd boxcmd opt
if. 1 < L. dat do.
  txy=. 1000 * > { int01 each |. $dat
  rec=. rndint (_1 _1 }. txy) ,"1 [ 1 1 }. txy
  rec=. ": ,/ |. 0 2 |: rec
  dat=. ,dat
  for_d. dat do.
    pd 'use ',d_index { rec
    pd > d
  end.
elseif. 3 = #$dat do.
  for_d. dat do.
    pd d
  end.
elseif. do.
  pd dat
end.

pd 'show'
)
coclass 'jzplot'
makegridpos=: 4 : 0
if. *./ 1 = GRIDPATTERN do.
  x;x+y return.
end.
step=. # GRIDPATTERN
len=. GRIDPATTERN i. 0
off=. - <. -: len
cnt=. >. y % step
px=. off + step * i.cnt
pr=. px + len
(x+0>.px);x+pr<.y
)
AxisIn=: ;: 'INT LABEL LOG Min Max RANGE TIC TICPOS'
AxisOut=: ;: 'Div Int Label Min Minor Max Step Tics TicPos'
getaxes=: 3 : 0
if. IfPie do. return. end.
getaxis 'X'
getaxis 'Y'
if. {:YAxes do.
  getaxis 'Y2'
else.
  Y2Tics=: ''
  if. DimType=3 do.
    getaxis 'Z'
  end.
end.
)
getaxis=: 3 : 0
pm=. y
wid=. ('Y'={.pm) { Lw,Lh
dat=. ". each (<pm) ,each AxisIn
dat=. dat,pm;wid;IfBar
((<pm) ,each AxisOut)=: getaxis1 dat
)
getaxis1=: 3 : 0
nms=. AxisIn,;:'pm wid ifbar'
(nms)=. y
Div=. 0
Tics=. $0
Int=. INT
Label=. LABEL
TicPos=. TICPOS
'Step Minor'=. TIC
wid=. wid - getplotfontsize LabelFontX
mtc=. <. wid % MinTic

if. #RANGE do.
  Min=. {.RANGE
  Max=. 1{RANGE,Max
end.

if. #Int do.
  Min=. Min <. Int
  Max=. Max >. Int
end.

if. #Label do.
  if. #TicPos do.
    if. (#TicPos) ~: #Label do.
      signal 'Number of labels and tic positions should be the same'
    end.
  else.
    TicPos=. Label getaxis_tics pm
  end.
end.

if. #TicPos do.
  Min=. Min <. <./TicPos
  Max=. Max >. >./TicPos
end.
if. ifbar *. pm = 'X' do.

  if. 0=#Label do.
    if. #TicPos do.
      Label=. ": each TicPos
    else.
      steps=. >./ # &> {."1 Data
      Label=. ": each >:i.steps
    end.
  end.

  if. 0 = #TicPos do.
    steps=. >./ # &> {."1 Data
    TicPos=. Min + (Max-Min)*int01 <: steps
  end.

  Div=. 0
  Int=. Min
else.

  if. ifbar do.
    select. 0 <: Min, Max
    case. 1 1 do.
      Min=. 0
    case. 0 0 do.
      Max=. 0
    end.
  end.

  if. #TicPos do.
    'Min Max Int'=. pm getminmax Int;TIC;TicPos;Min;Max;LOG
  else.
    'Step Min Max Int TicPos'=. pm getticpos Int;TIC;Min;Max;LOG;mtc
  end.
  Div=. zero (Int-Min)%Max-Min

end.
Tics=. 2 }. fit01 Min,Max,TicPos
Range=. Min,Max
if. Minor = _1 do.
  if. (0=#TICPOS) *. (Step > 0) *. 1 < #TicPos do.
    Minor=. Step getminor <. wid % MinMTic * <: #TicPos
  else.
    Minor=. 0
  end.

end.
". each AxisOut
)
getaxis_tics=: 4 : 0
labs=. x
select. {. y
case. 'X' do.
  dim0 (<0 0) pick Data
case. 'Y' do.
  dim1 (<0 1) pick Data
case. 'Y2' do.
  dim1 (<(PSDataY2 i.1);1) pick Data
case. 'Z' do.
  zdata=. ; ,each 2 {"1 Data
  n=. <./zdata
  x=. >./zdata
  steps n,x, <:#labs
end.
)
drawxaxis=: 3 : 0
if. 0={.AXES do. return. end.
if. FRAME *. YDiv e. 0 1 do. return. end.
y=. Gy + Gh * YDiv
pos=. Fx, y, (Fx + Fw), y
drawline iXAXIS;AXISCOLOR;GUIDESIZE;pos
)
drawxcaption=: 3 : 0
if. #XCAPTION do.
  x=. Xx + -: Xw
  y=. Xy + Xh - MXCaption
  drawtext iXCAPTION;iCENTER;CaptionFont;CAPTIONCOLOR;XCAPTION;x,y
end.
)
drawxgrid=: 3 : 0
if. 0={.GRIDS do. return. end.
if. {.YAxes do.
  ytics=. YTics
else.
  ytics=. Y2Tics
end.
if. #ytics do.
  ytics=. fitgrafy ytics
  'px pr'=. Gx makegridpos Gw
  len=. (#px) * #ytics
  ytics=. (#px) # ytics
  pos=. |: (len$px),ytics,(len$pr),:ytics
  drawline iXGRID;GRIDCOLOR;GUIDESIZE;pos
end.
)
drawxlabs=: 3 : 0
if. 0={.LABELS do. return. end.
if. 0=#XLabel do. return. end.
if. IfBar do.
  xpos=. fitgrafx }: (0.5&% + int01) # XLabel
  ypos=. (fitgrafy 0) - MXlabel + TICMAJOR
else.
  xpos=. fitgrafx XTics
  ypos=. (fitgrafy YDiv) - MXlabel
end.
if. FRAME do.
  ypos=. Fy - MXlabel + TICMAJOR * TicOut +. IfBar
end.
pos=. xpos,.ypos
drawtext iXLABEL;iCENTER;LabelFont;LABELCOLOR;XLabel;pos
)
drawxlabs3d=: 3 : 0
if. 0={.LABELS do. return. end.
if. 0=#XLabel do. return. end.

xpos=. XTics
ypos=. - (TICMAJOR * 1 + TicOut) % Gh
ndx=. Box3dL firstin 2 6 4 9
if. ndx e. 6 9 do. ypos=. -<:ypos end.

pos=. xpos,"0 1 ypos,ndx e. 4 9
pos=. fit3d pos
drawtext iXLABEL;iCENTER;LabelFont;LABELCOLOR;XLabel;pos
)
drawxtics=: 3 : 0

if. (0={.TICS) +. 0=#XTics do. return. end.
if. IfBar do.
  xpos=. }: (0.5&% + int01) # XLabel
  mark=. -TICMAJOR
  yint=. 0
else.
  'xpos mark'=. gettics XTics;XMinor;XMax;XMin;XLOG
  mark=. mark * _1 ^ TicOut +. (FRAME=0) *. YDiv >: MaxAxisInt
  yint=. YDiv
end.

if. FRAME do.
  h=. Fy - Gy
  pox=. (0,.h+mark),"1 [ 0,h
  pos=. pox +"1 fitgrafxy xpos,.0,.xpos,.0
  if. -. TicOut +. IfBar do.
    h=. (Gy + Gh) - Fy + Fh
    pox=. (0,.h+mark),"1 [ 0,h
    pos=. pos,(-pox) +"1 fitgrafxy xpos,.1,.xpos,.1
  end.
else.
  pox=. 0 0 0&, "0 +mark
  pos=. pox +"1 fitgrafxy xpos,.yint,.xpos,.yint
end.

drawline iXTICS;AXISCOLOR;GUIDESIZE;pos

)
drawxtics3d=: 3 : 0

if. 0={.TICS do. '' return. end.

step=. >:(>:XMinor)*<:#XLabel

mark=. step$(1,XMinor)#(TICMAJOR,TICMINOR)%Gh<.Gw
mark=. mark * _1 ^ TicOut
xpos=. int01 <: step
ypos=. ,0,.mark
ndx=. Box3dL firstin 2 4 6 9
if. ndx e. 6 9 do. ypos=. -.ypos end.

pos=. (2#xpos),.ypos,.ndx e. 4 9
pos=. fit3d pos

drawline iXTICS;AXISCOLOR;GUIDESIZE;_4[\,pos
)
drawyaxis=: 3 : 0
if. 0=1{AXES do. return. end.
if. FRAME *. XDiv e. 0 1 do. return. end.
x=. Gx + Gw * XDiv
pos=. x, Fy, x, Fy + Fh
drawline iYAXIS;AXISCOLOR;GUIDESIZE;pos
)
drawycaption=: 3 : 0
if. #YCAPTION do.
  x=. Yx + MYCaption
  y=. Yy + -: Yh
  if. Poutput e. iISI do.
    font=. CaptionFont,' angle900'
  else.
    font=. 90 (3) } CaptionFont
  end.
  drawtext iYCAPTION;iCENTER;font;CAPTIONCOLOR;YCAPTION;x,y
end.
)
drawy2caption=: 3 : 0
if. #Y2CAPTION do.
  x=. Y2x + Y2w - MYCaption
  y=. Y2y + -: Y2h
  if. Poutput e. iISI do.
    font=. CaptionFont,' angle2700'
  else.
    font=. 270 (3) } CaptionFont
  end.
  drawtext iY2CAPTION;iCENTER;font;CAPTIONCOLOR;Y2CAPTION;x,y
end.
)
drawygrid=: 3 : 0
if. IfBar +. (0=1{GRIDS) +. 0=#XTics do. return. end.
xtics=. fitgrafx XTics
'py ps'=. Gy makegridpos Gh
len=. (#py) * #xtics
xtics=. (#py) # xtics
pos=. |: xtics,(len$py),xtics,:len$ps
drawline iYGRID;GRIDCOLOR;GUIDESIZE;pos
)
drawylabs=: 3 : 0

if. 0=1{LABELS do. return. end.
if. 0=#YLabel do. return. end.

ypos=. <. (fitgrafy YTics) + -: YLabelHeight

tout=. TICMAJOR * TicOut

if. FRAME +. IfBar do.
  pos=. (Fx - MYlabel + tout) ,. ypos
  drawtext iYLABEL;iRIGHT;LabelFont;LABELCOLOR;YLabel;pos
else.
  if. XDiv < MaxAxisInt do.
    pos=. ((fitgrafx XDiv) - MYlabel + tout),.ypos
    drawtext iYLABEL;iRIGHT;LabelFont;LABELCOLOR;YLabel;pos
  else.
    pos=. ((fitgrafx XDiv) + MYlabel + tout),.ypos
    drawtext iYLABEL;iLEFT;LabelFont;LABELCOLOR;YLabel;pos
  end.
end.
)
drawy2labs=: 3 : 0
if. -. {:YAxes do. return. end.
if. (0=2{LABELS) +. 0=#Y2Label do. return. end.
ypos=. <. (fitgrafy Y2Tics) + -: YLabelHeight
pos=. (Fx + Fw + MYlabel) ,. ypos
drawtext iY2LABEL;iLEFT;LabelFont;LABELCOLOR;Y2Label;pos
)
drawylabs3d=: 3 : 0

if. 0=1{LABELS do. '' return. end.
if. 0=#YLabel do. return. end.

ypos=. YTics
xpos=. -(TICMAJOR +1 + TicOut) % Gw
ndx=. Box3dL firstin 1 8 3 10
if. ndx e. 8 10 do. xpos=. -<:xpos end.

pos=. xpos,.ypos,.ndx e. 3 10
pos=. fit3d pos

drawtext iYLABEL;iCENTER;LabelFont;LABELCOLOR;YLabel;pos
)
drawytics=: 3 : 0

if. 0=1{TICS do. return. end.
if. ({.YAxes) *. #YTics do.
  'ypos mark'=. gettics YTics;YMinor;YMax;YMin;YLOG
  mark=. <. mark * _1 ^ FRAME < TicOut +. XDiv >: MaxAxisInt
  if. FRAME +. IfBar do.
    w=. Fx - Gx
    pox=. ,&(0,w,0) "0 mark+w
    pos=. pox + fitgrafxy 0,.ypos,.0,.ypos
    if. FRAME > TicOut +. {:YAxes do.
      w=. (Fx + Fw) - Gx + Gw
      pox=. ,&(0,w,0) "0 w-mark
      pos=. pos,pox + fitgrafxy 1,.ypos,.1,.ypos
    end.
  else.
    pox=. 0,.0,.mark,.0
    pos=. pox + fitgrafxy XDiv,.ypos,.XDiv,.ypos
  end.

  drawline iYTICS;AXISCOLOR;GUIDESIZE;pos
end.
if. ({:YAxes) *. #Y2Tics do.
  'ypos mark'=. gettics Y2Tics;YMinor;Y2Max;Y2Min;Y2LOG
  w=. Fx - Gx
  pox=. ,&(0,w,0) "0 mark+w
  pos=. (-pox) + fitgrafxy 1,.ypos,.1,.ypos
  drawline iYTICS;AXISCOLOR;GUIDESIZE;pos
end.

)
drawy2tics=: 3 : 0
EMPTY
)
drawytics3d=: 3 : 0

if. 0=1{TICS do. '' return. end.

step=. >:(>:YMinor)*<:#YLabel
mark=. step$(1,YMinor)#(TICMAJOR,TICMINOR)%Gh<.Gw
mark=. mark * _1 ^ TicOut
ypos=. int01 <: step
xpos=. ,0,.mark
ndx=. Box3dL firstin 1 8 3 10
if. ndx e. 8 10 do. xpos=. -.xpos end.

pos=. (xpos),.(2#ypos),.ndx e. 3 10
pos=. fit3d pos
drawline iYTICS;AXISCOLOR;GUIDESIZE;_4[\,pos

)
drawzlabs3d=: 3 : 0

if. 0=2{LABELS do. '' return. end.
if. 0=#ZLabel do. return. end.

zpos=. ZTics
xpos=. - (TICMAJOR + 1 + TicOut) % Gh
ndx=. Box3dL firstin 0 5 7 11
if. ndx e. 7 11 do. xpos=. -<:xpos end.

end=. ndx e. 5 11
aln=. end { iRIGHT,iLEFT
pos=. xpos,.end,.zpos
pos=. fit3d pos
drawtext iZLABEL;aln;LabelFont;LABELCOLOR;ZLabel;pos
)
drawztics3d=: 3 : 0

if. 0=2{TICS do. '' return. end.

step=. >: (>:ZMinor) * <:#ZLabel
mark=. step$(1,ZMinor)#(TICMAJOR,TICMINOR) % Gh <. Gw
mark=. mark * _1 ^ TicOut

zpos=. int01 <: step
xpos=. ,0,.mark
ndx=. Box3dL firstin 0 5 7 11
if. ndx e. 7 11 do. xpos=. -. xpos end.

pos=. xpos,.(ndx e. 5 11),.2#zpos
pos=. fit3d pos
drawline iZTICS;AXISCOLOR;GUIDESIZE;_4[\,pos
)
drawpietics=: 3 : 0
rad=. <. -: <./ _2 {. Gxywh
ctr=. (Gx+-:Gw),Gy+-:Gh
xy=. rndint (rad * y),.(rad+MPieTic) * y
xy +"1 [ 4 $ ctr
)
coclass 'jzplot'
cfserr=: 3 : 0
signal 'need data matrix for 3d plot'
signal 'plot error'
)
conform3d=: 3 : 0
'x y z'=. y

shp=. $ each x;y;z
if2=. 2 = # &> shp

select. +/if2

case. 0 do.
  x=. ,:x
  y=. ,;y
  z=. ,:z
  rxy=. $z

case. 1 do.

  rxy=. ;(-.if2)#shp
  rmat=. ;if2#shp

  if. -. rxy -: rmat do.
    if. rxy -: |.rmat do.
      nm=. if2 # 'xyz'
      (nm)=. |:,nm~
    else. cfserr''
    end.
  end.

case. 2 do.
  rz=. ;(-.if2)#shp
  rs=. if2#shp
  rxy=. 0 pick rs
  if. (-:/rs) *: (rz e. rxy) do.
    cfserr''
  end.

case. 3 do.
  if. -. shp -: 3${.shp do.
    cfserr''
  end.
  rxy=. 0 pick shp
end.

'r c'=. rxy
if. 2>rank x do.
  x=. c#"1,.x
end.
if. 2>rank y do.
  y=. rxy$y
end.
if. 2>rank z do.
  z=. rxy$z
end.

x;y;z

)
getdata=: 4 : 0
dat=. y

if. 0 e. $ y do.
  '';(i.0 0);(i.0 0) return.
end.

if. iscomplexdata dat do.
  if. dat -: + dat do.
    dat=. {."1 dat
  else.
    if. 2 > #$dat do.
      dat=. ;/ |: +. dat
    else.
      dat=. ;/ 2 0 1 |: +. dat
    end.
  end.
end.

if. isboxed dat do.
  x getdata_boxed dat
else.
  x getdata_open dat
end.

)
getdata_boxed=: 4 : 0
select. (x=3),#y
case. 0 1 do.
  y=. citemize 0 pick y
  x=. i.{:$y
  x;y;0
case. 1 1 do.
  (i.#0 pick y);(i.{:$0 pick y);y
case. 1 2 do.
  (i.#1 pick y);y
case. do.
  3 {. y,<0
end.
)
getdata_open=: 4 : 0
if. x=2 do.
  y=. citemize y
  x=. i.{:$y
  x;y;0
else.
  z=. citemize y
  y=. i. {:$ z
  x=. i. # z
  x;y;z
end.
)
getmin=: 3 : 0
<./ &> ,each y
)
getmax=: 4 : 0
types=. x
'x y z'=. y
if. (1 e. types e. SumXTypes) do.
  mx=. >./, +/"1 x
else.
  mx=. >./, x
end.
if. (1 e. types e. SumYTypes) do.
  my=. >./, +/ y
else.
  my=. >./, y
end.
if. (1 e. types e. SumZTypes) do.
  mz=. >./, +/ z
else.
  mz=. >./, z
end.
mx,my,mz
)
getpolar=: 3 : 0
'x y z'=. y
(x * cos y) ; (x * sin y) ; z
)
getdatarange=: 3 : 0

'types dat y2msk yaxes'=. y

min=. getmin "1 dat
max=. types & getmax "1 dat

y2min=. y2max=. zmin=. zmax=. 0

select. yaxes

case. 1 0 do.
  'xmin ymin zmin'=. <./ min
  'xmax ymax zmax'=. >./ max
case. 0 1 do.
  'xmin y2min zmin'=. <./ min
  'xmax y2max zmax'=. >./ max
  ymin=. y2min
  ymax=. y2max
case. 1 1 do.
  lmsk=. -.y2msk
  rmsk=. y2msk

  'xln yln j'=. <./ lmsk # min
  'xlx ylx j'=. >./ lmsk # max
  'xrn yrn j'=. <./ rmsk # min
  'xrx yrx j'=. >./ rmsk # max

  xmin=. xln <. xrn
  xmax=. xlx >. xrx
  ymin=. yln
  ymax=. ylx
  y2min=. yrn
  y2max=. yrx
end.
if. (<'radar') e. types do.
  ymin=. 0 <. ymin
  ymax=. 1 >. ymax
end.
(xmin,xmax);(ymin,ymax);(y2min,y2max);zmin,zmax

)

coclass 'jzplot'
Box3d=: _3[\,".;._2 (0 : 0)
0 0 0 0 0 1
0 0 0 0 1 0
0 0 0 1 0 0
0 0 1 0 1 1
0 0 1 1 0 1
0 1 0 0 1 1
0 1 0 1 1 0
1 0 0 1 0 1
1 0 0 1 1 0
0 1 1 1 1 1
1 0 1 1 1 1
1 1 0 1 1 1
)
dofirst=: 1 : 0
Ndx=: Ndx-1
u y
Ndx=: Ndx+1
)
dolast=: 1 : 0
Ndx=: Ndx+1
u y
Ndx=: Ndx-1
)
drawborder=: 3 : 0
if. BORDER do.
  box=. PlotBox shrinkrect BORDERSIZE
  drawbox iBORDER;FORECOLOR;GUIDESIZE;box
end.
)
drawbox=: 3 : 0
'i c s p'=. y
'x y w h'=. p
xw=. x + w
yh=. y + h
drawline i;c;s;x,y,xw,y,xw,yh,x,yh,x,y
)
drawdot=: 3 : 0
'i c s p'=. y
setp 'dot';i;s;0;0;c;0;p
)
drawframebox=: 3 : 0
if. FRAME do.
  drawbox iBOX;AXISCOLOR;GUIDESIZE;Fxywh
end.
)
drawframebox3d=: 3 : 0
box=. (Box3d scalepos XYZDiff) movepos XYZMin
box=. project box
zbox=. {:"1 box
box=. }:"1 box
Box3dX=: /: _2 +/\ zbox
j=. <Box3dX /: 3#1 0 0 1
Box3dL=: j firstin &> 2 6 4 9 ;1 8 3 10 ;0 5 7 11
box=. fitgrafxy3d box
box=. 12 4$,box
box=. Box3dX{box
drawline iFRAME;AXISCOLOR;GUIDESIZE;box
drawline dolast iFRAME;AXISCOLOR;GUIDESIZE;3{.box
)
drawfxywh=: 3 : 0
setp 'fxywh';0;0;0;0;0;0;y#Fxywh
)
drawmarker=: 3 : 0
'i s c m p'=. y
setp 'marker';i;s;m;0;c;0;p
)

drawpline=: 3 : 0
'i t c s p'=. y
setp 'pline';i;s;t;0;c;0;p
)
drawtext=: 3 : 0
'i a f c t p'=. y
setp 'text';i;t;f;a;c;0;p
)
drawtitle=: 3 : 0
if. 0=#TITLE do. '' return. end.
x=. Tx + -: Tw
if. LF e. TITLE do.
  tit=. <;._2 TITLE,LF
  h=. (Th - +:MTitle) % #tit
  y=. Ty + Th - MTitle
  for_t. tit do.
    drawtext iTITLE;iCENTER;TitleFont;TITLECOLOR;t,<x,y
    y=. y - h
  end.
else.
  y=. Ty + Th - MTitle
  drawtext iTITLE;iCENTER;TitleFont;TITLECOLOR;TITLE;x,y
end.
)
drawsubtitle=: 3 : 0
if. 0=#SUBTITLE do. '' return. end.
x=. Vx + -: Vw
if. LF e. SUBTITLE do.
  tit=. <;._2 SUBTITLE,LF
  h=. (Vh - +:MSubTitle) % #tit
  y=. Vy + Vh - MSubTitle
  for_t. tit do.
    drawtext iSUBTITLE;iCENTER;SubTitleFont;SUBTITLECOLOR;t,<x,y
    y=. y - h
  end.
else.
  y=. Vy + Vh - MSubTitle
  drawtext iSUBTITLE;iCENTER;SubTitleFont;SUBTITLECOLOR;SUBTITLE;x,y
end.
)
draw1d=: 4 : 0
'i c s p'=. y
setp x;i;s;0;0;c;0;p
)
draw2d=: 4 : 0
'i e s c p'=. y
setp x;i;s;0;0;e;c;p
)
drawarc=: 'arc' & draw1d
drawline=: 'line' & draw1d
drawpie=: 'pie' & draw2d
drawpoly=: 'poly' & draw2d
drawrect=: 'rect' & draw2d
drawcircle=: 'circle' & draw2d
cube=: 3 : 0
v=. normalize 2 2 2#: i.8
ndx=. 0 2 6 4, 4 6 7 5, 1 5 7 3, 0 1 3 2, 2 3 7 6,: 0 4 5 1
ndx{v
)
dodecahedron=: 3 : 0
x=. 2 o. 1r5p1
y=. % <: +: x
a=. |: 2 1 o./ o. (+:i.5)%5
b=. |: 2 1 o./ o. (>:+:i.5)%5
v=. normalize (a,.0),((+:a*x),.1),((+:b*x),.y),b,.>:y
ndx=. 0 4 3 2 1, 0 1 6 10 5, 1 2 7 11 6, 2 3 8 12 7, 3 4 9 13 8
ndx=. ndx, 4 0 5 14 9, 5 10 15 19 14, 6 11 16 15 10, 7 12 17 16 11
ndx=. _5[\ ndx, 8 13 18 17 12, 9 14 19 18 13, 15 16 17 18 19
ndx{v
)
icosahedron=: 3 : 0
's c'=. 1 2 o. 1r5p1
x=. %: -. % 4 * *: s
y=. %: (1++:c) % 2++:c
a=. |: (2 1 o./ o. (+:i.5)%5) % +:s
b=. |: (2 1 o./ o. (>:+:i.5)%5) % +:s
v=. normalize 0,(a,.x),(b,.x+y),0 0,y++:x
ndx=. 0 2 1, 0 3 2, 0 4 3, 0 5 4, 0 1 5, 1 2 6, 2 3 7, 3 4 8
ndx=. ndx, 4 5 9, 5 1 10, 1 6 10, 2 7 6, 3 8 7, 4 9 8, 5 10 9
ndx=. _3[\ndx, 11 6 7, 11 7 8, 11 8 9, 11 9 10, 11 10 6
ndx{v
)
octahedron=: 3 : 0
v=. normalize 0 0 1, 1 0 0, 0 1 0, _1 0 0, 0 _1 0 ,: 0 0 _1
ndx=. 0 1 2, 0 2 3, 0 3 4, 0 4 1, 5 2 1, 5 3 2, 5 4 3,: 5 1 4
ndx{v
)
tetrahedron=: 3 : 0
r3=. -%%:3
r2=. %:2
r23=. %:2r3
v=. normalize (0,0,%:3), (0, (+:r23),r3), ((-r2),(-r23),r3),: r2,(-r23),r3
ndx=. 0 1 2, 0 2 3, 0 3 1,: 1 3 2
ndx{v
)
normalize=: 3 : 0
v=. (-"1 +/ % #) y
cleanz v % >./ dist"1 v
)
drawtrims=: 3 : 0

if. IfPie do. return. end.

if. DimType=2 do.
  drawframebox''

  drawxgrid''
  drawygrid''

  drawxaxis''
  drawyaxis''

  drawxtics''
  drawytics''

  drawxlabs''
  drawylabs''
  drawy2labs''

  drawxcaption''
  drawycaption''
  drawy2caption''

else.

  if. BOXED do.
    drawframebox3d''
    drawxtics3d''
    drawytics3d''
    drawztics3d''
    drawxlabs3d''
    drawylabs3d''
    drawzlabs3d''
  end.

end.
)
wpsave=: 3 : 0
cx=. ,_1 [ cy=. ,_1
gtk_window_get_position_jgtk_ y;cx;cy
cxywh_jwplot_=: cx,cy, 2}. getGtkWidgetAllocation_jgtk_ y
)

wpset=: 3 : 0
if. 0 0 0 0-:cxywh_jwplot_ do.
  gtk_window_move_jgtk_ y,0 0
  gtk_window_set_default_size_jgtk_ y,480 360
else.
  gtk_window_move_jgtk_ y,2{.cxywh_jwplot_
  gtk_window_set_default_size_jgtk_ y,2}.cxywh_jwplot_
end.
)
pclose_gtk=: 3 : 0
try.
  if. ifjwplot'' do.
    wpsave (0&". ::]) PFormhwnd
    if. #pdcmdsave do.
      gtk_save pdcmdsave
      pdcmdsave=: ''
    end.
    if. pdcmdclip do.
      gtk_clip ''
      pdcmdclip=: 0
    end.
    if. pdcmdprint do.
      pdcmdprint=: 0
      print''
    end.
  end.
  gtk_widget_destroy_jgtk_ ::0: (0&". ::]) PFormhwnd
  PFormhwnd=: 0
  pd 'reset'
catch. end.
if. (ifjwplot'') *. -.IFGTK do.
  f=. 1
  if. (0: <: 18!:0) <'gtkwd' do.
    if. 0~: #windowList_gtkwd_ do. f=. 0 end.
  end.
  if. f do. gtk_main_quit_jgtk_'' [ gtkMainLoop_jgtk_=: 0 end.
end.
0
)
popen_gtk=: 3 : 0
if. 0~: (0&". ::]) PFormhwnd do.
  if. gtk_widget_is_toplevel_jgtk_ (0&". ::]) PFormhwnd do.
    if. 0= gtk_window_has_toplevel_focus_jgtk_ ((0&". ::]) PFormhwnd) do.
      gtk_window_present_with_time_jgtk_ ((0&". ::]) PFormhwnd),GDK_CURRENT_TIME_jgtk_
    end.
    selectpid''
    0 return.
  end.
end.
PFormhwnd=: window=. gtk_window_new_jgtk_ GTK_WINDOW_TOPLEVEL_jgtk_
'Cw Ch'=: 480 360
gtk_window_set_title_jgtk_ window;PLOTCAPTION
gtk_widget_set_name_jgtk_ window;PForm
PIdhwnd=: glcanvas_jgl2_ (Cw,Ch);coname''
box=. gtk_vbox_new_jgtk_ 0 0
gtk_container_add_jgtk_ window,box
gtk_box_pack_start_jgtk_ box, PIdhwnd, 1 1 0
consig_jgtk_ window;'destroy';'pclose';coname''

if. ifjwplot'' do.
  wpset window
end.

fm=. PForm,'_'
id=. fm,PId,'_'
(fm,'close')=: pclose_gtk
(fm,'cancel')=: pclose_gtk
(fm,'tctrl_fkey')=: ptop_gtk
(id,'paint')=: ppaint_gtk
(id,'size')=: ppaint_gtk
(id,'mmove')=: ]

(fm,'f10_fkey')=: pd bind 'eps'
(fm,'f11_fkey')=: pd bind 'pdf'

Pxywh=: ''
PShow=: 0
1
)
ppaint_gtk=: 3 : 0
l=. glgetloc PIdhwnd
if. newsize__l do.
  gtk_show ''
  newsize__l=: 0
end.
0
)
psize_gtk=: 3 : 0
if. #Plot do.
  ppaint''
end.
)
ptop_gtk=: 3 : 0
PTop=: -. PTop
gtk_window_set_keep_above_jgtk_ ((0&". ::]) PFormhwnd), PTop
0
)
3 : 0''
if. 'Android'-:UNAME do.
pclose=: pclose_android
popen=: popen_android
ppaint=: ppaint_android
psize=: psize_android
ptop=: ptop_android
else.
pclose=: pclose_gtk
popen=: popen_gtk
ppaint=: ppaint_gtk
psize=: psize_gtk
ptop=: ptop_gtk
end.
EMPTY
)
PMenu=: 0 : 0
menupop "&File";
menu clip "&Clip" "" "" "";
menusep;
menu saveeps "&Save EPS" "" "" "";
menusep;
menu savepdf "&Save PDF" "" "" "";
menusep;
menu print "&Print" "" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Help";
menu help "&Plot Help" "" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
)
pclose_isi=: 3 : 0
try.
  wd 'psel ',": PFormhwnd
  if. ifjwplot'' do.
    wpsave_j_ :: 0: PForm
  end.
  wd 'pclose'
  pd 'reset'
catch. end.
)
popen_isi=: 3 : 0
if. ifparent ": PFormhwnd do.
  wd 'psel ',": PFormhwnd
  wd 'pactive'
  glsel PId
  0 return.
end.
wd 'pc ',PForm
PFormhwnd=: 0". wd 'qhwndp'
wd 'pn *',PLOTCAPTION
wd 'xywh 0 0 240 180'
wd 'cc ',PId,' isigraph rightmove bottommove'
wd 'pas 0 0'

if. ifjwplot'' do.
  wpset_j_ :: 0: PForm
else.
  wdmove _1 0
end.
wdfit ''

fm=. PForm,'_'
id=. fm,PId,'_'
(fm,'close')=: pclose_isi
(fm,'cancel')=: pclose_isi
(fm,'tctrl_fkey')=: ptop
(id,'paint')=: ppaint
(id,'size')=: ppaint
(id,'mmove')=: ]

(fm,'f10_fkey')=: pd bind 'eps'
(fm,'f11_fkey')=: pd bind 'pdf'

Pxywh=: ''
PShow=: 0
)
ppaint_isi=: 3 : 0
cwh=. glqwh''
if. -. cwh -: Cw,Ch do.
  isi_show ''
end.
)
psize_isi=: 3 : 0
if. #Plot do.
  ppaint''
end.
)
ptop_isi=: 3 : 0
PTop=: -. PTop
wd 'ptop ',":PTop
)
pclose_android=: 3 : 0
0
)
popen_android=: 3 : 0
if. (-.ifjwplot'') *. 0~: (0&". ::]) PFormhwnd do.
    selectpid''
    0 return.
end.
fm=. PForm,'_'
id=. fm,PId,'_'
(fm,'close')=: pclose_android
(id,'paint')=: ppaint
(id,'mmove')=: ]

Pxywh=: ''
PShow=: 0
StartActivity_ja_ (>coname'');'onDestroy'
)
ppaint_android=: 3 : 0
cwh=. glqwh''
if. 1[ cwh -.@-: Cw,Ch do.
  android_show ''
end.
)

3 : 0''
if. 'Android'-:UNAME do.
  pclose=: pclose_android
  popen=: popen_android
  ppaint=: ppaint_android
  psize=: psize_android
  ptop=: ptop_android
end.
EMPTY
)
fzskludge=: 4%3
pgetascender=: 3 : 0
if. Poutput = iISI do.
  if. 1=GL2Backend_jgl2_ do.
    glfont y
    1 { glqtextmetrics''
  else.
    FontScale * getascender y
  end.
elseif. Poutput = iGTK do.
  if. 1=GL2Backend_jgl2_ do.
    glfont gtkfontdesc y
    1 { glqtextmetrics''
  else.
    FontScale * getascender y
  end.
elseif. Poutput = iANDROID do.
  if. 1 [ 1=GL2Backend_jgl2_ do.
    glfont andfontdesc y
    1 { glqtextmetrics''
  else.
    FontScale * getascender y
  end.
elseif. Poutput = iCAIRO do.
  FontScale * getascender y
elseif. Poutput = iCANVAS do.
  FontScale * getascender (FontSizeMin >. 2{y) 2 } y
elseif. do.
  FontScale * getascender y
end.
)
pgetextent=: 4 : 0
select. Poutput
case. iISI do.
  glfont x
  |: glqextent &> y
case. iGTK do.
  glfont gtkfontdesc^:(0={.0#x) x
  |: glqextent &> y
case. iANDROID do.
  glfont andfontdesc^:(0={.0#x) x
  |: glqextent &> y
case. iCAIRO do.
  FontScale * fzskludge *  x getextent y
case. iCANVAS do.
  FontScale * fzskludge * ((FontSizeMin >. 2{x) 2} x) getextent y
case. do.
  FontScale * x getextent y
end.
)
pgetextent1=: 4 : 0
if. LF e. y do.
  r=. (<x) pgetextent1 &> <;._2 y,LF
  (>./{."1 r),+/{:"1 r return.
end.
select. Poutput
case. iISI do.
  glfont x
  glqextent y
case. iGTK do.
  glfont gtkfontdesc^:(0={.0#x) x
  glqextent y
case. iANDROID do.
  glfont andfontdesc^:(0={.0#x) x
  glqextent y
case. iCANVAS do.
  FontScale * fzskludge * ((FontSizeMin >. 2{x) 2} x) getextent1 y
case. do.
  FontScale * x getextent1 y
end.
)
getfontsize=: 13 : '{.1{._1 -.~ _1 ". y'
getplotfontsize=: 3 : 0
if. 2 131072 e.~ 3!:0 y do.
  FontScale * FontSizeMin >. getfontsize y
else.
  FontScale * FontSizeMin >. 2 { y
end.
)

pgetstringlen=: {. @ pgetextent
setfonts=: 3 : 0

CaptionFontX=: getfontid CAPTIONFONT
KeyFontX=: getfontid KEYFONT
LabelFontX=: getfontid LABELFONT
SubTitleFontX=: getfontid SUBTITLEFONT
SymbolFontX=: getfontid SYMBOLFONT
TitleFontX=: getfontid TITLEFONT

if. Poutput = iISI do.
  CaptionFont=: getisifontid CaptionFontX
  KeyFont=: getisifontid KeyFontX
  LabelFont=: getisifontid LabelFontX
  SubTitleFont=: getisifontid SubTitleFontX
  SymbolFont=: getisifontid SymbolFontX
  TitleFont=: getisifontid TitleFontX
elseif. Poutput e. iGTK do.
  CaptionFont=: getgtkfontid CaptionFontX
  KeyFont=: getgtkfontid KeyFontX
  LabelFont=: getgtkfontid LabelFontX
  SubTitleFont=: getgtkfontid SubTitleFontX
  SymbolFont=: getgtkfontid SymbolFontX
  TitleFont=: getgtkfontid TitleFontX
elseif. Poutput e. iANDROID do.
  CaptionFont=: getgtkfontid CaptionFontX
  KeyFont=: getgtkfontid KeyFontX
  LabelFont=: getgtkfontid LabelFontX
  SubTitleFont=: getgtkfontid SubTitleFontX
  SymbolFont=: getgtkfontid SymbolFontX
  TitleFont=: getgtkfontid TitleFontX
elseif. do.
  CaptionFont=: CaptionFontX
  KeyFont=: KeyFontX
  LabelFont=: LabelFontX
  SubTitleFont=: SubTitleFontX
  SymbolFont=: SymbolFontX
  TitleFont=: TitleFontX
end.

FontScale=: (Poutput e. iEPS,iPDF,iCAIRO) { 1,FONTSCALE
FontSizeMin=: (Poutput e. iCANVAS) { 0,FONTSIZEMIN
)
coclass 'jzplot'
gdxy=: 3 : 0
xy=. _2 [\ <;._1 ' ',deb y
,('x' gdxy1 {."1 xy),.'y' gdxy1 {:"1 xy
)
gdxy1=: 4 : 0
if. x='y' do.
  b=. Gy
  s=. Gh
  max=. YMax
  min=. YMin
else.
  b=. Gx
  s=. Gw
  max=. XMax+IfBar*1.5
  min=. XMin+IfBar*0.5
end.
np=. I. mp=. 'x' = {:&> y
nr=. I. mr=. 'r' = {:&> y
nm=. I. mm=. mr +: mp
y=. 0 ".&> (-mr+.mp) }. each y
y=. ((s%1000) * nm{y) nm}y
if. #np do.
  px=. np{y
  px=. (px<0) } px,:1 + s|px
  y=. px np}y
end.
if. #nr do.
  pr=. s * (max-min) %~ (nr{y) - min
  y=. pr nr}y
end.
b + rndint y
)
gdbrushcolor=: 3 : 0
BrushColor=: rndint _1 ". toupper y
)
gdlines=: 3 : 0
drawpline iGD;({:Pen);PenColor;({.Pen);gdxy y
)
gdpen=: 3 : 0
Pen=: 2 {. _1 ". y
)
gdpencolor=: 3 : 0
PenColor=: rndint _1 ". toupper y
)
gdrect=: 3 : 0
drawrect iGD;PenColor;({.Pen);BrushColor;gdxy y
)
drawgd=: 3 : 0
cmd=. ('Gcmd',":y)~
for_d. cmd do.
  'f v'=. d
  f~v
end.
)
coclass 'jzplot'
KeyOpts=: <;._2 (0 : 0)
bottom
boxed
center
combo
fat
horizontal
inside
left
marker
middle
open
outside
right
thin
top
vertical
)
drawkey=: 3 : 0

if. 0 = #KEY do. return. end.

len=. #KEY
if. #KEYCOLOR do.
  clr=. KEYCOLOR
else.
  clr=. ITEMCOLOR
end.
clr=. len $ clr
'hz rj'=. 'hr' e. KEYSTYLE

boxed=. -. 'o' e. KEYSTYLE
marker=. 1 e. 'mc' e. KEYSTYLE

if. marker do.
  if. #ndx=. KEYMARKERS,MARKERS do.
    markers=. ndx { KeyMarkerNames
  else.
    markers=. KeyMarkerNames
  end.
end.
'kx ky'=. ((boxed + 1) * MKx,MKy) + Kx,Ky
'tw th'=. KeyExtent
mtw=. >./tw
mth=. >./th
select. hz,rj
case. 0 0 do.
  gx=. 0
  gy=. ty=. |. +/\ th
  tx=. MKx + KeyLen
  ts=. iLEFT
case. 0 1 do.
  tx=. mtw
  gx=. tx + MKx
  gy=. ty=. |. +/\ th
  ts=. iRIGHT
case. 1 0 do.
  gy=. ty=. mth
  gx=. 0, +/\ }: tw + KeyLen + 3 * MKx
  tx=. gx + KeyLen + MKx
  ts=. iLEFT
case. 1 1 do.
  gy=. ty=. mth
  gx=. (+/\ tw) + (KeyLen + 3 * MKx) * i.#tw
  tx=. gx - MKx
  ts=. iRIGHT
end.

gx=. gx + kx
tx=. tx + kx
gy=. gy + ky
ty=. ty + ky
if. boxed do.
  rect=. boxwh2rs Kxywh shrinkrect MKx,MKy,MKx,MKy
  col=. ('o' e. KEYPOS) pick FrameBackColor;BACKCOLOR
  drawrect iKEY;AXISCOLOR;1;col;rect
end.
if. marker do.
  xy=. (gx + -: KeyLen),.ty - -: th
  for_i. i.#xy do.
    drawmarker iKEY;(MarkerScale*MARKERSIZE);(i{clr);(i{markers),<,:i{xy
  end.
  if. 'c' e. KEYSTYLE do.
    wh=. KeyLen,KeyPen
    xy=. gx,.ty - -: KeyPen + th
    dat=. xy ,"1 xy +"1 wh
    drawrect iKEY;AXISCOLOR;0;clr;dat
  end.
elseif. 'f' e. KEYSTYLE do.
  hit=. 0.5 * <./th
  ly=. ty + 1 - -: hit + th
  xy=. gx,.ly
  wh=. KeyLen,hit
  dat=. xy ,"1 xy +"1 wh
  drawrect iKEY;AXISCOLOR;0;clr;dat
elseif. do.
  ly=. ty + 1 - -: KeyPen + th
  xy=. gx,.ly
  wh=. KeyLen,KeyPen
  dat=. xy ,"1 xy +"1 wh
  drawrect iKEY;AXISCOLOR;0;clr;dat
end.
if. Poutput = iANDROID do.
  ty=. ty - <. 0.75 * {.th
end.
pos=. tx,.ty

drawtext dolast iKEY;ts;KeyFont;LABELCOLOR;KEY;pos
)
getinnerkeybox=: 3 : 0

if. 0 = #KEY do. return. end.

if. 'o' e. KEYPOS do. return. end.
if. 'h' e. KEYSTYLE do.
  if. 'r' e. KEYPOS do.
    x=. Gw - (+:MKx) + Kw
  elseif. 'c' e. KEYPOS do.
    x=. -: Gw - Kw
  elseif. do.
    x=. +:MKx
  end.
  if. 'b' e. KEYPOS do.
    y=. +:MKy
  else.
    y=. Gh - (+:MKy) + Kh
  end.
else.
  if. 'r' e. KEYPOS do.
    x=. Gw - (+:MKx) + Kw
  else.
    x=. +:MKx
  end.
  if. 'b' e. KEYPOS do.
    y=. +:MKy
  elseif. 'm' e. KEYPOS do.
    y=. -: Gh - Kh
  elseif. do.
    y=. Gh - (+:MKy) + Kh
  end.
end.

Kx=: x+Gx
Ky=: y+Gy
Kxywh=: Kx,Ky,Kw,Kh
)
ifouterkey=: 3 : 0
('o' e. KEYPOS) *. 0 < #KEY
)
getouterkeybox=: 3 : 0
if. -. ifouterkey'' do. return. end.

if. 'r' e. KEYPOS do.
  x=. Ox + Ow - Kw
elseif. 'c' e. KEYPOS do.
  x=. Ox + -: Ow - Kw
elseif. do.
  x=. Ox
end.

if. 'b' e. KEYPOS do.
  y=. Oy
elseif. 'm' e. KEYPOS do.
  y=. Oy + -: Oh - Kh
elseif. do.
  y=. Oy + Oh - Kh
end.

Kx=: x
Ky=: y
Kxywh=: Kx,Ky,Kw,Kh
)
getkeysize=: 3 : 0

if. 0 = #KEY do.
  'Kx Ky Kw Kh'=: Kxywh=: 4$0 return.
end.
len=. #KEY
KeyExtent=: KeyFont pgetextent KEY
'tw th'=. KeyExtent
if. 'h' e. KEYSTYLE do.
  kw=. (len * KeyLen + 3 * MKx) + +/tw
  kh=. (+:MKy) + >./th
else.
  kw=. (3 * MKx) + KeyLen + >./tw
  kh=. (+:MKy) + +/th
end.
if. -. 'o' e. KEYSTYLE do.
  kw=. kw + +: MKx
  kh=. kh + +: MKy
end.
'Kx Ky Kw Kh'=: Kxywh=: 0 0,kw,kh
)

coclass 'jzplot'
getaspect=: 3 : 0
if. ASPECT=0 do. return. end.
select. * ASPECT - Gh % Gw
case. _1 do.
  getaspecth''
case. 1 do.
  getaspectw''
end.
Gxywh=: Gx,Gy,Gw,Gh
Fxywh=: Fx,Fy,Fw,Fh
Lxywh=: Lx,Ly,Lw,Lh
)
getaspecth=: 3 : 0
new=. Gw * ASPECT
dh=. Gh - new
dy=. 0 >. (Dy - Gy) + -: Dh - new
Gh=: Gh - dh
Gy=: Gy + dy
Fh=: Fh - dh
Fy=: Fy + dy
Lh=: Lh - dh
Ly=: Ly + dy
if. (#KEY) *. 'o' e. KEYPOS do.
  Ky=: Ky + ('b' e. KEYPOS) { (dy-dh),dy
  Kxywh=: Kx,Ky,Kw,Kh
end.
if. #XCAPTION do.
  Xy=: Xy + dy
  Xxywh=: Xx, Xy, Xw, Xh
end.
if. #TITLE do.
  Ty=: Ty + dy - dh
  Txywh=: Tx, Ty, Tw, Th
end.
if. #SUBTITLE do.
  Vy=: Vy + dy - dh
  Vxywh=: Vx, Vy, Vw, Vh
end.
)
getaspectw=: 3 : 0
new=. Gh % ASPECT
dw=. Gw - new
dx=. 0 >. (Dx - Gx) + -: Dw - new
Gw=: Gw - dw
Gx=: Gx + dx
Fw=: Fw - dw
Fx=: Fx + dx
Lw=: Lw - dw
Lx=: Lx + dx
if. (#KEY) *. 'o' e. KEYPOS do.
  Kx=: Kx + ('r' e. KEYPOS) { dx,dx-dw
  Kxywh=: Kx,Ky,Kw,Kh
end.
if. (IfMulti >: IfPie) *. #YCAPTION do.
  Yx=: Yx + dx
  Yxywh=: Yx, Yy, Yw, Yh
end.
if. #Y2CAPTION do.
  Y2x=: Y2x + dx - dw
  Y2xywh=: Y2x, Y2y, Y2w, Y2h
end.
)
getframebox=: 3 : 0
if. 0 = #FRAMESTYLE do.
  FrameX=: -. IfBar
else.
  FrameX=: 'o' e. FRAMESTYLE
end.
if. #Frame do.
  'Fx Fy Fw Fh'=: Fxywh=: Frame return.
end.

if. 0 = #Data do. return. end.

x=. y=. r=. t=. 0
if. (YAxes -: 1 0) *. XDiv >: MaxAxisInt do.
  YAxes=: 0 1
  Y2Label=: YLabel
  Y2Tics=: YTics
  YTics=: YLabel=: ''
end.
if. #;XLabel do.
  mxlab=. MXlabel
  'xlw xlh'=. LabelFont pgetextent XLabel
  lx=. >.-:{.xlw
  lr=. 0 >. >.-:{:xlw
else.
  xlw=. xlh=. mxlab=. lx=. lr=. 0
end.
if. #;YLabel do.
  mylab=. MYlabel
  'ylw ylh'=. LabelFont pgetextent YLabel
  ly=. MGxy + (TICMAJOR * FrameX=0) + >.-:{.ylh
  lt=. 0 >. >.-:{:ylh
else.
  ylw=. ylh=. mylab=. ly=. lt=. 0
end.
YLabelHeight=: {. ylh
if. {:YAxes do.
  if. #;Y2Label do.
    mylab=. MYlabel
    'yrw yrh'=. LabelFont pgetextent Y2Label
    lr=. lr >. mylab + (>./ yrw)
    lt=. lt >. >.-:{:yrh
  else.
    ylw=. ylh=. mylab=. ly=. lt=. 0
  end.
end.
if. DimType=3 do.
  if. #;ZLabel do.
    'zlw zlh'=. LabelFont pgetextent ZLabel
    lx=. >./lx,zlw
    ly=. >./xlh,ylh,zlh
  end.
end.
if. FRAME +. XDiv=0 do.
  x=. lx >. mylab + >./ylw
else.
  x=. lx
end.
if. FRAME +. IfBar +. YDiv=0 do.
  y=. ly >. mxlab + {. >./xlh
else.
  y=. ly
end.
if. TicOut do.
  x=. x + TICMAJOR
  y=. y + TICMAJOR
  lr=. lr + TICMAJOR * {:YAxes
elseif. IfBar do.
  y=. y + TICMAJOR
end.
mrg=. rndint x,y,lr,lt
if. DimType=3 do.
  mrg=. 4 $ >./ mrg
end.
Fxywh=: Lxywh shrinkrect mrg
'Fx Fy Fw Fh'=: Fxywh
)
getminor=: 4 : 0
(y > 2) * 3 + 2 = (pow10 >. log10 x) % x
)
getminmax=: 4 : 0

'int tic ticpos min max log'=. y
if. log=1 do.
  dat=. (pow10 int);tic;(pow10 ticpos);(pow10 min);(pow10 max);2
  log10 each x getminmax dat return.
end.
min=. (10 ^ <. _2.9 + 10 ^. | min) rounddown min
max=. (10 ^ <. _2.9 + 10 ^. | max) roundup max
if. 0=#int do.
  if. max > 0 do.
    int=. 0 >. min
  else.
    int=. max
  end.
end.
min,max,int
)
gettfm=: 3 : 0
view=. VIEWPOINT-VIEWCENTER
ViewDist=: dist view
n=. view % ViewDist
v=. unitvec VIEWUP - n * n mp VIEWUP
t=. (v cross n),.v,.n
r=. -VIEWCENTER mp t
tfm=. (t,.0),r,1
XYZMin=: XMin,YMin,ZMin
XYZDiff=: (XMax,YMax,ZMax)-XYZMin
fitxyz=: [: movepos & XYZMin scalepos & XYZDiff
fit=. ((VIEWSIZE*=i.3)%XYZDiff),(-0.5+XYZMin%XYZDiff),1
Tfm=: fit mp tfm
)
getgrafbox=: 3 : 0
if. DimType=3 do.
  Gxywh=. Fxywh shrinkrect TICMAJOR * TicOut
else.
  if. FRAME *. FrameX do.
    Gxywh=: Fxywh shrinkrect TICMAJOR + MGxy
  else.
    Gxywh=: Fxywh
  end.
end.
'Gx Gy Gw Gh'=: Gxywh
)
lfmt=: 3 : 0
dat=. ": y
txt=. ,dat
($dat) $ '-' (I. txt='_') } txt
)
getlabelbox=: 3 : 0

lxywh=. Oxywh

if. ifouterkey'' do.

  'lx ly lw lh'=. lxywh
  lr=. lx + lw
  ls=. ly + lh

  if. 'h' e. KEYSTYLE do.
    if. 'b' e. KEYPOS do.
      ly=. Ky + Kh
    else.
      ls=. Ky
    end.
  else.
    if. 'r' e. KEYPOS do.
      lr=. Kx
    elseif. 'c' e. KEYPOS do.
      if. 'b' e. KEYPOS do.
        ly=. Ky + Kh
      else.
        ls=. Ky
      end.
    elseif. do.
      lx=. Kx + Kw
    end.
  end.
  lxywh=. lx,ly,(lr-lx),ls-ly

end.

'Lx Ly Lw Lh'=: Lxywh=: lxywh shrinkrect MLxy + MXlabel,MYlabel
)
getlabels=: 3 : 0

fm=. FRAME +. ORIGINXLABEL

if. (0=#XLabel) *. 0 { LABELS do.
  b=. (XInt=XTicPos) *. (XInt=0) >: YDiv e. 0 1
  ndx=. I. (DimType=2) *. fm<b
  XLabel=: (<'') ndx } lfmt each pow10 ^: XLOG XTicPos
end.
if. (0=#YLabel) *. 1 { LABELS do.
  b=. (YInt=YTicPos) *. (YInt=0) >: XDiv e. 0 1
  ndx=. I. (DimType=2) *. fm<b
  YLabel=: (<'') ndx } lfmt each pow10 ^: YLOG YTicPos
end.

if. DimType=2 do.
  if. {:YAxes do.
    if. (0=#Y2Label) *. 2 { LABELS do.
      b=. (Y2Int=Y2TicPos) *. (Y2Int=0) >: XDiv e. 0 1
      ndx=. I. (DimType=2) *. fm<b
      Y2Label=: (<'') ndx } lfmt each pow10 ^: Y2LOG Y2TicPos
    end.
  end.
  return.
end.
if. (0=#ZLabel) *. 2 { LABELS do.
  b=. (ZInt=ZTicPos) *. (ZInt=0) >: XDiv e. 0 1
  ndx=. I. (DimType=2) *. FRAME<b
  ZLabel=: (<'') ndx } lfmt each pow10 ^: ZLOG ZTicPos
end.
)
getinnerboxes=: 3 : 0
getframebox''
getgrafbox''
getaspect''
getinnerkeybox''
)
getouterlayout=: 3 : 0
if. IfPie do.
  setouterkey''
end.
getkeysize''
getouterboxes''
getouterkeybox''
)
getlayout=: 3 : 0
TicOut=: 'o' e. TICSTYLE
getouterlayout''
getlabelbox''
getaxes''
if. IfPie do.
  FRAME=: 0
  getpieframes'' return.
end.
if. 1 e. TYPE e. 'contour';'density' do.
  FRAME=: +./ AXES,FRAME
end.
getlabels''
getinnerboxes''
if. DimType=3 do.
  gettfm''
end.
)
getmultilayout=: 3 : 0
setouterkey''
getkeysize''
getouterboxes''
getouterkeybox''
getlabelbox''
)
setouterkey=: 3 : 0
KEYPOS=: ~.'o',KEYPOS -. 'i'
)
getouterboxes=: 3 : 0

'ox oy ow oh'=. Dxywh
or=. ox + ow
os=. oy + oh
if. #TITLE do.
  'Tw Th'=: (TitleFont pgetextent1 TITLE) + +: MTitle
  Tx=: Dx + -: Dw - Tw
  Ty=: Dy + Dh - Th
  Txywh=: Tx,Ty,Tw,Th
  os=. os <. Ty
else.
  'Tx Ty Tw Th'=: Txywh=: Dx,(Dy+Dh),0 0
end.
if. #SUBTITLE do.
  'Vw Vh'=: (SubTitleFont pgetextent1 SUBTITLE) + +: MSubTitle
  Vx=: Dx + -: Dw - Vw
  Vy=: Ty - Vh
  Vxywh=: Vx,Vy,Vw,Vh
  os=. os <. Vy
else.
  'Vx Vy Vw Vh'=: Vxywh=: Tx,Ty,0 0
end.
if. (-.IfPie) *. #YCAPTION do.
  'Yh Yw'=: (CaptionFont pgetextent1 YCAPTION) + +: MYCaption
  Yx=: Dx
  Yy=: Dy + -: Dh - Yh
  if. #TITLE,SUBTITLE do.
    if. (Tx<.Vx) < Yx+Yw do.
      Yy=: Dy >. Yy <. Vy - Yh
    end.
  end.
  Yxywh=: Yx,Yy,Yw,Yh
  ox=. ox >. Yx + Yw
else.
  'Yx Yy Yw Yh'=: Yxywh=: Dx,Dy,0 0
end.
if. #Y2CAPTION do.
  'Y2h Y2w'=: (CaptionFont pgetextent1 Y2CAPTION) + +: MYCaption
  Y2x=: Dx + Dw - Y2w
  Y2y=: Dy + -: Dh - Y2h
  if. #TITLE,SUBTITLE do.
    if. ((Tx+Tw)>.Vx+Vw) > Y2x do.
      Y2y=: Dy >. Y2y <. Vy - Y2h
    end.
  end.
  Y2xywh=: Y2x,Y2y,Y2w,Y2h
  or=. or <. Y2x
else.
  'Y2x Y2y Y2w Y2h'=: Y2xywh=: (Dx+Dw),Dy,0 0
end.
if. #XCAPTION do.
  'Xw Xh'=: (CaptionFont pgetextent1 XCAPTION) + +: MXCaption
  Xx=: Dx + -: Dw - Xw
  Xy=: Dy

  if. #YCAPTION do.
    if. Yy < Xy + Xh do.
      Xx=: Xx >. Yx + Yw
    end.
  end.

  if. #Y2CAPTION do.
    if. Y2y < Xy + Xh do.
      Xx=: 0 >. Xx <. Yx - Xw
    end.
  end.
  Xxywh=: Xx,Xy,Xw,Xh
  oy=. oy >. Xy + Xh
else.
  'Xx Xy Xw Xh'=: Xxywh=: Dx,Dy,0 0
end.
'Ox Oy Ow Oh'=: Oxywh=: ox,oy,(or-ox),os-oy
)
movepielabels=: 3 : 0

pos=. y
org=. y
len=. #pos
'Lmw Lmh'=: <. -: 2 3 { Lxywh
whilst. -. old -: pos do.

  old=. pos
  msk=. rectoverlaps pos
  if. -. 1 e. msk do.
    0;pos return.
  end.
  msk=. msk, 2 {. msk
  if. -. 0 e. msk do.
    pos=. moveoutpielabels pos continue.
  end.
  ndx=. 1 + I. 0 1 E. msk

  for_i. ndx do.
    'cur nxt'=. (len | i + 0 1) { pos
    if. (i+2) { msk do.
      new=. cur movepielabelback nxt
      pos=. new i } pos
    else.
      new=. cur separatepielabel nxt
      pos=. new (len | i + 0 1) } pos
    end.
    if. -. pos -: old do. break. end.
  end.

end.

(pos-:org);pos
)
moveoutpielabels=: 3 : 0
'x y w h'=. |: y
x=. x + * x
y=. y + * y
x=. (-Lmw) >. x <. Lmw - w
y=. (-Lmh) >. y <. Lmh - h
x,.y,.w,.h
)
movepielabelback=: 4 : 0

'lx ly lw lh'=. x
'rx ry rw rh'=. y
ox=. (lw+rw) + (lx<.rx) - (lx+lw)>.rx+rw
oy=. (lh+rh) + (ly<.ry) - (ly+lh)>.ry+rh
ox=. ox + 3
oy=. oy + 3
ang=. (ly - -: lh) getangle lx + -: lw
if. (ox % | cos ang) < oy % | sin ang do.
  mx=. ox
  my=. >. mx * | ly%lx
else.
  my=. oy
  mx=. >. my * | lx%ly
end.

mx=. mx * _1 ^ ly > 0
my=. my * _1 ^ lx < 0

lx=. lx + mx
ly=. ly + my

lx,ly,lw,lh
)

separatepielabel=: 4 : 0
'lx ly lw lh'=. x
'rx ry rw rh'=. y
ox=. (lw+rw) + (lx<.rx) - (lx+lw)>.rx+rw
oy=. (lh+rh) + (ly<.ry) - (ly+lh)>.ry+rh
ox=. >. 2 + -: ox
oy=. >. 2 + -: oy
ang=. (ly - -: lh) getangle lx + -: lw
rad=. -: Gh
if. rad < ly <. ry do.
  lx=. lx - ox
  rx=. rx + ox
elseif. rad < - (ly+lh) <. ry+rh do.
  lx=. lx + ox
  rx=. rx - ox
elseif. rad < rx <.ry do.
  ly=. ly - oy
  ry=. ry + oy
elseif. rad < - (rx+rw) <. ry+rw do.
  ly=. ly + oy
  ry=. ry - oy
elseif. do.
  if. (ox % | cos ang) < oy % | sin ang do.
    mx=. ox
    my=. >. mx * | ly%lx
  else.
    my=. oy
    mx=. >. my * | lx%ly
  end.
  mx=. mx * _1 ^ ly > 0
  my=. my * _1 ^ lx < 0
  lx=. lx + mx
  rx=. rx - mx
  ly=. ly + my
  ry=. ry - my
end.

lx=. (-Lmw) >. (lx + *lx) <. Lmw - lw
ly=. (-Lmh) >. (ly + *ly) <. Lmh - lh
rx=. (-Lmw) >. (rx + *rx) <. Lmw - rw
ry=. (-Lmh) >. (ry + *ry) <. Lmh - rh
(lx,ly,lw,lh),:rx,ry,rw,rh
)
rotxy=: 4 : 0
rot=. 2 2$ 1 1 _1 1 * 0 1 1 0 { 2 1 o. x
rot +/ . * "2 1 y
)
getticpos=: 4 : 0

'int tic min max log cnt'=. y

if. log do. x gettplog y return. end.
nmm=. 10 ^ <. <: 10 ^. max - min
min=. nmm rounddown min
max=. nmm roundup max

def=. cnt <. (DimType=3) { 10 6
step=. {.tic
wid=. max - min
if. wid=0 do.
  if. #int do.
    if. int=min do.
      'min max'=. straddle min
    else.
      'min max'=. sort int, min
    end.
  else.
    'min max'=. straddle int=. min
  end.
end.
if. #int do.
  max=. max >. int
  min=. min <. int
else.
  if. (min <: 0) *. max >: 0 do.
    int=. 0
  end.
end.
if. step > 0 do.
  s=. step * 1 + i.10
else.
  s=. 1 2 5 10 20 50 100 * pow10 <: <. log10 max - min
end.

if. min < 0 do.
  x=. s roundup min
else.
  x=. s rounddown min
end.
if. max > 0 do.
  y=. s rounddown max
else.
  y=. s roundup max
end.
c=. <. (y - x) % s
ndx=. (c <: def) i. 1
step=. ndx { s,0

if. (step=0) +. ndx = #x do.
  pos=. ''
else.
  pos=. (ndx{x) + step * i. 1 + ndx{c
  min=. min <. {. pos
  max=. max >. {: pos
end.
if. 0=#int do.
  if. max > 0 do.
    int=. 0 >. min
  else.
    int=. max
  end.
end.
step;min;max;int;pos
)
gettics=: 3 : 0
'tics minor max min log'=. y
if. (minor=0) +. 1 >: #tics do.
  tics;(#tics)$TICMAJOR return.
end.
if. log do.
  tics=. pow10 min + tics * max - min
  tmax=. pow10 max
  tmin=. pow10 min
  tics=. (tics - tmin) % tmax - tmin
  'pos mark'=. gettics tics;minor;0;0;0
  pos=. tmin + pos * tmax - tmin
  pos=. ((log10 pos) - min) % max - min
  pos;mark return.
end.
bgn=. {. tics
end=. {: tics
dif=. end - bgn

step=. minor + 1
len=. ((}.-}:) tics) % step
pos=. bgn + 0, +/\ step # len

if. dif = 1 do.
  mark=. (#pos) $ (1,minor) # TICMAJOR,TICMINOR
else.
  pos=. (bgn - +/\. minor # {. len), pos, end + +/\ minor # {:len
  mark=. ($pos) $ (minor,1) # TICMINOR,TICMAJOR
  msk=. (pos >: 0) *. pos <: 1
  pos=. msk # pos
  mark=. msk # mark
end.

pos;mark
)
gettplog=: 4 : 0
'int tic lmin lmax log cnt'=. y
def=. cnt <. (DimType=3) { 8 6
if. 2.9 < lmax-lmin do.
  max=. >.lmax
  min=. <.lmin
  step=. >.(max-min)%def
  if. 0=#int do.
    int=. min
  else.
    min=. min <. log10 int
  end.
  pos=. min+step*i.>:>.(max-min)%step
  step;min;max;int;pos return.
end.
min=. pow10 lmin
max=. pow10 lmax
nmm=. 10 ^ <. <: 10 ^. max - min
min=. nmm rounddown min
max=. nmm roundup max

step=. {.tic
wid=. max - min
if. wid=0 do.
  if. #int do.
    if. int=min do.
      'min max'=. straddle min
    else.
      'min max'=. sort int, min
    end.
  else.
    'min max'=. straddle int=. min
  end.
end.
if. #int do.
  max=. max >. int
  min=. min <. int
else.
  if. (min <: 0) *. max >: 0 do.
    int=. 0
  end.
end.
if. step > 0 do.
  s=. step * 1 + i.10
else.
  s=. 1 2 5 10 20 50 100 * pow10 <: <. log10 max - min
end.
x=. s rounddown min
y=. s rounddown max
c=. <. (y - x) % s
ndx=. (c <: def) i. 1
step=. ndx { s,0

if. (step=0) +. ndx = #x do.
  pos=. ''
else.
  pos=. (ndx{x) + step * i. 1 + ndx{c
  min=. min <. {. pos
  max=. max >. {: pos
end.
if. 0=#int do.
  int=. min
end.
if. min=0 do.
  pmin=. pow10 lmin
  min=. <. pmin
  if. min=0 do.
    p=. 10 ^ -i.15
    b=. 10 ^ - 1 i.~ pmin >: p
    min=. ({:p) >. b * <. pmin % b
  end.
  int=. int >. min
  pos=. pos >. min
end.

min=. log10 min
max=. log10 max
int=. log10 int
pos=. log10 pos

step;min;max;int;pos

)
coclass 'jzplot'
Y2Axis=: <'Y2AXIS'
j=. 'xint xmin xmax yint ymin ymax y2int y2min y2max zint zmin zmax'
SubCmds=: ;:'axes frame labels ',j
drawbackground=: 3 : 0
if. CLEAR do.
  drawrect iBACKGROUND;BACKCOLOR;1;BACKCOLOR;boxwh2rs Dxywh
  if. #FRAMEBACKCOLOR do.
    drawrect iBACKGROUND;FrameBackColor;1;FrameBackColor;boxwh2rs Fxywh
  end.
  if. #GRAPHBACKCOLOR do.
    drawrect iBACKGROUND;GraphBackColor;1;GraphBackColor;boxwh2rs Gxywh
  end.
  CLEAR=: 0
end.
)
getdeftype=: 3 : 0
t=. 0
if. (3 = #y) *. L. y do.
  t=. (ifplotf y) +. 2 = #$_1 pick y
end.
t { 'line';'surface'
)
getdims=: 3 : 0
'data types'=. y
if. 1 e. types e. PlotData3d -. PlotData2d do.
  dd=. 3
elseif. 1 e. types e. PlotData2d -. PlotData3d do.
  dd=. 2
elseif. do.
  dd=. >./ 2, getdim &> {:"1 data
end.
if. 1 e. types e. PlotTypes3d -. PlotTypes2d do.
  dt=. 3
elseif. 1 e. types e. PlotTypes2d -. PlotTypes3d do.
  dt=. 2
elseif. do.
  dt=. dd
end.

dd,dt
)

getdim=: [: # $^:(0 = L.)
getmulticmd=: 3 : 0
mat=. citemize y
res=. i. 0 2
for_m. mat do.
  'cmd dat'=. m
  'hdr cmd'=. pdcmdhdr boxcmd cmd
  cmd=. (1 + # &> hdr) }. each cmd
  cmd=. setoptions hdr,.cmd
  res=. res, cmd,'data';<dat
end.
)
getsubcmds=: 3 : 0
if. isboxed 0 pick y do.
  ;getsubcmds each y
else.
  'cmd dat'=. y
  if. #cmd do.
    cmd=. boxcmd cmd
    msk=. -. ({."1 cmd) e. SubCmds
    (msk # cmd), 'data';<dat
  else.
    ,:'data';<dat
  end.
end.
)
makepos_xy=: 3 : 0
'x y'=. y
tx=. (Dx,Dw) makepos1 x
ty=. (Dy,Dh) makepos1 y
tx,ty
)
makepos_xywh=: 4 : 0

if. 0 = #y do. x return. end.

'Bx By Bw Bh'=. x
if. ischar y do.
  'x y r s'=. <;._1 ' ',deb y
  tx=. (Bx,Bw) makepos1 x
  tr=. (Bx,Bw) makepos1 r
  ty=. (By,Bh) makepos1 y
  ts=. (By,Bh) makepos1 s
  tx,ty,(tr-tx),ts-ty
else.
  (4 $ Bw,Bh) * (boxrs2wh y) % 1000
end.
)
makepos1=: 4 : 0
'b w'=. x
t=. 0 ". y -. 'x'
select. (0 > t), 'x' e. y
case. 0 0 do.
  b + w * t % 1000
case. 0 1 do.
  b + t
case. 1 0 do.
  b + w * (1 + 1000 | t) % 1000
case. 1 1 do.
  b + 1 + w | t
end.
)
settypeflags=: 3 : 0
types=. y
IfBar=: 1 e. types e. BarTypes
IfFrame=: 1 e. types e. FrameTypes
IfBand=: 1 e. types e. BandTypes
IfPie=: 1 e. types e. PieTypes
)
makedata_init=: 3 : 0
DataNdx=: 0
getlayout''
drawbackground''
drawtrims''
drawfxywh 1
drawgd 0
)
makenodata=: 3 : 0
getouterlayout''
drawbackground''
getinnerboxes''
drawgd 0
)
MultiDefs=: <;._2 (0 : 0)
BACKCOLOR
ITEMCOLOR
KEY
KEYSTYLE
KeyExtent
KeyFont
Kxywh
SUBTITLE
SUBTITLECOLOR
SUBTITLEFONT
SUBTITLESTYLE
SubTitleFont
TITLE
TITLECOLOR
TITLEFONT
TITLESTYLE
TitleFont
Txywh
XCAPTION
XCAPTIONSTYLE
Xxywh
Y2CAPTION
Y2CAPTIONSTYLE
YCAPTION
YCAPTIONSTYLE
Yxywh
ZCAPTION
ZCAPTIONSTYLE
)
definemultidefs=: 3 : 0
pdefs y
'Kx Ky Kw Kh'=: Kxywh
'Tx Ty Tw Th'=: Txywh
'Xx Xy Xw Xh'=: Xxywh
'Yx Yy Yw Yh'=: Yxywh
)
MultiGroups=: <;._2 (0 : 0)
XGROUP
YGROUP
ZGROUP
)
MultiHdrs=: MultiDefs,MultiGroups,<;._2 (0 : 0)
CLEAR
COLOR
OUTPUT
)
getxgroup=: 4 : 0
dat=. y
for_n. x </. i.#x do.
  ind=. > n
  dat=. (getxgroup1 ind { dat) ind } dat
end.
)
getxgroup1=: 3 : 0
dat=. y
if. 1 = #dat do. return. end.

if. 1 < # ~. (pDimData,pDimType) {"1 dat do.
  'Incompatible types in XGROUP' assert 0
end.

int=. ; pXINT {"1 dat
if. #int do.
  dat=. (< <./int) pXINT }"1 dat
end.

rng=. > pXRANGE {"1 dat
rng=. ({.<./rng),.{:>./rng
dat=. (<rng) pXRANGE }"1 dat

lab=. ~. (pXLABEL {"1 dat) -. a:
select. #lab
case. 0 do.
case. 1 do.
  dat=. lab pXLABEL }"1 dat
case. do.
  'Incompatible labels in XGROUP' assert 0
end.

dat

)
getygroup=: 4 : 0
dat=. y
for_n. x </. i.#x do.
  ind=. > n
  dat=. (getygroup1 ind { dat) ind } dat
end.
)

getygroup1=: 3 : 0
dat=. y
if. 1 = #dat do. return. end.

if. 1 < # ~. (pDimData,pDimType) {"1 dat do.
  'Incompatible types in YGROUP' assert 0
end.

int=. ; pYINT {"1 dat
if. #int do.
  dat=. (< <./int) pYINT }"1 dat
end.

rng=. > pYRANGE {"1 dat
rng=. ({.<./rng),.{:>./rng
dat=. (<rng) pYRANGE }"1 dat

lab=. ~. (pYLABEL {"1 dat) -. a:
select. #lab
case. 0 do.
case. 1 do.
  dat=. lab pYLABEL }"1 dat
case. do.
  'Incompatible labels in YGROUP' assert 0
end.

dat
)
make=: 3 : 0
'out xywh'=. y
setoutput out
setpxywh xywh
Plot=: i. 0 0
Ndx=: 1
cmd=. setoptions PCmd
makesub cmd
Plot=: Plot /: {."1 Plot
EMPTY
)
makemulti=: 3 : 0

setplotdefaults 'new'
setsubdxywh''

'cmd pos'=. {. y
dat=. }. y
if. 0 = #dat do.
  drawbackground '' return.
end.
if. ',' e. pos do.
  ndx=. pos i. ','
  pos=. (0 ". ndx {. pos) ; 0 ". (ndx + 1) }. pos
else.
  pos=. (0 ". pos) # each 1
end.
Shape=: # &> pos
len=. */ Shape
ndx=. ({."1 dat) i. <'data'
opts=. ndx {. dat
cmds=. getmulticmd each 1 pick ndx { dat
msk=. ({."1 e. FontOpts"_) each cmds
mopts=. ; msk #each cmds
cmds=. (-.each msk) # each cmds
mopts=. mopts ,~ (-. ({."1 opts) e. MultiHdrs) # opts
mopts=. (|. ~: |. {."1 mopts) # mopts
defineoptions opts
setfonts''
getmultilayout''
multidefs=. packs MultiDefs
multigroups=. packs MultiGroups
drawbackground''
setplotdefaults 'new'
pdefs multigroups
if. *./ (XGROUP;YGROUP;ZGROUP) e. '';i.len do.
  mxywh=. Lxywh makesubshape pos
  for_i. i.#cmds do.
    Sxywh=: i { mxywh
    cmd=. ('new';''), mopts
    cmd=. cmd, i pick cmds
    makenew cmd
  end.
else.
  mxywh=. makemultigroup mopts;cmds;<pos
end.
makemulti_fini multidefs;mxywh
)
makemultigroup=: 3 : 0
'opts cmds pos'=. y

if. Y2Axis e. ; {."1 each cmds do.
  signal 'Y2Axis not supported in grouped Multiplots'
end.

len=. */ 'rws cls'=. shape=. # &> pos
if. #XGROUP do.
  if. -. (#XGROUP) e. 1,cls,len do.
    signal 'Number of X groups should be one of 1, ',(":cls),', ',":len
  end.
else.
  XGROUP=: i.len
end.
if. #YGROUP do.
  if. -. (#YGROUP) e. 1,rws,len do.
    signal 'Number of Y groups should be one of 1, ',(":rws),', ',":len
  end.
else.
  YGROUP=: i.len
end.
XGroup=: i.~ len $ XGROUP
YGroup=: i.~ len $ ((len=#YGROUP) { cls,1) # YGROUP

IfMXlabs=: 1 = #~. shape $ XGroup
IfMYlabs=: 1 = #~. |: shape $ YGroup
def=. (". each PDefNames) & getpdef &> cmds
def=. XGroup getxgroup def
def=. YGroup getygroup def
mxywh=. Lxywh makesubshape pos
fxywh=. i. 0 4
for_i. i.#def do.
  setplotdefaults 'new'
  defineoptions opts
  setdxywh i { mxywh
  fxywh=. fxywh, getframesize i { def
end.

fxywh=. fitmulti fxywh
def=. (<"1 fxywh) pFrame }"0 1 def
for_i. i.#def do.
  setplotdefaults 'new'
  defineoptions opts
  setdxywh i { mxywh
  makepdef i { def
end.

mxywh
)
makemulti_fini=: 3 : 0
'defs mxywh'=. y
definemultidefs defs
drawtitle''
drawsubtitle''
drawmulticaptions mxywh
drawborder''
drawkey''
Ndx=: Ndx + 3
)
drawmulticaptions=: 3 : 0
mxywh=. Shape $ y
if. #XCAPTION do.
  xcap=. boxarg XCAPTION
  if. 1=#xcap do.
    drawxcaption''
  else.
    cls=. 1 { $ mxywh
    xcap=. cls {. xcap
    for_i. i.cls do.
      mat=. i {"2 mxywh
      Xx=: 0 { <./mat
      Xw=: 2 { >./mat
      XCAPTION=: i pick xcap
      drawxcaption''
    end.
  end.
end.
if. #YCAPTION do.
  ycap=. boxarg YCAPTION
  if. 1=#ycap do.
    drawycaption''
  else.
    rws=. {. $ mxywh
    ycap=. rws {. ycap
    for_i. i.rws do.
      mat=. i { mxywh
      Yy=: 1 { <./mat
      Yh=: 3 { >./mat
      YCAPTION=: i pick ycap
      drawycaption''
    end.
  end.
end.
)
getframesize=: 3 : 0
(PDefNames)=: y
if. 0=#Data do.
  Dxywh return.
end.
defineoptions 0 pick Opts
setfonts''
settypeflags ;Types
getlayout''
Fxywh
)
fitmulti=: 3 : 0
fxw=. 0 2 {"1 y
fyh=. 1 3 {"1 y

'r c'=. Shape
len=. r * c

if. #XGroup do.
  xg=. XGroup + len $ len * i.c
  fxw=. xg fitmulti1 fxw
end.

if. #YGroup do.
  yg=. YGroup + c # len * i.r
  fyh=. yg fitmulti1 fyh
end.

0 2 1 3 {"1 fxw,.fyh
)
fitmulti1=: 4 : 0
}."1 /:~ ; x fitmulti2 /. (i.#y),.y
)
fitmulti2=: 3 : 0
'i fx fw'=. |: y
fx=. >./fx
fw=. (<./fx+fw) - fx
<i,"0 1 fx,fw
)
setcolorrep=: 3 : 0
if. *./ 1 = DataRep do. return. end.
f=. 4 : 'y #~ 1 >. (#y) {. x'
COLOR=: DataRep f COLOR
BANDCOLOR=: DataRep f BANDCOLOR
ITEMCOLOR=: DataRep f ITEMCOLOR
)
defineoptions=: 3 : 0
if. #y do.
  ({."1 y)=: {:"1 y
end.
)
definecolor=: 3 : 0
if. #COLOR do.
  if. IfBand do.
    BANDCOLOR=: COLOR
  else.
    ITEMCOLOR=: COLOR
  end.
  COLOR=: ''
end.
if. #FRAMEBACKCOLOR do.
  FrameBackColor=: FRAMEBACKCOLOR
else.
  FrameBackColor=: BACKCOLOR
end.
if. #GRAPHBACKCOLOR do.
  GraphBackColor=: GRAPHBACKCOLOR
else.
  GraphBackColor=: FrameBackColor
end.
)
setoptions=: 3 : 0

if. 0 e. $y do. i.0 0 return. end.

mat=. citemize y

opt=. toupper each {."1 mat
if. 0 e. opt e. DefOpts,PDDefs,PDGD do.
  j=. tolower 0 pick opt -. DefOpts,PDDefs,PDGD
  signal 'option not found: ', j
end.

arg=. {:"1 mat

ndx=. I. opt e. DefOpts
def=. ndx { opt

if. Y2Axis e. def do.
  ind=. I. ('Y' = {.&> def) > +./\. Y2Axis = def
  new=. (<'Y2') ,each }. each ind { def
  def=. new ind } def
end.

val=. {:"1 ndx { mat
ind=. DefOpts i. def
typ=. ind { DefOptx

for_i. i.#def do.

  dat=. i pick val
  select. i{typ
  case. 'A' do.
    dat=. boxarg dat
  case. 'B' do.
    dat=. boxarg tolower dat
  case. 'C' do.
  case. 'D' do.
    dat=. dat rplc '<br/>';LF
  case. 'F' do.
    dat=. getfont dat
  case. 'K' do.
    dat=. keyarg dat
  case. 'M' do.
    dat=. SEPARATOR mfv dat
  case. 'N' do.
    dat=. {. fix dat
  case. 'T' do.
    dat=. +/ ". &> 'i'&, each boxarg toupper comma2blank dat
  case. 'U' do.
    dat=. toupper {. dat
  case. 'V' do.
    dat=. fix dat
  case. 'X' do.
    dat=. ".toupper dat
  case. 'Y' do.
    dat=. _3[\, rndint ".toupper dat
  case. 'S' do.
    select. i pick def
    case. 'MARKERS' do.
      dat=. MarkerNames setfixx dat
    case. 'KEYMARKERS' do.
      dat=. KeyMarkerNames setfixx dat
    case. do.
      signal 'plot option not supported'
    end.
  case. do.
    signal 'plot option not supported'
  end.
  val=. (<dat) i } val
end.

mat=. (def,.val) ndx } mat
)
setfixx=: 4 : 0
if. *./ y e. '0123456789 ' do.
  fix y
else.
  y=. ',',tolower y
  x i. a: -.~ (y e. ', ') <;._1 y
end.
)
makenew=: 3 : 0

dat=. y
'cmd rect'=. {. dat
dat=. }. dat

setplotdefaults cmd
setsubdxywh rect
if. (1 = #dat) *. 'BACKCOLOR' -: 0 pick {. dat do.
  defineoptions dat
  dat=. ''
end.
if. 0 = #dat do.
  drawbackground '' return.
end.
msk=. ({."1 dat) e. PlotOpts
defineoptions msk # dat
dat=. (-.msk) # dat
makepdef (". each PDefNames) getpdef dat
)
makepdef=: 3 : 0
(PDefNames)=: y

defineoptions 0 pick Opts
setfonts''
settypeflags ;Types
setcolorrep''
definecolor''
if. 0=#Data do.
  makenodata ''
else.
  makedata_init {.Y2Msk
  mat=. (Y2Msk ;&> i.#Y2Msk),.Opts,.Types
  for_m. mat do.
    maketype m
  end.
end.
makenew_fini''
)
makenew_fini=: 3 : 0
drawgd 1
drawfxywh 0
drawbackground''
maketext''
makerule''
drawtitle''
drawsubtitle''
drawborder''
drawkey''
if. SHOWBOXES do.
  drawbox iBOX;BLUE;GUIDESIZE;Lxywh
  drawbox iBOX;RED;GUIDESIZE;Fxywh
  drawbox iBOX;GREEN;GUIDESIZE;Gxywh
  dat=. Kxywh,Txywh,Xxywh,Yxywh,:Y2xywh
  dat=. dat #~ 0 < +/"1 dat
  for_d. dat do.
    drawbox iBOX;MAGENTA;GUIDESIZE;d
  end.
end.
Ndx=: Ndx + 3
)
getpdef=: 4 : 0

(PDefNames)=. x

cmd=. y
hdr=. {."1 cmd
msk=. hdr e. PDgd
if. 1 e. msk do.
  gl2=. msk#cmd
  ndx=. ({."1 gl2) i. <'gdend'
  Gcmd0=. ndx {. gl2
  Gcmd1=. (ndx+1) }. gl2
  cmd=. (-.msk) # cmd
  hdr=. {."1 cmd
end.
msk=. (4 {.each hdr) e. 'rule';'RULE'
if. 1 e. msk do.
  Rule=. msk#cmd
  cmd=. (-.msk) # cmd
  hdr=. {."1 cmd
end.
msk=. (4 {.each hdr) e. 'text';'TEXT'
if. 1 e. msk do.
  Text=. msk#cmd
  cmd=. (-.msk) # cmd
  hdr=. {."1 cmd
end.
if. -. (<'data') e. hdr do.
  (hdr)=. {:"1 cmd
  Opts=. < cmd #~ -. hdr e. PDefNames
  ". each PDefNames return.
end.
if. (<'TYPE') e. hdr do.
  type=. 1 pick (hdr i. <'TYPE') { cmd
else.
  if. #TYPE do.
    type=. TYPE
  else.
    type=. getdeftype 1 pick (hdr i. <'data') { cmd
  end.
end.
msk=. hdr e. DefOpts
def=. msk # cmd
({."1 def)=. {:"1 def
PlotfDefs=: ". each PlotfNames
msk=. hdr = <'data'
dat=. msk ((}:;{:@{:));.2 cmd
'dat rep'=. getverbres dat
DataRep=. rep
opts=. {."1 dat
hdrs=. {."1 each opts
dats=. {:"1 dat
hdrmsk=. -. each hdrs e. each <PDefNames
Opts=. hdrmsk #each opts
Types=. (<'TYPE')&dictget &> opts
if. 0 = # 0 pick Types do.
  Types=. (<type) 0 } Types
end.
'DimData DimType'=. getdims dats;<type

Data=. DimData getdata &> dats

if. 0 = +/ # &> {."1 Data do.
  Data=. 0 # Data
end.

if. POLAR *. DimType=2 do.
  Data=. getpolar "1 Data
end.
ndx=. i.#Data
ind=. (Y2Axis & e. &> hdrs) i. 1
Y2Msk=. ndx >: ind
if. (1 e. Y2Msk) *. DimData = 3 do.
  signal 'Two Y axes are not supported for 3D data.'
end.
YAxes=. (ind > {.ndx), ind <: {:ndx
if. (1 e. type e. FrameTypes) +. {:YAxes do.
  FRAME=. 1
end.
'XRANGE YRANGE Y2RANGE ZRANGE'=. getdatarange (;Types);Data;Y2Msk;YAxes
({."1 def)=. {:"1 def
if. XLOG do.
  Data=. (log10 each 0 {"1 Data) 0 }"0 1 Data
  XINT=. log10 XINT
  XRANGE=. log10 XRANGE
end.
if. YLOG do.
  ndx=. I. -. Y2Msk
  Data=. (log10 each (<ndx;1) { Data) (<ndx;1) } Data
  YINT=. log10 YINT
  YRANGE=. log10 YRANGE
end.
if. Y2LOG do.
  ndx=. I. Y2Msk
  Data=. (log10 each (<ndx;1) { Data) (<ndx;1) } Data
  Y2INT=. log10 Y2INT
  Y2RANGE=. log10 Y2RANGE
end.
if. ZLOG do.
  Data=. (log10 each 2 {"1 Data) 2 }"0 1 Data
  ZINT=. log10 ZINT
  ZRANGE=. log10 ZRANGE
end.
AXES=. 3$AXES
LABELS=. 3$LABELS
GRIDS=. 3$GRIDS
TICS=. 3$TICS

if. Y2Msk do.
  AXES=. 0 (1)} AXES
  GRIDS=. 0 (1)} GRIDS
  TICS=. 0 (1)} TICS
end.

XTIC=. XTIC,(#XTIC)}._1 _1
YTIC=. YTIC,(#YTIC)}._1 _1
Y2TIC=. Y2TIC,(#Y2TIC)}._1 _1
ZTIC=. ZTIC,(#ZTIC)}._1 _1
". each PDefNames
)
getverbres=: 3 : 0
r=. i. 0 2
s=. ''
for_d. y do.
  v=. _1 pick d
  if. 0 = #v do.
    r=. r,d
  elseif. ifplotf v do.
    v=. plotsubd v
    s=. s, # &> v
    r=. r,({.d),.<"1 ;v
  elseif. do.
    r=. r,d
    s=. s,1
  end.
end.
r;s
)
makerule=: 3 : 0

for_p. Rule do.
  cmd=. {.p
  arg=. 1 pick p
  if. -. cmd e. PDdefs do.
    (cmd)=. arg
  else.
    arg=. <;._2 (deb arg),' '
    pos1=. makepos_xy 2 {. arg
    pos2=. makepos_xy _2 {. arg
    drawline iRULE;RULECOLOR;RULESIZE;pos1,pos2
  end.
end.
)
cocurrent 'jzplot'

bSub=: <'sub'
bEndSub=: <'endsub'
makesub=: 3 : 0
pcmd=. y
ndx=. ({."1 pcmd) i. bSub
if. ndx do.
  makesubdo ndx {. pcmd
  pcmd=. ndx }. pcmd
end.
if. #pcmd do.
  cmds=. {."1 pcmd
  msk=. 1, 0 = }: +/\ (bSub=cmds)-bEndSub=cmds
  msk=. firstones msk
  pcmd=. msk <;.1 pcmd
  for_p. pcmd do.
    makesubin >p
  end.
end.
)
makesubdo=: 3 : 0
pcmd=. y
if. -. ({. {. pcmd) e. PDcmds do.
  pcmd=. ('new';''), pcmd
end.
msk=. ({."1 pcmd) e. PDcmds
pcmd=. msk <;.1 pcmd
for_p. pcmd do.
  p=. > p
  'cmd arg'=. {. p
  if. #Mxywh do.
    if. 0 = # arg do.
      Sxywh=: Mndx { Mxywh
      Mndx=: (#Mxywh) | Mndx + 1
    end.
  end.
  if. cmd -: 'multi' do.
    makemulti p
  else.
    makenew p
  end.
end.
)
makesubin=: 3 : 0
pcmd=. y
if. bSub = {. {. pcmd do.

  val=. 1 pick {. pcmd
  pcmd=. }. pcmd
  pcmd=. (- bEndSub={:pcmd) }. pcmd
  if. ',' e. val do.
    ndx=. val i. ','
    val=. (0 ". ndx {. val) ; 0 ". (ndx + 1) }. val
    smat=. Sxywh makesubshape val
    sxywh=. {. smat
  else.
    if. 2 = # 0 ". val do.
      smat=. Sxywh makesubshape (0 ". val) # each 1
      sxywh=. {. smat
    else.
      smat=. ''
      sxywh=. Sxywh makepos_xywh val
      if. 1 e. 1 >: _2 {. sxywh do. return. end.
    end.
  end.
  pushsxywh smat;sxywh
  makesub pcmd
  popsxywh ''
else.
  makesub pcmd
end.
)
makesubshape=: 4 : 0
xy=. 2 {. x
wh=. _2 {. x
txy=. > { (scale01 1 pick y);scale01 |. 0 pick y
txy=. xy +"1 txy *"1 wh
bl=. _1 _1 }. txy
tr=. 1 1 }. txy
rec=. rndint bl ,"1 tr - bl
,/ |. 0 2 |: rec
)
maketext=: 3 : 0

for_p. Text do.
  cmd=. {.p
  arg=. 1 pick p
  if. -. cmd e. TextTypes do.
    (cmd)=. arg
  else.
    arg=. <;._2 (deb arg),' '
    pos=. makepos_xy 2 {. arg
    text=. towords 2 }. arg
    align=. TextTypes i. cmd
    font=. getfontid TEXTFONT
    if. Poutput e. iISI do.
      font=. getisifontid font
    elseif. Poutput e. iGTK do.
      font=. getgtkfontid font
    elseif. Poutput e. iANDROID do.
      font=. getgtkfontid font
    end.

    drawtext iTEXT;align;font;TEXTCOLOR;text;pos
  end.

end.
)
maketype=: 3 : 0

'y2 ndx opt type'=. y

defineoptions opt
definecolor''

if. #type do.
  DataNdx=: 0
  TYPE=: type
end.
if. y2 do.
  sety2vals''
end.
p=. (DimType=3) { 'plot_';'plot3d_'
fns=. p ,each TYPE
for_f. fns do.
  (>f)~ndx
end.
DataNdx=: DataNdx + # citemize (<ndx;1) pick Data

)
sety2vals=: 3 : 0
((<'Y') ,each AxisOut)=: ". each (<'Y2') ,each AxisOut
)
coclass 'jzplot'
j=. 'data endsub multi new rule sub text textc textr type use'

PDdefs=: ;: j
PDDefs=: ;: toupper j
j=. 'brushcolor end lines pen pencolor rect'
PDgd=: 'gd'&, each ;: j
PDGD=: 'GD'&, each ;: toupper j
PDshow=: ;: 'cairo canvas eps gtk isi android jpf pdf print show'
PDcopy=: ;: 'clip save get'
PDget=: ;: 'pdfr cairor canvasr'
PDcmds=: ;: 'multi new use'
boxcmd=: 3 : 0
if. L. y do. y return. end.
if. 2 = #$y do.
  y=. ,y,.';'
end.
y=. y,';'
b=. (y e. ';',LF) > ~:/\ y e. '"'
a: -.~ b (<@dlb) ;._2 y
)
getoptions=: 3 : 0
cmd=. boxcmd y
hdr=. tolower each head each cmd
if. 1 e. b=. hdr e. KEYWORDS do.
  new=. boxcmd @ ". @ toupper each b # cmd
  cmd=. <S:0 new (I. b) } y
  hdr=. tolower each head each cmd
end.
hdr,.(1 + # &> hdr) }.each cmd
)
pdreset=: 3 : 0
setplotdefaults 'plot'
if. #y do.
  PForm=: y
end.
PReset=: 1
pdcmdsave=: ''
pdcmdclip=: 0
pdcmdprint=: 0
EMPTY
)
pd=: 3 : 0

dat=. y

if. 0 = #dat do. return. end.

if. ischar dat do.
  pdcmd boxcmd dat return.
end.

if. isboxed dat do.
  if. 1 < #$dat do.
    dat=. pddefverb each <"1 dat
  elseif. ischar 0 pick dat do.
    pdcmd dat return.
  elseif. do.
    dat=. pddefverb dat
  end.
end.

if. -. PReset do. pdreset'' end.
PCmd=: PCmd,'data';<dat
EMPTY
)
pdcmd=: 3 : 0

cmd=. y
if. 0=#cmd do. EMPTY return. end.

'hdr cmd'=. pdcmdhdr cmd

len=. # hdr
cnt=. 1 + # &> hdr
if. len > ndx=. hdr i. <'reset' do.
  pdreset 6 }. ndx pick cmd
  pdcmd (ndx+1) }. cmd return.
end.
if. -. PReset do. pdreset'' end.
prm=. cnt }. each cmd
if. len = ndx=. <./ hdr i. PDshow,PDcopy,PDget do.
  PCmd=: PCmd, hdr ,. prm
else.
  PCmd=: PCmd, (ndx {. hdr) ,. ndx {. prm
  r=. ('pd_',ndx pick hdr)~ndx pick prm
  if. #r do. return. end.
  pdcmd (>:ndx) }. cmd
end.
EMPTY
)
pdcmdhdr=: 3 : 0
cmd=. y
hdr=. tolower each head each cmd
if. 1 e. b=. hdr e. KEYWORDS do.
  new=. boxcmd @ ". @ toupper each b # cmd
  cmd=. <S:0 new (I. b) } y
  hdr=. tolower each head each cmd
end.

hdr;<cmd
)
pddefverb=: 3 : 0
v=. _1 pick y
if. 2 ~: 3!:0 v do. y return. end.
v=. < caller plotdefverbm`plotdefverbd@.(3=#y) v
v _1 } y
)
pd_android=: android_show
pd_eps=: eps_show
pd_canvas=: canvas_show
pd_canvasr=: canvas_get
pd_cairo=: cairo_show
pd_cairor=: cairo_get
pd_gtk=: gtk_show
pd_isi=: isi_show
pd_pdf=: pdf_show
pd_pdfr=: pdf_get
pd_jpf=: pdf_jpf

pd_clip=: 3 : 0
if. Poutput e. _1,iGTK do.
  gtk_clip y
else.
  isi_clip y
end.
)

pd_print=: 3 : 0
if. Poutput e. _1,iGTK do.
  gtk_print y
else.
  isi_print y
end.
)

pd_save=: 3 : 0
if. Poutput e. _1,iGTK do.
  if. IFGTK < ifjwplot'' do.
    pdcmdsave=: y return.
  end.
  gtk_save y
else.
  isi_save y
end.
)

pd_get=: 3 : 0
if. Poutput e. _1,iGTK do.
  gtk_get y
else.
  isi_get y
end.
)
pd_show=: 3 : 0
ndx=. ({."1 PCmd) i. <'output'
if. ndx < #PCmd do.
  OUTPUT=: 1 pick ndx{PCmd
end.
out=. dlb OUTPUT
fn=. 'pd_', tolower ' ' taketo out
arg=. ' ' takeafter out
fn~arg
EMPTY
)

coclass 'jzplot'
ANDROID_DEFSIZE=: 400 200
ANDROID_DEFFILE=: jpath '~temp/plot'
ANDROID_PENSCALE=: 0.4
fext=: 4 : 0
f=. deb y
f, (-. x -: (-#x) {. f) # x
)
gettemp=: 3 : 0
p=. jpath '~temp/'
d=. 1!:0 p,'*.',y
a=. 0, {.@:(0&".)@> _4 }. each {."1 d
a=. ": {. (i. >: #a) -. a
p,a,'.',y
)
andfontdesc=: 3 : 0
'ind fst siz ang und'=. y
'ita bld'=. 2 2 #: fst
sty=. (bld#' bold'),(ita#' italic'),und#' underline'
if. ' ' e. nam=. ind pick ANDFONTNAMES do. nam=. '"', nam, '"' end.
nam,sty,' ',":siz
)

android_getsize=: 3 : 0
if. -. wdishandle :: 0: ": PFormhwnd do. '' return. end.
wd 'psel ', ":PFormhwnd
s=. wd :: 0: 'qchildxywhx ',PId
if. s -: 0 do. '' return. end.
2 3 { 0 ". s
)
output_parms=: 4 : 0
'size file'=. x
if. #y do.
  prm=. qchop y
  select. #prm
  case. 1 do.
    file=. 0 pick prm
  case. 2 do.
    size=. 0 ".&> prm
  case. 3 do.
    file=. 0 pick prm
    size=. 0 ". &> _2 {. prm
    if. 0 e. size do.
      size=. 0 ". &> 2 {. prm
      file=. 2 pick prm
    end.
  end.
else.
  if. #sz=. android_getsize'' do.
    size=. sz
  end.
end.
size;file
)
android_clip=: 3 : 0
if. -. IFWIN do.
  info 'Save plot to clipboard is only available in Windows'
  return.
end.
f=. gettemp 'emf'
android_emf dquote f
wd 'clipcopyx enhmetafile ',dquote f
1!:55 <f
)
android_gpcount=: ,"1~ 1 + [: {: 1 , $
android_gpcut=: 3 : 0
r=. ''
while. #y do.
  n=. {. y
  if. n=0 do.
    info 'zero length segment at: ',":#;r
    r
    return.
  end.
  r=. r, < n {. y
  y=. n }. y
end.
r
)
android_gpbuf=: 3 : 0
assert. 2 > #$y
buf=: buf,y
)
android_gpapply=: 3 : 0
glcmds buf
buf=: $0
)
android_gpflip=: flipxy @ rndint
android_gpfliplast=: 3 : 0
(<android_gpflip _1 pick y) _1 } y
)
android_gpinit=: 3 : 0
buf=: bufdef=: $0
r=. ''
r=. r,3 2003 1
r=. r,3 2071 1
android_gpapply''
)
android_gpbrushnull=: 3 : '2 2005'
android_gppens=: 4 : 0
y=. rndint y
5 2032,"1 x,"1 [ 4 2022,"1 y,.5*y=0
)
android_gppen=: 4 : 0
y=. rndint y
5 2032,(,x),4 2022,y,5*y=0
)
android_gppens1=: 3 : 0
5 2032,"1 y,"1 [ 4 2022 1 0
)
android_gppen1=: 3 : 0
5 2032,(,y),4 2022 1 0
)
android_gppenbrush1=: 3 : 0
5 2032,(,y),4 2022 1 0 2 2004
)
android_gppixel=: 3 : 0
's t f e c p'=. y
p=. android_gpcount 2024 ,"1 android_gpflip p
if. is1color e do.
  android_gpbuf e android_gppen 1
  android_gpbuf ,p
else.
  rws=. #p
  e=. rws $ citemize e
  pen=. e android_gppens 1
  android_gpbuf ,pen ,. p
end.
)
android_gppline=: 4 : 0
's t f e c p'=. y
if. (is1color e) *. 1 = #s do.
  android_gpbuf (,e) android_gppen s
  android_gpbuf ,android_gpcount x,"1 p
else.
  rws=. #p
  e=. rws $ citemize e
  s=. rws $ s
  pen=. e android_gppens s
  android_gpbuf ,pen ,. android_gpcount x,"1 p
end.
)
android_gppshape=: 4 : 0
'v s f e c p'=. y

if. v=0 do. e=. c end.

if. is1color e do.
  android_gpbuf e android_gppen v
  if. isempty c do.
    android_gpbuf android_gpbrushnull''
    android_gpbuf ,android_gpcount x,"1 p
  elseif. is1color c do.
    android_gpbuf 5 2032,(,c),2 2004
    android_gpbuf ,android_gpcount x,"1 p
  elseif. do.
    c=. (#p) $ c
    clr=. 5 2032 ,"1 c ,"1 [ 2 2004
    android_gpbuf , clr ,. android_gpcount x,"1 p
  end.
else.
  e=. (#p) $ e
  e=. e android_gppens v
  if. isempty c do.
    android_gpbuf android_gpbrushnull''
    android_gpbuf , e ,. android_gpcount x,"1 p
  elseif. is1color c do.
    android_gpbuf 5 2032,(,c),2 2004
    android_gpbuf , e ,. android_gpcount x,"1 p
  elseif. do.
    c=. (#p) $ c
    clr=. 5 2032 ,"1 c ,"1 [ 2 2004
    android_gpbuf , e ,. clr ,. android_gpcount x,"1 p
  end.

end.
)
androidarc=: 3 : '2001 android_gppline android_gpfliplast y'
androidline=: 3 : '2015 android_gppline android_gpfliplast y'
androidpie=: 3 : '2023 android_gppshape android_gpfliplast y'
androidpoly=: 3 : '2029 android_gppshape android_gpfliplast y'
androidcircle=: 3 : 0
p=. _1 pick y
ctr=. android_gpflip 0 1 {"1 p
rad=. rndint 2 {"1 p
xy=. ctr - rad
wh=. +: rad ,. rad
p=. xy ,. wh
2008 android_gppshape (<p) _1 } y
)
androiddot=: 3 : 0
'v s f e c p'=. y
select. v
case. 1 do.
  android_gppixel y
case. 2 do.
  p=. android_gpflip p
  p=. (p-1) ,"1 [ 2 2
  dat=. 1;0;0;e;e;p
  2031 android_gppshape dat
case. 3 do.
  h=. (p-"1[1 0) ,. p+"1[2 0
  v=. (p-"1[0 1) ,. p+"1[0 2
  androidline 1;0;0;e;e;h,v
case. do.
  o=. >. -: v
  p=. p ,"1 v,.v
  androidcircle 1;0;0;e;e;p
end.
)
androidfxywh=: 3 : 0
p=. _1 pick y
if. #p do.
  'x y w h'=. p
  xy=. _1 + <. x,Ch-y+h
  wh=. 2 + >. w,h
  android_gpbuf 6 2078,xy,wh
else.
  android_gpbuf 2 2079
end.
)
androidmarker=: 3 : 0
's m f e c p'=. y
p=. android_gpflip p
android_gpbuf android_gppenbrush1 e
s ('androidmark_',m)~ p
)
androidpie=: 3 : 0
p=. _1 pick y
ctr=. android_gpflip 0 1 {"1 p
rad=. 2 {"1 p
ang=. 3 4 {"1 p
xy=. ctr - rad
wh=. +: rad ,. rad
tx=. ({."1 ctr) + rad * sind ang
ty=. ({:"1 ctr) + rad * cosd ang
p=. rndint xy ,. wh ,. ,"2 tx ,"0 ty
2023 android_gppshape (<p) _1 } y
)
androidpline=: 3 : 0
's t f e c p'=. y
if. *./ t = 0 do.
  androidline y return.
end.
p=. android_gpflip p
t=. t { PENPATTERN
if. (is1color e) *. 1 = #s do.
  android_gpbuf 5 2032,(,e),4 2022,s,0
  pos=. t linepattern"0 1 p
  android_gpbuf ,android_gpcount 2015,"1 pos
else.
  rws=. #p
  e=. rws $ citemize e
  s=. rws $ s
  t=. rws $ t
  pen=. e android_gppens s
  for_i. i.#p do.
    android_gpbuf i{pen
    pos=. (i{t) linepattern i{p
    android_gpbuf ,android_gpcount 2015,"1 pos
  end.
end.
)
androidrect=: 3 : 0
p=. boxrs2wh^:1 android_gpflip _1 pick y
if. IFJAVA do.
  if. 0 = 1 pick y do.
    p=. 1 1 _2 _2 +"1 p
  end.
end.
y=. (<p) _1 } y
2031 android_gppshape y
)
androidtext=: 3 : 0
't f a e c p'=. y

f=. andfontdesc^:(0={.0#f) f
p=. android_gpflip p
t=. text2utf8 each boxopen t
if. a do.
  glfont f
  off=. <. -: a * {."1 wh=. glqextent &> t
  if. 1 e. 'angle900' E. f do.
    p=. p +"1 [ 0,.off
  elseif. 1 e. 'angle2700' E. f do.
    p=. p -"1 [ 0,.off
  elseif. do.
    p=. p -"1 off,. - {:"1 wh
  end.
end.
'face size style degree'=. parseFontSpec f
android_gpbuf android_gpcount 2312,(<.size*10),style,(<.degree*10),alfndx,face
if. is1color e do.
  android_gpbuf 5 2032,(,e),2 2040
  if. rank01 p do.
    android_gpbuf android_gpcount 2056,p
    android_gpbuf android_gpcount 2038,alfndx,>t
  else.
    t=. android_gpcount each 2038 ,each alfndx each t
    t=. (<"1 android_gpcount 2056 ,"1 p) ,each t
    android_gpbuf ; t
  end.
else.
  t=. android_gpcount each 2038 ,each alfndx each t
  t=. t ,each <"1 android_gpcount 2056 ,"1 p
  t=. (<"1 (5 2032 ,"1 e) ,"1 [ 2 2040) ,each t
  android_gpbuf ; t
end.

)
parseFontname=: 3 : 0
font=. ' ',y
b=. (font=' ') > ~:/\font='"'
a: -.~ b <@(-.&'"');._1 font
)
FontStyle=: ;:'regular bold italic underline strikeout'

parseFontSpec=: 3 : 0
'ns styleangle'=. 2 split parseFontname y
'face size'=. ns
size=. 12". size
style=. FontStyle i. tolower each styleangle
style=. <.+/2^<:(style ((> 0) *. <) #FontStyle) # style
if. 1 e. an=. ('angle'-:5&{.)&> styleangle do.
  degree=. 10%~ 0". 5}.>(an i. 1){styleangle
else.
  degree=. 0
end.
face;size;style;degree
)
androidmark_circle=: 4 : 0
s=. rndint x * 3
p=. (y - s) ,"1 >: +: s,s
android_gpbuf ,android_gpcount 2008 ,"1 p
)
androidmark_diamond=: 4 : 0
s=. rndint x * 4
'x y'=. |: y
p=. (x-s),.y,.x,.(y+s),.(x+s),.y,.x,.y-s
android_gpbuf ,android_gpcount 2029 ,"1 p
)
androidmark_line=: 4 : 0
'x y'=. , y
p=. >.(x--:KeyLen),(y--:KeyPen),<:KeyLen,KeyPen
android_gpbuf ,android_gpcount 2031 ,p
)
androidmark_plus=: 4 : 0
s=. rndint 4 1 * x
p=. (y -"1 s) ,"1 +: s
s=. |. s
p=. p , (y -"1 s) ,"1 +: s
android_gpbuf ,android_gpcount 2031 ,"1 p
)
androidmark_square=: 4 : 0
s=. rndint x * 3
p=. (y - s) ,"1 +: s,s
android_gpbuf ,android_gpcount 2031 ,"1 p
)
androidmark_times=: 4 : 0
if. x = 1 do.
  p=. (y - 3) ,. y + 4
  q=. (y - "1 [ 3 _3) ,. y +"1 [ 4 _4
  p=. p, (p +"1 [ 0 1 _1 0), p + "1 [ 1 0 0 _1
  q=. q, (q +"1 [ 0 _1 _1 0), q +"1 [ 1 0 0 1
  android_gpbuf ,android_gpcount 2015 ,"1 p,q
else.
  s=. rndint _1 + 3 * x
  n=. rndint 2 * x
  p=. (y - s) ,. y + s
  q=. (y - "1 s * 1 _1) ,. y +"1 s * 1 _1
  android_gpbuf 4 2022,n,0
  android_gpbuf ,android_gpcount 2015 ,"1 p,q
end.
)
androidmark_triangle=: 4 : 0
s=. rndint 2 * x
t=. rndint 4 * x
'x y'=. |: y
p=. rndint (x-t),.(y+s),.(x+t),.(y+s),.x,.y-t
android_gpbuf ,android_gpcount 2029 ,"1 p
)
PRINTP=: ''
android_print=: 3 : 0
if. #PRINTP do. wd 'psel ',PRINTP,';pclose' end.
wd 'pc print;cc g canvas'
PRINTP=: wd 'qhwndp'
PRINTED=: 0
opt=. '"" "" "" orientation ',":ORIENTATION
glprint opt
)
print_g_print=: 3 : 0
'page pass'=. ". sysdata
select. pass
case. _1 do.
  PRINTP=: PRINTPXYWH=: ''
  wd 'pclose'
case. 0 do.
  glprintmore -.PRINTED
case. do.
  'Cw Ch'=: glqprintwh''
  android_paintit android_printwin''
  PRINTED=: 1
end.
)
android_printwin=: 3 : 0
'pw ph mw mh'=. 4 {. glqprintpaper''
mrg=. 0 >. PRINTMARGIN - mw,(ph - mh + Ch),(pw - mw + Cw),mh
xywh=. (0 0,Cw,Ch) shrinkrect mrg
if. 0 = #PRINTWINDOW do.
  xywh
else.
  if. 4 ~: #PRINTWINDOW do.
    info 'PRINTWINDOW should be of form: x y wh' return.
  end.
  'x y w h'=. xywh
  'px py pw ph'=. PRINTWINDOW%1000
  fx=. x + px * w
  fy=. y + py * h
  fw=. (x-fx) + pw * w
  fh=. (y-fy) + ph * h
  fx,fy,fw,fh
end.
)
android_bmp=: 3 : 0
if. #y do.
  arg=. qchop y
  num=. __ ". &.> arg
  msk=. __ e. &> num
  file=. > {. msk # arg
  wh=. >(-.msk) # num
  if. -. (#wh) e. 0 2 do.
    info 'invalid [w h] parameter in save bmp' return.
  end.
else.
  wh=. file=. ''
end.
file=. file,(0=#file)#android_DEFFILE
file=. jpath '.bmp' fext file
if. (2 = #wh) > wh -: Pw,Ph do.
  a=. cocreate''
  coinsert__a (,copath) coname''
  bmp=. android_getbmpwh__a wh
  coerase a
else.
  bmp=. android_getbmp''
end.
bmp writebmp file
)
android_def=: 4 : 0
type=. x
file=. jpath ('.',type) fext (;qchop y),(0=#y) # android_DEFFILE
(android_getrgb'') writeimg file
)
android_defstr=: 4 : 0
type=. x
(android_getrgb'') putimg type
)
android_emf=: 3 : 0
file=. jpath '.emf' fext (;qchop y),(0=#y) # android_DEFFILE
wd 'psel ',": PFormhwnd
glsel PId
glfile file
glemfopen''
android_paint''
glemfclose''
)
android_getbmp=: 3 : 0
wd 'psel ',": PFormhwnd
glsel PId
box=. 0 ". wd 'qchildxywhx ',PId
res=. glqpixels box
(3 2 { box) $ res
)
android_getbmpwh=: 3 : 0
wd 'pc a owner;xywh 0 0 240 200;cc g canvas rightmove bottommove;pas 0 0'
PFormhwnd=: 0 ". wd 'qhwndp'
PId=: 'g'
wd 'setxywhx g 0 0 ',":y
wd 'pshow'
android_paintx''
glpaint''
res=. android_getbmp''
wd 'pclose'
res
)
android_getrgb=: 3 : 0
wd 'psel ',": PFormhwnd
glsel PId
box=. 0 ". wd 'qchildxywhx ',PId
(3 2 { box) $ 256 256 256 #: glqpixels box
)
android_jpg=: 3 : 0
file=. ''
qual=. 100
if. #y do.
  arg=. qchop y
  num=. __ ". &.> arg
  msk=. +./ &> num = &.> __
  file=. > {. msk # arg
  qual=. <. {. (>(-.msk) # num),qual
end.
file=. jpath '.jpg' fext file,(0=#file) # android_DEFFILE
rgb=. android_getrgb''
rgb writeimg file
)
android_png=: 3 : 0
file=. ''
comp=. 9
if. #y do.
  arg=. qchop y
  num=. __ ". &.> arg
  msk=. +./ &> num = &.> __
  file=. > {. msk # arg
  comp=. <. {. (>(-.msk) # num),comp
end.
file=. jpath '.png' fext file,(0=#file) # android_DEFFILE
rgb=. android_getrgb''
rgb writeimg file
)
android_save=: 3 : 0
if. Poutput ~: iANDROID do.
  msg=. 'First display an canvas Plot.'
  info msg return.
end.
if. 0=#y do.
  android_clip'' return.
end.
type=. tolower firstword y
if. (<type) e. ;: 'gif jpg png tif gifr jpgr pngr tifr' do.
  af=. jpath '~addons/media/platimg/platimg.ijs'
  if. -. flexist af do.
    info 'Save to ',type,' requires the platimg addon.' return.
  end.
  require af
end.
('android_',type)~ (1+#type) }. y
)

android_get=: 3 : 0
if. #y do.
  type=. tolower firstword y
  if. (<type) e. ;: 'gif jpg png tif' do.
    y=. type,'r ', (#type)}. y
  end.
end.
android_save y
)
android_gif=: 'gif' & android_def
android_tif=: 'tif' & android_def
android_pngr=: 'png' & android_defstr
android_jpgr=: 'jpg' & android_defstr
android_gifr=: 'gif' & android_defstr
android_tifr=: 'tif' & android_defstr
android_show=: 3 : 0
popen_android''
if. ifjwplot'' do.
  (PForm,'_',PId,'_paint')=: android_paint
end.
if. PShow=0 do.
  PShow=: 1
end.

if. -.ifjwplot'' do.
  android_paint''
  glpaint''
end.
)
android_paint=: 3 : 0
selectpid''
'Cw Ch'=: glqwh''
android_paintit 0 0,Cw,Ch
0
)
android_paintit=: 3 : 0
android_gpinit''
make iANDROID;y
ids=. 1 {"1 Plot
fns=. 'android'&, each ids
dat=. 3 }."1 Plot
for_d. dat do.
  (>d_index{fns)~d
end.
android_gpapply''
)

coclass 'jzplot'
CAIRO_DEFSHOW=: 'jijx'
CAIRO_DEFSIZE=: 400 200
CAIRO_DEFFILE=: jpath '~temp/plot.png'
CAIRO_PENSCALE=: 0.4

gtkpl=: gtkcr=: 0
cairo_getparms=: 3 : 0
(CAIRO_DEFSIZE;CAIRO_DEFFILE) output_parms y
)
cairo_write=: 3 : 0
'file ctx'=. y
assert. 0~:gtkcr
while. 0 ~: cairo_surface_write_to_png_jgtk_ (cairo_get_target_jgtk_ gtkcr) ; file do.

  msg=. 'Unable to write to file: ',file,LF,LF
  if. #d=. 1!:0 file do.
    msg=. msg, 'If the file is open in a viewer, close the file and try again.'
    if. 1 query msg do. return. end.
  else.
    info msg,'The file name is invalid.' return. end.
end.
if. (VISIBLE > IFJHS) do.
  browse_j_ file
end.
EMPTY
)
cairo_color=: 4 : 0
assert. 0~:gtkcr
assert. 3=#,y
cairo_set_source_rgb_jgtk_ gtkcr ; ;/ ,y%256
EMPTY
)
cairo_makerect=: 3 : 0
'x y r s'=. y
cairo_drawline (_2 [\ flipxy x,y,x,s,r,s,r,y,x,y)
EMPTY
)
cairo_drawline=: 3 : 0
assert. 0~:gtkcr
assert. 1<$$y
cairo_move_to_jgtk_ gtkcr ; ;/ {.y
for_p. }.y do.
  cairo_line_to_jgtk_ gtkcr ; ;/ p
end.
EMPTY
)
cairo_makelines=: 3 : 0
len=. -: {: $ y
if. len = 0 do. i.0 0 return. end.
if. 2 > #$y do.
  cairo_drawline _2 [\ flipxy y
else.
  cairo_drawline "2 (_2 [\"1 flipxy y)
end.
EMPTY
)
cairo_pens=: 4 : 0
assert. 0 [ 'cairo_pens not implemented'
(0 cairo_color x) ,"1 'ctx.lineWidth="',"1 (":1>.CAIRO_PENSCALE*y),"1 '";'
EMPTY
)
cairo_pen=: 4 : 0
assert. 0~:gtkcr
0 cairo_color x
cairo_set_line_width_jgtk_ gtkcr ; (1>.CAIRO_PENSCALE*y)
EMPTY
)
cairo_lines=: 3 : 0
(cairo_stroke_jgtk_ bind gtkcr)@cairo_makelines"1 y
EMPTY
)
cairo_text=: 3 : 0
'fnt txt pos align rot und'=. y
pos=. citemize pos
txt=. ,each boxxopen txt
txt=. utf8 each txt
if. und +. align e. iCENTER, iRIGHT do.
  len=. fnt pgetstringlen txt
end.
if. 1=#txt do. txt=. (#pos)#{.txt end.

select. rot
case. 0 do.
  select. align
  case. iCENTER do.
    pos=. pos -"1 (-:len),.0
  case. iRIGHT do.
    pos=. pos -"1 len,.0
  end.
  for_i. i.#pos do.
    cairo_move_to_jgtk_ gtkcr ; <"0 flipxy i{pos
    pango_layout_set_text_jgtk_ gtkpl;(,>i{txt);#>i{txt
    pango_cairo_show_layout_jgtk_ gtkcr, gtkpl
  end.
case. 1 do.
  select. align
  case. iCENTER do.
    pos=. pos -"1 [ 0,.-:len
  case. iRIGHT do.
    pos=. pos -"1 [ 0,.len
  end.
  for_i. i.#pos do.
    cairo_save_jgtk_ gtkcr
    cairo_move_to_jgtk_ gtkcr ; <"0 flipxy i{pos
    cairo_rotate_jgtk_ gtkcr ; - 0.5p1
    pango_cairo_update_layout_jgtk_ gtkcr, gtkpl
    pango_layout_set_text_jgtk_ gtkpl;(,>i{txt);#>i{txt
    pango_cairo_show_layout_jgtk_ gtkcr, gtkpl
    cairo_restore_jgtk_ gtkcr
  end.
case. 2 do.
  select. align
  case. iCENTER do.
    pos=. pos +"1 [ 0,.-:len
  case. iRIGHT do.
    pos=. pos +"1 [ 0,.len
  end.
  for_i. i.#pos do.
    cairo_save_jgtk_ gtkcr
    cairo_move_to_jgtk_ gtkcr ; <"0 flipxy i{pos
    cairo_rotate_jgtk_ gtkcr ; 0.5p1
    pango_cairo_update_layout_jgtk_ gtkcr, gtkpl
    pango_layout_set_text_jgtk_ gtkpl;(,>i{txt);#>i{txt
    pango_cairo_show_layout_jgtk_ gtkcr, gtkpl
    cairo_restore_jgtk_ gtkcr
  end.
end.

if. -. und do. EMPTY return. end.
pos=. citemize pos
len=. , len

'off lwd'=. getunderline fnt
select. rot
case. 0 do.
  bgn=. 0 >. pos -"1 [ 0,.-off
  end=. bgn + len,.0
case. 1 do.
  bgn=. 0 >. pos -"1 off,.0
  end=. bgn + 0,.len
case. 2 do.
  bgn=. 0 >. pos +"1 off,.0
  end=. bgn - 0,.len
end.

for_p. bgn,.end do.
  cairo_makelines p
  cairo_stroke_jgtk_ gtkcr
end.

EMPTY
)
cairocircle=: 3 : 0
'v s f e c p'=. y
if. isempty c do.
  if. is1color e do.
    e cairo_pen v
    for_i. i.#p do.
      cairo_new_sub_path_jgtk_ gtkcr
      cairo_arc_jgtk_ gtkcr ; ;/ (flipxy 2{.i{p) , (2{i{p), 0, 2p1
      cairo_stroke_jgtk_ gtkcr
    end.
  else.
    for_i. i.#p do.
      cairo_new_sub_path_jgtk_ gtkcr
      cairo_arc_jgtk_ gtkcr ; ;/ (flipxy 2{.i{p) , (2{i{p), 0, 2p1
      (i{e) cairo_pen (i{v)
      cairo_stroke_jgtk_ gtkcr
    end.
  end.
else.
  p=. citemize p
  c=. p cmatch c
  e=. p cmatch e
  v=. p cmatch v
  for_i. i.#p do.
    cairo_new_sub_path_jgtk_ gtkcr
    cairo_arc_jgtk_ gtkcr ; ;/ (flipxy 2{.i{p) , (2{i{p), 0, 2p1
    (i{e) cairo_pen (i{v)
    cairo_stroke_preserve_jgtk_ gtkcr
    1 cairo_color i{c
    cairo_fill_jgtk_ gtkcr
  end.
end.
)
cairodot=: 3 : 0
'v s f e c p'=. y
p=. citemize p
v=. v * CAIRO_PENSCALE
if. is1color e do.
  1 cairo_color e
  for_i. i.#p do.
    cairo_new_sub_path_jgtk_ gtkcr
    cairo_arc_jgtk_ gtkcr ; ;/ (flipxy i{p) , v, 0, 2p1
    cairo_fill_jgtk_ gtkcr
  end.
else.
  e=. p cmatch e
  for_i. i.#p do.
    1 cairo_color i{e
    cairo_new_sub_path_jgtk_ gtkcr
    cairo_arc_jgtk_ gtkcr ; ;/ (flipxy i{p) , v, 0, 2p1
    cairo_fill_jgtk_ gtkcr
  end.
end.
)
cairofxywh=: 3 : 0
''return.
p=. _1 pick y
if. #p do.
  CLIP=: >: CLIP
  'x y w h'=. p
  rect=. cairo_makerect x,y,(x+w),y+h
  pbuf 'gsave ',rect,' clip newpath'
else.
  if. CLIP do.
    CLIP=: <: CLIP
    pbuf 'grestore'
  end.
end.
)
cairoline=: 3 : 0
'v s f e c p'=. y
if. (is1color e) *. 1 = #s do.
  pbuf e cairo_pen v
  pbuf cairo_lines p
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  for_i. i. rws do.
    pbuf (i{e) cairo_pen i{v
    pbuf cairo_lines i{p
  end.
end.
)
cairomarker=: 3 : 0
('cairomark_',1 pick y)~ y
)
cairopie=: 3 : 0
'v s f e c p'=. y
pen=. e cairo_pen v
p=. citemize p
ctr=. 0 1 {"1 p
rad=. 2 {"1 p
ang=. 360 %~ 2p1 * 90 - 3 4 {"1 p
clr=. cmatch c
for_i. i.#p do.
  cairo_move_to_jgtk_ gtkcr ; ;/ (flipxy i{ ctr)
  cairo_arc_negative_jgtk_ gtkcr ; ;/ (flipxy i{ ctr) , (i{rad), (i{ang)
  cairo_close_path_jgtk_ gtkcr
  cairo_stroke_preserve_jgtk_ gtkcr
  1 cairo_color i{clr
  cairo_fill_jgtk_ gtkcr
end.
)
cairopline=: 3 : 0
'v s f e c p'=. y
if. *./ s = 0 do.
  cairoline y return.
end.
s=. s { PENPATTERN
if. (is1color e) *. 1 = #v do.
  pos=. s linepattern"0 1 p
  cairoline (<pos) _1 } y
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  s=. rws $ s
  for_i. i.#p do.
    (i{e) cairo_pen i{v
    pos=. (i{s) linepattern i{p
    cairoline (i{v);0;0;(i{e);0;pos
  end.
end.
)
cairopoly=: 3 : 0
'v s f e c p'=. y
p=. citemize p
if. v=0 do. e=. c end.
c=. p cmatch c
e=. p cmatch e
if. +/v do.
  v=. p cmatch v
  for_i. i.#p do.
    cairo_makelines i{p
    cairo_close_path_jgtk_ gtkcr
    (i{e) cairo_pen i{v
    cairo_stroke_preserve_jgtk_ gtkcr
    1 cairo_color i{c
    cairo_fill_jgtk_ gtkcr
  end.
else.
  for_i. i.#p do.
    cairo_makelines i{p
    cairo_close_path_jgtk_ gtkcr
    1 cairo_color i{c
    cairo_stroke_preserve_jgtk_ gtkcr
    cairo_fill_jgtk_ gtkcr
  end.
end.
)
cairorect=: 3 : 0
assert. 0~:gtkcr
'v s f e c p'=. y
p=. citemize p
if. v=0 do. e=. c end.
c=. p cmatch c
e=. p cmatch e
if. +/v do.
  v=. p cmatch v
  for_i. i.#p do.
    cairo_makerect i{p
    (i{e) cairo_pen i{v
    cairo_stroke_preserve_jgtk_ gtkcr
    1 cairo_color i{c
    cairo_fill_jgtk_ gtkcr
  end.
else.
  for_i. i.#p do.
    cairo_makerect i{p
    1 cairo_color i{c
    cairo_fill_jgtk_ gtkcr
  end.
end.
)
cairotext=: 3 : 0
't f a e c p'=. y
'fnx fst fsz fan und'=. f
rot=. 3 | 0 90 270 i. fan
asc=. _0.2 * pgetascender f
fnm=. getfntname fnx,fst
bold=. italic=. 0
if. (1 e. '-Oblique' E. fnm)+.(1 e. '-Bold' E. fnm)+.(1 e. '-Italic' E. fnm) do.
  bold=. (1 e. 'Bold' E. fnm)
  italic=. ((1 e. 'Oblique' E. fnm)+.(1 e. 'Italic' E. fnm))
  fnm=. ({.~ i:&'-') fnm
end.

gtkfontangle=: <.fan*10
gtkunderline=: Underline
fnt=. pango_font_description_from_string_jgtk_ <fnm
if. bold do. pango_font_description_set_weight_jgtk_ fnt, PANGO_WEIGHT_BOLD_jgtk_ end.
if. italic do. pango_font_description_set_style_jgtk_ fnt, PANGO_STYLE_ITALIC_jgtk_ end.
pango_font_description_set_size_jgtk_ fnt, <.PANGO_SCALE_jgtk_ * getplotfontsize f
pango_layout_set_font_description_jgtk_ gtkpl,fnt
pango_font_description_free_jgtk_ fnt
select. rot
case. 0 do. p=. 0 >. p -"1 [ 0, asc
case. 1 do. p=. p +"1 asc, 0
case. 2 do. p=. p -"1 asc, 0
end.
if. is1color e do.
  1 cairo_color e
  for_i. i.#p do.
    cairo_text f;t;p;a;rot;und
  end.
else.
  for_i. i.#e do.
    1 cairo_color i{e
    cairo_text f;(i{t);(i{p);a;rot;und
  end.
end.
)
cairomark_circle=: 3 : 0
's m f e c p'=. y
p=. citemize p
v=. 8 * s * CAIRO_PENSCALE
1 cairo_color e
for_i. i.#p do.
  cairo_new_sub_path_jgtk_ gtkcr
  cairo_arc_jgtk_ gtkcr ; ;/ (flipxy i{p) , v, 0, 2p1
  cairo_fill_jgtk_ gtkcr
end.
)
cairomark_diamond=: 3 : 0
's m f e c p'=. y
p=. 8 $"1 citemize p
d=. (3.5 * s) * _1 0 0 1 1 0 0 _1
p=. p +"1 d
for_i. i.#p do.
  cairo_makelines i{p
  cairo_close_path_jgtk_ gtkcr
  1 cairo_color e
  cairo_fill_jgtk_ gtkcr
end.
)
cairomark_line=: 3 : 0
's m f e c p'=. y
p=. ,p
s=. -:KeyLen,KeyPen
p=. (p - s) , p + s
cairo_makerect p
cairo_close_path_jgtk_ gtkcr
1 cairo_color e
cairo_fill_jgtk_ gtkcr
)
cairomark_plus=: 3 : 0
's m f e c p'=. y
s=. s * 4
t=. s, 0
e cairo_pen s
p=. citemize p
d=. (p -"1 t) ,. p +"1 t
t=. |. t
d=. d, (p -"1 t) ,. p +"1 t
cairo_lines d
)
cairomark_square=: 3 : 0
's m f e c p'=. y
p=. citemize p
s=. 3 * s
p=. (p - s) ,"1 p + s
for_i. i.#p do.
  cairo_makerect i{p
  cairo_close_path_jgtk_ gtkcr
  1 cairo_color e
  cairo_fill_jgtk_ gtkcr
end.
)
cairomark_times=: 3 : 0
's m f e c p'=. y
e cairo_pen 4 * s
t=. _1 + s * 3
r=. (p - t) ,. p + t
s=. (p +"1 t * 1 _1) ,. p +"1 t * _1 1
cairo_lines r,s
)
cairomark_triangle=: 3 : 0
's m f e c p'=. y
p=. 6 $"1 citemize p
d=. (4 * s) * , (sin,.cos) 2p1 * 0 1 2 % 3
p=. p +"1 d
for_i. i.#p do.
  cairo_makelines i{p
  cairo_close_path_jgtk_ gtkcr
  1 cairo_color e
  cairo_fill_jgtk_ gtkcr
end.
)
JSESC0=: LF,CR,TAB,FF,(8{a.),'\''"'
JSESC1=: 'nrtfb\''"'
jsesc=: 3 : 0
txt=. y
msk=. txt e. JSESC0
if. 1 e. msk do.
  ndx=. , ((I. msk) + i. +/ msk) +/ 0 1
  new=. ,'\',.JSESC1 {~ JSESC0 i. msk#txt
  txt=. new ndx } (1 + msk) # txt
end.

txt
)
cairo_get=: 3 : 0
'size file ctx'=. 3{. cairo_getparms y
res=. cairo_make size;file;ctx
)
cairo_show=: 3 : 0
'size file ctx'=. 3{. cairo_getparms y
res=. cairo_make size;file;ctx
cairo_write file;ctx
unrefcairo ''
if. IFJHS do. plotcairo__'' end.
i.0 0
)
cairo_make=: 3 : 0
'size file ctx'=. y
make iCAIRO;0 0,size
fns=. 'cairo'&, each 1 {"1 Plot
dat=. 3 }."1 Plot
buf=: ''
'Cw Ch'=: size
CLIP=: 0
initcairo size
for_d. dat do.
  (>d_index{fns)~d
end.
EMPTY
)

initcairo=: 3 : 0
if. 0~:gtkpl do. gtkpl=: 0 [ g_object_unref_jgtk_ gtkpl end.
if. 0~:gtkcr do. gtkcr=: 0 [ cairo_destroy_jgtk_ gtkcr end.
gtkcr=: cairo_create_jgtk_ surface=. cairo_image_surface_create_jgtk_ CAIRO_FORMAT_RGB24_jgtk_,>.y
cairo_surface_destroy_jgtk_ surface
gtkpl=: pango_cairo_create_layout_jgtk_ gtkcr
cairo_set_source_rgb_jgtk_ gtkcr ; 1 ; 1 ; 1
cairo_rectangle_jgtk_ gtkcr ; 0 ; 0 ; ;/ y
cairo_fill_jgtk_ gtkcr
EMPTY
)

unrefcairo=: 3 : 0
if. 0~:gtkpl do. gtkpl=: 0 [ g_object_unref_jgtk_ gtkpl end.
if. 0~:gtkcr do. gtkcr=: 0 [ cairo_destroy_jgtk_ gtkcr end.
EMPTY
)
coclass 'jzplot'
CANVAS_DEFSHOW=: 'jijx'
CANVAS_DEFSIZE=: 400 200
CANVAS_DEFFILE=: jpath '~temp/plot.html'
CANVAS_PENSCALE=: 0.4
canvas_getparms=: 3 : 0
(CANVAS_DEFSIZE;CANVAS_DEFFILE) output_parms y
)
canvas_write=: 4 : 0
dat=. x
'file ctx'=. y
while. _1 -: dat flwrites file do.
  msg=. 'Unable to write to file: ',file,LF,LF
  if. #d=. 1!:0 file do.
    msg=. msg, 'If the file is open in a viewer, close the file and try again.'
    if. 1 query msg do. return. end.
  else.
    info msg,'The file name is invalid.' return. end.
end.
if. (VISIBLE > IFJHS) *. '<!DOCTYPE html>' -: 15{.x do.
  browse_j_ file
end.
)
canvas_build=: 4 : 0
if. #x do.
  'function(ctx){',LF,y,'}',LF
else.
  canvas_wrap (canvas_header''),LF,'function drawPlot(ctx) {',LF,y,'}',LF
end.
)
canvas_header=: 3 : 0
r=. ('80';(pfmt 0{Pxywh);'40';(pfmt 1{Pxywh)) stringreplace canvas_template
r=. ('<1>';IFJHS{::'';'<!--[if lt IE 9]><script src="/~addons/ide/jhs/js/excanvas.js" type="text/javascript"></script><![endif]-->') stringreplace canvas_template
)

canvas_template=: 0 : 0
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset=utf-8>
	<title>J Plot</title>
	<style>
		#canvas1 { margin-left:80px; margin-top:40px; }
	</style>

  <1>
	<script type="text/javascript">
		function graph() {
			var graphCanvas = document.getElementById('canvas1');
			// ensure that the element is available within the DOM
			if (graphCanvas && graphCanvas.getContext) {
				// open a 2D context within the canvas
				var context = graphCanvas.getContext('2d');
				// draw
				drawPlot(context);
			}
		}
)
CANVAS_TRL=: 0 : 0
	</script>
</head>
<body onLoad="graph();">
	<article>
		<h1>plot</h1>
		<canvas id="canvas1" width="800" height="400"></canvas>
	</article>
</body>
</html>
)
canvas_wrap=: 3 : 0
y, ('800';(pfmt 2{Pxywh);'400';(pfmt 3{Pxywh)) stringreplace CANVAS_TRL
)
canvas_color=: 4 : 0
if. x do.
  'ctx.fillStyle= "rgb',"1 (pfmtjs y),"1 '";'
else.
  'ctx.strokeStyle= "rgb',"1 (pfmtjs y),"1 '";'
end.
)
canvas_makerect=: 3 : 0
'x y r s'=. y
r=. (pfmtjs _2 [\ flipxy x,y,x,s,r,s,r,y,x,y) ,.~ 1 4 # ' ctx.moveTo',:' ctx.lineTo'
(,r,"1 ';')
)
canvas_makelines=: 3 : 0
len=. -: {: $ y
if. len = 0 do. i.0 0 return. end.
opr=. (1,len-1) # 'ctx.moveTo',:'ctx.lineTo'
if. 2 > #$y do.
  , ((pfmtjs _2 [\ flipxy y) ,.~ opr) ,. ';'
else.
  ,"2 ((pfmtjs _2 [\"1 flipxy y) ,."2~ opr) ,."2 ';'
end.
)
canvas_pens=: 4 : 0
assert. 0 [ 'canvas_pens not implemented'
(0 canvas_color x) ,"1 'ctx.lineWidth="',"1 (":1>.CANVAS_PENSCALE*y),"1 '";'
)
canvas_pen=: 4 : 0
(0 canvas_color x) , 'ctx.lineWidth="',(":1>.CANVAS_PENSCALE*y),'";'
)
canvas_lines=: 3 : 0
'ctx.beginPath();' ,"1 (canvas_makelines y) ,"1 'ctx.stroke();ctx.closePath();'
)
canvas_text=: 3 : 0
'fnt txt pos align rot und'=. y
pos=. citemize pos
txt=. ,each boxxopen txt
txt=. utf8@('"'&,)@(,&'"')@jsesc each txt

if. 1=#txt do. txt=. (#pos)#{.txt end.

fn=. 'ctx.textBaseline= "middle";ctx.textAlign= "', (align{:: 'left';'center';'right'), '";'

select. rot
case. 0 do.
  res=. tolist (<fn) ,each (<'ctx.fillText(') ,each txt ,each (<',') ,each (<("1) 0&pfmtjs flipxy pos >. 0) ,each <');'
case. 1 do.
  r=. ''
  for_i. i.#pos do.
    s=. 'ctx.save();ctx.translate', (pfmtjs flipxy 0 >. i{pos), ';ctx.rotate(-Math.PI/2);'
    r=. r, <s, fn, 'ctx.fillText(' , (i pick txt), ',0,0);ctx.restore();'
  end.
  res=. tolist r
case. 2 do.
  r=. ''
  for_i. i.#pos do.
    s=. 'ctx.save();ctx.translate', (pfmtjs flipxy 0 >. i{pos), ';ctx.rotate(Math.PI/2);'
    r=. r, <s, fn, 'ctx.fillText(' , (i pick txt), ',0,0);ctx.restore();'
  end.
  res=. tolist r
end.

if. -. und do. res return. end.
wid=. ,{. fnt pgetextent txt
'off lwd'=. getunderline fnt
res=. res, LF, 'ctx.lineWidth="', (":1>.lwd) ,'";'

select. rot
case. 0 do.
  bgn=. pos - (wid * -: align),.-off
  end=. bgn + wid,.0
case. 1 do.
  bgn=. pos - off,.wid * -: align
  end=. bgn + 0,.wid
case. 2 do.
  bgn=. pos + off,.wid * -: align
  end=. bgn - 0,.wid
end.

bgn=. 'ctx.beginPath();ctx.moveTo' ,"1 (pfmtjs flipxy bgn >. 0) ,"1 ';'
end=. 'ctx.lineTo' ,"1 (pfmtjs flipxy end >. 0) ,"1 ';ctx.stroke();ctx.fill();ctx.closePath();'
lin=. ,LF,.bgn,.end

res,lin
)
canvascircle=: 3 : 0
'v s f e c p'=. y
if. isempty c do.
  if. is1color e do.
    pbuf e canvas_pen v
    pbuf 'ctx.beginPath();ctx.arc(' ,"1 (0&pfmtjs flipxy 2{."1 p) ,"1 ',' ,"1 (0&pfmtjs 2{"1 p) ,"1 ',0,2*Math.PI,1);ctx.stroke();ctx.closePath();'
  else.
    for_i. i.#p do.
      pbuf (i{e) canvas_pen i{v
      pbuf 'ctx.beginPath();ctx.arc(' ,"1 (0&pfmtjs flipxy 2{.i{p) ,"1 ',' ,"1 (0&pfmtjs 2{i{p) ,"1 ',0,2*Math.PI,1);ctx.stroke();ctx.closePath();'
    end.
  end.
else.
  p=. citemize p
  c=. p cmatch c
  e=. p cmatch e
  v=. p cmatch v
  for_i. i.#p do.
    pbuf 'ctx.beginPath();ctx.arc(' , (0&pfmtjs flipxy 2{.i{p) , ',' , (0&pfmtjs 2{i{p) , ',0,2*Math.PI,1);'
    pbuf (1 canvas_color i{c) ,((i{e) canvas_pen i{v), 'ctx.stroke();ctx.fill();ctx.closePath();'
  end.
end.
)
canvasdot=: 3 : 0
'v s f e c p'=. y
p=. citemize p
v=. v * CANVAS_PENSCALE
if. is1color e do.
  pbuf 1 canvas_color e
  pbuf 'ctx.beginPath();ctx.arc(' ,"1 (0&pfmtjs flipxy p) ,"1 ',' ,"1 (0&pfmtjs v) ,"1 ',0,2*Math.PI,1);ctx.fill();ctx.closePath();'
else.
  e=. p cmatch e
  for_c. p do.
    pbuf 1 canvas_color c_index { e
    pbuf 'ctx.beginPath();ctx.arc(' , (0&pfmtjs flipxy c) , ',' , (0&pfmtjs v) , ',0,2*Math.PI,1);ctx.fill();ctx.closePath();'
  end.
end.
)
canvasfxywh=: 3 : 0
''return.
p=. _1 pick y
if. #p do.
  CLIP=: >: CLIP
  'x y w h'=. p
  rect=. canvas_makerect x,y,(x+w),y+h
  pbuf 'gsave ',rect,' clip newpath'
else.
  if. CLIP do.
    CLIP=: <: CLIP
    pbuf 'grestore'
  end.
end.
)
canvasline=: 3 : 0
'v s f e c p'=. y
if. (is1color e) *. 1 = #s do.
  pbuf e canvas_pen v
  pbuf canvas_lines p
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  for_i. i. rws do.
    pbuf (i{e) canvas_pen i{v
    pbuf canvas_lines i{p
  end.
end.
)
canvasmarker=: 3 : 0
('canvasmark_',1 pick y)~ y
)
canvaspie=: 3 : 0
'v s f e c p'=. y
pen=. e canvas_pen v
p=. citemize p
ctr=. 0 1 {"1 p
rad=. 2 {"1 p
ang=. 360 %~ 2p1 * 360 + 90 + - 3 4 {"1 p
clr=. cmatch c
for_i. i.#p do.
  pbuf 'ctx.beginPath();', 'ctx.moveTo', (pfmtjs flipxy i { ctr), ';'
  pbuf 'ctx.arc(', (0&pfmtjs flipxy (i { ctr) ,(i{rad)), ',', (0&pfmtjs 0{i{ang), ',', (0&pfmtjs 1{i{ang), ',1);'
  pbuf (1 canvas_color i{clr) ,pen,'ctx.stroke();ctx.fill();ctx.closePath();'
end.
)
canvaspline=: 3 : 0
'v s f e c p'=. y
if. *./ s = 0 do.
  canvasline y return.
end.
s=. s { PENPATTERN
if. (is1color e) *. 1 = #v do.
  pos=. s linepattern"0 1 p
  canvasline (<pos) _1 } y
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  s=. rws $ s
  for_i. i.#p do.
    pbuf (i{e) canvas_pen i{v
    pos=. (i{s) linepattern i{p
    canvasline (i{v);0;0;(i{e);0;pos
  end.
end.
)
canvaspoly=: 3 : 0
'v s f e c p'=. y
p=. citemize p
if. v=0 do. e=. c end.
c=. p cmatch c
e=. p cmatch e
if. +/v do.
  v=. p cmatch v
  for_i. i.#p do.
    pbuf 'ctx.beginPath();', (canvas_makelines i{p), (1 canvas_color i{c), ((i{e) canvas_pen i{v), 'ctx.stroke();ctx.fill();ctx.closePath();'
  end.
else.
  for_i. i.#p do.
    pbuf 'ctx.beginPath();', (canvas_makelines i{p), (0 canvas_color i{c), (1 canvas_color i{c), 'ctx.stroke();ctx.fill();ctx.closePath();'
  end.
end.
)
canvasrect=: 3 : 0
'v s f e c p'=. y
p=. citemize p
if. v=0 do. e=. c end.
c=. p cmatch c
e=. p cmatch e
if. +/v do.
  v=. p cmatch v
  for_i. i.#p do.
    pbuf 'ctx.beginPath();', (canvas_makerect i{p) , (1 canvas_color i{c) ,((i{e) canvas_pen i{v) , 'ctx.stroke();ctx.fill();ctx.closePath();'
  end.
else.
  for_i. i.#p do.
    pbuf 'ctx.beginPath();', (canvas_makerect i{p) ,(1 canvas_color i{c) ,'ctx.fill();ctx.closePath();'
  end.
end.
)
canvastext=: 3 : 0
't f a e c p'=. y
'fnx fst fsz fan und'=. f
rot=. 3 | 0 90 270 i. fan
asc=. pgetascender f
fnm=. getfntname fnx,fst
bold=. italic=. ''
if. (1 e. '-Oblique' E. fnm)+.(1 e. '-Bold' E. fnm)+.(1 e. '-Italic' E. fnm) do.
  bold=. (1 e. 'Bold' E. fnm)#'bold '
  italic=. ((1 e. 'Oblique' E. fnm)+.(1 e. 'Italic' E. fnm))#'italic '
  fnm=. ({.~ i:&'-') fnm
end.
pbuf 'ctx.font= "', italic, bold, (": getplotfontsize f), 'pt \"', fnm,'\"";'
select. rot
case. 0 do. p=. 0 >. p -"1 [ 0, asc
case. 1 do. p=. p +"1 asc, 0
case. 2 do. p=. p -"1 asc, 0
end.
if. is1color e do.
  pbuf 1 canvas_color e
  pbuf canvas_text f;t;p;a;rot;und
else.
  for_i. i.#e do.
    pbuf 1 canvas_color i{e
    pbuf canvas_text f;(i{t);(i{p);a;rot;und
  end.
end.
)
canvasmark_circle=: 3 : 0
's m f e c p'=. y
p=. citemize p
v=. 8 * s * CANVAS_PENSCALE
pbuf 1 canvas_color e
pbuf 'ctx.moveTo', (pfmtjs flipxy {.p), ';'
pbuf 'ctx.beginPath();ctx.arc(' ,"1 (0&pfmtjs flipxy p) ,"1 ',' ,"1 (0&pfmtjs v) ,"1 ',0,2*Math.PI,1);ctx.stroke();ctx.fill();ctx.closePath();'
)
canvasmark_diamond=: 3 : 0
's m f e c p'=. y
e=. 1 canvas_color e
p=. 8 $"1 citemize p
d=. (3.5 * s) * _1 0 0 1 1 0 0 _1
p=. p +"1 d
pbuf 'ctx.beginPath();'
for_i. i.#p do.
  pbuf canvas_makelines i{p
  pbuf e,'ctx.fill();ctx.closePath();'
end.
)
canvasmark_line=: 3 : 0
's m f e c p'=. y
e=. 1 canvas_color e
p=. ,p
s=. -:KeyLen,KeyPen
p=. (p - s) , p + s
pbuf 'ctx.beginPath();'
pbuf canvas_makerect p
pbuf e,'ctx.fill();ctx.closePath();'
)
canvasmark_plus=: 3 : 0
's m f e c p'=. y
s=. s * 4
t=. s, 0
pbuf e canvas_pen s
p=. citemize p
d=. (p -"1 t) ,. p +"1 t
t=. |. t
d=. d, (p -"1 t) ,. p +"1 t
pbuf canvas_lines d
)
canvasmark_square=: 3 : 0
's m f e c p'=. y
e=. 1 canvas_color e
p=. citemize p
s=. 3 * s
p=. (p - s) ,"1 p + s
pbuf 'ctx.beginPath();'
for_i. i.#p do.
  pbuf canvas_makerect i{p
  pbuf e,'ctx.fill();ctx.closePath();'
end.
)
canvasmark_times=: 3 : 0
's m f e c p'=. y
pbuf e canvas_pen 4 * s
t=. _1 + s * 3
r=. (p - t) ,. p + t
s=. (p +"1 t * 1 _1) ,. p +"1 t * _1 1
pbuf canvas_lines r,s
)
canvasmark_triangle=: 3 : 0
's m f e c p'=. y
e=. 1 canvas_color e
p=. 6 $"1 citemize p
d=. (4 * s) * , (sin,.cos) 2p1 * 0 1 2 % 3
p=. p +"1 d
pbuf 'ctx.beginPath();'
for_i. i.#p do.
  pbuf canvas_makelines i{p
  pbuf e,'ctx.fill();ctx.closePath();'
end.
)
JSESC0=: LF,CR,TAB,FF,(8{a.),'\''"'
JSESC1=: 'nrtfb\''"'
jsesc=: 3 : 0
txt=. y
msk=. txt e. JSESC0
if. 1 e. msk do.
  ndx=. , ((I. msk) + i. +/ msk) +/ 0 1
  new=. ,'\',.JSESC1 {~ JSESC0 i. msk#txt
  txt=. new ndx } (1 + msk) # txt
end.

txt
)
canvas_get=: 3 : 0
'size file ctx'=. 3{. canvas_getparms y
res=. canvas_make size;file;ctx
)
canvas_show=: 3 : 0
'size file ctx'=. 3{. canvas_getparms y
res=. canvas_make size;file;ctx
res canvas_write file;ctx
if. IFJHS do. plotcanvas__'' end.
i.0 0
)
canvas_make=: 3 : 0
'size file ctx'=. y
make iCANVAS;0 0,size
fns=. 'canvas'&, each 1 {"1 Plot
dat=. 3 }."1 Plot
buf=: ''
'Cw Ch'=: size
CLIP=: 0
for_d. dat do.
  (>d_index{fns)~d
end.
ctx canvas_build buf
)
coclass 'jzplot'
EPS_DEFSIZE=: 480 360
EPS_DEFFILE=: jpath '~temp/plot.eps'
EPS_PENSCALE=: 0.4
eps_getparms=: 3 : 0
(EPS_DEFSIZE;EPS_DEFFILE) output_parms y
)
getarcangles=: 3 : 0
ang=. dfr arctan | %~/"1 y
quad=. (#. y < 0) { 0 3 1 2
(quad { 0 180 180 360) + ang * quad { 1 _1 1 _1
)
eps_write=: 4 : 0
dat=. x
file=. y
while. _1 -: dat flwrites file do.
  msg=. 'Unable to write to file: ',file,LF,LF
  if. #d=. 1!:0 file do.
    msg=. msg, 'If the file is open in a viewer, close the file and try again.'
    if. 1 query msg do. return. end.
  else.
    info msg,'The file name is invalid.' return. end.
end.
if. 0 = 4!:0 <'EPSReader_j_' do.
  if. check_EPSReader ::0: EPSReader_j_ do.
    fork_jtask_ (dquote EPSReader_j_),' ',dquote file
  else.
    info 'File written: ',file
  end.
end.
)
EPS_DEFS=: 0 : 0
/showc {dup stringwidth pop neg 2 div 0 rmoveto show } bind def
/showr {dup stringwidth pop neg 0 rmoveto show } bind def
)
eps_build=: 3 : 0
eps_wrap (eps_header''),LF,y
)

eps_header=: 3 : 0
r=. ''
r=. r,<'%!PS-Adobe-3.0 EPSF-3.0'
r=. r,<'%%Creator: J Plot'
r=. r,<'%%CreationDate: ','20', ; _2 {.each '0' ,each ": each <. 6!:0''
r=. r,<'%%BoundingBox: ',pfmt Pxywh
r=. r,<''
r=. r,<EPS_DEFS
tolist r
)
EPS_TRL=: 0 : 0
grestore
showpage
%%EOF
)
eps_wrap=: 3 : 0
y,EPS_TRL
)
eps_color=: 3 : 0
(": y % 255) ,"1 ' setrgbcolor '
)
eps_makerect=: 3 : 0
'x y r s'=. y
r=. (pfmt _2 [\ x,y,x,s,r,s,r,y) ,. 1 3 # ' moveto',:' lineto'
(,r,.LF),'closepath'
)
eps_makelines=: 3 : 0
len=. -: {: $ y
if. len = 0 do. i.0 0 return. end.
opr=. (1,len-1) # ' moveto',:' lineto'
if. 2 > #$y do.
  , ((pfmt _2 [\ y) ,. opr) ,. LF
else.
  ,"2 ((pfmt _2 [\"1 y) ,."2 opr) ,."2 LF
end.
)
eps_pens=: 4 : 0
(eps_color x) ,"1 (":,.EPS_PENSCALE*y) ,"1 ' setlinewidth '
)
eps_pen=: 4 : 0
(eps_color ,x), (":EPS_PENSCALE*y) ,' setlinewidth '
)
eps_lines=: 3 : 0
(eps_makelines y) ,"1 'stroke'
)
eps_text=: 3 : 0
'fnt txt pos align rot und'=. y
pos=. citemize pos
txt=. ,each boxxopen txt
txt=. pdfesc each txt

fn=. 'show',align{' cr'

select. rot
case. 0 do.
  res=. (<' moveto (') ,each txt ,each <') ',fn
  res=. tolist (<"1 pfmt pos >. 0) ,each res
case. 1 do.
  r=. ''
  for_i. i.#pos do.
    s=. 'save ',(pfmt 0 >. i{pos), ' translate 90 rotate',LF
    r=. r, <s, '0 0 moveto (' ,(i pick txt) , ') ',fn,' restore'
  end.
  res=. tolist r
case. 2 do.
  r=. ''
  for_i. i.#pos do.
    s=. 'save ',(pfmt 0 >. i{pos), ' translate 270 rotate',LF
    r=. r, <s, '0 0 moveto (' ,(i pick txt) , ') ',fn,' restore'
  end.
  res=. tolist r
end.

if. -. und do. return. end.
wid=. ,{. fnt pgetextent txt
'off lwd'=. getunderline fnt
res=. res, LF, (":lwd) ,' setlinewidth '

select. rot
case. 0 do.
  bgn=. pos - (wid * -: align),.-off
  end=. bgn + wid,.0
case. 1 do.
  bgn=. pos - off,.wid * -: align
  end=. bgn + 0,.wid
case. 2 do.
  bgn=. pos + off,.wid * -: align
  end=. bgn - 0,.wid
end.

bgn=. (": bgn >. 0) ,"1 ' moveto '
end=. (": end >. 0) ,"1 ' lineto stroke'
lin=. ,LF,.bgn,.end

res,lin

)
epscircle=: 3 : 0
'v s f e c p'=. y
if. isempty c do.
  txt=. (pfmt p ,"1[ 0 360) ,"1 ' arc stroke'
  if. is1color e do.
    pbuf e eps_pen v
    pbuf txt
  else.
    pbuf (e eps_pens v) ,. txt
  end.
else.
  p=. citemize p
  c=. p cmatch c
  e=. p cmatch e
  v=. p cmatch v
  for_i. i.#p do.
    pbuf (pfmt (i{p) ,"1[ 0 360) ,"1 ' arc'
    pbuf 'gsave ',(eps_color i{c),' fill grestore'
    pbuf ((i{e) eps_pen i{v),' stroke'
  end.
end.
)
epsdot=: 3 : 0
'v s f e c p'=. y
p=. citemize p
v=. v * EPS_PENSCALE
if. is1color e do.
  pbuf eps_color e
  pbuf (pfmt p,.v) ,"1 ' 0 360 arc fill'
else.
  e=. p cmatch e
  for_c. p do.
    pbuf eps_color c_index { e
    pbuf (pfmt c,.v) ,"1 ' 0 360 arc fill'
  end.
end.
)
epsfxywh=: 3 : 0
p=. _1 pick y
if. #p do.
  CLIP=: >: CLIP
  'x y w h'=. p
  rect=. eps_makerect x,y,(x+w),y+h
  pbuf 'gsave ',rect,' clip newpath'
else.
  if. CLIP do.
    CLIP=: <: CLIP
    pbuf 'grestore'
  end.
end.
)
epsline=: 3 : 0
'v s f e c p'=. y
if. (is1color e) *. 1 = #s do.
  pbuf e eps_pen v
  pbuf eps_lines p
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  for_i. i. rws do.
    pbuf (i{e) eps_pen i{v
    pbuf eps_lines i{p
  end.
end.
)
epsmarker=: 3 : 0
('epsmark_',1 pick y)~ y
)
epspie=: 3 : 0
'v s f e c p'=. y
pen=. e eps_pen v
p=. citemize p
ctr=. 0 1 {"1 p
rad=. 2 {"1 p
ang=. 360 + _90 + 3 4 {"1 p
clr=. cmatch c
for_i. i.#p do.
  pbuf 'newpath'
  pbuf (pfmt i { ctr),' moveto'
  pbuf (pfmt (i { ctr),(i{rad),i{ang),' arc closepath'
  pbuf 'gsave ',(eps_color i{clr),' fill grestore'
  pbuf pen,' stroke'
end.
)
epspline=: 3 : 0
'v s f e c p'=. y
if. *./ s = 0 do.
  epsline y return.
end.
s=. s { PENPATTERN
if. (is1color e) *. 1 = #v do.
  pos=. s linepattern"0 1 p
  epsline (<pos) _1 } y
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  s=. rws $ s
  for_i. i.#p do.
    pos=. (i{s) linepattern i{p
    epsline (i{v);0;0;(i{e);0;pos
  end.
end.
)
epspoly=: 3 : 0
'v s f e c p'=. y
p=. citemize p
if. v=0 do. e=. c end.
c=. p cmatch c
e=. p cmatch e
if. +/v do.
  v=. p cmatch v
  for_i. i.#p do.
    pbuf eps_makelines i{p
    pbuf 'gsave ',(eps_color i{c),' fill grestore'
    pbuf ((i{e) eps_pen i{v),' stroke'
  end.
else.
  for_i. i.#p do.
    pbuf eps_makelines i{p
    pbuf (eps_color i{c),' fill'
  end.
end.
)
epsrect=: 3 : 0
'v s f e c p'=. y
p=. citemize p
if. v=0 do. e=. c end.
c=. p cmatch c
e=. p cmatch e
if. +/v do.
  v=. p cmatch v
  for_i. i.#p do.
    pbuf eps_makerect i{p
    pbuf 'gsave ',(eps_color i{c),' fill grestore'
    pbuf ((i{e) eps_pen i{v),' stroke'
  end.
else.
  for_i. i.#p do.
    pbuf eps_makerect i{p
    pbuf (eps_color i{c),' fill'
  end.
end.
)
epstext=: 3 : 0
't f a e c p'=. y
'fnx fst fsz fan und'=. f
rot=. 3 | 0 90 270 i. fan
asc=. pgetascender f
fnm=. getfntname fnx,fst
pbuf '/',fnm,' findfont'
pbuf (": getplotfontsize f),' scalefont setfont'
select. rot
case. 0 do. p=. 0 >. p -"1 [ 0, asc
case. 1 do. p=. p +"1 asc, 0
case. 2 do. p=. p -"1 asc, 0
end.
if. is1color e do.
  pbuf eps_color e
  pbuf eps_text f;t;p;a;rot;und
else.
  for_i. i.#e do.
    pbuf eps_color i{e
    pbuf eps_text f;(i{t);(i{p);a;rot;und
  end.
end.
)
epsmark_circle=: 3 : 0
's m f e c p'=. y
p=. citemize p
v=. 8 * s * EPS_PENSCALE
pbuf eps_color e
pbuf (pfmt {.p), ' moveto'
pbuf (pfmt p,.v) ,"1 ' 0 360 arc fill'
)
epsmark_diamond=: 3 : 0
's m f e c p'=. y
e=. eps_color e
p=. 8 $"1 citemize p
d=. (3.5 * s) * _1 0 0 1 1 0 0 _1
p=. p +"1 d
for_i. i.#p do.
  pbuf eps_makelines i{p
  pbuf e,' fill'
end.
)
epsmark_line=: 3 : 0
's m f e c p'=. y
e=. eps_color e
p=. ,p
s=. -:KeyLen,KeyPen
p=. (p - s) , p + s
pbuf eps_makerect p
pbuf e,' fill'
)
epsmark_plus=: 3 : 0
's m f e c p'=. y
s=. s * 4
t=. s, 0
pbuf e eps_pen s
p=. citemize p
d=. (p -"1 t) ,. p +"1 t
t=. |. t
d=. d, (p -"1 t) ,. p +"1 t
pbuf eps_lines d
)
epsmark_square=: 3 : 0
's m f e c p'=. y
e=. eps_color e
p=. citemize p
s=. 3 * s
p=. (p - s) ,"1 p + s
for_i. i.#p do.
  pbuf eps_makerect i{p
  pbuf e,' fill'
end.
)
epsmark_times=: 3 : 0
's m f e c p'=. y
pbuf e eps_pen 4 * s
t=. _1 + s * 3
r=. (p - t) ,. p + t
s=. (p +"1 t * 1 _1) ,. p +"1 t * _1 1
pbuf eps_lines r,s
)
epsmark_triangle=: 3 : 0
's m f e c p'=. y
e=. eps_color e
p=. 6 $"1 citemize p
d=. (4 * s) * , (sin,.cos) 2p1 * 0 1 2 % 3
p=. p +"1 d
for_i. i.#p do.
  pbuf eps_makelines i{p
  pbuf e,' fill'
end.
)
eps_show=: 3 : 0
'size file ctx'=. 3{. eps_getparms y
make iEPS;0 0,size
fns=. 'eps'&, each 1 {"1 Plot
dat=. 3 }."1 Plot
buf=: ''
CLIP=: 0
for_d. dat do.
  (>d_index{fns)~d
end.
res=. eps_build buf
res eps_write file
)
coclass 'jzplot'
GTK_DEFFILE=: '~temp/plot'
fext=: 4 : 0
f=. deb y
f, (-. x -: (-#x) {. f) # x
)
gettemp=: 3 : 0
p=. jpath '~temp/'
d=. 1!:0 p,'*.',y
a=. 0, {.@:(0&".)@> _4 }. each {."1 d
a=. ": {. (i. >: #a) -. a
p,a,'.',y
)
gtkfontdesc=: 3 : 0
'ind fst siz ang und'=. y
'ita bld'=. 2 2 #: fst
sty=. (bld#' bold'),(ita#' italic'),und#' underline'
('_' (I.@(' '&=)nam)} nam=. ind pick GTKFONTNAMES),sty,' ',":siz
)
gtk_getsize=: 3 : 0
if. 0=(0&". ::]) PFormhwnd do. '' return. end.
_2{.getGtkWidgetAllocation_jgtk_ (0&". ::]) PIdhwnd
)
output_parms=: 4 : 0
'size file'=. x
ctx=. ''
if. #y do.
  prm=. qchop y
  select. #prm
  case. 1 do.
    file=. 0 pick prm
  case. 2 do.
    size=. 0 ".&> prm
  case. 3 do.
    file=. 0 pick prm
    size=. 0 ". &> _2 {. prm
    if. 0 e. size do.
      size=. 0 ". &> 2 {. prm
      file=. 2 pick prm
    end.
  case. 4 do.
    file=. 0 pick prm
    size=. 0 ". &> _2 {. prm
    if. 0 e. size do.
      size=. 0 ". &> 2 {. prm
      file=. 2 pick prm
    end.
    ctx=. 3 pick prm
  end.
else.
  if. #sz=. gtk_getsize'' do.
    size=. sz
  end.
end.
size;file;ctx
)
gtk_clip=: 3 : 0
if. IFGTK < ifjwplot'' do. pdcmdclip=: 1 return. end.
0
)
gtk_gpcount=: ,"1~ 1 + [: {: 1 , $
gtk_gpcut=: 3 : 0
r=. ''
while. #y do.
  n=. {. y
  if. n=0 do.
    info 'zero length segment at: ',":#;r
    r
    return.
  end.
  r=. r, < n {. y
  y=. n }. y
end.
r
)
gtk_gpbuf=: 3 : 0
assert. 2 > #$y
buf=: buf,y
)
gtk_gpapply=: 3 : 0
glcmds buf
buf=: $0
)
gtk_gpflip=: flipxy @ rndint
gtk_gpfliplast=: 3 : 0
(<gtk_gpflip _1 pick y) _1 } y
)
gtk_gpinit=: 3 : 0
buf=: bufdef=: $0
r=. ''
r=. r,3 2003 1
r=. r,3 2071 1
gtk_gpapply''
)
gtk_gpbrushnull=: 3 : '2 2005'
gtk_gppens=: 4 : 0
y=. rndint y
5 2032,"1 x,"1 [ 4 2022,"1 y,.5*y=0
)
gtk_gppen=: 4 : 0
y=. rndint y
5 2032,(,x),4 2022,y,5*y=0
)
gtk_gppens1=: 3 : 0
5 2032,"1 y,"1 [ 4 2022 1 0
)
gtk_gppen1=: 3 : 0
5 2032,(,y),4 2022 1 0
)
gtk_gppenbrush1=: 3 : 0
5 2032,(,y),4 2022 1 0 2 2004
)
gtk_gppixel=: 3 : 0
's t f e c p'=. y
p=. gtk_gpcount 2024 ,"1 gtk_gpflip p
if. is1color e do.
  gtk_gpbuf e gtk_gppen 1
  gtk_gpbuf ,p
else.
  rws=. #p
  e=. rws $ citemize e
  pen=. e gtk_gppens 1
  gtk_gpbuf ,pen ,. p
end.
)
gtk_gppline=: 4 : 0
's t f e c p'=. y
if. (is1color e) *. 1 = #s do.
  gtk_gpbuf (,e) gtk_gppen s
  gtk_gpbuf ,gtk_gpcount x,"1 p
else.
  rws=. #p
  e=. rws $ citemize e
  s=. rws $ s
  pen=. e gtk_gppens s
  gtk_gpbuf ,pen ,. gtk_gpcount x,"1 p
end.
)
gtk_gppshape=: 4 : 0
'v s f e c p'=. y

if. v=0 do. e=. c end.

if. is1color e do.
  gtk_gpbuf e gtk_gppen v
  if. isempty c do.
    gtk_gpbuf gtk_gpbrushnull''
    gtk_gpbuf ,gtk_gpcount x,"1 p
  elseif. is1color c do.
    gtk_gpbuf 5 2032,(,c),2 2004
    gtk_gpbuf ,gtk_gpcount x,"1 p
  elseif. do.
    c=. (#p) $ c
    clr=. 5 2032 ,"1 c ,"1 [ 2 2004
    gtk_gpbuf , clr ,. gtk_gpcount x,"1 p
  end.
else.
  e=. (#p) $ e
  e=. e gtk_gppens v
  if. isempty c do.
    gtk_gpbuf gtk_gpbrushnull''
    gtk_gpbuf , e ,. gtk_gpcount x,"1 p
  elseif. is1color c do.
    gtk_gpbuf 5 2032,(,c),2 2004
    gtk_gpbuf , e ,. gtk_gpcount x,"1 p
  elseif. do.
    c=. (#p) $ c
    clr=. 5 2032 ,"1 c ,"1 [ 2 2004
    gtk_gpbuf , e ,. clr ,. gtk_gpcount x,"1 p
  end.

end.
)
gtkarc=: 3 : '2001 gtk_gppline gtk_gpfliplast y'
gtkline=: 3 : '2015 gtk_gppline gtk_gpfliplast y'
gtkpie=: 3 : '2023 gtk_gppshape gtk_gpfliplast y'
gtkpoly=: 3 : '2029 gtk_gppshape gtk_gpfliplast y'
gtkcircle=: 3 : 0
p=. _1 pick y
ctr=. gtk_gpflip 0 1 {"1 p
rad=. rndint 2 {"1 p
xy=. ctr - rad
wh=. +: rad ,. rad
p=. xy ,. wh
2008 gtk_gppshape (<p) _1 } y
)
gtkdot=: 3 : 0
'v s f e c p'=. y
select. v
case. 1 do.
  gtk_gppixel y
case. 2 do.
  p=. gtk_gpflip p
  p=. (p-1) ,"1 [ 2 2
  dat=. 1;0;0;e;e;p
  2031 gtk_gppshape dat
case. 3 do.
  h=. (p-"1[1 0) ,. p+"1[2 0
  v=. (p-"1[0 1) ,. p+"1[0 2
  gtkline 1;0;0;e;e;h,v
case. do.
  o=. >. -: v
  p=. p ,"1 v,.v
  gtkcircle 1;0;0;e;e;p
end.
)
gtkfxywh=: 3 : 0
p=. _1 pick y
if. #p do.
  'x y w h'=. p
  xy=. _1 + <. x,Ch-y+h
  wh=. 2 + >. w,h
  gtk_gpbuf 6 2078,xy,wh
else.
  gtk_gpbuf 2 2079
end.
)
gtkmarker=: 3 : 0
's m f e c p'=. y
p=. gtk_gpflip p
gtk_gpbuf gtk_gppenbrush1 e
s ('gtkmark_',m)~ p
)
gtkpie=: 3 : 0
p=. _1 pick y
ctr=. gtk_gpflip 0 1 {"1 p
rad=. 2 {"1 p
ang=. 3 4 {"1 p
xy=. ctr - rad
wh=. +: rad ,. rad
tx=. ({."1 ctr) + rad * sind ang
ty=. ({:"1 ctr) + rad * cosd ang
p=. rndint xy ,. wh ,. ,"2 tx ,"0 ty
2023 gtk_gppshape (<p) _1 } y
)
gtkpline=: 3 : 0
's t f e c p'=. y
if. *./ t = 0 do.
  gtkline y return.
end.
p=. gtk_gpflip p
t=. t { PENPATTERN
if. (is1color e) *. 1 = #s do.
  gtk_gpbuf 5 2032,(,e),4 2022,s,0
  pos=. t linepattern"0 1 p
  gtk_gpbuf ,gtk_gpcount 2015,"1 pos
else.
  rws=. #p
  e=. rws $ citemize e
  s=. rws $ s
  t=. rws $ t
  pen=. e gtk_gppens s
  for_i. i.#p do.
    gtk_gpbuf i{pen
    pos=. (i{t) linepattern i{p
    gtk_gpbuf ,gtk_gpcount 2015,"1 pos
  end.
end.
)
gtkrect=: 3 : 0
p=. boxrs2wh gtk_gpflip _1 pick y
y=. (<p) _1 } y
2031 gtk_gppshape y
)
gtktext=: 3 : 0
't f a e c p'=. y

f=. getisifontid f
p=. gtk_gpflip p
t=. text2utf8 each boxopen t
if. a do.
  glfont f
  off=. <. -: a * {."1 glqextent &> t
  if. 1 e. 'angle900' E. f do.
    p=. p +"1 [ 0,.off
  elseif. 1 e. 'angle2700' E. f do.
    p=. p -"1 [ 0,.off
  elseif. do.
    p=. p -"1 off,.0
  end.
end.
'face size style degree'=. parseFontSpec f
gtk_gpbuf gtk_gpcount 2312,(<.size*10),style,(<.degree*10),alfndx,face
if. is1color e do.
  gtk_gpbuf 5 2032,(,e),2 2040
  if. rank01 p do.
    gtk_gpbuf gtk_gpcount 2056,p
    gtk_gpbuf gtk_gpcount 2038,alfndx,>t
  else.
    t=. gtk_gpcount each 2038 ,each alfndx each t
    t=. (<"1 gtk_gpcount 2056 ,"1 p) ,each t
    gtk_gpbuf ; t
  end.
else.
  t=. gtk_gpcount each 2038 ,each alfndx each t
  t=. t ,each <"1 gtk_gpcount 2056 ,"1 p
  t=. (<"1 (5 2032 ,"1 e) ,"1 [ 2 2040) ,each t
  gtk_gpbuf ; t
end.
)
parseFontname=: 3 : 0
font=. ' ',y
b=. (font=' ') > ~:/\font='"'
a: -.~ b <@(-.&'"');._1 font
)
FontStyle=: ;:'regular bold italic underline strikeout'

parseFontSpec=: 3 : 0
'ns styleangle'=. 2 split parseFontname y
'face size'=. ns
size=. 12". size
style=. FontStyle i. tolower each styleangle
style=. <.+/2^<:(style ((> 0) *. <) #FontStyle) # style
if. 1 e. an=. ('angle'-:5&{.)&> styleangle do.
  degree=. 10%~ 0". 5}.>(an i. 1){styleangle
else.
  degree=. 0
end.
face;size;style;degree
)
gtkmark_circle=: 4 : 0
s=. rndint x * 3
p=. (y - s) ,"1 >: +: s,s
gtk_gpbuf ,gtk_gpcount 2008 ,"1 p
)
gtkmark_diamond=: 4 : 0
s=. rndint x * 4
'x y'=. |: y
p=. (x-s),.y,.x,.(y+s),.(x+s),.y,.x,.y-s
gtk_gpbuf ,gtk_gpcount 2029 ,"1 p
)
gtkmark_line=: 4 : 0
'x y'=. , y
p=. >.(x--:KeyLen),(y--:KeyPen),<:KeyLen,KeyPen
gtk_gpbuf ,gtk_gpcount 2031 ,p
)
gtkmark_plus=: 4 : 0
s=. rndint 4 1 * x
p=. (y -"1 s) ,"1 +: s
s=. |. s
p=. p , (y -"1 s) ,"1 +: s
gtk_gpbuf ,gtk_gpcount 2031 ,"1 p
)
gtkmark_square=: 4 : 0
s=. rndint x * 3
p=. (y - s) ,"1 +: s,s
gtk_gpbuf ,gtk_gpcount 2031 ,"1 p
)
gtkmark_times=: 4 : 0
if. x = 1 do.
  p=. (y - 3) ,. y + 4
  q=. (y - "1 [ 3 _3) ,. y +"1 [ 4 _4
  p=. p, (p +"1 [ 0 1 _1 0), p + "1 [ 1 0 0 _1
  q=. q, (q +"1 [ 0 _1 _1 0), q +"1 [ 1 0 0 1
  gtk_gpbuf ,gtk_gpcount 2015 ,"1 p,q
else.
  s=. rndint _1 + 3 * x
  n=. rndint 2 * x
  p=. (y - s) ,. y + s
  q=. (y - "1 s * 1 _1) ,. y +"1 s * 1 _1
  gtk_gpbuf 4 2022,n,0
  gtk_gpbuf ,gtk_gpcount 2015 ,"1 p,q
end.
)
gtkmark_triangle=: 4 : 0
s=. rndint 2 * x
t=. rndint 4 * x
'x y'=. |: y
p=. rndint (x-t),.(y+s),.(x+t),.(y+s),.x,.y-t
gtk_gpbuf ,gtk_gpcount 2029 ,"1 p
)
gtk_print=: 3 : 0
if. IFGTK < ifjwplot'' do. pdcmdprint=: 1 return. end.
window=. gtk_window_new_jgtk_ GTK_WINDOW_TOPLEVEL_jgtk_
canvas=. glcanvas_jgl2_ 540 400;coname''
l=. glgetloc_jgl2_ canvas
print__l''
evtloop_jgtk_''
)
gtk_def=: 4 : 0
type=. x
file=. jpath ('.',type) fext (;qchop y),(0=#y) # GTK_DEFFILE
(gtk_getrgb'') saveimg x;file
)
gtk_emf=: 0:
gtk_gif=: 0:
gtk_getrgb=: 3 : 0
selectpid''
box=. 0 0,glqwh''
(2}.box),glqpixels box
)
gtk_bmp=: 3 : 0
type=. 'bmp'
file=. jpath ('.',type) fext (;qchop y),(0=#y) # GTK_DEFFILE
rgb=. gtk_getrgb''
if. IFWIN do.
  ((1 0{rgb) $ fliprgb 2}.rgb) writebmp file
else.
  rgb saveimg type;file
end.
)
gtk_emf=: 3 : 0
file=. jpath '.emf' fext (;qchop y),(0=#y) # GTK_DEFFILE
glsel PIdhwnd
glfile file
glemfopen''
gtk_paint''
glemfclose''
)
gtk_jpg=: 3 : 0
file=. ''
qual=. 85
if. #y do.
  arg=. qchop y
  num=. __ ". &.> arg
  msk=. +./ &> num = &.> __
  file=. > {. msk # arg
  qual=. <. {. (>(-.msk) # num),qual
end.
file=. jpath '.jpg' fext file,(0=#file) # GTK_DEFFILE
rgb=. gtk_getrgb''
rgb saveimg 'jpeg';file;'quality';":qual
)
gtk_png=: 3 : 0
file=. ''
comp=. 5
if. #y do.
  arg=. qchop y
  num=. __ ". &.> arg
  msk=. +./ &> num = &.> __
  file=. > {. msk # arg
  comp=. <. {. (>(-.msk) # num),comp
end.
file=. jpath '.png' fext file,(0=#file) # GTK_DEFFILE
rgb=. gtk_getrgb''
rgb saveimg 'png';file;'compression';":comp
)
gtk_save=: 3 : 0
if. 0=#y do.
  gtk_clip'' return.
end.
type=. tolower firstword y
('gtk_',type)~ (1+#type) }. y
)

gtk_get=: 0:
gtk_tif=: 'tif' & gtk_def
3 : 0''
if. IF64 do.
  ALPHA=: 0{_3 ic 0 0 0 255 255 255 255 255{a.
else.
  ALPHA=: 0{_2 ic 0 0 0 255{a.
end.
''
)

OR=: 23 b./

saveimg=: 4 : 0
'type fl'=. 2{.y
type=. type, (type-:'tif')#'f'
'w h'=. 2{.x
d=. 2}.x
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
buf=. gdk_pixbuf_new_from_data_jgtk_ (15!:14<'d'),GDK_COLORSPACE_RGB_jgtk_,1,8,w,h,(4*w),0,0
if. buf do.
  if. 3<#y do.
    gdk_pixbuf_save_2_jgtk_ buf;fl;type;0;(2 3{y),<0
  else.
    gdk_pixbuf_save_jgtk_ buf;fl;type;0;0
  end.
end.
g_object_unref_jgtk_ buf
)
gtk_show=: 3 : 0
if. -.IFGTK do. gtkinit_jgtk_ '' end.
popen_gtk''
if. ifjwplot'' do.
  (PForm,'_',PId,'_paint')=: gtk_paint
end.
if. PShow=0 do.
  if. VISIBLE do.
    gtk_widget_show_all_jgtk_ (0&". ::]) PFormhwnd
  else.
    gtk_widget_hide_all_jgtk_ (0&". ::]) PFormhwnd
  end.
  PShow=: 1
  gtk_window_set_keep_above_jgtk_ ((0&". ::]) PFormhwnd),PTop
end.
gtk_paint''
glpaint''
evtloop_jgtk_''
)
gtk_paint=: 3 : 0
selectpid''
'Cw Ch'=: glqwh''
gtk_paintit 0 0,Cw,Ch
)
gtk_paintit=: 3 : 0
gtk_gpinit''
make iGTK;y
ids=. 1 {"1 Plot
fns=. 'gtk'&, each ids
dat=. 3 }."1 Plot
for_d. dat do.
  (>d_index{fns)~d
end.
gtk_gpapply''
)

coclass 'jzplot'
ISI_DEFFILE=: '~temp/plot'
fext=: 4 : 0
f=. deb y
f, (-. x -: (-#x) {. f) # x
)
gettemp=: 3 : 0
p=. jpath '~temp/'
d=. 1!:0 p,'*.',y
a=. 0, {.@:(0&".)@> _4 }. each {."1 d
a=. ": {. (i. >: #a) -. a
p,a,'.',y
)
isi_getsize=: 3 : 0
if. -. wdishandle :: 0: ": PFormhwnd do. '' return. end.
wd 'psel ', ":PFormhwnd
s=. wd :: 0: 'qchildxywhx ',PId
if. s -: 0 do. '' return. end.
2 3 { 0 ". s
)
output_parms=: 4 : 0
'size file'=. x
if. #y do.
  prm=. qchop y
  select. #prm
  case. 1 do.
    file=. 0 pick prm
  case. 2 do.
    size=. 0 ".&> prm
  case. 3 do.
    file=. 0 pick prm
    size=. 0 ". &> _2 {. prm
    if. 0 e. size do.
      size=. 0 ". &> 2 {. prm
      file=. 2 pick prm
    end.
  end.
else.
  if. #sz=. isi_getsize'' do.
    size=. sz
  end.
end.
size;file
)
isi_clip=: 3 : 0
if. -. IFWIN do.
  info 'Save plot to clipboard is only available in Windows'
  return.
end.
f=. gettemp 'emf'
isi_emf dquote f
wd 'clipcopyx enhmetafile ',dquote f
1!:55 <f
)
isi_gpcount=: ,"1~ 1 + [: {: 1 , $
isi_gpcut=: 3 : 0
r=. ''
while. #y do.
  n=. {. y
  if. n=0 do.
    info 'zero length segment at: ',":#;r
    r
    return.
  end.
  r=. r, < n {. y
  y=. n }. y
end.
r
)
isi_gpbuf=: 3 : 0
assert. 2 > #$y
buf=: buf,y
)
isi_gpapply=: 3 : 0
glcmds buf
buf=: $0
)
isi_gpflip=: flipxy @ rndint
isi_gpfliplast=: 3 : 0
(<isi_gpflip _1 pick y) _1 } y
)
isi_gpinit=: 3 : 0
buf=: bufdef=: $0
r=. ''
r=. r,3 2003 1
r=. r,3 2071 1
isi_gpapply''
)
isi_gpbrushnull=: 3 : '2 2005'
isi_gppens=: 4 : 0
y=. rndint y
5 2032,"1 x,"1 [ 4 2022,"1 y,.5*y=0
)
isi_gppen=: 4 : 0
y=. rndint y
5 2032,(,x),4 2022,y,5*y=0
)
isi_gppens1=: 3 : 0
5 2032,"1 y,"1 [ 4 2022 1 0
)
isi_gppen1=: 3 : 0
5 2032,(,y),4 2022 1 0
)
isi_gppenbrush1=: 3 : 0
5 2032,(,y),4 2022 1 0 2 2004
)
isi_gppixel=: 3 : 0
's t f e c p'=. y
p=. isi_gpcount 2024 ,"1 isi_gpflip p
if. is1color e do.
  isi_gpbuf e isi_gppen 1
  isi_gpbuf ,p
else.
  rws=. #p
  e=. rws $ citemize e
  pen=. e isi_gppens 1
  isi_gpbuf ,pen ,. p
end.
)
isi_gppline=: 4 : 0
's t f e c p'=. y
if. (is1color e) *. 1 = #s do.
  isi_gpbuf (,e) isi_gppen s
  isi_gpbuf ,isi_gpcount x,"1 p
else.
  rws=. #p
  e=. rws $ citemize e
  s=. rws $ s
  pen=. e isi_gppens s
  isi_gpbuf ,pen ,. isi_gpcount x,"1 p
end.
)
isi_gppshape=: 4 : 0
'v s f e c p'=. y

if. v=0 do. e=. c end.

if. is1color e do.
  isi_gpbuf e isi_gppen v
  if. isempty c do.
    isi_gpbuf isi_gpbrushnull''
    isi_gpbuf ,isi_gpcount x,"1 p
  elseif. is1color c do.
    isi_gpbuf 5 2032,(,c),2 2004
    isi_gpbuf ,isi_gpcount x,"1 p
  elseif. do.
    c=. (#p) $ c
    clr=. 5 2032 ,"1 c ,"1 [ 2 2004
    isi_gpbuf , clr ,. isi_gpcount x,"1 p
  end.
else.
  e=. (#p) $ e
  e=. e isi_gppens v
  if. isempty c do.
    isi_gpbuf isi_gpbrushnull''
    isi_gpbuf , e ,. isi_gpcount x,"1 p
  elseif. is1color c do.
    isi_gpbuf 5 2032,(,c),2 2004
    isi_gpbuf , e ,. isi_gpcount x,"1 p
  elseif. do.
    c=. (#p) $ c
    clr=. 5 2032 ,"1 c ,"1 [ 2 2004
    isi_gpbuf , e ,. clr ,. isi_gpcount x,"1 p
  end.

end.
)
isiarc=: 3 : '2001 isi_gppline isi_gpfliplast y'
isiline=: 3 : '2015 isi_gppline isi_gpfliplast y'
isipie=: 3 : '2023 isi_gppshape isi_gpfliplast y'
isipoly=: 3 : '2029 isi_gppshape isi_gpfliplast y'
isicircle=: 3 : 0
p=. _1 pick y
ctr=. isi_gpflip 0 1 {"1 p
rad=. rndint 2 {"1 p
xy=. ctr - rad
wh=. +: rad ,. rad
p=. xy ,. wh
2008 isi_gppshape (<p) _1 } y
)
isidot=: 3 : 0
'v s f e c p'=. y
select. v
case. 1 do.
  isi_gppixel y
case. 2 do.
  p=. isi_gpflip p
  p=. (p-1) ,"1 [ 2 2
  dat=. 1;0;0;e;e;p
  2031 isi_gppshape dat
case. 3 do.
  h=. (p-"1[1 0) ,. p+"1[2 0
  v=. (p-"1[0 1) ,. p+"1[0 2
  isiline 1;0;0;e;e;h,v
case. do.
  o=. >. -: v
  p=. p ,"1 v,.v
  isicircle 1;0;0;e;e;p
end.
)
isifxywh=: 3 : 0
p=. _1 pick y
if. #p do.
  'x y w h'=. p
  xy=. _1 + <. x,Ch-y+h
  wh=. 2 + >. w,h
  isi_gpbuf 6 2078,xy,wh
else.
  isi_gpbuf 2 2079
end.
)
isimarker=: 3 : 0
's m f e c p'=. y
p=. isi_gpflip p
isi_gpbuf isi_gppenbrush1 e
s ('isimark_',m)~ p
)
isipie=: 3 : 0
p=. _1 pick y
ctr=. isi_gpflip 0 1 {"1 p
rad=. 2 {"1 p
ang=. 3 4 {"1 p
xy=. ctr - rad
wh=. +: rad ,. rad
tx=. ({."1 ctr) + rad * sind ang
ty=. ({:"1 ctr) + rad * cosd ang
p=. rndint xy ,. wh ,. ,"2 tx ,"0 ty
2023 isi_gppshape (<p) _1 } y
)
isipline=: 3 : 0
's t f e c p'=. y
if. *./ t = 0 do.
  isiline y return.
end.
p=. isi_gpflip p
t=. t { PENPATTERN
if. (is1color e) *. 1 = #s do.
  isi_gpbuf 5 2032,(,e),4 2022,s,0
  pos=. t linepattern"0 1 p
  isi_gpbuf ,isi_gpcount 2015,"1 pos
else.
  rws=. #p
  e=. rws $ citemize e
  s=. rws $ s
  t=. rws $ t
  pen=. e isi_gppens s
  for_i. i.#p do.
    isi_gpbuf i{pen
    pos=. (i{t) linepattern i{p
    isi_gpbuf ,isi_gpcount 2015,"1 pos
  end.
end.
)
isirect=: 3 : 0
p=. boxrs2wh isi_gpflip _1 pick y
if. IFJAVA do.
  if. 0 = 1 pick y do.
    p=. 1 1 _2 _2 +"1 p
  end.
end.
y=. (<p) _1 } y
2031 isi_gppshape y
)
isitext=: 3 : 0
't f a e c p'=. y

p=. isi_gpflip p
t=. text2utf8 each boxopen t
if. a do.
  glfont f
  off=. <. -: a * {."1 glqextent &> t
  if. 1 e. 'angle900' E. f do.
    p=. p +"1 [ 0,.off
  elseif. 1 e. 'angle2700' E. f do.
    p=. p -"1 [ 0,.off
  elseif. do.
    p=. p -"1 off,.0
  end.
end.
'face size style degree'=. parseFontSpec f
isi_gpbuf isi_gpcount 2312,(<.size*10),style,(<.degree*10),alfndx,face
if. is1color e do.
  isi_gpbuf 5 2032,(,e),2 2040
  if. rank01 p do.
    isi_gpbuf isi_gpcount 2056,p
    isi_gpbuf isi_gpcount 2038,alfndx,>t
  else.
    t=. isi_gpcount each 2038 ,each alfndx each t
    t=. (<"1 isi_gpcount 2056 ,"1 p) ,each t
    isi_gpbuf ; t
  end.
else.
  t=. isi_gpcount each 2038 ,each alfndx each t
  t=. t ,each <"1 isi_gpcount 2056 ,"1 p
  t=. (<"1 (5 2032 ,"1 e) ,"1 [ 2 2040) ,each t
  isi_gpbuf ; t
end.
)
isimark_circle=: 4 : 0
s=. rndint x * 3
p=. (y - s) ,"1 >: +: s,s
isi_gpbuf ,isi_gpcount 2008 ,"1 p
)
isimark_diamond=: 4 : 0
s=. rndint x * 4
'x y'=. |: y
p=. (x-s),.y,.x,.(y+s),.(x+s),.y,.x,.y-s
isi_gpbuf ,isi_gpcount 2029 ,"1 p
)
isimark_line=: 4 : 0
'x y'=. , y
p=. >.(x--:KeyLen),(y--:KeyPen),<:KeyLen,KeyPen
isi_gpbuf ,isi_gpcount 2031 ,p
)
isimark_plus=: 4 : 0
s=. rndint 4 1 * x
p=. (y -"1 s) ,"1 +: s
s=. |. s
p=. p , (y -"1 s) ,"1 +: s
isi_gpbuf ,isi_gpcount 2031 ,"1 p
)
isimark_square=: 4 : 0
s=. rndint x * 3
p=. (y - s) ,"1 +: s,s
isi_gpbuf ,isi_gpcount 2031 ,"1 p
)
isimark_times=: 4 : 0
if. x = 1 do.
  p=. (y - 3) ,. y + 4
  q=. (y - "1 [ 3 _3) ,. y +"1 [ 4 _4
  p=. p, (p +"1 [ 0 1 _1 0), p + "1 [ 1 0 0 _1
  q=. q, (q +"1 [ 0 _1 _1 0), q +"1 [ 1 0 0 1
  isi_gpbuf ,isi_gpcount 2015 ,"1 p,q
else.
  s=. rndint _1 + 3 * x
  n=. rndint 2 * x
  p=. (y - s) ,. y + s
  q=. (y - "1 s * 1 _1) ,. y +"1 s * 1 _1
  isi_gpbuf 4 2022,n,0
  isi_gpbuf ,isi_gpcount 2015 ,"1 p,q
end.
)
isimark_triangle=: 4 : 0
s=. rndint 2 * x
t=. rndint 4 * x
'x y'=. |: y
p=. rndint (x-t),.(y+s),.(x+t),.(y+s),.x,.y-t
isi_gpbuf ,isi_gpcount 2029 ,"1 p
)
PRINTP=: ''
isi_print=: 3 : 0
if. #PRINTP do. wd 'psel ',PRINTP,';pclose' end.
wd 'pc print;cc g isigraph'
PRINTP=: wd 'qhwndp'
PRINTED=: 0
opt=. '"" "" "" orientation ',":ORIENTATION
glprint opt
)
print_g_print=: 3 : 0
'page pass'=. ". sysdata
select. pass
case. _1 do.
  PRINTP=: PRINTPXYWH=: ''
  wd 'pclose'
case. 0 do.
  glprintmore -.PRINTED
case. do.
  'Cw Ch'=: glqprintwh''
  isi_paintit isi_printwin''
  PRINTED=: 1
end.
)
isi_printwin=: 3 : 0
'pw ph mw mh'=. 4 {. glqprintpaper''
mrg=. 0 >. PRINTMARGIN - mw,(ph - mh + Ch),(pw - mw + Cw),mh
xywh=. (0 0,Cw,Ch) shrinkrect mrg
if. 0 = #PRINTWINDOW do.
  xywh
else.
  if. 4 ~: #PRINTWINDOW do.
    info 'PRINTWINDOW should be of form: x y wh' return.
  end.
  'x y w h'=. xywh
  'px py pw ph'=. PRINTWINDOW%1000
  fx=. x + px * w
  fy=. y + py * h
  fw=. (x-fx) + pw * w
  fh=. (y-fy) + ph * h
  fx,fy,fw,fh
end.
)
isi_bmp=: 3 : 0
if. #y do.
  arg=. qchop y
  num=. __ ". &.> arg
  msk=. __ e. &> num
  file=. > {. msk # arg
  wh=. >(-.msk) # num
  if. -. (#wh) e. 0 2 do.
    info 'invalid [w h] parameter in save bmp' return.
  end.
else.
  wh=. file=. ''
end.
file=. file,(0=#file)#ISI_DEFFILE
file=. jpath '.bmp' fext file
if. (2 = #wh) > wh -: Pw,Ph do.
  a=. cocreate''
  coinsert__a (,copath) coname''
  bmp=. isi_getbmpwh__a wh
  coerase a
else.
  bmp=. isi_getbmp''
end.
bmp writebmp file
)
isi_def=: 4 : 0
type=. x
file=. jpath ('.',type) fext (;qchop y),(0=#y) # ISI_DEFFILE
(isi_getrgb'') writeimg file
)
isi_defstr=: 4 : 0
type=. x
(isi_getrgb'') putimg type
)
isi_emf=: 3 : 0
file=. jpath '.emf' fext (;qchop y),(0=#y) # ISI_DEFFILE
wd 'psel ',": PFormhwnd
glsel PId
glfile file
glemfopen''
isi_paint''
glemfclose''
)
isi_getbmp=: 3 : 0
wd 'psel ',": PFormhwnd
glsel PId
box=. 0 ". wd 'qchildxywhx ',PId
res=. glqpixels box
(3 2 { box) $ res
)
isi_getbmpwh=: 3 : 0
wd 'pc a owner;xywh 0 0 240 200;cc g isigraph rightmove bottommove;pas 0 0'
PFormhwnd=: 0 ". wd 'qhwndp'
PId=: 'g'
wd 'setxywhx g 0 0 ',":y
wd 'pshow'
isi_paintx''
glpaint''
res=. isi_getbmp''
wd 'pclose'
res
)
isi_getrgb=: 3 : 0
wd 'psel ',": PFormhwnd
glsel PId
box=. 0 ". wd 'qchildxywhx ',PId
(3 2 { box) $ 256 256 256 #: glqpixels box
)
isi_jpg=: 3 : 0
file=. ''
qual=. 100
if. #y do.
  arg=. qchop y
  num=. __ ". &.> arg
  msk=. +./ &> num = &.> __
  file=. > {. msk # arg
  qual=. <. {. (>(-.msk) # num),qual
end.
file=. jpath '.jpg' fext file,(0=#file) # ISI_DEFFILE
rgb=. isi_getrgb''
rgb writeimg file
)
isi_png=: 3 : 0
file=. ''
comp=. 9
if. #y do.
  arg=. qchop y
  num=. __ ". &.> arg
  msk=. +./ &> num = &.> __
  file=. > {. msk # arg
  comp=. <. {. (>(-.msk) # num),comp
end.
file=. jpath '.png' fext file,(0=#file) # ISI_DEFFILE
rgb=. isi_getrgb''
rgb writeimg file
)
isi_save=: 3 : 0
if. Poutput ~: iISI do.
  msg=. 'First display an isigraph Plot.'
  info msg return.
end.
if. 0=#y do.
  isi_clip'' return.
end.
type=. tolower firstword y
if. (<type) e. ;: 'gif jpg png tif gifr jpgr pngr tifr' do.
  af=. jpath '~addons/media/platimg/platimg.ijs'
  if. -. flexist af do.
    info 'Save to ',type,' requires the platimg addon.' return.
  end.
  require af
end.
('isi_',type)~ (1+#type) }. y
)

isi_get=: 3 : 0
if. #y do.
  type=. tolower firstword y
  if. (<type) e. ;: 'gif jpg png tif' do.
    y=. type,'r ', (#type)}. y
  end.
end.
isi_save y
)
isi_gif=: 'gif' & isi_def
isi_tif=: 'tif' & isi_def
isi_pngr=: 'png' & isi_defstr
isi_jpgr=: 'jpg' & isi_defstr
isi_gifr=: 'gif' & isi_defstr
isi_tifr=: 'tif' & isi_defstr
isi_show=: 3 : 0
popen_isi''
(PForm,'_',PId,'_paint')=: isi_paint
if. PShow=0 do.
  if. VISIBLE do.
    wd 'pshow ',PSHOW
  else.
    wd 'pshow sw_hide'
  end.
  wd 'ptop ',":PTop
  PShow=: 1
end.
isi_paint''
glpaint''
evtloop^:(-.IFJ6)''
)
isi_paint=: 3 : 0
glsel PId
'Cw Ch'=: glqwh''
isi_paintit 0 0,Cw,Ch
)
isi_paintit=: 3 : 0
isi_gpinit''
make iISI;y
ids=. 1 {"1 Plot
fns=. 'isi'&, each ids
dat=. 3 }."1 Plot
for_d. dat do.
  (>d_index{fns)~d
end.
isi_gpapply''
)

coclass 'jzplot'
PDF_DEFSIZE=: 480 360
PDF_DEFFILE=: jpath '~temp/plot.pdf'
JPF_DEFFILE=: jpath '~temp/plot.jpf'
PDF_PENSCALE=: 0.4

CIDFONTS=: 'MSung-Light';'STSong-Light'
endian=. ({.a.)={. 1&(3!:4) 1
toucodem=: ''&,@(1&(3!:4))@(3&u:)@u:
toucoder=: ''&,@:,@:(|."1@(_2: ]\ 1&(3!:4)))@(3&u:)@u:
toucode1=: toucodem`toucoder@.(-.endian) f.
jpf_getparms=: 3 : 0
(PDF_DEFSIZE;JPF_DEFFILE) output_parms y
)
pdf_boxrs2wh=: 3 : 0
a=. 2 {."1 y
b=. 2 }."1 y
(a <. b) ,"1 | a - b
)
pdf_getparms=: 3 : 0
(PDF_DEFSIZE;PDF_DEFFILE) output_parms y
)
pdf_dict=: 3 : 0
if. L. y do.
  s=. ; y ,each <LF
else.
  s=. y , (LF ~: {: y) # LF
end.
'<<',LF,s,'>>',LF
)
pdf_rotxy=: 3 : 0
if. ROT do.
  'px py'=. y
  (Sh-py),px
else.
  y
end.
)
pdf_rotxym=: 3 : 0
if. ROT do.
  'px py'=. |:y
  (Sh-py),.px
else.
  y
end.
)
pdf_wraptext=: 3 : 0
'BT ',y,' ET '
)
pdf_write=: 4 : 0
dat=. x
file=. y
while. _1 -: dat flwrite file do.
  msg=. 'Unable to write to file: ',file,LF,LF
  if. #d=. 1!:0 file do.
    msg=. msg, 'If the file is open in Adobe, close the file and try again.'
    if. 1 query msg do. return. end.
  else.
    info msg,'The file name is invalid.' return. end.
end.
if. VISIBLE do.
  if. -.IFJ6 do.
    viewpdf_j_ file
  else.
    if. 0 = 4!:0 <'PDFReader_j_' do.
      if. #PDFReader_j_ do.
        fork_jtask_ (dquote PDFReader_j_),' ',dquote file
      end.
    end.
  end.
end.
)
bezierarc=: 3 : 0
'x y h a b'=. y
off=. 90
t1=. rfd 360 | a - off
t2=. rfd 360 | b - off
th=. 6 %~ 2p1 | t2 - t1
'c c1 s s1'=. (cos , sin) th,t1
x0=. x1=. 1 [ y0=. 0
'x3 y3'=. c,s
x2=. 3%~ (8*cos-:th)-x0+x3+3*x1
y2=. y3-(-x2-x3)%-tan th
y1=. 3%~ (8*sin-:th)-y0+y3+3*y2
r=. (x0,x1,x2,x3),:y0,y1,y2,y3
r=. r +/ . *~ (c1,-s1),:s1,c1
r=. r (+/ . *)^:(i.6)~ (c,-s),:s,c
,@|:"2 (x,y)+"2 h*r
)
PDF_FONTOBJ=: 0 : 0
<<
/Type /Font
/Subtype /Type1
/Name /FXX
>>
)
PDF_TRAILER=: 0 : 0
trailer
<<
/Size {z}
/Info 1 0 R
/Root 2 0 R
>>
startxref
)
pdf_build=: 3 : 0
PDFFontpages=: pdf_fontpages ''
pdf_wrap (pdf_header''),pdf_page y
)
pdf_creationdate=: 3 : 0
t=. '20', ; _2 {.each '0' ,each ": each <. 6!:0''
'/CreationDate (D:',t,')'
)
pdf_cidfont=: 4 : 0
txt=. LF;<;.2 ". toupper y -. '-'
msk=. 1 = #&> txt
txt=. msk<@;;._1 txt
txt=. (<'<<',LF) ,each txt ,each <'>>',LF
'a b c'=. txt
prev=. x { 3 + 0 0, +/\PDFFontpages
b=. b rplc '%prev';":prev
c=. c rplc '%prev';":prev+1
c=. c rplc '/Name /F';'/Name /F',":x
a;b;c
)
pdf_fonts=: 3 : 0
ndx=. 1 i.~ 'XX' E. PDF_FONTOBJ
hdr=. ndx {. PDF_FONTOBJ
ftr=. (ndx+2) }. PDF_FONTOBJ
r=. ''
for_f. PDFFonts do.
  if. f e. CIDFONTS do.
    r=. r, ( 1+f_index) pdf_cidfont >f
  else.
    fnt=. (": 1 + f_index),LF,'/BaseFont /', >f
    fnt=. fnt,LF,'/Encoding /WinAnsiEncoding'
    r=. r, <hdr, fnt, ftr
  end.
end.
)
pdf_fontpages=: 3 : 0
1 + 2 * PDFFonts e. CIDFONTS
)
pdf_header=: 3 : 0
t=. '/Title (Plot)'
a=. '/Author (',(9!:14''),')'
p=. '/Producer (J Plot)'
d=. pdf_creationdate''
tit=. pdf_dict t;a;p;d
pag=. ": 3 + +/ PDFFontpages
cat=. pdf_dict '/Type /Catalog',LF,'/Pages ',pag,' 0 R',LF
fnt=. pdf_fonts ''
tit;cat;fnt
)
pdf_page=: 3 : 0
kp=. 4 + +/ PDFFontpages
r=. '/Type /Pages',LF
r=. r, pdf_pageheader''
r=. r, '/MediaBox [',(pfmt Pxywh),']',LF
r=. r,'/Kids [',(":kp),' 0 R]',LF
r=. r, '/Count 1',LF
res=. pdf_dict r
r=. '/Type /Page',LF
r=. r,'/Parent ',(":kp-1),' 0 R',LF
r=. r,'/Contents ',(":kp+1),' 0 R',LF
res=. res ; pdf_dict r
t=. y
s=. '<< /Length ',(":#t),' >>',LF
res ,< s,'stream',LF,t,'endstream',LF
)
pdf_pageheader=: 3 : 0
r=. '/Resources',LF,'<<',LF,' /ProcSet [/PDF /Text]',LF
r=. r,' /Font <<',LF
fx=. ' /F'&, &> ": each 1 + i.#PDFFonts
px=. ' ',. ": &> 2 + +/\ PDFFontpages
r=. r, ,fx ,"1 px ,"1 ' 0 R',LF
r=. r,' >>',LF,'>>',LF
)
pdf_wrap=: 3 : 0
z=. ": 1 + #y
r=. '%PDF-1.3',LF
r=. r, '%', (a. {~128 + a. i. 'elmo'),LF
s=. 'xref',LF,'0 ',z,LF
s=. s,(10#'0'),' 65535 f ',LF

for_i. i.#y do.
  s=. s,(_10 {.!.'0' ": #r),' 00000 n ',LF
  c=. LF,(>i{y)
  r=. r,(":1+i),' 0 obj',c,'endobj',LF,LF
end.
ndx=. I. '{z}' E. PDF_TRAILER
tr=. (ndx {. PDF_TRAILER), z, (ndx+3) }. PDF_TRAILER
r,s,LF,tr,(":#r),LF,'%%EOF'
)
MSUNGLIGHT=: 0 : 0
/Type /FontDescriptor
/FontName /MSung-Light
/Flags 5
/FontBBox [ -260 -174 1043 826 ]
/MissingWidth 600
/StemV 93
/ItalicAngle 0
/CapHeight 625
/Ascent 826
/Descent -174

/Type /Font
/Subtype /CIDFontType0
/BaseFont /MSung-Light
/FontDescriptor %prev 0 R
/CIDSystemInfo << /Registry (Adobe)/Ordering (CNS1)/Supplement 4 >>
/DW 1200
/W [ 1 255 600 ]

/Type /Font
/Subtype /Type0
/Name /F
/BaseFont /MSung-Light
/DescendantFonts [ %prev 0 R ]
/Encoding /UniCNS-UCS2-H
)
STSONGLIGHT=: 0 : 0
/Type /FontDescriptor
/FontName /STSong-Light
/Flags 5
/FontBBox [ -260 -174 1043 826 ]
/MissingWidth 600
/StemV 93
/ItalicAngle 0
/CapHeight 625
/Ascent 826
/Descent -174

/Type /Font
/Subtype /CIDFontType0
/BaseFont /STSong-Light
/FontDescriptor %prev 0 R
/CIDSystemInfo << /Registry (Adobe)/Ordering (GB1)/Supplement 4 >>
/DW 1200
/W [ 1 255 600 ]

/Type /Font
/Subtype /Type0
/Name /F
/BaseFont /STSong-Light
/DescendantFonts [ %prev 0 R ]
/Encoding /UniGB-UCS2-H
)
pdf_circle=: 3 : 0
'x y r'=. y
arc=. _2 [\ 0 1 2 1 1 2 1 0 { 0 1, 4r3*<:%:2
arr=. |."1 arc *"1 [ _1 1
mat=. _4 ,\ arc,arr,-arc,arr
(mat * r) + ($mat) $ x,y
)

pdf_colorstroke=: 3 : 0
(": y % 255),"1 ' RG '
)
pdf_colorfill=: 3 : 0
(": y % 255),"1 ' rg '
)
pdf_color=: 3 : 0
clr=. ": y % 255
clr ,"1 ' RG ' ,"1 clr ,"1 ' rg '
)
pdf_makelines=: 3 : 0
if. 2 > #$y do.
  ,: (pfmt 2 {. y),' m ',,(pfmt _2 [\ 2 }. y) ,"1 ' l '
else.
  mov=. (pfmt 2 {."1 y) ,"1 ' m '
  lns=. ,"2 (pfmt _2 [\"1 [ 2 }."1 y) ,"1 ' l '
  mov,.lns
end.
)
pdf_pens=: 4 : 0
(pdf_color x) ,"1 (":,.PDF_PENSCALE*y) ,"1 ' w '
)
pdf_pen=: 4 : 0
(pdf_color ,x), (":PDF_PENSCALE*y) ,' w '
)
pdf_lines=: 3 : 0
(pdf_makelines y) ,"1 ' S'
)
pdf_text=: 4 : 0
0 pdf_text y
:
'fnt clr txt pos align rot und'=. y

clr=. pdf_color clr

txt=. ,each boxopen txt
if. und +. align e. iCENTER, iRIGHT do.
  len=. fnt pgetstringlen txt
end.
if. x do.
  txt=. toucode1@(7&u:) each txt
else.
  txt=. u2a each txt
end.

txt=. pdfesc each txt
select. rot

case. 0 do.
  select. align
  case. iCENTER do.
    pos=. pos -"1 (-:len),.0
  case. iRIGHT do.
    pos=. pos -"1 len,.0
  end.
  txt=. (<' Tm (') ,each txt ,each <') Tj '
  res=. clr,(<"1 '1 0 0 1 ' ,"1 pfmt pos >. 0) ,&> txt
case. 1 do.
  select. align
  case. iCENTER do.
    pos=. pos -"1 [ 0,.-:len
  case. iRIGHT do.
    pos=. pos -"1 [ 0,.len
  end.
  txt=. (<' Tm (') ,each txt ,each <') Tj '
  res=. clr,(<"1 '0 1 -1 0 ' ,"1 pfmt pos >. 0) ,&> txt
case. 2 do.
  select. align
  case. iCENTER do.
    pos=. pos +"1 [ 0,.-:len
  case. iRIGHT do.
    pos=. pos +"1 [ 0,.len
  end.
  txt=. (<' Tm (') ,each txt ,each <') Tj '
  res=. clr,(<"1 '0 -1 1 0 ' ,"1 pfmt pos >. 0) ,&> txt
end.
if. -. und do. res;'' return. end.
pos=. citemize pos
len=. , len

'off lwd'=. getunderline fnt
lin=. clr,' ',(":lwd) ,' w '

select. rot
case. 0 do.
  bgn=. 0 >. pos -"1 [ 0,.-off
  end=. bgn + len,.0
case. 1 do.
  bgn=. 0 >. pos -"1 off,.0
  end=. bgn + 0,.len
case. 2 do.
  bgn=. 0 >. pos +"1 off,.0
  end=. bgn - 0,.len
end.

lin=. lin,(pdf_makelines bgn,.end) ,"1 ' b'
res;lin

)
pdfcircle=: 3 : 0
'v s f e c p'=. y
if. isempty c do.
  if. is1color e do.
    pbuf e pdf_pen v
    clr=. (#p) $ citemize pdf_color e
    for_i. i.#p do.
      pbuf i{clr
      pos=. pdf_circle i{p
      mov=. (pfmt 2 {. {. pos) , ' m '
      pbuf mov
      crv=. (pfmt 2 }."1 pos) ,"1 ' c '
      pbuf crv
      pbuf 'S'
    end.
  end.
end.
)
pdfdot=: 3 : 0
'v s f e c p'=. y
pbuf e pdf_pen v
for_i. i.#p do.
  pos=. pdf_circle (i{p), v
  pbuf (pfmt 2 {. {. pos) , ' m '
  pbuf (pfmt 2 }."1 pos) ,"1 ' c '
  pbuf 'B'
end.
)
pdffxywh=: 3 : 0
p=. _1 pick y
if. #p do.
  PDFClip=: >: PDFClip
  pbuf 'q ',(":p),' re W n'
else.
  if. PDFClip do.
    PDFClip=: <: PDFClip
    pbuf 'Q'
  end.
end.
)
pdfline=: 3 : 0
'v s f e c p'=. y
if. (is1color e) *. 1 = #s do.
  pbuf e pdf_pen v
  pbuf pdf_lines p
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  pen=. e pdf_pens v
  pbuf pen ,. pdf_lines p
end.
)
pdfmarker=: 3 : 0
's m f e c p'=. y
pbuf e pdf_pen 1
s ('pdfmark_',m)~ citemize p
)
pdfpie=: 3 : 0
'v s f e c p'=. y
pbuf e pdf_pen v
clr=. (pdf_colorfill c),"1 pdf_colorstroke e
clr=. (#p) $ citemize clr
for_i. i.#p do.
  pbuf i{clr
  pos=. bezierarc i{p
  pbuf (pfmt 2{.i{p), ' m ',(pfmt 2{.{.pos),' l '
  pbuf (pfmt 2}."1 pos),"1 ' c '
  pbuf 'b'
end.
)
pdfpline=: 3 : 0
'v s f e c p'=. y
if. *./ s = 0 do.
  pdfline y return.
end.
s=. s { PENPATTERN
if. (is1color e) *. 1 = #v do.
  pos=. s linepattern"0 1 p
  pdfline (<pos) _1 } y
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  s=. rws $ s
  for_i. i.#p do.
    pos=. (i{s) linepattern i{p
    pdfline (i{v);0;0;(i{e);0;pos
  end.
end.
)
pdfpoly=: 3 : 0
'v s f e c p'=. y
if. v=0 do. e=. c end.
c=. citemize c
e=. citemize e
pbuf ({.e) pdf_pen v
pos=. (pdf_makelines p) ,"1 (v=0) pick ' b';' h f'
if. (1 = # ~.e) *. 1 = # ~.c do.
  pbuf (pdf_colorfill {.c), pdf_colorstroke {.e
  pbuf pos
else.
  c=. pos cmatch pdf_colorfill c
  e=. pos cmatch pdf_colorstroke e
  pbuf c,.e,.pos
end.
)
pdfrect=: 3 : 0
'v s f e c p'=. y
p=. pdf_boxrs2wh p
if. v=0 do.
  clr=. (pdf_colorfill c),"1 pdf_colorstroke c
else.
  pbuf e pdf_pen v
  clr=. (pdf_colorfill c),"1 pdf_colorstroke e
end.
pbuf clr ,"1 (pfmt p) ,"1 ' re B'
)
pdftext=: 3 : 0
't f a e c p'=. y
'fnx fst fsz fan und'=. f
rot=. 3 | 0 90 270 i. fan
asc=. pgetascender f
fnm=. <getfntname fnx,fst
PDFFonts=: ~. PDFFonts,fnm
fnx=. 1 + PDFFonts i. fnm
txt=. '/F',(":fnx),' ',(": getplotfontsize f),' Tf '
select. rot
case. 0 do. p=. 0 >. p -"1 [ 0, asc
case. 1 do. p=. p +"1 asc, 0
case. 2 do. p=. p -"1 asc, 0
end.

lin=. ''
if. is1color e do.
  'rtxt rlin'=. (fnm e. CIDFONTS) pdf_text f;e;t;p;a;rot;und
  txt=. txt,,LF ,"1 rtxt
  lin=. lin,rlin,(0<#rlin)#LF
else.
  for_i. i.#e do.
    'rtxt rlin'=. (fnm e. CIDFONTS) pdf_text f;(i{e);(i{t);(i{p);a;rot;und
    txt=. txt,,LF ,"1 rtxt
    lin=. lin,rlin,(0<#rlin)#LF
  end.
end.
pbuf pdf_wraptext txt
pbuf rlin
)
PDFESC0=: LF,CR,TAB,FF,(8{a.),'\()'
PDFESC1=: 'nrtfb\()'
PDFASC=: PDFESC0,32}.127{.a.
pdfesc=: 3 : 0
txt=. y
msk=. txt e. PDFESC0
if. 1 e. msk do.
  ndx=. , ((I. msk) + i. +/ msk) +/ 0 1
  new=. ,'\',.PDFESC1 {~ PDFESC0 i. msk#txt
  txt=. new ndx } (1 + msk) # txt
end.
msk=. -. txt e. PDFASC
if. 1 e. msk do.
  new=. 1 ": 8 8 8 #: a. i. msk # txt
  ndx=. ,((I. msk) + 3 * i. +/ msk) +/ i. 4
  txt=. (,'\',"1 new) ndx } (1 + msk * 3) # txt
end.

txt
)
pdfmark_circle=: 4 : 0
s=. 3.5 * x
p=. y ,. s
for_d. p do.
  pos=. pdf_circle d
  pbuf (pfmt 2 {. {. pos) , ' m '
  pbuf (pfmt 2 }."1 pos) ,"1 ' c '
  pbuf 'B'
end.
)
pdfmark_diamond=: 4 : 0
p=. 8 $"1 y
d=. (3.5 * x) * _1 0 0 1 1 0 0 _1
p=. p +"1 d
pbuf (pdf_makelines p) ,"1 ' b'
)
pdfmark_line=: 4 : 0
'x y'=. , y
p=. (x--:KeyLen),(y--:KeyPen),KeyLen,KeyPen
pbuf (pfmt p) ,"1 ' re B'
)
pdfmark_plus=: 4 : 0
s=. 0, x * 4
t=. |. s
p=. (y -"1 t) ,. y +"1 t
p=. p, (y -"1 s) ,. y +"1 s
pbuf (":PDF_PENSCALE * 5 * x) , ' w '
pbuf (pdf_makelines p) ,"1 ' b'
)
pdfmark_square=: 4 : 0
s=. 3 * x
p=. (y - s) ,"1 +: s,s
pbuf (pfmt p) ,"1 ' re B'
)
pdfmark_times=: 4 : 0
s=. _1 + 3 * x
p=. y
r=. (p - s) ,. p + s
s=. (p +"1 s * 1 _1) ,. p +"1 s * _1 1
pbuf (":PDF_PENSCALE * 5 * x) , ' w '
pbuf (pdf_makelines r,s) ,"1 ' b'
)
pdfmark_triangle=: 4 : 0
p=. 6 $"1 y
d=. (4 * x) * , (sin,.cos) 2p1 * 0 1 2 % 3
p=. p +"1 d
pbuf (pdf_makelines p) ,"1 ' b'
)
pdf_get=: 3 : 0
'size file ctx'=. 3{. pdf_getparms y
pdf_make size
)
pdf_jpf=: 3 : 0
'size file ctx'=. 3{. jpf_getparms y
txt=. pdf_make size
size=. ":size
fnt=. ; PDFFonts ,each ','
top=. ; (size;fnt) ,each ';'
txt=. top,LF,txt
res=. txt flwritenew file
if. _1 -: res do.
  info 'Unable to write to file: ',file
end.
)
pdf_show=: 3 : 0
'size file ctx'=. 3{. pdf_getparms y
res=. pdf_make size
res=. pdf_build res
res pdf_write file
)
pdf_make=: 3 : 0
make iPDF;0 0,y
fns=. 'pdf'&, each 1 {"1 Plot
dat=. 3 }."1 Plot
buf=: ''
PDFFonts=: ,<'Helvetica'
PDFClip=: 0
for_d. dat do.
  (>d_index{fns)~d
end.
buf
)
coclass 'jzplot'
plot_area=: 3 : 0

'x y'=. 2 {. y { Data

if. 1 e. 0 > ,y do.
  signal 'area plot y-values should not be negative'
end.

x=. get01x x
y=. get01y y
clr=. getitemcolor #y

for_d. y do.
  pts=. fitgrafxy x makearea d
  drawpoly iDATA;EDGECOLOR;EDGESIZE;(d_index{clr);,pts
end.

)
makearea=: 4 : 0
(x ,. y),1 0,0 0,:0,{.y
)
plot_bar=: 3 : 0
'x y'=. 2 {. y { Data
dat=. citemize y
pos=. makebar dat
pos makedrawbar dat
)
plot_fbar=: 3 : 0
'x y'=. 2 {. y { Data
dat=. citemize y
pos=. makestackbar dat
pos=. ({:$dat) }. pos
dat=. }. dat
pos makedrawbar dat
)
plot_fbarv=: 3 : 0
'x y'=. 2 {. y { Data
dat=. citemize y
pos=. makestackbar |. dat
pos=. ({:$dat) }. pos
dat=. }. dat
pos makedrawbarv dat
)
plot_sbar=: 3 : 0
'x y'=. 2 {. y { Data
dat=. citemize y
pos=. makestackbar dat
pos makedrawbar dat
)
plot_sbarv=: 3 : 0
'x y'=. 2 {. y { Data
dat=. citemize y
pos=. makestackbar |.dat
pos makedrawbarv dat
)
makedrawbar=: 4 : 0
pos=. x
dat=. y
'r c'=. $dat
if. r=1 do.
  drawrect iDATA;EDGECOLOR;EDGESIZE;(ITEMCOLOR {~ 0 >, dat);pos
else.
  clr=. r $ ITEMCOLOR
  pos=. (-c) ,\ pos
  for_p. pos do.
    drawrect iDATA;EDGECOLOR;EDGESIZE;(p_index{clr);_4 [\ p
  end.
end.
)
makedrawbarv=: 4 : 0
pos=. x
dat=. y
'r c'=. $dat
if. r=1 do.
  drawrect iDATA;EDGECOLOR;EDGESIZE;(|.ITEMCOLOR {~ 0 >, dat);pos
else.
  clr=. |. r $ ITEMCOLOR
  pos=. (-c) ,\ pos
  for_p. pos do.
    drawrect iDATA;EDGECOLOR;EDGESIZE;(p_index{clr);_4 [\ p
  end.
end.
)
makebar=: 3 : 0
dat=. ,y
'r c'=. $y
w=. Gw * BARWIDTH % r * c
t=. Gw * -: (-.BARWIDTH) % c
if. r=1 do.
  x=. Gw * }: int01 c
else.
  x=. ,(w * i.r) +/ Gw * }: int01 c
end.
x=. Gx + x + t
if. YDiv=0 do.
  h=. (dat-YMin) % YMax-YMin
elseif. YDiv=1 do.
  h=. (dat-YMax) % YMax-YMin
elseif. do.
  h=. dat % (YMax%1-YDiv) >. |YMin%YDiv
end.
h=. Gh * h
y=. Gy + Gh * YDiv
x,.y,.(x+w),.y+h
)
makestackbar=: 3 : 0
dat=. ,y
if. 1 e. 0 > dat do.
  signal 'stackbar values should not be negative'
end.
'r c'=. $y
wid=. BARWIDTH
w=. Gw * wid % c
t=. Gw * -: (-.wid) % c
h=. Gh * y % YMax
y=. Gy + ,+/\ h
x=. Gx + ($y) $ t + Gw * }: int01 c
x,.y,.(x+w),.y-,h
)
CONTRI=: 0 1 4, 0 2 4, 1 4 3,: 2 4 3
CONPTS=: 0 0 1 0 0.5 0.5, 0 0 0 1 0.5 0.5, 1 0 0.5 0.5 1 1,: 0 1 0.5 0.5 1 1
plot_contour=: 3 : 0

'x y z'=. y { Data

signal^:(2 ~: #$z) 'need data matrix for contour plot'

dat=. |: z
'rws cls'=. shape=. $dat
dat=. ,dat
min=. <./dat
max=. >./dat
dat=. (CONTOURLEVELS + 1) * (dat - min) % max - min
ndx=. ,/ 2 2 ,;._3 i. shape
dat=. |: ndx { dat
lvl=. *./ dat ="1 <.{. dat
dat=. dat, (lvl * 0.001) + 0.25 * +/ dat
dat=. ,/ 0 1 |: CONTRI { dat
xy=. 4 # ((#ndx) $ (i.cls-1)),.(cls-1) # i.rws-1
txy=. xy,.(#dat) $ 0 1 2 3
msk=. +./"1 (~:{."1) <. dat
txy=. msk # txy
dat=. msk # dat
mat=. (<.dat),.dat,.txy
res=. i.0 0
for_m. mat do.
  res=. res, contri m
end.
lvl=. {."1 res
pos=. }."1 res
pos=. pos % ($pos) $ <: |. shape
pos=. fitgrafxy pos
clr=. getbandcolor lvl
drawline iDATA;clr;PENSIZE;pos
)
contri=: 3 : 0
'l0 l1 l2 v0 v1 v2 x y i'=. y
pts=. i { CONPTS
min=. <./ l0,l1,l2
max=. >./ l0,l1,l2
lvl=. min + 1 + i. max-min
ndx=. (#. lvl >:/ v0,v1,v2) { 0 0 1 2 2 1 0 3
res=. i.0 5
for_lv. lvl do.
  select. lv_index { ndx
  case. 0 do.
    res=. res, contri1 lv,v0,v1,v2,pts
  case. 1 do.
    res=. res, contri1 lv,v0,v2,v1,0 1 4 5 2 3 { pts
  case. 2 do.
    res=. res, contri1 lv,v1,v2,v0,2 3 4 5 0 1 { pts
  case. 3 do.
  end.
end.
res + 0 ,. (0 _1 + $res) $ x,y
)
contri1=: 3 : 0
'lvl v0 v1 v2 x0 y0 x1 y1 x2 y2'=. y
p=. (lvl - v0) % v2 - v0
q=. (lvl - v1) % v2 - v1
lvl, ((p * x2,y2) + (-.p) * x0,y0), (q * x2,y2) + (-.q) * x1,y1
)
plot_density=: 3 : 0

'x y z'=. y { Data

signal^:(2 ~: #$z) 'need data matrix for density plot'

j=. {(int01 #x);int01 #y
pos=. fitgrafxy ,/ ,"2 tiles >j

j=. (#BANDCOLOR) ncile ,z
clr=. j { BANDCOLOR
drawpoly iDATA;EDGECOLOR;(EDGESIZE*MESH);clr;pos
)
plot_dot=: 3 : 0
dat=. getgrafmat y
clr=. getitemcolor #dat
for_d. dat do.
  drawdot iDATA;(d_index{clr);PENSIZE;_2[\d
end.
)

plot_point=: plot_dot
plot_errorbar=: 3 : 0

'x y'=. getgrafxy y
'r c'=. $y

if. r ~: 3 do.
  signal 'errorbar data should have 3 rows'
end.

'hi mid lo'=. y
j=. ,./x,."1 [ hi ,: lo
k=. _3 0 3 0 +"1 ,.~ _2[\,j
errorbar=. j,k

xm=. ,x,.mid

clr=. getitemcolor 1
drawline iDATA;clr;PENSIZE;xm
drawline iDATA;clr;PENSIZE;errorbar
)
plot_hilo=: 3 : 0
'x y'=. getgrafxy y
'r c'=. $y
ifclose=. 3=r
'hi lo close'=: 3$y
clr=. getitemcolor 2
hilo=. ,./x,."1 [ 2{.y
drawline iDATA;({.clr);PENSIZE;hilo
if. ifclose do.
  close=. ,x,.{:y
  drawline iDATA;({.clr);PENSIZE;close
end.
)
plot_hist=: 3 : 0
'x y'=. 2 {. y { Data
dat=. citemize y
'r c'=. $dat
if. r ~: 1 do.
  signal 'Histogram should have only one data set.'
end.
pos=. makehist dat
drawrect iDATA;EDGECOLOR;EDGESIZE;(ITEMCOLOR {~ 0 >, dat);pos
)
makehist=: 3 : 0
dat=. ,y
'r c'=. $y
w=. Gw % c
x=. Gw * }: int01 c
x=. Gx + x
if. YDiv=0 do.
  h=. (dat-YMin) % YMax-YMin
elseif. YDiv=1 do.
  h=. (dat-YMax) % YMax-YMin
elseif. do.
  h=. dat % (YMax%1-YDiv) >. |YMin%YDiv
end.
h=. Gh * h
y=. Gy + Gh * YDiv
x,.y,.(x+w),.y+h
)
plot_line=: 3 : 0
dat=. getgrafmat y
clr=. getitemcolor #dat
if. *./ PENSTYLE=0 do.
  drawline iDATA;clr;PENSIZE;dat
else.
  sty=. PENSTYLE $~ #dat
  drawpline iDATA;sty;clr;PENSIZE;dat
end.
)
MarkerNames=: ;: 'diamond square circle triangle plus times'
KeyMarkerNames=: MarkerNames,<'line'
plot_marker=: 3 : 0
dat=. getgrafmat y
clr=. getitemcolor #dat
if. #MARKERS do.
  nms=. MARKERS { MarkerNames
else.
  nms=. MarkerNames
end.
mrk=. ((#nms) | i. #dat) { nms
for_d. dat do.
  drawmarker iDATA;(MarkerScale*MARKERSIZE);(d_index{clr);(d_index{mrk),<_2 [\ d
end.
)
plot_pie=: 3 : 0
YCaption=: ; YCAPTION
'x y'=. 2 {. y { Data
if. 1 = #y do.
  plot_pied y
else.
  plot_piem y
end.
)
plot_pied=: 3 : 0
dat=. 360 | 90 - 0, 360 * (%{:) +/\ , y
if. PIEPERCENT *. 0=#XLABEL do.
  XLabel=: getpiepercent ,y
else.
  XLabel=: XLABEL
end.
if. #YCaption do.
  'w h'=. CaptionFont pgetextent1 YCaption
  cx=. Lx + -: Lw - w
  cy=. Ly + Lh - MSubTitle
  setgxywh Gxywh shrinkrect 0 0 0,h+3*MSubTitle
end.
if. #XLabel do.
  'pxy tic'=. makefitpie dat
  drawtext iXLABEL;iLEFT;LabelFont;BLACK;XLabel;pxy
  drawline iXTICS;BLACK;GUIDESIZE;tic
end.
rad=. -: Gw <. Gh
org=. (Gx,Gy) + -: Gw,Gh
dat=. (org, rad),"1 [ 2 |.\ dat
clr=. getitemcolor #dat
drawpie iDATA;EDGECOLOR;EDGESIZE;clr;dat
if. #YCaption do.
  xlab=. (0<#XLabel) * MSubTitle + {: LabelFont pgetextent1 'X'
  xcap=. {: CaptionFont pgetextent1 'X'
  cy=. cy <. ({:org) + rad + MPie + xlab + xcap
  drawtext iYCAPTION;iLEFT;CaptionFont;BLACK;YCaption;cx,cy
end.
)
makefitpie=: 3 : 0
dat=. rfd y
'lw lh'=. LabelFont pgetextent XLabel
lh=. {.lh
bgn=. }: dat
end=. }. dat
mid=. -: bgn + end - 2p1 * end > bgn
rhw=. |."1 +. r. mid
'rw rh'=. 1 _1 * |: rhw
pos=. 2 {."1 fitpie lw;lh;rw;rh;mid
tic=. drawpietics rw,.rh
pos;tic
)
fitpie=: 3 : 0

'lw lh rw rh mid'=. y
while. 1 do.
  rad=. <. -: <./ _2 {. Gxywh
  pad=. rad + MPie

  msk=. MPie <: (-:lh) + | pad * -. cos mid
  int=. lw * (-:-.msk) + msk * (mid<0) +. mid>1p1
  px=. (Gx+-:Gw) + (rw * pad) - int
  py=. (Gy+-:Gh) + (rh * pad) - -:lh
  pos=. px,.py,.lw,.lh
  if. 1 = fitpielabels pos do. continue. end.
  'rc pos'=. movepielabels pos
  if. rc do.
    if. 1 = fitpielabels pos do. continue. end.
  end.
  break.
end.
(0,lh,0 0) +"1 pos
)
fitpielabels=: 3 : 0
'x y w h'=. |: y

bx=. 0 >. Lx - <./x
ex=. 0 >. (>./x+w) - Lx + Lw
by=. 0 >. Ly - <./y
ey=. 0 >. (>./y+h) - Ly + Lh

be=. bx,by,ex,ey
if. 0 = +/be do. 0 return. end.

mw=. 0 >. Gw - MinPie
if. mw < bx + ex do.
  'bx ex'=. (bx,ex) * mw % bx + ex
end.

mh=. 0 >. Gh - MinPie
if. mh < by + ey do.
  'by ey'=. (by,ey) * mh % by + ey
end.

be=. bx,by,ex,ey
if. 0 = +/be do. 0 return. end.

setgxywh Gxywh shrinkrect >. be

1
)
getpiepercent=: 3 : 0
dat=. 100 * y % +/y
val=. 1 rounddist dat
txt=. (":each val) ,each '%'
)
plot_piem=: 3 : 0

dat=. y
if. #YCAPTION do.
  ycap=. boxarg YCAPTION
  if. 1=#ycap do.
    ycap=. (#dat) $ ycap
  else.
    if. (#dat) ~: #ycap do.
      info 'Y Captions do not match number of pie charts' return.
    end.
  end.
  'cw ch'=. CaptionFont pgetextent ycap
  cw=. >./cw
  ch=. ({.ch) + +: MSubTitle
else.
  cw=. ch=. 0
  ycap=. (#dat) # <''
end.
len=. #dat
rws=. 1 + i. len
cls=. >. len % rws
msk=. cw <: Lw % cls
rws=. msk#rws
cls=. msk#cls
ndx=. (i.>./) (Lw%cls) <. Lh%rws
rws=. ndx{rws
cls=. ndx{cls
wid=. <. Lw % cls
hit=. <. Lh % rws
OLxywh=: Lxywh
xy=. ((rws*cls)$Lx + wid*i.cls),.cls#Ly + hit*i.-rws
lxywh=. len {. xy,"1 wid,hit
lxywh=. lxywh shrinkrect"1 MPie
if. PIEPERCENT < 0 = #XLABEL do.
  gxywh=. lxywh shrinkrect"1 [ 0 0 0,ch
else.
  setlxywh {. lxywh
  getpieframes''
  setgxywh Lxywh shrinkrect 0 0 0,ch
  r=. i. 0 4
  for_d. dat do.
    deg=. 360 | 90 - 0, 360 * (%{:) +/\ d
    if. PIEPERCENT do.
      XLabel=: getpiepercent d
    else.
      XLabel=: XLABEL
    end.
    makefitpie deg
    r=. r,Gxywh
  end.
  xy=. >./2 {."1 r
  off=. xy - 2 {. Lxywh
  wh=. (<./(2 {."1 r) + 2 }."1 r) - xy
  gxywh=. (off +"1 [ 2 {."1 lxywh) ,"1 wh
end.
for_d. dat do.
  YCaption=: d_index pick ycap
  setlxywh d_index { lxywh
  getpieframes''
  setgxywh d_index { gxywh
  plot_pied d
end.
Lxywh=: OLxywh
)
plot_poly=: 3 : 0
dat=. getgrafmat y
clr=. getitemcolor #dat
drawpoly iDATA;EDGECOLOR;EDGESIZE;clr;dat
)
plot_radar=: 3 : 0

dat=. 1 pick y { Data
dat=. YRANGE fit01"1 dat

rad=. -: Gw <. Gh
org=. (Gx,Gy) + -: Gw,Gh

RTIC=: 2{. RTIC,(#RTIC)}.3 1

if. {.GRIDS do.
  grd=. org ,"1 0 [ rad * }. int01 {.RTIC
  drawcircle iXGRID;GRIDCOLOR;EDGESIZE;'';grd
end.

if. {.AXES do.
  pts=. fitgrafxy makeradaraxes dat
  drawline iXAXIS;FORECOLOR;EDGESIZE;pts
end.

pts=. fitgrafxy makeradar dat
clr=. getitemcolor #pts
sty=. PENSTYLE $~ #pts
drawpline iDATA;sty;clr;PENSIZE;pts
)
makeradar=: 3 : 0
dat=. |:y
xy=. cleanz (cos ,. sin) +: o. int01 #dat
r=. ,"2 [ 0 1 |: xy */"1 dat, {. dat
0.5 * 1 + r
)
makeradaraxes=: 3 : 0
if. {.TICS do.
  'maj min'=. RTIC
  len=. maj * >: min
  pos=. }.int01 len
  tic=. TICMINOR,(0={.GRIDS)*TICMAJOR
  mark=. len$(min,1)#500 %~ tic
  pts=. 0 0 0 1, 0 ,. pos ,. mark,. pos
else.
  pts=. ,:0 0 0 1
end.
f=. ((cos,sin),:-@sin,cos)"0
s=. f o. +: }:int01 {:$y
pts=. ,/ ,"2 [ 1 |: s mp 0 1 |: _2 [\"1 pts
pts=. 0.5 * 1 + pts
)
plot_stick=: 3 : 0
dat=. getgrafmat y
dat=. _2 (4&$)\ ,dat
ydiv=. fitgrafy YDiv
dat=. ydiv 3 }"1 dat
drawline iDATA;(getitemcolor #dat);PENSIZE;dat
)
plot_symbol=: 3 : 0
dat=. getgrafmat y
clr=. getitemcolor #dat
font=. SymbolFont
if. Poutput e. iISI,iGTK,iANDROID,iCANVAS,iCAIRO do.
  sym=. utf8 each ucp text2utf8 SYMBOLS
else.
  sym=. <&> text2ascii8 SYMBOLS
end.

off=. 0,.-:{:SymbolFont pgetextent sym
dat=. dat + ({:$dat) $"1 (#dat)$off
chr=. (#dat)$sym
for_d. dat do.
  drawtext iDATA;iCENTER;font;(d_index{clr);(d_index{chr),<_2 [\ d
end.
)
coclass 'jzplot'
plot3d_dot=: 3 : 0

'x y z'=. y { Data

dat=. 1 |: (x ,: y),"2 1 citemize z
dat=. }:"1 project dat
dat=. ,"2 dat

rws=. #dat
cls=. {:$dat
clr=. getitemcolor #dat

rws=. 1

while. #dat do.
  drawcircle iDATA;({.clr);4;({.clr);1;_2[\{.dat
  dat=. }.dat
  clr=. 1|.clr
end.
)

plot3d_point=: plot3d_dot
plot3d_line=: 3 : 0

'x y z'=. y { Data

dat=. 1 |: (x ,: y),"2 1 citemize z
shape=. $dat
dat=. shape $ , project ,/dat
dat=. _2[\ ,}:"1 dat
dat=. fitgrafxy3d dat
dat=. (-+:1{shape) [\ ,dat

clr=. getitemcolor #dat

if. *./ PENSTYLE=0 do.
  drawline iDATA;clr;PENSIZE;dat
else.
  sty=. PENSTYLE $~ #dat
  drawpline iDATA;sty;clr;PENSIZE;dat
end.
)
plot3d_poly=: 3 : 0

'x y z'=. y { Data

dat=. x ,"0 1 y ,"0 z
vert=. 1{$dat
dat=. ($dat) $ , project ,/dat
dat=. dat #~ facing dat

dist=. {:"1 dat
dat=. }:"1 dat

near=. ~.(<.-:#,dist){.sort ,dist

ndx=. /: +/"1 dist e. near
dat=. ndx{dat
dist=. ndx{dist

ndx=. \:+/"1 dist
dist=. ndx{dist
dat=. ndx{dat

dat=. ,/ dat
dat=. fitgrafxy3d dat
dat=. (-vert),\ dat


clr=. getitemcolor blockcount dat
drawpoly iDATA;EDGECOLOR;EDGESIZE;clr;dat
)
plot3d_stick=: 3 : 0

'x y z'=. conform3d y { Data
dat=. x ,"0 1 y ,"0 z
minz=. ZInt <. <./ , {:"1 dat
bas=. minz 2}"1 dat
dat=. bas ,"1 dat
dat=. ,/ _3 [\"1 dat
dat=. project ,/dat
dat=. fitgrafxy3d }:"1 dat
dat=. _2 ,\ dat
drawline iDATA;(getitemcolor'');PENSIZE;dat
)
plot3d_surface=: 3 : 0
'x y z'=. conform3d y { Data
pos=. x ,"0 1 y ,"0 z
pos=. ($pos) $ ,project ,/ pos
zpos=. ,tilesum z
dpos=. ,tilesum {:"1 pos
ndx=. \:dpos
pos=. ,/,/ tiles }:"1 pos
pos=. fitgrafxy3d pos
pos=. _8[\,pos
pos=. ndx{pos

j=. ndx { (#BANDCOLOR) ncile zpos
clr=. j { BANDCOLOR

drawpoly iDATA;EDGECOLOR;(MESH*EDGESIZE);clr;pos
)
plot3d_wire=: 3 : 0
'x y z'=. conform3d y { Data
pos=. x ,"0 1 y ,"0 z
if. PStyle has 'clear' do.
  pos=. pos,0 2 |: pos
  shape=. $pos
  pos=. shape $ ,project ,/ pos
  pos=. _2[\ ,}:"1 pos
  pos=. fitgrafxy3d pos
  pos=. (-+:1{shape) [\ ,pos
  drawline iDATA;(getitemcolor 1);EDGESIZE;pos

else.
  pos=. ($pos) $ ,project ,/ pos
  zpos=. ,tilesum z
  dpos=. ,tilesum {:"1 pos
  ndx=. \:dpos
  pos=. ,/,/ tiles }:"1 pos
  pos=. fitgrafxy3d pos
  pos=. _8[\,pos
  pos=. ndx{pos

  j=. ndx { (#BANDCOLOR) ncile zpos
  clr=. j { BANDCOLOR
  drawpoly iDATA;clr;EDGESIZE;BACKCOLOR;pos

end.

)

