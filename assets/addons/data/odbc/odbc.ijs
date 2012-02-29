
3 : 0''
if. IFJ6 do.
  script_z_ '~system\main\dates.ijs'
  script_z_ '~system\main\dll.ijs'
  script_z_ '~system\main\files.ijs'
  script_z_ '~system\main\strings.ijs'
end.
EMPTY
)

coclass 'jdd'

InitDone=: 0
UseErrRet=: 0
UseDayNo=: 0
UseUnicode=: 0

create=: 3 : 0
if. 0=InitDone do.
  InitDone_jdd_=: 1
end.
settypeinfo 0
initodbcenv 0
''
)

destroy=: 3 : 0
endodbcenv 0
codestroy''
)
setzlocale=: 3 : 0
wrds=. 'ddsrc ddtbl ddtblx ddcol ddcon dddis ddfch ddend ddsel ddcnm dderr'
wrds=. wrds, ' dddrv ddsql ddcnt ddtrn ddcom ddrbk ddbind ddfetch'
wrds=. wrds ,' dddata ddfet ddbtype ddcheck ddrow ddins ddparm ddsparm dddbms ddcolinfo ddttrn'
wrds=. >;: wrds ,' dddriver ddconfig'

cl=. '_jdd_'
". (wrds ,"1 '_z_ =: ',"1 wrds ,"1 cl) -."1 ' '

if. 0=InitDone_jdd_ do.
  InitDone_jdd_=: 1
end.
settypeinfo 0
endodbcenv 0
initodbcenv 0

EMPTY
)
3 : 0''
select. UNAME
case. 'Linux' do. libodbc=: 'libodbc.so.1'
case. 'Darwin' do. libodbc=: 'libiodbc.dylib'
case. do. libodbc=: 'odbc32'
end.
i.0 0
)
sqlallochandle=: (libodbc, ' SQLAllocHandle s s x *x') &cd
sqlbindcol=: (libodbc, ' SQLBindCol s x s s * x *') &cd
sqlbindparameter=: (libodbc, ' SQLBindParameter s x s s s s x s * i *') &cd
sqlbulkoperations=: (libodbc, ' SQLBulkOperations s x s') &cd
sqlcolumns=: (libodbc, ' SQLColumns s x * s * s *c s * s') &cd
sqlconnect=: (libodbc, ' SQLConnect s x *c s *c s *c s') &cd
sqldatasources=: (libodbc, ' SQLDataSources s x s *c s *s *c s *s') &cd
sqldescribecol=: (libodbc, ' SQLDescribeCol s x s *c s *s *s *x *s *s') &cd
sqldisconnect=: (libodbc, ' SQLDisconnect s x') &cd
sqldriverconnect=: (libodbc, ' SQLDriverConnect s x x *c s *c s *s s') &cd
sqldrivers=: (libodbc, ' SQLDrivers s x s *c s *s *c s *s') &cd
sqlendtran=: (libodbc, ' SQLEndTran s s x s') &cd
sqlexecdirect=: (libodbc, ' SQLExecDirect s x *c i') &cd
sqlexecute=: (libodbc, ' SQLExecute s x') &cd
sqlfetch=: (libodbc, ' SQLFetch s x') &cd
sqlfetchscroll=: (libodbc, ' SQLFetchScroll s x s x') &cd
sqlfreehandle=: (libodbc, ' SQLFreeHandle s s x') &cd
sqlgetdata=: (libodbc, ' SQLGetData s x s s * x *x') &cd
sqlgetdiagrec=: (libodbc, ' SQLGetDiagRec s s x s *c *i *c s *s') &cd
sqlgetinfo=: (libodbc, ' SQLGetInfo s x s * s *s') &cd
sqlnumresultcols=: (libodbc, ' SQLNumResultCols s x *s') &cd
sqlprepare=: (libodbc, ' SQLPrepare s x *c i') &cd
sqlrowcount=: (libodbc, ' SQLRowCount s x *x') &cd
sqlsetconnectattr=: (libodbc, ' SQLSetConnectAttr s x i x i') &cd
sqlsetenvattr=: (libodbc, ' SQLSetEnvAttr s x i x i') &cd
sqlsetstmtattr=: (libodbc, ' SQLSetStmtAttr s x i x i') &cd
sqltables=: (libodbc, ' SQLTables s x *c s *c s *c s *c s') &cd
sqlcolattribute=: (libodbc, ' SQLColAttribute s x s s *c s *s *') &cd
ISI01=: 'ISI01 Too many connections'  
ISI02=: 'ISI02 Too many statements'   
ISI03=: 'ISI03 Bad connection handle'
ISI04=: 'ISI04 Bad statement handle'
ISI05=: 'ISI05 Not a select command'
ISI06=: 'ISI06 Transactions not supported'
ISI07=: 'ISI07 Bad transaction state'
ISI08=: 'ISI08 Bad arguments'         
ISI09=: 'ISI09 Unsupported data type'
ISI10=: 'ISI10 Unable to bind all columns'
ISI11=: 'ISI11 Unable to initialize ODBC environment'
ISI12=: 'ISI12 Unable to set 3.x ODBC version'
ISI13=: 'ISI13 SQL errors fetching row'
ISI14=: 'ISI14 Not implemented'
ISI15=: 'ISI15 Driver limitation'
ISI16=: 'ISI16 Shared library error'
ISI17=: 'ISI17 Out of memory'
ISI18=: 'ISI18 Database file not found'
ISI19=: 'ISI19 Unable to open database'
ISI50=: 'ISI50 Incorrect number of columns'
ISI51=: 'ISI51 Incorrect data type'
ISI52=: 'ISI52 Incorrect base table'
ISI53=: 'ISI53 No column in query result'
ISI54=: 'ISI54 Column ordinal number error'
ISI55=: 'ISI55 Unable to map data type to ODBC data type'
ISI56=: 'ISI56 Unable to handle parameterized query'
SQLST_WARNING=: '01000'
SQL_SUCCESS=: 0
SQL_SUCCESS_WITH_INFO=: 1
SQL_NO_DATA=: 100
SQL_ERROR=: _1
SQL_INVALID_HANDLE=: _2
SQL_STILL_EXECUTING=: 2
SQL_NEED_DATA=: 99
SQL_MAX_DSN_LENGTH=: 32
SQL_COMMIT=: 0
SQL_ROLLBACK=: 1
SQL_NTS=: _3                     
SQL_HANDLE_ENV=: 1
SQL_HANDLE_DBC=: 2
SQL_HANDLE_STMT=: 3
SQL_HANDLE_DESC=: 4
SQL_FETCH_NEXT=: 1
SQL_FETCH_FIRST=: 2
SQL_ATTR_ODBC_VERSION=: 200
SQL_OV_ODBC3=: 3
SQL_ATTR_ROW_BIND_TYPE=: 5       
SQL_BIND_BY_COLUMN=: 0           
SQL_ATTR_ROWS_FETCHED_PTR=: 26
SQL_ATTR_ROW_ARRAY_SIZE=: 27
SQL_ATTR_ROW_STATUS_PTR=: 25
SQL_ATTR_AUTOCOMMIT=: 102        
SQL_AUTOCOMMIT_OFF=: 0           
SQL_ROWSET_SIZE=: 9
SQL_IS_UINTEGER=: _5

SQL_DESC_BASE_COLUMN_NAME=: 22
SQL_DESC_BASE_TABLE_NAME=: 23
SQL_DESC_CATALOG_NAME=: 17
SQL_DESC_NAME=: 1011
SQL_DESC_SCHEMA_NAME=: 16
SQL_DESC_TABLE_NAME=: 15
SQL_DESC_TYPE_NAME=: 14

SQL_SIGNED_OFFSET=: _20
SQL_C_CHAR=: 1
SQL_C_DOUBLE=: 8
SQL_C_LONG=: 4
SQL_C_SLONG=: (SQL_C_LONG+SQL_SIGNED_OFFSET)
SQL_C_SHORT=: 5
SQL_C_SSHORT=: (SQL_C_SHORT+SQL_SIGNED_OFFSET)
SQL_C_BINARY=: _2
SQL_LONGVARBINARY=: _4
SQL_TYPE_DATE=: 91
SQL_TYPE_TIME=: 92
SQL_C_BIGINT=: _5
SQL_C_SBIGINT=: (SQL_C_BIGINT+SQL_SIGNED_OFFSET)

