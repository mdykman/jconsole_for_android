
3 : 0''
if. IFJ6 do.
  script_z_ '~system/main/dates.ijs'
  script_z_ '~system/main/dll.ijs'
  script_z_ '~system/main/files.ijs'
  script_z_ '~system/main/strings.ijs'
end.
EMPTY
)

coclass 'jddsqlite'

InitDone=: 0
UseErrRet=: 0
UseDayNo=: 0
UseUnicode=: 0

create=: 3 : 0
if. 0=InitDone do.
  sqlite3_initialize''
  sqlite3_enable_shared_cache 1
  Init_jddsqlite_=: 1
end.
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

cl=. '_jddsqlite_'
". (wrds ,"1 '_z_ =: ',"1 wrds ,"1 cl) -."1 ' '

if. 0=InitDone_jddsqlite_ do.
  sqlite3_initialize_jddsqlite_''
  sqlite3_enable_shared_cache 1
  InitDone_jddsqlite_=: 1
end.
endodbcenv_jddsqlite_ 0
initodbcenv_jddsqlite_ 0

EMPTY
)
3 : 0''
if. IFUNIX do.
  libsqlite=: unxlib 'sqlite3'
else.
  libsqlite=: 'sqlite3.dll'
end.
i.0 0
)
SQLITE_INTEGER=: 1
SQLITE_FLOAT=: 2
SQLITE_TEXT=: SQLITE3_TEXT=: 3
SQLITE_BLOB=: 4
SQLITE_NULL=: 5
SQLITE_OK=: 0
SQLITE_ERROR=: 1
SQLITE_INTERNAL=: 2
SQLITE_PERM=: 3
SQLITE_ABORT=: 4
SQLITE_BUSY=: 5
SQLITE_LOCKED=: 6
SQLITE_NOMEM=: 7
SQLITE_READONLY=: 8
SQLITE_INTERRUPT=: 9
SQLITE_IOERR=: 10
SQLITE_CORRUPT=: 11
SQLITE_NOTFOUND=: 12
SQLITE_FULL=: 13
SQLITE_CANTOPEN=: 14
SQLITE_PROTOCOL=: 15
SQLITE_EMPTY=: 16
SQLITE_SCHEMA=: 17
SQLITE_TOOBIG=: 18
SQLITE_CONSTRAINT=: 19
SQLITE_MISMATCH=: 20
SQLITE_MISUSE=: 21
SQLITE_NOLFS=: 22
SQLITE_AUTH=: 23
SQLITE_FORMAT=: 24
SQLITE_RANGE=: 25
SQLITE_NOTADB=: 26
SQLITE_ROW=: 100
SQLITE_DONE=: 101
SQLITE_OPEN_READONLY=: 16b00000001
SQLITE_OPEN_READWRITE=: 16b00000002
SQLITE_OPEN_CREATE=: 16b00000004
SQLITE_OPEN_NOMUTEX=: 16b00008000
SQLITE_OPEN_FULLMUTEX=: 16b00010000
SQLITE_OPEN_SHAREDCACHE=: 16b00020000
SQLITE_OPEN_PRIVATECACHE=: 16b00040000
SQLITE_LOCK_NONE=: 0
SQLITE_LOCK_SHARED=: 1
SQLITE_LOCK_RESERVED=: 2
SQLITE_LOCK_PENDING=: 3
SQLITE_LOCK_EXCLUSIVE=: 4
SQLITE_UTF8=: 1
SQLITE_UTF16LE=: 2
SQLITE_UTF16BE=: 3
SQLITE_UTF16=: 4
SQLITE_ANY=: 5
SQLITE_UTF16_ALIGNED=: 8

