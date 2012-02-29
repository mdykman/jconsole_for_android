require 'gtk'
coclass 'jgl2'

RGBSEQ=: IFJ6
FIXFONT=: PROFONT=: IFUNIX{::'Tahoma 10';'Sans 10'

create=: destroy=: [:

locGL2=: 0$<''

3 : 0''
if. 0~: 4!:0 <'GL2Backend_j_' do. GL2Backend_j_=: 0 end.
if. 0~: 4!:0 <'GL2ExtGlcmds_j_' do. GL2ExtGlcmds_j_=: 1 end.
)

GL2Backend=: GL2Backend_j_
GL2Backend=: ((-.IFWIN) *. GL2Backend e. 3 4){GL2Backend, 0
GL2ExtGlcmds=: GL2ExtGlcmds_j_
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
glarc=: 3 : 0
glarc__l y [[ l=. locGL2_jgl2_
)

glarcx=: 3 : 0
glarcx__l y [[ l=. locGL2_jgl2_
)

glbrush=: 3 : 0
glbrush__l y [[ l=. locGL2_jgl2_
)

glbrushnull=: 3 : 0
glbrushnull__l y [[ l=. locGL2_jgl2_
)

glclear=: 3 : 0
glclear__l y [[ l=. locGL2_jgl2_
)

glclip=: 3 : 0
glclip__l y [[ l=. locGL2_jgl2_
)

glclipreset=: 3 : 0
glclipreset__l y [[ l=. locGL2_jgl2_
)

glcmds=: 3 : 0
glcmds__l y [[ l=. locGL2_jgl2_
)

glellipse=: 3 : 0
glellipse__l y [[ l=. locGL2_jgl2_
)

glfont=: 3 : 0
glfont__l y [[ l=. locGL2_jgl2_
)

glfontangle=: 3 : 0
glfontangle__l y [[ l=. locGL2_jgl2_
)

glrgb=: 3 : 0
glrgb__l y [[ l=. locGL2_jgl2_
)

gllines=: 3 : 0
gllines__l y [[ l=. locGL2_jgl2_
)

glpaint=: 3 : 0
glpaint__l y [[ l=. locGL2_jgl2_
)

glpaintx=: 3 : 0
glpaintx__l y [[ l=. locGL2_jgl2_
)

glpen=: 3 : 0
glpen__l y [[ l=. locGL2_jgl2_
)

glpie=: 3 : 0
glpie__l y [[ l=. locGL2_jgl2_
)

glpixel=: 3 : 0
glpixel__l y [[ l=. locGL2_jgl2_
)

glpixels=: 3 : 0
glpixels__l y [[ l=. locGL2_jgl2_
)

glpolygon=: 3 : 0
glpolygon__l y [[ l=. locGL2_jgl2_
)

glqpixels=: 3 : 0
glqpixels__l y [[ l=. locGL2_jgl2_
)

glqwh=: 3 : 0
glqwh__l y [[ l=. locGL2_jgl2_
)

glrect=: 3 : 0
glrect__l y [[ l=. locGL2_jgl2_
)

glsetbrush=: 3 : 0
glsetbrush__l y [[ l=. locGL2_jgl2_
)

glsetpen=: 3 : 0
glsetpen__l y [[ l=. locGL2_jgl2_
:
x glsetpen__l y [[ l=. locGL2_jgl2_
)

gltext=: 3 : 0
gltext__l y [[ l=. locGL2_jgl2_
)

gltextcolor=: 3 : 0
gltextcolor__l y [[ l=. locGL2_jgl2_
)

gltextxy=: 3 : 0
gltextxy__l y [[ l=. locGL2_jgl2_
)

glqextent=: 3 : 0
glqextent__l y [[ l=. locGL2_jgl2_
)

glqextentw=: 3 : 0
glqextentw__l y [[ l=. locGL2_jgl2_
)

glwindoworg=: 3 : 0
glwindoworg__l y [[ l=. locGL2_jgl2_
)

glcapture=: 3 : 0
glcapture__l y [[ l=. locGL2_jgl2_
)

glcaret=: 3 : 0
glcaret__l y [[ l=. locGL2_jgl2_
)

glcmds=: 3 : 0
glcmds__l y [[ l=. locGL2_jgl2_
)

glcursor=: 3 : 0
glcursor__l y [[ l=. locGL2_jgl2_
)

glemfclose=: 3 : 0
glemfclose__l y [[ l=. locGL2_jgl2_
)

glemfopen=: 3 : 0
glemfopen__l y [[ l=. locGL2_jgl2_
)

glemfplay=: 3 : 0
glemfplay__l y [[ l=. locGL2_jgl2_
)

glfile=: 3 : 0
glfile__l y [[ l=. locGL2_jgl2_
)

glnodblbuf=: 3 : 0
glnodblbuf__l y [[ l=. locGL2_jgl2_
)

glpixelsx=: 3 : 0
glpixelsx__l y [[ l=. locGL2_jgl2_
)

glprint=: 3 : 0
glprint__l y [[ l=. locGL2_jgl2_
)

glprintmore=: 3 : 0
glprintmore__l y [[ l=. locGL2_jgl2_
)

glqhandles=: 3 : 0
glqhandles__l y [[ l=. locGL2_jgl2_
)

glqprintpaper=: 3 : 0
glqprintpaper__l y [[ l=. locGL2_jgl2_
)

glqprintwh=: 3 : 0
glqprintwh__l y [[ l=. locGL2_jgl2_
)

glqtextmetrics=: 3 : 0
glqtextmetrics__l y [[ l=. locGL2_jgl2_
)

glroundr=: 3 : 0
glroundr__l y [[ l=. locGL2_jgl2_
)
glcanvas=: 0&$: : (4 : 0)
'p c wh l'=. 4{.y
if. 0=#>l do.
  l=. coname''
  if. l-:<'jgl2' do.
    'missing parent locale' 13!:8[3
  end.
else.
  l=. boxxopen l
end.
locGL2_jgl2_=: b=. (wh,x) conew 'jglcanvas'
PForm__b=: ,p
PId__b=: ,c
PLocale__b=: l
b
)

glsetlocale=: 3 : 0
b=. locGL2_jgl2_
PLocale__b=: y
)
glsel=: 3 : 0
if. 2 131072 e.~ 3!:0 y do.
  if. 3 = 4!:0 <'getlocgl2_gtkwd_' do.
    y=. getlocgl2_gtkwd_ ,y
  end.
end.
l=. locGL2_jgl2_=: boxxopen y
try.
  if. iOPENGL=gloption__l do.
    ogl=. ogl__l
    current__ogl canvas__l
  end.
catch. end.
EMPTY
)
3 : 0''
if. IFWIN do.
  require 'api/gdi32 api/gdiplus'
end.
EMPTY
)

coclass'jglcanvas'
coinsert'jgtk'

3 : 0''
if. IFWIN do.
  coinsert 'jgdi32 jgdiplus'
  so=. 'libglcmds',((-.IF64)#'_32'),'.dll'
else.
  so=. 'libglcmds',((-.IF64)#'_32'),(UNAME-:'Darwin'){::'.so';'.dylib'
end.
LIBGLCMDS=: ''
if. fexist f=. jpath '~addons/graphics/gl2/',so do.
  LIBGLCMDS=: f
elseif. fexist f=. jpath '~tools/',so do.
  LIBGLCMDS=: f
elseif. fexist f=. jpath '~bin/',so do.
  LIBGLCMDS=: f
end.
LIBGLCMDS=: dquote^:(' 'e.]) LIBGLCMDS
EMPTY
)

'iGL2 iOPENGL'=: i.2

initialized=: 0
RGBSEQ=: RGBSEQ_jgl2_
gloption=: iGL2
PForm=: PId=: PLocale=: ''
gtkcr=: gtkpl=: 0
gtkwin=: gtkdagc=: gtkgc=: gtkpx=: gtkpc=: gtkpl=: gtkplc=: 0
gtkclipped=: gtkrgb=: gtkfontangle=: gtkunderline=: 0
gtktextxy=: 0 0
gtkpenrgb=: gtkbrushrgb=: gtktextrgb=: gtkbrushnull=: 0
TOK=: BMP=: GC=: PEN=: BRUSH=: FONT=: TXTCLR=: 0
HDC=: BMP=: PEN=: BRUSH=: FONT=: OLDPEN=: OLDBRUSH=: OLDFONT=: 0
printoperation=: printcontext=: 0
twipscaled=: 2$1%1
printnpage=: 1
async_print=: IFUNIX
printsettings=: 0
ogl=: 0$<''
newctx=: 1
newsize=: 1
create=: 3 : 0
'w h option'=. 3{.y
canvas=: gtk_drawing_area_new''
gtkwh=: w,h
gloption=: option

if. *./ 0<w,h do.
  gtk_widget_set_size_request canvas,w,h
end.
gtk_widget_set_can_focus ::0: canvas,1
events=. GDK_EXPOSURE_MASK,GDK_BUTTON_PRESS_MASK,GDK_BUTTON_RELEASE_MASK,GDK_POINTER_MOTION_MASK,GDK_KEY_PRESS_MASK,GDK_KEY_RELEASE_MASK,GDK_FOCUS_CHANGE_MASK
gtk_widget_add_events canvas, OR events

consig3 canvas;'configure-event';'configure_event'
consig canvas;'realize';'realize_event'
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

0
)
destroy=: 3 : 0
if. (iOPENGL=gloption) *. #ogl do.
  destroy__ogl ''
end.
cbfree''
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
button_event=: 4 : 0
'widget event data'=. y
n=. ,(get_button event){' lmr'
x=. ,>(5=get_type event){x;'dbl'
name=. 'mb',n,x
mousepos=. <.2 3{;gdk_event_get_coords event;(,0.0);,0.0
state=. 2{;gdk_event_get_state event;,0
'shift lock control mod1 mod2 mod3 mod4 mod5 button1 button2 button3 button4 button5'=. 13{. |.(32#2) #: state
if. #PForm do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_',name,'_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysmodifiers__PLocale=: ,":shift+2*control
      sysdata__PLocale=: 0":mousepos,gtkwh,button1,button2,control,shift,button3,0,0,0
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      f~ ''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
elseif. 'gtkwd'-:PId do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      (coname'') (f~)~ name; (0":mousepos,gtkwh,button1,button2,control,shift,button3,0,0,0) ; ,":shift+2*control
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
0
)
button_press_event=: 3 : 0
'down' button_event y
)
button_release_event=: 3 : 0
'up' button_event y
)
scroll_event=: 3 : 0
'widget event data'=. y
dir=. 256#.endian a.i.memr event,GdkEventScroll_direction,4
mousepos=. <.2 3{;gdk_event_get_coords event;(,0.0);,0.0
state=. 2{;gdk_event_get_state event;,0
'shift lock control mod1 mod2 mod3 mod4 mod5 button1 button2 button3 button4 button5'=. 13{. |.(32#2) #: state
if. #PForm do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_mwheel_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysmodifiers__PLocale=: ,":shift+2*control
      sysdata__PLocale=: 0":mousepos,gtkwh,button1,button2,control,shift,button3,0,0,1-2*dir
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      f~ ''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
elseif. 'gtkwd'-:PId do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      (coname'') (f~)~ 'mwheel'; (0":mousepos,gtkwh,button1,button2,control,shift,button3,0,0,0) ; ,":shift+2*control
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
0
)
motion_notify_event=: 3 : 0
'widget event gpointer'=. y
mousepos=. <.2 3{;gdk_event_get_coords event;(,0.0);,0.0
state=. 2{;gdk_event_get_state event;,0
'shift lock control mod1 mod2 mod3 mod4 mod5 button1 button2 button3 button4 button5'=. 13{. |.(32#2) #: state
if. #PForm do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_mmove_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysmodifiers__PLocale=: ,":shift+2*control
      sysdata__PLocale=: 0":mousepos,gtkwh,button1,button2,control,shift,button3,0,0,0
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      f~ ''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
elseif. 'gtkwd'-:PId do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      (coname'') (f~)~ 'mmove'; (0":mousepos,gtkwh,button1,button2,control,shift,button3,0,0,0) ; ,":shift+2*control
      if. (iOPENGL=gloption) *. #ogl do.
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
if. #PForm do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_char_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysmodifiers__PLocale=: ,":shift+2*control
      sysdata__PLocale=: utf8 u: key
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      f~ ''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
elseif. 'gtkwd'-:PId do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      (coname'') (f~)~ 'char'; (utf8 u: key) ; ,":shift+2*control
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
0
)
focus_in_event=: 3 : 0
'widget event data'=. y
if. #PForm do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_focus_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysfocus__PLocale=: PId
      syslastfocus__PLocale=: PId
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      f~ ''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
elseif. 'gtkwd'-:PId do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysfocus__PLocale=: PId
      syslastfocus__PLocale=: PId
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      (coname'') (f~)~ ,<'focus'
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
1
)
focus_out_event=: 3 : 0
'widget event data'=. y
if. #PForm do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_focuslost_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysfocus__PLocale=: PId
      syslastfocus__PLocale=: PId
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      f~ ''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
elseif. 'gtkwd'-:PId do.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysfocus__PLocale=: PId
      syslastfocus__PLocale=: PId
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      (coname'') (f~)~ ,<'focuslost'
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.
1
)
realize_event=: 3 : 0
'widget data'=. y
gtkwh=: _2{. getGtkWidgetAllocation widget
0
)
configure_event=: 3 : 0
'widget event data'=. y
gtkwh=: _2{. getGtkWidgetAllocation widget
gtkwin=: getGtkWidgetWindow widget
newsize=: 1
if. (iOPENGL=gloption) *. #ogl do.
  wh__ogl=: gtkwh
  if. #PForm do. openglut_newsize__PLocale=: 1 end.
  if. OsMesa_jzopengl_ do. free__ogl widget end.
  if. 0= ctx=. getglctx__ogl widget do.
    ctx=. alloc__ogl widget
    newctx=: 1
  end.
  if. 0= ctx do. smoutput 'cannot alloc opengl context' end.
end.
if. iOPENGL~:gloption do.
  if. GL2Backend_jgl2_ e. 0 1 do.
    if. 0~:gtkpl do. gtkpl=: 0 [ g_object_unref gtkpl end.
    if. 0~:gtkcr do. gtkcr=: 0 [ cairo_destroy gtkcr end.
    gtkcr=: cairo_create surface=. cairo_image_surface_create CAIRO_FORMAT_RGB24,gtkwh
    cairo_surface_destroy surface
    gtkpl=: pango_cairo_create_layout gtkcr
  elseif. 2=GL2Backend_jgl2_ do.
    if. gtkpx do. g_object_unref gtkpx end.
    if. gtkgc do. g_object_unref gtkgc end.
    if. gtkpl do. g_object_unref gtkpl end.
    if. gtkpc do. g_object_unref gtkpc end.
    gtkdagc=: getdagc widget
    gtkgc=: gdk_gc_new gtkwin
    gtkpx=: gdk_pixmap_new gtkwin,gtkwh,_1
    gtkpc=: gtk_widget_create_pango_context widget
    gtkpl=: pango_layout_new gtkpc
    gtkplc=: pango_layout_get_context gtkpl
  elseif. 3=GL2Backend_jgl2_ do.
    if. 0~:TOK do. gdip_free '' end.
    gdip_init gtkwh
    assert. 0~:TOK,GC
  elseif. 4=GL2Backend_jgl2_ do.
    if. 0~:HDC do. gdi32_free '' end.
    gdi32_init gtkwh
    assert. 0~:HDC,BMP
  end.
  glclear''
end.
initialized=: 1
if. #PForm do.
  locGL2_jgl2_=: coname''
elseif. 'gtkwd'-:PId do.
  locGL2_jgl2_=: coname''
end.

0
)
draw=: expose_event=: 3 : 0
'widget event data'=. y
if. #PForm do.
  locGL2_jgl2_=: coname''
  if. (iOPENGL=gloption) *. #ogl do.
    current__ogl widget
  end.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_paint_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      f~ ''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
elseif. 'gtkwd'-:PId do.
  locGL2_jgl2_=: coname''
  if. (iOPENGL=gloption) *. #ogl do.
    current__ogl widget
  end.
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl widget [ ogl__PLocale=: ogl
      end.
      (coname'') (f~)~ ,<'paint'
      if. (iOPENGL=gloption) *. #ogl do.
        current__ogl 0 [ show__ogl widget
      end.
    end.
  end.
end.

if. iOPENGL~:gloption do.
  if. GL2Backend_jgl2_ e. 0 1 do.
    if. 3=GTKVER_j_ do.
      cr=. event
      cairo_set_operator cr, CAIRO_OPERATOR_SOURCE
      cairo_set_source_surface cr; (cairo_get_target gtkcr); 0 ; 0
      cairo_paint cr
    else.
      cairo_surface_flush cairo_get_target gtkcr
      cr=. gdk_cairo_create getGtkWidgetWindow widget
      cairo_set_operator cr, CAIRO_OPERATOR_SOURCE
      cairo_set_source_surface cr; (cairo_get_target gtkcr); 0 ; 0
      cairo_rectangle cr; 0 ;0; <"0 gtkwh
      cairo_clip cr
      cairo_paint cr
      cairo_destroy cr
    end.
  elseif. 2=GL2Backend_jgl2_ do.
    gdk_draw_drawable gtkwin,gtkdagc,gtkpx, 0 0 0 0 _1 _1
  elseif. 3=GL2Backend_jgl2_ do.
    argb=. flip_rgb^:RGBSEQ gdip_glqpixels 0 0,gtkwh
    gtkwin pixbufwin_setpixels 0 0,gtkwh,argb
  elseif. 4=GL2Backend_jgl2_ do.
    argb=. flip_rgb^:RGBSEQ gdi32_glqpixels 0 0,gtkwh
    gtkwin pixbufwin_setpixels 0 0,gtkwh,argb
  end.
end.
0
)
destroy_event=: 3 : 0
'widget data'=. y

if. (iOPENGL=gloption) *. #ogl do.
  current__ogl 0 [ removectx__ogl widget
end.
if. iOPENGL~:gloption do.
  if. GL2Backend_jgl2_ e. 0 1 do.
    if. 0~:gtkpl do. gtkpl=: 0 [ g_object_unref gtkpl end.
    if. 0~:gtkcr do. gtkcr=: 0 [ cairo_destroy gtkcr end.
  elseif. 2=GL2Backend_jgl2_ do.
    if. gtkpx do. g_object_unref gtkpx end.
    if. gtkgc do. g_object_unref gtkgc end.
    if. gtkpl do. g_object_unref gtkpl end.
    if. gtkpc do. g_object_unref gtkpc end.
  elseif. 3=GL2Backend_jgl2_ do.
    if. 0~:TOK do. gdip_free '' end.
  elseif. 4=GL2Backend_jgl2_ do.
    if. 0~:HDC do. gdi32_free '' end.
  end.
end.

destroy ''
0
)
draw_page=: 3 : 0
'operation context page_nr data'=. y
assert. iOPENGL~:gloption
gtkcr=: gtk_print_context_get_cairo_context context
gtkpl=: gtk_print_context_create_pango_layout context
w=. <. gtk_print_context_get_width context
h=. <. gtk_print_context_get_height context
gtkwh=: w,h
gtkclipped=: 0
glclear''
paint__PLocale ''
gtkpl=: 0 [ g_object_unref gtkpl
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
gtkpl=: gtk_print_context_create_pango_layout context
gtkpc=: gtk_print_context_create_pango_context context
w=. <. gtk_print_context_get_width context
h=. <. gtk_print_context_get_height context
gtkwh=: w,h
dpix=: <. gtk_print_context_get_dpi_x context
dpiy=: <. gtk_print_context_get_dpi_y context
twipscaled=: 1440 %~ dpix,dpiy
if. #PForm do.
  locGL2_jgl2_=: coname''
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_print_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysdata__PLocale=: ":0 0
      f~ ''
    end.
  end.
elseif. 'gtkwd'-:PId do.
  locGL2_jgl2_=: coname''
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      (coname'') (f~)~ 'print'; ":0 0
    end.
  end.
end.
printoperation=: printcontext=: 0
gtkpl=: 0 [ g_object_unref gtkpl
gtkpc=: 0 [ g_object_unref gtkpc
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
gtkpl=: gtk_print_context_create_pango_layout context
gtkpc=: gtk_print_context_create_pango_context context
w=. <. gtk_print_context_get_width context
h=. <. gtk_print_context_get_height context
gtkwh=: w,h
gtkclipped=: 0
glclear''
if. #PForm do.
  locGL2_jgl2_=: coname''
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_print_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysdata__PLocale=: ":page_nr, 1
      f~ ''
    end.
  end.
elseif. 'gtkwd'-:PId do.
  locGL2_jgl2_=: coname''
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      (coname'') (f~)~ 'print'; ":page_nr, 1
    end.
  end.
end.
printoperation=: printcontext=: 0
gtkpl=: 0 [ g_object_unref gtkpl
gtkpc=: 0 [ g_object_unref gtkpc
gtkcr=: 0
0
)
print_done=: 3 : 0
'operation res data'=. y
assert. iOPENGL~:gloption
if. #PForm do.
  locGL2_jgl2_=: coname''
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. PForm,'_',PId,'_print_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      sysdata__PLocale=: ":0 _1
      f~ ''
    end.
  end.
elseif. 'gtkwd'-:PId do.
  locGL2_jgl2_=: coname''
  if. (0: <: 18!:0) PLocale do.
    if. 3= nc <f=. 'isigraph_event_',(>PLocale),'_' do.
      locGL2_jgl2_=: coname''
      (coname'') (f~)~ 'print'; ":0 _1
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
_2 {. ;pango_layout_get_pixel_size x;(,2);,3
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
cairo_glwindoworg 0 0
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
cairo_glcmds=: 3 : 0
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. GL2ExtGlcmds_jgl2_ *. 0~:#LIBGLCMDS_jglcanvas_ do.
  ipar=. gtkclipped,gtkwh,gtkrgb,gtktextxy,gtkunderline,gtkfontangle,gtkpenrgb,gtkbrushrgb,gtktextrgb,gtkbrushnull
  (LIBGLCMDS,' Glcmds_cairo > + i x x *x *c *x x')&cd gtkcr;gtkpl;ipar;(utf8 PROFONT_jgl2_);(,y);#y
  'clip gtkw gtkh rgb tx ty underline angle penrgb brushrgb textrgb brushnull'=. ipar
  gtkclipped=: clip [ gtkrgb=: rgb [ gtktextxy=: tx,ty [ gtkunderline=: underline [ gtkfontangle=: angle
  gtkpenrgb=: penrgb [ gtkbrushrgb=: brushrgb [ gtktextrgb=: textrgb [ gtkbrushnull=: brushnull
  0 return.
end.
p=. 0
while. p<#y do.
  cnt=. p{y
  cmd=. (1+p){y
  dat=. (2+p+i.cnt-2){y
  select. cmd
  case. 2001 do. cairo_glarc dat
  case. 2003 do. ''
  case. 2004 do. cairo_glbrush dat
  case. 2005 do. cairo_glbrushnull dat
  case. 2062 do. ''
  case. 2065 do. cairo_glcaret dat
  case. 2007 do. cairo_glclear dat
  case. 2078 do. cairo_glclip dat
  case. 2079 do. cairo_glclipreset dat
  case. 2999 do. ''
  case. 2069 do. ''
  case. 2008 do. cairo_glellipse dat
  case. 2085 do. cairo_glemfclose dat
  case. 2084 do. cairo_glemfopen dat
  case. 2086 do. cairo_glemfplay dat
  case. 2066 do. cairo_glfile dat{a.
  case. 2012 do. cairo_glfont dat{a.
  case. 2312 do. cairo_glfont2 dat
  case. 2342 do. cairo_glfontangle dat
  case. 2015 do. cairo_gllines dat
  case. 2070 do. ''
  case. 2071 do. ''
  case. 2020 do. ''
  case. 2022 do. cairo_glpen dat
  case. 2023 do. cairo_glpie dat
  case. 2024 do. cairo_glpixel dat
  case. 2076 do. cairo_glpixels dat
  case. 2075 do. cairo_glpixelsx dat
  case. 2029 do. cairo_glpolygon dat
  case. 2089 do. ''
  case. 2091 do. ''
  case. 2057 do. ''
  case. 2083 do. ''
  case. 2060 do. ''
  case. 2077 do. ''
  case. 2092 do. ''
  case. 2088 do. ''
  case. 2058 do. ''
  case. 2059 do. ''
  case. 2031 do. cairo_glrect dat
  case. 2032 do. cairo_glrgb dat
  case. 2033 do. cairo_glroundr dat
  case. 2035 do. ''
  case. 2038 do. cairo_gltext dat{a.
  case. 2040 do. cairo_gltextcolor dat
  case. 2056 do. cairo_gltextxy dat
  case. 2045 do. cairo_glwindoworg dat
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
fnt=. pango_font_description_from_string <y
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
fnt=. pango_font_description_from_string <face
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
gtkrgb=: RGB y
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
cairo_glpaint=: 3 : 0 "1
newsize=: 1
gtk_widget_queue_draw canvas
0
)
cairo_glpaintx=: 3 : 0 "1
assert. 0~:gtkcr,gtkpl
newsize=: 1
if. iOPENGL~:gloption do.
  cairo_surface_flush cairo_get_target gtkcr
  cr=. gdk_cairo_create getGtkWidgetWindow canvas
  cairo_set_operator cr, CAIRO_OPERATOR_SOURCE
  cairo_set_source_surface cr; (cairo_get_target gtkcr); 0 ; 0
  cairo_rectangle cr; 0 ;0; <"0 gtkwh
  cairo_clip cr
  cairo_paint cr
  cairo_destroy cr
end.
0
)

cairo_glpen=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
gtkpenrgb=: gtkrgb
gtkpenwidth=: 0.5>.{.y
gtkpenstyle=: {:y
cairo_set_line_width gtkcr ; (1.1-1.1)+gtkpenwidth
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
cairo_rectangle gtkcr ; <"0 (twipscaled * 2{.y), 1 1
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
d=. flip_rgb^:(-.RGBSEQ) d

d=. 2 ic d
surface=. cairo_image_surface_create_for_data d ; CAIRO_FORMAT_RGB24 ; w ; h ; 4*w
if. surface do.
  cairo_save gtkcr
  cairo_set_operator gtkcr ; CAIRO_OPERATOR_OVER
  cairo_set_source_surface gtkcr ; surface ; a ; b
  cairo_rectangle gtkcr ; a ; b ; w ; h
  cairo_clip gtkcr
  cairo_paint gtkcr
  cairo_restore gtkcr
end.
cairo_surface_destroy surface
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
d=. flip_rgb^:(-.RGBSEQ) d

d=. 2 ic d
surface=. cairo_image_surface_create_for_data d ; CAIRO_FORMAT_RGB24 ; w ; h ; 4*w
if. surface do.
  cairo_save gtkcr
  cairo_set_operator gtkcr ; CAIRO_OPERATOR_OVER
  cairo_set_source_surface gtkcr ; surface ; a ; b
  cairo_rectangle gtkcr ; a ; b ; w ; h
  cairo_clip gtkcr
  cairo_paint gtkcr
  cairo_restore gtkcr
end.
cairo_surface_destroy surface
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

assert. 0~: ad=. cairo_image_surface_get_data surface
assert. (4*w)= cairo_image_surface_get_stride surface

if. IF64 do.
  r=. _2 ic memr ad,0,(w*h*4),JCHAR
else.
  r=. memr ad,0,(w*h),JINT
end.
cairo_destroy cr
cairo_surface_destroy surface

r=. flip_rgb^:(-.RGBSEQ) r
)
cairo_glqwh=: 3 : 0
gtkwh
)
cairo_glrect=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0 e. _2{.y do. 0 return. end.
assert. 0~:gtkcr,gtkpl
if. 0~:printcontext do. cairo_scale gtkcr ; <"0 twipscaled [ cairo_save gtkcr end.
if. -.gtkbrushnull do.
  cairo_cairocolor gtkbrushrgb
  cairo_rectangle gtkcr ; <"0 y
  cairo_fill_preserve gtkcr
  cairo_cairocolor gtkpenrgb
  cairo_stroke gtkcr
else.
  cairo_cairocolor gtkpenrgb
  cairo_rectangle gtkcr ; <"0 y
  cairo_stroke gtkcr
end.
if. 0~:printcontext do. cairo_restore gtkcr end.
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
z=. _2 {. ;pango_layout_get_pixel_size gtkpl;(,2);,3
z
)
cairo_glqextentw=: 3 : 0 "1
{."1>cairo_glqextent each<;._2 y,LF#~LF~:{:y
)
cairo_glwindoworg=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkcr,gtkpl
cairo_translate gtkcr ; <"0 twipscaled * y
0
)
cairo_glqhandles=: 3 : 0 "1
if. 0< #y do. (13!:8) 3 end.
canvas,gtkcr,gtkpl
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
cairo_printer_dialog=: 3 : 0
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
cairo_settings_printer=: 3 : 0
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
  ctx=. gtkpc
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
cairo_glnodblbuf=: [:
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
hwnd=. gdk_win32_drawable_get_handle gtkwin
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
  assert. prev=BRUSH
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
gdi32_glwindoworg 0 0
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
gdi32_glcmds=: 3 : 0
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
if. GL2ExtGlcmds_jgl2_ *. 0~:#LIBGLCMDS_jglcanvas_ do.
  xpar=. <.PEN,OLDPEN,BRUSH,OLDBRUSH,FONT,OLDFONT
  ipar=. <.gtkclipped,gtkwh,gtkrgb,gtktextxy,gtkunderline,gtkfontangle
  (LIBGLCMDS,' Glcmds_gdi32 > + i x *x *x *c *x x')&cd HDC;xpar;ipar;(utf8 ,PROFONT_jgl2_);(,y);#y
  'PEN OLDPEN BRUSH OLDBRUSH FONT OLDFONT'=: xpar
  'clip gtkw gtkh rgb tx ty underline angle'=. ipar
  gtkclipped=: clip [ gtkrgb=: rgb [ gtktextxy=: tx,ty [ gtkunderline=: underline [ gtkfontangle=: angle
  0 return.
end.
p=. 0
while. p<#y do.
  cnt=. p{y
  cmd=. (1+p){y
  dat=. (2+p+i.cnt-2){y
  select. cmd
  case. 2001 do. gdi32_glarc dat
  case. 2003 do. ''
  case. 2004 do. gdi32_glbrush dat
  case. 2005 do. gdi32_glbrushnull dat
  case. 2062 do. ''
  case. 2065 do. gdi32_glcaret dat
  case. 2007 do. gdi32_glclear dat
  case. 2078 do. gdi32_glclip dat
  case. 2079 do. gdi32_glclipreset dat
  case. 2999 do. ''
  case. 2069 do. ''
  case. 2008 do. gdi32_glellipse dat
  case. 2085 do. gdi32_glemfclose dat
  case. 2084 do. gdi32_glemfopen dat
  case. 2086 do. gdi32_glemfplay dat
  case. 2066 do. gdi32_glfile dat{a.
  case. 2012 do. gdi32_glfont dat{a.
  case. 2312 do. gdi32_glfont2 dat
  case. 2342 do. gdi32_glfontangle dat
  case. 2015 do. gdi32_gllines dat
  case. 2070 do. ''
  case. 2071 do. ''
  case. 2020 do. ''
  case. 2022 do. gdi32_glpen dat
  case. 2023 do. gdi32_glpie dat
  case. 2024 do. gdi32_glpixel dat
  case. 2076 do. gdi32_glpixels dat
  case. 2075 do. gdi32_glpixelsx dat
  case. 2029 do. gdi32_glpolygon dat
  case. 2089 do. ''
  case. 2091 do. ''
  case. 2057 do. ''
  case. 2083 do. ''
  case. 2060 do. ''
  case. 2077 do. ''
  case. 2092 do. ''
  case. 2088 do. ''
  case. 2058 do. ''
  case. 2059 do. ''
  case. 2031 do. gdi32_glrect dat
  case. 2032 do. gdi32_glrgb dat
  case. 2033 do. gdi32_glroundr dat
  case. 2035 do. ''
  case. 2038 do. gdi32_gltext dat{a.
  case. 2040 do. gdi32_gltextcolor dat
  case. 2056 do. gdi32_gltextxy dat
  case. 2045 do. gdi32_glwindoworg dat
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
  if. -. IF64 *. GL2ExtGlcmds_jgl2_ *. 0~:#LIBGLCMDS_jglcanvas_ do.
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
gtkrgb=: BGR y
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
gdi32_glpaint=: 3 : 0 "1
newsize=: 1
gtk_widget_queue_draw canvas
0
)
gdi32_glpaintx=: 3 : 0 "1
assert. 0~:HDC,BMP
newsize=: 1
if. iOEPNGL~:gloption do.
  argb=. gdi32_glqpixels 0 0,gtkwh
  gtkwin pixbufwin_setpixels 0 0,gtkwh,argb
end.
0
)

gdi32_glpen=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
gtkpenwidth=. 0>.{.y
gtkpenstyle=. {:y
gtkpenrgb=: gtkrgb
obj=. CreatePen gtkpenstyle , gtkpenwidth , gtkpenrgb
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
SetPixel HDC,(<.2{.y),gtkrgb
0
)
gdi32_glpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
'a b w h1'=. 4{.y
h=. |h1
d=. 4}.y
d=. , |.^:(h1<0) (h,w)$flip_rgb^:RGBSEQ d

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
d=. , |.^:(h1<0) (h,w)$flip_rgb^:RGBSEQ d

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
z=. flip_rgb^:RGBSEQ ,z
)
gdi32_glqtextmetrics=: 3 : 0 "1
metrics=. 64${.a.
r=. GetTextMetrics HDC, metrics
'h as de int ext acw mcw'=. _2 ic 28{.metric
)
gdi32_glqwh=: 3 : 0
gtkwh
)
gdi32_glrect=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0 e. _2{.y do. 0 return. end.
assert. 0~:HDC,BMP
Rectangle HDC, (2{.y), (2{.y) + 2}.y
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
{."1>gdi32_glqextent each<;._2 y,LF#~LF~:{:y
)
gdi32_glwindoworg=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:HDC,BMP
SetViewportOrgEx HDC;(<"0 y),<<0
0
)
gdi32_glemfclose=: [:
gdi32_glemfopen=: [:
gdi32_glemfplay=: [:
gdi32_glfile=: [:
gdi32_glnodblbuf=: [:
gdi32_glprint=: [:
gdi32_glprintmore=: [:
gdi32_glqhandles=: [:
gdi32_glqprintpaper=: [:
gdi32_glqprintwh=: [:
gdi32_glroundr=: [:
gdip_init=: 3 : 0
'w h'=. y
MAT=: (|.y)$_1
TOK=: {.TOK [ r=. GdiplusStartup (TOK=: ,_1);GdiplusStartupInput;0
assert. 0=r
BMP=: {.BMP [ r=. GdipCreateBitmapFromScan0 w;h;(w*4);PixelFormat32bppARGB;MAT;BMP=: ,_1
assert. 0=r
GC=: {. GC [ r= GdipGetImageGraphicsContext BMP;GC=: ,_1
assert. 0=r
assert. 0~:TOK,BMP,GC
PenUnit=: Pixel [ FontUnit=: Point
PEN=: BRUSH=: FONT=: TXTCLR=: 0
gtktextxy=: 2$0
gtkrgb=: BGRA 0 0 0
EMPTY
)
gdip_free=: 3 : 0
if. FONT do. GdipDeleteFont FONT end.
if. PEN do. GdipDeletePen PEN end.
if. BRUSH do. GdipDeleteBrush BRUSH end.
if. TXTCLR do. GdipDeleteBrush TXTCLR end.
if. GC do. GdipDeleteGraphics GC end.
if. BMP do. GdipDisposeImage BMP end.
if. TOK do. GdiplusShutdown TOK end.
TOK=: BMP=: GC=: 0
PEN=: BRUSH=: FONT=: TXTCLR=: 0
)
gdip_glarc2=: 3 : 0 "1
if. PEN do.
  GdipDrawArc GC;PEN;<"0 <.y
end.
)
gdip_glpie2=: 3 : 0 "1
if. (-.gtkbrushnull) *. BRUSH do.
  GdipFillPie GC;BRUSH;<"0 <.y
end.
if. PEN do.
  GdipDrawPie GC;PEN;<"0 <.y
end.
)

gdip_glcurve=: 3 : 0 "1
if. PEN do.
  if. 2|#y do. 't y'=. ({. ; }.) y else. t=. 1 end.
  GdipDrawCurve GC;PEN;(<.y);(<.-:#y);t%1
end.
)

gdip_glclosedcurve=: 3 : 0 "1
if. 2|#y do. 't y'=. ({. ; }.) y else. t=. 1 end.
if. (-.gtkbrushnull) *. BRUSH do.
  GdipFillClosedCurve GC;BRUSH;(<.y);(<.-:#y);(t%1);FillModeWinding
end.
if. PEN do.
  GdipDrawClosedCurve GC;PEN;(<.y);(<.-:#y);t%1
end.
)
gdip_gdiarcisi=: 3 : 0
ctr=. (0 1{y) + -: (2 3{y)
'bgn end'=. - ctr calcAngle (6 7,:4 5){y
dif=. end - bgn
<.(4{.y), dfr 2p1| bgn,dif
)
gdip_glarc=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
t=. gtkbrushnull
gtkbrushnull=: 0
gdip_glarcx gdip_gdiarcisi y
gtkbrushnull=: t
0
)
gdip_glarcx=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
if. (-.gtkbrushnull) *. BRUSH do.
  GdipDrawArc GC;BRUSH;<"0 <.y
end.
GdipDrawArc GC;PEN;<"0 <.y
0
)
gdip_glbrush=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. BRUSH do. GdipDeleteBrush BRUSH end.
gtkbrushrgb=: gtkrgb
r=. GdipCreateSolidFill gtkbrushrgb;BRUSH=: ,_1
assert. 0=r
BRUSH=: {.BRUSH
gtkbrushnull=: 0
0
)
gdip_glbrushnull=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkbrushnull=: 1
0
)
gdip_glcapture=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
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
gdip_glcaret=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0 e. _2{.y do. 0 return. end.
assert. 0~:TOK,GC
GdipFillRectangle GC;(BGRA 0 0 0);<"0 <.y
0
)
gdip_glclear=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gdip_glclipreset''
gdip_glwindoworg 0 0
gdip_glrgb 255 255 255
gdip_glpen 1 0
gdip_glbrush''
gdip_glrect 0 0,gtkwh
gdip_glbrushnull''
gdip_glrgb 0 0 0
gdip_glpen 1 0
gdip_gltextcolor''
gdip_glfont PROFONT_jgl2_
gdip_glfontangle 0
gdip_gltextxy 0 0
0
)
gdip_glclip=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
gtkclipped=: 1
GdipSetClipRect GC;<"0 (<.y),0
0
)
gdip_glclipreset=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
if. gtkclipped do.
  GdipResetClip <GC
  gtkclipped=: 0
end.
0
)
gdip_glcmds=: 3 : 0
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
p=. 0
while. p<#y do.
  cnt=. p{y
  cmd=. (1+p){y
  dat=. (2+p+i.cnt-2){y
  select. cmd
  case. 2001 do. gdip_glarc dat
  case. 2003 do. ''
  case. 2004 do. gdip_glbrush dat
  case. 2005 do. gdip_glbrushnull dat
  case. 2062 do. ''
  case. 2065 do. gdip_glcaret dat
  case. 2007 do. gdip_glclear dat
  case. 2078 do. gdip_glclip dat
  case. 2079 do. gdip_glclipreset dat
  case. 2999 do. ''
  case. 2069 do. ''
  case. 2008 do. gdip_glellipse dat
  case. 2085 do. gdip_glemfclose dat
  case. 2084 do. gdip_glemfopen dat
  case. 2086 do. gdip_glemfplay dat
  case. 2066 do. gdip_glfile dat{a.
  case. 2012 do. gdip_glfont dat{a.
  case. 2312 do. gdip_glfont2 dat
  case. 2342 do. gdip_glfontangle dat
  case. 2015 do. gdip_gllines dat
  case. 2070 do. ''
  case. 2071 do. ''
  case. 2020 do. ''
  case. 2022 do. gdip_glpen dat
  case. 2023 do. gdip_glpie dat
  case. 2024 do. gdip_glpixel dat
  case. 2076 do. gdip_glpixels dat
  case. 2075 do. gdip_glpixelsx dat
  case. 2029 do. gdip_glpolygon dat
  case. 2089 do. ''
  case. 2091 do. ''
  case. 2057 do. ''
  case. 2083 do. ''
  case. 2060 do. ''
  case. 2077 do. ''
  case. 2092 do. ''
  case. 2088 do. ''
  case. 2058 do. ''
  case. 2059 do. ''
  case. 2031 do. gdip_glrect dat
  case. 2032 do. gdip_glrgb dat
  case. 2033 do. gdip_glroundr dat
  case. 2035 do. ''
  case. 2038 do. gdip_gltext dat{a.
  case. 2040 do. gdip_gltextcolor dat
  case. 2056 do. gdip_gltextxy dat
  case. 2045 do. gdip_glwindoworg dat
  case. do.
    ('un-implemented glcmds ', ":cmd) 13!:8[3
  end.
  p=. p+cnt
end.
0
)
gdip_glcursor=: 3 : 0 "1
gtkwin=. getGtkWidgetWindow canvas
if. y -.@e. IDC_ARROW,IDC_IBEAM,IDC_WAIT,IDC_CROSS,IDC_UPARROW,IDC_SIZENWSE,IDC_SIZENESW,IDC_SIZEWE,IDC_SIZENS,IDC_SIZEALL,IDC_NO,IDC_APPSTARTING,IDC_HELP do. 0 return. end.
n=. y i.~ IDC_ARROW,IDC_IBEAM,IDC_WAIT,IDC_CROSS,IDC_UPARROW,IDC_SIZENWSE,IDC_SIZENESW,IDC_SIZEWE,IDC_SIZENS,IDC_SIZEALL,IDC_NO,IDC_APPSTARTING,IDC_HELP
gdk_window_set_cursor gtkwin, gdk_cursor_new n{GDK_ARROW,GDK_XTERM,GDK_WATCH,GDK_CROSS,GDK_CENTER_PTR,GDK_BOTTOM_RIGHT_CORNER,GDK_BOTTOM_LEFT_CORNER,GDK_SB_H_DOUBLE_ARROW,GDK_SB_V_DOUBLE_ARROW,GDK_FLEUR,GDK_BLANK_CURSOR,GDK_ICON,GDK_QUESTION_ARROW
0
)
gdip_glellipse=: 3 : 0"1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
gdip_glarcx (<.y),"1 [ 0,360*64
0
)
gdip_glfont=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
if. 0=#y=. ,y do. 0 return. end.
'face size style degree'=. parseFontSpec y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
gtkfontangle=: <.degree*10
gtkunderline=: Underline
r=. GdipCreateFontFamilyFromName (uucp face);0;ffam=. ,_1
if. 0~:r do.
  smoutput 'font not found ',face
  _1 return.
end.
ffam=. {.ffam
r=. GdipCreateFont ffam;(|size);style;FontUnit;Font=. ,_1
if. 15=r do.
  r=. GdipCreateFont ffam;(|size);0;FontUnit;Font=. ,_1
end.
if. 15=r do.
  r=. GdipCreateFont ffam;(|size);1;FontUnit;Font=. ,_1
end.
if. 0~:r do. _1 return. end.
if. ffam do. GdipDeleteFontFamily ffam end.
if. FONT do. GdipDeleteFont FONT end.
FONT=: {.Font
0
)
gdip_glfont2=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
'size10 style degree10'=. 3{.y
face=. a.{~3}.y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
gtkfontangle=: degree10
gtkunderline=: Underline
r=. GdipCreateFontFamilyFromName (uucp face);0;ffam=. ,_1
if. 0~:r do.
  smoutput 'font not found ',face
  _1 return.
end.
ffam=. {.ffam
r=. GdipCreateFont ffam;(|size10%10);style;FontUnit;Font=. ,_1
if. 15=r do.
  r=. GdipCreateFont ffam;(|size10%10);0;FontUnit;Font=. ,_1
end.
if. 15=r do.
  r=. GdipCreateFont ffam;(|size10%10);1;FontUnit;Font=. ,_1
end.
if. 0~:r do. _1 return. end.
if. ffam do. GdipDeleteFontFamily ffam end.
if. FONT do. GdipDeleteFont FONT end.
FONT=: {.Font
0
)
gdip_glfontangle=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkfontangle=: y
0
)
gdip_glrgb=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkrgb=: BGRA y
0
)
gdip_gllines=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. *./ 0=y do. 0 return. end.
assert. 0~:TOK,GC
if. PEN do.
  GdipDrawLines GC;PEN;(<.y);(<.-:#y)
end.
0
)
gdip_glpaint=: 3 : 0 "1
newsize=: 1
gtk_widget_queue_draw canvas
0
)
gdip_glpaintx=: 3 : 0 "1
assert. 0~:TOK,GC
newsize=: 1
if. iOPENGL~:gloption do.
  argb=. gdip_glqpixels 0 0,gtkwh
  gtkwin pixbufwin_setpixels 0 0,gtkwh,argb
end.
0
)

gdip_glpen=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkpenwidth=. 0>.{.y
gtkpenstyle=. {:y
if. 0=TOK do. 0 return. end.
if. PEN do. GdipDeletePen PEN end.
gtkpenrgb=: gtkrgb
if. 1+.gtkpenwidth>0 do.
  r=. GdipCreatePen1 gtkpenrgb;1;PenUnit;PEN=: ,_1
  assert. 0=r
  PEN=: {.PEN
  GdipSetPenWidth PEN;gtkpenwidth
  GdipSetPenDashStyle PEN;<.gtkpenstyle
end.
0
)
gdip_glpie=: 3 : 0 "1
xywha1a2=. gdip_gdiarcisi y
if. (-.gtkbrushnull) *. BRUSH do.
  GdipFillPie GC;BRUSH;<"0 xywha1a2
end.
if. PEN do.
  GdipDrawPie GC;PEN;<"0 xywha1a2
end.
0
)
gdip_glpixel=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
GdipBitmapSetPixel BMP,(<.2{.y),gtkrgb
0
)
gdip_glpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
'a b w h1'=. 4{.y
h=. |h1
d=. 4}.y
if. h1<0 do. d=. ,|.(h,w)$ d end.
d=. ALPHA OR flip_rgb^:(-.RGBSEQ) d
GdipCreateBitmapFromScan0c w;h;(w*4);PixelFormat32bppARGB;(2&ic d);bmp=.,_1
r=. GdipDrawImageI GC, bmp, a, b
assert. 0=r
GdipDisposeImage {.bmp
0
)
gdip_glpixelsx=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
'a b w h1 da'=. y
h=. |h1
d=. memr da,0,(w*h),JINT
if. h1<0 do. d=. ,|.(h,w)$ d end.
d=. ALPHA OR flip_rgb^:(-.RGBSEQ) d
GdipCreateBitmapFromScan0c w;h;(w*4);PixelFormat32bppARGB;(2&ic d);bmp=.,_1
r=. GdipDrawImageI GC, bmp, a, b
assert. 0=r
GdipDisposeImage {.bmp

0
)
gdip_glpolygon=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. *./ 0=y do. 0 return. end.
c=. 2>.(+ 2&|)#y
if. (-.gtkbrushnull) *. BRUSH do.
  GdipFillPolygon GC;BRUSH;(<.c{.y);(<.-:c);FillModeAlternate
end.
if. PEN do.
  GdipDrawPolygon GC;PEN;(<.c{.y);<.-:c
end.
0
)
gdip_glqpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0$0 return. end.
assert. 0~:TOK,GC
'a b w h'=. y
rect=. a,b,w,h
DATA=. i.6
'r DATA'=. 0 _1{ GdipBitmapLockBits ({.BMP);rect;ImageLockModeRead;PixelFormat32bppARGB;DATA
assert. 0=r
if. IF64 do.
  'wh sf p r'=. 4{.DATA
  'w h'=. _2&ic 3&ic wh
  's f'=. _2&ic 3&ic sf
  z=. |.^:(s<0) w&{."1^:(w~:|s%4) _2&ic("1) (h,|s)$memr p,((s<0)*s*<:h),(h*<.|s),JCHAR
else.
  'w h s f p r'=. DATA
  z=. |.^:(s<0) w&{."1^:(w~:|s%4) (h,|s%4)$memr p,((s<0)*s*<:h),(h*<.|s%4),JINT
end.
GdipBitmapUnLockBits ({.BMP);DATA
z=. flip_rgb^:(-.RGBSEQ) ,z AND NOTALPHA
)
gdip_glqtextmetrics=: 3 : 0 "1
assert. 0~:FONT
if. FONT do.
  r=. GdipGetFamily FONT;fam=. ,_1
  assert. 0=r
  fam=. {.fam
  r=. GdipGetFontStyle FONT;style=. ,_1
  assert. 0=r
  style=. {.style
  GdipGetEmHeight fam;style;h=. ,_1
  GdipGetCellAscent fam;style;a=. ,_1
  GdipGetCellDescent fam;style;d=. ,_1
  GdipGetLineSpacing fam;style;s=. ,_1
  'aw ah'=. gdip_glqextent 'n'
  mw=. {.gdip_glqextent 'W'
  <.0.5+(ah*({.s)%~h,a,d,(h-a),(s-h)),aw,mw
else.
  ''
end.
)
gdip_glqwh=: 3 : 0
gtkwh
)
gdip_glrect=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0 e. _2{.y do. 0 return. end.
assert. 0~:TOK,GC
if. (-.gtkbrushnull) *. BRUSH do.
  GdipFillRectangle GC;BRUSH;<"0 <.y
end.
if. PEN do.
  GdipDrawRectangle GC;PEN;<"0 <.y
end.
0
)
gdip_glsetbrush=: gdip_glbrush @ gdip_glrgb
gdip_glsetpen=: gdip_glpen @ ((1 0 [ gdip_glrgb) :((2 {. [) gdip_glrgb))
gdip_gltext=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
if. FONT do.
  text=. uucp ,y
  if. 0=gtkfontangle do.
    GdipDrawString GC;text;(#text);FONT;(gtktextxy,2$1.1-1.1);0;TXTCLR
  else.
    GdipSaveGraphics GC;state=. ,_1
    GdipTranslateWorldTransform GC;(2{.<"0 gtktextxy,2$1.1-1.1),<MatrixOrderPrepend
    GdipRotateWorldTransform GC;(-gtkfontangle%10);MatrixOrderPrepend
    GdipDrawString GC;text;(#text);FONT;(4$1.1-1.1);0;TXTCLR
    GdipRestoreGraphics GC,state
  end.
end.
0
)
gdip_gltextcolor=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. TXTCLR do. GdipDeleteBrush TXTCLR end.
gtktextrgb=: gtkrgb
TXTCLR=: {.TXTCLR [ GdipCreateSolidFill gtktextrgb;TXTCLR=: ,_1
0
)
gdip_gltextxy=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtktextxy=: <.y
0
)
gdip_glqextent=: 3 : 0 "1
z=. 1 1
if. iOPENGL=gloption do. z return. end.
assert. 0~:TOK,GC
assert. 0~:FONT
if. FONT do.
  text=. uucp ,y
  rect=. 4$1.1-1.1
  z=. 4$1.1-1.1
  GdipMeasureString GC;text;(#text);FONT;rect;0;z;(<0);<(<0)
  z=. <.0.5+2 3 {z
end.
z
)
gdip_glqextentw=: 3 : 0 "1
{."1>gdip_glqextent each<;._2 y,LF#~LF~:{:y
)
gdip_glwindoworg=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:TOK,GC
GdipResetWorldTransform GC
GdipTranslateWorldTransform GC;(<"0 <.y),<MatrixOrderPrepend
0
)
gdip_glemfclose=: [:
gdip_glemfopen=: [:
gdip_glemfplay=: [:
gdip_glfile=: [:
gdip_glnodblbuf=: [:
gdip_glprint=: [:
gdip_glprintmore=: [:
gdip_glqhandles=: [:
gdip_glqprintpaper=: [:
gdip_glqprintwh=: [:
gdip_glroundr=: [:
pixmap_glarc=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
t=. gtkbrushnull
gtkbrushnull=: 1
pixmap_glarcx pixmap_gtkarcisi y
gtkbrushnull=: t
0
)
pixmap_glarcx=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
if. -.gtkbrushnull do.
  pixmap_gtkcolor gtkbrushrgb
  gdk_draw_arc gtkpx,gtkgc,1,<.y
end.
pixmap_gtkcolor gtkpenrgb
gdk_draw_arc gtkpx,gtkgc,0,<.y
0
)
pixmap_glbrush=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkbrushrgb=: gtkrgb
gtkbrushnull=: 0
0
)
pixmap_glbrushnull=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkbrushnull=: 1
0
)
pixmap_glcapture=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
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
pixmap_glcaret=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0 e. _2{.y do. 0 return. end.
assert. 0~:gtkpx,gtkpc
pixmap_gtkcolor RGB 0 0 0
gdk_draw_rectangle gtkpx,gtkgc,1,<.y
pixmap_gtkcolor gtkpenrgb
0
)
pixmap_glclear=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
pixmap_glclipreset''
pixmap_glwindoworg 0 0
pixmap_glrgb 255 255 255
pixmap_glpen 1 0
pixmap_glbrush''
pixmap_glrect 0 0,gtkwh
pixmap_glbrushnull''
pixmap_glrgb 0 0 0
pixmap_glpen 1 0
pixmap_gltextcolor''
pixmap_glfont PROFONT_jgl2_
pixmap_glfontangle 0
pixmap_gltextxy 0 0
0
)
pixmap_glclip=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
gtkclipped=: 1
gdk_gc_set_clip_rectangle gtkgc;2(3!:4)<.y
0
)
pixmap_glclipreset=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
if. gtkclipped do.
  gdk_gc_set_clip_rectangle gtkgc;2(3!:4)0 0,gtkwh
  gtkclipped=: 0
end.
0
)
pixmap_glcmds=: 3 : 0
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
p=. 0
while. p<#y do.
  cnt=. p{y
  cmd=. (1+p){y
  dat=. (2+p+i.cnt-2){y
  select. cmd
  case. 2001 do. pixmap_glarc dat
  case. 2003 do. ''
  case. 2004 do. pixmap_glbrush dat
  case. 2005 do. pixmap_glbrushnull dat
  case. 2062 do. ''
  case. 2065 do. pixmap_glcaret dat
  case. 2007 do. pixmap_glclear dat
  case. 2078 do. pixmap_glclip dat
  case. 2079 do. pixmap_glclipreset dat
  case. 2999 do. ''
  case. 2069 do. ''
  case. 2008 do. pixmap_glellipse dat
  case. 2085 do. pixmap_glemfclose dat
  case. 2084 do. pixmap_glemfopen dat
  case. 2086 do. pixmap_glemfplay dat
  case. 2066 do. pixmap_glfile dat{a.
  case. 2012 do. pixmap_glfont dat{a.
  case. 2312 do. pixmap_glfont2 dat
  case. 2342 do. pixmap_glfontangle dat
  case. 2015 do. pixmap_gllines dat
  case. 2070 do. ''
  case. 2071 do. ''
  case. 2020 do. ''
  case. 2022 do. pixmap_glpen dat
  case. 2023 do. pixmap_glpie dat
  case. 2024 do. pixmap_glpixel dat
  case. 2076 do. pixmap_glpixels dat
  case. 2075 do. pixmap_glpixelsx dat
  case. 2029 do. pixmap_glpolygon dat
  case. 2089 do. ''
  case. 2091 do. ''
  case. 2057 do. ''
  case. 2083 do. ''
  case. 2060 do. ''
  case. 2077 do. ''
  case. 2092 do. ''
  case. 2088 do. ''
  case. 2058 do. ''
  case. 2059 do. ''
  case. 2031 do. pixmap_glrect dat
  case. 2032 do. pixmap_glrgb dat
  case. 2033 do. pixmap_glroundr dat
  case. 2035 do. ''
  case. 2038 do. pixmap_gltext dat{a.
  case. 2040 do. pixmap_gltextcolor dat
  case. 2056 do. pixmap_gltextxy dat
  case. 2045 do. pixmap_glwindoworg dat
  case. do.
    ('un-implemented glcmds ', ":cmd) 13!:8[3
  end.
  p=. p+cnt
end.
0
)
pixmap_glcursor=: 3 : 0 "1
gtkwin=. getGtkWidgetWindow canvas
if. y -.@e. IDC_ARROW,IDC_IBEAM,IDC_WAIT,IDC_CROSS,IDC_UPARROW,IDC_SIZENWSE,IDC_SIZENESW,IDC_SIZEWE,IDC_SIZENS,IDC_SIZEALL,IDC_NO,IDC_APPSTARTING,IDC_HELP do. 0 return. end.
n=. y i.~ IDC_ARROW,IDC_IBEAM,IDC_WAIT,IDC_CROSS,IDC_UPARROW,IDC_SIZENWSE,IDC_SIZENESW,IDC_SIZEWE,IDC_SIZENS,IDC_SIZEALL,IDC_NO,IDC_APPSTARTING,IDC_HELP
gdk_window_set_cursor gtkwin, gdk_cursor_new n{GDK_ARROW,GDK_XTERM,GDK_WATCH,GDK_CROSS,GDK_CENTER_PTR,GDK_BOTTOM_RIGHT_CORNER,GDK_BOTTOM_LEFT_CORNER,GDK_SB_H_DOUBLE_ARROW,GDK_SB_V_DOUBLE_ARROW,GDK_FLEUR,GDK_BLANK_CURSOR,GDK_ICON,GDK_QUESTION_ARROW
0
)
pixmap_glellipse=: 3 : 0"1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
pixmap_glarcx y,"1 [ 0,360*64
0
)
pixmap_glfont=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
if. 0=#y=. ,y do. return. end.
'face size style degree'=. parseFontSpec y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
gtkfontangle=: <.degree*10
gtkunderline=: Underline
fnt=. pango_font_description_from_string <y
if. Bold do. pango_font_description_set_weight fnt, PANGO_WEIGHT_BOLD end.
if. Italic do. pango_font_description_set_style fnt, PANGO_STYLE_ITALIC end.
pango_font_description_set_size fnt, <.PANGO_SCALE*size
pango_layout_set_font_description gtkpl,fnt
pango_font_description_free fnt
0
)
pixmap_glfont2=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
'size10 style degree10'=. 3{.y
face=. a.{~3}.y
'Bold Italic Underline Strikeout'=. 4{. |. #: style
gtkfontangle=: <.degree10
gtkunderline=: Underline
fnt=. pango_font_description_from_string <face
if. Bold do. pango_font_description_set_weight fnt, PANGO_WEIGHT_BOLD end.
if. Italic do. pango_font_description_set_style fnt, PANGO_STYLE_ITALIC end.
pango_font_description_set_size fnt, <.PANGO_SCALE*size10%10
pango_layout_set_font_description gtkpl,fnt
pango_font_description_free fnt
0
)
pixmap_glfontangle=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkfontangle=: <.y
0
)
pixmap_glrgb=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkrgb=: RGB y
0
)
pixmap_gllines=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. *./ 0=y do. 0 return. end.
assert. 0~:gtkpx,gtkpc
pixmap_gtkcolor gtkpenrgb
c=. <.-:#y=. <.y
if. IF64 do. y=. _3 ic 2 ic y end.
gdk_draw_lines gtkpx;gtkgc;y;c
0
)
pixmap_glpaint=: 3 : 0 "1
newsize=: 1
gtk_widget_queue_draw canvas
0
)
pixmap_glpaintx=: 3 : 0 "1
assert. 0~:gtkpx,gtkpc
newsize=: 1
if. iOPENGL~:gloption do.
  gdk_draw_drawable gtkwin,gtkdagc,gtkpx,0 0 0 0 _1 _1
end.
0
)

pixmap_glpen=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtkpenrgb=: gtkrgb
gtkpenwidth=: 0>.{.y
gtkpenstyle=: {:y
if. 0=gtkgc do. 0 return. end.
gdk_gc_set_line_attributes gtkgc;gtkpenwidth;0;1;0
0
)
pixmap_glpie=: 3 : 0 "1
pixmap_glarcx pixmap_gtkarcisi y
0
)
pixmap_glpixel=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
pixmap_gtkcolor gtkrgb
gdk_draw_point gtkpx,gtkgc,2{.<.y
0
)
pixmap_glpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
'a b w h1'=. 4{.y
h=. |h1
d=. 4}.y
if. h1<0 do. d=. ,|.(h,w)$ d end.

d=. ALPHA OR flip_rgb^:RGBSEQ d
if. IF64 do. d=. 2 ic d end.
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
if. buf do.
  gdk_draw_pixbuf gtkpx,0,buf,0,0,a,b,w,h,0,0,0
end.
g_object_unref buf
0
)
pixmap_glpixelsx=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
'a b w h1 da'=. y
h=. |h1
d=. memr da,0,(w*h),JINT
if. h1<0 do. d=. ,|.(h,w)$ d end.

d=. ALPHA OR flip_rgb^:RGBSEQ d
if. IF64 do. d=. 2 ic d end.
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
if. buf do.
  gdk_draw_pixbuf gtkpx,0,buf,0,0,a,b,w,h,0,0,0
end.
g_object_unref buf
0
)
pixmap_glpolygon=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. *./ 0=y do. 0 return. end.
c=. <.-:#y=. <.y
if. IF64 do. y=. _3 ic 2 ic y end.
if. -.gtkbrushnull do.
  pixmap_gtkcolor gtkbrushrgb
  gdk_draw_polygon gtkpx;gtkgc;1;y;c
end.
pixmap_gtkcolor gtkpenrgb
gdk_draw_polygon gtkpx;gtkgc;0;y;c

0
)
pixmap_glqpixels=: 3 : 0 "1
if. iOPENGL=gloption do. 0$0 return. end.
assert. 0~:gtkpx,gtkpc
'a b w h'=. y
pixbuf=. gdk_pixbuf_new GDK_COLORSPACE_RGB,1,8,w,h
gdk_pixbuf_get_from_drawable pixbuf,gtkpx,GDK_COLORSPACE_RGB,a,b,0,0,w,h
ad=. gdk_pixbuf_get_pixels pixbuf
if. IF64 do.
  r=. _2 ic memr ad,0,(w*h*4),JCHAR
else.
  r=. memr ad,0,(w*h),JINT
end.
g_object_unref pixbuf
NOTALPHA AND flip_rgb^:RGBSEQ r
)
pixmap_glqwh=: 3 : 0
gtkwh
)
pixmap_glrect=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
if. 0 e. _2{.y do. 0 return. end.
assert. 0~:gtkpx,gtkpc
if. -.gtkbrushnull do.
  pixmap_gtkcolor gtkbrushrgb
  gdk_draw_rectangle gtkpx,gtkgc,1,y
end.
pixmap_gtkcolor gtkpenrgb
gdk_draw_rectangle gtkpx,gtkgc,0,y-0 0 1 1
0
)
pixmap_glsetbrush=: pixmap_glbrush @ pixmap_glrgb
pixmap_glsetpen=: pixmap_glpen @ ((1 0 [ pixmap_glrgb) :((2 {. [) pixmap_glrgb))
pixmap_gltext=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
assert. 0~:gtkpl
pixmap_gtkcolor gtktextrgb
if. gtkunderline do.
  atl=. pango_attr_list_new ''
  ul=. pango_attr_underline_new 1
  pango_attr_list_insert atl,ul
  pango_layout_set_attributes gtkpl,atl
  pango_attr_list_unref atl
end.
if. 0=gtkfontangle do.
  pango_layout_set_text gtkpl;(,y);#y
  gdk_draw_layout gtkpx,gtkgc,gtktextxy,gtkpl
else.
  pangotextangle gtkfontangle%10
  pango_layout_set_text gtkpl;(,y);#y
  gdk_draw_layout gtkpx,gtkgc,gtktextxy,gtkpl
  pangotextangle 0
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
pixmap_gltextcolor=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtktextrgb=: gtkrgb
0
)
pixmap_gltextxy=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
gtktextxy=: <.y
0
)
pixmap_glqextent=: 3 : 0 "1
z=. 1 1
if. iOPENGL=gloption do. z return. end.
assert. 0~:gtkpx,gtkpc
assert. 0~:gtkpl
pango_layout_set_text gtkpl;(,y);#y
z=. _2 {. ;pango_layout_get_pixel_size gtkpl;(,2);,3
z
)
pixmap_glqextentw=: 3 : 0 "1
{."1>pixmap_glqextent each<;._2 y,LF#~LF~:{:y
)
pixmap_glwindoworg=: 3 : 0 "1
if. iOPENGL=gloption do. 0 return. end.
assert. 0~:gtkpx,gtkpc
''
0
)
pixmap_glemfclose=: [:
pixmap_glemfopen=: [:
pixmap_glemfplay=: [:
pixmap_glfile=: [:
pixmap_glnodblbuf=: [:
pixmap_glprint=: [:
pixmap_glprintmore=: [:
pixmap_glqhandles=: [:
pixmap_glqprintpaper=: [:
pixmap_glqprintwh=: [:
pixmap_glqtextmetrics=: [:
pixmap_glroundr=: [:
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

flip_rgb=: 3 : 0
d=. ((#y),4)$2 (3!:4) y
d=. 2 1 0 3{"1 d
_2(3!:4),d
)
get_button=: 3 : 0
if. IF64 do.
  a.i.memr y,52 1
else.
  memr y,40 1,JINT
end.
)
get_button=: 3 : 0
256#.endian a.i.memr y,GdkEventButton_button,4
)
get_type=: 3 : 0
memr y,0 1,JINT
)
RGB=: <.@(256&#.)@endian
BGR=: <.@(256&#.)@Endian
IRGB=: _4&{.@endian@(256 256 256 256&#:)
BGRA=: 3 : 'ALPHA OR 256 256 256#.@Endian y'
cairo_cairocolor=: 3 : 0
cairo_set_source_rgba gtkcr ; <"0 rgba2cairo IRGB y
)
pixmap_gtkcolor=: 3 : 0
gdk_gc_set_rgb_fg_color gtkgc;rgb2gtk IRGB y
)
pangotextangle=: 3 : 0
mat=. 1 0 0 1 0 0 + 1.1 - 1.1
pango_matrix_rotate mat;y
pango_context_set_matrix gtkplc;mat
pango_layout_context_changed gtkpl
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
glarc=: cairo_glarc`cairo_glarc`pixmap_glarc`gdip_glarc`gdi32_glarc@.GL2Backend_jgl2_
glarcx=: cairo_glarcx`cairo_glarcx`pixmap_glarcx`gdip_glarcx`gdi32_glarcx@.GL2Backend_jgl2_
glbrush=: cairo_glbrush`cairo_glbrush`pixmap_glbrush`gdip_glbrush`gdi32_glbrush@.GL2Backend_jgl2_
glbrushnull=: cairo_glbrushnull`cairo_glbrushnull`pixmap_glbrushnull`gdip_glbrushnull`gdi32_glbrushnull@.GL2Backend_jgl2_
glcapture=: cairo_glcapture`cairo_glcapture`pixmap_glcapture`gdip_glcapture`gdi32_glcapture@.GL2Backend_jgl2_
glcaret=: cairo_glcaret`cairo_glcaret`pixmap_glcaret`gdip_glcaret`gdi32_glcaret@.GL2Backend_jgl2_
glclear=: cairo_glclear`cairo_glclear`pixmap_glclear`gdip_glclear`gdi32_glclear@.GL2Backend_jgl2_
glclip=: cairo_glclip`cairo_glclip`pixmap_glclip`gdip_glclip`gdi32_glclip@.GL2Backend_jgl2_
glclipreset=: cairo_glclipreset`cairo_glclipreset`pixmap_glclipreset`gdip_glclipreset`gdi32_glclipreset@.GL2Backend_jgl2_
glcmds=: cairo_glcmds`cairo_glcmds`pixmap_glcmds`gdip_glcmds`gdi32_glcmds@.GL2Backend_jgl2_
glcmds=: cairo_glcmds`cairo_glcmds`pixmap_glcmds`gdip_glcmds`gdi32_glcmds@.GL2Backend_jgl2_
glcursor=: cairo_glcursor`cairo_glcursor`pixmap_glcursor`gdip_glcursor`gdi32_glcursor@.GL2Backend_jgl2_
glellipse=: cairo_glellipse`cairo_glellipse`pixmap_glellipse`gdip_glellipse`gdi32_glellipse@.GL2Backend_jgl2_
glfont=: cairo_glfont`cairo_glfont`pixmap_glfont`gdip_glfont`gdi32_glfont@.GL2Backend_jgl2_
glfontangle=: cairo_glfontangle`cairo_glfontangle`pixmap_glfontangle`gdip_glfontangle`gdi32_glfontangle@.GL2Backend_jgl2_
gllines=: cairo_gllines`cairo_gllines`pixmap_gllines`gdip_gllines`gdi32_gllines@.GL2Backend_jgl2_
glpaint=: cairo_glpaint`cairo_glpaint`pixmap_glpaint`gdip_glpaint`gdi32_glpaint@.GL2Backend_jgl2_
glpaintx=: cairo_glpaintx`cairo_glpaintx`pixmap_glpaintx`gdip_glpaintx`gdi32_glpaintx@.GL2Backend_jgl2_
glpen=: cairo_glpen`cairo_glpen`pixmap_glpen`gdip_glpen`gdi32_glpen@.GL2Backend_jgl2_
glpie=: cairo_glpie`cairo_glpie`pixmap_glpie`gdip_glpie`gdi32_glpie@.GL2Backend_jgl2_
glpixel=: cairo_glpixel`cairo_glpixel`pixmap_glpixel`gdip_glpixel`gdi32_glpixel@.GL2Backend_jgl2_
glpixels=: cairo_glpixels`cairo_glpixels`pixmap_glpixels`gdip_glpixels`gdi32_glpixels@.GL2Backend_jgl2_
glpixelsx=: cairo_glpixelsx`cairo_glpixelsx`pixmap_glpixelsx`gdip_glpixelsx`gdi32_glpixelsx@.GL2Backend_jgl2_
glpolygon=: cairo_glpolygon`cairo_glpolygon`pixmap_glpolygon`gdip_glpolygon`gdi32_glpolygon@.GL2Backend_jgl2_
glqextent=: cairo_glqextent`cairo_glqextent`pixmap_glqextent`gdip_glqextent`gdi32_glqextent@.GL2Backend_jgl2_
glqextentw=: cairo_glqextentw`cairo_glqextentw`pixmap_glqextentw`gdip_glqextentw`gdi32_glqextentw@.GL2Backend_jgl2_
glqpixels=: cairo_glqpixels`cairo_glqpixels`pixmap_glqpixels`gdip_glqpixels`gdi32_glqpixels@.GL2Backend_jgl2_
glqwh=: cairo_glqwh`cairo_glqwh`pixmap_glqwh`gdip_glqwh`gdi32_glqwh@.GL2Backend_jgl2_
glrect=: cairo_glrect`cairo_glrect`pixmap_glrect`gdip_glrect`gdi32_glrect@.GL2Backend_jgl2_
glrgb=: cairo_glrgb`cairo_glrgb`pixmap_glrgb`gdip_glrgb`gdi32_glrgb@.GL2Backend_jgl2_
glsetbrush=: cairo_glsetbrush`cairo_glsetbrush`pixmap_glsetbrush`gdip_glsetbrush`gdi32_glsetbrush@.GL2Backend_jgl2_
glsetpen=: cairo_glsetpen`cairo_glsetpen`pixmap_glsetpen`gdip_glsetpen`gdi32_glsetpen@.GL2Backend_jgl2_
gltext=: cairo_gltext`cairo_gltext`pixmap_gltext`gdip_gltext`gdi32_gltext@.GL2Backend_jgl2_
gltextcolor=: cairo_gltextcolor`cairo_gltextcolor`pixmap_gltextcolor`gdip_gltextcolor`gdi32_gltextcolor@.GL2Backend_jgl2_
gltextxy=: cairo_gltextxy`cairo_gltextxy`pixmap_gltextxy`gdip_gltextxy`gdi32_gltextxy@.GL2Backend_jgl2_
glwindoworg=: cairo_glwindoworg`cairo_glwindoworg`pixmap_glwindoworg`gdip_glwindoworg`gdi32_glwindoworg@.GL2Backend_jgl2_
glprint=: cairo_glprint`cairo_glprint`pixmap_glprint`gdip_glprint`gdi32_glprint@.GL2Backend_jgl2_
glprintmore=: cairo_glprintmore`cairo_glprintmore`pixmap_glprintmore`gdip_glprintmore`gdi32_glprintmore@.GL2Backend_jgl2_
glqhandles=: cairo_glqhandles`cairo_glqhandles`pixmap_glqhandles`gdip_glqhandles`gdi32_glqhandles@.GL2Backend_jgl2_
glqprintpaper=: cairo_glqprintpaper`cairo_glqprintpaper`pixmap_glqprintpaper`gdip_glqprintpaper`gdi32_glqprintpaper@.GL2Backend_jgl2_
glqprintwh=: cairo_glqprintwh`cairo_glqprintwh`pixmap_glqprintwh`gdip_glqprintwh`gdi32_glqprintwh@.GL2Backend_jgl2_
glemfclose=: cairo_glemfclose`cairo_glemfclose`pixmap_glemfclose`gdip_glemfclose`gdi32_glemfclose@.GL2Backend_jgl2_
glemfopen=: cairo_glemfopen`cairo_glemfopen`pixmap_glemfopen`gdip_glemfopen`gdi32_glemfopen@.GL2Backend_jgl2_
glemfplay=: cairo_glemfplay`cairo_glemfplay`pixmap_glemfplay`gdip_glemfplay`gdi32_glemfplay@.GL2Backend_jgl2_
glfile=: cairo_glfile`cairo_glfile`pixmap_glfile`gdip_glfile`gdi32_glfile@.GL2Backend_jgl2_
glnodblbuf=: cairo_glnodblbuf`cairo_glnodblbuf`pixmap_glnodblbuf`gdip_glnodblbuf`gdi32_glnodblbuf@.GL2Backend_jgl2_
glqtextmetrics=: cairo_glqtextmetrics`cairo_glqtextmetrics`pixmap_glqtextmetrics`gdip_glqtextmetrics`gdi32_glqtextmetrics@.GL2Backend_jgl2_
glroundr=: cairo_glroundr`cairo_glroundr`pixmap_glroundr`gdip_glroundr`gdi32_glroundr@.GL2Backend_jgl2_