SQL_ADD=: 4
SQL_ATTR_CURSOR_TYPE=: 6
SQL_CURSOR_DYNAMIC=: 2
SQL_ATTR_CONCURRENCY=: 7
SQL_CONCUR_LOCK=: 2
SQL_PARAM_INPUT=: 1
COLUMNBUF=: 1000     
LONGBUF=: 500000     
SHORTBUF=: 255       
MAXARRAYSIZE=: 65535
char_trctnb=: ]`trctnb @. (2:=3!:0)
trctnb=: <:@{:@$ {."1 (i.&({.a.) {. ])"1
trbuclnb=: (] i.&> ({.a.)"_) {.&.> ]
rebtbcol=: ] #"1~ [: -. [: *./ [: *./\."1 ' '&=
trctnob=: [: rebtbcol ] -."1 (0{a.)"_
trctguid=: 36&{."1

nullvec2mat=: 3 : '> a: -.~ deb each <;._2 y,{.a.'
SZI=: IF64{4 8     
SFX=: >IF64{'32';'64'
b0=: <"0
bs=: ];#
fat=: ''&$@:,
tolower=: 3 : '(y i.~''ABCDEFGHIJKLMNOPQRSTUVWXYZ'',a.){''abcdefghijklmnopqrstuvwxyz'',a.'
alltrim=: ] #~ [: -. [: (*./\. +. *./\) ' '&=
src=: _1: ic 1: ic ]
sqlbad=: 13 : '(src >{. y) e. DD_ERROR'
sqlok=: 13 : '(src >{. y) e. DD_SUCCESS'
iscl=: e.&(2 131072)@(3!:0) *. 1: >: [: # $
isua=: 0: = [: # $
isiu=: 3!:0 e. 1 4"_
isia=: isua *. isiu
ifs=: [: ,. [: _1&ic ,
i64fs=: [: ,. _2 ic 2 ic ,
ffs=: [: ,. [: _1&fc ,
dts=: 13 : '((#y),6) $ _1&ic , 12{."1 y'
fmterr=: [: ; ([: ":&.> ]) ,&.> ' '"_
badrow=: 13 : '0 e. (src ;{.&> y) e. DD_SUCCESS'
isbx=: 3!:0 e. 32"_
isca=: 3!:0 e. 2"_
cvt2str=: 'a'&,@":
bindcol=: 4 : 0"1 1
'sh col rows'=. y
'type precision'=. x
type=. fat src type

name=. (":sh),'_',":col
bname=. 'BIND_',name
blname=. 'BINDLN_',name
(blname)=: (rows,1)$2-2
if. type e. SQL_CHAR,SQL_VARCHAR,SQL_DECIMAL,SQL_NUMERIC do.
  len=. fat >:precision [ tartype=. SQL_DEFAULT
  (bname)=: (rows,len)$' '
elseif. type e. SQL_BINARY,SQL_VARBINARY do.
  len=. fat >:precision [ tartype=. SQL_CHAR
  (bname)=: (rows,len)$' '
elseif. type e. SQL_INTEGER do.
  len=. 4 [ tartype=. SQL_DEFAULT
  (bname)=: (rows,1)$2-2
elseif. type e. SQL_BIGINT do.
  if. IF64 do.
    len=. 8 [ tartype=. SQL_DEFAULT
  else.
    len=. 4 [ tartype=. SQL_INTEGER
  end.
  (bname)=: (rows,1)$2-2
elseif. type e. SQL_SMALLINT do.
  len=. 2 [ tartype=. SQL_DEFAULT
  (bname)=: (rows,len)$' '
elseif. type e. SQL_TYPE_TIMESTAMP do.
  len=. 16 [ tartype=. SQL_DEFAULT
  (bname)=: (rows,len)$' '
elseif. type e. SQL_WCHAR,SQL_WVARCHAR do.  
  len=. fat >: +: precision [ tartype=. SQL_CHAR
  (bname)=: (rows,len)$' '
elseif. type e. SQL_DOUBLE,SQL_FLOAT do.
  len=. 8 [ tartype=. SQL_DEFAULT
  (bname)=: (rows,1)$2.5-2.5
elseif. type e. SQL_REAL do.
  len=. 4 [ tartype=. SQL_DEFAULT
  (bname)=: (rows,len)$' '
elseif. type e. SQL_BIT,SQL_TINYINT do.
  len=. 1 [ tartype=. SQL_DEFAULT
  (bname)=: (rows,len)$' '
elseif. type e. SQL_UNIQUEID do.
  len=. 37 [ tartype=. SQL_CHAR
  (bname)=: (rows,len)$' '
elseif.do. SQL_ERROR return.
end.

sqlbindcol sh;col;tartype;(vad bname);len;<vad blname
)
DD_SUCCESS=: SQL_SUCCESS,SQL_SUCCESS_WITH_INFO
DD_ERROR=: SQL_ERROR,SQL_INVALID_HANDLE
DD_OK=: 0

fmtdts=: 3 : 0
d=. dts y
b=. ({:"1 d ) <: 60 
s=. $d=. (4,5#3) ": b *"0 1 d
d=. , d
d=. s$'0'(I. ' '=d)}d
d=. ((#d)#,:'-- ::') (<a:;4 7 10 13 16)} d
(b * {:$d) {."0 1 d
)

errret=: 3 : 0
r=. SQL_ERROR
LERR=: ''
ALLDM=: i. 0 0
if. iscl y do.
  LERR=: y
else.
  't h'=. y
  if. SQL_ERROR-:em=. t getlasterror h do. r return.
  elseif. c=. #em do.
    LERR=: fmterr {. em   
    ALLDM=: em             
    if. 1<c do. LERR=: LERR , ' - more error info available (1)' end.
  end.
end.
r
)

clr=: 3 : 0
LERR=: ''
ALLDM=: i. 0 0
)
ddconfig=: 3 : 0  
clr 0
0
)
dddriver=: 3 : 0  
clr 0
'ODBC'
)
dddrv=: 3 : 0  
clr 0
d=. EH;SQL_FETCH_FIRST
n=. EH;SQL_FETCH_NEXT
r=. i.0 0
while.do.
  z=. sqldrivers d , 6$(256#' ');256;,0
  if. sqlbad z do. errret '' return. end.
  if. SQL_NO_DATA=rc=. src >0{z do. break. end.
  if. -. sqlok rc do. errret '' return. end.
  d=. n
  r=. r , 3 6{z
end.
(trbuclnb {."1 r),.nullvec2mat &.> {:"1 r
)
ddsrc=: 3 : 0  
clr 0
d=. EH;SQL_FETCH_FIRST
n=. EH;SQL_FETCH_NEXT
l=. >:SQL_MAX_DSN_LENGTH
r=. i.0 0

while.do.
  z=. sqldatasources d ,(l#' ');256;(,0);(256#' ');256;,0
  if. sqlbad z do. errret '' return. end.
  if. SQL_NO_DATA=rc=. src >0{z do. break. end.
  if. -. sqlok rc do. errret '' return. end.
  d=. n
  r=. r , 3 6{z

end.
trbuclnb r
)

ddtbl=: 3 : 0  
clr 0
if. -. isia y do. errret ISI08 return. end.
if. -. y e. CHALL do. errret ISI03 return. end.
if. SQL_ERROR=sh=. getstmt y do. errret '' return. end.
z=. sqltables sh;(<0);256;(<0);256;(<0);256;(<0);256
if. sqlok z do.
  CSPALL=: CSPALL,y,sh
  sh
else.
  r=. errret SQL_HANDLE_STMT,sh
  r [ freestmt sh return.
end.
)

ddtblx=: 3 : 0  
if. SQL_ERROR-:sh=. ddtbl y do. SQL_ERROR
elseif. SQL_ERROR-:dat=. ddfch sh,_1 do. SQL_ERROR
elseif. 0<>./ #&> dat do. trctnob@:":&.> dat
elseif.do. dat
end.
)
ddcheck=: 3 : 0
if. _1=y do. wdinfo 'Data Driver';dderr $0 else. y end.
)
ddcol=: 4 : 0  
clr 0
w=. y
if. -. (iscl x) *. isia w=. fat w do. errret ISI08 return. end.
if. -. w e. CHALL do. errret ISI03 return. end.
x=. ,x
if. SQL_ERROR=sh=. getstmt w do. errret '' return. end.
z=. sqlcolumns sh;(<0);256;(<0);256;x;SQL_NTS;(<0);256
if. sqlbad z do.
  r=. errret SQL_HANDLE_STMT,sh
  r [ freestmt sh return.
end.
r=. getcoldefs sh
r [ freestmt sh
)

getlasterror=: 3 : 0
(EH;CHALL;1{"1 CSPALL) getlasterror y
:
if. 0=L. x do.
  t=. fat x
else.
  b=. >(<y) e. each x
  if. 1~:+/b do. SQL_ERROR return. end.
  t=. fat b#SQL_HANDLE_ENV,SQL_HANDLE_DBC,SQL_HANDLE_STMT
end.
r=. 0 3$''
while.do.
  z=. sqlgetdiagrec t;y;(1+0{$r);(5#' ');(,0);(256#' ');256;,0
  if. sqlbad z do. SQL_ERROR return. end.
  if. SQL_NO_DATA=src >0{z do. break. end.
  r=. r,(2{.4}.z),<(>8{z){.>6{z
end.
r
)

getstmt=: 3 : 0
z=. sqlallochandle SQL_HANDLE_STMT;({.y);,0
if. sqlbad z do. SQL_ERROR else. fat >3{z end.
)

freestmt=: 3 : 0
sqlfreehandle SQL_HANDLE_STMT;y
)

freeenv=: 3 : 0
sqlfreehandle SQL_HANDLE_ENV;y
)

gc=: 0 4 6&{  
tdatchar=: 3 : 0"1
sqlgetdata (b0 y),SQL_CHAR;(SHORTBUF$' ');(>:SHORTBUF);,0
)

trimdat=: 13 : '(<(>2{y){.>1{y) 1} y'
datchar=: 3 : 0"1
z=. gc sqlgetdata (b0 y),SQL_CHAR;(SHORTBUF$' ');(>:SHORTBUF);,0
if. sqlok z do. trimdat z else. z end.
)
datwchar=: 3 : 0"1
bufln=. >:buf=. 2*SHORTBUF
z=. gc sqlgetdata (b0 y),SQL_CHAR;(buf$' ');bufln;,0
if. sqlok z do. trimdat z else. z end.
)
datdouble=: 3 : 0"1
gc sqlgetdata (b0 y),SQL_DOUBLE;(,1.5-1.5);8;,0
)
datinteger32=: 3 : 0"1
gc sqlgetdata (b0 y),SQL_INTEGER;(,256);4;,0
)
datinteger64=: 3 : 0"1
z=. gc sqlgetdata (b0 y),SQL_INTEGER;(4${.a.);4;,0
if. sqlok z do.
  (<fat _2&ic >1{z) 1} z
else.
  z
end.
)

datinteger=: ('datinteger',SFX)~ f.
datsmallint=: 3 : 0"1
z=. gc sqlgetdata (b0 y),SQL_SMALLINT;(2${.a.);2;,0
if. sqlok z do.
  (<fat _1&ic >1{z) 1} z
else.
  z
end.
)
datbit=: 3 : 0"1
z=. gc sqlgetdata (b0 y),SQL_CHAR;(1${.a.);1;,0
if. sqlok z do.
  (<a.&i. fat >1{z) 1} z
else.
  z
end.
)
datreal=: 3 : 0"1
z=. gc sqlgetdata (b0 y),SQL_CHAR;(4$' ');4;,0
if. sqlok z do.
  (<fat _1&fc >1{z) 1} z
else.
  z
end.
)
dattimestamp=: 3 : 0"1
z=. gc sqlgetdata (b0 y),SQL_DEFAULT;(16$' ');17;,0
if. sqlok z do.
  (<,fmtdts ,:>1{z) 1}z
else.
  z
end.
)
datlong=: 3 : 0"1
sc=. b0 y
get=. sc,SQL_BINARY;(LONGBUF$' ');LONGBUF;,0

z=. sqlgetdata get
lim=. a:{ >{:z  
dat=. ''
while. lim>:#dat do.
  if. sqlbad rc=. >{. z do. SQL_ERROR;'';0 return. end.
  if. SQL_NO_DATA=src rc do. break. end.
  dat=. dat , (LONGBUF<.>{:z) {. , >4{z
  z=. sqlgetdata get
end.
DD_OK ; dat ; #dat  
)
getchar=: datchar&.>
getwchar=: datwchar&.>
getbinary=: datchar&.>
getvarbinary=: datchar&.>
getbit=: datbit&.>
getdecimal=: datchar&.>
getnumeric=: datchar&.>
getbigint=: datchar&.>
getdouble=: datdouble&.>
getfloat=: datdouble&.>
getreal=: datreal&.>
getvarchar=: datchar&.>
getwvarchar=: datchar&.>
getinteger=: datinteger&.>
getsmallint=: datsmallint&.>
gettinyint=: datbit&.>
getlongvarchar=: datlong&.>
getlongvarbinary=: datlong&.>
getwlongvarchar=: datlong&.>
gettype_timestamp=: dattimestamp&.>
getuniqueid=: datchar&.>

iad=: 3 : 0
ple=. 15!:6 <y         
pa=. memr ple,SZI,1 4  
''$pa+memr pa,0 1 4    
)
vad=: <@:iad  
getcolinfo=: 3 : 0"1
arg=. (b0 y),(bs 128$' '),5#<,0
z=. sqldescribecol arg
z=. (<(fat 5{::z){.3{::z) 3}z
)
getallcolinfo=: 3 : 0
if. sqlbad z=. sqlnumresultcols y;,0 do.
  SQL_ERROR
else.
  z=. getcolinfo y,.1+i.>2{z
  z=. (<"0 src;6{"1 z)(<a:;6)}z
end.
)

SQL_DRIVER_NOPROMPT=: 0

ddcon=: 3 : 0  
f=. (i.&';')({. ; }.@}.) ]
clr 0
if. -.iscl y do. errret ISI08 return. end.
usedsn=. 'dsn=' -: tolower 4{.y

if. usedsn do.
  dsn=. uid=. pwd=. ''

  txt=. <;._2 y, ';' -. {:y
  ndx=. txt i.&> '='
  nms=. tolower each ndx {.each txt
  vls=. (ndx+1) }.each txt
  (nms)=. vls

  z=. sqlallochandle SQL_HANDLE_DBC;EH;,0
  if. sqlbad z do. errret SQL_HANDLE_ENV,EH return. end.

  HDBC=: fat >3{z

  z=. sqlconnect LASTCONNECT=: HDBC;(bs dsn),(bs uid),bs pwd
  if. sqlbad z do. errret SQL_HANDLE_DBC,HDBC return. end.

else.
  z=. sqlallochandle SQL_HANDLE_DBC;EH;,0
  if. sqlbad z do. errret SQL_HANDLE_ENV,EH return. end.

  HDBC=: fat >3{z

  outstr=. 1024$' '
  z=. sqldriverconnect LASTCONNECT=: HDBC;0;(bs y),(bs outstr),(,0);SQL_DRIVER_NOPROMPT
  if. sqlbad z do. errret SQL_HANDLE_DBC,HDBC return. end.
  odsn=. ({.7{::z) {. 5{::z
end.
if. SQL_ERROR-:em=. SQL_HANDLE_DBC getlasterror HDBC do. errret '' return.
elseif. #em do.
  if. 0&e. ({."1 em) e. <SQLST_WARNING do.
    errret fmterr {.em return.
  end.
end.

CHALL=: CHALL,HDBC
dddbms HDBC
HDBC
)

dddis=: 3 : 0"0   
clr 0
w=. y
if. -.isia w=. fat w do. errret ISI08 return. end.
if. -. w e. CHALL do. errret ISI03 return. end.
if. #shs=. 1{"1 CSPALL#~w=0{"1 CSPALL do. ddend shs end.
ch=. w 
if. sqlbad sqldisconnect w do. errret SQL_HANDLE_DBC,ch return. end.
if. sqlbad sqlfreehandle SQL_HANDLE_DBC;y do. errret '' return. end.
CHALL=: CHALL-.ch
CSPALL=: CSPALL#~ch~:0{"1 CSPALL
DBMSALL=: DBMSALL#~ch~:>0{("1) DBMSALL
DD_OK
)

ddsel=: 4 : 0  
clr 0
if. -.(isia w=. fat y) *. iscl x do. errret ISI08 return. end.
if. -.w e. CHALL do. errret ISI03 return. end.
x=. ,x
if. SQL_ERROR=sh=. getstmt w do. errret SQL_HANDLE_DBC,w return. end.
if. sqlok sqlexecdirect sh;bs x do.
  sh [ CSPALL=: CSPALL,w,sh
else.
  r=. errret SQL_HANDLE_STMT,sh
  r [ freestmt sh
end.
)
transact=: 4 : 0
if. sqlok sqlendtran SQL_HANDLE_DBC;y;x do.
  DD_OK [ CHTR=: CHTR-.y
else.
  SQL_ERROR
end.
)

ddsql=: 4 : 0  
clr DDROWCNT=: 0
if. -.(isia y) *. iscl x do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
x=. ,x
if. SQL_ERROR=sh=. getstmt y do. errret SQL_HANDLE_DBC,y return. end.
if. sqlok sqlexecdirect sh;bs x do.
  if. sqlok z=. sqlrowcount sh;,256 do. DDROWCNT=: fat >{:z end.
  if. -. y e. CHTR do. SQL_COMMIT transact y end.
  DD_OK [ freestmt sh
else.
  r=. errret SQL_HANDLE_STMT,sh
  r [ freestmt sh
end.
)

ddcnt=: 3 : 0  
DDROWCNT
)

ddend=: 3 : 0"0  
clr 0
w=. y
if. -.isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
sh=. w
z=. sqlfreehandle SQL_HANDLE_STMT;w
CSPALL=: CSPALL#~sh~:1{"1 CSPALL
erasebind sh
if. sqlbad z do. errret SQL_HANDLE_STMT,sh else. DD_OK end.
)
ddfch=: 3 : 0
COLUMNBUF ddfch y
:
clr 0
if. -.(isia x) *. isiu y do. errret ISI08 return. end.
'sh r'=. 2{.,y,1
if. -.sh e.1{"1 CSPALL do. errret ISI04 return. end.
r=. (r<0){r,_1  
if. SQL_ERROR-:ci=. getallcolinfo sh do. errret '' return. end.
assert. 10={:@$ ci
buf=. (_1=r){r,x
if. sqlbad z=. ci dbind sh,buf do. SQL_ERROR return. end.
cv=. GCNM {~ GDX i. ; 6 {"1 ci

one=. 0<r
dat=. (#ci)#<i.0 0
if. r=0 do. dat return. end.
fetch=. sh;SQL_FETCH_NEXT;0
while.do.

  rc=. >{.sqlfetchscroll fetch
  if. sqlbad rc do. errret SQL_HANDLE_STMT,sh return. end.
  if. SQL_NO_DATA=src rc do. ddend sh break. end.
  c=. dddcnt sh
  z=. ''
  for_i. i.#ci do.
    n=. (i_index{cv) `:0 dddata sh,i+1


    if. _1 e. len=. dddataln sh,i+1 do.
      ndx=. I. len = _1
      if. 2 = 3!:0 n do.
        n=. ' ' ndx } n
      else.
        n=. __ ndx } n
      end.
    end.
    z=. z,< n
  end.
  if. c<buf do. z=. (fat c) {.&.> z end.

  dat=. dat ,&.> z
  if. one do. if. c<buf do. ddend sh end. break. end.
end.
assert. 1= # ~. #&> dat
dat
)

