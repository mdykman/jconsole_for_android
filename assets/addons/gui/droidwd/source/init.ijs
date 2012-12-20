NB. init

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

wantstatusbar=: 1
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
CBSIZE=: 20        NB. default height of combobox
wdptr0=: wdptr=: 0
wdstr=: ''
sysmodifiers=: ,'0'
sysdata=: ''
disable_toggle_event=: 0
listbox_evtdata=: ''

lasterrcmd=: lastcmd=: ''
cWindow=: 0          NB. current window
cChild=: 0           NB. current child (reset after psel pc)
cRadio=: 0           NB. current radio button group (reset after psel pc or radiobutton with group style)
cContainer=: 0       NB. current container: creategroup
cSubform=: ''        NB. current subform id: pc id after creategroup
windowList=: 0 18$<'' NB. window list
NB. structure of windowList
NB. 0 handle
NB. 1 id
NB. 2 locale
NB. 3 pgroup
NB. 4 not used
NB. 5 fixed widget
NB. 6 fontdef
NB. 7 toolbar
NB. 8 statusbar
NB. 9 menubar
NB. 10 wh1 last wh
NB. 11 accelerator
NB. 12 wh0 initial wh info for move/scale
NB. 13 not used
NB. 14 tbimg
NB. 15 closeok
NB. 16 pending wd menu cmd
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

containerList=: 0 3$<'' NB. container list
NB. structure of containerList
NB. 0 parent handle
NB. 1 container handle
NB. 2 wh0 initial wh info for move/scale

subformList=: 0 4$<'' NB. subform list
NB. structure of subformList
NB. 0 parent handle
NB. 1 container handle
NB. 2 subform id
NB. 3 fixed

childList=: 0 12$<'' NB. child list
NB. structure of childList
NB. 0 parent handle
NB. 1 child handle
NB. 2 id
NB. 3 iclass
NB. 4 stylen  left top right bottom /  move scale
NB. 5 hide
NB. 6 container
NB. 7 subform id
NB. 8 xywh0  initial xywh info for move/scale
NB. 9 not used
NB. 10 localec  for setlocale
NB. 11 data   user data

ChildListContainer=: 6
ChildListSubform=: 7
ChildListWywh0=: 8
ChildListHide=: 9
ChildListLocalec=: 10
ChildListUserdata=: 11

menuList=: 0 5$<'' NB. menu list
NB. structure of menuList
NB. 0 parent handle
NB. 1 child handle
NB. 2 id
NB. 3 revertmenu
NB. 4 state (created checked disabled)

toolbarList=: 0 5$<'' NB. toolbar list
NB. structure of toolbarList
NB. 0 parent handle
NB. 1 child handle
NB. 2 id
NB. 3 index
NB. 4 image

statusbarList=: 0 3$<'' NB. statusbar list
NB. structure of statusbarList
NB. 0 parent handle
NB. 1 child handle
NB. 2 id

activeidx=: 0$0        NB. the last active form
cxywh=: 0 0 100 100
cFontdef=: ''
cSetFont=: ''
tbimg=: 0   NB. toolbar image buffer
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
NB. concrete object for abstract interface
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

