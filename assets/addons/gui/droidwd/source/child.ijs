NB. child related cmd

NB. =========================================================

wdcc=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 2> #args do. seterr 'bad class : ' return.
end.
id=. 0{::args [ class=. 1{::args
localec=. userdata=. ''
if. (<class) -.@e. {."1 CONTROLS do. seterr 'bad class : ' return. end.
iclass=. (<class) i.~ {."1 CONTROLS
if. 2< #args do.
  styles=. ~. 2}.args
NB. leftmove=1  topmove=2 rightmove=4 etc
  stylen=. 2#. |. styles e.~ FMSTYLE
else.
  stylen=. 0
  styles=. 0$<''
end.
styles=. (<'ws_group') (I. styles = <'group') } styles
styles=. (<'gs_image') (I. styles = <'image') } styles
styles=. (<'gs_opengl') (I. styles = <'opengl') } styles
styles=. (<'gs_video') (I. styles = <'video') } styles
styles=. (<'gs_web') (I. styles = <'web') } styles
if. 0 e. styles e. (;:'ws_group nopas'), FMSTYLE, ;2 3{ iclass{CONTROLS do. seterr 'bad style : ' return. end.
if. 0= cContainer do.
  fixed1=. getchildwin fixedidn
else.
  if. 1 e. f=. (cContainer = >1{"1 subformList) *. (<cSubform) = 2{"1 subformList do.
    fixedid=. 3{:: ({.I.f){subformList
    fixed1=. getchildwin fixedid
    assert. 0~:fixed1
  else.
    seterr 'todomsg1 : ' return.
  end.
  assert. 0~:fixed1
  assert. fixedid e. 3{::"1 subformList
end.
defpushbutton=. 0
newgroup=. 0
barsoffset=. 0
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  cParentId=. (handle i. cWindow){ >WindowListId{"1 windowList
  cParentLoc=. (handle i. cWindow){ >WindowListLocale{"1 windowList
  'tbvisi tbcnt tbpx'=. 1 2 3{ (handle i. cWindow){ >WindowListToolbar{"1 windowList
  barsoffset=. (0=cContainer) * <. px2dpw tbvisi *. tbpx
else.
  cParentId=. ''
  cParentLoc=. ''
end.
select. iclass
case. wdcl_button do.
  if. (<'bs_ownerdraw') e. styles do.
    jniCheck win=. cWindow jniNewObject 'ImageButton LContext;'
  else.
    jniCheck win=. cWindow jniNewObject 'Button LContext;'
    jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <id
  end.
  if. (<'bs_defpushbutton') e. styles do. defpushbutton=. window end.
  jniCheck win ('setOnClickListener (LView$OnClickListener;)V' jniMethod)~ button_click_listener
case. wdcl_checkbox do.
  jniCheck win=. cWindow jniNewObject 'CheckBox LContext;'
  jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <id
  jniCheck win ('setOnClickListener (LView$OnClickListener;)V' jniMethod)~ button_click_listener
fcase. wdcl_combobox do.
fcase. wdcl_combodrop do.
case. wdcl_combolist do.
  jniCheck win=. cWindow jniNewObject 'Spinner LContext;'
  jniCheck win ('setOnItemSelectedListener (LAdapterView$OnItemSelectedListener;)V' jniMethod)~ combobox_select_listener
fcase. wdcl_richedit do.
  iclass=. wdcl_edit
case. wdcl_edit do.
  jniCheck win=. cWindow jniNewObject 'EditText LContext;'
  if. ((<'es_readonly') e. styles) *. (<'es_password') e. styles do.
    ip=. inputtype_text, inputtype_textPassword
    jniCheck win ('setInputType (I)V' jniMethod)~ (23 b.)/ ip
    jniCheck win ('setEnabled (Z)V' jniMethod)~ 0
  elseif. (<'es_readonly') e. styles do.
    jniCheck win ('setInputType (I)V' jniMethod)~ 0
  elseif. do.
    ip=. inputtype_text
    if. (<'es_uppercase') e. styles do. ip=. ip, inputtype_textCapCharacters end.
    if. (<'es_password') e. styles do. ip=. ip, inputtype_textPassword end.
    jniCheck win ('setInputType (I)V' jniMethod)~ (23 b.)/ ip
  end.
  jniCheck win ('setOnEditorActionListener (LTextView$OnEditorActionListener;)V' jniMethod)~ editor_action_listener
fcase. wdcl_editijs;wdcl_editijx;wdcl_richeditm do.
  iclass=. wdcl_editm
case. wdcl_editm do.
  jniCheck win=. cWindow jniNewObject 'EditText LContext;'
  if. 0[ (<'es_readonly') e. styles do.
    jniCheck win ('setInputType (I)V' jniMethod)~ 0      NB. TODO this will make it single line edit
  else.
    ip=. inputtype_textMultiLine
    if. (<'es_uppercase') e. styles do. ip=. ip, inputtype_textCapCharacters end.
    if. (<'es_password') e. styles do. ip=. ip, inputtype_textPassword end.
    jniCheck win ('setInputType (I)V' jniMethod)~ (23 b.)/ ip
  end.
  jniCheck win ('setGravity (I)V' jniMethod)~ 16b30
  if. (hsc=. (<'ws_hscroll') e. styles) do.
    jniCheck win ('setHorizontallyScrolling (Z)V' jniMethod)~ 1
  end.
  jniCheck myscroller=. cWindow jniNewObject 'Scroller LContext;'
  jniCheck mymethod=. '' jniNewObject 'ScrollingMovementMethod'
  win ('setScroller (LScroller;)V' jniMethod)~ myscroller
  win ('setVerticalScrollBarEnabled (Z)V' jniMethod)~ 1
  win ('setMovementMethod (LMovementMethod;)V' jniMethod)~ mymethod
  jniCheck DeleteLocalRef"0 myscroller;mymethod

case. wdcl_groupbox do.
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 8
case. wdcl_isigraph do.
  if. (<'gs_image') e. styles do.
    userdata=. 2
    jniCheck win=. cWindow jniNewObject 'ImageView LContext;'
  elseif. (<'gs_video') e. styles do.
    userdata=. 3
    jniCheck win=. cWindow jniNewObject 'VideoView LContext;'
  elseif. (<'gs_web') e. styles do.
    userdata=. 4
    jniCheck win=. cWindow jniNewObject 'WebView LContext;'
    jniCheck ct=. '' jniNewObject 'WebViewClient'
    jniCheck win ('setWebViewClient (LWebViewClient;)V' jniMethod)~ ct
    jniCheck set=. win ('getSettings ()LWebSettings;' jniMethod)~ ''
    jniCheck set ('setBuiltInZoomControls (Z)V' jniMethod)~ 1
    jniCheck set ('setJavaScriptEnabled (Z)V' jniMethod)~ 1
    jniCheck DeleteLocalRef"0 ct;set
  elseif. do.
    userdata=. 0
    if. styleOpengl=. (<'gs_opengl') e. styles do. userdata=. 1 end.
    size=. dpw2px 2}. cxywh
    idnx=. (userdata,cWindow) glcanvas_jgl2_ size ; coname''
    l=. glgetloc_jgl2_ idnx
    assert. *#>l
    gloption__l=: styleOpengl
    win=. view__l
  end.
case. wdcl_listbox do.
  jniCheck win=. cWindow jniNewObject 'ListView LContext;'
  jniCheck win ('setOnItemClickListener (LAdapterView$OnItemClickListener;)V' jniMethod)~ listbox_click_listener
  userdata=. (<'lbs_multiplesel') e. styles
  if. 0=userdata do. userdata=. 2* (<'lbs_nosel') e. styles end.
  if. 2~:userdata do.
    jniCheck win ('setOnItemLongClickListener (LAdapterView$OnItemLongClickListener;)V' jniMethod)~ listbox_longclick_listener
  end.
case. wdcl_radiobutton do.
  if. newgroup=. (0=cRadio) +. (<'ws_group') -.@e. styles do.
    if. cRadio do. DeleteLocalRef <cRadio end.
    jniCheck cRadio=: cWindow jniNewObject 'RadioGroup LContext;'
    jniCheck cRadio ('setOrientation (I)V' jniMethod)~ (<'bs_lefttext') -.@e. styles  NB. use this style for orientation
  end.
  userdata=. newgroup
  assert. 0~:cRadio
  jniCheck win=. cWindow jniNewObject 'RadioButton LContext;'
  jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <id
  jniCheck cRadio ('addView (LView;)V' jniMethod)~ win
  jniCheck win ('setOnClickListener (LView$OnClickListener;)V' jniMethod)~ button_click_listener
case. wdcl_scrollbar do.
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 8
case. wdcl_scrollbarv do.
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 8
case. wdcl_static do.
  jniCheck win=. cWindow jniNewObject 'TextView LContext;'
  jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <id
case. wdcl_staticbox do.
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 8
case. wdcl_progress do.
  jniCheck win=. cWindow jniNewObject 'ProgressBar LContext;'
  jniCheck win ('setMax (I)V' jniMethod)~ 100
  jniCheck win ('setProgress (I)V' jniMethod)~ 0
case. wdcl_spin ; wdcl_spinv do.
NB. initial is adj's initial value.
NB. lower is the lower bound of adj's value.
NB. upper is the upper bound of adj's value.
NB. step_increment is a small step; when you drag a slider or click the spin button's arrow, adj's value changes by at least this much.
NB. page_increment is a big step; a click in the trough of a slider changes adj's value by this much.
NB. page_size is the currently visible size of the page. This parameter is useful only for scrollbars; set this to 0 for sliders and spin buttons.
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 8
case. wdcl_tab do.
  tableft=. (<'tcs_left') e. styles
NB.   jniCheck win=. cWindow jniNewObject 'TabHost LContext;'        NB. this form does not work
  jniCheck win=. (cWindow;0) jniNewObject 'TabHost LContext;LAttributeSet;'
  jniCheck win ('setId (I)V' jniMethod)~ R_id_tabhost

  jniCheck l1=. cWindow jniNewObject 'LinearLayout LContext;'
  jniCheck jniCheck lp=. ('FrameLayout$LayoutParams II') jniNewObject~ MATCH_PARENT;MATCH_PARENT
  jniCheck l1 ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck l1 ('setOrientation (I)V' jniMethod)~ tableft{VERTICAL, HORIZONTAL
  jniCheck l1 ('setPadding (IIII)V' jniMethod)~ 4#<dpw2px 5
  jniCheck DeleteLocalRef <lp

  jniCheck t1=. cWindow jniNewObject 'TabWidget LContext;'
  jniCheck t1 ('setId (I)V' jniMethod)~ R_id_tabs
  jniCheck jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ <"0 tableft{:: (MATCH_PARENT, WRAP_CONTENT);(MATCH_PARENT, WRAP_CONTENT)
  jniCheck t1 ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck t1 ('setOrientation (I)V' jniMethod)~ tableft{HORIZONTAL, VERTICAL
  jniCheck l1 ('addView (LView;)V' jniMethod)~ t1
  jniCheck DeleteLocalRef"0 t1;lp

  jniCheck f1=. cWindow jniNewObject 'FrameLayout LContext;'
  jniCheck f1 ('setId (I)V' jniMethod)~ R_id_tabcontent
  jniCheck jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ MATCH_PARENT;MATCH_PARENT
  jniCheck f1 ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck f1 ('setPadding (IIII)V' jniMethod)~ 4#<dpw2px 5
  jniCheck l1 ('addView (LView;)V' jniMethod)~ f1
  jniCheck DeleteLocalRef"0 f1;lp

  jniCheck win ('addView (LView;)V' jniMethod)~ l1
  jniCheck DeleteLocalRef <l1

  jniCheck win ('setup ()V' jniMethod)~ ''

  jniCheck win ('setOnTabChangedListener (LTabHost$OnTabChangeListener;)V' jniMethod)~ tab_changed_listener
  userdata=. 0
case. wdcl_trackbar do.
  jniCheck win=. cWindow jniNewObject 'SeekBar LContext;'
  jniCheck win ('setMax (I)V' jniMethod)~ 100
  jniCheck win ('setProgress (I)V' jniMethod)~ 0
  jniCheck win ('setKeyProgressIncrement (I)V' jniMethod)~ 1
NB. TODO this listenser will crash
  jniCheck win ('setOnSeekBarChangeListener (LSeekBar$OnSeekBarChangeListener;)V' jniMethod)~ seekbar_changed_listener
case. wdcl_trackbarv do.
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 8
case. do.
  win seterr 'bad class : ' return.
end.
NB. default font
if. '' -.@-: cSetFont do.
  fontdef=. cFontdef
else.
  if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
    fontdef=. (handle i. cWindow){:: WindowListFontdef{"1 windowList
  else.
    assert. 0
  end.
end.
NB. default to follow gtk theme
if. '' -.@-: fontdef do.
NB.   'font asize style angle'=. fontdef
NB. style 	'oblique', 'italic'
NB. weight 	'light', 'bold', 'heavy'
NB.   st=. (|. 2 2 2#:style)#'italic' ; 'bold' ; ''  NB.  underline not supported
NB.   fd=. pango_font_description_from_string <'', font, '', (;' ' ,&.> st), ' ', (":asize)
  if. '"' e. f=. fontdef do. f=. }. (}.~ i:&'"') end.
  if. #fs=. I. 1= (*./@:(e.&'_.0123456789')) &> fb=. ;: f do.
    asize=. {. 10&". ({.fs){::fb
  else.
    asize=. 10
  end.
  f=. getfontspec fontdef
  if. 0=WDERRN do.
    'face asize style angle'=. f
    'Bold Italic Underline Strikeout'=. 4{. |. #: style
    jniCheck ft=. 'android.graphics.Typeface' ('create (LString;I)LTypeface;' jniStaticMethod)~ face;(Bold + 2*Italic)
    try.
      jniCheck win ('setTypeface (LTypeface;)V' jniMethod)~ ft
      jniCheck win ('setTextSize (F)V' jniMethod)~ pt2sp * asize
    catch.
      ExceptionClear''
    end.
    jniCheck DeleteLocalRef <ft
  end.
else.
  asize=. 10
end.
if. iclass e. wdcl_combobox, wdcl_combodrop, wdcl_combolist do.
  cxywh1=. (3{.cxywh) , >. CBSIZE * asize%10
else.
  cxywh1=. cxywh
end.
cxywh1=. cxywh1 + 0, barsoffset, 0 0
if. newgroup *. iclass = wdcl_radiobutton do.
  assert. 0~:cRadio
  lpclass=. 'AbsoluteLayout$LayoutParams'
  jniCheck lp=. (lpclass, ' IIII') jniNewObject~ <"0 dpw2px (WRAP_CONTENT, WRAP_CONTENT), 2{.cxywh1
NB. setlayoutparams must before addview or else requestLayout will be needed
  jniCheck cRadio ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck DeleteLocalRef <lp
elseif. iclass ~: wdcl_radiobutton do.
  lpclass=. 'AbsoluteLayout$LayoutParams'
  if. iclass e. wdcl_edit, wdcl_combobox, wdcl_combodrop, wdcl_combolist do.
    jniCheck lp=. (lpclass, ' IIII') jniNewObject~ <"0 dpw2px 2|. WRAP_CONTENT (3)}cxywh1
  else.
    jniCheck lp=. (lpclass, ' IIII') jniNewObject~ <"0 dpw2px 2|.cxywh1
  end.
NB. setlayoutparams must before addview
  jniCheck win ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck DeleteLocalRef <lp
end.
if. newgroup *. iclass = wdcl_radiobutton do.
  jniCheck fixed1 ('addView (LView;)V' jniMethod)~ cRadio
elseif. iclass ~: wdcl_radiobutton do.
  jniCheck fixed1 ('addView (LView;)V' jniMethod)~ win
end.

jniCheck DeleteLocalRef <fixed1
idx=. windowlistidx cWindow
idn=. (<idx,4){::windowList
if. (iclass=wdcl_isigraph) *. (0-:userdata) do.
  cChild=: idnx
elseif. iclass= wdcl_tab do.
  cChild=: R_id_tabhost
elseif. do.
  jniCheck win ('setId (I)V' jniMethod)~ idn=. >:idn
  cChild=: idn
end.
jniCheck DeleteLocalRef <win
if. 0&= win do. seterr 'cannot create child : ' return. end.
childList=: childList, cWindow ; cChild ; id ; iclass ; stylen ; 0 ; cContainer ; ((0~:cContainer){::'';cSubform) ; (dpw2px cxywh1) ; 0 ; localec ;< userdata
if. (<'nopas') -.@e. styles do.
  if. 0= cContainer do.
    idx=. windowlistidx cWindow
    assert. _1~:idx
    wh0=. (<idx, WindowListWh0){::windowList
    wh0=. wh0 >. dpw2px +/ 2 2$cxywh
    windowList=: (<wh0) (<idx, WindowListWh0)} windowList
  else.
    idx=. (>1{"1 containerList) i. cContainer
    assert. idx < #containerList
    wh0=. (<idx, 2){::containerList
    wh0=. wh0 >. dpw2px +/ 2 2$cxywh
    containerList=: (<wh0) (<idx, 2)} containerList
  end.
end.
idx=. windowlistidx cWindow
windowList=: (<idn) (<idx, 4) } windowList
)

wdcn=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= window=. cChild do. seterr 'no child selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ''
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
win=. getchildwin window
select. iclass=. getcchildclass window
case. wdcl_button do.
  if. 'android.widget.ImageButton'-:jniClassName win do.
    if. ''-:s do.
      jniCheck win ('setImageBitmap (LBitmap;)V' jniMethod)~ 0
    else.
      pic=. 1!:1 ::(''"_) <s
      ba=. jniCheck NewByteArray <#pic
      jniCheck SetByteArrayRegion ba;0;(#pic);pic
      bm=. jniCheck 'android.graphics.BitmapFactory' ('decodeByteArray ([BII)LBitmap;' jniStaticMethod)~ ba;0;#pic
      jniCheck win ('setImageBitmap (LBitmap;)V' jniMethod)~ bm
      jniCheck DeleteLocalRef"0 ba;bm
    end.
  else.
    jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <s-.'&'
  end.
case. wdcl_static;wdcl_checkbox;wdcl_radiobutton do.
  jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <s
case. wdcl_staticbox;wdcl_groupbox do.
case. do. win seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef <win
)

wdqchildxywh=: 3 : 0
if. 2= 3!:0 z=. qchildxywhx '' do. z return. end.
": px2dpw z
)

wdqchildxywhx=: 3 : 0
if. 2= 3!:0 z=. qchildxywhx '' do. z return. end.
": z
)

qchildxywhx=: 3 : 0
z=. 4$_1
if. 0= cWindow do. z [ seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. z [ seterr 'bad id : ' return.
elseif. 1< #args do. z [ seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. z [ seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. z [ seterr 'bad id : ' return. end.
idx=. windowlistidx cWindow
'tbvisi tbcnt tbpx'=. 1 2 3{ (<idx, WindowListToolbar){:: windowList
offset=. <. tbvisi *. tbpx
win=. getchildwin window
wh=. getchildwh win
xy=. getchildxy win
jniCheck DeleteLocalRef <win
(xy,wh) - 0,offset,0 0
)

wdqhwndc=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
":window
)

NB. id
wdrm=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
if. _1= ix=. getcchildidx window do. 0 return. end.
win=. getchildwin window
NB. TODO radiogroup
jniCheck p=. win ('getParent ()LViewParent;' jniMethod)~ ''
jniCheck p ('removeView (LView;)V' jniMethod)~ win
jniCheck DeleteLocalRef"0 win;p
childList=: (<<<ix){childList
)

NB. id ....
wdset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
menu=. tbar=. 0
if. 0= window=. cWindow getcchild id do.
  menu=. cWindow getmenu id
  tbar=. cWindow gettoolbar id
  if. (0=menu) *. 0=tbar do. menu,tbar seterr 'bad id : ' return. end.
  if. 1= #args do. s=. ,'1'
  elseif. 2< #args do. menu,tbar seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. menu,tbar seterr 'bad number : ' return. end.
  if. 0 1 -.@e.~ flag=. {.@(0&".) s do. menu,tbar seterr 'bad number : ' return. end.
  if. 0~: menu do.
    imx=. cWindow getmenuidx menu
    menuList=: (<1) (<imx ,3)}menuList
    if. 1= {. menust=. (<imx,4){::menuList do.
NB. set check mark
NB.     gtk_check_menu_item_set_active menu, flag
    else.
      menuList=: (<flag 1}menust) (<imx ,4)}menuList
    end.
  end.
NB. only applicable to toggle toolbar button
  if. 0~: tbar do. ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd tbar ; 'active' ; flag ;< 0 end.
  return.
end.
win=. getchildwin window
select. iclass=. getcchildclass window
case. wdcl_isigraph do.
  if. 1= #args do. s=. ''
  elseif. 2< #args do. menu,tbar,win seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  ix=. getcchildidx window
  style=. > (<ix,ChildListUserdata){childList
  if. 2=style do.
    if. ''-:s do.
      jniCheck win ('setImageBitmap (LBitmap;)V' jniMethod)~ 0
    else.
      pic=. s
      ba=. jniCheck NewByteArray <#pic
      jniCheck SetByteArrayRegion ba;0;(#pic);pic
      bm=. jniCheck 'android.graphics.BitmapFactory' ('decodeByteArray ([BII)LBitmap;' jniStaticMethod)~ ba;0;#pic
      jniCheck win ('setImageBitmap (LBitmap;)V' jniMethod)~ bm
      jniCheck DeleteLocalRef"0 ba;bm
    end.
  elseif. 3=style do.
    if. (1 e. '://' E. 50{.s) do.
      jniCheck uri=. 'android.net.Uri' ('parse (LString;)LUri;' jniStaticMethod)~ <s
      jniCheck win ('setVideoURI (LUri;)V' jniMethod)~ uri
      jniCheck DeleteLocalRef <uri
    else.
      jniCheck win ('setVideoPath (LString;)V' jniMethod)~ <s
    end.
    jniCheck win ('start ()V' jniMethod)~ ''
  elseif. 4=style do.
    if. (1 e. '://' E. 50{.s) do.
      jniCheck win ('loadUrl (LString;)V' jniMethod)~ <s
    else.
      jniCheck win ('loadData (LString;LString;LString;)V' jniMethod)~ s;'text/html';<<0
    end.
  elseif. do. menu,tbar,win seterr 'bad class : ' return.
  end.
case. wdcl_edit ; wdcl_editm ; wdcl_static do.
  if. 1= #args do. s=. ''
  elseif. 2< #args do. menu,tbar,win seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  select. iclass
  case. wdcl_edit do.
    jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <s
  case. wdcl_editm do.
    jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <s
  case. wdcl_static do.
    jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <s
  end.
case. wdcl_checkbox ; wdcl_radiobutton do.
  if. 1= #args do. s=. ,'1'
  elseif. 2< #args do. menu,tbar,win seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. menu,tbar,win seterr 'bad number : ' return. end.
  if. 0 1 -.@e.~ flag=. {.@(0&".) s do. menu,tbar,win seterr 'bad number : ' return. end.
  jniCheck win ('setChecked (Z)V' jniMethod)~ flag
case. wdcl_combobox ; wdcl_combodrop ; wdcl_combolist ; wdcl_listbox do.
  ix=. getcchildidx window
  multiselect=. (iclass=wdcl_listbox){:: 0;(<ix,ChildListUserdata){childList
  pa=. 0$<''
  for_s1. }.args do.
    s=. >s1
    if. LF e. s do.
      pa=. pa, <;._2 s, (LF~:{:s)#LF
    else.
      pa=. pa, s1
    end.
  end.
  if. #pa do.
    pa setadapter cWindow,win,(iclass~:wdcl_listbox),multiselect
  end.
case. wdcl_progress do.
  if. 1= #args do. menu,tbar,win seterr 'bad number : ' return.
  elseif. 2< #args do. menu,tbar,win seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. menu,tbar,win seterr 'bad number : ' return. end.
  item1=. {.@(0&".) s
  gtk_progress_bar_set_fraction window ; (1 <. 0>.item1%100)
case. wdcl_scrollbar ; wdcl_scrollbarv do. NB. min/position/max/pagesize
  if. 1= #args do. menu,tbar,win seterr 'bad number : ' return.
  elseif. 3 4 e.~ #args do. menu,tbar,win seterr 'extra parameter : ' return.
  elseif. 5< #args do. menu,tbar,win seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. menu,tbar,win seterr 'bad number : ' return. end.
  if. 2= #args do.
    item1=. {.@(0&".) 1{::args
    gtk_range_set_value window ;< (0.5-0.5)&+ item1
  else.
    'item1 item2 item3 item4'=. {.@(0&".)&> 4{. }.args
    gtk_range_set_range window ; <("0) (0.5-0.5)&+ item1, item3
    gtk_range_set_increments window ; <("0) (0.5-0.5)&+ 1, item4
    gtk_range_set_value window ;< (0.5-0.5)&+ item2
  end.
case. wdcl_spin ; wdcl_spinv do.
  if. 1= #args do. menu,tbar,win seterr 'bad number : ' return.
  elseif. 2< #args do. menu,tbar,win seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. menu,tbar,win seterr 'bad number : ' return. end.
  item1=. {.@(0&".) 1{::args
  gtk_spin_button_set_value window ;< (0.5-0.5)&+ item1
case. wdcl_trackbar ; wdcl_trackbarv do. NB. min/position/max/pagesize/linesize
  if. 1= #args do. menu,tbar,win seterr 'bad number : ' return.
  elseif. 3 4 5 e.~ #args do. menu,tbar,win seterr 'extra parameter : ' return.
  elseif. 6< #args do. menu,tbar,win seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. menu,tbar,win seterr 'bad number : ' return. end.
  if. 2= #args do.
    item1=. {.@(0&".) 1{::args
    jniCheck win ('setProgress (I)V' jniMethod)~ item1
  else.
NB. TODO left, linesize ignored
    'item1 item2 item3 item4 item5'=. {.@(0&".)&> 5{. }.args
    jniCheck win ('setMax (I)V' jniMethod)~ item3
    jniCheck win ('setProgress (I)V' jniMethod)~ item2
    jniCheck win ('setKeyProgressIncrement (I)V' jniMethod)~ item4
  end.
case. wdcl_tab do.
  if. 1= #args do. menu,tbar,win seterr 'bad id : ' return. end.
NB. disable trigger
  disable_toggle_event=: 1
  idx=. windowlistidx cWindow
  idn=. (<idx,4){::windowList
  for_item. }.args do.
    jniCheck tb=. win ('newTabSpec (LString;)LTabHost$TabSpec;' jniMethod)~ <('tag',":idn=. >:idn)
    jniCheck tb ('setIndicator (LCharSequence;)LTabHost$TabSpec;' jniMethod)~ <>item
    jniCheck tb ('setContent (LTabHost$TabContentFactory;)LTabHost$TabSpec;' jniMethod)~ tabcreator
    jniCheck win ('addTab (LTabHost$TabSpec;)V' jniMethod)~ tb
  end.
  windowList=: (<idn) (<idx, 4) } windowList
NB. enable trigger
  disable_toggle_event=: 0
case. do. menu,tbar,win seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef"0 menu;tbar;win
cChild=: window
)

NB. id n
wdsetscroll=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
return.  NB. TODO
win=. getchildwin window
select. iclass=. getcchildclass window
case. wdcl_editm ; wdcl_richeditm do.
  if. 1= #args do. win seterr 'bad number : ' return.
  elseif. 2< #args do. win seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. win seterr 'bad number : ' return. end.
  line=. 0 >. <: {.@(0&".) s   NB. to base 0
  return.
  buf=. gtk_text_view_get_buffer window
  gtk_text_buffer_get_iter_at_line buf ; (iter=. i.ITERSIZE) ;< line
  mark=. gtk_text_buffer_create_mark buf;'setscroll';iter;0
  assert. 0~:mark
  gtk_text_view_scroll_to_mark window; mark; 0; 0; 0; 0
  gtk_text_buffer_delete_mark buf;mark
case. do. win seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef <win
cChild=: window
)

wdsetlimit=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 2= #args do. s=. 1{::args
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 > len=. <.@{.@(0&".) s do. seterr 'bad number : ' return. end.
return.  NB. TODO
win=. getchildwin window
select. iclass=. getcchildclass window
case. wdcl_edit do. gtk_entry_set_max_length window, len
end.
jniCheck DeleteLocalRef <win
cChild=: window
)

wdsetlocale=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
localec=. ,>{.}.args
ix=. getcchildidx window
childList=: (<localec) (<ix,ChildListLocalec)}childList
cChild=: window
)

wdsetcaption=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
s=. >{.}.args
win=. getchildwin window
select. iclass=. getcchildclass window
case. wdcl_button do.
  if. 'android.widget.ImageButton'-:jniClassName win do.
    if. ''-:s do.
      jniCheck win ('setImageBitmap (LBitmap;)V' jniMethod)~ 0
    else.
      pic=. 1!:1 ::(''"_) <s
      ba=. jniCheck NewByteArray <#pic
      jniCheck SetByteArrayRegion ba;0;(#pic);pic
      bm=. jniCheck 'android.graphics.BitmapFactory' ('decodeByteArray ([BII)LBitmap;' jniStaticMethod)~ ba;0;#pic
      jniCheck win ('setImageBitmap (LBitmap;)V' jniMethod)~ bm
      jniCheck DeleteLocalRef"0 ba;bm
    end.
  else.
    jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <s-.'&'
  end.
case. wdcl_static;wdcl_checkbox;wdcl_radiobutton do.
  jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <s
case. do. win seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef <win
cChild=: window
)

wdsetdelete=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
if. -.@isnum ax=. 1{::args do. seterr 'bad number : ' return. end.
tabn=. {.@(0&".) ax
return.  NB. TODO
win=. getchildwin window
if. g_type_check_instance_is_a window, gtk_notebook_get_type '' do.
  if. pg=. gtk_notebook_get_nth_page window, tabn do.
    for_child. > (window = >6{"1 childList) # 1{"1 childList do.
      if. gtk_widget_is_ancestor pg, child do.
        cWindow delcchild child
      end.
    end.
  end.
NB.   tabHost.getTabWidget().removeView(tabHost.getTabWidget().getChildTabViewAt(3))
  jniCheck tw=. win ('getTabWidget ()LTabWidget;' jniMethod)~ ''
  jniCheck vw=. tw ('getChildTabViewAt (I)LView;' jniMethod)~ tabn
  jniCheck tw ('removeView (LView;)V' jniMethod)~ vw
  jniCheck DeleteLocalRef"0 tw;vw
end.
jniCheck DeleteLocalRef <win
cChild=: window
)

NB. id x
wdsetedit=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
return.  NB. TODO
win=. getchildwin window
select. getcchildclass window
case. wdcl_edit ; wdcl_editm do.
  if. 1= #args do. win seterr 'bad parameter : ' return
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  end.
  s=. 1{::args
  if. (<s) -.@e. ;:'z x c v y' do. win seterr 'bad data : ' return. end.
  if. g_type_check_instance_is_a window, gtk_text_view_get_type '' do.
    buf=. gtk_text_view_get_buffer window
    clip=. gtk_clipboard_get GDK_NONE
    select. {.s
    case. 'z' do. gtk_source_buffer_undo buf
    case. 'x' do. gtk_text_buffer_cut_clipboard buf ; clip ;< 1
    case. 'c' do. gtk_text_buffer_copy_clipboard buf ;< clip
    case. 'v' do.
      mark=. gtk_text_buffer_get_insert buf
      gtk_text_buffer_get_iter_at_mark buf ; (iter=. i.ITERSIZE) ; mark
      gtk_text_buffer_paste_clipboard buf ; clip ; iter ;< 1
    case. 'y' do. gtk_source_buffer_redo buf
    end.
  else.
    select. {.s
    case. 'z' do. NB. TODO
    case. 'x' do. gtk_editable_cut_clipboard window
    case. 'c' do. gtk_editable_copy_clipboard window
    case. 'v' do. gtk_editable_paste_clipboard window
    case. 'y' do. NB. TODO
    end.
  end.
case. do. win seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef <win
cChild=: window
)

wdsetenable=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. s=. ,'1'
elseif. 2= #args do. s=. 1{::args
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
menupending=. 'created' -.@-: ((>WindowListHandle{"1 windowList) i. cWindow){:: WindowListDefpushbutton{"1 windowList
window=. cWindow getcchild id
menu=. cWindow getmenu id
tbar=. cWindow gettoolbar id
win=. 0
if. -.@isnum s do. menu,tnar seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. menu,tnar seterr 'bad number : ' return. end.
if. (0=menu) *. (0=tbar ) *. (0=window) do. menu,tnar seterr 'bad id : ' return. end.
if. 0~: window do.
  win=. getchildwin window
  jniCheck win ('setEnabled (Z)V' jniMethod)~ flag
  jniCheck DeleteLocalRef <win
end.
if. 0~: menu do.
  imx=. cWindow getmenuidx menu
  menuList=: (<1) (<imx ,3)}menuList
  if. 1= {. menust=. (<imx,4){::menuList do.
NB. set enable/disbale
NB.   ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd menu ; 'sensitive' ; flag ;< 0
  else.
    menuList=: (<(-.flag) 2}menust) (<imx ,4)}menuList
  end.
end.
if. 0~: tbar do. ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd tbar ; 'sensitive' ; flag ;< 0 end.
jniCheck DeleteLocalRef"0 menu;tbar;win
if. 0~: window do. cChild=: window end.
)

wdsetfocus=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
win=. getchildwin window
win ('requestFocus ()Z' jniMethod)~ ''
jniCheck DeleteLocalRef <win
cChild=: window
)

wdsetinsert=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 2= #args do. seterr 'missing parameter : ' return.
elseif. 3< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
if. -.@isnum ax=. 1{::args do. seterr 'bad number : ' return. end.
tabn=. {.@(0&".) ax
s=. 2{::args
return.  NB. TODO
win=. getchildwin window
if. g_type_check_instance_is_a window, gtk_notebook_get_type '' do.
  lb=. gtk_label_new <s
  fixed1=. gtk_fixed_new ''
  gtk_widget_show fixed1
  if. _1&= pg=. gtk_notebook_insert_page window, fixed1, lb, tabn do.
    g_object_unref lb
    g_object_unref fixed1
    win seterr 'todomsg3 : ' return.
  end.
end.
jniCheck DeleteLocalRef <win
cChild=: window
)

wdsetinvalid=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
win=. getchildwin window
win ('invalidate ()V' jniMethod)~ ''
jniCheck DeleteLocalRef <win
cChild=: window
)

NB. id bool
wdsetreadonly=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. s=. ,'1'
elseif. 2= #args do. s=. 1{::args
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
win=. getchildwin window
select. getcchildclass window
case. wdcl_edit ; wdcl_editm do.
  if. -.@isnum s do. win seterr 'bad number : ' return. end.
  if. 0 1 -.@e.~ flag=. {.@(0&".) s do. win seterr 'bad number : ' return. end.
  jniCheck win ('setEnabled (Z)V' jniMethod)~ flag
  jniCheck DeleteLocalRef <win
case. do. win seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef <win
cChild=: window
)

NB. id text or id n text
wdsetreplace=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
return.  NB. TODO
win=. getchildwin window
select. getcchildclass window
case. wdcl_editm do.
  if. 2< #args do. win seterr 'extra parameter : ' return. end.
  s=. >@{.}.args
  if. g_type_check_instance_is_a window, gtk_text_view_get_type '' do.
    buf=. gtk_text_view_get_buffer window
    gtk_text_buffer_delete_selection buf, 0, 1
    gtk_text_buffer_insert_at_cursor buf ; s ; #s
  else.
    gtk_editable_delete_selection window
    p=. gtk_editable_get_position window
    gtk_editable_insert_text window ; s ; (#s) ;< ,p
  end.
case. wdcl_tab do.
  if. 1= #args do. win seterr 'bad number : ' return.
  elseif. 2= #args do. s=. ''
  elseif. 3= #args do. s=. 2{::args
  elseif. 3< #args do. win seterr 'extra parameter : ' return.
  end.
  if. -.@isnum aitem1=. 1{::args do. win seterr 'bad number : ' return. end.
  item1=. {.@(0&".) aitem1
  jniCheck tw=. win ('getTabWidget ()LTabWidget;' jniMethod)~ ''
  jniCheck npage=. tw ('getChildCount ()I' jniMethod)~ ''
  if. (npage>item ) *. item>:0 do.
    jniCheck cw=. tw ('getChildAt (I)LView;' jniMethod)~ item
    jniCheck vw=. cw ('findViewById (I)LView;' jniMethod)~ R_id_title
    jniCheck vw ('setText (LCharSequence;)V' jniMethod)~ <s
    jniCheck DeleteLocalRef"0 cw;vw
  end.
  jniCheck DeleteLocalRef <tw
case. do. win seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef <win
cChild=: window
)

NB. id [ start end [noscroll ]
wdsetselect=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
win=. getchildwin window
select. iclass=. getcchildclass window
case. wdcl_edit ; wdcl_editm do.
  if. 4< #args do. win seterr 'extra parameter : ' return.
  elseif. 1 3 4 -.@e.~ #args do. win seterr 'bad number : ' return.
  end.
  if. 1= #args do.
    allsel=. 1 [ noscroll=. 1
  else.
    allsel=. 0
    if. 0 e. isnum&> }.args do. win seterr 'bad number : ' return. end.
    'startsel endsel noscroll'=. 3{. {.@(0&".)&> }.args
    if. 3= #args do. noscroll=. 1 end.
  end.
case. wdcl_combobox ; wdcl_combodrop ; wdcl_combolist do.
  if. 2> #args do. win seterr 'bad number : ' return.
  elseif. 2< #args do. win seterr 'extra parameter : ' return.
  end.
  s=. 1{::args
  if. -.@isnum s do. win seterr 'bad number : ' return. end.
  item=. {.@(0&".) s
  jniCheck cnt=. win ('getCount ()I' jniMethod)~ ''
  if. (item>:0) *. item<cnt do.
    jniCheck win ('setSelection (I)V' jniMethod)~ item
  end.
case. wdcl_listbox do.
  if. 2> #args do. win seterr 'bad number : ' return.
  elseif. 2< #args do. win seterr 'extra parameter : ' return.
  end.
  s=. 1{::args
  if. -.@isnum s do. win seterr 'bad number : ' return. end.
  item=. {.@(0&".) s
  jniCheck cnt=. win ('getCount ()I' jniMethod)~ ''
  if. _1&= item do.
    for_i. i.cnt do.
      jniCheck win ('setItemChecked (IZ)V' jniMethod)~ i;0
    end.
  else.
    if. (item>:0) *. item<cnt do.
      jniCheck win ('setItemChecked (IZ)V' jniMethod)~ item;1
    end.
  end.
case. wdcl_tab do.
  if. 2> #args do. win seterr 'bad number : ' return.
  elseif. 2< #args do. win seterr 'extra parameter : ' return.
  end.
  s=. 1{::args
  if. -.@isnum s do. win seterr 'bad number : ' return. end.
  item=. {.@(0&".) s
NB. disable trigger
  disable_toggle_event=: 1
  jniCheck tw=. win ('getTabWidget ()LTabWidget;' jniMethod)~ ''
  jniCheck npage=. tw ('getChildCount ()I' jniMethod)~ ''
  jniCheck DeleteLocalRef <tw
  if. item < npage do.
    jniCheck win ('setCurrentTab (I)V' jniMethod)~ item
  end.
NB. enable trigger
  disable_toggle_event=: 0
case. do. win seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef <win
cChild=: window
)

wdsetshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. s=. ,'1'
elseif. 2= #args do. s=. 1{::args
elseif. 2< #args do. seterr 'extra paramenter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
win=. 0
if. 0= window=. cWindow getcchild id do.
  for_ix. I. ((<id)= ChildListSubform{"1 childList) *. (cWindow = >{."1 childList) do.
    window=. (<ix,1){::childList
    win=. getchildwin window
    jniCheck win ('setVisibility (I)V' jniMethod)~ flag{8 0
    jniCheck DeleteLocalRef <win
  end.
NB. do not set cChild
else.
  ix=. getcchildidx window
  assert. _1~: ix
  childList=: (<flag) (<ix,5)}childList
  win=. getchildwin window
  jniCheck win ('setVisibility (I)V' jniMethod)~ flag{8 0   NB. 0=visible 4=invisible 8=gone
  jniCheck DeleteLocalRef <win
  cChild=: window
end.
)

wdsetxywh=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 5> #args do. seterr 'bad number : ' return.
elseif. 5< #args do. seterr 'extra paramenter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> }.args
idx=. windowlistidx cWindow
'tbvisi tbcnt tbpx'=. 1 2 3{ (<idx, WindowListToolbar){:: windowList
offset=. <. tbvisi *. tbpx
setxywhx id ; (dpw2px xywh) ; offset
)

wdsetxywhx=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 5> #args do. seterr 'bad number : ' return.
elseif. 5< #args do. seterr 'extra paramenter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> }.args
idx=. windowlistidx cWindow
'tbvisi tbcnt tbpx'=. 1 2 3{ (<idx, WindowListToolbar){:: windowList
offset=. <. tbvisi *. tbpx
setxywhx id ; xywh ; offset
)

NB. c ViewGroup.LayoutParams getLayoutParams ()) android.view.ViewGroup.LayoutParams public void requestLayout ()
NB.  android.view.ViewGroup.LayoutParams public void requestLayout ()
setxywhx=: 3 : 0
'id xywh offset'=. y
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
win=. getchildwin window
NB. fixed1=. getchildwin fixedidn
lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
'x y w h'=. xywh
lp ('x I' jniField)~ <x
lp ('y I' jniField)~ <y + offset
lp ('width I' jniField)~ <w
lp ('height I' jniField)~ <h
win ('requestLayout ()V' jniMethod)~ ''
jniCheck DeleteLocalRef"0 win;lp

cChild=: window
)

wdxywh=: 3 : 0
if. 4> #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 4< #args do. seterr 'extra paramenter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
cxywh=: <. {.@(0&".)&> args
)