ddbind=: 3 : 0  
COLUMNBUF ddbind y 
:
clr 0
if. -.(isia x) *. isiu y do. errret ISI08 return. end.
'sh r'=. 2{.,y,x
if. -.sh e.1{"1 CSPALL do. errret ISI04 return. end.
if. SQL_ERROR-:ci=. getallcolinfo sh do. errret ''
elseif. sqlbad ci dbind sh,r do. SQL_ERROR
elseif.do. DD_OK [ ('BINDTI_',":sh)=: ci  
end.
)

dbind=: 4 : 0
if. 0&e. b=. (;6{"1 x) e. SQL_COLBIND_TYPES do. errret ISI10 typeerr (-.b)#x return. end.
dcolbind y
z=. (6 7{"1 x) bindcol (0{y),.(>: i.#x),.1{y
if. *./(src ; 0{"1 z) e. DD_SUCCESS do. DD_OK else. errret ISI10 end.
)

ddfetch=: 3 : 0  
w=. y
if. -.isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
if. sqlok sqlfetchscroll w;SQL_FETCH_NEXT;0 do. DD_OK else. errret SQL_HANDLE_STMT,y end.
)

typeerr=: 4 : 0
hd=. ;:'ColNumber ColName TypeCode SqlType'
dat=. 2 3 6 {"1 y
sqltypes=. (}.SQL_SUPPORTED_NAMES) , '**JDD UNKNOWN TYPE**'
tnames=. <"1 sqltypes {~ SQL_SUPPORTED_TYPES i. ; {:"1 dat
BADTYPES=: hd , (trbuclnb ":&.> dat) ,. alltrim&.> tnames
x ,' - more error info available (2)'
)

dddata=: 3 : 0  
".'BIND_',(":0{y),'_',":1{y
)
dddataln=: 3 : 0
,".'BINDLN_',(":0{y),'_',":1{y
)

dddcnt=: 3 : 0
".'BINDRR_',":y
)
ddrow=: dddcnt 

initodbcenv=: 3 : 0
CHTR=: CHALL=: i.0  
CSPALL=: 0 2$0      
DBMSALL=: 0 12$<''  
LERR=: ''           
ALLDM=: i. 0 3      
BADTYPES=: i. 0 0   
DDROWCNT=: 0        
z=. sqlallochandle SQL_HANDLE_ENV;0;,0
EH=: fat >3{z
if. sqlbad z do.
  wdinfo dderr errret ISI11
  return.
end.
if. sqlbad sqlsetenvattr EH;SQL_ATTR_ODBC_VERSION;SQL_OV_ODBC3;0 do.
  wdinfo dderr errret ISI12
  return.
end.
6!:3[0

DD_OK
)

getcoldefs=: 3 : 0
if. SQL_ERROR-:ci=. getallcolinfo y do. SQL_ERROR return. end.
assert. 10={:@$ ci

if. #dc=. ci getdata y,_1 do.
  (trbuclnb 3 {"1 ci) , ,&.> dc
else.
  trbuclnb 3 {"1 ci
end.

)

endodbcenv=: 3 : 0
set=. 0&= @: (4!:0)
if. set <'CHTR' do. if. #CHTR do. ddrbk CHTR end. end.
if. set <'CSPALL' do. if. #CSPALL do. ddend {:"1 CSPALL end. end.
if. set <'CHALL' do. if. #CHALL do. dddis CHALL end. end.
if. set <'EH' do. freeenv EH end.  
erase ;:'CSPALL CHALL EH'
)

ddcnm=: 3 : 0  
clr 0
w=. y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
if. SQL_ERROR-:ci=. getallcolinfo w do. errret SQL_HANDLE_STMT,w return. end.
assert. 10={:@$ ci
trbuclnb 3{"1 ci
)

dderr=: 3 : 0  
0 dderr y
:
select. x
case. 1 do. ALLDM
case. 2 do. BADTYPES
case.do. LERR
end.
)

ddtrn=: 3 : 0  
clr 0
w=. fat y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -. w e. CHALL do. errret ISI03 return. end.
if. w e. CHTR do. errret ISI07 return. end.

if. sqlok sqlsetconnectattr w;SQL_ATTR_AUTOCOMMIT;SQL_AUTOCOMMIT_OFF;SQL_IS_UINTEGER do.
  DD_OK [ CHTR=: CHTR,w
else.
  errret SQL_HANDLE_DBC,w
end.
)

comrbk=: 4 : 0
w=. y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -. w e. CHALL do. errret ISI03 return. end.
if. -. w e. CHTR do. errret ISI07 return. end.
if. sqlok x transact w do. DD_OK else. errret SQL_HANDLE_DBC,w end.
)

ddcom=: 3 : 0  
clr 0
SQL_COMMIT comrbk y
)

ddrbk=: 3 : 0  
clr 0
SQL_ROLLBACK comrbk y
)

ddttrn=: 3 : 0"0
if. y e. CHALL do.
  y e. CHTR
else.
  0
end.
)
erasebind=: 3 : 0"0
if. b=. #n=. 'B' (4!:1) 0 do. *./(4!:55) n #~ +./"1 (,:'_',":,y) E. > n else. b end.
)

dcolbind=: 3 : 0
'sh r'=. y
bstname=. 'BINDST_',":sh
if. IF64 do.  
  (bstname)=: r$2-2
else.
  (bstname)=: (r,2)$' '
end.
brfname=. 'BINDRR_',":sh
(brfname)=: ,256
et=. SQL_HANDLE_STMT,sh
if. sqlbad sqlsetstmtattr sh;SQL_ATTR_ROW_BIND_TYPE;SQL_BIND_BY_COLUMN;0 do. errret et
elseif. sqlbad sqlsetstmtattr sh;SQL_ATTR_ROW_ARRAY_SIZE;r;0 do. errret et
elseif. sqlbad sqlsetstmtattr sh;SQL_ATTR_ROW_STATUS_PTR;(iad bstname);0 do. errret et
elseif. sqlbad sqlsetstmtattr sh;SQL_ATTR_ROWS_FETCHED_PTR;(iad brfname);0 do. errret et
elseif.do. DD_OK
end.
)

setzface=: 3 : 0
r=. i. 0 0
if. (<'base') -: cl=. 18!:5 '' do. r
else.
  cl=. '_' , (,>cl) , '_'
  wrds=. 'ddsrc ddtbl ddtblx ddcol ddcon dddis ddfch ddend ddsel ddcnm dderr'
  wrds=. wrds, ' dddrv ddsql ddcnt ddtrn ddcom ddrbk ddbind ddfetch'
  wrds=. wrds ,' dddata ddfet ddbtype ddcheck ddrow ddins ddparm ddsparm dddbms ddcolinfo ddttrn'
  wrds=. >;: wrds ,' dddriver ddconfig'
  ". (wrds ,"1 '_z_ =: ',"1 wrds ,"1 cl) -."1 ' '
  r
