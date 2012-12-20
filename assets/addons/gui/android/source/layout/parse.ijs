NB. parse res/layout

expat_initx=: 3 : 0
id_offset=: y
elements=: 0 0$''
idnames=: 0$<''
parents=: 0$0
)

expat_start_elementx=: 4 : 0
'elm att val'=. x
if. 0=#parents do. cparent=. _1 else. cparent=. {:parents end.
id=. _1 [ idname=. ''
if. (#att) > i=. (att i. <'id')<.(att i. <'android:id') do.
  if. '@' = {.va=. i{::val do.
    id=. _1 [ idname=. va
  else.
    id=. {.0".va
  end.
end.
idnames=: idnames, <idname
parents=: parents, #elements
elements=: elements , cparent;elm;id; (att,.val);''
)

expat_end_elementx=: 3 : 0
if. #expat_characterData do.
  elements=: (<expat_characterData) (<_1,~ {:parents)}elements
end.
parents=: }:parents
)

expat_parse_xmlx=: 3 : 0
if. #i=. I. (<'') ~: idnames do.
  idnames=: idnames -. <''
  id=. (id_offset+i.#i) i} >2{|:elements
  elements=: |: (<"0 id) 2}|:elements
end.
0;elements;< }.@(}.~ i.&'/')&.> idnames
)
