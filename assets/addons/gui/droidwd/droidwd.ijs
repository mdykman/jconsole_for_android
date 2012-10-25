require 'gui/android gl2'
require '~addons/gui/droidwd/isigraph.ijs'

3 : 0''
if. 0~: 4!:0 <'FIXFONT_z_' do. FIXFONT_z_=: FIXFONT_jgl2_ end.
if. 0~: 4!:0 <'PROFONT_z_' do. PROFONT_z_=: PROFONT_jgl2_ end.
''
)

coclass 'droidwd'
coinsert 'jni jaresu'

jniImport ::0: (0 : 0)
android.content.Context
android.graphics.Bitmap
android.graphics.BitmapFactory
android.graphics.Typeface
android.graphics.drawable.BitmapDrawable
android.graphics.drawable.Drawable
android.media.MediaPlayer
android.media.ToneGenerator
android.net.Uri
android.view.Display
android.view.View
android.view.View$OnClickListener
android.view.ViewGroup
android.view.WindowManager
android.webkit.WebSettings
android.webkit.WebView
android.webkit.WebViewClient
android.widget.AbsListView
android.widget.AbsoluteLayout
android.widget.AbsoluteLayout$LayoutParams
android.widget.AdapterView$OnItemClickListener
android.widget.AdapterView$OnItemSelectedListener
android.widget.AnalogClock
android.widget.ArrayAdapter
android.widget.Button
android.widget.CheckBox
android.widget.DatePicker
android.widget.DigitalClock
android.widget.EditText
android.widget.FrameLayout
android.widget.Gallery
android.widget.HorizontalScrollView
android.widget.ImageButton
android.widget.ImageView
android.widget.LinearLayout
android.widget.ListAdapter
android.widget.ListView
android.widget.ProgressBar
android.widget.RadioButton
android.widget.RadioGroup
android.widget.RelativeLayout
android.widget.ScrollView
android.widget.Spinner
android.widget.SpinnerAdapter
android.widget.TableLayout
android.widget.TableRow
android.widget.TextView
android.widget.TimePicker
android.widget.VideoView
)

wdqdata=: 0 0$0

Debugwd=: 1
TileWM=: 0
LASTCMD=: ''
WDERR=: ''
WDERRN=: 0
WDLOC=: 'base'
CBSIZE=: 20
wdptr0=: wdptr=: 0
wdstr=: ''
sysmodifiers=: ,'0'
sysdata=: ''
disable_toggle_event=: 0

lasterrcmd=: lastcmd=: ''
cWindow=: 0
cChild=: 0
cRadio=: 0
cContainer=: 0
cSubform=: ''
windowList=: 0 16$<''
WindowListHandle=: 0
WindowListId=: 1
WindowListLocale=: 2
WindowListPgroup=: 3
WindowListActiveidx=: 4
WindowListFixed=: 5
WindowListFontdef=: 6
WindowListToolbar=: 7
WindowListStatusbar=: 8
WindowListMenubar=: 9
WindowListWh1=: 10
WindowListAccel=: 11
WindowListWh0=: 12
WindowListDefpushbutton=: 13
WindowListTbimg=: 14
WindowListCloseok=: 15

containerList=: 0 3$<''
subformList=: 0 4$<''
childList=: 0 12$<''
ChildListContainer=: 6
ChildListSubform=: 7
ChildListWywh0=: 8
ChildListHide=: 9
ChildListLocalec=: 10
ChildListUserdata=: 11

menuList=: 0 4$<''
toolbarList=: 0 5$<''
statusbarList=: 0 3$<''
activeidx=: 0$0
cxywh=: 0 0 100 100
cFontdef=: ''
cSetFont=: ''
tbimg=: 0
3 : 0''
if. 0 = 4!:0 <'systimerid_droidwd_' do.
  if. 0~:systimerid do. systimerid=: 0 [ g_source_remove systimerid end.
end.
''
)

systimerid=: timerdelay=: 0

jloc=: 3 : 0
WDLOC
)

Activity=: 0

3 : 0''
if. 0~: 4!:0 <'wdlistener_droidwd_' do.
  button_click_listener=: NewGlobalRef < a1=. '' jniOverride 'org.dykman.jn.android.view.View$OnClickListener' ; 'droidwd' ; 'button'
  listbox_select_listener=: NewGlobalRef < a2=. '' jniOverride 'org.dykman.jn.android.widget.AdapterView$OnItemSelectedListener' ; 'droidwd' ; 'listbox'
  listbox_click_listener=: NewGlobalRef < a3=. '' jniOverride 'org.dykman.jn.android.widget.AdapterView$OnItemClickListener' ; 'droidwd' ; 'listbox'

  jniCheck DeleteLocalRef"0 a1;a2;a3
  wdlisteners=: button_click_listener, listbox_select_listener, listbox_click_listener
else.
  wdlisteners=: 0$0
end.
)

inputtype_none=: 16b00000000
inputtype_text=: 16b00000001
inputtype_textCapCharacters=: 16b00001001
inputtype_textCapWords=: 16b00002001
inputtype_textCapSentences=: 16b00004001
inputtype_textAutoCorrect=: 16b00008001
inputtype_textAutoComplete=: 16b00010001
inputtype_textMultiLine=: 16b00020001
inputtype_textImeMultiLine=: 16b00040001
inputtype_textNoSuggestions=: 16b00080001
inputtype_textUri=: 16b00000011
inputtype_textEmailAddress=: 16b00000021
inputtype_textEmailSubject=: 16b00000031
inputtype_textShortMessage=: 16b00000041
inputtype_textLongMessage=: 16b00000051
inputtype_textPersonName=: 16b00000061
inputtype_textPostalAddress=: 16b00000071
inputtype_textPassword=: 16b00000081
inputtype_textVisiblePassword=: 16b00000091
inputtype_textWebEditText=: 16b000000a1
inputtype_textFilter=: 16b000000b1
inputtype_textPhonetic=: 16b000000c1
inputtype_textWebEmailAddress=: 16b000000d1
inputtype_textWebPassword=: 16b000000e1
inputtype_number=: 16b00000002
inputtype_numberSigned=: 16b00001002
inputtype_numberDecimal=: 16b00002002
inputtype_numberPassword=: 16b00000012
inputtype_phone=: 16b00000003
inputtype_datetime=: 16b00000004
inputtype_date=: 16b00000014
inputtype_time=: 16b00000024
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
  stylen=. 2#. |. styles e.~ FMSTYLE
else.
  stylen=. 0
  styles=. 0$<''
