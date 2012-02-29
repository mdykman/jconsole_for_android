require 'bmp color16 gtk gl2'

coclass 'jzgraph'
coinsert 'jgl2'

GDLOC=: <''
GDIDS=: 0 3 $ <''
EMPTY=: i. 0 0
create=: 3 : 0
window=: 0
reset''
)
reset=: 3 : 0
GDCMD=: i.0 2
)
destroy=: 3 : 0
gddel window
gtk_widget_destroy_jgtk_ ::0: window
codestroy''
)
index=: #@[ (| - =) i.
intersect=: e. # [
roundint=: <.@:+&0.5
flipyarc=: 3 : 0
y=. _8[\,y
c=. H - (+/"1 [ 1 3{"1 y) ,. 5 7{"1 y
($y) $ ,c 1 5 7}"1 y
)
flipxy=: 3 : 0
s=. $y
(s $ 0, H) + y * s $ 1 _1
)
flipyrect=: 3 : 0
y=. _4 [\, y
c=. H - +/"1 [ 1 3{"1 y
($y) $ ,c 1}"0 1 y
)
gettemp=: 3 : 0
p=. jpath '~temp\'
d=. 1!:0 p,'*.',y
a=. 0, {.@:(0&".)@> _4 }. each {."1 d
a=. ": {. (i. >: #a) -. a
p,a,'.',y
)
initdef=: 3 : 0
PEN=: 1
PENCOLOR=: 0 0 0
BRUSHCOLOR=: 255 255 255
TEXTCOLOR=: 0 0 0
FONT=: PROFONT
)
initwin=: 3 : 0
try.
  glsel gloc
catch. destroy'' return.
end.
wh=. glqwh''
'W H'=: wh
WH=: <./ wh
WH2=: -: WH
XY=: -: wh - WH
)
nameindex=: 3 : '(0 {"1 GDIDS) index <,> y'
rgb=: 0&$: : (4 : 0)
if. x do. |."1[ 256 256 256 #: y
else. y +/ .* 1 256 65536
end.
)
roundrect=: 3 : 0
shape=. $y
'x y w h'=. |: _4 [\ ,y
xw=. x+w
yh=. y+h
x=. roundint x
y=. roundint y
w=. roundint xw - x
h=. roundint yh - y
shape $ , |: x, y, w,: h
)
spos=: 3 : 'flipxy (($y) $ XY) + WH2 * >: y'
spos01=: 3 : 'flipxy (($y) $ XY) + WH * y'

srec=: 3 : 'flipyrect (($y) $ (XY + WH2),0 0) + WH2 * y'
srec01=: 3 : 'flipyrect (($y) $ XY,0 0) + WH * y'

scalexy=: roundint @ spos
scalearc=: scalexy
scalerect=: roundrect @: srec

