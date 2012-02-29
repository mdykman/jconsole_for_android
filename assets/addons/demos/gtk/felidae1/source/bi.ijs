NB. ui independent business intelligence

NB. find record index with name as key
NB. return _1 is not found
cat_index=: 3 : 0
if. (#db_name) > r=. db_name i. y do. r else. _1 end.
)

NB. y either cat index or cat name
NB. return cat index; name ; genus
this_cat=: 3 : 0
z=. 0$<''
if. 32=3!:0 y do. y=. cat_index y end.
if. (0<:y) *. y< #db_name do.
  z=. y;(y{db_name),y{db_genus
end.
z
)

NB. record data for the next cat
NB. return cat index; name ; genus
next_cat=: 3 : 0
if. 0>current_cat do. 0$<'' return. end.
this_cat >:current_cat
)

NB. record data for the previous cat
NB. return cat index; name ; genus
previous_cat=: 3 : 0
if. 0>current_cat do. 0$<'' return. end.
this_cat <:current_cat
)
