cocurrent 'base'

18!:55 <'jddsqlite'

load 'data/ddsqlite'

smoutput y=. 'update t set a=12,b=b+?,c=(?),k=''abc'',p=right(t,3),q=trim(?,4),d=? where e1=foo(?) and e2=? or and e3<>4 and e4=?'
smoutput parsesqlparm_jddsqlite_ y
smoutput y=. 'insert into t (a,b,c,d,e,f) values (?,''?'',1,?,?,''aa'')'
smoutput parsesqlparm_jddsqlite_ y
