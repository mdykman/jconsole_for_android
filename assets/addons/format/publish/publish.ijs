3 : 0''
if. IFJ6 do.
  script_z_ jpath '~system/classes/plot/afm.ijs'
  script_z_ jpath '~system/packages/graphics/bmp.ijs'
  script_z_ jpath '~system/packages/color/colortab.ijs'
  script_z_ jpath '~system/main/dll.ijs'
  script_z_ jpath '~system/main/files.ijs'
  script_z_ jpath '~system/packages/misc/font.ijs'
  script_z_ jpath '~system/main/gl2.ijs'
  script_z_ jpath '~system/classes/plot/jzplot.ijs'
  script_z_ jpath '~system/main/numeric.ijs'
  script_z_ jpath '~system/classes/plot/plot.ijs'
  script_z_ jpath '~system/main/regex.ijs'
  script_z_ jpath '~system/main/strings.ijs'
  script_z_ jpath '~system/main/trig.ijs'
else.
  require 'afm bmp colortab dll files general/misc/font gl2 jzplot numeric plot regex strings trig'
end.
''
)

coclass 'ppublish'
cutlist=: 3 : 0
txt=. trimWS y
msk=. (txt = LF) > ~: /\ txt = '"'
txt=. ' ' (I. msk) } txt
txt=. deb txt
if. 0=#txt do. '' return. end.
txt=. ',', txt
a=. (txt ~: ' ') +. ~: /\ txt = '"'
b=. (a # txt) e. ','
c=. b +. }. b, 1
d=. ~: /\ a #^:_1 c ~: }: 0, c
txt=. (a >: d) # txt
msk=. txt = '"'
com=. (txt e. ' ,') > ~: /\ msk
msk=. (msk *. ~:/\msk) < msk <: 1 |. msk
deb each (msk # com) <;._1 msk # txt
)
cutparms=: 3 : 0
txt=. deb y
if. 0 = #txt do. i.0 2 return. end.
txt=. txt, ','
msk=. txt = '"'
com=. (txt = ',') > ~: /\ msk
msk=. (msk *. ~:/\msk) < msk <: 1 |. msk
txt=. a: -.~ deb each (msk # com) <;._2 msk # txt
ndx=. txt i.&> '='
(toupper each ndx{.each txt),.deb each (ndx+1)}.each txt
)
cutpages=: 3 : 0
txt=. '<newpage/>',txt
10 }.each ('<newpage/>' E. txt) <;.1 txt
)
cutparas=: 3 : 0
txt=. y,LF,LF
msk=. (LF,LF) E. txt
msk=. msk +. 0,}:msk
ndx=. I. msk < txt=LF
txt=. ' ' ndx } txt
msk=. msk > 0 ,~ }.msk
txt=. msk <;._2 txt
ndx=. txt i.&> LF
txt=. ndx {.each txt
txt=. deb each txt
txt -. a:
)
BOXEMPTY=: <''
BOXTYPE=: 32
CHARTYPE=: 2 131072
EMPTY=: i. 0 0
LF2=: LF,LF
PATHJSEP=: PATHJSEP_j_
WHITESPACE=: TAB,CRLF,' '

create=: ]

