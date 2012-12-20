NB. parse res/menu

expat_initx=: 3 : 0
'id_offset group_offset'=: y
elements=: 0 0$''
idnames=: 0$<''
parents=: 0$0
menus=: 0$0
groups=: 0$0
gid=: 0
)

expat_start_elementx=: 4 : 0
'elm att val'=. x
if. 0=#parents do. cparent=. _1 else. cparent=. {:parents end.
if. 0=#menus do. cmenu=. 0 else. cmenu=. {:menus end.
if. 0=#groups do. cgroup=. 0 else. cgroup=. {:groups end.
id=. 0 [ idname=. ''
if. (0~:#parents) *. 'menu'-:elm do.
  for_i. i.-# elements do.
    'cp el dummy cm'=. 4{.i{elements
    if. 'item'-:el do.
      elements=: (<'submenu') (<1,~i)} elements
      menus=: menus, i break.
    end.
  end.
  return. NB. no need to add to elements
end.
if. (#att) > i=. (att i. <'id')<.(att i. <'android:id') do.
  if. '@' = {.va=. i{::val do.
    id=. 0 [ idname=. va
  else.
    id=. {.0".va
  end.
end.
idnames=: idnames, <idname
parents=: parents, #elements
if. 'group' -: elm do.
  groups=: groups, group_offset+gid
  gid=: gid+1
end.
elements=: elements , cparent;elm;id;cmenu;cgroup; (att,.val);''
)

expat_end_elementx=: 3 : 0
if. #expat_characterData do.
  elements=: (<expat_characterData) (<_1,~ {:parents)}elements
end.
if. 'menu' -: elm=. 1{::({:parents){elements do.
  menus=: }:menus
elseif. (<elm) e. <'menu' do.
  groups=: }:groups
  parents=: }:parents
elseif. do.
  parents=: }:parents
end.
)

expat_parse_xmlx=: 3 : 0
if. #i=. I. (<'') ~: idnames do.
  idnames=: idnames -. <''
  id=. (id_offset+i.#i) i}((#elements)#0)
  elements=: |: (<"0 id) 2}|:elements
end.
0;elements;(}.@(}.~ i.&'/')&.>idnames);group_offset+i.gid
)
