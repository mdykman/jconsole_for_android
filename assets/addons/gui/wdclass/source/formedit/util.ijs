NB. util

NB. =========================================================
addLF=: , & LF
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
dquote=: '"'&, @ (,&'"')
index=: #@[ (| - =) i.
isempty=: 0: e. $
rounddown=: [ * [: <. %~
roundint=: <. @ +&0.5
roundup=: [ * [: >. %~
sessiontime=: 6!:1
tolist=: }. @ ; @: (LF&, @ , @ ": each)
towords=: ;: ^: _1

NB. =========================================================
capture=: 3 : 0
CAPTURE=: {. y
glcapture y
)

NB. =========================================================
cursor=: 3 : 0
glcursor CURSOR=: y
)

NB. =========================================================
NB. deb ignoring double quoted strings
debs=: 3 : 0
msk=. (y ~: ' ') +. ~: /\ y = '"'
y #~ msk +. 1 |. msk > </\ msk
)

NB. =========================================================
deletecc=: 3 : 0
if. #SELECT do.
  ndx=. <<<SELECT
  CCS=: ndx { CCS
  CLS=: ndx { CLS
  CPS=: ndx { CPS
  IDS=: ndx { IDS
  STY=: ndx { STY
  SELECT=: $0
  drawpaint ''
  bufsnap''
end.
)

NB. =========================================================
NB. deldblquote v delete double quotes
deldblquote=: 3 : 0
nd0=. 1 + y index '"'
nd1=. y i: '"'
nd0 }. nd1 {. y
)

NB. =========================================================
dblquote=: '"'&, @ (,&'"')

NB. =========================================================
delprefix=: 3 : 0
ndx=. 1 + y i. &> '_'
towords ndx }. each y
)

NB. =========================================================
flipypos=: 3 : 0
ry=. $y
(ry $ 0, GHX) + y * ry $ 1 _1
)

NB. =========================================================
flipypos1=: 3 : 0
({. y), GHX - {:y
)

NB. =========================================================
flipyrect=: 3 : 0
c=. GHX - +/"1 [ 1 3{"1 y
($y) $ ,c 1}"0 1 y
)

NB. =========================================================
ferase=: (1!:55&< :: _1: ) &>
fread=: (1!:1 :: _1:) @ boxopen
fstamp=: (1: >@{ ,@(1!:0)) ::(_1:)
fwrite=: (1!:2 :: _1:) boxopen

NB. =========================================================
freads=: 3 : 0
dat=. (1!:1) :: _1: boxopen y
if. (dat -: _1) +. 0=#dat do. return. end.
dat,LF -. {:dat=. toJ dat
)

NB. =========================================================
NB. writes text to file (if changed)
flwrites=: 4 : 0
dat=. x
if. -. 0 e. $dat do.
  if. 1 >: #$dat do.
    dat=. dat,(LF ~: {:dat)#LF
  else.
    dat=. ,dat,"1 LF
  end.
end.
(toHOST dat) flwritenew y
)

NB. =========================================================
NB. writes data to file (if changed)
flwritenew=: 4 : 0
dat=. ,x
new=. -. dat -: fread y
if. new do. dat fwrite y end.
new
)

NB. =========================================================
NB. getformsizes
NB. 5 numbers:
NB. button width, button height, edit width, edit height, label height
getformsizes=: 3 : 0
FORMSIZES=: FORMSIZES_j_
)

