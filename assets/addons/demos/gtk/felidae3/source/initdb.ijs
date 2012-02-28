NB. preload database
db_name=: <;._2 [ 0 : 0
domestic cat
lion
tiger
snow leopard
)

db_genus=: <;._2 [ 0 : 0
felis
panthera
panthera
uncia
)

db_lineage=: 8 1 1 1

3 : 0''
db_picture=: db_sypnosis=: 0$<''
for_i. i.#db_name do.
  if. _1-:data=. 1!:1 ::_1: <8&u: jpath '~felidae/data/', '_'&((' ' I.@:= ])}) (i{::db_name), '.jpg' do.
    data=. ''
  end.
  db_picture=: db_picture, <data
  db_sypnosis=: db_sypnosis, <(i{::db_name), LF, (i{::db_genus)
end.
)

ddl=: 0 : 0
name char;
genus char
lineage int
picture binary
sypnosis varchar
)

createdb=: 3 : 0
f=. Open_jdb_ jpath '~temp'
Drop__f 'felidae'
d=. Create__f 'felidae'
t=. Create__d 'animal';ddl
NB. smoutput Tables__d
NB. smoutput ShowCols__d 'animal'
Insert__d 'animal';< (>db_name);(>db_genus);db_lineage;db_picture;<db_sypnosis
NB. smoutput Reads__d 'name,genus,lineage,sypnosis from animal'
NB. smoutput Read__d 'name,genus,lineage,sypnosis from animal'
destroy__d ''
0
)

NB. create and import jdb
createdb ''