scalexy01=: roundint @ spos01
scalearc01=: scalexy01
scalerect01=: roundrect @: srec01
buf=: 3 : 0
'sel val'=. 2 {. (boxopen y),a:
loc=. {.GDLOC
select. sel
case. 'clear' do.
  GDCMD__GDLOC=: i. 0 2
case. do.
  GDCMD__GDLOC=: GDCMD__GDLOC, ('v',sel);<val
end.
gdclean''
EMPTY
)
gdaddid=: 3 : 0
gdids y, GDIDS
gdloc {: y
)
gdclean=: 3 : 0
if. 0=#GDIDS do. return. end.
msk=. (>1 {"1 GDIDS) e. getGtkToplevelWindows_jgtk_''
if. -. 0 e. msk do. return. end.
ndx=. I. -. msk
coerase (18!:1[1) intersect 2 {"1 ndx { GDIDS
gdids (<<<ndx) { GDIDS
gdloc''
)
gdids=: 3 : 0
GDIDS_jzgraph_=: ~.y
)
gddel=: 3 : 0
gdids GDIDS #~ y ~: >1 {"1 GDIDS
gdloc''
)
gdloc=: 3 : 0
if. #y do.
  GDLOC_jzgraph_=: y
end.
if. -. GDLOC e. 2 {"1 GDIDS do.
  GDLOC_jzgraph_=: {: 2 {"1 GDIDS
end.
)
vcolor=: 3 : 0
BRUSHCOLOR=: vrgb y
glbrush glrgb BRUSHCOLOR
)
vfont=: 3 : 0
FONT=: y
)
vpen=: 3 : 0
PEN=: 2 {. y
glrgb PENCOLOR
glpen PEN
)
vpencolor=: 3 : 0
PENCOLOR=: vrgb y
glrgb PENCOLOR
glpen PEN
)
vtextcolor=: 3 : 0
TEXTCOLOR=: vrgb y
)
vrgb=: 3 : 0
clr=. y
if. 1=#clr do.
  |. 256 256 256 #: {.clr
end.
)
vtext=: 3 : 0
'p a t'=. y
vtextdo (scalexy p);a;t
)
vtext01=: 3 : 0
'p a t'=. y
vtextdo (scalexy01 p);a;t
)
vtextdo=: 3 : 0
'p a t'=. y
glfont FONT
glrgb TEXTCOLOR
gltextcolor ''
'w h'=. glqextent t
gltextxy p - (w * a%2),h%2
gltext t
glrgb PENCOLOR
)
varc=: glarc @: scalexy
vchord=: glchord @: scalexy
vellipse=: glellipse @: scalerect
vlines=: gllines @: scalexy
vpie=: glpie @: scalexy
vpixel=: glpixel @: scalexy
vpolygon=: glpolygon @: scalexy
vrect=: glrect @: scalerect
vroundr=: glroundr @: scalerect

varc01=: glarc @: scalexy01
vchord01=: glchord @: scalexy01
vellipse01=: glellipse @: scalerect01
vlines01=: gllines @: scalexy01
vpie01=: glpie @: scalexy01
vpixel01=: glpixel @: scalexy01
vpolygon01=: glpolygon & scalexy01
vrect01=: glrect @: scalerect01
vroundr01=: glroundr @: scalerect01
gdreset=: create
gdclear=: buf bind 'clear'
gdpen=: buf @ ('pen'&;)
gdcolor=: buf @ ('color'&;)
gdfont=: buf @ ('font'&;)
gdshow=: 3 : 'pshow__GDLOC y'
gdtextcolor=: buf @ ('textcolor'&;)

