NB. sqlite -- sqlite enhanced API for J
NB.    based on sqlite 3.3.7
NB.    http://www.sqlite.org/
NB.
NB. Sql is SQL test with optional parameters as ?
NB. Params is a list or matrix of atomic SQL parameters
NB.    if matrix, operation is repeated for each row
NB. ParamTypes indicate 0=normal and 1=BLOB parameter
NB.
NB. Errors are raised as J signal with error message
NB.
NB. Copyright 2006 (C) Oleg Kobchenko
NB. Provided AS IS. No warrantiles or liabilities extended.
NB.
NB. 11/28/05 Oleg Kobchenko
NB. 09/25/06 Oleg Kobchenko - j601
NB. 10/04/06 Oleg Kobchenko - blobsize, optional transaction; strtbl, double bind fix
NB. 10/05/06 Oleg Kobchenko - extran, bulkins

require 'files'
require '~addons/data/sqlite/def.ijs'

coclass 'psqlite'

MAXROWS=: 1000
COMMITROWS=: 1000

trc=: [ smoutput  NB. trace

chrr=: _1&$: : ([: memr ] , 0 , [)
intr=: 1&$: : ([: memr ] , 0 , JINT ,~ [)

NB.*create v opens a database connection
NB.   db=: 'psqlite'conew~ 'path/to/file.sqlite'
create=: 3 : 0
  limit''
  ignore''   NB. don't ignore errors
  blobsize'' NB. normal blob results
  r=. sqlite_open y;c1=. ,_1
  con=: {.c1
  check r
)

destroy=: 3 : 0
  check sqlite_close con
  codestroy''
)

NB.*strtbl v returns unrestricted number of rows of strings
NB.   sqltbl Sql
strtbl=: 3 : 0
  'rp rn cn ep'=. (,_1);(,_1);(,_1);(,_1)
  if. sqlite_get_table con;y;rp;rn;cn;ep do.
    es=. chrr {.ep
    sqlite_free {.ep
    sqlite_free_table {.rp
    sqlerr es
    return.
  end.
  tbl=. ((1+rn),cn)$ chrr@intr &.> ({.rp)+4*i.(1+rn)*cn
  sqlite_free_table {.rp
  tbl
)

NB.*exec v excutes one or more SQL statements
NB.   exec Sql
exec=: 3 : 0
  if. rc=. sqlite_exec con;y;0;0;ep=. ,_1 do.
    es=. chrr {.ep
    sqlite_free {.ep
    sqlerr es
    return.
  end.
  affected''
)

affected=: 3 : '(sqlite_changes , sqlite_total_changes) con'

NB.*extran v excute under optional transaction
NB.   extran Sql    See bulkins 
extran=: 3 : 0
  trans=. 1
  try. exec 'begin transaction;'
  catch. trans=. 0 end.
  try.
    r=. exec y
  catch.
    smoutput 13!:12''
    if. trans do. exec 'rollback;' end.
    sqlerr 'exec failed'
  end.
  if. trans do. exec 'commit;' end.
  r
)

NB.*apply v bulk insert/update/delete
NB.   Params apply Sql;[ParamTypes]
apply=: 4 : 0
  trans=. 1
  try. exec 'begin;'
  catch. trans=. 0 end.
  'sql pt'=. 2{.(boxopen y),<0
  trans prepare sql
  nrows=. #x=. trans normalize x
  tbl=. ''
  for_r. i.1>.nrows do.
    if. nrows do. pt bind r { x end.
    select. rc=. step''
    case. SQLITE_DONE do.
      tbl=. tbl,sqlite_last_insert_rowid con
    case. SQLITE_ERROR do.
      err=. -sqlite_reset st
      if. (0~:ignerr)+.err=0 do.
        tbl=. tbl,err
      else.
        msg=. errmsg''
        finalize''
        exec 'rollback;'
        sqlerr msg
      end.
    case. do.
      tbl=. tbl,SQLITE_E_RESULT
      if. 0=ignerr do. break. end.
    end.
    if. trans*.(r>0)*.0=COMMITROWS|r do.
      trc 'autocommit ', ":r
      exec 'commit;'
      exec 'begin;'
    end.
    sqlite_reset st
  end.
  finalize''
  if. trans do. exec 'commit;' end.
  ignore''
  tbl
)

NB.*limit v pagination for next query statement
NB.   limit [[skip],maxrows]
limit=: 3 : 0  NB. limit [[skip],maxrows]
  maxrows=: {:MAXROWS,y
  skip=: _2{0 0,y
)

ignore=: 3 : 0
  ignerr=: {.y,0
)

blobsize=: 3 : 0
  BLOBSIZE=: {.y,0
)

queryloop=: 4 : 0
  prepare y
  nrows=. #x=. normalize x
  i=. 0
  for_r. i.1>.nrows do.
    if. nrows do. bind r { x end.
    done=. 0
    while. -.done do.
      rc=. step''
      select. rc
      case. SQLITE_ERROR do.
        finalize''
        check rc
        break.
      case. SQLITE_ROW do.
        done=. query_aux_verb i=. i + 1
      case. SQLITE_DONE do.
        done=. 1
      case. do.
        break.
      end.
    end.
    sqlite_reset st
  end.
  finalize''
  limit''
)

query_aux=: 3 : 0
  if. y<:skip do. 0 return. end.
  if. 0=#tbl do. tbl=: tbl,head'' end.
  maxrows < #tbl=: tbl,vrow''
)

NB.*query v select with boxed valued results
NB.   Params query Sql
query=: 3 : 0
  '' query y
:
  tbl=: empty''
  query_aux_verb=: query_aux
  x queryloop y
  tbl
)

strquery_aux=: 3 : 0
  if. y<:skip do. 0 return. end.
  if. 0=#tbl do. tbl=: tbl,head'' end.
  maxrows < #tbl=: tbl,srow''
)

NB.*strquery v select with boxed string results
NB.   Params strquery Sql
strquery=: 3 : 0
  '' strquery y
:
  tbl=: empty''
  query_aux_verb=: strquery_aux
  x queryloop y
  tbl
)

NB.*colquery v select with column string results
NB.   Params colquery Sql
colquery=: 3 : 0
  '' colquery y
:
  if. 0=# r=. x strquery y do. r return. end.
  ({. ,: <@:>"1@|:@}.) r
)

prepare=: 3 : 0
  0 prepare y
:
  'st tail'=: (,_1);(,_1)
  r=. sqlite_prepare con;y;(#y);st;tail
  tail=: {.tail
  st=: {.st
  if. r do.
    msg=. errmsg''
    if. x do. exec 'rollback;' end.
    sqlerr msg
  end.
)

finalize=: 3 : 'check sqlite_finalize st'

step=: 3 : '>{. sqlite_step st'

normalize=: 3 : 0
  0 normalize y
:
  sharg=. $y
  try.
    select. npar=. sqlite3_bind_parameter_count st
    case. 0 do.
    case. 1 do.
      assert -.0 e. sharg
      ,y return.
    case. do.
      assert -.0 e. sharg
      assert 2 >: #sharg
      select. #sharg
      case. 0 do.
        (1,npar) $ y return.
      case. 1 do.
        assert npar = {.sharg
        (1,npar) $ y return.
      case. 2 do.
        assert npar = {:sharg
        y return.
      end.
    end.
  catch.
    smoutput 13!:12''
    finalize ''
    if. x do. exec 'rollback;' end.
    sqlerr 'argument error'
  end.
  ''
)

JB01INT=: JB01;JINT
bind=: 3 : 0
  0 bind y
:
  x=. x $~ #y
  for_c. 1+i.#y do.
    v=. >(c-1){y
    select. 3!:0 v
    case. JCHAR do.
      v=. ,v
      if. 0<#v do.
        f=. sqlite_bind_text`sqlite_bind_blob@.(*(c-1){x)
        rc=. f st;c;v;(#v);SQLITE_TRANSIENT
      else.
        rc=. sqlite_bind_null st;c
      end.
    case. JB01INT do.
      rc=. sqlite_bind_int st;c;{.v
    case. JFL do.
      rc=. sqlite_bind_double st;c;{.v
    case. do.  NB. SQLITE_NULL, etc
      v=. ''
    end.
    check rc
  end.
)

srow=: 3 : 0
  row=. ''
  cn=. sqlite_column_count st
  for_c. i.cn do.
    len=. sqlite_column_bytes st;c
    row=. row,<len chrr sqlite_column_text st;c
  end.
  row
)

vrow=: 3 : 0
  row=. ''
  cn=. sqlite_column_count st
  for_c. i.cn do.
    select. sqlite_column_type st;c
    case. SQLITE_INTEGER do.
      v=. sqlite_column_int st;c
    case. SQLITE_FLOAT do.
      v=. sqlite_column_double st;c
    case. SQLITE_TEXT do.
      len=. sqlite_column_bytes st;c
      v=. len chrr sqlite_column_text st;c
    case. SQLITE_BLOB do.
      len=. sqlite_column_bytes st;c
      if. BLOBSIZE do. v=. len else.
        v=. len chrr sqlite_column_blob st;c end.
    case. do.  NB. SQLITE_NULL, etc
      v=. ''
    end.
    row=. row,<v
  end.
  row
)

head=: 3 : 0
  row=. ''
  cn=. >{.sqlite_column_count st
  for_c. i.cn do.
    row=. row,<chrr sqlite_column_name st;c
  end.
  row
)

sqlerr=: (13!:8)&101
errmsg=: 3 : 'chrr sqlite_errmsg con'
check=: sqlerr@errmsg^:(*@])

strjoin=: ":&.>@] ;@}:@,@,. boxopen@[
strquot=: ([:''''&, ,&'''')^:(2=3!:0)

NB.*bulkins v forms string of inserts
NB.   extran__db 'table1 (col1,col2)' bulkins i.4 2
bulkins=: 4 : 0
  x=. 'insert into ',x,' values('
  ; <@(x , ');',~ [:; ','strjoin ":@strquot&.>)"1 y
)
