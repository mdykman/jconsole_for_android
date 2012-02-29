NB. =========================================================
NB. tables/tara
NB. Reads and writes files in Excel format
NB. ---------------------------------------------------------
NB.  jolew script for reading and writing ole2 storage
NB.  portion based on ole::storage_lite by kawai takanori, kwitknr@cpan.org
NB. utility function for olew
coclass 'oleutlfcn'
NB. return datetime in j timestamp format
oledate2local=: 3 : 0
86400000* _72682+86400%~10000000%~(8#256)#. a.i.y
)

NB. y datetime in j timestamp format
localdate2ole=: 3 : 0
a.{~(8#256)#: 10000000*x:86400*(y%86400000)+72682
)

NB. not defined in stdlib pre-J6
Note=: 3 : '0 0 $ 0 : 0' : [

NB. followings also defined in z locale
NB. ---------------------------------------------------------
NB. followings bit op require j5
bitand=: 17 b.
bitxor=: 22 b.
bitor=: 23 b.
bitneg=: 26 b.
bitrot=: 32 b.
bitshl=: 33 b.
bitsha=: 34 b.
NB. binary strings
bigendian=: ({.a.)={. 1&(3!:4) 1  NB. 0 little endian   1 big endian
toBYTE=: {&a.@(256&|)
fromBYTE=: a.&i.
toWORDm=: 1&(3!:4)@:<.
toDWORDm=: 2&(3!:4)@:<.
toucodem=: ''&,@(1&(3!:4))@(3&u:)@u:
toDoublem=: 2&(3!:5)
fromWORDm=: _1&(3!:4)
fromDWORDm=: _2&(3!:4)
fromucodem=: 6&u:
fromDoublem=: _2&(3!:5)
toWORDr=: ,@:(|."1)@(_2: ]\ 1&(3!:4)@:<.)
toDWORDr=: ,@:(|."1)@(_4: ]\ 2&(3!:4)@:<.)
toucoder=: ''&,@:,@:(|."1@(_2: ]\ 1&(3!:4)))@(3&u:)@u:
toDoubler=: ,@:(|."1)@(_8: ]\ 2&(3!:5))
fromWORDr=: _1&(3!:4)@:,@:(|."1)@(_2&(]\))
fromDWORDr=: _2&(3!:4)@:,@:(|."1)@(_4&(]\))
fromucoder=: 6&u:@:,@:(|."1)@(_2&(]\))
fromDoubler=: _2&(3!:5)@:,@:(|."1)@(_8&(]\))
NB. always little endian conversion
toWORD0=: toWORDm`toWORDr@.bigendian f.
toDWORD0=: toDWORDm`toDWORDr@.bigendian f.
toucode0=: toucodem`toucoder@.bigendian f.
toDouble0=: toDoublem`toDoubler@.bigendian f.
fromWORD0=: fromWORDm`fromWORDr@.bigendian f.
fromDWORD0=: fromDWORDm`fromDWORDr@.bigendian f.
fromucode0=: fromucodem`fromucoder@.bigendian f.
fromDouble0=: fromDoublem`fromDoubler@.bigendian f.
NB. always big endian conversion
toWORD1=: toWORDm`toWORDr@.(-.bigendian) f.
toDWORD1=: toDWORDm`toDWORDr@.(-.bigendian) f.
toucode1=: toucodem`toucoder@.(-.bigendian) f.
toDouble1=: toDoublem`toDoubler@.(-.bigendian) f.
fromWORD1=: fromWORDm`fromWORDr@.(-.bigendian) f.
fromDWORD1=: fromDWORDm`fromDWORDr@.(-.bigendian) f.
fromucode1=: fromucodem`fromucoder@.(-.bigendian) f.
fromDouble1=: fromDoublem`fromDoubler@.(-.bigendian) f.
NB. decimal from hex string, always return integer
DFH=: 3 : 0
if. '0x'-:2{.y=. }:^:('L'={:y) y do.
  d=. 0
  for_nib. ('0123456789abcdef'&i.) tolower 2}.y do.
    d=. nib (23 b.) 4 (33 b.) d
  end.
else.
  0&". y
end.
)

NB. for biff8 RGB values
RGB=: 3 : 0"1
(0{y) (23 b.) 8 (33 b.) (1{y) (23 b.) 8 (33 b.) (2{y)
)

RGBtuple=: 3 : 0"0
(16bff (17 b.) y), (_8 (33 b.) 16bff00 (17 b.) y), (_16 (33 b.) 16bff0000 (17 b.) y)
)

NB. utf8 filename in J601
3 : 0''
if. 504 < 0&". 'j'-.~4{.9!:14 '' do.
  fboxname=: ([: < 8 u: >) :: ]
else.
  fboxname=: ([: < [: (1&u: ::]) >) ::]
end.
empty ''
)

fread=: (1!:1 :: _1:) @ fboxname
fdir=: 1!:0@fboxname
freadx=: (1!:11 :: _1:)@(fboxname@{., }.)`(1!:11)@.(0: = L.)
fwritex=: ([ (1!:12) (fboxname@{., }.)@])`(1!:12)@.((0: = L.)@])
fopen=: (1!:21 :: _1:) @ (fboxname &>) @ boxopen
fclose=: (1!:22 :: _1:) @ (fboxname &>) @ boxopen
fwrite=: [ (1!:2) fboxname@]
fappend=: [ (1!:3) fboxname@]
fexist=: (1:@(1!:4) :: 0:) @ (fboxname &>) @ boxopen
ferase=: (1!:55 :: _1:) @ (fboxname &>) @ boxopen
maxpp=: 15 [ 16   NB. max print precision for ieee 8-byte double (52 + 1 implied mantissa)
NB. ---------------------------------------------------------

coclass 'oleheaderinfo'
coinsert 'olepps'
create=: 3 : 0
smallsize=: 16b1000
ppssize=: 16b80
bigblocksize=: 16b200
smallblocksize=: 16b0040
bdbcount=: 0
rootstart=: 0
sbdstart=: 0
sbdcount=: 0
extrabbdstart=: 0
extrabbdcount=: 0
bbdinfo=: 0 2$''
sbstart=: 0
sbsize=: 0
data=: ''
fileh=: ''
ppsfile=: ''
)

coclass 'olestorage'
coinsert 'oleutlfcn'
ppstyperoot=: 5
ppstypedir=: 1
ppstypefile=: 2
datasizesmall=: 16b1000
longintsize=: 4
ppssize=: 16b80
create=: 3 : 0
sfile=: y
openfilenum=: ''
headerinfo=: ''
)

destroy=: 3 : 0
if. '' -.@-: openfilenum do. fclose("0) openfilenum end.
if. '' -.@-: headerinfo do. destroy__headerinfo '' end.
codestroy ''
)

NB.  getppstree:
getppstree=: 3 : 0
bdata=. y
NB. 0.init
rhinfo=. initparse sfile
if. ''-:rhinfo do. '' return. end.
NB. 1. get data
1{:: ugetppstree 0 ; rhinfo ; bdata ;< 0$0
)

NB.  getsearch:
getppssearch=: 3 : 0
'raname bdata icase'=. y
NB. 0.init
rhinfo=. initparse sfile
if. ''-:rhinfo do. '' return. end.
NB. 1. get data
1{:: ugetppssearch 0 ; rhinfo ; raname ; bdata ; icase ;< 0$0
)

NB.  getnthpps:
getnthpps=: 3 : 0
'ino bdata'=. y
NB. 0.init
rhinfo=. initparse sfile
if. ''-:rhinfo do. '' return. end.
NB. 1. get data
1{:: ugetnthpps ino ; rhinfo ; <bdata
)

NB.  initparse:
initparse=: 3 : 0
if. '' -.@-: headerinfo do. headerinfo return. end.
NB. 1. sfile is a resource  hopefully a file resource
if. 1 4 e.~ 3!:0 y do.
  oio=. y
else.
NB. 2. sfile is a filename string
  openfilenum=: ~. openfilenum, oio=. fopen <y   NB. ~. workaround J504's 1!:21 bug
end.
if. '' -.@-: p=. getheaderinfo oio do. headerinfo=: p end.
p
)

NB.  ugetppstree:
ugetppstree=: 3 : 0
'ino rhinfo bdata radone'=. y
if. #radone do.
  if. ino e. radone do. radone ; <'' return. end.
end.
irootblock=. rootstart__rhinfo
NB. 1. get information about itself
if. ''-: opps=. ugetnthpps ino ; rhinfo ; <bdata do. radone ; <'' return. end.
radone=. radone, ino
NB. 2. child
if. dirpps__opps ~: _1 do.
  'rad achild'=. ugetppstree dirpps__opps ; rhinfo ; bdata ; <radone
  radone=. radone, rad
  child__opps=: child__opps, achild
else.
  child__opps=: ''
end.
NB. 3. previous, next ppss
alist=. ''
if. prevpps__opps ~: _1 do.
  'rad achild'=. ugetppstree prevpps__opps ; rhinfo ; bdata ; <radone
  radone=. radone, rad
  alist=. alist, achild
end.
alist=. alist, opps
if. nextpps__opps ~: _1 do.
  'rad achild'=. ugetppstree nextpps__opps ; rhinfo ; bdata ; <radone
  radone=. radone, rad
  alist=. alist, achild
end.
radone ; <alist
)

NB.  ugetppssearch:
ugetppssearch=: 3 : 0
'ino rhinfo raname bdata icase radone'=. y
irootblock=. rootstart__rhinfo
NB. 1. check it self
if. #radone do.
  if. ino e. radone do. radone ; <'' return. end.
end.
alist=. ''
if. ''-: opps=. ugetnthpps ino ; rhinfo ; <0 do. radone ; <'' return. end.
found=. 0
if. ((icase *. name__opps -:&toupper raname) +. name__opps-:raname) do.
  if. 1=bdata do.
    if. ''-: opps1=. ugetnthpps ino ; rhinfo ; <bdata do.
      destroy__opps ''
      radone ; <'' return.
    else.
      destroy__opps ''
      alist=. opps=. opps1
      radone=. radone, ino
    end.
  else.
    alist=. opps
    radone=. radone, ino
  end.
  found=. 1
end.
NB. 2. check child, previous, next ppss
if. dirpps__opps ~: _1 do.
  'rad achild'=. ugetppssearch dirpps__opps ; rhinfo ; raname ; bdata ; icase ; <radone
  radone=. radone, rad
  alist=. alist, achild
end.
if. prevpps__opps ~: _1 do.
  'rad achild'=. ugetppssearch prevpps__opps ; rhinfo ; raname ; bdata ; icase ; <radone
  radone=. radone, rad
  alist=. alist, achild
end.
if. nextpps__opps ~: _1 do.
  'rad achild'=. ugetppssearch nextpps__opps ; rhinfo ; raname ; bdata ; icase ; <radone
  radone=. radone, rad
  alist=. alist, achild
end.
if. 0=found do. destroy__opps '' end.
radone ; <alist
)

NB.  get header info  base informain about that file
getheaderinfo=: 3 : 0
NB. 0. check id
fp=. 0
if. -. (freadx y, fp, 8)-:16bd0 16bcf 16b11 16be0 16ba1 16bb1 16b1a 16be1{a. do. '' return. end.
rhinfo=. '' conew 'oleheaderinfo'
fileh__rhinfo=: y
NB. big block size
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b1e ; 2 do. '' [ destroy__rhinfo '' return. end.
bigblocksize__rhinfo=: <. 2&^ iwk
NB. small block size
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b20 ; 2 do. '' [ destroy__rhinfo '' return. end.
smallblocksize__rhinfo=: <. 2&^ iwk
NB. bdb count
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b2c ; 4 do. '' [ destroy__rhinfo '' return. end.
bdbcount__rhinfo=: iwk
NB. start block
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b30 ; 4 do. '' [ destroy__rhinfo '' return. end.
rootstart__rhinfo=: iwk
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b3c ; 4 do. '' [ destroy__rhinfo '' return. end.
sbdstart__rhinfo=: iwk
NB. small bd count
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b40 ; 4 do. '' [ destroy__rhinfo '' return. end.
sbdcount__rhinfo=: iwk
NB. extra bbd start
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b44 ; 4 do. '' [ destroy__rhinfo '' return. end.
extrabbdstart__rhinfo=: iwk
NB. extra bd count
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b48 ; 4 do. '' [ destroy__rhinfo '' return. end.
extrabbdcount__rhinfo=: iwk
NB. get bbd info
bbdinfo__rhinfo=: getbbdinfo rhinfo
NB. get root pps
if. ''-: opps=. ugetnthpps 0 ; rhinfo ; <0 do. '' [ destroy__rhinfo '' return. end.
sbstart__rhinfo=: startblock__opps
sbsize__rhinfo=: size__opps
destroy__opps ''
rhinfo
)

NB.  getinfofromfile
getinfofromfile=: 3 : 0
'file ipos ilen'=. y
if. ''-:file do. '' return. end.
if. 2=ilen do.
  fromWORD0 freadx file, ipos, ilen
else.
  fromDWORD0 freadx file, ipos, ilen
end.
)

NB.  getbbdinfo
getbbdinfo=: 3 : 0
rhinfo=. y
abdlist=. ''
ibdbcnt=. bdbcount__rhinfo
i1stcnt=. <.(bigblocksize__rhinfo - 16b4c) % longintsize
ibdlcnt=. (<.bigblocksize__rhinfo % longintsize) - 1
NB. 1. 1st bdlist
fp=. 16b4c
igetcnt=. ibdbcnt <. i1stcnt
abdlist=. abdlist, fromDWORD0 freadx fileh__rhinfo, fp, longintsize*igetcnt
ibdbcnt=. ibdbcnt - igetcnt
NB. 2. extra bdlist
iblock=. extrabbdstart__rhinfo
while. ((ibdbcnt> 0) *. isnormalblock iblock) do.
  fp=. setfilepos iblock ; 0 ; <rhinfo
  igetcnt=. ibdbcnt <. ibdlcnt
  abdlist=. abdlist, fromDWORD0 freadx fileh__rhinfo, fp, longintsize*igetcnt
  ibdbcnt=. ibdbcnt - igetcnt
  iblock=. fromDWORD0 freadx fileh__rhinfo, (fp=. fp+longintsize*igetcnt), longintsize
end.
NB. 3.get bds
iblkno=. 0
ibdcnt=. <.bigblocksize__rhinfo % longintsize
hbd=. 0 2$''
for_ibdl. abdlist do.
  fp=. setfilepos ibdl ; 0 ; <rhinfo
  awk=. fromDWORD0 freadx fileh__rhinfo, fp, bigblocksize__rhinfo
  for_i. i.ibdcnt do.
    if. ((i{awk) ~: iblkno+1) do.
      hbd=. hbd, iblkno, i{awk
    end.
    iblkno=. >:iblkno
  end.
end.
hbd
)

NB.  ugetnthpps
ugetnthpps=: 3 : 0
'ipos rhinfo bdata'=. y
ippsstart=. rootstart__rhinfo
ibasecnt=. <.bigblocksize__rhinfo % ppssize
ippsblock=. <.ipos % ibasecnt
ippspos=. ipos |~ ibasecnt
iblock=. getnthblockno ippsstart ; ippsblock ; <rhinfo
if. ''-:iblock do. '' return. end.
fp=. setfilepos iblock ; (ppssize*ippspos) ; <rhinfo
inmsize=. fromWORD0 (16b40+i.2){swk=. freadx fileh__rhinfo, fp, ppssize
inmsize=. 0 >. inmsize - 2
snm=. inmsize{.swk
sname=. fromucode0 (i.inmsize){swk
itype=. 256|fromWORD0 (16b42+i.2){swk
'lppsprev lppsnext ldirpps'=. fromDWORD0 (16b44+i.12){swk
ratime1st=: ((itype = ppstyperoot) +. (itype = ppstypedir)) { 0, oledate2local (16b64+i.8){swk
ratime2nd=: ((itype = ppstyperoot) +. (itype = ppstypedir)) { 0, oledate2local (16b6c+i.8){swk
'istart isize'=. fromDWORD0 (16b74+i.8){swk
if. 1=bdata do.
  sdata=. getdata itype ; istart ; isize ; <rhinfo
  pps=. createpps ipos ; sname ; itype ; lppsprev ; lppsnext ; ldirpps ; ratime1st ; ratime2nd ; istart ; isize ; sdata
else.
  pps=. createpps ipos ; sname ; itype ; lppsprev ; lppsnext ; ldirpps ; ratime1st ; ratime2nd ; istart ; isize
end.
pps
)

NB.  setfilepos
setfilepos=: 3 : 0
'iblock ipos rhinfo'=. y
ipos + (iblock+1)*bigblocksize__rhinfo
)

NB.  getnthblockno
getnthblockno=: 3 : 0
'istblock inth rhinfo'=. y
inext=. istblock
for_i. i.inth do.
  isv=. inext
  inext=. getnextblockno isv ; <rhinfo
  if. 0= isnormalblock inext do. '' return. end.
end.
inext
)

NB.  getdata
getdata=: 3 : 0
'itype iblock isize rhinfo'=. y
if. itype = ppstypefile do.
  if. isize < datasizesmall do.
    getsmalldata iblock ; isize ; <rhinfo
  else.
    getbigdata iblock ; isize ; <rhinfo
  end.
elseif. itype = ppstyperoot do.  NB. root
  getbigdata iblock ; isize ; <rhinfo
elseif. itype = ppstypedir do.  NB.  directory
  0
end.
)

NB.  getbigdata
getbigdata=: 3 : 0
'iblock isize rhinfo'=. y
if. 0= isnormalblock iblock do. '' return. end.
irest=. isize
sres=. ''
akeys=. /:~ {.("1) bbdinfo__rhinfo
while. irest > 0 do.
  ares=. (akeys>:iblock)#akeys
  inkey=. {.ares
  i=. inkey - iblock
  inext=. ({:("1) bbdinfo__rhinfo){~({.("1) bbdinfo__rhinfo)i.inkey
  fp=. setfilepos iblock ; 0 ; <rhinfo
  igetsize=. irest <. bigblocksize__rhinfo * (i+1)
  sres=. sres, freadx fileh__rhinfo, fp, igetsize
  irest=. irest-igetsize
  iblock=. inext
end.
sres
)

NB.  getnextblockno
getnextblockno=: 3 : 0
'iblockno rhinfo'=. y
if. iblockno e. {.("1) bbdinfo__rhinfo do.
  ({:("1) bbdinfo__rhinfo){~({.("1) bbdinfo__rhinfo)i.iblockno
else.
  iblockno+1
end.
)

NB.  isnormalblock
NB. _4 : bdlist, _3 : bbd,
NB. _2: end of chain _1 : unused
isnormalblock=: 3 : 0
y -.@e. _4 _3 _2 _1
)

NB.  getsmalldata
getsmalldata=: 3 : 0
'ismblock isize rhinfo'=. y
irest=. isize
sres=. ''
while. irest > 0 do.
  fp=. setfilepossmall ismblock ; <rhinfo
  sres=. sres, freadx fileh__rhinfo, fp, irest <. smallblocksize__rhinfo
  irest=. irest - smallblocksize__rhinfo
  ismblock=. getnextsmallblockno ismblock ; <rhinfo
end.
sres
)

NB.  setfilepossmall
setfilepossmall=: 3 : 0
'ismblock rhinfo'=. y
ismstart=. sbstart__rhinfo
ibasecnt=. <.bigblocksize__rhinfo % smallblocksize__rhinfo
inth=. <.ismblock%ibasecnt
ipos=. ismblock |~ ibasecnt
iblk=. getnthblockno ismstart ; inth ; <rhinfo
setfilepos iblk ; (ipos * smallblocksize__rhinfo) ; <rhinfo
)

NB.  getnextsmallblockno
getnextsmallblockno=: 3 : 0
'ismblock rhinfo'=. y
ibasecnt=. <.bigblocksize__rhinfo % longintsize
inth=. <.ismblock%ibasecnt
ipos=. ismblock |~ ibasecnt
iblk=. getnthblockno sbdstart__rhinfo ; inth ; <rhinfo
fp=. setfilepos iblk ; (ipos * longintsize) ; <rhinfo
fromDWORD0 freadx fileh__rhinfo, fp, longintsize
)

createpps=: 3 : 0
'ipos sname itype lppsprev lppsnext ldirpps ratime1st ratime2nd istart isize sdata'=. 11{.y
select. {.itype
case. ppstyperoot do.
  p=. conew 'oleppsroot'
  create__p ratime1st ; ratime2nd ;< ''
case. ppstypedir do.
  p=. conew 'oleppsdir'
  create__p sname ; ratime1st ; ratime2nd ;< ''
case. ppstypefile do.
  p=. conew 'oleppsfile'
  create__p sname ; sdata ;< ''
case. do.
  assert. 0
end.
no__p=: ipos
name__p=: u: sname
type__p=: {.itype
prevpps__p=: lppsprev
nextpps__p=: lppsnext
dirpps__p=: ldirpps
time1st__p=: ratime1st
time2nd__p=: ratime2nd
startblock__p=: istart
size__p=: isize
data__p=: sdata
p
)

coclass 'olepps'
coinsert 'oleutlfcn'
ppstyperoot=: 5
ppstypedir=: 1
ppstypefile=: 2
datasizesmall=: 16b1000
longintsize=: 4
ppssize=: 16b80
child=: ''
adoptedchild=: ''
NB.  no
NB.  name
NB.  type
NB.  prevpps
NB.  nextpps
NB.  dirpps
NB.  time1st
NB.  time2nd
NB.  startblock
NB.  size
NB.  data
NB.  child
NB.  ppsfile

destroy=: 3 : 0
for_pps. child -. adoptedchild do. destroy__pps '' end.
codestroy ''
)

fputs=: 3 : 0
if. fileh-:'' do. data=: data, y else. fileh fappend~ y end.
)

NB. ---------------------------------------------------------
NB.  datalen
NB.  check for update
NB. ---------------------------------------------------------
datalen=: 3 : 0
if. '' -.@-: ppsfile do. fsize ppsfile return. end.
#data
)

NB. ---------------------------------------------------------
NB.  makesmalldata
NB. ---------------------------------------------------------
makesmalldata=: 3 : 0
'alist rhinfo'=. y
sres=. ''
ismblk=. 0
for_opps. alist do.
NB. 1. make sbd, small data string
  if. type__opps=ppstypefile do.
    if. size__opps <: 0 do. continue. end.
    if. size__opps < smallsize__rhinfo do.
      ismbcnt=. >. size__opps % smallblocksize__rhinfo
NB. 1.1 add to sbd
      for_i. i.ismbcnt-1 do.
        fputs__rhinfo toDWORD0 i+ismblk+1
      end.
      fputs__rhinfo toDWORD0 _2
NB. 1.2 add to data string  will be written for rootentry
NB. check for update
      if. '' -.@-: ppsfile__opps do.
        sres=. sres, ]`(''"_)@.(_1&-:)@:fread ppsfile__opps
      else.
        sres=. sres, data__opps
      end.
      if. size__opps |~ smallblocksize__rhinfo do.
        sres=. sres, ({.a.) #~ smallblocksize__rhinfo ([ - |) size__opps
      end.
NB. 1.3 set for pps
      startblock__opps=: ismblk
      ismblk=. ismblk + ismbcnt
    end.
  end.
end.
isbcnt=. <. bigblocksize__rhinfo % longintsize
if. ismblk |~ isbcnt do.
  fputs__rhinfo, (,:toDWORD0 _1) #~ isbcnt ([ - |) ismblk
end.
NB. 2. write sbd with adjusting length for block
sres
)

NB. ---------------------------------------------------------
NB.  saveppswk
NB. ---------------------------------------------------------
saveppswk=: 3 : 0
rhinfo=. y
NB. 1. write pps
z=. toucode0 name
z=. z, ({.a.)#~ 64-2*#name                         NB.   64
z=. z, toWORD0 2*1+#name                     NB.   66
z=. z, toBYTE type                                 NB.   67
z=. z, toBYTE 16b00 NB. uk                         NB.   68
z=. z, toDWORD0 prevpps NB. prev             NB.   72
z=. z, toDWORD0 nextpps NB. next             NB.   76
z=. z, toDWORD0 dirpps  NB. dir              NB.   80
z=. z, 0 9 2 0{a.                                  NB.   84
z=. z, 0 0 0 0{a.                                  NB.   88
z=. z, 16bc0 0 0 0{a.                              NB.   92
z=. z, 0 0 0 16b46{a.                              NB.   96
z=. z, 0 0 0 0{a.                                  NB.  100
z=. z, localdate2ole time1st                       NB.  108
z=. z, localdate2ole time2nd                       NB.  116
z=. z, toDWORD0 startblock                   NB.  120
z=. z, toDWORD0 size                         NB.  124
z=. z, toDWORD0 0                            NB.  128
fputs__rhinfo z
z
)

coclass 'oleppsdir'
coinsert 'olepps'
create=: 3 : 0
'sname ratime1st ratime2nd rachild'=. y
no=: 0
name=: u: sname
type=: ppstypedir
prevpps=: 0 ] _1
nextpps=: 0 ] _1
dirpps=: 0 ] _1
time1st=: ratime1st
time2nd=: ratime2nd
startblock=: 0
size=: 0
data=: ''
child=: rachild
adoptedchild=: rachild
fileh=: ''
ppsfile=: ''
)

coclass 'oleppsfile'
coinsert 'olepps'
create=: 3 : 0
'snm sdata sfile'=. y
no=: 0
name=: u: snm
type=: ppstypefile
prevpps=: 0 ] _1
nextpps=: 0 ] _1
dirpps=: 0 ] _1
time1st=: 0
time2nd=: 0
startblock=: 0
size=: 0
data=: >(''-:sfile) { sdata ; ''
child=: ''
fileh=: ''
ppsfile=: ''
if. '' -.@-: sfile do.
  if. 1 4 e.~ 3!:0 sfile do.
    ppsfile=: sfile
  elseif. do.
    fname=. sfile
    ferase <fname
    ppsfile=: fopen <fname
  end.
  if. #sdata do.
    ppsfile fappend~ sdata
  end.
end.
)

append=: 3 : 0
if. '' -.@-: ppsfile do.
  ppsfile fappend~ y
else.
  data=: data, y
end.
)

coclass 'oleppsroot'
coinsert 'olepps'
create=: 3 : 0
'ratime1st ratime2nd rachild'=. y
no=: 0
name=: u: 'Root Entry'
type=: ppstyperoot
prevpps=: 0 ] _1
nextpps=: 0 ] _1
dirpps=: 0 ] _1
time1st=: ratime1st
time2nd=: ratime2nd
startblock=: 0
size=: 0
data=: ''
child=: rachild
adoptedchild=: rachild
fileh=: ''
ppsfile=: ''
)

NB.  save  ole:
save=: 3 : 0
'sfile bnoas rhinfo'=. y
if. ''-:rhinfo do.
  rhinfo=. '' conew 'oleheaderinfo'
end.
bigblocksize__rhinfo=: <. 2&^ (0= bigblocksize__rhinfo) { (adjust2 bigblocksize__rhinfo), 9
smallblocksize__rhinfo=: <. 2&^ (0= smallblocksize__rhinfo) { (adjust2 smallblocksize__rhinfo), 6
smallsize__rhinfo=: 16b1000
ppssize__rhinfo=: 16b80
NB. 1.open file
NB. 1.1 sfile is ref of scalar
if. ''-:sfile do.
  fileh__rhinfo=: ''
elseif. 1 4 e.~ 3!:0 sfile do.
  fileh__rhinfo=: sfile
NB. 1.2 sfile is a simple filename string
elseif. do.
  ferase <sfile
  fileh__rhinfo=: fopen <sfile
end.
iblk=. 0
NB. 1. make an array of pps  for save
alist=. ''
list=. 18!:5 ''
if. bnoas do.
  alist=. 0{::saveppssetpnt2 list ; alist ; <rhinfo
else.
  alist=. 0{::saveppssetpnt list ; alist ; <rhinfo
end.
'isbdcnt ibbcnt ippscnt'=. calcsize alist ; <rhinfo
NB. 2.save header
saveheader rhinfo ; isbdcnt ; ibbcnt ; <ippscnt
NB. 3.make small data string  write sbd
ssmwk=. makesmalldata alist ; <rhinfo
data=: ssmwk  NB. small datas become rootentry data
NB. 4. write bb
ibblk=. isbdcnt
ibblk=. savebigdata ibblk ; alist ; <rhinfo
NB. 5. write pps
savepps alist ; <rhinfo
NB. 6. write bd and bdlist and adding header informations
savebbd isbdcnt ; ibbcnt ; ippscnt ; <rhinfo
NB. 7.close file
if. (''-.@-:sfile) *. -. 1 4 e.~ 3!:0 sfile do.
  fclose fileh__rhinfo
end.
if. ''-:sfile do.
  rc=. data__rhinfo
else.
  rc=. ''
end.
destroy__rhinfo ''
rc
)

NB.  calcsize
calcsize=: 3 : 0
'ralist rhinfo'=. y
NB. 0. calculate basic setting
isbdcnt=. 0
ibbcnt=. 0
ippscnt=. 0
ismalllen=. 0
isbcnt=. 0
for_opps. ralist do.
  if. type__opps=ppstypefile do.
    size__opps=: datalen__opps ''  NB. mod
    if. size__opps < smallsize__rhinfo do.
      isbcnt=. isbcnt + >.size__opps % smallblocksize__rhinfo
    else.
      ibbcnt=. ibbcnt + >.size__opps % bigblocksize__rhinfo
    end.
  end.
end.
ismalllen=. isbcnt * smallblocksize__rhinfo
islcnt=. <. bigblocksize__rhinfo % longintsize
isbdcnt=. >.isbcnt % islcnt
ibbcnt=. ibbcnt + >.ismalllen % bigblocksize__rhinfo
icnt=. #ralist
ibdcnt=. <.bigblocksize__rhinfo % ppssize
ippscnt=. >.icnt % ibdcnt
isbdcnt ; ibbcnt ; <ippscnt
)

NB.  adjust2
adjust2=: 3 : 0
>. 2^.y
)

NB.  saveheader
saveheader=: 3 : 0
'rhinfo isbdcnt ibbcnt ippscnt'=. y
NB. 0. calculate basic setting
iblcnt=. <.bigblocksize__rhinfo % longintsize
i1stbdl=. <.(bigblocksize__rhinfo - 16b4c) % longintsize
i1stbdmax=. (i1stbdl*iblcnt) - i1stbdl
ibdexl=. 0
iall=. ibbcnt + ippscnt + isbdcnt
iallw=. iall
ibdcntw=. >.iallw % iblcnt
ibdcnt=. >.(iall + ibdcntw) % iblcnt
NB. 0.1 calculate bd count
if. ibdcnt > 109 do.
  iblcnt=. <:iblcnt  NB. the blcnt is reduced in the count of the last sect is used for a pointer the next bl
  ibbleftover=. iall - i1stbdmax
  if. iall > i1stbdmax do.
    whilst. ibdcnt > >. ibbleftover % iblcnt do.
      ibdcnt=. >. ibbleftover % iblcnt
      ibdexl=. >. ibdcnt % iblcnt
      ibbleftover=. ibbleftover + ibdexl
    end.
  end.
  ibdcnt=. ibdcnt + i1stbdl
end.
NB. 1.save header
z=. 16bd0 16bcf 16b11 16be0 16ba1 16bb1 16b1a 16be1{a.
z=. z, 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0{a.
z=. z, toWORD0 16b3b
z=. z, toWORD0 16b03
z=. z, toWORD0 _2
z=. z, toWORD0 9
z=. z, toWORD0 6
z=. z, toWORD0 0
z=. z, 0 0 0 0 0 0 0 0 {a.
z=. z, toDWORD0 ibdcnt
z=. z, toDWORD0 ibbcnt+isbdcnt NB. root start
z=. z, toDWORD0 0
z=. z, toDWORD0 16b1000
z=. z, toDWORD0 (0=isbdcnt){0 _2    NB. small block depot
z=. z, toDWORD0 isbdcnt
NB. 2. extra bdlist start, count
if. ibdcnt < i1stbdl do.
  z=. z, toDWORD0 _2       NB. extra bdlist start
  z=. z, toDWORD0 0        NB. extra bdlist count
else.
  z=. z, toDWORD0 iall+ibdcnt
  z=. z, toDWORD0 ibdexl
end.
fputs__rhinfo z
NB. 3. bdlist
i=. 0
while. (i<i1stbdl) *. (i < ibdcnt) do.
  fputs__rhinfo toDWORD0 iall+i
  i=. >:i
end.
if. i<i1stbdl do.
  fputs__rhinfo, (,:toDWORD0 _1) #~ i1stbdl-i
end.
)

NB.  savebigdata
savebigdata=: 3 : 0
'istblk ralist rhinfo'=. y
ires=. 0
NB. 1.write big (ge 16b1000)  data into block
for_opps. ralist do.
  if. type__opps ~: ppstypedir do.
    size__opps=: datalen__opps ''   NB. mod
    if. ((size__opps >: smallsize__rhinfo) +. ((type__opps = ppstyperoot) *. 0~:#data__opps)) do.
NB. 1.1 write data
NB. check for update
      if. '' -.@-: ppsfile__opps do.
NB. check for update
        ilen=. #sbuff=. ]`(''"_)@.(_1&-:)@:fread ppsfile__opps
        fputs__rhinfo sbuff
      else.
        fputs__rhinfo data__opps
      end.
      if. size__opps |~ bigblocksize__rhinfo do.
NB.  todo: check, if strrepeat()  is binary safe
        fputs__rhinfo ({.a.) #~ bigblocksize__rhinfo ([ - |) size__opps
      end.
NB. 1.2 set for pps
      startblock__opps=: istblk
      istblk=. istblk + >.size__opps % bigblocksize__rhinfo
    end.
  end.
end.
istblk
)

NB.  savepps
savepps=: 3 : 0
'ralist rhinfo'=. y
NB. 0. initial
NB. 2. save pps
for_pps. ralist do. saveppswk__pps rhinfo end.
NB. 3. adjust for block
icnt=. #ralist
ibcnt=. <.bigblocksize__rhinfo % ppssize__rhinfo
if. (icnt |~ ibcnt) do.
  fputs__rhinfo ({.a.) #~ (ibcnt ([ - |) icnt) * ppssize__rhinfo
end.
>.icnt % ibcnt
)

NB.  saveppssetpnt2
NB.   for test
saveppssetpnt2=: 3 : 0
'athis ralist rhinfo'=. y
NB. 1. make array as children-relations
NB. 1.1 if no children
if. ''-:athis do. ralist ; _1 return.
elseif. 1=#athis do.
NB. 1.2 just only one
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. 0{::ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: _1{::ra
  ralist ; no__l return.
elseif. do.
NB. 1.3 array
  icnt=. #athis
NB. 1.3.1 define center
  ipos=. 0 NB. int(icnt% 2)
  awk=. athis
  if. (#athis) > 2 do.
    aprev=. 1{awk
    anext=. 2}.awk
  else.
    aprev=. ''
    anext=. }.awk
  end.
  l=. ipos{athis
  ralist=. 0{::ra=. saveppssetpnt2 aprev ; ralist ; <rhinfo
  prevpps__l=: _1{::ra
  ralist= ralist, l
  no__l=: (#ralist) -1
NB. 1.3.2 devide a array into previous, next
  ralist=. 0{::ra=. saveppssetpnt2 anext ; ralist ; <rhinfo
  nextpps__l=: _1{::ra
  ralist=. 0{::ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: _1{::ra
  ralist ; no__l return.
end.
)

NB.  saveppssetpnt2
NB.   for test
saveppssetpnt2s=: 3 : 0
'athis ralist rhinfo'=. y
NB. 1. make array as children-relations
NB. 1.1 if no children
if. (0:=#) athis do. ralist ; _1 return.
elseif. (#athis) =1 do.
NB. 1.2 just only one
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. 0{::ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: _1{::ra
  ralist ; no__l return.
elseif. do.
NB. 1.3 array
  icnt=. #athis
NB. 1.3.1 define center
  ipos=. 0 NB. int(icnt% 2)
  ralist=. ralist, l=. ipos{athis
  no__l=: (#ralist) -1
  awk=. athis
NB. 1.3.2 devide a array into previous, next
  aprev=. ipos{.awk
  anext=. (1+ipos)}.awk
  ralist=. 0{::ra=. saveppssetpnt2 aprev ; ralist ; <rhinfo
  prevpps__l=: _1{::ra
  ralist=. 0{::ra=. saveppssetpnt2 anext ; ralist ; <rhinfo
  nextpps__l=: _1{::ra
  ralist=. 0{::ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: _1{::ra
  ralist ; no__l return.
end.
)

NB.  saveppssetpnt
saveppssetpnt=: 3 : 0
'athis ralist rhinfo'=. y
NB. 1. make array as children-relations
NB. 1.1 if no children
if. (0:=#) athis do. ralist ; _1 return.
elseif. (#athis) =1 do.
NB. 1.2 just only one
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. 0{::ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: _1{::ra
  ralist ; no__l return.
elseif. do.
NB. 1.3 array
  icnt=. #athis
NB. 1.3.1 define center
  ipos=. <.icnt % 2
  ralist=. ralist, l=. ipos{athis
  no__l=: (#ralist) -1
  awk=. athis
NB. 1.3.2 devide a array into previous, next
  aprev=. ipos{.awk
  anext=. (1+ipos)}.awk
  ralist=. 0{::ra=. saveppssetpnt aprev ; ralist ; <rhinfo
  prevpps__l=: _1{::ra
  ralist=. 0{::ra=. saveppssetpnt anext ; ralist ; <rhinfo
  nextpps__l=: _1{::ra
  ralist=. 0{::ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: _1{::ra
  ralist ; no__l return.
end.
)

NB.  saveppssetpnt
saveppssetpnt1=: 3 : 0
'athis ralist rhinfo'=. y
NB. 1. make array as children-relations
NB. 1.1 if no children
if. (0:=#) athis do. ralist ; _1 return.
elseif. (#athis) =1 do.
NB. 1.2 just only one
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. 0{::ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: _1{::ra
  ralist ; no__l return.
elseif. do.
NB. 1.3 array
  icnt=. #athis
NB. 1.3.1 define center
  ipos=. <.icnt % 2
  ralist=. ralist, l=. ipos{athis
  no__l=: (#ralist) -1
  awk=. athis
NB. 1.3.2 devide a array into previous, next
  aprev=. ipos{.awk
  anext=. (1+ipos)}.awk
  ralist=. 0{::ra=. saveppssetpnt aprev ; ralist ; <rhinfo
  prevpps__l=: _1{::ra
  ralist=. 0{::ra=. saveppssetpnt anext ; ralist ; <rhinfo
  nextpps__l=: _1{::ra
  ralist=. 0{::ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: _1{::ra
  ralist ; no__l return.
end.
)

NB.  savebbd
savebbd=: 3 : 0
'isbdsize ibsize ippscnt rhinfo'=. y
NB. 0. calculate basic setting
ibbcnt=. <.bigblocksize__rhinfo % longintsize
i1stbdl=. <.(bigblocksize__rhinfo - 16b4c) % longintsize
ibdexl=. 0
iall=. ibsize + ippscnt + isbdsize
iallw=. iall
ibdcntw=. >.iallw % ibbcnt
ibdcnt=. >.(iall + ibdcntw) % ibbcnt
NB. 0.1 calculate bd count
if. ibdcnt >i1stbdl do.
NB.  todo: do-while correct here?
  whilst. ibdcnt > i1stbdl+ibdexl*ibbcnt do.
    ibdexl=. >:ibdexl
    iallw=. >:iallw
    ibdcntw=. >.iallw % ibbcnt
    ibdcnt=. >.(iallw + ibdcntw) % ibbcnt
  end.
end.
NB. 1. making bd
NB. 1.1 set for sbd
if. isbdsize > 0 do.
  for_i. i.(isbdsize-1) do.
    fputs__rhinfo toDWORD0 i+1
  end.
  fputs__rhinfo toDWORD0 _2
end.
NB. 1.2 set for b
for_i. i.(ibsize-1) do.
  fputs__rhinfo toDWORD0 i+isbdsize+1
end.
fputs__rhinfo toDWORD0 _2
NB. 1.3 set for pps
for_i. i.(ippscnt-1) do.
  fputs__rhinfo toDWORD0 i+isbdsize+ibsize+1
end.
fputs__rhinfo toDWORD0 _2
NB. 1.4 set for bbd itself  _3 : bbd
for_i. i.ibdcnt do.
  fputs__rhinfo toDWORD0 _3
end.
NB. 1.5 set for extrabdlist
for_i. i.ibdexl do.
  fputs__rhinfo toDWORD0 _4
end.
NB. 1.6 adjust for block
if. ((iallw + ibdcnt) |~ ibbcnt) do.
  fputs__rhinfo, (,:toDWORD0 _1) #~ ibbcnt ([ - |) (iallw + ibdcnt)
end.
NB. 2.extra bdlist
if. (ibdcnt > i1stbdl) do.
  in=. 0
  inb=. 0
  i=. i1stbdl
  while. i<ibdcnt do.
    if. (in>: (ibbcnt-1)) do.
      in=. 0
      inb=. >:inb
      fputs__rhinfo toDWORD0 iall+ibdcnt+inb
    end.
    fputs__rhinfo toDWORD0 ibsize+isbdsize+ippscnt+i
    i=. >:i
    in=. >:in
  end.
  if. ((ibdcnt-i1stbdl) |~ (ibbcnt-1)) do.
    fputs__rhinfo, (,:toDWORD0 _1) #~ (ibbcnt-1) ([ - |) (ibdcnt-i1stbdl)
  end.
  fputs__rhinfo toDWORD0 _2
end.
)

NB. ---------------------------------------------------------
NB. package for biff format
coclass 'biff'
coinsert 'oleutlfcn'
shortdatefmt=: 'dd/mm/yyyy'
NB. inflate file size to make xls2csv happy
IFBIGBLOCK_PADDING=: 1
RECORDLEN=: 8224   NB. BIFF5: 2080 bytes, BIFF8: 8224 bytes
NB. Excel version BIFF version Document type File type
NB. Excel 2.1 BIFF2 Worksheet Stream
NB. Excel 3.0 BIFF3 Worksheet Stream
NB. Excel 4.0 BIFF4S Worksheet Stream
NB. Excel 4.0 BIFF4W Workbook Stream
NB. Excel 5.0 BIFF5 Workbook Compound Document
NB. Excel 7.0 (Excel 95) BIFF7 Workbook Compound Document
NB. Excel 8.0 (Excel 97) BIFF8 Workbook Compound Document
NB. Excel 9.0 (Excel 2000) BIFF8 Workbook Compound Document
NB. Excel 10.0 (Excel XP) BIFF8X Workbook Compound Document
NB. Excel 11.0 (Excel 2003) BIFF8X Workbook Compound Document
NB. Index     Format String
NB. ---------------------------------------------------------
NB. 0 General General
NB. 1 Decimal 0
NB. 2 Decimal 0.00
NB. 3 Decimal #,##0
NB. 4 Decimal #,##0.00
NB. 5 Currency "$"#,##0_); ("$"#,##0)
NB. 6 Currency "$"#,##0_);[Red] ("$"#,##0)
NB. 7 Currency "$"#,##0.00_); ("$"#,##0.00)
NB. 8 Currency "$"#,##0.00_);[Red] ("$"#,##0.00)
NB. 9 Percent 0%
NB. 10 Percent 0.00%
NB. 11 Scientific 0.00E+00
NB. 12 Fraction # ?/?
NB. 13 Fraction # ??/??
NB. 14 Date M/D/YY
NB. 15 Date D-MMM-YY
NB. 16 Date D-MMM
NB. 17 Date MMM-YY
NB. 18 Time h:mm AM/PM
NB. 19 Time h:mm:ss AM/PM
NB. 20 Time h:mm
NB. 21 Time h:mm:ss
NB. 22 Date/Time M/D/YY h:mm
NB. 37 Account. _(#,##0_);(#,##0)
NB. 38 Account. _(#,##0_);[Red](#,##0)
NB. 39 Account. _(#,##0.00_);(#,##0.00)
NB. 40 Account. _(#,##0.00_);[Red](#,##0.00)
NB. 41 Currency _ ("$"* #,##0_);_ ("$"* (#,##0);_ ("$"* "-"_);_(@_)
NB. 42 Currency _(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)
NB. 43 Currency _ ("$"* #,##0.00_);_ ("$"* (#,##0.00);_ ("$"* "-"??_);_(@_)
NB. 44 Currency _(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)
NB. 45 Time mm:ss
NB. 46 Time [h]:mm:ss
NB. 47 Time mm:ss.0
NB. 48 Scientific ##0.0E+0
NB. 49 Text @
format0n=: 164  NB. reserved by excel
colorset0n=: 8   NB. reserved by excel
colorborder=: 16b40
colorpattern=: 16b41
colorfont=: 16b7fff
NB. for debug
DEBUG=: 1

NB. cell ref 'AA5' => 4 26
A1toRC=: 3 : 0
assert. y e. '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
(<: 26 #. ' ABCDEFGHIJKLMNOPQRSTUVWXYZ'&i. _5&{. c),~ <: 1&". y -. c=. y -. '0123456789'
)

toHeader=: toWORD0
UString=: 3 : 0
toucode0 u: y
)

SString=: 3 : 0
(1&u: ::]) y
)

toString=: 3 : 0
if. 131072= 3!:0 y do.
  toucode0 y
else.
  y
end.
)

toUString8=: 3 : 0
if. 131072= 3!:0 y do.
  (a.{~#y), (1{a.), toucode0 y
else.
  (a.{~#y), (0{a.), y
end.
)

toUString16=: 3 : 0
if. 131072= 3!:0 y do.
  (toWORD0 #y), (1{a.), toucode0 y
else.
  (toWORD0 #y), (0{a.), y
end.
)

toUString=: 3 : 0
if. 131072= 3!:0 y do.
  (1{a.), toucode0 y
else.
  (0{a.), y
end.
)

toStream=: 4 : 0
x fappend~ y
)

sulen8=: 3 : 0
if. 131072= 3!:0 y do.
  2+2*#y
else.
  2+#y
end.
)

sulen16=: 3 : 0
if. 131072= 3!:0 y do.
  3+2*#y
else.
  3+#y
end.
)

NB. enum constants
cellborder_no_line=: 0
cellborder_thin=: 1
cellborder_medium=: 2
cellborder_dashed=: 3
cellborder_dotted=: 4
cellborder_thick=: 5
cellborder_double=: 6
cellborder_hair=: 7
cellborder_medium_dashed=: 8
cellborder_thin_dash_dotted=: 9
cellborder_medium_dash_dotted=: 10
cellborder_thin_dash_dot_dotted=: 11
cellborder_medium_dash_dot_dotted=: 12
cellborder_slanted_medium_dash_dotted=: 13

NB. ---------------------------------------------------------

coinstance=: {. @ (18!:2 & boxxopen)

NB. utility for writing continue record
NB. biffappend
NB.
NB. General storage function
NB.

biffappend=: 3 : 0

0 biffappend y
:

if. RECORDLEN < #y do. x add_continue y else. y end.
)

NB. add_continue
NB.
NB. Excel limits the size of BIFF records. In Excel 5 the limit is 2084 bytes. In
NB. Excel 97 the limit is 8228 bytes. Records that are longer than these limits
NB. must be split up into CONTINUE blocks.
NB.
NB. This function take a long BIFF record and inserts CONTINUE records as
NB. necessary.
NB.
NB. Some records have their own specialised Continue blocks so there is also an
NB. option to bypass this function.
NB.
add_continue=: 4 : 0

data=. y
recordtype=. 16b003c NB. Record identifier

NB. Skip this if another method handles the continue blocks.
if. x do. data return. end.

NB. The first 2080/8224 bytes remain intact. However, we have to change
NB. the length field of the record.
data=. RECORDLEN}.data [ tmp=. RECORDLEN{.data
tmp=. (toWORD0 RECORDLEN-4) 2 3}tmp

NB. Strip out chunks of 2080/8224 bytes +4 for the header.
while. RECORDLEN < #data do.
  tmp=. tmp, (RECORDLEN{.data),~ toHeader recordtype, RECORDLEN
  data=. RECORDLEN}.data
end.

NB. Mop up the last of the data
tmp=. tmp, data,~ toHeader recordtype, #data
)

NB. extend crc32 to 16 bytes to simulate md4
biffcrc32=: 3 : 0

2&(3!:4) 4# (128!:3) y
)

biffmd4=: 3 : 0

md5bin_crypt_ y
)

NB. add_mso_generic
NB.
NB. Create a mso structure that is part of an Escher drawing object. These are
NB. are used for images, comments and filters. This generic method is used by
NB. other methods to create specific mso records.
NB.
NB. Returns the packed record.
NB.
add_mso_generic=: 4 : 0

data=. x
'type version instance length'=. y

NB. The header contains version and instance info packed into 2 bytes.
header=. version (23 b.) 4 (33 b.) instance

record=. toWORD0 header, type
record=. record, toDWORD0 length
record, data
)

NB. ---------------------------------------------------------

NB. biff record
NB. a formula which was array-entered into a range of cells
biff_array=: 3 : 0
'range recalc parsedexpr'=. y
'firstrow lastrow firstcol lastcol'=. range
recordtype=. 16b0221
z=. ''
z=. z, toWORD0 firstrow
z=. z, toWORD0 lastrow
z=. z, toBYTE firstcol
z=. z, toBYTE lastcol
z=. z, toWORD0 recalc
z=. z, toDWORD0 0
z=. z, toWORD0 #parsedexpr
z=. z, SString parsedexpr
z=. z,~ toHeader recordtype, #z
)

NB. Should Excel make a backup of this XLS sheet?
biff_backup=: 3 : 0
recordtype=. 16b0040
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. a cell with no formula or value
biff_blank=: 4 : 0
recordtype=. 16b0201
y=. >y
assert. 2=#y
z=. ''
z=. z, toWORD0 y
z=. z, toWORD0 x
z=. z,~ toHeader recordtype, #z
)

NB. set the Beginning of File marker
NB.  version = Excel version   default is biff8 (97-2003)
NB.  docn = Excel document type   default is worksheet
biff_bof=: 3 : 0
'version docn'=. y
recordtype=. 16b809
z=. ''
z=. z, toWORD0 version
z=. z, toWORD0 docn
z=. z, toWORD0 8111   NB. built id
z=. z, toWORD0 1997   NB. built year
z=. z, toDWORD0 16b40c1
z=. z, toDWORD0 16b106
z=. z,~ toHeader recordtype, #z
)

biff_bookbool=: 3 : 0
recordtype=. 16b00da
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. a cell with a constant boolean OR error
NB. boolerrvalue = boolean or error value
NB. boolORerr = specifies a boolean or error   1 =. error, 0 =. boolean
biff_boolerr=: 4 : 0
'rowcol boolerrvalue boolORerr'=. y
recordtype=. 16b0205
z=. ''
z=. z, toWORD0 rowcol
z=. z, toWORD0 x
z=. z, toBYTE boolerrvalue
z=. z, toBYTE boolORerr
z=. z,~ toHeader recordtype, #z
)

NB. set the bottom margin, used when printing, in inches
NB. 8-byte IEEE floating point format
biff_bottommargin=: 3 : 0
recordtype=. 16b0029
z=. ''
z=. z, toDouble0 y
z=. z,~ toHeader recordtype, #z
)

biff_boundsheet=: 3 : 0
'offset visible type sheetname'=. y
recordtype=. 16b85
z=. ''
z=. z, toDWORD0 offset
z=. z, toBYTE visible
z=. z, toBYTE type
z=. z, toUString8 sheetname
z=. z,~ toHeader recordtype, #z
)

NB. set the iteration count as set in Options->Calculation
biff_calccount=: 3 : 0
recordtype=. 16b000c
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

NB. set the calculation mode
biff_calcmode=: 3 : 0
recordtype=. 13
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

biff_codepage=: 3 : 0
recordtype=. 16b0042
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

biff_colinfo=: 4 : 0
'col1 col2 width hide level collapse'=. y
recordtype=. 16b007d
z=. ''
z=. z, toWORD0 col1, col2, width, x
z=. z, toWORD0 hide bitor 8 bitshl level bitor 4 bitshl collapse
z=. z, toWORD0 0
z=. z,~ toHeader recordtype, #z
)

NB. set the default cell attributes for those cells which aren't
NB. defined
biff_columndefault=: 3 : 0
recordtype=. 16b0020
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

NB. a continuation of a formula too long to fit into one cell
biff_continue=: 3 : 0
recordtype=. 16b003c
z=. ''
z=. z, toString y
z=. z,~ toHeader recordtype, #z
)

biff_country=: 3 : 0
recordtype=. 16b008c
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

biff_crn=: 3 : 0
recordtype=. 16b005a
z=. ''
z=. z, SString y
z=. z,~ toHeader recordtype, #z
)

NB. Specify the date system used in the XLS worksheet
biff_date1904=: 3 : 0
recordtype=. 16b0022
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. width is in character
biff_defaultcolwidth=: 3 : 0
recordtype=. 16b0055
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

NB. the row height of all undefined rows
NB. does not affect explicitly defined rows
NB. height is in increments of 1/20th of a point
biff_defaultrowheight=: 3 : 0
'notmatch hidden spaceabove spacebelow height'=. y
recordtype=. 16b0225
z=. ''
z=. z, toWORD0 bitor (0~:notmatch) bitor 1 bitshl (0~:hidden) bitor 1 bitshl (0~:spaceabove) bitor 1 bitshl (0~:spacebelow)
z=. z, toWORD0 height
z=. z,~ toHeader recordtype, #z
)

NB. set the maximum change for an interative record
biff_delta=: 3 : 0
recordtype=. 16b0010
z=. ''
z=. z, toDouble0 y
z=. z,~ toHeader recordtype, #z
)

NB. the minimum and maximum bounds of the worksheet
NB. the last row and column are numbered one higher than
NB. the last occupied row/column
biff_dimensions=: 3 : 0
recordtype=. 16b0200
z=. ''
z=. z, toDWORD0 0 1+0 1{y
z=. z, toWORD0 0 1+2 3{y
z=. z, toWORD0 0
z=. z,~ toHeader recordtype, #z
)

NB. set the EOF record
biff_eof=: 3 : 0
recordtype=. 16b000a
z=. ''
z=. z,~ toHeader recordtype, #z
)

biff_externname=: 4 : 0
recordtype=. 16b0023
z=. ''
if. 'external'-:x do.
  'builtin sheetidx name formula'
  z=. z, toWORD0 0~:builtin
  z=. z, toWORD0 >:sheetidx
  z=. z, toWORD0 0
  z=. z, toUString8 name
  z=. z, SString formula
elseif. 'internal'-:x do.
  'unhandled exception' 13!:8 (3)
elseif. 'addin'-:x do.
  z=. z, toWORD0 0
  z=. z, toDWORD0 0
  z=. z, toUString8 y
  z=. z, SString a.{~2 0 16b1c 16b17
elseif. 'dde'-:x do.
  'automatic stddoc clip item'=. y
  if. 0~:stddoc do. clip=. 16bfff end.
  z=. z, toWORD0 1 bitshl (0~:automatic) bitand 1 bitshl (0~:stddoc) bitand 2 bitshl clip
  z=. z, toDWORD0 0
  z=. z, toUString8 item
elseif. 'ole'-:x do.
  'automatic storage'=. y
  z=. z, toWORD0 1 bitshl (0~:automatic)
  z=. z, toDWORD0 storage
  z=. z, SString a.{~1 0 16b27
elseif. do.
  'unhandled exception' 13!:8 (3)
end.
z=. z,~ toHeader recordtype, #z
)

biff_externsheet=: 3 : 0
recordtype=. 16b0017
z=. ''
z=. z, toWORD0 #y
for_yi. y do.
  z=. z, toWORD0 yi
end.
z=. z,~ toHeader recordtype, #z
)

NB. describes an entry in Excels font table
NB.  height of the font in 1/20 of a point increments
biff_font=: 3 : 0
recordtype=. 16b0031
z=. ''
'height italic strikeout color weight script underline family charset fontname'=. y
z=. z, toWORD0 height
z=. z, toWORD0 (1 bitshl 0~:italic) bitor (3 bitshl 0~:strikeout)
z=. z, toWORD0 color
z=. z, toWORD0 weight
z=. z, toWORD0 script
z=. z, toBYTE underline
z=. z, toBYTE family
z=. z, toBYTE charset
z=. z, toBYTE 0
z=. z, toUString8 fontname
z=. z,~ toHeader recordtype, #z
)

NB. sepcify the footer for the worksheet
biff_footer=: 3 : 0
recordtype=. 16b0015
z=. ''
if. #y do.
  z=. z, toUString16 y
end.
z=. z,~ toHeader recordtype, #z
)

NB. describes a cell format
biff_format=: 3 : 0
'num str'=. y
recordtype=. 16b041e
z=. ''
z=. z, toWORD0 num
z=. z, toUString16 str
z=. z,~ toHeader recordtype, #z
)

NB. a cell with a formula
NB.  value = current value of the formula
NB.  recalc = should the cell be recalculated on XLS load?
NB.  exprlength = length of parsed expression
NB.  pasedexpr = parsed expression
biff_formula=: 4 : 0
'rowcol value recalc calcopen shared parsedexpr'=. y
recordtype=. 16b0006
z=. ''
z=. z, toWORD0 rowcol
z=. z, toWORD0 x
z=. z, SString 8{.value
z=. z, toWORD0 (0~:recalc) bitor 1 bitshl 1 (0~:calcopen) bitor 1 bitshl 1 (0~:shared)
z=. z, toDWORD0 0
z=. z, toWORD0 #parsedexpr
z=. z, SString parsedexpr
z=. z,~ toHeader recordtype, #z
)

biff_gridset=: 3 : 0
recordtype=. 16b0082
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

biff_guts=: 3 : 0
recordtype=. 16b0080
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

biff_hcenter=: 3 : 0
recordtype=. 16b0083
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. specify the header for the worksheet
biff_header=: 3 : 0
recordtype=. 16b0014
z=. ''
if. #y do.
  z=. z, toUString16 y
end.
z=. z,~ toHeader recordtype, #z
)

biff_hideobj=: 3 : 0
recordtype=. 16b008d
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

biff_hlink=: 3 : 0
recordtype=. 16b01b8
z=. ''
NB. 'url'       'linktype rowcols link dummy dummy   textmark target description'
NB. 'local'     'linktype rowcols link elink uplevel textmark target description'
NB. 'unc'       'linktype rowcols link dummy dummy   textmark target description'
NB. 'worksheet' 'linktype rowcols dummy dummy dummy  textmark target description'

'linktype rowcols link elink uplevel textmark target description'=. y
bit8=. bit7=. bit6=. bit5=. bit4=. bit3=. bit2=. bit1=. bit0=. 0
if. #target do. bit7=. 1 end.
if. #description do. bit2=. bit4=. 1 end.
if. #textmark do. bit3=. 1
elseif. 'worksheet'-:linktype do.
  'unhandled exception' 13!:8 (3)
end.
if. ('worksheet'-:linktype) *. (':'e.link) do. bit1=. 1 end.
if. 'url'-:linktype do. bit0=. bit1=. 1
elseif. 'local'-:linktype do. bit0=. 1
elseif. 'unc'-:linktype do. bit0=. bit1=. bit8=. 1
elseif. 'worksheet'-:linktype do. bit3=. 1
end.
flag=. #. bit8, bit7, bit6, bit5, bit4, bit3, bit2, bit1, bit0
z=. z, toWORD0 rowcols  NB. rowcols is row1 row2 col1 col2
z=. z, SString a.{~16bd0 16bc9 16bea 16b79 16bf9 16bba 16bce 16b11 16b8c 16b82 16b00 16baa 16b00 16b4b 16ba9 16b0b
z=. z, toDWORD0 2
z=. z, toDWORD0 flag
if. #description do.
  z=. z, toDWORD0 1+#description
  z=. z, UString description,{.a.
end.
if. #target do.
  z=. z, toDWORD0 1+#target
  z=. z, UString target,{.a.
end.
if. 'url'-:linktype do.
  z=. z, SString a.{~16be0 16bc9 16bea 16b79 16bf9 16bba 16bce 16b11 16b8c 16b82 16b00 16baa 16b00 16b4b 16ba9 16b0b
  z=. z, toDWORD0 2*1+#link
  z=. z, UString link,{.a.
elseif. 'local'-:linktype do.
  z=. z, SString a.{~16b03 16b03 16b00 16b00 16b00 16b00 16b00 16b00 16bc0 16b00 16b00 16b00 16b00 16b00 16b00 16b46
  z=. z, toWORD0 uplevel
  z=. z, toDWORD0 1+#link
  z=. z, SString link,{.a.
  z=. z, SString a.{~16bff 16bff 16bad 16bde, 20#0
  if. #elink do.
    z=. z, toDWORD0 10+2*#elink
    z=. z, toDWORD0 2*#elink
    z=. z, SString a.{~16b03 16b00
    z=. z, UString elink
  else.
    z=. z, toDWORD0 0
  end.
elseif. 'unc'-:linktype do.
  z=. z, SString a.{~16be0 16bc9 16bea 16b79 16bf9 16bba 16bce 16b11 16b8c 16b82 16b00 16baa 16b00 16b4b 16ba9 16b0b
  z=. z, toDWORD0 1+#link
  z=. z, UString link,{.a.
elseif. 'worksheet'-:linktype do.
  ''  NB. only textmark present
end.
if. #textmark do.
  z=. z, toDWORD0 1+#textmark
  z=. z, UString textmark,{.a.
end.
z=. z,~ toHeader recordtype, #z
)

NB. a list of explicit row page breaks
biff_horizontalpagebreaks=: 3 : 0
recordtype=. 16b001b
z=. ''
z=. z, toWORD0 #y
for_iy. y do. z=. z, toWORD0 iy end.
z=. z,~ toHeader recordtype, #z
)

biff_index=: 3 : 0
recordtype=. 16b020b
z=. ''
z=. z, toDWORD0 0
z=. z, toDWORD0 y
z=. z,~ toHeader recordtype, #z
)

NB. a cell containing a 14-bit signed integer, biff8 use RK value to store integer
NB. negative numbers and those outside this range are to
NB. be held in a NUMBER cell
biff_integer=: 4 : 0
assert. 2=#y
assert. 2=# 0{::y
assert. 1 4 8 e.~ (3!:0) 1{::y
recordtype=. 16b027e
z=. ''
z=. z, toWORD0 0{::y
z=. z, toWORD0 x
z=. z, toDWORD0 2b10 bitor 2 bitshl <. 1{::y
z=. z,~ toHeader recordtype, #z
)

NB. set the state of iteration
biff_iteration=: 3 : 0
recordtype=. 16b0011
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

NB. cell with a constant string of length
biff_label=: 4 : 0
assert. 2=#y
assert. 2=# 0{::y
assert. 2 131072 e.~ (3!:0) 1{::y
if. ''-:, 1{::y do.
  x biff_blank {.y
else.
  recordtype=. 16b00fd
  z=. ''
  z=. z, toWORD0 0{::y
  z=. z, toWORD0 x
  z=. z, toDWORD0 add2sst ,&.> 1{y
  z=. z,~ toHeader recordtype, #z
end.
)

biff_labelranges=: 3 : 0
'row col'=. y
if. 0=(#row)+#col do. '' return. end.
recordtype=. 16b015f
z=. ''
z=. z, toWORD0 #row
for_iy. row do. z=. z, toWORD0 iy end.
z=. z, toWORD0 #col
for_iy. col do. z=. z, toWORD0 iy end.
z=. z,~ toHeader recordtype, #z
)

NB. set the left margin, used when printing, in inches
NB. 8-byte IEEE floating point format
biff_leftmargin=: 3 : 0
recordtype=. 16b0026
z=. ''
z=. z, toDouble0 y
z=. z,~ toHeader recordtype, #z
)

biff_mergedcells=: 3 : 0
if. (0:=#) y do. '' return. end.
recordtype=. 16b00e5
z=. ''
z=. z, toWORD0 #y
for_iy. y do. z=. z, toWORD0 iy end.
z=. z,~ toHeader recordtype, #z
)

biff_name=: 3 : 0
recordtype=. 16b0018
z=. ''
'hidden function command macro complex builtin functiongroup binaryname keybd name formula sheet menu description helptopic statusbar'=. y
flag=. (0~:hidden) bitor 1 bitshl (0~:function) bitor 1 bitshl (0~:command) bitor 1 bitshl (0~:macro) bitor 1 bitshl (0~:complex) bitor 1 bitshl (0~:builtin) bitor 1 bitshl functiongroup bitor 6 bitshl binaryname
z=. z, toWORD0 flag
z=. z, toBYTE keybd
z=. z, toBYTE #name
z=. z, toWORD0 #formula
z=. z, toWORD0 0
z=. z, toWORD0 >:sheet
z=. z, toBYTE #menu
z=. z, toBYTE #description
z=. z, toBYTE #helptopic
z=. z, toBYTE #statusbar
z=. z, toUString name
z=. z, SString formula
if. #menu do. z=. z, toUString menu end.
if. #description do. z=. z, toUString description end.
if. #helptopic do. z=. z, toUString helptopic end.
if. #statusbar do. z=. z, toUString statusbar end.
z=. z,~ toHeader recordtype, #z
)

NB. a cell containing a constant floating point number
NB. IEEE 8-byte floating point format
biff_number=: 4 : 0
assert. 2=#y
assert. 2=# 0{::y
assert. 1 4 8 e.~ (3!:0) 1{::y
recordtype=. 16b0203
z=. ''
z=. z, toWORD0 0{::y
z=. z, toWORD0 x
z=. z, toDouble0 1{::y
z=. z,~ toHeader recordtype, #z
)

NB. workbook/worksheet object protection
biff_objectprotect=: 3 : 0
recordtype=. 16b0063
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

biff_palette=: 3 : 0
recordtype=. 16b0092
z=. ''
z=. z, toWORD0 #y
z=. z, toDWORD0 y
z=. z,~ toHeader recordtype, #z
)

NB. number and position of panes in a window
biff_pane=: 3 : 0
recordtype=. 16b0041
z=. ''
'split vis activepane'=. y
z=. z, toWORD0 split   NB. xsplit ysplit
z=. z, toWORD0 vis     NB. topvis leftvis
for_pane. activepane do. z=. z, toWORD0 pane end.
z=. z,~ toHeader recordtype, #z
)

NB. worksheet/workbook protection (.5.18). It stores a 16-bit hash value,
biff_password=: 3 : 0
recordtype=. 16b0013
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

NB. set the precision as set in Option->Calculation
biff_precision=: 3 : 0
recordtype=. 16b000e
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. Print Gridlines when printing?
biff_printgridlines=: 3 : 0
recordtype=. 16b002b
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. Shall Excel print the row 'n column headers
biff_printheaders=: 3 : 0
recordtype=. 16b002a
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. workbook/worksheet cell content protection
biff_protect=: 3 : 0
recordtype=. 16b0012
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. This record contains the cell range and text for a tool tip.
NB. It occurs in conjunction with the HLINK record for hyperlinks in the Hyperlink Table.
NB. This feature is only available in Excel 9.0 (Excel 2000) and later.
biff_quicktip=: 3 : 0
recordtype=. 16b0800
z=. ''
'rowcols description'=. y
z=. z, toWORD0 rowcols  NB. rowcols is row1 row2 col1 col2
z=. z, UString description,{.a.
z=. z,~ toHeader recordtype, #z
)

NB. set the cell reference mode as in Options->Desktop
NB. sets the cell reference mode to
NB. <letter><number>   like A1 or C3 -- you sank my battleship
NB.    OR
NB. R<number>C<number>   y'know R1C1 = row 1 col 1
biff_refmode=: 3 : 0
recordtype=. 16b000f
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. set the right margin, used when printing, in inches
NB. 8-byte IEEE floating point format
biff_rightmargin=: 3 : 0
recordtype=. 16b0027
z=. ''
z=. z, toDouble0 y
z=. z,~ toHeader recordtype, #z
)

NB. a row descriptor needs the follwing ingredients
biff_row=: 4 : 0
xf=. x
'rownumber firstcol lastcol usedefaultheight rowheight heightnotmatch spaceabove spacebelow hidden explicitformat outlinelevel outlinegroup'=. y
recordtype=. 16b0208
z=. ''
z=. z, toWORD0 rownumber
z=. z, toWORD0 firstcol
z=. z, toWORD0 lastcol
z=. z, toWORD0 (16b7fff bitand rowheight) bitor 15 bitshl 0~:usedefaultheight
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toDWORD0 (16b7 bitand outlinelevel) bitor 4 bitshl (0~:outlinegroup) bitor 1 bitshl (0~:hidden) bitor 1 bitshl (0~:heightnotmatch) bitor 1 bitshl (0~:explicitformat) bitor 1 bitshl 1 bitor 8 bitshl (16bfff bitand xf) bitor 12 bitshl (0~:spaceabove) bitor 1 bitshl 0~:spacebelow
z=. z,~ toHeader recordtype, #z
)

NB. workbook/worksheet scenarios protection
biff_scenprotect=: 3 : 0
recordtype=. 16b00dd
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

biff_scl=: 3 : 0
recordtype=. 16b00a0
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

NB. sets the cells which are selected in a pane
NB. not implemented yet
biff_selection=: 3 : 0
recordtype=. 16b001d
z=. ''
'panenum row col refnum refs'=. y
z=. z, toBYTE panenum
z=. z, toWORD0 row
z=. z, toWORD0 col
z=. z, toWORD0 refnum
z=. z, toWORD0 #refs
for_i. i.#refs do.
  z=. z, toWORD0 2{.>i{refs
  z=. z, toBYTE 2}.>i{refs
end.
z=. z,~ toHeader recordtype, #z
)

biff_setup=: 3 : 0
recordtype=. 16b00a1
z=. ''
'setuppapersize setupscaling setupstartpage setupfitwidth setupfitheight setuprowmajor setupportrait setupinvalid setupblackwhite setupdraft setupcellnote setuporientinvalid setupusestartpage setupnoteatend setupprinterror setupdpi setupvdpi setupheadermargin setupfootermargin setupnumcopy'=. y
z=. z, toWORD0 setuppapersize
z=. z, toWORD0 setupscaling
z=. z, toWORD0 setupstartpage
z=. z, toWORD0 setupfitwidth
z=. z, toWORD0 setupfitheight
z=. z, toWORD0 setuprowmajor bitor 1 bitshl setupportrait bitor 1 bitshl setupinvalid bitor 1 bitshl setupblackwhite bitor 1 bitshl setupdraft bitor 1 bitshl setupcellnote bitor 1 bitshl setuporientinvalid bitor 1 bitshl setupusestartpage bitor 2 bitshl setupnoteatend bitor 1 bitshl setupprinterror
z=. z, toWORD0 setupdpi
z=. z, toWORD0 setupvdpi
z=. z, toDouble0 setupheadermargin
z=. z, toDouble0 setupfootermargin
z=. z, toWORD0 setupnumcopy
z=. z,~ toHeader recordtype, #z
)

biff_standardwidth=: 3 : 0
recordtype=. 16b0099
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

NB. the string value of a formula
NB. the value of all formulas outside of this record are held in
NB. Excels formula format
biff_string=: 3 : 0
if. #y do.
  recordtype=. 16b0207
  z=. ''
  z=. z, toUString16 y
  z=. z,~ toHeader recordtype, #z
else.
  z=. ''
end.
)

biff_style=: 4 : 0
recordtype=. 16b0293
z=. ''
'builtin id level name'=. y
if. 0=builtin do.
  z=. z, toWORD0 16bfff bitand x
  z=. z, toUString16 name
else.
  z=. z, toWORD0 16b8000 bitor 16bfff bitand x
  z=. z, toBYTE id
  z=. z, toBYTE level
end.
z=. z,~ toHeader recordtype, #z
)

biff_supbook=: 4 : 0
recordtype=. 16b01ae
z=. ''
if. 'external'-:x do.
  z=. z, toWORD0 # _1{::y
  z=. z, toUString16 0{::y
  for_yi. _1{::y do.
    z=. z, toUString16 >yi
  end.
elseif. 'internal'-:x do.
  z=. z, toWORD0 y
  z=. z, SString 1 4{a.
elseif. 'addin'-:x do.
  z=. z, toWORD0 1
  z=. z, SString 1 3{a.
elseif. ('ole'-:x)+.('dde'-:x) do.
  z=. z, toWORD0 0
  z=. z, toUString16 y
elseif. do.
  'unhandled exception' 13!:8 (3)
end.
z=. z,~ toHeader recordtype, #z
)

NB. a one-input row or column table created with the Data Table command
biff_table=: 3 : 0
recordtype=. 16b0036
z=. ''
'firstrow lastrow firstcol lastcol recalc rowinput colinput row col'=. y
z=. z, toWORD0 firstrow
z=. z, toWORD0 lastrow
z=. z, toBYTE firstcol
z=. z, toBYTE lastcol
z=. z, toWORD0 recalc
z=. z, toWORD0 rowinput
z=. z, toWORD0 colinput
z=. z, toWORD0 row
z=. z, toWORD0 col
z=. z,~ toHeader recordtype, #z
)

NB. set the top margin, used when printing, in inches
NB. 8-byte IEEE floating point format
biff_topmargin=: 3 : 0
recordtype=. 16b0028
z=. ''
z=. z, toDouble0 y
z=. z,~ toHeader recordtype, #z
)

biff_vcenter=: 3 : 0
recordtype=. 16b0084
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

NB. a list of explicit column page breaks
biff_verticalpagebreaks=: 3 : 0
recordtype=. 16b001a
z=. ''
z=. z, toWORD0 #y
for_iy. y do. z=. z, toWORD0 iy end.
z=. z,~ toHeader recordtype, #z
)

NB. basic Excel window information
biff_window1=: 3 : 0
recordtype=. 16b003d
z=. ''
'x y width height hidden'=. y
z=. z, toWORD0 x
z=. z, toWORD0 y
z=. z, toWORD0 width
z=. z, toWORD0 height
z=. z, toWORD0 hidden
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toWORD0 1
z=. z, toWORD0 250
z=. z,~ toHeader recordtype, #z
)

NB. advanced window information
biff_window2=: 3 : 0
recordtype=. 16b023e
z=. ''
'flag topvisiblerow leftvisiblecol RGBcolor'=. y
z=. z, toWORD0 flag
z=. z, toWORD0 topvisiblerow
z=. z, toWORD0 leftvisiblecol
z=. z, toWORD0 RGBcolor
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toDWORD0 0
z=. z,~ toHeader recordtype, #z
)

NB. workbook/worksheet window configuration protection
biff_windowprotect=: 3 : 0
recordtype=. 16b0019
z=. ''
z=. z, toWORD0 0~:y
z=. z,~ toHeader recordtype, #z
)

biff_wsbool=: 3 : 0
recordtype=. 16b0081
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

biff_xct=: 3 : 0
recordtype=. 16b0059
z=. ''
z=. z, toWORD0 y
z=. z,~ toHeader recordtype, #z
)

biff_xf=: 3 : 0
recordtype=. 16b00e0
'font format typeprot align rotate indent used border linecolor color'=. y
z=. ''
z=. z, toWORD0 font
z=. z, toWORD0 format
z=. z, toWORD0 typeprot
z=. z, toBYTE align
z=. z, toBYTE rotate
z=. z, toBYTE indent
z=. z, toBYTE used
z=. z, toDWORD0 border
z=. z, toDWORD0 linecolor
z=. z, toWORD0 color
z=. z,~ toHeader recordtype, #z
)

coclass 'biffrefname'
coinsert 'biff'
create=: 3 : 0
'hidden function command macro complex builtin functiongroup binaryname keybd sheetidx'=: 0
'name formula menu description helptopic statusbar'=: 6#a:
)

destroy=: codestroy
writestream=: 3 : 0
z=. biff_name hidden ; function ; command ; macro ; complex ; builtin ; functiongroup ; binaryname ; keybd ; name ; formula ; sheetidx ; menu ; description ; helptopic ; statusbar
)

coclass 'biffsupbook'
coinsert 'biff'
newextname=: 3 : 0
extname=: extname, <y
)

create=: 3 : 0
'type sheetn source sheetname'=: 4{.y
if. -. (<type) e. 'external' ; 'internal' ; 'addin' ; 'ole' ; 'dde' do.
  'unhandled exception' 13!:8 (3)
end.
extname=: ''
crn=: ''  NB. not yet implemented
)

destroy=: codestroy
writestream=: 3 : 0
z=. ''
if. 'external'-:type do. z=. z, type biff_supbook source ,&< sheetname
elseif. 'internal'-:type do. z=. z, type biff_supbook y
elseif. 'addin'-:type do. z=. z, type biff_supbook ''
elseif. 'ole'-:type do. z=. z, type biff_supbook source
elseif. 'dde'-:type do. z=. z, type biff_supbook source
end.
for_ni. extname do.
  z=. z, type biff_externname >ni
end.
for_ni. crn do.
  z=. z, type biff_crn >ni
end.
z
)

coclass 'biffxf'
coinsert 'biff'
NB. merely create biffxf will not result in a new biff xf record in excel file
NB. each biffxf object must be getxfidx
NB. getcolor=: 3 : 0
NB. y=. y.
NB. if. y e. colorborder, colorpattern, colorfont do. y return. end.
NB. if. (#colorset__COCREATOR)= n=. colorset__COCREATOR i. y do.
NB.   colorset__COCREATOR=: colorset__COCREATOR, y
NB. end.
NB. n
NB. )
getcolor=: ]
getfont=: 3 : 0
'fontheight fontitalic fontstrike fontcolor fontweight fontscript fontunderline fontfamily fontcharset fontname'=. y
y=. fontheight ; fontitalic ; fontstrike ; (getcolor fontcolor) ; fontweight ; fontscript ; fontunderline ; fontfamily ; fontcharset ; dltb fontname
if. (#fontset__COCREATOR)= n=. fontset__COCREATOR i. y do.
  fontset__COCREATOR=: fontset__COCREATOR, y
end.
n
)

getformat=: 3 : 0
if. (#formatset__COCREATOR)= n=. formatset__COCREATOR i. <y=. dltb y do.
  formatset__COCREATOR=: formatset__COCREATOR, <y
end.
n
)

NB. return xf in xfset row for an biffxf object
NB. usage: getxfrow__xfo ''
NB. font format typeprotparent align rotate indent used border linecolor color
getxfrow=: 3 : 0
font=. getfont fontheight ; fontitalic ; fontstrike ; fontcolor ; fontweight ; fontscript ; fontunderline ; fontfamily ; fontcharset ; fontname
formatn=. getformat format
NB. see 6.70, otherwise excel cannot use cell format edit
if. (0=leftlinecolor) *. leftlinestyle do. leftlinecolor=. 16b40 end.
if. (0=rightlinecolor) *. rightlinestyle do. rightlinecolor=. 16b40 end.
if. (0=toplinecolor) *. toplinestyle do. toplinecolor=. 16b40 end.
if. (0=bottomlinecolor) *. bottomlinestyle do. bottomlinecolor=. 16b40 end.
if. (0=diagonalcolor) *. diagonalstyle do. diagonalcolor=. 16b40 end.
if. (0=patternbgcolor) *. pattern do. patternbgcolor=. 16b41 end.
typeprotparent=. lock bitor 1 bitshl hideformula bitor 1 bitshl type bitor 2 bitshl parentxf
align=. horzalign bitor 3 bitshl textwrap bitor 1 bitshl vertalign
indentshrink=. indent bitor 4 bitshl shrink
used=. 2 bitshl usedformat bitor 1 bitshl usedfont bitor 1 bitshl usedalign bitor 1 bitshl usedborder bitor 1 bitshl usedbackground bitor 1 bitshl usedprotect
border=. leftlinestyle bitor 4 bitshl rightlinestyle bitor 4 bitshl toplinestyle bitor 4 bitshl bottomlinestyle bitor 4 bitshl (getcolor leftlinecolor) bitor 7 bitshl (getcolor rightlinecolor) bitor 7 bitshl diagonaltopleft bitor 1 bitshl diagonalbottomleft
linecolor=. (getcolor toplinecolor) bitor 7 bitshl (getcolor bottomlinecolor) bitor 7 bitshl (getcolor diagonalcolor) bitor 7 bitshl diagonalstyle bitor 5 bitshl pattern
color=. (getcolor patterncolor) bitor 7 bitshl (getcolor patternbgcolor)
font, formatn, typeprotparent, align, rotation, indentshrink, used, border, linecolor, color
)

NB. set biffxf object to an xfset row
NB. font format typeprotparent align rotate indent used border linecolor color
copyxfrow=: 3 : 0
'font formatn typeprotparent align rotate indentshrink used border linecolor color'=. y
'fontheight fontitalic fontstrike fontcolor fontweight fontscript fontunderline fontfamily fontcharset fontname'=: font{fontset__COCREATOR
NB. if. -. fontcolor e. colorborder, colorpattern, colorfont do.
NB.   fontcolor=: fontcolor{.colorset__COCREATOR
NB. end.
format=: >formatn{formatset__COCREATOR
lock=: 1 bitand typeprotparent
hideformula=: _1 bitshl 2b10 bitand typeprotparent
type=: _2 bitshl 2b100 bitand typeprotparent
parentxf=: _4 bitshl 16bfff0 bitand typeprotparent
rotation=: rotate
horzalign=: 7 bitand align
textwrap=: _3 bitshl 8 bitand align
vertalign=: _4 bitshl 16b70 bitand align
indent=: 16bf bitand indentshrink
shrink=: _4 bitshl 16b10 bitand indentshrink
'usedformat usedfont usedalign usedborder usedbackground usedprotect'=: |. _2}. _8{. (8#0), #: used
leftlinestyle=: 16bf bitand border
rightlinestyle=: _4 bitshl 16bf0 bitand border
toplinestyle=: _8 bitshl 16bf00 bitand border
bottomlinestyle=: _12 bitshl 16bf000 bitand border
leftlinecolor=: _16 bitshl 16b7f0000 bitand border
rightlinecolor=: _23 bitshl 16b3f800000 bitand border
diagonaltopleft=: _30 bitshl 16b40000000 bitand border
diagonalbottomleft=: _31 bitshl (DFH '0x80000000') bitand border
toplinecolor=: 16b7f bitand linecolor
bottomlinecolor=: _7 bitshl 16b3f80 bitand linecolor
diagonalcolor=: _14 bitshl 16b1fc000 bitand linecolor
diagonalstyle=: _21 bitshl 16b1e00000 bitand linecolor
pattern=: _26 bitshl (DFH '0xfc000000') bitand linecolor
patterncolor=: 16b7f bitand color
patternbgcolor=: _7 bitshl 16b3f80 bitand color
)

NB. copy content from an another biffxf object
copyxfobj=: 3 : 0
l=. y
nm=. nl__l 0
for_nmi. nm do. (>nmi)=: ((>nmi), '__l')~ end.
)

create=: 3 : 0
NB. read section 5.113 XF Extended Format and 5.43 FONT
'fontheight fontitalic fontstrike fontcolor fontweight fontscript fontunderline fontfamily fontcharset fontname'=: {.fontset_COCREATOR
format=: 'General'
lock=: 0
hideformula=: 1
type=: 0  NB. 0: cell 1:style
parentxf=: 0
horzalign=: 0  NB. 0 general  1 left  2 center  3 right
textwrap=: 0
vertalign=: 2  NB. 0 top  1 centre  2 bottom
rotation=: 0
indent=: 0
shrink=: 0
usedformat=: 0
usedfont=: 0
usedalign=: 0
usedborder=: 0
usedbackground=: 0
usedprotect=: 0
leftlinestyle=: 0
rightlinestyle=: 0
toplinestyle=: 0
bottomlinestyle=: 0
leftlinecolor=: 0
rightlinecolor=: 0
diagonaltopleft=: 0
diagonalbottomleft=: 0
toplinecolor=: 0
bottomlinecolor=: 0
diagonalcolor=: 0
diagonalstyle=: 0
pattern=: 0
patterncolor=: colorborder
patternbgcolor=: colorpattern
xfindex=: _1   NB. undefined
if. ''-.@-:y do.
  if. (3!:0 y) e. 1 4 do.
    copyxfrow y
  elseif. (3!:0 y) e. 32 do.
    copyxfobj y
  end.
end.
)

destroy=: codestroy

coclass 'biffsheet'
coinsert 'biff'

NB. This verb use IMDATA record which has been obsoleted, only MS Excel can display it correct.
NB. other Excel compatible program (open office calc, gnumeric can not display it.
NB.   Insert a 24bit bitmap image in a worksheet.
NB. x
NB.   row     The row we are going to insert the bitmap into
NB.   col     The column we are going to insert the bitmap into
NB.   x       The horizontal position (offset) of the image inside the cell.
NB.   y       The vertical position (offset) of the image inside the cell.
NB.   scale_x The horizontal scale
NB.   scale_y The vertical scale
NB. y
NB.   bitmap  The bitmap filename
insertpicture=: 4 : 0
img=. y
'rowcol xyoffset scalexy'=. x
if. 2 131072 e.~ 3!:0 rowcol do. rowcol=. A1toRC rowcol end.
'row col'=. rowcol
'x1 y1'=. xyoffset
'scalex scaley'=. scalexy
z=. processbitmap img
if. _1&= 0{::z do. z return. end.
'width height size data'=. }.z
NB. Scale the frame of the image.
width=. width * scalex
height=. height * scaley
NB. Calculate the vertices of the image and write the OBJ record
positionImage row, col, x1, y1, width, height
NB. Write the IMDATA record to store the bitmap data
record=. 16b007f
if. RECORDLEN>:8 + size do.
  length=. 8 + size
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, data
else.
  length=. RECORDLEN
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, (RECORDLEN-8){.data
  data=. (RECORDLEN-8)}.data
  a=. <.(#data) % RECORDLEN
  b=. RECORDLEN | #data
  if. #a do.
    imdata=: imdata,, (toHeader 16b003c, RECORDLEN) ,("1) (a, RECORDLEN)$(a*RECORDLEN){.data
  end.
  if. #b do.
    imdata=: imdata, (toHeader 16b003c, b), (-b){.data
  end.
end.
0 ; ''
)

NB.
NB.   Calculate the vertices that define the position of the image as required by
NB.   the OBJ record.
NB.
NB.           +------------+------------+
NB.           |     A      |      B     |
NB.     +-----+------------+------------+
NB.     |     |(x1, y1)     |            |
NB.     |  1  |(A1)._______|______      |
NB.     |     |    |              |     |
NB.     |     |    |              |     |
NB.     +-----+----|    BITMAP    |-----+
NB.     |     |    |              |     |
NB.     |  2  |    |______________.     |
NB.     |     |            |        (B2)|
NB.     |     |            |     (x2, y2)|
NB.     +---- +------------+------------+
NB.
NB.   Example of a bitmap that covers some of the area from cell A1 to cell B2.
NB.
NB.   Based on the width and height of the bitmap we need to calculate 8 vars:
NB.       $col_start, $row_start, $col_end, $row_end, $x1, $y1, $x2, $y2.
NB.   The width and height of the cells are also variable and have to be taken into
NB.   account.
NB.   The values of $col_start and $row_start are passed in from the calling
NB.   function. The values of $col_end and $row_end are calculated by subtracting
NB.   the width and height of the bitmap from the width and height of the
NB.   underlying cells.
NB.   The vertices are expressed as a percentage of the underlying cell width as
NB.   follows (rhs values are in pixels):
NB.
NB.         x1 = X / W *1024
NB.         y1 = Y / H *256
NB.         x2 = (X-1) / W *1024
NB.         y2 = (Y-1) / H *256
NB.
NB.         Where:  X is distance from the left side of the underlying cell
NB.                 Y is distance from the top of the underlying cell
NB.                 W is the width of the cell
NB.                 H is the height of the cell
NB.
NB.   the SDK incorrectly states that the height should be expressed as a percentage of 1024.
NB.
NB.   notice relative ordering of row col x1 y1
NB.   row_start Row containing top left corner of object
NB.   col_start Col containing upper left corner of object
NB.   x1        Distance to left side of object
NB.   y1        Distance to top of object
NB.   width     Width of image frame
NB.   height    Height of image frame
NB.
position_object=: 3 : 0
'rowstart colstart x1 y1 width height'=. y
NB. Initialise end cell to the same as the start cell
colend=. colstart  NB. Col containing lower right corner of object
rowend=. rowstart  NB. Row containing bottom right corner of object
NB. Zero the specified offset if greater than the cell dimensions
if. x1 >: sizeCol colstart do. x1=. 0 end.
if. y1 >: sizeRow rowstart do. y1=. 0 end.
width=. width + x1
height=. height + y1
NB. Subtract the underlying cell widths to find the end cell of the image
while. width >: sizeCol colend do.
  width=. width - sizeCol colend
  colend=. >:colend
end.
NB. Subtract the underlying cell heights to find the end cell of the image
while. height >: sizeRow rowend do.
  height=. height - sizeRow rowend
  rowend=. >:rowend
end.
NB. Bitmap isn't allowed to start or finish in a hidden cell, i.e. a cell
NB. with zero height or width.
NB.
if. 0= sizeCol colstart do. return. end.
if. 0= sizeCol colend do. return. end.
if. 0= sizeRow rowstart do. return. end.
if. 0= sizeRow rowend do. return. end.
NB. Convert the pixel values to the percentage value expected by Excel
x1=. <. 1024 * x1 % sizeCol colstart
y1=. <. 256 * y1 % sizeRow rowstart
x2=. <. 1024 * width % sizeCol colend NB. Distance to right side of object
y2=. <. 256 * height % sizeRow rowend NB. Distance to bottom of object
colstart , x1 , rowstart , y1 , colend , x2 , rowend , y2
)

positionImage=: storeobjpicture@:position_object

getcolsizes=: 3 : 0
if. (#colsizes)= i=. y i.~ {.("1) colsizes do.
  _1
else.
  {: i{colsizes
end.
)

getrowsizes=: 3 : 0
if. (#rowsizes)= i=. y i.~ {.("1) rowsizes do.
  _1
else.
  {: i{rowsizes
end.
)

NB.
NB.   Convert the width of a cell from user's units to pixels. By interpolation
NB.   the relationship is: y = 7x +5. If the width hasn't been set by the user we
NB.   use the default value. If the col is hidden we use a value of zero.
NB.
NB.   return The width in pixels
NB.
sizeCol=: 3 : 0
NB. Look up the cell value to see if it has been changed
if. _1~: getcolsizes y do.
  if. 0= getcolsizes y do.
    0 return.
  else.
NB. user unit is 0.38 + number of character
NB. y = 8x +5  seem correct on my 800X600 screen
    <. 5 + 8 * 0.38 + 256%~ getcolsizes y return.
  end.
else.
  <. 5 + 8 * 0.38 + 256%~ defaultcolwidth * 256 return.
end.
)

NB.
NB.   Convert the height of a cell from user's units to pixels. By interpolation
NB.   the relationship is: y = 4/3x. If the height hasn't been set by the user we
NB.   use the default value. If the row is hidden we use a value of zero. (Not
NB.   possible to hide row yet).
NB.
NB.   return The width in pixels
NB.
sizeRow=: 3 : 0
NB. Look up the cell value to see if it has been changed
if. _1~: getrowsizes y do.
  if. 0= getrowsizes y do.
    0 return.
  else.
NB. user unit is point (=1/72")
    <. (4%3) * 20%~ getrowsizes y return.
  end.
else.
  <. (4%3) * 20%~ defaultrowheight return.
end.
)

NB.
NB.   Store the OBJ record that precedes an IMDATA record. This could be generalise
NB.   to support other Excel objects.
NB.
NB.   colL Column containing upper left corner of object
NB.   dxL  Distance from left side of cell
NB.   rwT  Row containing top left corner of object
NB.   dyT  Distance from top of cell
NB.   colR Column containing lower right corner of object
NB.   dxR  Distance from right of cell
NB.   rwB  Row containing bottom right corner of object
NB.   dyB  Distance from bottom of cell
NB.
storeobjpicture=: 3 : 0
'colL dxL rwT dyT colR dxR rwB dyB'=. y
record=. 16b005d   NB. Record identifier
length=. 16b003c   NB. Bytes to follow
cObj=. 16b0001   NB. Count of objects in file (set to 1)
OT=. 16b0008   NB. Object type. 8 =. Picture
id=. 16b0001   NB. Object ID
grbit=. 16b0614   NB. Option flags
cbMacro=. 16b0000   NB. Length of FMLA structure
Reserved1=. 16b0000   NB. Reserved
Reserved2=. 16b0000   NB. Reserved
icvBack=. 16b09     NB. Background colour
icvFore=. 16b09     NB. Foreground colour
fls=. 16b00     NB. Fill pattern
fAuto=. 16b00     NB. Automatic fill
icv=. 16b08     NB. Line colour
lns=. 16bff     NB. Line style
lnw=. 16b01     NB. Line weight
fAutoB=. 16b00     NB. Automatic border
frs=. 16b0000   NB. Frame style
cf=. 16b0009   NB. Image format, 9 =. bitmap
Reserved3=. 16b0000   NB. Reserved
cbPictFmla=. 16b0000   NB. Length of FMLA structure
Reserved4=. 16b0000   NB. Reserved
grbit2=. 16b0001   NB. Option flags
Reserved5=. 16b0000   NB. Reserved
header=. toWORD0 record, length
data=. toDWORD0 cObj
data=. data, toWORD0 OT
data=. data, toWORD0 id
data=. data, toWORD0 grbit
data=. data, toWORD0 colL
data=. data, toWORD0 dxL
data=. data, toWORD0 rwT
data=. data, toWORD0 dyT
data=. data, toWORD0 colR
data=. data, toWORD0 dxR
data=. data, toWORD0 rwB
data=. data, toWORD0 dyB
data=. data, toWORD0 cbMacro
data=. data, toDWORD0 Reserved1
data=. data, toWORD0 Reserved2
data=. data, toBYTE icvBack
data=. data, toBYTE icvFore
data=. data, toBYTE fls
data=. data, toBYTE fAuto
data=. data, toBYTE icv
data=. data, toBYTE lns
data=. data, toBYTE lnw
data=. data, toBYTE fAutoB
data=. data, toWORD0 frs
data=. data, toDWORD0 cf
data=. data, toWORD0 Reserved3
data=. data, toWORD0 cbPictFmla
data=. data, toWORD0 Reserved4
data=. data, toWORD0 grbit2
data=. data, toDWORD0 Reserved5
imdata=: imdata, header, data
)

NB.
NB.   Convert a 24 bit bitmap into the modified internal format used by Windows.
NB.   This is described in BITMAPCOREHEADER and BITMAPCOREINFO structures in the
NB.   MSDN library.
NB.
NB.   return Array with data and properties of the bitmap
NB.
processbitmap=: 3 : 0
raiseError=. ''
NB. Open file.
if. 32=3!:0 y do.
  data=. ]`(''"_)@.(_1&-:)@:fread y
else.
  data=. y
end.
NB. Check that the file is big enough to be a bitmap.
if. ((#data) <: 16b36) do.
  raiseError=. 'size error'
  goto_error.
end.
NB. The first 2 bytes are used to identify the bitmap.
identity=. 2{.data
if. (identity -.@-: 'BM') do.
  raiseError=. 'signiture error'
  goto_error.
end.
NB. Remove bitmap data: ID.
data=. 2}.data
NB. Read and remove the bitmap size. This is more reliable than reading
NB. the data size at offset 16b22.
NB.
size=. fromDWORD0 4{.data
data=. 4}.data
size=. size - 16b36 NB. Subtract size of bitmap header.
size=. size + 16b0c NB. Add size of BIFF header.
NB. Remove bitmap data: reserved, offset, header length.
data=. 12}.data
NB. Read and remove the bitmap width and height. Verify the sizes.
'width height'=. fromDWORD0 8{.data
data=. 8}.data
if. (width > 16bffff) do.
  raiseError=. 'bitmap width greater than 65535'
  goto_error.
end.
if. (height > 16bffff) do.
  raiseError=. 'bitmap height greater than 65535'
  goto_error.
end.
NB. Read and remove the bitmap planes and bpp data. Verify them.
planesandbitcount=. fromWORD0 4{.data
data=. 4}.data
if. (24 ~: 1{planesandbitcount) do.  NB. Bitcount
  raiseError=. 'not 24 bit color'
  goto_error.
end.
if. (1 ~: 0{planesandbitcount) do.
  raiseError=. 'contain more than 1 plane'
  goto_error.
end.
NB. Read and remove the bitmap compression. Verify compression.
compression=. fromDWORD0 4{.data
data=. 4}.data
if. (compression ~: 0) do.
  raiseError=. 'compression not supported'
  goto_error.
end.
NB. Remove bitmap data: data size, hres, vres, colours, imp. colours.
data=. 20}.data
NB. Add the BITMAPCOREHEADER data
header=. toDWORD0 16b000c
header=. header, toWORD0 width, height, 16b01, 16b18
data=. header, data
0 ; width ; height ; size ; data
return.
label_error.
_1 ; raiseError
)

insertbackground=: 3 : 0
z=. processbitmap y
if. _1&= 0{::z do. z return. end.
'width height size data'=. }.z
NB. Write the BITMAP record to store the bitmap data
record=. 16b00e9
if. RECORDLEN>:8 + size do.
  length=. 8 + size
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, data
else.
  length=. RECORDLEN
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, (RECORDLEN-8){.data
  data=. (RECORDLEN-8)}.data
  a=. <.(#data) % RECORDLEN
  b=. RECORDLEN | #data
  if. #a do.
    imdata=: imdata,, (toHeader 16b003c, RECORDLEN) ,("1) (a, RECORDLEN)$(a*RECORDLEN){.data
  end.
  if. #b do.
    imdata=: imdata, (toHeader 16b003c, b), (-b){.data
  end.
end.
0 ; ''
)

adjdim=: 3 : 0
dimensions=: ((1 3{dimensions)>. y) 1 3}dimensions
)

initsheet=: 3 : 0
NB. read section 4.2.6 Record Order in BIFF8
sheetname=: y
NB. = calculation setting block
calccount=: 100
calcmode=: 1
refmode=: 1
delta=: 0.001000
iteration=: 0
NB. = calculation setting block
printheaders=: 0
printgridlines=: 0
defaultrowheightnotmatch=: 1
defaultrowheighthidden=: 0
defaultrowheightspaceabove=: 0
defaultrowheightspacebelow=: 0
defaultrowheight=: 315  NB. flag, 1/20 point
wsbool=: 0
NB. = page setting block
horizontalpagebreaks=: 0 3$''         NB. row after pagebreak, 0, _1
verticalpagebreaks=: 0 3$''           NB. col after pagebreak, 0, _1
NB. command used in header and footer
NB. && The "&" character itself
NB. &L Start of the left section
NB. &C Start of the centred section
NB. &R Start of the right section
NB. &P Current page number
NB. &N Page count
NB. &D Current date
NB. &T Current time
NB. &A Sheet name (BIFF5-BIFF8)
NB. &F File name without path
NB. &Z File path without file name (BIFF8X)
NB. &G Picture (BIFF8X)
NB. &U Underlining on/off
NB. &E Double underlining on/off (BIFF5-BIFF8)
NB. &S Strikeout on/off
NB. &X Superscript on/off (BIFF5-BIFF8)
NB. &Y Subscript on/off (BIFF5-BIFF8)
NB. &"<fontname>" Set new font <fontname>
NB. &"<fontname>, <fontstyle>"
NB.     Set new font with specified style <fontstyle>. The style <fontstyle> is in most cases
NB.     one of Regular, Bold, Italic, or Bold Italic. But this setting is dependent on the
NB.     used font, it may differ (localised style names, or Standard, Oblique,...). (BIFF5-
NB.     BIFF8)
NB. &<fontheight>
NB.     Set font height in points (<fontheight> is a decimal value). If this command is followed
NB.     by a plain number to be printed in the header, it will be separated from the font height
NB.     with a space character.
header=: ''  NB. '&A'
footer=: 'Page &P of &N'
hcenter=: 0
vcenter=: 0
leftmargin=: 0.5
rightmargin=: 0.5
topmargin=: 0.5
bottommargin=: 0.75
NB. setup
NB. read section 5.87 SETUP
'setuppapersize setupscaling setupstartpage setupfitwidth setupfitheight setuprowmajor setupportrait setupinvalid setupblackwhite setupdraft setupcellnote setuporientinvalid setupusestartpage setupnoteatend setupprinterror setupdpi setupvdpi setupheadermargin setupfootermargin setupnumcopy'=: 0
setuprowmajor=: 1
setupportrait=: 1
setupinvalid=: 0
setupscaling=: 100
setupdpi=: setupvdpi=: 600
setupheadermargin=: 0.75
setupfootermargin=: 0.75
backgroundbitmap=: ''
NB. = page setting block
protect=: 1
windowprotect=: 1
objectprotect=: 1
scenprotect=: 1
password=: ''
NB.
defaultcolwidth=: 8
colinfoset=: 0 7$''
dimensions=: 0 0 0 0
NB. cell table
window2=: 16b6b6 0 0 10
sclnum=: sclden=: 1
'xsplit ysplit topvis leftvis'=: 0
activepane=: ''
NB.  standardwidth=: 8*256            NB. appear buggy
mergedcell=: 0 4$''               NB. row1 row2 col1 col2
rowlabelrange=: collabelrange=: 0 4$''
condformatstream=: ''
selection=: 0 5$''
hlink=: 0 8$''
imdata=: ''
dvstream=: ''
colsizes=: 0 2$''
rowsizes=: 0 2$''
NB. mso stuff
sheetoffset=: 0
object_ids=: 1024 0 0 1024
images_array=: 0 0$''
image_mso_size=: 0
comments_array=: 0 0$''
charts_array=: 0 0$''
comments_author=: ''
comments_visible=: 0
filter_area=: ''
filter_count=: 0
filter_on=: 0
filter_cols=: 0 0$''
NB. for debug
rowcolused=: 0 2$0
)

writestream=: 3 : 0
z=. biff_bof 16b600, 16
NB. = calculation setting block
p1=. #z
z=. z, biff_index (0 1+2{.dimensions), 0
z=. z, biff_calccount calccount
z=. z, biff_calcmode calcmode
z=. z, biff_refmode refmode
z=. z, biff_delta delta
z=. z, biff_iteration iteration
NB. = calculation setting block
z=. z, biff_printheaders printheaders
z=. z, biff_printgridlines printgridlines
z=. z, biff_defaultrowheight defaultrowheightnotmatch, defaultrowheighthidden, defaultrowheightspaceabove, defaultrowheightspacebelow, defaultrowheight
z=. z, biff_wsbool wsbool
NB. = page setting block
z=. z, biff_horizontalpagebreaks horizontalpagebreaks
z=. z, biff_verticalpagebreaks verticalpagebreaks
z=. z, biff_header header
z=. z, biff_footer footer
z=. z, biff_hcenter hcenter
z=. z, biff_vcenter vcenter
z=. z, biff_leftmargin leftmargin
z=. z, biff_rightmargin rightmargin
z=. z, biff_topmargin topmargin
z=. z, biff_bottommargin bottommargin
z=. z, biff_setup setuppapersize ; setupscaling ; setupstartpage ; setupfitwidth ; setupfitheight ; setuprowmajor ; setupportrait ; setupinvalid ; setupblackwhite ; setupdraft ; setupcellnote ; setuporientinvalid ; setupusestartpage ; setupnoteatend ; setupprinterror ; setupdpi ; setupvdpi ; setupheadermargin ; setupfootermargin ; setupnumcopy
z=. z, backgroundbitmap
NB. = page setting block
if. (#password) *. protect +. windowprotect +. objectprotect +. scenprotect do.
  if. protect do. z=. z, biff_protect protect end.
  if. windowprotect do. z=. z, biff_windowprotect windowprotect end.
  if. objectprotect do. z=. z, biff_objectprotect objectprotect end.
  if. scenprotect do. z=. z, biff_scenprotect scenprotect end.
  z=. z, biff_password passwordhash password
end.
NB. amend INDEX record, set Absolute stream position of the DEFCOLWIDTH record
p2=. #z
z=. (toDWORD0 p2+y) (p1+16+i.4)}z
z=. z, biff_defaultcolwidth defaultcolwidth
for_item. colinfoset do. z=. z, ({.item) biff_colinfo }.item end.

z=. z, store_filtermode ''
z=. z, store_autofilterinfo ''
z=. z, store_autofilters ''

z=. z, biff_dimensions dimensions
z=. z, stream, imdata
z=. z, store_images ''
z=. z, store_charts ''
z=. z, store_filters ''
z=. z, store_comments ''

z=. z, biff_window2 window2
z=. z, biff_scl sclnum, sclden
if. #activepane do. z=. z, biff_pane (xsplit, ysplit) ; (topvis, leftvis) ; activepane end.
if. #selection do. z=. z, biff_selection selection end.
NB. standardwidth broken
NB. z=. z, biff_standardwidth standardwidth
if. (2:~:$$) mergedcell do. mergedcell=: _4]\, mergedcell end.
z=. z, biff_mergedcells mergedcell
z=. z, biff_labelranges rowlabelrange ; collabelrange
z=. z, condformatstream
for_item. hlink do. z=. z, biff_hlink item end.
z=. z, dvstream
z=. z, biff_eof ''
)

NB. 16 bit hash value for worksheet password (5.18.4)
passwordhash=: 3 : 0
pw=. (15<.#y){.y
hash=. 0 [ i=. 0
while. i<#pw do.
  c=. 3&u: u: i{pw
  i=. >:i
  hash=. hash bitxor #. i&|. _15{.#: c
end.
hash=. 16bce4b bitxor (#pw) bitxor hash
)

create=: 3 : 0
stream=: ''
initsheet y
)

destroy=: codestroy

coclass 'biffbook'
coinsert 'biff'
getxfobj=: 3 : 0
z=. _1  NB. error
if. ''-:y do.
  z=. cxf
else.
  if. (3!:0 y) e. 32 do.
    z=. y
  elseif. (3!:0 y) e. 1 4 do.
    if. 1=#y do.
      z=. addxfobj ({.y){xfset
    elseif. (}.$xfset)-:$y do.
      if. (#xfset)= n=. xfset i. y do.
        xfset=: xfset, y
      end.
      z=. addxfobj n{xfset
    end.
  end.
end.
z
)

getxfidx=: 3 : 0
rc=. 0
if. ''-:y do. y=. cxf end.
if. (3!:0 y) e. 32 do.
  l=. y
  if. (#xfset)= n=. xfset i. a=. getxfrow__l '' do.
    xfset=: xfset, a
    xfindex__l=: n
  end.
  rc=. n
elseif. (3!:0 y) e. 1 4 do.
  if. 1=#y do.
    rc=. {.y
  elseif. (}.$xfset)-:$y do.
    if. (#xfset)= n=. xfset i. y do.
      xfset=: xfset, y
    end.
    rc=. n
  end.
end.
rc
)

add2sst=: 3 : 0
sstn=: >:sstn
if. (#sst) = b=. sst i. y do. sst=: sst, y end.
b
)

WriteSST=: 3 : 0
sstbuf=: (toWORD0 16b00fc, 0), toDWORD0 sstn, #sst
wrtp=: 0 [ bufn=: RECORDLEN-8
for_ix. sst do.
  oix=. >ix
  if. 131072= 3!:0 oix do.
    if. bufn<5 do. wrtcont '' end.
    wrtn #oix
    wrtw oix
  else.
    if. bufn<4 do. wrtcont '' end.
    wrtn #oix
    wrt oix
  end.
end.
sstbuf=: (toWORD0 RECORDLEN-bufn) (wrtp+2+i.2)}sstbuf
)

wrtn=: 3 : 0
sstbuf=: sstbuf, toWORD0 y
bufn=: bufn-2
)

wrtw=: 3 : 0
while. #y do.
  if. bufn<1+2*#y do.
    sstbuf=: sstbuf, (1{a.), toucode0 (<.-:bufn-1){.y
    y=. (<.-:bufn-1)}.y
    bufn=: bufn - 1+ 2*(<.-:bufn-1)
    wrtcont ''
  else.
    sstbuf=: sstbuf, (1{a.), toucode0 y
    bufn=: bufn - 1+2*#y
    y=. ''
  end.
end.
)

wrt=: 3 : 0
while. #y do.
  if. bufn<1+#y do.
    sstbuf=: sstbuf, (0{a.), (bufn-1){.y
    y=. (bufn-1)}.y
    bufn=: bufn - 1+ bufn-1
    wrtcont ''
  else.
    sstbuf=: sstbuf, (0{a.), y
    bufn=: bufn - 1+#y
    y=. ''
  end.
end.
)

wrtcont=: 3 : 0
sstbuf=: (toWORD0 RECORDLEN-bufn) (wrtp+2+i.2)}sstbuf
wrtp=: #sstbuf
sstbuf=: sstbuf, toWORD0 16b003c, 0
bufn=: RECORDLEN
)

initbook=: 3 : 0
NB. read section 4.2.6 Record Order in BIFF8
fileprotectionstream=: ''
workbookprotectionstream=: ''
codepage=: 1200
window1=: 672 192 11004 6636 16b38
backup=: 0
hideobj=: 0
date1904=: 0
precision=: 1
bookbool=: 1
NB. height italic strike color weight script underline family charset fontname
fontset=: 0 0$''
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 0
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 1
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 2
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 3
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 4 (missing)
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 5
formatset=: format0n$<''
NB. format 0-22
formatset=: ('General';'0';'0.00';'#,##0';'#,##0.00';'"$"#,##0_); ("$"#,##0)';'"$"#,##0_);[Red] ("$"#,##0)';'"$"#,##0.00_); ("$"#,##0.00)';'"$"#,##0.00_);[Red] ("$"#,##0.00)';'0%';'0.00%';'0.00E+00';'# ?/?';'# ??/??';'M/D/YY';'D-MMM-YY';'D-MMM';'MMM-YY';'h:mm AM/PM';'h:mm:ss AM/PM';'h:mm';'h:mm:ss';'M/D/YY h:mm') (i.23) } formatset
NB. format 37-49
formatset=: ('_(#,##0_);(#,##0)';'_(#,##0_);[Red](#,##0)';'_(#,##0.00_);(#,##0.00)';'_(#,##0.00_);[Red](#,##0.00)';'_ ("$"* #,##0_);_ ("$"* (#,##0);_ ("$"* "-"_);_(@_)';'_(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)';'_ ("$"* #,##0.00_);_ ("$"* (#,##0.00);_ ("$"* "-"??_);_(@_)';'_(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)';'mm:ss';'[h]:mm:ss';'mm:ss.0';'##0.0E+0';'@') (37+i.13)}formatset
NB. user-defined
formatset=: formatset, 'd/m/yyyy';'#,##0.000';'#,##0.0000';'#,##0.000000000'
NB. font format typeprot align rotate indent used border linecolor color
xfset=: 0 10$''
NB. style XF
xfset=: xfset, 0 0 16bfff5 16b20 0 0 0 0 0 16b20c0 NB. all valid
xfset=: xfset, 1 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0 NB. only font valid
xfset=: xfset, 1 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 2 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 2 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
NB. cell XF (15) will become default current xf (21)
xfset=: xfset, 0 0 1 16b20 0 0 0 0 0 16b20c0 NB. all valid
NB. Excel written XF, must include because they are referred by styleset
NB. (16)
xfset=: xfset, 1 16b2b 16bfff5 16b20 0 0 16bf8 0 0 16b20c0 NB. only format valid
xfset=: xfset, 1 16b29 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
xfset=: xfset, 1 16b2c 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
xfset=: xfset, 1 16b2a 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
xfset=: xfset, 1 9 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
NB. user-defined XF start here
NB. (21)
biffxfset=: ''
NB. xf builtin id level name
styleset=: 0 5$''
styleset=: styleset, 16b10 ; 1 ; 3 ; 16bff ; ''
styleset=: styleset, 16b11 ; 1 ; 6 ; 16bff ; ''
styleset=: styleset, 16b12 ; 1 ; 4 ; 16bff ; ''
styleset=: styleset, 16b13 ; 1 ; 7 ; 16bff ; ''
styleset=: styleset, 16b00 ; 1 ; 0 ; 16bff ; ''
styleset=: styleset, 16b14 ; 1 ; 5 ; 16bff ; ''
NB. predefine    black white red green blue yellow magenta cyan
colorset=: 0 16bffffff 16bff 16bff00 16bff0000 16bffff 16bff00ff 16bffff00
NB. Sets extra colour palette to the Excel 97+ default.
colorset=: colorset, RGB 16b00 16b00 16b00  NB. 8
colorset=: colorset, RGB 16bff 16bff 16bff  NB. 9
colorset=: colorset, RGB 16bff 16b00 16b00  NB. 10
colorset=: colorset, RGB 16b00 16bff 16b00  NB. 11
colorset=: colorset, RGB 16b00 16b00 16bff  NB. 12
colorset=: colorset, RGB 16bff 16bff 16b00  NB. 13
colorset=: colorset, RGB 16bff 16b00 16bff  NB. 14
colorset=: colorset, RGB 16b00 16bff 16bff  NB. 15
colorset=: colorset, RGB 16b80 16b00 16b00  NB. 16
colorset=: colorset, RGB 16b00 16b80 16b00  NB. 17
colorset=: colorset, RGB 16b00 16b00 16b80  NB. 18
colorset=: colorset, RGB 16b80 16b80 16b00  NB. 19
colorset=: colorset, RGB 16b80 16b00 16b80  NB. 20
colorset=: colorset, RGB 16b00 16b80 16b80  NB. 21
colorset=: colorset, RGB 16bc0 16bc0 16bc0  NB. 22
colorset=: colorset, RGB 16b80 16b80 16b80  NB. 23
colorset=: colorset, RGB 16b99 16b99 16bff  NB. 24
colorset=: colorset, RGB 16b99 16b33 16b66  NB. 25
colorset=: colorset, RGB 16bff 16bff 16bcc  NB. 26
colorset=: colorset, RGB 16bcc 16bff 16bff  NB. 27
colorset=: colorset, RGB 16b66 16b00 16b66  NB. 28
colorset=: colorset, RGB 16bff 16b80 16b80  NB. 29
colorset=: colorset, RGB 16b00 16b66 16bcc  NB. 30
colorset=: colorset, RGB 16bcc 16bcc 16bff  NB. 31
colorset=: colorset, RGB 16b00 16b00 16b80  NB. 32
colorset=: colorset, RGB 16bff 16b00 16bff  NB. 33
colorset=: colorset, RGB 16bff 16bff 16b00  NB. 34
colorset=: colorset, RGB 16b00 16bff 16bff  NB. 35
colorset=: colorset, RGB 16b80 16b00 16b80  NB. 36
colorset=: colorset, RGB 16b80 16b00 16b00  NB. 37
colorset=: colorset, RGB 16b00 16b80 16b80  NB. 38
colorset=: colorset, RGB 16b00 16b00 16bff  NB. 39
colorset=: colorset, RGB 16b00 16bcc 16bff  NB. 40
colorset=: colorset, RGB 16bcc 16bff 16bff  NB. 41
colorset=: colorset, RGB 16bcc 16bff 16bcc  NB. 42
colorset=: colorset, RGB 16bff 16bff 16b99  NB. 43
colorset=: colorset, RGB 16b99 16bcc 16bff  NB. 44
colorset=: colorset, RGB 16bff 16b99 16bcc  NB. 45
colorset=: colorset, RGB 16bcc 16b99 16bff  NB. 46
colorset=: colorset, RGB 16bff 16bcc 16b99  NB. 47
colorset=: colorset, RGB 16b33 16b66 16bff  NB. 48
colorset=: colorset, RGB 16b33 16bcc 16bcc  NB. 49
colorset=: colorset, RGB 16b99 16bcc 16b00  NB. 50
colorset=: colorset, RGB 16bff 16bcc 16b00  NB. 51
colorset=: colorset, RGB 16bff 16b99 16b00  NB. 52
colorset=: colorset, RGB 16bff 16b66 16b00  NB. 53
colorset=: colorset, RGB 16b66 16b66 16b99  NB. 54
colorset=: colorset, RGB 16b96 16b96 16b96  NB. 55
colorset=: colorset, RGB 16b00 16b33 16b66  NB. 56
colorset=: colorset, RGB 16b33 16b99 16b66  NB. 57
colorset=: colorset, RGB 16b00 16b33 16b00  NB. 58
colorset=: colorset, RGB 16b33 16b33 16b00  NB. 59
colorset=: colorset, RGB 16b99 16b33 16b00  NB. 60
colorset=: colorset, RGB 16b99 16b33 16b66  NB. 61
colorset=: colorset, RGB 16b33 16b33 16b99  NB. 62
colorset=: colorset, RGB 16b33 16b33 16b33  NB. 63
country=: 1 1
supbook=: ''
externsheet=: 0 3$''
extname=: ''
refname=: ''
NB. mso stuff
datasize=: 0
biffsize=: 0
mso_size=: 0
mso_clusters=: 0 5$''
images_size=: 0
images_data=: 0 0$''  NB. Store the data for MSODRAWINGGROUP.
)

addhlink=: 3 : 0
l=. sheeti{sheet
hlink__l=: hlink__l, y
)

writefileprotection=: 3 : 0
fileprotectionstream=: y
)

writeworkbookprotection=: 3 : 0
workbookprotectionstream=: y
)

writecelltable=: 3 : 0
l=. sheeti{sheet
stream__l=: stream__l, y
)

writecondformattable=: 3 : 0
l=. sheeti{sheet
condformatstream__l=: y
)

writedvtable=: 3 : 0
l=. sheeti{sheet
dvstream__l=: y
)

celladr=: 4 : 0
'relrow relcol'=. x
'row col'=. y
z=. toWORD0 row
z=. z, toWORD0 (16bff bitand col) bitor 14 bitshl (0~:relcol) bitor 1 bitshl 0~:relrow
)

cellrangeadr=: 4 : 0
'relrow1 relrow2 relcol1 relcol2'=. x
'row1 row2 col1 col2'=. y
z=. toWORD0 row1, row2
z=. z, toWORD0 (16bff bitand col1) bitor 14 bitshl (0~:relcol1) bitor 1 bitshl 0~:relrow1
z=. z, toWORD0 (16bff bitand col2) bitor 14 bitshl (0~:relcol2) bitor 1 bitshl 0~:relrow2
)

newsupbook=: 3 : 0
supbook=: supbook, y conew 'biffsupbook'
supbooki=: <:#supbook
)

newrefname=: 3 : 0
refname=: refname, '' conew 'biffrefname'
{:refname
)

newextname=: 3 : 0
l=. supbooki{supbook
newextname__l y
)

newcrn=: 3 : 0
l=. supbooki{supbook
newcrn__l y
)

create=: 3 : 0
if. ''-:y do.
  'fontname fontsize'=: ((IFUNIX+IFWINE){::'Courier New' ; 'Monospace') ; 220
  sheetname=. 'Sheet1'
else.
  'fontname fontsize'=: 2{.y
  sheetname=. 0{:: (2}.y) , <'Sheet1'
end.
sstn=: #sst=: ''
xfset=: sheet=: ''
initbook ''
addsheet sheetname  NB. create worksheet object
cxf=: addxfobj 15{xfset  NB. predefined cell style
)

destroy=: 3 : 0
if. DEBUG do.
  for_l. sheet do.
    if. n=. #rowcolused__l do.
      if. n ~: # a=. ~.rowcolused__l do.
        1!:2&2 sheetname__l, ' duplicated cell'
        1!:2&2 (1 < rowcolused__l #/. rowcolused__l) # a
      end.
    end.
  end.
end. for_l. sheet do. destroy__l '' end.
for_l. biffxfset do. destroy__l '' end.
for_l. supbook do. destroy__l '' end.
for_l. refname do. destroy__l '' end.
codestroy ''
)

NB. match color (red, green, blue) to internal color palette table
NB. return color index
rgbcolor=: 3 : 0
(i: <./) +/("1) | y -("1) RGBtuple colorset
)

NB. add new extended format
NB. return xf object
addxfobj=: 3 : 0
biffxfset=: biffxfset, z=. y conew 'biffxf'
z
)

NB. add new worksheet
NB. return worksheet index
NB. y sheet name or ''
addsheet=: 3 : 0
sheet=: sheet, ((y-:''){:: y ; 'Sheet', ": >:#sheet) conew 'biffsheet'
sheeti=: <:#sheet
)

NB. save to file
NB. y  filename ('' if return character data)
save=: 3 : 0
fn=. >y
calc_mso_sizes ''
z=. biff_bof 16b600, 5
z=. z, fileprotectionstream
z=. z, biff_codepage codepage
z=. z, workbookprotectionstream
z=. z, biff_window1 window1
z=. z, biff_backup backup
z=. z, biff_hideobj hideobj
z=. z, biff_date1904 date1904
z=. z, biff_precision precision
z=. z, biff_bookbool bookbool
NB. excel peculiar, 4 is missing
fontset1=. (4{.fontset), 5}.fontset
for_item. fontset1 do. z=. z, biff_font item end.
if. 164<#formatset do.
  for_i. i.164-~#formatset do. z=. z, biff_format (i+164) ; (i+164){formatset end.
end.
for_item. xfset do. z=. z, biff_xf item end.
for_item. styleset do. z=. z, (0{::item) biff_style }.item end.
if. 8<#colorset do.
  z=. z, biff_palette 8}.colorset
end.
olesheet=. ''
olehead=. z
seekpoint=. #z

NB. Calculate the offsets required by the BOUNDSHEET records
NB. calc_sheet_offsets ''

z=. ''
for_item. sheet do.
  z=. z, a=. biff_boundsheet 0 ; 0 ; 0 ; sheetname__item
  seekpoint=. seekpoint, #a
end.
z=. z, biff_country country
z=. z, add_mso_drawing_group ''
if. IFBIGBLOCK_PADDING do.
  if. 2680>#z1=. WriteSST '' do.
    add2sst <(2680-#z1)#{.a.
    z=. z, WriteSST ''
  else.
    z=. z, z1
  end.
else.
  z=. z, WriteSST ''
end.
if. #supbook do.
  for_item. supbook do.
    z=. z, writestream__item #sheet
  end.
  z=. z, biff_externsheet externsheet
  for_item. refname do.
    z=. z, writestream__item ''
  end.
end.
z=. z, biff_eof ''
olehead=. olehead, z
sheetoffset=. ({.seekpoint)+ #z
for_item. sheet do.
  z=. writestream__item {:sheetoffset
  olesheet=. olesheet, z
  sheetoffset=. sheetoffset, #z
end.
seekpoint=. }:+/\seekpoint
sheetoffset=. }:+/\sheetoffset
for_i. i.#seekpoint do.
  p1=. 4+i{seekpoint
  p2=. 0
  z=. toDWORD0 i{sheetoffset
  olehead=. z (p1+i.4)}olehead
end.
stream=. ('Workbook' ; '' ; '') conew 'oleppsfile'
append__stream olehead
append__stream olesheet

NB. hardwire summary info
stream1=. (((5{a.),'SummaryInformation') ; '' ; '') conew 'oleppsfile'
append__stream1 a.{~ 254 255 0 0 4 10 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 224 133 159 242 249 79 104 16 171 145 8 0 43 39 179 217 48 0 0 0 24 0 0 0 1 0 0 0 1 0 0 0 16 0 0 0 2 0 0 0 228 4 0 0
stream2=. (((5{a.),'DocumentSummaryInformation') ; '' ; '') conew 'oleppsfile'
append__stream2 a.{~ 254 255 0 0 4 10 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 2 213 205 213 156 46 27 16 147 151 8 0 43 44 249 174 48 0 0 0 24 0 0 0 1 0 0 0 1 0 0 0 16 0 0 0 2 0 0 0 228 4 0 0

root=. (0 ; 0 ; <stream1,stream2,stream) conew 'oleppsroot'
rc=. save__root fn ; 0 ; ''
destroy__root ''
destroy__stream ''
destroy__stream1 ''
destroy__stream2 ''
rc
)

NB. set column width of current worksheet
NB. x xf
NB. y col1 col2 width hide level collapse
NB.    eg. 2 5 400  to set (col 2 3 4 5) 400 twip hight
addcolinfo=: 3 : 0
cxf addcolinfo y
:
'col1 col2 width hide level collapse'=. 6{.y
l=. sheeti{sheet
colsizes__l=: ~. colsizes__l, (col1 + i.>:col2-col1) ,("0) (0~:hide){width, 0
colinfoset__l=: colinfoset__l, (getxfidx x), col1, col2, width, hide, level, collapse
''
)

NB. set row height of current worksheet
NB. x xf
NB. y rownumber firstcol_lastcol usedefaultheight rowheight heightnotmatch spaceabove spacebelow hidden explicitformat outlinelevel outlinegroup
NB.    eg. 3 0 256 0 12*256  to set (row 3) 12 character wide
addrowinfo=: 3 : 0
cxf addrowinfo y
:
'rownumber firstcol lastcols usedefaultheight rowheight'=. 5{. y=. 12{.y
l=. sheeti{sheet
if. 0=usedefaultheight do.
  rowsizes__l=: ~. rowsizes__l, rownumber, rowheight
end.
stream__l=: stream__l, (getxfidx x) biff_row y
''
)

NB. write string to the current worksheet
NB. x xf
NB. y row col ; text  [ ; option ]         (where 4>$$text)
NB.   row col ; boxed text  [ ; option ]   (where 3>$$boxed text)
NB.            (always box text argument to make 2 3 e.~ #y)
NB. option 1: write format for empty string cells
writestring=: 3 : 0
cxf writestring y
:
assert. 2 3 e.~ #y
assert. 1 2 4 8 131072 e.~ (3!:0) 0{::y
assert. 2 32 131072 e.~ (3!:0) 1{::y
if. 2 131072 e.~ 3!:0 rc=. 0{::y do. y=. (<A1toRC rc) 0}y end.
l=. sheeti{sheet
xf=. getxfidx x
if. 3=#y do. opt=. 2{::y else. opt=. 0 end.
if. (0=opt) *. 0 e. $yn=. 1{::y do. '' return. end.  NB. ignore null
if. 2 131072 e.~ 3!:0 yn do.
  if. 2> $$yn do.
    adjdim__l 0{::y
    stream__l=: stream__l, xf biff_label 2{.y
    if. DEBUG do.
      rowcolused__l=: rowcolused__l, ,0{::y
    end.
    '' return.
  elseif. 2=$$yn do.
    yn=. ,. <@dtb("1) yn    NB. column vector, yn may contain <'' here
  elseif. 3=$$yn do.
    yn=. <@dtb("1) yn       NB. yn may contain <'' here
  elseif. do. 'unhandled exception' 13!:8 (3)
  end.
elseif. -. 32 e.~ 3!:0 yn do.
  'unhandled exception' 13!:8 (3)
end.
NB. yn is now box array
if. 1=#@, yn do.  NB. singleton
  if. (0=opt) *. (0:=#), >yn do. '' return. end. NB. ignore null
  adjdim__l 0{::y
  stream__l=: stream__l, xf biff_label ({.y), <, >yn
  if. DEBUG do.
    rowcolused__l=: rowcolused__l, ,0{::y
  end.
elseif. 3>$$yn do.
  if. 1=$$yn do. yn=. ,:yn end.
  s=. $yn
  'r c'=. 0{::y
NB. biff8 cannot store empty string
  if. (0=opt) *. 0= +./ f1=. ,f=. (<'') ~: yn do. '' return. end.
  if. 0=opt do.
    mr=. 1 i.~ 1 e.("1) f
    mc=. 1 i.~ 1 e.("1) |:f
    adjdim__l (mr, mc) + 0{::y
    mr=. 1 i:~ 1 e.("1) f
    mc=. 1 i:~ 1 e.("1) |:f
    adjdim__l (mr, mc) + 0{::y
  else.
    adjdim__l 0{::y
    adjdim__l (<:s) + 0{::y
  end.
  sst=: sst, (~.f1#,yn) -. sst
  sstn=: sstn + +/f1
  stream__l=: stream__l,, (toHeader 16b00fd, 10) ,("1) (_2]\ toWORD0 f1#({:s)#r+i.{.s) ,("1) (_2]\ toWORD0 f1#,({.s)#,:c+i.{:s) ,("1) (toWORD0 xf) ,("1) (_4]\ toDWORD0 sst i. f1#,yn)
  if. DEBUG do.
    rowcolused__l=: rowcolused__l, (f1#({:s)#r+i.{.s) ,. f1#,({.s)#,:c+i.{:s
  end.
  if. (1=opt) *. 0 e. f1 do.
    stream__l=: stream__l,, (toHeader 16b0201, 6) ,("1) (_2]\ toWORD0 (-.f1)#({:s)#r+i.{.s) ,("1) (_2]\ toWORD0 (-.f1)#,({.s)#,:c+i.{:s) ,("1) (toWORD0 xf)
  end.
elseif. do. 'unhandled exception' 13!:8 (3)
end.
''
)

NB. write blank to the current worksheet
NB. x xf
NB. y row col [ row col ... ]
NB.   _2]\ row col [ row col ... ]
writeblank=: 3 : 0
cxf writeblank y
:
assert. 1 2 4 8 131072 e.~ (3!:0) y
if. 2 131072 e.~ 3!:0 y do. y=. A1toRC y end.
assert. 0=2|#,y
if. 0=#,y do. '' return. end.  NB. ignore null
'r c'=. |: _2]\ ,y
l=. sheeti{sheet
xf=. getxfidx x
adjdim__l (<./r), <./c
adjdim__l (>./r), >./c
stream__l=: stream__l,, (toHeader 16b0201, 6) ,("1) (_2]\ toWORD0 r) ,("1) (_2]\ toWORD0 c) ,("1) (toWORD0 xf)
if. DEBUG do.
  rowcolused__l=: rowcolused__l, r ,. c
end.
''
)

NB. write integer to the current worksheet
NB. x xf
NB. y row col ; integer [ ; option ]  (where 3>$$number)
NB. option 1: suppress zero   2: suppress zero but not format
writeinteger=: 3 : 0
cxf writeinteger y
:
assert. 2 3 e.~ #y
assert. 1 2 4 8 131072 e.~ (3!:0) 0{::y
assert. 1 4 8 e.~ (3!:0) 1{::y
if. 2 131072 e.~ 3!:0 rc=. 0{::y do. y=. (<A1toRC rc) 0}y end.
l=. sheeti{sheet
xf=. getxfidx x
NB. only 30 bit is used 536870911 = <:2^29
if. 536870911 < >./ |, 1{::y do. x writenumber y end.
if. (0:=#), yn=. 2b10 bitor 2 bitshl <. 1{::y do. '' return. end.  NB. ignore null
if. 3=#y do. opt=. 2{::y else. opt=. 0 end.
if. 1=#@, yn do.  NB. singleton
  if. (1=opt) *. 0= <. 1{::y do. '' return. end.
  adjdim__l 0{::y
  stream__l=: stream__l, xf biff_integer ({.y), < {., 1{::y
  if. DEBUG do.
    rowcolused__l=: rowcolused__l, ,0{::y
  end.
elseif. 3>$$yn do.
  if. 1=$$yn do. yn=. ,:yn end.
  s=. $yn
  'r c'=. 0{::y
  if. 0~:opt do.
    if. (1=opt) *. 0= +./ f1=. ,f=. 0~: <. 1{::y do. '' return. end.
    if. 1=opt do.
      mr=. 1 i.~ 1 e.("1) f
      mc=. 1 i.~ 1 e.("1) |:f
      adjdim__l (mr, mc) + 0{::y
      mr=. 1 i:~ 1 e.("1) f
      mc=. 1 i:~ 1 e.("1) |:f
      adjdim__l (mr, mc) + 0{::y
    else.
      adjdim__l 0{::y
      adjdim__l (<:s) + 0{::y
    end.
    stream__l=: stream__l,, (toHeader 16b027e, 10) ,("1) (_2]\ toWORD0 f1#({:s)#r+i.{.s) ,("1) (_2]\ toWORD0 f1#,({.s)#,:c+i.{:s) ,("1) (toWORD0 xf) ,("1) (_4]\ toDWORD0 f1#,yn)
    if. DEBUG do.
      rowcolused__l=: rowcolused__l, (f1#({:s)#r+i.{.s) ,. f1#,({.s)#,:c+i.{:s
    end.
    if. 2=opt do.
      stream__l=: stream__l,, (toHeader 16b0201, 6) ,("1) (_2]\ toWORD0 (-.f1)#({:s)#r+i.{.s) ,("1) (_2]\ toWORD0 (-.f1)#,({.s)#,:c+i.{:s) ,("1) (toWORD0 xf)
    end.
  else.
    adjdim__l 0{::y
    adjdim__l (<:s) + 0{::y
    stream__l=: stream__l,, (toHeader 16b027e, 10) ,("1) (_2]\ toWORD0 ({:s)#r+i.{.s) ,("1) (_2]\ toWORD0 ,({.s)#,:c+i.{:s) ,("1) (toWORD0 xf) ,("1) (_4]\ toDWORD0 ,yn)
    if. DEBUG do.
      rowcolused__l=: rowcolused__l, (({:s)#r+i.{.s) ,. ,({.s)#,:c+i.{:s
    end.
  end.
elseif. do. 'unhandled exception' 13!:8 (3)
end.
''
)

NB. write number to the current worksheet
NB. x xf
NB. y row col ; number [ ; option ]  (where 3>$$number)
NB. option 1: suppress zero   2: suppress zero but not format
writenumber=: 3 : 0
cxf writenumber y
:
assert. 2 3 e.~ #y
assert. 1 2 4 8 131072 e.~ (3!:0) 0{::y
assert. 1 4 8 e.~ (3!:0) 1{::y
if. 2 131072 e.~ 3!:0 rc=. 0{::y do. y=. (<A1toRC rc) 0}y end.
l=. sheeti{sheet
xf=. getxfidx x
if. (0:=#), yn=. 1{::y do. '' return. end.  NB. ignore null
if. 3=#y do. opt=. 2{::y else. opt=. 0 end.
if. 1=#@, yn do.  NB. singleton
  if. (1=opt) *. 0=1{::y do. '' return. end.
  adjdim__l 0{::y
  stream__l=: stream__l, xf biff_number ({.y), < {., yn
  if. DEBUG do.
    rowcolused__l=: rowcolused__l, ,0{::y
  end.
elseif. 3>$$yn do.
  if. 1=$$yn do. yn=. ,:yn end.
  s=. $yn
  'r c'=. 0{::y
  if. 0~:opt do.
    if. (1=opt) *. 0= +./ f1=. ,f=. 0~: <. 1{::y do. '' return. end.
    if. 1=opt do.
      mr=. 1 i.~ 1 e.("1) f
      mc=. 1 i.~ 1 e.("1) |:f
      adjdim__l (mr, mc) + 0{::y
      mr=. 1 i:~ 1 e.("1) f
      mc=. 1 i:~ 1 e.("1) |:f
      adjdim__l (mr, mc) + 0{::y
    else.
      adjdim__l 0{::y
      adjdim__l (<:s) + 0{::y
    end.
    stream__l=: stream__l,, (toHeader 16b0203, 14) ,("1) (_2]\ toWORD0 f1#({:s)#r+i.{.s) ,("1) (_2]\ toWORD0 f1#,({.s)#,:c+i.{:s) ,("1) (toWORD0 xf) ,("1) (_8]\ toDouble0 f1#,yn)
    if. DEBUG do.
      rowcolused__l=: rowcolused__l, (f1#({:s)#r+i.{.s) ,. f1#,({.s)#,:c+i.{:s
    end.
    if. 2=opt do.
      stream__l=: stream__l,, (toHeader 16b0201, 6) ,("1) (_2]\ toWORD0 (-.f1)#({:s)#r+i.{.s) ,("1) (_2]\ toWORD0 (-.f1)#,({.s)#,:c+i.{:s) ,("1) (toWORD0 xf)
    end.
  else.
    adjdim__l 0{::y
    adjdim__l s + 0{::y
    stream__l=: stream__l,, (toHeader 16b0203, 14) ,("1) (_2]\ toWORD0 ({:s)#r+i.{.s) ,("1) (_2]\ toWORD0 ,({.s)#,:c+i.{:s) ,("1) (toWORD0 xf) ,("1) (_8]\ toDouble0 ,yn)
    if. DEBUG do.
      rowcolused__l=: rowcolused__l, (({:s)#r+i.{.s) ,. ,({.s)#,:c+i.{:s
    end.
  end.
elseif. do. 'unhandled exception' 13!:8 (3)
end.
''
)

NB. write number to the current worksheet with format
NB. x xf
NB. y row col ; number ; format [ ; option ]   (where 3>$$number)
writenumber2=: 3 : 0
cxf writenumber2 y
:
assert. 3 4 e.~ #y
assert. 1 2 4 8 131072 e.~ (3!:0) 0{::y
assert. 1 4 8 e.~ (3!:0) 1{::y
assert. 2 131072 e.~ (3!:0) 2{::y
if. 2 131072 e.~ 3!:0 rc=. 0{::y do. y=. (<A1toRC rc) 0}y end.
l=. getxfobj x
t=. format__l
format__l=: 2{::y
if. 8= (3!:0) 1{::y do.
  l writenumber (2{.y), (4=#y)#{:y
else.
  l writeinteger (2{.y), (4=#y)#{:y
end.
format__l=: t
''
)

NB. write date to the current worksheet with format
NB. x xf
NB. y row col ; datenumber ; format   (where 3>$$datenumber)
writedate=: 3 : 0
cxf writedate y
:
assert. 2 3 e.~ #y
assert. 1 2 4 8 131072 e.~ (3!:0) 0{::y
assert. 1 4 8 e.~ (3!:0) 1{::y
if. 2 131072 e.~ 3!:0 rc=. 0{::y do. y=. (<A1toRC rc) 0}y end.
l=. getxfobj x
t=. format__l
if. 2=#y do. y=. y, <shortdatefmt end. NB. default date format
assert. 2 131072 e.~ (3!:0) 2{::y
format__l=: 2{::y
l writenumber ({.y), <36522-~ 1{::y
format__l=: t
''
)

NB. insert bitmap to the current worksheet
NB. x (row, col) ; (offsetx(in point, 1/72"), offsety(in character)) ; scalex, scaley
NB. y boxed bitmap file name or charachar data of bitmap
NB. return if success   0 ; ''
NB.        if fail     _1 ; 'reason for failure'
insertpicture=: 4 : 0
l=. sheeti{sheet
x insertpicture__l y
)

NB. insert bitmap as background for the current worksheet
NB. y boxed bitmap file name or charachar data of bitmap
NB. return if success   0 ; ''
NB.        if fail     _1 ; 'reson for failure'
insertbackground=: 3 : 0
l=. sheeti{sheet
insertbackground__l y
)

NB. builtin name
NB. 00H Consolidate_Area
NB. 01H Auto_Open
NB. 02H Auto_Close
NB. 03H Extract
NB. 04H Database
NB. 05H Criteria
NB. 06H Print_Area
NB. 07H Pint_Titles
NB. 08H Recorder
NB. 09H Data_Form
NB. 0AH Auto_Activate (BIFF5-BIFF8)
NB. 0BH Auto_Deactivate (BIFF5-BIFF8)
NB. 0CH Sheet_Title (BIFF5-BIFF8)
NB. 0DH _FilterDatabase (BIFF8)
NB. tmem 16b29
NB. tArea 16b3b
NB. tCellrangelist 16b10
NB. x supbook
NB.    _1 first call printarea, rowrepeat, colrepeat, rowcolrepeat
NB. y row1 row2 col1 col2
NB. return  supbook
printarea=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b06{a.
sheet__r=: 0
formula__r=: (a.{~16b3b 0 0), (0 0 0 0 cellrangeadr y)
x
)

NB. x supbook
NB.    _1 first call printarea, rowrepeat, colrepeat, rowcolrepeat
NB. y sheetidx row1 row2
NB. return  supbook
rowrepeat=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b07{a.
sheet__r=: {.y
formula__r=: (a.{~16b3b 0 0), 0 0 0 0 cellrangeadr, (}.y), 0 255
x
)

NB. x supbook
NB.    _1 first call printarea, rowrepeat, colrepeat, rowcolrepeat
NB. y sheetidx col1 col2
NB. return  supbook
colrepeat=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b07{a.
sheet__r=: {.y
formula__r=: (a.{~16b3b 0 0), 0 0 0 0 cellrangeadr 0 16bffff, (}.y)
x
)

NB. x supbook
NB.    _1 first call printarea, rowrepeat, colrepeat, rowcolrepeat
NB. y sheetidx row1 row2 col1 col2
NB. return  supbook
rowcolrepeat=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b07{a.
sheet__r=: {.y
formula__r=: (16b29{a.), (toWORD0@# , ]) ((a.{~16b3b 0 0), 0 0 0 0 cellrangeadr 0 16bffff, (>_2{.}.y)), ((a.{~16b3b 0 0), 0 0 0 0 cellrangeadr, (>2{.}.y), 0 255), (16b10{a.)
x
)

NB. ---------------------------------------------------------
NB. read numeric and string data from excel files
NB. written by bill lam
NB. ---------------------------------------------------------

coclass 'biffread'
coinsert 'oleutlfcn'
NB. x 0 normal  1 debug
NB. y stream data
create=: 4 : 0
debug=: x
stream=: y
biffver=: 0        NB. biff5/7 16b500   biff8 16b600
NB. biff2 16b200 biff3 16b300  biff4 16b400  (there is in fact no biffver stored)
streamtype=: 16    NB. worksheet 16
filepos=: 0
worksheets=: 0 2$''
bkrecords=: 0 3$'' [ bkbytes=: ''   NB. dump workbook for debug mode
records=: 0 3$'' [ bytes=: ''       NB. dump worksheet for debug mode
sst=: ''
bnsst=: nsst=: 0  NB. number of strings
sstchar=: 0
sstrtffe=: 0
insst=. 0
type=. _1
newptr=. 0
while. (type~:10)*.filepos<#stream do.
  'type ptr len'=. nextrecord ''
NB. dump records of workbook global to [bkbytes] with index held in [bkrecords]
  if. debug do.
    bkbytes=: bkbytes, (ptr+i.len){stream
    newptr=. newptr+len [ bkrecords=: bkrecords, type, newptr, len
  end.
  if. 16b9=type do.        NB. BOF record biff2
    biffver=: 16b200 break.
  elseif. 16b209=type do.  NB. BOF record biff3
    biffver=: 16b300 break.
  elseif. 16b409=type do.  NB. BOF record biff4
    biffver=: 16b400 break.
  elseif. 16b809=type do.  NB. BOF record
    if. 0=biffver do.  NB. only read the 1st BOF record in workbook
      'biffver streamtype'=: fromWORD0 4{.data=. (ptr+i.len){stream
    end.
  elseif. 16b0085=type do.  NB. boundsheet record
    if. 0={.fromBYTE 5{data=. (ptr+i.len){stream do.
      if. 16b500=biffver do.
        worksheets=: worksheets, (0 decodestring8 6}.data) ,< {.(fromDWORD0 4{.data)
      else.
        worksheets=: worksheets, (0 decodeustring8 6}.data) ,< {.(fromDWORD0 4{.data)
      end.
    end.
  elseif. 16b00fc=type do.  NB. sst record
    'bnsst nsst'=: fromDWORD0 8{.data=. (ptr+i.len){stream
    readsst 8}.data
    insst=. 1
  elseif. insst *. 16b003c=type do. NB. continue record after sst
    readsst data=. (ptr+i.len){stream
  elseif. do.
    insst=. 0
  end.
end.
if. #sst do. sst=: <;._2 sst end.
assert. nsst=#sst
assert. 0~:biffver
)

destroy=: codestroy
NB. parse string from sst record
readsst=: 3 : 0
fp=. 0
while. fp<#y do.
  if. 0=sstchar+sstrtffe do.
    't t1'=. fp decodeustring16 y
    sst=: sst, t, {.a.
    fp=. fp + a [ 'a b c'=. t1
    sstchar=: b-#t
    sstrtffe=: c
  else.
    't t1'=. (fp, sstchar, sstrtffe) decodeustring16a y
    sst=: (}:sst), t, {.a.
    fp=. fp + a [ 'a b c'=. t1
    sstchar=: sstchar-#t
    sstrtffe=: c
  end.
end.
)

NB. return record type, pointer to data buffer, length of data buffer
nextrecord=: 3 : 0
'type len'=. fromWORD0 (filepos+i.4){stream
filepos=: +/data=. (4+filepos), len
type, data
)

NB. byte string used in biff2/3/4/5/7
NB. assume no continue record
decodestring8=: 4 : 0
len=. {.fromBYTE (x+0){y
< len (([ <. #@]) {. ]) (x+1)}.y
)

decodestring16=: 4 : 0
len=. {.fromWORD0 (x+i.2){y
< len (([ <. #@]) {. ]) (x+2)}.y
)

NB. assume no continue record
decodeustring8=: 4 : 0
len=. {.fromBYTE (x+0){y
uc=. 0~:1 bitand op=. {.fromBYTE (x+1){y
fe=. 0~:4 bitand op
rtf=. 0~:8 bitand op
if. uc do.
  < fromucode0 (2*len) (([ <. #@]) {. ]) (x+2+(fe*4)+(rtf*2))}.y
else.
  < len (([ <. #@]) {. ]) (x+2+(fe*4)+(rtf*2))}.y
end.
)

decodeustring16=: 4 : 0
NB. len number of (unicode) character in string
NB. z decoded string
NB. p point to rtf/fe block
NB. p1 byte length of decoded string segment
NB. p2 number of pending bytes to be read in next record
NB. lenrtf rtf size in byte (4 bytes per block)
NB. lenfe  fe size in byte
len=. {.fromWORD0 (x+i.2){y
uc=. 0~:1 bitand op=. {.fromBYTE (x+2){y  NB. uncompress unicode
fe=. 0~:4 bitand op                         NB. #far east phonetic (4 byte)
rtf=. 0~:8 bitand op                        NB. #rtf format run (2 byte)
lenrtffe=. 0
if. rtf do. lenrtffe=. 4* {.fromWORD0 ((x+3)+i.2){y end.
if. fe do. lenrtffe=. lenrtffe + {.fromDWORD0 ((x+3+(rtf*2))+i.4){y end.
NB. p point to position of fe/rtf block if read
NB. p2 #byte in character array not yet read
l=. (3+(fe*4)+(rtf*2)) + (len*uc{1 2) + lenrtffe  NB. expect length if no further continue record need
if. uc do.
  z=. fromucode0 z1=. (2*len) (([ <. #@]) {. ]) (x+3+(fe*4)+(rtf*2))}.y
  z2=. (2*len)-#z1  NB. byte length of remaining character array
else.
  z=. z1=. len (([ <. #@]) {. ]) (x+3+(fe*4)+(rtf*2))}.y
  z2=. len-#z1  NB. byte length of remaining character array
end.
if. (#y)<x+l do.
  z ; (#y), len, (x+l)-z2+#y
else.
  z ; l, len, 0
end.
)

NB. the first splitted string in continue record
decodeustring16a=: 4 : 0
'x len lenrtffe'=. x
NB. there is no len for the first splitted string in continue record
NB. there is option byte the first splitted string in continue record
NB. but if length of remaining character array is zero, ie rtf/fe portion only
NB. then there will be no option byte
if. len do.
  uc=. 0~:1 bitand op=. {.fromBYTE (x+0){y
  l=. 1 + (len*uc{1 2) + lenrtffe  NB. expect length if no further continue record need
  if. uc do.
    z=. fromucode0 z1=. (2*len) (([ <. #@]) {. ]) (x+1)}.y
    z2=. (2*len)-#z1    NB. byte length of remaining character array
  else.
    z=. z1=. len (([ <. #@]) {. ]) (x+1)}.y
    z2=. len-#z1  NB. byte length of remaining character array
  end.
else.
  l=. lenrtffe  NB. expect length if no further continue record need
  z=. ''
  z2=. 0
end.
if. (#y)<x+l do.
  z ; (#y), len, (x+l)-z2+#y
else.
  z ; l, len, 0
end.
)

NB. x 1 convert all number to string
readsheet=: 0&$: : (4 : 0)
if. 16b200 16b300 16b400 e.~ biffver do.  NB. biff2/3/4
  filepos=: 0
  scnt=. _1
  sheetfound=. 0
else.
  filepos=: y
  sheetfound=. 1
end.
rowcolss=. rowcol=. rowcol4=. rowcol8=. rowcolc=. 0 2$''
cellvalss=. cellval=. cellval4=. cellval8=. cellvalc=. ''
null=. {.a.
type=. _1
records=: 0 3$'' [ bytes=: ''       NB. dump worksheet for debug mode
newptr=. 0
lookstr=. 0
while. filepos<#stream do.
  'type ptr len'=. nextrecord ''
NB. dump records of worksheet to [bytes] with index held in [records]
  if. debug do.
    bytes=: bytes, (ptr+i.len){stream
    newptr=. newptr+len [ records=: records, type, newptr, len
  end.
  if. 0=sheetfound do.  NB. biff2/3/4
    if. 16b0009 16b0209 16b0409 e.~ type do.  NB. biff2/3/4  BOF
      if. 16b10= fromWORD0 (2+ptr+i.2){stream do.  NB. worksheet stream
        if. y = scnt=. >:scnt do.         NB. test worksheet index wanted
          sheetfound=. 1
        end.
      end.
    end.
    continue.
  end.
  select. type
  case. 16b000a do. NB. EOF
    break.
  case. 16b027e do. NB. rk
    if. 0=x do.
      if. 8=3!:0 a=. >getrk 4}.data=. (ptr+i.len){stream do.
        rowcol8=. rowcol8, fromWORD0 4{.data
        cellval8=. cellval8, a
      else.
        rowcol4=. rowcol4, fromWORD0 4{.data
        cellval4=. cellval4, a
      end.
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, ; null&,@ (":(!.maxpp))&.> getrk 4}.data   NB. ieee double have at most 16 sig. digits
    end.
  case. 16b0002 do. NB. unsigned 16-bit integer biff2
    if. 0=x do.
      rowcol4=. rowcol4, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval4=. cellval4, {.fromDWORD0 (2#{.a.),~ (7+i.2){data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@": {.fromDWORD0 (2#{.a.),~ (7+i.2){data
    end.
  case. 16b0003 do. NB. number biff2
    if. 0=x do.
      rowcol8=. rowcol8, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval8=. cellval8, {.fromDouble0 (7+i.8){data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (7+i.8){data
    end.
  case. 16b0203 do. NB. number
    if. 0=x do.
      rowcol8=. rowcol8, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval8=. cellval8, {.fromDouble0 (6+i.8){data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (6+i.8){data
    end.
  case. 16b00fd do. NB. labelss
    rowcolss=. rowcolss, fromWORD0 4{.data=. (ptr+i.len){stream
    cellvalss=. cellvalss, fromDWORD0 (6+i.4){data
  case. 16b0005 do. NB. boolerr biff2
    if. ({.a.)=(8+ptr){stream do. NB. error code ignored
      if. 0=x do.
        rowcol4=. rowcol4, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval4=. cellval4, ({.a.)~:7{data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@": ({.a.)~:7{data
      end.
    end.
  case. 16b0205 do. NB. boolerr
    if. ({.a.)=(7+ptr){stream do. NB. error code ignored
      if. 0=x do.
        rowcol4=. rowcol4, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval4=. cellval4, ({.a.)~:6{data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@": ({.a.)~:6{data
      end.
    end.
  case. 16b00bd do. NB. multrk
    rocol=. fromWORD0 4{.data=. (ptr+i.len){stream
    lc=. fromWORD0 _2{.data
    nc=. >:lc-{:rocol
    if. 0=x do.
      v=. getrk("1) _6]\ _2}.4}.data
      for_rcl. rocol +("1) 0 ,("0) i.nc do.
        if. 8=3!:0 a=. >rcl_index{v do.
          rowcol8=. rowcol8, rcl
          cellval8=. cellval8, a
        else.
          rowcol4=. rowcol4, rcl
          cellval4=. cellval4, a
        end.
      end.
    else.
      rowcol=. rowcol, rocol +("1) 0 ,("0) i.nc
      cellval=. cellval, ; null&,@ (":(!.maxpp))&.> getrk("1) _6]\ _2}.4}.data
    end.
  case. 16b0006 do. NB. formula, only cached result read
    data=. (ptr+i.len){stream
    if. 16b200 = biffver do. NB. biff2
      if. (255 255{a.)-:13 14{data do.
        if. (0{a.)=7{data do. NB. string result
          lookrowcol=. fromWORD0 4{.data
          lookstr=. 2
        elseif. (1{a.)=7{data do. NB. boolerr
          if. 0=x do.
            rowcol4=. rowcol4, fromWORD0 4{.data
            cellval4=. cellval4, ({.a.)~:9{data
          else.
            rowcol=. rowcol, fromWORD0 4{.data
            cellval=. cellval, null&,@": ({.a.)~:9{data
          end.
        end.
      else.  NB. double
        if. 0=x do.
          rowcol8=. rowcol8, fromWORD0 4{.data
          cellval8=. cellval8, {.fromDouble0 (7+i.8){data
        else.
          rowcol=. rowcol, fromWORD0 4{.data
          cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (7+i.8){data
        end.
      end.
    else.
      if. (255 255{a.)-:12 13{data do.
        if. (0{a.)=6{data do. NB. string result
          lookrowcol=. fromWORD0 4{.data
          lookstr=. 2
        elseif. (1{a.)=6{data do. NB. boolerr
          if. 0=x do.
            rowcol4=. rowcol4, fromWORD0 4{.data
            cellval4=. cellval4, ({.a.)~:8{data
          else.
            rowcol=. rowcol, fromWORD0 4{.data
            cellval=. cellval, null&,@": ({.a.)~:8{data
          end.
NB. blank and multblank records may be ignore
NB.       elseif. (3{a.)=6{data do.  NB. blank
NB.         if. 0=x do.
NB.           rowcolc=. rowcolc, fromWORD0 4{.data
NB.           cellvalc=. cellvalc, null
NB.         else.
NB.           rowcol=. rowcol, fromWORD0 4{.data
NB.           cellval=. cellval, null
NB.         end.
        end.
      else.  NB. double
        if. 0=x do.
          rowcol8=. rowcol8, fromWORD0 4{.data
          cellval8=. cellval8, {.fromDouble0 (6+i.8){data
        else.
          rowcol=. rowcol, fromWORD0 4{.data
          cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (6+i.8){data
        end.
      end.
    end.
NB. string for formula result, assume no continue record
  case. 16b0007 do. NB. biff2
    if. 1=lookstr do.
      if. 0=x do.
        rowcolc=. rowcolc, lookrowcol
        cellvalc=. cellvalc, null&,@> {.0 decodestring8 data=. (ptr+i.len){stream
      else.
        rowcol=. rowcol, lookrowcol
        cellval=. cellval, null&,@> {.0 decodestring8 data=. (ptr+i.len){stream
      end.
    end.
NB. string for formula result, assume no continue record
  case. 16b0207 do.
    if. 1=lookstr do.
      if. 16b300 16b400 16b500 e.~ biffver do.  NB. biff3/4/5/7
        if. 0=x do.
          rowcolc=. rowcolc, lookrowcol
          cellvalc=. cellvalc, null&,@> {.0 decodestring16 data=. (ptr+i.len){stream
        else.
          rowcol=. rowcol, lookrowcol
          cellval=. cellval, null&,@> {.0 decodestring16 data=. (ptr+i.len){stream
        end.
      else.
        if. 0=x do.
          rowcolc=. rowcolc, lookrowcol
          cellvalc=. cellvalc, null&,@> {.0 decodeustring16 data=. (ptr+i.len){stream
        else.
          rowcol=. rowcol, lookrowcol
          cellval=. cellval, null&,@> {.0 decodeustring16 data=. (ptr+i.len){stream
        end.
      end.
    end.
NB. blank and multblank records may be ignore
NB.   case. 16b0201 do. NB. blank
NB.     if. 0=x do.
NB.       rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
NB.       cellvalc=. cellvalc, null
NB.     else.
NB.       rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
NB.       cellval=. cellval, null
NB.     end.
NB.   case. 16b00be do. NB. multblank
NB.     rocol=. fromWORD0 4{.data=. (ptr+i.len){stream
NB.     lc=. fromWORD0 _2{.data
NB.     nc=. >:lc-{:rocol
NB.     if. 0=x do.
NB.       rowcolc=. rowcolc, rocol +("1) 0 ,("0) i.nc
NB.       cellvalc=. cellvalc, nc#null
NB.     else.
NB.       rowcol=. rowcol, rocol +("1) 0 ,("0) i.nc
NB.       cellval=. cellval, nc#null
NB.     end.
  case. 16b0004 do. NB. biff2 label, assume no continue record
    if. 0=x do.
      rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
      cellvalc=. cellvalc, null&,@> {.0 decodestring8 7}.data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@> {.0 decodestring8 7}.data
    end.
NB. biff8 does not use label record, but excel will read it
  case. 16b0204 do. NB. label, assume no continue record
    if. 16b300 16b400 16b500 e.~ biffver do.  NB. biff3/4/5/7
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodestring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodestring16 6}.data
      end.
    else.
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodeustring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodeustring16 6}.data
      end.
    end.
NB. biff8 does not use rstring record, but excel will read it
  case. 16b00d6 do. NB. rstring, assume no continue record
    if. 16b300 16b400 16b500 e.~ biffver do.  NB. biff3/4/5/7
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodestring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodestring16 6}.data
      end.
    else.
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodeustring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodeustring16 6}.data
      end.
    end.
  end.
  lookstr=. 0>.<:lookstr
end.
if. 0=x do.
  (rowcol4, rowcol8, rowcolc, rowcolss) (;<) (<("0) cellval4), (<("0) cellval8), ( <;._1 cellvalc), sst{~cellvalss
else.
  (rowcol, rowcolss) (;<) ( <;._1 cellval), sst{~cellvalss
end.
)

NB. decode rk value
getrk=: 3 : 0
if. 0=2 bitand d=. fromDWORD0 2}.y do. NB. double
  bigendian=: ({.a.)={. 1&(3!:4) 1  NB. 0 little endian   1 big endian
  if. 0=bigendian do.
    rk=. fromDouble0 toDWORD0 0, d bitand DFH '0xfffffffc'
  else.
    rk=. fromDouble0 toDWORD0 0,~ d bitand DFH '0xfffffffc'
  end.
else.  NB. integer
  rk=. _2 bitsha d bitand DFH '0xfffffffc'
end.
if. 1 bitand d do.  NB. scale factor
  rk=. rk%100
end.
<{.rk
)

NB. ---------------------------------------------------------
NB. Covers for reading sheet(s) from an Excel workbook
NB. redeveloped by Ric Sherlock from original by bill lam
NB. ---------------------------------------------------------

NB.*readxlsheets v Reads one or more sheets from an Excel file
NB. returns: 2-column matrix with a row for each sheet
NB.       0{"1 boxed list of sheet names
NB.       1{"1 boxed list of boxed matrices of sheet contents
NB. y is: 1 or 2-item boxed list:
NB.       0{ filename of Excel workbook
NB.       1{ [default 0] optional switch to return all cells contents as strings
NB. x is: one of [default is 0]:
NB.       * numeric list of indicies of sheets to return
NB.       * boxed list of sheet names to return
NB.       * '' - return all sheets
NB. EG:   0 readxlsheets 'test.xls'
NB. reads Excel Versions 5, 95, 97, 2000, XP, 2003
NB. biff5  excel 5  biff7 excel 97   biff8 excel 97, xp, 2003
readxlsheets=: 3 : 0
0 readxlsheets y
:
try.
  'fln strng'=. 2{.!.(<0) boxopen y
  x=. boxopen x
  locs=. '' NB. store locales created
  (msg=. 'file not found') assert fexist fln
  locs=. locs,ole=. fln conew 'olestorage'
  if. 0=#wks=. getppssearch__ole 'Workbook' ; 1 ; 1 do.              NB. biff8
    if. 0=#wks=. getppssearch__ole 'Book' ; 1 ; 1 do.                NB. biff5/7
      (msg=. 'unknown Excel file format') assert 16b40009 16b60209 16b60409 e.~ fromDWORD0 freadx fln;0 4  NB. biff2/3/4
    end.
  end.
  locs=. locs,wks
  locs=. locs,ex=. conew 'biffread'
  if. #wks do.
    wk=. {.wks
    0&create__ex data__wk
NB. get worksheet location
    if. x-:<'' do.
      x=. i.#worksheets__ex
    elseif. -. */ 1 4 8 e.~ 3!:0 every x do.
      x=. x i.&(tolower&.>"_)~ {."1 worksheets__ex   NB. case insensitive worksheet name
    elseif. do. x=. >x NB. unbox numeric list
    end.
    (msg=. 'worksheet not found') assert x<#worksheets__ex
    'name location'=. |: x{worksheets__ex
  else.
    0&create__ex fread fln
    location=. {.>x
  end.
  'ix cell'=. <"1 |: ,:^:(1:=#@:$) strng&readsheet__ex"0 location NB. read worksheets
  for_l. |.locs do. NB. housekeeping
    destroy__l ''
    locs=. locs -. l
  end.
  rcs=. 0&>.@(>./ >:@- <./) each ix   NB. transform cell records to matrix
  offset_biffread_=: >{: off=. <./ each ix   NB. store offset in static class variable if needed
  ix=. ix -"1 each off
  m=. 0$0
  for_sht. cell do.
    n=. (sht_index{::rcs)$a:
    n=. (>sht) (<"1^:(0:<#) sht_index{::ix)} n
    m=. m,<n
  end.
  dtb=. #~ ([: +./\. ' '&~:)
  (<@dtb"1 name) ,. m
NB. convert excel date
NB. todate (+&36522) 38335 --> 2004 12 14
catch.
  for_l. |.locs do. NB. housekeeping
    destroy__l ''
    locs=. locs -. l
  end.
  smoutput 'readxlsheets: ',msg
end.
)

NB. stringtype v Ensures string type returned by appending <1 filename
stringtype=:  (<1) ,~ [: {. boxopen  
NB. firstsheet v Returns the first reference to a worksheet in x, or in the worksheet if no x.
firstsheet=: 0: :({.^:(3!:0 -.@e. 2 131072"_)@[) NB. 

NB.*readxlsheetsstring v Reads contents of one or more sheets from an Excel file as strings
NB. see readxlsheets
readxlsheetsstring=: 0&$: : ([ readxlsheets stringtype@])

NB.*readxlworkbook v Reads all sheets from an Excel file
NB. see readxlsheets
readxlworkbook=: ''&readxlsheets

NB.*readexcel v Reads contents of a sheet from an Excel file
NB. see readxlsheets
readexcel=: 0 _1 {:: firstsheet readxlsheets ]

NB.*readexcelstring v Reads contents of a sheet from an Excel file as strings
NB. see readxlsheets
readexcelstring=: 0 _1 {:: firstsheet readxlsheets stringtype@]

NB. ---------------------------------------------------------
NB.*readxlsheetnames v Reads sheet names from Excel workbook
NB. returns: boxed list of sheet names
NB. y is: Excel file name
NB. eg: readxlsheetnames 'test.xls'
NB. read Excel Versions 5, 95, 97, 2000, XP, 2003
NB. biff5  excel 5  biff7 excel 97   biff8 excel 97, xp, 2003
readxlsheetnames=: 3 : 0
try.
  fln=. boxopen y
  locs=. '' NB. store locales created
  (msg=. 'file not found') assert fexist fln
  locs=. locs,ole=. fln conew 'olestorage'
  if. 0=#wks=. getppssearch__ole 'Workbook' ; 1 ; 1 do.              NB. biff8
    if. 0=#wks=. getppssearch__ole 'Book' ; 1 ; 1 do.                NB. biff5/7
      (msg=. 'unknown Excel file format') assert 16b40009 16b60209 16b60409 e.~ fromDWORD0 freadx fln;0 4  NB. biff2/3/4
    end.
  end.
  locs=. locs,wks
  locs=. locs,ex=. conew 'biffread'
  if. #wks do.
    wk=. {.wks
    0&create__ex data__wk
  else.
    0&create__ex fread y
  end.
NB. read worksheet
  nms=. {."1 worksheets__ex
  for_l. |.locs do. destroy__l '' end. NB. housekeeping
  nms
catch.
  for_l. |.locs do. destroy__l '' end.
  smoutput 'readxlsheetnames: ',msg
end.
)

NB. cover function to dump worksheet
NB. sst shared string
NB. (bk)records= type index length
NB. (bk)bytes= byte stream for records
NB. x sheet index or name
NB. y Excel file name
NB. 0 dumpexcel 'test.xls'
dumpexcel=: 0&$: : (4 : 0)
assert. fexist y
ole=. (>y) conew 'olestorage'
if. 0=#wks=. getppssearch__ole 'Workbook' ; 1 ; 1 do.              NB. biff8
  if. 0=#wks=. getppssearch__ole 'Book' ; 1 ; 1 do.                NB. biff5/7
    assert. 16b40009 16b60209 16b60409 e.~ fromDWORD0 freadx y;0 4  NB. biff2/3/4
  end.
end.
ex=. conew 'biffread'
if. #wks do.
  wk=. {.wks
  1&create__ex data__wk       NB. 1=debug mode
NB. get worksheet location
  if. 2 131072 e.~ 3!:0 x do. x=. (<x) i.~ {.("1) worksheets__ex end.
  assert. x<#worksheets__ex
  'name location'=. x{worksheets__ex
else.
  1&create__ex fread y
  location=. x
end.
NB. get worksheet location
NB. read worksheet
'ix cell'=. 0&readsheet__ex location
NB. workbook global
sst__=: sst__ex
bkrecords__=: bkrecords__ex
bkbytes__=: bkbytes__ex
NB. worksheet
records__=: records__ex
bytes__=: bytes__ex
NB. housekeeping
destroy__ex ''
for_wk. wks do. destroy__wk '' end.
destroy__ole ''
''
)

NB.  populate z locale
readexcel_z_=: readexcel_biffread_
readexcelstring_z_=: readexcelstring_biffread_
dumpexcel_z_=: dumpexcel_biffread_
readxl_z_=: readexcel_biffread_
readxlstring_z_=: readexcelstring_biffread_
readxlsheetnames_z_=: readxlsheetnames_biffread_
readxlsheets_z_=: readxlsheets_biffread_
readxlsheetsstring_z_=: readxlsheetsstring_biffread_
readxlworkbook_z_=: readxlworkbook_biffread_
NB. =========================================================
NB. Cover for writing one or more arrays to sheets in an Excel workbook
NB. written by Ric Sherlock

coclass 'biffwrite'
coinsert 'biffbook'

NB. ---------------------------------------------------------
NB.*writexlsheets v Write arrays to sheets of Excel workbook
NB. returns: numeric 1 if successful.
NB. form: ([<sheetname(s)>],.<sheetcontent(s)>) writesheets <filename>
NB. y is: literal filename of workbook to create
NB. x is: One of;
NB.     * literal (data to write in topleft cell of Sheet1)
NB.     * numeric matrix (data to write to Sheet1)
NB.     * boxed (numeric/literal/mixed) matrix (data to write to Sheet1)
NB.     * 2-item/column vector/matrix,
NB.          Sheetnames in 1st item/col (literal)
NB.          Associated data formats (above) for sheetnames
NB. if <sheetname(s)> not given then defaults used
writexlsheets=: 4 : 0
  try.
    locs=. '' NB. store locales created
    if. 0=#x do. empty'' return. end. NB. if empty xarg then return.
    (msg=. 'too many levels of boxing') assert 2>:L. x
    msg=. 'error in left argument'
    shts=. makexarg x
    shtnme=. ((0 < #) {:: 'Sheet1'&;) (<0 0) {:: shts
    locs=. locs,bi=. ('Arial';220;shtnme) conew 'biffbook'
    shtdat=. (<0 1){:: shts
    msg=. 'error writing data for ',shtnme
    bi writeshtdat shtdat NB. write data for first worksheet
    shts=. }.shts         NB. drop first sheet from list
    msg=. 'error creating/writing later sheets'
    if. #shts do. bi addsheets"1 shts end. NB. add and write to rest of sheets
    binary=. save__bi y
    success=. destroy__bi ''
    (*#binary){:: success;binary
  catch.
    for_l. |.locs do. NB. housekeeping
      destroy__l ''
      locs=. locs -. l
    end.
    0 [ smoutput 'writexlsheets: ',msg
  end.
)

NB. ---------------------------------------------------------
NB. utils
mfv1=: ,:^:(#&$ = 1:)       NB. makes 1-row matrix from vector
mfva=: ,:^:([: 2&> #@$)^:_  NB. makes a matrix from an atom or vector
ischar=: 3!:0 e. 2 131072"_
firstones=: > 0: , }:
lastones=: > 0: ,~ }.
NB. indices=: $ #: I.@,   NB. get row,.col indices of 1s in matrix
indices=: 4:$.$.       NB. get row,.col indices of 1s in matrix
isrowblks=: >/@(+/^:(#&$)"_1) NB. are blocks row oriented

NB. isdata v Verb decides on type of x argument to writesheets
NB. returns 0 for array of names and data, 1 for single data matrix.
isdata=: 3 : 0
  if. 1< lvls=. L. y do. 0 return. NB. if 1<L.x must be multiple sheets
  elseif. 0= lvls do. 1 return. NB. if not boxed then must be data for single sheet
  elseif. 2< cols=. {:$ y do. 1 return. NB. if more than 2 items/cols then data for one sheet
  elseif. (-. *./(ischar&> +. a:&=) {."1 y) *. 2 = cols do. 1 return. NB. if 2 cols and not all 1st col contents are either literal or empty then must be data for one sheet
  elseif. 1< #@$ &> {:"1 y do. 0 return. NB. if any last col contents have rank greater than 1 then must be multiple sheets
  elseif. do. 1 NB. else assume that boxed data for one sheet
  end.
)

NB. makexarg v Ensures that xarg to writesheets has right form.
NB. returns: 2-item/column vector/array.
NB.       {."1 are sheetnames, {:"1 are boxed rank-2 arrays of sheetdata
makexarg=: 3 : 0
  if. isdata y do.
    if. 2= 3!:0 y do. y=. <y end.
    y=. a:,. <mfva y
  else.
    if. 2>{:$ y do. NB. if only 1 item/col add empty column of sheetnames
      y=. a:,.y
    end.
    if. #idx=. (I. b=. ischar &>{:"1 y) do.  NB. sheets with unboxed string data
      upd=. ({."1 ,. <&.>@({:"1)) b#y NB. boxed versions
      y=. upd idx }y
    end.
    if. #idx=. (I. b=. 2> #@$&>{:"1 y) do.  NB. sheets with unboxed string data
      upd=. ({."1 ,. mfva&.>@({:"1)) b#y NB. boxed versions
      y=. upd idx }y
    end.
  end.
  mfv1 y
)

NB. addsheets v Creates new sheet and writes data to it
NB. form: <wkbklocale> addSheets <sheetname>;<array>
addsheets=: 4 : 0
  'shtnme shtdat'=. y
  addsheet__x shtnme
  x writeshtdat shtdat
)

NB. writeshtdat v Writes array to current worksheet
NB. form: <wkbklocale> writeShtdat <array>
NB. Writes blocks of string data and numeric data separately
writeshtdat=: 4 : 0
  if. 0=L.y do.
    writenumber__x 0 0;y
  else.
    as=. ischar &> y
    blks=. blocks as
    tls=. {.0 2|: blks
    dat=. blks <;.0 y NB. blocks of char
    writestring__x"1 (<"1 tls),.dat
    blks=. blocks -.as
    tls=. {.0 2|: blks
    dat=. blks ([:<>);.0 y  NB. blocks of non-char
    writenumber__x"1 (<"1 tls),.dat
  end.
)

NB. ---------------------------------------------------------
NB. Find rectangular blocks of same type.
NB. 2d solution based on algorithm by RE Boss
NB. http://www.jsoftware.com/pipermail/programming/2008-June/011077.html

NB. blocks per row; top left in first and bottom right in last column!
tlc=: [: I. firstones      NB. column indices of toplefts
brc=: [: I. lastones       NB. column indices of bottomrights
tlbrc=: <@(tlc ,. brc)"1   NB. box by row
bpr=: i.@# ,:"0 1&.> tlbrc NB. laminate row indices

mtch=: 4 : 0
  's t'=. <"0 x (](#~; (#~-.)) e.~&:(<@{:"2))&> {.y
  t=. t((,&.>{:)`[)@.(1=#@])y
  s=. x([:(<@{:"2 ({:@{.@{:(<0 1)} {.)/.]) ,)&> s
  s;t
)

NB. rowwise blocks (topleft,:bottomright)
blcks=: [:|:"2 [:; [:mtch/ bpr

tlshape=: ([,: (-~>:))/"_1 NB. converts tl,:br to tl,:shape
blocks=: tlshape@:blcks  NB. rowwise merged blocks

NB. =========================================================
NB.  publish in z locale
writexlsheets_z_=: writexlsheets_biffwrite_
NB. other  crc32 128!:3
coclass 'biffmd4'

md4=: crc32_md4=: 3 : 0
z=. 2&(3!:4) 4{. 128!:3 y
assert. 16=#z
z
)

coclass 'biffsheet'
coinsert 'biff'

NB. =========================================================
NB. Methods related to comments and MSO objects.
NB. ported from CPAN Spreadsheet::WriteExcel
NB. portion Copyrighted by John McNamara, jmcnamara@cpan.org
NB.

NB.
NB. filename embedchart rowcol xy_offset xy_scale
NB.
NB. TODO.
NB.
embedchart=: 4 : 0
chart=. y
'rowcol xy_offset xy_scale'=. x
if. 2 131072 e.~ 3!:0 rowcol do. rowcol=. A1toRC rowcol end.
charts_array=: charts_array, rowcol ; chart ; xy_offset ; xy_scale
)

NB.
NB. filename insertimage rowcol xy_offset xy_scale
NB.
NB. Insert an image into the worksheet.
NB.
insertimage=: 4 : 0
img=. y
'rowcol xy_offset xy_scale'=. x
if. 2 131072 e.~ 3!:0 rowcol do. rowcol=. A1toRC rowcol end.
NB. image_id type width height will be filled when saving workbook
if. 32=3!:0 img do.
NB. img is filename
  if. -.fexist img do. 'file not exist' 13!:8 (3) end.
  images_array=: images_array, rowcol ; (>img) ; xy_offset ; xy_scale ; (16#{.a.) ; 0 ; 0 ; 0 0
else.
NB. img is data
  img=. (1&u: ::]) img  NB. force single byte
  assert. 2=3!:0 img
  images_array=: images_array, rowcol ; img ; xy_offset ; xy_scale ; (16#{:a.) ; 0 ; 0 ; 0 0
end.
''
)

NB. string writecomment rowcol ; opt_name ; opt_value .....
NB.
NB. Write a comment to the specified row and column (zero indexed).
NB. opt and default
NB. author ''
NB. color _1
NB. start_cell _1 _1
NB. start_col _1
NB. start_row _1
NB. visible _1
NB. width 128
NB. height 74
NB. x_offset _1
NB. x_scale 1
NB. y_offset _1
NB. y_scale 1
NB. return ''
writecomment=: 4 : 0

rowcol=. >@{. y=. boxopen y
opt=. }.y
string=. x
if. 2 131072 e.~ 3!:0 rowcol do. rowcol=. A1toRC rowcol end.

NB.  Check for pairs of optional arguments, i.e. an odd number of args.
if. 2|#,opt do. 'Uneven number of additional arguments' 13!:8 (3) end.

NB.  Check that row and col are valid and store max and min values
NB. if. check_dimensions rowcol do. _2 return. end.

NB.  We have to avoid duplicate comments in cells or else Excel will complain.
comments_array=: comments_array, comment_params (rowcol ; string), opt
''
)

NB.
NB. prepare_images
NB.
NB. Turn the HoH that stores the images into an array for easier handling.
NB.
prepare_images=: 3 : 0

NB. We sort the images by row and column but that isn't strictly required.
if. #images_array do.
  images_array=: images_array{~ /: > {.("1) images_array
end.
#images_array
)

NB.
NB. prepare_comments
NB.
NB. Turn the HoH that stores the comments into an array for easier handling.
NB.
prepare_comments=: 3 : 0

NB. We sort the comments by row and column but that isn't strictly required.
if. #comments_array do.
  comments_array=: comments_array{~ /: > {.("1) comments_array
end.
#comments_array
)

NB.
NB. prepare_charts
NB.
NB. Turn the HoH that stores the charts into an array for easier handling.
NB.
prepare_charts=: 3 : 0

NB. We sort the charts by row and column but that isn't strictly required.
if. #charts_array do.
  charts_array=: charts_array{~ /: > {.("1) charts_array
end.
#charts_array
)

NB. TODO
store_filtermode=: ''"_
store_autofilterinfo=: ''"_
store_autofilters=: ''"_

NB.
NB. store_images
NB.
NB. Store the collections of records that make up images.
NB.
store_images=: 3 : 0

recordtype=. 16b00ec                NB. Record identifier

spid=. {.object_ids

NB. Skip this if there aren't any images.
if. 0=#images_array do. '' return. end.

z=. ''
for_i. i.#images_array do.
  'rowcol name xy_offset xy_scale checksum image_id type widthheight'=. i{images_array
  'width height'=. widthheight
  'scale_x scale_y'=. xy_scale
  width=. <.width * (0~:scale_x){1, scale_x
  height=. <.height * (0~:scale_y){1, scale_y

NB. Calculate the positions of image object.
  vertices=. position_object rowcol, xy_offset, width, height

  if. 0=i do.
NB. Write the parent MSODRAWIING record.
    dg_length=. 72 + 84* #images_array
    spgr_length=. 48 + 84* #images_array

    dg_length=. dg_length + 120* #charts_array
    spgr_length=. spgr_length + 120* #charts_array

    dg_length=. dg_length + 96* filter_count
    spgr_length=. spgr_length + 96* filter_count

    dg_length=. dg_length + 92* #comments_array
    spgr_length=. spgr_length + 92* #comments_array

    data=. store_mso_dg_container dg_length
    data=. data, store_mso_dg }.object_ids
    data=. data, store_mso_spgr_container spgr_length
    data=. data, store_mso_sp_container 40
    data=. data, store_mso_spgr ''
    data=. data, store_mso_sp 0, spid, 16b0005
    spid=. >:spid
    data=. data, store_mso_sp_container 76
    data=. data, store_mso_sp 75, spid, 16b0a00
    spid=. >:spid
    data=. data, store_mso_opt_image image_id
    data=. data, store_mso_client_anchor 2 ; vertices
    data=. data, store_mso_client_data ''

    z=. z, biffappend data,~ toHeader recordtype, #data

  else.
NB. Write the child MSODRAWIING record.
    data=. store_mso_sp_container 76
    data=. data, store_mso_sp 75, spid, 16b0a00
    spid=. >:spid
    data=. data, store_mso_opt_image image_id
    data=. data, store_mso_client_anchor 2 ; vertices
    data=. data, store_mso_client_data ''

    z=. z, biffappend data,~ toHeader recordtype, #data

  end.

  z=. z, store_obj_image i+1
end.

object_ids=: spid 0}object_ids
z
)

NB.
NB. store_charts
NB.
NB. Store the collections of records that make up charts.
NB.
store_charts=: 3 : 0

recordtype=. 16b00ec                NB. Record identifier

spid=. {.object_ids

NB. Number of objects written so far.
num_objects=. #images_array

NB. Skip this if there aren't any charts.
if. 0=#charts_array do. '' return. end.

z=. ''
for_i. i.#charts_array do.
  'rowcol name xy_offset xy_scale'=. i{charts_array
  'width height'=. 526 319
  'scale_x scale_y'=. xy_scale
  width=. <.width * (0~:scale_x){1, scale_x
  height=. <.height * (0~:scale_y){1, scale_y

NB. Calculate the positions of chart object.
  vertices=. position_object rowcol, xy_offset, width, height

  if. (0=i) *. 0=num_objects do.
NB. Write the parent MSODRAWIING record.
    dg_length=. 72 + 120* #charts_array
    spgr_length=. 48 + 120* #charts_array

    dg_length=. dg_length + 96* filter_count
    spgr_length=. spgr_length + 96* filter_count

    dg_length=. dg_length + 92* #comments_array
    spgr_length=. spgr_length + 92* #comments_array

    data=. store_mso_dg_container dg_length
    data=. data, store_mso_dg }.object_ids
    data=. data, store_mso_spgr_container spgr_length
    data=. data, store_mso_sp_container 40
    data=. data, store_mso_spgr ''
    data=. data, store_mso_sp 0, spid, 16b0005
    spid=. >:spid
    data=. data, store_mso_sp_container 112
    data=. data, store_mso_sp 201, spid, 16b0a00
    spid=. >:spid
    data=. data, store_mso_opt_chart ''
    data=. data, store_mso_client_anchor 0 ; vertices
    data=. data, store_mso_client_data ''

    z=. z, biffappend data,~ toHeader recordtype, #data

  else.
NB. Write the child MSODRAWIING record.
    data=. store_mso_sp_container 112
    data=. data, store_mso_sp 201, spid, 16b0a00
    spid=. >:spid
    data=. data, store_mso_opt_chart ''
    data=. data, store_mso_client_anchor 0 ; vertices
    data=. data, store_mso_client_data ''

    z=. z, biffappend data,~ toHeader recordtype, #data

  end.

  z=. z, store_obj_chart num_objects+i+1
  store_chart_binary name
end.

NB. Simulate the EXTERNSHEET link between the chart and data using a formula
NB. such as '=Sheet1!A1'.
NB. TODO. Won't work for external data refs. Also should use a more direct
NB.       method.
NB.
formula=. '=', sheetname, '!A1'
NB. TODO formula
NB. store_formula formula

object_ids=: spid 0}object_ids
z
)

NB.
NB. store_chart_binary
NB.
NB. Add a binary chart object extracted from an Excel file.
NB.
store_chart_binary=: 3 : 0

if. _1-: z=. fread y do. 'Couldn''t open file in add_chart_ext' 13!:8 (3) end.
z=. biffappend z
)

NB.
NB. store_filters
NB.
NB. Store the collections of records that make up filters.
NB.
store_filters=: 3 : 0

recordtype=. 16b00ec                NB. Record identifier

spid=. {.object_ids

NB. Number of objects written so far.
num_objects=. (#images_array) + #charts_array

NB. Skip this if there aren't any filters.
if. 0=filter_count do. '' return. end.

'row1 row2 col1 col2'=. filter_area

z=. ''
for_i. i.filter_count do.

  vertices=. (col1 +i), 0, row1, 0, (col1 +i +1), 0, (row1 +1), 0

  if. (0=i) *. 0=num_objects do.
NB. Write the parent MSODRAWIING record.
    dg_length=. 72 + 96* filter_count
    spgr_length=. 48 + 96* filter_count

    dg_length=. dg_length + 92* #comments_array
    spgr_length=. spgr_length + 92* #comments_array

    data=. store_mso_dg_container dg_length
    data=. data, store_mso_dg }.object_ids
    data=. data, store_mso_spgr_container spgr_length
    data=. data, store_mso_sp_container 40
    data=. data, store_mso_spgr ''
    data=. data, store_mso_sp 0, spid, 16b0005
    spid=. >:spid
    data=. data, store_mso_sp_container 88
    data=. data, store_mso_sp 201, spid, 16b0a00
    spid=. >:spid
    data=. data, store_mso_opt_filter ''
    data=. data, store_mso_client_anchor 1 ; vertices
    data=. data, store_mso_client_data ''

    z=. z, biffappend data,~ toHeader recordtype, #data

  else.
NB. Write the child MSODRAWIING record.
    data=. store_mso_sp_container 88
    data=. data, store_mso_sp 201, spid, 16b0a00
    spid=. >:spid
    data=. data, store_mso_opt_filter ''
    data=. data, store_mso_client_anchor 1 ; vertices
    data=. data, store_mso_client_data ''

    z=. z, biffappend data,~ toHeader recordtype, #data

  end.

  z=. z, store_obj_filter (num_objects+i+1), col1 +i
end.

NB. Simulate the EXTERNSHEET link between the filter and data using a formula
NB. such as '=Sheet1!A1'.
NB. TODO. Won't work for external data refs. Also should use a more direct
NB.       method.
NB.
formula=. '=', sheetname, '!A1'
z=. z, store_formula formula

object_ids=: spid 0}object_ids
z
)

NB.
NB. store_comments
NB.
NB. Store the collections of records that make up cell comments.
NB.
NB. NOTE: We write the comment objects last since that makes it a little easier
NB. to write the NOTE records directly after the MSODRAWIING records.
NB.
store_comments=: 3 : 0

recordtype=. 16b00ec                NB. Record identifier

spid=. {.object_ids

NB. Number of objects written so far.
num_objects=. (#images_array) + filter_count + #charts_array

NB. Skip this if there aren't any comments.
if. 0=#comments_array do. '' return. end.

z=. ''
for_i. i.#comments_array do.
  'rowcol str author visible color vertices'=. i{comments_array
  formats=. 0 5 ,: (#str), 0
  if. (0=i) *. 0=num_objects do.
NB. Write the parent MSODRAWIING record.
    dg_length=. 72 + 92* #comments_array
    spgr_length=. 48 + 92* #comments_array

    data=. store_mso_dg_container dg_length
    data=. data, store_mso_dg }.object_ids
    data=. data, store_mso_spgr_container spgr_length
    data=. data, store_mso_sp_container 40
    data=. data, store_mso_spgr ''
    data=. data, store_mso_sp 0, spid, 16b0005
    spid=. >:spid
    data=. data, store_mso_sp_container 84
    data=. data, store_mso_sp 202, spid, 16b0a00
    spid=. >:spid
    data=. data, store_mso_opt_comment visible
    data=. data, store_mso_client_anchor 3 ; vertices
    data=. data, store_mso_client_data ''

    z=. z, biffappend data,~ toHeader recordtype, #data

  else.
NB. Write the child MSODRAWIING record.
    data=. store_mso_sp_container 84
    data=. data, store_mso_sp 202, spid, 16b0a00
    spid=. >:spid
    data=. data, store_mso_opt_comment visible
    data=. data, store_mso_client_anchor 3 ; vertices
    data=. data, store_mso_client_data ''

    z=. z, biffappend data,~ toHeader recordtype, #data

  end.

  z=. z, store_obj_comment num_objects+i+1
  z=. z, store_mso_drawing_text_box ''
  z=. z, store_txo #str
  z=. z, store_txo_continue_1 str
  z=. z, store_txo_continue_2 formats
end.

NB. Write the NOTE records after MSODRAWIING records.
for_i. i.#comments_array do.
  'rowcol str author visible color vertices'=. i{comments_array
  z=. z, store_note rowcol ; (num_objects+i+1) ; author ; visible
end.
z
)

NB.
NB. store_mso_dg_container
NB.
NB. Write the Escher DgContainer record that is part of MSODRAWING.
NB.
store_mso_dg_container=: 3 : 0

type=. 16bf002
version=. 15
'' add_mso_generic type, version, 0, y
)

NB.
NB. store_mso_dg
NB.
NB. Write the Escher Dg record that is part of MSODRAWING.
NB.
store_mso_dg=: 3 : 0

type=. 16bf008
version=. 0
'instance num_shapes max_spid'=. y
data=. toDWORD0 num_shapes, max_spid
data add_mso_generic type, version, instance, #data
)

NB.
NB. store_mso_spgr_container
NB.
NB. Write the Escher SpgrContainer record that is part of MSODRAWING.
NB.
store_mso_spgr_container=: 3 : 0

type=. 16bf003
version=. 15
'' add_mso_generic type, version, 0, y
)

NB.
NB. store_mso_sp_container
NB.
NB. Write the Escher SpContainer record that is part of MSODRAWING.
NB.
store_mso_sp_container=: 3 : 0

type=. 16bf004
version=. 15
'' add_mso_generic type, version, 0, y
)

NB.
NB. store_mso_spgr
NB.
NB. Write the Escher Spgr record that is part of MSODRAWING.
NB.
store_mso_spgr=: 3 : 0

type=. 16bf009
version=. 1
data=. toDWORD0 0 0 0 0
data add_mso_generic type, version, 0, #data
)

NB.
NB. store_mso_sp
NB.
NB. Write the Escher Sp record that is part of MSODRAWING.
NB.
store_mso_sp=: 3 : 0

type=. 16bf00a
version=. 2
'instance spid options'=. y
data=. toDWORD0 spid, options
data add_mso_generic type, version, instance, #data
)

NB.
NB. store_mso_opt
NB.
NB. Write the Escher Opt record that is part of MSODRAWING.
NB.
store_mso_opt=: 3 : 0

type=. 16bf00b
version=. 3
instance=. 9

length=. 54   NB. Bytes to follow

'spid visible color'=. 3{.y, 16b50

NB. Use the visible flag if set by the user or else use the worksheet value.
NB. Note that the value used is the opposite of store_note.

if. _1~:visible do.
  hidden=. (0=visible) { 16b0000 16b0002
else.
  hidden=. (0=comments_visible) { 16b0000 16b0002
end.

data=. toDWORD0 spid
data=. data, toBYTE 16b00, 16b00, 16bbf, 16b00, 16b08, 16b00, 16b08, 16b00, 16b58, 16b01, 16b00, 16b00, 16b00, 16b00, 16b81, 16b01
data=. data, toBYTE color
data=. data, toBYTE 16b00, 16b00, 16b08, 16b83, 16b01, 16b50, 16b00, 16b00, 16b08, 16bbf, 16b01, 16b10, 16b00, 16b11, 16b00, 16b01, 16b02, 16b00, 16b00, 16b00, 16b00, 16b3f, 16b02, 16b03, 16b00, 16b03, 16b00, 16bbf, 16b03
data=. data, toWORD0 hidden
data=. data, toBYTE 16b0a, 16b00

assert. length = #data
data add_mso_generic type, version, instance, #data
)

NB.
NB. store_mso_opt_image
NB.
NB. Write the Escher Opt record that is part of MSODRAWING.
NB.
store_mso_opt_image=: 3 : 0

type=. 16bf00b
version=. 3
instance=. 3

length=. 6 * instance   NB. Bytes to follow

spid=. y

data=. toWORD0 16b4104                 NB. Blip -> pib
data=. data, toDWORD0 spid
data=. data, toWORD0 16b01bf           NB. Fill Style -> fNoFillHitTest
data=. data, toDWORD0 16b00010000
data=. data, toWORD0 16b03bf           NB. Group Shape -> fPrint
data=. data, toDWORD0 16b00080000

assert. length = #data
data add_mso_generic type, version, instance, #data
)

NB.
NB. store_mso_opt_chart
NB.
NB. Write the Escher Opt record that is part of MSODRAWING.
NB.
store_mso_opt_chart=: 3 : 0

type=. 16bf00b
version=. 3
instance=. 9

length=. 6 * instance   NB. Bytes to follow

data=. toWORD0 16b007f                  NB. Protection -> fLockAgainstGrouping
data=. data, toDWORD0 16b01040104

data=. data, toWORD0 16b00bf            NB. Text -> fFitTextToShape
data=. data, toDWORD0 16b00080008

data=. data, toWORD0 16b0181            NB. Fill Style -> fillColor
data=. data, toDWORD0 16b0800004e

data=. data, toWORD0 16b0183            NB. Fill Style -> fillBackColor
data=. data, toDWORD0 16b0800004d

data=. data, toWORD0 16b01bf            NB. Fill Style -> fNoFillHitTest
data=. data, toDWORD0 16b00110010

data=. data, toWORD0 16b01c0            NB. Line Style -> lineColor
data=. data, toDWORD0 16b0800004d

data=. data, toWORD0 16b01ff            NB. Line Style -> fNoLineDrawDash
data=. data, toDWORD0 16b00080008

data=. data, toWORD0 16b023f            NB. Shadow Style -> fshadowObscured
data=. data, toDWORD0 16b00020000

data=. data, toWORD0 16b03bf            NB. Group Shape -> fPrint
data=. data, toDWORD0 16b00080000

assert. length = #data
data add_mso_generic type, version, instance, #data
)

NB.
NB. store_mso_opt_filter
NB.
NB. Write the Escher Opt record that is part of MSODRAWING.
NB.
store_mso_opt_filter=: 3 : 0

type=. 16bf00b
version=. 3
instance=. 5

length=. 6 * instance   NB. Bytes to follow

data=. toWORD0 16b007f                  NB. Protection -> fLockAgainstGrouping
data=. data, toDWORD0 16b01040104

data=. data, toWORD0 16b00bf            NB. Text -> fFitTextToShape
data=. data, toDWORD0 16b00080008

data=. data, toWORD0 16b01bf            NB. Fill Style -> fNoFillHitTest
data=. data, toDWORD0 16b00010000

data=. data, toWORD0 16b01ff            NB. Line Style -> fNoLineDrawDash
data=. data, toDWORD0 16b00080000

data=. data, toWORD0 16b03bf            NB. Group Shape -> fPrint
data=. data, toDWORD0 16b000a0000

assert. length = #data
data add_mso_generic type, version, instance, #data
)

NB.
NB. store_mso_opt_comment
NB.
NB. Write the Escher Opt record that is part of MSODRAWING.
NB.
store_mso_opt_comment=: 3 : 0

type=. 16bf00b
version=. 3
instance=. 3

length=. 6 * instance   NB. Bytes to follow

visible=. y

NB. Use the visible flag if set by the user or else use the worksheet value.
NB. Note that the value used is the opposite of store_note.
if. _1~:visible do.
  hidden=. (0=visible) { 16b0000 16b0002
else.
  hidden=. (0=comments_visible) { 16b0000 16b0002
end.

data=. toWORD0 16b0080            NB. Text -> lTxid
data=. data, toDWORD0 0
data=. data, toWORD0 16b03be            NB. Group Shape -> fHidden
data=. data, toWORD0 hidden, 16b0002
data=. data, toWORD0 16b03bf            NB. Group Shape -> fPrint
data=. data, toWORD0 16b0002, 16b0002

assert. length = #data
data add_mso_generic type, version, instance, #data
)

NB.
NB. store_mso_client_anchor
NB.
NB. Write the Escher ClientAnchor record that is part of MSODRAWING.
NB.
store_mso_client_anchor=: 3 : 0

type=. 16bf010
version=. 0

'flag vertices'=. y
'col_start x1 row_start y1 col_end x2 row_end y2'=. vertices
NB. col_start Col containing upper left corner of object
NB. x1 Distance to left side of object

NB. row_start Row containing top left corner of object
NB. y1 Distance to top of object

NB. col_end Col containing lower right corner of object
NB. x2 Distance to right side of object

NB. row_end Row containing bottom right corner of object
NB. y2 Distance to bottom of object

data=. toWORD0 flag, col_start, x1, row_start, y1, col_end, x2, row_end, y2

data add_mso_generic type, version, 0, #data
)

NB.
NB. store_mso_client_data
NB.
NB. Write the Escher ClientData record that is part of MSODRAWING.
NB.
store_mso_client_data=: 3 : 0

type=. 16bf011
version=. 0
'' add_mso_generic type, version, 0, 0
)

NB.
NB. store_obj_comment
NB.
NB. Write the OBJ record that is part of cell comments.
NB.
store_obj_comment=: 3 : 0

recordtype=. 16b005d        NB. Record identifier
length=. 16b0034            NB. Bytes to follow

obj_id=. y                  NB. Object ID number.
obj_type=. 16b0019          NB. Object type (comment).

options=. 16b4011
reserved=. 16b0000

NB. Add ftCmo (common object data) subobject
sub_recordtype=. 16b0015             NB. ftCmo
sub_data=. toWORD0 obj_type, obj_id, options
sub_data=. sub_data, toDWORD0 reserved, reserved, reserved
assert. 16b0012 = #sub_data
data=. sub_data,~ toHeader sub_recordtype, #sub_data

NB. Add ftNts (note structure) subobject
sub_recordtype=. 16b000d             NB. ftNts
sub_data=. toDWORD0 5#reserved
sub_data=. sub_data, toWORD0 reserved
assert. 16b0016 = #sub_data
data=. data, sub_data,~ toHeader sub_recordtype, #sub_data

NB. Add ftEnd (end of object) subobject
sub_recordtype=. 16b0000                 NB. ftNts
data=. data, toHeader sub_recordtype, 0

assert. length = #data
NB. Pack the record.
z=. biffappend data,~ toHeader recordtype, length
)

NB.
NB. store_obj_image
NB.
NB. Write the OBJ record that is part of image records.
NB.
store_obj_image=: 3 : 0

recordtype=. 16b005d        NB. Record identifier
length=. 16b0026            NB. Bytes to follow

obj_id=. y                  NB. Object ID number.
obj_type=. 16b0008          NB. Object type (Picture).

options=. 16b6011
reserved=. 16b0000

NB. Add ftCmo (common object data) subobject
sub_recordtype=. 16b0015             NB. ftCmo
sub_data=. toWORD0 obj_type, obj_id, options
sub_data=. sub_data, toDWORD0 reserved, reserved, reserved
assert. 16b0012 = #sub_data
data=. sub_data,~ toHeader sub_recordtype, #sub_data

NB. Add ftCf (Clipboard format) subobject
sub_recordtype=. 16b0007             NB. ftCf
sub_data=. toWORD0 16bffff
assert. 16b0002 = #sub_data
data=. data, sub_data,~ toHeader sub_recordtype, #sub_data

NB. Add ftPioGrbit (Picture option flags) subobject
sub_recordtype=. 16b0008                  NB. ftPioGrbit
sub_data=. toWORD0 16b0001
assert. 16b0002 = #sub_data
data=. data, sub_data,~ toHeader sub_recordtype, #sub_data

NB. Add ftEnd (end of object) subobject
sub_recordtype=. 16b0000                 NB. ftNts
data=. data, toHeader sub_recordtype, 0

assert. length = #data
NB. Pack the record.
z=. biffappend data,~ toHeader recordtype, length
)

NB.
NB. store_obj_chart
NB.
NB. Write the OBJ record that is part of chart records.
NB.
store_obj_chart=: 3 : 0

recordtype=. 16b005d        NB. Record identifier
length=. 16b001a            NB. Bytes to follow

obj_id=. y                  NB. Object ID number.
obj_type=. 16b0005          NB. Object type (chart).

options=. 16b6011
reserved=. 16b0000

NB. Add ftCmo (common object data) subobject
sub_recordtype=. 16b0015             NB. ftCmo
sub_data=. toWORD0 obj_type, obj_id, options
sub_data=. sub_data, toDWORD0 reserved, reserved, reserved
assert. 16b0012 = #sub_data
data=. sub_data,~ toHeader sub_recordtype, #sub_data

NB. Add ftEnd (end of object) subobject
sub_recordtype=. 16b0000                 NB. ftNts
data=. data, toHeader sub_recordtype, 0

assert. length = #data
NB. Pack the record.
z=. biffappend data,~ toHeader recordtype, length
)

NB.
NB. store_obj_filter
NB.
NB. Write the OBJ record that is part of filter records.
NB.
store_obj_filter=: 3 : 0

recordtype=. 16b005d        NB. Record identifier
length=. 16b0046        NB. Bytes to follow

'obj_id col'=. y        NB. Object ID number.
obj_type=. 16b0014        NB. Object type (combo box).

options=. 16b2101
reserved=. 16b0000

NB. Add ftCmo (common object data) subobject
sub_recordtype=. 16b0015             NB. ftCmo
sub_data=. toWORD0 obj_type, obj_id, options
sub_data=. sub_data, toDWORD0 reserved, reserved, reserved
assert. 16b0012 = #sub_data
data=. sub_data,~ toHeader sub_recordtype, #sub_data

NB. Add ftSbs Scroll bar subobject
sub_recordtype=. 16b000c             NB. ftSbs
sub_data=. toBYTE 16b00, 16b00, 16b00, 16b00, 16b00, 16b00, 16b00, 16b00, 16b64, 16b00, 16b01, 16b00, 16b0a, 16b00, 16b00, 16b00, 16b10, 16b00, 16b01, 16b00
assert. 16b0014 = #sub_data
data=. data, sub_data,~ toHeader sub_recordtype, #sub_data

NB. Add ftLbsData (List box data) subobject
sub_recordtype=. 16b0013             NB. ftLbsData
NB. Special case (undocumented).

NB. If the filter is active we set one of the undocumented flags.

if. col e. >{.("1) filter_cols do.
  sub_data=. toBYTE 16b00, 16b00, 16b00, 16b00, 16b01, 16b00, 16b01, 16b03, 16b00, 16b00, 16b0a, 16b00, 16b08, 16b00, 16b57, 16b00
else.
  sub_data=. toBYTE 16b00, 16b00, 16b00, 16b00, 16b01, 16b00, 16b01, 16b03, 16b00, 16b00, 16b02, 16b00, 16b08, 16b00, 16b57, 16b00
end.

assert. 16b1fee = #sub_data
data=. data, sub_data,~ toHeader sub_recordtype, #sub_data

NB. Add ftEnd (end of object) subobject
sub_recordtype=. 16b0000                 NB. ftNts
data=. data, toHeader sub_recordtype, 0

assert. length = #data
NB. Pack the record.
z=. biffappend data,~ toHeader recordtype, length
)

NB.
NB. store_mso_drawing_text_box
NB.
NB. Write the MSODRAWING ClientTextbox record that is part of comments.
NB.
store_mso_drawing_text_box=: 3 : 0

recordtype=. 16b00ec                NB. Record identifier
length=. 16b0008                NB. Bytes to follow

data=. store_mso_client_text_box ''

assert. length = #data
z=. biffappend data,~ toHeader recordtype, length
)

NB.
NB. store_mso_client_text_box
NB.
NB. Write the Escher ClientTextbox record that is part of MSODRAWING.
NB.
store_mso_client_text_box=: 3 : 0

type=. 16bf00d
version=. 0

'' add_mso_generic type, version, 0, 0
)

NB.
NB. store_txo
NB.
NB. Write the worksheet TXO record that is part of cell comments.
NB.
store_txo=: 3 : 0

recordtype=. 16b01b6               NB. Record identifier
length=. 16b0012                   NB. Bytes to follow
'string_len format_len rotation'=. 3{.y
format_len=. (2>#y){format_len, 16          NB. default format_len rotation: 16 0
NB. string_len Length of the note text.
NB. format_len Length of the format runs.
NB. rotation Options
grbit=. 16b0212                  NB. Options
reserved=. 16b0000                  NB. Options

NB. Pack the record.
data=. toWORD0 grbit, rotation
data=. data, toDWORD0 reserved
data=. data, toWORD0 reserved, string_len, format_len
data=. data, toDWORD0 reserved

assert. length = #data
z=. biffappend data,~ toHeader recordtype, length
)

NB.
NB. store_txo_continue_1
NB.
NB. Write the first CONTINUE record to follow the TXO record. It contains the
NB. text data.
NB.
store_txo_continue_1=: 3 : 0

recordtype=. 16b003c         NB. Record identifier
string=. y                   NB. Comment string.
if. encoding=. 2~: 3!:0 string do.  NB. Encoding of the string.
  string=. toucode0 string
end.
NB. Split long comment strings into smaller continue blocks if necessary.
NB. We can't let add_continue handled this since an extra
NB. encoding byte has to be added similar to the SST block.
NB.
NB. We make the limit size smaller than the add_continue size and even
NB. so that UTF16 chars occur in the same block.
NB.
limit=. RECORDLEN-6  NB. 8218
z=. ''
while. limit<#string do.
  string=. limit}.string [ tmp_str=. limit{.string
  z=. z, biffappend data,~ toHeader recordtype, #data=. tmp_str,~ toBYTE encoding
end.

NB. Pack the record.
z=. z, biffappend data,~ toHeader recordtype, #data=. string,~ toBYTE encoding
)

NB.
NB. store_txo_continue_2
NB.
NB. Write the second CONTINUE record to follow the TXO record. It contains the
NB. formatting information for the string.
NB.
store_txo_continue_2=: 3 : 0

recordtype=. 16b003c                   NB. Record identifier
formats=. y                   NB. Formatting information

NB. Pack the record.
data=. ''
for_aref. formats do.
  data=. data, toWORD0 aref
  data=. data, toDWORD0 16b0
end.
z=. biffappend data,~ toHeader recordtype, #data
)

NB.
NB. store_note
NB.
NB. Write the worksheet NOTE record that is part of cell comments.
NB.
store_note=: 3 : 0

recordtype=. 16b001c                   NB. Record identifier
length=. 16b000c                   NB. Bytes to follow
'rowcol obj_id author visible'=. y
author=. (''-:author){:: author ; comments_author

NB. Use the visible flag if set by the user or else use the worksheet value.
NB. The flag is also set in store_mso_opt but with the opposite value.
NB.
if. _1~:visible do.
  hidden=. (0=visible) { 16b0002 16b0000
else.
  hidden=. (0=comments_visible) { 16b0002 16b0000
end.

NB. Get the number of chars in the author string (not bytes).
num_chars=. #author

NB. Null terminate the author string.
author=. author, {.a.

NB. Pack the record.
data=. toWORD0 rowcol, hidden, obj_id, num_chars
if. 2= (3!:0) author do.
  data=. data, toBYTE 0
  z=. biffappend (data, author),~ toHeader recordtype, (#data) + #author
else.
  data=. data, toBYTE 1
  z=. biffappend (data, author),~ toHeader recordtype, (#data) + #author=. toucode0 author
end.
z
)

defcommentparams=: 0 : 0
author ''
color _1
start_cell _1 _1
start_col _1
start_row _1
visible _1
width 128
height 74
x_offset _1
x_scale 1
y_offset _1
y_scale 1
)

NB.
NB. comment_params
NB.
NB. This method handles the additional optional parameters to write_comment as
NB. well as calculating the comment object position and vertices.
NB.
comment_params=: 3 : 0

'rowcol string'=. 2{.y

NB. Overwrite the defaults with any user supplied values. Incorrect or
NB. misspelled parameters are silently ignored.
nm=. (<'params_'),&.> {.("1) nmv=. (_2]\ 2}.y),~ ;:;._2 defcommentparams
(, (1&u: :: ])&.> nm)=. ".&.>{:("1) nmv

NB. Ensure that a width and height have been set.
params_width=. (0<:params_width){ params_width, 128
params_height=. (0<:params_height){ params_height, 74

NB. Limit the string to the max number of chars (not bytes).
max_len=. 32767
if. max_len < #string do. string=. max_len{.string end.

NB. Set the comment background color.
color=. params_color
color=. color
color=. (color=16b7fff){ color, 16b50   NB. Default color.
params_color=. color

NB. Convert a cell reference to a row and column.
if. _1 _1-.@-:params_start_cell do.
  if. 2 131072 e.~ 3!:0 params_start_cell do. params_start_cell=. A1toRC params_start_cell end.
  rowcol=. 'params_start_row params_start_col'=. params_start_cell
end.

'row col'=. rowcol

NB. Set the default start cell and offsets for the comment. These are
NB. generally fixed in relation to the parent cell. However there are
NB. some edge cases for cells at the edges.
NB.
if. _1=params_start_row do.
  if. 0=col do. params_start_row=. 0
  elseif. 65533=row do. params_start_row=. 65529
  elseif. 65534=row do. params_start_row=. 65530
  elseif. 65535=row do. params_start_row=. 65531
  elseif. do. params_start_row=. row -1
  end.
end.

if. _1=params_y_offset do.
  if. 0=row do. params_y_offset=. 2
  elseif. 65533=row do. params_y_offset=. 4
  elseif. 65534=row do. params_y_offset=. 4
  elseif. 65535=row do. params_y_offset=. 2
  elseif. do. params_y_offset=. 7
  end.
end.

if. _1=params_start_col do.
  if. 253=col do. params_start_col=. 250
  elseif. 254=col do. params_start_col=. 251
  elseif. 255=col do. params_start_col=. 252
  elseif. do. params_start_col=. col +1
  end.
end.

if. _1=params_x_offset do.
  if. 253=col do. params_x_offset=. 49
  elseif. 254=col do. params_x_offset=. 49
  elseif. 255=col do. params_x_offset=. 49
  elseif. do. params_x_offset=. 15
  end.
end.

NB. Scale the size of the comment box if required.
if. params_x_scale do.
  params_width=. <. params_width * params_x_scale
end.

if. params_y_scale do.
  params_height=. <. params_height * params_y_scale
end.

NB. Calculate the positions of comment object.
vertices=. position_object params_start_col, params_start_row, params_x_offset, params_y_offset, params_width, params_height

(row, col) ; string ; params_author ; params_visible ; params_color ; vertices
)

NB. =========================================================

coclass 'biffbook'
coinsert 'biff'

NB.
NB. Methods related to comments and MSO objects.
NB.

NB.
NB. filename embedchart rowcol xy_offset xy_scale
NB.
NB. TODO.
NB.

embedchart=: 4 : 0
l=. sheeti{sheet
x embedchart__l y
)

NB.
NB. filename insertimage rowcol xy_offset xy_scale
NB.
NB. Insert an image into the worksheet.
NB.
NB. x (row, col) ; (offsetx(in point, 1/72"), offsety(in character)) ; scalex, scaley
NB. y boxed image file name or charachar data of image
NB. return ''
insertimage=: 4 : 0
l=. sheeti{sheet
x insertimage__l y
)

NB. string writecomment rowcol ; opt_name ; opt_value .....
NB.
NB. Write a comment to the specified row and column (zero indexed).
NB. opt and default
NB. author ''
NB. color _1
NB. start_cell _1 _1
NB. start_col _1
NB. start_row _1
NB. visible _1
NB. width 128
NB. height 74
NB. x_offset _1
NB. x_scale 1
NB. y_offset _1
NB. y_scale 1
NB. return ''
writecomment=: 4 : 0
l=. sheeti{sheet
x writecomment__l y
)

NB.
NB. add_mso_drawing_group
NB.
NB. Write the MSODRAWINGGROUP record that keeps track of the Escher drawing
NB. objects in the file such as images, comments and filters.
NB.
add_mso_drawing_group=: 3 : 0

if. 0=mso_size do. '' return. end.

recordtype=. 16b00eb               NB. Record identifier

data=. store_mso_dgg_container ''
data=. data, store_mso_dgg mso_clusters
data=. data, store_mso_bstore_container ''
for_im. images_data do. data=. data, store_mso_images im end.
data=. data, store_mso_opt ''
data=. data, store_mso_split_menu_colors ''

header=. toHeader recordtype, #data

z=. add_mso_drawing_group_continue header, data
NB. header, data    NB. For testing only.
z
)

NB.
NB. add_mso_drawing_group_continue
NB.
NB. See first the Spreadsheet::WriteExcel::BIFFwriter::_add_continue() method.
NB.
NB. Add specialised CONTINUE headers to large MSODRAWINGGROUP data block.
NB. We use the Excel 97 max block size of 8228 - 4 bytes for the header =. 8224.
NB.
NB. The structure depends on the size of the data block:
NB.
NB.     Case 1:  <=   8224 bytes      1 MSODRAWINGGROUP
NB.     Case 2:  <= 2*8224 bytes      1 MSODRAWINGGROUP + 1 CONTINUE
NB.     Case 3:  >  2*8224 bytes      2 MSODRAWINGGROUP + n CONTINUE
NB.
add_mso_drawing_group_continue=: 3 : 0

data=. y
limit=. RECORDLEN  NB. 8228 -4
mso_group=. 16b00eb    NB. Record identifier
continue=. 16b003c    NB. Record identifier
block_count=. 1

NB. Ignore the base class add_continue() method.

NB. Case 1 above. Just return the data as it is.
if. (#data) <: limit do.
  z=. 1&biffappend data
  return.
end.

z=. ''
NB. Change length field of the first MSODRAWINGGROUP block. Case 2 and 3.
data=. (limit+4)}.data [ tmp=. (limit+4){.data
tmp=. (toWORD0 limit) 2 3}tmp
z=. z, 1&biffappend tmp

NB. Add MSODRAWINGGROUP and CONTINUE blocks for Case 3 above.
while. (#data) > limit do.
  if. (block_count = 1) do.
NB. Add extra MSODRAWINGGROUP block header.
    header=. toHeader mso_group, limit
    block_count=. >:block_count
  else.
NB. Add normal CONTINUE header.
    header=. toHeader continue, limit
  end.

  data=. limit}.data [ tmp=. limit{.data
  z=. z, 1&biffappend header, tmp
end.

NB. Last CONTINUE block for remaining data. Case 2 and 3 above.
z=. z, 1&biffappend data,~ toHeader continue, #data

NB. Turn the base class add_continue() method back on.
z
)

NB.
NB. store_mso_dgg_container
NB.
NB. Write the Escher DggContainer record that is part of MSODRAWINGGROUP.
NB.
store_mso_dgg_container=: 3 : 0

type=. 16bf000
version=. 15
data=. ''
length=. mso_size -12    NB. -4 (biff header) -8 (for this).

data add_mso_generic type, version, 0, length
)

NB.
NB. store_mso_dgg
NB.
NB. Write the Escher Dgg record that is part of MSODRAWINGGROUP.
NB.
store_mso_dgg=: 3 : 0

type=. 16bf006
version=. 0

'max_spid num_clusters shapes_saved drawings_saved clusters'=. y

data=. toDWORD0 max_spid, num_clusters, shapes_saved, drawings_saved

data=. data, toDWORD0 ,clusters

data add_mso_generic type, version, 0, #data  NB. Calculate length automatically.
)

NB.
NB. store_mso_bstore_container
NB.
NB. Write the Escher BstoreContainer record that is part of MSODRAWINGGROUP.
NB.
store_mso_bstore_container=: 3 : 0

if. 0=images_size do. '' return. end.

type=. 16bf001
version=. 15
instance=. #images_data    NB. Number of images.
data=. ''
length=. images_size +8 *instance

data add_mso_generic type, version, instance, length
)

NB.
NB. store_mso_images
NB.
NB. Write the Escher BstoreContainer record that is part of MSODRAWINGGROUP.
NB.
store_mso_images=: 3 : 0

'ref_count image_type image size checksum1 checksum2'=. y

blip_store_entry=. store_mso_blip_store_entry ref_count ; image_type ; size ; checksum1

blip=. store_mso_blip image_type ; image ; size ; checksum1 ; checksum2

blip_store_entry , blip
)

NB.
NB. store_mso_blip_store_entry
NB.
NB. Write the Escher BlipStoreEntry record that is part of MSODRAWINGGROUP.
NB.
store_mso_blip_store_entry=: 3 : 0

'ref_count image_type size checksum1'=. y

type=. 16bf007
version=. 2
instance=. image_type
length=. size +61
data=. toBYTE image_type   NB. Win32
data=. data, toBYTE image_type   NB. Mac
data=. data, checksum1           NB. Uid checksum
data=. data, toWORD0 16bff          NB. Tag
data=. data, toDWORD0 size +25     NB. Next Blip size
data=. data, toDWORD0 ref_count    NB. Image ref count
data=. data, toDWORD0 16b00000000    NB. File offset
data=. data, toBYTE 16b00          NB. Usage
data=. data, toBYTE 16b00          NB. Name length
data=. data, toBYTE 16b00          NB. Unused
data=. data, toBYTE 16b00          NB. Unused

NB. for this record, length ~: #data
data add_mso_generic type, version, instance, length
)

NB.
NB. store_mso_blip
NB.
NB. Write the Escher Blip record that is part of MSODRAWINGGROUP.
NB.
store_mso_blip=: 3 : 0

'image_type image_data size checksum1 checksum2'=. y

if. image_type = 5 do. instance=. 16b046a end.   NB. JFIF
if. image_type = 6 do. instance=. 16b06e0 end.   NB. PNG
if. image_type = 7 do. instance=. 16b07a9 end.   NB. BMP 16b07a8 +1 because 2 uid for bmp

NB. BMPs contain an extra checksum for the stripped data.
if. ( image_type = 7) do.
  checksum1=. checksum2, checksum1
end.

type=. 16bf018 + image_type
version=. 16b0000
length=. size +17
data=. checksum1          NB. Uid checksum
data=. data, toBYTE 16bff       NB. Tag
data=. data, image_data            NB. Image

assert. length=#data
data add_mso_generic type, version, instance, length
)

NB.
NB. store_mso_opt
NB.
NB. Write the Escher Opt record that is part of MSODRAWINGGROUP.
NB.
store_mso_opt=: 3 : 0

type=. 16bf00b
version=. 3

data=. toBYTE 16bfb, 16b00, 16b80, 16b00, 16b80, 16b00, 16b18, 16b10, 16b90, 16b00, 16b00, 16b80, 16b0c, 16b10, 16b04, 16b00, 16b00, 16b80
data add_mso_generic type, version, 3, #data
)

NB.
NB. store_mso_split_menu_colors
NB.
NB. Write the Escher SplitMenuColors record that is part of MSODRAWINGGROUP.
NB.
store_mso_split_menu_colors=: 3 : 0

type=. 16bf11e
version=. 0

data=. toBYTE 16bd0, 16b00, 16b00, 16b80, 16bc0, 16b00, 16b00, 16b80, 16b71, 16b00, 16b00, 16b80, 16b7f, 16b00, 16b00, 16b01
data add_mso_generic type, version, 4, #data
)

NB.
NB. calc_sheet_offsets
NB.
NB. Calculate Worksheet BOF offsets records for use in the BOUNDSHEET records.
NB.
calc_sheet_offsets=: 3 : 0

BOF=. 12
EOF=. 4
offset=. datasize

NB. Add the length of the SST and associated CONTINUEs
offset=. offset + calculate_shared_string_sizes ''

NB. Add the length of the SUPBOOK, EXTERNSHEET and NAME records
offset=. offset + calculate_extern_sizes ''

NB. Add the length of the MSODRAWINGGROUP records including an extra 4 bytes
NB. for any CONTINUE headers. See add_mso_drawing_group_continue.
offset=. offset + mso_size + 4 * <.(mso_size -1) % limit

for_wsheet. sheet do.
  offset=. offset + BOF + #name__wsheet   NB. SUSPENSE  byte or characters
end.

offset=. offset + EOF

for_wsheet. sheet do.
NB.   sheetoffset__wsheet=: offset      NB. use original method
  offset=. offset + datasize__wsheet
end.

biffsize=: offset
)

NB.
NB. calc_mso_sizes
NB.
NB. Calculate the MSODRAWINGGROUP sizes and the indexes of the Worksheet
NB. MSODRAWING records.
NB.
NB. In the following SPID is shape id, according to Escher nomenclature.
NB.
calc_mso_sizes=: 3 : 0

msoSize=. 0     NB. Size of the MSODRAWINGGROUP record
start_spid=. 1024  NB. Initial spid for each sheet
max_spid=. 1024  NB. spidMax
num_clusters=. 1     NB. cidcl
shapes_saved=. 0     NB. cspSaved
drawings_saved=. 0     NB. cdgSaved
clusters=. 0 2$''

process_images ''

NB. Add Bstore container size if there are images.
msoSize=. msoSize + (0~:#images_data){0 8

NB. Iterate through the worksheets, calculate the MSODRAWINGGROUP parameters
NB. and space required to store the record and the MSODRAWING parameters
NB. required by each worksheet.

for_wsheet. sheet do.
  if. 'biffsheet' -.@-: >@coinstance wsheet do. continue. end.

  if. 0= num_shapes=. (#images_array__wsheet) + filter_count__wsheet + (prepare_comments__wsheet '') + (prepare_charts__wsheet '') do. continue. end.

NB. Include 1 parent MSODRAWING shape, per sheet, in the shape count.
  shapes_saved=. shapes_saved + num_shapes=. 1 + num_shapes
  msoSize=. msoSize + image_mso_size__wsheet

NB. Add a drawing object for each sheet with comments.
  drawings_saved=. >:drawings_saved

NB. For each sheet start the spids at the next 1024 interval.
  max_spid=. 1024 * 1 + <.(max_spid -1)%1024
  start_spid=. max_spid

NB. Max spid for each sheet and eventually for the workbook.
  max_spid=. max_spid + num_shapes

NB. Store the cluster ids
  i=. num_shapes
  while. i > 0 do.
    num_clusters=. num_clusters + 1
    msoSize=. msoSize + 8
    size=. (i <: 1024) { 1024, i
    clusters=. clusters, drawings_saved, size
    i=. i - 1024
  end.

NB. Pass calculated values back to the worksheet
  object_ids__wsheet=: start_spid, drawings_saved, num_shapes, max_spid -1
end.

NB. Calculate the MSODRAWINGGROUP size if we have stored some shapes.
mso_size=: msoSize + (0~:msoSize){0 86  NB. Smallest size is 86+8=94
mso_clusters=: max_spid ; num_clusters ; shapes_saved ; drawings_saved ; clusters
)

NB.
NB. process_images
NB.
NB. We need to process each image in each worksheet and extract information.
NB. Some of this information is stored and used in the Workbook and some is
NB. passed back into each Worksheet. The overall size for the image related
NB. BIFF structures in the Workbook is calculated here.
NB.
NB. MSO size =.  8 bytes for bstore_container +
NB.            44 bytes for blip_store_entry +
NB.            25 bytes for blip
NB.          =. 77 + image size.
NB.
process_images=: 3 : 0

images_seen=. 0 4$''
imageData=. 0 0$''
image_id=. 1
imageSize=. 0

for_wsheet. sheet do.
  if. 'biffsheet' -.@-: >@coinstance wsheet do. continue. end.
  if. 0=prepare_images__wsheet '' do. continue. end.

  image_msoSize=. 0
  imagesArray=. 0 0$''
  for_imageref. images_array__wsheet do.
NB. For each Worksheet image we get a structure like this
NB. [
NB.   row col,
NB.   name,
NB.   x_offset y_offset,
NB.   scale_x scale_y,
NB. ]
NB. And we add additional information:
NB.   checksum,
NB.   image_id,
NB.   type,
NB.   width height
    if. (16#{.a.)-: 4{::imageref do.
      filename=. 1{imageref
      if. _1-: data=. fread filename do.
        'Couldn''t import file' 13!:8 (3)
      end.
    elseif. (16#{:a.)-: 4{::imageref do.
      data=. 1{:: imageref
    elseif. do.
      'unhandled exception' 13!:8 (3)
    end.

    if. ({.("1)images_seen) -.@e.~ <ck=. image_checksum data do.
NB. match seen images based on checksum.

NB. Slurp the file into a string and do some size calcs.
      size=. #data
      checksum1=. image_checksum data
      checksum2=. checksum1
      ref_count=. 1

NB. Process the image and extract dimensions.
      if. (}.4{.data) -: 'PNG' do.
        'type width height'=. process_png data

      elseif. (2{.data) -: 'BM' do.
        'type width height'=. process_bmp data
NB. The 14 byte header of the BMP is stripped off.
        data=. 14}.data
NB. A checksum of the new image data is also required.
        checksum2=. image_checksum data

NB. Adjust size -14 (header) + 16 (extra checksum).
        size=. size + 2

      elseif. do.
        if. 0 0 0 -: 'type width height'=. process_jfif data do.
          'Unsupported image format for file' 13!:8 (3)
        end.
      end.

NB. Push the new data back into the Worksheet array
      imagesArray=. imagesArray, (_4}.imageref), checksum1 ; image_id ; type ; width, height

NB. Store information required by the Workbook.
      imageData=. imageData, ref_count ; type ; data ; size ; checksum1 ; checksum2

NB. Keep track of overall data size.
NB. Also store new data for use in duplicate images.
      imageSize=. imageSize + size +61  NB. Size for bstore container.
      image_msoSize=. image_msoSize + size +69  NB. Size for dgg container.

      images_seen=. images_seen, checksum1 ; image_id ; type ; width, height
      image_id=. >:image_id
    else.
NB. We've processed this file already.
      index=. ({.("1)images_seen) i. <ck

NB. Increase image reference count.
      imageData=. (>:&.> (<index, 0){imageData) (<index, 0)}imageData

NB. Add previously calculated data back onto the Worksheet array.
NB. image_id, type, width, height

      imagesArray=. imagesArray, (_4}.imageref), index{images_seen
    end.
  end.

NB. Store information required by the Worksheet.
  assert. (#imagesArray) = #images_array__wsheet
  images_array__wsheet=: imagesArray
  image_mso_size__wsheet=: image_msoSize
end.

NB. Store information required by the Workbook.
images_size=: imageSize
images_data=: imageData  NB. Store the data for MSODRAWINGGROUP.
)

NB.
NB. image_checksum
NB.
NB. Generate a checksum for the image using whichever module is available..The
NB. available modules are checked in get_checksum_method. Excel uses an MD4
NB. checksum but any other will do. In the event of no checksum module being
NB. available we simulate a checksum using the image index.
NB.
image_checksum=: 3 : 0

md4_biffmd4_ y
)

NB.
NB. process_jfif
NB.
NB. Extract width and height information from a JFIF file.
NB.
process_jfif=: 3 : 0

type=. 5  NB. Excel Blip type (MSOBLIPTYPE).

if. 1 e. a=. (16bff 16bd8 16bff{a.) E. y do.
  p=. 2+ a i. 1
  try.
    while. do.
      while. -. ((16bff{a.)=p{y) *. (16bff{a.)~:(p+1){y do.
        p=. p+1
      end.
      p=. p+1
      if. (p{y) e. 16bc0 16bc1 16bc2 16bc3 16bc5 16bc6 16bc7 16bc9 16bca 16bcb 16bcd 16bce 16bcf{a. do.
        break.
      end.
      p=. p + (a.i.(p+2){y)+ 256 * a.i.(p+1){y
    end.
    h=. (a.i.(p+5){y)+ 256 * a.i.(p+4){y
    w=. (a.i.(p+7){y)+ 256 * a.i.(p+6){y
    depth=. 8 * a.i.(p+8){y
    type, w, h
  catch.
    0 0 0
  end.
else.
  0 0 0
end.
)

NB.
NB. process_png
NB.
NB. Extract width and height information from a PNG file.
NB.
process_png=: 3 : 0

type=. 6  NB. Excel Blip type (MSOBLIPTYPE).
'width height'=. fromDWORD1 (16+i.8){y

type, width, height
)

NB.
NB. process_bmp
NB.
NB. Extract width and height information from a BMP file.
NB.
NB. Most of these checks came from the old Worksheet::_process_bitmap method.
NB.
process_bmp=: 3 : 0

data=. y
type=. 7 NB. Excel Blip type (MSOBLIPTYPE).

NB. Check that the file is big enough to be a bitmap.
if. (#data) <: 16b36 do.
  'file: doesn''t contain enough data.' 13!:8 (3)
end.

NB. Read the bitmap width and height. Verify the sizes.
'width height'=. fromDWORD0 (18+i.8){data

if. (width > 16bffff) do.
  'file: largest image width width supported is 65k.' 13!:8 (3)
end.

if. (height > 16bffff) do.
  'file: largest image height supported is 65k.' 13!:8 (3)
end.

NB. Read the bitmap planes and bpp data. Verify them.
'planes bitcount'=. fromWORD0 (26+i.4){data

NB. if. (bitcount ~: 24) do.
NB.   'filename isn''t a 24bit true color bitmap.' 13!:8 (3)
NB. end.

if. (planes ~: 1) do.
  'file: only 1 plane supported in bitmap image.' 13!:8 (3)
end.

NB. Read the bitmap compression. Verify compression.
compression=. fromDWORD0 (30+i.4){data

if. (compression ~: 0) do.
  'file: compression not supported in bitmap image.' 13!:8 (3)
end.

type, width, height
)

NB.
NB. end of Methods related to comments and MSO objects.
NB. =========================================================
