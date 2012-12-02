require 'gui/android gl2'

3 : 0''
if. 0~: 4!:0 <'IFJAVA_z_' do. IFJAVA_z_=: 0 end.
if. 0~: 4!:0 <'IFWINCE_z_' do. IFWINCE_z_=: 0 end.
if. 0~: 4!:0 <'FIXFONT_z_' do. FIXFONT_z_=: FIXFONT_jgl2_ end.
if. 0~: 4!:0 <'PROFONT_z_' do. PROFONT_z_=: PROFONT_jgl2_ end.
if. 0~: 4!:0 <'gtkInitDone_jgtk_' do. gtkInitDone_jgtk_=: 0 end.
''
)

coclass 'droidwd'
coinsert 'jni jaresu'

wantstatusbar=: 0
barsheight=: 12

jniImport ::0: (0 : 0)
android.app.AlertDialog
android.app.AlertDialog$Builder
android.content.Context
android.content.DialogInterface$OnClickListener
android.graphics.Bitmap
android.graphics.BitmapFactory
android.graphics.Bitmap$Config
android.graphics.Typeface
android.graphics.drawable.BitmapDrawable
android.graphics.drawable.Drawable
android.media.MediaPlayer
android.media.ToneGenerator
android.net.Uri
android.text.method.KeyListener
android.text.method.MovementMethod
android.text.method.ScrollingMovementMethod
android.util.AttributeSet
android.view.ContextMenu
android.view.Display
android.view.Menu
android.view.MenuItem
android.view.MenuItem$OnMenuItemClickListener
android.view.SubMenu
android.view.View
android.view.View$OnClickListener
android.view.ViewGroup
android.view.ViewParent
android.view.WindowManager
android.webkit.WebSettings
android.webkit.WebView
android.webkit.WebViewClient
android.widget.AbsListView
android.widget.AbsoluteLayout
android.widget.AbsoluteLayout$LayoutParams
android.widget.AdapterView$OnItemClickListener
android.widget.AdapterView$OnItemLongClickListener
android.widget.AdapterView$OnItemSelectedListener
android.widget.AnalogClock
android.widget.ArrayAdapter
android.widget.Button
android.widget.CheckBox
android.widget.DatePicker
android.widget.DigitalClock
android.widget.EditText
android.widget.FrameLayout
android.widget.FrameLayout$LayoutParams
android.widget.Gallery
android.widget.HorizontalScrollView
android.widget.ImageButton
android.widget.ImageView
android.widget.LinearLayout
android.widget.LinearLayout$LayoutParams
android.widget.ListAdapter
android.widget.ListView
android.widget.ProgressBar
android.widget.RadioButton
android.widget.RadioGroup
android.widget.RelativeLayout
android.widget.RelativeLayout$LayoutParams
android.widget.ScrollView
android.widget.Scroller
android.widget.SeekBar
android.widget.SeekBar$OnSeekBarChangeListener
android.widget.Spinner
android.widget.SpinnerAdapter
android.widget.TabHost
android.widget.TabHost$OnTabChangeListener
android.widget.TabHost$TabContentFactory
android.widget.TabHost$TabSpec
android.widget.TabWidget
android.widget.TableLayout
android.widget.TableLayout$LayoutParams
android.widget.TableRow
android.widget.TextView
android.widget.TextView$OnEditorActionListener
android.widget.TimePicker
android.widget.VideoView
)

wdqdata=: 0 0$0

Debugwd=: 0
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
listbox_evtdata=: ''

lasterrcmd=: lastcmd=: ''
cWindow=: 0
cChild=: 0
cRadio=: 0
cContainer=: 0
cSubform=: ''
windowList=: 0 18$<''
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
WindowListMenuPending=: 16
WindowListMenuCreated=: 17

containerList=: 0 3$<''
subformList=: 0 4$<''
childList=: 0 12$<''
ChildListContainer=: 6
ChildListSubform=: 7
ChildListWywh0=: 8
ChildListHide=: 9
ChildListLocalec=: 10
ChildListUserdata=: 11

menuList=: 0 5$<''
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
  jniCheck button_click_listener=: NewGlobalRef < a1=. '' jniOverride 'org.dykman.jn.android.view.View$OnClickListener' ; 'droidwd' ; 'button'
  jniCheck combobox_select_listener=: NewGlobalRef < a2=. '' jniOverride 'org.dykman.jn.android.widget.AdapterView$OnItemSelectedListener' ; 'droidwd' ; 'combobox'
  jniCheck listbox_click_listener=: NewGlobalRef < a3=. '' jniOverride 'org.dykman.jn.android.widget.AdapterView$OnItemClickListener' ; 'droidwd' ; 'listbox'
  jniCheck listbox_longclick_listener=: NewGlobalRef < a4=. '' jniOverride 'org.dykman.jn.android.widget.AdapterView$OnItemLongClickListener' ; 'droidwd' ; 'listbox'
  jniCheck tabcreator=: NewGlobalRef < a5=. '' jniOverride 'org.dykman.jn.android.widget.TabHost$TabContentFactory' ; 'droidwd' ; 'tab'
  jniCheck tab_changed_listener=: NewGlobalRef < a6=. '' jniOverride 'org.dykman.jn.android.widget.TabHost$OnTabChangeListener' ; 'droidwd' ; 'tab'
  jniCheck seekbar_changed_listener=: NewGlobalRef < a7=. '' jniOverride 'org.dykman.jn.android.widget.SeekBar$OnSeekBarChangeListener' ; 'droidwd' ; 'seekbar'
  jniCheck alertdialog0_listener=: NewGlobalRef < a8=. '' jniOverride 'org.dykman.jn.android.content.DialogInterface$OnClickListener' ; 'droidwd' ; 'alertdialog0'
  jniCheck alertdialog_listener=: NewGlobalRef < a9=. '' jniOverride 'org.dykman.jn.android.content.DialogInterface$OnClickListener' ; 'droidwd' ; 'alertdialog'
  jniCheck editor_action_listener=: NewGlobalRef < a10=. '' jniOverride 'org.dykman.jn.android.widget.TextView$OnEditorActionListener' ; 'droidwd' ; 'edit'

  jniCheck DeleteLocalRef"0 a1;a2;a3;a4;a5;a6;a7;a8;a9;a10
  wdlisteners=: button_click_listener, combobox_select_listener, listbox_click_listener, listbox_longclick_listener, tabcreator, tab_changed_listener, seekbar_changed_listener, alertdialog0_listener, alertdialog_listener, editor_action_listener
  JACT=: getjactivity_ja_ 0
  assert. 0~:JACT
