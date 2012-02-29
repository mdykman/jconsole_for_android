NB. section/employee/region database

require 'data/jdb'

NB. utilities
dtb=: #~ +./\.@(' '&~:)
fixcols=: 0&".@>each@{`[`]} [: <"1 [: |: <@dtb;._1;._2
nestcols=: 4 : '(<x{y) ({.x) } (<<<}.x) { y'
showx=: smoutput@". [ smoutput@('   '&,)
NB. =========================================================
NB. Tables
NB.                          r(rno,name;popul)
NB.                          |
NB.               s(sno,sdiv,rnum;name)
NB.               |
NB.       e(ename,secnum)
NB.       |
NB. t(tno,enum,tname,tsize)

NB. table: r(rno,name;popul)
RCols=: 0 : 0
  rno   int
  name  varchar;
  popul int
)

RData=: 0 2 fixcols 0 : 0
|4|Naples|1000
|5|Rome  |2000
|6|Naples|2000
)

NB. table: s(sno,sdiv,rnum;name)
SCols=: 0 : 0
  sno  int
  sdiv varchar
  rnum r;
  name varchar
)

SData=: 2 3 nestcols 0 2 fixcols 0 : 0
|31|Auto |4|Naples|Sales
|31|Truck|6|Naples|Clerical
|33|Truck|5|Rome  |Engineering
|34|Auto |6|Naples|Clerical
|35|Auto |4|Naples|Marketing
)

NB. table: e(ename,secnum)
ECols=: 0 : 0
  ename varchar
  secnum s
)

j=. 1 3 fixcols 0 : 0
|Smith    |34|Auto |6|Naples
|Jones    |33|Truck|5|Rome
|Robinson |34|Auto |6|Naples
|Jasper   |33|Truck|5|Rome
|Steinberg|33|Truck|5|Rome
|Rafferty |31|Auto |4|Naples
)

EData=: (0{j),<(1 2{j),<3 4{ j

NB. table: t(tno,enum,tname,tsize)
NB. enum maps to e autoid (since no key fields in e)
TCols=: 0 : 0
  tno   int
  enum  e
  tname char
  tsize varchar;
  tcat  byte
)

TData=: 0 1 fixcols 0 : 0
|11|2|Desk   |small |A
|12|4|Cabinet|medium|B
|13|1|Chair  |small |A
|14|2|Cabinet|medium|R
)

TData=: (<>>2{TData) 2} TData
TData=: (<;>4{TData) 4} TData
NB. build

NB. =========================================================
NB. buildsed v build and open SED database
buildsed=: 3 : 0
  f=. Open_jdb_ y
  Drop__f 'sed'
  d=. Create__f 'sed'
  Create__d 'r';RCols;<RData
  NB. create d data separately:
  Create__d 's';SCols
  Insert__d 's';<SData
  NB. create e all separately:
  Create__d 'e'
  InsertCols__d 'e';ECols
  Insert__d 'e';<EData
  Create__d 't';TCols;<TData
  destroy__f''
)

NB. =========================================================
initsed=: 3 : 0
  buildsed y
  resetall_jdb_''
  opensed y
)

NB. =========================================================
opensed=: 3 : 0
  f=. Open_jdb_ y
  locD=: Open__f 'sed'
  i.0 0
)

NB. =========================================================
closesed=: 3 : 0
  destroy__locD ''
)
NB. run

NB. =========================================================
NB. DBPATH is a directory name, e.g.
NB.   demosed ''  or  run by line: Ctrl+E
DBPATH=: jpath'~temp'

demosed=: (showx;._2) bind (0 : 0)
  initsed DBPATH
  Reads__locD 'from r'
  Reads__locD 'from s'
  Reads__locD 'from e'
  Reads__locD 'from t'
  Reads__locD 'ename,sno,sdiv,rno,r.name,s.name from e'
  Reads__locD 'ename,sno,sdiv,rno,r.name,s.name from e where r.name=Rome'
  Reads__locD '** from e where r.name=Rome'
  Reads__locD '*+ from e where sdiv=Auto'
  Reads__locD 'tno,ename,r.name from t'
)



