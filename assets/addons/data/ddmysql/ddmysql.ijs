
3 : 0''
if. IFJ6 do.
  script_z_ '~system/main/dates.ijs'
  script_z_ '~system/main/dll.ijs'
  script_z_ '~system/main/files.ijs'
  script_z_ '~system/main/strings.ijs'
end.
EMPTY
)

coclass 'jddmysql'

InitDone=: 0
UseErrRet=: 0
UseDayNo=: 0
UseUnicode=: 0

create=: 3 : 0
if. 0=InitDone do.
  Init_jddmysql_=: 1
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

cl=. '_jddmysql_'
". (wrds ,"1 '_z_ =: ',"1 wrds ,"1 cl) -."1 ' '

if. 0=InitDone_jddmysql_ do.
  InitDone_jddmysql_=: 1
end.
endodbcenv_jddmysql_ 0
initodbcenv_jddmysql_ 0

EMPTY
)
3 : 0''
select. UNAME
case. 'Linux' do. libmysql=: 'libmysqlclient.so.16'
case. 'Darwin' do. libmysql=: 'libmysqlclient.dylib'
case. 'Win' do. libmysql=: 'libmysql.dll'
end.
i.0 0
)

MYSQL_OK=: 0
PREFETCH_ROWS=: IFWIN{1000 255     
MYSQL_NO_DATA=: 100
MYSQL_DATA_TRUNCATED=: 101

CURSOR_TYPE_NO_CURSOR=: 0
CURSOR_TYPE_READ_ONLY=: 1
CURSOR_TYPE_FOR_UPDATE=: 2
CURSOR_TYPE_SCROLLABLE=: 4

MYSQL_TIMESTAMP_NONE=: _2
MYSQL_TIMESTAMP_ERROR=: _1
MYSQL_TIMESTAMP_DATE=: 0
MYSQL_TIMESTAMP_DATETIME=: 1
MYSQL_TIMESTAMP_TIME=: 2

NOT_NULL_FLAG=: 1
PRI_KEY_FLAG=: 2
UNIQUE_KEY_FLAG=: 4
MULTIPLE_KEY_FLAG=: 8
BLOB_FLAG=: 16
UNSIGNED_FLAG=: 32
ZEROFILL_FLAG=: 64
BINARY_FLAG=: 128

MYSQL_TYPE_DECIMAL=: 0
MYSQL_TYPE_TINY=: 1
MYSQL_TYPE_SHORT=: 2
MYSQL_TYPE_LONG=: 3
MYSQL_TYPE_FLOAT=: 4
MYSQL_TYPE_DOUBLE=: 5
MYSQL_TYPE_NULL=: 6
MYSQL_TYPE_TIMESTAMP=: 7
MYSQL_TYPE_LONGLONG=: 8
MYSQL_TYPE_INT24=: 9
MYSQL_TYPE_DATE=: 10
MYSQL_TYPE_TIME=: 11
MYSQL_TYPE_DATETIME=: 12
MYSQL_TYPE_YEAR=: 13
MYSQL_TYPE_NEWDATE=: 14
MYSQL_TYPE_VARCHAR=: 15
MYSQL_TYPE_BIT=: 16

MYSQL_TYPE_NEWDECIMAL=: 246
MYSQL_TYPE_ENUM=: 247
MYSQL_TYPE_SET=: 248
MYSQL_TYPE_TINY_BLOB=: 249
MYSQL_TYPE_MEDIUM_BLOB=: 250
MYSQL_TYPE_LONG_BLOB=: 251
MYSQL_TYPE_BLOB=: 252
MYSQL_TYPE_VAR_STRING=: 253
MYSQL_TYPE_STRING=: 254
MYSQL_TYPE_GEOMETRY=: 255

STMT_ATTR_UPDATE_MAX_LENGTH=: 0
STMT_ATTR_CURSOR_TYPE=: 1
STMT_ATTR_PREFETCH_ROWS=: 2

3 : 0''
if. IF64 do.
  if. IFUNIX do.
    SZ_MYSQL_FIELD=: 128
    MYSQL_FIELD_name=: 0
    MYSQL_FIELD_org_name=: 8
    MYSQL_FIELD_table=: 16
    MYSQL_FIELD_org_table=: 24
    MYSQL_FIELD_db=: 32
    MYSQL_FIELD_catalog=: 40
    MYSQL_FIELD_def=: 48
    MYSQL_FIELD_length=: 56
    MYSQL_FIELD_max_length=: 64
    MYSQL_FIELD_name_length=: 72
    MYSQL_FIELD_org_name_length=: 76
    MYSQL_FIELD_table_length=: 80
    MYSQL_FIELD_org_table_length=: 84
    MYSQL_FIELD_db_length=: 88
    MYSQL_FIELD_catalog_length=: 92
    MYSQL_FIELD_def_length=: 96
    MYSQL_FIELD_flags=: 100
    MYSQL_FIELD_decimals=: 104
    MYSQL_FIELD_charsetnr=: 108
    MYSQL_FIELD_type=: 112
    MYSQL_FIELD_extension=: 120
    SZ_MYSQL_BIND=: 112
    MYSQL_BIND_length=: 0
    MYSQL_BIND_is_null=: 8
    MYSQL_BIND_buffer=: 16
    MYSQL_BIND_error=: 24
    MYSQL_BIND_row_ptr=: 32
    MYSQL_BIND_buffer_length=: 64
    MYSQL_BIND_offset=: 72
    MYSQL_BIND_length_value=: 80
    MYSQL_BIND_param_number=: 88
    MYSQL_BIND_pack_length=: 92
    MYSQL_BIND_buffer_type=: 96
    MYSQL_BIND_error_value=: 100
    MYSQL_BIND_is_unsigned=: 101
    MYSQL_BIND_long_data_used=: 102
    MYSQL_BIND_is_null_value=: 103
    MYSQL_BIND_extension=: 104
    SZ_MYSQL_TIME=: 40
    MYSQL_TIME_year=: 0
    MYSQL_TIME_month=: 4
    MYSQL_TIME_day=: 8
    MYSQL_TIME_hour=: 12
    MYSQL_TIME_minute=: 16
    MYSQL_TIME_second=: 20
    MYSQL_TIME_second_part=: 24
    MYSQL_TIME_neg=: 32
    MYSQL_TIME_time_type=: 36

  else.
    SZ_MYSQL_FIELD=: 120
    MYSQL_FIELD_name=: 0
    MYSQL_FIELD_org_name=: 8
    MYSQL_FIELD_table=: 16
    MYSQL_FIELD_org_table=: 24
    MYSQL_FIELD_db=: 32
    MYSQL_FIELD_catalog=: 40
    MYSQL_FIELD_def=: 48
    MYSQL_FIELD_length=: 56
    MYSQL_FIELD_max_length=: 60
    MYSQL_FIELD_name_length=: 64
    MYSQL_FIELD_org_name_length=: 68
    MYSQL_FIELD_table_length=: 72
    MYSQL_FIELD_org_table_length=: 76
    MYSQL_FIELD_db_length=: 80
    MYSQL_FIELD_catalog_length=: 84
    MYSQL_FIELD_def_length=: 88
    MYSQL_FIELD_flags=: 92
    MYSQL_FIELD_decimals=: 96
    MYSQL_FIELD_charsetnr=: 100
    MYSQL_FIELD_type=: 104
    MYSQL_FIELD_extension=: 112
    SZ_MYSQL_BIND=: 104
    MYSQL_BIND_length=: 0
    MYSQL_BIND_is_null=: 8
    MYSQL_BIND_buffer=: 16
    MYSQL_BIND_error=: 24
    MYSQL_BIND_row_ptr=: 32
    MYSQL_BIND_buffer_length=: 64
    MYSQL_BIND_offset=: 68
    MYSQL_BIND_length_value=: 72
    MYSQL_BIND_param_number=: 76
    MYSQL_BIND_pack_length=: 80
    MYSQL_BIND_buffer_type=: 84
    MYSQL_BIND_error_value=: 88
    MYSQL_BIND_is_unsigned=: 89
    MYSQL_BIND_long_data_used=: 90
    MYSQL_BIND_is_null_value=: 91
    MYSQL_BIND_extension=: 96
    SZ_MYSQL_TIME=: 36
    MYSQL_TIME_year=: 0
    MYSQL_TIME_month=: 4
    MYSQL_TIME_day=: 8
    MYSQL_TIME_hour=: 12
    MYSQL_TIME_minute=: 16
    MYSQL_TIME_second=: 20
    MYSQL_TIME_second_part=: 24
    MYSQL_TIME_neg=: 28
    MYSQL_TIME_time_type=: 32
  end.

else.
  SZ_MYSQL_FIELD=: 84
  MYSQL_FIELD_name=: 0
  MYSQL_FIELD_org_name=: 4
  MYSQL_FIELD_table=: 8
  MYSQL_FIELD_org_table=: 12
  MYSQL_FIELD_db=: 16
  MYSQL_FIELD_catalog=: 20
  MYSQL_FIELD_def=: 24
  MYSQL_FIELD_length=: 28
  MYSQL_FIELD_max_length=: 32
  MYSQL_FIELD_name_length=: 36
  MYSQL_FIELD_org_name_length=: 40
  MYSQL_FIELD_table_length=: 44
  MYSQL_FIELD_org_table_length=: 48
  MYSQL_FIELD_db_length=: 52
  MYSQL_FIELD_catalog_length=: 56
  MYSQL_FIELD_def_length=: 60
  MYSQL_FIELD_flags=: 64
  MYSQL_FIELD_decimals=: 68
  MYSQL_FIELD_charsetnr=: 72
  MYSQL_FIELD_type=: 76
  MYSQL_FIELD_extension=: 80
  SZ_MYSQL_BIND=: 64
  MYSQL_BIND_length=: 0
  MYSQL_BIND_is_null=: 4
  MYSQL_BIND_buffer=: 8
  MYSQL_BIND_error=: 12
  MYSQL_BIND_row_ptr=: 16
  MYSQL_BIND_buffer_length=: 32
  MYSQL_BIND_offset=: 36
  MYSQL_BIND_length_value=: 40
  MYSQL_BIND_param_number=: 44
  MYSQL_BIND_pack_length=: 48
  MYSQL_BIND_buffer_type=: 52
  MYSQL_BIND_error_value=: 56
  MYSQL_BIND_is_unsigned=: 57
  MYSQL_BIND_long_data_used=: 58
  MYSQL_BIND_is_null_value=: 59
  MYSQL_BIND_extension=: 60
  SZ_MYSQL_TIME=: 36
  MYSQL_TIME_year=: 0
  MYSQL_TIME_month=: 4
  MYSQL_TIME_day=: 8
  MYSQL_TIME_hour=: 12
  MYSQL_TIME_minute=: 16
  MYSQL_TIME_second=: 20
  MYSQL_TIME_second_part=: 24
  MYSQL_TIME_neg=: 28
  MYSQL_TIME_time_type=: 32
end.
''
)
mysql_affected_rows=: (libmysql, ' mysql_affected_rows > x x' ) &cd
mysql_autocommit=: (libmysql, ' mysql_autocommit > i x i' ) &cd
mysql_commit=: (libmysql, ' mysql_commit > i x' ) &cd
mysql_rollback=: (libmysql, ' mysql_rollback > i x' ) &cd
mysql_character_set_name=: (libmysql, ' mysql_character_set_name > x x' ) &cd
mysql_close=: (libmysql, ' mysql_close > n x' ) &cd
mysql_errno=: (libmysql, ' mysql_errno > i x' ) &cd
mysql_error=: (libmysql, ' mysql_error > x x' ) &cd
mysql_fetch_field_direct=: (libmysql, ' mysql_fetch_field_direct > x x i' ) &cd
mysql_fetch_lengths=: (libmysql, ' mysql_fetch_lengths > x x' ) &cd
mysql_fetch_row=: (libmysql, ' mysql_fetch_row > x x' ) &cd
mysql_field_count=: (libmysql, ' mysql_field_count > i x' ) &cd
mysql_free_result=: (libmysql, ' mysql_free_result > n x' ) &cd
mysql_get_client_info=: (libmysql, ' mysql_get_client_info > x' ) &cd
mysql_get_host_info=: (libmysql, ' mysql_get_host_info > x x' ) &cd
mysql_get_server_info=: (libmysql, ' mysql_get_server_info > x x' ) &cd
mysql_init=: (libmysql, ' mysql_init > x x' ) &cd
mysql_num_fields=: (libmysql, ' mysql_num_fields > i x' ) &cd
mysql_real_connect=: (libmysql, ' mysql_real_connect > x x *c *c *c *c i *c x' ) &cd
mysql_real_escape_string=: (libmysql, ' mysql_real_escape_string > x *c *c x' ) &cd
mysql_real_query=: (libmysql, ' mysql_real_query > i x *c x' ) &cd
mysql_set_character_set=: (libmysql, ' mysql_set_character_set > i x *c' ) &cd
mysql_sqlstate=: (libmysql, ' mysql_sqlstate > x x' ) &cd
mysql_stmt_affected_rows=: (libmysql, ' mysql_stmt_affected_rows > x x' ) &cd
mysql_stmt_attr_get=: (libmysql, ' mysql_stmt_attr_get > i x i *x' ) &cd
mysql_stmt_attr_set=: (libmysql, ' mysql_stmt_attr_set > i x i *x' ) &cd
mysql_stmt_bind_param=: (libmysql, ' mysql_stmt_bind_param > i x x' ) &cd
mysql_stmt_bind_result=: (libmysql, ' mysql_stmt_bind_result > i x x' ) &cd
mysql_stmt_close=: (libmysql, ' mysql_stmt_close > i x' ) &cd
mysql_stmt_errno=: (libmysql, ' mysql_stmt_errno > i x' ) &cd
mysql_stmt_error=: (libmysql, ' mysql_stmt_error > x x' ) &cd
mysql_stmt_execute=: (libmysql, ' mysql_stmt_execute > i x' ) &cd
mysql_stmt_fetch=: (libmysql, ' mysql_stmt_fetch > i x' ) &cd
mysql_stmt_fetch_column=: (libmysql, ' mysql_stmt_fetch_column > i x x i x' ) &cd
mysql_stmt_free_result=: (libmysql, ' mysql_stmt_free_result > i x' ) &cd
mysql_stmt_init=: (libmysql, ' mysql_stmt_init > x x' ) &cd
mysql_stmt_param_count=: (libmysql, ' mysql_stmt_param_count > x x' ) &cd
mysql_stmt_param_metadata=: (libmysql, ' mysql_stmt_param_metadata > x x' ) &cd
mysql_stmt_prepare=: (libmysql, ' mysql_stmt_prepare > i x *c x' ) &cd
mysql_stmt_reset=: (libmysql, ' mysql_stmt_reset > i x' ) &cd
mysql_stmt_result_metadata=: (libmysql, ' mysql_stmt_result_metadata > x x' ) &cd
mysql_stmt_sqlstate=: (libmysql, ' mysql_stmt_sqlstate > x x' ) &cd
mysql_store_result=: (libmysql, ' mysql_store_result > x x' ) &cd
mysql_use_result=: (libmysql, ' mysql_use_result > x x' ) &cd
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

