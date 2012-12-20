NB. parse

wd_menu=: 3 : 0
NB. cannot call twice for a form 
assert. 0~:cWindow 
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  mn=. (icx=. handle i. cWindow){ >WindowListMenubar{"1 windowList
else.
  assert. 0
end.
assert. 0=#mn
windowList=: (<mn=. ,y) (<icx, WindowListMenubar) } windowList
windowList=: (<1) (<icx, WindowListMenuCreated) } windowList
y=. (<icx, WindowListMenuPending) {:: windowList

z=. ''
wdptr1=: 0
while. #y do.
  if. 0<s1=. clws y do.
    wdptr1=: wdptr1 + s1
    y=. s1}. y continue.
  end.
  s=. y e. ';'
  a=. y e. '*'
  q=. 2| +/\ y e. '"'
  d=. 2| +/\ y e. DEL
  s=. s *. -.q+.d
  a=. a *. -.q+.d
  if. (1 e. a) *. 1 e. s do.
    s1=. {.I.s [ a1=. {.I.a
    if. s1<a1 do.
      z=. wd2 s1{.y
      wdptr1=: wdptr1 + 1 + s1
      y=. (1+s1)}. y continue.
    else.
      z=. wd2 y break.
    end.
  elseif. 1 e. s do.
    s1=. {.I.s
    z=. wd2 s1{.y
    wdptr1=: wdptr1 + 1 + s1
    y=. (1+s1)}. y continue.
  elseif. do.
    z=. wd2 y break.
  end.
end.
mn=. icx{ >WindowListMenubar{"1 windowList
if. 1<#mn do. jniCheck DeleteLocalRef"0 <"0 }.mn end.
windowList=: (<,0$0) (<icx, WindowListMenubar) } windowList
windowList=: (<'') (<icx, WindowListMenuPending) } windowList
z
)

wd2=: 3 : 0
if. 0=#y do. '' return. end.
smoutput^:(1<Debugwd) y      NB. echo all cmd
wdptr=: 0 [ wdstr=: y
LASTCMD=: y [ WDERRN=: 0
select. cmd=. shiftarg''
case. 'menu' do. wdmenu ''
case. 'menupop' do. wdmenupop ''
case. 'menupopz' do. wdmenupopz ''
case. 'menusep' do. wdmenusep ''
end.
if. 0~:WDERRN do. 13!:8[3 end.
EMPTY
)