addLF=: , (LF #~ 0 < #) -. {:
citemize=: ,:^:(2 > #@$)
dlb=: }.~ =&' ' i. 0:
fix=: 0&". ::]
intersect=: e. # [
partition=: 1 , [: -. }. -:"_1 }:
pfl=: [: ; {.&1&.>
readlist=: 3 : '<;._2 (0 : 0)'
tolist=: }.@;@:(LF&,@,@":each)
towords=: ;:^:_1
trimLF=: 3 : 'y #~ (+./\msk) *. +./\.msk=. y ~: LF'
trimWS=: 3 : 'y #~ (+./\msk) *. +./\.msk=. -. y e. LF,TAB,'' '''
wraptag=: '<'&, @ (,&'>')
endian=. ({.a.)={. 1&(3!:4) 1
toucodem=: ''&,@(1&(3!:4))@(3&u:)@u:
toucoder=: ''&,@:,@:(|."1@(_2: ]\ 1&(3!:4)))@(3&u:)@u:
toucode1=: toucodem`toucoder@.(-.endian) f.
is1integer=: ({. -: <.) :: 0:
isboxed=: 0 < L.
ischar=: 3!:0 e. CHARTYPE"_
isempty=: 0 e. $
isinteger=: (-: <.) :: 0:
isnumeric=: [: -. 3!:0 e. (CHARTYPE,BOXTYPE)"_
isscalar=: 0 = #@$
is1color=: 3 = */ @ $

round=: [ * [: <. 0.5"_ + %~
roundint=: <. @ +&0.5
debugq=: 13!:17
debugss=: 13!:3
debugstack=: 13!:13
ascii2utf8=: 3 : 0
y=. a. i. y
y=. y #~ 1 j. 127 < y
c=. y {~ ndx=. I. 127 < y
n=. 192 128 +"1 [ 0 64 #: c
a. {~ n (ndx +/ 0 1) } y
)
checktag2=: 3 : 0
if. 2 ~: #y do.
  throw '101 Invalid block for tag: ',wraptag 1 pick {.y
end.
if. -. (1;_1) -: {."1 y do.
  throw '101 Invalid begin, end tags for: ',wraptag 1 pick {.y
end.
{. y
)
defineindex=: 3 : 0
y=. <;._2 (0 : 0)
('i',each y)=: i.#y
)
destroy=: 3 : 0
coerase locT
codestroy''
)
dictget=: 4 : 0
(({."1 y) i. boxxopen x) { ({:"1 y),<''
)
dictget1=: > @: dictget
filename=: 3 : 0
p=. PATHJSEP
d=. jpathsep deb y
if. 0 = #d do.
  throw '101 Filename is empty'
end.
if. IFWIN *: ':' = {: 2 {. d do.
  if. p ~: {.d do.
    d=. MasterPath,d
  end.
end.
d
)
indexq=: 4 : 0
1 i.~ (x=y) > ~:/\x='"'
)
info=: 3 : 0
wdinfo@('Publish'&;) :: smoutput y
)
getpath=: ([: +./\. =&PATHJSEP) # ]
jcmd=: 3 : 0
loc=. 18!:5''
18!:4 <'base'
3 : '0!:100 y' y
18!:4 loc
)
jcmdr=: 3 : 0
loc=. 18!:5''
18!:4 <'base'
r=. 3 : '". y' y
18!:4 loc
r
)
jset=: 3 : 0
try.
  0!:100 y
catch.
end.
fixaligns''
)
newinstance=: 4 : 0
obj=. cocreate''
coinsert__obj <y
COCREATOR__obj=: coname''
create__obj x
locT__locS=: locT,obj
obj
)
pbuf=: 3 : 0
if. #y do.
  buf=: buf,,y,"1 LF
end.
)
pbufread=: 3 : 0
a=. buf
buf=: ''
a
)
pfmt=: 3 : 0
dat=. ": y
txt=. ,dat
($dat) $ '-' (I. txt='_') } txt
)
pread=: 3 : 0
dat=. fread y
if. (dat -: _1) +. 0=#dat do. return. end.
if. (255 254 { a.) -: 2 {. dat do.
  dat=. utf8 6 u: 2 }. dat
elseif. (239 187 191 { a.) -: 3 {. dat do.
  dat=. 3 }. dat
elseif. 0 -: 7 u: :: 0: dat do.
  val=. a. i. dat
  msk=. 127 < val
  uni=. 192 128 +"1 [ 0 64 #: msk # val
  val=. val #~ 1 j. msk
  ndx=. I. 127 < val
  dat=. a. {~ uni (ndx +/ 0 1) } val
end.
dat=. (-(26{a.)={:dat) }. dat
dat,LF -. {:dat=. toJ dat
)
prnd=: 0.01 * [: <. 0.5 + 100&*
query=: 4 : 0
x ((wdquery 'Publish'&;) :: (1: smoutput)) y
)
rgb2alf=: 3 : 0
a.{~,|."1 [256 256 256 #: ,y
)
shrinkmargins=: 4 : 0
'l t r b'=. y
x + l,b,-(l+r),t+b
)
u2a=: 5 u: 7 u: ]
toascii85=: 3 : 0
r=. ,y
len=. #r
r=. 256 #. _4[\ a.i.r
m=. 0 (_1) } r = 0
n=. 5 * I.m
r=. a. {~ 33 + ,(5#85) #: r
r=. 'z' n } r
m=. 1 n } 5 # -. m
r=. m # r
r=. (- (4|len) { 0 3 2 1) }. r
r=. }: ,(_75 [\ r),.LF
('~>',LF) ,~ (r i: ' ') {. r
)
fromascii85=: 3 : 0
r=. ,y
r=. a.i.r
r=. (r > 32) # r
r=. (2 * (a.i.'<~') -: 2 {. r) }. r
r=. (-2 * (a.i.'~>') -: _2 {. r) }. r
m=. r = a.i.'z'
r=. r - 33
r=. 0 (I.m) } r
r=. (1+4*m) # r
b=. 5 | #r
r=. r,84 #~ b{ 0 4 3 2 1
r=. a.{~ ,(4#256) #: 85 #. _5 [\ r
r }.~ - b { 0 0 3 2 1
)
FORCETHROW=: 0
throwtext=: ''
rcOK=: 0;<
dat=. 0 : 0
0   OK
1   Unknown error
101 Problem with source data
201 Problem with program code
)

dat=. a: -.~ <;._2 dat
RCN=: 0 ". 3 {.&> dat
ndx=. RCN i. 101
RCS=: (,ndx&{) (<&>RCN),.4 }.each dat
getrc=: 3 : 'RCS {~ RCN i. y'
getreturncode=: 3 : 0
txt=. throwtext
if. 0 = #txt do.
  getrc 101 return.
end.
ndx=. txt i. ' '
rc=. _1 ". ndx {. txt
'rc msg'=. getrc rc
txt=. deb (ndx+1) }. txt
rc;msg,(0<#txt)#': ',txt
)
throw=: 3 : 0
throwtext__locB=: y
if. FORCETHROW < debugq'' do.
  debugss ; (2 }. {."1 debugstack'') ,each <' *:*,'
  info y
else.
  smoutput y
  throw.
end.
)
LOG=: jpath '~temp/publish.log'
loginit=: 3 : 0
if. _1 -: '' fwrite LOG do.
  throw 'Unable to write to log file: ',LOG
end.
)
log=: 3 : 0
((,":y),LF) fappends LOG
)
r100=. <;._1 '  c cc ccc cd d dc dcc dccc cm'
r10=. <;._1 '  x xx xxx xl l lx lxx lxxx xc'
r1=. <;._1 '  i ii iii iv v vi vii viii ix'
R1000=: , r100 ,&.>/ r10 ,&.>/ r1
roman=: 3 : 0
r=. ('m'$~<.y%1000),R1000{::~1000|y
'(',r,')'
)

coclass 'ppublish'

addcontents=: 3 : 'Contents__locS=: Contents,y'
newsectionnum=: 3 : 0
SectionNum__locS=: SectionNum+1
)
newgroup=: 3 : 0
GroupNum__locS=: GroupNum+1
)
newsection=: 3 : 0
cocurrent locS
y newinstance 'ppubsection'
)
newurl=: 3 : 0
cocurrent locS
if. (<y) e. UrlIds do. return. end.
y newinstance 'ppuburl'
)
newxobject=: 3 : 0
cocurrent locS
y newinstance 'ppubxobject'
)
newplot=: 3 : 0
cocurrent locS
y newinstance 'ppubplot'
)
setgroup=: 3 : 0
Groups__locS=: Groups,SNum,PNum,Sh,Locales i. coname''
)
ShowFrames=: 0

getPDFreader=: 3 : 0
if. 0~: 4!:0 <'PDFReader_j_' do.
  ''
else.
  PDFReader_j_
end.
)
Padchar=: 'W'
Txm_port=: '1 0 0 1 '
Txm_land=: '0 1 -1 0 '
PSletter=: 612 792
PSa4=: 595.28 841.89
setdefaults=: 3 : 0
locS=: locP=: coname''
buf=: ''
GroupNum=: _1
Level=: ''
Locales=: ''
Localex=: ''
Plots=: ''
Sections=: ''
SectionNum=: _1
Urls=: UrlIds=: ''
XObjects=: ''
)
pageinit=: 3 : 0
'Px Py Pw Ph'=: Pxywh=: 0 0,PAGESIZE
'Lm Tm Rm Bm'=: PAGEMARGINS
setframe Pxywh shrinkmargins PAGEMARGINS
setdraw Fxywh
)
FONTH0=: 'Sans 11 bold'
FONTH1=: 'Sans 11 bold'
FONTH2=: 'Sans 10 bold'
FONTH3=: 'Sans 9 bold'
FONTH4=: 'Sans 9 bold'
FONTH5=: 'Sans 9 bold'
FONTH6=: 'Sans 9 bold'
FONTC0=: 'Sans 10 bold'
FONTC1=: 'Sans 10 bold'
FONTC2=: 'Sans 9'
FONTC3=: 'Sans 9'
FONTC4=: 'Sans 9'
FONTC5=: 'Sans 9'
FONTC6=: 'Sans 9'

FONTP=: 'Sans 9'
FONTPF=: 'Mono 9'
FONTTH=: 'Sans 9'
FONTTC=: 'Sans 9'
TCOLOR=: ". ;._2 (0 : 0)
0 0 0 192 192 192
0 0 0 255 255 255
0 0 0 255 255 255
0 0 0 255 255 179
0 0 0 153 153 255
255 0 0 255 255 255
255 255 255 0 128 128
)
TGRIDSIZE=: 0.3
ALIGN=: 0
ALIGNV=: 0
AUTHOR=: ''
BMLEVEL=: 3
CLASS=: ''
HYPHEN=: '~'
LEADING=: 1.2
LCOLOR=: 0 0 128
NAME=: ''
PAGEMARGINS=: 72
PAGESIZE=: PSletter
PARASPACE=: 0.6
SCALE=: 1
STYLE=: ''
TITLE=: ''
TOCLEVEL=: 3
". toupper COLORTABLE

Colors=: i.0 3
colorindex=: 3 : 0
c=. y % 255
r=. Colors i. c
m=. r = #Colors
if. is1color c do.
  if. m do.
    Colors__locS=: Colors,c
  end.
else.
  if. 1 e. m do.
    Colors__locS=: Colors,m#c
  end.
  r=. Colors i. c
end.
r
)
colorinit=: 3 : 0
a=. ;:'BLACK WHITE RED'
('i',each a)=: i.#a
colorindex ". >a
Tfcolor=: colorindex 3 {."1 TCOLOR
Tbcolor=: colorindex 3 }."1 TCOLOR
)
setframe=: 3 : 0
'Fx Fy Fw Fh'=: Fxywh=: y
)
setdraw=: 3 : 0
'Dx Dy Dw Dh'=: Dxywh=: y
)
setnewpage=: 3 : 0
PNum__locS=: PNum + 1
setsxywh Dxywh
)
setnewpageP=: 3 : 0
PNum__locS=: PNum + 1
setsxywhP Dxywh
)
setsxywh=: 3 : 0
'Sx Sy Sw Sh'=: Sxywh=: 0 >. y
)
setsxywhP=: 3 : 'setsxywh__locP y'
subwindow=: 4 : 0
'px py pw ph'=. x
'sx sy sw sh'=. y
if. sx < 0 do.
  sx=. px + pw - sx
else.
  sx=. px + sx
end.
if. sy < 0 do.
  sy=. py + ph - sy
else.
  sy=. py + sy
end.
if. sw < 0 do.
  sw=. px + pw + sw - sx
end.
sw=. 0 >. sw <. px + pw - sx
if. sh < 0 do.
  sh=. py + ph + sh - sy
end.
sh=. 0 >. sh <. py + ph - sy
sx,sy,sw,sh
)
iLEFT=: iTOP=: 0
iCENTER=: iCENTRE=: iMIDDLE=: 1
iRIGHT=: iBOTTOM=: 2
iJUST=: iJUSTIFIED=: 3
defineindex ''
BOLD
ITALIC
)
defineindex ''
PORT
LAND
)
defineindex ''
TITLE
H1
H2
H3
H4
H5
H6
PARA
)
defineindex''
GROUP
HEADER
IMAGE
LIST
PAGE
PLOT
PRE
SECTION
SKIP
TABLE
TEXT
TOC
XOBJECT
)
defineindex ''
)
opts=. ;: ;._2 (0 : 0)
ALIGN a
ALIGNV a
BMLEVEL n
CLASS c
FONTH0 f
FONTH1 f
FONTH2 f
FONTH3 f
FONTH4 f
FONTH5 f
FONTH6 f
FONTC0 f
FONTC1 f
FONTC2 f
FONTC3 f
FONTC4 f
FONTC5 f
FONTC6 f
FONTP f
FONTTH v
FONTTC f
LEADING n
NAME c
PAGEMARGINS v
PAGESIZE v
PARASPACE n
SCALE v
SHAPE v
STYLE s
TOCLEVEL n
TOCALIGN a
)

DefOpts=: {."1 opts
DefOptx=: ; {:"1 opts
set=: 3 : 0
if. 0 e. $y do. '' return. end.
if. 1 = #$y do. y=. _2 [\ y end.
nam=. toupper each {."1 y
val=. {:"1 y
opt=. <&> (DefOpts i. nam) { DefOptx
for_s. opt,.nam,.val do.
  't n v'=. s
  select. t
  case. 'a' do.
    v=. fixalign v
  case. 'c' do.
  case. 'f' do.
  case. 'n' do.
    v=. {. fix v
  case. 's' do.
    v=. toupper v
    if. 0 ~: nc <v do.
      throw '101 Style not found: ',v
    end.
    jset ". v return.
  case. 'v' do.
    v=. fix v
  end.
  (n)=: v
end.
)
setfixx=: 4 : 0
if. *./ y e. '0123456789 ' do.
  fix y
else.
  y=. ',',tolower y
  x i. a: -.~ (y e. ', ') <;._1 y
end.
)
fixalign=: 3 : 0
if. -. ischar y do. y return. end.
n=. {. _1 ". y
if. n ~: _1 do. return. end.
{. ". 'i',toupper y
)
fixaligns=: 3 : 0
ALIGN=: fixalign ALIGN
ALIGNV=: fixalign ALIGNV
)
publish=: 3 : 0
'file throw'=. 2 {. (boxxopen y),<FORCETHROW
locS=: conew 'ppublish'
FORCETHROW__locS=: throw
try.
  res=. publishrun__locS file
catcht.
  res=. throwtext__locS
  log res
end.
destroy__locS ''
res
)
publishconfig=: 3 : 0
PDFCompress=: zlibinit_ppubzlib_''
)
publishinit=: 3 : 0
loginit''
rxinit''
setdefaults ''
Counth1=: 0
Contents=: i.0 3
MasterFile=: jpathsep y
log 'master file: ',MasterFile
if. -. fexist MasterFile do.
  throw '101 Master file not found: ',MasterFile
end.
MasterPath=: getpath MasterFile
OutputFile=: ((i:&'.'{.])MasterFile),'.pdf'
log 'output file: ',OutputFile
dat=. pread MasterPath,'master.ijs'
if. -. dat -: _1 do. jcmd dat end.
dat=. pread MasterPath,'master.sty'
if. -. dat -: _1 do. 0!:100 dat end.
1
)
publishfini=: 3 : 0
rxfree Rxhnd
)
publishrun=: 3 : 0
locB=: coname''
locT=: ''
if. 0=publishinit y do. '' return. end.
txt=. readtext MasterFile
if. 0=#txt do.
  throw '101 No text in file: ',MasterFile
end.
colorinit''
pageinit''
log 'First pass through source text'
txt=. fixedtext txt
if. 0=#txt do.
  throw '101 No source text for report'
end.
log 'Parse source text into sections'
'sec front'=. parsetext txt
FrontPage=: front
for_s. sec do.
  log 'Parse section ',":s_index
  parsesec >s
end.
b=. build front
write b
log 'Report created'
view ''
publishfini''
EMPTY
)
publish_z_=: publish_ppublish_
publishload_z_=: 3 : 0
if. -. 1 e. '/\' e. y do.
  loc=. locS_ppublish_
  y=. MasterPath__loc,y
end.
load y
)
coclass 'ppublish'
PDFCompress=: 0
dict=: 3 : 0
if. L. y do.
  s=. ; y ,each <LF
else.
  s=. y , (LF ~: {: y) # LF
end.
'<<',LF,s,'>>',LF
)
view=: 3 : 0
if. IFJ6 do.
  if. #PDFreader=. getPDFreader'' do.
    cmd=. PDFreader,' "',OutputFile,'"'
    if. IFUNIX do.
      2!:1 cmd,' &'
    else.
      wd 'winexec *',cmd
    end.
  end.
else.
  viewpdf_j_ OutputFile
end.
EMPTY
)
write=: 3 : 0
while. _1 = y fwrite OutputFile do.
  msg=. 'Unable to write to file: ',OutputFile,LF,LF
  if. #d=. 1!:0 OutputFile do.
    msg=. msg, 'If the file is open in Adobe, close the file and try again.'
    if. 1 query msg do. return. end.
  else.
    info msg,'The file name is invalid.' return.
  end.
end.
EMPTY
)
build=: 3 : 0
log 'Make creator'
inf=. creator''
log 'Resolve urls'
uls=. urls''
log 'Resolve images'
xbs=. xobjects''
sec=. sections''
log 'Make page numbers'
sec=. y numbers sec
log 'Make fonts'
fnt=. fonts''
log 'Make PDF pages'
roots''
nds=. pages sec
out=. outlines''
cat=. catalog ''
wrapbody inf;cat;fnt,uls,xbs,nds,out
)
catalog=: 3 : 0
r=. '/Type /Catalog',LF
r=. r, '/Pages ',(":RootPages),' 0 R',LF
if. RootOutlines do.
  r=. r, '/Outlines ',(":RootOutlines),' 0 R',LF
end.
dict r
)
creator=: 3 : 0
msk=. (0 < #TITLE),(0 < #AUTHOR), 1 1
t=. u2a '/Title (',TITLE,')'
a=. u2a '/Author (',AUTHOR,')'
p=. '/Producer (J Publish)'
d=. creationdate''
dict msk # t;a;p;d
)
creationdate=: 3 : 0
t=. '20', ; _2 {.each '0' ,each ": each <. 6!:0''
'/CreationDate (D:',t,')'
)
roots=: 3 : 0
RootUrls=: 3 + +/ PDFFontpages
RootXObjects=: RootUrls + #Urls
RootPages=: RootXObjects + #XObjects
RootOutlines=: 0
)
cidfont=: 4 : 0
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
fonts=: 3 : 0

PDFFonts=: (~.{."1 AFMdir) { PSFONTNAMES_jafm_
PDFFontpages=: 1 + 2 * PDFFonts e. CIDfonts

hdr=. '<<',LF,'/Type /Font',LF,'/Subtype /Type1',LF,'/Name /F'
ftr=. LF,'/Encoding /WinAnsiEncoding',LF,'>>',LF
r=. ''
for_f. PDFFonts do.
  if. f e. CIDfonts do.
    r=. r, ( 1+f_index) cidfont >f
  else.
    fnt=. (": 1 + f_index),LF,'/BaseFont /', >f
    r=. r, <hdr, fnt, ftr
  end.
end.
r
)
numbers=: 4 : 0

sec=. y
len=. # &> sec
sec=. ;sec
lvl=. 0 {"1 sec
msk=. ;1 {"1 sec
ndx=. lvl i. {."1 Contents
Contents=: Contents,.<&>ndx { +/\msk
if. x do.
  top=. 1 i.~ 1 = {. &> lvl
  ini=. top {. sec
  mst=. top {. msk
  msk=. top }. msk
  sec=. top }. sec
  s=. {. Sections
  if. iTOC e. Locx__s do.
    setnewpage''
    setnewpage__s ''
    ini=. draw__s ''
    mst=. ;1 {"1 ini
    len=. (#ini) 0 } len
  end.
  ndx=. I. 1 |. mst
  for_n. ndx do.
    s=. (<n;2) pick ini
    s=. s,drawpagenum roman 1+n_index
    ini=. (<s) (<n;2) } ini
  end.
else.
  ini=. 0 # sec
end.
ndx=. I. 1 |. msk
for_n. ndx do.
  s=. (<n;2) pick sec
  s=. s,drawpagenum 1+n_index
  sec=. (<s) (<n;2) } sec
end.
(pfl len) <;.1 ini,sec
)
drawpagenum=: 3 : 0
p=. ":y
f=. fontindex FONTP
w=. f fontwidth p
h=. fontheight f
x=. Dx + -: Dw - w
y=. -: Dy + h
r=. '/F',(":f{AFMffi),' ',(":h),' Tf ',LF
r=. r,'1 0 0 1 ',(":x,y),' Tm (',p,') Tj',LF
wraptext r
)
outlines=: 3 : 0

if. isempty Contents do. '' return. end.
msk=. BMLEVEL >: # &> {."1 Contents
if. -. 1 e. msk do. '' return. end.
dat=. 0 1 3 {"1 msk # Contents

dat=. dat #~ partition 1 {"1 dat
dat=. dat ,. (": each Next + 1 + i. #dat) ,each <' 0 R'
top=. dat #~ 1 = # &> {."1 dat
if. 0 = #top do. '' return. end.

RootOutlines=: Next
r=. '/Type /Outlines',LF
r=. r,'/First ',(_1 pick 0 { top),LF
if. 2 < #top do.
  r=. r,'/Next ',(_1 pick 1 { top),LF
end.
r=. r,'/Last ',(_1 pick _1 { top),LF
r=. dict r
here=. (":Next),' 0 R'
s=. here outlineset dat
r;s
)
outlineset=: 4 : 0
nub=. ~: 0 1 {"1 y
dat=. nub # y
dat=. ({. &> {."1 dat) </. dat
s=. ''
for_i. i.#dat do.
  sub=. i pick dat
  'pos lab pag obj'=. {. sub
  r=. '/Title (',lab,')',LF
  r=. r,'/Parent ',x,LF
  if. i do.
    r=. r, '/Prev ',(_1 pick {.(i-1) pick dat),LF
  end.
  if. i < _1 + #dat do.
    r=. r, '/Next ',(_1 pick {.(i+1) pick dat),LF
  end.
  dest=. '/Dest [',pag,' /XYZ null null null]',LF
  if. 1 = #sub do.
    r=. r, dest
    s=. s, <dict r
  else.
    sub=. }. sub
    sub=. (}. each {."1 sub) ,. }."1 sub
    top=. sub #~ 1 = # &> {."1 sub
    r=. r, '/First ',(3 pick 0 { top),LF
    r=. r, '/Last ',(3 pick _1 { top),LF
    r=. r, dest
    s=. s, <dict r
    s=. s, obj outlineset sub
  end.

end.

)
pages=: 3 : 0

Next=: 1 + RootPages
Contents=: Contents,.<0
PageNum=: 1
r=. pagesheader''
r=. r,'/Kids [',LF
s=. ''
for_d. y do.
  r=. r, (":Next),' 0 R',LF
  s=. s, pageset > d
  PageBlk=: >: PageBlk
end.
r=. r, ']',LF
r=. r, '/Count ',(":PageNum-1),LF
r=. dict r

r;s
)
pageset=: 3 : 0
dat=. y
here=. Next
Next=: Next+1
pno=. PageNum
len=. #dat
r=. '/Type /Pages',LF
r=. r, '/Parent ',(":RootPages),' 0 R',LF
r=. r,'/Kids [',LF
s=. ''
levs=. ''
page=. ''
for_d. dat do.
  'pos new txt'=. d
  if. new do.
    pagecontents levs
    levs=. <pos
    if. #page do.
      r=. r, (":Next),' 0 R',LF
      s=. s, here pageset1 page
    end.
    page=. txt
  else.
    levs=. levs,(<pos) -. levs
    page=. page,txt
  end.
end.
if. #page do.
  pagecontents levs
  r=. r, (":Next),' 0 R',LF
  s=. s, here pageset1 page
end.
r=. r, ']',LF
r=. r, '/Count ',(":PageNum-pno),LF
r=. dict r
r;s
)
pageset1=: 4 : 0
r=. '/Type /Page',LF
r=. r,'/Parent ',(":x),' 0 R',LF
r=. r,'/Contents ',(":Next+1),' 0 R',LF
r=. dict r
Next=: Next + 2
PageNum=: PageNum+1
s=. y
if. ShowFrames do. s=. s, drawbox Dxywh end.
r;wrapstream s
)
pagesheader=: 3 : 0
r=. '/Type /Pages',LF
x=. ''
if. #Urls do.
  o=. LF,' /Filespec <<',LF
  px=. i.#Urls
  t=. ,('  /Ul'&, &> ":each px),.' ',.(":,.px+RootUrls),"1 ' 0 R',LF
  t=. t,' >>'
  x=. o,t
end.
if. #XObjects do.
  o=. LF,' /XObject <<',LF
  px=. i.#XObjects
  t=. ,('  /Im'&, &> ":each px),.' ',.(":,.px+RootXObjects),"1 ' 0 R',LF
  t=. t,' >>'
  x=. x,o,t
end.
s=. '/Resources',LF,'<<',LF
s=. s,' /ProcSet [/PDF /Text /ImageC]',LF
s=. s,' /Font <<',LF
fx=. '  /F'&, &> ": each 1 + i.#PDFFonts
px=. ' ',. ": &> 2 + +/\ PDFFontpages
t=. ,fx ,"1 px ,"1 ' 0 R',LF
t=. t,' >>'
r=. r,s,t,x
r=. r,LF,'>>',LF
r=. r, '/MediaBox [0 0 ',(":PAGESIZE),']',LF
)

pagecontents=: 3 : 0
ndx=. I. ({."1 Contents) e. y
nxt=. < (":Next),' 0 R'
Contents=: nxt (<ndx;3) } Contents
EMPTY
)
sections=: 3 : 0
log 'Build sections'
if. GroupNum >: 0 do.
  sectiongroups''
  sectionreset''
end.
sectionrun 1
)
sectiongroups=: 3 : 0
sectionrun 1
while. #Groups do.
  bal=. i.0 0
  for_grp. ({."1 Groups) </. Groups do.
    dat=. >grp
    msk=. 2 # _2 =/\ 1 {"1 dat
    if. {. msk do.
      ndx=. msk # {:"1 dat
      for_loc. ndx{Locales do.
        Gstate__loc=: 1
      end.
    end.
    dat=. (-.msk)#dat
    if. #dat do.
      loc=. ((<0;_1){dat){Locales
      Gstate__loc=: 2
      loc=. ((<1;_1){dat){Locales
      Gstate__loc=: 1
      dat=. 2 }. dat
      bal=. bal,dat
    end.
  end.
  if. 0=#bal do. break. end.
  sectionrun (i.#Sections) e. {."1 bal
end.
)
sectionreset=: 3 : 0
locs=. (Localex e. iPAGE,iGROUP)#Locales
for_loc. locs do.
  State__loc=: 0
end.
EMPTY
)
sectionrun=: 3 : 0
PNum=: 0
Groups=: i.0 0
ndx=. y # i.#Sections
r=. ''
for_s. ndx{Sections do.
  log 'Build section ',":s_index{ndx
  setnewpage ''
  r=. r,<draw__s 1
end.
r
)
urls=: 3 : 0
r=. ''
for_s. Urls do.
  r=. r,<url__s''
end.
)
wrapbody=: 3 : 0
z=. ": 1 + #y
r=. '%PDF-1.4',LF
r=. r, '%', (a. {~128 + a. i. 'elmo'),LF
s=. 'xref',LF,'0 ',z,LF
s=. s,(10#'0'),' 65535 f ',LF
for_i. i.#y do.
  s=. s,(_10 {.!.'0' ": #r),' 00000 n ',LF
  c=. LF,(>i{y)
  r=. r,(":1+i),' 0 obj',c,'endobj',LF,LF
end.
hdr=. 'trailer',LF,'<<',LF,'/Size '
ftr=. '/Info 1 0 R',LF,'/Root 2 0 R',LF,'>>',LF,'startxref',LF
tr=. hdr, z, LF, ftr
r,s,LF,tr,(":#r),LF,'%%EOF'
)
wrapstream=: 3 : 0
if. PDFCompress do.
  s=. '<< /Length ',(":#y),' /Filter /FlateDecode >> stream',LF
  s,(9 compress_ppubzlib_ y),LF,'endstream',LF
else.
  y=. addLF y
  s=. '<< /Length ',(":#y),' >> stream',LF
  s,y,'endstream',LF
end.
)
wraptext=: 3 : 0
y=. addLF y
'BT',LF,y,'ET',LF
)
xobjects=: 3 : 0
r=. ''
for_s. XObjects do.
  r=. r,<xobject__s''
end.
)
coclass 'ppublish'
setcolor=: 3 : 0
clr=. ": y % 255
clr,' RG ',clr,' rg',LF
)
drawbox=: 3 : 0
'x y w h'=. y
xw=. x + w
yh=. y + h
cn=. _2 [\ x,y,x,yh,xw,yh,xw,y,x,y
r=. '0.1 w',LF
r,,(":}:cn) ,"1 ' m ' ,"1 (":}.cn) ,"1 ' l S',LF
)
drawboxc=: 4 : 0
(setcolor x),(drawbox y),setcolor BLACK
)
drawtext=: 3 : 0
r=. ''
for_d. y do.
  'pos clr font txt'=. d
  if. clr -: Textc do.
    s=. ''
  else.
    Textc=: clr
    s=. (":clr{Colors),' rg ',LF
  end.
  if. font ~: Textf do.
    Textf=: font
    Texth=: fontheight font
    s=. s,'/F',(":font{AFMffi),' ',(":Texth),' Tf ',LF
  end.
  txt=. pdfesc txt
  txt=. ' Tm (',txt,') Tj'
  clr=. ''
  pos=. pos - 0,Texth
  r=. r,s,clr,'1 0 0 1 ',(pfmt pos),txt,LF
end.
)
PDFRESC0=: LF,CR,TAB,FF,(8{a.),'\()'
PDFRESC1=: 'nrtfb\()'
PDFASC=: PDFRESC0,32}.127{.a.
pdfesc=: 3 : 0
txt=. y
msk=. txt e. PDFRESC0
if. 1 e. msk do.
  ndx=. , ((I. msk) + i. +/ msk) +/ 0 1
  new=. ,'\',.PDFRESC1 {~ PDFRESC0 i. msk#txt
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
coclass 'ppublish'
CIDfonts=: ''
AFMloc=: ''
AFMdir=: i.0 2
AFMffi=: ''
coclass 'ppublish'
CIDfonts=: ''
AFMloc=: ''
AFMdir=: i.0 2
AFMffi=: ''
fontascender=: 3 : 0
loc=. y { AFMloc
AscenderP__loc
)
fontbold=: 3 : 0
loc=. y { AFMloc
'fam sty'=. fontfs Name__loc
sty=. sty + sty e. 0 2
fontindex1 (4 #. fam,sty),Size__loc
)
fontindex=: 3 : 0
'fnt sty size ang und'=. getfont_jafm_ y
fontindex1 (4 #. fnt,sty),size
)
fontindex1=: 3 : 0
ndx=. AFMdir i. y
if. ndx = #AFMdir do.
  loc=. y newinstance 'jafm'
  AFMloc__locS=: AFMloc,loc
  AFMdir__locS=: AFMdir,y
  AFMffi__locS=: AFMffi,1 + (~.{."1 AFMdir) i. {.y
  ndx
end.
)
fontfs=: 3 : '0 4 #: PSFONTNAMES_jafm_ i. <y'
fontffi=: 3 : 0
ndx=. fontindex y,' 10'
ndx { AFMffi
)
fontheight=: 3 : 0
loc=. y { AFMloc
Size__loc
)
fontitalic=: 3 : 0
loc=. y { AFMloc
'fam sty'=. fontfs Name__loc
sty=. sty + 2 * sty < 2
fontindex1 (4 #. fam,sty),Size__loc
)
fontloc=: 3 : '(fontindex y) { AFMloc'
fontcharwidth=: 4 : 0
loc=. x { AFMloc
getcharlen__loc y
)
fontscale=: 4 : 0
(0.1 round x * getfontsize y) setfontsize y
)
fontwidth=: 4 : 0
loc=. x { AFMloc
getstrlen__loc y
)
fontwidthboxed=: 4 : 0
loc=. x { AFMloc
getstrlen__loc &> y
)
fontwidthboxedm=: 4 : 0
loc=. x { AFMloc
getstrwid__loc &> y
)
fontwidths=: 4 : 0
loc=. x { AFMloc
getstrlens__loc y
)

coclass 'ppublish'
delNB=: 3 : 0
txt=. <;._2 y
txt=. txt #~ (<'NB.') ~: 3 {.each txt
; txt ,each LF
)
findrx=: 4 : 0
hit=. x rxmatches y
res=. (#y)$0
if. #hit do.
  1 ({."1 {."2 hit) } res
end.
)
pairs=: 4 : 0
r=. +/\x - y
*./ (0={:r), 0<:r
)
premask=: 3 : 0
bgn=. I. '<pre>' E. y
res=. (#y)$0
if. 0 = #bgn do. return. end.
end=. I. '</pre>' E. y
if. (#bgn) ~: #end do.
  throw '101 Unmatched <pre> and </pre> tags'
end.
end=. (end+6) -. #res
msk=. +/\ _1 end } 1 bgn } res
if. -. *./ msk e. 0 1 do.
  throw '101 Unmatched <pre> and </pre> tags'
end.
0 < msk
)
tagsplit=: 3 : 0
if. 1 ~: > {.{.y do.
  throw '101 Invalid tag block'
end.
tags=. 1 {"1 y
tag0=. > {. tags
if. '/' = {:tag0 do.
  (,:{.y);<}.y
else.
  msk=. tags = {.tags
  cnt=. ;msk # {."1 y
  ndx=. 1 i.~ 0 = +/\cnt
  len=. ndx { (1 + I. msk),1
  (len{.y);<len}.y
end.
)
fixedtext=: 3 : 0
txt=. y
var=. -. premask txt
msk=. '' fixedtag txt;var;'comment'
msk=. 'AUTHOR' fixedtag txt;msk;'author'
msk=. 'TITLE' fixedtag txt;msk;'title'
msk=. msk >: var
trimWS msk#txt
)
fixedtag=: 4 : 0
'txt msk tag'=. y
b=. msk *. (wraptag tag) E. txt
e=. msk *. ('</',tag,'>') E. txt
if. -. b pairs e do.
  throw '101 Begin and end tags do not match for tag: ',wraptag tag
end.
if. 0=+/b do. msk return. end.
b=. I.b
e=. I.e
len=. 2+#tag
ndx=. b (+i.) each 1+len+e-b
tag=. len }. (-1+len) }. (_1 pick ndx) { txt
if. (#x) *. #tag do. (x)=: tag end.
0 (;ndx) } msk
)
parseml=: 4 : 0
msk=. (y = '<') > premask y
ndx=. msk i. 1
hdr=. ndx {. y
txt=. ndx }. y
if. 0=#txt do. ,:1;'';'';hdr return. end.
dat=. msk <;.1 y
len=. # &> dat
ndx=. (dat i.&> '>') <. dat i.&> ' '
val=. ndx {.each dat
ife=. (<'</') = 2 {.each val
bgn=. ; len {.each (}.each val) e. x
end=. ; len {.each ife *. (2 }.each val) e. x
msk=. bgn +. end
bgn=. msk#bgn
end=. msk#end
ndx=. msk i. 1
hdr=. hdr, ndx {. txt
dat=. msk <;.1 txt
ind=. dat indexq &> '>'
prm=. ind {.each dat
dat=. (1+ind) }.each dat
sel=. '/' ~: {:&> prm
if. -. (sel#bgn) pairs sel#end do.
  throw '101 Begin and end tags do not match'
end.
off=. bgn-end
prm=. (bgn++:end) }.each prm
ndx=. prm i.&> ' '
tag=. ndx {.each prm
prm=. (1+ndx) }.each prm
prm=. cutparms each prm
res=. (<&>off),.tag,.prm,.dat
if. #hdr do.
  (1;'';'';hdr),res
end.

)
readtext=: 3 : 0
txt=. pread y
txt=. trimWS delNB txt
inc=. ('<include>' E. txt) > premask txt
if. 0=#inc do. txt return. end.
ndx=. inc i. 1
res=. ndx {. txt
txt=. inc <;.1 txt
for_t. txt do.
  t=. >t
  ndx=. 1 i.~ '</include>' E. t
  if. ndx = #t do.
    throw '101 <include> tag has no closing </include>'
  end.
  f=. filename 9 }. ndx {. t
  t=. (ndx+10) }. t
  h=. ''
  select. tolower _4 {. f
  case. '.ijs' do.
    jcmd pread f
  case. '.sty' do.
    0!:100 pread f
  case. '.txt' do.
    h=. readtext f
  case. do.
    throw '101 Invalid <include> file type: ',f
  end.
  res=. res,h,t
end.
trimWS res
)
rxinit=: 3 : 0
Rxh1=: rxcomp '<h1[^>]*>'
Rxhnd=: Rxh1
)
parsesec=: 3 : 0
txt=. parsej y
sec=. StructTags parseml txt
if. 1 e. '<pre>' E. y do.
  sec=. parsepre sec
end.
sec=. parsegroup sec
a=. newsection''
make__a sec
)
parsegroup=: 3 : 0
msk=. (<'group') = 1{"1 y
if. -. 1 e. msk do. y return. end.
mid=. (~:/\msk) # 1{"1 y
if. 1 e. NotGroupTags e. mid do.
  msg=. towords wraptag each NotGroupTags intersect mid
  throw '101 Not supported within <group> tag: ',msg
end.
(1;'group/') (<(I.msk);0 1) } y
)
parsej=: 3 : 0
txt=. y
msk=. ('<j>' E. txt) > premask txt
if. -. 1 e. msk do. txt return. end.
ndx=. msk i. 1
res=. ndx {. txt
txt=. 3 }. each msk <;.1 txt
for_t. txt do.
  t=. >t
  x=. ('</j>' E. t) i. 1
  exp=. jcmdr x {. t
  res=. res,exp,(x+4) }. t
end.
)
parsepre=: 3 : 0
r=. i.0 4
for_s. y do.
  txt=. 3 pick s
  msk=. '<pre>' E. txt
  if. 1 e. msk do.
    ndx=. msk i. 1
    hdr=. ndx {. txt
    r=. r,(3 {. s),<hdr
    for_t. msk <;.1 txt do.
      t=. >t
      ndx=. 1 i.~ '</pre>' E. t
      r=. r,1;'pre';'';5 }. ndx {. t
      r=. r,_1;'pre';'';(ndx+6) }. t
    end.
  else.
    r=. r,s
  end.
end.
)
StructTags=: readlist''
group
h0
h1
h2
h3
h4
h5
h6
image
list
para
newpage/
plot
skip
table
toc
)
NotGroupTags=: <;._1 ' h0 h1 newpage/ toc'
parsetext=: 3 : 0
txt=. trimLF y
if. 0=#txt do. '';0 return. end.
msk=. Rxh1 findrx txt
msk=. msk > premask txt
front=. 0 = {.msk
msk=. 1 (0)} msk
txt=. msk <;.1 txt
txt=. trimLF each txt
txt;front
)
coclass 'ppubzlib'
z2chr=: 2 & ic
z2num=: _2 & ic
zlibinit=: 3 : 0
if. UNAME-:'Linux' do.
  p=. > (IFDEF'android') {'libz.so.1';'libz.so'
elseif. UNAME-:'Darwin' do.
  p=. 'libz.dylib'
elseif. do.
  p=. 'zlib1.dll'
  p=. (fexist p) # p
end.
res=. 0 < #p
if. res do.
  zcompress2=: (p,' compress2 + i * *i * i i') & cd
  zuncompress=: (p,' uncompress + i * *i * i') & cd
end.
res
)


compress=: 3 : 0
1 compress y
:
dat=. y
len=. >: >. 1.01 * 12 + #dat
'rc res wid j j j'=. zcompress2 ((len$' ');,len),dat;(#dat);x
if. rc do.
  dat
else.
  wid {. res
end.
)
coclass 'ppubgroup'
Gstate=: 0
State=: 0
create=: 3 : 0
coinsert locP=: COCREATOR
GroupNum=: newgroup''
)
draw=: 3 : 0
select. Gstate
case. 0 do.
  setgroup ''
  0;''
case. 1 do.
  0;''
case. 2 do.
  State=: -. State
  State;''
end.
)
coclass 'ppubimage'
Loc=: ''
add=: 3 : 'Loc=: y'
create=: 3 : 0
coinsert locP=: COCREATOR
)
coclass 'ppubimage'
Loc=: ''
add=: 3 : 'Loc=: y'
create=: 3 : 0
coinsert locP=: COCREATOR
)
draw=: 3 : 0

plot=. Loc e. Plots
scale=. |. 2 $ SCALE

'rws cls'=. scale * Shape__Loc
pre=. PARASPACE * fontheight fontindex FONTTH
pst=. pre
if. Sh < rws+pre do.
  1;'' return.
end.

mx=. Sx + (Sw-cls) * ALIGN { 0 0.5 1 0.5
my=. pre -~ Sy + (Sh-rws) * ALIGNV { 1 0.5 0
if. plot do.
  dat=. draw__Loc''
  ts=. _1 |. 0 0,scale
else.
  dat=. '/',NAME__Loc,' Do'
  ts=. cls,0 0,rws
end.
r=. 'q'
r=. r,LF,(":ts,mx,my),' cm'
r=. r,LF,dat
r=. r,LF,'Q',LF
setsxywhP Sx,Sy,Sw,(ALIGNV=0)*Sh-rws+pre+pst
0;r
)

coclass 'ppublist'
create=: 3 : 0
coinsert locP=: COCREATOR
)
coclass 'ppublist'
create=: 3 : 0
coinsert locP=: COCREATOR
)
coclass 'ppubpage'
State=: 0
create=: 3 : 0
coinsert locP=: COCREATOR
)
draw=: 3 : 0
State=: -. State
State;''
)
coclass 'ppubplot'
Data=: ''
Shape=: ''
create=: 3 : 0
coinsert locP=: COCREATOR
NAME=: 'Pl',":#Plots
Plots__locS=: Plots,coname''
)
add=: 3 : 0
dat=. 1!:1 :: _1: <filename y
if. dat -: _1 do.
  throw '101 Unable to read file: ',filename y
end.
ndx=. dat i. LF
hdr=. ndx {. dat
dat=. (ndx+1) }. dat
hdr=. <;._2 hdr
Shape=: |. 0 ". 0 pick hdr
fnt=. <;._2 [ 1 pick hdr
rep=. i. 0 2
for_f. fnt do.
  x=. fontffi > f
  n=. f_index + 1
  if. x ~: n do.
    rep=. rep,('BT /F',(":n),' ');'BT /F',(":x),' '
  end.
end.
if. rep do.
  dat=. dat rplc rep
end.
Data=: dat
)
draw=: 3 : 'Data'

coclass 'ppubpre'
Data=: ''
Font=: ''
create=: 3 : 0
coinsert locP=: COCREATOR
)
add=: 3 : 0
Data=: u2a y
Font=: fontindex FONTPF
)
draw=: 3 : 0

if. y do.
  Dbal=: <;._2 Data,LF
end.

hit=. fontheight Font
max=. <. Sh % hit
rc=. max < #Dbal
if. rc do.
  dat=. max {. Dbal
  Dbal=: max }. Dbal
else.
  dat=. Dbal
end.
pos=. <"1 Sx,.Sy + Sh - hit * i.#dat
Textc=: Textf=: _1
r=. wraptext drawtext pos,.(<0),.(<Font),.dat
setsxywhP Sx,Sy,Sw,Sh-hit * #dat
rc;r
)
coclass 'ppubsection'
Locs=: ''
Locx=: ''
Name=: ''
LName=: ''
create=: 3 : 0
coinsert locP=: COCREATOR
Sections__locP=: Sections,coname''
Level=: Level__locP,#Sections
if. FrontPage *. 1=#Level do. Level=: <:Level end.
if. 1 = #Level do. SNum=: newsectionnum'' end.
Sections=: ''
)
new=: 3 : 0
a=. '' newinstance 'ppub',y
i=. ('i',toupper y)~
Locs=: Locs,a
Locx=: Locx,i
Locales__locS=: Locales,a
Localex__locS=: Localex,i
a
)
dogroup=: 0:
reset=: ]
draw=: 3 : 0
newpage=. 1=#Level
page=. ''
if. y do.
  setsxywh Sxywh__locP
end.
res=. i.0 3
for_loc. Locs do.
  if. ShowFrames do. page=. page,LF,RED drawboxc Sxywh end.
  lox=. loc_index { Locx
  r=. draw__loc 1
  if. lox = iSECTION do.
    if. #page do.
      res=. res, Level;newpage;page
      newpage=. 0
      page=. ''
    end.
    res=. res, r continue.
  end.
  while.
    'rc dat'=. r
    page=. page,dat
    rc do.
    if. #page do.
      res=. res, Level;newpage;page
      page=. ''
    end.
    newpage=. 1
    setnewpage''
    r=. draw__loc 0
  end.
end.
setsxywhP Sxywh
res=. res, Level;newpage;page
res
)
Headers=: ;: 'h1 h2 h3 h4 h5 h6'
make=: 3 : 0
max=. BMLEVEL >. TOCLEVEL
lvlheaders=. 'h0';(#Level) {. Headers
subheaders=. (#Level) }. max {. Headers
while. #y do.

  'top y'=. tagsplit y
  'off tag prm val'=. {. top
  bal=. > {: {: top
  select. tag
  case. lvlheaders do.
    a=. new 'header'
    add__a top
  case. subheaders do.
    ndx=. (1{"1 y) i. <tag
    top=. top, ndx {. y
    bal=. ''
    y=. ndx }. y
    a=. new 'section'
    make__a top
  case. Headers do.
    a=. new 'header'
  case. 'group/' do.
    new 'group'
  case. 'newpage/' do.
    new 'page'
  case. 'toc' do.
    if. #val do.
      a=. new 'text'
      set__a 'fontp';FONTC0
      set__a prm
      add__a val
    end.
    a=. new 'toc'
    set__a prm
  case. 'image' do.
    if. '.jpf' -: deb _4 {. val do.
      a=. newplot''
    else.
      a=. newxobject''
    end.
    add__a val
    b=. new 'image'
    set__b prm
    add__b a
  case. 'para' do.
    a=. new 'text'
    set__a prm
    add__a val
  case. 'pre' do.
    a=. new 'pre'
    add__a val
  case. 'skip' do.
    a=. new 'skip'
    add__a val
  case. 'table' do.
    a=. new 'table'
    add__a top
  case. '' do.
    bal=. val
  case. do.
    throw '101 Invalid tag: ',wraptag tag
  end.
  bal=. trimWS bal
  if. #bal do.
    a=. new 'text'
    add__a bal
    bal=. ''
  end.

end.
)
coclass 'ppubskip'
Size=: 1
create=: 3 : 0
coinsert locP=: COCREATOR
)
add=: 3 : 0
Size=: {. (0 ". y),Size
)
draw=: 3 : 0
h=. Size * fontheight fontindex FONTP
setsxywhP Sxywh - 0 0 0,h
0;''
)
coclass 'ppubskip'
Size=: 1
create=: 3 : 0
coinsert locP=: COCREATOR
)
add=: 3 : 0
Size=: {. (0 ". y),Size
)
draw=: 3 : 0
h=. Size * fontheight fontindex FONTP
setsxywhP Sxywh - 0 0 0,h
0;''
)
coclass 'ppubtable'
Align=: ''
Bold=: ''
Col=: ''
Data=: ''
Font=: ''
High=: ''
Gridv=: ''
Gridh=: ''
Row=: ''
Top=: ''
CLASS=: 'std'
SHAPE=: ''
NewPage=: 0
STATE=: 0
Leading=: 1.4
Leadingm=: 1
MinCellWid=: 50
MinLabelWid=: 100
PadCell=: 15
PadHeader=: 0
PadLabel=: 1
SepHdrCell=: 2
create=: 3 : 0
coinsert locP=: COCREATOR
)
br2lf=: 3 : 0
m=. '<br/>' E. y
if. -. 1 e. m do. y return. end.
((m i. 1) {. y), ; LF ,each 5 }. each m <;.1 y
)
drawall=: 3 : 0
res=. drawback''
res, drawcell''
)
draw_keskey=: draw_std
setalign=: 3 : 0
aln=. ,Align
select. #aln
case. 0 do.
  Trws$,:0,Ccls$1
case. 1;Ccls;Clen do.
  0,.((Hrws,Ccls)$1),(Crws,Ccls)$aln
case. (Ccls + 1);Tlen do.
  (Trws,Tcls) $ aln
case. do.
  throw '101 Invalid align setting'
end.
)
setfont=: 3 : 0
f0=. fontindex FONTTH
f1=. fontbold f0
f2=. fontindex FONTTC
f3=. fontbold f2
bld=. ,Bold
select. #bld
case. 0 do.
  r=. ((Hrws,Ccls+1)$1),1,.(Crws,Ccls)$2
case. 1;Ccls;Clen do.
  r=. 1,.((Hrws,Ccls)$1),(Crws,Ccls)$2+bld
case. (Ccls + 1);Tlen do.
  r=. ((Trws,Tcls) $ bld) + (-Trws,Tcls) {. (Crws,Ccls)$2
case. do.
  throw '101 Font values do not match table size'
end.
tab=. r { f0,f1,f2,f3
hdr=. ({."1 r),,Hrws{.r
F0=. (>./hdr) { f0,f1
dat=. (}."1 r),,Hrws}.r
F1=. (_2+>./hdr) { f2,f3
tab;F0;F1
)
setgridh=: 3 : 0
gh=. ,Gridh
select. #gh
case. 0 do.
  (1+Trws)$0
case. 1;1+Trws do.
  (1+Trws)$gh
case. do.
  throw '101 Gridh values do not match table size'
end.
)
setgridv=: 3 : 0
gv=. ,Gridv
select. #gv
case. 0 do.
  (1+Tcls)$0
case. 1;1+Tcls do.
  (1+Tcls)$gv
case. do.
  throw '101 Gridv values do not match table size'
end.
)
sethigh=: 3 : 0
clr=. ,High
def=. (-Trws) {. 1,.(Crws,Ccls)$2
select. #clr
case. 0 do.
  def
case. 1 do.
  def sethighx {.clr
case. Ccls;Clen do.
  ndx=. <(Hrws+i.Crws);1+i.Ccls
  (2 sethighx (Crws,Ccls) $ clr) ndx } def
case. (Ccls + 1);Tlen do.
  def sethighx (Trws,Tcls) $ clr
case. do.
  throw '101 Color values do not match table size'
end.
)
sethighx=: 4 : '(x * y=0) + (y+2) * y>0'
TableTags=: <;._2 (0 : 0)
align
bold
col
data
gridh
gridv
high
row
top
)
add=: 3 : 0
'off tag prm val'=. checktag2 y
set prm
val=. TableTags parseml val
if. -. (<'data') e. 1{"1 val do.
  throw '101 Data not given in table definition'
end.
msk=. (<1) = {."1 val
addopts msk # val
IfRow=: 0 < #Row
IfCol=: 0 < #Col
select. IfRow,IfCol
case. 0 0 do.
  if. 0=#SHAPE do.
    throw '101 Shape not given in table definition'
  end.
  'Crws Ccls'=: SHAPE
  Clen=: Crws * Ccls
  Row=: Crws#<''
  Col=: Ccls#<''
  Top=: ''
case. 1 0 do.
  Clen=: #Data
  Crws=: #Row
  Ccls=: <. Clen % Crws
  Col=: Ccls#<''
  Top=: ''
case. 0 1 do.
  Clen=: #Data
  Ccls=: #Col
  Crws=: <. Clen % Ccls
  Row=: Crws#<''
case. 1 1 do.
  Crws=: #Row
  Ccls=: #Col
  Clen=: Crws * Ccls
end.
if. Clen ~: #Data do.
  msg=. LF,LF,'Expected data items: ',":Clen
  msg=. msg,LF,LF,'Given data items: ',":#Data
  throw '101 Table data does not match rows and cols',msg
end.
CDlen=: 1 + +/@(LF&=) &> Data
CRlen=: >./"1 (Crws,Ccls) $ CDlen
IfMulti=: 1 e. 1 < CDlen
if. IfMulti do.
  DataM=: ; CDlen {.each 1
  DataX=: ; <;._1 each LF ,each Data
end.
hc=. <;._1 &> LF ,each Top;Col
Top=: {.hc
Col=: |:}.hc

if. Ccls ~: {:$Col do.
  msg=. LF,LF,'Expected header columns: ',":Ccls
  msg=. msg,LF,LF,'Given header columns: ',":{:$Col
  throw '101 Header columns do not match data',msg
end.
Hrws=: #Col
Trws=: Hrws+Crws
Tcls=: 1 + Ccls
Tlen=: Trws * Tcls
)
addopts=: 3 : 0
for_d. y do.
  'off nam prm val'=. d
  set prm
  val=. u2a val
  select. nam
  case. 'align' do.
    Align=: fix val
  case. 'bold' do.
    Bold=: fix val
  case. 'col' do.
    Col=: br2lf each cutlist val
  case. 'data' do.
    Data=: br2lf each cutlist val
  case. 'gridh' do.
    Gridh=: fix val
  case. 'gridv' do.
    Gridv=: fix val
  case. 'high' do.
    High=: fix val
  case. 'row' do.
    Row=: cutlist val
  case. 'top' do.
    Top=: br2lf deb val
  end.
end.
)
drawback=: 3 : 0

r=. '0.2 w',LF
rx=. {.Dx
rw=. {.Dw
rh=. Dh0
ry=. (}:Dy) - rh
if. IfRow do.
  pos=. rx,.ry,.rw,.rh
  clr=. ({."1 Thigh) { Tbcolor
  r=. r,clr drawbackcolor pos
end.
if. IfCol do.
  cx=. (Hrws*Ccls) $ }.}:Dx
  cw=. (Hrws*Ccls) $ }. Dw
  ch=. Ccls # Hrws {. rh
  cy=. Ccls # Hrws {. ry
  pos=. cx,.cy,.cw,.ch
  clr=. (, }."1 Hrws {. Thigh) { Tbcolor
  r=. r,clr drawbackcolor pos
end.
x=. Clen$}.}:Dx
w=. Clen$}.Dw
h=. Ccls#Hrws}.Dh
y=. (Ccls#Hrws}.}:Dy) - h
pos=. x,.y,.w,.h
clr=. (, }."1 Hrws }. Thigh) { Tbcolor
r=. r,clr drawbackcolor pos
r,'0 0 0 rg 0 0 0 RG',LF
)

drawbackcolor=: 4 : 0

off=. 0 0 0.1 0.1
msk=. x ~: iWHITE
msk=. msk *. (0 < 2{"1 y) *. 0 < 3{"1 y
if. 0 = +/ msk do. '' return. end.

clr=. msk # x
pos=. msk # y
pos=. clr </. pos -"1 off

nub=. ~.clr
r=. '0.2 w',LF
for_c. nub do.
  c=. ": c { Colors
  c=. c,' rg ', c, ' RG '
  c=. c ,"1 (pfmt c_index pick pos),"1 ' re B',LF
  r=. r,,c
end.
)
drawcell=: 3 : 0

vw=. Dw -"1 Tw
dy=. Dy - (#Dy) {. PadHeader
if. IfRow do.
  x=. ({.Dx) + -: ({."1 Align) * ({."1 vw) - PadLabel
  x=. x + PadLabel * {.Gridv
  pos=. x,.}:dy
  clr=. ({."1 Thigh) { Tfcolor
  dat=. Top,Row
  fnt=. {."1 Font
else.
  pos=. i. 0 2
  clr=. dat=. fnt=. ''
end.
s=. Hrws,Ccls
a=. ,}."1 Hrws{.Align
x=. ,s $ }:}.Dx
x=. x + -: (a * , }."1 Hrws {. vw) - (a-1) * PadCell
y=. Ccls # Hrws {. dy
pos=. pos,x,.y
clr=. <&> clr,(, }."1 Hrws {. Thigh) { Tfcolor
fnt=. <&> fnt,,}."1 Hrws{.Font
dat=. dat,,Col
r=. drawtext (<"1 pos),.clr,.fnt,.dat
s=. Crws,Ccls
a=. ,}."1 Hrws}.Align
x=. ,s $ }:}.Dx
x=. x + -: (a * ,}."1 Hrws }. vw) - (a-1) * PadCell
y=. ,Ccls # Hrws }.}: dy
clr=. <&> (, }."1 Hrws }. Thigh) { Tfcolor
fnt=. <&> ,}."1 Hrws}.Font

if. IfMulti do.
  a=. CDlen#a
  h=. ; (Fh1m * i.) each CDlen
  y=. h -~ CDlen#y
  x=. (CDlen#x) - Twx * -: a
  clr=. CDlen#clr
  fnt=. CDlen#fnt
  dat=. DataX
else.
  dat=. Data
end.
r=. r,drawtext (<"1 x,.y),.clr,.fnt,.dat
wraptext r
)
draw=: 3 : 0

if. (NewPage=0) *. y=0 do.
  drawtable'' return.
end.
NewPage=: 0
Align=: setalign''
Gridh=: setgridh''
Gridv=: setgridv''
Thigh=: sethigh''
FONTTHSIZE=: getfontsize FONTTH

'Font F0 F1'=: setfont''
RowPos=: 0
Textf=: Textc=: _1
space=. _4 {. prnd PARASPACE * fontheight F0
setsxywhP Sxywh - space
res=. ('draw_',tolower CLASS)~''
setsxywhP Sxywh - space

res
)
drawit=: 3 : 0
while. 1 do.
  Fh0=: prnd Leading * fontheight F0
  Fh1=: prnd Leading * fontheight F1
  Fh1m=: prnd Leadingm * fontheight F1
  hrw=. F0 fontwidthboxed Row
  hcw=. F0 fontwidthboxed Col
  htw=. F0 fontwidthboxed Top
  if. IfMulti do.
    dtx=: F1 fontwidthboxed DataX
    dtw=. (Crws,Ccls)$DataM >./;.1 dtx
    Twx=: dtx - CDlen#,dtw
  else.
    dtw=. F1 fontwidthboxed (Crws,Ccls)$Data
  end.
  Tw=: (htw,.hcw),hrw,.dtw
  rlw=. IfRow * MinLabelWid >. PadLabel + >./htw,hrw
  dcw=. MinCellWid >. PadCell + >./ hcw,dtw
  Dw=: rlw, dcw
  Dx=: Sx + +/\ 0, Dw

  if. Sw >: +/ Dw do. break. end.
  select. STATE
  case. 0 do.
    k=. 0.5
    inc=. 0.01
    while. k < 1 do.
      t=. k + inc
      rlw=. IfRow * (t*MinLabelWid) >. (t*PadLabel) + >./htw,hrw
      dcw=. (t*MinCellWid) >. (t*PadCell) + >./ hcw,dtw
      if. Sw < +/ rlw,dcw do. break. end.
      k=. t
    end.
    scalemargins k
    STATE=: 1
  case. 1 do.
    if. (-: FONTTHSIZE) >: getfontsize FONTTH do.
      STATE=: 2
    else.
      FONTTH=: 0.99 fontscale FONTTH
      FONTTC=: 0.99 fontscale FONTTC
      'Font F0 F1'=: setfont''
    end.
  case. 2 do.
    break.
  end.

end.
if. IfCol do.
  hch=. (Hrws$Fh0) + Hrws{.PadHeader
else.
  hch=. 0
end.
Dh0=: hch, (Fh0>.Fh1) + Fh1m * CRlen-1
Dh=: Dh0 + (#Dh0){.(-Hrws*IfCol){.SepHdrCell
Dy=: Sy + Sh - +/\ 0,Dh
drawtable''
)
scalemargins=: 3 : 0
MinLabelWid=: y*MinLabelWid
PadLabel=: y*PadLabel
MinCellWid=: y*MinCellWid
PadCell=: y*PadCell
)
draw_std=: 3 : 0
Gridh=: 0 (1+i.Hrws) } Gridh
'rc txt'=. drawit''
if. rc do. rc;txt return. end.
s=. ''
if. IfCol do.
  x=. {.Dx
  xw=. {:Dx
  y=. ({.Dy) - +/ Hrws{.Dh0
  t=. '0 0 0 RG ',(":TGRIDSIZE),' w '
  s=. s,t,(":x,y),' m ',(":xw,y),' l S',LF
end.
if. +/Gridh do.
  ndx=. I. Gridh > 0
  siz=. TGRIDSIZE * ndx { Gridh
  x=. {.Dx
  xw=. {:Dx
  y=. ndx { Dy
  t=. '0 0 0 RG ',"1 (": ,.siz) ,"1 ' w '
  p=. (": x,.y) ,"1 ' m ' ,"1 (":xw,.y)
  s=. s,,t,.p,"1 ' l S',LF
end.
if. +/Gridv do.
  ndx=. I. Gridv > 0
  siz=. TGRIDSIZE * ndx { Gridv
  x=. ndx { Dx
  y=. {.Dy
  yh=. {:Dy
  t=. '0 0 0 RG ',"1 (": ,.siz) ,"1 ' w '
  p=. (": x,.y) ,"1 ' m ' ,"1 (":x,.yh)
  s=. s,,t,.p,"1 ' l S',LF
end.
rc;txt,s
)
drawtable=: 3 : 0
hit=. +/ (Hrws{.Dh),(Hrws+RowPos)}.Dh
if. Sh >: hit do.
  res=. drawrows Crws - RowPos
  setsxywhP Sx,Sy,Sw,Sh - hit
  0;res return.
end.
if. hit <: {:Dxywh do.
  NewPage=: 1
  1;'' return.
end.
hit=. +/\ (Hrws{.Dh),(Hrws+RowPos)}.Dh
rws=. (Sh < hit) i. 1
max=. (({:Dxywh) < +/\ Dh) i. 1
req=. max <. 3 + Hrws
if. rws < req do. 1;'' return. end.
blk=. rws - Hrws
res=. drawrows blk
RowPos=: RowPos + blk
1;res
)
drawrows=: 3 : 0
if. y = Crws do.
  drawall'' return.
end.
a=. cocreate''
coinsert__a coname''
res=. drawrows1__a y
coerase a
res
)
drawrows1=: 3 : 0
pos=. RowPos
dat=. (Crws,Ccls)$Data
Crws=: y
Clen=: Crws * Ccls
cndx=. RowPos + i.Crws
ndx=. (i.Hrws),Hrws + cndx
Dh0=: ndx { Dh0
Dh=: ndx { Dh
Dy=: Sy + Sh - +/\ 0,Dh
Data=: ,cndx { dat
Row=: cndx { Row
Align=: ndx { Align
Gridh=: ((1+Hrws) {. Gridh),(Hrws+cndx) { Gridh
Font=: ndx { Font
Thigh=: ndx { Thigh
Tw=: ndx { Tw
drawall''
)
coclass 'ppubtext'
Data=: ''
Para=: ''
Font=: ''
Color=: ''
create=: 3 : 0
coinsert locP=: COCREATOR
)
delparaLF=: 3 : 0
txt=. LF, y
a=. txt ~: ' '
b=. (a # txt) e. LF
c=. b +. }. b, 1
d=. ~: /\ a #^:_1 c ~: }: 0, c
}. (a >: d) # txt
)
fitdlb=: 3 : 0
'c f t w h'=. {.y
if. ' ' ~: {.t do. y return. end.
t=. (+./\ ' ' ~: t) # t
w=. f fontwidth t
(c;f;t;w;h) 0 } y
)
fitdtb=: 3 : 0
'c f t w h'=. {:y
if. ' ' ~: {:t do. y return. end.
t=. (+./\. ' ' ~: t) # t
w=. f fontwidth t
(c;f;t;w;h) _1 } y
)
fixbreak=: 3 : 0
y rplc ('<br/>',LF);'<br/>'
)
add=: 3 : 0
dat=. y
dat=. fixbreak dat
select. L. dat
case. 0 do.
  if. 0=#Font do.
    Font=: fontindex FONTP
  end.
  if. 0=#Color do.
    Color=: iBLACK
  end.
  dat=. fixpara each cutparas dat
case. 1 do.
  dat=. <citemize dat
case. 2 do.
  dat=. citemize each dat
end.
Data=: Data,dat
)
draw=: drawpara
drawpara=: 3 : 0

if. y do.
  Para=: Sw fit &> Data
end.
cls=. {:"1 each {:"1 Para
par=. LEADING * +/ &> cls
spc=. PARASPACE * {:&> cls
scn=. +/\par + 0,}:spc
mov=. +/par + spc
tot=. {:scn
rc=. Sh < tot
if. rc do.
  ndx=. (scn <: Sh) i. 0
  tot=. ndx { 0,scn
  dat=. ndx {. Para
  Para=: ndx }. Para
else.
  dat=. Para
end.
mx=. Sx + Sw * ALIGN { 0 0.5 1 0
my=. Sy + Sh - -: ALIGNV * Sh - tot
Textc=: Textf=: _1
r=. ''
for_d. dat do.
  'par siz'=. d
  for_p. par do.
    for_ln. p do.
      cnk=. > ln
      hit=. >./ ; 4{"1 cnk
      wid=. ; 3 {"1 cnk
      if. wid do.
        select. ALIGN
        case. iLEFT do.
          px=. mx + 0, +/\ }: wid
        case. iCENTER do.
          ext=. {: len=. +/\ wid
          px=. (mx - -: ext) + 0, }:len
        case. iRIGHT do.
          px=. mx - +/\. wid
        case. iJUST do.
          if. p_index < <: #par do.
            'wid cnk'=. Sw drawjust cnk
          end.
          px=. mx + 0, +/\ }: wid
        end.
        pos=. <"1 px,.my
        r=. r,drawtext pos,.3 {."1 cnk
      end.
      my=. my - prnd hit*LEADING
    end.
  end.
  my=. my - prnd hit*PARASPACE
end.
setsxywhP Sx,Sy,Sw,(ALIGNV=0) * Sh-mov
rc;wraptext r
)
drawjust=: 4 : 0
wid=. x
cnk=. fitdlb y
res=. i.0 4
for_d. cnk do.
  'c f t w h'=. d
  wid=. f fontcharwidth t
  msk=. 1, }. t=' '
  wid=. msk +/ ;.1 wid
  t=. msk <;.1 t
  res=. res, (<c),.(<f),.t,.(<&>wid),.<h
end.
wid=. ; 3{"1 res
if. 0.75 <: (+/wid) % x do.
  wid=. wid + (x - +/wid) % 1 >. <:#res
end.
wid;<res
)
fit=: 4 : 0
wid=. x
dat=. y
txt=. u2a each 2{"1 dat
dat=. txt 2}"0 1 dat
fit=. ''
siz=. i.0 2
while. #dat do.
  'lin bal'=. wid fitline dat
  lin=. fitdtb lin
  fit=. fit,<lin
  len=. +/ ; 3 {"1 lin
  hit=. >./; 4 {"1 lin
  siz=. siz,len,hit
  if. bal -: dat do.
    throw '201 Problem in fit - unable to fit text in width'
  end.
  dat=. bal
end.
fit;siz
)
fitchars=: 4 : 0
'fnt txt'=. y
len=. fnt fontwidths txt
cnt=. (len > x) i. 1
(cnt{.txt);(cnt}.txt);cnt { 0,len
)
fitline=: 4 : 0
res=. x fitline1 y
if. #0 pick res do. return. end.
cf=. 2 {.{:y
(cf,'';0;fontheight 1 pick cf);{:res
)
fitline1=: 4 : 0
wid=. x
dat=. y
fit=. i. 0 5
bal=. i. 0 3
while. #dat do.
  'clr fnt txt'=. top=. {.dat
  if. 0=#txt do. dat=. }.dat continue. end.
  if. txt -: ,LF do.
    dat=. }.dat
    fit;<dat,bal return.
  end.
  if. LF e. }: txt do.
    ndx=. txt i. LF
    rem=. (ndx+1) }. txt
    bal=. }.dat
    if. #rem do. bal=. (clr;fnt;rem),bal end.
    dat=. ,:clr;fnt;(ndx+1){.txt continue.
  end.
  'txt rem len hit'=. wid fitwords }. top
  if. len=0 do.
    fit;<dat,bal return.
  end.
  dat=. }. dat
  fit=. fit,clr;fnt;txt;len;hit
  if. #rem do.
    bal=. dat,bal
    if. -. rem -: ,LF do.
      bal=. (clr;fnt;rem),bal
    end.
    fit;<bal return.
  end.
  wid=. wid-len
end.
fit;<bal
)
fitwords=: 4 : 0
wid=. x
'fnt str'=. y
b=. LF = {:str
tlf=. b#LF
txt=. (-b) }. str -. HYPHEN
if. LF e. txt do.
  throw '201 Problem in fitwords - text has a LF'
end.
hit=. fontheight fnt
off=. +/\ 1 + str = HYPHEN
len=. 0, fnt fontwidths txt
cnt=. <: (len > wid) i. 1
if. cnt = 0 do.
  '';str;0;hit return.
end.
if. cnt = #txt do.
  txt;tlf;({:len);hit return.
end.
if. ' ' = (cnt-1){txt do.
  cnt=. cnt-1
  bal=. (cnt{off)}.str
  (cnt{.txt);bal;(cnt{len);hit return.
end.
if. ' ' = cnt{txt do.
  bal=. (cnt{off)}.str
  (cnt{.txt);bal;(cnt{len);hit return.
end.
pfx=. cnt {. txt
ndx=. pfx i: ' '
sel=. ndx { len
bal=. (ndx{off)}.str
res=. (ndx{.txt);bal;sel;hit

if. -. HYPHEN e. str do. res return. end.
hlen=. {. fnt fontwidth '-'
hcnt=. <: (len > wid - hlen) i. 1
htxt=. (off i. hcnt) {. str
hndx=. htxt i: '~'
if. hndx = #htxt do. res return. end.
if. hndx <: ndx do. res return. end.
pfx=. (hndx{.txt),'-'
sel=. hlen + hndx { len
bal=. (1+(hndx-1){off)}.str
pfx;bal;sel;hit
)
make=: 4 : 0
r=. i. 0 3
'clr fnt'=. x
ind=. (0 _1;1);<_1;_1
while. #y do.
  'top y'=. tagsplit y
  'off tag prm val'=. {. top
  if. off ~: 1 do.
    throw '201 Problem in make - invalid text tags'
  end.
  bal=. > {: {: top
  top=. (<'') (<_1 _1) } top
  top=. (1;'') (<0 _1;0 1) } top
  
  select. tag
  case. ,'b' do.
    r=. r,(clr,fontbold fnt) make top
  case. ,'i' do.
    r=. r,(clr,fontitalic fnt) make top
  case. 'link' do.
    newurl val
    clk=. colorindex LCOLOR
    r=. r,(clk,fnt) make top
  case. 'style' do.
    throw '101 Tag not supported: <style>'
  case. '' do.
    bal=. val
  case. do.
    throw '101 Tag not supported: ',wraptag tag
  end.
  
  if. #bal do.
    r=. r,clr;fnt;bal
    bal=. ''
  end.
  
end.
r
)
ParaTags=: <;._2 (0 : 0)
b
i
link
style
)
j=. '<br/>';LF;'&lt;';'<';'&gt;';'>';'&nbsp';' '
Pararplc=: _2 [\ j
fixpara=: 3 : 0
txt=. y
txt=. delparaLF txt
txt=. deb txt
txt=. txt rplc Pararplc
txt=. ParaTags parseml txt
(Color,Font) make txt
)

coclass 'ppuburl'
create=: 3 : 0
coinsert locP=: COCREATOR
Data=: y
NAME=: 'Ul',":#Urls
Urls__locS=: Urls,coname''
UrlIds__locS=: UrlIds,<y
)
coclass 'ppuburl'
create=: 3 : 0
coinsert locP=: COCREATOR
Data=: y
NAME=: 'Ul',":#Urls
Urls__locS=: Urls,coname''
UrlIds__locS=: UrlIds,<y
)
url=: 3 : 0
s=. '/Type /Filespec'
s=. s,LF,'/FS /URL'
s=. s,LF,'/F (',Data,')'
dict s
)
coclass 'ppubxobject'
Shape=: ''
create=: 3 : 0
coinsert locP=: COCREATOR
NAME=: 'Im',":#XObjects
XObjects__locS=: XObjects,coname''
)
add=: 3 : 0
File=: filename y
Type=: tolower (1+File i: '.') }. File
if. Type -: 'jpeg' do. Type=: 'jpg' end.
if. -. (<Type) e. 'bmp';'jpg' do.
  throw '101 Image file not supported: ',FILE
end.
Shape=: readshape''
)
read=: 3 : 0
('read',Type)~File
)
readshape=: 3 : 0
dat=. read''
select. Type
case. 'bmp' do.
  $dat
case. 'jpg' do.
  readjpgshape dat
end.
)
xobject=: 3 : 0
('xobject',Type)~''
)
xobjectbmp=: 3 : 0
dat=. read''
'rws cls'=. Shape
dat=. toascii85 rgb2alf ,dat
s=. '/Type /XObject'
s=. s,LF,'/Subtype /Image'
s=. s,LF,'/Width ',":cls
s=. s,LF,'/Height ',":rws
s=. s,LF,'/ColorSpace /DeviceRGB'
s=. s,LF,'/BitsPerComponent 8'
s=. s,LF,'/Length ',":#dat
s=. s,LF,'/Filter /ASCII85Decode'
s=. dict s
s=. s,'stream',LF,dat,LF,'endstream',LF
)
xobjectjpg=: 3 : 0
dat=. read''
'rws cls'=. Shape
dat=. ,dat
s=. '/Type /XObject'
s=. s,LF,'/Subtype /Image'
s=. s,LF,'/Width ',":cls
s=. s,LF,'/Height ',":rws
s=. s,LF,'/ColorSpace /DeviceRGB'
s=. s,LF,'/BitsPerComponent 8'
s=. s,LF,'/Length ',":#dat
s=. s,LF,'/Filter /DCTDecode'
s=. dict s
s=. s,'stream',LF,dat,'endstream',LF
)
readjpg=: 3 : 0
dat=. 1!:1 boxxopen y
if. -. 255 216 255 224 -: a.i.4{.dat do.
  throw '101 Not recognized as a JPEG: ',>y
end.
dat
)
readjpgshape=: 3 : 0
ff=. 255{a.
sf=. a. {~ 192 + (i.16) -. 4 8 12
dat=. 4 }. y
while. 1 do.
  ndx=. dat i. ff
  if. ndx >: _10 + #dat do.
    throw '101 Could not read JPEG file correctly'
  end.
  sel=. (ndx+1) { dat
  if. sel=ff do. dat=. }. dat continue. end.
  if. sel e. sf do. break. end.
  len=. 256 #. a.i.(ndx+2 3) { dat
  dat=. (ndx+len+2) }. dat
end.
256 #. a.i. _2 [\ 5 6 7 8 { dat
)
coclass 'ppubheader'
NAME=: ''
Tag=: ''
create=: 3 : 0
coinsert locP=: COCREATOR
coinsert 'ppubtext'
ALIGN=: iLEFT
ALIGNV=: iTOP
)
coclass 'ppubheader'
NAME=: ''
Tag=: ''
create=: 3 : 0
coinsert locP=: COCREATOR
coinsert 'ppubtext'
ALIGN=: iLEFT
ALIGNV=: iTOP
)
add=: 3 : 0
'off tag prm val'=. checktag2 y
num=. ; ,&'.' each ": each Level
num=. (-1 < #Level) }. num
fontname=. 'FONT',toupper tag
FONT=: fontname~
Tag=: tag
if. tag -: 'h0' do.
  addh0 prm;val return.
end.
set prm
if. ALIGN=iJUST do. ALIGN=: iCENTER end.
fnt=. fontindex FONT
Height=: fontheight fnt
val=. deb ' ' (I.val=LF) } val
ndx=. 1 i.~ '<br/>' E. val
hdr=. num,'  ',deb ndx {. val
addcontents Level;NAME;hdr
if. 0=#NAME do. NAME=: hdr end.
if. ndx < #val do.
  r=. ,:0;fnt;hdr,LF
  fnt=. fontindex FONTP
  Data=: ,<r,0;fnt;deb (ndx+5)}.val
else.
  Data=: ,<,:0;fnt;hdr
end.
)
addh0=: 3 : 0
'prm val'=. y
ALIGN=: iCENTER
ALIGNV=: iCENTER
NAME=: 'Front Page'
set prm
if. ALIGN=iJUST do. ALIGN=: iCENTER end.
fnt=. fontindex FONTH0
val=. deb ' ' (I.val=LF) } val
val=. val rplc '<br/>';LF
val=. deb each <;._2 val,LF
hdr=. 0 pick val
val=. }. val
addcontents Level;NAME;hdr
res=. ,<,:0;fnt;hdr
if. #val do.
  fnt=. fontindex FONTP
  res=. res, ,: each 0 ;each fnt ;each val
end.
Data=: res
)
draw=: 3 : 0
if. (Dxywh -: Sxywh) +: Tag -: 'h0' do.
  setsxywhP Sxywh - 0 0 0,PARASPACE * Height
end.
drawpara 1
)
coclass 'ppubtoc'
Data=: ''
TOCALIGN=: 0
create=: 3 : 0
coinsert 'ppubtext'
coinsert locP=: COCREATOR
Font=: fontindex FONTC0
)
coclass 'ppubtoc'
Data=: ''
TOCALIGN=: 0
create=: 3 : 0
coinsert 'ppubtext'
coinsert locP=: COCREATOR
Font=: fontindex FONTC0
)
draw=: 3 : 0
res=. 0;''
if. isempty Contents do. res return. end.
if. 3 = {:$Contents do. res return. end.
pos=. {."1 Contents
msk=. (TOCLEVEL >: # &> pos) > 0 = {.&> pos
if. -. 1 e. msk do. res return. end.
dat=. ~. 0 2 3 {"1 msk # Contents
off=. <: _1 pick {. dat
fts=. fontindex"1 ". 'FONTC' ,"1 ":,.1 + i.TOCLEVEL
r=. ''
p=. i.0 3
for_d. dat do.
  'pos txt num'=. d
  lvl=. <: #pos
  if. (#p) *. lvl=0 do.
    r=. r,<remlastLF p
    p=. i.0 3
  end.
  txt=. ((4*lvl)$' '),txt,(4$' '),(":num-off),LF
  p=. p,0;(lvl{fts);txt
end.

if. #p do. r=. r,<remlastLF p end.
Data=: r
drawpara 1
)
drawpara=: 3 : 0
if. y do.
  Para=: fit each Data
end.
cls=. ; each {:"1 each Para
par=. LEADING * +/ &> cls
spc=. PARASPACE * {: &> cls
scn=. +/\par + 0,}:spc
mov=. +/par + spc
tot=. {:scn
rc=. Sh < tot
if. rc do.
  ndx=. (scn <: Sh) i. 0
  tot=. ndx { 0,scn
  dat=. ndx {. Para
  Para=: ndx }. Para
else.
  dat=. Para
end.
mx=. Sx
my=. Sy + Sh
Textc=: Textf=: _1
r=. ''
for_d. dat do.
  for_ln. >d do.
    'clr fnt bgn end bwd ewd hit'=. ln
    if. #bgn do.
      r=. r,drawtext ,:(mx,my);clr;fnt;bgn
    end.
    if. #end do.
      r=. r,drawtext ,:((mx+Sw-ewd),my);clr;fnt;end
    end.
    my=. my - prnd hit*LEADING
  end.
  my=. my - prnd hit*PARASPACE
end.
setsxywhP Sx,Sy,Sw,Sh-mov
rc;wraptext r
)
remlastLF=: 3 : 0
'c f txt'=. {:y
txt=. (-LF={:txt) }. txt
y=. (c;f;txt) _1 } y
)
fit=: 3 : 0
r=. i.0 7
for_p. y do.
  'clr fnt txt'=. p
  txt=. u2a txt
  txt=. (- LF = {: txt) }. txt
  if. TOCALIGN=2 do.
    ndx=. txt i: ' '
    bgn=. dtb ndx {. txt
    end=. }. ndx }. txt
    bwd=. fnt fontwidth bgn
    ewd=. 0
  else.
    bgn=. txt
    end=. ''
    bwd=. fnt fontwidth bgn
    ewd=. fnt fontwidth end
  end.
  hit=. fontheight fnt
  r=. r,clr;fnt;bgn;end;bwd;ewd;hit
end.
)
3 : 0''
if. IFJ6 do.
  script_z_ jpath '~system/main/compare.ijs'
  script_z_ jpath '~system/main/dir.ijs'
  script_z_ jpath '~system/packages/winapi/dirbrowse.ijs'
  script_z_ jpath '~system/main/dll.ijs'
  script_z_ jpath '~system/main/files.ijs'
  script_z_ jpath '~system/main/gl2.ijs'
  script_z_ jpath '~system/classes/view/jview.ijs'
  script_z_ jpath '~system/packages/print/print.ijs'
  script_z_ jpath '~system/main/regex.ijs'
  script_z_ jpath '~system/main/strings.ijs'
  script_z_ jpath '~system/packages/misc/task.ijs'
  script_z_ jpath '~system/main/text.ijs'
else.
  require 'gtkwd'
  require 'dir dll files gl2 print regex strings task text'
end.
''
)

coclass 'ppubman'
MAXRECENT=: 20
PUBSNAPS=: 5
PUBSNAPX=: ''
PUBCFG=: jpath '~config/pubmancfg.ijs'
PUBOLD=: ''
PUBDEFS=: ;:'OTHERFILES SCRIPTFILES STYLEFILES TEXTFILES'
pubdefs=: 3 : '". each PUBDEFS'
pubreset=: 3 : 0
PUBFILE=: PUBFILES=: PUBPATH=: PUBPID=: PUBRECFILES=: ''
(PUBDEFS)=: <''
)
EMPTY=: i. 0 0
3 : 0''
if. IFUNIX do.
  filecase=: [
else.
  filecase=: tolower
end.
0
)
bcfind=: #@[ (| - =) i. &: (filecase each)

addsep=: , '/' -. {:
cutLF=: <;._2 @ (, LF -. {:)
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
delfret=: }: @ addsep
drophead=: ] }.~ #@[ * [ -: &: filecase #@[ {. ]
dtb=: #~ [: +./\. ' '&~:
fix=: _1&".
hostcmd=: [: 2!:0 '(' , ,&' || true)'
index=: #@[ (| - =) i.
info=: wdinfo @ ('Publish Manager'&;)
infonopub=: info bind 'First select a Publish Manager file'
infonosel=: info bind 'No file selected'
infonospec=: info bind 'No file specified'
intersect=: e. # [
isboxed=: 0 < L.
isempty=: 0: e. $
dirname=: ] #~ [: *./\. '/' ~: ]
matchhead=: [ -: &: filecase #@[ {. ]
pathname=: 3 : '(b#y);(-.b=.+./\.y=PATHJSEP_j_)#y'
query=: wdquery 'Publish Manager'&;
subs=. 2 : 'x I. @(e.&y)@]} ]'
termLF=: , (0: < #) # LF -. _1&{.
termdelLF=: {.~ 1: i.~ [: *./\. =&LF
toblank=: ' ' subs '_'
tolist=: }. @ ; @: (LF&, each)
tounderscore=: '_' subs ' '
a=. ''''
quote=: (a&,@(,&a))@ (#~ >:@(=&a))
dquote=: '"'&, @ (,&'"')
addNB=: 3 : 0
if. 0=#y do. '' return. end.
y=. cutLF termLF y
b=. 0='NB.'&-: @ (3&{.) &> y
add=. b #each <'NB. '
tolist add ,each y
)
dpath=: 3 : 0
y=. '/' (I. y='\')} y
p=. (+./\. y = '/') # y
d=. 1!:0 y,('/' = {:y) # '*'
if. 0 = #d do. '' return. end.
d=. d #~ '-d' -:"1 [ 1 4 {"1 > 4 {"1 d
if. 0 = #d do. '' return. end.
f=. (<p) ,each {."1 d
f, ; dpath each f ,each <'/*'
)
fwritesnew=: 4 : 0
dat=. x
if. -. 0 e. $dat do.
  if. 1>:#$dat do.
    dat=. toHOST dat
    dat=. dat,(LF ~: {:dat)#CRLF
  else. dat=. dat,"1 CRLF
  end.
end.
dat fwritenew y
)
fwritenew=: 4 : 0
dat=. ,x
new=. -. dat -: fread y
if. new do. dat fwrite y end.
new
)
namerep=: 3 : 0
LF ,~ y,'=: ',nounrep1 ".y
)
nounrep=: 4 : 0
LF ,~ x,'=: ',nounrep1 y
)

nounrep1=: 3 : 0
dat=. y
if. 0=#dat do. '''''' return. end.
if. isboxed dat do.
  dat=. ; (": each dat) ,each LF
end.
select. 3!:0 dat
case. 2 do.
  if. LF e. dat do.
    dat=. dat, LF -. {:dat
    '0 : 0', LF, ; <;.2 dat,')'
  else.
    quote dat
  end.
case. do.
  ": dat
end.
)
shellcmd=: 3 : 0
if. IFUNIX do.
  'res err'=. unixshell y
  if. #err do.
    res=. res,((0<#res)#LF,LF),err
  end.
  res
else.
  spawn_jtask_ y
end.
)
sortfiles=: 3 : 0
files=. sort y
files /: (<PUBPATH) ~: (#PUBPATH) {.each files
)
unixshell=: 3 : 0
f=. jpath '~temp/shell.sh'
t=. jpath '~temp/shell.txt'
e=. jpath '~temp/shell.err'
('#!/bin/sh',LF,y,LF) fwrite f
'rwx------' 1!:7 <f
hostcmd '"',f,'" > "',t,'" 2> "',e,'"'
r=. (fread t);fread e
ferase f;t;e
r
)
unixshellx=: 3 : 0
'res err'=. unixshell y
if. #err do.
  info 'Shell command error: ',LF,LF,err
end.
res
)
snapfilecopy=: 3 : 0
'source dest'=. y
if. IFWIN do.
  0 pick 'kernel32 CopyFileW i *w *w i' cd (uucp source);(uucp dest);0
else.
  if. 0 = pathcreate fpath dest do. 0 return. end.
  if. _1 -: dat=. fread source do. 0 return. end.
  -. _1 -: dat fwrite dest
end.
)
CFGHDR=: ; < @ ('NB. '&,) ;.2 (0 : 0)
Publish configuration

defines:
PUBRECFILES        recent pubman files
)
pubaddrecent=: 3 : 0
recfiles=. ~. (<PUBFILE),PUBRECFILES
PUBRECFILES=: ({.~ MAXRECENT <. #) recfiles
pubcfgsave''
)
pubcfgread=: 3 : 0
PUBRECFILES=: ''
try. 0!:0 <PUBCFG catch. end.
PUBRECFILES=: cutLF jpathsep PUBRECFILES
EMPTY
)
pubcfgsave=: 3 : 0
PUBRECFILES=: fexists PUBRECFILES
recfiles=. 'PUBRECFILES' nounrep tolist PUBRECFILES
dat=. CFGHDR,LF,recfiles
dat fwritesnew PUBCFG
)
PUBEXT=: <;.1 '.jpb.ijs.sty.txt'
fexist=: 1:@(1!:4)@boxopen :: 0:
fexists=: #~ fexist&>
jpathsep=: '/' & (I.@(=&'\')@]})
pathfile=: 3 : '(b#y);(-.b=.+./\.y=''/'')#y'
fpath=: 0 pick pathfile
addext=: 4 : 0
if. 0 e. (#x),#y do. y return. end.
y, (-.x -: (-#x) {. y) # x
)

extjpb=: '.jpb' & addext
extnone=: 3 : 0
(- 4 * (<_4 {. y) e. PUBEXT) }. y
)
pubfullname=: 3 : 0
if. 0 = #y do. '' return. end.
d=. filecase jpathsep y
if. +:/ '/:' = 2 {. d do.
  if. '/' e. d do.
    PUBPID,d
  else.
    PUBPATH,d
  end.
end.
)
pubshortname=: 3 : 0
PUBPID drophead PUBPATH drophead extnone y
)
WNOTE=: 0 : 0
pc wnote owner;
xywh 2 3 55 11;cc z0 static;cn "Notes:";
xywh 0 16 250 200;cc noteedit editm ws_border ws_hscroll ws_vscroll rightmove bottommove;
xywh 207 2 38 12;cc cancel button leftmove rightmove;cn "Close";
pas 0 0;
rem form end;
)
wnote_run=: 3 : 0
if. wdisparent 'wnote' do.
  wd 'psel wnote;pactive' return.
end.
pos=. wd 'qformx'
wd WNOTE
wd 'set noteedit *',XNOTES
wd 'setfocus noteedit'
wdcenter pos
wd 'pshow'
)
wnoteclose=: 3 : 0
XNOTES=: termLF (#~ +./\.@(~:&LF)) noteedit
wd 'pclose'
wd 'psel ',HWNDP,';pactive'
)

wnote_cancel_button=: wnote_cancel=: wnote_close=: wnoteclose
deletefile=: 3 : 0

p=. PUBID
j=. '"Script Files (*.ijs)|*.ijs|Text Files (*.txt)|*.txt|'
j=. j,'All Files (*.*)|*.*" ofn_nochangedir'
f=. mbopen '"Remove File" "',p,'" "" ',j

if. ''-:f do. return. end.
if. 0=fexist f do. return. end.
if. 1=2 query 'OK to delete: ',f,'?' do. return. end.

file=. <f
1!:55 file
TEXTFILES=: TEXTFILES -. file
SCRIPTFILES=: SCRIPTFILES -. file
STYLEFILES=: STYLEFILES -. file
OTHERFILES=: OTHERFILES -. file
showfiles''
)
pubdir=: 3 : 0
jpathsep each 1 dir y
)
pubinit=: 3 : 0
pubreset''
p=. jpathsep filecase deb y
if. 0=#p do.
  info 'Empty argument given to pubman'
  0 return.
end.
pubcfgread''
if. '.jpb' -: _4 {. p do.
  pubopen p
else.
  pubopenpid p
end.
1
)
pubmakemaster=: 3 : 0
mas=. PUBPATH,'master.txt'
if. -. fexist mas do.
  '' fwrite mas
end.
)
pubmerge=: 4 : 0
f=. jpathsep each x,,y
if. #f do.
  fexists sortfiles ~.f
end.
)
pubnewbrowse=: 3 : 0
pubsave 0
path=. jpathsep addsep PUBPID
while. 1 do.
  j=. '"Publish Files(*.jpb)|*.jpb" ofn_nochangedir'
  f=. mbsave '"New Publish File" "',path,'" "" ',j
  if. 0=#f do. return. end.
  f=. extjpb jpathsep f
  if. -. '.jpb' -: _4 {.f do.
    info 'Publish filename extension should be .jpb' continue.
  end.
  'path file'=. pathfile f
  pid=. 1 pick pathfile }:path
  req=. jpathsep path,pid,'.jpb'
  f=. jpathsep f
  if. -. f -: req do.
    info 'Publish project file should be named: ',req,'. Using that name.'
    f=. req
  end.
  if. fexist f do.
    if.
      msg=. f,LF,'This file already exists.'
      msg=. msg,LF,LF,'Replace existing file?'
      0=2 1 query msg do. break.
    end.
  elseif. 1 do.
    '' fwrite f break.
  end.
end.
pubopen f
pubmakemaster''
pubformshow''
)
pubopenbrowse=: 3 : 0
pubsave 0
path=. jpathsep }:PUBPID
while. 1 do.
  j=. '"Publish Files(*.jpb)|*.jpb" ofn_filemustexist ofn_nochangedir'
  f=. mbopen '"Open Publish File" "',path,'" "" ',j
  if. 0=#f do. return. end.
  f=. extjpb f
  if. '.jpb' -: _4 {.f do. break. end.
  info 'Publish filename extension should be .jpb'
  path=. 0 pick pathfile jpathsep f
end.
pubopen f
pubformshow''
)

pubopen=: 3 : 0
file=. pubfullname y
if. -. '.jpb' -: _4 {. file do.
  info 'Not a pubman file: ',file
  0 return.
end.
if. -. fexist file do.
  info 'not found: ',file
  0 return.
end.
pubsetfile file
pubread''
snapshot''
1
)
pubopenpid=: 3 : 0
pubsetpid addsep jpathsep deb y
if. #PUBFILES do.
  pubopen 0 pick PUBFILES
else.
  PUBFILE=: PUBPATH=: ''
end.
)
pubread=: 3 : 0
(PUBDEFS)=: <''
try. 0!:0 <PUBFILE
catch. info 'Unable to load: ',y
end.
SCRIPTFILES=: sortfiles cutopen jpathsep SCRIPTFILES
STYLEFILES=: sortfiles cutopen jpathsep STYLEFILES
TEXTFILES=: sortfiles cutopen jpathsep TEXTFILES
OTHERFILES=: sortfiles cutopen jpathsep OTHERFILES
OTHERFILES=: sortfiles OTHERFILES -. SCRIPTFILES,STYLEFILES,TEXTFILES
PUBOLD=: pubdefs''
pubrefresh''
)
pubrefresh=: 3 : 0
p=. jpathsep addsep PUBPATH
TEXTFILES=: TEXTFILES pubmerge pubdir p,'*.txt'
STYLEFILES=: STYLEFILES pubmerge pubdir p,'*.sty'
SCRIPTFILES=: SCRIPTFILES pubmerge pubdir p,'*.ijs'
sel=. PUBFILE;TEXTFILES,STYLEFILES,SCRIPTFILES
bal=. (pubdir p,'*.*') -. sel
OTHERFILES=: (OTHERFILES -. sel) pubmerge bal
)
pubsave=: 3 : 0
if. (y=0) *. PUBOLD -: pubdefs'' do. return. end.
pn=. jpathsep extnone PUBFILE
hdr=. 'NB. publish manager file: ',pn,LF,LF
hdr=. hdr,'coclass ''ppubman''',LF
pub=. pubdir jpathsep PUBPATH,'*.*'
r=. ''
r=. r,<'SCRIPTFILES' nounrep SCRIPTFILES -. pub
r=. r,<'STYLEFILES' nounrep STYLEFILES -. pub
r=. r,<'TEXTFILES' nounrep TEXTFILES -. pub
r=. r,<'OTHERFILES' nounrep OTHERFILES -. pub
dat=. hdr, ; LF&, each r
dat fwritesnew PUBFILE
PUBOLD=: pubdefs''
EMPTY
)
pubsetfile=: 3 : 0
PUBFILE=: y
PUBPATH=: 0 pick pathfile PUBFILE
path=. PUBPID
if. (0=#path) >: path -: (#path){.PUBPATH do.
  path=. 0 pick pathfile }:PUBPATH
end.
pubsetpid path
pubaddrecent''
)
pubsetpid=: 3 : 0
PUBPID=: y
t=. jpathsep each filecase each dpath PUBPID
t=. t ,each '/' ,each (dirname each t) ,each <'.jpb'
PUBFILES=: fexists t
)
RECENT=: 0 : 0
pc precent nomin owner;pn "Recent Publish Files";
xywh 4 8 51 10;cc s0 static;cn "Publish Files:";
xywh 3 18 174 123;cc l0 listbox ws_vscroll rightmove bottommove;
xywh 95 5 40 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 136 5 40 12;cc ok button bs_defpushbutton leftmove rightmove;cn "OK";
pas 2 2;pcenter;
rem form end;
)
precent_run=: 3 : 0
if. 0 e. #PUBRECFILES do.
  info 'No recent pubman files' return.
end.
pubsave 0
rp=. pubshortname PUBRECFILES
pos=. wd 'qformx'
wd RECENT
wdcenter pos
wd 'set l0 *', tolist rp
wd 'setselect l0 0'
wd 'setfocus l0'
wd 'pshow'
)
precent_close=: 3 : 0
wd 'pclose'
wd 'psel ',HWNDP,';pactive'
)
precent_doit=: 3 : 0
wd 'pclose'
if. #l0 do.
  wd 'psel ',HWNDP
  pubopen l0
  pubaddrecent''
  pubformshow''
end.
wd 'psel ',HWNDP,';pactive'
)
precent_enter=: precent_ok_button=: precent_l0_button=: precent_doit
precent_cancel=: precent_cancel_button=: precent_close
plast_run=: 3 : 0
j=. PUBRECFILES -. < PUBFILE
if. 0 e. #j do.
  info 'No other recent pubman files' return.
end.
pubsave 0
pubopen >{.j
pubaddrecent''
pubformshow''
)
RX=: '^(load|require|script<|script_z_<|script <|script_z_) *(''(''''|[^''])*'')'

reqread=: 1!:1 :: (''"_)
reqscripts=: fromfoldername @ getlibfiles @ ; @: (cutopen@".&.>)
reqlibs=: getlibids @: req @: getlibfiles
reqlibs1=: 3 : 0
a=. y
b=. ''
while. -. '' -: r=. reqlibs a do.
  a=. r [ b=. r,b
end.
~.b,y
)
getliball=: 3 : 0
sort STDLIBS -.~ ~. {."1 PUBLIC
)
getlibfiles=: 3 : 0
f=. (0{"1 PUBLIC),y
t=. (1{"1 PUBLIC),y
t {~ f i. y
)
getlibids=: 3 : 0
s=. jpathsep each y
f=. (1{"1 PUBLIC),y
t=. (0{"1 PUBLIC),s
t {~ f i. y
)
nodepends=: 3 : 0
if. 0=#y do. '' return. end.
dat=. (LF,LF),y
hit=. RX rxmatches_jregex_ dat
if. 0=#hit do. y return. end.
ndx=. 0, {.@(1&{)"2 hit
dat=. ((i.#dat) e. ndx) <;.1 dat
dat=. 6 }. ; 'NB. '&, each dat
)
req=: 3 : 0
RXH=: rxcomp_jregex_ RX
files=. fromfoldername boxxopen y
done=. ''
found=. i.0 2
while. #files do.
  done=. done,f=. {.files
  r=. req1 f
  found=. found, r ,. f
  files=. ~. (}.files), r -. done
end.
rxfree_jregex_ RXH
reqsort found
)
req1=: 3 : 0
dat=. reqread < jpath > y
if. 0=#dat do. '' return. end.
hit=. RXH rxmatches_jregex_ LF,dat
if. 0=#hit do. '' return. end.
reqscripts (2{"2 hit) rxfrom_jregex_ LF,dat
)
reqsort=: 3 : 0
b=. {."1 y
e=. {:"1 y
r=. ''
while. #b do.
  n=. b -. e
  if. 0=#n do. n=. {.b end.
  r=. r,n
  msk=. -. b e. n
  e=. msk#e
  b=. msk#b
end.
r=. ~. r
s=. 1{"1 PUBLIC
t=. fromfoldername s
(s,r) {~ (t,r) i. r
)
snapdir=: 3 : 0
jpathsep PUBPATH,'/.pub'
)
snapshot=: 3 : 0
return.

today=. 's', 2 }. ": <. 100 #. 3 {.6!:0''
p=. snapdir''
if. 0 = #1!:0 p do.
  if. -. ss_makedir p do. return. end.
end.
p=. p,PATHJSEP_j_
d=. 1!:0 p,'*'
pfx=. p,today
if. 0=#d do. ss_make pfx,'001' return. end.
d=. \:~ {."1 d #~ 'd' = 4{"1 > 4{"1 d
last=. 0 pick d
iftoday=. today -: 7 {. last
if. y -: 1 do.
  if. (p,last) ss_match PUBPATH do.
    ss_info 'Last snapshot matches current pubman.' return.
  end.
  if. iftoday do.
    f=. pfx,_3 {. '00',": 1 + 0 ". _3 {. last
  else.
    f=. pfx,'001'
  end.
  ss_make f
  ss_info 'New snapshot: ',1 pick pathfile f
else.
  if. iftoday do. return. end.
  if. (p,last) ss_match PUBPATH do. return. end.
  ss_make pfx,'001'
end.
d=. (PUBSNAPS-1) }. d
for_s. d do.
  f=. p,(>s),PATHJSEP_j_
  1!:55 f&, each {."1 [ 1!:0 f,'*'
  1!:55 <f
end.
)
snapview=: 3 : 0
if. IFJ6 do.
  require '~system/extras/util/dirmatch.ijs'
  PJPROJ_jdirmatch_=: ''
  dmrun_jdirmatch_ 1 1
end.
)
ss_files=: 3 : 0
t=. 1!:0 y,'*'
if. 0=#t do. return. end.
att=. > 4{"1 t
msk=. ('h' = 1{"1 att) +: 'd' = 4{"1 att
t=. /:~ msk # t
if. #PUBSNAPX do.
  t #~ -. +./ PUBSNAPX (1: e. E.) &>/ {."1 t
end.
)
ss_info=: wdinfo @ ('Snapshot'&;)
ss_make=: 3 : 0
fm=. jpathsep PUBPATH,'/'
to=. jpathsep y,'/'
if. 0 -: 1!:5 :: 0: <to do.
  ss_info 'Unable to create snapshot directory.'
  0 return.
end.
f=. {."1 ss_files fm
fm=. (<fm) ,each f
to=. (<to) ,each f
res=. snapfilecopy"1 fm ,. to
if. 0 e. res do.
  txt=. 'Unable to copy:',LF,LF,tolist (res=0)#fm
  ss_info txt
end.
)
ss_makedir=: 3 : 0
if. 0 -: 1!:5 :: 0: <y do.
  ss_info 'Unable to create snapshot directory.'
  0 return.
end.
arw=. 'rw' 0 1 } 1!:7 <y
if. 0 -: arw 1!:7 :: 0: <y do.
  ss_info 'Unable to set read/write attributes for snapshot directory.'
  0 return.
end.
if. -.IFUNIX do.
  ph=. 'h' 1 } 1!:6 <y
  if. 0 -: ph 1!:6 :: 0: <y do.
    ss_info 'Unable to set hidden attribute for snapshot directory.'
  end.
end.
1
)
ss_match=: 4 : 0
x=. addsep x
y=. addsep y
a=. ss_files x
b=. ss_files y
ra=. #a
rb=. #b
if. 0 e. ra,rb do.
  ra = rb return.
end.
fa=. {."1 a
fb=. {."1 b
if. -. fa -: fb do. 0 return. end.
if. -. (2 {"1 a) -: (2 {"1 b) do. 0 return. end.
fx=. x&, each fa
fy=. y&, each fa
(<@(1!:1) fy) -: <@(1!:1) fx
)
BPREFIX=: 'tsjw'
BFILES=: ;: 'TEXTFILES STYLEFILES SCRIPTFILES OTHERFILES'
BEXTS=: '.txt';'.sty';'.ijs';''
BLABELS=: ;: 'Text Style Script All'

BTYPES=: <;._2 (0 : 0)
Text Files(*.txt)|*.txt
Style Files(*.sty)|*.sty
Script Files(*.ijs)|*.ijs
All Files(*.*)|*.*
)
tab_add_button=: 3 : 0
if. 0=#PUBFILE do. infonopub'' return. end.
p=. jpathsep }:PUBPATH
typ=. dquote TABNDX pick BTYPES
lab=. TABNDX pick BLABELS
ext=. TABNDX pick BEXTS
fls=. TABNDX pick BFILES

while. 1 do.
  j=. typ,' ofn_nochangedir'
  f=. mbsave '"New ',lab,' File" "',p,'" "" ',j
  if. ''-:f do. return. end.
  if. TABNDX<3 do.
    f=. ext addext f
    if. ext -: _4 {.f do. break. end.
    info lab,' filename extension should be ',ext
  end.
end.
f=. filecase f
path=. 0 pick pathfile jpathsep f

if. path -: PUBPATH do.
  if. fexist f do.
    info 'already in pubman: ',pubshortname f return.
  end.
  '' fwritesnew f
else.
  if. -. fexist f do.
    '' fwritesnew f
  end.
end.

(fls)=: sortfiles (fls~),<jpathsep f
tab_show''
)
tab_button=: 3 : 0
TABNDX=: y
tab_refresh''
)
tab_delete_button=: 3 : 0
if. 0= #files=. tab_selected '' do. return. end.
ff=. tolist pubshortname files
if. 1=2 query 'OK to delete:',LF,LF,ff do. return. end.
fls=. TABNDX pick BFILES
for_f. files do.
  f=. >f
  if. PUBPATH -: 0 pick pathfile jpathsep f do.
    ferase jpathsep f
  else.
    (fls)=: fls~ -. <jpathsep f
  end.
end.
tab_refresh''
)
tab_open=: 3 : 'tab_open1 tab_selected 0'
tab_openall=: 3 : 'tab_open1 ". TABNDX pick BFILES'
tab_open1=: 3 : 0
fls=. y
if. 0 = #fls do. return. end.
ext=. (fls i: &> '.') }. each fls
msk=. ext e. '.pdf';'.jpf';'.jpg';'.jpeg'
view msk # fls

ext=. (-.msk)#ext
fls=. (-.msk) # fls

msk=. ext e. PUBEXT
if. 0 e. msk do.
  info 'Cannot open: ',LF,LF,tolist (0=msk)#fls
end.
fls=. msk # fls
if. 0 = #fls do. return. end.
open_ppubwin_ jpathsep each fls
)
tab_refresh=: 3 : 0
pubrefresh''
tab_show''
)
tab_selected=: 3 : 0
if. 0=#filelist do. '' return. end.
nms=. <;._2 filelist
if. TABNDX<3 do.
  nms=. (TABNDX{BEXTS) addext each nms
end.
pubfullname each nms
)
tab_show=: 3 : 0
fls=. ". TABNDX pick BFILES
wd 'psel ',HWNDP
if. 0=#PUBFILE do.
  wd 'set filelist *'
else.
  wd 'set filelist *', jpathsep tolist pubshortname each fls
end.
)
tab_view=: 3 : 0
fls=. jpathsep each tab_selected ''
if. #fls do. view fls end.
)
view=: 3 : 0

ext=. (y i: &> '.') }. each y
dun=. (#y) $ 0
pdf=. getPDFreader_ppublish_''
msk=. ext = <'.pdf'
dun=. dun +. msk
for_t. msk#y do.
  if. IFJ6 do.
    cmd=. pdf,' "',(>t),'"'
    if. IFUNIX do.
      2!:1 cmd,' &'
    else.
      if. #pdf do.
        wd 'winexec *',cmd
      else.
        shell }.cmd
      end.
    end.
  else.
    viewpdf_j_ >t
  end.
end.
msk=. IFUNIX < ext e. '.jpg';'.jpeg'
dun=. dun +. msk
for_t. msk#y do.
  shell '"',(>t),'"'
end.
msk=. ext e. '.ijs';'.jpf';'.sty';'.txt'
dun=. dun +. msk

for_t. msk#y do.
  try.
    (>t) wdview 1!:1 t
  catch. end.
end.
if. 0 e. dun do.
  info 'Cannot view: ',LF,LF,tolist (0=dun)#y
end.
wd 'psel ',HWNDP,';pactive'

)
PUBFORM=: 0 : 0
pc pubform;pn "Publish Manager";
menupop "&File";
menu pnew "&New..." "" "" "";
menu popen "&Open..." "" "" "";
menusep;
menu plast "&Last" "Ctrl+L" "" "";
menu precent "&Recent..." "" "" "";
menusep;
menu save "&Save" "Ctrl+S" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Tools";
menu pubdir "Publish &Directory" "" "" "";
menusep;
menu viewlog "&View Publish Log..." "" "" "";
menupopz;
menupop "&Windows";
menu closewin "&Close Windows" "" "" "";
menupopz;
xywh 4 5 30 11;cc s0 static;cn "Report:";
xywh 33 4 104 300;cc pubmanfile combodrop ws_vscroll rightmove;
xywh 0 20 198 1;cc s2 staticbox ss_etchedhorz rightmove;
xywh 154 4 42 12;cc run button leftmove rightmove;cn "&Run";
xywh 5 28 33 11;cc btext radiobutton;cn "Text";
xywh 38 28 33 10;cc bstyle radiobutton group;cn "Style";
xywh 71 28 35 10;cc bscript radiobutton group;cn "Script";
xywh 107 28 33 10;cc bother radiobutton group;cn "Other";
xywh 2 43 148 162;cc filelist listbox ws_vscroll lbs_extendedsel rightmove bottommove;
xywh 154 51 42 12;cc open button leftmove rightmove;cn "&Open";
xywh 154 64 42 12;cc openall button leftmove rightmove;cn "O&pen All";
xywh 154 77 42 12;cc view button leftmove rightmove;cn "&View";
xywh 154 90 42 12;cc add button leftmove rightmove;cn "&Add";
xywh 154 103 42 12;cc delete button leftmove rightmove;cn "&Remove";
xywh 154 190 42 12;cc cancel button leftmove topmove rightmove bottommove;cn "Close";
pas 0 2;pcenter;
rem form end;
)
pubform_run=: 3 : 0
if. wdisparent 'pubform' do.
  if. -. pubclose'' do. return. end.
end.
TABNDX=: 0
wd PUBFORM
HWNDP=: wd 'qhwndp'
pubformshow''
wd 'setfocus run'
wpset_j_ 'pubform'
wd 'pshow;'
)
pubclose=: 3 : 0
saveall_ppubwin_''
closeall_ppubwin_''
pubsave 0
try.
  wd 'psel wnote;pclose'
catch. end.
try.
  wd 'psel ',HWNDP
  wpsave_j_ 'pubform'
  wd 'pclose'
catch. end.
HWNDP=: ''
1
)
pubform_pubmanfile_select=: 3 : 0
if. #pubmanfile_select do.
  f=. (".pubmanfile_select) pick PUBFILES
  if. f -: PUBFILE do. return. end.
  pubsave 0
  pubopen f
  tab_refresh''
end.
)
pubform_save_button=: 3 : 0
if. 0=#PUBFILE do. infonopub'' return. end.
pubsave 1
info 'Saved: ',PUBFILE
)
pubformshow=: 3 : 0
wd 'psel ',HWNDP
showpubman''
wd 'psel ',HWNDP,';pactive'
wd 'setfocus run'
tab_show''
)
pubform_viewlog_button=: 3 : 0
if. fexist LOG_ppublish_ do.
  fview LOG_ppublish_
else.
  info 'No Publish log file'
end.
)
showpubdir=: 3 : 'dirs PUBPATH'
showpubman=: 3 : 0
if. #PUBFILES do.
  len=. 1 + # &> dirname each PUBFILES
  nms=. (#PUBPID) }. each (-len) }.each PUBFILES
  wd 'set pubmanfile *', tolist nms
  wd 'setselect pubmanfile ',": PUBFILES bcfind <PUBFILE
  wd 'setenable pubmanfile 1'
else.
  wd 'set pubmanfile *'
  wd 'setenable pubmanfile 0'
end.
)
pubform_enter=: ]
pubform_cancel=: pubform_close=: pubclose
pubform_cancel_button=: pubclose
pubform_closewin_button=: closeall_ppubwin_
pubform_delete_button=: deletefile
pubform_exit_button=: pubform_close
pubform_run_button=: pubmanrun
pubform_plast_button=: plast_run
pubform_pnew_button=: pubnewbrowse
pubform_popen_button=: pubopenbrowse
pubform_precent_button=: precent_run
pubform_pubdir_button=: showpubdir
pubform_pubmanfile_button=: pubform_pubmanfile_select
pubform_sctrl_fkey=: pubform_save_button
pubform_btext_button=: tab_button bind 0
pubform_bstyle_button=: tab_button bind 1
pubform_bscript_button=: tab_button bind 2
pubform_bother_button=: tab_button bind 3

pubform_add_button=: tab_add_button
pubform_configure_button=: pubconfigure
pubform_filelist_button=: tab_open
pubform_open_button=: tab_open
pubform_openall_button=: tab_openall
pubform_delete_button=: tab_delete_button
pubform_view_button=: tab_view
pubmanrun=: 3 : 0
if. 0=#PUBFILE do. infonopub'' return. end.
saveall_ppubwin_''
mas=. jpathsep PUBPATH,'master.txt'
if. -. fexist mas do.
  info 'Master file not found: ',mas return.
end.
res=. publish_ppublish_ mas;1
if. #res do.
  info (1+res i. ' ') }. res
end.
)
pubman=: 3 : 0
if. -. pubinit y do. return. end.
pubform_run''
)
pubman_z_=: pubman_ppubman_
coclass 'ppubwin'
coinsert 'ppubman'

SIZE=: 0 0
create=: 3 : 0
FILE=: >y
TEXT=: freads FILE
IFSAVED=: 0
add FILE;coname''
win_run''
)
destroy=: 3 : 0
delete FILE
try.
  wd 'psel ',HWNDP
  wd 'pclose'
catch. end.
codestroy''
)
add=: 3 : 0
cocurrent 'ppubwin'
FILES=: FILES,0{y
LOCS=: LOCS,1{y
)
close=: 3 : 0
save 1
destroy''
)
closeall=: 3 : 0
refresh''
for_loc. LOCS do.
  close__loc 1
end.
)
delete=: 3 : 0
cocurrent 'ppubwin'
msk=. FILES ~: <y
FILES=: msk#FILES
LOCS=: msk#LOCS
refresh''
)
getsaveas=: 3 : 0
fn=. FILE
types=. '"Text (*.txt)|*.txt|Scripts (*.ijs)|*.ijs|Styles (*.sty)|*.sty|All Files (*.*)|*.*"'
types=. types,' ofn_nochangedir'
while. 1 do.
  'p f'=. pathname fn
  fn=. mbsave '"Save As" "',p,'" "',f,'" ',types
  if. 0=#fn do. return. end.
  if. -. '.' e. fn do. fn=. fn,'.txt' end.
  if. fn -: FILE do. return. end.
  if. 0=fexist fn do. return. end.
  j=. fn,LF,'This file already exists.',LF,LF
  msg=. j,'Replace existing file?'
  if. 0=2 query msg do. fn return. end.
end.

)
getsel=: 3 : 0
dat=. wd 'qd'
ndx=. ({."1 dat) i. <'e_select'
0 ". 1 pick ndx { dat
)
marksaved=: 3 : 0
wd 'psel ',HWNDP
wd 'setmodified e 0'
)
open=: 3 : 0
refresh''
for_f. boxxopen y do.
  if. f e. FILES do.
    ndx=. FILES i. f
    loc=. ndx{LOCS
    wd 'psel ',HWNDP__loc
    wd 'pactive'
  else.
    f conew 'ppubwin'
  end.
end.
)
read=: 3 : 0
wd 'psel ',HWNDP
dat=. wd 'qd'
ndx=. ({."1 dat) i. <,'e'
1 pick ndx { dat
)
refresh=: 3 : 0
cocurrent 'ppubwin'
if. _1=nc <'FILES' do.
  FILES=: LOCS=: ''
else.
  msk=. LOCS e. 18!:1[1
  LOCS=: msk#LOCS
  FILES=: msk#FILES
end.
)
replace=: 3 : 0
wd 'psel ',HWNDP
wd 'setreplace e *',utf8 y
)
save=: 3 : 0
sel=. {. y , 1
new=. read''
if. TEXT -: new do. 1 return. end.
if. (sel=0) +. (sel=1) *. IFSAVED=0 do.
  q=. 3 query 'Save changes to ',FILE,'?'
  if. q do.
    (1 2 i. q) { 0 2 return.
  end.
end.
new fwrites FILE
marksaved ''
TEXT=: new
IFSAVED=: 1
)
saveall=: 3 : 0
refresh''
for_loc. LOCS do.
  save__loc 1
end.
)
saveas=: 3 : 0
fn=. getsaveas''
if. #fn do.
  FILE=: fn
  new=. read''
  new fwrites FILE
  TEXT=: new
  IFSAVED=: 1
  wd 'pn *',1 pick pathname FILE
  tab_refresh_ppubman_''
  wd 'psel ',HWNDP
end.
)
setsel=: 3 : 0
wd 'psel ',HWNDP
wd 'setselect e ',": y
)
WIN=: 0 : 0
pc win;
menupop "&File";
menu save "Save" "Ctrl+S" "" "";
menu saveas "Save &As..." "" "" "";
menusep;
menu close "Close" "" "" "";
menupopz;
menupop "&Edit";
menu editundo "&Undo" "Ctrl+Z" "" "";
menu editredo "&Redo" "Ctrl+Y" "" "";
menusep;
menu editcut "Cu&t" "Ctrl+X" "" "";
menu editcopy "&Copy" "Ctrl+C" "" "";
menu editpaste "&Paste" "Ctrl+V" "" "";
menusep;
menu editselectall "Select &All" "Ctrl+A" "" "";
menupopz;
menupop "Tools";
menu selminus "&Remove ZZ." "Ctrl+Shift+B" "" "";
menu selplus "&Add ZZ." "Ctrl+Shift+N" "" "";
menu selplusline1 "&Add ZZ. --" "Ctrl+Shift+K" "" "";
menu selplusline2 "&Add ZZ. ==" "Ctrl+Shift+L" "" "";
menusep;
menu sellower "&Lower Case" "" "" "";
menu selupper "&Upper Case" "" "" "";
menu seltoggle "&Toggle Case" "" "" "";
menusep;
menu selsort "&Sort" "" "" "";
menusep;
menu selwrap "&Wrap" "" "" "";
menupopz;
xywh 0 0 300 300;cc e edit ws_hscroll ws_vscroll es_nohidesel rightmove bottommove;
pas 0 0;
rem form end;
)

WINT=: WIN rplc 'e edit ';'e editijs ';'ZZ.';'NB.'
win_run=: 3 : 0
wd WINT
HWNDP=: wd 'qhwndp'
wd 'pn *',1 pick pathname FILE
wd 'set e *',TEXT
wd 'setfont e ',FIXFONT
if. SIZE -: 0 0 do.
  SIZE_ppubwin_=: _2 {. 0 ". wd 'qformx'
else.
  wd 'pmovex ',":getcascade''
end.
wd 'pshow'
)
win_cancel=: destroy
win_close_button=: win_close=: close
win_e_button=: ]
win_save_button=: save bind 2
win_saveas_button=: saveas
win_editcopy_button=: 3 : 'wd ''setedit e c'''
win_editcut_button=: 3 : 'wd ''setedit e x'''
win_editpaste_button=: 3 : 'wd ''setedit e v'''
win_editredo_button=: 3 : 'wd ''setedit e y'''
win_editselectall_button=: 3 : 'wd ''setselect e'''
win_editundo_button=: 3 : 'wd ''setedit e z'''
win_sellower_button=: select_text bind 'lower'
win_selminus_button=: select_line bind 'minus'
win_selplus_button=: select_line bind 'plus'
win_selplusline1_button=: select_line bind 'plusline1'
win_selplusline2_button=: select_line bind 'plusline2'
win_selsave_button=: ]
win_selsaveas_button=: ]
win_selsort_button=: select_line bind 'sort'
win_seltoggle_button=: select_text bind 'toggle'
win_selupper_button=: select_text bind 'upper'
win_selwrap_button=: select_text bind 'wrap'

win_bctrlshift_fkey=: win_selminus_button
win_kctrlshift_fkey=: win_selplusline1_button
win_lctrlshift_fkey=: win_selplusline2_button
win_nctrlshift_fkey=: win_selplus_button
refresh''
3 : 0''
qm=. 0 ". wd 'qm'
if. IFWIN > IFJAVA do.
  DESK=: 14 15 { qm
  BLK=: +/ <: 9 10 { qm
else.
  DESK=: (2 {. qm) - 0 33
  BLK=: 26
end.
)
getcascade=: 3 : 0
lcs=. }:LOCS
if. 0 = #lcs do. 0 0,SIZE return. end.
top=. i.0 2
for_loc. lcs do.
  wd 'psel ',HWNDP__loc
  top=. top,2 {. 0 ". wd 'qformx'
end.
wd 'psel ',HWNDP
len=. 1 + 0 >. <. <./ (DESK - SIZE) % BLK
bgn=. (BLK * i.len) - -: BLK
end=. bgn + BLK
top=. top #~ *./"1 top < {: end
x=. {."1 top
y=. {:"1 top
x=. (i.<./) +/ (x >/ bgn) *. x </ end
y=. (i.<./) +/ (y >/ bgn) *. y </ end
SIZE ,~ BLK * x,y
)
select_line=: 3 : 0

txt=. read ''
'bgn end'=. oldsel=. getsel ''

if. 0 = #txt do.
  wdinfo 'Selection';'No text selected' return.
end.

sel=. bgn }. end {. txt
ndx=. LF i.~ |. bgn {. txt
bgn=. bgn - ndx
if. LF ~: {: sel do.
  txt=. txt, LF
  ndx=. 1 + LF i.~ end }. txt
  end=. end + ndx
end.

sel=. bgn }. end {. txt

csl=. <;.2 sel

select. y
case. 'minus' do.
  msk=. -. (8 {. each csl) e. 'NB. ----';'NB. ===='
  csl=. msk # csl
  msk4=. (<'NB. ') = 4 {. each csl
  msk3=. msk4 < (<'NB.') = 3 {. each csl
  new=. ; ((msk4 * 4) + msk3 * 3) }. each csl
  set=. bgn + 0, <: #new
case. 'plus' do.
  msk=. 1 < # &> csl
  hdr=. (3 + msk) {. each <'NB.'
  new=. ; hdr ,each csl
  set=. bgn + 0, <: #new
case. 'plusline1' do.
  cmt=. 'NB. ',(57#'-'),LF
  new=. ; cmt ; csl
  set=. oldsel + #cmt
case. 'plusline2' do.
  cmt=. 'NB. ',(57#'='),LF
  new=. ; cmt ; csl
  set=. oldsel + #cmt
case. 'sort' do.
  new=. ; /:~ csl
  set=. bgn + 0, <: #new
end.

if. -. new -: sel do.
  setsel bgn, end
  replace new
  setsel set <. <: #read''
end.

)
select_text=: 3 : 0

txt=. read ''
'bgn end'=. getsel ''

if. bgn = end do.
  wdinfo 'Selection';'No text selected' return.
end.

sel=. bgn }. end {. txt
select. y
case. 'lower' do.
  new=. tolower sel
case. 'toggle' do.
  lwr=. a. {~ (i.26) + a. i. 'a'
  upr=. a. {~ (i.26) + a. i. 'A'
  ndx=. (lwr,upr,a.) i. sel
  new=. ndx { upr,lwr,a.
case. 'upper' do.
  new=. toupper sel
case. 'wrap' do.
  new=. 61 foldtext sel
end.

if. -. new -: sel do.
  replace new
  setsel bgn + 0,#new
end.

)


cocurrent 'ppublish'
publishconfig''
cocurrent 'base'
