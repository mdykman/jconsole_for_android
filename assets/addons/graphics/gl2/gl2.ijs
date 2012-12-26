require 'gui/android gui/gtk graphics/color/rgb'
require^:(IFWIN>IFQT) 'api/gdi32'

coclass 'jgl2'


create=: destroy=: [:

locGL2=: 0$<''

3 : 0''
if. 0~: 4!:0 <'PROFONT_z_' do. PROFONT=: IFUNIX{::'Tahoma 10'; ('Android'-:UNAME){::'Sans 10';'Sans 10' else. PROFONT=: PROFONT_z_ end.
if. 0~: 4!:0 <'FIXFONT_z_' do. FIXFONT=: IFUNIX{::'"Lucida Console" 10' ; ('Android'-:UNAME){::'mono 10';'monospace 10' else. FIXFONT=: FIXFONT_z_ end.
if. 0~: 4!:0 <'GL2Backend_j_' do. GL2Backend_j_=: 0 end.
if. 0~: 4!:0 <'GL2ExtGlcmds_j_' do. GL2ExtGlcmds_j_=: 1 end.

if. IFQT do.
  GL2Backend=: 3
  GL2ExtGlcmds=: GL2ExtGlcmds_j_
  locGL2_jgl2_=: <'jglcanvas'
elseif. 'Android'-:UNAME do.
  GL2Backend=: 2
  GL2ExtGlcmds=: GL2ExtGlcmds_j_
elseif. do.
  GL2Backend=: (IFWIN > 3 = GTKVER_j_) <. GL2Backend_j_
end.
GL2ExtGlcmds=: GL2ExtGlcmds_j_
EMPTY
)
PS_DASH=: 1
PS_DASHDOT=: 3
PS_DASHDOTDOT=: 4
PS_DOT=: 2
PS_INSIDEFRAME=: 6
PS_NULL=: 5
PS_SOLID=: 0

IDC_ARROW=: 32512
IDC_IBEAM=: 32513
IDC_WAIT=: 32514
IDC_CROSS=: 32515
IDC_UPARROW=: 32516
IDC_SIZENWSE=: 32642
IDC_SIZENESW=: 32643
IDC_SIZEWE=: 32644
IDC_SIZENS=: 32645
IDC_SIZEALL=: 32646
IDC_NO=: 32648
IDC_APPSTARTING=: 32650
IDC_HELP=: 32651
glarc_n=: 2001
glbrush_n=: 2004
glbrushnull_n=: 2005
glcapture_n=: 2062
glcaret_n=: 2065
glclear_n=: 2007
glclip_n=: 2078
glclipreset_n=: 2079
glcmds_n=: 2999
glcursor_n=: 2069
glellipse_n=: 2008
glemfopen_n=: 2084
glemfclose_n=: 2085
glemfplay_n=: 2086
glfile_n=: 2066
glfont_n=: 2012
gllines_n=: 2015
glnodblbuf_n=: 2070
glpaint_n=: 2020
glpaintx_n=: 2021
glpen_n=: 2022
glpie_n=: 2023
glpixel_n=: 2024
glpixelsx_n=: 2075
glpixels_n=: 2076
glprint_n=: 2089
glprintmore_n=: 2091
glpolygon_n=: 2029
glqextent_n=: 2057
glqextentw_n=: 2083
glqpixels_n=: 2077
glqprintpaper_n=: 2092
glqprintwh_n=: 2088
glqtextmetrics_n=: 2058
glqwh_n=: 2059
glqhandles_n=: 2060
glrect_n=: 2031
glrgb_n=: 2032
glroundr_n=: 2033
glsel_n=: 2035
gltext_n=: 2038
gltextcolor_n=: 2040
gltextxy_n=: 2056
glwindoworg_n=: 2045

glbkmode_n=: 2003
glnoerasebkgnd_n=: 2071

glfont2_n=: 2312
glfontangle_n=: 2342
3 : 0''
if. (-.IFQT) *. 'Android'-.@-:UNAME do.
  kbBS=: GDK_BackSpace_jgtk_
  kbLF=: GDK_Linefeed_jgtk_
  kbENTER=: GDK_Return_jgtk_
  kbPUP=: GDK_Page_Up_jgtk_
  kbPDOWN=: GDK_Page_Down_jgtk_
  kbEND=: GDK_End_jgtk_
  kbHOME=: GDK_Home_jgtk_
  kbLEFT=: GDK_Left_jgtk_
  kbUP=: GDK_Up_jgtk_
  kbRIGHT=: GDK_Right_jgtk_
  kbDOWN=: GDK_Down_jgtk_
  kbESC=: GDK_Escape_jgtk_
  kbINS=: GDK_Insert_jgtk_
  kbDEL=: GDK_Delete_jgtk_
else.
  kbBS=: 0
  kbLF=: 0
  kbENTER=: 0
  kbPUP=: 0
  kbPDOWN=: 0
  kbEND=: 0
  kbHOME=: 0
  kbLEFT=: 0
  kbUP=: 0
  kbRIGHT=: 0
  kbDOWN=: 0
  kbESC=: 0
  kbINS=: 0
  kbDEL=: 0
end.
EMPTY
)
glarc=: 3 : 'glarc__l y [[ l=. locGL2_jgl2_'
glarcx=: 3 : 'glarcx__l y [[ l=. locGL2_jgl2_'
glbrush=: 3 : 'glbrush__l y [[ l=. locGL2_jgl2_'
glbrushnull=: 3 : 'glbrushnull__l y [[ l=. locGL2_jgl2_'
glcapture=: 3 : 'glcapture__l y [[ l=. locGL2_jgl2_'
glcaret=: 3 : 'glcaret__l y [[ l=. locGL2_jgl2_'
glclear=: 3 : 'glclear__l y [[ l=. locGL2_jgl2_'
glclip=: 3 : 'glclip__l y [[ l=. locGL2_jgl2_'
glclipreset=: 3 : 'glclipreset__l y [[ l=. locGL2_jgl2_'
glcmds=: 3 : 'glcmds__l y [[ l=. locGL2_jgl2_'
glcmds=: 3 : 'glcmds__l y [[ l=. locGL2_jgl2_'
glcursor=: 3 : 'glcursor__l y [[ l=. locGL2_jgl2_'
glellipse=: 3 : 'glellipse__l y [[ l=. locGL2_jgl2_'
glemfclose=: 3 : 'glemfclose__l y [[ l=. locGL2_jgl2_'
glemfopen=: 3 : 'glemfopen__l y [[ l=. locGL2_jgl2_'
glemfplay=: 3 : 'glemfplay__l y [[ l=. locGL2_jgl2_'
glfile=: 3 : 'glfile__l y [[ l=. locGL2_jgl2_'
glfont=: 3 : 'glfont__l y [[ l=. locGL2_jgl2_'
glfontangle=: 3 : 'glfontangle__l y [[ l=. locGL2_jgl2_'
gllines=: 3 : 'gllines__l y [[ l=. locGL2_jgl2_'
glnodblbuf=: 3 : 'glnodblbuf__l y [[ l=. locGL2_jgl2_'
glpaint=: 3 : 'glpaint__l y [[ l=. locGL2_jgl2_'
glpaintx=: 3 : 'glpaintx__l y [[ l=. locGL2_jgl2_'
glpen=: 3 : 'glpen__l y [[ l=. locGL2_jgl2_'
glpie=: 3 : 'glpie__l y [[ l=. locGL2_jgl2_'
glpixel=: 3 : 'glpixel__l y [[ l=. locGL2_jgl2_'
glpixels=: 3 : 'glpixels__l y [[ l=. locGL2_jgl2_'
glpixelsx=: 3 : 'glpixelsx__l y [[ l=. locGL2_jgl2_'
glpolygon=: 3 : 'glpolygon__l y [[ l=. locGL2_jgl2_'
glprint=: 3 : 'glprint__l y [[ l=. locGL2_jgl2_'
glprintmore=: 3 : 'glprintmore__l y [[ l=. locGL2_jgl2_'
glqextent=: 3 : 'glqextent__l y [[ l=. locGL2_jgl2_'
glqextentw=: 3 : 'glqextentw__l y [[ l=. locGL2_jgl2_'
glqhandles=: 3 : 'glqhandles__l y [[ l=. locGL2_jgl2_'
glqpixels=: 3 : 'glqpixels__l y [[ l=. locGL2_jgl2_'
glqprintpaper=: 3 : 'glqprintpaper__l y [[ l=. locGL2_jgl2_'
glqprintwh=: 3 : 'glqprintwh__l y [[ l=. locGL2_jgl2_'
glqtextmetrics=: 3 : 'glqtextmetrics__l y [[ l=. locGL2_jgl2_'
glqwh=: 3 : 'glqwh__l y [[ l=. locGL2_jgl2_'
glrect=: 3 : 'glrect__l y [[ l=. locGL2_jgl2_'
glrgb=: 3 : 'glrgb__l y [[ l=. locGL2_jgl2_'
glroundr=: 3 : 'glroundr__l y [[ l=. locGL2_jgl2_'
glsetbrush=: 3 : 'glsetbrush__l y [[ l=. locGL2_jgl2_'
glsetlocale=: 3 : 'glsetlocale__l y [[ l=. locGL2_jgl2_'
glsetpen=: 3 : 'glsetpen__l y [[ l=. locGL2_jgl2_'
gltext=: 3 : 'gltext__l y [[ l=. locGL2_jgl2_'
gltextcolor=: 3 : 'gltextcolor__l y [[ l=. locGL2_jgl2_'
gltextxy=: 3 : 'gltextxy__l y [[ l=. locGL2_jgl2_'
glwindoworg=: 3 : 'glwindoworg__l y [[ l=. locGL2_jgl2_'
glbuf=: 3 : 'glbuf__l y [[ l=. locGL2_jgl2_'
glmark=: 3 : 'glmark__l y [[ l=. locGL2_jgl2_'
glqmark=: 3 : 'glqmark__l y [[ l=. locGL2_jgl2_'
gltrash=: 3 : 'gltrash__l y [[ l=. locGL2_jgl2_'
glcanvas=: 0&$: : (4 : 0)
'wh l'=. 2{.y
if. 0=#>l do.
  l=. coname''
  if. l-:<'jgl2' do.
    'missing parent locale' 13!:8[3
  end.
else.
  l=. boxxopen l
end.
assert. -. ''-:l
assert. wh>0
locGL2_jgl2_=: b=. (wh,x) conew 'jglcanvas'
PLocale__b=: l
canvas__b
)
glsel=: 3 : 0
if. IFQT do.
  if. 2 131072 e.~ 3!:0 y do.
    if. ({.y) e. '_0123456789' do.
      qt_glsel_jglcanvas_ <.0".y return.
    else.
      qt_glsel2_jglcanvas_ utf8 y return.
    end.
  else.
    qt_glsel_jglcanvas_ <.y return.
  end.
end.
l=. glgetloc y
if. 0= #>l do. EMPTY return. end.
locGL2_jgl2_=: l
if. iOPENGL_jglcanvas_=gloption__l do.
  ogl=. ogl__l
  current__ogl canvas__l
end.
EMPTY
)
glgetloc=: 3 : 0
l=. 0$<''
assert. 1 2 4 8 131072 e.~ 3!:0 y
if. 2 131072 e.~ 3!:0 y do.
  if. ({.y) e. '_0123456789' do.
    y=. <. {. 0". y
  else.
    if. 3 = 4!:0 <'getlocgl2_gtkwd_' do.
      l=. getlocgl2_gtkwd_ ,y
    elseif. 3 = 4!:0 <'getlocgl2_droidwd_' do.
      l=. getlocgl2_droidwd_ ,y
    end.
  end.
end.
if. 1 4 8 e.~ 3!:0 y do.
  if. 1 e. b=. (y = >0{"1 canvaslocale_jglcanvas_) do.
    ix=. {.I.b
    l=. (<ix,1){canvaslocale_jglcanvas_
  end.
end.
l
)

coclass'jglcanvas'

RGBA=: 3 : 'r (23 b.) 8 (33 b.) g (23 b.) 8 (33 b.) b (23 b.) 8 (33 b.) a [ ''r g b a''=. <.y'
BGRA=: 3 : 'b (23 b.) 8 (33 b.) g (23 b.) 8 (33 b.) r (23 b.) 8 (33 b.) a [ ''r g b a''=. <.y'

3 : 0''
if. -.IFQT do. libjqt=: '' end.
if. IFQT do.
  coinsert'jqt'
elseif. 'Android'-:UNAME do.
  coinsert'jni jaresu'
  if. 0~: 4!:0 <'CANVASIDN' do. CANVASIDN=: 1000 end.
elseif. do.
  coinsert'jgtk'
end.
so=. ''
if. IFWIN do.
  if. -. IFQT do.
    coinsert 'jgdi32'
    so=. 'libglcmds',((-.IF64)#'_32'),'.dll'
  end.
elseif. IFQT do.
elseif. 'Android'-:UNAME do.
elseif. do.
  if. 3=GTKVER_j_ do.
    so=. 'libglcmds',((-.IF64)#'_32'),(UNAME-:'Darwin'){::'.so';'3.dylib'
  else.
    so=. 'libglcmds',((-.IF64)#'_32'),(UNAME-:'Darwin'){::'.so';'.dylib'
  end.
end.
LIBGLCMDS=: ''
if. #so do.
  if. fexist f=. jpath '~addons/graphics/gl2/',so do.
    LIBGLCMDS=: f
  elseif. fexist f=. jpath '~tools/',so do.
    LIBGLCMDS=: f
  elseif. fexist f=. jpath '~bin/',so do.
    LIBGLCMDS=: f
  end.
  LIBGLCMDS=: dquote^:(' 'e.]) LIBGLCMDS
end.
EMPTY
)

jniImport ::0:^:('Android'-:UNAME) (0 : 0)
android.content.Context
android.graphics.Bitmap
android.graphics.Bitmap$Config
android.graphics.Canvas
android.graphics.Paint
android.graphics.Paint$FontMetrics
android.graphics.Path
android.graphics.Rect
android.graphics.Typeface
android.view.View
android.view.View$OnTouchListener
android.view.Window
)

'iGL2 iOPENGL'=: i.2

initialized=: 0
nodoublebuf=: 0
gloption=: iGL2
PLocale=: PLocalec=: 0$<''
gtkcr=: gtkpl=: gtkplc=: 0

gtkclipped=: gtkrgb=: gtkfontangle=: gtkunderline=: gtkorgx=: gtkorgy=: 0
gtktextxy=: 0 0
gtkpenrgb=: gtkbrushrgb=: gtktextrgb=: gtkbrushnull=: 0
HDC=: BMP=: PEN=: BRUSH=: FONT=: OLDPEN=: OLDBRUSH=: OLDFONT=: 0
qtpenrgb=: qtbrushrgb=: qttextrgb=: RGBA 0 0 0 255
qtbrushnull=: 0
qtcr=: qtpl=: qtplc=: 0
qtclipped=: qtrgb=: qtfontangle=: qtunderline=: qtorgx=: qtorgy=: 0
qttextxy=: 0 0
qtcs1=: 0
qtcs=: qtpt=: 0
andpenrgb=: andbrushrgb=: andtextrgb=: RGBA 0 0 0 255
andbrushnull=: 0
andcr=: andpl=: andplc=: 0
andclipped=: andrgb=: andfontangle=: andunderline=: andorgx=: andorgy=: 0
andtextxy=: 0 0
andcs1=: 0
andcs=: andpt=: path=: ontouchlistener=: 0
andbm=: 0
PContext=: 0
printoperation=: printcontext=: 0
twipscaled=: 2$1%1
printnpage=: 1
async_print=: IFUNIX
printsettings=: 0
ogl=: 0$<''
newctx=: 1
newsize=: 1
stash_state=: 0
stash_buf=: 0$0
canvaslocale=: 0 2$<''
create=: 3 : 0
if. IFQT do.

elseif. 'Android'-:UNAME do.
  'w h option context'=. 4{.y
  assert. 0~: context
  idn=. CANVASIDN_jglcanvas_=: >:CANVASIDN_jglcanvas_
  jniCheck view=: context jniOverride 'org.dykman.jn.android.view.View LContext;' ; (>coname'') ; 'view' ; 'onDraw onLayout onDetachedFromWindow'
  jniCheck view ('setId (I)V' jniMethod)~ idn
  canvas=: idn
  Activity=: context
  andwh=: w,h
  gloption=: option
  jniCheck view ('setFocusable (Z)V' jniMethod)~ 1

  if. iOPENGL=gloption do.
    ogl=: '' conew 'jzopengl'
  else.
    jniCheck path=: NewGlobalRef <a1=. 'android/graphics/Path' jniNewObject~ ''
    jniCheck andpt=: NewGlobalRef <a2=. 'android.graphics.Paint' jniNewObject~ ''
    jniCheck ontouchlistener=: NewGlobalRef <a3=. '' jniOverride 'org.dykman.jn.android.view.View$OnTouchListener' ; (>coname'') ; 'view'
    jniCheck DeleteLocalRef"0 a1;a2;a3
    jniCheck view ('setOnTouchListener (LView$OnTouchListener;)V' jniMethod)~ ontouchlistener
  end.
  canvaslocale_jglcanvas_=: ~. canvaslocale_jglcanvas_, canvas;coname''
  0
elseif. do.
  'w h option'=. 3{.y
  canvas=: gtk_drawing_area_new''
  gtkwh=: w,h
  gloption=: option

  gtk_widget_set_double_buffered canvas, -.nodoublebuf
  if. *./ 0<w,h do.
    gtk_widget_set_size_request canvas,w,h
  end.
  gtk_widget_set_can_focus ::0: canvas,1
  events=. GDK_EXPOSURE_MASK,GDK_BUTTON_PRESS_MASK,GDK_BUTTON_RELEASE_MASK,GDK_POINTER_MOTION_MASK,GDK_KEY_PRESS_MASK,GDK_KEY_RELEASE_MASK,GDK_FOCUS_CHANGE_MASK
  gtk_widget_add_events canvas, OR events

  consig3 canvas;'configure-event';'configure_event'
  if. 3=GTKVER_j_ do.
    consig3 canvas;'draw';'draw'
  else.
    consig3 canvas;'expose-event';'expose_event'
  end.
  consig3 canvas;'button-press-event';'button_press_event'
  consig3 canvas;'button-release-event';'button_release_event'
  consig3 canvas;'motion-notify-event';'motion_notify_event'
  consig3 canvas;'scroll-event';'scroll_event'
  consig3 canvas;'key-press-event';'key_press_event'
  consig3 canvas;'focus-in-event';'focus_in_event'
  consig3 canvas;'focus-out-event';'focus_out_event'
  consig canvas;'destroy';'destroy_event'

  if. iOPENGL=gloption do.
    ogl=: '' conew 'jzopengl'
  end.
  canvaslocale_jglcanvas_=: ~. canvaslocale_jglcanvas_, canvas;coname''
  gtk_widget_show canvas

  0
end.
)
destroy=: 3 : 0
if. (iOPENGL=gloption) *. *#ogl do.
  destroy__ogl ''
end.
if. IFQT do.
elseif. 'Android'-:UNAME do.
  jniCheck DeleteGlobalRef"0 path;andpt;ontouchlistener
elseif. do.
  cbfree ''
end.
codestroy''
0
)
PS_DASH=: 1
PS_DASHDOT=: 3
PS_DASHDOTDOT=: 4
PS_DOT=: 2
PS_INSIDEFRAME=: 6
PS_NULL=: 5
PS_SOLID=: 0

IDC_ARROW=: 32512
IDC_IBEAM=: 32513
IDC_WAIT=: 32514
IDC_CROSS=: 32515
IDC_UPARROW=: 32516
IDC_SIZENWSE=: 32642
IDC_SIZENESW=: 32643
IDC_SIZEWE=: 32644
IDC_SIZENS=: 32645
IDC_SIZEALL=: 32646
IDC_NO=: 32648
IDC_APPSTARTING=: 32650
IDC_HELP=: 32651
button_event=: 3 : 0
'widget event data'=. y
'lmr evt mousex mousey dir state'=. gtkeventmouse event
assert. lmr e. 1 2 3
n=. ,lmr{' lmr'
assert. evt e. 4 5 7
x=. ,>(4 5 7 i. evt){'down';'dbl';'up'
name=. 'mb',n,x
'shift lock control mod1 mod2 mod3 mod4 mod5 button1 button2 button3 button4 button5'=. 13{. |.(32#2) #: state
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      rc=. ('jglcanvas';(coname''),<y) (f~) name; (mousex,mousey,gtkwh,button1,button2,control,shift,button3,0,0,0) ; shift+2*control
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
0
)
button_press_event=: button_event
button_release_event=: button_event
scroll_event=: 3 : 0
'widget event data'=. y
'lmr evt mousex mousey dir state'=. gtkeventmouse event
'shift lock control mod1 mod2 mod3 mod4 mod5 button1 button2 button3 button4 button5'=. 13{. |.(32#2) #: state
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      rc=. ('jglcanvas';(coname''),<y) (f~) 'mwheel'; (mousex,mousey,gtkwh,button1,button2,control,shift,button3,0,0,1-2*dir) ; shift+2*control
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
0
)
motion_notify_event=: 3 : 0
'widget event gpointer'=. y
'lmr evt mousex mousey dir state'=. gtkeventmouse event
'shift lock control mod1 mod2 mod3 mod4 mod5 button1 button2 button3 button4 button5'=. 13{. |.(32#2) #: state
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      rc=. ('jglcanvas';(coname''),<y) (f~) 'mmove'; (mousex,mousey,gtkwh,button1,button2,control,shift,button3,0,0,0) ; shift+2*control
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
0
)
key_press_event=: 3 : 0
'widget event data'=. y
'state key'=. gtkeventkey event
'control j shift'=. 2 2 2 #: state
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      rc=. ('jglcanvas';(coname''),<y) (f~) 'char'; (utf8 u: key) ; shift+2*control
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl 0 [ show__ogl widget
      end.
      1 return.
    end.
  end.
end.
0
)
focus_in_event=: 3 : 0
'widget event data'=. y
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      rc=. ('jglcanvas';(coname''),<y) (f~) ,<'focus'
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
1
)
focus_out_event=: 3 : 0
'widget event data'=. y
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      rc=. ('jglcanvas';(coname''),<y) (f~) ,<'focuslost'
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
1
)
configure_event=: 3 : 0
'widget event data'=. y
gtkwh=: _2{. getGtkWidgetAllocation widget
gtkwin=: getGtkWidgetWindow widget
newsize=: 1
if. (iOPENGL=gloption) *. *#ogl do.
  wh__ogl=: gtkwh
  if. #>PLocale do.
    if. (0: <: 18!:0) PLocale do.
      openglut_newsize__PLocale=: 1
    end.
  end.
  if. OsMesa_jzopengl_ do. free__ogl widget end.
  if. 0= ctx=. getglctx__ogl widget do.
    ctx=. alloc__ogl widget
    newctx=: 1
  end.
  if. 0= ctx do. smoutput 'cannot alloc opengl context' end.
end.
if. iOPENGL~:gloption do.
  if. 0=GL2Backend_jgl2_ do.
    if. 0~:gtkpl do. gtkpl=: 0 [ g_object_unref gtkpl end.
    if. 0~:gtkplc do. gtkplc=: 0 [ g_object_unref gtkplc end.
    if. 0~:gtkcr do. gtkcr=: 0 [ cairo_destroy gtkcr end.
    if. nodoublebuf do.
      gtkcr=: gdk_cairo_create getGtkWidgetWindow widget
    else.
      gtkcr=: cairo_create surface=. cairo_image_surface_create CAIRO_FORMAT_RGB24,gtkwh
      cairo_surface_destroy surface
    end.
    gtkplc=: pango_cairo_create_context gtkcr
    gtkpl=: pango_layout_new gtkplc
    cairo_glclear''
  elseif. 1=GL2Backend_jgl2_ do.
    if. 0~:HDC do. gdi32_free '' end.
    gdi32_init gtkwh
    assert. 0~:HDC,BMP
    gdi32_glclear''
  end.
end.
initialized=: 1
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
    end.
  end.
end.
0
)
draw=: expose_event=: 3 : 0
'widget event data'=. y
gtkwh=: _2{. getGtkWidgetAllocation widget
gltrash''
if. (iOPENGL=gloption) *. *#ogl do.
  current__ogl widget
end.
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      rc=. ('jglcanvas';(coname''),<y) (f~) ,<'paint'
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.

if. iOPENGL~:gloption do.
  if. 0=GL2Backend_jgl2_ do.
    gltrash @: cairo_glpaint''
    if. 3=GTKVER_j_ do.
      if. -.nodoublebuf do.
        cr=. event
        cairo_set_operator cr, CAIRO_OPERATOR_SOURCE
        cairo_set_source_surface cr; (cairo_get_target gtkcr); 0 ; 0
        cairo_paint cr
      end.
    else.
      if. -.nodoublebuf do.
        cr=. gdk_cairo_create getGtkWidgetWindow widget
        cairo_set_operator cr, CAIRO_OPERATOR_SOURCE
        cairo_set_source_surface cr; (cairo_get_target gtkcr); 0 ; 0
        cairo_rectangle cr; 0 ;0; <"0 gtkwh
        cairo_clip cr
        cairo_paint cr
        cairo_destroy cr
      end.
    end.
  elseif. 1=GL2Backend_jgl2_ do.
    gltrash @: gdi32_glpaint''
    arbg=. gdi32_glqpixels 0 0,gtkwh
    gtkwin pixbufwin_setpixels 0 0,gtkwh,argb
  end.
end.
0
)
destroy_event=: 3 : 0
'widget data'=. y

if. (iOPENGL=gloption) *. *#ogl do.
  current__ogl 0 [ removectx__ogl widget
end.
if. iOPENGL~:gloption do.
  if. 0=GL2Backend_jgl2_ do.
    if. 0~:gtkpl do. gtkpl=: 0 [ g_object_unref gtkpl end.
    if. 0~:gtkplc do. gtkplc=: 0 [ g_object_unref gtkplc end.
    if. 0~:gtkcr do. gtkcr=: 0 [ cairo_destroy gtkcr end.
  elseif. 1=GL2Backend_jgl2_ do.
    if. 0~:HDC do. gdi32_free '' end.
  end.
end.
if. 1 e. b=. (widget  = >0{"1 canvaslocale_jglcanvas_) do.
  ix=. {.I.b
  canvaslocale_jglcanvas_=: (<<<ix){canvaslocale_jglcanvas_
end.
destroy ''
0
)
draw_page=: 3 : 0
'operation context page_nr data'=. y
assert. iOPENGL~:gloption
gtkcr=: gtk_print_context_get_cairo_context context
gtkplc=: gtk_print_context_create_pango_context context
gtkpl=: pango_layout_new gtkplc
w=. <. gtk_print_context_get_width context
h=. <. gtk_print_context_get_height context
gtkwh=: w,h
gtkclipped=: 0
glclear''
print__PLocale ''
gtkpl=: 0 [ g_object_unref gtkpl
gtkplc=: 0 [ g_object_unref gtkplc
gtkcr=: 0
0
)

begin_print=: 3 : 0
'operation context data'=. y
assert. iOPENGL~:gloption
gtk_print_operation_set_n_pages operation, 1
0
)
print_begin=: 3 : 0
'operation context data'=. y
assert. iOPENGL~:gloption
printcontext=: context
printoperation=: operation
gtkcr=: gtk_print_context_get_cairo_context context
gtkplc=: gtk_print_context_create_pango_context context
gtkpl=: pango_layout_new gtkplc
w=. <. gtk_print_context_get_width context
h=. <. gtk_print_context_get_height context
gtkwh=: w,h
dpix=: <. gtk_print_context_get_dpi_x context
dpiy=: <. gtk_print_context_get_dpi_y context
twipscaled=: 1440 %~ dpix,dpiy
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      rc=. ('jglcanvas';(coname''),<y) (f~) 'print'; ":0 0
    end.
  end.
end.
printoperation=: printcontext=: 0
gtkpl=: 0 [ g_object_unref gtkpl
gtkplc=: 0 [ g_object_unref gtkplc
gtkcr=: 0
if. 0< printnpage do.
  gtk_print_operation_set_n_pages operation, printnpage
else.
  gtk_print_operation_cancel operation
end.
0
)
print_draw=: 3 : 0
'operation context page_nr data'=. y
assert. iOPENGL~:gloption
printcontext=: context
printoperation=: operation
gtkcr=: gtk_print_context_get_cairo_context context
gtkplc=: gtk_print_context_create_pango_context context
gtkpl=: pango_layout_new gtkplc
w=. <. gtk_print_context_get_width context
h=. <. gtk_print_context_get_height context
gtkwh=: w,h
gtkclipped=: 0
glclear''
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      rc=. ('jglcanvas';(coname''),<y) (f~) 'print'; ":page_nr, 1
    end.
  end.
end.
printoperation=: printcontext=: 0
gtkpl=: 0 [ g_object_unref gtkpl
gtkplc=: 0 [ g_object_unref gtkplc
gtkcr=: 0
0
)
print_done=: 3 : 0
'operation res data'=. y
assert. iOPENGL~:gloption
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      rc=. ('jglcanvas';(coname''),<y) (f~) 'print'; ":0 _1
    end.
  end.
end.
if. res= GTK_PRINT_OPERATION_RESULT_APPLY do.
  if. 0~:printsettings do. g_object_unref printsettings end.
  printsettings_jglcanvas_=: gtk_print_settings_copy gtk_print_operation_get_print_settings operation
end.
g_object_unref operation
printoperation=: printcontext=: 0
0
)
view_onLayout=: 3 : 0
jniCheck changed=. '' ('booleanValue ()Z' jniMethod) ochanged=. GetObjectArrayElement (3{y);0
jniCheck DeleteLocalRef <ochanged
if. 0=changed do. 0 return. end.

if. nodoublebuf do.
  assert. 0=andcs
end.
view=. 2{y
jniCheck w=. view ('getWidth ()I' jniMethod)~ ''
jniCheck h=. view ('getHeight ()I' jniMethod)~ ''
andwh=: w,h
newsize=: 1
if. (iOPENGL=gloption) *. *#ogl do.
  wh__ogl=: droidwh
  if. #>PLocale do.
    if. (0: <: 18!:0) PLocale do.
      openglut_newsize__PLocale=: 1
    end.
  end.
  if. OsMesa_jzopengl_ do. free__ogl widget end.
  if. 0= ctx=. getglctx__ogl widget do.
    ctx=. alloc__ogl widget
    newctx=: 1
  end.
  if. 0= ctx do. smoutput 'cannot alloc opengl context' end.
end.
if. iOPENGL~:gloption do.
  if. -.nodoublebuf do.
    jniCheck DeleteGlobalRef"0 andbm;andcs
    jniCheck andbm=: NewGlobalRef <a1=. 'android.graphics.Bitmap' ('createBitmap (IILBitmap$Config;)LBitmap;' jniStaticMethod)~ <"0 andwh, ARGB_8888
    jniCheck andcs=: NewGlobalRef <a2=. 'android/graphics/Canvas LBitmap;' jniNewObject~ andbm
    assert. 0~:andbm,andcs
    jniCheck DeleteLocalRef"0 a1;a2
  end.
end.
initialized=: 1
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
    end.
  end.
end.
0
)
view_onDraw=: 3 : 0
view=. 2{y
if. nodoublebuf do.
  assert. 0=andcs
end.
if. -.nodoublebuf do.
  andcs0=. jniCheck GetObjectArrayElement (3{y);0
else.
  andcs0=. andbm=: 0
  andcs=: jniCheck GetObjectArrayElement (3{y);0
end.
jniCheck w=. andcs ('getWidth ()I' jniMethod)~ ''
jniCheck h=. andcs ('getHeight ()I' jniMethod)~ ''
andwh=: w,h
and_glclear''
gltrash''
if. (iOPENGL=gloption) *. *#ogl do.
  current__ogl widget
end.
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      rc=. ('jglcanvas';(coname''),<,view) (f~) ,<'paint'
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.

if. iOPENGL~:gloption do.
  gltrash @: and_glpaint''
end.
if. -.nodoublebuf do.
  jniCheck andcs0 ('drawBitmap (LBitmap;FFLPaint;)V' jniMethod)~ andbm;0;0;andpt
  andcs0=. 0 [ jniCheck DeleteLocalRef <andcs0
else.
  andcs=: 0 [ jniCheck DeleteLocalRef <andcs
end.
0
)

ACTION_DOWN=: 0 [ ACTION_UP=: 1 [ ACTION_MOVE=: 2
view_onTouch=: 3 : 0
jniCheck view=. GetObjectArrayElement (3{y);0
jniCheck event=. GetObjectArrayElement (3{y);1
jniCheck action=. event ('getAction ()I' jniMethod)~ ''
jniCheck cx=. <. event ('getX ()F' jniMethod)~ ''
jniCheck cy=. <. event ('getY ()F' jniMethod)~ ''
jniCheck dt=. (event ('getEventTime ()J' jniMethod)~ '') - event ('getDownTime ()J' jniMethod)~ ''
if. action -.@e. ACTION_DOWN,ACTION_UP,ACTION_MOVE do. 0 return. end.
name=. ((ACTION_DOWN,ACTION_UP,ACTION_MOVE ) i. action){::'mbldown';'mblup';'mmove'
if. (dt>500) *. action=ACTION_UP do. name=. 'mbldbl' end.
'shift lock control button1 button2 button3'=. 6#0
button1=. 1
plocale=. {. PLocalec,PLocale
if. #>plocale do.
  if. (0: <: 18!:0) plocale do.
    if. 3= nc <f=. 'isigraph_event_',(>plocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      rc=. ('jglcanvas';(coname''),<view,event) (f~) name; (cx,cy,andwh,button1,button2,control,shift,button3,0,0,0) ; shift+2*control
      if. (iOPENGL=gloption) *. *#ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
1
)
view_onDetachedFromWindow=: 3 : 0
if. (iOPENGL=gloption) *. *#ogl do.
  current__ogl 0 [ removectx__ogl widget
end.
if. iOPENGL~:gloption do.
  if. -.nodoublebuf do.
    jniCheck DeleteGlobalRef"0 <andbm
  end.
  jniCheck DeleteGlobalRef"0 andpt;path;ontouchlistener;onlongtouchlistener
  andcs=: andpt=: andbm=: path=: ontouchlistener=: 0
end.
if. 1 e. b=. (canvas  = >0{"1 canvaslocale_jglcanvas_) do.
  ix=. {.I.b
  canvaslocale_jglcanvas_=: (<<<ix){canvaslocale_jglcanvas_
end.
destroy ''
)
gtkextents=: 4 : 0
p=. mema JINT * 8
pango_layout_get_pixel_extents x,p + 0,JINT * 4
res=. char4toint memr p,0,(4*8),JCHAR
memf p
res
)
gtkextent=: 3 : 0
'p txt font'=. y
glfont font
if. L.txt do.
  |: p gtkextent1 &> txt
else.
  p gtkextent1 ,txt
end.
)
gtkextent1=: 4 : 0
pango_layout_set_text x;y;#y
pango_layout_get_pixel_size x;(w=. ,_1);h=. ,_1
w,h
)
gtkextentink=: 3 : 0
'p txt font'=. y
glfont font
if. L.txt do.
  |: p gtkextentink1 &> txt
else.
  p gtkextentink1 ,txt
end.
)
gtkextentink1=: 4 : 0
pango_layout_set_text x;y;#y
_2 {. gtkextents ''
)

NB cairo gl2
and_glarc=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ STROKE
androidcolor andpt, andpenrgb
'x y r s ang1 ang2'=. android_arcisi y
rectf=. 'android/graphics/RectF FFFF' jniNewObject~ x;y;r;s
andcs ('drawArc (Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V' jniMethod)~ rectf;ang1;ang2;0;andpt
jniCheck DeleteLocalRef <rectf
0
)
and_glbrush=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
andbrushrgb=: andrgb
andbrushnull=: 0
0
)
and_glbrushnull=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
andbrushnull=: 1
0
)
and_glcapture=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
select. cap=. {.y
case. 0 do.
  capture=: cap
case. 1 do.
  capture=: cap
case. 5 do.
  capture=: cap
case. 6 do.
  capture=: cap
case. 7 do.
  capture=: cap
  rect=. }.cap
end.
0
)
and_glcaret=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0 e. _2{.y do. 0 return. end.
assert. 0~:andcs,andpt
0
)
and_glclear=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
andunderline=: 0
andfontangle=: 0
and_glclipreset''
and_glwindoworg - andorgx, andorgy
andorgx=: andorgy=: 0
and_glrgb 255 255 255
and_glpen 1 0
and_glbrush''
and_glrect 0 0,andwh
and_glbrushnull''
and_glrgb 0 0 0
and_glpen 1 0
and_gltextcolor''
and_glfont PROFONT_jgl2_
and_glfontangle 0
and_gltextxy 0 0
0
)
and_glclip=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
andclipped=: 1
0
)
and_glclipreset=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. andclipped do.
  if. 0~:andcs do.
  end.
end.
andclipped=: 0
0
)
and_glcmds=: 3 : 0"1
if. 0=#y do. 0 return. end.
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
if. 1[GL2ExtGlcmds_jgl2_ do.
  jniCheck jbuf=. NewIntArray <#y=. <.y
  jniCheck SetIntArrayRegion jbuf; 0; (#y); y
  ipar=. andclipped,andwh,andrgb,andtextxy,andunderline,andfontangle,andpenrgb,andbrushrgb,andtextrgb,andbrushnull,andorgx,andorgy,nodoublebuf
  assert. 15=#ipar
  jniCheck ibuf=. NewIntArray <#ipar
  jniCheck SetIntArrayRegion ibuf; 0; (#ipar); ipar
  jniCheck glc=. 'org/dykman/jn/Glcmds' jniNewObject~ ''
  jniCheck glcmdsrc=. glc ('glcmds (LCanvas;LPaint;LPath;[ILString;[III)I' jniMethod)~ andcs;andpt;path;ibuf;(utf8 PROFONT_jgl2_);jbuf;(#y);RGBSEQ_j_

  jniCheck GetIntArrayRegion ibuf; 0; (#ipar); ipar=. 15#2-2
  'clip andw andh rgb tx ty underline angle penrgb brushrgb textrgb brushnull orgx orgy no_doublebuf'=. ipar
  andclipped=: clip [ andwh=: andw,andh [ andrgb=: rgb [ andtextxy=: tx,ty [ andunderline=: underline [ andfontangle=: angle
  andpenrgb=: penrgb [ andbrushrgb=: brushrgb [ andtextrgb=: textrgb [ andbrushnull=: brushnull [ andorgx=: orgx ] andorgy=: orgy [ nodoublebuf=: no_doublebuf

  jniCheck DeleteLocalRef"0 jbuf;ibuf;glc
  0 return.
end.
p=. 0
while. p<#y do.
  cnt=. p{y
  cmd=. (1+p){y
  dat=. (2+p+i.cnt-2){y
  select. cmd
  case. glarc_n_jgl2_ do. and_glarc dat
  case. glbkmode_n_jgl2_ do. ''
  case. glbrush_n_jgl2_ do. and_glbrush dat
  case. glbrushnull_n_jgl2_ do. and_glbrushnull dat
  case. glcapture_n_jgl2_ do. ''
  case. glcaret_n_jgl2_ do. and_glcaret dat
  case. glclear_n_jgl2_ do. and_glclear dat
  case. glclip_n_jgl2_ do. and_glclip dat
  case. glclipreset_n_jgl2_ do. and_glclipreset dat
  case. glcmds_n_jgl2_ do. ''
  case. glcursor_n_jgl2_ do. ''
  case. glellipse_n_jgl2_ do. and_glellipse dat
  case. glemfclose_n_jgl2_ do. and_glemfclose dat
  case. glemfopen_n_jgl2_ do. and_glemfopen dat
  case. glemfplay_n_jgl2_ do. and_glemfplay dat
  case. glfile_n_jgl2_ do. and_glfile dat{a.
  case. glfont_n_jgl2_ do. and_glfont dat{a.
  case. glfont2_n_jgl2_ do. and_glfont2 dat
  case. glfontangle_n_jgl2_ do. and_glfontangle dat
  case. gllines_n_jgl2_ do. and_gllines dat
  case. glnodblbuf_n_jgl2_ do. ''
  case. glnoerasebkgnd_n_jgl2_ do. ''
  case. glpaint_n_jgl2_ do. ''
  case. glpaintx_n_jgl2_ do. ''
  case. glpen_n_jgl2_ do. and_glpen dat
  case. glpie_n_jgl2_ do. and_glpie dat
  case. glpixel_n_jgl2_ do. and_glpixel dat
  case. glpixels_n_jgl2_ do. and_glpixels dat
  case. glpixelsx_n_jgl2_ do. and_glpixelsx dat
  case. glpolygon_n_jgl2_ do. and_glpolygon dat
  case. glprint_n_jgl2_ do. ''
  case. glprintmore_n_jgl2_ do. ''
  case. glqextent_n_jgl2_ do. ''
  case. glqextentw_n_jgl2_ do. ''
  case. glqhandles_n_jgl2_ do. ''
  case. glqpixels_n_jgl2_ do. ''
  case. glqprintpaper_n_jgl2_ do. ''
  case. glqprintwh_n_jgl2_ do. ''
  case. glqtextmetrics_n_jgl2_ do. ''
  case. glqwh_n_jgl2_ do. ''
  case. glrect_n_jgl2_ do. and_glrect dat
  case. glrgb_n_jgl2_ do. and_glrgb dat
  case. glroundr_n_jgl2_ do. and_glroundr dat
  case. glsel_n_jgl2_ do. ''
  case. gltext_n_jgl2_ do. and_gltext dat{a.
  case. gltextcolor_n_jgl2_ do. and_gltextcolor dat
  case. gltextxy_n_jgl2_ do. and_gltextxy dat
  case. glwindoworg_n_jgl2_ do. and_glwindoworg dat
  case. do.
    ('un-implemented glcmds ', ":cmd) 13!:8[3
  end.
  p=. p+cnt
end.
0
)
and_glcursor=: 3 : 0 "1
0
)
and_glellipse=: 3 : 0"1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ FILL
androidcolor andpt, andbrushrgb
'x y r s ang1 ang2'=. android_arcisi (4#0),~ y
rectf=. 'android/graphics/RectF FFFF' jniNewObject~ x;y;r;s
andcs ('drawOval (Landroid/graphics/RectF;Landroid/graphics/Paint;)V' jniMethod)~ rectf;andpt

andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ STROKE
androidcolor andpt, andpenrgb
andcs ('drawOval (Landroid/graphics/RectF;Landroid/graphics/Paint;)V' jniMethod)~ rectf;andpt
jniCheck DeleteLocalRef <rectf
0
)
and_glfont=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andpt
if. 0=#y=. ,y do. return. end.
'face size style degree'=. parseFontSpec y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
andfontangle=: <.degree*10
andunderline=: Underline
jniCheck ft=. 'android.graphics.Typeface' ('create (LString;I)LTypeface;' jniStaticMethod)~ face;(Bold + 2*Italic)
jniCheck andpt ('setTypeface (LTypeface;)LTypeface;' jniMethod)~ ft
jniCheck andpt ('setTextSize (F)V' jniMethod)~ (96%72) * size
jniCheck DeleteLocalRef <ft
0
)
and_glfont2=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andpt
'size10 style degree10'=. 3{.y
face=. a.{~3}.y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
andfontangle=: <.degree10
andunderline=: Underline
jniCheck ft=. 'android.graphics.Typeface' ('create (LString;I)LTypeface;' jniStaticMethod)~ face;(Bold + 2*Italic)
jniCheck andpt ('setTypeface (LTypeface;)LTypeface;' jniMethod)~ ft
jniCheck andpt ('setTextSize (F)V' jniMethod)~ (96%72) * size10%10
jniCheck DeleteLocalRef <ft
0
)
and_glfontangle=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
andfontangle=: <.y
0
)
and_glrgb=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
andrgb=: BGRA`RGBA@.RGBSEQ_j_ 255,~ y
0
)
and_gllines=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0=#y=. ,y do. return. end.
assert. 0~:andcs,andpt
androidcolor andpt, andpenrgb
jniCheck andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ STROKE
c=. <.2%~#y
pt=. 2{.y
jniCheck path ('reset ()V' jniMethod)~ ''
jniCheck path ('moveTo (FF)V' jniMethod)~ <"0 pt
for_i. i.c-1 do.
  pt=. (0 1 + 2*1+i){y
  jniCheck path ('lineTo (FF)V' jniMethod)~ (<"0 pt)
end.
jniCheck andcs ('drawPath (Landroid/graphics/Path;Landroid/graphics/Paint;)V' jniMethod)~ path;andpt
jniCheck path ('reset ()V' jniMethod)~ ''
0
)
and_glnodblbuf=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. nodoublebuf~:flag=. 0~:{.y do.
  if. 0=nodoublebuf do.
    andcs=: 0 [ jniCheck DeleteGlobalRef <andcs
    andbm=: 0 [ jniCheck DeleteGlobalRef <andbm
  end.
  if. 0=nodoublebuf=: flag do.
    jniCheck andbm=: 'android.graphics.Bitmap' ('createBitmap (IILBitmap$Config;)LBitmap;' jniStaticMethod)~ <"0 andwh, ARGB_8888
    jniCheck andcs=: 'android/graphics/Canvas LBitmap;' jniNewObject~ andbm
  end.
  and_glclear''
end.
0
)
and_glpaint=: 3 : 0 "1
if. #stash_buf do. stash_buf=: 0$0 [ and_glcmds stash_buf end.
newsize=: 1
if. iOPENGL~:gloption do.
  if. -.nodoublebuf do.
  end.
end.
0
)
and_glpaintx=: 3 : 0 "1
newsize=: 1
jniCheck ocs=. Activity ('findViewById (I)LView;' jniMethod)~ canvas
jniCheck ocs ('invalidate ()V' jniMethod)~ ''
jniCheck DeleteLocalRef <ocs
0
)
and_glpen=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
andpenrgb=: andrgb
penwidth=. 1.3 >.{.y
penstyle=. {:y
jniCheck andpt ('setStrokeWidth (F)V' jniMethod)~ penwidth
0
)
and_glpie=: 3 : 0 "1
andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ FILL
androidcolor andpt, andbrushrgb
'x y r s ang1 ang2'=. android_arcisi y
rectf=. 'android/graphics/RectF FFFF' jniNewObject~ x;y;r;s
andcs ('drawArc (Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V' jniMethod)~ rectf;ang1;ang2;1;andpt
jniCheck DeleteLocalRef <rectf
0
)
and_glpixel=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
androidcolor andpt, andrgb
i=. 0
while. i<#y do.
  andcs 'drawPoint (FFZLandroid/graphics/Paint;)V' jniMethod)~ (<"0 (0 1+i){y), <andpt
  i=. 2+i
end.

0
)
and_glpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
'a b'=. <. twipscaled * 2{.y
'w h1'=. <. 2{.2}.y
h=. |h1
d=. <. 4}.y
if. h1<0 do. d=. ,|.(h,w)$d end.
d=. fliprgb^:(-.RGBSEQ_j_) d
jniCheck colors=. NewIntArray <#d
jniCheck SetIntArrayRegion colors;0;(#d);d
jniCheck andcs ('drawBitmap ([IIIIIIIZLPaint;)V' jniMethod)~ colors;0;w;a;b;w;h;0;andpt
jniCheck DeleteLocalRef <colors
0
)
and_glpixelsx=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
'a b'=. <. twipscaled * 2{.y
'w h1'=. <. 2{.2}.y
da=. <. {:y
h=. |h1
d=. memr da,0,(w*h),JINT
if. h1<0 do. d=. ,|.(h,w)$ d end.
d=. fliprgb^:(-.RGBSEQ_j_) d

jniCheck colors=. NewIntArray <#d
jniCheck SetIntArrayRegion colors;0;(#d);d
jniCheck andcs ('drawBitmap ([IIIIIIIZLPaint;)V' jniMethod)~ colors;0;w;a;b;w;h;0;andpt
jniCheck DeleteLocalRef <colors
0
)
and_glpolygon=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. *./ 0=y do. 0 return. end.
c=. <.-:#y
if. 0=c do. 0 return. end.
assert. 0~:andcs,andpt
c=. <.2%~(#y)-2
path ('reset ()V' jniMethod)~ ''
if. 0 = andbrushnull do.
  pt=. 2{.y
  path ('moveTo (FF)V' jniMethod)~ <"0 pt
  for_i. i.c-1 do.
    pt=. (0 1 + 2*1+i){y
    path ('lineTo (FF)V' jniMethod)~ <"0 pt
  end.
  path ('close ()V' jniMethod)~ ''
  andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ FILL
  androidcolor andpt, andbrushrgb
  andcs ('drawPath (Landroid/graphics/Path;Landroid/graphics/Paint;)V' jniMethod)~ path;andpt
  andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ STROKE
  androidcolor andpt, andpenrgb
  andcs ('drawPath (Landroid/graphics/Path;Landroid/graphics/Paint;)V' jniMethod)~ path;andpt
else.
  pt=. 2{.y
  path ('moveTo (FF)V' jniMethod)~ <"0 pt
  for_i. i.c-1 do.
    pt=. (0 1 + 2*1+i){y
    path ('lineTo (FF)V' jniMethod)~ <"0 pt
  end.
  path ('close ()V' jniMethod)~ ''
  andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ STROKE
  androidcolor andpt, andpenrgb
  andcs ('drawPath (Landroid/graphics/Path;Landroid/graphics/Paint;)V' jniMethod)~ path;andpt
end.
path ('reset ()V' jniMethod)~ ''
0
)
and_glqpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0$0 return. end.
assert. 0~:andcs,andpt
'a b'=. <. twipscaled * 2{.y
'w h'=. <. 2{.2}.y
d=. (w*h)#2-2
if. nodoublebuf do. d return. end.
assert. 0~:andbm

jniCheck colors=. NewIntArray <#d
jniCheck andbm ('getPixels ([IIIIIII)V' jniMethod)~ colors;0;w;a;b;w;h
jniCheck GetIntArrayRegion colors;0;(#d);d
jniCheck DeleteLocalRef <colors

d=. 16bffffff (17 b.) d
d=. fliprgb^:(-.RGBSEQ_j_) d
)
and_glqwh=: 3 : 0"1
andwh
)
and_glrect=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
if. (0 = andbrushnull) do.
  i=. 0
  while. i<#y do.
    androidcolor andpt , andbrushrgb
    andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ FILL
    andcs ('drawRect (FFFFLandroid/graphics/Paint;)V' jniMethod)~ (<"0 tors (0 1 2 3 +i){y), <andpt
    androidcolor andpt, andpenrgb
    andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ STROKE
    andcs ('drawRect (FFFFLandroid/graphics/Paint;)V' jniMethod)~ (<"0 tors (0 1 2 3 +i){y), <andpt
    i=. i+4
  end.
else.
  androidcolor andpt, andpenrgb
  andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ STROKE
  i=. 0
  while. i<#y do.
    andcs ('drawRect (FFFFLandroid/graphics/Paint;)V' jniMethod)~ (<"0 tors (0 1 2 3 +i){y), <andpt
    i=. i+4
  end.
end.
0
)
and_glsetlocale=: 3 : 0
if. PLocale -: <'droidwd' do. 0 return. end.
PLocalec=: boxxopen y
0
)
and_glsetbrush=: and_glbrush @ and_glrgb
and_glsetpen=: and_glpen @ ((1 0 [ and_glrgb) :((2 {. [) and_glrgb))
and_gltext=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:andcs,andpt
androidcolor andpt , andtextrgb
andpt ('setStyle (Landroid/graphics/Paint$Style;)V' jniMethod)~ FILL
'tx ty'=. andtextxy
andcs ('drawText (Ljava/lang/String;FFLandroid/graphics/Paint;)V' jniMethod)~ y;tx;ty;andpt
0
)
and_gltextcolor=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
andtextrgb=: andrgb
0
)
and_gltextxy=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
andtextxy=: <. y
0
)
and_glqextent=: 3 : 0 "1
z=. 1 1
if. iOPENGL=gloption do. z return. end.
assert. 0~:andpt
jniCheck rect=. 'android/graphics/Rect' jniNewObject~ ''
jniCheck andpt ('getTextBounds (LString;IILRect;)V' jniMethod)~ (utf8 y);0;(#ucp y);rect
jniCheck w=. rect ('width ()I' jniMethod)~ ''
jniCheck h=. rect ('height ()I' jniMethod)~ ''
jniCheck DeleteLocalRef <rect
w,h
)
and_glqextentw=: 3 : 0 "1
assert. 0~:andpt
if. iOPENGL=gloption do. 0$0 return. end.
if. 1[ GL2ExtGlcmds_jgl2_ do.
  len=. #@ucp;._2 txt=. y,LF#~LF~:{:y
  jniCheck olen=. NewIntArray <#len
  jniCheck SetIntArrayRegion olen; 0; (#len); len
  jniCheck glc=. 'org/dykman/jn/Glcmds' jniNewObject~ ''
  jniCheck wlen=. glc ('qextentwv (LPaint;LString;[II)[I' jniMethod)~ andpt;(txt-.LF);olen;(#len)
  w=. (#len)$2-2
  jniCheck GetIntArrayRegion wlen;0;(#w);w
  jniCheck DeleteLocalRef"0 olen;wlen;glc
  w
else.
  w=. {. glqextent '8'
  w * #@ucp;._2 txt=. y,LF#~LF~:{:y
end.
)
and_glwindoworg=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
andorgx=: andorgx + <.{.y
andorgy=: andorgy + <.{:y
if. 0~:andcs do.
end.
0
)
and_glqhandles=: 3 : 0 "1
if. 0< #y do. (13!:8) 3 end.
canvas,andcs,0
)
and_glprint=: [:
and_glprintmore=: [:
and_glqprintpaper=: [:
and_glqprintwh=: [:
and_glqtextmetrics=: 3 : 0 "1
if. 0< #y do. (13!:8) 3 end.
assert. 0~:andpt
metrics=. andpt ('getFontMetrics ()LPaint$FontMetrics;' jniMethod)~ ''
asc=. | ('ascend ()LPaint$FontMetrics;' jniField)~ metrics
bottom=. | ('bottom ()LPaint$FontMetrics;' jniField)~ metrics
descent=. | ('descent ()LPaint$FontMetrics;' jniField)~ metrics
leading=. | ('leading ()LPaint$FontMetrics;' jniField)~ metrics
top=. | ('top ()LPaint$FontMetrics;' jniField)~ metrics
jniCheck DeleteLocalRef <metrics
cw=. {. and_glqextent ,'8'
cw1=. {. and_glqextent ,'M'
<. (asc + dsc),asc,dsc,0,leading,cw,cw1
)
and_glemfclose=: [:
and_glemfopen=: [:
and_glemfplay=: [:
and_glfile=: [:
and_glroundr=: [:
and_cleanup=: 3 : 0
EMPTY
)
cairo_glarc=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
t=. gtkbrushnull
gtkbrushnull=: 1
cairo_glarcx cairo_gtkarcisi y
gtkbrushnull=: t
0
)
cairo_glarcx=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
cairo_new_sub_path gtkcr
if. -.gtkbrushnull do.
  cairo_move_to gtkcr ; <"0] 0 1{2}.y
  cairo_cairocolor gtkbrushrgb
  cairo_save gtkcr
  cairo_scale gtkcr ; 1 ; ra=. %~/ 2{.y
  cairo_arc gtkcr ; <"0] (1,ra,1 1 1)%~ 2}.y
  cairo_close_path gtkcr
  cairo_restore gtkcr
  cairo_fill gtkcr
end.
cairo_cairocolor gtkpenrgb
cairo_save gtkcr
cairo_scale gtkcr ; 1 ; ra=. %~/ 2{.y
cairo_arc gtkcr ; <"0] (1,ra,1 1 1)%~ 2}.y
cairo_restore gtkcr
cairo_stroke gtkcr
if. 0~:printcontext do. cairo_restore gtkcr end.
0
)
cairo_glbrush=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkbrushrgb=: gtkrgb
gtkbrushnull=: 0
0
)
cairo_glbrushnull=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkbrushnull=: 1
0
)
cairo_glcapture=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
select. cap=. {.y
case. 0 do.
  capture=: cap
case. 1 do.
  capture=: cap
case. 5 do.
  capture=: cap
case. 6 do.
  capture=: cap
case. 7 do.
  capture=: cap
  rect=. }.cap
end.
0
)
cairo_glcaret=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0 e. _2{.y do. 0 return. end.
assert. 0~:gtkcr,gtkpl
cairo_cairocolor 0
cairo_rectangle gtkcr ; <"0 y
cairo_fill_preserve gtkcr
cairo_cairocolor gtkpenrgb
cairo_stroke gtkcr
0
)
cairo_glclear=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
cairo_glclipreset''
cairo_glwindoworg - gtkorgx, gtkorgy
gtkorgx=: gtkorgy=: 0
cairo_glrgb 255 255 255
cairo_glpen 1 0
cairo_glbrush''
cairo_glrect 0 0,gtkwh
cairo_glbrushnull''
cairo_glrgb 0 0 0
cairo_glpen 1 0
cairo_gltextcolor''
cairo_glfont PROFONT_jgl2_
cairo_glfontangle 0
cairo_gltextxy 0 0
0
)
cairo_glclip=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
gtkclipped=: 1
cairo_save gtkcr
cairo_rectangle gtkcr ; <"0 y
cairo_clip gtkcr
if. 0~:printcontext do. cairo_restore gtkcr end.
0
)
cairo_glclipreset=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
if. gtkclipped do.
  cairo_restore gtkcr
  gtkclipped=: 0
end.
if. 0~:printcontext do. cairo_restore gtkcr end.
0
)
cairo_glcmds=: 3 : 0"1
if. 0=#y do. 0 return. end.
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. GL2ExtGlcmds_jgl2_ *. 0~:#LIBGLCMDS_jglcanvas_ do.
  ipar=. gtkclipped,gtkwh,gtkrgb,gtktextxy,gtkunderline,gtkfontangle,gtkpenrgb,gtkbrushrgb,gtktextrgb,gtkbrushnull,gtkorgx,gtkorgy
  glcmdsrc=. (LIBGLCMDS,' Glcmds_cairo > + i x x *x *c *x x x')&cd gtkcr;gtkpl;ipar;(utf8 PROFONT_jgl2_);(<.,y);(#y);RGBSEQ_j_
  assert. 0= glcmdsrc
  'clip gtkw gtkh rgb tx ty underline angle penrgb brushrgb textrgb brushnull orgx orgy'=. ipar
  gtkclipped=: clip [ gtkrgb=: rgb [ gtktextxy=: tx,ty [ gtkunderline=: underline [ gtkfontangle=: angle
  gtkpenrgb=: penrgb [ gtkbrushrgb=: brushrgb [ gtktextrgb=: textrgb [ gtkbrushnull=: brushnull [ gtkorgx=: orgx ] gtkorgy=: orgy
  0 return.
end.
p=. 0
while. p<#y do.
  cnt=. p{y
  cmd=. (1+p){y
  dat=. (2+p+i.cnt-2){y
  select. cmd
  case. glarc_n_jgl2_ do. cairo_glarc dat
  case. glbkmode_n_jgl2_ do. ''
  case. glbrush_n_jgl2_ do. cairo_glbrush dat
  case. glbrushnull_n_jgl2_ do. cairo_glbrushnull dat
  case. glcapture_n_jgl2_ do. ''
  case. glcaret_n_jgl2_ do. cairo_glcaret dat
  case. glclear_n_jgl2_ do. cairo_glclear dat
  case. glclip_n_jgl2_ do. cairo_glclip dat
  case. glclipreset_n_jgl2_ do. cairo_glclipreset dat
  case. glcmds_n_jgl2_ do. ''
  case. glcursor_n_jgl2_ do. ''
  case. glellipse_n_jgl2_ do. cairo_glellipse dat
  case. glemfclose_n_jgl2_ do. cairo_glemfclose dat
  case. glemfopen_n_jgl2_ do. cairo_glemfopen dat
  case. glemfplay_n_jgl2_ do. cairo_glemfplay dat
  case. glfile_n_jgl2_ do. cairo_glfile dat{a.
  case. glfont_n_jgl2_ do. cairo_glfont dat{a.
  case. glfont2_n_jgl2_ do. cairo_glfont2 dat
  case. glfontangle_n_jgl2_ do. cairo_glfontangle dat
  case. gllines_n_jgl2_ do. cairo_gllines dat
  case. glnodblbuf_n_jgl2_ do. ''
  case. glnoerasebkgnd_n_jgl2_ do. ''
  case. glpaint_n_jgl2_ do. ''
  case. glpaintx_n_jgl2_ do. ''
  case. glpen_n_jgl2_ do. cairo_glpen dat
  case. glpie_n_jgl2_ do. cairo_glpie dat
  case. glpixel_n_jgl2_ do. cairo_glpixel dat
  case. glpixels_n_jgl2_ do. cairo_glpixels dat
  case. glpixelsx_n_jgl2_ do. cairo_glpixelsx dat
  case. glpolygon_n_jgl2_ do. cairo_glpolygon dat
  case. glprint_n_jgl2_ do. ''
  case. glprintmore_n_jgl2_ do. ''
  case. glqextent_n_jgl2_ do. ''
  case. glqextentw_n_jgl2_ do. ''
  case. glqhandles_n_jgl2_ do. ''
  case. glqpixels_n_jgl2_ do. ''
  case. glqprintpaper_n_jgl2_ do. ''
  case. glqprintwh_n_jgl2_ do. ''
  case. glqtextmetrics_n_jgl2_ do. ''
  case. glqwh_n_jgl2_ do. ''
  case. glrect_n_jgl2_ do. cairo_glrect dat
  case. glrgb_n_jgl2_ do. cairo_glrgb dat
  case. glroundr_n_jgl2_ do. cairo_glroundr dat
  case. glsel_n_jgl2_ do. ''
  case. gltext_n_jgl2_ do. cairo_gltext dat{a.
  case. gltextcolor_n_jgl2_ do. cairo_gltextcolor dat
  case. gltextxy_n_jgl2_ do. cairo_gltextxy dat
  case. glwindoworg_n_jgl2_ do. cairo_glwindoworg dat
  case. do.
    ('un-implemented glcmds ', ":cmd) 13!:8[3
  end.
  p=. p+cnt
end.
0
)
cairo_glcursor=: 3 : 0 "1
gtkwin=. getGtkWidgetWindow canvas
if. y -.@e. IDC_ARROW,IDC_IBEAM,IDC_WAIT,IDC_CROSS,IDC_UPARROW,IDC_SIZENWSE,IDC_SIZENESW,IDC_SIZEWE,IDC_SIZENS,IDC_SIZEALL,IDC_NO,IDC_APPSTARTING,IDC_HELP do. 0 return. end.
n=. y i.~ IDC_ARROW,IDC_IBEAM,IDC_WAIT,IDC_CROSS,IDC_UPARROW,IDC_SIZENWSE,IDC_SIZENESW,IDC_SIZEWE,IDC_SIZENS,IDC_SIZEALL,IDC_NO,IDC_APPSTARTING,IDC_HELP
gdk_window_set_cursor gtkwin, gdk_cursor_new n{GDK_ARROW,GDK_XTERM,GDK_WATCH,GDK_CROSS,GDK_CENTER_PTR,GDK_BOTTOM_RIGHT_CORNER,GDK_BOTTOM_LEFT_CORNER,GDK_SB_H_DOUBLE_ARROW,GDK_SB_V_DOUBLE_ARROW,GDK_FLEUR,GDK_BLANK_CURSOR,GDK_ICON,GDK_QUESTION_ARROW
0
)
cairo_glellipse=: 3 : 0"1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
t=. gtkbrushnull
gtkbrushnull=: 0
cairo_glarcx (0, 2p1),~ _2}.cairo_gtkarcisi y,4#0
gtkbrushnull=: t
if. 0~:printcontext do. cairo_restore gtkcr end.
0
)
cairo_glfont=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0=#y=. ,y do. return. end.
'face size style degree'=. parseFontSpec y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
gtkfontangle=: <.degree*10
gtkunderline=: Underline
fnt=. pango_font_description_from_string <'"' -.~ ,y
if. Bold do. pango_font_description_set_weight fnt, PANGO_WEIGHT_BOLD end.
if. Italic do. pango_font_description_set_style fnt, PANGO_STYLE_ITALIC end.
pango_font_description_set_size fnt, <.PANGO_SCALE*size
pango_layout_set_font_description gtkpl,fnt
pango_font_description_free fnt
0
)
cairo_glfont2=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
'size10 style degree10'=. 3{.y
face=. a.{~3}.y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
gtkfontangle=: <.degree10
gtkunderline=: Underline
fnt=. pango_font_description_from_string <'"' -.~ face
if. Bold do. pango_font_description_set_weight fnt, PANGO_WEIGHT_BOLD end.
if. Italic do. pango_font_description_set_style fnt, PANGO_STYLE_ITALIC end.
pango_font_description_set_size fnt, <.PANGO_SCALE*size10%10
pango_layout_set_font_description gtkpl,fnt
pango_font_description_free fnt
0
)
cairo_glfontangle=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkfontangle=: <.y
0
)
cairo_glrgb=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkrgb=: BGR`RGB@.RGBSEQ_j_ y
0
)
cairo_gllines=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. *./ 0=y do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
cairo_cairocolor gtkpenrgb
c=. <.-:#y
if. 0=c do. 0 return. end.
cairo_move_to gtkcr ; <"0 (0 1){y
for_i. +:>:i.<:c do.
  cairo_line_to gtkcr ; <"0 (0 1+i){y
end.
cairo_stroke gtkcr
if. 0~:printcontext do. cairo_restore gtkcr end.
0
)
cairo_glnodblbuf=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. nodoublebuf~:flag=. 0~:{.y do.
  if. 0~:gtkpl do. gtkpl=: 0 [ g_object_unref gtkpl end.
  if. 0~:gtkplc do. gtkplc=: 0 [ g_object_unref gtkplc end.
  if. 0~:gtkcr do. gtkcr=: 0 [ cairo_destroy gtkcr end.
  if. nodoublebuf=: flag do.
    gtkcr=: gdk_cairo_create getGtkWidgetWindow canvas
  else.
    gtkcr=: cairo_create surface=. cairo_image_surface_create CAIRO_FORMAT_RGB24,gtkwh
    cairo_surface_destroy surface
  end.
  gtkplc=: pango_cairo_create_context gtkcr
  gtkpl=: pango_layout_new gtkplc
  gtk_widget_set_double_buffered canvas, -.nodoublebuf
  cairo_glclear''
end.
0
)
cairo_glpaint=: 3 : 0 "1
assert. 0~:gtkcr,gtkpl
if. #stash_buf do. stash_buf=: 0$0 [ cairo_glcmds stash_buf end.
newsize=: 1
if. 0~: s=. cairo_get_target gtkcr do. cairo_surface_flush s end.
if. iOPENGL~:gloption do.
  if. -.nodoublebuf do.
    cr=. gdk_cairo_create getGtkWidgetWindow canvas
    cairo_set_operator cr, CAIRO_OPERATOR_SOURCE
    cairo_set_source_surface cr; (cairo_get_target gtkcr); 0 ; 0
    cairo_rectangle cr; 0 ;0; <"0 gtkwh
    cairo_clip cr
    cairo_paint cr
    cairo_destroy cr
  end.
end.
0
)
cairo_glpaintx=: 3 : 0 "1
newsize=: 1
gtk_widget_queue_draw canvas
0
)
cairo_glpen=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
gtkpenrgb=: gtkrgb
penwidth=. 0.5>.{.y
penstyle=. {:y
cairo_set_line_width gtkcr ; (1.1-1.1)+penwidth
if. 0~:printcontext do. cairo_restore gtkcr end.
0
)
cairo_glpie=: 3 : 0 "1
cairo_glarcx cairo_gtkarcisi y
0
)
cairo_glpixel=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
cairo_cairocolor gtkrgb
for_p. <. (twipscaled *("1) _2[\ y),("1) twipscaled * 1 1 do.
  cairo_rectangle gtkcr ; <"0 p
end.
cairo_fill gtkcr
0
)
cairo_glpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
'a b'=. <. twipscaled * 2{.y
'w h1'=. <. 2{.2}.y
h=. |h1
d=. <. 4}.y
if. h1<0 do. d=. ,|.(h,w)$d end.
d=. fliprgb^:(-.RGBSEQ_j_) d

d=. 2 ic d
surface=. cairo_image_surface_create_for_data d ; CAIRO_FORMAT_RGB24 ; w ; h ; cairo_format_stride_for_width CAIRO_FORMAT_RGB24, w
if. surface do.
  cairo_save gtkcr
  cairo_set_operator gtkcr ; CAIRO_OPERATOR_OVER
  cairo_set_source_surface gtkcr ; surface ; a ; b
  cairo_rectangle gtkcr ; a ; b ; w ; h
  cairo_clip gtkcr
  cairo_paint gtkcr
  cairo_restore gtkcr
  cairo_surface_destroy surface
end.
0
)
cairo_glpixelsx=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
'a b'=. <. twipscaled * 2{.y
'w h1'=. <. 2{.2}.y
da=. <. {:y
h=. |h1
d=. memr da,0,(w*h),JINT
if. h1<0 do. d=. ,|.(h,w)$ d end.
d=. fliprgb^:(-.RGBSEQ_j_) d

d=. 2 ic d
surface=. cairo_image_surface_create_for_data d ; CAIRO_FORMAT_RGB24 ; w ; h ; cairo_format_stride_for_width CAIRO_FORMAT_RGB24, w
if. surface do.
  cairo_save gtkcr
  cairo_set_operator gtkcr ; CAIRO_OPERATOR_OVER
  cairo_set_source_surface gtkcr ; surface ; a ; b
  cairo_rectangle gtkcr ; a ; b ; w ; h
  cairo_clip gtkcr
  cairo_paint gtkcr
  cairo_restore gtkcr
  cairo_surface_destroy surface
end.
0
)
cairo_glpolygon=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. *./ 0=y do. 0 return. end.
c=. <.-:#y
if. 0=c do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
if. -.gtkbrushnull do.
  cairo_cairocolor gtkbrushrgb
  cairo_move_to gtkcr ; <"0 (0 1){y
  for_i. +:>:i.<:c do.
    cairo_line_to gtkcr ; <"0 (0 1+i){y
  end.
  cairo_line_to gtkcr ; <"0 (0 1){y
  cairo_fill_preserve gtkcr
  cairo_cairocolor gtkpenrgb
  cairo_stroke gtkcr
else.
  cairo_cairocolor gtkpenrgb
  cairo_move_to gtkcr ; <"0 (0 1){y
  for_i. +:>:i.<:c do.
    cairo_line_to gtkcr ; <"0 (0 1+i){y
  end.
  cairo_line_to gtkcr ; <"0 (0 1){y
  cairo_stroke gtkcr
end.
if. 0~:printcontext do. cairo_restore gtkcr end.
0
)
cairo_glqpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0$0 return. end.
assert. 0~:gtkcr,gtkpl
'a b'=. <. twipscaled * 2{.y
'w h'=. <. 2{.2}.y
surface=. cairo_image_surface_create CAIRO_FORMAT_RGB24 ; w ; h
cr=. cairo_create surface

cairo_set_operator cr ; CAIRO_OPERATOR_SOURCE
cairo_set_source_surface cr ; (cairo_get_target gtkcr) ; (-a) ; -b
cairo_rectangle cr ; 0 ; 0 ; w ; h
cairo_clip cr
cairo_paint cr

ad=. cairo_image_surface_get_data surface
assert. 0~: ad
assert. (4*w)= cairo_image_surface_get_stride surface

if. IF64 do.
  r=. _2 ic memr ad,0,(w*h*4),JCHAR
else.
  r=. memr ad,0,(w*h),JINT
end.
cairo_destroy cr
cairo_surface_destroy surface

r=. fliprgb^:(-.RGBSEQ_j_) r
)
cairo_glqwh=: 3 : 0"1
gtkwh
)
cairo_glrect=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
if. -.gtkbrushnull do.
  for_p. <. _4[\ y do.
    cairo_cairocolor gtkbrushrgb
    cairo_rectangle gtkcr ; <"0 p
    cairo_fill_preserve gtkcr
    cairo_cairocolor gtkpenrgb
    cairo_stroke gtkcr
  end.
else.
  for_p. <. _4[\ y do.
    cairo_cairocolor gtkpenrgb
    cairo_rectangle gtkcr ; <"0 p
    cairo_stroke gtkcr
  end.
end.
if. 0~:printcontext do. cairo_restore gtkcr end.
0
)
cairo_glsetlocale=: 3 : 0
if. PLocale -: <'gtkwd' do. 0 return. end.
PLocalec=: boxxopen y
0
)
cairo_glsetbrush=: cairo_glbrush @ cairo_glrgb
cairo_glsetpen=: cairo_glpen @ ((1 0 [ cairo_glrgb) :((2 {. [) cairo_glrgb))
cairo_gltext=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
cairo_cairocolor gtktextrgb
pango_layout_set_text gtkpl;(,y);#y
if. gtkunderline do.
  atl=. pango_attr_list_new ''
  ul=. pango_attr_underline_new 1
  pango_attr_list_insert atl,ul
  pango_layout_set_attributes gtkpl,atl
  pango_attr_list_unref atl
end.
if. 0=gtkfontangle do.
  cairo_move_to gtkcr ; <"0 gtktextxy * twipscaled
  pango_cairo_show_layout gtkcr, gtkpl
else.
  cairo_save gtkcr
  cairo_move_to gtkcr ; <"0 gtktextxy * twipscaled
  cairo_rotate gtkcr ; - rfd gtkfontangle%10
  pango_cairo_update_layout gtkcr, gtkpl
  pango_cairo_show_layout gtkcr, gtkpl
  cairo_restore gtkcr
end.
if. gtkunderline do.
  atl=. pango_attr_list_new ''
  ul=. pango_attr_underline_new 0
  pango_attr_list_insert atl,ul
  pango_layout_set_attributes gtkpl,atl
  pango_attr_list_unref atl
end.
0
)
cairo_gltextcolor=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtktextrgb=: gtkrgb
0
)
cairo_gltextxy=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtktextxy=: <.y
0
)
cairo_glqextent=: 3 : 0 "1
z=. 1 1
if. iOPENGL=gloption do. z return. end.
assert. 0~:gtkcr,gtkpl
pango_layout_set_text gtkpl;(,y);#y
pango_layout_get_pixel_size gtkpl;(w=. ,_1);h=. ,_1
<. (w,h) % twipscaled
)
cairo_glqextentw=: 3 : 0 "1
assert. 0~:gtkcr,gtkpl
if. iOPENGL=gloption do. 0$0 return. end.
if. GL2ExtGlcmds_jgl2_ *. 0~:#LIBGLCMDS_jglcanvas_ do.
  len=. #;._2 txt=. y,LF#~LF~:{:y
  (LIBGLCMDS,' Glcmds_cairo_qextentwv > + i x x *c *x x *x')&cd gtkcr;gtkpl;txt;len;(#len);(w=. _1#~#len)
  <. w % {.twipscaled
else.
  w=. {. glqextent '8'
  w * #@ucp;._2 txt=. y,LF#~LF~:{:y
end.
)
cairo_glwindoworg=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
gtkorgx=: gtkorgx + <.{.y
gtkorgy=: gtkorgy + <.{:y
cairo_translate gtkcr ; <"0 twipscaled * y
0
)
cairo_glqhandles=: 3 : 0 "1
if. 0< #y do. (13!:8) 3 end.
canvas,gtkcr,printcontext
)
cairo_glprint=: 3 : 0 "1
job=. 'J Print' [ printer=. file=. '' [ devmod=. 0$<''
PrinterDevmode=. ;:'orientation copies papersize paperlength paperwidth scale defaultsource printquality color duplex'
if. 0< #args=. wdglshiftargs y do. job=. >@{.args end.
if. 1< #args do. printer=. 1{::args end.
if. 2< #args do. file=. 2{::args end.
if. 3< #args do.
  for_mv. _2[\ 3}.args do.
    'mod val'=. mv
    if. (<mod) -.@e. PrinterDevmode do. (13!:8) 3 end.
    if. 0 e. val e. '0123456789' do. (13!:8) 3 end.
    devmod=. devmod, mv
  end.
end.
assert. iOPENGL~:gloption
assert. 0=gtkcr,gtkpl
assert. 0=printcontext
assert. 0=printoperation
if. 0= printsettings do. printsettings_jglcanvas_=: gtk_print_settings_new '' end.
if. #printer do. gtk_print_settings_set printsettings ; 'printer' ; printer end.
if. #devmod do.
  for_mv. _2[\ devmod do.
    'mod val'=. mv
    select. mod
    case. 'copies' do. gtk_print_settings_set_int printsettings ; 'n-copies' ; 1 >. <. {.@(0&".) val
    case. 'orientation' do. gtk_print_settings_set_int printsettings ; 'orientation' ; 0 >. <: <. {.@(0&".) val
    end.
  end.
end.
operation=. gtk_print_operation_new ''
if. IFUNIX do.
  if. p=. gtk_print_settings_get printsettings ; 'printer' do.
    if. 'PDF' -: 3{. memr p, 0 _1 do. job=. '' end.
  end.
end.
if. #job do. gtk_print_operation_set_job_name operation ; job end.
if. #file do. gtk_print_operation_set_export_filename operation ; file end.
gtk_print_operation_set_print_settings operation, printsettings
if. async_print do. gtk_print_operation_set_allow_async operation,1 end.
consig3 operation;'begin_print';'print_begin'
consig4 operation;'draw_page';'print_draw'
if. async_print do. consig3 operation;'done';'print_done' end.
printnpage=: 1
res=. gtk_print_operation_run operation, GTK_PRINT_OPERATION_ACTION_PRINT, 0, 0
if. 0=async_print do. print_done operation,res,0 end.
0
)
cairo_printer_dialog=: 3 : 0"1
z=. 0
if. 0= printsettings do. printsettings_jglcanvas_=: gtk_print_settings_new '' end.
operation=. gtk_print_operation_new ''
gtk_print_operation_set_print_settings operation, printsettings
gtk_print_operation_set_embed_page_setup ::0: operation, 1
res=. gtk_print_operation_run operation, GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG, 0, 0
if. res= GTK_PRINT_OPERATION_RESULT_APPLY do.
  g_object_unref printsettings
  printsettings_jglcanvas_=: gtk_print_settings_copy gtk_print_operation_get_print_settings operation
  z=. 1
end.
z [ g_object_unref operation
)
cairo_settings_printer=: 3 : 0"1
z=. ''
if. 0~: printsettings do.
  if. p=. gtk_print_settings_get printsettings ; 'printer' do. z=. memr p, 0 _1 end.
end.
z
)
cairo_glprintmore=: 3 : 0 "1
if. 1 4 8 -.@e.~ 3!:0 y do. (13!:8) 3 end.
if. 1~: #y do. (13!:8) 3 end.
if. 0=printcontext do. (13!:8) 3 end.
printnpage=: 0 >. <. {.y
''
)
cairo_glqprintpaper=: 3 : 0 "1
if. 0< #y do. (13!:8) 3 end.
if. 0=printcontext do. (13!:8) 3 end.
assert. iOPENGL~:gloption
marx=. mary=. 0
context=. printcontext
operation=. printoperation
w=. <. gtk_print_context_get_width context
h=. <. gtk_print_context_get_height context
gtkwh=: w,h
dpix=: <. gtk_print_context_get_dpi_x context
dpiy=: <. gtk_print_context_get_dpi_y context
twipscaled=: 1440 %~ dpix,dpiy
'w h'=. <. (w,h) % twipscaled
if. gtk_print_context_get_hard_margins context; (top=. ,1.1); (bottom=. ,1.1); (left=. ,1.1); (right=. ,1.1) do.
  'marx mary'=. <. (left,top) % twipscaled
end.
settings=. gtk_print_operation_get_print_settings operation
assert. 0~:settings
copies=. gtk_print_settings_get_n_copies settings
ori=. 1+ gtk_print_settings_get_orientation settings
papersize=. gtk_print_settings_get_paper_size settings
if. 0~:papersize do.
  papername=. memr (gtk_paper_size_get_name papersize), 0 _1
  w=. <. 1440* gtk_paper_size_get_width papersize, GTK_UNIT_INCH
  h=. <. 1440* gtk_paper_size_get_height papersize, GTK_UNIT_INCH
  marx=. <. 1440* gtk_paper_size_get_default_left_margin papersize, GTK_UNIT_INCH
  mary=. <. 1440* gtk_paper_size_get_default_top_margin papersize, GTK_UNIT_INCH
end.
<. w,h,marx,mary,ori,copies,0
)
cairo_glqprintwh=: 3 : 0 "1
if. 0< #y do. (13!:8) 3 end.
if. 0=printcontext do. (13!:8) 3 end.
assert. iOPENGL~:gloption
context=. printcontext
w=. <. gtk_print_context_get_width context
h=. <. gtk_print_context_get_height context
gtkwh=: w,h
dpix=: <. gtk_print_context_get_dpi_x context
dpiy=: <. gtk_print_context_get_dpi_y context
twipscaled=: 1440 %~ dpix,dpiy
<. gtkwh % twipscaled
)
cairo_glqtextmetrics=: 3 : 0 "1
if. 0< #y do. (13!:8) 3 end.
if. 0=printcontext do.
  ctx=. gtk_widget_get_pango_context canvas
else.
  ctx=. gtkplc
end.
fnt=. pango_context_get_font_description ctx
sz=. pango_font_description_get_size fnt
metrics=. pango_context_get_metrics ctx, fnt, 0
asc=. pango_font_metrics_get_ascent metrics
dsc=. pango_font_metrics_get_descent metrics
cw=. pango_font_metrics_get_approximate_char_width metrics
a=. PANGO_SCALE %~ (asc + dsc),asc,dsc,0,0,cw,cw
<. ((3{.a) % {:twipscaled), ((3}.a) % {.twipscaled)
)
cairo_glemfclose=: [:
cairo_glemfopen=: [:
cairo_glemfplay=: [:
cairo_glfile=: [:
cairo_glroundr=: [:
cairo_cleanup=: 3 : 0
if. printsettings do. printsettings_jglcanvas_=: 0 [ g_object_unref printsettings end.
)
GetDC=: 'user32 GetDC > x x'&(15!:0)
ReleaseDC=: 'user32 ReleaseDC > i x x'&(15!:0)

GlobalAlloc=: 'kernel32 GlobalAlloc > x i x'&cd
GlobalSize=: 'kernel32 GlobalSize > x x'&cd
GlobalLock=: 'kernel32 GlobalLock > x x'&cd
GlobalUnlock=: 'kernel32 GlobalUnlock > i x'&cd
GlobalFree=: 'kernel32 GlobalFree > i x'&cd

GMEM_FIXED=: 16b0000
GMEM_MOVEABLE=: 16b0002
GMEM_NOCOMPACT=: 16b0010
GMEM_NODISCARD=: 16b0020
GMEM_ZEROINIT=: 16b0040
GMEM_MODIFY=: 16b0080
GMEM_DISCARDABLE=: 16b0100
GMEM_NOT_BANKED=: 16b1000
GMEM_SHARE=: 16b2000
GMEM_DDESHARE=: 16b2000
GMEM_NOTIFY=: 16b4000
GMEM_LOWER=: GMEM_NOT_BANKED
GMEM_DISCARDED=: 16b4000
GMEM_LOCKCOUNT=: 16b00ff
GMEM_INVALID_HANDLE=: 16b8000

GHND=: GMEM_MOVEABLE + GMEM_ZEROINIT
GPTR=: GMEM_FIXED + GMEM_ZEROINIT
gdi32_init=: 3 : 0
'w h'=. y
gtkwin=. getGtkWidgetWindow canvas
hwnd=. gdk_win32_drawable_get_handle`gdk_win32_window_get_impl_hwnd@.(3=GTKVER_j_) gtkwin
hdc0=. GetDC hwnd
HDC=: CreateCompatibleDC hdc0
BMP=: CreateCompatibleBitmap hdc0,w,h
OLDBMP=: SelectObject HDC,BMP
ReleaseDC hwnd, hdc0
assert. 0~:HDC,BMP
PEN=: BRUSH=: FONT=: 0
OLDPEN=: OLDBRUSH=: OLDFONT=: 0
gtktextxy=: 2$0
EMPTY
)
gdi32_free=: 3 : 0
if. HDC do.
  if. OLDBRUSH do. prevbrush=. SelectObject HDC,OLDBRUSH end.
  if. OLDPEN do. prevpen=. SelectObject HDC,OLDPEN end.
  if. OLDFONT do. prevfont=. SelectObject HDC,OLDFONT end.
  SelectObject HDC,OLDBMP
end.
if. FONT do. DeleteObject FONT end.
if. PEN do. DeleteObject PEN end.
if. BRUSH do. DeleteObject BRUSH end.
if. BMP do. DeleteObject BMP end.
if. HDC do. DeleteDC HDC end.
HDC=: BMP=: 0
PEN=: BRUSH=: FONT=: 0
OLDPEN=: OLDBRUSH=: OLDFONT=: 0
gtktextxy=: 2$0
EMPTY
)
gdi32_setbkmode=: 3 : 0
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
SetBkMode HDC, y{OPAQUE,TRANSPARENT
)
gdi32_glarc=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
Arc HDC, (2{.y),((2{.y)+(2 3{y)),4}.y=. <.y
0
)
gdi32_glbrush=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkbrushrgb=: gtkrgb
obj=. CreateSolidBrush gtkbrushrgb
prev=. SelectObject HDC, obj
if. BRUSH do.
  if. -. GL2ExtGlcmds_jgl2_ *. 0~:#LIBGLCMDS_jglcanvas_ do.
    assert. prev=BRUSH
  end.
  DeleteObject BRUSH
else.
  OLDBRUSH=: prev
end.
BRUSH=: obj
0
)
gdi32_glbrushnull=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. BRUSH do.
  SelectObject HDC, GetStockObject NULL_BRUSH
  DeleteObject BRUSH
end.
BRUSH=: OLDBRUSH=: 0
0
)
gdi32_glcapture=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
select. cap=. {.y
case. 0 do.
  capture=: cap
case. 1 do.
  capture=: cap
case. 5 do.
  capture=: cap
case. 6 do.
  capture=: cap
case. 7 do.
  capture=: cap
  rect=. }.cap
end.
0
)
gdi32_glcaret=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0 e. _2{.y do. 0 return. end.
assert. 0~:HDC,BMP
prev=. SelectObject HDC, GetStockObject BLACK_PEN
prevb=. SelectObject HDC, GetStockObject BLACK_BRUSH
Rectangle HDC, (2{.y), (2{.y) + 2}.y=. <.y
SelectObject HDC, prev
SelectObject HDC, prevb
0
)
gdi32_glclear=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
SetBkMode HDC, TRANSPARENT
SetPolyFillMode HDC,ALTERNATE
gdi32_glclipreset''
gdi32_glwindoworg - gtkorgx, gtkorgy
gtkorgx=: gtkorgy=: 0
gdi32_glrgb 255 255 255
gdi32_glpen 1 0
gdi32_glbrush''
gdi32_glrect 0 0,gtkwh
gdi32_glbrushnull''
gdi32_glrgb 0 0 0
gdi32_glpen 1 0
gdi32_gltextcolor''
gdi32_glfont PROFONT_jgl2_
gdi32_glfontangle 0
gdi32_gltextxy 0 0
0
)
gdi32_glclip=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
gtkclipped=: 1
BeginPath HDC
Rectangle HDC, (2{.y), (2{.y) + 2}.y=. <.y
EndPath HDC
SelectClipPath HDC,RGN_COPY
0
)
gdi32_glclipreset=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
if. gtkclipped do.
  BeginPath HDC
  Rectangle HDC, 0 0, gtkwh
  EndPath HDC
  SelectClipPath HDC,RGN_COPY
  gtkclipped=: 0
end.
0
)
gdi32_glcmds=: 3 : 0"1
if. 0=#y do. 0 return. end.
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
if. GL2ExtGlcmds_jgl2_ *. 0~:#LIBGLCMDS_jglcanvas_ do.
  xpar=. <.PEN,OLDPEN,BRUSH,OLDBRUSH,FONT,OLDFONT
  ipar=. <.gtkclipped,gtkwh,gtkrgb,gtktextxy,gtkunderline,gtkfontangle,gtkorgx,gtkorgy
  glcmdsrc=. (LIBGLCMDS,' Glcmds_gdi32 > + i x *x *x *c *x x x')&cd HDC;xpar;ipar;(utf8 ,PROFONT_jgl2_);(<.,y);(#y);RGBSEQ_j_
  assert. 0= glcmdsrc
  'PEN OLDPEN BRUSH OLDBRUSH FONT OLDFONT'=: xpar
  'clip gtkw gtkh rgb tx ty underline angle orgx orgy'=. ipar
  gtkclipped=: clip [ gtkrgb=: rgb [ gtktextxy=: tx,ty [ gtkunderline=: underline [ gtkfontangle=: angle [ gtkorgx=: orgx ] gtkorgy=: orgy
  0 return.
end.
p=. 0
while. p<#y do.
  cnt=. p{y
  cmd=. (1+p){y
  dat=. (2+p+i.cnt-2){y
  select. cmd
  case. glarc_n_jgl2_ do. gdi32_glarc dat
  case. glbkmode_n_jgl2_ do. ''
  case. glbrush_n_jgl2_ do. gdi32_glbrush dat
  case. glbrushnull_n_jgl2_ do. gdi32_glbrushnull dat
  case. glcapture_n_jgl2_ do. ''
  case. glcaret_n_jgl2_ do. gdi32_glcaret dat
  case. glclear_n_jgl2_ do. gdi32_glclear dat
  case. glclip_n_jgl2_ do. gdi32_glclip dat
  case. glclipreset_n_jgl2_ do. gdi32_glclipreset dat
  case. glcmds_n_jgl2_ do. ''
  case. glcursor_n_jgl2_ do. ''
  case. glellipse_n_jgl2_ do. gdi32_glellipse dat
  case. glemfclose_n_jgl2_ do. gdi32_glemfclose dat
  case. glemfopen_n_jgl2_ do. gdi32_glemfopen dat
  case. glemfplay_n_jgl2_ do. gdi32_glemfplay dat
  case. glfile_n_jgl2_ do. gdi32_glfile dat{a.
  case. glfont_n_jgl2_ do. gdi32_glfont dat{a.
  case. glfont2_n_jgl2_ do. gdi32_glfont2 dat
  case. glfontangle_n_jgl2_ do. gdi32_glfontangle dat
  case. gllines_n_jgl2_ do. gdi32_gllines dat
  case. glnodblbuf_n_jgl2_ do. ''
  case. glnoerasebkgnd_n_jgl2_ do. ''
  case. glpaint_n_jgl2_ do. ''
  case. glpaintx_n_jgl2_ do. ''
  case. glpen_n_jgl2_ do. gdi32_glpen dat
  case. glpie_n_jgl2_ do. gdi32_glpie dat
  case. glpixel_n_jgl2_ do. gdi32_glpixel dat
  case. glpixels_n_jgl2_ do. gdi32_glpixels dat
  case. glpixelsx_n_jgl2_ do. gdi32_glpixelsx dat
  case. glpolygon_n_jgl2_ do. gdi32_glpolygon dat
  case. glprint_n_jgl2_ do. ''
  case. glprintmore_n_jgl2_ do. ''
  case. glqextent_n_jgl2_ do. ''
  case. glqextentw_n_jgl2_ do. ''
  case. glqhandles_n_jgl2_ do. ''
  case. glqpixels_n_jgl2_ do. ''
  case. glqprintpaper_n_jgl2_ do. ''
  case. glqprintwh_n_jgl2_ do. ''
  case. glqtextmetrics_n_jgl2_ do. ''
  case. glqwh_n_jgl2_ do. ''
  case. glrect_n_jgl2_ do. gdi32_glrect dat
  case. glrgb_n_jgl2_ do. gdi32_glrgb dat
  case. glroundr_n_jgl2_ do. gdi32_glroundr dat
  case. glsel_n_jgl2_ do. ''
  case. gltext_n_jgl2_ do. gdi32_gltext dat{a.
  case. gltextcolor_n_jgl2_ do. gdi32_gltextcolor dat
  case. gltextxy_n_jgl2_ do. gdi32_gltextxy dat
  case. glwindoworg_n_jgl2_ do. gdi32_glwindoworg dat
  case. do.
    ('un-implemented glcmds ', ":cmd) 13!:8[3
  end.
  p=. p+cnt
end.
0
)
gdi32_glcursor=: 3 : 0 "1
gtkwin=. getGtkWidgetWindow canvas
if. y -.@e. IDC_ARROW,IDC_IBEAM,IDC_WAIT,IDC_CROSS,IDC_UPARROW,IDC_SIZENWSE,IDC_SIZENESW,IDC_SIZEWE,IDC_SIZENS,IDC_SIZEALL,IDC_NO,IDC_APPSTARTING,IDC_HELP do. 0 return. end.
n=. y i.~ IDC_ARROW,IDC_IBEAM,IDC_WAIT,IDC_CROSS,IDC_UPARROW,IDC_SIZENWSE,IDC_SIZENESW,IDC_SIZEWE,IDC_SIZENS,IDC_SIZEALL,IDC_NO,IDC_APPSTARTING,IDC_HELP
gdk_window_set_cursor gtkwin, gdk_cursor_new n{GDK_ARROW,GDK_XTERM,GDK_WATCH,GDK_CROSS,GDK_CENTER_PTR,GDK_BOTTOM_RIGHT_CORNER,GDK_BOTTOM_LEFT_CORNER,GDK_SB_H_DOUBLE_ARROW,GDK_SB_V_DOUBLE_ARROW,GDK_FLEUR,GDK_BLANK_CURSOR,GDK_ICON,GDK_QUESTION_ARROW
0
)
gdi32_glellipse=: 3 : 0"1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
Ellipse HDC, <.(2{.y),((2{.y)+(2 3{y))
0
)
gdi32_glfont=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
if. 0=#y=. ,y do. return. end.
'face size style degree'=. parseFontSpec y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
gtkfontangle=: <.degree*10
gtkunderline=: Underline
obj=. CreateFontW (<.size*(GetDeviceCaps HDC, LOGPIXELSY)%72); 0; (<.10*degree); (<.10*degree); (Bold{FW_NORMAL,FW_BOLD); Italic; Underline; Strikeout; DEFAULT_CHARSET; OUT_DEFAULT_PRECIS; CLIP_DEFAULT_PRECIS; PROOF_QUALITY; DEFAULT_PITCH; uucp face
prev=. SelectObject HDC, obj
if. FONT do.
  if. -. GL2ExtGlcmds_jgl2_ *. 0~:#LIBGLCMDS_jglcanvas_ do.
    assert. prev=FONT
  end.
  DeleteObject FONT
else.
  OLDFONT=: prev
end.
FONT=: obj
0
)
gdi32_glfont2=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
'size10 style degree10'=. 3{.y
face=. a.{~3}.y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
gtkfontangle=: degree10
gtkunderline=: Underline
obj=. CreateFontW (<.size10*(GetDeviceCaps HDC, LOGPIXELSY)%720); 0; degree10; degree10; (Bold{FW_NORMAL,FW_BOLD); Italic; Underline; Strikeout; DEFAULT_CHARSET; OUT_DEFAULT_PRECIS; CLIP_DEFAULT_PRECIS; PROOF_QUALITY; DEFAULT_PITCH; uucp face
prev=. SelectObject HDC, obj
if. FONT do.
  assert. prev=FONT
  DeleteObject FONT
else.
  OLDFONT=: prev
end.
FONT=: obj
0
)
gdi32_glfontangle=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkfontangle=: <.y
0
)
gdi32_glrgb=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkrgb=: BGR`RGB@.(1[RGBSEQ_j_) y
0
)
gdi32_gllines=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. *./ 0=y do. 0 return. end.
assert. 0~:HDC,BMP
c=. 2>.(+ 2&|)#y
Polyline HDC; (<.c{.y); (<.-:c)
0
)
gdi32_glnodblbuf=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
nodoublebuf=: flag=. 0~:{.y
0
)
gdi32_glpaint=: 3 : 0 "1
assert. 0~:HDC,BMP
if. #stash_buf do. stash_buf=: 0$0 [ gdi32_glcmds stash_buf end.
newsize=: 1
if. iOPENGL~:gloption do.
  gtkwin=. getGtkWidgetWindow canvas
  argb=. gdi32_glqpixels 0 0,gtkwh
  gtkwin pixbufwin_setpixels 0 0,gtkwh,argb
end.
0
)
gdi32_glpaintx=: 3 : 0 "1
newsize=: 1
gtk_widget_queue_draw canvas
0
)
gdi32_glpen=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
penwidth=. 0>.{.y
penstyle=. {:y
gtkpenrgb=: gtkrgb
obj=. CreatePen penstyle , penwidth , gtkpenrgb
prev=. SelectObject HDC, obj
if. PEN do.
  assert. prev=PEN
  DeleteObject PEN
else.
  OLDPEN=: prev
end.
PEN=: obj
0
)
gdi32_glpie=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
Pie HDC, <.(2{.y),((2{.y)+(2 3{y)),4}.y
0
)
gdi32_glpixel=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
for_p. <. (_2[\ y) do.
  SetPixel HDC,p,gtkrgb
end.
0
)
gdi32_glpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
'a b w h1'=. 4{.y
h=. |h1
d=. 4}.y
d=. , |.^:(h1<0) (h,w)$fliprgb^:(-.RGBSEQ_j_) d

if. IF64 do. d=. 2&ic d end.

bi=. 40${.a.
bi=. (2 ic 40,w,-h) (i.12)}bi
bi=. (1 ic 1 32) (12+i.4)}bi
bi=. (2 ic BI_RGB) (16+i.4)}bi
BmpSize=. (s=. 4 * w) * h
hDIB=. CreateDIBitmap HDC; bi; CBM_INIT; (<15!:14 <'d'); bi; DIB_RGB_COLORS
memdc=. CreateCompatibleDC HDC
oldbm=. SelectObject memdc,hDIB
BitBlt HDC,a,b,w,h,memdc,0,0,SRCCOPY
SelectObject memdc,oldbm
DeleteDC memdc
DeleteObject hDIB
0
)
gdi32_glpixelsx=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
'a b w h1 da'=. y
h=. |h1
d=. memr da,0,(w*h),JINT
d=. , |.^:(h1<0) (h,w)$fliprgb^:(-.RGBSEQ_j_) d

if. IF64 do. d=. 2&ic d end.

bi=. 40${.a.
bi=. (2 ic 40,w,-h) (i.12)}bi
bi=. (1 ic 1 32) (12+i.4)}bi
bi=. (2 ic BI_RGB) (16+i.4)}bi
BmpSize=. (s=. 4 * w) * h
hDIB=. CreateDIBitmap HDC; bi; CBM_INIT; (<15!:14 <'d'); bi; DIB_RGB_COLORS
memdc=. CreateCompatibleDC HDC
oldbm=. SelectObject memdc,hDIB
BitBlt HDC,a,b,w,h,memdc,0,0,SRCCOPY
SelectObject memdc,oldbm
DeleteDC memdc
DeleteObject hDIB
0
)
gdi32_glpolygon=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. *./ 0=y do. 0 return. end.
c=. 2>.(+ 2&|)#y
Polygon HDC; (<.c{.y); (<.-:c)
0
)
gdi32_glqpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0$0 return. end.
assert. 0~:HDC,BMP
'a b w h'=. y
ww=. {.gtkwh

bi=. 40${.a.
bi=. (2 ic 40,ww,-h) (i.12)}bi
bi=. (1 ic 1 32) (12+i.4)}bi
bi=. (2 ic BI_RGB) (16+i.4)}bi
BmpSize=. (s=. 4 * ww) * h
hDIB=. GlobalAlloc GHND,BmpSize
p=. GlobalLock hDIB
GetDIBits HDC; BMP; b; h; (<p); bi; DIB_RGB_COLORS
if. IF64 do.
  z=. |.^:(s<0) ww&{."1^:(ww~:|s%4) _2&ic("1) (h,|s)$memr p,((s<0)*s*<:h),(h*<.|s),JCHAR
else.
  z=. |.^:(s<0) ww&{."1^:(ww~:|s%4) (h,|s%4)$memr p,((s<0)*s*<:h),(h*<.|s%4),JINT
end.

GlobalUnlock hDIB
GlobalFree hDIB
if. 0~:a do. z=. a}."1 z end.
if. w~:{:$z do. z=. w{."1 z end.
z=. fliprgb^:(-.RGBSEQ_j_) ,z
)
gdi32_glqtextmetrics=: 3 : 0 "1
metrics=. 64${.a.
r=. GetTextMetrics HDC, metrics
'h as de int ext acw mcw'=. _2 ic 28{.metric
)
gdi32_glqwh=: 3 : 0"1
gtkwh
)
gdi32_glrect=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
for_p. <. _4[\ y do.
  Rectangle HDC, (2{.p), (2{.p) + 2}.p
end.
0
)
gdi32_glsetlocale=: 3 : 0
if. PLocale -: <'gtkwd' do. 0 return. end.
PLocalec=: boxxopen y
0
)
gdi32_glsetbrush=: gdi32_glbrush @ gdi32_glrgb
gdi32_glsetpen=: gdi32_glpen @ ((1 0 [ gdi32_glrgb) :((2 {. [) gdi32_glrgb))
gdi32_gltext=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
text=. uucp ,y
TextOutW HDC;(<"0 gtktextxy),text;#text
0
)
gdi32_gltextcolor=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtktextrgb=: gtkrgb
SetTextColor HDC, gtktextrgb
0
)
gdi32_gltextxy=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtktextxy=: <.y
0
)
gdi32_glqextent=: 3 : 0 "1
z=. 2$2-1
if. iOPENGL=gloption do. z return. end.
assert. 0~:HDC,BMP
text=. uucp ,y
r=. GetTextExtentPointW HDC;text;(#text);z
z
)
gdi32_glqextentw=: 3 : 0 "1
if. iOPENGL=gloption do. 0$0 return. end.
if. GL2ExtGlcmds_jgl2_ *. 0~:#LIBGLCMDS_jglcanvas_ do.
  len=. #;._2 txt=. uucp y,LF#~LF~:{:y
  (LIBGLCMDS,' Glcmds_gdi32_qextentwv > + i x *w *x x *x')&cd HDC;txt;len;(#len);(w=. _1#~#len)
  <. w % {.twipscaled
else.
  w=. {. glqextent '8'
  w * #@ucp;._2 txt=. y,LF#~LF~:{:y
end.
)
gdi32_glwindoworg=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
gtkorgx=: gtkorgx + <.{.y
gtkorgy=: gtkorgy + <.{:y
SetViewportOrgEx HDC;(<"0 y),<<0
0
)
gdi32_glemfclose=: [:
gdi32_glemfopen=: [:
gdi32_glemfplay=: [:
gdi32_glfile=: [:
gdi32_glprint=: [:
gdi32_glprintmore=: [:
gdi32_glqhandles=: [:
gdi32_glqprintpaper=: [:
gdi32_glqprintwh=: [:
gdi32_glroundr=: [:
NB qt gl2
qt_glarc=: ('"',libjqt,'" glarc >',(IFWIN#'+'),' i *i') cd <
qt_glbrush=: ('"',libjqt,'" glbrush >',(IFWIN#'+'),' i')&cd bind ''
qt_glbrushnull=: ('"',libjqt,'" glbrushnull >',(IFWIN#'+'),' i')&cd bind ''
qt_glcapture=: ('"',libjqt,'" glcapture >',(IFWIN#'+'),' i i')&cd
qt_glcaret=: ('"',libjqt,'" glcaret >',(IFWIN#'+'),' i *i') cd <
qt_glclear=: ('"',libjqt,'" glclear >',(IFWIN#'+'),' i')&cd bind ''
qt_glclip=: ('"',libjqt,'" glclip >',(IFWIN#'+'),' i *i') cd <
qt_glclipreset=: ('"',libjqt,'" glclipreset >',(IFWIN#'+'),' i')&cd bind ''
qt_glcmds=: ('"',libjqt,'" glcmds >',(IFWIN#'+'),' i *i i') cd (;#)
qt_glcursor=: ('"',libjqt,'" glcursor >',(IFWIN#'+'),' i i')&cd
qt_glellipse=: ('"',libjqt,'" glellipse >',(IFWIN#'+'),' i *i') cd <
qt_glfont=: ('"',libjqt,'" glfont >',(IFWIN#'+'),' i *c') cd <@,
qt_glfont2=: ('"',libjqt,'" glfont2 >',(IFWIN#'+'),' i *i i') cd (;#)
qt_glfontangle=: ('"',libjqt,'" glfontangle >',(IFWIN#'+'),' i i')&cd
qt_gllines=: ('"',libjqt,'" gllines >',(IFWIN#'+'),' i *i i') cd (;#)
qt_glnodblbuf=: ('"',libjqt,'" glnodblbuf >',(IFWIN#'+'),' i i')&cd
qt_glpaint=: ('"',libjqt,'" glpaint >',(IFWIN#'+'),' i')&cd bind ''
qt_glpaintx=: ('"',libjqt,'" glpaintx >',(IFWIN#'+'),' i')&cd bind ''
qt_glpen=: ('"',libjqt,'" glpen >',(IFWIN#'+'),' i *i') cd <@:(2&{.)
qt_glpie=: ('"',libjqt,'" glpie >',(IFWIN#'+'),' i *i') cd <
qt_glpixel=: ('"',libjqt,'" glpixel >',(IFWIN#'+'),' i *i') cd <
qt_glpixels=: ('"',libjqt,'" glpixels >',(IFWIN#'+'),' i *i i') cd (;#)
qt_glpixelsx=: ('"',libjqt,'" glpixelsx >',(IFWIN#'+'),' i *i') cd <
qt_glpolygon=: ('"',libjqt,'" glpolygon >',(IFWIN#'+'),' i *i i') cd (;#)
qt_glrect=: ('"',libjqt,'" glrect >',(IFWIN#'+'),' i *i') cd <
qt_glrgb=: ('"',libjqt,'" glrgb >',(IFWIN#'+'),' i *i') cd <
qt_glsel=: ('"',libjqt,'" glsel >',(IFWIN#'+'),' i x')&cd
qt_glsel2=: ('"',libjqt,'" glsel2 >',(IFWIN#'+'),' i *c') cd <@,
qt_gltext=: ('"',libjqt,'" gltext >',(IFWIN#'+'),' i *c') cd <@,
qt_gltextcolor=: ('"',libjqt,'" gltextcolor >',(IFWIN#'+'),' i')&cd bind ''
qt_gltextxy=: ('"',libjqt,'" gltextxy >',(IFWIN#'+'),' i *i') cd <
qt_glwindoworg=: ('"',libjqt,'" glwindoworg >',(IFWIN#'+'),' i *i') cd <

qt_glsetlocale=: ('"',libjqt,'" glsetlocale >',(IFWIN#'+'),' i *c') cd <@,
qt_glqhandles=: 3 : 0"1
hs=. 3#2-2
('"',libjqt,'" glqhandles >',(IFWIN#'+'),' i *i') cd <hs
hs
)
qt_glqwh=: 3 : 0"1
wh=. 2#2-2
('"',libjqt,'" glqwh >',(IFWIN#'+'),' i *i') cd <wh
wh
)
qt_glqpixels=: 3 : 0"1
n=. */ 2{.2}.y
pix=. n#2-2
('"',libjqt,'" glqpixels >',(IFWIN#'+'),' i *i *i') cd y;pix
pix
)
qt_glqextent=: 3 : 0"1
wh=. 2#2-2
('"',libjqt,'" glqextent >',(IFWIN#'+'),' i *c *i') cd (,y);wh
wh
)
qt_glqextentw=: 3 : 0"1
y=. y,(LF~:{:y)#LF [ y=. ,y
w=. (+/LF=y)#2-2
('"',libjqt,'" glqextentw >',(IFWIN#'+'),' i *c *i') cd y;w
w
)
qt_glqtextmetrics=: 3 : 0"1
tm=. 7#2-2
('"',libjqt,'" glqtextmetrics >',(IFWIN#'+'),' i *i') cd tm
tm
)
qt_glsetbrush=: qt_glbrush @ qt_glrgb
qt_glsetpen=: qt_glpen @ ((1 0 [ qt_glrgb) :((2 {. [) qt_glrgb))
qt_glprint=: [:
qt_glprintmore=: [:
qt_glqprintpaper=: [:
qt_glqprintwh=: [:
qt_glemfclose=: [:
qt_glemfopen=: [:
qt_glemfplay=: [:
qt_glfile=: [:
qt_glroundr=: [:
qwh=: 3 : 0
assert. iOPENGL=gloption
gtkwh
)

realloc=: 3 : 0
newsize=: 1
if. #PForm do. openglut_newsize__PLocale=: 1 end.
free__ogl widget
if. 0= ctx=. getglctx__ogl widget do.
  ctx=. alloc__ogl widget
  newctx=: 1
end.
if. 0= ctx do. smoutput 'cannot alloc opengl context' end.
EMPTY
)

qpixels=: 3 : 0
assert. iOPENGL=gloption
0$0
)
print=: 3 : 0
assert. iOPENGL~:gloption
operation=. gtk_print_operation_new ''
consig3 operation;'begin_print';'begin_print'
consig4 operation;'draw_page';'draw_page'
gtk_print_operation_run operation, GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG, 0, 0
g_object_unref operation
0
)
glqmark=: 3 : 0"1
stash_state
)
glmark=: 3 : 0"1
stash_state=: 1
EMPTY
)
gltrash=: 3 : 0"1
stash_state=: 0 [ stash_buf=: 0$0
EMPTY
)
glbuf=: 4 : 0"0 1
assert. 1=stash_state
if. (*#y) *. 2 = 3!:0 y do. y=. a. i. y end.
if. glcmds_n_jgl2_ = x do.
  stash_buf=: stash_buf, y
else.
  stash_buf=: stash_buf, (2+#y),x,<.y
end.
EMPTY
)
pafc=: 2p1&|@{:@:(*.@(j./))

rfd=: *&(1p1%180)
dfr=: *&(180%1p1)
calcAngle=: ([: pafc _1 1 * -)"1
degree64=: 0.5 <.@:+ 64 * dfr
bufreport=: 3 : 0
smoutput 'width   : ',":w=. cairo_image_surface_get_width y
smoutput 'height  : ',":h=. cairo_image_surface_get_height y
smoutput 'stride  : ',":cairo_image_surface_get_stride y
smoutput 'pixels  : ',":d=. cairo_image_surface_get_data y
smoutput 'format: ',":cairo_image_surface_get_format y
if. IF64 do.
  smoutput 'nub data: ',":~.memr d,0,(w*h*4),JCHAR
else.
  smoutput 'nub data: ',":~.memr d,0,(w*h),JINT
end.
)
bufreport=: 3 : 0
smoutput 'width   : ',":w=. gdk_pixbuf_get_width y
smoutput 'height  : ',":h=. gdk_pixbuf_get_height y
smoutput 'stride  : ',":gdk_pixbuf_get_rowstride y
smoutput 'pixels  : ',":d=. gdk_pixbuf_get_pixels y
smoutput 'channels: ',":gdk_pixbuf_get_n_channels y
smoutput 'hasalpha: ',":gdk_pixbuf_get_has_alpha y
smoutput 'bitspers: ',":gdk_pixbuf_get_bits_per_sample y
smoutput 'nub data: ',":~.memr d,0,(w*h),JINT
)
3 : 0''
if. IF64 do.
  ALPHA=: 0{_3 ic 0 0 0 255 255 255 255 255{a.
else.
  ALPHA=: 0{_2 ic 0 0 0 255{a.
end.
''
)
NOTALPHA=: 0{_2 ic 255 255 255 0{a.
ALPHARGB=: IF64{::_1;16bffffffff
cairo_cairocolor=: 3 : 0
cairo_set_source_rgba gtkcr ; <"0 rgba2cairo 1 BGR`RGB@.RGBSEQ_j_ y
)
pangotextangle=: 3 : 0
mat=. 1 0 0 1 0 0 + 1.1 - 1.1
pango_matrix_rotate mat;y
pango_context_set_matrix gtkplc;mat
pango_layout_context_changed gtkpl
)
android_arcisi=: 3 : 0
'x y w h xa ya xz yz'=. y
rect=. tors x,y,w,h
'xc yc'=. (x,y)+0.5*w,h
a=. (xa-xc) [ b=. (ya-yc)
if. 0=a do.
  ang1=. 90*(b>0){_1 1
else.
  ang1=. 180p_1 * _3 o. b%a
end.
if. (0<:ang1) *. (a<0) do. ang1=. 180 + ang1
elseif. (0>ang1) *. (a<0) do. ang1=. 180 + ang1
end.
a=. (xz-xc) [ b=. (yz-yc)
if. 0=a do.
  ang2=. 90*(b>0){_1 1
else.
  ang2=. 180p_1 * _3 o. b%a
end.
if. (0<:ang2) *. (a<0) do. ang2=. 180 + ang2
elseif. (0>ang2) *. (a<0) do. ang2=. 180 + ang2
end.
rect,ang2,360|ang1-ang2
)
cairo_gtkarcisi=: 3 : 0
ctr=. (0 1{y) + -: (2 3{y)
rds=. -: 2{y
bgn=. pafc ctr -~ 4 5{y
end=. pafc ctr -~ 6 7{y
(2 3{y),ctr,rds,end,bgn
)
pixmap_gtkarcisi=: 3 : 0
ctr=. (0 1{y) + -: (2 3{y)
'bgn end'=. ctr calcAngle (4 5,:6 7){y
dif=. 2p1 | end - bgn
<. (4{.y), degree64 bgn,dif
)
rgba2cairo=: 3 : 0
'r g b a'=. 255%~ 4{.y,0
a=. 1-a
(r,g,b), a
)
rgb2gtk=: 3 : 0
y=. <.y
(0 0 0 0{a.), 1 (3!:4) (256 * y) + 255 * 127 < y=. Endian 3{.y
)
parseFontname=: 3 : 0
font=. ' ',y
b=. (font=' ') > ~:/\font='"'
a: -.~ b <@(-.&'"');._1 font
)
FontStyle=: ;:'regular bold italic underline strikeout'

parseFontSpec=: 3 : 0
'ns styleangle'=. 2 split parseFontname y
'face size'=. ns
size=. 12". size
style=. FontStyle i. tolower each styleangle
style=. <.+/2^<:(style ((> 0) *. <) #FontStyle) # style
if. 1 e. an=. ('angle'-:5&{.)&> styleangle do.
  degree=. 10%~ 0". 5}.>(an i. 1){styleangle
else.
  degree=. 0
end.
face;size;style;degree
)
dlws=: 3 : 0
y }.~ +/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)
clws=: 3 : 0
+/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)
wdglshiftarg=: 3 : 0
if. (#wdglstr) = wdglptr=: wdglptr + clws wdglptr}. wdglstr do. '' return. end.
y=. wdglptr}.wdglstr
b=. y e. ' '
a=. y e. '*'
q=. 2| +/\ y e. '"'
d=. 2| +/\ y e. DEL
b=. b *. -.q+.d
a=. a *. -.q+.d
if. 1={.a do.
  z=. }.y
  wdglptr=: #wdglstr
elseif. (1={.d)+.(1={.q) do.
  p2=. 1+ (}.y) i. {.y
  z=. }.p2{.y
  wdglptr=: wdglptr+ p2+1
elseif. 1 e. b do.
  p2=. {.I.b
  z=. p2{.y
  wdglptr=: wdglptr+ 1+p2
elseif. do.
  z=. y
  wdglptr=: #wdglstr
end.
<z
)
wdglshiftargs=: 3 : 0
wdglptr=: 0 [ wdglstr=: y
z=. 0$<''
while. wdglptr < #wdglstr do. z=. z, wdglshiftarg'' end.
z
)

tors=: 3 : 0
(2{.y),(2{.y)+2}.y
)

androidcolor=: 3 : 0
'paint andcolor'=. y
jniCheck paint ('setColor (I)V' jniMethod)~ andcolor
)
glarc=: (cairo_glarc`gdi32_glarc`and_glarc`qt_glarc@.GL2Backend_jgl2_)`(glarc_n_jgl2_&glbuf)@.glqmark
glarcx=: (cairo_glarcx`gdi32_glarcx`and_glarcx`qt_glarcx@.GL2Backend_jgl2_)`(glarcx_n_jgl2_&glbuf)@.glqmark
glbrush=: (cairo_glbrush`gdi32_glbrush`and_glbrush`qt_glbrush@.GL2Backend_jgl2_)`(glbrush_n_jgl2_&glbuf)@.glqmark
glbrushnull=: (cairo_glbrushnull`gdi32_glbrushnull`and_glbrushnull`qt_glbrushnull@.GL2Backend_jgl2_)`(glbrushnull_n_jgl2_&glbuf)@.glqmark
glcapture=: (cairo_glcapture`gdi32_glcapture`and_glcapture`qt_glcapture@.GL2Backend_jgl2_)`(glcapture_n_jgl2_&glbuf)@.0:
glcaret=: (cairo_glcaret`gdi32_glcaret`and_glcaret`qt_glcaret@.GL2Backend_jgl2_)`(glcaret_n_jgl2_&glbuf)@.0:
glclear=: (cairo_glclear`gdi32_glclear`and_glclear`qt_glclear@.GL2Backend_jgl2_)`(glclear_n_jgl2_&glbuf)@.glqmark
glclip=: (cairo_glclip`gdi32_glclip`and_glclip`qt_glclip@.GL2Backend_jgl2_)`(glclip_n_jgl2_&glbuf)@.glqmark
glclipreset=: (cairo_glclipreset`gdi32_glclipreset`and_glclipreset`qt_glclipreset@.GL2Backend_jgl2_)`(glclipreset_n_jgl2_&glbuf)@.glqmark
glcmds=: (cairo_glcmds`gdi32_glcmds`and_glcmds`qt_glcmds@.GL2Backend_jgl2_)`(glcmds_n_jgl2_&glbuf)@.glqmark
glcursor=: (cairo_glcursor`gdi32_glcursor`and_glcursor`qt_glcursor@.GL2Backend_jgl2_)`(glcursor_n_jgl2_&glbuf)@.0:
glellipse=: (cairo_glellipse`gdi32_glellipse`and_glellipse`qt_glellipse@.GL2Backend_jgl2_)`(glellipse_n_jgl2_&glbuf)@.glqmark
glfont=: (cairo_glfont`gdi32_glfont`and_glfont`qt_glfont@.GL2Backend_jgl2_)`(glfont_n_jgl2_&glbuf)@.glqmark
glfontangle=: (cairo_glfontangle`gdi32_glfontangle`and_glfontangle`qt_glfontangle@.GL2Backend_jgl2_)`(glfontangle_n_jgl2_&glbuf)@.glqmark
gllines=: (cairo_gllines`gdi32_gllines`and_gllines`qt_gllines@.GL2Backend_jgl2_)`(gllines_n_jgl2_&glbuf)@.glqmark
glnodblbuf=: (cairo_glnodblbuf`gdi32_glnodblbuf`and_glnodblbuf`qt_glnodblbuf@.GL2Backend_jgl2_)`(glnodblbuf_n_jgl2_&glbuf)@.0:
glpaint=: (cairo_glpaint`gdi32_glpaint`and_glpaint`qt_glpaint@.GL2Backend_jgl2_)`(glpaint_n_jgl2_&glbuf)@.0:
glpaintx=: (cairo_glpaintx`gdi32_glpaintx`and_glpaintx`qt_glpaintx@.GL2Backend_jgl2_)`(glpaintx_n_jgl2_&glbuf)@.0:
glpen=: (cairo_glpen`gdi32_glpen`and_glpen`qt_glpen@.GL2Backend_jgl2_)`(glpen_n_jgl2_&glbuf)@.glqmark
glpie=: (cairo_glpie`gdi32_glpie`and_glpie`qt_glpie@.GL2Backend_jgl2_)`(glpie_n_jgl2_&glbuf)@.glqmark
glpixel=: (cairo_glpixel`gdi32_glpixel`and_glpixel`qt_glpixel@.GL2Backend_jgl2_)`(glpixel_n_jgl2_&glbuf)@.glqmark
glpixels=: (cairo_glpixels`gdi32_glpixels`and_glpixels`qt_glpixels@.GL2Backend_jgl2_)`(glpixels_n_jgl2_&glbuf)@.glqmark
glpixelsx=: (cairo_glpixelsx`gdi32_glpixelsx`and_glpixelsx`qt_glpixelsx@.GL2Backend_jgl2_)`(glpixelsx_n_jgl2_&glbuf)@.glqmark
glpolygon=: (cairo_glpolygon`gdi32_glpolygon`and_glpolygon`qt_glpolygon@.GL2Backend_jgl2_)`(glpolygon_n_jgl2_&glbuf)@.glqmark
glqextent=: (cairo_glqextent`gdi32_glqextent`and_glqextent`qt_glqextent@.GL2Backend_jgl2_)`(glqextent_n_jgl2_&glbuf)@.0:
glqextentw=: (cairo_glqextentw`gdi32_glqextentw`and_glqextentw`qt_glqextentw@.GL2Backend_jgl2_)`(glqextentw_n_jgl2_&glbuf)@.0:
glqpixels=: (cairo_glqpixels`gdi32_glqpixels`and_glqpixels`qt_glqpixels@.GL2Backend_jgl2_)`(glqpixels_n_jgl2_&glbuf)@.0:
glqtextmetrics=: (cairo_glqtextmetrics`gdi32_glqtextmetrics`and_glqtextmetrics`qt_glqtextmetrics@.GL2Backend_jgl2_)`(glqtextmetrics_n_jgl2_&glbuf)@.0:
glqwh=: (cairo_glqwh`gdi32_glqwh`and_glqwh`qt_glqwh@.GL2Backend_jgl2_)`(glqwh_n_jgl2_&glbuf)@.0:
glrect=: (cairo_glrect`gdi32_glrect`and_glrect`qt_glrect@.GL2Backend_jgl2_)`(glrect_n_jgl2_&glbuf)@.glqmark
glrgb=: (cairo_glrgb`gdi32_glrgb`and_glrgb`qt_glrgb@.GL2Backend_jgl2_)`(glrgb_n_jgl2_&glbuf)@.glqmark
glsetbrush=: (cairo_glsetbrush`gdi32_glsetbrush`and_glsetbrush`qt_glsetbrush@.GL2Backend_jgl2_)`(glsetbrush_n_jgl2_&glbuf)@.glqmark
glsetlocale=: (cairo_glsetlocale`gdi32_glsetlocale`and_glsetlocale`qt_glsetlocale@.GL2Backend_jgl2_)`(glsetlocale_n_jgl2_&glbuf)@.0:
glsetpen=: (cairo_glsetpen`gdi32_glsetpen`and_glsetpen`qt_glsetpen@.GL2Backend_jgl2_)`(glsetpen_n_jgl2_&glbuf)@.0:
gltext=: (cairo_gltext`gdi32_gltext`and_gltext`qt_gltext@.GL2Backend_jgl2_)`(gltext_n_jgl2_&glbuf)@.glqmark
gltextcolor=: (cairo_gltextcolor`gdi32_gltextcolor`and_gltextcolor`qt_gltextcolor@.GL2Backend_jgl2_)`(gltextcolor_n_jgl2_&glbuf)@.glqmark
gltextxy=: (cairo_gltextxy`gdi32_gltextxy`and_gltextxy`qt_gltextxy@.GL2Backend_jgl2_)`(gltextxy_n_jgl2_&glbuf)@.glqmark
glwindoworg=: (cairo_glwindoworg`gdi32_glwindoworg`and_glwindoworg`qt_glwindoworg@.GL2Backend_jgl2_)`(glwindoworg_n_jgl2_&glbuf)@.glqmark
glprint=: cairo_glprint`gdi32_glprint`and_glprint`qt_glprint@.GL2Backend_jgl2_
glprintmore=: cairo_glprintmore`gdi32_glprintmore`and_glprintmore`qt_glprintmore@.GL2Backend_jgl2_
glqhandles=: cairo_glqhandles`gdi32_glqhandles`and_glqhandles`qt_glqhandles@.GL2Backend_jgl2_
glqprintpaper=: cairo_glqprintpaper`gdi32_glqprintpaper`and_glqprintpaper`qt_glqprintpaper@.GL2Backend_jgl2_
glqprintwh=: cairo_glqprintwh`gdi32_glqprintwh`and_glqprintwh`qt_glqprintwh@.GL2Backend_jgl2_
glemfclose=: cairo_glemfclose`gdi32_glemfclose`and_glemfclose`qt_glemfclose@.GL2Backend_jgl2_
glemfopen=: cairo_glemfopen`gdi32_glemfopen`and_glemfopen`qt_glemfopen@.GL2Backend_jgl2_
glemfplay=: cairo_glemfplay`gdi32_glemfplay`and_glemfplay`qt_glemfplay@.GL2Backend_jgl2_
glfile=: cairo_glfile`gdi32_glfile`and_glfile`qt_glfile@.GL2Backend_jgl2_
glroundr=: cairo_glroundr`gdi32_glroundr`and_glroundr`qt_glroundr@.GL2Backend_jgl2_