else.
  jniCheck JACT ('setjtimer (IILString;)V' jniMethod)~ 10;0;''
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
    jniCheck win ('setInputType (I)V' jniMethod)~ 0
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
    jniCheck cRadio ('setOrientation (I)V' jniMethod)~ (<'bs_lefttext') -.@e. styles
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
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 8
case. wdcl_tab do.
  tableft=. (<'tcs_left') e. styles
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
  jniCheck win ('setOnSeekBarChangeListener (LSeekBar$OnSeekBarChangeListener;)V' jniMethod)~ seekbar_changed_listener
case. wdcl_trackbarv do.
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 8
case. do.
  win seterr 'bad class : ' return.
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
  jniCheck cRadio ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck DeleteLocalRef <lp
elseif. iclass ~: wdcl_radiobutton do.
  lpclass=. 'AbsoluteLayout$LayoutParams'
  if. iclass e. wdcl_edit, wdcl_combobox, wdcl_combodrop, wdcl_combolist do.
    jniCheck lp=. (lpclass, ' IIII') jniNewObject~ <"0 dpw2px 2|. WRAP_CONTENT (3)}cxywh1
  else.
    jniCheck lp=. (lpclass, ' IIII') jniNewObject~ <"0 dpw2px 2|.cxywh1
  end.
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
wdrm=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
if. _1= ix=. getcchildidx window do. 0 return. end.
win=. getchildwin window
jniCheck p=. win ('getParent ()LViewParent;' jniMethod)~ ''
jniCheck p ('removeView (LView;)V' jniMethod)~ win
jniCheck DeleteLocalRef"0 win;p
childList=: (<<<ix){childList
)
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
    else.
      menuList=: (<flag 1}menust) (<imx ,4)}menuList
    end.
  end.
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
case. wdcl_scrollbar ; wdcl_scrollbarv do.
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
case. wdcl_trackbar ; wdcl_trackbarv do.
  if. 1= #args do. menu,tbar,win seterr 'bad number : ' return.
  elseif. 3 4 5 e.~ #args do. menu,tbar,win seterr 'extra parameter : ' return.
  elseif. 6< #args do. menu,tbar,win seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. menu,tbar,win seterr 'bad number : ' return. end.
  if. 2= #args do.
    item1=. {.@(0&".) 1{::args
    jniCheck win ('setProgress (I)V' jniMethod)~ item1
  else.
    'item1 item2 item3 item4 item5'=. {.@(0&".)&> 5{. }.args
    jniCheck win ('setMax (I)V' jniMethod)~ item3
    jniCheck win ('setProgress (I)V' jniMethod)~ item2
    jniCheck win ('setKeyProgressIncrement (I)V' jniMethod)~ item4
  end.
case. wdcl_tab do.
  if. 1= #args do. menu,tbar,win seterr 'bad id : ' return. end.
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
  disable_toggle_event=: 0
case. do. menu,tbar,win seterr 'bad class : ' return.
end.
jniCheck DeleteLocalRef"0 menu;tbar;win
cChild=: window
)
wdsetscroll=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
return.
win=. getchildwin window
select. iclass=. getcchildclass window
case. wdcl_editm ; wdcl_richeditm do.
  if. 1= #args do. win seterr 'bad number : ' return.
  elseif. 2< #args do. win seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. win seterr 'bad number : ' return. end.
  line=. 0 >. <: {.@(0&".) s
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
return.
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
return.
win=. getchildwin window
if. g_type_check_instance_is_a window, gtk_notebook_get_type '' do.
  if. pg=. gtk_notebook_get_nth_page window, tabn do.
    for_child. > (window = >6{"1 childList) # 1{"1 childList do.
      if. gtk_widget_is_ancestor pg, child do.
        cWindow delcchild child
      end.
    end.
  end.
  jniCheck tw=. win ('getTabWidget ()LTabWidget;' jniMethod)~ ''
  jniCheck vw=. tw ('getChildTabViewAt (I)LView;' jniMethod)~ tabn
  jniCheck tw ('removeView (LView;)V' jniMethod)~ vw
  jniCheck DeleteLocalRef"0 tw;vw
end.
jniCheck DeleteLocalRef <win
cChild=: window
)
wdsetedit=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
return.
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
    case. 'z' do.
    case. 'x' do. gtk_editable_cut_clipboard window
    case. 'c' do. gtk_editable_copy_clipboard window
    case. 'v' do. gtk_editable_paste_clipboard window
    case. 'y' do.
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
return.
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
wdsetreplace=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
return.
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
  disable_toggle_event=: 1
  jniCheck tw=. win ('getTabWidget ()LTabWidget;' jniMethod)~ ''
  jniCheck npage=. tw ('getChildCount ()I' jniMethod)~ ''
  jniCheck DeleteLocalRef <tw
  if. item < npage do.
    jniCheck win ('setCurrentTab (I)V' jniMethod)~ item
  end.
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
else.
  ix=. getcchildidx window
  assert. _1~: ix
  childList=: (<flag) (<ix,5)}childList
  win=. getchildwin window
  jniCheck win ('setVisibility (I)V' jniMethod)~ flag{8 0
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
setxywhx=: 3 : 0
'id xywh offset'=. y
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
win=. getchildwin window
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
extendedsel multicolumn multiplesel nosel ownerdrawfixed sort
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
buttons multiline left
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
gs_image
gs_opengl
gs_video
gs_web
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
  jniCheck cap=. jniToJString ts=. '' ('toString ()LString;' jniMethod) cs=. w ('getTitle ()LCharSequence;' jniMethod)~ ''
  jniCheck DeleteLocalRef"0 ts;cs
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
if. timerdelay ~: delay do.
  timerdelay=: delay
  jniCheck JACT ('setjtimer (IILString;)V' jniMethod)~ 10;timerdelay;''
end.
)

return0=: 0:
return1=: 1:

form_evt=: 3 : 0
'widget event child data'=. y
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
sysfocus=. ''
syslastfocus=. ''
sysdata=: data
wdd=. ;: 'syshandler sysevent sysdefault sysparent syschild systype syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers', (0<#sysdata)#' sysdata'
wddata=. ".&.>wdd
qdata=. 0 2$<''
for_ls. (widget = >{."1 childList)#childList do.
  qdata=. qdata, childevtdata 1 2 3{ls
end.
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
  if. _1= ix=. getcchildidx widget do. return. end.
  'pawin childid iclass'=. 0 2 3{ ix{childList
  for_ls. (pawin = >{."1 childList)#childList do.
    childdata=. childdata, childevtdata 1 2 3{ls
  end.
elseif. 1=eventcat do.
  if. _1= ix=. cWindow getmenuidx widget do. return. end.
  'pawin childid'=. 0 2{ ix{menuList
  for_ls. (pawin = >{."1 childList)#childList do.
    childdata=. childdata, childevtdata 1 2 3{ls
  end.
elseif. 2=eventcat do.
  if. _1= ix=. cWindow gettoolbaridx widget do. return. end.
  'pawin childid'=. 0 2{ ix{toolbarList
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
case. wdcl_trackbar ; wdcl_trackbarv do.
  wdd=. wdd, <id
  wddata=. wddata, < ": view ('getProgress ()I' jniMethod)~ ''
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
  jniCheck ncnt=. view ('getCount ()I' jniMethod)~ ''
  if. (0=ncnt) +. _1=nsel do.
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
  if. widget-:>{.listbox_evtdata do.
    'nsel ssel'=. }.listbox_evtdata
  else.
    nsel=. 0$0 [ ssel=. 0$<''
    jniCheck ncnt=. view ('getCount ()I' jniMethod)~ ''
    if. ncnt do.
      jniCheck sp=. view ('getCheckedItemPositions ()Landroid/util/SparseBooleanArray;' jniMethod)~ ''
      if. sp do.
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
      end.
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
case. wdcl_tab do.
  ix=. getcchildidx widget
  assert. _1~: ix
  if. 0<: pagenum=. > (<ix,ChildListUserdata){childList do.
    jniCheck tw=. view ('getTabWidget ()LTabWidget;' jniMethod)~ ''
    jniCheck cw=. tw ('getChildAt (I)LView;' jniMethod)~ pagenum
    jniCheck vw=. cw ('findViewById (I)LView;' jniMethod)~ R_id_title
    jniCheck pagelabel=. jniToJString cs=. vw ('getText ()LCharSequence;' jniMethod)~ ''
    jniCheck DeleteLocalRef"0 tw;cw;vw;cs
  else.
    pagelabel=. ''
  end.
  wdd=. wdd, <id
  wddata=. wddata, < ": pagelabel
  wdd=. wdd, <id,'_select'
  wddata=. wddata, < ": pagenum
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
  1 [ form_evt widget ; keyevent ; child ; ''
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
form_evt widget ; 'close' ; '' ; ''
1
)

wddestroy=: 3 : 0
widget=. y
if. _1~: ix=. windowlistidx widget do.
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

scrollbar_change=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0
)

listbox_onItemClick=: 3 : 0
if. disable_toggle_event do. 0 return. end.
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. 2= style=. > (<ix,ChildListUserdata){childList do.
  jniCheck pos=. '' ('intValue ()I' jniMethod) opos=. GetObjectArrayElement (3{y);2
  jniCheck ch=. parent ('getItemAtPosition (I)LObject;' jniMethod)~ pos
  jniCheck s=. jniToJString ch
  jniCheck DeleteLocalRef <ch
  listbox_evtdata=: widget;pos;<<s
  listbox_evtdata=: ''
  jniCheck DeleteLocalRef"0 opos;ch
end.
0 child_evt (parent,widget) ; (2=style){::'select';'button'
listbox_evtdata=: ''
jniCheck DeleteLocalRef <parent
1
)

listbox_onItemLongClick=: 3 : 0
if. disable_toggle_event do. 0 return. end.
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. 2= style=. > (<ix,ChildListUserdata){childList do.
  jniCheck pos=. '' ('intValue ()I' jniMethod) opos=. GetObjectArrayElement (3{y);2
  jniCheck ch=. parent ('getItemAtPosition (I)LObject;' jniMethod)~ pos
  jniCheck s=. jniToJString ch
  listbox_evtdata=: widget;pos;<<s
  listbox_evtdata=: ''
  jniCheck DeleteLocalRef"0 opos;ch
end.
0 child_evt (parent,widget) ; 'button'
listbox_evtdata=: ''
jniCheck DeleteLocalRef <parent
1
)

combobox_onItemSelected=: 3 : 0
if. disable_toggle_event do. 0 return. end.
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
0 child_evt (parent,widget) ; 'select'
jniCheck DeleteLocalRef <parent
1
)

combobox_onNothingSelected=: 3 : 0
if. disable_toggle_event do. 0 return. end.
jniCheck parent=. GetObjectArrayElement (3{y);0
jniCheck widget=. parent ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <parent return. end.
0 child_evt (parent,widget) ; 'select'
jniCheck DeleteLocalRef <parent
1
)

menu_onItemSelected=: 3 : 0
'view widget'=. y
if. _1= ix=. cWindow getmenuidx widget do. 0 return. end.
1 child_evt (view,widget) ; 'button'
1
)

button_onClick=: 3 : 0
jniCheck view=. GetObjectArrayElement (3{y);0
jniCheck widget=. view ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
if. _1~: ix=. getcchildidx widget do.
  0 child_evt (view,widget) ; 'button'
  1 [ jniCheck DeleteLocalRef <view
elseif. _1~: ix=. cWindow gettoolbaridx widget do.
  2 child_evt (view,widget) ; 'button'
  1 [ jniCheck DeleteLocalRef <view
elseif. do.
  0 [ jniCheck DeleteLocalRef <view return.
end.
0
)
IME_NULL=: 0
IME_ACTION_DONE=: 6
IME_ACTION_NEXT=: 5
ACTION_DOWN=: 0
edit_onEditorAction=: 3 : 0
jniCheck action=. '' ('intValue ()I' jniMethod) oaction=. GetObjectArrayElement (3{y);1
jniCheck DeleteLocalRef <oaction
jniCheck event=. GetObjectArrayElement (3{y);2
if. 0=event do.
  if. action -.@e. IME_ACTION_DONE,IME_ACTION_NEXT do. 0 [ DeleteLocalRef <event return. end.
elseif. IME_NULL=action do.
  if. ACTION_DOWN ~: jniCheck event ('getAction ()I' jniMethod)~'' do. 1 [ DeleteLocalRef <event return. end.
elseif. do.
  0 [ DeleteLocalRef <event return.
end.
jniCheck DeleteLocalRef <event
jniCheck view=. GetObjectArrayElement (3{y);0
jniCheck widget=. view ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
if. _1~: ix=. getcchildidx widget do.
  0 child_evt (view,widget) ; 'button'
  1 [ jniCheck DeleteLocalRef <view
end.
0
)
fixed1_onLayout=: 3 : 0
jniCheck changed=. '' ('booleanValue ()Z' jniMethod) ochanged=. GetObjectArrayElement (3{y);0
jniCheck DeleteLocalRef <ochanged
if. 0=changed do. 0 return. end.
jniCheck h=. (2{y) ('getHeight ()I' jniMethod)~ ''
jniCheck w=. (2{y) ('getWidth ()I' jniMethod)~ ''
wh=. w,h
assert. 0~:cWindow
idx=. windowlistidx cWindow
assert. _1~:idx
fixed1=. 2{y
wh0=. (<idx, WindowListWh0) {:: windowList
'tbvisi tbcnt tbpx'=. 1 2 3{ (<idx, WindowListToolbar){:: windowList
offset=. <. tbvisi *. tbpx
windowList=: (<wh) (<idx, WindowListWh1) } windowList
(wh,wh0) resizechild cWindow, fixed1,offset
jniCheck DeleteLocalRef <fixed1
form_evt cWindow ; 'size' ; '' ; ":0 0,w,h
1
)

tab_createTabContent=: 3 : 0
jniCheck s=. jniToJString cs=. GetObjectArrayElement (3{y);0
assert. 'tag'-:3{.s
idn=. 0 ". 3}.s
assert. 0~:cWindow
jniCheck fixed1=. cWindow jniNewObject 'AbsoluteLayout LContext;'
jniCheck fixed1 ('setId (I)V' jniMethod)~ idn
jniCheck DeleteLocalRef <cs
<fixed1
)

tab_onTabChanged=: 3 : 0
if. disable_toggle_event do. 0 return. end.
assert. 0~:cWindow
widget=. R_id_tabhost
if. _1= ix=. getcchildidx widget do. 0 return. end.
th=. getchildwin widget
jniCheck page=. th ('getCurrentTab ()I' jniMethod)~ ''
jniCheck DeleteLocalRef <th
childList=: (<page) (<ix,ChildListUserdata)}childList
0 child_evt widget ; 'button'
1
)

tab_switch_page=: 3 : 0
'widget page page_num data'=. y
if. disable_toggle_event do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
childList=: (<page) (<ix,ChildListUserdata)}childList
0 child_evt widget ; 'button'
0
)

edit_key_press=: 3 : 0
'widget event data'=. y
if. _1= ix=. getcchildidx widget do. 0 return. end.
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

toolbar_clicked_event=: 3 : 0
'widget data'=. y
if. _1= ix=. cWindow gettoolbaridx widget do. 0 return. end.
2 child_evt widget ; 'button'
0
)

seekbar_onProgressChanged=: 3 : 0
jniCheck user=. '' ('booleanValue ()Z' jniMethod) ouser=. GetObjectArrayElement (3{y);2
jniCheck DeleteLocalRef <ouser
if. 0=user do. 1 return. end.
jniCheck view=. GetObjectArrayElement (3{y);0
jniCheck widget=. view ('getId ()I' jniMethod)~ ''
if. 1>widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
if. _1= ix=. getcchildidx widget do. 0 [ jniCheck DeleteLocalRef <view return. end.
0 child_evt (view,widget) ; 'button'
jniCheck DeleteLocalRef <view
1
)

seekbar_onStartTrackingTouch=: 0:
seekbar_onStopTrackingTouch=: 0:
alertdialog0_onClick=: 3 : 0
jniCheck dialog=. GetObjectArrayElement (3{y);0
jniCheck dialog ('dismiss ()V' jniMethod)~ ''
jniCheck DeleteLocalRef <dialog
)

alertdialog_onClick=: 3 : 0
jniCheck dialog=. GetObjectArrayElement (3{y);0
jniCheck pos=. '' ('intValue ()I' jniMethod) opos=. GetObjectArrayElement (3{y);1
jniCheck DeleteLocalRef <opos
form_evt cWindow ; 'alertdialog' ; '' ; ":pos
jniCheck dialog ('dismiss ()V' jniMethod)~ ''
jniCheck DeleteLocalRef <dialog
1
)

androidwidget_event=: 4 : 0
assert. 'jglcanvas' -: >@{.x
l=. 1{x
widget=. canvas__l
view=. 0{2{::x
evt=. >@{.y
if. 1=#y do.
  0 child_evt (view,widget) ; evt
elseif. 2=#y do.
  sysdata=: ": >1{y
  0 child_evt (view,widget) ; evt
elseif. 3=#y do.
  sysdata=: ": >1{y
  sysmodifiers=: ": 0
  0 child_evt (view,widget) ; evt
end.
0
)

timer_event=: 3 : 0
system_evt 'timer';'sys_timer'
0~:systimerid
)

invalideview=: 3 : 0
if. 0= cWindow do. return. end.
jniCheck view=. cWindow ('findViewById (I)LView;' jniMethod)~ viewidn
jniCheck view ('invalidate ()V' jniMethod)~ ''
jniCheck DeleteLocalRef <view
)
wdfontdef=: 3 : 0
if. 0= #args=. shiftargs'' do. seterr 'bad font name : ' return. end.
cFontdef=: '"' -.~ }. ;' ',&.> args
)
wdsetfont=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
f=. getfontspec }.args
if. 0=WDERRN do.
  win=. getchildwin window
  'face asize style angle'=. f
  'Bold Italic Underline Strikeout'=. 4{. |. #: style
  jniCheck ft=. 'android.graphics.Typeface' ('create (LString;I)LTypeface;' jniStaticMethod)~ face;(Bold + 2*Italic)
  try.
    jniCheck win ('setTypeface (LTypeface;)V' jniMethod)~ ft
    jniCheck win ('setTextSize (F)V' jniMethod)~ pt2sp asize
  catch.
    ExceptionClear''
  end.
  jniCheck DeleteLocalRef"0 win;ft
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
font ; ({. 0&". asize) ; style ; angle
)
wdmbfont=: 3 : 0
f=. ''
if. 0< #args=. shiftargs'' do.
  f=. getfontspec args
  if. 0~:WDERRN do. return. end.
end.
'' return.
if. #f do.
  fontdialog ''; (>@{.f),' ', (": >1{f)
else.
  fontdialog '';''
end.
)
wdmb=: 3 : 0
if. 0= cWindow do. '' [ seterr 'no parent selected : ' return. end.
args=. shiftargs''
title=. >@{.args
txt=. >@{.}.args
if. 2< #args do.
  styles=. 2}.args
else.
  styles=. 0$<''
end.
if. (<'mb_yesno') e. styles do.
  'pos neg neu'=. 'Yes' ; 'No' ; ''
elseif. (<'mb_yesnocancel') e. styles do.
  'pos neg neu'=. 'Yes' ; 'No' ; 'Cancel'
elseif. (<'mb_okcancel') e. styles do.
  'pos neg neu'=. 'Ok' ; '' ; 'Cancel'
elseif. (<'mb_retrycancel') e. styles do.
  'pos neg neu'=. 'Retry' ; '' ; 'Cancel'
elseif. (<'mb_abortretryignore') e. styles do.
  'pos neg neu'=. 'Retry' ; 'Abort' ; 'Ignore'
elseif. do.
  'pos neg neu'=. '' ; '' ; ''
end.

jniCheck builder=. cWindow jniNewObject 'AlertDialog$Builder LContext;'
jniCheck builder ('setTitle (LCharSequence;)LAlertDialog$Builder;' jniMethod)~ <title
jniCheck builder ('setMessage (LCharSequence;)LAlertDialog$Builder;' jniMethod)~ <txt
if. 0= # pos,neg,neu do.
  jniCheck builder ('setNeutralButton (LCharSequence;LDialogInterface$OnClickListener;)LAlertDialog$Builder;' jniMethod)~ 'Ok' ; alertdialog0_listener
else.
  if. #pos do.
    jniCheck builder ('setPositiveButton (LCharSequence;LDialogInterface$OnClickListener;)LAlertDialog$Builder;' jniMethod)~ pos ; alertdialog_listener
  end.
  if. #neg do.
    jniCheck builder ('setNegativeButton (LCharSequence;LDialogInterface$OnClickListener;)LAlertDialog$Builder;' jniMethod)~ neg ; alertdialog_listener
  end.
  if. #neu do.
    jniCheck builder ('setNeutralButton (LCharSequence;LDialogInterface$OnClickListener;)LAlertDialog$Builder;' jniMethod)~ neu ; alertdialog_listener
  end.
end.
jniCheck builder ('show ()LAlertDialog;' jniMethod)~ ''
''
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
'' return.
cWindow filechooser_jgtk_ y ; title ; pattern ; path
)
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
if. 1{menust do.
end.
if. 2{menust do.
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
)

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
    win seterr 'bad id : ' return.
  end.
  jniCheck DeleteLocalRef <win
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
  jniCheck view ('setOrientation (I)V' jniMethod)~ VERTICAL
  if. scroll+.hscroll do.
    jniCheck scrollvw=. activity jniNewObject (hscroll#'Horizontal'),'ScrollView LContext;'
    jniCheck scrollvw ('setId (I)V' jniMethod)~ scrollvwidn=: idn=. >:idn
    jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ MATCH_PARENT;WRAP_CONTENT
    jniCheck scrollvw ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
    jniCheck DeleteLocalRef <lp
    jniCheck view ('addView (LView;)V' jniMethod)~ scrollvw
    jniCheck fixed1=. activity jniOverride 'org.dykman.jn.android.widget.AbsoluteLayout LContext;' ; 'droidwd' ; 'fixed1' ; 'onLayout'
    jniCheck fixed1 ('setId (I)V' jniMethod)~ fixedidn=: idn=. >:idn
    jniCheck lp=. ('FrameLayout$LayoutParams II') jniNewObject~ MATCH_PARENT;wantstatusbar{MATCH_PARENT,WRAP_CONTENT
    jniCheck fixed1 ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
    jniCheck DeleteLocalRef <lp
    jniCheck scrollvw ('addView (LView;)V' jniMethod)~ fixed1
  else.
    jniCheck fixed1=. activity jniOverride 'org.dykman.jn.android.widget.AbsoluteLayout LContext;' ; 'droidwd' ; 'fixed1' ; 'onLayout'
    jniCheck fixed1 ('setId (I)V' jniMethod)~ fixedidn=: idn=. >:idn
    jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ MATCH_PARENT;wantstatusbar{MATCH_PARENT,WRAP_CONTENT
    jniCheck fixed1 ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
    jniCheck DeleteLocalRef <lp
    jniCheck view ('addView (LView;)V' jniMethod)~ fixed1
    scrollvw=. 0
  end.
  jniCheck tbar=. activity jniNewObject 'LinearLayout LContext;'
  jniCheck tbar ('setId (I)V' jniMethod)~ tbaridn=: idn=. >:idn
  jniCheck tbar ('setOrientation (I)V' jniMethod)~ HORIZONTAL
  jniCheck lp=. ('AbsoluteLayout$LayoutParams IIII') jniNewObject~ <"0 dpw2px (MATCH_PARENT, WRAP_CONTENT), 0 0
  jniCheck tbar ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck tbar ('setVisibility (I)V' jniMethod)~ 8
  jniCheck DeleteLocalRef <lp
  jniCheck fixed1 ('addView (LView;)V' jniMethod)~ tbar
  jniCheck sbar=. activity jniNewObject 'LinearLayout LContext;'
  jniCheck sbar ('setId (I)V' jniMethod)~ sbaridn=: idn=. >:idn
  jniCheck sbar ('setOrientation (I)V' jniMethod)~ HORIZONTAL
  jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ MATCH_PARENT;WRAP_CONTENT
  jniCheck sbar ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck sbar ('setVisibility (I)V' jniMethod)~ 8
  jniCheck DeleteLocalRef <lp
  jniCheck view ('addView (LView;)V' jniMethod)~ sbar

  jniCheck activity ('setContentView (LView;)V' jniMethod)~ view
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
return.
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
return.
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
return.
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
case. 'rm' do. wdrm ''
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
wd_menu=: 3 : 0
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
smoutput^:(1<Debugwd) y
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
wdsbar=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
idn0=. idn=. (<idx,4){::windowList
'sbaridn id0 cnt nxt'=. (<idx,WindowListStatusbar){::windowList
assert. 0~:sbaridn
if. 0~:cnt do. seterr 'nounce error : ' return. end.
if. -.@isnum s=. >@{.args do. seterr 'bad number : ' return. end.
if. 0>: count=. {.@(0&".) s do. seterr 'bad number : ' return. end.
sbar=. getchildwin sbaridn
assert. 0~:sbar
jniCheck sbar ('setVisibility (I)V' jniMethod)~ 0
jniCheck DeleteLocalRef <sbar
windowList=: (<idn0+count) (<idx, 4) } windowList
windowList=: (<sbaridn, idn0, count, 0) (<idx, WindowListStatusbar) } windowList
)
wdsbarset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 3< #args do. seterr 'extra parameter : ' return.
end.
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
'sbaridn idn0 count next'=. (<idx,WindowListStatusbar){::windowList
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. -.@isnum awidth=. 1{::args do. seterr 'bad number : ' return. end.
width=. {.@(0&".) awidth
txt=. >@{.2}.args
sbar=. getchildwin sbaridn
assert. 0~:sbar
if. _1~: ix=. cWindow getstatusbaridx id do.
  window=. (<ix,1){::statusbarList
  win=. getchildwin window
else.
  if. count<:next do. sbar seterr 'bad number : ' return. end.
  jniCheck win=. cWindow jniNewObject 'TextView LContext;'
  jniCheck win ('setId (I)V' jniMethod)~ window=. idn0+next+1
  jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ WRAP_CONTENT;WRAP_CONTENT
  jniCheck win ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
  jniCheck sbar ('addView (LView;)V' jniMethod)~ win
  jniCheck DeleteLocalRef <lp
end.
jniCheck win ('setText (LCharSequence;)V' jniMethod)~ <txt
if. width>0 do.
  lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
  lp ('width I' jniField)~ dpw2px width
  jniCheck DeleteLocalRef <lp
end.
jniCheck DeleteLocalRef"0 win;sbar
if. _1=ix do.
  windowList=: (<sbaridn, idn0, count, >:next) (<idx, WindowListStatusbar) } windowList
  statusbarList=: statusbarList, cWindow ; window ; id
end.
)
wdsbarshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1< #args do. seterr 'extra parameter : ' return.
elseif. do. s=. >@{.args
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
'sbaridn idn0 cnt nxt'=. (<idx,WindowListStatusbar){::windowList
assert. 0~:sbaridn
sbar=. getchildwin sbaridn
assert. 0~:sbar
jniCheck sbar ('setVisibility (I)V' jniMethod)~ flag{8 0
jniCheck DeleteLocalRef <sbar
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
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
idn0=. idn=. (<idx,4){::windowList
'tbaridn visi cnt height'=. (<idx,WindowListToolbar){::windowList
assert. 0~:tbaridn
mn=. WindowListMenubar{:: idx{windowList
if. 0~: tbimg=. (<idx, WindowListTbimg) {:: windowList do. seterr 'command failed : ' return. end.
if. #pix=. readimg_ja_ fn do.
  'h w'=. $pix
  if. -. (15 144-:$pix) +. 0=h|w do. seterr 'picture width not 16x : ' return. end.
  tbimg=. pix
  assert. 0~:#tbimg
  cnt=. w%h
  if. (15 144-:$pix) do. cnt=. 9 end.
else.
  seterr 'wrong file type : ' return.
end.
tbar=. getchildwin tbaridn
jniCheck tbar ('setVisibility (I)V' jniMethod)~ 0
windowList=: (<tbimg) (<idx, WindowListTbimg) } windowList
windowList=: (<tbaridn,1,cnt,height) (<idx, WindowListToolbar) } windowList
)
wdtbarset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 3> #args do. seterr 'bad number : ' return.
elseif. 5< #args do. seterr 'extra parameter : ' return.
end.
idx=. windowlistidx cWindow
if. _1~: idx=. windowlistidx cWindow do.
  if. 0= 1{ 'tbaridn visi count height'=. (<idx, WindowListToolbar){::windowList do. seterr 'no control bar : ' return. end.
else.
  seterr 'command3 failed : ' return.
end.
idn=. (<idx,4){::windowList
id=. >@{.args
if. 0 e. isnum&> 2{. }.args do. seterr 'bad number : ' return. end.
'index image'=. {.@(0&".)&> 2{. }.args
'statushelp tooltip'=. 2{. 3}.args
if. 0=#id do.
  jniCheck win=. cWindow jniNewObject 'View LContext;'
  jniCheck win ('setVisibility (I)V' jniMethod)~ 4
  'w h'=. 1,~ <. dpw2px barsheight%4
else.
  if. count<:image do. seterr 'bad number : ' return. end.
  jniCheck win=. cWindow jniNewObject 'ImageButton LContext;'
  if. 0~:#tbimg=. (<idx, WindowListTbimg){:: windowList do.
    'h0 w0'=. $tbimg
    if. 15 144-:$tbimg do.
      w=. h=. 16
    else.
      w=. h=. h0
    end.
    d=. w{."1 (image*w)}."1 tbimg
    if. 15 144-:$tbimg do.
      d=. 16{.d
    end.
    d=. fliprgb^:(-.RGBSEQ_j_) , d
    d=. ALPHA_ja_ (23 b.) d
    jniCheck colors=. NewIntArray <#d
    jniCheck SetIntArrayRegion colors;0;(#d);d
    jniCheck bm=. 'android.graphics.Bitmap' ('createBitmap ([IIIIILBitmap$Config;)LBitmap;' jniStaticMethod)~ colors;0;w;w;h;ARGB_8888
    if. (h1=. <.dpw2px barsheight)>h do.
      jniCheck bm1=. 'android.graphics.Bitmap' ('createScaledBitmap (LBitmap;IIZ)LBitmap;' jniStaticMethod)~ bm;h1;h1;0
      jniCheck DeleteLocalRef <bm
      bm=. bm1
      w=. h=. h1
    end.
    jniCheck win ('setImageBitmap (LBitmap;)V' jniMethod)~ bm
    jniCheck DeleteLocalRef"0 colors;bm
  else.
    win seterr 'command failed : ' return.
  end.
  jniCheck win ('setId (I)V' jniMethod)~ idn=. >:idn
  jniCheck win ('setOnClickListener (LView$OnClickListener;)V' jniMethod)~ button_click_listener
end.
jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ <"0 w,h
jniCheck win ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
jniCheck win ('setFocusable (Z)V' jniMethod)~ 0
tbar=. getchildwin tbaridn
assert. 0~:tbar
jniCheck tbar ('addView (LView;)V' jniMethod)~ win
if. 0~:#id do.
  toolbarList=: toolbarList, cWindow ; idn ; id ; index ; image
  windowList=: (<idn) (<idx, 4) } windowList
  windowList=: (<tbaridn,visi,count,h>.height) (<idx, WindowListToolbar) } windowList
end.
jniCheck DeleteLocalRef"0 win;lp;tbar
)
wdtbarshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
idx=. windowlistidx cWindow
if. _1=idx do. seterr 'parent deleted : ' return. end.
'tbaridn visi cnt height'=. (<idx,WindowListToolbar){::windowList
assert. 0~:tbaridn
tbar=. getchildwin tbaridn
assert. 0~:tbar
jniCheck tbar ('setVisibility (I)V' jniMethod)~ flag{8 0
jniCheck DeleteLocalRef <tbar
windowList=: (<tbaridn,flag,cnt,height) (<idx, WindowListToolbar) } windowList
)
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

ismenucreated=: 3 : 0
if. _1 = icx=. windowlistidx y do. 0 return. end.
(<icx, WindowListMenuCreated){::windowList
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

seterr=: ''&$: : (4 : 0)
if. *#x do. jniCheck DeleteLocalRef@boxopen"0 x end.
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

delcchild=: 4 : 0
parent=. x
widget=. y
if. 0= #childList do. return. end.
childList=: ((parent = >0{"1 childList)*:(widget = >1{"1 childList))#childList
)
getcchild=: 4 : 0
parent=. x
id=. <,> y
z=. 0
if. 0= #childList do. z return. end.
if. 1 e. ix=. (parent = >0{"1 childList)*.(id = 2{"1 childList) do. z=. (<({.I.ix),1){::childList end.
z
)
getcchildid=: 3 : 0
widget=. y
if. _1= ix=. getcchildidx widget do. '' return. end.
(<ix,2 ){::childList
)

getcchildclass=: 3 : 0
widget=. y
if. _1= ix=. getcchildidx widget do. _1 return. end.
(<ix, 3){::childList
)
getcchildidx=: 3 : 0
assert. 0~:cWindow
widget=. y
z=. _1
if. 0= #childList do. z return. end.
if. 1 e. ix=. (cWindow = >0{"1 childList) *. (widget = >1{"1 childList) do. z=. {.I.ix end.
z
)
getcparent=: 3 : 0
widget=. y
if. 0= #windowList do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
(<ix, 0){::childList
)

getccontaineridx=: 3 : 0
assert. 0~:cWindow
widget=. y
z=. _1
if. 0= #containerList do. z return. end.
if. 1 e. ix=. (cWindow = >0{"1 containerList)*.(widget = >1{"1 containerList) do. z=. I.{.ix end.
z
:
getccontaineridx x getcchild y
)
getmenuidx=: 4 : 0
parent=. x
widget=. y
assert. 0~:parent
z=. _1
if. 0= #menuList do. z return. end.
if. 1 e. ix=. (cWindow = >0{"1 menuList)*.(widget = >1{"1 menuList) do. z=. {.I.ix end.
z
)
getmenu=: 4 : 0
parent=. x
id=. <,> y
z=. 0
if. 1 e. ix=. (parent = >0{"1 menuList)*.(id = 2{"1 menuList) do. z=. (<({.I.ix),1){::menuList end.
z
)
gettoolbaridx=: 4 : 0
parent=. x
widget=. y
assert. 0-:{.0$y
assert. 0~:parent
z=. _1
if. 0= #toolbarList do. z return. end.
if. 1 e. ix=. (parent = >0{"1 toolbarList)*.(widget = >1{"1 toolbarList) do. z=. {.I.ix end.
z
)
gettoolbar=: 4 : 0
parent=. x
assert. ' '-:{.0$>y
assert. 0~:parent
id=. <,> y
if. 1 -.@e. ix=. (parent = >0{"1 toolbarList)*.(id = 2{"1 toolbarList) do. 0 return. end.
(<({.I.ix), 1){::toolbarList
)
getstatusbaridx=: 4 : 0
parent=. x
id=. <,> y
assert. 0~:parent
z=. _1
if. 0= #statusbarList do. z return. end.
if. 1 e. ix=. (parent = >0{"1 statusbarList)*.(id = 2{"1 statusbarList) do. z=. {.I.ix end.
z
)

getstatusbar=: 4 : 0
parent=. x
id=. <,> y
if. _1= ix=. parent getstatusbaridx id do. 0 return. end.
(<ix, 1){::statusbarList
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
assert. 0~:y
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
listbox_evtdata=: ''
lasterrcmd=: lastcmd=: ''
cWindow=: 0
cChild=: 0
cRadio=: 0
cContainer=: 0
cContaineri=: _1
cSubform=: ''
windowList=: 0 18$<''
containerList=: 0 3$<''
subformList=: 0 4$<''
childList=: 0 12$<''
menuList=: 0 5$<''
toolbarList=: 0 5$<''
statusbarList=: 0 3$<''
activeidx=: 0$0
cxywh=: 0 0 100 100
cFontdef=: ''
cSetFont=: ''
tbimg=: 0
systimerid=: timerdelay=: 0
jniCheck JACT ('setjtimer (IILString;)V' jniMethod)~ 10;0;''
)
setadapter=: 4 : 0
'activity view isspin multiselect'=. y
ar=. jniToStringarr x
jniCheck adapter=. 'ArrayAdapter LContext;I[LObject;' jniNewObject~ activity ; (isspin{ (multiselect{R_layout_simple_list_item_single_choice,R_layout_simple_list_item_multiple_choice,R_layout_simple_list_item_1), R_layout_simple_spinner_item) ; ar
if. isspin do.
  jniCheck adapter ('setDropDownViewResource (I)V' jniMethod)~ R_layout_simple_dropdown_item_1line
  jniCheck view ('setAdapter (LSpinnerAdapter;)V' jniMethod)~ adapter
else.
  jniCheck view ('setAdapter (LListAdapter;)V' jniMethod)~ adapter
  if. 1=multiselect do.
    jniCheck view ('setChoiceMode (I)V' jniMethod)~ CHOICE_MODE_MULTIPLE=. 2
  elseif. 2=multiselect do.
    jniCheck view ('setChoiceMode (I)V' jniMethod)~ CHOICE_MODE_SINGLE=. 1
  elseif. do.
    jniCheck view ('setChoiceMode (I)V' jniMethod)~ CHOICE_MODE_SINGLE=. 1
  end.
end.
jniCheck DeleteLocalRef"0 ar;adapter
EMPTY
)

resizechild=: 4 : 0
'wh wh0'=. 1 >. 2 2$x
'w h'=. wh
if. (w>h) *. 0.3>h%w do. return. end.
if. (h>w) *. 0.3>w%h do. return. end.
assert. 0~:2{.y
'parent fixed1 offset'=. y
assert. 0~:fixed1
'top bot lef rig'=. 4#0
pad0=. 0
fixed1wh=. wh=. 1 >. wh - (0,offset) + (0,pad0) + 0>. (lef+rig),(top+bot)
minpad=. 0

chg=. 0
for_wx. ((0&~: >4{"1 childList) *. (0= >6{"1 childList) *. (parent = >{."1 childList))#childList do.
  'parent window id iclass stylen hide container subform xywh0 dummy1 localec userdata'=. 12{.wx
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

  cw=. 1 >. ex - cx
  ch=. 1 >. ey - cy
  if. +./ 0 < | xywh0 - cx,cy,cw,ch do.
    if. iclass=wdcl_radiobutton do.
      if. 1=userdata do.
        win=. getchildwin window
        jniCheck parent=. win ('getParent ()Landroid/view/ViewParent;' jniMethod)~ ''
        if. parent do.
          lp=. parent ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
          lp ('x I' jniField)~ <cx
          lp ('y I' jniField)~ <cy + offset
          lp ('width I' jniField)~ <WRAP_CONTENT
          lp ('height I' jniField)~ <WRAP_CONTENT
        end.
        jniCheck DeleteLocalRef"0 parent;win;lp
      end.
      continue.
    end.
    win=. getchildwin window
    lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
    lp ('x I' jniField)~ <cx
    lp ('y I' jniField)~ <cy + offset
    lp ('width I' jniField)~ <cw
    lp ('height I' jniField)~ <ch
    jniCheck DeleteLocalRef"0 win;lp
  end.
end.
ct=. 0$0
for_wx. ((0&~: >4{"1 childList) *. (0~: >6{"1 childList) *. (parent = >{."1 childList))#childList do.
  'parent window id iclass stylen hide container subform xywh0 dummy1 localec userdata'=. 12{.wx

  if. _1= ix=. getccontaineridx container do. continue. end.
  if. 1 e. f=. (container = >1{"1 subformList) *. (<subform) = 2{"1 subformList do.
    fixed1=. 3{:: ({.I.f){subformList
  else.
    continue.
  end.
  wh=. 0 >. fixed1wh
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

  cw=. 1 >. ex - cx
  ch=. 1 >. ey - cy
  if. +./ 0 < | xywh0 - cx,cy,cw,ch do.
    if. iclass=wdcl_radiobutton do.
      if. 1=userdata do.
        win=. getchildwin window
        jniCheck parent=. win ('getParent ()Landroid/view/ViewParent;' jniMethod)~ ''
        if. parent do.
          lp=. parent ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
          lp ('x I' jniField)~ <cx
          lp ('y I' jniField)~ <cy + offset
          lp ('width I' jniField)~ <WRAP_CONTENT
          lp ('height I' jniField)~ <WRAP_CONTENT
        end.
        jniCheck DeleteLocalRef"0 parent;win;lp
      end.
      continue.
    end.
    win=. getchildwin window
    lp=. win ('getLayoutParams ()Landroid/view/ViewGroup$LayoutParams;' jniMethod)~ ''
    lp ('x I' jniField)~ <cx
    lp ('y I' jniField)~ <cy + offset
    lp ('width I' jniField)~ <cw
    lp ('height I' jniField)~ <ch
    jniCheck DeleteLocalRef"0 win;lp
  end.
end.
)
18!:4 <'z'
wd_z_=: 3 : 0"1
wd_droidwd_ y [ WDLOC_droidwd_=: >coname''
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
0 [ wd m
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
coclass 'wdbase'
coinsert 'jni jaresu'

Activity=: 0
onCreate=: 3 : 0
if. Activity do. DeleteGlobalRef <Activity end.
jniCheck Activity_droidwd_=: Activity=: NewGlobalRef <2{y
jniCheck Activity ('requestWindowFeature (I)Z' jniMethod)~ FEATURE_LEFT_ICON
droidwd_run''
0
)

onStart=: 0:
onRestart=: 0:
onResume=: 0:
onPause=: 0:
onStop=: 0:

onDestroy=: 3 : 0
DeleteGlobalRef@< 0: wddestroy_droidwd_ Activity
)
onCreateOptionsMenu=: 3 : 0
jniCheck menu=. GetObjectArrayElement (3{y);0
wd_menu_droidwd_ menu
jniCheck DeleteLocalRef <menu
1
)

onOptionsItemSelected=: 3 : 0
jniCheck item=. GetObjectArrayElement (3{y);0
jniCheck widget=. item ('getItemId ()I' jniMethod)~ ''
z=. 0
if. widget>0 do. z=. 1 [ menu_onItemSelected_droidwd_ item,widget end.
jniCheck DeleteLocalRef <item
z
)
start_droidwd=: 0&$: : (4 : 0)
if. ''-:y do.
  y=. (>18!:5'');'onStart onRestart onPause onResume onStop onDestroy onCreateOptionsMenu onOptionsItemSelected'
elseif. 1=# y=. boxopen y do.
  y=. (>y); 'onStart onRestart onPause onResume onStop onDestroy onCreateOptionsMenu onOptionsItemSelected'
end.
x StartActivity_ja_ y
)
droidwd_run=: 0:
