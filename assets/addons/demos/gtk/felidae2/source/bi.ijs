NB. ui independent business intelligence

NB. find record index with name as key
NB. return _1 is not found
cat_index=: 3 : 0
if. (#db_name) > r=. db_name i. y do. r else. _1 end.
)

NB. return cat index; name ; genus ; lineage

NB. record data for the next cat
NB. y either cat index or cat name
this_cat=: 3 : 0
z=. 0$<''
if. 32=3!:0 y do. y=. cat_index y end.
if. (0<:y) *. y< #db_name do.
  z=. y;(y{db_name),(y{db_genus),(<y{db_lineage)
end.
z
)

NB. record data for the next cat
next_cat=: 3 : 0
if. 0>current_cat do. 0$<'' return. end.
this_cat >:current_cat
)

NB. record data for the previous cat
previous_cat=: 3 : 0
if. 0>current_cat do. 0$<'' return. end.
this_cat <:current_cat
)

NB. delete record
delete_cat=: 3 : 0
if. _1= r=. cat_index y do. 1 return. end.
db_name=: (<<<r){db_name
db_genus=: (<<<r){db_genus
db_lineage=: (<<<r){db_lineage
0
)

NB. update record or add new record
NB. y cat name
NB. x record data
update_cat=: 4 : 0
if. _1= r=. cat_index y do.
  db_name=: (0{x),~ db_name
  db_genus=: (1{x),~ db_genus
  db_lineage=: (>2{x),~ db_lineage
else.
  db_name=: (0{x) r}db_name
  db_genus=: (1{x) r}db_genus
  db_lineage=: (>2{x) r}db_lineage
end.
0
)