native_type_table=: ". ;._2[ 0 : 0
MYSQL_TYPE_NEWDECIMAL
MYSQL_TYPE_NEWDECIMAL
MYSQL_TYPE_TINY
MYSQL_TYPE_SHORT
MYSQL_TYPE_LONG
MYSQL_TYPE_LONGLONG
MYSQL_TYPE_FLOAT
MYSQL_TYPE_DOUBLE
MYSQL_TYPE_TIME
MYSQL_TYPE_DATE
MYSQL_TYPE_DATETIME
MYSQL_TYPE_STRING
MYSQL_TYPE_VAR_STRING
MYSQL_TYPE_BLOB
)

odbc_type_table=: ". ;._2[ 0 : 0
SQL_NUMERIC
SQL_DECIMAL
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
DD_SUCCESS=: MYSQL_OK
DD_ERROR=: SQL_ERROR,SQL_INVALID_HANDLE
DD_OK=: MYSQL_OK
SZI=: IF64{4 8     
SFX=: >IF64{'32';'64'

iad=: 15!:14@boxopen   
b0=: <"0
bs=: ];#
fat=: ''&$@:,
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
([: -. SQL_ERROR&-:)`(MYSQL_OK = >@{.)@.UseErrRet y
)
ret_DD_OK=: 3 : 0
if. UseErrRet do. (<DD_OK), <y else. if. y do. y else. DD_OK end. end.
)
sh_to_ch=: 3 : 0
if. -.y e. shs=. 1{"1 CSPALL do. _1 return. end.
(shs i.y) { 0{"1 CSPALL
)
sh_to_mres=: 3 : 0
if. -.y e. shs=. 0{"1 SMPALL do. _1 return. end.
(shs i.y) { 1{"1 SMPALL
)
fmtfch=: >`(,.@:,)@.(1 4 8 e.~ 3!:0)

fmtfchres=: 3 : 0
if. UseErrRet do.
  if. sqlresok y do. y=. ({.y), fmtfch&.>&.>{:y end.
else.
  fmtfch&.> y
end.
)
todaynox=: 3 : 0
a=. todayno 3{."1 y
s=. 86400 %~ 3600 60 1 +/ .*"1 [ 3}."1 y
a+s
)
todatex=: 3 : 0
ymd=. todate d=. <. y
ymd,. 24 60 60#: 86400*y-d
)
errret=: 3 : 0
LERR=: ''
ALLDM=: i. 0 0
r=. SQL_ERROR
if. iscl y do.
  LERR=: y
else.
  assert. isiu y
  assert. 1 = #@$y
  assert. 2 = #y
  'ht h'=. y
  if. _1=h do.
    LERR=: '.....     0 [MYSQL Driver] No error message'
  else.
    if. 0=ht do.
      s=. mysql_errno h
      if. 0~: p=. mysql_error h do.
        erm=. memr p, 0 _1
      else.
        erm=. 'No error message'
      end.
      if. 0~: p=. mysql_sqlstate h do.
        ers=. memr p, 0 _1
      else.
        ers=. '.....'
      end.
    else.
      s=. mysql_stmt_errno h
      if. 0~: p=. mysql_stmt_error h do.
        erm=. memr p, 0 _1
      else.
        erm=. 'No error message'
      end.
      if. 0~: p=. mysql_stmt_sqlstate h do.
        ers=. memr p, 0 _1
      else.
        ers=. '.....'
      end.
    end.
    LERR=: ers,' ',(5":s),' [MYSQL Driver] ',erm
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
freestmt=: 3 : 0
erasebind y
if. #rs=. 1{"1 SMPALL#~y=0{"1 SMPALL do. mysql_free_result"0 rs end.
SMPALL=: SMPALL#~y~:0{"1 SMPALL
mysql_stmt_free_result y
mysql_stmt_close y
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
  4!:55 <'BINDRR',":y
  for_i. i.n do.
    4!:55 <'BIND',(":y),'_',":i
    4!:55 <'BINDP',(":y),'_',":i
    4!:55 <'BINDLN',(":y),'_',":i
    if. p=. bind + i*SZ_MYSQL_BIND do.
      if. 1=io do.  
        memf {. memr p, MYSQL_BIND_buffer, 1 4
      end.
      memf {. memr p, MYSQL_BIND_is_null, 1 4
      memf {. memr p, MYSQL_BIND_length, 1 4
      memf {. memr p, MYSQL_BIND_error, 1 4
    end.
  end.
end.
)

getcolinfo=: 3 : 0"1
fld=. mysql_fetch_field_direct y
assert. 0~:fld
database=. memr (memr fld, MYSQL_FIELD_db, 1 4), 0, (_2&ic memr fld, MYSQL_FIELD_db_length, 4)
catalog=. memr (memr fld, MYSQL_FIELD_catalog, 1 4), 0, (_2&ic memr fld, MYSQL_FIELD_catalog_length, 4)
table=. memr (memr fld, MYSQL_FIELD_table, 1 4), 0, (_2&ic memr fld, MYSQL_FIELD_table_length, 4)
org_table=. memr (memr fld, MYSQL_FIELD_org_table, 1 4), 0, (_2&ic memr fld, MYSQL_FIELD_org_table_length, 4)
name=. memr (memr fld, MYSQL_FIELD_name, 1 4), 0, (_2&ic memr fld, MYSQL_FIELD_name_length, 4)
org_name=. memr (memr fld, MYSQL_FIELD_org_name, 1 4), 0, (_2&ic memr fld, MYSQL_FIELD_org_name_length, 4)
def=. memr (memr fld, MYSQL_FIELD_def, 1 4), 0, (_2&ic memr fld, MYSQL_FIELD_def_length, 4)
length=. {. _2&ic memr fld, MYSQL_FIELD_length, 4
max_length=. {. _2&ic memr fld, MYSQL_FIELD_max_length, 4
flags=. {. _2&ic memr fld, MYSQL_FIELD_flags, 4
decimals=. {. _2&ic memr fld, MYSQL_FIELD_decimals, 4
charsetnr=. {. _2&ic memr fld, MYSQL_FIELD_charsetnr, 4
type=. {. _2&ic memr fld, MYSQL_FIELD_type, 4

nullable=. 0= flags 17 b. NOT_NULL_FLAG
binary=. charsetnr=63

select. type
case. MYSQL_TYPE_TINY do. typename=. 'TINY' [ coltype=. SQL_TINYINT
case. MYSQL_TYPE_SHORT do. typename=. 'SHORT' [ coltype=. SQL_SMALLINT
case. MYSQL_TYPE_LONG do. typename=. 'LONG' [ coltype=. SQL_INTEGER
case. MYSQL_TYPE_INT24 do. typename=. 'INT24' [ coltype=. SQL_INTEGER
case. MYSQL_TYPE_LONGLONG do. typename=. 'LONGLONG' [ coltype=. SQL_BIGINT
case. MYSQL_TYPE_DECIMAL do. typename=. 'DECIMAL' [ coltype=. SQL_DECIMAL
case. MYSQL_TYPE_NEWDECIMAL do. typename=. 'NEWDECIMAL' [ coltype=. SQL_DECIMAL
case. MYSQL_TYPE_FLOAT do. typename=. 'FLOAT' [ coltype=. SQL_FLOAT
case. MYSQL_TYPE_DOUBLE do. typename=. 'DOUBLE' [ coltype=. SQL_DOUBLE
case. MYSQL_TYPE_BIT do. typename=. 'BIT' [ coltype=. SQL_BIT
case. MYSQL_TYPE_TIMESTAMP do. typename=. 'TIMESTAMP' [ coltype=. SQL_TYPE_TIMESTAMP
case. MYSQL_TYPE_DATE do. typename=. 'DATE' [ coltype=. SQL_TYPE_DATE
case. MYSQL_TYPE_TIME do. typename=. 'TIME' [ coltype=. SQL_TYPE_TIME
case. MYSQL_TYPE_DATETIME do. typename=. 'DATETIME' [ coltype=. SQL_TYPE_TIMESTAMP
case. MYSQL_TYPE_YEAR do. typename=. 'YEAR' [ coltype=. SQL_TINYINT
case. MYSQL_TYPE_STRING do. typename=. 'STRING' [ coltype=. binary{SQL_CHAR,SQL_BINARY
case. MYSQL_TYPE_VAR_STRING do. typename=. 'VAR_STRING' [ coltype=. binary{SQL_VARCHAR,SQL_VARBINARY
case. MYSQL_TYPE_BLOB do. typename=. 'BLOB' [ coltype=. binary{SQL_LONGVARCHAR,SQL_LONGVARBINARY
case. MYSQL_TYPE_SET do. typename=. 'SET' [ coltype=. 0
case. MYSQL_TYPE_ENUM do. typename=. 'ENUM' [ coltype=. binary{SQL_VARCHAR,SQL_VARBINARY
case. MYSQL_TYPE_GEOMETRY do. typename=. 'GEOMETRY' [ coltype=. 0
case. MYSQL_TYPE_NULL do. typename=. 'NULL' [ coltype=. 0
case. do. assert. 0
end.

z=. ,&.> catalog;database;table;org_table;name;org_name;(>:{:y);typename;coltype;length;decimals;nullable;def;type;flags
)
getallcolinfo=: 3 : 0
rs=. sh_to_mres {.y
assert. _1~:rs
if. n=. mysql_num_fields rs do.
  z=. getcolinfo rs,.i.n
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
'MYSQL'
)
dddrv=: 3 : 0  
clr 0
ret_DD_OK ,:'MySQL';'MySQL'
)
ddsrc=: 3 : 0  
clr 0
if. -. isia y do. errret ISI08 return. end.
if. -. y e. CHALL do. errret ISI03 return. end.

if. _1= sh=. 0{:: rc=. 'show databases' preparesel y do. 1{::rc return. end.
CSPALL=: CSPALL,y,sh
if. sqlresok dat=. ddfet sh,_1 do.
  ddend^:UseErrRet sh
  ret_DD_OK dat,.(#dat)#<'MySQL'
else.
  dat [ ddend sh
end.
)

ddtbl=: 3 : 0  
clr 0
if. -. isia y do. errret ISI08 return. end.
if. -. y e. CHALL do. errret ISI03 return. end.

if. _1= sh=. 0{:: rc=. 'show tables' preparesel y do. rc return. end.
CSPALL=: CSPALL,y,sh
ret_DD_OK sh
)
ddtblx=: 3 : 0  
if. -.@sqlresok z=. ddtbl y do. z
elseif. -.@sqlresok dat=. ddfch sh,_1 [ sh=. sqlres z do. dat
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

sql=. 'select * from ', x,' where 1=0'
if. _1= sh=. 0{:: rc=. sql preparesel w do. 1{::rc return. end.
ci=. getallcolinfo sh
freestmt sh
hdr=. <;._1 ' TABLE_CAT TABLE_SCHEM TABLE_NAME COLUMN_NAME DATA_TYPE TYPE_NAME COLUMN_SIZE BUFFER_LENGTH DECIMAL_DIGITS NUM_PREC_RADIX NULLABLE REMARKS COLUMN_DEF SQL_DATA_TYPE SQL_DATETIME_SUB CHAR_OCTET_LENGTH ORDINAL_POSITION IS_NULLABLE'
r=. 0 0$<''
if. #ci do.
  cat=. 0{"1 ci
  db=. 1{"1 ci
  tb=. 2{"1 ci
  column=. 4{"1 ci
  ordid=. 6{"1 ci
  type_name=. 7{"1 ci
  data_type=. 8{"1 ci
  col_size=. 9{"1 ci
  decimals=. 10{"1 ci
  nullable=. 11{"1 ci
  dflt=. 12{"1 ci

  radix=. <"1 <. 10 * (>data_type) e. SQL_TINYINT, SQL_SMALLINT, SQL_INTEGER, SQL_INTEGER, SQL_BIGINT, SQL_DECIMAL, SQL_DECIMAL, SQL_FLOAT, SQL_DOUBLE

  sql_data_type=. data_type
  sub=. <"1[ 4|1+(SQL_TYPE_DATE,SQL_TYPE_TIME,SQL_TYPE_TIMESTAMP) i. >data_type
  char_octlen=. <"1 <. (>col_size) * (>data_type) e. SQL_CHAR, SQL_BINARY, SQL_VARCHAR, SQL_VARBINARY, SQL_LONGVARCHAR, SQL_LONGVARBINARY

  s0=. (>col_size) * (>data_type) e. SQL_BINARY, SQL_CHAR, SQL_LONGVARBINARY, SQL_LONGVARCHAR, SQL_VARBINARY, SQL_VARCHAR
  s1=. 8 1 8 8 4 4 2 1 10 12 23 0 {~ (>data_type) i.~ SQL_BIGINT, SQL_BIT, SQL_DECIMAL, SQL_DOUBLE, SQL_FLOAT, SQL_INTEGER, SQL_SMALLINT, SQL_TINYINT, SQL_TYPE_DATE, SQL_TYPE_TIME, SQL_TYPE_TIMESTAMP
  buflen=. <"1 <. s0 + s1
  r=. cat,.db,.tb,.column,.data_type,.type_name,.col_size,.buflen,.((#ci)#<,0),.radix,.nullable,.((#ci)#<''),.dflt,.sql_data_type,.sub,.char_octlen,.ordid,.((>nullable){'NO';'YES')
end.
if. #r do.
  r=. hdr,r
else.
  r=. ,:hdr
end.
ret_DD_OK r
)
ddcon=: 3 : 0  
f=. (i.&';')({. ; }.@}.) ]
clr 0
if. -.iscl y do. errret ISI08 return. end.
y=. utf8 ,y
keypair=. <;._2 y,(';'~:{:y)#';'
keyname=. tolower@dltb@({.~ i.&'=')&.> keypair
keyvalue=. dltb@(}.~ >:@(i.&'='))&.> keypair
if. keyname e.~ <'server' do.
  server=. > keyvalue {~ keyname i. <'server'
else.
  server=. 'localhost'
end.
if. keyname e.~ <'port' do.
  port=. 0". > keyvalue {~ keyname i. <'port'
else.
  port=. 0
end.
if. keyname e.~ <'database' do.
  database=. > keyvalue {~ keyname i. <'database'
else.
  database=. <0
end.
if. keyname e.~ <'uid' do.
  uid=. > keyvalue {~ keyname i. <'uid'
else.
  uid=. ''
end.
if. keyname e.~ <'pwd' do.
  pwd=. > keyvalue {~ keyname i. <'pwd'
else.
  pwd=. ''
end.

if. 0= handle=. mysql_init ::0: 0 do.
  errret ISI16 return.
end.
if. 0-: mysql_real_connect handle;server;uid;pwd;database;port;(<0);0 do.
  r=. errret 0,handle
  r [ mysql_close handle return.
end.
mysql_autocommit handle,1
mysql_set_character_set handle;'utf8'
HDBC=: handle

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
if. sqlbad mysql_close w do. errret 0,ch return. end.
CHALL=: CHALL-.ch
CSPALL=: CSPALL#~ch~:0{"1 CSPALL
DBMSALL=: DBMSALL#~ch~:>0{("1) DBMSALL
ret_DD_OK DD_OK
)
preparesel=: 4 : 0
sql=. ,utf8 x
if. 0= sh=. mysql_stmt_init y do.
  _1;ISI17 return.
end.
if. 0~: 1&(17 b.)^:IFWIN mysql_stmt_attr_set sh; STMT_ATTR_CURSOR_TYPE; ,CURSOR_TYPE_READ_ONLY do.
  r=. errret 1,sh
  mysql_stmt_close sh
  _1 ,&< r return.
end.
if. 0~: 1&(17 b.)^:IFWIN mysql_stmt_attr_set sh; STMT_ATTR_PREFETCH_ROWS; ,PREFETCH_ROWS do.
  r=. errret 1,sh
  mysql_stmt_close sh
  _1 ,&< r return.
end.
if. 0~: rc=. mysql_stmt_prepare sh;sql;#sql do.
  r=. errret 1,sh
  mysql_stmt_close sh
  _1 ,&< r return.
end.
if. 0~: mysql_stmt_param_count sh do.
  mysql_stmt_close sh
  _1 ,&< errret ISI56 return.
end.
if. 0= mres=. mysql_stmt_result_metadata sh do.
  r=. errret 1,sh
  mysql_stmt_close sh
  mysql_stmt_close sh
  _1 ,&< r return.
end.
if. 0= mysql_num_fields mres do.
  mysql_free_result mres
  mysql_stmt_close sh
  _1 ,&< errret ISI53
end.
SMPALL=: SMPALL,sh,mres
sh;''
)

preparesql=: 4 : 0
sql=. ,utf8 x
if. 0= sh=. mysql_stmt_init y do.
  _1;ISI17 return.
end.
if. 0~: rc=. mysql_stmt_prepare sh;sql;#sql do.
  r=. errret 1,sh
  mysql_stmt_close sh
  _1 ,&< r return.
end.
sh;''
)

ddsel=: 4 : 0  
clr 0
if. -.(isia w=. fat y) *. iscl x do. errret ISI08 return. end.
if. -.w e. CHALL do. errret ISI03 return. end.
x=. utf8 ,x

if. IFUNIX do.
  x1=. mema >:+:#x
  try.
    n=. mysql_real_escape_string y;x;(<x1);#x
    x=. memr x1,0,n
  catch. end.
  memf x1
end.

if. _1= sh=. 0{:: rc=. x preparesel w do. 1{::rc return. end.

CSPALL=: CSPALL,w,sh
ret_DD_OK sh
)
transact=: 4 : 0
assert. x e. SQL_COMMIT,SQL_ROLLBACK,SQL_BEGIN
COMRBK=. x{::'COMMIT';'ROLLBACK';'START TRANSACTION'
if. MYSQL_OK= r=. mysql_real_query y;COMRBK;(#COMRBK) do.
  DD_OK
else.
  SQL_ERROR
end.
)

ddsql=: 4 : 0  
clr DDROWCNT=: 0
if. -.(isia y) *. iscl x do. errret ISI08 return. end.
if. -.y e.CHALL do. errret ISI03 return. end.
x=. utf8 ,x
x1=. mema >:+:#x
try.
  n=. mysql_real_escape_string y;x;(<x1);#x
  x=. memr x1,0,n
catch. end.
memf x1

if. MYSQL_OK ~: rc=. mysql_real_query y;x;#x do. errret 0,y return. end.
DDROWCNT=: mysql_affected_rows y

ret_DD_OK DD_OK
)

ddfch=: 3 : 0  
1 ddfch y
:
clr 0
if. -. isiu y do. errret ISI08 return. end.
'sh r'=. 2{.,y,1
if. -. sh e.1{"1 CSPALL do. errret ISI04 return. end.
r=. (r<0){r,_1  
if. 0=#ci=. getallcolinfo sh do.
  r=. errret 1,sh
  r [ freestmt sh return.
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
if. -. isiu y do. errret ISI08 return. end.
'sh r'=. 2{.,y,1
if. -. sh e.1{"1 CSPALL do. errret ISI04 return. end.
r=. (r<0){r,_1  
if. 0=#ci=. getallcolinfo sh do.
  r=. errret 1,sh
  r [ freestmt sh return.
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

ddend=: 3 : 0"0  
clr 0
w=. y
if. -.isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
sh=. w
z=. freestmt sh
CSPALL=: CSPALL#~sh~:1{"1 CSPALL
if. sqlbad z do. errret 1,sh else. ret_DD_OK DD_OK end.
)
dddata=: 3 : 0  
clr 0
w=. >{.y
if. -. isia w=. fat w do. errret ISI08 return. end.
if. -.w e.1{"1 CSPALL do. errret ISI04 return. end.
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

ret_DD_OK ". ::0: 'BINDRR',":w
)
ddrow=: dddcnt 

initodbcenv=: 3 : 0
CHTR=: CHALL=: i.0  
CSPALL=: 0 2$0      
SMPALL=: 0 2$0      
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
if. 0=#ci=. getallcolinfo w do. errret 0,sh_to_ch w return. end.
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
if. sqlok SQL_BEGIN transact w do.
  CHTR=: ~.CHTR,y
  ret_DD_OK DD_OK
else.
  errret 0,w
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
  errret 0,w
end.
)

ddcom=: 3 : 0  
SQL_COMMIT comrbk y
)

ddrbk=: 3 : 0  
SQL_ROLLBACK comrbk y
)
ddttrn=: 3 : 0"0  
if. y e. CHALL do.
  y e. CHTR
else.
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
if. 'utf8' -: 4{. memr 0 _1,~ mysql_character_set_name ch do.
  charset=. UTF8
  chardiv=. 3
else.
  charset=. OEMCP
end.
dsn=. ''
uid=. ''
server=. memr 0 _1,~ mysql_get_host_info ch
ver=. memr 0 _1,~ mysql_get_server_info ch
drvname=. libmysql
drvver=. memr 0 _1,~ mysql_get_client_info''
name=. 'MYSQL'

DBMSALL=: DBMSALL, y; r=. 'MYSQL';dsn;uid;server;name;ver;drvname;drvver;charset;chardiv;bugflag
ret_DD_OK r
)
ddbind=: ddfetch=: ddbtype=: errret bind ISI14
ddcolinfo=: 3 : 0
clr 0
if. -. isia y=. fat y do. errret ISI08 return. end.
if. -.y e. 1{("1) CSPALL do. errret ISI04 return. end.
sh=. y
if. 0= #ci=. getallcolinfo sh do.
  z=. errret 1,sh
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
sql=. , utf8 x

if. _1= sh=. 0{:: rc=. sql preparesel y do. 1{::rc return. end.
if. #ci=. getallcolinfo sh do.
  freestmt sh
  assert. 15={:@$ci
  assert. 1= #@$&> ,ci
  ret_DD_OK ci
else.
  z=. errret 1,sh
  freestmt sh
  z
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
  if. 'select'-.@-:tolower 6{.sql0=. deb sql do. errret ISI08 return. end.
  if. 'show'-.@-:tolower 4{.sql0=. deb sql do. errret ISI08 return. end.
  if. 'explain'-.@-:tolower 7{.sql0=. deb sql do. errret ISI08 return. end.
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
y=. deb y
fmt=. 0  
if. ('insert into' ; 'select into') e.~ <tolower 11{.y do. ix=. 11 [ fmt=. 1
elseif. 'insert ' -: tolower 7{.y do. ix=. 6 [ fmt=. 1
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
    errret 0,y return.
  end.
end.

if. _1= sh=. 0{:: rc=. sql preparesql y do.
  r=. 1{::rc
  if. loctran do. SQL_ROLLBACK transact y end.
  r return.
end.
if. (#ty) ~: mysql_stmt_param_count sh do.
  freestmt sh [ r=. errret ISI50
  if. loctran do. SQL_ROLLBACK transact y end.
  r return.
end.
ncol=. #ty
bytelen=. ''
boxs=. ncol#0

bindname=. 'BIND',(":sh)
assert. 0~: nc <bindname

bind=. mema sb=. SZ_MYSQL_BIND * #ty
(sb#{.a.) memw bind,0,sb,2
(bindname)=: bind
('BINDN',":sh)=: #ty
('BINDIO',":sh)=: 0        

ec=. MYSQL_OK
for_i. i.ncol do.
  bname=. 'BIND',(":sh),'_',":i
  bnamel=. 'BINDLN',(":sh),'_',":i
  select. t=. i{ty
  case. MYSQL_TYPE_TINY do.
    try.
      nr=. #(bname)=: a.{~ <.,(i+of){::x
    catch.
      ec=. SQL_ERROR break.
    end.
    (bnamel)=: nr$1
    1&bindiorow bind,i,t,1
  case. MYSQL_TYPE_SHORT do.
    try.
      nr=. 2%~ #(bname)=: 1&ic <.,(i+of){::x
    catch.
      ec=. SQL_ERROR break.
    end.
    (bnamel)=: nr$2
    1&bindiorow bind,i,t,2
  case. MYSQL_TYPE_LONG do.
    if. IF64 do.
      try.
        nr=. 4%~ #(bname)=: 2&ic <.,(i+of){::x
      catch.
        ec=. SQL_ERROR break.
      end.
    else.
      try.
        nr=. #(bname)=: <.,(i+of){::x
      catch.
        ec=. SQL_ERROR break.
      end.
    end.
    (bnamel)=: nr$4
    1&bindiorow bind,i,t,4
  case. MYSQL_TYPE_LONGLONG do.
    if. IF64 do.
      try.
        nr=. #(bname)=: <.,(i+of){::x
      catch.
        ec=. SQL_ERROR break.
      end.
    else.
      try.
        nr=. 4%~ #(bname)=: 2&ic <.,(i+of){::x
      catch.
        ec=. SQL_ERROR break.
      end.
    end.
    (bnamel)=: nr$8
    1&bindiorow bind,i,t,8
  case. MYSQL_TYPE_FLOAT do.
    try.
      nr=. 4%~ #(bname)=: 1&fc (1.1-1.1)+,(i+of){::x
    catch.
      ec=. SQL_ERROR break.
    end.
    (bnamel)=: nr$4
    1&bindiorow bind,i,t,4
  case. MYSQL_TYPE_DOUBLE;MYSQL_TYPE_DECIMAL;MYSQL_TYPE_NEWDECIMAL do.
    try.
      nr=. #(bname)=: (1.1-1.1)+,(i+of){::x
    catch.
      ec=. SQL_ERROR break.
    end.
    (bnamel)=: nr$8
    1&bindiorow bind,i,MYSQL_TYPE_DOUBLE,8
  case. MYSQL_TYPE_STRING; MYSQL_TYPE_VAR_STRING do.
    if. L. da=. (i+of){::x do.
      if. 0 e. (2 e.~ 3!:0)&> da do.
        ec=. SQL_ERROR break.
      end.
      nr=. #(bname)=: da=. ,da
      boxs=. 1 i}boxs
      (bnamel)=: #&> da
      1&bindiorow bind,i,MYSQL_TYPE_STRING, 0
    else.
      if. 2>#@$ da do. da=. ,: ,da end.
      nr=. #(bname)=: da
      lns=. (ls=. {:@$ da) i}lns
      (bnamel)=: nr$ls
      1&bindiorow bind,i,MYSQL_TYPE_STRING, ls
    end.
  case. MYSQL_TYPE_BLOB do.
    if. L. da=. (i+of){::x do.
      if. 0 e. (2 e.~ 3!:0)&> da do.
        ec=. SQL_ERROR break.
      end.
      nr=. #(bname)=: da=. ,da
      boxs=. 1 i}boxs
      (bnamel)=: #&> da
      1&bindiorow bind,i,t, 0
    else.
      if. 2>#@$ da do. da=. ,: ,da end.
      nr=. #(bname)=: da
      lns=. (ls=. {:@$ da) i}lns
      (bnamel)=: nr$ls
      1&bindiorow bind,i,t, ls
    end.
  case. MYSQL_TYPE_DATE;MYSQL_TYPE_TIME;MYSQL_TYPE_TIMESTAMP do.
    if. UseDayNo do.
      if. 1 4 8 -.@e.~ 3!:0 da=. (i+of){::x do.
        ec=. SQL_ERROR break.
      end.
    else.
      if. 2 131072 -.@e.~ 3!:0 da=. (i+of){::x do.
        ec=. SQL_ERROR break.
      end.
      if. 2>#@$ da=. (i+of){::x do. da=. ,: ,da end.
      if. MYSQL_TYPE_TIMESTAMP= t do. da=. numdatetime@(23&{.)"1 da
      elseif. MYSQL_TYPE_DATE= t do. da=. numdate@(10&{.)"1 da
      elseif. MYSQL_TYPE_TIME= t do. da=. numtime@(11&}.)"1 da
      end.
    end.
    nr=. #da=. ,da
    (bname)=: SZ_MYSQL_TIME{.!.({.a.)"1[ _24]\ 2&ic ,<. todatex da
    (bnamel)=: nr#SZ_MYSQL_TIME
    (bnamel)=: 0 (I. 0=da)}bnamel~
    1&bindiorow bind,i,t,SZ_MYSQL_TIME
  case. do.
    smoutput 'ddparm unsupported type: ',":t
    ec=. SQL_ERROR break.
  end.
  bnamep=. 'BINDP',(":sh),'_',":i
  (bnamep)=: iad bname
end.
if. (MYSQL_OK) -.@e.~ ec do.
  freestmt sh [ r=. errret ISI51
  if. loctran do. SQL_ROLLBACK transact y end.
  r return.
end.

rowcnt=. 0
k=. 0
ec=. MYSQL_OK
while. k<rows do.
  for_i. i.ncol do.
    (k,(i{ty),(i{lns),i{boxs) setbinddat sh,bind,i
  end.
  if. MYSQL_OK~: ec=. 1&(17 b.)^:IFWIN mysql_stmt_bind_param sh,bind do. break end.
  if. MYSQL_OK~: ec=. mysql_stmt_execute sh do. break end.
  rowcnt=. rowcnt + 0 >. mysql_stmt_affected_rows sh
  if. MYSQL_OK~: ec=. 1&(17 b.)^:IFWIN mysql_stmt_reset sh do. break. end.
  k=. >:k
end.
if. (MYSQL_OK) -.@e.~ ec do.
  freestmt sh [ r=. errret 1,sh
  if. loctran do. SQL_ROLLBACK transact y end.
  r return.
end.
assert. k=rows
DDROWCNT=: rowcnt
freestmt sh
if. loctran do. SQL_COMMIT transact y end.
ret_DD_OK DD_OK
)
setbinddat=: 4 : 0
'sh bind i'=. y
'k ty ln boxs'=. x
bnamep=. 'BINDP',(":sh),'_',":i
pbuf=. bnamep~
p=. bind + i * SZ_MYSQL_BIND
select. ty
case. MYSQL_TYPE_TINY do.
  (pbuf+k) memw p,MYSQL_BIND_buffer,1 4
case. MYSQL_TYPE_SHORT do.
  (pbuf+k*2) memw p,MYSQL_BIND_buffer,1 4
case. MYSQL_TYPE_LONG do.
  (pbuf+k*4) memw p,MYSQL_BIND_buffer,1 4
case. MYSQL_TYPE_LONGLONG do.
  (pbuf+k*8) memw p,MYSQL_BIND_buffer,1 4
case. MYSQL_TYPE_FLOAT do.
  (pbuf+k*4) memw p,MYSQL_BIND_buffer,1 4
case. MYSQL_TYPE_DOUBLE;MYSQL_TYPE_DECIMAL;MYSQL_TYPE_NEWDECIMAL do.
  (pbuf+k*8) memw p,MYSQL_BIND_buffer,1 4
case. MYSQL_TYPE_DATETIME do.
  (pbuf+k*SZ_MYSQL_TIME) memw p,MYSQL_BIND_buffer,1 4
  bnamel=. 'BINDLN',(":sh),'_',":i
  if. 0=k{bnamel~ do.
    pisnull=. {.memr p,MYSQL_BIND_is_null,1 4
    1 memw pisnull, 0 1 1
  end.
case. MYSQL_TYPE_DATE do.
  (pbuf+k*SZ_MYSQL_TIME) memw p,MYSQL_BIND_buffer,1 4
  bnamel=. 'BINDLN',(":sh),'_',":i
  if. 0=k{bnamel~ do.
    pisnull=. {.memr p,MYSQL_BIND_is_null,1 4
    1 memw pisnull, 0 1 1
  end.
case. MYSQL_TYPE_TIME do.
  (pbuf+k*SZ_MYSQL_TIME) memw p,MYSQL_BIND_buffer,1 4
  bnamel=. 'BINDLN',(":sh),'_',":i
  if. 0=k{bnamel~ do.
    pisnull=. {.memr p,MYSQL_BIND_is_null,1 4
    1 memw pisnull, 0 1 1
  end.
case. MYSQL_TYPE_STRING; MYSQL_TYPE_VAR_STRING do.
  if. boxs do.
    bname=. 'BIND',(":sh),'_',":i
    dat=. k{::bname~
    (iad 'dat') memw p,MYSQL_BIND_buffer,1 4
    (#dat) memw p, MYSQL_BIND_buffer_length, 1 4
    plength=. {.memr p,MYSQL_BIND_length,1 4
    (#dat) memw plength, 0 1 4
  else.
    (pbuf+k*ln) memw p,MYSQL_BIND_buffer,1 4
    ln memw p, MYSQL_BIND_buffer_length, 1 4
    plength=. {.memr p,MYSQL_BIND_length,1 4
    ln memw plength, 0 1 4
  end.
case. MYSQL_TYPE_BLOB do.
  if. boxs do.
    bname=. 'BIND',(":sh),'_',":i
    dat=. k{::bname~
    (iad 'dat') memw p,MYSQL_BIND_buffer,1 4
    (#dat) memw p, MYSQL_BIND_buffer_length, 1 4
    plength=. {.memr p,MYSQL_BIND_length,1 4
    (#dat) memw plength, 0 1 4
  else.
    (pbuf+k*ln) memw p,MYSQL_BIND_buffer,1 4
    ln memw p, MYSQL_BIND_buffer_length, 1 4
    plength=. {.memr p,MYSQL_BIND_length,1 4
    ln memw plength, 0 1 4
  end.
  bnamel=. 'BINDLN',(":sh),'_',":i
  pisnull=. {.memr p,MYSQL_BIND_is_null,1 4
  (a.{~0=k{bnamel~) memw pisnull, 0 1 2
case. do.
  smoutput 'setbinddat unsupported type: ',":ty
  assert. 0
end.
)
numdate=: 3 : 0
if. 0= #y=. dltb y do.
  0
else.
  NULL=. null=. 0
  86400000%~ tsrep 0 0 0,~ 3{. ". ' ' (I. y e. '-:')}y
end.
)

numtime=: 3 : 0"1
if. 0= #y=. dltb y do.
  0
else.
  NULL=. null=. 0
  86400000%~ tsrep 0 (0 1 2)} 6{. ". ' ' (I. y e. '-:')}y
end.
)

numdatetime=: 3 : 0"1
if. 0= #y=. dltb y do.
  0
else.
  NULL=. null=. 0
  86400000%~ tsrep 6{. ". ' ' (I. y e. '-:')}y
end.
)
bindiorow=: 4 : 0
'bind i ty ln'=. y
p=. bind + i*SZ_MYSQL_BIND
(2&ic ty) memw p, MYSQL_BIND_buffer_type, 4 2
if. (0=x) *. 0<ln do.
  (mema ln) memw p, MYSQL_BIND_buffer, 1 4
  ln memw p, MYSQL_BIND_buffer_length, 1 4
else.
  0 memw p, MYSQL_BIND_buffer, 1 4
  0 memw p, MYSQL_BIND_buffer_length, 1 4
end.
(isnull=. mema 1) memw p, MYSQL_BIND_is_null, 1 4
(length=. mema SZI) memw p, MYSQL_BIND_length, 1 4
(error=. mema 1) memw p, MYSQL_BIND_error, 1 4
({.a.) memw isnull, 0 1
0 memw length, 0 1 4
({.a.) memw error, 0 1
)
getbinddat=: 3 : 0
'sh bind i'=. y
p=. bind + i * SZ_MYSQL_BIND
ty=. {. _2&ic memr p,MYSQL_BIND_buffer_type,4 2
buf=. {. memr p,MYSQL_BIND_buffer,1 4
length=. {. memr 0 1 4,~ {.memr p,MYSQL_BIND_length,1 4
isnull=. ({.a.)~: {. memr 0 1,~ {. memr p,MYSQL_BIND_is_null,1 4
error=. ({.a.)~: {. memr 0 1,~ {. memr p,MYSQL_BIND_error,1 4
select. ty
case. MYSQL_TYPE_TINY do.
  if. isnull +: error do.
    z=. memr buf,0 1 2
    st=. 1
  else.
    z=. ,{.a.
    st=. error{(isnull{1,_2),_1
  end.
case. MYSQL_TYPE_SHORT do.
  if. isnull +: error do.
    z=. memr buf,0 2 2
    st=. 2
  else.
    z=. 2#{.a.
    st=. error{(isnull{1,_2),_1
  end.
case. MYSQL_TYPE_LONG do.
  if. isnull +: error do.
    if. IF64 do.
      z=. memr buf,0 4 2
    else.
      z=. memr buf,0 1 4
    end.
    st=. 4
  else.
    if. IF64 do.
      z=. 4#{.a.
    else.
      z=. ,0
    end.
    st=. error{(isnull{1,_2),_1
  end.
case. MYSQL_TYPE_LONGLONG do.
  if. isnull +: error do.
    if. IF64 do.
      z=. memr buf,0 1 4
    else.
      z=. memr buf,0 4 2      
    end.
    st=. 8
  else.
    if. IF64 do.
      z=. ,0
    else.
      z=. 4#{.a.
    end.
    st=. error{(isnull{1,_2),_1
  end.
case. MYSQL_TYPE_FLOAT do.
  if. isnull +: error do.
    z=. _1&fc memr buf,0 4 2
    st=. 4
  else.
    z=. 1&fc 1.1-1.1
    st=. error{(isnull{1,_2),_1
  end.
case. MYSQL_TYPE_DOUBLE;MYSQL_TYPE_DECIMAL;MYSQL_TYPE_NEWDECIMAL do.
  if. isnull +: error do.
    z=. memr buf,0 1 8
    st=. 8
  else.
    z=. 2&fc 1.1-1.1
    st=. error{(isnull{1,_2),_1
  end.
case. MYSQL_TYPE_TIME;MYSQL_TYPE_DATE;MYSQL_TYPE_DATETIME do.
  if. isnull +: error do.
    z=. memr buf,0, SZ_MYSQL_TIME
    st=. SZ_MYSQL_TIME
  else.
    z=. SZ_MYSQL_TIME#{.a.
    st=. error{(isnull{1,_2),_1
  end.
case. MYSQL_TYPE_STRING;MYSQL_TYPE_VAR_STRING do.
  if. -.isnull do.
    if. buf do.
      z=. memr buf, 0, length, 2
      st=. length
    else.
      if. error do.
        (tbuf=. mema length) memw p, MYSQL_BIND_buffer, 1 4
        length memw p, MYSQL_BIND_buffer_length, 1 4
        rc=. mysql_stmt_fetch_column sh, p, i, 0
        assert. 0=rc
        z=. memr tbuf, 0, length, 2
        memf tbuf
        0 memw p, MYSQL_BIND_buffer, 1 4
        0 memw p, MYSQL_BIND_buffer_length, 1 4
        st=. length
      else.
        z=. ''
        st=. 0
      end.
    end.
  else.
    z=. ''
    st=. error{(isnull{1,_2),_1
  end.
  z=. ,&({.a.) z
case. MYSQL_TYPE_BLOB do.
  if. -.isnull do.
    if. buf do.
      z=. memr buf, 0, length, 2
      st=. length
    else.
      if. error do.
        (tbuf=. mema length) memw p, MYSQL_BIND_buffer, 1 4
        length memw p, MYSQL_BIND_buffer_length, 1 4
        rc=. mysql_stmt_fetch_column sh, p, i, 0
        assert. 0=rc
        z=. memr tbuf, 0, length, 2
        memf tbuf
        0 memw p, MYSQL_BIND_buffer, 1 4
        0 memw p, MYSQL_BIND_buffer_length, 1 4
        st=. length
      else.
        z=. ''
        st=. 0
      end.
    end.
  else.
    z=. ''
    st=. error{(isnull{1,_2),_1
  end.
  z=. <z
case. do.
  smoutput 'getbinddat unsupported type: ',":ty
  assert. 0
end.
z;st
)
getdata=: 4 : 0
'sh r'=. y
assert. 15={:$x
oty=. ; 8 {"1 x
ln=. ; 9 {"1 x
ty=. ; 13 {"1 x

dat=. 0$<''
if. r=0 do. dat return. end.

bindname=. 'BIND',(":sh)
if. 0= nc <bindname do.
  bind=. bindname~
else.
  if. MYSQL_OK~: mysql_stmt_execute sh do.
    er=. errret 1,sh
    er [ freestmt sh return.
  end.
  cnt=. 0 >. mysql_stmt_affected_rows sh

  bind=. mema sb=. SZ_MYSQL_BIND * #ty
  (sb#{.a.) memw bind,0,sb,2

  for_i. i.#ty do.
    select. t=. i{ty
    case. MYSQL_TYPE_TINY do. 0&bindiorow bind,i,t,1
    case. MYSQL_TYPE_SHORT do. 0&bindiorow bind,i,t,2
    case. MYSQL_TYPE_LONG do. 0&bindiorow bind,i,t,4
    case. MYSQL_TYPE_LONGLONG do. 0&bindiorow bind,i,t,8
    case. MYSQL_TYPE_FLOAT do. 0&bindiorow bind,i,t,4
    case. MYSQL_TYPE_DOUBLE;MYSQL_TYPE_DECIMAL;MYSQL_TYPE_NEWDECIMAL do. 0&bindiorow bind,i,MYSQL_TYPE_DOUBLE,8
    case. MYSQL_TYPE_TIME;MYSQL_TYPE_DATE;MYSQL_TYPE_DATETIME do. 0&bindiorow bind,i,t,SZ_MYSQL_TIME
    case. MYSQL_TYPE_STRING; MYSQL_TYPE_VAR_STRING do. 0&bindiorow bind,i,t,(30>:i{ln){0,i{ln
    case. MYSQL_TYPE_BLOB do. 0&bindiorow bind,i,t,0
    case. do.
      smoutput 'getdata unsupported type: ',":t
      assert. 0
    end.
  end.
  mysql_stmt_bind_result sh,bind
  (bindname)=: bind
  ('BINDN',":sh)=: #ty
  ('BINDIO',":sh)=: 1          
  ('BINDRR',":sh)=: cnt
end.

pref=. 'BIND',(":sh),'_'
prefst=. 'BINDLN',(":sh),'_'
for_i. i.#ty do.
  (prefst,":i)=: 0$0
  select. t=. i{ty
  case. MYSQL_TYPE_TINY do. (pref,":i)=: 0$''
  case. MYSQL_TYPE_SHORT do. (pref,":i)=: 0$''
  case. MYSQL_TYPE_LONG do. (pref,":i)=: 0$ IF64{:: 0;''
  case. MYSQL_TYPE_LONGLONG do. (pref,":i)=: 0$ IF64{:: '';0
  case. MYSQL_TYPE_FLOAT do. (pref,":i)=: 0$''
  case. MYSQL_TYPE_DOUBLE;MYSQL_TYPE_DECIMAL;MYSQL_TYPE_NEWDECIMAL do. (pref,":i)=: 0$1.1-1.1
  case. MYSQL_TYPE_TIME;MYSQL_TYPE_DATE;MYSQL_TYPE_DATETIME do. (pref,":i)=: 0$''
  case. MYSQL_TYPE_STRING; MYSQL_TYPE_VAR_STRING do. (pref,":i)=: 0$''
  case. MYSQL_TYPE_BLOB do. (pref,":i)=: 0$<''
  case. do.
    smoutput 'getdata unsupported type: ',":t
    assert. 0
  end.
end.
eof=. 0
z=. mysql_stmt_fetch sh
while.do.

  if. MYSQL_NO_DATA= z do.
    eof=. 1
    break.
  elseif. MYSQL_DATA_TRUNCATED= z do.
  elseif. 1= z do.
    er=. errret 1,sh
    er [ freestmt sh return.
  end.

  row=. 0$<i.0 0
  for_i. i.#ty do.
    'da lengthorstatus'=. getbinddat sh,bind,i
    (pref,":i)=: (pref,":i)~, da
    (prefst,":i)=: (prefst,":i)~, lengthorstatus
  end.

  if. 0=r=. <:r do. break. end.  
  z=. mysql_stmt_fetch sh
end.

if. 0=#(pref,":0)~ do.
  dat=. (#ty)$<i.0 0
else.
  dat=. 0$<i.0 0
  for_i. i.#ty do.
    select. t=. i{ty
    case. MYSQL_TYPE_TINY do. dat=. dat, < a.i.(pref,":i)~
    case. MYSQL_TYPE_SHORT do. dat=. dat, < _1&ic (pref,":i)~
    case. MYSQL_TYPE_LONG do. dat=. dat, < _2&ic^:IF64 (pref,":i)~
    case. MYSQL_TYPE_LONGLONG do. dat=. dat, < _2&ic^:(-.IF64) (pref,":i)~
    case. MYSQL_TYPE_FLOAT do. dat=. dat, < _1&fc (pref,":i)~
    case. MYSQL_TYPE_DOUBLE;MYSQL_TYPE_DECIMAL;MYSQL_TYPE_NEWDECIMAL do. dat=. dat, < (pref,":i)~
    case. MYSQL_TYPE_DATETIME do.
      dat=. dat, < isotimestamp`todaynox@.UseDayNo "1[ _6]\ _2&ic , 24&{."1 (-SZ_MYSQL_TIME)]\ (pref,":i)~
    case. MYSQL_TYPE_DATE do.
      dat=. dat, < 10&{.@:isotimestamp`todaynox@.UseDayNo "1[ _6]\ _2&ic , 24&{."1 (-SZ_MYSQL_TIME)]\ (pref,":i)~
    case. MYSQL_TYPE_TIME do.
      dat=. dat, < 11&}.@:isotimestamp`todaynox@.UseDayNo "1[ _6]\ _2&ic , 24&{."1 (-SZ_MYSQL_TIME)]\ (pref,":i)~
    case. MYSQL_TYPE_STRING; MYSQL_TYPE_VAR_STRING do. dat=. dat, < <;._2 ucp^:UseUnicode (pref,":i)~
    case. MYSQL_TYPE_BLOB do. dat=. dat, < (pref,":i)~
    case. do.
      smoutput 'getidata unsupported type: ',":t
      assert. 0
    end.
  end.
end.
assert. 1= # ~. #&> dat
if. eof do. ddend^:(-.UseErrRet) sh end.
if. UseErrRet do.
  (<<<0),dat
else.
  dat
end.
)

