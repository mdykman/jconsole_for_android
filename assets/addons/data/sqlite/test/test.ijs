NB. sqlite test - select all Ctrl+E
NB. on error destroy__db'' or restart J

require 'data/sqlite'

sqlSummary=: 0 : 0
  select 'S' TAB, count(*) CNT from S union
  select 'P' TAB, count(*) CNT from P union
  select 'SP' TAB, count(*) CNT from SP union
  select 'J' TAB, count(*) CNT from J union
  select 'SPJ' TABE, count(*) CNT from SPJ;
)

sqlSpjBySupplierAndWeight=: 0 : 0
  select S.SNAME,P.PNAME,P.WEIGHT,J.JNAME,J.CITY
    from SPJ,S,P,J
   where SPJ.SID=S.SID and SPJ.PID=P.PID and SPJ.JID=J.JID
     and SPJ.SID=? 
     and SPJ.PID in (select PID from P where WEIGHT=?);
)

FDIR=: jpath '~addons/data/sqlite/test/'
FTMP=: jpath '~temp/'
'FDB FDDL FDATA'=: cut 'date.sqlite date_ddl.sql date_data.sql '
ferase FTMP,FDB

]db=: 'psqlite'conew~ FTMP,FDB

exec__db fread FDIR,FDDL
exec__db fread FDIR,FDATA
strquery__db 'select count(*) as COUNT from S;'
strquery__db 'select * from S;' [ limit__db 2 3
strquery__db 'select * from P;'
strquery__db sqlSummary
colquery__db 'select * from P;'
17 colquery__db 'select * from P where WEIGHT=?;'
('S5';17) colquery__db sqlSpjBySupplierAndWeight
(14 17)colquery__db'select * from P where WEIGHT BETWEEN ? and ?;'
strtbl__db'select * from SP where SID=''S1'';'
(12 17) query__db 'select * from P where WEIGHT=?;'
(;+/);}.query__db 'select WEIGHT from P;'

('P7';'Cog';'Red';19.0;'London') apply__db 'insert into P values (?,?,?,?,?);'
('test1';64{.a.) apply__db 'insert into PIC values (?,?);';0 1  NB. 2nd blob
(<'test1')query__db 'select * from PIC where PICNAME=?;'
(64{.a.)-:1 0{::(<'test1')query__db 'select PICVAL from PIC where PICNAME=?;'

colquery__db 'select * from WORDS;'
(1 3) apply__db'delete from WORDS where WID=?;'
exec__db'delete from WORDS where 1;'
sqlInsWords=: 'insert into WORDS (WVAL) VALUES(?);'
(;:'one two three four') apply__db sqlInsWords
(('eleven';1),:('twelve';2))query__db'update WORDS SET WVAL=? WHERE WID=?;'

exec__db 'begin;'
(;:'qq zz') apply__db sqlInsWords
exec__db 'commit;'

extran__db 'WORDS' bulkins__db (100+i.26);"0 1]26 3$(65,:26)];.0 a.
extran__db 'WORDS' bulkins__db 200+i.8 2
colquery__db 'select * from WORDS where WID>=200'
extran__db 'WORDS (WVAL)' bulkins__db ,.i.8

destroy__db''
