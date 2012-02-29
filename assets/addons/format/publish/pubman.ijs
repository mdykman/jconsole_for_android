require 'gtkwd'

coclass 'ppubman'
'load'~'format/publish'
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
require '~system/extras/util/dirmatch.ijs'
PJPROJ_jdirmatch_=: ''
dmrun_jdirmatch_ 1 1
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

