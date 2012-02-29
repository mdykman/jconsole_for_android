cocurrent 'base'

wrds=. 'ddsrc ddtbl ddtblx ddcol ddcon dddis ddfch ddend ddsel ddcnm dderr'
wrds=. wrds, ' dddrv ddsql ddcnt ddtrn ddcom ddrbk ddbind ddfetch'
wrds=. wrds ,' dddata ddfet ddbtype ddcheck ddrow ddins ddparm ddsparm dddbms ddcolinfo ddttrn'
wrds=. ;: wrds ,' dddriver ddconfig'
4!:55 wrds ,&.> <'_z_'
18!:55 <'jddmysql'

load 'data/ddmysql'

integerdate=: 0

tdata_ddl=: 0 : 0
create table tdata (
NAME varchar(15),
SEX varchar(1),
DEPT varchar(4),
DOB date,
DOH date,
SALARY decimal(8,2),
PHOTO longblob );
)

tdata_ddl2=: 0 : 0
create table tdata (
NAME varchar(15),
SEX varchar(1),
DEPT varchar(4),
DOB integer,
DOH integer,
SALARY integer,
PHOTO longblob );
)

tdata_data=: 0 : 0
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Macdonald B', 'F', 'D101', '1959-06-01', '1978-05-01', 32591);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Genereaux S', 'F', 'D103', '1945-03-01', '1966-02-01', 95415);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Koebel R', 'M', 'D101', '1937-11-01', '1980-09-01', 63374);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Keller J', 'F', 'D101', '1951-05-01', '1974-04-01', 48898);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Twa L', 'F', 'D108', '1955-07-01', '1980-04-01', 49075);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Blamire J', 'F', 'D101', '1960-08-01', '1979-12-01', 46469);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Gordon E', 'F', 'D103', '1952-02-01', '1979-08-01', 29960);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Denny D', 'F', 'D101', '1949-08-01', '1980-04-01', 46939);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Newton R', 'M', 'D108', '1956-01-01', '1979-02-01', 73368);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Miller S', 'F', 'D103', '1965-01-01', '1983-03-01', 43418);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Dingee S', 'M', 'D103', '1964-10-01', '1983-09-01', 46877);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Bugg P', 'F', 'D101', '1920-11-01', '1958-04-01', 47165);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Lafrance R', 'F', 'D101', '1952-02-01', '1983-02-01', 47017);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Rogerson G', 'M', 'D101', '1957-12-01', '1983-02-01', 108777);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Brando D', 'F', 'D108', '1959-04-01', '1977-08-01', 44931);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Anctil J', 'M', 'D108', '1946-06-01', '1979-06-01', 60974);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Bauerlein J', 'F', 'D103', '1962-04-01', '1984-09-01', 33668);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('O''Keefe D', 'M', 'D101', '1939-03-01', '1967-10-01', 66377);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Beale D', 'F', 'D103', '1957-03-01', '1974-04-01', 48023);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Chesher D', 'F', 'D103', '1956-10-01', '1984-08-01', 35184);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Cahill G', 'M', 'D108', '1932-05-01', '1967-10-01', 81358);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Abbott K', 'M', 'D103', '1963-10-01', '1983-09-01', 50817);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('McKee M', 'F', 'D103', '1960-04-01', '1981-04-01', 43115);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Livingston P', 'F', 'D101', '1958-09-01', '1980-08-01', 50010);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Holliss D', 'F', 'D101', '1960-05-01', '1977-07-01', 46313);
)

tdata_data2=: 0 : 0
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Macdonald B', 'F', 'D101', 19590601, 19780501, 32591);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Genereaux S', 'F', 'D103', 19450301, 19660201, 95415);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Koebel R', 'M', 'D101', 19371101, 19800901, 63374);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Keller J', 'F', 'D101', 19510501, 19740401, 48898);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Twa L', 'F', 'D108', 19550701, 19800401, 49075);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Blamire J', 'F', 'D101', 19600801, 19791201, 46469);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Gordon E', 'F', 'D103', 19520201, 19790801, 29960);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Denny D', 'F', 'D101', 19490801, 19800401, 46939);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Newton R', 'M', 'D108', 19560101, 19790201, 73368);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Miller S', 'F', 'D103', 19650101, 19830301, 43418);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Dingee S', 'M', 'D103', 19641001, 19830901, 46877);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Bugg P', 'F', 'D101', 19201101, 19580401, 47165);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Lafrance R', 'F', 'D101', 19520201, 19830201, 47017);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Rogerson G', 'M', 'D101', 19571201, 19830201, 108777);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Brando D', 'F', 'D108', 19590401, 19770801, 44931);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Anctil J', 'M', 'D108', 19460601, 19790601, 60974);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Bauerlein J', 'F', 'D103', 19620401, 19840901, 33668);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('O''Keefe D', 'M', 'D101', 19390301, 19671001, 66377);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Beale D', 'F', 'D103', 19570301, 19740401, 48023);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Chesher D', 'F', 'D103', 19561001, 19840801, 35184);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Cahill G', 'M', 'D108', 19320501, 19671001, 81358);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Abbott K', 'M', 'D103', 19631001, 19830901, 50817);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('McKee M', 'F', 'D103', 19600401, 19810401, 43115);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Livingston P', 'F', 'D101', 19580901, 19800801, 50010);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Holliss D', 'F', 'D101', 19600501, 19770701, 46313);
)

