NB. ui independent business intelligence

NB. return key(name) ; name ; genus ; lineage

NB. record data for the next cat
NB. y either cat index or cat name
this_cat=: 3 : 0
z=. 0$<''
if. 0<#(<0 1){::r=. Read__locdb 'name,genus,lineage,picture,sypnosis from animal where name=', quote >y do.
  z=. (,~{.) dtb`>@.(32=3!:0)@:{.&.> {:"1 r
end.
z
)

NB. record data for the next cat
next_cat=: 3 : 0
if. ''-:current_cat do. 0$<'' return. end.
z=. 0$<''
if. 0< #r=. (<0 1){:: Read__locdb 'name from animal order by name' do.
  if. (<:#r1) > i=. current_cat i.~ r1=. <@dtb"1 r do.
    z=. this_cat (>:i){r1
  end.
end.
z
)

NB. record data for the previous cat
previous_cat=: 3 : 0
if. ''-:current_cat do. 0$<'' return. end.
z=. 0$<''
if. 0< #r=. (<0 1){:: Read__locdb 'name from animal order by name desc' do.
  if. (<:#r) > i=. current_cat i.~ r1=. <@dtb"1 r do.
    z=. this_cat (>:i){r1
  end.
end.
z
)

NB. record data for the first cat
first_cat=: 3 : 0
z=. 0$<''
if. 0<#(<0 1){::r=. Read__locdb 'name,genus,lineage,picture,sypnosis from animal order by name' do.
  z=. (,~{.) dtb`>@.(32=3!:0)@:{.&.> {:"1 r
end.
z
)

NB. record data for the last cat
last_cat=: 3 : 0
z=. 0$<''
if. 0<#(<0 1){::r=. Read__locdb 'name,genus,lineage,picture,sypnosis from animal order by name desc' do.
  z=. (,~{.) dtb`>@.(32=3!:0)@:{.&.> {:"1 r
end.
z
)

NB. delete record
delete_cat=: 3 : 0
Delete__locdb 'animal';'name=', quote >y
0
)

NB. update record or add new record
NB. y cat name
NB. x record data
update_cat=: 4 : 0
if. 0<#(<0 1){::r=. Read__locdb 'name from animal where name=', quote >y do.
  Update__locdb 'animal';< ((,:&.>0{x),(,:&.>1{x),(2{x),(<3{x),(<4{x)) ; ('name=', (quote >y)) ;< 'name';'genus';'lineage';'picture';'sypnosis'
else.
  Insert__locdb 'animal';< ((,:&.>0{x),(,:&.>1{x),(2{x),(<3{x),(<4{x))
end.
0
)