NB. =========================================================
geteditheight=: 3 : 0
EDITHEIGHT=: FORMSIZES {~ {: 4 pick (({."1 CONTROLS) i. <'edit') { CONTROLS
)

NB. =========================================================
getoleocx=: 3 : 0
if. 0 = # OLEOCX do.
  j=. _2 [\ <;._2 wd 'oleocx'
  OLEOCX=: j /: tolower each {."1 j
end.
)

NB. =========================================================
NB. get isigraph size in pixels:
getwhx=: 3 : 0
selectform''
2 3 { 0 ". wd 'qchildxywhx g'
)

NB. =========================================================
NB.*globals v names assigned globally in text
NB. beginning with PID_
globals=: 3 : 0
rx=. rxcomp '([[:alpha:]][[:alnum:]_]*|x\.|y\.|m\.|n\.|u\.|v\.) *=:'
nms=. rx rxall y
rxfree rx
nms=. _2 }. each ~. nms
hdr=. PID, '_'
len=. # hdr
len }. each ((<hdr) = len {. each nms) # nms
)

NB. =========================================================
ifshiftkey=: 3 : '''1'' e. sysmodifiers'
ifctrlkey=: 3 : '''2'' e. sysmodifiers'
ifctrlshiftkey=: 3 : '''3'' e. sysmodifiers'

NB. =========================================================
info=: 3 : 0
sminfo 'Form Edit';y
)

NB. =========================================================
makeccx=: 3 : 0
CCX=: topixelsxywh viewccs''
)

NB. =========================================================
makedots=: 3 : 0
'w h'=. 0 >. y
x=. h # i.w
y=. (w*h) $ i.h
m=. 2 | x + y
(m#x),.m#y
)

NB. =========================================================
NB. for development:
minform=: 3 : 0
if. IFUNIX do. return. end.
smsel_jijs_ FNAME
wd 'psel ',SMSEL_jijs_
wd 'pshow sw_showminimized'
)

NB. =========================================================
NB. mousepos v mouse position in units
mousepos=: 3 : 0
2 {. 0 ". sysdata
)

NB. =========================================================
NB. mousepos v mouse position in units
mouseposu=: 3 : 0
roundint (mousepos'') % GSCALE
)

NB. =========================================================
query=: 4 : 0
x wdquery 'Form Edit';y
)

NB. =========================================================
selectcode=: 3 : 0
smopen FNAME
dat=. smread ''
sel=. {. SELECT
id=. sel pick IDS
ndx=. ({."1 CONTROLS) i. sel { CLS
evt=. > {. 6 pick ndx { CONTROLS
if. 0 = #evt do. return. end.
fn=. PID,'_',id,'_',evt
ndx=. 1 i.~ ((fn,'=:') E. dat) +. (fn,' =:') E. dat
if. ndx = #dat do.
  new=. LF,fn,'=: 3 : 0',LF
  dat=. dat,new,')',LF
  smwrite dat
  ndx=. ndx + #new
else.
  ndx=. ndx + 1 + (ndx }. dat) i. LF
end.
smsetselect ndx,ndx,0
smfocus''
)

NB. =========================================================
state=: 3 : 0
nms=. 'cc';'caption';'id';'class';'style'
dat=. > each CCS ; CPS ; IDS ; CLS ; <STY
nms ,: dat
)

NB. =========================================================
NB. convert from pixels to absolute coord
NB. convert from absolute to pixels coord

NB. =========================================================
tocoordsxywh1=: 3 : 0
'x y w h'=. y
s=. roundint (x + w) % GSCALE
t=. roundint (y + h) % GSCALE
x=. roundint x % GSCALE
y=. roundint y % GSCALE
x,y,(s-x),t-y
)

NB. =========================================================
topixelsxywh=: 3 : 0
'x y w h'=. |: y
s=. roundint GSCALE * x + w
t=. roundint GSCALE * y + h
x=. roundint x * GSCALE
y=. roundint y * GSCALE
x,.y,.(s-x),.t-y
)

NB. =========================================================
NB. validatecc v validate control id return success
validatecc=: 3 : 0
if. '_' e. y do.
  info 'An id cannot contain an underscore: ',y
  0 return.
end.

NB. ---------------------------------------------------------
if. (<y) e. WDNAMES do.
  msg=. 'The id "',y,'" is reserved.',LF,LF
  info msg,'It is best to avoid ids beginning "wd".'
  0 return.
end.

NB. ---------------------------------------------------------
if. _2 = 4!:0 <y do.
  info 'Invalid control id: ',y
  0 return.
end.

NB. ---------------------------------------------------------
1
)

NB. =========================================================
NB. convert CCS into viewable sizes
viewccs=: 3 : 0
ndx=. I. CLS e. 'combodrop';'combolist'
CBSIZE (<ndx;3) } CCS
)

NB. =========================================================
ws_add=: 3 : 0
dat=. ;: ^: (L.=0:) y
dat=. (<'ws_group') (I. dat = <'group') } dat
dat=. (<'gs_opengl') (I. dat = <'opengl') } dat
towords dat
)

NB. =========================================================
ws_del=: 3 : 0
dat=. ;: ^: (L.=0:) y
dat=. (<'group') (I. dat = <'ws_group') } dat
dat=. (<'opengl') (I. dat = <'gs_opengl') } dat
)
