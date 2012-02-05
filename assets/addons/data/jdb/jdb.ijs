require 'data/jmf'

coclass 'jdb'
create=: ]
destroy=: codestroy
BASE=: <'base'
BOXEMPTY=: <''
BOXTYPE=: 32 
CHARTYPE=: 2 131072 
EMPTY=: i. 0 0

is1integer=: ({. -: <.) :: 0:
isboolean=: *./ @ e.&0 1
isboxed=: 0 < L.
ischaracter=: 3!:0 e. CHARTYPE"_
isextended=: 3!:0 e. 64 128"_
isinteger=: (-: <.) :: 0:
isnumeric=: [: -. 3!:0 e. (CHARTYPE,BOXTYPE)"_
isscalar=: 0 = #@$
islocale=: e. 18!:1 @ 1:

dcreate=: (1!:5 :: 0:) @ (fboxname@:>)
derase=: (1!:55 :: 0:) @ (fboxname@:>)

charwid=: +/ @ (+./\.)"1 @ (' '&~:)
getlocale=: islocale f. # [
hostcmd=: [: 2!:0 '('"_ , ] , ' || true)'"_
index=: #@[ (| - =) i.
info=: wdinfo @ ('JDB'&;)
intersect=: e. # [
jdbpath=: '/'&(I.@(=&'\')@]})
pack=: [: (,. ".&.>) ;: ::]
partition=: 1: , [: -. }. -:"_1 }:
pdef=: 3 : '0 0$({."1 y)=: {:"1 y'
tablelookup=: #@[ ({. i. ,@}.) ,
tablemember=: #@[ ({. e. }.) ,
termSEP=: , (0 < #) # '/' -. {:
tindexof=: i.&>~@[ i.&|: i.&>
tnubsieve=: ~:@|:@:(i.&>)~
tocolumn=: ,. @: > each
tomatrix=: (_2 {. 1 1,$) ($,) ]
towords=: ;:^:(_1 * 1 = L.)
transclosure=: (+. +./ .*.~)^:_

strjoin=: ":&.>@] ;@}:@,@,. boxopen@[
strsplit=: #@[ }.each [ (E. <;.1 ]) ,

throw=: 13!:8&101
rethrow=: throw @ (13!:12@(''"_) , ])
throwmsg=: }. @ ({.~i.&LF) @ (13!:12)
debugq=: 13!:17
debugss=: 13!:3
debugstack=: 13!:13
boxtolower=: 13 : '($y) $ < ;._2 tolower ; y ,each {:a.'
boxsequal=: = & (boxtolower@boxxopen)
boxsindex=: i.!.0 & (boxtolower@boxxopen)
boxsmember=: e.!.0 & (boxtolower@boxxopen)
boxsminus=: -.@boxsmember # [
boxsintersect=: boxsmember # [
amendtable=: 1 : 0
:
rep=. x
dat=. y
if. ischaracter dat do.
  cls=. {: $ dat
  len=. {: $ rep
  select. * cls - len
  case. _1 do.
    dat=. len {."1 y
  case. 1 do.
    rep=. cls {."1 rep
  end.
end.
rep m } dat
)
commasep=: 3 : 0
}. ; (',' , deb@":@;) each y
)
cutcommas=: deb each @ (a: -.~ <;._1) @ (','&,)
cutnames=: (a: -.~ e.&', ' <;._1 ]) @ (' '&,)
define_index=: 3 : 0
y=. cutopen y
(y)=: i. #y
)
default=: 4 : 0
if. _1 = 4!:0 <x do. (x)=: y end.
EMPTY
)
delquotes=: 3 : 0
if. '''' = {. y do. ". y else. y end.
)
delparens=: 3 : 0
if. '(' = {. y do. }. y {.~ y i: ')' else. y end.
)
destroyloc=: 3 : 0
for_loc. getlocale y do.
  destroy__loc''
end.
)
fixcols=: 4 : 0
ndx=. ,x
dat=. ' ' ,each <;._2 y
dat=. <;._1 each dat
dat=. dat -.each <a:
dat=. <"1 |: > dat
(0&".&> each ndx{ dat) ndx} dat
)
fixnums=: 3 : 0
if. -. ischaracter y do. y return. end.
t=. ' ' (I. y=',')} y
t=. ('('={.t) }. t
t=. (-')'={:t) }. t
__ ". t
)

fixnum1=: {. @ fixnums f.
isdirectory=: 3 : 0
d=. 1!:0 y
if. 1 ~: #d do. 0 return. end.
'd' = 4 { 4 pick ,d
)
flrename=: 4 : 0
if. x -: y do. return. end.
if. IFUNIX do.
  hostcmd 'mv "',y,'" "',x,'"'
else.
  'kernel32 MoveFileW i *w *w' 15!:0 (uucp y);(uucp x)
end.
)

direrase=: 3 : 0
if. 0=#y do. return. end.
if. 0=#1!:0 y do. return. end.
if. 0=#d=. dirxtree y do. return. end.
d=. d \: # &> d
m=. derase "0 d
if. 0 e. m do.
  throw '101 Unable to delete: ',towords (-.m)#d
end.
EMPTY
)
dirpaths=: 3 : 0
if. 0=#y do. '' return. end.
if. 0=#1!:0 y do. '' return. end.
r=. <y
dir=. <y,'/'
sub=. '-d' -:"1 (1 4&{"1) @ > @ (4&{"1)
while. #dir do.
  fpath=. (>{.dir) &,
  dir=. }.dir
  dat=. 1!:0 fpath '*'
  msk=. sub dat
  dat=. fpath each {."1 dat
  r=. r, dat
  dat=. msk # dat
  if. #dat do.
    dir=. (dat ,each '/'),dir
  end.
end.
r \: # &> r
)
dirsubdirs=: 3 : 0
r=. 1!:0 (termSEP y),'*'
if. 0=#r do. '' return. end.
{."1 r #~ '-d' -:("1) 1 4{"1 > 4{"1 r
)
dirxtree=: 3 : 0
y=. jdbpath y
p=. (+./\. y = '/') # y
d=. 1!:0 y,('/' = {:y) # '*'
if. 0 = #d do. '' return. end.
a=. > 4 {"1 d
m=. 'd' = 4 {"1 a
f=. (<p) ,each {."1 d
if. 1 e. m do.
  f, ; dirxtree each (m#f) ,each <'/','*'
end.
)
coclass 'jdb'
'Folders' default i.0 2
gettranmask=: 3 : 0
del=. (y >: {."1 deleted) # {:"1 deleted
msk=. (c1 <: y) *. -. autoid e. del
nub=. ~:&.|. msk#autoid
msk expand nub
)
foldername=: 3 : 0
if. -. isboxed y do. ,y return. end.
ndx=. ({:"1 Folders) i. y
if. ndx=#Folders do.
  throw '101 Not a folder locale: ',>y
end.
>{.ndx{Folders
)
reset=: 3 : 0
if. 0 = nc <'Folders' do.
  Close '*'
else.
  Folders=: i.0 2
end.
)
resetall=: 3 : 0
reset''
unmapall_jmf_''
)
unmappath=: 3 : 0
p=. y,'/'
msk=. (<p) = (#p) {.each 1 {"1 mappings_jmf_
unmap_jmf_ &> msk # {."1 mappings_jmf_
)
Close=: 3 : 0
dbf=. foldername y
if. dbf -: ,'*' do.
  destroyloc {:"1 Folders
  Folders=: i.0 2
else.
  ndx=. ({."1 Folders) i. <dbf
  if. ndx=#Folders do.
    throw '101 Folder not found: ',dbf
  end.
  destroyloc {:ndx{Folders
  Folders=: (<<<ndx) { Folders
end.
EMPTY
)
Open=: 3 : 0
dbf=. ,y
if. -. isdirectory dbf do.
  msg=. (0<#y) { 'Directory not given';'Not a directory: ',dbf
  throw msg
end.
ndx=. ({."1 Folders) i. <dbf
if. ndx < #Folders do.
  {: ndx { Folders
else.
  loc=. dbf conew 'jdbfolder'
  Folders=: Folders,dbf;loc
  loc
end.
)
coclass 'jdbdatabase'
coinsert 'jdb'
SAVENAMES=: <;._2 (0 : 0)
Tables
Columns
ColTab
)
create=: 3 : 0
locDB=: coname''
Database=: termSEP y
DBDir=: Database,'dir'
DBTrans=: Database,'trans'
DBSort=: 0
if. fexist DBDir do.
  opentables''
else.
  opennotables''
end.
)
destroy=: 3 : 0
closetables''
unmap_jmf_ ::] DBDir
codestroy''
)
addcolumns=: 3 : 0
'cls tab'=. y
Columns=: Columns,cls
ColTab=: ColTab,tab
DBSort=: DBSort >: cls -: ;:'autoid tranid'
makeglobals''
)
closetables=: 3 : 0
destroyloc Locales
Locales=: (#Tables) $ BOXEMPTY
)
definereqs=: 3 : 0
for_loc. Locales do.
  definereq__loc ''
end.
)
definetables=: 3 : 0
for_loc. Locales do.
  definetable__loc loc_index
end.
definereqs''
)
opennotables=: 3 : 0
Columns=: TabColnames=: Locales=: Tables=: ''
TableTrans=: ''
ColTab=: i.0 5
Trans=: 0
dbwritedir''
dbwritetrans''
)
opentables=: 3 : 0
dbreaddir''
dbreadtrans''
Locales=: ''
for_i. i.#Tables do.
  Locales=: Locales, i conew 'jdbtable'
end.
definereqs''
)
refresh=: 3 : 0
dbwritedir''
dbwritetrans''
definetables''
)
tableloc=: 3 : 0
try.
  Locales {~ Tables i. <,>y
catch.
  throw '101 Table not found: ',>y
end.
)
tablename=: 3 : 0
if. -. isboxed y do. ,y return. end.
ndx=. ({:"1 Tables) i. y
if. ndx=#Tables do.
  throw '101 Not a table locale: ',>y
end.
>{.ndx{Tables
)
tablendx=: 3 : 0
if. isnumeric y do.
  y
else.
  Tables i. boxxopen y
end.
)
validatefkeys=: 3 : 0
ndx=. 2 {. |: ColTab
ndx=. ndx #~ -. _1 e."1 ndx
if. 0 = #ndx do. return. end.
m=. 1 (<"1 ndx)} (,~#Tables)$0
b=. (<0 1) |: transclosure m
if. 1 e. b do.
  msg=. '101 Circular reference in foreign keys.',LF
  msg=. msg, towords b#Tables
  throw msg
end.
)
ColHdr=: ;: 'table column type unique parent parentkey'
getcols=: 3 : 0
if. (,'*') -: ,y do.
  ind=. (i.#ColTab) -. ,(0 1 +/ [i.~.) {."1 ColTab
  ct=. ind { ColTab
else.
  ndx=. Tables i. <,y
  if. ndx=#Tables do.
    throw '101 Table not found: ',y
  end.
  ind=. 2 }. I.ndx={."1 ColTab
  ct=. ind { ColTab
end.
't d e j u'=. |: ct
tab=. t{Tables
col=. ind{Columns
typ=. j{DATATYPES
uni=. u
pat=. d{Tables,<''
ndx=. I. d > _1
ref=. (ndx{d) { TabKeys
ind=. I. 0 = # &> ref
ref=. (<&> ({."1 ColTab) i. ind{ndx{d) ind } ref 
ref=. commasep each ref {each <Columns
key=. ref ndx} (#tab)$<''
ColHdr,.tab;col;typ;uni;pat;<key
)
j=. ' '&cutopen ;._2 (0 : 0)
0  autoid       32   64   0       1
1  boolean      8    8    0       1
2  int          32   64   0       2
3  float        64   64   0       2.1
4  byte         8    8    {.a.    'a'
5  char         8    8    ,:0$a.  'abc'
6  varchar      32   64   <''     <'abc'
7  binary       32   64   <''     <'abc'
)
DATATYPEX=: 0 ". &> 0 {"1 j
DATATYPES=: 1 {"1 j
DATATYPESU=: toupper each DATATYPES
DATASIZES=: 8 %~ 0 ". &> (2+IF64) {"1 j
DATADEFS=: ". each 4 {"1 j
('i',each DATATYPESU)=: i.#DATATYPES
iVARS=: iVARCHAR,iBINARY
('s',each DATATYPESU)=: DATASIZES
dbreaddir=: 3 : 0
pdef 3!:2 fread DBDir
makeglobals''
)
dbsortdir=: 3 : 0
ct=. 2 {."1 ColTab
ct=. ct #~ -. _1 e."1 ct
bal=. i.#Tables
res=. bal -. {."1 ct
bal=. bal -. res
whilst. #ct do.
  res=. res, bal -. {."1 ct
  bal=. bal -. res
  ct=. ct #~ -. ({:"1 ct) e. res
end.
res=. res,bal
inx=. (i.#Tables),_1
ct=. (inx {~ res i. 2 {."1 ColTab),.2 }."1 ColTab
ndx=. /: {."1 ct
if. ColTab -: ndx{ct do. return. end.
ColTab=: ndx{ct
Columns=: ndx{Columns
Tables=: res{Tables
Locales=: res{Locales
makeglobals''
definetables''
)
dbwritedir=: 3 : 0
if. DBSort do.
  dbsortdir__locDB''
  DBSort__locDB=: 0
end.
(3!:1 pack SAVENAMES) fwrite DBDir
)
dbreadtrans=: 3 : 0
Trans=: 0 ". 1!:1 <DBTrans
)
dbwritetrans=: 3 : 0
Trans=: Trans + 1
(":Trans) 1!:2 <DBTrans
)
makeglobals=: 3 : 0

if. 0 = #Columns do.
  ColDups=: ColHiddens=: ColKeys=: ColRefs=: ''
  TabColnames=: TabCols=: TabKeys=: ''
  return.
end.

ColDups=: ~. (#~ 0 = ~:) Columns

cls=. #ColTab
key=. _1 < 1{"1 ColTab
ColKeys=: I. 4 {"1 ColTab
TabColnames=: (({."1 ColTab){Tables) ,each '.' ,each Columns
msk=. partition {."1 ColTab
TabCols=: msk <;.1 i.cls
TabKeys=: TabCols intersect each <ColKeys
ColHiddens=: ; 2 {.&> TabCols
ref=. I. key
ColRefs=: ref #~ 0 < # &> (ref{ 1{"1 ColTab) { TabKeys
)
Alter=: 3 : 0
locs=. ''
for_d. y do.
  'cmd tab val'=. >d
  loc=. tableloc tab
  locs=. locs,loc
  (cmd,'__loc')~val
end.
for_d. ~.locs do.
  commit__d''
end.
dbwritetrans''
)
Create=: 3 : 0
dat=. boxopen ,y
if. 3 < #dat do.
  throw (":#dat),' arguments given to Create, max is 3'
end.
tab=. <,>{.dat
dat=. 2 {. }.dat,2$a:
if. tab e. {."1 Tables do.
  throw '101 Table already exists: ',>tab
end.
Tables=: Tables,tab
loc=. dat conew 'jdbtable'
Locales=: Locales,loc
dbwritedir''
dbwritetrans''
definereqs''
loc
)
Delete=: 3 : 0
'tab val'=. y
loc=. tableloc tab
Delete__loc val
)
DeleteCols=: 3 : 0
'tab val'=. y
loc=. tableloc tab
ndx=. DeleteCols__loc val
if. 0=#ndx do. return. end.
ndx=. <<<ndx
Columns=: ndx { Columns
ColTab=: ndx { ColTab
dbwritedir''
dbwritetrans''
closetables''
opentables''
)
Drop=: 3 : 0
tab=. tablename y
ndx=. Tables i. <tab
msk=. ndx~:{."1 ColTab
if. ndx e. msk # 1{"1 ColTab do.
  throw 'Cannot drop table referenced from another table: ',tab
end.
closetables''
Columns=: msk#Columns
ColTab=: msk#ColTab
ColTab=: ((]`<:)@.(ndx&<)"0 ]0 1&{"1 ColTab),"1 }.^:2"1 ColTab 
Tables=: (<<<ndx){Tables
direrase Database,tab
dbwritedir''
dbwritetrans''
opentables''
EMPTY
)
GetTable=: 3 : 0
if. L.y do.
  nms=. ,each y
else.
  nms=. cutnames y
end.
ndx=. Tables i. nms
if. 1 e. ndx=#Tables do.
  throw '101 Not found: ',towords (ndx=#Tables)#nms
end.
loc=. ndx{Locales
if. 1 = #ndx do.
  {.loc
else.
  <each loc
end.
)
Insert=: 3 : 0
'tab val'=. y
loc=. tableloc tab
Insert__loc val
)
InsertCols=: 3 : 0
'tab val'=. y
loc=. tableloc tab
InsertCols__loc val
)
Read=: 3 : 0
sel=. sel_parse y
loc=. tableloc {.sel
read__loc }.sel
)
Reads=: 3 : 0
dat=. Read y
({."1 dat),:tocolumn {:"1 dat
)
Readr=: 3 : 0
'tab val'=. y
loc=. tableloc tab
readr__loc val
)
ReadCols=: getcols
ShowCols=: 3 : 0
dat=. getcols y
({."1 dat),:tocolumn {:"1 dat
)
Update=: 3 : 0
'tab val'=. y
loc=. tableloc tab
Update__loc val
)
Updatebyautoids=: 3 : 0
'tab val'=. y
loc=. tableloc tab
Updatebyautoids__loc val
)
sel_split=: <"1 @ |: @: ((_2 {. strsplit)&>)
sel_delblank=: -.&' ' L:0
sel_parse=: 3 : 0
t=. y -. CR
t=. ' ',deb ' ' (I.y=LF)} t
't order'=. 2{.' order by ' strsplit t
't where'=. 2{.' where ' strsplit t
't from'=. 2{.' from ' strsplit t
'sel by'=. 2{.' by ' strsplit t
if. #by do.
  by=. sel_delblank ':' sel_split ',' strsplit by
else.
  by=. '';''
end.
if. #sel do.
  'ra re'=. ':' sel_split ',' strsplit sel
  sel=. sel_delblank ra;' ' sel_split re
else.
  sel=. '';'';''
end.
from;sel;by;where;order
)
showit=: 3 : 0
pack 'Database Tables Columns Locales ColTab Trans'
)
coclass 'jdbfolder'
coinsert 'jdb'
Databases=: i. 0 2
Folder=: ''
create=: 3 : 0
locDBF=: coname''
Folder=: termSEP jdbpath y
Databases=: (dirsubdirs Folder),.BOXEMPTY
)
destroy=: 3 : 0
Close '*'
codestroy''
)
databasename=: 3 : 0
if. -. isboxed y do. ,y return. end.
ndx=. ({:"1 Databases) i. y
if. ndx=#Databases do.
  throw '101 Not a database locale: ',>y
end.
>{.ndx{Databases
)
Close=: 3 : 0
db=. databasename y
if. db -: ,'*' do.
  destroyloc {:"1 Databases
  Databases=: BOXEMPTY 1 }"1 Databases
else.
  ndx=. ({."1 Databases) i. <db
  if. ndx=#Databases do.
    throw '101 Database not found: ',db
  end.
  destroyloc {:ndx{Databases
  Databases=: BOXEMPTY (<ndx;1) } Databases
end.
EMPTY
)
Create=: 3 : 0
db=. ,y
if. (<db) e. {."1 Databases do.
  throw '101 Database already exists: ',db
end.
if. -. dcreate Folder,db do.
  throw '101 Unable to create: ',db
end.
loc=. (Folder,db) conew 'jdbdatabase'
Databases=: Databases,db;loc
loc
)
Drop=: 3 : 0
db=. databasename y
ndx=. ({."1 Databases) i. <,y
if. ndx=#Databases do. EMPTY return. end.
destroyloc 1{ndx{Databases
path=. Folder,db
unmappath path
direrase path
Databases=: (<<<ndx) { Databases
EMPTY
)
Open=: 3 : 0
db=. ,y
ndx=. ({."1 Databases) i. <db
if. ndx=#Databases do.
  throw '101 Database not found: ',db
end.
loc=. (<ndx;1) { Databases
if. #getlocale loc do. return. end.
loc=. (Folder,y) conew 'jdbdatabase'
Databases=: loc (<ndx;1) } Databases
loc
)
coclass 'jdbtable'
create=: 3 : 0
coinsert COCREATOR
Tloc=: '_',(>coname''),'_'
if. isboxed y do.
  createtable y
else.
  opentable y
end.
)
destroy=: 3 : 0
unmapcols''
codestroy''
)
charmatchwid=: 3 : 0
'ndx wid dat'=. y
if. 1 e. wid < charwid dat do.
  throw '101 Reference not found for column: ',ndx pick Tcolnms
end.
wid {."1 dat
)
definetable=: 3 : 0
Tndx=: {. y,Tndx
Tcolndx=: Tndx pick TabCols
'Tcolfrx Tcolfrm Tcoltyp Tcolkey'=: }. |: Tcolndx{ColTab
Tcolmap=: ('autoid';'tranid'),2 }. 'p<c>' 8!:0 i.#Tcolndx
Tcolnms=: Tcolndx{Columns
definetinsert''
)
definetinsert=: 3 : 0
j=. (":each i.#Tcolmap) ,each <'{Tinsert',LF
j=. ((,'=:',',>',~]) each Tcolmap) ,each j
j=. j,<'active=:active,(#>0{Tinsert)$1',LF
j=. '0' ,~ ;j
tinsert=: 3 : j
EMPTY
)
getvindex=: 3 : '(Tcolinx e. I. Tcolkey) # Tcolndx'
unmapcols=: 3 : 0
unmap_jmf_ &> (Tcolmap,Thidmap) ,each <Tloc
)
validate=: 3 : 0
assert. 1 = # ~. (#@".) &> 'active';Tcolmap
)
Padrws=: 1e3     
Padmin=: 1e3     
Padvar=: 1e4     

Thidmap=: ;: 'active deleted state'

Tloc=: ''        
Tname=: ''       
Tndx=: ''        
Tpath=: ''       
Vreq=: ''        
Vcls=: ''        
Vtcs=: ''        
Tcolndx=: ''     
Tcolmap=: ''     
Tcolfrx=: ''     
Tcolfrm=: ''     
Tcolnms=: ''     
Tcoltyp=: ''     
Tcolkey=: ''     
Tdelete=: ''     
Tinsert=: ''     
deletecols=: 3 : 0
cls=. ~. cutnames y
if. 0 = #cls do. return. end.
if. 0 e. cls e. Tcolnms do.
  throw '101 Columns not in table ',Tname,': ',towords cls -. Tcolnms
end.
if. 0 = #Tcolnms -. cls do.
  throw '101 Cannot delete all columns in table ',Tname
end.
ind=. Tcolnms i. cls
ndx=. ind { Tcolndx
if. 1 = +/Tcolkey do.
  key=. Tcolkey i. 1
  if. key e. ind do.
    kdx=. key{ndx
    if. kdx e. ; (<<<kdx){ColRefs do.
      throw '101 Cannot delete key column referenced elsewhere: ',key pick Tcolnms
    end.
  end.
elseif. 1 e. (I.Tcolkey) e. ind do.
  if. -. isunique (I.Tcolkey) -. ind do.
    nms=. towords (ind intersect I.Tcolkey) { Tcolnms
    throw '101 Cannot delete key column since remaining key columns are not unique: ',nms
  end.
end.

unmapcols''

fls=. Tpath&, each Tcolmap
ferase ind{fls
fm=. (<<<ind){fls
to=. (#fm){.fls
msk=. fm ~: to
for_i. I.msk do.
  (>i{to) flrename >i{fm
end.

ndx
)
insertcols=: 3 : 0
def=. toJ y
ndx=. def i. ';'

if. ndx < #def do.
  if. 1 e. Tcolkey do.
    throw '101 Key columns already defined for table ',Tname
  end.
  prc=. cutcoldefs ndx {. def
  def=. prc, cutcoldefs (ndx+1) }. def
  key=. (#prc) $ 1
else.
  def=. cutcoldefs def
  key=. 0
end.

def=. cutcoldef1 &> def
len=. #def
key=. len {. key
cls=. 0 {"1 def
'typ frx frm'=. }.|:def
map=. 'c' ,each ": each (#Tcolmap) + i.#cls
typ makecolfile each map
addcolumns__locDB cls;Tndx,.frx,.frm,.typ,.key
definetable ''
)
makecolfile=: 4 : 0
name=. y
typx=. DATATYPEX i. x
size=. >. Tall * typx { DATASIZES
size=. size + Padvar * typx e. iVARS
createjmf name;size
(name)=: (#autoid) $ typx pick DATADEFS
EMPTY
)
cutcoldefs=: 3 : 0
a: -.~ (t e. ',',LF) <@deb;._2 t=. y,LF
)
cutcoldef1=: 3 : 0
ndx=. y i. ' '
nam=. ndx {. y
typ=. deb ndx }. y
frx=. _1
frm=. 0
if. 0=#typ do.
  ndx=. Columns i. <nam
  tpx=. 3{ndx{ColTab
else.
  tpx=. DATATYPES i. <typ
  if. tpx = #DATATYPES do.
    frx=. Tables i. <typ
    if. frx = #Tables do.
      throw '101 Invalid datatype: ',typ
    end.
    tpx=. 0
    loc=. frx{Locales
    frm=. 1 = +/Tcolkey__loc
  end.
end.
nam;tpx;frx;frm
)
createtable=: 3 : 0
'cols data'=. y
Tndx=: <:#Tables
Tname=: Tndx pick Tables
Tpath=: termSEP Database,Tname
dcreate Tpath
createhidden''
if. #cols do.
  insertcols cols
end.
if. #data do.
  definereq''
  Insert data
end.
)
createhidden=: 3 : 0
Tpid=: 1
Tran=: 0
Tall=: Padrws
size=. >.Tall*sINT
createjmf 'c0';size;'autoid'
createjmf 'c1';size;'tranid'
createjmf 'd0';size;'active'
createjmf 'd1';size;'deleted'
createjmf 'd2';(3*sINT);'state'
autoid=: $0
tranid=: $0
active=: $0
deleted=: 0 2$0
state=: Tall,Tpid,Tran
addcolumns__locDB (;:'autoid tranid');,:~Tndx,_1 0 0
definetable''
EMPTY
)
delete=: 3 : 0
sel=. ,y
if. sel -: ,'*' do.
  rws=. i.Tall
else.
  rws=. getwhere sel
end.

delete1 rws
)
delete1=: 3 : 0
new=. Trans,.y
req=. Padmin + <. +/ 7!:5 'deleted';'new'
act=. getmapsize 'deleted'
if. req > act do.
  resizemap 'd1';(Padvar + req);'deleted'
end.
Tdelete=: Tdelete,y

EMPTY
)
fixrefs=: 4 : 0
frx=. x
dat=. y
for_i. I. frx > _1 do.
  loc=. (i{frx){Locales
  dat=. (<getkeyid__loc i pick dat) i} dat
end.
)
fixvalues=: 4 : 0
dat=. y
for_t. x do.
  val=. >t_index{dat
  rnk=. #$val
  if. rnk > 1 + iCHAR=t do.
    throw '101 Invalid data rank'
  end.
  select. t
  case. iBOOLEAN do.
    if. 1 ~: 3!:0 val do.
      if. -. *./ val e. 0 1 do.
        throw '101 Invalid boolean data'
      end.
      val=. 0 ~: val
    end.
  case. iINT do.
    if. 4 ~: 3!:0 val do.
      int=. <. :: 0: val
      if. -. int -: val do.
        throw '101 Invalid integer data'
      end.
      val=. int + -~ 2
    end.
  case. iFLOAT do.
    if. 8 ~: 3!:0 val do.
      if. -. (3!:0 val) e. 1 2 4 do.
        throw '101 Invalid float data'
      end.
      val=. val + -~ 2.1
    end.
  case. iBYTE do.
    if. 2 ~: 3!:0 val do.
      throw '101 Invalid byte data'
    end.
  case. iCHAR do.
    if. (rnk>2) +. 2 ~: 3!:0 val do.
      throw '101 Invalid char data'
    end.
    if. rnk<2 do.
      val=. tomatrix val
    end.
  case. iVARCHAR do.
    if. 1 < L. val do.
      throw '101 Invalid text data'
    end.
    val=. ,each boxxopen val
  case. iBINARY do.
    if. 1 < L. val do.
      throw '101 Invalid binary data'
    end.
    val=. ,each boxxopen val
  case. iAUTOID do.
  case. do.
    assert. 'Invalid type in fixvalues: ',":t
  end.
  dat=. (<val) t_index} dat
end.
)
get_format1=: 4 : 0
lcs=. (x { Typex) { DATALOCS
dat=. y
for_loc. lcs do.
  new=. < get_format__loc loc_index pick dat
  dat=. new loc_index } dat
end.
)
getorder=: 4 : 0
if. 0 = #y do. '' return. end.
if. 0 = #ord=. cutcommas y do. '' return. end.
nms=. (x{Columns), (x{TabColnames)
ind=. ord i. &> ' '
ndx=. nms boxsindex ind {.each ord
msk=. ndx < 2 * #x
ndx=. (#x) | ndx
dir=. (<'desc') = tolower each 4 {. each (ind + 1) }. each ord
msk # (_1 ^ dir) * dir + ndx
)
getrowcol=: 3 : 0
if. 0 = L. y do.
  (getwhere y);2}.Tcolndx return.
end.
'rws cls'=. 2 {. y, '*';'*'
(getwhere rws);getreqindex cls
)
getrows=: 3 : 0
(y{".) &.> Tcolmap
)
insert=: 3 : 0
dat=. boxxopen y
if. (#dat) ~: _2 + #Tcolndx do.
  msg=. 'Insert rows required items: ',":_2 + #Tcolndx
  msg=. msg,', given items: ',":#dat
  throw msg
end.
dat=. (2}.Tcolfrx) fixrefs dat
len=. #0 pick dat
if. len=0 do. return. end.
dat=. (2}.Tcoltyp) fixvalues dat
checkkey dat
seq=. len $ Trans
aid=. Tpid + i.len
Tpid=: Tpid + len
insert1 aid;seq;dat
EMPTY
)
insert1=: 3 : 0

len=. #0 pick y
if. Tall < len + #autoid do.
  Tall=: Padrws + Tall + len
  resizefix''
  writestate''
end.

frx=. Tcolfrx > -1
msk=. frx < Tcoltyp = iCHAR
for_i. I.msk do.
  id=. i pick Tcolmap
  new=. i pick y
  cls=. ({:$id) >. {:$new
  req=. Padmin + cls * len + #autoid
  act=. getmapsize id
  if. req > act do.
    resizemap id;req
  end.
end.

msk=. frx < Tcoltyp e. iVARS
for_i. I.msk do.
  id=. i pick Tcolmap
  new=. i pick y
  req=. Padmin + <. +/ 7!:5 id;'new'
  act=. getmapsize id
  if. req > act do.
    resizemap id;Padvar + req
  end.
end.

if. #Tinsert do.
  Tinsert=: Tinsert ,each y
else.
  Tinsert=: y
end.

EMPTY
)
checkautoid=: 3 : 0
try. -. 0 e. (autoid i: y){active catch. 0 end.
)
getkeyid=: 3 : 0

typ=. Tcolkey#Tcoltyp

select. +/Tcolkey
case. 0 do.
  if. -. checkautoid y do.
    throw '101 Reference not found for autoid column'
  end.
  y
case. 1 do.
  ndx=. Tcolkey i. 1
  val=. ('c',":ndx)~
  if. _1 < ndx { Tcolfrx do.
    loc=. (ndx{Tcolfrx) { Locales
    ind=. val i: getkeyid__loc y
  else.
    dat=. > typ fixvalues <y
    if. iCHAR = typ do.
      dat=. charmatchwid ndx;({:$val);dat
    end.
    ind=. val i: dat
    if. (#autoid) e. ind do.
      throw '101 Reference not found for column: ',ndx pick Tcolnms
    end.
  end.
  res=. ind{autoid
  if. -. checkautoid res do.
    throw '101 Reference not found for column: ',ndx pick Tcolnms
  end.
case. do.
  clx=. I. Tcolkey
  tab=. clx getkeylookup &> y
  ids=. 0{"1 tab
  aid=. (~.;ids) #~ (#tab) = #/.~;ids
  msk=. ids e.each <aid
  rdx=. |:>msk #each 1{"1 tab
  sdx=. |:>2{"1 tab
  ind=. rdx i. sdx
  if. 1 e. ind = #rdx do.
    throw '101 Reference not found for columns: ',towords clx{Tcolnms
  end.
  res=. ind{aid
  if. -. checkautoid res do.
    throw '101 Reference not found for columns: ',towords clx{Tcolnms
  end.
end.
)
getkeylookup=: 4 : 0
val=. ('c',":x)~
if. _1 < x{Tcolfrx do.
  loc=. (x{Tcolfrx) { Locales
  'aid rndx sndx'=. getkeylookups__loc y
  msk=. active *. val e. aid
  rndx=. rndx {~ aid i. msk#val
  aid=. msk#autoid
else.
  typ=. x{Tcoltyp
  dat=. > typ fixvalues <y
  if. iCHAR = typ do.
    dat=. charmatchwid x;({:$val);dat
  end.
  nub=. ~.dat
  inx=. I. active *. val e. nub
  aid=. inx{autoid
  rndx=. nub i. inx{val
  sndx=. nub i. dat
end.
ndx=. /: aid
aid=. ndx{aid
rndx=. ndx{rndx
aid;rndx;sndx
)
getkeylookups=: 3 : 0
select. +/Tcolkey
case. 0 do.
  nub=. ~.y
  if. 0 e. nub e. autoid do.
    throw '101 Reference not found in autoid column'
  end.
  y;;~nub i. y
case. 1 do.
  (Tcolkey i. 1) getkeylookup y
case. do.
  clx=. I. Tcolkey
  tab=. clx getkeylookup &> y
  ids=. 0{"1 tab
  rdx=. 1{"1 tab
  sdx=. |:>2{"1 tab
  id0=. 0 pick ids
  msk=. ids e. each < id0 #~ *./ (<id0) e.&> ids
  aid=. (0 pick msk) # 0 pick ids
  rdx=. |:>msk #each rdx
  sdx=. rdx i. sdx
  rdx=. rdx i. rdx
  if. 1 e. sdx = #rdx do.
    throw '101 Reference not found for columns: ',towords clx{Tcolnms
  end.
  aid;rdx;sdx
end.
)
createjmf=: 3 : 0
'name size map'=. 3$y
file=. Tpath,name
createjmf_jmf_ file;size+Padmin
map_jmf_ (map,Tloc);file
)
getmapsize=: 3 : 0
try.
  msize_jmf_ 6 pick (({."1 mappings_jmf_) i. <y,Tloc){mappings_jmf_
catch.
  0
end.
)
resizefix=: 3 : 0
ndx=. I. (Tcolfrx = -1) *: Tcoltyp e. iCHAR,iVARS
typ=. iINT,ndx{Tcoltyp
siz=. Padmin + >. Tall * typ { DATASIZES
nms=. (<'active'),ndx{Tcolmap
nms=. nms,each <Tloc
fls=. (<(({."1 mappings_jmf_) i. nms);1){mappings_jmf_
for_i. i.#nms do.
  unmap_jmf_ (i{nms),<i{siz
  map_jmf_ (i{nms),i{fls
end.
)
resizemap=: 3 : 0
'name size map'=. 3$y
mapname=. map,Tloc
unmap_jmf_ mapname;size
map_jmf_ mapname;Tpath,name
)
Delete=: 3 : 0
delete y
commit''
dbwritetrans''
)
DeleteCols=: deletecols
Insert=: 3 : 0
insert y
commit''
dbwritetrans''
)
InsertCols=: 3 : 0
insertcols y
refresh__locDB''
)
Read=: read
Readr=: readr
Reads=: 3 : 0
dat=. read y
({.dat),:tocolumn {:dat
)
Update=: 3 : 0
update y
commit''
dbwritetrans''
)
Updatebyautoids=: 3 : 0
updatebyautoids y
commit''
dbwritetrans''
)

Hidcol=: ;: 'd0 d1 d2 c0 c1'
opentable=: 3 : 0
definetable y
Tname=: Tndx pick Tables
Tpath=: termSEP Database,Tname
maps=. (Thidmap,Tcolmap) ,each <Tloc
mfls=. (<Tpath) ,each Hidcol,2}.Tcolmap
for_i. i.#maps do.
  map_jmf_ (i{maps),i{mfls
end.
readstate''
revert''
)
definereq=: 3 : 0

if. 2=#Tcolnms do. definereqinit'' return. end.

cls=. Tcolnms
req=. ,each Tcolndx
tcs=. (<Tname,'.') ,each Tcolnms

ndx=. I. _1 < Tcolfrx
for_n. ndx do.
  r=. n{req
  loc=. (n{Tcolfrx) { Locales
  if. n{Tcolfrm do.
    req=. (r ,each 2{Vreq__loc) n} req
  end.
  msk=. (Vcls__loc e. cls) +: '.' e.&> Vcls__loc
  if. 1 e. msk do.
    cls=. cls,msk#Vcls__loc
    req=. req,r ,each msk#Vreq__loc
    tcs=. tcs,msk#Vtcs__loc
  end.
  cls=. cls,(<(>n{cls),'.') ,each Vcls__loc
  req=. req,r ,each Vreq__loc
  tcs=. tcs,Vtcs__loc
end.

Vcls=: cls
Vreq=: req
Vtcs=: tcs

cls=. cls,tcs
msk=. ~: cls
Tcls=: msk # cls
Treq=: msk # req,req
Tcnm=: TabColnames intersect Tcls

definestar''
)
definestar=: 3 : 0
Tstar=: 2 }. i.#Tcolnms

msk=. -. ({:&> Treq) e. ColHiddens,ColRefs
cls=. msk # Tcls
req=. msk # Treq

msk=. (cls e. Tcolnms) +. ('.' e. &> cls) +: cls e. ColDups
rcs=. msk # cls
rrq=. msk # req

msk=. msk +: req e. rrq
if. 1 e. msk do.
  cls=. msk # cls
  req=. msk # req
  msk=. -. cls e. Tcnm
  rcs=. rcs, cls /: msk
  rrq=. rrq, req /: msk
end.

msk=. ~: rrq
rcs=. msk # rcs
rrq=. msk # rrq

len=. >./ #&> rrq
ndx=. /: len {.each rrq
rcs=. ndx { rcs
rrq=. ndx { rrq

Tstarstar=: Tcls i. rcs
Tstarplus=: Tstarstar #~ ({: &> Tstarstar{Treq) e. Tcolndx,ColKeys

EMPTY
)
definereqinit=: 3 : 0
Vcls=: Tcolnms
Vreq=: ,each Tcolndx
Vtcs=: (<Tname,'.') ,each Tcolnms
Tcls=: Vcls,Vtcs
Treq=: Vreq,Vreq
Tcnm=: Vtcs
Tstar=: Tstarstar=: Tstarplus=: ''
)
showit=: 3 : 0
r=. 'len0,len1,all,pid,par,seq = ',":state

nms=. Tcolndx { Columns
frx=. (<Tcolndx;1) { ColTab
typ=. (<Tcolndx;3) { ColTab

hdr=. ;:'Columns Index Type FKey'
dat=. tocolumn nms;Tcolndx;typ;frx
r,,LF,.": hdr,:dat
)
readstate=: 3 : 0
'Tall Tpid Tran'=: state
)
writestate=: 3 : 'state=: Tall,Tpid,Tran'
commit=: 3 : 0
Tran=: Trans
writestate''

if. #Tdelete do.
  active=: 0 Tdelete} active
  deleted=: deleted,Tran,.Tdelete{tranid
end.

if. #Tinsert do.
  tinsert''
end.

Tdelete=: Tinsert=: ''
validate''
)
revert=: 3 : 0
if. Tran <: Trans do. return. end.
len=. tranid (1 i.~ <:) Trans
map=. 'active';Tcolmap
ndx=. I. len < #@". &> map
for_i. ndx do.
  id=. i{map
  (id)=: len {. id~
end.
deleted=: deleted #~ deleted <: Trans
Tran=: Trans
Tdelete=: Tinsert=: ''
writestate''
validate''
)
checkkey=: 3 : 0
select. +/Tcolkey
case. 0 do.
case. 1 do.
  ndx=. Tcolkey i. 1
  dat=. (ndx-2) pick y
  if. 0 e. ~: dat do.
    msg=. (ndx pick Tcolnms),LF,LF,'value: ',":>({~ ~: i. 0:) dat
    throw '101 Duplicate values in new data column: ',msg
  end.
  val=. ". ndx pick Tcolmap
  if. iCHAR = ndx{Tcoltyp do.
    rws=. {:$val
    dat=. dat #~ rws >: charwid dat
    if. 0 e. $dat do. return. end.
    dat=. rws {."1 dat
  end.
  msk=. dat e. val
  if. 1 e. msk do.
    dat=. msk # dat
    msk=. active *. val e. dat
    if. 1 e. msk do.
      msg=. (ndx pick Tcolnms),LF,LF,'value: ',":>{.(msk i. 1){val
      throw '101 Duplicate values in column: ',msg
    end.
  end.
case. do.
  ndx=. I. Tcolkey
  dat=. 1 #each (ndx-2){y
  if. 0 e. tnubsieve dat do.
    msg=. commasep (0 i.~ tnubsieve dat) {each dat
    msg=. (commasep ndx { Tcolnms),LF,LF,'values: ',msg
    throw '101 Duplicate values in new data column: ',msg
  end.
  for_n. I. iCHAR = ndx{Tcoltyp do.
    val=. ". (n{ndx) pick Tcolmap
    rws=. {:$val
    sel=. n pick dat
    msk=. rws >: charwid sel
    if. -. 1 e. msk do. return. end.
    dat=. (<msk) #each dat
    dat=. (<msk # rws{."1 sel) n} dat
  end.
  msk=. a: { active
  for_n. ndx do.
    msk=. msk *. (". n pick Tcolmap) e. n_index pick dat
    if. -. 1 e. msk do. return. end.
  end.
  sel=. ((I.msk){".) each ndx{Tcolmap
  dax=. |: sel i.&> dat
  vax=. |: i.~ &> sel
  if. 1 e. dax e. vax do.
    msg=. commasep (1 i.~ dax e. vax) {each dat
    msg=. (commasep ndx { Tcolnms),LF,LF,'values: ',msg
    throw '101 Duplicate values in columns: ',msg
  end.
end.
)
isunique=: 3 : 0
select. #y
case. 0 do.
  1
case. 1 do.
  *./ ~: ". ({.y) pick Tcolmap
case. do.
  dat=. ". each y { Tcolmap
  *./ tnubsieve dat
end.
)
update=: 3 : 0
'dat rws cls'=. 3 {. y, 3 # <'*'
rws=. getwhere rws
len=. #rws
if. len=0 do. return. end.
clx=. Tcolndx i. getcolndx cls
dat=. boxxopen dat
assert. (#clx) = #dat
dat=. (clx{Tcolfrx) fixrefs dat
dat=. (clx{Tcoltyp) fixvalues dat
if. *./ 1 = # &> dat do. dat=. len&# &.> dat end.
assert. len = # &> dat
old=. getrows rws
new=. dat clx } old
new=. (<len$Trans) 1 } new
delete1 rws
insert1 new
EMPTY
)
updatebyautoids=: 3 : 0
'dat auts cls'=. 3 {. y, 3 # <'*'
assert. auts e. autoid
rws=. (active (* - -.@[) autoid) i. auts
len=. #rws
if. len=0 do. return. end.
clx=. Tcolndx i. getcolndx cls
dat=. boxxopen dat
assert. (#clx) = #dat
dat=. (clx{Tcolfrx) fixrefs dat
dat=. (clx{Tcoltyp) fixvalues dat
assert. len = # &> dat
old=. getrows rws
new=. dat clx } old
new=. (<len$Trans) 1 } new
delete1 rws
insert1 new
EMPTY
)
coclass 'jdbtable'
ovr=: [^:(0 < #@[) each   
getreadcols=: 3 : 0
if. 0=#y do.
  getcolstar '*' return.
end.
pfx=. {. &> y
if. '*' e. pfx do.
  ndx=. pfx i. '*'
  (getcolstar >ndx{y),getreqindex (<<<ndx){y
else.
  getreqindex y
end.
)
readr=: 3 : 'autoid {~ getwhere y'
readbase=: 3 : 0
'rws cls'=. y

req=. cls { Treq
clr=. ~. red=. {.&> req
msk=. 1 < # &> req
res=. (clr i. red) { readbase1 rws;clr
if. -. 1 e. msk do. return. end.

req=. msk # req
nub=. ~. {.&> req
rex=. ({.&> req) </. I.msk
req=. ({.&> req) </. }.each req
for_n. nub do.
  ren=. n_index { req
  loc=. Locales {~ {. ({.>{.>ren) { ColTab
  val=. readbase2__loc ren,(red i. n){res
  res=. val (>n_index { rex) } res
end.
)
readbase1=: 3 : 0
'rws cls'=. y
cls=. (Tcolndx i. cls) { Tcolmap
if. rws -: '*' do.
  ". &.> cls
else.
  (rws{".) &.> cls
end.
)
readbase2=: 3 : 0
'req val'=. y
rws=. autoid i: val

clr=. ~. red=. {.&> req
msk=. 1 < # &> req
cls=. (Tcolndx i. clr) { Tcolmap
res=. (clr i. red) { (rws{".) &.> cls
if. -. 1 e. msk do. return. end.

req=. msk # req
nub=. ~. {.&> req
rex=. ({.&> req) </. I.msk
req=. ({.&> req) </. }.each req
for_n. nub do.
  ren=. n_index { req
  loc=. Locales {~ {. ({.>{.>ren) { ColTab
  val=. readbase2__loc ren,(red i. n){res
  res=. val (>n_index { rex) } res
end.
)
AGGFNS=: ;:'avg count countunique first last max min sum'

avg=: +/%#
count=: #
countunique=: #@~.
first=: {.
last=: {:
max=: >./
min=: <./
sum=: +/
getcolnames=: 3 : 0
nms=. y { Tcls
)
getcolstar=: 3 : 0
select. ,y
case. ,'*' do. Tstar
case. '**' do. Tstarstar
case. '*+' do. Tstarplus
case. do.
  throw '101 Unrecognized column selection: ',y
end.
)
sortorder=: 4 : 0
if. 0 = #ord=. cutcommas x do. y return. end.
nms=. {."1 y
ind=. ord i. &> ' '
ndx=. nms boxsindex ind {.each ord
msk=. ndx < #nms
dir=. (<'desc') = 4 {. each (ind + 1) }. each ord
ord=. msk # (_1 ^ dir) * dir + ndx
if. 0=#ord do. y return. end.
val=. {:"1 y
for_n. |. ord do.
  if. n < 0 do.
    srt=. \: (| 1 + n) pick val
  else.
    srt=. /: n pick val
  end.
  val=. (<srt) {each val
end.
nms,.val
)
read=: 3 : 0
'select by where order'=. y
rws=. getwhere where
if. #1 pick by do.
  res=. rws readby select;<by
else.
  res=. rws readsimple select
end.
if. 0=#order do. res return. end.
order sortorder res
)
readby=: 4 : 0
rws=. x
'ra rf rc'=. 0 pick y
'ba bc'=. 1 pick y
if. 0 e. rf e. AGGFNS do.
  throw '101 Unrecognized aggregate function: ',towords rf -. AGGFNS
end.
rc=. getreadcols rc
bc=. getreadcols bc
brc=. bc,rc
nms=. getcolnames brc
s=. readbase x;brc
c=. i.~|:i.~every (#bc){.s       
ff=. rf,~(#bc)${.`{.             
r=. ''
for_i. i.#bc,rc do.
  r=. r,< c ff@.i/. i {::s       
end.
((ba,ra) ovr nms),.r
)
readsimple=: 4 : 0
'ra rf rc'=. y
rc=. getreadcols rc
nms=. getcolnames rc
s=. readbase x;rc
if. #;rf do.
  for_i. i.#rc do.
    s=. (< (i{::rf)~ i{::s) i} s
  end.
end.
nms,.s
)
coclass 'jdbtable'
getcolumn=: 3 : 0
cls=. getreq1 y

if. 1 = #cls do.
  readcolindex clx return.
end.
clx=. {:cls
loc=. Locales {~ {. clx { ColTab
val=. readcolindex__loc clx
cls=. }:cls
clx=. {:cls
lcc=. Locales {~ {. clx { ColTab
sel=. autoid__loc i. readcolindex__lcc clx

while. #cls=. }:cls do.
  clx=. {:cls
  lcc=. Locales {~ {. clx { ColTab
  sel=. sel i. readcolindex__lcc clx
end.

sel{val
)
getcolndx=: 3 : 0
ind=. ,y
if. 0 = #ind do. return. end.
ndx=. Tcls i. boxxopen ind
if. (#Tcls) e. ndx do.
  throw '101 Invalid column: ',towords (ndx = #Tcls) # boxxopen ind
end.
ndx=. {.&> ndx{Treq
if. 0 e. ndx e. Tcolndx do.
  throw '101 Invalid column: ',towords (0 = ndx e. Tcolndx) # boxxopen ind
end.
)
getcolndx1=: 3 : 0
ndx=. Tcls i. <,y
if. ndx = #Tcls do.
  throw '101 Invalid column: ',y
end.
ndx=. {. > ndx{Treq
if. -. ndx e. Tcolndx do.
  throw '101 Invalid column: ',y
end.
)
getreqindex=: 3 : 0
ind=. ,y
if. 0 = #ind do. return. end.
ndx=. Tcls i. boxxopen ind
if. (#Tcls) e. ndx do.
  throw '101 Invalid column: ',towords (ndx = #Tcls) # boxxopen ind
end.
)
getreq1=: 3 : 0
ndx=. Tcls i. <,y
if. ndx = #Tcls do.
  throw '101 Invalid column: ',y
end.
> ndx { Treq
)
readcolindex=: 3 : '". >Tcolmap {~ Tcolndx i. y'
fixwhere=: 3 : 0
txt=. deb y

if. 0 = #txt do. return. end.
if. 'not ' -: 4 {. txt do.
  'qnot' ; <fixwhere 4 }. txt return.
end.
if. '(' = {. txt do.
  ndx=. 0 i.~ +/\ -/ '()' =/ txt
  bal=. dlb (ndx + 1) }. txt
  sel=. fixwhere }. ndx {. txt
  if. #bal do.
    ind=. 1 i.~ (bal e. ' ') > ~:/\ bal e. ''''
    ('q',ind {. bal) ; sel ; <fixwhere (ind + 1) }. bal
  end.
  return.
end.
msk=. 0 = +/\ -/ '()' =/ txt
ndx=. 1 i.~ msk *. (' and ' E. txt) +. ' or ' E. txt
if. ndx=#txt do. <fixwhere1 txt return. end.
bal=. (ndx+1) }. txt
ind=. bal i. ' '
('q',ind {. bal) ; (fixwhere ndx {. txt) ; <fixwhere ind }. bal
)
fixwhere1=: 3 : 0
sel=. ~: /\ y e. ''''
msk=. sel <"1 > qDFS E. each <y
ind=. (0 < +/"1 msk) i. 1
if. ind = #msk do.
  throw '101 Unrecognised where statement: ',y
end.
ndx=. (ind { msk) i. 1
len=. # ind pick qDFS
bal=. delquotes deb (ndx + len) }. y
(deb ndx {. y) ; (ind pick qFNS) ; deb bal
)
require 'regex'
j=. cutopen ;._2 (0 : 0)
qgreaterequal ge >=
qlessequal le <=
qnotequal ne <>
qequal eq =
qgreater gt >
qless lt <
qin in
qis is
qnotin notin
qlike like
)

a=. 0 {"1 j
b=. ' ',each (1 {"1 j) ,each ' '
c=. 2 {"1 j
m=. 0 < # &> c
qFNS=: a, m # a
qDFS=: b, m # c

qand=: *.
qor=: +.
qnot=: -.
qequal=: 4 : 0
if. 0 = #x do. '' return. end.
if. isnumeric x do.
  x = fixnum1 y return.
end.
select. 3!:0 x
case. 2 do.
  if. 2 > #$x do.
    x = {.y
  else.
    cls=. {:$x
    if. cls < charwid y do. 0 return. end.
    x e. cls {."1 tomatrix y
  end.
case. 32 do.
  x = boxopen y
case. 1;4;8 do.
  x = fixnum1 y
case. do.
  throw '101 Unsupported datatype in select statement'
end.
)
qless=: 4 : 0
if. 0 = #x do. '' return. end.
if. isnumeric x do.
  x < fixnum1 y
else.
  throw '101 Unsupported datatype in select statement'
end.
)
qlessequal=: 4 : 0
if. 0 = #x do. '' return. end.
if. isnumeric x do.
  x <: fixnum1 y
else.
  throw '101 Unsupported datatype in select statement'
end.
)
qin=: 4 : 0
if. 0 = #x do. '' return. end.

if. isnumeric x do.
  x e. fixnums y return.
end.

y=. y -. '()'

select. 3!:0 x
case. 2 do.
  if. 2 > #$x do.
    x e. y
  else.
    cls=. {:$x
    sel=. >cutnames y
    sel=. sel #~ cls >: charwid sel
    if. 0 = #sel do. 0 return. end.
    x e. cls {."1 tomatrix sel
  end.
case. 32 do.
  x e.!.0 cutnames y
case. 1;4;8 do.
  x e. fixnums cutnames y
case. do.
  throw '101 Unsupported datatype in select statement'
end.
)
qlike=: 4 : 0
 if. 0 = #x do. '' return. end.

 if. -. 2 32 e.~ dt =. 3!:0 x do.
   throw '101 Unsupported datatype in select statement'
 end.

 noRE =. 'invalid handle'
 y=. rxcomp :: (noRE"_) y
 if. noRE -: y do.
   throw '101 Invalid regular expression, ',rxerror''
 end.

 matches =. ((y&rxmatch)@>)`(y&rxmatch"0 1) @. (2 = dt) x

 rxfree y

 _1 < , _ 1 1 {. matches
)
qis=: qequal
qnotequal=: -. @: qequal
qnotin=: -. @: qin
qgreater=: -. @: qlessequal
qgreaterequal=: -. @: qless
qequalc=: =
qlessc=: <
qlessequalc=: <:
qinc=: e.
qisc=: =
qnotequalc=: ~:
qnotinc=: -. @: e.
qgreaterc=: >
qgreaterequalc=: >:
qlikec=: dyad define
  throw '101 Unsupported: regex from table value.'
)
getwhere=: 3 : 0
if. #y do.
  I. active *. getwherex fixwhere y
else.
  I. active
end.
)
getwherex=: 3 : 0
select. #y
case. 0 do.
  1
case. 1 do.
  getwherex_select 0 pick y
case. 2 do.
  'opn sel'=. y
  opn~ getwherex sel
case. 3 do.
  'opn sel1 sel2'=. y
  (getwherex sel1) opn~ getwherex sel2
end.
)
getwherex_select=: 3 : 0

'col fn val'=. y

if. (<val) e. Tcnm do.
  getwherex_select2 y return.
end.

cls=. getreq1 col

if. 1 = #cls do.
  fid=. >Tcolmap {~ Tcolndx i. {.cls
  fid~ fn~ val return.
end.

clx=. {:cls
loc=. Locales {~ {. clx { ColTab
msk=. getwherex_select1__loc clx;fn;val

while. #cls=. }:cls do.
  val=. msk # autoid__loc
  clx=. {:cls
  loc=. Locales {~ {. clx { ColTab
  msk=. getwherex_select1__loc clx;'qin';val
end.
)
getwherex_select1=: 3 : 0
'clx fn val'=. y
fid=. > Tcolmap {~ Tcolndx i. clx
active *. fid~ fn~ val
)
getwherex_select2=: 3 : 0
'col0 fn col1'=. y
val0=. getcolumn col0
val1=. getcolumn col1
fnc=. fn,'c'
val0 fnc~ val1
)
coclass 'jdb'
showx=: 4 : 0 ".
smoutput '   ',x
smoutput y
)
JCols=: 0 : 0
jid varchar;
jname varchar
city varchar
)

JData=: '' fixcols 0 : 0
J1 Sorter  Paris
J2 Display Rome
J3 OCR     Athens
J4 Console Athens
J5 RAID    London
J6 EDS     Oslo
J7 Tape    London
)
PCols=: 0 : 0
pid varchar;
pname varchar
color varchar
weight int
city varchar
)

PData=: 3 fixcols 0 : 0
P1 Nut   Red   12 London
P2 Bolt  Green 17 Paris
P3 Screw Blue  17 Oslo
P4 Screw Red   14 London
P5 Cam   Blue  12 Paris
P6 Cog   Red   19 London
)
SCols=: 0 : 0
sid varchar;
sname varchar
status int
city
)

SData=: 2 fixcols 0 : 0
S1 Smith 20 London
S2 Jones 10 Paris
S3 Blake 30 Paris
S4 Clark 20 London
S5 Adams 30 Athens
)
SPCols=: 0 : 0
sid s
pid p;
qty int
)

SPData=: 2 fixcols 0 : 0
S1 P1 300
S1 P2 200
S1 P3 400
S1 P4 200
S1 P5 100
S1 P6 100
S2 P1 300
S2 P2 400
S3 P2 200
S4 P2 200
S4 P4 300
S4 P5 400
)
SPJCols=: 0 : 0
sid s
pid p
jid j;
qty
)

SPJData=: 3 fixcols 0 : 0
S1 P1 J1 200
S1 P1 J4 700
S2 P3 J1 400
S2 P3 J2 200
S2 P3 J3 200
S2 P3 J4 500
S2 P3 J5 600
S2 P3 J6 400
S2 P3 J7 800
S2 P5 J2 100
S3 P3 J1 200
S3 P4 J2 500
S4 P6 J3 300
S4 P6 J7 300
S5 P2 J2 200
S5 P2 J4 100
S5 P5 J5 500
S5 P5 J7 100
S5 P6 J2 200
S5 P1 J4 100
S5 P3 J4 200
S5 P4 J4 800
S5 P5 J4 400
S5 P6 J4 500
)
buildsandp=: 3 : 0
f=. Open foldersandp y
Drop__f 'sandp'
d=. Create__f 'sandp'
Create__d 'j';JCols;<JData
Create__d 'p';PCols;<PData
Create__d 's';SCols;<SData
Create__d 'sp';SPCols;<SPData
Create__d 'spj';SPJCols;<SPJData
d
)
opensandp=: 3 : 0
f=. Open foldersandp y
locD__=: Open__f 'sandp'
)
demosandp=: 3 : 0
buildsandp y
d=. opensandp y
showx 'Reads__d ''from j'''
showx 'Reads__d ''from p'''
showx 'Reads__d ''from s'''
showx 'Reads__d ''from sp'''
showx 'Reads__d ''from spj'''
showx 'Reads__d ''from sp where sid=S1 and qty > 250'''
showx 'Reads__d ''pid,qty from sp where pid=P2'''
showx 'Reads__d ''** from sp where s.city=p.city'''
showx 'Reads__d ''job_cnt:count jname by city from j'''
showx 'Reads__d ''sum weight by color from p where city<>Paris'''
showx 'Reads__d ''sum weight by color,city from p'''
showx 'Reads__d ''avg weight by city,color from p'''
showx 'Reads__d ''avg weight,pone:first pid by where:city,color from p'''
showx 'Reads__d ''min_st:min status by city from s'''
showx 'Reads__d ''sum weight,min status by supplier:s.city from sp'''
showx 'Reads__d ''sum weight by supp:s.city,part:p.city from sp'''
showx 'Reads__d ''avg_qty:avg qty by supp:sname,part:p.city from spj order by avg_qty'''
showx 'Reads__d ''avg_qty:avg qty by part_col:p.color from spj'''
)
foldersandp=: 3 : 0
if. #y do.
  try. y=. jpath y catch. end.
  y return.
end.
a=. jpath '~.JDB/data'
a=. (isdirectory a) # a
if. 0 = #a do.
  info 'Demo sandp needs a foldername argument.'
end.
)
cocurrent 'jdb'
reset''
