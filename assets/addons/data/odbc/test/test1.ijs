NB. test1
NB.
NB. includes bigint

NMS=: ;: 'Anne Brenda Carol Denise Esther Fanny'
NB. require 'stats'
toss=: ? @ (# #) { ]

NB. =========================================================
testdb=: 3 : 0

NB. 1099511627776 _35184372088832 1125899906842624
abc=. 1 _1 1 * <. 2^40 45 50
'a b c'=. deb each '0.0' (8!:0) abc

NB. ---------------------------------------------------------
cls=. 'bon,name,sal,rate,dob'
def=. 'bon bigint,name char(6),sal numeric,rate float,dob datetime'

CH=: ddcheck ddcon 'dsn=testdata'
'drop table mytab' ddsql CH
('create table mytab (',def,')') ddsql CH

for_i. 1 do.
  t=. 'insert into mytab (',cls,') values (',a,',''Anne'',40000,1.234,''1970-11-23 11:12:13'')'
  assert. 0 = t ddsql CH
  t=. 'insert into mytab (',cls,') values (',b,',''Brenda'',42000,0.7,''1982-05-28'')'
  assert. 0 = t ddsql CH
end.

if. 1 do.
  len=. 3
NB. ?format for datetime ddins
  s=. (,.len$abc);(>len toss NMS);(,.20000+?len$50000);(,.0.001*?len$100000) NB. ;len$,:'1970-11-23 11:12:13'
  smoutput s
  sel=. 'select bon,name,sal,rate from mytab'
  smoutput (sel;s) ddins CH
end.

sh=. 'select * from mytab' ddsel CH
smoutput 'ddfet'
smoutput ddfet sh,_1

sh=. 'select * from mytab' ddsel CH
smoutput 'ddfch'
smoutput ddfch sh,_1

empty dddis sh,CH
)

dbg 1
dbstops''
NB. dbstops 'ddins'
testdb ''

