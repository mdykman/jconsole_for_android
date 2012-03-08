NB. def -- sqlite library binding for J
NB.    based on sqlite 3.3.7
NB.    http://www.sqlite.org/
NB.
NB. 11/28/05 Oleg Kobchenko
NB. 09/25/06 Oleg Kobchenko - j601
NB. 06/01/08 Ric Sherlock - version 3.5.9
NB. 06/10/10 Ric Sherlock - j701

require 'dll strings libpath'
coclass 'psqlite'

ADDONDIR=: jpath '~addons/data/sqlite/'

3 : 0 ''
  if. IFWIN do. LIBSQLITE=: jpathsep ADDONDIR,'lib/sqlite3.dll'
            elseif. UNAME-:'Linux' do. LIBSQLITE=: > (IFDEF'android') { 'libsqlite3.so.0';'libsqlite.so'
            elseif. do. LIBSQLITE=: find_dll 'sqlite3' end.
)

cdsq=: 1 : '(deb ''"'',LIBSQLITE,''" '',m)&cd'

sqlite_errmsg=:        'sqlite3_errmsg  >+ x  x' cdsq
sqlite_errcode=:       'sqlite3_errcode >+ i  x' cdsq
sqlite_open=:          'sqlite3_open    >+ i  *c *x' cdsq
sqlite_close=:         'sqlite3_close   >+ i  x' cdsq

sqlite_exec=:          'sqlite3_exec          >+ i  x *c  x x  *x' cdsq
sqlite_get_table=:     'sqlite3_get_table     >+ i  x *c *x  *i *i  *x' cdsq
sqlite_free_table=:    'sqlite3_free_table    >+ i  x' cdsq
sqlite_free=:          'sqlite3_free          >+ i  x' cdsq
sqlite_changes=:       'sqlite3_changes       >+ i  x' cdsq
sqlite_total_changes=: 'sqlite3_total_changes >+ i  x' cdsq

sqlite_prepare=:       'sqlite3_prepare  >+ i  x *c i *x *x' cdsq
sqlite_step=:          'sqlite3_step     >+ i  x' cdsq
sqlite_reset=:         'sqlite3_reset    >+ i  x' cdsq
sqlite_finalize=:      'sqlite3_finalize >+ i  x' cdsq

sqlite_column_count=:  'sqlite3_column_count  >+ i  x' cdsq
sqlite_column_type=:   'sqlite3_column_type   >+ i  x i' cdsq
sqlite_column_name=:   'sqlite3_column_name   >+ i  x i' cdsq
sqlite_column_bytes=:  'sqlite3_column_bytes  >+ i  x i' cdsq
sqlite_column_text=:   'sqlite3_column_text   >+ i  x i' cdsq
sqlite_column_blob=:   'sqlite3_column_blob   >+ i  x i' cdsq
sqlite_column_int=:    'sqlite3_column_int    >+ i  x i' cdsq
sqlite_column_double=: 'sqlite3_column_double >+ d  x i' cdsq

sqlite_last_insert_rowid=:     'sqlite3_last_insert_rowid    >+ i  x' cdsq
sqlite3_bind_parameter_count=: 'sqlite3_bind_parameter_count >+ i  x' cdsq

sqlite_bind_blob=:     'sqlite3_bind_blob   >+ i  x i *c i x' cdsq
sqlite_bind_int=:      'sqlite3_bind_int    >+ i  x i i' cdsq
sqlite_bind_double=:   'sqlite3_bind_double >+ i  x i d' cdsq
sqlite_bind_text=:     'sqlite3_bind_text   >+ i  x i *c i x' cdsq
sqlite_bind_null=:     'sqlite3_bind_null   >+ i  x i' cdsq


s=.  'SQLITE_OK SQLITE_ERROR SQLITE_INTERNAL SQLITE_PERM SQLITE_ABORT SQLITE_BUSY '
s=.s,'SQLITE_LOCKED SQLITE_NOMEM SQLITE_READONLY SQLITE_INTERRUPT SQLITE_IOERR '
s=.s,'SQLITE_CORRUPT SQLITE_NOTFOUND SQLITE_FULL SQLITE_CANTOPEN SQLITE_PROTOCOL '
s=.s,'SQLITE_EMPTY SQLITE_SCHEMA SQLITE_TOOBIG SQLITE_CONSTRAINT SQLITE_MISMATCH '
s=.s,'SQLITE_MISUSE SQLITE_NOLFS SQLITE_AUTH SQLITE_FORMAT SQLITE_RANGE SQLITE_NOTADB'
(s)=: i.#;:s
'SQLITE_ROW SQLITE_DONE'=: 100 101

s=. 'SQLITE_INTEGER SQLITE_FLOAT SQLITE_TEXT SQLITE_BLOB SQLITE_NULL'
(s)=: 1+i.#;:s

'SQLITE_STATIC SQLITE_TRANSIENT'=: 0 _1

SQLITE_E_RESULT=: _999  NB. unexpected result code
