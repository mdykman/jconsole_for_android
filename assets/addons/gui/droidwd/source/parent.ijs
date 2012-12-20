
NB. =========================================================

wdcreategroup=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do.
  cSubform=: '' [ cContaineri=: _1 [ cContainer=: 0
else.
  if. 1< #args do. seterr 'extra parameter : ' return. end.
  id=. 0{::args
  if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
  win=. getchildwin window
  if. 'android.widget.TabHost'-.@-:jniClassName win do.
    win seterr 'bad id : ' return.    NB. only allow tab
  end.
  jniCheck DeleteLocalRef <win
  cContaineri=: _1 [ cContainer=: window
  containerList=: containerList, (cWindow ; window ; 0 0)
end.
)

wdpactive=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
NB. not implemented
)

wdpas=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 2> #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
if. 0~: cContainer do. return. end. NB. only applicable to top-level window
pasij=. <. {.@(0&".)&> args
return. NB. not implemented
vbox=. gtk_bin_get_child cWindow
g=. gtk_container_get_children vbox
align1=. 0
for_i. i. g_list_length g do.
  align1=. g_list_nth_data g, i
  if. g_type_check_instance_is_a align1, gtk_alignment_get_type '' do. break. end.
end.
assert. 0~:align1
g_list_free g
gtk_alignment_set_padding align1, 0, ({:D2P pasij), 0, ({.D2P pasij)
)

wdpc=: 3 : 0
pcstyle=. ;:'nomenu nomin nomax nosize dialog owner closeok scroll hscroll'
args=. shiftargs''
if. 0= #args do. seterr 'bad id : ' return. end.
styles=. ~. }.args [ id=. >@{.args
if. 0 e. styles e. pcstyle do. seterr 'bad style : ' return. end.
style=. 0
closeok=. (<'closeok') e. styles
owner=. (<'owner') e. styles
scroll=. (<'scroll') e. styles  NB. use to enable scrollview
hscroll=. (<'hscroll') e. styles
for_s. styles do.
  style=. style (23 b.) <. 2 ^ s i.~ pcstyle
end.
if. 0= cContainer do.
  assert. 0~:Activity
  idn=. 0
  Activity=: 0 [ activity=. Activity
  jniCheck view=. activity jniNewObject 'LinearLayout LContext;'
  jniCheck view ('setId (I)V' jniMethod)~ viewidn=: idn=. >:idn
  jniCheck view ('setOrientation (I)V' jniMethod)~ VERTICAL
NB. addOnLayoutChangeListener (View.OnLayoutChangeListener listener)
NB. removeOnLayoutChangeListener (View.OnLayoutChangeListener listener)
  if. scroll+.hscroll do.
    jniCheck scrollvw=. activity jniNewObject (hscroll#'Horizontal'),'ScrollView LContext;'
    jniCheck scrollvw ('setId (I)V' jniMethod)~ scrollvwidn=: idn=. >:idn
    jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ MATCH_PARENT;WRAP_CONTENT
    jniCheck scrollvw ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
    jniCheck DeleteLocalRef <lp
    jniCheck view ('addView (LView;)V' jniMethod)~ scrollvw
    jniCheck tbar=. activity jniNewObject 'LinearLayout LContext;'
    jniCheck tbar ('setId (I)V' jniMethod)~ tbaridn=: idn=. >:idn
    jniCheck tbar ('setOrientation (I)V' jniMethod)~ HORIZONTAL
    jniCheck lp=. ('AbsoluteLayout$LayoutParams IIII') jniNewObject~ <"0 dpw2px (MATCH_PARENT, WRAP_CONTENT), 0 0
    jniCheck tbar ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
    jniCheck tbar ('setVisibility (I)V' jniMethod)~ 8
    jniCheck DeleteLocalRef <lp
    jniCheck view ('addView (LView;)V' jniMethod)~ tbar
    jniCheck fixed1=. activity jniOverride 'org.dykman.jn.android.widget.AbsoluteLayout LContext;' ; 'droidwd' ; 'fixed1' ; 'onLayout'
    jniCheck fixed1 ('setId (I)V' jniMethod)~ fixedidn=: idn=. >:idn
    jniCheck lp=. ('LinearLayout$LayoutParams IIF') jniNewObject~ MATCH_PARENT;(wantstatusbar{MATCH_PARENT,WRAP_CONTENT);1
    jniCheck fixed1 ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
    jniCheck DeleteLocalRef <lp
    jniCheck scrollvw ('addView (LView;)V' jniMethod)~ fixed1
  else.
    jniCheck tbar=. activity jniNewObject 'LinearLayout LContext;'
    jniCheck tbar ('setId (I)V' jniMethod)~ tbaridn=: idn=. >:idn
    jniCheck tbar ('setOrientation (I)V' jniMethod)~ HORIZONTAL
    jniCheck lp=. ('AbsoluteLayout$LayoutParams IIII') jniNewObject~ <"0 dpw2px (MATCH_PARENT, WRAP_CONTENT), 0 0
    jniCheck tbar ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
    jniCheck tbar ('setVisibility (I)V' jniMethod)~ 8
    jniCheck DeleteLocalRef <lp
    jniCheck view ('addView (LView;)V' jniMethod)~ tbar
    jniCheck fixed1=. activity jniOverride 'org.dykman.jn.android.widget.AbsoluteLayout LContext;' ; 'droidwd' ; 'fixed1' ; 'onLayout'
    jniCheck fixed1 ('setId (I)V' jniMethod)~ fixedidn=: idn=. >:idn
    jniCheck lp=. ('LinearLayout$LayoutParams IIF') jniNewObject~ MATCH_PARENT;(wantstatusbar{MATCH_PARENT,WRAP_CONTENT);1
    jniCheck fixed1 ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
    jniCheck DeleteLocalRef <lp
    jniCheck view ('addView (LView;)V' jniMethod)~ fixed1
    scrollvw=. 0
  end.
  jniCheck sbar=. activity jniNewObject 'LinearLayout LContext;'
  jniCheck sbar ('setId (I)V' jniMethod)~ sbaridn=: idn=. >:idn
  jniCheck sbar ('setOrientation (I)V' jniMethod)~ HORIZONTAL
  jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ MATCH_PARENT;WRAP_CONTENT
  jniCheck sbar ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck sbar ('setVisibility (I)V' jniMethod)~ 8
  jniCheck DeleteLocalRef <lp
  jniCheck view ('addView (LView;)V' jniMethod)~ sbar

  jniCheck activity ('setContentView (LView;)V' jniMethod)~ view
NB.   jniCheck view ('requestFocus ()Z' jniMethod)~ ''
  jniCheck DeleteLocalRef"0 view;tbar;sbar;fixed1;scrollvw
else.
  if. 0= cWindow do. seterr 'no parent selected : ' return. end.
  win=. getchildwin cContainer
  jniCheck tw=. win ('getTabWidget ()LTabWidget;' jniMethod)~ ''
  jniCheck npage=. tw ('getTabCount ()I' jniMethod)~ ''
  jniCheck DeleteLocalRef <tw
  if. npage do.
    for_i. i.npage do.
      jniCheck win ('setCurrentTab (I)V' jniMethod)~ i
      jniCheck vw=. win ('getCurrentView ()LView;' jniMethod)~ ''
      if. jniCheck vw ('getChildCount ()I' jniMethod)~ '' do.
        jniCheck DeleteLocalRef <vw
      else.
        jniCheck fixedid=. vw ('getId ()I' jniMethod)~ ''
        jniCheck DeleteLocalRef <vw
        cContaineri=: i break.
      end.
    end.
    jniCheck win ('setCurrentTab (I)V' jniMethod)~ 0
  end.
  jniCheck DeleteLocalRef <win
  if. _1&= cContaineri do. seterr 'todomsg4 : ' return. end.
  if. 1> fixedid do.
    seterr 'todomsg5 : ' return.
  end.
end.

if. 0= cContainer do.
  windowList=: windowList, activity ; id ; (jloc '') ; '' ; idn ; fixed1 ; cFontdef ; (tbaridn,0 0 0) ; (sbaridn,0 0 0) ; (0$0) ; 0 0 ; 0 ; 0 0 ; 0 ; 0 ; closeok ; '' ; 0
  cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: activity
  activeidx=: ~. activeidx, activity
else.
  cSubform=: id
  subformList=: subformList, (cWindow ; cContainer ; id ; fixedid)
end.
)

wdpcenter=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
NB. not implemented
)

wdpclose=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
jniCheck cWindow ('finish ()V' jniMethod)~ ''
)

wdpgroup=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 1> #args=. shiftargs'' do. seterr'bad id : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
s=. 0{::args
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  windowList=: (<s) (<(handle i. cWindow) ; WindowListPgroup) } windowList
else.
  assert. 0
end.
)

NB. set form icon with icon n from image file
NB. parameter n will be ignored
wdpicon=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr'bad number : ' return.
elseif. 1= #args do. seterr'bad number : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
return. NB. not implemented
NB. getWindow().setFeatureDrawable(FEATURE_LEFT_ICON, drawable);
s=. 0{::args
ax=. 1{::args
if. 0= isnum ax do. seterr 'bad number : ' return. end.
if. (<tolower _4{.s) e. '.exe';'.dll' do. return. end.  NB. cannot handle icons in exe dll
gtk_window_set_icon_from_file cWindow ; s ; 0
)


wdpmove=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 4> #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 4< #args do. seterr 'extra parameter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> args
NB. not implemented
)

wdpmovex=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 4> #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 4< #args do. seterr 'extra parameter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> args
NB. not implemented
)

wdpn=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0=#args=. shiftargs'' do. s=. ''
elseif. 1<#args do. seterr 'extra parameter : ' return.
elseif. 1=#args do. s=. 0{::args
end.
jniCheck cWindow ('setTitle (LCharSequence;)V' jniMethod)~ <s
)

wdpsel=: 3 : 0
if. 0= #args=. shiftargs'' do. cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: cWindow=: 0 return.
elseif. 1<#args do. seterr 'extra parameter : ' return.
elseif. 1=#args do. id=. 0{::args
end.
return. NB. not implemented
if. 0= #windowList do. return. end.
if. '_0123456789' e.~ {.id do.
  if. (w=. 0&". id) -.@e. (>WindowListHandle{"1 windowList) do. seterr 'bad id : ' return. end.
  if. w~: cWindow do.
    cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: w
  end.
else.
  if. 0~: checkbadname id do. seterr 'bad id : ' return. end.
  if. (<id) -.@e. (WindowListId{"1 windowList) do. seterr 'bad id : ' return. end.
  w=. (>WindowListHandle{"1 windowList){~ (<id) i.~ (WindowListId{"1 windowList)
  if. w~: cWindow do.
    cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: w
  end.
end.
activeidx=: ~. activeidx, w
)

showStyle=: ;:'sw_hide sw_minimize sw_restore sw_show sw_showmaximized sw_showminimized sw_showminnoactive sw_showna sw_shownoactivate sw_shownormal'
NB. SW_HIDE Hides the window and activates the executable file.
NB. SW_MAXIMIZE Maximizes the window.
NB. SW_MINIMIZE Minimizes the window. The next top-level window in the z-order is activated.
NB. SW_RESTORE Activates the window even if it is hidden or minimized.
NB. SW_SHOW Activates the window and displays it in its original size and at its original position.
NB. SW_SHOWMAXIMIZED Activates the window. The window is displayed as maximized.
NB. SW_SHOWMINIMIZED Activates the window. The window is displayed as minimized.
NB. SW_SHOWMINNOACTIVE Activates the window as minimized. The active window retains the focus.
NB. SW_SHOWNA Activates the window in its current state but the active window retains the focus.
NB. SW_SHOWNOACTIVATE Displays the window in its most recent size and in its most recent position. The active window retains the focus.
NB. SW_SHOWNORMAL Displays the window in its original size and at its original position.

wdpshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0=#args=. shiftargs'' do. style=. 'sw_shownormal'
elseif. 1<#args do. seterr 'extra parameter : ' return.
elseif. do. style=. 0{::args
end.
return. NB. not implemented
select. style
case. 'sw_hide' do. return.
case. 'sw_maximize' do.
case. 'sw_minimize' do.
case. 'sw_restore' do.
case. 'sw_show' do. ''
case. 'sw_showmaximized' do.
case. 'sw_showminimized' do.
case. 'sw_showminnoactive' do.
case. 'sw_showna' do. ''
case. 'sw_shownoactive' do. ''
case. 'sw_shownormal' do. ''
case. do. seterr 'bad style : ' return.
end.
NB. if. (<style) e. ;:'sw_restore sw_show sw_shownormal sw_showmaximized sw_showminimized' do.
NB.   if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
NB.     activeidx=: ~. activeidx, cWindow
NB.   else.
NB.     assert. 0
NB.   end.
NB. end.
)

wdptop=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1< #args do. seterr 'extra parameter : ' return.
elseif. do. s=. 0{::args
end.
if. 0 e. isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
flag=. flag > TileWM  NB. disable floating window on tiling wnidow manager
NB. not implemented
)

wdqformx=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
jniCheck view=. cWindow ('findViewById (I)LView;' jniMethod)~ viewidn
jniCheck w=. view ('getWidth ()I' jniMethod)~ ''
jniCheck h=. view ('getHeight ()I' jniMethod)~ ''
jniCheck DeleteLocalRef <view
": 0,0,w,h
)

wdqhwndp=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
":cWindow
)
