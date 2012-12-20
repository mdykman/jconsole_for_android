NB. parse res/string

expat_initx=: 3 : 0
elements=: 0 0$''
tag=: 0
)

expat_start_elementx=: 4 : 0
'elm att val'=. x
if. 'resources'-: elm do. tag=: >:tag return. end.
if. 1=tag do.
  if. (#att) > i=. att i. <'name' do.
    name=. i{::val
    elements=: elements , elm;name;''
  end.
end.
)

expat_end_elementx=: 3 : 0
if. (1~:tag) +. 0=#elements do. return. end.
elm=. (<_1 0){::elements
if. 'resources'-: elm do. tag=: <:tag return. end.
if. #expat_characterData do.
  elements=: (<expat_characterData) (<_1 _1)}elements
end.
)

expat_parse_xmlx=: 3 : 0
0;elements;''
)