end.
)

ddfet=: 3 : 0  
clr 0
if. -. isiu y do. errret ISI08 return. end.
'sh r'=. 2{.,y,1
if. -. sh e.1{"1 CSPALL do. errret ISI04 return. end.
r=. (r<0){r,_1  
if. SQL_ERROR-:ci=. getallcolinfo sh do.
  errret ''
else.
  z=. ,&.> ci getdata sh,r
  assert. 1= #@$&> ,z
  z
end.
)

ddbtype=: 3 : 0
".'BINDTI_',":y
)

'UCS2 UCS4 UTF8 OEMCP'=: i.4
BUGFLAG_BINDPARMBIGINT=: 8       
BUGFLAG_WCHAR_SUTF8=: 16            
BUGFLAG_LONGVARBINARY_BINARY=: 128  
BUGFLAG_BULKOPERATIONS=: 256        

SQL_DATA_SOURCE_NAME=: 2
SQL_DBMS_NAME=: 17
SQL_DBMS_VER=: 18
SQL_DRIVER_NAME=: 6
SQL_DRIVER_VER=: 7
SQL_SERVER_NAME=: 13
SQL_USER_NAME=: 47

strsqlgetinfo=: SQL_DATA_SOURCE_NAME,SQL_DBMS_NAME,SQL_DBMS_VER,SQL_DRIVER_NAME,SQL_DRIVER_VER,SQL_SERVER_NAME,SQL_USER_NAME
getinfo2=: 4 : 0
if. -. isia y=. fat y do. assert. 0 end.
ch=. y
'info chars'=. x
if. sqlbad z=. sqlgetinfo ch;info;(256#{.a.);256;(,-0) do. z return. end.
if. info e. strsqlgetinfo do.
  if. (UCS2=chars) do.
    rz=. 6&u: (<.&.-: _1{::z){. 3{::z
  elseif. do.
    rz=. (fat _1{::z){. 3{::z
  end.
else.
  rz=. (IF64{_2 _3)&ic SZI{. 3{::z
end.
rz
)
dddbms=: 3 : 0  
if. -. isia y=. fat y do. errret ISI08 return. end.
if. -.y e. CHALL do. errret ISI03 return. end.
ch=. y
clr 0
if. ch e. >0{("1) DBMSALL do.
  }.DBMSALL{~(>0{("1) DBMSALL)i.ch
  return.
end.
bugflag=. 0
chardiv=. 1  
charset=. IFUNIX{OEMCP,UTF8
dsn=. ch getinfo2~ SQL_DATA_SOURCE_NAME, charset
uid=. ch getinfo2~ SQL_USER_NAME, charset
server=. ch getinfo2~ SQL_SERVER_NAME, charset
ver=. ch getinfo2~ SQL_DBMS_VER, charset
drvname=. ch getinfo2~ SQL_DRIVER_NAME, charset
drvver=. ch getinfo2~ SQL_DRIVER_VER, charset
name=. ch getinfo2~ SQL_DBMS_NAME, charset
name=. ('Microsoft SQL Server'-:name){:: name ; 'MSSQL'
name=. ('ACCESS'-:name){:: name ; 'MSACCESS'
name=. (((<3{.ver)e.'12.';'14.')*.'MSACCESS'-:name){:: name ; 'MSACEDB'
name=. ('firebird'-:tolower name){:: name ; 'Firebird'
name=. ('interbase'-:tolower name){:: name ; 'InterBase'
name=. ('oracle'-:tolower name){:: name ; 'Oracle'
name=. ('mysql'-:tolower name){:: name ; 'MYSQL'

if. drvname -: 'libtdsodbc.so' do.   
  charset=. UTF8
  chardiv=. 4
  bugflag=. bugflag (23 b.) BUGFLAG_WCHAR_SUTF8
elseif. name -: 'SQLite' do.         
  charset=. UTF8
  chardiv=. 4
  bugflag=. bugflag (23 b.) BUGFLAG_LONGVARBINARY_BINARY
elseif. name -: 'MYSQL' do.
  charset=. UTF8
  chardiv=. 3
end.

if. ((<tolower drvname) e. <'aceodbc.dll') do. bugflag=. bugflag (23 b.) IF64 *. BUGFLAG_BINDPARMBIGINT end.

if. (<tolower drvname) -.@e. 'sqlsrv32.dll' ; 'sqlncli.dll' ; 'sqlncli10.dll' ; 'odbcjt32.dll' ; 'aceodbc.dll' ; 'odbcfb' do.
  bugflag=.  bugflag (23 b.) BUGFLAG_BULKOPERATIONS   
end.

DBMSALL=: DBMSALL, y; r=. 'ODBC';dsn;uid;server;name;ver;drvname;drvver;charset;chardiv;bugflag
r
)
getdata=: 4 : 0
'sh r'=. y
assert. 10={:@$ x
ty=. ; 6 {"1 x
if. -.*./b=. ty e. SQL_SUPPORTED_TYPES do. errret ISI09 typeerr (-.b)#x return. end.
gf=. (SQL_SUPPORTED_TYPES i. ty){GGETV
cc=. <"1 sh,.>:i.#ty

dat=. (0,#ty)$<''
if. r=0 do. dat return. end.

z=. sqlfetch sh
while.do.

  if. sqlbad rc=. >{.z do.
    errret SQL_HANDLE_STMT,sh return.
  end.
  if. SQL_NO_DATA=src rc do.
    ddend sh break.
  end.
  row=. , 1 gf\cc
  if. badrow row do.
    errret ISI13 return.
  end.
  dat=. dat , 1 {&> row

  if. 0=r=. <:r do. break. end.  
  z=. sqlfetch sh
end.
dat
)
ddins=: 4 : 0
clr 0
if. -.(isia y) *. isbx x do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
'datadriver dsn uid server name ver drvname drvver charset chardiv bugflag'=. }.DBMSALL{~(>0{("1) DBMSALL)i. y
if. bugflag (17 b.) BUGFLAG_BULKOPERATIONS do. x ddinsemu y return. end.

if. 2>#x do. errret ISI08 return. end.
if. -. *./ 2=> #@$&.>}.x do. errret ISI08 return. end.
if. 1<#rows=. ~. > {.@$&.>}.x do. errret ISI08 return. end.
if. 0=rows=. fat rows do. DD_OK return. end.

sql=. ,>0{x
of=. 1

loctran=. 0
if. y -.@e. CHTR do.
  if. sqlok sqlsetconnectattr y;SQL_ATTR_AUTOCOMMIT;SQL_AUTOCOMMIT_OFF;SQL_IS_UINTEGER do.
    loctran=. 1 [ CHTR=: CHTR, y
  end.
end.

if. SQL_ERROR=sh=. getstmt y do.
  r=. errret SQL_HANDLE_DBC,y
  if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
  r return.
end.
arraysize=. MAXARRAYSIZE<.rows
bstname=. 'BINDST_', (cvt2str sh)
(bstname)=: (arraysize,2)${.a.

et=. SQL_HANDLE_STMT,sh
if. sqlbad sqlsetstmtattr sh;SQL_ATTR_ROW_BIND_TYPE;SQL_BIND_BY_COLUMN;0 do. rc=. errret et
elseif. sqlbad sqlsetstmtattr sh;SQL_ATTR_CURSOR_TYPE;SQL_CURSOR_DYNAMIC;0 do. rc=. errret et
elseif. sqlbad sqlsetstmtattr sh;SQL_ATTR_CONCURRENCY;SQL_CONCUR_LOCK;0 do. rc=. errret et
elseif. sqlbad sqlsetstmtattr sh;SQL_ATTR_ROW_ARRAY_SIZE;arraysize;0 do. rc=. errret et
elseif. sqlbad sqlsetstmtattr sh;SQL_ATTR_ROW_STATUS_PTR;(iad bstname);0 do. rc=. errret et
elseif.do. rc=. DD_OK
end.

if. -. DD_OK= >@{.rc do.
  erasebind sh [ freestmt sh [ r=. errret SQL_HANDLE_STMT,sh
  if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
  r return.
end.

z=. sqlexecdirect sh;bs sql

if. sqlbad z do.
  erasebind sh [ freestmt sh [ r=. errret SQL_HANDLE_STMT,sh
  if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
  r return.
end.

ty=. ; src&.> 6{"1 a=. getallcolinfo sh
lns=. ; src&.> 7{"1 a
if. (#x)~:of+#ty do.
  erasebind sh [ freestmt sh [ r=. errret ISI50
  if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
  r return.
end.
if. #ty do.
  ncol=. #ty
  for_brows. (-arraysize)<\i.rows do.
    nrows=. #brow=. >brows
    if. arraysize~:nrows do.
      if. sqlbad sqlsetstmtattr sh;SQL_ATTR_ROW_ARRAY_SIZE;nrows;0 do.
        erasebind sh [ freestmt sh [ r=. errret SQL_HANDLE_STMT,sh
        if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
        r return.
      end.
    end.
    for_i. i.ncol do.
      name=. (cvt2str sh),'_',":i
      bname=. 'BIND_',name
      blname=. 'BINDLN_',name
      ln=. i{lns
      select. i{ty
      case. SQL_INTEGER;SQL_SMALLINT;SQL_BIT;SQL_TINYINT;SQL_BIGINT do.
        if. (1 4 8) -.@e.~ 3!:0 >(of+i){x do.
          erasebind sh [ freestmt sh [ r=. errret ISI51
          if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
          r return.
        end.
        if. IF64 do.
          if. SQL_BIGINT=i{ty do.
            (bname)=: (2-2)&+ <. brow&{ >(of+i){x
            (blname)=: (nrows,1)$SZI
            q=. sh;(>:i);SQL_C_SBIGINT;(vad bname);SZI;(<vad blname)
          else.
            (bname)=: 2 ic , (2-2)&+ <. brow&{ >(of+i){x
            (blname)=: (nrows,1)$4
            q=. sh;(>:i);SQL_C_SLONG;(vad bname);4;(<vad blname)
          end.
        else.
          (bname)=: (2-2)&+ <. brow&{ >(of+i){x
          (blname)=: (nrows,1)$SZI
          q=. sh;(>:i);SQL_C_SLONG;(vad bname);SZI;(<vad blname)
        end.
      case. SQL_DOUBLE;SQL_FLOAT;SQL_REAL;SQL_DECIMAL;SQL_NUMERIC do.
        if. (1 4 8) -.@e.~ 3!:0 >(of+i){x do.
          erasebind sh [ freestmt sh [ r=. errret ISI51
          if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
          r return.
        end.
        (bname)=: (_&<.) brow&{ >(of+i){x
        (blname)=: (nrows,1)$8
        q=. sh;(>:i);SQL_C_DOUBLE;(vad bname);8;(<vad blname)
      case. SQL_CHAR;SQL_VARCHAR do.
        if. 2 -.@e.~ 3!:0 >(of+i){x do.
          erasebind sh [ freestmt sh [ r=. errret ISI51
          if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
          r return.
        end.
        (bname)=: ,a=. ln&{."1 brow&{ >(of+i){x
        (blname)=: (nrows,1)$#{.a
        q=. sh;(>:i);SQL_C_CHAR;(vad bname);(#{.a);(<vad blname)
      case. <SQL_LONGVARCHAR do.
        if. 2 -.@e.~ 3!:0 >(of+i){x do.
          erasebind sh [ freestmt sh [ r=. errret ISI51
          if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
          r return.
        end.
        ln=. 1
        (bname)=: ,a=. ln&{."1 brow&{ >(of+i){x
        (blname)=: (nrows,1)$SQL_NULL_DATA
        q=. sh;(>:i);SQL_C_CHAR;(vad bname);(#{.a);(<vad blname)
      case. <SQL_LONGVARBINARY do.
        if. 2 -.@e.~ 3!:0 >(of+i){x do.
          erasebind sh [ freestmt sh [ r=. errret ISI51
          if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
          r return.
        end.
        ln=. 1
        (bname)=: ,a=. ln&{."1 brow&{ >(of+i){x
        (blname)=: (nrows,1)$SQL_NULL_DATA
        q=. sh;(>:i);SQL_C_CHAR;(vad bname);(#{.a);(<vad blname)
      case. SQL_TYPE_DATE;SQL_TYPE_TIME;SQL_TYPE_TIMESTAMP do.
        if. 2 e.~ 3!:0 data=. >(of+i){x do.
          a=. data
          select. <3{.{.a
          case. <'{d ' do. fm=. SQL_TYPE_DATE
          case. <'{t ' do. fm=. SQL_TYPE_TIME
          case. <'{ts' do. fm=. SQL_TYPE_TIMESTAMP
          case. do.
            erasebind sh [ freestmt sh [ r=. errret ISI51
            if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
            r return.
          end.
        elseif. do.
          erasebind sh [ freestmt sh [ r=. errret ISI51
          if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
          r return.
        end.
        (bname)=: ,a=. brow&{ >(of+i){x
        (blname)=: (nrows,1)$#{.a
        q=. sh;(>:i);SQL_C_CHAR;(vad bname);(#{.a);(<vad blname)
      case. do.
        erasebind sh [ freestmt sh [ r=. errret ISI51
        if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
        r return.
      end.
      if. sqlbad sqlbindcol q do.
        erasebind sh [ freestmt sh [ r=. errret SQL_HANDLE_STMT,sh
        if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
        r return.
      end.
    end.
    if. SQL_SUCCESS~: src >@{. z=. sqlbulkoperations sh;SQL_ADD do.
      erasebind sh [ freestmt sh [ r=. errret SQL_HANDLE_STMT,sh
      if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
      r return.
    end.
  end.
end.
erasebind sh [ freestmt sh
if. loctran do. CHTR=: CHTR-. y [ SQL_COMMIT comrbk y end.
DDROWCNT=: rows
DD_OK
)
getcolinfo1=: 3 : 0"1
if. sqlbad z=. sqlcolattribute (b0 y),SQL_DESC_CATALOG_NAME;(bs 128#{.a.), (,2-2) (;<) <0 do.
  catalog=. ''
else.
  catalog=. (fat 6{::z){.4{::z
end.
if. sqlbad z=. sqlcolattribute (b0 y),SQL_DESC_SCHEMA_NAME;(bs 128#{.a.), (,2-2) (;<) <0 do.
  schema=. ''
else.
  schema=. (fat 6{::z){.4{::z
end.
if. sqlbad z=. sqlcolattribute (b0 y),SQL_DESC_TABLE_NAME;(bs 128#{.a.), (,2-2) (;<) <0 do.
  table=. ''
else.
  table=. (fat 6{::z){.4{::z
end.
if. sqlbad z=. sqlcolattribute (b0 y),SQL_DESC_BASE_TABLE_NAME;(bs 128#{.a.), (,2-2) (;<) <0 do.
  org_table=. ''
else.
  org_table=. (fat 6{::z){.4{::z
end.
if. sqlbad z=. sqlcolattribute (b0 y),SQL_DESC_BASE_COLUMN_NAME;(bs 128#{.a.), (,2-2) (;<) <0 do.
  org_column=. ''
else.
  org_column=. (fat 6{::z){.4{::z
end.
if. sqlbad z=. sqlcolattribute (b0 y),SQL_DESC_TYPE_NAME;(bs 128#{.a.), (,2-2) (;<) <0 do.
  typename=. ''
else.
  typename=. (fat 6{::z){.4{::z
end.
'colnum colname coltype colsize decimal nullable'=. 2 3 6 7 8 9{getcolinfo y
z=. ,&.> catalog;schema;table;org_table;colname;org_column;colnum;typename;coltype;colsize;decimal;nullable;'';coltype;0
)
getallcolinfo1=: 4 : 0
ch=. y [ sh=. x
if. sqlbad z=. sqlnumresultcols sh;,0 do.
  SQL_ERROR
else.
  z=. getcolinfo1 sh,.1+i. 2{::z
end.
z
)
ddcolinfo=: 3 : 0
clr 0
if. -. isia y=. fat y do. errret ISI08 return. end.
if. -.y e. 1{("1) CSPALL do. errret ISI04 return. end.
sh=. y
ch=. (0{("1) CSPALL){~(1{("1) CSPALL)i.{.sh
if. SQL_ERROR-:ci=. sh getallcolinfo1 ch do.
  z=. errret SQL_HANDLE_STMT,sh
else.
  assert. 15={:@$ci
  assert. 1= #@$&> ,ci
  z=. ci
end.
z
)
ddcoltype=: 4 : 0
clr 0
if. -.y e.CHALL do. errret ISI03 return. end.
if. -. iscl sql=. x do. errret ISI08 return. end.
if. SQL_ERROR=sh=. getstmt y do. errret SQL_HANDLE_DBC,y return. end.
z=. sqlexecdirect sh;bs sql
if. sqlbad z do.
  r=. errret SQL_HANDLE_STMT,sh
  r [ freestmt sh return.
end.
if. SQL_ERROR-:ci=. sh getallcolinfo1 y do.
  z=. errret SQL_HANDLE_STMT,sh
else.
  assert. 15={:@$ci
  assert. 1= #@$&> ,ci
  z=. ci
end.
freestmt sh
z
)
parsesqlparm=: 3 : 0
y=. deb y
fmt=. 0  
if. ('insert into' ; 'select into') e.~ <tolower 11{.y do. ix=. 11 [ fmt=. 1
elseif. 'delete from' -: tolower 11{.y do. ix=. 11
elseif. 'update' -: tolower 6{.y do. ix=. 6
elseif. do. ix=. _1
end.
if. _1~:ix do.
  table=. a{.~ +/@:(*./\)@:-.@:(e.&' ,(') a=. dlb ix}.y
else.
  table=. ''
end.
if. 1=fmt do.
  if. 1 e. ivb=. (')values(' E. ly) +. (')values (' E. ly) +. (') values(' E. ly) +. (') values (' E. ly) [[ ly=. tolower y do. iv=. 1 i.~ ivb else. fmt=. 0 end.
end.
len=. +/@:(*./\)@:-.@:(e.&' ,')@:|.&> a=. (('=?' E. y) +. ('= ?' E. y)) <;._2 y
parm1=. (-len) {.&.> a
parm=. 0$<''
for_b. parm1 do.
  b1=. >b
  if. ('(' e. b1) *. ')' e. b1 do.
    parm=. parm , < }.(}.~ i:&'(') ({.~ i:&')') b1
  else.
    parm=. parm, b
  end.
end.
if. 0=fmt do.
  (<table), parm
else.
  c=. '(' i:~ b=. y{.~ iv
  fld=. <@dltb ;._1 ',', (1+c)}.b
  'c d'=. '()' i.~ b=. y}.~ 1+iv
  pval=. (<,'?') = <@dltb ;._1 ',', (1+c)}.d{.b
  (<table), (pval (# :: (''"_)) fld), parm
end.
)
ddinsemu=: 4 : 0
clr 0
if. -.(isia y) *. isbx x do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
if. 2>#x do. errret ISI08 return. end.
if. -. *./ 2>: #@$&> }.x do. errret ISI08 return. end.
if. 1<#rows=. ~. > {.@$&>}.x do. errret ISI08 return. end.
if. 0=rows=. fat rows do. SQL_NO_DATA return. end.
sql=. ,0{::x
if. SQL_ERROR-: z=. y ddcoltype~ sql do. z return. end.
'oty ty lns'=. |: _3]\;8 13 9{("1) z
flds=. 4{("1) z
tbl=. ~. 2{("1) z
if. (,a:)-:tbl do.
  if. 'select'-.@-: tolower 6{.sql0=. deb sql do. errret ISI08 return. end.
  sql0=. dlb 6}.sql0
  if. 1 e. r=. ' where ' E. s=. tolower sql0 do. sql0=. sql0{.~ r i: 1
  elseif. 1 e. r=. ' where(' E. s do. sql0=. sql0{.~ r i: 1
  elseif. 1 e. r=. ')where ' E. s do. sql0=. sql0{.~ r i: 1
  elseif. 1 e. r=. ')where(' E. s do. sql0=. sql0{.~ r i: 1
  end.
  if. 1 e. r=. ' from ' E. s=. tolower sql0 do.
    tbl=. dltb sql0}.~ a + #' from ' [[ a=. r i: 1
  elseif. 1 e. r=. ' from(' E. s do.
    tbl=. dltb sql0}.~ a + #' from(' [[ a=. r i: 1
  elseif. 1 e. r=. ')from ' E. s do.
    tbl=. dltb sql0}.~ a + #')from ' [[ a=. r i: 1
  elseif. 1 e. r=. ')from(' E. s do.
    tbl=. dltb sql0}.~ a + #')from(' [[ a=. r i: 1
  elseif. do. errret ISI08 return. end.
  tbl=. < tbl -. '+/()*,-.:;=?@\^_`{|}'''
end.
if. (1~:#tbl) +. a: e. tbl do.  
  errret ISI52 return.
end.
if. (<:#x)~:#ty do.
  errret ISI50 return.
end.
inssql=. 'insert into ', (>@{.tbl), '(', (}. ; (<',') ,("0) flds), ') values (', (}. ; (#flds)#<',?'), ')'
z=. (inssql ; (|: oty,.lns,.ty) ; (}.x)) ddparm y
)
ddsparm=: 4 : 0
clr 0
if. -.(isiu y) *. (isbx x) do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
if. 2>#x do. errret ISI08 return. end.
sql=. 0{::x
if. -.(iscl sql) do. errret ISI08 return. end.
if. ''-:table=. 0{:: tp=. parsesqlparm sql do. errret ISI08 return. end.
if. tp ~:&# x do. errret ISI08 return. end.
sql2=. 'select ', (}. ; (<',') ,&.> (}.tp)), ' from ', table, ' where 1=0'
if. SQL_ERROR-: z=. y ddcoltype~ sql2 do. z return. end.
'oty ty lns'=. |: _3]\;8 13 9{("1) z
a=. (2 131072 e.~ 3!:0)&> x1=. }.x
b=. (2>(#@$))&> x1
if. 1 e. r=. a *. b do.
  x=. (,:@:,&.> (1+I.r){x) (1+I.r)}x
end.
y ddparm~ (<|:oty,.lns,.ty) ,&.(1&|.) x
)
ddparm=: 4 : 0
clr 0
if. -.(isiu y) *. (isbx x) do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
if. 3>#x do. errret ISI08 return. end.
sql=. ,>0{x
tyln=. >1{x
if. -.(iscl sql) *. (isiu tyln) do. errret ISI08 return. end.
if. 1 e. 2< #@$&> 2}.x do. errret ISI08 return. end.
if. 1 < #@:~. #&> 2}.x do. errret ISI08 return. end.
f=. >x{~ of=. 2
arraysize=. nrows=. #f
ty=. ''
if. 2=$$tyln do.
  if. 2=#tyln do.
    'sqlty lns'=. tyln
  elseif. 3=#tyln do.
    'sqlty lns ty'=. tyln
  elseif. do.
    assert. 0
  end.
else.
  sqlty=. tyln [ lns=. (#tyln)#_2 
end.
if. ''-:ty do.
  ty=. sqlty
end.

if. (#x) ~: of+#ty do. errret ISI50 return. end.
if. 0=nrows do. SQL_NO_DATA return. end.

loctran=. 0
if. y -.@e. CHTR do.
  if. sqlok sqlsetconnectattr y;SQL_ATTR_AUTOCOMMIT;SQL_AUTOCOMMIT_OFF;SQL_IS_UINTEGER do.
    loctran=. 1 [ CHTR=: CHTR, y
  end.
end.

if. SQL_ERROR=sh=. getstmt y do.
  r= errret SQL_HANDLE_DBC,y
  if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
  r return.
end.
ncol=. #ty
bytelen=. ''
for_i. i.ncol do.
  name=. (cvt2str sh),'_',":i
  bname=. 'BIND_',name
  blname=. 'BINDLN_',name
  (blname)=: 2-2
  select. i{ty
  case. SQL_TINYINT;SQL_SMALLINT;SQL_INTEGER;SQL_BIGINT do.
    try.
      (bname)=: a=. (2-2) + <. ,.@, >(of+i){x  
    catch.
      erasebind sh [ freestmt sh [ r=. errret ISI51
      if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
      r return.
    end.
    if. IF64 do.
      if. SQL_BIGINT=i{ty do.
        (blname)=: (nrows,1)$bl=. SZI
        if. (IF64*.(SQL_BIGINT~:i{ty)+.(0~:bugflag (17 b.) BUGFLAG_BINDPARMBIGINT)) do.
          (bname)=: 2&ic ,bname~
          (blname)=: nrows$bl=. 4
        end.
        bytelen=. bytelen, bl
        q=. sh;(>:i);SQL_PARAM_INPUT;((IF64*.(SQL_BIGINT=i{ty)*.(0=bugflag (17 b.) BUGFLAG_BINDPARMBIGINT)){SQL_C_SLONG, SQL_C_SBIGINT);((IF64*.(SQL_BIGINT=i{ty)*.(0=bugflag (17 b.) BUGFLAG_BINDPARMBIGINT)){SQL_INTEGER, SQL_BIGINT);0;0;(vad bname);bl;(<vad blname)
      else.
        (bname)=: 2 ic , bname~
        (blname)=: (nrows,1)$bl=. 4
        bytelen=. bytelen, bl
        q=. sh;(>:i);SQL_PARAM_INPUT;SQL_C_SLONG;SQL_INTEGER;0;0;(vad bname);0;(<vad blname)
      end.
    else.
      (blname)=: (nrows,1)$bl=. SZI
      bytelen=. bytelen, bl
      q=. sh;(>:i);SQL_PARAM_INPUT;SQL_C_SLONG;SQL_INTEGER;0;0;(vad bname);0;(<vad blname)
    end.
  case. SQL_DOUBLE;SQL_FLOAT;SQL_REAL;SQL_DECIMAL;SQL_NUMERIC do.
    try.
      (bname)=: a=. (_&<.) ,.@, >(of+i){x  
    catch.
      erasebind sh [ freestmt sh [ r=. errret ISI51
      if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
      r return.
    end.
    (blname)=: (nrows,1)$bl=. 8
    bytelen=. bytelen, bl
    q=. sh;(>:i);SQL_PARAM_INPUT;SQL_C_DOUBLE;SQL_DOUBLE;0;0;(vad bname);0;(<vad blname)
  case. SQL_BIT do.
    if. 2~:$$a=. >(of+i){x do. a=. ,:@, a end.
    if. 1~: 3!:0 a do.
      erasebind sh [ freestmt sh [ r=. errret ISI51
      if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
      r return.
    end.
    (blname)=: (nrows,1)$bl=. 1
    bytelen=. bytelen, bl
    q=. sh;(>:i);SQL_PARAM_INPUT;SQL_C_BIT;SQL_BIT;(1);0;(vad bname);(1);(<vad blname)
  case. SQL_BINARY;SQL_VARBINARY do.
    if. 2~:$$a=. (1&u: ::]) >(of+i){x do. a=. ,:@, a end.
    if. -. isca a do.
      erasebind sh [ freestmt sh [ r=. errret ISI51
      if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
      r return.
    end.
    if. _2 ~: i{lns do. colsize=. i{lns [ a=. (({:@$a)<.i{lns){."1 a else. colsize=. {:@$a end.
    (bname)=: a
    if. {:@$a do. (blname)=: (nrows,1)$bl=. {:@$a else. (blname)=: (nrows,1)$SQL_NULL_DATA end.
    bytelen=. bytelen, bl
    q=. sh;(>:i);SQL_PARAM_INPUT;SQL_C_BINARY;SQL_VARBINARY;(1>.colsize);0;(vad bname);(1>.colsize);(<vad blname)
  case. SQL_CHAR;SQL_VARCHAR do.
    if. 2~:$$a=. (1&u: ::]) >(of+i){x do. a=. ,:@, a end.
    if. -. isca a do.
      erasebind sh [ freestmt sh [ r=. errret ISI51
      if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
      r return.
    end.
    if. _2 ~: i{lns do. colsize=. i{lns [ a=. (({:@$a)<.i{lns){.("1) a else. colsize=. {.@{:@$a end.
    if. 0=colsize do. colsize=. 1 [ a=. (1,~ {.@$a)$u:' ' end.  
    (bname)=: (1+colsize)&{.("1) a
    if. colsize do.
      (blname)=: nrows$colsize
      bl=. 1+colsize
    else.
      (blname)=: nrows$SQL_NULL_DATA [ bl=. SZI
    end.
    bytelen=. bytelen, bl
    q=. sh;(>:i);SQL_PARAM_INPUT;SQL_C_CHAR;SQL_VARCHAR;(colsize);0;(vad bname);bl;(<vad blname)
  case. SQL_TYPE_DATE;SQL_TYPE_TIME;SQL_TYPE_TIMESTAMP do.
    if. 2 e.~ 3!:0 data=. >(of+i){x do.
      a=. 1&u:"1 data
      select.<3{.{.a
      case. <'{d ' do. fm=. SQL_TYPE_DATE
      case. <'{t ' do. fm=. SQL_TYPE_TIME
      case. <'{ts' do. fm=. SQL_TYPE_TIMESTAMP
      case. do.  
        select. i{ty
        case. SQL_TYPE_DATE do.
          fm=. i{ty
          if. -. '{' e. tolower {."1 a do.  
            a=. ('{d ''') ,("1 1) (10{."1 a) ,("1 1) '''}'
          end.
        case. SQL_TYPE_TIME do.
          fm=. i{ty
          if. -. '{' e. tolower {."1 a do.  
            a=. ('{t ''') ,("1 1) (11}."1 a) ,("1 1) '''}'
          end.
        case. SQL_TYPE_TIMESTAMP do.
          fm=. i{ty
          if. -. '{' e. tolower {."1 a do.  
            a=. ('{ts ''') ,("1 1) a ,("1 1) '''}'
          end.
        end.
      end.
    elseif. do.
      erasebind sh [ freestmt sh [ r=. errret ISI51
      if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
      r return.
    end.
    (bname)=: a
    (blname)=: (nrows,1)$bl=. {:@$a [ nrows=. {.@$ a
    bytelen=. bytelen, bl
    if. nnul=. +/ nul=. (+./"1 '1800-01-01'&E."1 a) +. (+./"1 'NULL'&E."1 a) do.
      (blname)=: (,.nnul#SQL_NULL_DATA) ((# i.@#)nul)} (blname)~
    end.
    q=. sh;(>:i);SQL_PARAM_INPUT;SQL_C_CHAR;fm;({:@$a);0;(vad bname);({:@$a);(<vad blname)
  case. SQL_LONGVARBINARY do.
    if. 2~:$$a=. >(of+i){x do. a=. ,:@, a end.
    if. 0=#,a do. a=. ($a)$'' end.
    if. -. isca a do.
      erasebind sh [ freestmt sh [ r=. errret ISI51
      if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
      r return.
    end.
    (bname)=: a
    (blname)=: (nrows,1)$bl=. {:@$a
    bytelen=. bytelen, bl
    q=. sh;(>:i);SQL_PARAM_INPUT;SQL_C_BINARY;SQL_LONGVARBINARY;(1>.{:@$a);0;(vad bname);(1>.{:@$a);(<vad blname)
  case. SQL_LONGVARCHAR do.
    if. 2~:$$a=. 1&u: >(of+i){x do. a=. ,:@, a end.
    if. -. isca a do.
      erasebind sh [ freestmt sh [ r=. errret ISI51
      if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
      r return.
    end.
    (bname)=: a
    (blname)=: (nrows,1)$bl=. {:@$a
    bytelen=. bytelen, bl
    q=. sh;(>:i);SQL_PARAM_INPUT;SQL_C_CHAR;SQL_LONGVARCHAR;(1>.{:@$a);0;(vad bname);(1>.{:@$a);(<vad blname)
  case. do.
    erasebind sh [ freestmt sh [ r=. errret ISI51
    if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
    r return.
  end.
  z=. sqlbindparameter q
  if. sqlbad z do.
    erasebind sh [ freestmt sh [ r=. errret SQL_HANDLE_STMT,sh
    if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
    r return.
  end.
end.
if. sqlbad z=. sqlprepare sh; bs sql do.
  erasebind sh [ freestmt sh [ r=. errret SQL_HANDLE_STMT,sh
  if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
  r return.
end.
rowcnt=. 0
k=. 0
while. k<nrows do.
  if. 0<k do.
    for_i. i.ncol do.
      if. 0<i{bytelen do.
        name=. (cvt2str sh),'_',":i
        bname=. 'BIND_',name
        blname=. 'BINDLN_',name
        v=. iad bname
        (memr v, (k*i{bytelen), i{bytelen) memw v, 0, i{bytelen
        v=. iad blname
        (memr v, (SZI*k), SZI) memw v, 0, SZI
      end.
    end.
  end.
  if. sqlbad z=. sqlexecute <sh do.
    erasebind sh [ freestmt sh [ r=. errret SQL_HANDLE_STMT,sh
    if. loctran do. CHTR=: CHTR-. y [ SQL_ROLLBACK comrbk y end.
    r return.
  end.
  if. sqlok z=. sqlrowcount sh;,256 do. rowcnt=. rowcnt + fat >{:z end.
  k=. >:k
end.
erasebind sh [ freestmt sh
if. loctran do. CHTR=: CHTR-. y [ SQL_COMMIT comrbk y end.
DDROWCNT=: rowcnt
DD_OK
)
SQL_SUPPORTED_NAMES=: (];._2) 0 : 0
0 
SQL_CHAR=: 1['*'           
SQL_NUMERIC=: 2['*'        
SQL_DECIMAL=: 3['*'        
SQL_INTEGER=: 4['*'        
SQL_SMALLINT=: 5['*'       
SQL_FLOAT=: 6['*'          
SQL_REAL=: 7['*'           
SQL_DOUBLE=: 8['*'         
SQL_TYPE_TIMESTAMP=:93['*' 
SQL_VARCHAR=: 12['*'       
SQL_DEFAULT=: 99['*'       
SQL_LONGVARCHAR=: _1       
SQL_BINARY=: _2['*'        
SQL_VARBINARY=: _3['*'     
SQL_LONGVARBINARY=:_4      
SQL_BIGINT=: _5['*'        
SQL_TINYINT=: _6['*'       
SQL_BIT=: _7['*'           
SQL_WCHAR=: _8['*'         
SQL_WVARCHAR=: _9['*'      
SQL_WLONGVARCHAR=: _10     
SQL_UNIQUEID=:_11['*'      
)
settypeinfo=: 3 : 0
sqlnames=. }. SQL_SUPPORTED_NAMES
SQL_SUPPORTED_TYPES=: , ". sqlnames
GDX=: SQL_SMALLINT, SQL_VARCHAR, SQL_CHAR, SQL_TYPE_TIMESTAMP
GCNM=: ;:'ifs           trctnb       trctnb     fmtdts'
GDX=: GDX, SQL_REAL, SQL_WCHAR, SQL_WVARCHAR, SQL_UNIQUEID
GCNM=: GCNM,;:'ffs     trctnb     trctnb        trctguid   char_trctnb'
if. IF64 do.
  GDX=: GDX ,~ SQL_INTEGER
  GCNM=: GCNM ;~ 'i64fs'
end.
GGETV=: (sqlnames i."1'=') {."0 1 sqlnames
GGETV=: alltrim&.> <"1 'get',"1 tolower 4 }."1 GGETV
SQL_COLBIND_TYPES=: ('*' +./"1 . = sqlnames) # SQL_SUPPORTED_TYPES
)
SQL_CHAR_z_=: 1
SQL_NUMERIC_z_=: 2
SQL_DECIMAL_z_=: 3
SQL_INTEGER_z_=: 4
SQL_SMALLINT_z_=: 5
SQL_FLOAT_z_=: 6
SQL_REAL_z_=: 7
SQL_DOUBLE_z_=: 8
SQL_DATE_z_=: 9
SQL_DATETIME_z_=: 9
SQL_TIME_z_=: 10
SQL_TYPE_DATE_z_=: 91
SQL_TYPE_TIME_z_=: 92
SQL_TYPE_TIMESTAMP_z_=: 93
SQL_VARCHAR_z_=: 12
SQL_DEFAULT_z_=: 99
SQL_LONGVARCHAR_z_=: _1
SQL_BINARY_z_=: _2
SQL_VARBINARY_z_=: _3
SQL_LONGVARBINARY_z_=: _4
SQL_BIGINT_z_=: _5
SQL_TINYINT_z_=: _6
SQL_BIT_z_=: _7
SQL_WCHAR_z_=: _8
SQL_WVARCHAR_z_=: _9
SQL_WLONGVARCHAR_z_=: _10
SQL_UNIQUEID_z_=: _11

3 : 0''
setz=. 1
if. 0=4!:0<'ODBCSETZLOCALE' do.
  if. 0=ODBCSETZLOCALE do. setz=. 0 end.
end.

if. setz do.
  settypeinfo 0
  endodbcenv 0
  setzlocale 0
  InitDone_jdd_=: 1
  initodbcenv 0
end.
EMPTY
)
