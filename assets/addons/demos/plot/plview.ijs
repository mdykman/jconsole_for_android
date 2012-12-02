NB. Plot viewer

3 : 0''
if. -.IFGTK+IFIOS+.IFQT+.UNAME-:'Android' do. gtkinit_jgtk_'' end.
''
)

coclass 'jdplotgtk'
coinsert 'jgtk jzplot jgl2 jni jaresu'

jniImport ::0: (0 : 0)
android.content.Context
android.view.View
android.view.View$OnClickListener
android.widget.Button
android.widget.LinearLayout
android.widget.LinearLayout$LayoutParams
android.widget.HorizontalScrollView
android.widget.ScrollView
)

RUNID1=: 0
plotedit=: 0
CMDS=: ''

plotruns=: plotrunsx=: plotrunsa=: 3 : 0
CMDS=: ". y
glsel canvas
glpaintx''
)

PLTIMER=: 3000
PLDEMOVER=: 7.01
SLIDES=: 0

NB. =========================================================
NB. android button callback
button_onClick=: 3 : 0
jniCheck b=. GetObjectArrayElement (3{y);0
jniCheck id=. b ('getId ()I' jniMethod)~ ''
jniCheck DeleteLocalRef <b
PLDEMOSEL=: (id-1){::PLOTNAMES
plotrunsa 'D',PLDEMOSEL
1
)

NB. =========================================================
NB. android activity callback
onCreate=: 3 : 0
jniCheck PFormhwnd=: Activity=: NewGlobalRef <2{y

NB. hide title and status bar
jniCheck Activity ('requestWindowFeature (I)Z' jniMethod)~ FEATURE_NO_TITLE
jniCheck win=. Activity ('getWindow ()LWindow;' jniMethod)~ ''
jniCheck win ('setFlags (II)V' jniMethod)~ FLAG_FULLSCREEN;FLAG_FULLSCREEN
jniCheck DeleteLocalRef <win

jniCheck sv=. Activity jniNewObject 'LinearLayout LContext;'
jniCheck sv ('setOrientation (I)V' jniMethod)~ 1
wh=. 280 280
canvas=: idnx=: (0,Activity) glcanvas_jgl2_ wh ; coname''
PIdhwnd=: ":canvas
l=. glgetloc_jgl2_ idnx
vw=. view__l
jniCheck jniCheck lp=. ('LinearLayout$LayoutParams IIF') jniNewObject~ (<"0 dp2px MATCH_PARENT, 280), <1
jniCheck vw ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
jniCheck DeleteLocalRef <lp
jniCheck sv ('addView (LView;)V' jniMethod)~ vw

jniCheck hs=. Activity jniNewObject 'HorizontalScrollView LContext;'
jniCheck jniCheck lp=. ('LinearLayout$LayoutParams II') jniNewObject~ <"0 dp2px MATCH_PARENT, 50
jniCheck hs ('setLayoutParams (Landroid/view/ViewGroup$LayoutParams;)V' jniMethod)~ lp
jniCheck DeleteLocalRef <lp
jniCheck sv ('addView (LView;)V' jniMethod)~ hs

jniCheck ll=. Activity jniNewObject 'LinearLayout LContext;'
jniCheck hs ('addView (LView;)V' jniMethod)~ ll

NB. concrete object for abstract interface
jniCheck listener=. '' jniOverride 'org.dykman.jn.android.view.View$OnClickListener' ; (>18!:5'') ; 'button'

NB. one button for each plot example
list=. ''
for_n. plotnames do.
  b=. Activity jniNewObject 'Button LContext;'
  b ('setText (LCharSequence;)V' jniMethod)~ n
  b ('setId (I)V' jniMethod)~ 1+n_index
  b ('setOnClickListener (LView$OnClickListener;)V' jniMethod)~ listener
  ll ('addView (LView;)V' jniMethod)~ b
  list=. list,b
end.

jniCheck Activity ('setContentView (LView;)V' jniMethod)~ sv
jniCheck DeleteLocalRef"0 (sv;hs;vw;ll;listener), <"0 list

plotrunsa 'D',PLDEMOSEL

0
)

onDestroy=: 3 : 0
if. Activity do.
  jniCheck DeleteGlobalRef <Activity
end.
Activity=: idnx=: 0
0
)

NB. =========================================================
plotdemo_run=: 3 : 0

Cw=: Ch=: _1 NB. ensure plot window is sized
f=. jpath '~system/packages/graphics/'&, @ (,&'.ijs')
DATHILO=: }. 'm' fread jpath '~addons/demos/plot/dm0396.txt'