NB. =========================================================
testdb=: 3 : 0
NB. either set user and password here or define them in environment
NB. user=. 'yourid'
NB. password=. 'yourpassword'
if. 0 0 -.@-: nc 'user';'password' do.
  user=. 2!:5'MYSQL_USER'
  password=. 2!:5'MYSQL_PASSWORD'
  if. 0-:host=. 2!:5'MYSQL_HOST' do.
    smoutput '>>> environmental variable MYSQL_HOST not set. use default localhost'
    host=. 'localhost'
  end.
  if. (0-:user) +. 0-:password do.
    smoutput '>>> environmental variable MYSQL_USER or MYSQL_PASSWORD not set' return.
  end.
end.
NB. setzlocale_jddmysql_ ''
db=. '' conew 'jddmysql'

ddconfig__db 'errret';0;'dayno';0;'unicode';1

smoutput '>> dddriver'
smoutput dddriver__db''

smoutput '>> dddrv'
smoutput dddrv__db''

f=. 'jdata'

smoutput '>> connect to server'
if. _1~: ch=. ddcon__db 'server=',host,';uid=',user,';pwd=',password,';database=mysql' do.

  smoutput '>> delete old database'
  if. _1= ch ddsql__db~ 'drop database if exists ',f do.
    smoutput dderr__db''
  end.

  if. _1= ch ddsql__db~ 'create database ',f,' character set=utf8' do.
    smoutput dderr__db''
    return.
  end.

  dddis__db ch

else.
  smoutput dderr__db''
  destroy__db''
  return.
end.

