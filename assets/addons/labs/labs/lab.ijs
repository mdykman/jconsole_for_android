PATHSEP_j_=: '/'

coclass 'jlab'


cat=: ,&,.&.|:
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
dtb=: #~ [: +./\. ' '&~:
info=: wdinfo @ ('Labs'&;)
getfontsize=: 13 : '{.1{._1 -.~ _1 ". y'
pathname=: 3 : '(b#y);(-.b=.+./\.y=PATHSEP_j_)#y'
a=. ''''
quote=: (a&,@(,&a))@ (#~ >:@(=&a))
plurals=: ] , (1: ~: [) # 's'"_
round=: [ * [: <. 0.5"_ + %~
setlocale=: 18!:4 @ <
termLF=: , (0: < #) # LF"_ -. _1&{.    
termdelLF=: }.~ [: - 0: i.~ LF&= @ |.  
tolist=: }. @ ; @: (LF&, each)
wdifopen=: boxopen e. <;._2 @ (wd bind 'qp')
assert=: 3 : 0
'' assert y
:
if. -. 0 e. y do. return. end.
msg=. x
if. 0=#msg do.
  j=. 'There is a problem with the lab.',LF,LF
  msg=. j,'Try re-loading J and starting it again.'
end.
info msg
laberror=. 13!:8@1:
laberror''
)
pdef=: 3 : 0
if. 0 e. $y do. empty'' return. end.
names=. {."1 y
if. #names do. (names)=: {:"1 y end.
names
:
names=. {."1 y
nl=. ;: ::] x
pdef (names e. nl)#y
)
setfontsize=: 4 : 0
b=. ~: /\ y='"'
nam=. b#y
txt=. ;:(-.b)#y
ndx=. 1 i.~ ([: *./ e.&'0123456789.') &> txt
nam, ; ,&' ' &.> (<":x) ndx } txt
)
doquiet=: 3 : 0
setlocale 'base'
0!:100 y [ 4!:55<'y'
)
tdo=: 3 : 0
setlocale 'base'
0!:101 y [ 4!:55<'y'
)
tdo1=: 3 : 0
setlocale 'base'
0!:111 y [ 4!:55<'y'
)

runquiet=: doquiet f.
run=: tdo f.
run1=: tdo1 f.
wdmove=: 4 : 0
'px py'=. y
'sx sy'=. 2 {. 0 ". wd 'qm'
'x y w h'=. 0 ". wd 'psel ',x,';qformx'
if. px < 0 do. px=. sx - w + 1 + px end.
if. py < 0 do. py=. sy - h + 1 + py end.
wd 'pmovex ',": px,py,w,h
)
wraptext=: 3 : 0
if. LABWIDTH > #y do. y return. end.
if. LABWRAP do.
  (LABWIDTH foldtext _2}. y) , _2{.y
else.
  y
end.
)
f=. 3 : 'labnext_jlab_ :: ] '''''
plot_jctrl_fkey_jwplot_=: f f.
jvm_jctrl_fkey_jviewmat_=: f f.
graph_jctrl_fkey_jzgraph_=: f f.
labaddons=: 3 : 0
ADDLABS=: ''
p=. jpath '~addons/'
0!:0 :: ] <jpath p,'config/config.ijs'
if. #ADDLABS do.
  nms=. <;._1 &> ' ' ,each <;._2 jhostpath ADDLABS
  fls=. (<p) ,each {."1 nms
  msk=. fexist &> fls
  fls=. msk # fls
  nms=. msk # nms
  cat=. {:"1 nms
  tit=. labgettitle1 each fls
  ADDLABS=: cat,.tit,.fls,.<0
else.
  ADDLABS=: i.0 4
end.
)
labgetsubdir=: 3 : 0
t=. 1!:0 y,'*'
b=. 'd' = 4{ &> 4{"1 t
{."1 b # t
)
labdir=: 3 : 0
fl=. jpath '~config\labdir.ijs'
if. 0 = fexist fl do.
  fl=. LABDIRECTORY,'labdir.ijs'
end.
0!:0 <fl
n=. '_ '&charsub each {."1 LABDIR
d=. {:"1 LABDIR
LABDIR=: (~:d) # n,.d
)
labdir1=: 3 : 0
t=. 1!:0 y,'*'
d=. 'd' = 4{ &> 4{"1 t
t=. tolower each {."1 d#t
n=. ((toupper)@{. , }.) each t
t=. n ,. (y&,) each t
b=. 0 < # @ (1!:0) @ (,&'\*.ijt') &> {:"1 t
b=. b +. 0 < # @ (1!:0) @ (,&'\*.rtf') &> {:"1 t
b # t
)
labgetfiles=: 3 : 0
if. #y do.
  path=. y,PATHSEP_j_ -. {:y
  j=. labgetjt path
  if. 0=#j do.
    info 'No tutorials found in: ',":y
    labreset''
    return.
  end.
  dname=. 1 pick pathname }:path
  LABDIR=: 1 2$dname;path
else.
  labdir''
  j=. ; < @ ({. ,. labgettutor &> @ {:)"1 LABDIR
  j=. j,~ADDLABS
end.
j=. (~: 1 {"1 j) # j
LABS=: j sort > 1{"1 j
)
labgettutor=: labgetjt , labgetrtf
labgetjt=: 3 : 0
path=. y, PATHSEP_j_ -. _1{.y
files=. 1 dir jhostpath path,'*.ijt'

if. 0=#files do.
  t=. i.0 3
else.
  sf=. 1 dir jhostpath path,'*.ijf'
  if. #sf do.
    j=. _4&}. each sf
    k=. _4&}. each files
    s=. k e. j
  else.
    s=. (#files)#0
  end.
  t=. labgettitle1 each files
  t=. t,. files (,<)"0 [s
end.

if. #s=. labgetsubdir path do.
  t=. t, ; labgetjt each path&, each s
end.

)
labgettitle1=: 3 : 0
t=. toJ 1!:11 y;0 100
". (t i. LF) {. t
)
labgetrtf=: 3 : 0
i.0 3 return.

path=. y, PATHSEP_j_ -. _1{.y
files=. 1 dir path,'*.rtf'
if. 0=#files do.
  t=. i.0 3
else.
  sf=. 1 dir path,'*.ijf'
  if. #sf do.
    j=. _4&}. each sf
    k=. _4&}. each files
    s=. k e. j
  else.
    s=. (#files)#0
  end.
  ph=. rxcomp_jregex_ 'LABTITLE[ ]*=:'
  t=. ph deb@labrtftitle each files
  rxfree_jregex_ ph
  t=. (*@# &> t) # t,. files (,<)"0 [s
end.

if. #s=. labgetsubdir path do.
  t=. t, ; labgetrtf each path&, each s
end.

)
labrtftitle=: 4 : 0
size=. 1!:4 <y
dat=. fread y;0,size <. 5000
'ndx len'=. {. x rxmatch_jregex_ dat
if. ndx=_1 do.
  'ndx len'=. {. x rxmatch_jregex_ fread y
  if. ndx=_1 do.'' return. end.
end.
dat=. (ndx+len) }. dat
j=. '{}',CRLF
". ((<./ dat i. j) {. dat) -. j
)
ADVANCE=: 'To advance the lab, press Esc A in JHS or Ctrl-J in Gtk.'

ALL=: '(All)'
LABDIRECTORY=: jpath '~system\extras\labs\'
ADDONSDIRECTORY=: }: jpath '~addons\a'
CMARKER=: 'Lab Chapter'
RXCMARKER=: '\\par [\\[:alnum:]* ]*',CMARKER
SMARKER=: 'Lab Section'
RXSMARKER=: '\\par [\\[:alnum:]* ]*',SMARKER
RXPAREN=: '\\par [\\[:alnum:]* ]*)'

IFCOMMENTS=: 1        
IFSENTENCES=: 1       
LABFOCUS=: _1         
IFWINDOWS=: 1         

LABS=: ''
LABCAT=: ''
LABCATS=: ''
LABCATSEL=: 0
LABCTD=: ' (ctd)'
FONTSCALE=: 1

AUTOLAB=: 0
labreset=: 3 : 0
LABAUTHOR=: ''
LABCOMMENTS=: ''
LABERRORS=: 0
LABTITLE=: ''
LABWINPOS=: _1
LABOUTPUT=: 1
LABWIDTH=: 61
LABFILE=: ''

LINE=: 1{,":<' '

CHAPTERDATA=: ,a:
CHAPTERNDX=: 0
CHAPTERS=: ,a:

CODE=: ''
CODENDX=: 0
SECTIONDATA=: ,a:
NDX=: 0
SECTIONINDEX=: 0
SECTIONS=: ,a:

IFCHAPTERS=: 0
IFNEWSECTION=: 0
IFSOUND=: 0
LABFOCUS=: _1
LABWRAP=: 1
ENDOFLAB=: 0

empty''
)
output=: [: empty 1!:2 & 2
outputwin=: labwin_output
start=: 3 : 0
if. #LABS do. y labinit 1 pick LABNDX{LABS end.
empty''
)
lab=: 3 : 0
if. 1=L.y do.
  'file ndx'=. y
  ndx labinit file
elseif. 0 e. $y do.
  labselect''
elseif. 0 = {.y do.
  labrun }.y
elseif. y-:1 do.
  labjump''
elseif. y-:3 do.
  labopt_run''
elseif. 2=3!:0 y do.
  d=. 1 dir y
  if. 0 e. $y do.
    info 'not found: ',y
  elseif. d -: ,<y do.
    labinit y
  elseif. 1 do.
    labselect y
  end.
end.
empty''
)
labnext=: 3 : 0
if. #LABFILE do.
  lab 0
end.
)
labchapterline=: 3 : 0
if. IFCHAPTERS do.
  j=. ' Chapter ',(":1+CHAPTERNDX),' ',(CHAPTERNDX pick CHAPTERS),' '
  output LF,(2$LINE),j,(0>.LABWIDTH-2+#j)$LINE
end.
)
labchaptername=: 3 : 0
if. 1 < #CHAPTERS do.
  (":CHAPTERNDX+1),' ',(CHAPTERNDX pick CHAPTERS),' '
else. '' end.
)
labinit=: 3 : 0
0 labinit y
:
if. 0=labopen y do. return. end.
if. x=0 do.
  dat=. 'Lab: ',LABTITLE,LF
  dat=. dat, (*#LABAUTHOR) # 'Author: ',LABAUTHOR,LF
  dat=. (LABWIDTH#LINE),LF,dat,ADVANCE
  output dat
  labchapterline''
  labrun x
end.
)
labjump=: 3 : 0
if. 0=#LABFILE do. info 'no lab selected' return. end.

if. NDX=0 do.
  if. 0=#LABFILE do.
    info 'no lab selected' return.
  end.
  0 labinit LABPATH,LABFILE
end.
labjump_run''
)
labline=: 3 : 0
j=. ' ',labsectionname''
(2$LINE),j,' ',(0>.LABWIDTH-3+#j)$LINE
)
labopen=: 3 : 0
labreset''
try. dat=. 1!:1 boxopen y
catch.
  info 'not found: ',":>y
  0 return.
end.
LABFOCUS=: 0 >. LABFOCUS

'LABPATH LABFILE'=: pathname >y

IFCHAPTERS=: 1 e. CMARKER E. dat
dat=. toJ dat
dat=. dat,LF -. {:dat
dat=. <;.2 dat
dat=. ;dat #~ -. 'NB. =='&-: @ (6&{.) &> dat

if. IFCHAPTERS do.
  cut=. }:(LF,CMARKER) E. LF,dat
  0!:100 (cut i. 1){.dat
  dat=. cut <;.1 dat
  ind=. dat i.&> LF
  CHAPTERS=: (>:#CMARKER) }.each ind {.each dat
  CHAPTERDATA=: ind }. each dat
else.
  cut=. }:(LF,SMARKER) E. LF,dat
  0!:100 (cut i. 1){.dat
  CHAPTERS=: ,a:
  CHAPTERDATA=: <(cut i. 1)}.dat
end.

if. LABOUTPUT *. IFCOMMENTS do.
  output=: [: empty 1!:2 & 2
else.
  output=: ]
end.

labopenchapter 0
)
labopenchapter=: 3 : 0
CHAPTERNDX=: y
if. IFCHAPTERS do.
  WINTITLE=: LABTITLE,' - ',y pick CHAPTERS
else.
  WINTITLE=: LABTITLE
end.
dat=. y pick CHAPTERDATA
if. #dat do.
  cut=. }:(LF,SMARKER) E. LF,dat
  dat=. cut <;.1 dat
  ind=. dat i.&> LF
  top=. (>:#SMARKER) }.each ind {.each dat
  NDX=: 0
  SECTIONDATA=: ind }. each dat
  SECTIONINDEX=: I. 0< # &> top
  SECTIONS=: SECTIONINDEX { top
else.
  SECTIONDATA=: ,a:
  SECTIONINDEX=: 0
  SECTIONS=: ,a:
end.
NDX=: 0
CODENDX=: 0
CODE=: ''
1
)
labposition=: 3 : 0
j=. (":NDX+1),' of ',":#SECTIONDATA
if. IFCHAPTERS do.
  '(',(":CHAPTERNDX+1),') ',j
end.
)
labrun=: 3 : 0
if. 0=#LABFILE do. info 'no lab selected' return. end.

if. #y do.
  if. y e. i.#SECTIONDATA do.
    NDX=: {. y
    CODENDX=: 0
    CODE=: ''
  else.
    info 'Invalid jump section'
    return.
  end.
end.

if. NDX >: #SECTIONDATA do.
  if. CHAPTERNDX >: <: #CHAPTERS do.
    ENDOFLAB=: 1
    (LF,'End of lab') 1!:2 [ 2 return.
  else.
    labopenchapter CHAPTERNDX+1
    labchapterline''
  end.
end.

if. CODENDX < #CODE do. labruncode'' return. end.
dat=. NDX pick SECTIONDATA
labrun0 dat
)
labrun0=: 3 : 0
'txt dat'=. labsplit y

section=. labline''
txt=. LF, (0<#txt) # wraptext txt
output LF,section,txt

cmd=. (+./\.dat ~: LF)#dat

while. 1 do.
  if. 'PREPARE' -: 7{.cmd do.
    cmd=. }. <;.2 cmd,LF
    ndx=. 1 i.~ 'PREPARE'&-: @ (7&{.) &> cmd
    prep=. ;ndx{.cmd
    cmd=. ;(ndx+1)}.cmd
    runquiet prep
    continue.
  elseif. 'SCRIPT' -: 6{.cmd do.
    cmd=. }. <;.2 cmd,LF
    ndx=. 1 i.~ 'SCRIPT'&-: @ (6&{.) &> cmd
    SCRIPT=: ;ndx{.cmd
    cmd=. ;(ndx+1)}.cmd
    continue.
  end.
  break.
end.

CODE=: labsplitcode cmd
CODENDX=: 0

labruncode''
)
labruncode=: 3 : 0

if. 0=#CODE do.
  labadvance''
  labsetfocus''
  return.
end.
if. IFSENTENCES=0 do.
  labadvance''
  labsetfocus''
  return.
end.

'cmd snd'=. CODENDX pick CODE
CODENDX=: >:CODENDX
if. CODENDX < #CODE do.
  outtxt=. LF,(3#LINE),' more ',(7#LINE),LF
else.
  outtxt=. i.0 0
  labadvance''
end.

if. (1 e. cmd ~: LF) *. 2 = 3!:0 cmd do.
  if. LABERRORS do.
    run1 cmd
  else.
    run cmd
  end.
end.

output outtxt
labsetfocus''
)
labsetfocus=: 3 : 0
if. LABFOCUS do.
  smselout_jijs_''
  smfocus_jijs_''
end.
)
labadvance=: 3 : 0
NDX=: >:NDX
CODE=: ''
CODENDX=: 0
)
labsectionname=: 3 : 0
j=. '(',(labposition''),') ',;labsection''
)
labselect=: 3 : 0
labaddons''
labgetfiles y
j=. sort ~. {."1 LABS
if. 1=#j do.
  LABCATS=: LABCAT=: j
else.
  LABCATS=: ALL;j
  if. (0=#LABCAT) +. -. LABCAT e. LABCATS do.
    LABCAT=: <ALL
  end.
end.
labsel_run''
)
labwelcome=: 3 : 0
r=. LF,'Welcome to lab: ',LABTITLE
if. 0<#LABAUTHOR do.
  r=. r,LF,LF,'Author: ',LABAUTHOR
end.
r=. r,LF,LF,ADVANCE
)
labsection=: 3 : 0
r=. ({.SECTIONS),a:
if. 0 < NDX do.
  j=. (<:+/NDX >: SECTIONINDEX) pick SECTIONS
  k=. (-.NDX e. SECTIONINDEX)#LABCTD
  if. #j do. r=. j;k end.
end.
r
)
labsplit=: 3 : 0
ind=. 2+((LF,')') E. y) i. 1
}. each ind ({.;}.) y
)
labsplitcode=: 3 : 0
f=. 'SOUND'&-: @ (5&{.) &>
dat=. <;.2 termLF y
dat=. ;dat #~ -. f dat
,<dat;''
)

labreset ''