MyPlotDefaults=: '' NB. turn off user defaults

def=. 'JGRAPHICS'

if. 0 ~: 4!:0 <'PLDEMOSEL' do.
  PLDEMOSEL=: def
end.

ASPECT=: 170%270
PShow=: 0
PForm=: 'plotdemo'
PId=: 'ps'

NB. start android activity
if. 'Android'-:UNAME do.
  StartActivity_ja_ coname'' return.
end.

make_main_window''
PFormhwnd=: window
gtk_widget_show_all window

plotruns 'D',PLDEMOSEL

if. -.IFGTK+.IFQT do. gtk_main'' end.
)

NB. =========================================================
menu_button=: 0 : 0
plotdemo_Mxxx_button=: (3) : 0
'widget data'=. y
name=. 'xxx'
if. name -: PLDEMOSEL do.
  0 return.
end.
if. (<name) e. PLOTNAMES do.
  if. 0~:RUNID1 do. RUNID1=: 0 [ g_source_remove RUNID1 end.
  SLIDES=: 0
  PLDEMOSEL=: name
  plotrunsx 'D',PLDEMOSEL
end.
0
)

NB. =========================================================
NB. menu button event handler
3 : 0''
for_i. PLOTNAMES do.
  0!:0 (')',LF),~ ('xxx';>i) stringreplace menu_button
end.
''
)

NB. =========================================================
plotdemo_view_button=: 3 : 0
plotedit_run PLDEMOSEL
0
)

NB. =========================================================
plotdemo_exit_button=: 3 : 0
gtk_widget_destroy window
0
)

NB. =========================================================
plotdemo_contents_button=: 3 : 0
mbox 1;'help contents'
0
)

NB. =========================================================
plotdemo_about_button=: 3 : 0
j=. 'Plot Demo V',(4j2 ": PLDEMOVER)
mbox 1;'Plot';j
0
)

NB. =========================================================
plotdemo_ps_paint=: 3 : 0
l=. glgetloc canvas
if. newsize__l do.
  if. #CMDS do.
    glclear''
    pd 'reset ',":PForm
    0!:100 CMDS
  end.
  if. 'Android'-:UNAME do.
    android_show''
  else.
    gtk_show''
  end.
  newsize__l=: 0
end.
0
)

NB. =========================================================
plotdemo_ps_char=: 0:

NB. =========================================================
plotdemo_slides_button=: 3 : 0
SLIDES=: -. SLIDES
if. SLIDES do.
  RUNID1=: g_timeout_add_full G_PRIORITY_DEFAULT_IDLE;3000;cb1;(cbreg 'plotdemo_slides','_',(>coname''),'_');0
else.
  if. 0~:RUNID1 do. RUNID1=: 0 [ g_source_remove RUNID1 end.
end.
0
)

NB. =========================================================
plotdemo_slides=: 3 : 0
try.
  plotdemo_next_button''
  1
catch.
  RUNID1=: 0
  0
end.
)

NB. =========================================================
plotdemo_step=: 3 : 0
ndx=. (#PLOTALL) | y + PLOTALL i. <'D',PLDEMOSEL
PLDEMOSEL=: }.ndx pick PLOTALL
plotrunsx 'D',PLDEMOSEL
0
)

NB. =========================================================
plotdemo_destroy=: 3 : 0
'widget data'=. y
if. 0~:RUNID1 do. RUNID1=: 0 [ g_source_remove RUNID1 end.
if. plotedit do. gtk_widget_destroy ::0: plotedit end.
window=: 0
if. -.IFGTK+.IFQT do. gtk_main_quit'' end.
cbfree''
0
)

plotdemo_saveeps_button=: pd_jdplotgtk_ bind 'eps'
plotdemo_savepdf_button=: pd_jdplotgtk_ bind 'pdf'
plotdemo_clip_button=: pd_jdplotgtk_ bind 'clip'
plotdemo_print_button=: 0:

NB. =========================================================
plotdemo_next_button=: plotdemo_step bind 1
plotdemo_prev_button=: plotdemo_step bind _1
plotdemo_f10_fkey=: plotdemo_saveeps_button
plotdemo_f11_fkey=: plotdemo_savepdf_button
plotdemo_f12_fkey=: plotdemo_next_button
plotdemo_f12shift_fkey=: plotdemo_prev_button

plotdemo=: plotdemo_run