gdbmp=: 3 : 'pbmp__GDLOC y'
gdadd=: 1 : 0
gdselopen''
gdshow u y
:
gdselopen''
gdshow x u y
)
gdopen=: 3 : 0
y=. boxxopen y
y=. y, (0=#y) # <'graph'
ndx=. nameindex {. y
if. _1 = ndx do.
  a=. '' conew 'jzgraph'
  popen__a y
else.
  gdloc {: ndx { GDIDS
  gdclear''
end.
)
gdclose=: 3 : 0
gdclean''
if. 0 = #y do.
  if. 0 = #>GDLOC do. EMPTY return. end.
  loc=. GDLOC
else.
  nam=. <,> y
  nms=. 0 {"1 GDIDS
  if. -. nam e. nms do.
    sminfo 'graph';'Not found: ',>nam return.
  end.
  loc=. {: (nms i. nam) { GDIDS
end.
destroy__loc ''
EMPTY
)
gdcloseall=: 3 : 0
gdclean''
if. 0=#GDIDS do. EMPTY return. end.
lcs=. {:"1 GDIDS
for_loc. lcs do.
  destroy__loc ''
end.
EMPTY
)
gdselopen=: 3 : 0
y=. <'graph'
ndx=. nameindex {. y
if. _1 = ndx do.
  a=. '' conew 'jzgraph'
  popen__a y
else.
  gdloc {: ndx { GDIDS
end.
)
gdselect=: 3 : 0
gdclean''
nam=. <,> y
nms=. 0 {"1 GDIDS
if. -. nam e. nms do.
  sminfo 'graph';'Not found: ',>nam return.
end.
gdloc {: (nms i. nam) { GDIDS
EMPTY
)
gddraw=: 1 : 0
gdopen''
gdshow u y
:
gdopen''
gdshow x u y
)
gdpencolor=: 3 : 0
'c p'=. 2 {. boxopen y
if. #p do.
  buf 'pen';2 {. p
end.
buf 'pencolor';c
)
gdrgb=: 3 : 0
clr=. y
if. 1=#clr do. clr=. |. 256 256 256 #: {.clr end.
buf 'rgb';clr
)
f=. 1 : ' u : ($:@] [ gdcolor@[)'
g=. 1 : ' u : ($:@] [ gdpencolor@[)'
h=. 1 : ' u : ($:@] [ gdtextcolor@[)'

gdarc=: buf @ ('arc'&;) f "1 L: 0
gdchord=: buf @ ('chord'&;) f "1 L: 0
gdellipse=: buf @ ('ellipse'&;) f "1 L: 0
gdlines=: buf @ ('lines'&;) g "1 L: 0
gdpie=: buf @ ('pie'&;) f "1 L: 0
gdpixel=: buf @ ('pixel'&;) f "1 L: 0
gdpolygon=: buf @ ('polygon'&;) f "1 L: 0
gdrect=: buf @ ('rect'&;) f "1 L: 0
gdroundr=: buf @ ('roundr'&;) f "1 L: 0
gdtext=: buf @ ('text';<) h "1

gdarc01=: buf @ ('arc01'&;) f "1 L: 0
gdchord01=: buf @ ('chord01'&;) f "1 L: 0
gdellipse01=: buf @ ('ellipse01'&;) f "1 L: 0
gdlines01=: buf @ ('lines01'&;) g "1 L: 0
gdpie01=: buf @ ('pie01'&;) f "1 L: 0
gdpixel01=: buf @ ('pixel01'&;) f "1 L: 0
gdpolygon01=: buf @ ('polygon01'&;) f "1 L: 0
gdrect01=: buf @ ('rect01'&;) f "1 L: 0
gdroundr01=: buf @ ('roundr01'&;) f "1 L: 0
gdtext01=: buf @ ('text01';<) h "1
pbmp=: 3 : 0
if. 0=#y do.
  y=. '~temp/graph.bmp'
else.
  y=. y, (-. '.bmp' -: _4 {. y) # '.bmp'
end.
initwin''
box=. 0 0, glqwh''
res=. glqpixels box
bmp=. (3 2{box) $ res
bmp writebmp jpath y
EMPTY
)
popen=: 3 : 0
'pid pnm siz'=. 3 {. boxopen y
pnm=. pnm, (0=#pnm) # pid
window=: gtk_window_new_jgtk_ GTK_WINDOW_TOPLEVEL_jgtk_
gtk_widget_set_name_jgtk_ window;,pid
gtk_window_set_title_jgtk_ window;,pnm
consig3_jgtk_ window;'delete-event';'pclose';coname''
gloc=: glcanvas pid;'g';((0=#siz){::siz;_1 _1);coname''
box=. gtk_vbox_new_jgtk_ 0 0
gtk_container_add_jgtk_ window,box
gtk_box_pack_start_jgtk_ box, canvas__gloc, 1 1 0
gtk_window_set_keep_above_jgtk_ window,1
gtk_widget_show_all_jgtk_ window
gdaddid (,pid);window;coname''
if. 0=#siz do.
  gtk_window_move_jgtk_ window,600 20
end.
(pid,'_g_paint')=: ppaint
(pid,'_close')=: pclose
wdfit''
''
)
pclose=: 3 : 0
destroy''
0
)
pshow=: 3 : 0
glsel gloc
ppaint''
glpaint''
)
ppaint=: 3 : 0
initdef''
initwin''
glclear''
for_d. GDCMD do.
  'f v'=. d
  f~v
end.
)