smoutput '>> open database'
if. _1~: ch=. ddcon__db 'server=',host,';uid=',user,';pwd=',password,';database=',f do.

  smoutput '>> ddsrc'
  smoutput ddsrc__db ch

  smoutput '>> use innodb engine which supports transactions'
  if. _1= ch ddsql__db~ 'set storage_engine=innodb' do.
    smoutput dderr__db''
    return.
  end.
  smoutput '>> create metadata and fill sample data'
  if. _1= ch ddsql__db~ integerdate{::tdata_ddl;tdata_ddl2 do.
    smoutput dderr__db''
    return.
  end.
  ddtrn__db ch
  ddsql__db&ch &.> <;._2 (integerdate{::tdata_data;tdata_data2) -. LF
  ddcom__db ch

  smoutput '>> dddbm'
  smoutput dddbms__db ch
  smoutput '>> ddtblx'
  smoutput ddtblx__db ch

  smoutput '>> ddtbl'
  if. _1~: sh=. ddtbl__db ch do.
    smoutput '>> ddcnm'
    smoutput ddcnm__db sh
    smoutput '>> ddfet'
    smoutput ddfet__db sh,_1
  end.
  smoutput '>> ddcol'
  smoutput 'tdata' ddcol__db ch
  smoutput '>> ddsel 5 rows'
  if. _1~: sh=. ch ddsel__db~ 'select * from tdata' do.
    smoutput '>> ddcolinfo'
    smoutput ddcolinfo__db sh
    smoutput '>> ddcnm'
    ddcnm__db sh
    smoutput '>> ddfet'
    smoutput ddfet__db sh,5
    smoutput '>> ddend'
    ddend__db sh
  end.
  smoutput '>> ddfch'
  if. _1~: sh=. ch ddsel__db~ 'select * from tdata' do.
    smoutput ddfch__db sh,_1
    ddend__db sh
  end.
  smoutput '>> ddfch__db raw format'
  if. _1~: sh=. ch ddsel__db~ 'select * from tdata' do.
    smoutput r=. _2&ddfch__db sh,_1
    ddend__db sh
  end.
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch
  smoutput '>> ddtrn'
  ddtrn__db ch
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch
  smoutput '>> update inside transaction'
  if. _1= ch ddsql__db~ 'update tdata set SALARY=SALARY + 100' do.
    smoutput dderr__db''
  else.
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
  end.
  smoutput '>> value changed in transaction'
  if. _1~: sh=. ch ddsel__db~ 'select * from tdata' do.
    smoutput ddfet__db sh,3
    ddend__db sh
  else.
    smoutput dderr__db''
  end.
  smoutput '>> abort transaction'
  ddrbk__db ch
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch

  smoutput '>> value restored'
  if. _1~: sh=. ch ddsel__db~ 'select * from tdata' do.
    smoutput ddfet__db sh,3
    ddend__db sh
  else.
    smoutput dderr__db''
  end.

  smoutput '>> ddtrn'
  ddtrn__db ch
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch
  smoutput '>> update inside transaction'
  ch ddsql__db~ 'update tdata set SALARY=SALARY + 1'
  smoutput '>> commit transaction'
  ddcom__db ch
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch
  if. _1~: sh=. ch ddsel__db~ 'select * from tdata' do.
    smoutput ddfet__db sh,3
    ddend__db sh
  end.
  smoutput '>> dderr'
  ch ddsql__db~ 'update NOTABLE set status=status + 1'
  smoutput dderr__db''

  smoutput '>> ddins'
  len=. 1e3              NB. very slow
  if. integerdate do.
    data=. ((len, 5)$'A''BCDEF');((len, 1)$'MF');((len, 4)$'E101E201');((len, 1)$19910213);((len, 1)$20081203);(,. 1+i.len)
  else.
    if. UseDayNo__db do.
      data=. ((len,5)$'A''BCDEF');((len,1)$'MF');((len,4)$'E101E201');(len$todayno 1991 2 13);(len$todayno 2008 12 3);(,. 1+i.len)
    else.
      data=. ((len,5)$'A''BCDEF');((len,1)$'MF');((len,4)$'E101E201');((len,10)$'1991-02-13');((len,10)$'2008-12-03');(,. 1+i.len)
    end.
  end.
  smoutput '>> begin insert ', (":len), ' rows'
  if. _1~: rc=. ch ddins__db~ 'select NAME, SEX, DEPT, DOB, DOH, SALARY from tdata';data do.
    smoutput '>> finish insert ', (":len), ' rows'
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. _1~: sh=. ch ddsel__db~ 'select count(*) from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203' do.
      smoutput ddfet__db sh,_1
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
    if. _1~: sh=. ch ddsel__db~ 'select * from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203' do.
      smoutput ddfet__db sh,5
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> bulk insert with ddparm'
  ch ddsql__db~ 'delete from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203'
  smoutput '>> begin insert ', (":len), ' rows'
  sql=. 'insert into tdata(NAME, SEX, DEPT, DOB, DOH, SALARY) values (?,?,?,?,?,?)'
  if. _1~: rc=. ch ddparm__db~ sql;((3#SQL_VARCHAR),(2#integerdate{::SQL_TYPE_DATE,SQL_INTEGER),SQL_INTEGER);data do.
    smoutput '>> finish insert ', (":len), ' rows'
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. _1~: sh=. ch ddsel__db~ 'select count(*) from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203' do.
      smoutput ddfet__db sh,_1
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> bulk insert with ddsparm'
  ch ddsql__db~ 'delete from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203'
  smoutput '>> begin insert ', (":len), ' rows'
  sql=. 'insert into tdata(NAME, SEX, DEPT, DOB, DOH, SALARY) values (?,?,?,?,?,?)'
  if. _1~: rc=. ch ddsparm__db~ sql;data do.
    smoutput '>> finish insert ', (":len), ' rows'
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. _1~: sh=. ch ddsel__db~ 'select count(*) from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203' do.
      smoutput ddfet__db sh,_1
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> ddsparm'
  if. 0= rc=. ch ddsparm__db~ 'update tdata set PHOTO=? where NAME=?';(>'photo1';'photo2';'photo3');< (>'Abbott K';'Nobody';'Denny D') do.
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. _1~: sh=. ch ddsel__db~ 'select * from tdata where photo is not null' do.
      smoutput ddfet__db sh,_1
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> ddsparm box'
  if. 0= rc=. ch ddsparm__db~ 'update tdata set PHOTO=? where NAME=?';('photo4';'photo5';'photo6');< ('Blamire J';'somebody';'Gordon E') do.
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. _1~: sh=. ch ddsel__db~ 'select * from tdata where photo is not null' do.
      smoutput ddfet__db sh,_1
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> ddsparm long binary'
  photo1=. a.{~ ?1e5#256
  photo2=. a.{~ ?5e6#256
  if. 0= rc=. ch ddsparm__db~ 'update tdata set PHOTO=? where NAME=?';(photo1;photo2);< (>'Abbott K';'Denny D') do.
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. _1~: sh=. ch ddsel__db~ 'select NAME,PHOTO from tdata where NAME in (''Abbott K'',''Denny D'') order by NAME' do.
      photo=. 1{"1 ddfet__db sh,_1
      ddend__db sh
      smoutput 'photo # ',": #&> photo
      if. photo -: photo1;photo2 do.
        smoutput 'long binary test ok'
      else.
        smoutput 'long binary test failed'
      end.
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> dddis'
  dddis__db ch

  smoutput '>> finish'
else.
  smoutput '>> cannot open ',f
end.
destroy__db''
EMPTY
)

testdb''