end.
if. 0 e. styles e. (;:'group nopas'), FMSTYLE, ;2 3{ iclass{CONTROLS do. seterr 'bad style : ' return. end.
if. 0= cContainer do.
  fixed1=. getchildwin fixedidn
else.
  if. 1 e. f=. (cContainer = >1{"1 subformList) *. (<cSubform) = 2{"1 subformList do.
    fixed1=. 3{:: ({.I.f){subformList
    assert. 0~:fixed1
  else.
    seterr 'todomsg1 : ' return.
  end.
  assert. 0~:fixed1
  assert. fixed1 e. 3{::"1 subformList
end.
defpushbutton=. 0
newgroup=. 0
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  cParentId=. (handle i. cWindow){ >WindowListId{"1 windowList
  cParentLoc=. (handle i. cWindow){ >WindowListLocale{"1 windowList
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
  jniCheck win ('setOnItemSelectedListener (LAdapterView$OnItemSelectedListener;)V' jniMethod)~ listbox_select_listener
fcase. wdcl_richedit do.
  iclass=. wdcl_edit
case. wdcl_edit do.
  jniCheck win=. cWindow jniNewObject 'EditText LContext;'
  if. (<'es_readonly') e. styles do. jniCheck win ('setEnabled (Z)V' jniMethod)~ 0 end.
  password=. 0
  ip=. inputtype_text
  if. (<'es_uppercase') e. styles do. ip=. ip, inputtype_textCapCharacters end.
  if. (<'es_password') e. styles do. ip=. ip, inputtype_textPassword end.
  jniCheck win ('setInputType (I)V' jniMethod)~ (23 b.)/ ip
fcase. wdcl_editijs;wdcl_editijx;wdcl_richeditm do.
  iclass=. wdcl_editm
case. wdcl_editm do.
  jniCheck win=. cWindow jniNewObject 'EditText LContext;'
  if. (<'es_readonly') e. styles do. jniCheck win ('setEnabled (Z)V' jniMethod)~ 0 end.
  ip=. inputtype_textMultiLine
  if. (<'es_uppercase') e. styles do. ip=. ip, inputtype_textCapCharacters end.
  if. (<'es_password') e. styles do. ip=. ip, inputtype_textPassword end.
  jniCheck win ('setInputType (I)V' jniMethod)~ (23 b.)/ ip
  jniCheck win ('setGravity (I)V' jniMethod)~ 16b30
  if. (hsc=. (<'ws_hscroll') e. styles) do.
    jniCheck win ('setHorizontallyScrolling (Z)V' jniMethod)~ 1
  end.
case. wdcl_groupbox do.
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_frame_get_type '') ; 'shadow-type' ; GTK_SHADOW_NONE ;< 0
case. wdcl_isigraph do.
  if. (<'gs_opengl') e. styles do.
    userdata=. 1
    jniCheck win=. cWindow jniOverride 'org.dykman.jn.android.view.View LContext;' ; 'droidwd' ; 'isigraph' ; 'onDraw'
  elseif. (<'gs_image') e. styles do.
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
    jniCheck win=. cWindow jniOverride 'org.dykman.jn.android.view.View LContext;' ; 'droidwd' ; 'isigraph' ; 'onDraw'
  end.
case. wdcl_listbox do.
  jniCheck win=. cWindow jniNewObject 'ListView LContext;'
  jniCheck win ('setOnItemClickListener (LAdapterView$OnItemClickListener;)V' jniMethod)~ listbox_click_listener
  userdata=. (<'lbs_multiplesel') e. styles
case. wdcl_radiobutton do.
  if. newgroup=. (0=cRadio) +. (<'group') e. styles do.
    if. cRadio do. DeleteLocalRef <cRadio end.
    jniCheck cRadio=: cWindow jniNewObject 'RadioGroup LContext;'
    jniCheck cRadio ('setOrientation (I)V' jniMethod)~ (<'bs_lefttext') -.@e. styles
  end.
  jniCheck win=. cWindow jniNewObject 'RadioButton LContext;'
  jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <id
  jniCheck cRadio ('addView (LView;)V' jniMethod)~ win
  jniCheck win ('setOnClickListener (LView$OnClickListener;)V' jniMethod)~ button_click_listener
case. wdcl_scrollbar do.
  adjust=. gtk_adjustment_new <("0) (0.5-0.5)&+ 0 0 100 1 10 5
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_hscrollbar_get_type '') ; 'adjustment' ; adjust ;< 0
  consig window ; 'value-changed' ; 'scrollbar_change'
case. wdcl_scrollbarv do.
  adjust=. gtk_adjustment_new <("0) (0.5-0.5)&+ 0 0 100 1 10 5
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_vscrollbar_get_type '') ; 'adjustment' ; adjust ;< 0
  consig window ; 'value-changed' ; 'scrollbar_change'
case. wdcl_static do.
  jniCheck win=. cWindow jniNewObject 'TextView LContext;'
  jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <id
case. wdcl_progress do.
  window=. gtk_progress_bar_new ''
case. wdcl_spin ; wdcl_spinv do.
  adjust=. gtk_adjustment_new <("0) (0.5-0.5)&+ 0 0 100 1 10 0
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x *c d x')&cd ( gtk_spin_button_get_type '') ; 'adjustment' ; adjust ; 'value' ; (0.5-0.5) ;< 0
  consig window ; 'value-changed' ; 'spin_change'
case. wdcl_tab do.
  window=. gtk_notebook_new ''
  consig4 window ; 'switch-page' ; 'tab_switch_page'
  consig4 window ; 'page-removed' ; 'tab_page_removed'
  userdata=. 0
case. wdcl_trackbar do.
  adjust=. gtk_adjustment_new <("0) (0.5-0.5)&+ 0 0 100 1 10 0
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_hscale_get_type '') ; 'adjustment' ; adjust ;< 0
  consig window ; 'value-changed' ; 'trackbar_change'
case. do.
  seterr 'bad class : ' return.
end.
if. '' -.@-: cSetFont do.
  fontdef=. cFontdef
else.
  if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
    fontdef=. (handle i. cWindow){:: WindowListFontdef{"1 windowList
  else.
    assert. 0
  end.
end.
if. '' -.@-: fontdef do.
  if. '"' e. f=. fontdef do. f=. }. (}.~ i:&'"') end.
  if. #fs=. I. 1= (*./@:(e.&'_.0123456789')) &> fb=. ;: f do.
    asize=. {. 10&". ({.fs){::fb
  else.
    asize=. 10
  end.
  fd=. pango_font_description_from_string <fontdef
  gtk_widget_modify_font window, fd
  pango_font_description_free fd
else.
  asize=. 10
end.
if. iclass e. wdcl_combobox, wdcl_combodrop, wdcl_combolist do.
  cxywh1=. (3{.cxywh) , >. CBSIZE * asize%10
else.
  cxywh1=. cxywh
end.
if. newgroup do.
  lpclass=. 'AbsoluteLayout$LayoutParams'
  lp=. (lpclass, ' IIII') jniNewObject~ <"0 dp2px _2 _2, 2{.cxywh1
  jniCheck cRadio ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck DeleteLocalRef <lp
elseif. iclass ~: wdcl_radiobutton do.
  lpclass=. 'AbsoluteLayout$LayoutParams'
  if. iclass e. wdcl_edit, wdcl_combobox, wdcl_combodrop, wdcl_combolist do.
    lp=. (lpclass, ' IIII') jniNewObject~ <"0 dp2px 2|. _2 (3)}cxywh1
  else.
    lp=. (lpclass, ' IIII') jniNewObject~ <"0 dp2px 2|.cxywh1
  end.
  jniCheck win ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck DeleteLocalRef <lp
end.
if. newgroup do.
  jniCheck fixed1 ('addView (LView;)V' jniMethod)~ cRadio
elseif. iclass ~: wdcl_radiobutton do.
  jniCheck fixed1 ('addView (LView;)V' jniMethod)~ win
end.

jniCheck DeleteLocalRef <fixed1
idx=. windowlistidx cWindow
idn=. (<idx,4){::windowList
jniCheck win ('setId (I)V' jniMethod)~ idn=. >:idn
cChild=: idn
if. 0&= win do. seterr 'cannot create child : ' return. end.
childList=: childList, cWindow ; cChild ; id ; iclass ; stylen ; 0 ; cContainer ; ((0~:cContainer){::'';cSubform) ; (dp2px cxywh1) ; 0 ; localec ;< userdata
if. (<'nopas') -.@e. styles do.
  if. 0= cContainer do.
    idx=. windowlistidx cWindow
    assert. _1~:idx
    wh0=. (<idx, WindowListWh0){::windowList
    wh0=. wh0 >. dp2px +/ 2 2$cxywh
    windowList=: (<wh0) (<idx, WindowListWh0)} windowList
  else.
    idx=. (>1{"1 containerList) i. cContainer
    assert. idx < #containerList
    wh0=. (<idx, 2){::containerList
    wh0=. wh0 >. dp2px +/ 2 2$cxywh
    containerList=: (<wh0) (<idx, 2)} containerList
  end.
end.
windowList=: (<idn) (<idx, 4) } windowList
if. (0~:defpushbutton) *. 0= cContainer do.
  idx=. windowlistidx cWindow
  windowList=: (<window) (<idx, WindowListDefpushbutton) } windowList
end.
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
    jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <s
  end.
end.
jniCheck DeleteLocalRef <win
)

wdqchildxywh=: 3 : 0
if. 2= 3!:0 z=. qchildxywhx '' do. z return. end.
": px2dp z
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
win=. getchildwin window
wh=. getchildwh win
xy=. getchildxy win
xy,wh
)

wdqhwndc=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
":getchildwin window
)
wdset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do.
  menu=. cWindow getmenu id
  tbar=. cWindow gettoolbar id
  if. (0=menu) *. 0=tbar do. seterr 'bad id : ' return. end.
  if. 1= #args do. s=. ,'1'
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
  if. 0~: menu do.
    ix=. (>1{"1 menuList) i. menu
    menuList=: (<1) (<ix ,3)}menuList
    gtk_check_menu_item_set_active menu, flag
  end.
  if. 0~: tbar do. ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd tbar ; 'active' ; flag ;< 0 end.
  return.
end.
win=. getchildwin window
select. iclass=. getcchildclass window
case. wdcl_isigraph do.
  if. 1= #args do. s=. ''
  elseif. 2< #args do. seterr 'extra parameter : ' return.
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
  elseif. do. seterr 'bad class : ' return.
  end.
case. wdcl_edit ; wdcl_editm ; wdcl_static do.
  if. 1= #args do. s=. ''
  elseif. 2< #args do. seterr 'extra parameter : ' return.
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
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
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
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  item1=. {.@(0&".) s
  gtk_progress_bar_set_fraction window ; (1 <. 0>.item1%100)
case. wdcl_scrollbar ; wdcl_scrollbarv do.
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 3 4 e.~ #args do. seterr 'extra parameter : ' return.
  elseif. 5< #args do. seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
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
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
  item1=. {.@(0&".) 1{::args
  gtk_spin_button_set_value window ;< (0.5-0.5)&+ item1
case. wdcl_trackbar ; wdcl_trackbarv do.
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 3 4 5 e.~ #args do. seterr 'extra parameter : ' return.
  elseif. 6< #args do. seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
  if. 2= #args do.
    item1=. {.@(0&".) 1{::args
    gtk_range_set_value window ;< (0.5-0.5)&+ item1
  else.
    'item1 item2 item3 item4 item5'=. {.@(0&".)&> 5{. }.args
    gtk_range_set_range window ; <("0) (0.5-0.5)&+ item1, item3
    gtk_range_set_increments window ; <("0) (0.5-0.5)&+ 1, item4
    gtk_range_set_value window ;< (0.5-0.5)&+ item2
  end.
case. do. seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef <win
cChild=: window
)
wdsetscroll=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
select. iclass=. getcchildclass window
case. wdcl_editm ; wdcl_richeditm do.
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  line=. 0 >. <: {.@(0&".) s
  buf=. gtk_text_view_get_buffer window
  gtk_text_buffer_get_iter_at_line buf ; (iter=. i.ITERSIZE) ;< line
  mark=. gtk_text_buffer_create_mark buf;'setscroll';iter;0
  assert. 0~:mark
  gtk_text_view_scroll_to_mark window; mark; 0; 0; 0; 0
  gtk_text_buffer_delete_mark buf;mark
case. do. seterr 'bad class : ' return.
end.
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
select. iclass=. getcchildclass window
case. wdcl_edit do. gtk_entry_set_max_length window, len
end.
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
if. g_type_check_instance_is_a window, gtk_button_get_type '' do.
  if. 0= image=. gtk_button_get_image <window do.
    gtk_button_set_label window ; '&_' charsub s
  else.
    setbuttonimage window ; image ;< s
  end.
else.
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c *c x')&cd window ; 'label' ; s ;< 0
end.
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
if. g_type_check_instance_is_a window, gtk_notebook_get_type '' do.
  if. pg=. gtk_notebook_get_nth_page window, tabn do.
    for_child. > (window = >6{"1 childList) # 1{"1 childList do.
      if. gtk_widget_is_ancestor pg, child do.
        cWindow delcchild child
      end.
    end.
  end.
  gtk_notebook_remove_page window, tabn
end.
cChild=: window
)
wdsetedit=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
select. getcchildclass window
case. wdcl_edit ; wdcl_editm do.
  if. 1= #args do. seterr 'bad parameter : ' return
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  end.
  s=. 1{::args
  if. (<s) -.@e. ;:'z x c v y' do. seterr 'bad data : ' return. end.
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
    case. 'z' do.
    case. 'x' do. gtk_editable_cut_clipboard window
    case. 'c' do. gtk_editable_copy_clipboard window
    case. 'v' do. gtk_editable_paste_clipboard window
    case. 'y' do.
    end.
  end.
case. do. seterr 'bad class : ' return.
end.
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
window=. cWindow getcchild id
menu=. cWindow getmenu id
tbar=. cWindow gettoolbar id
if. (0=menu) *. (0=tbar ) *. (0=window) do. seterr 'bad id : ' return. end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
if. 0~: window do.
  win=. getchildwin window
  jniCheck win ('setEnabled (Z)V' jniMethod)~ flag
  jniCheck DeleteLocalRef <win
end.
if. 0~: menu do. ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd menu ; 'sensitive' ; flag ;< 0 end.
if. 0~: tbar do. ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd tbar ; 'sensitive' ; flag ;< 0 end.
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
win ('requestFocus ()V' jniMethod)~ ''
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
if. g_type_check_instance_is_a window, gtk_notebook_get_type '' do.
  lb=. gtk_label_new <s
  fixed1=. gtk_fixed_new ''
  gtk_widget_show fixed1
  if. _1&= pg=. gtk_notebook_insert_page window, fixed1, lb, tabn do.
    g_object_unref lb
    g_object_unref fixed1
    seterr 'todomsg3 : ' return.
  end.
end.
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
wdsetreadonly=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. s=. ,'1'
elseif. 2= #args do. s=. 1{::args
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
select. getcchildclass window
case. wdcl_edit ; wdcl_editm do.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
  if. g_type_check_instance_is_a window, gtk_text_view_get_type '' do.
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd window ; 'editable' ; (-.flag) ;< 0
  else.
    gtk_editable_set_editable window, (-.flag)
  end.
case. do. seterr 'bad class : ' return.
end.
cChild=: window
)
wdsetreplace=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
select. getcchildclass window
case. wdcl_editm do.
  if. 2< #args do. seterr 'extra parameter : ' return. end.
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
case. do. seterr 'bad class : ' return.
end.
cChild=: window
)
wdsetselect=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
win=. getchildwin window
select. iclass=. getcchildclass window
case. wdcl_edit ; wdcl_editm do.
  if. 4< #args do. seterr 'extra parameter : ' return.
  elseif. 1 3 4 -.@e.~ #args do. seterr 'bad number : ' return.
  end.
  if. 1= #args do.
    allsel=. 1 [ noscroll=. 1
  else.
    allsel=. 0
    if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
    'startsel endsel noscroll'=. 3{. {.@(0&".)&> }.args
    if. 3= #args do. noscroll=. 1 end.
  end.
case. wdcl_combobox ; wdcl_combodrop ; wdcl_combolist do.
  if. 2> #args do. seterr 'bad number : ' return.
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  end.
  s=. 1{::args
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  item=. {.@(0&".) s
  jniCheck cnt=. win ('getCount ()I' jniMethod)~ ''
  if. (item>:0) *. item<cnt do.
    jniCheck win ('setSelection (I)V' jniMethod)~ item
  end.
case. wdcl_listbox do.
  if. 2> #args do. seterr 'bad number : ' return.
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  end.
  s=. 1{::args
  if. -.@isnum s do. seterr 'bad number : ' return. end.
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
case. wdcl_trackbar ; wdcl_trackbarv do.
  allsel=. 0
  if. 1= #args do. allsel=. 1
  elseif. 2= #args do. seterr 'bad number : ' return.
  elseif. 3< #args do. seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
  'startsel endsel'=. {.@(0&".)&> }.args
  gtk_window_set_select window ; startsel ; endsel
case. do. seterr 'bad class : ' return.
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
if. 0= window=. cWindow getcchild id do.
  for_ix. I. ((<id)= ChildListSubform{"1 childList) *. (cWindow = >{."1 childList) do.
    window=. (<ix,1){::childList
    win=. getchildwin window
    jniCheck win ('setVisibility (Z)V' jniMethod)~ flag
    jniCheck DeleteLocalRef <win
  end.
else.
  ix=. getcchildidx window
  assert. _1~: ix
  childList=: (<flag) (<ix,5)}childList
  win=. getchildwin window
  jniCheck win ('setVisibility (Z)V' jniMethod)~ flag
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
setxywhx id ; dp2px xywh
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
setxywhx id ; xywh
)
setxywhx=: 3 : 0
'id xywh'=. y
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
win=. getchildwin window
lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
'x y w h'=. xywh
lp ('x I' jniField)~ <x
lp ('y I' jniField)~ <y
lp ('width I' jniField)~ <w
lp ('height I' jniField)~ <h
win ('requestLayout ()V' jniMethod)~ ''
jniCheck DeleteLocalRef"0 win;lp
)

wdxywh=: 3 : 0
if. 4> #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 4< #args do. seterr 'extra paramenter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
cxywh=: <. {.@(0&".)&> args
)


FMSTYLE=: , ; each { (;<;:'left top right bottom') ; <;:'move scale'
j=. 0 : 0
button
bs
group
defpushbutton ownerdraw
0 1
1
button
checkbox
bs
group
lefttext
2 4
1
button
combobox
cbs
group vscroll
autohscroll sort
2 2
0
button select
combodrop
cbs
group vscroll
autohscroll sort
2 2
0
button select
combolist
cbs
group vscroll
sort
2 2
0
button select
edit
es
group thickframe
autohscroll lowercase nohidesel password readonly right uppercase
2 3
0
button
editm
es
group hscroll thickframe vscroll
autohscroll autovscroll center lowercase nohidesel readonly right uppercase
2 2
0

groupbox
-
group
-
2 2
1

isigraph
gs
-
opengl image video web
2 2
0
char copy cut focus focuslost mbldbl mbldown mblup mblmdown mblmdbl mblmup mbrdbl mbrdown mbrup mmove mwheel paint paste undo
listbox
lbs
group hscroll vscroll
extendedsel multicolumn multiplesel ownerdrawfixed sort
2 2
0
button select
progress
-
group
-
2 3
0
button
radiobutton
bs
-
lefttext
2 4
1
button
richedit
es
group thickframe
autohscroll nohidesel readonly sunken
2 3
0
button
richeditm
es
group hscroll thickframe vscroll
autohscroll autovscroll center nohidesel readonly right sunken
2 2
0

scrollbar
sbs
group
-
2 3
0
button
scrollbarv
sbs
group
-
3 2
0
button
spin

group
-
1 1
0
button
spinv

group
-
1 1
0
button
static
ss
group
center leftnowordwrap noprefix right simple
2 4
1

staticbox
ss
group
blackframe blackrect etchedframe etchedhorz etchedvert grayframe grayrect sunken whiteframe whiterect
2 2
0

tab
tcs
group
buttons multiline
2 2
0
button
trackbar
tbs
group
autoticks both enableselrange nothumb noticks top
2 3
0
button
trackbarv
tbs
group
autoticks both enableselrange left nothumb noticks
3 2
0
button
ocx
ocx
group

2 2
0
button
editijs
es
group hscroll thickframe vscroll
autohscroll autovscroll center lowercase nohidesel readonly right uppercase
2 2
0

editijx
es
group hscroll thickframe vscroll
autohscroll autovscroll center lowercase nohidesel readonly right uppercase
2 2
0

)
j=. _7 [\ <;._2 j -. '-'
s=. 'border disabled '
std=. ([: 'ws_'&, each [: ;: s&,) each 2 {"1 j
sty=. (1 {"1 j) ,each '_'
cls=. (< each sty) ,each each ;: each 3 {"1 j
siz=. 0 ". each 4 {"1 j
cap=. 0 ". each 5 {"1 j
evt=. ;: each 6 {"1 j
CONTROLS=: (2 {."1 j) ,. std ,. cls ,. siz ,. cap ,. evt
JAVASTYLES=: (<;._2) 0 : 0
bs_defpushbutton
bs_lefttext
bs_ownerdraw
cbs_autohscroll
cbs_sort
es_autohscroll
es_autovscroll
es_center
es_lowercase
es_nohidesel
es_password
es_readonly
es_right
es_sunken
es_uppercase
gs_opengl
lbs_extendedsel
lbs_multicolumn
lbs_multiplesel
lbs_ownerdrawfixed
lbs_sort
sbs_vert
ss_blackframe
ss_blackrect
ss_center
ss_etchedframe
ss_etchedhorz
ss_etchedvert
ss_grayframe
ss_grayrect
ss_leftnowordwrap
ss_noprefix
ss_right
ss_simple
ss_sunken
ss_whiteframe
ss_whiterect
tbs_autoticks
tbs_both
tbs_enableselrange
tbs_left
tbs_nothumb
tbs_noticks
tbs_top
tcs_buttons
tcs_multiline
ws_border
ws_disabled
ws_group
ws_hscroll
ws_thickframe
ws_vscroll
)
3 : 0''
std=. 2 {"1 CONTROLS
cls=. 3 {"1 CONTROLS
CONTROLS=: (std ,. cls) 2 3 }"1 CONTROLS
STDCONTROLS=: CONTROLS #~ (<'ocx') ~: {."1 CONTROLS
)

(a)=: i.# a=. (<'wdcl_') ,&.> {."1 CONTROLS
qcolor=: ".;._2 [ 0 : 0
212 208 200
58 110 165
10 36 106
128 128 128
212 208 200
255 255 255
0 0 0
0 0 0
0 0 0
255 255 255
212 208 200
212 208 200
128 128 128
10 36 106
255 255 255
212 208 200
128 128 128
128 128 128
0 0 0
212 208 200
255 255 255
64 64 64
212 208 200
0 0 0
255 255 225
181 181 181
0 0 200
166 202 240
192 192 192
10 36 106
212 208 200
)

wdbeep=: 3 : 0
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
jniCheck tg=. 'ToneGenerator II' jniNewObject~ (STREAM_NOTIFICATION=. 5);100
tg ('startTone (I)Z' jniMethod)~ TONE_PROP_BEEP=. 24
jniCheck DeleteLocalRef <tg
)

wdmsgs=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
EMPTY
)

wdq=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. wdqdata-: 0 0$0 do. seterr 'invalid command(wdq) : ' return. end.
t=. wdqdata
smoutput^:(1<Debugwd) t
t [ wdqdata=: 0 0$0
)

wdqcolor=: 3 : 0
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum ax=. >@{.args do. seterr 'bad number : ' return. end.
if. 0 > c=. <. {.@(0&".) ax do.seterr 'bad number : ' return. end.
if. c >: #qcolor do.
  z=. 3$0
else.
  z=. c{qcolor
end.
":z
)

wdqd=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
pa=. {.(cWindow = >{."1 windowList)#windowList
syslocalep=. >WindowListLocale{pa
syslocalec=. ''
syshwndp=. ":cWindow
syshwndc=. ":cChild
sysfocus=. getcchildid gtk_window_get_focus cWindow
syslastfocus=. ''
sysmodifiers=. ''
wdd=. ;: 'syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers'
wddata=. ".&.>wdd
qdata=. 0 2$<''
for_ls. (cWindow = >{."1 childList)#childList do.
  qdata=. qdata, childevtdata 1 2 3{ls
end.
(wdd ,. wddata), qdata
)

wdqiox=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
,'0'
)

wdqer=: 3 : 0
z=. WDERR
if. ''-: z do.
  'no error : 0'
else.
  z, ": wdptr0
end.
)

wdqm=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
dm=. getdisplaymetrics_ja_ cWindow
assert. 8=#dm
'w h'=. <. 5 3{dm
": w, h, 8 16, 1 1 3 3 4 4 19 19 0 0, w, h
)

wdqp=: 3 : 0
if. 0= #args=. shiftargs'' do. s=. ''
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0= #windowList do. '' return. end.
ws=. WindowListPgroup{"1 windowList
;LF ,&.>~ (WindowListId{"1 windowList)#~(<s)=ws
)
wdqpx=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. 0= #windowList do. '' return. end.
act=. /:@\: (|.activeidx) i. WindowListHandle{::"1 windowList
z=. ''
for_i. i.#windowList do.
  'w id loc grp'=. (WindowListHandle, WindowListId, WindowListLocale, WindowListPgroup){i{windowList
  if. 0~: s=. gtk_window_get_title w do.
    cap=. memr s,0 _1 2
  else.
    cap=. ''
  end.
  z=. z, id, ({.a.), (":w), ({.a.), loc, ({.a.), grp, ({.a.), (":i{act), ({.a.), (cap), ({.a.), LF
end.
z
)

wdqscreen=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
dm=. getdisplaymetrics_ja_ 0
assert. 8=#dm
'w h dpi'=. <. 5 3 2{dm
'wmm hmm'=. 25.4*dpi%~w,h
pxsiz=. <. 0.5 + 36*96%dpi
": wmm, hmm, w, h, dpi, 32 1 _1, pxsiz, <. 0.5 + %: +/ *: pxsiz
)

wdqwd=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
'jandroid'
)
wdreset=: 3 : 0
if. 1< #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
for_pa. |. WindowListHandle{::"1 windowList do.
  jniCheck pa ('finish ()V;' jniMethod)~ ''
end.
cleanup''
)

wdclipcopy=: 3 : 0
if. 0= #args=. shiftargs'' do. txt=. ''
elseif. 1= #args do. txt=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
jniCheck clipboard=. (ctx=. getjactivity_ja_ cWindow) ('getSystemService (LString;)LObject;' jniMethod)~ <'clipboard'
if. APILEVEL_ja_ < 11 do.
  jniCheck clipboard ('setText (LCharSequence;)V' jniMethod)~ <txt
  jniCheck DeleteLocalRef <clipboard
else.
  jniCheck clip=. 'android.content.ClipData' ('newPlainText (LCharSequence;LCharSequence;)Landroid/content/ClipData;' jniStaticMethod)~ 'text label';txt
  jniCheck clipboard ('setPrimaryClip (Landroid/content/ClipData;)V' jniMethod)~ clip
  jniCheck DeleteLocalRef"0 clipboard;clip
end.
if. 0=cWindow do. jniCheck DeleteLocalRef <ctx end.
)

wdclippaste=: 3 : 0
if. 0= #args=. shiftargs'' do. ax=. ,'0'
elseif. 1= #args do. ax=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum ax do. seterr 'bad number : ' return. end.
if. -. 0 1 2 e.~ ty=. <. {.@(0&".) ax do. seterr 'bad number : ' return. end.
txt=. ''
jniCheck clipboard=. (ctx=. getjactivity_ja_ cWindow) ('getSystemService (LString;)LObject;' jniMethod)~ <'clipboard'
if. APILEVEL_ja_ < 11 do.
  if. jniCheck clipboard ('hasText ()Z' jniMethod)~ '' do.
    jniCheck txt=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. clipboard ('getText ()LCharSequence;' jniMethod)~ ''
    jniCheck DeleteLocalRef"0 clipboard;ts;cs
  end.
else.
  if. jniCheck clipboard ('hasPrimaryClip ()Z' jniMethod)~ '' do.
    jniCheck txt=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. ctx ('coerceToText (LContext;)LCharSequence;' jniMethod) item=. 0 ('getItemAt (I)Landroid/content/ClipData$Item;' jniMethod) clip=. clipboard ('getPrimaryClip ()Landroid/content/ClipData;' jniMethod)~ ''
    jniCheck DeleteLocalRef"0 clipboard;clip;item;ts;cs
  end.
end.
if. 0=cWindow do. jniCheck DeleteLocalRef <ctx end.
txt
)

wdtimer=: 3 : 0
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum ax=. >@{.args do. seterr 'bad number : ' return. end.
if. 0 > delay=. <. {.@(0&".) ax do.seterr 'bad number : ' return. end.
timerdelay=: delay
)

return0=: 0:
return1=: 1:

form_evt=: 3 : 0
'widget event child'=. y
if. _1= ix=. windowlistidx widget do. return. end.
if. cWindow~:widget do.
  if. cRadio do. DeleteLocalRef <cRadio end.
  cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: widget
end.
'parentid locale'=. (WindowListId, WindowListLocale){ix{windowList
syshandler=. parentid, '_handler'
sysevent=. parentid, ((child-.@-:'')#'_', child), '_', event
sysdefault=. parentid, '_default'
sysparent=. parentid
syschild=. child
systype=. event
syslocalep=. locale
syslocalec=. ''
syshwndp=. ":widget
syshwndc=. ":cChild
if. ''-: sysfocus=. getcchildid ::(''"_) w=. gtk_window_get_focus widget do.
  if. 0~: w do.
    sysfocus=. getcchildid ::(''"_) gtk_widget_get_parent w
  end.
end.
syslastfocus=. ''
wdd=. ;: 'syshandler sysevent sysdefault sysparent syschild systype syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers', (0<#sysdata)#' sysdata'
wddata=. ".&.>wdd
qdata=. 0 2$<''
for_ls. (widget = >{."1 childList)#childList do.
  qdata=. qdata, childevtdata 1 2 3{ls
end.
sysdata=: ''
wdqdata=: (wdd ,. wddata) , qdata
if. #locale do.
  if. (0: <: 18!:0) <locale do.
    if. 3= 4!:0 <fn=. 'wdhandler_',locale,'_' do.
      fn~ ''
    end.
  end.
end.
)

system_evt=: 3 : 0
'event handler'=. y
parentid=. 'sys'
syshandler=. parentid, '_handler'
sysevent=. parentid, '_', event
sysdefault=. parentid, '_default'
wdd=. ;: 'syshandler sysevent sysdefault'
wddata=. ".&.>wdd
qdata=. 0 2$<''
wdqdata=: (wdd ,. wddata) , qdata
if. 3= 4!:0 <fn=. handler, '_z_' do.
  fn~ ''
elseif. 3= 4!:0 <fn=. handler, '__' do.
  fn~ ''
end.
)

child_evt=: 4 : 0
eventcat=. x
'vie event'=. y
'view widget'=. 2{.vie
childdata=. 0 2$0
if. 0=eventcat do.
  if. 0&= #ls=. (widget = >1{"1 childList)#childList do. return. end.
  'pawin childid iclass'=. 0 2 3{ {.ls
  Activity MakeToast_ja_ 'event for: ', ":childid
  for_ls. (pawin = >{."1 childList)#childList do.
    childdata=. childdata, childevtdata 1 2 3{ls
  end.
elseif. 1=eventcat do.
  if. 0&= #ls=. (widget = >1{"1 menuList)#menuList do. return. end.
  'pawin childid'=. 0 2{ {.ls
elseif. 2=eventcat do.
  if. 0&= #ls=. (widget = >1{"1 toolbarList)#toolbarList do. return. end.
  'pawin childid'=. 0 2{ {.ls
elseif. do. assert. 0
end.
if. 0&= #pals=. (pawin = >{."1 windowList)#windowList do. return. end.
'parentid locale'=. (WindowListId, WindowListLocale){ {.pals
syslocalec=. ''
if. 0=eventcat do.
  if. _1~: ix=. getcchildidx widget do.
    if. #subform=. (<ix,ChildListSubform){::childList do. parentid=. subform end.
    syslocalec=. (<ix,ChildListLocalec){::childList
  end.
end.
syshandler=. parentid, '_handler'
sysevent=. parentid, '_', childid, '_', event
sysdefault=. parentid, '_default'
sysparent=. parentid
syschild=. childid
systype=. event
syslocalep=. locale
syshwndp=. ":pawin
syshwndc=. ":widget
sysfocus=. ''
syslastfocus=. ''
wdd=. ;: 'syshandler sysevent sysdefault sysparent syschild systype syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers', (0<#sysdata)#' sysdata'
wdqdata=: (wdd ,. ".&.>wdd) , childdata
sysdata=: ''
locale=. (''-:syslocalec){::syslocalec;syslocalep
if. #locale do.
  if. (0: <: 18!:0) <locale do.
    if. 3= 4!:0 <fn=. 'wdhandler_',locale,'_' do.
      chgparent=. 0
      if. cWindow~:pawin do.
        chgparent=. 1
        oldcSubform=. cSubform [ oldcSetFont=. cSetFont [ oldcContainer=. cContainer [ oldcRadio=. cRadio [ oldcChild=. cChild [ oldcWindow=. cWindow
        cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: pawin
      end.
      fn~ ''
      if. chgparent do.
        cSubform=: oldcSubform [ cSetFont=: oldcSetFont [ cContainer=: oldcContainer [ cRadio=: oldcRadio [ cChild=: oldcChild [ cWindow=: oldcWindow
      end.
    end.
  end.
end.
)

childevtdata=: 3 : 0
'widget id iclass'=. y
wdd=. wddata=. 0$<''
view=. getchildwin widget
select. iclass
case. wdcl_spin ; wdcl_spinv do.
  wdd=. wdd, <id
  wddata=. wddata, < ": gtk_spin_button_get_value_as_int widget
fcase. wdcl_trackbar ; wdcl_trackbarv do.
case. wdcl_scrollbar ; wdcl_scrollbarv do.
  wdd=. wdd, <id
  wddata=. wddata, < ": <. gtk_range_get_value widget
case. wdcl_edit do.
  wdd=. wdd, <id
  jniCheck s=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. view ('getText ()LCharSequence;' jniMethod)~ ''
  jniCheck DeleteLocalRef"0 cs;ts
  wddata=. wddata, <s
case. wdcl_editm do.
  wdd=. wdd, <id
  jniCheck s=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. view ('getText ()LCharSequence;' jniMethod)~ ''
  jniCheck DeleteLocalRef"0 cs;ts
  wddata=. wddata, <s
  wdd=. wdd, <id, '_select'
  wddata=. wddata, < ": 0 0
  wdd=. wdd, <id, '_scroll'
  wddata=. wddata, < ": 0 0
case. wdcl_checkbox ; wdcl_radiobutton do.
  wdd=. wdd, <id
  jniCheck ck=. view ('isChecked ()Z' jniMethod)~ ''
  wddata=. wddata, < ": ck
case. wdcl_combobox ; wdcl_combodrop ; wdcl_combolist do.
  jniCheck nsel=. view ('getSelectedItemPosition ()I' jniMethod)~ ''
  if. _1=nsel do.
    wdd=. wdd, <id
    wddata=. wddata, <''
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": _1
  else.
    jniCheck ch=. view ('getSelectedItem ()LObject;' jniMethod)~ ''
    jniCheck s=. jniToJString ch
    jniCheck DeleteLocalRef <ch
    wdd=. wdd, <id
    wddata=. wddata, <s
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": nsel
  end.
case. wdcl_listbox do.
  nsel=. 0$0 [ ssel=. 0$<''
  sp=. view ('getCheckedItemPositions ()Landroid/util/SparseBooleanArray;' jniMethod)~ ''
  jniCheck ncnt=. sp ('size ()I' jniMethod)~ ''
  for_i. i.ncnt do.
    jniCheck pos=. sp ('keyAt (I)I' jniMethod)~ i
    jniCheck sel=. sp ('valueAt (I)Z' jniMethod)~ i
    if. sel do.
      jniCheck ch=. view ('getItemAtPosition (I)LObject;' jniMethod)~ pos
      jniCheck s=. jniToJString ch
      jniCheck DeleteLocalRef <ch
      nsel=. nsel, pos
      ssel=. ssel, <s
    end.
  end.
  if. _0=#nsel do.
    wdd=. wdd, <id
    wddata=. wddata, <''
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": _1
  else.
    wdd=. wdd, <id
    wddata=. wddata, < }: ; ssel ,&.> <LF
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": nsel
  end.
  jniCheck DeleteLocalRef <sp
end.
assert. 1= (2:=(3!:0))&> wdd
assert. 1= (2:=(3!:0))&> wddata
jniCheck DeleteLocalRef <view
wdd ,. wddata
)

window_configure=: 3 : 0
'widget event data'=. y
if. _1= ix=. windowlistidx widget do. 0 return. end.
wh=. _2{. getGdkEventConfigure_xywh event
wh0=. (<ix, WindowListWh0) {:: windowList
if. (2=GTKVER_j_) +. wh -.@-: wh1=. (<ix, WindowListWh1) {:: windowList do.
  windowList=: (<wh) (<ix, WindowListWh1) } windowList
  (wh,wh0) resizechild widget
end.
0
)

window_key_press=: 3 : 0
'widget event data'=. y
if. 0> ix=. windowlistidx widget do. 0 return. end.
'state key'=. gtkeventkey event
'ctrl j shift'=. 2 2 2 #: state
keyevent=. '' [ child=. ''
if. (GDK_Return = key) *. 0 = ctrl do.
  if. _1= getcchildidx w=. gtk_window_get_focus widget do.
    if. _1= getcchildidx w=. gtk_widget_get_parent w do.
      if. 0~: but=. (<ix, WindowListDefpushbutton){::windowList do.
        1 [ 0 child_evt but ; 'button' return.
      end.
      keyevent=. 'enter'
    end.
  end.
elseif. (GDK_Escape = key) *. 0=ctrl do. keyevent=. 'cancel'
elseif. key e. GDK_FKeys do.
  keyevent=. 'fkey'
  child=. ('f',":(>: key - GDK_F1)),(ctrl#'ctrl'),(shift#'shift')
elseif. (key e. GDK_a + i.26) *. 1=ctrl do.
  keyevent=. 'fkey'
  child=. (key{a.),(ctrl#'ctrl')
elseif. (key e. GDK_A + i.26) *. 1=ctrl do.
  keyevent=. 'fkey'
  child=. (((a.i.'a')+(key - GDK_A)){a.),(ctrl#'ctrl'),'shift'
end.
if. #keyevent do.
  sysdata=: key
  sysmodifiers=: ,":shift+2*ctrl
  1 [ form_evt widget ; keyevent ; child
end.
0
)

window_focus_in=: 3 : 0
'widget event data'=. y
activeidx=: ~. activeidx, widget
0
)

window_delete=: 3 : 0
'widget event data'=. y
if. _1= ix=. windowlistidx widget do. 0 return. end.
if. 0= gtk_widget_get_sensitive widget do. 1 return. end.
if. 1= (<ix, WindowListCloseok) {:: windowList do. 0 return. end.
form_evt widget ; 'close' ; ''
1
)

wdstart=: 3 : 0
assert. 0~:y
if. Activity do. DeleteGlobalRef <Activity end.
jniCheck Activity=: NewGlobalRef <y
)

wddestroy=: 3 : 0
widget=. y
if. _1~: ix=. windowlistidx widget do.
  if. 0~: tbimg=. (<ix, WindowListTbimg) {:: windowList do. g_object_unref tbimg end.
  windowList=: (<<<ix){windowList
end.
if. 1 e. ix=. (widget = (>{."1 containerList)) do. containerList=: (-.ix)#containerList end.
if. 1 e. ix=. (widget = (>{."1 subformList)) do. subformList=: (-.ix)#subformList end.
if. 1 e. ix=. (widget = (>{."1 childList)) do. childList=: (-.ix)#childList end.
if. 1 e. ix=. (widget = (>{."1 menuList)) do. menuList=: (-.ix)#menuList end.
if. 1 e. ix=. (widget = (>{."1 toolbarList)) do. toolbarList=: (-.ix)#toolbarList end.
if. 1 e. ix=. (widget = (>{."1 statusbarList)) do. statusbarList=: (-.ix)#statusbarList end.
activeidx=: activeidx -. widget
DeleteGlobalRef <widget
if. 0=#windowList do.
  cleanup''
else.
  if. widget=cWindow do.
    cWindow=: {:activeidx
    if. cRadio do. DeleteGlobalRef <cRadio end.
    cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0
    if. widget = Activity do. Activity=: 0 end.
  end.
end.
0
)

combobox_changed=: 3 : 0
'widget data'=. y
if. disable_toggle_event do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0 child_evt widget ; 'select'
0
)

listbox_changed=: 3 : 0
'widget data'=. y
if. disable_toggle_event do. 0 return. end.
if. 0= widget=. gtk_tree_selection_get_tree_view widget do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0 child_evt widget ; 'select'
0
)

listbox_activated=: 3 : 0
'widget path column data'=. y
if. disable_toggle_event do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0 child_evt widget ; 'button'
0
)

button_toggled=: 3 : 0
'widget data'=. y
if. disable_toggle_event do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0 child_evt widget ; 'button'
0
)

spin_change=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0
)

trackbar_change=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0
)

scrollbar_change=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0
)

listbox_onItemClick=: 3 : 0
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
0 child_evt (parent,widget) ; 'select'
jniCheck DeleteLocalRef <parent
0
)

listbox_onItemSelected=: 3 : 0
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
0 child_evt (parent,widget) ; 'select'
jniCheck DeleteLocalRef <parent
0
)

listbox_onNothingSelected=: 3 : 0
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
0 child_evt (parent,widget) ; 'select'
jniCheck DeleteLocalRef <parent
0
)

button_onClick=: 3 : 0
jniCheck view=. GetObjectArrayElement (3{y);0
jniCheck widget=. view ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
if. disable_toggle_event do. 0 [ jniCheck DeleteLocalRef <view return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
0 child_evt (view,widget) ; 'button'
jniCheck DeleteLocalRef <view
0
)
fixed1_onLayout=: 3 : 0
jniCheck changed=. '' ('booleanValue ()Z' jniMethod) ochanged=. GetObjectArrayElement (3{y);0
DeleteLocalRef <changed
if. 0=changed do. 0 return. end.
jniCheck h=. (2{y) ('getHeight ()I' jniMethod)~ ''
jniCheck w=. (2{y) ('getWidth ()I' jniMethod)~ ''
wh=. w,h
assert. 0~:cWindow
ix=. windowlistidx cWindow
assert. _1~:ix
fixed1=. 2{y
wh0=. (<ix, WindowListWh0) {:: windowList
windowList=: (<wh) (<ix, WindowListWh1) } windowList
(wh,wh0) resizechild cWindow, fixed1
DeleteLocalRef <fixed1
0
)

isigraph_onDraw=: 3 : 0
0
)

edit_key_press=: 3 : 0
'widget event data'=. y
if. widget -.@e. ls=. >1{"1 childList do. 0 return. end.
'state key'=. gtkeventkey event
'ctrl j shift'=. 2 2 2 #: state
if. (GDK_Return = key) *. 0 = ctrl do.
  sysdata=: key
  sysmodifiers=: ,":shift+2*ctrl
  0 child_evt widget ; 'button'
  1 return.
end.
0
)

menu_activate_event=: 3 : 0
'widget data'=. y
if. widget -.@e. ls=. >1{"1 menuList do. 0 return. end.
ix=. ls i. widget
if. 1= revertmenu=. (<ix ,3){::menuList do.
  menuList=: (<0) (<ix ,3)}menuList
else.
  menuList=: (<1) (<ix ,3)}menuList
  gtk_check_menu_item_set_active widget, -. gtk_check_menu_item_get_active widget
  1 child_evt widget ; 'button'
end.
0
)

toolbar_clicked_event=: 3 : 0
'widget data'=. y
if. widget -.@e. ls=. >1{"1 toolbarList do. 0 return. end.
2 child_evt widget ; 'button'
0
)

gtkwidget_event=: 4 : 0
assert. 'jglcanvas' -: >@{.x
l=. 1{x
widget=. canvas__l
evt=. >@{.y
if. 1=#y do.
  0 child_evt widget ; evt
elseif. 2=#y do.
  sysdata=: ": >1{y
  0 child_evt widget ; evt
elseif. 3=#y do.
  sysdata=: ": >1{y
  sysmodifiers=: ": >2{y
  0 child_evt widget ; evt
end.
0
)

timer_event=: 3 : 0
system_evt 'timer';'sys_timer'
0~:systimerid
)

wdstart_z_=: wdstart_droidwd_
wddestroy_z_=: wddestroy_droidwd_
wdfontdef=: 3 : 0
if. 0= #args=. shiftargs'' do. seterr 'bad font name : ' return. end.
cFontdef=: '"' -.~ }. ;' ',&.> args
)
wdsetfont=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
if. 1[ 0=WDERRN do.
  fd=. pango_font_description_from_string < '"' -.~ }. ;' ',&.> }.args
  gtk_widget_modify_font window, fd
  pango_font_description_free fd
end.
)
getfontspec=: 3 : 0
if. 0= #args=. y do. seterr 'bad font name : ' return.
elseif. 2> #args do. seterr 'bad number : ' return.
elseif. 7< #args do. seterr 'extra parameter : ' return.
end.
font=. >@{.args
if. -.@isnum asize=. 1{::args do. seterr 'bad number : ' return. end.
'style angle'=. 0 0
for_s1. 2}.args do.
  s=. >s1
  if. s1 e. <'default' do. continue.
  elseif. s1 e. 'italic' ; 'bold' ; 'underline' do. style=. style (23 b.) <. 2 ^ (<s) i.~ 'italic' ; 'bold' ; 'underline'
  elseif. 'angle'-:5{.s do. if. isnum 5}.s do. angle=. <. {.@(0&".) 5}.s else. seterr 'bad style : ' return. end.
  elseif. do. seterr 'bad style : ' return.
  end.
end.
font ; (0&". asize) ; style ; angle
)
wdmbfont=: 3 : 0
f=. ''
if. 0< #args=. shiftargs'' do.
  f=. getfontspec args
  if. 0~:WDERRN do. return. end.
end.
if. #f do.
  fontdialog ''; (>@{.f),' ', (": >1{f)
else.
  fontdialog '';''
end.
)
wdmb=: 3 : 0
args=. shiftargs''
title=. >@{.args
txt=. >@{.}.args
if. 2< #args do.
  styles=. 2}.args
else.
  styles=. 0$<''
end.
if. (<'mb_yesno') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_YES ; GTK_RESPONSE_YES ; GTK_STOCK_NO ; GTK_RESPONSE_NO ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_NO
  end.
elseif. (<'mb_yesnocancel') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_YES ; GTK_RESPONSE_YES ; GTK_STOCK_NO ; GTK_RESPONSE_NO ; GTK_STOCK_CANCEL ; GTK_RESPONSE_CANCEL ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_NO
  elseif. (<'mb_defbutton3') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_CANCEL
  end.
elseif. (<'mb_okcancel') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_OK ; GTK_RESPONSE_OK ; GTK_STOCK_CANCEL ; GTK_RESPONSE_CANCEL ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_CANCEL
  end.
elseif. (<'mb_yesnocancel') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_YES ; GTK_RESPONSE_YES ; GTK_STOCK_NO ; GTK_RESPONSE_NO ; GTK_STOCK_CANCEL ; GTK_RESPONSE_CANCEL ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_NO
  elseif. (<'mb_defbutton3') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_CANCEL
  end.
elseif. (<'mb_retrycancel') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; 'Retry' ; 2 ; GTK_STOCK_CANCEL ; GTK_RESPONSE_CANCEL ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_CANEL
  end.
elseif. (<'mb_arbortretryignore') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; 'Abort' ; 1 ; 'Retry' ; 2 ; 'Ignore' ; 3 ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, 2
  elseif. (<'mb_defbutton3') e. styles do.
    gtk_dialog_set_default_response dialog, 3
  end.
elseif. do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_OK ; GTK_RESPONSE_OK ; 0
end.

hbox=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_hbox_get_type '') ; 'border-width' ; 8 ;< 0

gtk_box_pack_start (gtk_dialog_get_content_area dialog), hbox, 0, 0, 0
if. +./ (<;._1 ' mb_iconasterisk mb_iconhand mb_iconinformation') e. styles do.
  stock=. gtk_image_new_from_stock GTK_STOCK_DIALOG_INFO ;< GTK_ICON_SIZE_DIALOG
  gtk_box_pack_start hbox, stock, 0, 0, 0
elseif. (<'mb_iconquestion') e. styles do.
  stock=. gtk_image_new_from_stock GTK_STOCK_DIALOG_QUESTION ;< GTK_ICON_SIZE_DIALOG
  gtk_box_pack_start hbox, stock, 0, 0, 0
elseif. (<'mb_iconexclamation') e. styles do.
  stock=. gtk_image_new_from_stock GTK_STOCK_DIALOG_WARNING ;< GTK_ICON_SIZE_DIALOG
  gtk_box_pack_start hbox, stock, 0, 0, 0
elseif. (<'mb_iconstop') e. styles do.
  stock=. gtk_image_new_from_stock GTK_STOCK_STOP ;< GTK_ICON_SIZE_DIALOG
  gtk_box_pack_start hbox, stock, 0, 0, 0
end.
lb=. gtk_label_new <txt
gtk_label_set_line_wrap lb, 1
gtk_box_pack_start hbox, lb, 1, 1, 0
gtk_widget_show_all hbox
result=. gtk_dialog_run dialog
gtk_widget_destroy dialog
>('CANCEL' ; 'CANCEL' ; 'CANCEL' ; 'OK' ; 'YES' ; 'NO' ; 'ABORT' ; 'RETRY' ; 'IGNORE'){~result i.~ GTK_RESPONSE_DELETE_EVENT, GTK_RESPONSE_NONE, GTK_RESPONSE_CANCEL, GTK_RESPONSE_OK, GTK_RESPONSE_YES, GTK_RESPONSE_NO, 1 2 3
)
wdmbopen=: mbopensave bind 0
wdmbsave=: mbopensave bind 2
mbopensave=: 3 : 0
args=. shiftargs''
title=. >@{.args
dir=. dltb >@{.}.args
fil=. dltb >@{.2}.args
filter=. dltb >@{.3}.args
ofn_style=. <;._1 ' ofn_createprompt ofn_filemustexist ofn_nochangedir ofn_overwriteprompt ofn_pathmustexist'
if. 4 <#args do.
  for_a. 4}.args do.
    if. a -.@e. ofn_style do. seterr 'bad style : ' return. end.
  end.
end.
path=. dir, ('/'#~(0<#dir)*.0<#fil), fil
if. #filter do.
  if. 0=2| +/ '|'=filter do. seterr 'bad filter : ' return. end.
  pattern=. |. L: 1 [ _2<\ <;._1 '|',filter
else.
  pattern=. ''
end.
cWindow filechooser_jgtk_ y ; title ; pattern ; path
)
wdmenu=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 5< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. 0{::args do. seterr 'bad id : ' return. end.
txt=. 1{::args,5#<''
shortcut=. 2{::args,5#<''
statushelp=. 3{::args,5#<''
tooltip=. 4{::args,5#<''
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  mn=. (handle i. cWindow){ >WindowListMenubar{"1 windowList
  acl=. (handle i. cWindow){ >WindowListAccel{"1 windowList
else.
  assert. 0
end.
if. 0= {.mn do. mn=. , createmenubar cWindow end.
if. '&' e. txt do.
  window=. gtk_check_menu_item_new_with_mnemonic <'&_'&charsub txt
else.
  window=. gtk_check_menu_item_new_with_label <txt
end.
if. '' -.@-: tooltip do.
  gtk_widget_set_tooltip_text window ; tooltip
end.
if. '' -.@-: shortcut do.
  shortcut=. toupper shortcut
  if. '+' e. shortcut do.
    ks=. <;._1 '+', shortcut
    shortcut=. (_1{::ks) ,~ ; ('<') ,&.> (}:ks) ,&.> ('>')
  end.
  gtk_accelerator_parse shortcut ; (key=. ,_1) ;< (modifiers=. ,_1)
  key=. {.key [ modifiers=. {.modifiers
  if. gtk_accelerator_valid key ;< modifiers do.
    gtk_widget_add_accelerator window ; 'activate' ; acl ; key ; modifiers ;< GTK_ACCEL_VISIBLE (23 b.) GTK_ACCEL_LOCKED
  end.
end.
gtk_menu_shell_append ({:mn) ;< window
gtk_widget_show window
consig window ; 'activate' ; 'menu_activate_event'
windowList=: (<mn) (<(handle i. cWindow) ; WindowListMenubar) } windowList
menuList=: menuList, cWindow ; window ; id ; 0
)

wdmenupop=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. txt=. ''
elseif. 1< #args do. seterr 'extra parameter : ' return.
elseif. do. txt=. >@{.args
end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  mn=. (handle i. cWindow){ >WindowListMenubar{"1 windowList
else.
  assert. 0
end.
if. 0= {.mn do. mn=. , createmenubar cWindow end.
window=. gtk_menu_item_new_with_mnemonic <'&_'&charsub txt
gtk_menu_shell_append ({:mn) ;< window
gtk_widget_show window
submn=. gtk_menu_new ''
gtk_menu_item_set_submenu window, submn
mn=. mn , submn
windowList=: (<mn) (<(handle i. cWindow) ; WindowListMenubar) } windowList
)

wdmenupopz=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  mn=. (handle i. cWindow){ >WindowListMenubar{"1 windowList
else.
  assert. 0
end.
if. 1 < #mn do. mn=. }:mn end.
windowList=: (<mn) (<(handle i. cWindow) ; WindowListMenubar) } windowList
)

wdmenusep=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  mn=. (handle i. cWindow){ >WindowListMenubar{"1 windowList
else.
  assert. 0
end.
if. 0= {.mn do. mn=. , createmenubar cWindow end.
window=. gtk_separator_menu_item_new ''
gtk_menu_shell_append ({:mn) ;< window
gtk_widget_show window
windowList=: (<mn) (<(handle i. cWindow) ; WindowListMenubar) } windowList
)
createmenubar=: 3 : 0
cWindow=. y
vbox1=. gtk_bin_get_child cWindow
menubar1=. gtk_menu_bar_new ''
gtk_widget_show menubar1
gtk_box_pack_start vbox1, menubar1, 0, 0, 0
gtk_box_reorder_child vbox1, menubar1, 0
menubar1
)
wdcreategroup=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do.
  cSubform=: '' [ cContaineri=: _1 [ cContainer=: 0
else.
  if. 1< #args do. seterr 'extra parameter : ' return. end.
  id=. 0{::args
  if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
  if. 0= g_type_check_instance_is_a window, gtk_notebook_get_type '' do.
    seterr 'bad id : ' return.
  end.
  cContaineri=: _1 [ cContainer=: window
  containerList=: containerList, (cWindow ; window ; 0 0)
end.
)

wdpactive=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
)

wdpas=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 2> #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
if. 0~: cContainer do. return. end.
pasij=. <. {.@(0&".)&> args
return.
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
scroll=. (<'scroll') e. styles
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
  jniCheck view ('setOrientation (I)V' jniMethod)~ LinearLayout_VERTICAL_ja_
  jniCheck tbar=. activity jniNewObject 'LinearLayout LContext;'
  jniCheck tbar ('setId (I)V' jniMethod)~ tbaridn=: idn=. >:idn
  jniCheck tbar ('setOrientation (I)V' jniMethod)~ LinearLayout_HORIZONTAL_ja_
  jniCheck view ('addView (LView;)V' jniMethod)~ tbar
  if. scroll+.hscroll do.
    jniCheck scrollvw=. activity jniNewObject (hscroll#'Horizontal'),'ScrollView LContext;'
    jniCheck scrollvw ('setId (I)V' jniMethod)~ scrollvwidn=: idn=. >:idn
    if. hscroll do. jniCheck scrollvw ('setId (I)V' jniMethod)~ end.
    jniCheck view ('addView (LView;)V' jniMethod)~ scrollvw
    jniCheck fixed1=. activity jniOverride 'org.dykman.jn.android.widget.AbsoluteLayout LContext;' ; 'droidwd' ; 'fixed1' ; 'onLayout'
    jniCheck fixed1 ('setId (I)V' jniMethod)~ fixedidn=: idn=. >:idn
    jniCheck scrollvw ('addView (LView;)V' jniMethod)~ fixed1
  else.
    jniCheck fixed1=. activity jniOverride 'org.dykman.jn.android.widget.AbsoluteLayout LContext;' ; 'droidwd' ; 'fixed1' ; 'onLayout'
    jniCheck fixed1 ('setId (I)V' jniMethod)~ fixedidn=: idn=. >:idn
    jniCheck view ('addView (LView;)V' jniMethod)~ fixed1
    scrollvw=. 0
  end.
  jniCheck sbar=. activity jniNewObject 'LinearLayout LContext;'
  jniCheck sbar ('setId (I)V' jniMethod)~ sbaridn=: idn=. >:idn
  jniCheck sbar ('setOrientation (I)V' jniMethod)~ LinearLayout_HORIZONTAL_ja_
  jniCheck view ('addView (LView;)V' jniMethod)~ sbar

  jniCheck activity ('setContentView (LView;)V' jniMethod)~ view
  DeleteLocalRef"0 view;tbar;sbar;fixed1;scrollvw
else.
  if. 0= cWindow do. seterr 'no parent selected : ' return. end.
  assert. g_type_check_instance_is_a cContainer, gtk_notebook_get_type ''
  npage=. gtk_notebook_get_n_pages cContainer
  for_i. i.npage do.
    if. 0~: page=. gtk_notebook_get_nth_page cContainer, i do.
      if. 0~: g=. gtk_container_get_children page do.
        g_list_free g
      else.
        cContaineri=: i break.
      end.
    end.
  end.
  if. _1&= cContaineri do. seterr 'todomsg4 : ' return. end.
  if. 0&= fixed1=. gtk_notebook_get_nth_page cContainer, cContaineri do.
    seterr 'todomsg5 : ' return.
  end.
end.

if. 0= cContainer do.
  windowList=: windowList, activity ; id ; (jloc '') ; '' ; idn ; fixed1 ; cFontdef ; 0 ; (,0) ; (,0) ; 0 0 ; 0 ; 0 0 ; 0 ; 0 ; closeok
  cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: activity
else.
  cSubform=: id
  subformList=: subformList, (cWindow ; cContainer ; id ; fixed1)
end.
)

wdpcenter=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
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
wdpicon=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr'bad number : ' return.
elseif. 1= #args do. seterr'bad number : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
EMPTY return.
s=. 0{::args
ax=. 1{::args
if. 0= isnum ax do. seterr 'bad number : ' return. end.
if. (<tolower _4{.s) e. '.exe';'.dll' do. return. end.
gtk_window_set_icon_from_file cWindow ; s ; 0
)


wdpmove=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 4> #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 4< #args do. seterr 'extra parameter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> args
)

wdpmovex=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 4> #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 4< #args do. seterr 'extra parameter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> args
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
EMPTY return.
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
wdpshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0=#args=. shiftargs'' do. style=. 'sw_shownormal'
elseif. 1<#args do. seterr 'extra parameter : ' return.
elseif. do. style=. 0{::args
end.
select. style
case. 'sw_hide' do. gtk_widget_hide cWindow return.
case. 'sw_maximize' do. gtk_window_maximize cWindow
case. 'sw_minimize' do. gtk_window_iconify cWindow
case. 'sw_restore' do. gtk_window_present cWindow
case. 'sw_show' do. ''
case. 'sw_showmaximized' do. gtk_window_maximize cWindow
case. 'sw_showminimized' do. gtk_window_iconify cWindow
case. 'sw_showminnoactive' do. gtk_window_iconify cWindow
case. 'sw_showna' do. ''
case. 'sw_shownoactive' do. ''
case. 'sw_shownormal' do. ''
case. do. seterr 'bad style : ' return.
end.
if. (<style) e. ;:'sw_restore sw_show sw_shownormal sw_showmaximized sw_showminimized' do.
  if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
    activeidx=: ~. activeidx, cWindow
  else.
    assert. 0
  end.
end.
)

wdptop=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1< #args do. seterr 'extra parameter : ' return.
elseif. do. s=. 0{::args
end.
if. 0 e. isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
flag=. flag > TileWM
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
wd=: 3 : 0
z=. ''
wdptr0=: 0
while. #y do.
  if. 0<s1=. clws y do.
    wdptr0=: wdptr0 + s1
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
      z=. wd1 s1{.y
      wdptr0=: wdptr0 + 1 + s1
      y=. (1+s1)}. y continue.
    else.
      z=. wd1 y break.
    end.
  elseif. 1 e. s do.
    s1=. {.I.s
    z=. wd1 s1{.y
    wdptr0=: wdptr0 + 1 + s1
    y=. (1+s1)}. y continue.
  elseif. do.
    z=. wd1 y break.
  end.
end.
z
)

wd1=: 3 : 0
if. 0=#y do. '' return. end.
smoutput^:(1<Debugwd) y
wdptr=: 0 [ wdstr=: y
t=. EMPTY
if. (<'qer') -.@e.~ cmd=. shiftarg'' do. LASTCMD=: y [ WDERRN=: 0 end.
select. cmd
case. 'beep' do. wdbeep ''
case. 'cc' do. wdcc ''
case. 'clipcopy' do. wdclipcopy ''
case. 'clippaste' do. t=. wdclippaste ''
case. 'cn' do. wdcn ''
case. 'creategroup' do. wdcreategroup ''
case. 'fontdef' do. wdfontdef ''
case. 'mb' do. t=. wdmb ''
case. 'mbcolor' do. t=. ": 51$255
case. 'mbfont' do. t=. wdmbfont ''
case. 'mbopen' do. t=. wdmbopen ''
case. 'mbprinter' do. t=. wdmbprinter ''
case. 'mbsave' do. t=. wdmbsave ''
case. 'menu' do. wdmenu ''
case. 'menupop' do. wdmenupop ''
case. 'menupopz' do. wdmenupopz ''
case. 'menusep' do. wdmenusep ''
case. 'msgs' do. wdmsgs ''
case. 'pactive' do. wdpactive ''
case. 'pas' do. wdpas ''
case. 'pc' do. wdpc ''
case. 'pcenter' do. wdpcenter ''
case. 'pclose' do. wdpclose ''
case. 'pgroup' do. wdpgroup ''
case. 'picon' do. wdpicon ''
case. 'pmove' do. wdpmove ''
case. 'pmovex' do. wdpmovex ''
case. 'pn' do. wdpn ''
case. 'psel' do. wdpsel ''
case. 'pshow' do. wdpshow ''
case. 'ptop' do. wdptop ''
case. 'qchildxywh' do. t=. wdqchildxywh ''
case. 'qchildxywhx' do. t=. wdqchildxywhx ''
case. 'qcolor' do. t=. wdqcolor ''
case. 'qd' do. t=. wdqd ''
case. 'qer' do. t=. wdqer ''
case. 'qformx' do. t=. wdqformx ''
case. 'qhwndc' do. t=. wdqhwndc ''
case. 'qhwndp' do. t=. wdqhwndp ''
case. 'qiox' do. t=. wdqiox ''
case. 'qm' do. t=. wdqm ''
case. 'qp' do. t=. wdqp ''
case. 'qprinters' do. t=. wdqprinters ''
case. 'qpx' do. t=. wdqpx ''
case. 'qscreen' do. t=. wdqscreen ''
case. 'qwd' do. t=. wdqwd ''
case. 'rem' do. ''
case. 'reset' do. wdreset ''
case. 'sbar' do. wdsbar ''
case. 'sbarset' do. wdsbarset ''
case. 'sbarshow' do. wdsbarshow ''
case. 'set' do. wdset ''
case. 'setcaption' do. wdsetcaption ''
case. 'setdelete' do. wdsetdelete ''
case. 'setedit' do. wdsetedit ''
case. 'setenable' do. wdsetenable ''
case. 'setfocus' do. wdsetfocus ''
case. 'setfont' do. wdsetfont ''
case. 'setinsert' do. wdsetinsert ''
case. 'setinvalid' do. wdsetinvalid ''
case. 'setlimit' do. wdsetlimit ''
case. 'setlocale' do. wdsetlocale ''
case. 'setmodified' do. wdsetmodified ''
case. 'setreadonly' do. wdsetreadonly ''
case. 'setreplace' do. wdsetreplace ''
case. 'setscroll' do. wdsetscroll ''
case. 'setselect' do. wdsetselect ''
case. 'setshow' do. wdsetshow ''
case. 'setxywh' do. wdsetxywh ''
case. 'setxywhx' do. wdsetxywhx ''
case. 'tbar' do. wdtbar ''
case. 'tbarset' do. wdtbarset ''
case. 'tbarshow' do. wdtbarshow ''
case. 'timer' do. wdtimer ''
case. 'xywh' do. wdxywh ''
case. ,'q' do. t=. wdq ''
case. 'setwrap' do. wdsetwrap ''
case. ;:'setbkgnd' do. ''
case. ;:'smcolor smkeywords smsetlog' do. ''
case. 'sminputlog' do. t=. ''
case. ;:'oleget olegetlic oleinfo' do. t=. ''
case. ;:'oledlg oleenable oleid oleload olemethod olemethodx oleocx olerelease olesave oleset olesetlic' do. ''
case. ;:'qhinst qhwndx qkeystate qrtf' do. t=. ''
case. ;:'clipcopyx clippastex pcolor security setcolor setcolwidth setpclip setupdate settabstops tnomsgs wait' do. ''

case. do. seterr 'invalid command : '
end.
if. ((<'qer') -.@e.~ cmd) *. 0~:WDERRN do. 13!:8[3 end.
(EMPTY-:t){::t;''
)
wdsbar=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  if. 0~: {. sb=. (handle i. cWindow){ >WindowListStatusbar{"1 windowList do. seterr 'command failed : ' return. end.
else.
  assert. 0
end.
if. -.@isnum s=. >@{.args do. seterr 'bad number : ' return. end.
if. 0>: count=. {.@(0&".) s do. seterr 'bad number : ' return. end.
vbox1=. gtk_bin_get_child cWindow
sbarwin=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x *c x x')&cd ( gtk_hbox_get_type '') ; 'spacing' ; 2 ; 'visible' ; 0 ;< 0
gtk_widget_set_can_focus sbarwin, 0
gtk_widget_show sbarwin
for_i. i. count do.
  st=. gtk_statusbar_new ''
  gtk_widget_show st
  gtk_box_pack_start sbarwin, st, ((i=0){0 1), ((i=0){0 1), 0
end.
gtk_box_pack_end vbox1, sbarwin, 0, 0, 0
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  windowList=: (<sbarwin, count, 0) (<(handle i. cWindow) ; WindowListStatusbar) } windowList
else.
  assert. 0
end.
)
wdsbarset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 3< #args do. seterr 'extra parameter : ' return.
end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  if. 0= {. sb=. (handle i. cWindow){ >WindowListStatusbar{"1 windowList do. seterr 'command failed : ' return. end.
else.
  assert. 0
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. -.@isnum awidth=. 1{::args do. seterr 'bad number : ' return. end.
width=. {.@(0&".) awidth
txt=. >@{.2}.args
'sbarwin count next'=. 3{.sb
if. 0> width do.
  if. 1 e. ls=. (cWindow = >{."1 statusbarList) *. (2{"1 statusbarList) e. <id do.
    window=. 1{::({.I.ls){statusbarList
    msgid=. gtk_statusbar_push window ; 0 ;< txt
  else.
    seterr 'bad id : ' return.
  end.
else.
  if. count<:next do. seterr 'bad number : ' return. end.
  g=. gtk_container_get_children sbarwin
  window=. g_list_nth_data g, next
  gtk_statusbar_pop window, 0
  msgid=. gtk_statusbar_push window ; 0 ;< txt
  if. 0~:next do.
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd window ; 'width-request' ; (D2P width) ;< 0
  end.
  g_list_free g
  if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
    windowList=: (<sbarwin, count, >:next) (<(handle i. cWindow) ; WindowListStatusbar) } windowList
  else.
    assert. 0
  end.
  statusbarList=: statusbarList, cWindow ; window ; id
end.
)
wdsbarshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1< #args do. seterr 'extra parameter : ' return.
elseif. do. s=. >@{.args
end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  if. 0= sbarwin=. {. sb=. (handle i. cWindow){ >WindowListStatusbar{"1 windowList do. seterr 'command failed : ' return. end.
else.
  assert. 0
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd sbarwin ; 'visible' ; flag ;< 0
)
wdtbar=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs '' do. seterr 'bad filename : ' return.
elseif. 3< #args do. seterr 'extra parameter : ' return.
end.
fn=. >@{.args
count=. _1
if. 1< #args do.
  s=. 1{::args
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  count=. {.@(0&".) s
end.
style=. ''
if. 2< #args do.
  style=. 2{::args
  if. 'tbstyle_flat' -.@-: style do. seterr 'bad style : ' return. end.
end.
if. _1~: idx=. windowlistidx cWindow do.
  if. 0~: tbarwin=. WindowListToolbar{::idx{windowList do. seterr 'command failed : ' return. end.
  mn=. WindowListMenubar{:: idx{windowList
else.
  seterr 'no parent selected : ' return.
end.
if. 0~: tbimg=. (<idx, WindowListTbimg) {:: windowList do. seterr 'command failed : ' return. end.
if. 0~: pix=. gdk_pixbuf_new_from_file fn ;< 0 do.
  w=. gdk_pixbuf_get_width <pix
  h=. gdk_pixbuf_get_height <pix
  if. -. (0=16|w) do. seterr 'picture width not 16x : ' return. end.
  tbimg=. pix
  assert. 0~:tbimg
else.
  seterr 'wrong file type : ' return.
end.
tbarwin=. gtk_toolbar_new ''
gtk_widget_set_can_focus tbarwin, 0
((>libgobject), ' g_object_set ', gtkcv, 'n x *c x *c x x')&cd tbarwin ; 'visible' ; 0 ; 'toolbar-style' ; GTK_TOOLBAR_ICONS ;< 0
vbox1=. gtk_bin_get_child cWindow
gtk_box_pack_start vbox1, tbarwin, 0, 0, 0
gtk_box_reorder_child vbox1, tbarwin, (0={.mn){1 0
gtk_widget_show tbarwin
windowList=: (<tbimg) (<idx, WindowListTbimg) } windowList
windowList=: (<tbarwin) (<idx, WindowListToolbar) } windowList
)
wdtbarset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 3> #args do. seterr 'bad number : ' return.
elseif. 5< #args do. seterr 'extra parameter : ' return.
end.
if. _1~: idx=. windowlistidx cWindow do.
  if. 0= tbarwin=. WindowListToolbar{:: idx{windowList do. seterr 'no control bar : ' return. end.
else.
  seterr 'command3 failed : ' return.
end.
id=. >@{.args
if. 0 e. isnum&> 2{. }.args do. seterr 'bad number : ' return. end.
'index image'=. {.@(0&".)&> 2{. }.args
'statushelp tooltip'=. 2{. 3}.args
if. 0=#id do.
  window=. gtk_separator_tool_item_new ''
else.
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x x')&cd ( gtk_tool_button_get_type '') ;< 0
  if. '' -.@-: tooltip do.
    gtk_widget_set_tooltip_text window ; tooltip
  end.
  if. 0~:tbimg=. (<idx, WindowListTbimg){:: windowList do.
    w=. gdk_pixbuf_get_width <tbimg
    h=. gdk_pixbuf_get_height <tbimg
    if. w<16*image do. seterr 'picture too narrow : ' return. end.
    pix=. gdk_pixbuf_new_subpixbuf tbimg, (16*image), 0, 16, h

    icon=. gtk_image_new_from_pixbuf pix
    gtk_widget_show icon
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd window ; 'icon-widget' ; icon ;< 0
    g_object_unref <pix
  else.
    seterr 'command failed : ' return.
  end.
  consig window ; 'clicked' ; 'toolbar_clicked_event'
end.
gtk_toolbar_insert tbarwin, window, _1
gtk_widget_show window
if. 0~:#id do.
  toolbarList=: toolbarList, cWindow ; window ; id ; index ; image
end.
)
wdtbarshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. _1~: idx=. windowlistidx cWindow do.
  if. 0= tbarwin=. WindowListToolbar{:: idx{windowList do. seterr 'no control bar : ' return. end.
else.
  seterr 'no parent selected : ' return.
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd tbarwin ; 'visible' ; flag ;< 0
)
D2P=: +:
P2D=: <.@-:

isnum=: 3 : 0
if. '-_0123456789' e.~ {.y do.
  try.
    if. 0~:$$a=. ".y do.
      0
    else.
      1 4 8 e.~ (3!:0) a
    end.
  catch. 0 end.
else.
  0
end.
)
windowlistidx=: 3 : 0
window=. y
z=. _1
if. 0= #windowList do. z return. end.
if. window e. ls=. >WindowListHandle{"1 windowList do.
  z=. ls i. window
end.
z
)
dlws=: 3 : 0
y }.~ +/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)
clws=: 3 : 0
+/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)
shiftarg=: 3 : 0
if. (#wdstr) = wdptr=: wdptr + clws wdptr}. wdstr do. '' return. end.
y=. wdptr}.wdstr
b=. y e. ' '
a=. y e. '*'
q=. 2| +/\ y e. '"'
d=. 2| +/\ y e. DEL
b=. b *. -.q+.d
a=. a *. -.q+.d
if. 1={.a do.
  z=. }.y
  wdptr=: #wdstr
elseif. (1={.d)+.(1={.q) do.
  p2=. 1+ (}.y) i. {.y
  z=. }.p2{.y
  wdptr=: wdptr+ p2+1
elseif. 1 e. b do.
  p2=. {.I.b
  z=. p2{.y
  wdptr=: wdptr+ 1+p2
elseif. do.
  z=. y
  wdptr=: #wdstr
end.
<z
)
shiftargs=: 3 : 0
z=. 0$<''
while. wdptr < #wdstr do. z=. z, shiftarg'' end.
z
)

seterr=: 3 : 0
WDERR=: y [ WDERRN=: 3
smoutput^:(0<Debugwd) '**ERROR: ', y
smoutput^:(0<Debugwd) wdstr
if. 2<Debugwd do. 13!:8[3 end.
EMPTY
)
setbuttonimage=: 3 : 0
'window image s'=. y
if. ''-: s do. return. end.
if. _1&~: {. alloc=. getGtkWidgetAllocation image do.
  wh=. _2{. alloc
  'w h'=. 1 >. wh
else.
  if. _1&~: {. alloc=. getGtkWidgetAllocation window do.
    wh=. _2{. alloc
  else.
    wh=. _2{. getAllocation window
  end.
  'w h'=. 1 >. _12 _3 + wh
end.
if. 0~: pix=. gdk_pixbuf_new_from_file_at_size s ; w ; h ;< 0 do.
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd image ; 'pixbuf' ; pix ;< 0
  g_object_unref <pix
end.
)

getAllocation=: 3 : 0
widget=. y
_1 _1, w,h [ gtk_widget_get_size_request widget ; (w=. ,_1) ; (h=. ,_1)
)

delcchild=: 4 : 0
parent=. x
widget=. y
if. 0= #childList do. return. end.
childList=: (widget ~: >1{"1 childList)#childList
)
getcchild=: 4 : 0
parent=. x
id=. ,y
z=. 0
if. 0= #childList do. z return. end.
if. #winid=. (parent = >{."1 childList)#(1 2{"1 childList) do.
  z=. (0,~ >{."1 winid) {~ ((<id),~ {:"1 winid) i. <id
end.
z
)
getcchildid=: 3 : 0
widget=. y
if. _1= ix=. getcchildidx widget do. '' return. end.
2{:: ix{childList
)

getcchildclass=: 3 : 0
widget=. y
if. _1= ix=. getcchildidx widget do. _1 return. end.
3{:: ix{childList
)
getcchildidx=: 3 : 0
widget=. y
z=. _1
if. 0= #childList do. z return. end.
if. widget e. ls=. >1{"1 childList do.
  z=. ls i. widget
end.
z
)
getcparent=: 3 : 0
widget=. y
if. 0= #windowList do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0{:: ix{childList
)

getccontaineridx=: 3 : 0
widget=. y
z=. _1
if. 0= #containerList do. z return. end.
if. widget e. ls=. >1{"1 containerList do. z=. ls i. widget end.
z
:
getccontaineridx x getcchild y
)

getmenu=: 4 : 0
parent=. x
id=. y
if. 0= #menuList do. 0 return. end.
rz=. {. (>1{"1 menuList) #~ (parent = >{."1 menuList) *. ((<id) = 2{"1 menuList)
)

gettoolbar=: 4 : 0
parent=. x
id=. y
if. 0= #toolbarList do. 0 return. end.
rz=. {. (>1{"1 toolbarList) #~ (parent = >{."1 toolbarList) *. ((<id) = 2{"1 toolbarList)
)

getstatusbar=: 4 : 0
parent=. x
id=. y
if. 0= #statusbarList do. 0 return. end.
rz=. {. (>1{"1 statusbarList) #~ (parent = >{."1 statusbarList) *. ((<id) = 2{"1 statusbarList)
)

checkbadname=: 3 : 0
rz=. 1
if. ({.y) e. a.{~(65+i.26),(97+i.26) do.
  rz=. 0 e. (}.y) e. '0123456789', a.{~(65+i.26),(97+i.26)
end.
rz
)

getchildwh=: 3 : 0
widget=. y
jniCheck w=. widget ('getWidth ()I' jniMethod)~ ''
jniCheck h=. widget ('getHeight ()I' jniMethod)~ ''
w,h
)
getchildxy=: 3 : 0
wid=. y
xy=. 0 0
while. wid do.
  jniCheck x=. wid ('getLeft ()I' jniMethod)~ ''
  jniCheck y=. wid ('getTop ()I' jniMethod)~ ''
  xy=. xy + x,y
  jniCheck parent=. wid ('getParent ()Landroid/view/ViewParent;' jniMethod)~ ''
  if. parent do.
    if. fixedidn = jniCheck parent ('getId ()I' jniMethod)~ '' do. break. end.
    wid=. parent
  else.
    break.
  end.
end.
xy
)
getchildwin=: 3 : 0
assert. 0~:cWindow
jniCheck view=. cWindow ('findViewById (I)LView;' jniMethod)~ y
assert. 0~:view
view
)
getlocgl2=: 3 : 0
z=. 0$<''
if. 0= #windowList do. z return. end.
if. 0= #childList do. z return. end.
if. ({.y) e. '_0123456789' do.
  widget=. {. 0".y
else.
  widget=. cWindow getcchild y
end.
if. (#canvaslocale_jglcanvas_) > ix=. widget i.~ >{."1 canvaslocale_jglcanvas_ do.
  z=. (<ix,1){canvaslocale_jglcanvas_
end.
z
)
cleanup=: 3 : 0
wdqdata=: 0 0$0
WDERR=: ''
WDLOC=: 'base'
sysmodifiers=: ,'0'
sysdata=: ''
disable_toggle_event=: 0
lasterrcmd=: lastcmd=: ''
cWindow=: 0
cChild=: 0
cRadio=: 0
cContainer=: 0
cContaineri=: _1
cSubform=: ''
windowList=: 0 16$<''
containerList=: 0 3$<''
subformList=: 0 4$<''
childList=: 0 12$<''
menuList=: 0 4$<''
toolbarList=: 0 5$<''
statusbarList=: 0 3$<''
activeidx=: 0$0
cxywh=: 0 0 100 100
cFontdef=: ''
cSetFont=: ''
tbimg=: 0
if. 0~:systimerid do. systimerid=: 0 [ g_source_remove systimerid end.
systimerid=: timerdelay=: 0
)
setadapter=: 4 : 0
'activity view isspin multiselect'=. y
ar=. jniToStringarr x
jniCheck adapter=. 'ArrayAdapter LContext;I[LObject;' jniNewObject~ activity ; (isspin{ (multiselect{R_layout_simple_list_item_single_choice,R_layout_simple_list_item_multiple_choice), R_layout_simple_spinner_item) ; ar
if. isspin do.
  jniCheck adapter ('setDropDownViewResource (I)V' jniMethod)~ R_layout_simple_dropdown_item_1line
  jniCheck view ('setAdapter (LSpinnerAdapter;)V' jniMethod)~ adapter
else.
  jniCheck view ('setAdapter (LListAdapter;)V' jniMethod)~ adapter
  if. multiselect do.
    view ('setChoiceMode (I)V' jniMethod)~ CHOICE_MODE_MULTIPLE
  else.
    view ('setChoiceMode (I)V' jniMethod)~ CHOICE_MODE_SINGLE
  end.
end.
jniCheck DeleteLocalRef"0 ar;adapter
EMPTY
)

dp2px=: 3 : 0"0
if. y>0 do.
  <. 0.5+y*DM_density_ja_*2
else.
  y
end.
)

px2dp=: 3 : 0"0
if. y>0 do.
  <. 0.5+y%DM_density_ja_*2
else.
  y
end.
)

resizechild=: 4 : 0
'wh wh0'=. 1 >. 2 2$x
smoutput 'resizechild ', ":x
assert. 0~:y
'parent fixed1'=. y
assert. 0~:fixed1
'top bot lef rig'=. 4#0
pad0=. 0
fixed1wh=. wh=. 0 >. wh - (0,pad0) + 0>. (lef+rig),(top+bot)
minpad=. 0

chg=. 0
for_wx. ((0&~: >4{"1 childList) *. (0= >6{"1 childList) *. (parent = >{."1 childList))#childList do.
  'parent window id iclass stylen hide container subform xywh0 '=. 9{.wx
  'cx cy cw ch'=. 'cx0 cy0 cw0 ch0'=. xywh0
  ex=. ex0=. cx0 + cw0
  ey=. ey0=. cy0 + ch0
  W0=. {.wh0 [ H0=. {:wh0
  W=. {.wh [ H=. {:wh
  (FMSTYLE)=. |. (8#2) #: stylen
  if. leftmove do. cx=. cx0 + (W-W0) end.
  if. leftscale do. cx=. <. cx0 * W%W0 end.
  if. rightmove do. ex=. (W-minpad) <. (cx0+cw0) + (W-W0) end.
  if. rightscale do. ex=. (W-minpad) <. <. W - (W0 - cx0+cw0) * W%W0 end.

  if. topmove do. cy=. cy0 + (H-H0) end.
  if. topscale do. cy=. <. cy0 * H%H0 end.
  if. bottommove do. ey=. (H-minpad) <. (cy0+ch0) + (H-H0) end.
  if. bottomscale do. ey=. (H-minpad) <. <. H - (H0 - cy0+ch0) * H%H0 end.

  cw=. 0 >. ex - cx
  ch=. 0 >. ey - cy
  if. +./ 0 < | xywh0 - cx,cy,cw,ch do.
    win=. getchildwin window
    lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
    lp ('x I' jniField)~ <cx
    lp ('y I' jniField)~ <cy
    lp ('width I' jniField)~ <cw
    lp ('height I' jniField)~ <ch
  end.
end.
jniCheck fixed1 ('invalidate ()V' jniMethod)~ ''
ct=. 0$0
for_wx. ((0&~: >4{"1 childList) *. (0~: >6{"1 childList) *. (parent = >{."1 childList))#childList do.
  'parent window id iclass stylen hide container subform xywh0 '=. 9{.wx

  if. _1= ix=. getccontaineridx container do. continue. end.
  if. 1 e. f=. (container = >1{"1 subformList) *. (<subform) = 2{"1 subformList do.
    fixed1=. 3{:: ({.I.f){subformList
  else.
    continue.
  end.
  wh=. 0 >. fixed1wh <. _2{. getGtkWidgetAllocation fixed1
  wh0=. (<ix,2){::containerList
  ct=. ct, container
  (FMSTYLE)=. |. (8#2) #: stylen

  'cx cy cw ch'=. 'cx0 cy0 cw0 ch0'=. xywh0
  ex=. ex0=. cx0 + cw0
  ey=. ey0=. cy0 + ch0
  W0=. {.wh0 [ H0=. {:wh0
  W=. {.wh [ H=. {:wh

  if. leftmove do. cx=. cx0 + (W-W0) end.
  if. leftscale do. cx=. <. cx0 * W%W0 end.
  if. rightmove do. ex=. (W-minpad) <. (cx0+cw0) + (W-W0) end.
  if. rightscale do. ex=. (W-minpad) <. <. W - (W0 - cx0+cw0) * W%W0 end.

  if. topmove do. cy=. cy0 + (H-H0) end.
  if. topscale do. cy=. <. cy0 * H%H0 end.
  if. bottommove do. ey=. (H-minpad) <. (cy0+ch0) + (H-H0) end.
  if. bottomscale do. ey=. (H-minpad) <. <. H - (H0 - cy0+ch0) * H%H0 end.

  cw=. 0 >. ex - cx
  ch=. 0 >. ey - cy
  if. +./ 0 < | xywh0 - cx,cy,cw,ch do.
    win=. getchildwin window
    lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
    lp ('x I' jniField)~ <cx
    lp ('y I' jniField)~ <cy
    lp ('width I' jniField)~ <cw
    lp ('height I' jniField)~ <ch
  end.
end.
for_cti. ~.ct do.
  jniCheck cti ('invalidate ()V' jniMethod)~ ''
end.
)
18!:4 <'z'
wd_z_=: 3 : 0"1
wd_droidwd_ y [ WDLOC_droidwd_=: >coname''
)
wdactivity_z_=: 3 : 0
assert. 0~:y
if. Acitivity_droidwd_ do. DeleteGlobalRef <Acitivity_droidwd_ end.
jniCheck Acitivity_droidwd_=: NewGlobalRef <y
)
wdreset=: wd bind 'reset'
wdclipread=: toJ @ wd bind 'clippaste'
wdbox=: 3 : 0
whs=. 8 9 10 13 32{a.
del=. 127{a.
dat=. ' ',y
msk=. ~:/\ dat e. del
mqt=. 2: +./\ 0: , 2: | +/\ @ (=&'"')
mquote=. -. mqt dat
msk=. mquote *. msk
ndx=. 1 i.~ msk < dat='*'
end=. < }. ndx }. dat
dat=. ndx{.dat
msk=. mquote *.(ndx {. msk) < dat e. whs
dat=. (msk <;._1 dat) , end
a: -.~ dat -. each <del
)
wdcenter=: 3 : 0
'fx fy fw fh'=. 0&". :: ] y
'sx sy'=. sxy=. 2 {. 0 ". wd 'qm'
'w h'=. sxy <. _2 {. 0 ". wd 'qformx'
x=. 0 >. (sx-w) <. fx + <. -: fw-w
y=. 0 >. (sy-h) <. fy + <. -: fh-h
wd 'pmovex ',": x,y,w,h
)
wdclipwrite=: 3 : 0
txt=. y
if. L. txt do.
  txt=. }. ; (LF&, @ , @ ": each) txt
else.
  txt=. ": txt
  if. 1 < #$txt do. txt=. }. , LF,"1 txt end.
end.
wd 'clipcopy *',toHOST txt
#txt
)
wde=: 3 : 0
try. res=. wd y
catch.
  err=. wd 'qer'
  ndx=. >: err i. ':'
  msg=. ndx {. err
  pos=. {.". ndx }. err
  cmd=. (>:j i.';') {. j=. pos}.y
  if. 50 < #cmd do.
    cmd=. (47{.cmd),'...' end.
  wdinfo 'Window Driver';'wd error ',msg,LF,cmd
  wderr=. 13!:8@1:
  wderr ''
end.
)
wdfit=: 3 : 0

'mx my'=. 2{.y,(#y)}.1 1
'x y w h'=. 0 ". wd 'qformx'
'fx fy zx zy yc ym sx sy sw sh'=. 6 }. 0 ". wd 'qm'

select. mx
case. 0 do.
  w=. w - 0 <. sx - x
  x=. x >. sx
  w=. 0 >. w <. sx + sw - x
case. 1 do.
  x=. sx >. x <. (sx+sw) - w
  w=. 0 >. w <. sx + sw - x
case. 2 do.
  x=. sx
  w=. sw
case. 3 do.
  x=. - fx
  w=. sw + 2 * fx
end.

select. my
case. 0 do.
  h=. h - 0 <. sy - y
  y=. y >. sy
  h=. 0 >. h <. sy + sh - y
case. 1 do.
  y=. sy >. y <. (sy+sh) - h
  h=. 0 >. h <. sy + sh - y
case. 2 do.
  y=. sy
  h=. sh
case. 3 do.
  y=. - yc + fy
  h=. sh + yc + 2 * fy
end.

wd 'pmovex ',":x,y,w,h
)
wdforms=: 3 : 0
if. 0=# z=. <;._2;._2 @ wd 'qpx' do. z=. 0 6$<'' end.
z
)
wdget=: 4 : 0
nms=. {."1 y
vls=. {:"1 y
if. L. x do. vls {~ nms i. ,&.>x
else. > vls {~ nms i. <,x
end.
)

SYSPPC=: (<'syschild'),.'ppcnext';'ppcprevious'
wdhandler=: 3 : 0
wdq=: wd 'q'
wd_val=. {:"1 wdq
({."1 wdq)=: wd_val
if. 3=4!:0<'wdhandler_debug' do.
  try. wdhandler_debug'' catch. end.
end.
wd_ndx=. 1 i.~ 3 = 4!:0 [ 3 {. wd_val
if. 3 > wd_ndx do.
  wd_fn=. > wd_ndx { wd_val
  if. 13!:17'' do.
    wd_fn~''
  else.
    try. wd_fn~''
    catch.
      wd_err=. 13!:12''
      if. 0=4!:0 <'ERM_j_' do.
        wd_erm=. ERM_j_
        ERM_j_=: ''
        if. wd_erm -: wd_err do. i.0 0 return. end.
      end.
      wd_err=. LF,,LF,.}.;._2 wd_err
      wdinfo 'wdhandler';'error in: ',wd_fn,wd_err
    end.
  end.
end.
i.0 0
)
wdinfo=: 3 : 0
'a b'=. _2{. boxopen y
if. 0<Debugwd_droidwd_ do.
  smoutput b return.
end.
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
empty wd 'mb ',(f a),' ',(f b),' mb_iconinformation'
)
wdisparent=: boxopen e. <;._2 @ wd bind 'qp'
wdishandle=: boxopen e. 1: {"1 wdforms
wdmove=: 3 : 0
'' wdmove y
:
'px py'=. y
'sx sy sw sh'=. 12 13 14 15 { 0 ". wd 'qm'
if. #x do. wd 'psel ',x end.
'x y w h'=. 0 ". wd 'qformx'
if. px < 0 do. px=. sw - w - 1 + px end.
if. py < 0 do. py=. sh - h - 1 + py end.
wd 'pmovex ',": (px+sx),(py+sy),w,h
)
wdpclose=: [: wd :: empty 'psel ' , ,&';pclose'
wdqshow=: 3 : 0
txt=. (>{."1 wdq),.TAB,.>{:"1 wdq
wdinfo 'wdq';(60 <. {:$txt) {."1 txt
)
wdquery=: 3 : 0
0 wdquery y
:
msg=. ;:'okcancel retrycancel yesno yesnocancel abortretryignore'
res=. ;:'OK CANCEL RETRY YES NO ABORT IGNORE'
ndx=. 0 1;2 1;3 4;3 4 1;5 2 6
't d'=. 2{.x [ 'a b'=. _2{. boxopen y
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
m=. 'mb ',(f a),' ',(f b),' mb_iconquestion mb_',>t{msg
if. d e. 1 2 do. m=. m,' mb_defbutton',":>:d end.
(res {~ >t{ndx) i. <wd m
)
wdselect=: 3 : 0
0 wdselect y
:
if. 0=#y do.
  empty wd 'psel wdselect;pclose' return.
end.

'n s e'=. 3{.x

if. 2=L.y do. 'hdr sel'=. y
else. hdr=. '' [ sel=. y
end.

'r c'=. $,.>sel
sel=. ;sel ,each LF

'c r'=. (12,5*6>r) + >. 4 8 * >. c,r
c=. 205 <. 80 >. (4*#hdr) >. c
r=. 128 <. r

if. (<'wdselect') e. <;._2 wd 'qp' do.
  wd 'psel wdselect;pn '",hdr,'";'
else.
  wd 'pc wdselect;pn *',hdr
  wd 'xywh 4 4 ',":c,r
  wd 'cc l0 listbox ws_vscroll rightmove bottommove',s#' lbs_multiplesel'
  wd 'setfont l0 ',PROFONT
  wd 'cc e0 editm; setshow e0 0'
  wd 'xywh ',(":14+c),' 6 36 12;cc ok button leftmove rightmove bottommove;cn "OK";'
  wd 'xywh ',(":14+c),' 21 36 12;cc cancel button leftmove rightmove bottommove;cn "Cancel";'
  wd 'pas 4 2;pcenter;'
end.

wd 'set e0 *',sel
wd 'set l0 *',sel
wd (_1 ~: n) # 'setselect l0 ',":n
wd 'setfocus l0'
wd 'pshow'

while. 1 do.
  wdq=. wd 'wait;q'
  ({."1 wdq)=. {:"1 wdq
  done=. (<'cancel') e. systype;syschild
  button=. systype -: 'button'
  ok=. button *. (<syschild) e. ;:'l0 ok enter'
  if. ok +. done do.
    wd (ok *: e)#'pclose'
    ok;".l0_select
    break.
  end.
end.
)
wdstatus=: 3 : 0
'' wdstatus y
:
if. 0 e. $y do.
  empty wd :: [ 'psel status;pclose'
  return.
end.

msg=. y
if. 2=#$msg=. ":msg do. msg=. }.,LF,.msg
else. msg=. toJ (-LF={:msg)}.msg
end.

pn=. (*#x)#'pn ',DEL,x,DEL,';'

if. (<'status') e. <;._2 wd 'qp;' do.
  wd 'psel status;',pn
else.
  size=. |. 0 100 >. 8 4*$];._2 msg,LF
  wd 'pc status closeok;',pn
  wd 'xywh 10 10 ',(":size),';'
  wd 'cc s0 static;'
  wd 'pas 10 10;pcenter;'
end.

wd 'set s0 *',msg
wd 'pshow;'
)
mbopen=: 3 : 0
jpathsep wd 8 u: 'mbopen ',y
)
mbsave=: 3 : 0
jpathsep wd 8 u: 'mbsave ',y
)
