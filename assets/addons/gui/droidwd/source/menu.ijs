NB. menu id "&Context Sensitive" "Ctrl+F1" statushelp tooltip
wdmenu=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 5< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. 0{::args do. seterr 'bad id : ' return. end.
if. _1= icx=. windowlistidx cWindow do. seterr 'internal error : ' return. end.
if. -.ismenucreated cWindow do.
  s1=. wdstr
  idn=. (<icx,4){::windowList
  menuList=: menuList, cWindow ; (idn=. >:idn) ; id ; 0 ; 0 0 0
  windowList=: (<idn) (<icx, 4) } windowList
  s=. (<icx, WindowListMenuPending){:: windowList
  windowList=: (<s,s1,';') (<icx, WindowListMenuPending) } windowList
  return.
end.
txt=. 1{::args,5#<''
shortcut=. 2{::args,5#<''
statushelp=. 3{::args,5#<''
tooltip=. 4{::args,5#<''
mn=. (<icx, WindowListMenubar){:: windowList
acl=. (<icx, WindowListAccel){:: windowList
assert. 0~:#mn
menu=. cWindow getmenu id
assert. 0~:menu
imx=. cWindow getmenuidx menu
assert. _1~:imx
menust=. (<imx,4){::menuList
assert. 0= {.menust
idn=. (<imx,1){::menuList
jniCheck e=. ({:mn) ('add (IIILCharSequence;)LMenuItem;' jniMethod)~ 0;(idn);0;txt-.'&'
if. '' -.@-: shortcut do.
  alphabeticShortcutcut=. numericShortcut=. ' '
  shortcut=. {:shortcut
  if. shortcut e. '0123456789' do. numericShortcut=. shortcut else. alphabeticShortcutcut=. shortcut end.
  jniCheck e ('setShortcut (CC)LMenuItem;' jniMethod)~ numericShortcut;alphabeticShortcutcut
end.
jniCheck DeleteLocalRef <e
if. 1{menust do.  NB. set checked
end.
if. 2{menust do.  NB. set enable/disable
end.
menuList=: (<1 (0)}menust) (<imx ,4)}menuList
)

wdmenupop=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. txt=. ''
elseif. 1< #args do. seterr 'extra parameter : ' return.
elseif. do. txt=. >@{.args
end.
if. _1= icx=. windowlistidx cWindow do. seterr 'internal error : ' return. end.
if. -.ismenucreated cWindow do.
  s1=. wdstr
  s=. (<icx, WindowListMenuPending){:: windowList
  windowList=: (<s,s1,';') (<icx, WindowListMenuPending) } windowList
  return.
end.
mn=. (<icx, WindowListMenubar){:: windowList
assert. 0~:#mn
jniCheck e=. ({:mn) ('addSubMenu (IIILCharSequence;)LSubMenu;' jniMethod)~ 0;0;0;txt-.'&'
windowList=: (<mn, e) (<icx, WindowListMenubar) } windowList
jniCheck DeleteLocalRef <e
)

wdmenupopz=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. _1= icx=. windowlistidx cWindow do. seterr 'internal error : ' return. end.
if. -.ismenucreated cWindow do.
  s1=. wdstr
  s=. (<icx, WindowListMenuPending){:: windowList
  windowList=: (<s,s1,';') (<icx, WindowListMenuPending) } windowList
  return.
end.
mn=. (<icx, WindowListMenubar){:: windowList
if. 1 < #mn do. jniCheck DeleteLocalRef <{:mn end.
windowList=: (<}:mn) (<icx, WindowListMenubar) } windowList
)

wdmenusep=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. _1= icx=. windowlistidx cWindow do. seterr 'internal error : ' return. end.
if. -.ismenucreated cWindow do.
  s1=. wdstr
  s=. (<icx, WindowListMenuPending){:: windowList
  windowList=: (<s,s1,';') (<icx, WindowListMenuPending) } windowList
  return.
end.
mn=. (<icx, WindowListMenubar){:: windowList
assert. 0~:#mn
NB. not implemented
)