SQLITE_STATIC=: 0
SQLITE_TRANSIENT=: _1
sqlite3_bind_blob=: (libsqlite, ' sqlite3_bind_blob > ',(IFWIN#'+'),' i x i *c i x' ) &cd
sqlite3_bind_double=: (libsqlite, ' sqlite3_bind_double > ',(IFWIN#'+'),' i x i d' ) &cd
sqlite3_bind_int64=: (libsqlite, ' sqlite3_bind_int64 > ',(IFWIN#'+'),' i x i x' ) &cd
sqlite3_bind_int=: (libsqlite, ' sqlite3_bind_int > ',(IFWIN#'+'),' i x i i' ) &cd
sqlite3_bind_null=: (libsqlite, ' sqlite3_bind_null > ',(IFWIN#'+'),' i x i' ) &cd
sqlite3_bind_parameter_count=: (libsqlite, ' sqlite3_bind_parameter_count > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_bind_text=: (libsqlite, ' sqlite3_bind_text > ',(IFWIN#'+'),' i x i *c i x' ) &cd
sqlite3_bind_zeroblob=: (libsqlite, ' sqlite3_bind_zeroblob > ',(IFWIN#'+'),' i x i i' ) &cd
sqlite3_busy_timeout=: (libsqlite, ' sqlite3_busy_timeout > ',(IFWIN#'+'),' i x i' ) &cd
sqlite3_changes=: (libsqlite, ' sqlite3_changes > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_close=: (libsqlite, ' sqlite3_close > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_column_blob=: (libsqlite, ' sqlite3_column_blob > ',(IFWIN#'+'),' x x i' ) &cd
sqlite3_column_bytes=: (libsqlite, ' sqlite3_column_bytes > ',(IFWIN#'+'),' i x i' ) &cd
sqlite3_column_count=: (libsqlite, ' sqlite3_column_count > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_column_database_name=: (libsqlite, ' sqlite3_column_database_name > ',(IFWIN#'+'),' x x i' ) &cd
sqlite3_column_decltype=: (libsqlite, ' sqlite3_column_decltype > ',(IFWIN#'+'),' x x i' ) &cd
sqlite3_column_double=: (libsqlite, ' sqlite3_column_double > ',(IFWIN#'+'),' d x i' ) &cd
sqlite3_column_int64=: (libsqlite, ' sqlite3_column_int64 > ',(IFWIN#'+'),' x x i' ) &cd
sqlite3_column_int=: (libsqlite, ' sqlite3_column_int > ',(IFWIN#'+'),' i x i' ) &cd
sqlite3_column_name=: (libsqlite, ' sqlite3_column_name > ',(IFWIN#'+'),' x x i' ) &cd
sqlite3_column_origin_name=: (libsqlite, ' sqlite3_column_origin_name > ',(IFWIN#'+'),' x x i' ) &cd
sqlite3_column_table_name=: (libsqlite, ' sqlite3_column_table_name > ',(IFWIN#'+'),' x x i' ) &cd
sqlite3_column_text=: (libsqlite, ' sqlite3_column_text > ',(IFWIN#'+'),' x x i' ) &cd
sqlite3_column_type=: (libsqlite, ' sqlite3_column_type > ',(IFWIN#'+'),' i x i' ) &cd
sqlite3_db_handle=: (libsqlite, ' sqlite3_db_handle > ',(IFWIN#'+'),' x x' ) &cd
sqlite3_enable_shared_cache=: (libsqlite, ' sqlite3_enable_shared_cache > ',(IFWIN#'+'),' i i' ) &cd
sqlite3_errcode=: (libsqlite, ' sqlite3_errcode > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_errmsg=: (libsqlite, ' sqlite3_errmsg > ',(IFWIN#'+'),' x x' ) &cd
sqlite3_exec=: (libsqlite, ' sqlite3_exec > ',(IFWIN#'+'),' i x *c x x *x' ) &cd
sqlite3_extended_result_codes=: (libsqlite, ' sqlite3_extended_result_codes > ',(IFWIN#'+'),' i x i' ) &cd
sqlite3_finalize=: (libsqlite, ' sqlite3_finalize > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_free=: (libsqlite, ' sqlite3_free > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_free_table=: (libsqlite, ' sqlite3_free_table > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_get_autocommit=: (libsqlite, ' sqlite3_get_autocommit > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_get_table=: (libsqlite, ' sqlite3_get_table > ',(IFWIN#'+'),' i x *c *x *i *i *x' ) &cd
sqlite3_initialize=: (libsqlite, ' sqlite3_initialize > ',(IFWIN#'+'),' i') &cd
sqlite3_last_insert_rowid=: (libsqlite, ' sqlite3_last_insert_rowid > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_libversion=: (libsqlite, ' sqlite3_libversion > ',(IFWIN#'+'),' x' ) &cd
sqlite3_libversion_number=: (libsqlite, ' sqlite3_libversion_number > ',(IFWIN#'+'),' i' ) &cd
sqlite3_open=: (libsqlite, ' sqlite3_open > ',(IFWIN#'+'),' i *c *x' ) &cd
sqlite3_open_v2=: (libsqlite, ' sqlite3_open_v2 > ',(IFWIN#'+'),' i *c *x i *c' ) &cd
sqlite3_prepare=: (libsqlite, ' sqlite3_prepare > ',(IFWIN#'+'),' i x *c i *x *x' ) &cd
sqlite3_prepare_v2=: (libsqlite, ' sqlite3_prepare_v2 > ',(IFWIN#'+'),' i x *c i *x *x' ) &cd
sqlite3_reset=: (libsqlite, ' sqlite3_reset > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_shutdown=: (libsqlite, ' sqlite3_shutdown > ',(IFWIN#'+'),' i') &cd
sqlite3_step=: (libsqlite, ' sqlite3_step > ',(IFWIN#'+'),' i x' ) &cd
sqlite3_table_column_metadata=: (libsqlite, ' sqlite3_table_column_metadata > ',(IFWIN#'+'),' i x *c *c *c *x *x *i *i *i' ) &cd
sqlite3_total_changes=: (libsqlite, ' sqlite3_total_changes > ',(IFWIN#'+'),' i x' ) &cd
3 : 0''
if. IFIOS +. (<UNAME) e. <'Android' do.
  sqlite3_column_database_name=: 0:
  sqlite3_column_origin_name=: 0:
  sqlite3_column_table_name=: 0:
  sqlite3_table_column_metadata=: 1:
end.
EMPTY
)
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
SQL_BEGIN=: 2
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

SQL_SIGNED_OFFSET=: _20
SQL_C_CHAR=: 1
SQL_C_DOUBLE=: 8
SQL_C_LONG=: 4
SQL_C_SLONG=: (SQL_C_LONG+SQL_SIGNED_OFFSET)
SQL_C_SHORT=: 5
SQL_C_SSHORT=: (SQL_C_SHORT+SQL_SIGNED_OFFSET)
SQL_C_BINARY=: _2
SQL_C_BIGINT=: _5
SQL_C_SBIGINT=: (SQL_C_BIGINT+SQL_SIGNED_OFFSET)

SQL_ADD=: 4
SQL_ATTR_CURSOR_TYPE=: 6
SQL_CURSOR_DYNAMIC=: 2
SQL_ATTR_CONCURRENCY=: 7
SQL_CONCUR_LOCK=: 2
SQL_PARAM_INPUT=: 1

'UCS2 UCS4 UTF8 OEMCP'=: i.4
COLUMNBUF=: 1000
LONGBUF=: 500000
SHORTBUF=: 255
MAXARRAYSIZE=: 65535
SQL_CHAR_z_=: SQL_CHAR=: 1
SQL_NUMERIC_z_=: SQL_NUMERIC=: 2
SQL_DECIMAL_z_=: SQL_DECIMAL=: 3
SQL_INTEGER_z_=: SQL_INTEGER=: 4
SQL_SMALLINT_z_=: SQL_SMALLINT=: 5
SQL_FLOAT_z_=: SQL_FLOAT=: 6
SQL_REAL_z_=: SQL_REAL=: 7
SQL_DOUBLE_z_=: SQL_DOUBLE=: 8
SQL_DATE_z_=: SQL_DATE=: 9
SQL_DATETIME_z_=: SQL_DATETIME=: 9
SQL_TIME_z_=: SQL_TIME=: 10
SQL_TYPE_DATE_z_=: SQL_TYPE_DATE=: 91
SQL_TYPE_TIME_z_=: SQL_TYPE_TIME=: 92
SQL_TYPE_TIMESTAMP_z_=: SQL_TYPE_TIMESTAMP=: 93
SQL_VARCHAR_z_=: SQL_VARCHAR=: 12
SQL_DEFAULT_z_=: SQL_DEFAULT=: 99
SQL_LONGVARCHAR_z_=: SQL_LONGVARCHAR=: _1
SQL_BINARY_z_=: SQL_BINARY=: _2
SQL_VARBINARY_z_=: SQL_VARBINARY=: _3
SQL_LONGVARBINARY_z_=: SQL_LONGVARBINARY=: _4
SQL_BIGINT_z_=: SQL_BIGINT=: _5
SQL_TINYINT_z_=: SQL_TINYINT=: _6
SQL_BIT_z_=: SQL_BIT=: _7
SQL_WCHAR_z_=: SQL_WCHAR=: _8
SQL_WVARCHAR_z_=: SQL_WVARCHAR=: _9
SQL_WLONGVARCHAR_z_=: SQL_WLONGVARCHAR=: _10
SQL_UNIQUEID_z_=: SQL_UNIQUEID=: _11

SQL_NULL_DATA_z_=: SQL_NULL_DATA=: _1

native_type_table=: ". ;._2 [ 0 : 0
SQL_TINYINT
SQL_SMALLINT
SQL_INTEGER
SQL_BIGINT
SQL_FLOAT
SQL_DOUBLE
SQL_TYPE_TIME
SQL_TYPE_DATE
SQL_TYPE_TIMESTAMP
SQL_CHAR
SQL_VARCHAR
SQL_LONGVARBINARY
)

odbc_type_table=: ". ;._2 [ 0 : 0
SQL_TINYINT
SQL_SMALLINT
SQL_INTEGER
SQL_BIGINT
SQL_FLOAT
SQL_DOUBLE
SQL_TYPE_TIME
SQL_TYPE_DATE
SQL_TYPE_TIMESTAMP
SQL_CHAR
SQL_VARCHAR
SQL_LONGVARBINARY
)
DD_SUCCESS=: SQLITE_OK
DD_ERROR=: SQL_ERROR,SQL_INVALID_HANDLE
DD_OK=: SQLITE_OK
SZI=: IF64{4 8
SFX=: >IF64{'32';'64'
b0=: <"0
bs=: ];#
fat=: ''&$@:,
tolower=: 3 : '(y i.~''ABCDEFGHIJKLMNOPQRSTUVWXYZ'',a.){''abcdefghijklmnopqrstuvwxyz'',a.'
alltrim=: ] #~ [: -. [: (*./\. +. *./\) ' '&=
src=: ]
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
isca=: 3!:0 e. 2 131072"_
cvt2str=: 'a'&,@":
sqlres=: 3 : 0
1&{::^:UseErrRet y
)
sqlresok=: 3 : 0
([: -. SQL_ERROR&-:)`(SQLITE_OK = >@{.)@.UseErrRet y
)
ret_DD_OK=: 3 : 0
if. UseErrRet do. (<DD_OK), <y else. if. y do. y else. DD_OK end. end.
)
sh_to_ch=: 3 : 0
if. y e. shs=. 1{"1 CSPALL do.
  if. 2{CSPALL{~ y i.~ shs do. _1 return. end.
end.
sqlite3_db_handle y
)
fmtfch=: >`(,.@:,)@.(1 4 8 e.~ 3!:0)

fmtfchres=: 3 : 0
if. UseErrRet do.
  if. sqlresok y do. y=. ({.y), fmtfch&.>&.>{:y end.
else.
  fmtfch&.> y
end.
)
declchar=: 3 : 0
s=. (}.~ i.&'(') y
(z;0){::~ ''-: z=. 0 ". ({.~ i.&')') }.s
)
parse_sqlite_typename=: 3 : 0
ly=. tolower type_name=. y
if. 1 e. 'int' E. ly do. aff=. 'int'
elseif. (1 e. 'char' E. ly) +. (1 e. 'clob' E. ly) +. (1 e. 'text' E. ly) do. aff=. 'text'
elseif. 1 e. 'blob' E. ly do. aff=. 'none'
elseif. (1 e. 'real' E. ly) +. (1 e. 'flo' E. ly) +. (1 e. 'doub' E. ly) +. (1 e. 'real' E. ly) do. aff=. 'real'
elseif. do. aff=. 'numeric'
end.
col_size=. 0
if. aff-:'int' do. col_size=. IF64{4 8
elseif. (<aff) e. 'text';'none' do. col_size=. declchar ly
elseif. (<aff) e. 'real';'numeric' do. col_size=. 8
end.
if. aff -: 'int' do. data_type=. SQL_INTEGER
elseif. aff -: 'text' do. data_type=. (0=col_size){::SQL_WVARCHAR,SQL_WLONGVARCHAR
elseif. aff -: 'none' do. data_type=. SQL_LONGVARBINARY
elseif. aff -: 'real' do. data_type=. SQL_DOUBLE
elseif. 'numeric'-:aff do.
  if. 1 e. 'timestamp' E. ly do. data_type=. SQL_TYPE_TIMESTAMP [ col_size=. 23
  elseif. 1 e. 'datetime' E. ly do. data_type=. SQL_TYPE_TIMESTAMP [ col_size=. 23
  elseif. 1 e. 'date' E. ly do. data_type=. SQL_TYPE_DATE [ col_size=. 10
  elseif. 1 e. 'time' E. ly do. data_type=. SQL_TYPE_TIME [ col_size=. 13
  elseif. do. data_type=. SQL_DOUBLE
  end.
end.
data_type ; type_name ; col_size
)
guess_sqlite_buffer=: 3 : 0
sub=. 0
'ty sz'=. y
char_octlen=. 0 [ radix=. 0 [ sql_data_type=. ty
select. ty
case. SQL_DOUBLE do. buflen=. 8 [ radix=. 10
case. SQL_INTEGER do. buflen=. IF64{4 8 [ radix=. 10 [ char_octlen=. 0
case. SQL_LONGVARBINARY do. buflen=. sz [ char_octlen=. sz
case. SQL_LONGVARCHAR do. buflen=. sz [ char_octlen=. sz
case. SQL_TYPE_DATE do. buflen=. 10 [ sql_data_type=. SQL_DATE [ sub=. 1
case. SQL_TYPE_TIME do. buflen=. 13 [ sql_data_type=. SQL_TIME [ sub=. 2
case. SQL_TYPE_TIMESTAMP do. buflen=. 23 [ sql_data_type=. SQL_DATETIME [ sub=. 3
case. SQL_VARCHAR do. buflen=. sz [ char_octlen=. sz
case. SQL_WLONGVARCHAR do. buflen=. sz [ char_octlen=. sz
case. SQL_WVARCHAR do. buflen=. 4*sz [ char_octlen=. 4*sz
case. do. 13!:8[3
end.
buflen, char_octlen, radix, sql_data_type, sub
)
errret=: 3 : 0
LERR=: ''
ALLDM=: i. 0 0
r=. SQL_ERROR
if. iscl y do.
  LERR=: y
else.
  assert. isiu y
  h=. (_1=y){y,0
  s=. sqlite3_errcode h
  if. 0~: p=. sqlite3_errmsg h do.
    LERR=: 'HY000 ',(5":s),' [SQLITE Driver] ',memr p, 0 _1
  else.
    LERR=: 'HY000 ',(5":s),' [SQLITE Driver] No error message'
  end.
end.
if. UseErrRet do.
  r;LERR
else.
  r
end.
)

clr=: 3 : 0
LERR=: ''
ALLDM=: i. 0 0
)
erasebind=: 3 : 0
if. 0= nc <('BIND',":y) do.
  assert. 0= nc <('BINDN',":y)
  n=. ('BINDN',":y)~
  4!:55 <'BINDN',":y
  bind=. ('BIND',":y)~
  4!:55 <'BIND',":y
  assert. 0= nc <('BINDIO',":y)
  io=. ('BINDIO',":y)~
  4!:55 <'BINDIO',":y
  for_i. i.n do.
    4!:55 <'BIND',(":y),'_',":i
    4!:55 <'BINDLN',(":y),'_',":i
  end.
end.
)

freestmt=: 3 : 0
erasebind y
sqlite3_finalize y
)
getcolinfo=: 3 : 0"1
'sh icol'=. y
ch=. sh_to_ch sh
assert. _1~:ch

cat=. ''

if. p=. sqlite3_column_database_name y do. database=. memr p, 0 _1 else. database=. '' end.
if. p=. sqlite3_column_table_name y do. table=. memr p, 0 _1 else. table=. '' end.
if. p=. sqlite3_column_name y do. column=. memr p, 0 _1 else. column=. '' end.
if. p=. sqlite3_column_origin_name y do. org_column=. memr p, 0 _1 else. org_column=. '' end.

org_table=. table
if. #org_column do.
  datatype=. ,_1 [ collate=. ,_1 [ notnull=. ,_1 [ primkey=. ,_1 [ autoinc=. ,_1
  if. SQLITE_OK= ec=. sqlite3_table_column_metadata ch;database;table;org_column;datatype;collate;notnull;primkey;autoinc do.
    typenamex=. memr datatype,0 _1 [ nullable=. -.{.notnull
    'datatype typename length'=. parse_sqlite_typename typenamex
    'buflen char_octlen radix sqlcoltype sub'=. guess_sqlite_buffer datatype; length
    z=. cat;database;table;org_table;column;org_column;(>:icol);typename;datatype;length;radix;nullable;'';datatype;0
  end.
else.
  if. p=. sqlite3_column_decltype y do.
    'datatype typename length'=. parse_sqlite_typename typenamex=. memr p, 0 _1
    'buflen char_octlen radix sqlcoltype sub'=. guess_sqlite_buffer datatype; length
    z=. cat;database;table;org_table;column;org_column;(>:icol);typename;datatype;length;0;0;'';datatype;0
  else.
    z=. cat;database;table;org_table;column;org_column;(>:icol);'';0;0;0;0;'';0;0
  end.
end.
,&.> z
)

getallcolinfo=: 3 : 0
if. n=. sqlite3_column_count y do.
  z=. getcolinfo y,.i.n
else.
  0 15$<''
end.
)
ddconfig=: 3 : 0
clr 0
key=. {.keynvalue=. |: _2]\ y
value=. {:keynvalue
for_i. i.#key do.
  select. tolower i{::key
  case. 'errret' do. UseErrRet=: -. 0-: {.i{::value
  case. 'dayno' do. UseDayNo=: -. 0-: {.i{::value
  case. 'unicode' do. UseUnicode=: -. 0-: {.i{::value
  end.
end.
0
)
dddriver=: 3 : 0
clr 0
'SQLITE'
)
dddrv=: 3 : 0
clr 0
ret_DD_OK ,:'SQLite3';'SQLite3'
)
ddsrc=: 3 : 0
clr 0
ret_DD_OK 0 2$<''
)

ddtbl=: 3 : 0
clr 0
if. -. isia y do. errret ISI08 return. end.
if. -. y e. CHALL do. errret ISI03 return. end.

db=. 'main'

if. SQLITE_OK = >@{. z=. ('select '''' as TABLE_CAT, ''',db,''' as TABLE_SCHEMA, name as TABLE_NAME, type as TABLE_TYPE, '''' as REMARKS from ',db,'.sqlite_master where type=''table'' order by name') preparestmt y do.
  sh=. 1{::z
  CSPALL=: CSPALL,y,sh,0
  ret_DD_OK sh
else.
  r=. errret y
end.
)

ddtblx=: 3 : 0
if. -.@sqlresok z=. ddtbl y do. z
elseif. -.@sqlresok dat=. ddfch sh,_1 [ sh=. sqlres z do. z
elseif.do. fmtfchres dat [ ddend^:UseErrRet sh
end.
)
ddcheck=: 3 : 0
if. _1=y do. empty smoutput dderr $0 else. y end.
)
ddcol=: 4 : 0
clr 0
w=. y
if. -. (iscl x) *. isia w=. fat w do. errret ISI08 return. end.
if. -. w e. CHALL do. errret ISI03 return. end.
x=. utf8 ,x

if. '.' e. x do.
  db=. }:({.~ i.&'.') x
  tb=. }.(}.~ i.&'.') x
else.
  db=. 'main' [ tb=. x
end.

tbcolname=. 0$<'' [ tbdflt=. 0$<''
if. sqlresok rc=. y ddsel~ 'PRAGMA table_info(',x,')' do.
  sh=. sqlres rc
  rc=. ddfet sh,_1
  if. UseErrRet do.
    ddend^:UseErrRet sh
    if. sqlresok rc do.
      if. #rc=. sqlres rc do.
        tbcolname=. 1{"1 rc [ tbdflt=. 4{"1 rc
      end.
    end.
  else.
    if. (0~:#rc) *. 32 = 3!:0 rc do.
      tbcolname=. 1{"1 rc [ tbdflt=. 4{"1 rc
    end.
  end.
end.

if. SQLITE_OK = >@{. z=. ('select * from ', x,' where 1=0') preparestmt y do.
  sh=. 1{::z
  err=. 0 [ r=. 0 0$<'' [ cat=. ''
  hdr=. <;._1 ' TABLE_CAT TABLE_SCHEM TABLE_NAME COLUMN_NAME DATA_TYPE TYPE_NAME COLUMN_SIZE BUFFER_LENGTH DECIMAL_DIGITS NUM_PREC_RADIX NULLABLE REMARKS COLUMN_DEF SQL_DATA_TYPE SQL_DATETIME_SUB CHAR_OCTET_LENGTH ORDINAL_POSITION IS_NULLABLE'

  for_i. i.n=. sqlite3_column_count sh do.
    if. p=. sqlite3_column_origin_name sh,i do.
      column=. memr p, 0 _1
      datatype=. ,_1 [ collate=. ,_1 [ notnull=. ,_1 [ primkey=. ,_1 [ autoinc=. ,_1
      if. SQLITE_OK= ec=. sqlite3_table_column_metadata w;db;tb;column;datatype;collate;notnull;primkey;autoinc do.
        typenamex=. memr datatype,0 _1 [ nullable=. -.{.notnull
        'data_type type_name col_size'=. parse_sqlite_typename typenamex
        'buflen char_octlen radix sql_data_type sub'=. guess_sqlite_buffer data_type; col_size
        if. (<column) e. tbcolname do.
          dflt=. ": >tbdflt{~ tbcolname i. <column
        else.
          dflt=. ''
        end.
        r=. r, cat;db;tb;column;data_type;type_name;col_size;buflen;0;radix;nullable;'';dflt;sql_data_type;sub;char_octlen;(>:i);(nullable{::'NO';'YES')
      else.
        err=. 1 break.
      end.
    else.
      err=. 1 break.
    end.
  end.
  if. 1=err do. errret w [ freestmt sh return. end.
  if. #r do.
    r=. hdr,r
  else.
    r=. ,:hdr
  end.
  ret_DD_OK r [ freestmt sh
else.
  errret w
end.
)
ddcon=: 3 : 0
f=. (i.&';')({. ; }.@}.) ]
clr 0
if. -.iscl y do. errret ISI08 return. end.
y=. utf8 ,y
keypair=. <;._2 y,(';'~:{:y)#';'
keyname=. tolower@dltb@({.~ i.&'=')&.> keypair
keyvalue=. dltb@(}.~ >:@(i.&'='))&.> keypair
if. keyname -.@e.~ <'database' do.
  errret ISI08 return.
end.
dbq=. > keyvalue {~ keyname i. <'database'
nocreate=. 1
if. keyname e.~ <'nocreate' do.
  if. ((,'0');'no';'false') e.~ keyvalue {~ keyname i. <'nocreate' do. nocreate=. 0 end.
end.
if. nocreate *. -.fexist dbq do. errret ISI18 return. end.

timeout=. 60000
if. keyname e.~ <'timeout' do.
  timeout=. <. timeout ". '0', >keyvalue {~ keyname i. <'timeout'
end.

handle=. ,_1
if. SQLITE_OK~: sqlite3_open_v2 dbq;handle;(SQLITE_OPEN_READWRITE+SQLITE_OPEN_FULLMUTEX+SQLITE_OPEN_SHAREDCACHE+(nocreate{SQLITE_OPEN_CREATE,0));<<0 do.
  errret ISI19 return.
end.
sqlite3_extended_result_codes handle, 1
sqlite3_busy_timeout handle, timeout
HDBC=: {.handle

CHALL=: CHALL,HDBC
dddbms HDBC
ret_DD_OK HDBC
)

dddis=: 3 : 0"0
clr 0
w=. y
if. -.isia w=. fat w do. errret ISI08 return. end.
if. -. w e. CHALL do. errret ISI03 return. end.

if. #sh=. 1{"1 CSPALL#~w=0{"1 CSPALL do. ddend"0 sh end.
ch=. w
if. sqlbad sqlite3_close w do. errret ch return. end.
CHALL=: CHALL-.ch
CSPALL=: CSPALL#~ch~:0{"1 CSPALL
DBMSALL=: DBMSALL#~ch~:>0{("1) DBMSALL
ret_DD_OK DD_OK
)
preparestmt=: 4 : 0
stmt=. ,_1 [ tail=. ,_1
if. SQLITE_OK = rc=. sqlite3_prepare_v2 ({.y);(bs x),stmt;tail do.
  if. ({.tail) e. 0 _1 do.
    rc;({.stmt);''
  else.
    rc;({.stmt);memr tail,0 _1
  end.
else.
  rc;_1;''
end.
)
ddsel=: 4 : 0
clr 0
if. -.(isia w=. fat y) *. iscl x do. errret ISI08 return. end.
if. -.w e. CHALL do. errret ISI03 return. end.
x=. utf8 ,x
if. SQLITE_OK ~: >@{. z=. x preparestmt w do. errret w return. end.
'ec sh tail'=. z
CSPALL=: CSPALL,w,sh,0
ret_DD_OK sh
)
transact=: 4 : 0
assert. x e. SQL_COMMIT,SQL_ROLLBACK,SQL_BEGIN
COMRBK=. x{::'COMMIT';'ROLLBACK';'BEGIN'
st=. ,_1
if. SQLITE_OK= r=. sqlite3_prepare_v2 y;COMRBK;(#COMRBK);st;<<0 do.
  r=. sqlite3_step {.st
  r1=. sqlite3_finalize {.st
  if. (SQLITE_OK,SQLITE_DONE) e.~ r do.
    DD_OK
  else.
    SQL_ERROR
  end.
else.
  SQL_ERROR
end.
)

ddsql=: 4 : 0
clr DDROWCNT=: 0
if. -.(isia y) *. iscl x do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
x=. utf8 ,x
if. SQLITE_OK ~: >@{. z=. x preparestmt y do. errret y return. end.
sh=. 1{::z
if. (SQLITE_OK,SQLITE_DONE) e.~ ec=. sqlite3_step sh do.
  DDROWCNT=: sqlite3_changes y
  ret_DD_OK DD_OK [ freestmt sh
else.
  r=. errret y
  r [ freestmt sh
end.
)

ddfch=: 3 : 0
1 ddfch y
:
clr 0
if. -. isiu y do. errret ISI08 return. end.
'sh r'=. 2{.,y,1
if. -. sh e.1{"1 CSPALL do. errret ISI04 return. end.
if. 2{CSPALL{~ sh i.~ 1{"1 CSPALL do. errret ISI04 return. end.
r=. (r<0){r,_1
if. 0=#ci=. getallcolinfo sh do.
  errret sh_to_ch sh
else.
  z=. ci getdata sh,r
  if. UseErrRet do.
    if. (<<<0)-:{.z do.
      r=. fmtfch&.>^:(_2~:x) }.z
      ret_DD_OK r
    else.
      z
    end.
  else.
    r=. fmtfch&.>^:(_2~:x) z
  end.
end.
)

ddfet=: 3 : 0
clr 0
if. -. isiu y do. errret ISI08 return. end.
'sh r'=. 2{.,y,1
if. -. sh e.1{"1 CSPALL do. errret ISI04 return. end.
if. 2{CSPALL{~ sh i.~ 1{"1 CSPALL do. errret ISI04 return. end.
r=. (r<0){r,_1
if. 0=#ci=. getallcolinfo sh do.
  errret sh_to_ch sh
else.
  z=. ci getdata sh,r
  if. UseErrRet do.
    if. (<<<0)-:{.z do.
      r=. }.z
      if. #>{.r do.
        r=. |:@:(((<@,"_1)^:(0=L.))@>) r
      else.
        r=. (0,#r)$<''
      end.
      ret_DD_OK r
    else.
      z
    end.
  else.
    if. -. SQL_ERROR-: z do.
      r=. z
      if. #>{.r do.
        r=. |:@:(((<@,"_1)^:(0=L.))@>) r
      else.
        r=. (0,#r)$<''
      end.
    else.
      z
    end.
  end.
end.
)

ddcnt=: 3 : 0
ret_DD_OK DDROWCNT
)

ddend=: 0&$: : (4 : 0)"0
clr 0
w=. y
if. -.isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
if. x do.
  assert. 3={:$CSPALL
  k=. w i.~ 1{"1 CSPALL
  CSPALL=: 1 (<k,2)}CSPALL
  ret_DD_OK DD_OK return.
end.

sh=. w
z=. freestmt w
CSPALL=: CSPALL#~sh~:1{"1 CSPALL
if. sqlbad z do. errret sh_to_ch sh else. ret_DD_OK DD_OK end.
)
dddata=: 3 : 0
clr 0
w=. >{.y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
if. 2{CSPALL{~ w i.~ 1{"1 CSPALL do. ISI04 return. end.
c=. >{:y
if. -. isia c=. fat c do. errret ISI08 return. end.
if. (0>c) +. c>: ('BINDN',":w)~ do. errret ISI54 return. end.

ret_DD_OK ". ::(''"_) 'BIND',(":w),'_',":c
)
dddataln=: 3 : 0
clr 0
w=. >{.y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
if. 2{CSPALL{~ w i.~ 1{"1 CSPALL do. ISI04 return. end.
c=. >{:y
if. -. isia c=. fat c do. errret ISI08 return. end.
if. (0>c) +. c>: ('BINDN',":w)~ do. errret ISI54 return. end.

". ::(''"_) 'BINDLN',(":w),'_',":c
)

dddcnt=: 3 : 0
clr 0
w=. y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
if. 2{CSPALL{~ w i.~ 1{"1 CSPALL do. ISI04 return. end.

errret ISI14
)
ddrow=: dddcnt

initodbcenv=: 3 : 0
CHTR=: CHALL=: i.0
CSPALL=: 0 3$0
DBMSALL=: 0 12$<''
LERR=: ''
ALLDM=: i. 0 3
BADTYPES=: i. 0 0
DDROWCNT=: 0

DD_OK
)

endodbcenv=: 3 : 0
set=. 0&= @: (4!:0)
if. set <'CHTR' do. if. #CHTR do. ddrbk CHTR end. end.
if. set <'CSPALL' do. if. #CSPALL do. ddend {:"1 CSPALL end. end.
if. set <'CHALL' do. if. #CHALL do. dddis CHALL end. end.
erase ;:'CSPALL CHALL CHTR'
)

ddcnm=: 3 : 0
clr 0
w=. y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
if. 2{CSPALL{~ w i.~ 1{"1 CSPALL do. ISI04 return. end.
if. 0=#ci=. getallcolinfo w do. errret sh_to_ch w return. end.
assert. 15= {:@$ ci
ret_DD_OK 4{"1 ci
)

dderr=: 3 : 0
0 dderr y
:
LERR
)

ddtrn=: 3 : 0
clr 0
w=. fat y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -. w e. CHALL do. errret ISI03 return. end.
if. w e. CHTR do. errret ISI07 return. end.
if. 0~: sqlite3_get_autocommit w do.
  errret ISI07
end.
if. sqlok SQL_BEGIN transact w do.
  CHTR=: ~.CHTR,y
  ret_DD_OK DD_OK
else.
  errret w
end.
)

comrbk=: 4 : 0
clr 0
w=. y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -. w e. CHALL do. errret ISI03 return. end.
if. -. w e. CHTR do. errret ISI07 return. end.
if. sqlok x transact w do.
  CHTR=: CHTR-.y
  ret_DD_OK DD_OK
else.
  errret w
end.
)

ddcom=: 3 : 0
SQL_COMMIT comrbk y
)

ddrbk=: 3 : 0
SQL_ROLLBACK comrbk y
)
ddttrn=: 3 : 0"0
if. _1~: y do.
  if. y e. CHALL do.
    0= sqlite3_get_autocommit y
  else.
    0
  end.
else.
  for_y1. CHALL do.
    if. 0= sqlite3_get_autocommit y1 do. 1 return. end.
  end.
  0
end.
)
dddbms=: 3 : 0
if. -. isia y=. fat y do. errret ISI08 return. end.
if. -.y e. CHALL do. errret ISI03 return. end.
ch=. y
clr 0
if. ch e. >0{("1) DBMSALL do.
  ret_DD_OK }.DBMSALL{~(>0{("1) DBMSALL)i.ch
  return.
end.
bugflag=. 0
chardiv=. 1
charset=. UTF8
dsn=. ''
uid=. ''
server=. ''
ver=. memr 0 _1,~ sqlite3_libversion''
drvname=. libsqlite
drvver=. ver
name=. 'SQLite'

DBMSALL=: DBMSALL, y; r=. 'SQLITE';dsn;uid;server;name;ver;drvname;drvver;charset;chardiv;bugflag
ret_DD_OK r
)
ddbind=: ddfetch=: ddbtype=: errret bind ISI14
ddcolinfo=: 3 : 0
clr 0
if. -. isia y=. fat y do. errret ISI08 return. end.
if. -.y e. 1{"1 CSPALL do. errret ISI04 return. end.
if. 2{CSPALL{~ y i.~ 1{"1 CSPALL do. errret ISI04 return. end.
sh=. y
if. 0= #ci=. getallcolinfo sh do.
  z=. errret sh_to_ch sh
else.
  assert. 15={:@$ci
  assert. 1= #@$&> ,ci
  z=. ret_DD_OK ci
end.
z
)
ddcoltype=: 4 : 0
if. -.y e.CHALL do. errret ISI03 return. end.
if. -. iscl sql=. x do. errret ISI08 return. end.

if. SQLITE_OK = >@{. z=. x preparestmt y do.
  sh=. 1{::z
  if. #ci=. getallcolinfo sh do.
    freestmt sh
    ret_DD_OK ci
  else.
    z=. errret y
    freestmt sh
    z
  end.
else.
  errret y
end.
)
ddins=: 4 : 0
clr DDROWCNT=: 0
if. -.(isia y) *. isbx x do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
if. 2>#x do. errret ISI08 return. end.
if. -. *./ 2>: #@$&> }.x do. errret ISI08 return. end.
if. 1<#rows=. ~. > {.@$&>}.x do. errret ISI08 return. end.
if. 0=rows=. fat rows do. SQL_NO_DATA; 0 return. end.
sql=. utf8 , 0{::x
if. SQL_ERROR-: z=. y ddcoltype~ sql do. z return. end.
if. (<SQL_ERROR)-: {.z do. z return. end.
'oty ty lns'=. |: _3]\;8 13 9{("1) z=. 1&{::^:UseErrRet z
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
parsesqlparm=: 3 : 0
fmt=. 0
if. ('insert into' ; 'select into') e.~ <tolower 11{.y=. dlb y do. ix=. 11 [ fmt=. 1
elseif. 'insert ' -: tolower 7{.y do. ix=. 6 [ fmt=. 1
elseif. 'delete from' -: tolower 11{.y do. ix=. 11
elseif. 'update' -: tolower 6{.y do. ix=. 6
elseif. do. ix=. _1
end.
if. _1~:ix do.
  table=. ({.~ i.&' ') dlb ix}. ' ' (I.y e.'()')}y
else.
  table=. ''
end.
if. 1=fmt do.
  if. 1 e. ivb=. ' values ' E. tolower ' ' (I.y e.'()')}y do. iv=. {.I.ivb else. fmt=. 0 end.
end.
if. 0=fmt do.
  y1=. y
  f1=. (0=(2&|)) +/\ ''''=y1
  f2=. (> 0:,}:) f1
  f2=. 0,}.f2
  y1=. ' ' (I.-.f1)}y1
  y1=. ' ' (I.f2)}y1
  f1=. 0< (([: +/\ '('&=) - ([: +/\ ')'&=)) y1
  y1=. ' ' (I.f1 *. ','=y1)}y1
  y1=. ' ' (I.y1 e.'()')}y1
  y1=. (' where ';', where ';' WHERE ';', WHERE ';' and ';', and ';' AND ';', AND ';' or ';', or ';' OR ';', OR ') stringreplace (deb y1) , ','
  a=. (',' = y1) <;._2 y1
  b=. (#~ ('='&e. *. '?'&e.)&>) a
  c=. ({.~ i:&'=')&.> b
  parm=. dtb&.> ({.~ i.&' ')&.|.&.> c
else.
  fld=. <@dltb;._1 ',', ' ' (I.a e.'()')} a=. (}.~ i.&'(') y{.~ iv

  y1=. y}.~ iv + #' values '
  f1=. (0=(2&|)) +/\ ''''=y1
  f2=. (> 0:,}:) f1
  f2=. 0,}.f2
  y1=. ' ' (I.-.f1)}y1
  y1=. ' ' (I.f2)}y1
  y1=. }.}:dltb y1
  f1=. 0< (([: +/\ '('&=) - ([: +/\ ')'&=)) y1
  y1=. ' ' (I.f1 *. ','=y1)}y1
  y1=. ' ' (I.y1 e.'()')}y1
  y1=. (deb y1),','
  a=. <;._2 y1
  msk=. ('?'&e.)&> a
  parm=. ((#fld){.msk)#fld
end.
table;parm
)
ddsparm=: 4 : 0
clr 0
if. -.(isiu y) *. (isbx x) do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
if. 2>#x do. errret ISI08 return. end.
sql=. ,0{::x
if. -.(iscl sql) do. errret ISI08 return. end.
if. ''-:table=. 0{:: tp=. parsesqlparm sql do. errret ISI08 return. end.
if. tp ~:&# x do. errret ISI08 return. end.
sql2=. 'select ', (}. ; (<',') ,&.> (}.tp)), ' from ', table, ' where 1=0'
if. SQL_ERROR-: z=. y ddcoltype~ sql2 do. z return. end.
if. (<SQL_ERROR)-: {.z do. z return. end.
'oty ty lns'=. |: _3]\;8 13 9{("1) z=. 1&{::^:UseErrRet z
a=. (2 131072 e.~ 3!:0)&> x1=. }.x
b=. (2>(#@$))&> x1
if. 1 e. r=. a *. b do.
  x=. (,:@:,&.> (1+I.r){x) (1+I.r)}x
end.
y ddparm~ (<|:oty,.lns,.ty) ,&.(1&|.) x
)
ddparm=: 4 : 0
clr DDROWCNT=: 0
if. -.(isiu y) *. (isbx x) do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
if. 3>#x do. errret ISI08 return. end.
sql=. utf8 , >0{x
tyln=. >1{x
if. -.(iscl sql) *. (isiu tyln) do. errret ISI08 return. end.
if. 1 e. 2< #@$&> 2}.x do. errret ISI08 return. end.
if. 1 < #@:~. #&> 2}.x do. errret ISI08 return. end.
f=. >x{~ of=. 2
arraysize=. rows=. #f
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
  try.
    ty=. (odbc_type_table i. sqlty){native_type_table
  catch.
    errret ISI55 return.
  end.
end.

if. (#x) ~: of+#ty do. errret ISI50 return. end.
if. 0=rows do. ret_DD_OK SQL_NO_DATA return. end.

loctran=. 0
if. y -.@e. CHTR do.
  if. sqlok SQL_BEGIN transact y do.
    loctran=. 1
  else.
    errret y return.
  end.
end.

if. SQLITE_OK ~: >@{. z=. sql preparestmt y do.
  r=. errret y
  if. loctran do. SQL_ROLLBACK transact y end.
  r return.
end.
sh=. 1{::z
if. (#ty) ~: sqlite3_bind_parameter_count sh do.
  freestmt sh [ r=. errret ISI50
  if. loctran do. SQL_ROLLBACK transact y end.
  r return.
end.
ncol=. #ty
bytelen=. ''
boxs=. ncol#0

bindname=. 'BIND',(":sh)
assert. 0~: nc <bindname

('BINDN',":sh)=: #ty
('BINDIO',":sh)=: 0

ec=. SQLITE_OK
for_i. i.ncol do.
  bname=. 'BIND',(":sh),'_',":i
  bnamel=. 'BINDLN',(":sh),'_',":i
  select. t=. i{ty
  case. SQL_INTEGER do.
    nr=. #(bname)=: <.,(i+of){::x
    (bnamel)=: nr$IF64{4 8
  case. SQL_DOUBLE do.
    nr=. #(bname)=: (1.1-1.1)+,(i+of){::x
    (bnamel)=: nr$8
  case. SQL_CHAR;SQL_WCHAR;SQL_VARCHAR;SQL_WVARCHAR;SQL_LONGVARCHAR;SQL_WLONGVARCHAR do.
    if. L. da=. (i+of){::x do.
      if. 0 e. (2 e.~ 3!:0)&> da do.
        ec=. SQL_ERROR break.
      end.
      nr=. #(bname)=: da=. ,da
      boxs=. 1 i}boxs
      (bnamel)=: #&> da
    else.
      if. 2>#@$ da do. da=. ,: ,da end.
      nr=. #(bname)=: da
      lns=. (ls=. {:@$ da) i}lns
      (bnamel)=: #@dtb"1 (bname)=: utf8"1 da
    end.
  case. SQL_LONGVARBINARY do.
    if. L. da=. (i+of){::x do.
      if. 0 e. (2 e.~ 3!:0)&> da do.
        ec=. SQL_ERROR break.
      end.
      nr=. #(bname)=: da=. ,da
      boxs=. 1 i}boxs
      (bnamel)=: #&> da
    else.
      if. 2>#@$ da do. da=. ,: ,da end.
      nr=. #(bname)=: da
      lns=. (ls=. {:@$ da) i}lns
      (bnamel)=: nr$ls
    end.
  case. SQL_TYPE_DATE;SQL_TYPE_TIME;SQL_TYPE_TIMESTAMP do.
    if. UseDayNo do.
      if. 1 4 8 -.@e.~ 3!:0 da=. (i+of){::x do.
        ec=. SQL_ERROR break.
      end.
      da=. isotimestamp 1 tsrep <.86400000* da0=. ,da
      if. SQL_TYPE_TIMESTAMP= t do. (bname)=: 23{."1 da
      elseif. SQL_TYPE_DATE= t do. (bname)=: 10{."1 da
      elseif. SQL_TYPE_TIME= t do. (bname)=: 11}."1 da
      end.
      lns=. (ls=. {:@$ da) i}lns
      nr=. #da
      (bnamel)=: nr$ls
      if. t e. SQL_TYPE_TIMESTAMP,SQL_TYPE_DATE do.
        if. 1 e. nul=. 0= da0 do.
          (bnamel)=: SQL_NULL_DATA (I. nul)} bnamel~
        end.
      end.
    else.
      if. 2 131072 -.@e.~ 3!:0 da=. (i+of){::x do.
        ec=. SQL_ERROR break.
      end.
      if. 2>#@$ da do. da=. ,: ,da end.
      if. SQL_TYPE_TIMESTAMP= t do. (bname)=: 23{."1 da
      elseif. SQL_TYPE_DATE= t do. (bname)=: 10{."1 da
      elseif. SQL_TYPE_TIME= t do. (bname)=: da
      end.
      lns=. (ls=. {:@$ da) i}lns
      nr=. #da
      (bnamel)=: nr$ls
      if. t e. SQL_TYPE_TIMESTAMP,SQL_TYPE_DATE do.
        if. 1 e. nul=. (+./("1) '1800-01-01'&E.("1) da) +. (+./("1) 'NULL'&E.("1) da) do.
          (bnamel)=: SQL_NULL_DATA (I. nul)} bnamel~
        end.
      end.
    end.
  case. do.
    freestmt sh [ r=. errret ISI51
    if. loctran do. SQL_ROLLBACK transact y end.
    r return.
  end.
end.
if. (SQLITE_OK) -.@e.~ ec do.
  freestmt sh [ r=. errret ISI51
  if. loctran do. SQL_ROLLBACK transact y end.
  r return.
end.

rowcnt=. 0
k=. 0
ec=. SQLITE_OK
while. k<rows do.
  for_i. i.ncol do.
    bname=. 'BIND',(":sh),'_',":i
    bnamel=. 'BINDLN',(":sh),'_',":i
    if. SQL_NULL_DATA = klen=. k{bnamel~ do.
      ec=. sqlite3_bind_null sh;(>:i)
    else.
      select. t=. i{ty
      case. SQL_INTEGER do.
        ec=. sqlite3_bind_int`sqlite3_bind_int64@.IF64 sh;(>:i);k{bname~
      case. SQL_DOUBLE do.
        ec=. sqlite3_bind_double sh;(>:i);k{bname~
      case. SQL_CHAR;SQL_WCHAR;SQL_VARCHAR;SQL_WVARCHAR do.
        ec=. sqlite3_bind_text sh;(>:i);(,>k{bname~);klen;SQLITE_TRANSIENT
      case. SQL_LONGVARCHAR;SQL_WLONGVARCHAR do.
        blob=. ,>k{bname~
        ec=. sqlite3_bind_text sh;(>:i);blob;(#blob);SQLITE_TRANSIENT
      case. SQL_LONGVARBINARY do.
        if. #blob=. ,>k{bname~ do.
          ec=. sqlite3_bind_blob sh;(>:i);blob;(#blob);SQLITE_TRANSIENT
        else.
          ec=. sqlite3_bind_zeroblob sh;(>:i);_1
        end.
      case. SQL_TYPE_DATE;SQL_TYPE_TIME;SQL_TYPE_TIMESTAMP do.
        ec=. sqlite3_bind_text sh;(>:i);(utf8 ,>k{bname~);_1;SQLITE_TRANSIENT
      case. do.
        assert. 0
      end.
    end.
    if. SQLITE_OK~:ec do. break. end.
  end.
  if. SQLITE_OK~:ec do. break. end.
  if. (SQLITE_OK,SQLITE_DONE) -.@e.~ ec=. sqlite3_step sh do. break. end.
  rowcnt=. rowcnt + sqlite3_changes y
  if. SQLITE_OK~:ec=. sqlite3_reset sh do. break. end.
  k=. >:k
end.
if. (SQLITE_OK,SQLITE_DONE) -.@e.~ ec do.
  freestmt sh [ r=. errret y
  if. loctran do. SQL_ROLLBACK transact y end.
  r return.
end.
assert. k=rows
DDROWCNT=: rowcnt
freestmt sh
if. loctran do. SQL_COMMIT transact y end.
ret_DD_OK DD_OK
)
datnull=: 3 : 0"1
if. SQLITE_TEXT= t=. sqlite3_column_type (b0 y) do. SQL_VARCHAR ,&< datchar y
elseif. SQLITE_BLOB= t do. SQL_LONGVARBINARY ,&< datblob y
elseif. SQLITE_INTEGER= t do. SQL_INTEGER ,&< datinteger y
elseif. SQLITE_FLOAT= t do. SQL_DOUBLE ,&< datdouble y
elseif. SQLITE_NULL= t do. 0 ,&< 0
end.
)
datchar=: 3 : 0"1
p=. sqlite3_column_text (b0 y)
n=. sqlite3_column_bytes (b0 y)
if. (0~:p) *. n>0 do.
  ({.a.),~memr p,0,n,2
else.
  {.a.
end.
)
datblob=: 3 : 0"1
p=. sqlite3_column_blob (b0 y)
n=. sqlite3_column_bytes (b0 y)
if. (0~:p) *. n>0 do.
  <memr p,0,n,2
else.
  <''
end.
)
datdouble=: 3 : 0"1
{.sqlite3_column_double (b0 y)
)
datinteger=: 3 : 0"1
{.sqlite3_column_int`sqlite3_column_int64@.IF64 (b0 y)
)
datdate=: 3 : 0"1
p=. sqlite3_column_text (b0 y)
n=. sqlite3_column_bytes (b0 y)
if. (0~:p) *. n>0 do.
  ({.a.),~ 10{. memr p,0,n,2
else.
  {.a.
end.
)
dattime=: 3 : 0"1
p=. sqlite3_column_text (b0 y)
n=. sqlite3_column_bytes (b0 y)
if. (0~:p) *. n>0 do.
  ({.a.),~ memr p,0,n,2
else.
  {.a.
end.
)
datdatetime=: 3 : 0"1
p=. sqlite3_column_text (b0 y)
n=. sqlite3_column_bytes (b0 y)
if. (0~:p) *. n>0 do.
  ({.a.),~ memr p,0,n,2
else.
  {.a.
end.
)
getdata=: 4 : 0
'sh r'=. y
assert. 15={:$x
oty=. ; 8 {"1 x
ln=. ; 9 {"1 x
ty=. ; 13 {"1 x
cc=. sh,.i.#ty

dat=. 0$<''
if. r=0 do. dat return. end.

pref=. 'BIND',(":sh),'_'
for_i. i.#ty do.
  if. SQL_INTEGER = i{ty do.
    (pref,":i)=. 0$0
  elseif. SQL_DOUBLE = i{ty do.
    (pref,":i)=. 0$1.1-1.1
  elseif. (SQL_CHAR,SQL_WCHAR,SQL_VARCHAR,SQL_WVARCHAR) e.~ i{ty do.
    (pref,":i)=. 0$''
  elseif. (SQL_LONGVARCHAR,SQL_WLONGVARCHAR) e.~ i{ty do.
    (pref,":i)=. 0$<''
  elseif. SQL_LONGVARBINARY = i{ty do.
    (pref,":i)=. 0$<''
  elseif. (SQL_TYPE_DATE,SQL_TYPE_TIME,SQL_TYPE_TIMESTAMP) e.~ i{ty do.
    (pref,":i)=. 0$''
  elseif. do.
    (pref,":i)=. 0$i.0
  end.
end.

z=. sqlite3_step sh
while.do.

  if. (SQLITE_OK,SQLITE_ROW,SQLITE_DONE) -.@e.~ rc=. >{.z do.
    errret sh_to_ch sh return.
  end.
  if. (SQLITE_ROW) -.@e.~ rc do.
    UseErrRet&ddend sh
    break.
  end.

  for_i. i.#ty do.
    if. SQL_INTEGER = i{ty do.
      (pref,":i)=. (pref,":i)~, datinteger i{cc
    elseif. SQL_DOUBLE = i{ty do.
      (pref,":i)=. (pref,":i)~, datdouble i{cc
    elseif. (SQL_CHAR,SQL_WCHAR,SQL_VARCHAR,SQL_WVARCHAR) e.~ i{ty do.
      (pref,":i)=. (pref,":i)~, datchar i{cc
    elseif. (SQL_LONGVARCHAR,SQL_WLONGVARCHAR) e.~ i{ty do.
      (pref,":i)=. (pref,":i)~, datchar i{cc
    elseif. SQL_LONGVARBINARY = i{ty do.
      (pref,":i)=. (pref,":i)~, datblob i{cc
    elseif. SQL_TYPE_DATE = i{ty do.
      (pref,":i)=. (pref,":i)~, datdate i{cc
    elseif. SQL_TYPE_TIME = i{ty do.
      (pref,":i)=. (pref,":i)~, dattime i{cc
    elseif. SQL_TYPE_TIMESTAMP = i{ty do.
      (pref,":i)=. (pref,":i)~, datdatetime i{cc
    elseif. do.
      't d'=. datnull i{cc
      if. SQL_INTEGER = t do.
        ty=. t i}ty
        (pref,":i)=. (0$~#(pref,":i)~), d
      elseif. SQL_DOUBLE = t do.
        ty=. t i}ty
        (pref,":i)=. (0$~#(pref,":i)~), d
      elseif. (SQL_CHAR,SQL_WCHAR,SQL_VARCHAR,SQL_WVARCHAR) e.~ t do.
        ty=. t i}ty
        (pref,":i)=. (({.a.)$~#(pref,":i)~), d
      elseif. (SQL_LONGVARCHAR,SQL_WLONGVARCHAR) e.~ t do.
        ty=. t i}ty
        (pref,":i)=. (({.a.)$~#(pref,":i)~), d
      elseif. SQL_LONGVARBINARY = t do.
        ty=. t i}ty
        (pref,":i)=. ((<'')$~#(pref,":i)~), d
      elseif. SQL_TYPE_DATE = t do.
        ty=. t i}ty
        (pref,":i)=. (({.a.)$~#(pref,":i)~), d
      elseif. SQL_TYPE_TIME = t do.
        ty=. t i}ty
        (pref,":i)=. (({.a.)$~#(pref,":i)~), d
      elseif. SQL_TYPE_TIMESTAMP = t do.
        ty=. t i}ty
        (pref,":i)=. (({.a.)$~#(pref,":i)~), d
      elseif. do.
        (pref,":i)=. (pref,":i)~, d
      end.
    end.
  end.

  if. 0=r=. <:r do. break. end.
  z=. sqlite3_step sh
end.
if. 0=#(pref,":0)~ do.
  dat=. (#ty)$<i.0 0
else.
  for_i. i.#ty do.
    if. SQL_INTEGER = i{ty do.
      dat=. dat, < (pref,":i)~
    elseif. SQL_DOUBLE = i{ty do.
      dat=. dat, < (pref,":i)~
    elseif. (SQL_CHAR,SQL_WCHAR,SQL_VARCHAR,SQL_WVARCHAR) e.~ i{ty do.
      dat=. dat, < <;._2 ucp^:UseUnicode (pref,":i)~
    elseif. (SQL_LONGVARCHAR,SQL_WLONGVARCHAR) e.~ i{ty do.
      dat=. dat, < <;._2 ucp^:UseUnicode (pref,":i)~
    elseif. SQL_LONGVARBINARY = i{ty do.
      dat=. dat, < (pref,":i)~
    elseif. (SQL_TYPE_DATE,SQL_TYPE_TIME,SQL_TYPE_TIMESTAMP) e.~ i{ty do.
      if. UseDayNo do.
        dat=. dat, < numdate`numtime`numdatetime@.((SQL_TYPE_DATE,SQL_TYPE_TIME,SQL_TYPE_TIMESTAMP)i.i{ty);._2 (pref,":i)~
      else.
        dat=. dat, < <;._2 (pref,":i)~
      end.
    elseif. do.
      dat=. dat, < 0#~#(pref,":i)~
    end.
  end.
end.
assert. 1= # ~. #&> dat
if. UseErrRet do.
  (<<<0),dat
else.
  dat
end.
)
numdate=: 3 : 0
if. 0= #y=. dltb y do.
  0
else.
  86400000%~ tsrep 0 0 0,~ 3{. ". ' ' (I. y e. '-:')}y
end.
)

numtime=: 3 : 0"1
if. 0= #y=. dltb y do.
  0
else.
  86400000%~ tsrep 0 (0 1 2)} 6{. ". ' ' (I. y e. '-:')}y
end.
)

numdatetime=: 3 : 0"1
if. 0= #y=. dltb y do.
  0
else.
  86400000%~ tsrep 6{. ". ' ' (I. y e. '-:')}y
end.
)
createdb=: 3 : 0
if. -.iscl y do. _2 return. end.
dbq=. utf8 ,>y
if. fexist dbq do. _1 return. end.
handle=. ,_1
if. SQLITE_OK~: rc=. sqlite3_open_v2 dbq;handle;(SQLITE_OPEN_READWRITE+SQLITE_OPEN_CREATE);<<0 do.
  rc
else.
  0 [ sqlite3_close {.handle
end.
)
exec=: 4 : 0
if. -. isia y do. _1 return. end.
if. -. y e. CHALL do. _1 return. end.
if. -.iscl x do. _1 return. end.
sql=. utf8 ,>x

if. rc=. sqlite3_exec y;sql;0;0;ep=. ,_1 do.
  if. {.ep do. sqlite_free {.ep end.
end.
rc
)
