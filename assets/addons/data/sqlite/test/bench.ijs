NB. sqlite benchmark insert methods
NB. on error destroy__db'' or restart J

Note 'Benchmark insert methods'
  NB. run each line (Ctrl+r)
  load 'data/sqlite/test/bench'
  test 'mode1 da'
  test 'mode2 da'
  test 'mode3 da'
  test 'mode5 dv'
  test 'mode6 dv'
)

require '~Addons/data/sqlite/sqlite.ijs'

tm=: 6!:2

mode1=: 3 : 0
  exec__db'PRAGMA synchronous = FULL;'
  $y apply__db sqlIns
)

mode2=: 3 : 0
  exec__db'PRAGMA synchronous = OFF;'
  $y apply__db sqlIns
)

mode3=: 3 : 0
  exec__db'PRAGMA synchronous = OFF;'
  exec__db'begin;'
  $y apply__db sqlIns
  exec__db'commit;'
)

mode4veryslow=: 3 : 0  NB. x100 times
  exec__db'PRAGMA synchronous = FULL;'
  exec__db dv
)

mode5=: 3 : 0
  exec__db'PRAGMA synchronous = FULL;'
  extran__db dv
)

mode6=: 3 : 0
  exec__db'PRAGMA synchronous = OFF;'
  extran__db dv
)

ddl=: 0 : 0
create table table1(
  fname varchar(250),
  fsize long,
  fts timestamp,
  int1 long,
  int2 long,
  int3 long);
)

sqlIns=: 0 : 0
  insert into table1 values(?,?,?,?,?,?);
)

nr=: 10000
da=: (nr$<250$'abc')
da=: da,.(<"0 i.nr)
da=: da,.(nr$ <'2006-07-28')
da=: da,.(nr$ <"0 ]4 5 6)
da=: da,.(nr$ <"0 ]7 8 9)
da=: da,.(nr$ <"0 ]0 1 2)
dv=: 'table1' bulkins_psqlite_ da

FDB=: jpath '~temp/bench.sqlite'

test=: 3 : 0
  ferase FDB
  ]db=: 'psqlite'conew~ FDB
  exec__db ddl
  
  smoutput tm y
  
  smoutput exec__db 'select count(*) from table1;'
  destroy__db''
)
