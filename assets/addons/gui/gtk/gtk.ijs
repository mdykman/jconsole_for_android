coclass 'jgtk'

3 : 0''
if. IFJ6 do.
  'require'~'dll strings unicode'
end.
''
)

NoEvents=: 0

ic=: 3!:4
fc=: 3!:5
char4toint=: _2 & ic
inttochar4=: 2 & ic
debb=: #~ [: (+. (1 |. (> </\))) (0 e. ' '&=)&>
extsrc=: , ('.ijs' #~ '.'&e. < 0 < #)
getenv=: 2!:5
index=: #@[ (| - =) i.
intersect=: e. # [
memri4=: _2 ic [: memr ,&0 4
readerror=: 3 : 'readstring memr y,8 1 4'
termLF=: , (0 < #) # LF -. {:
remsep=: }.~ [: - '/' = {:
setenable=: gtk_widget_set_sensitive
setwindowfocus=: gtk_window_present
setchildfocus=: gtk_widget_grab_focus
addpattern=: 3 : 0
'w p n'=. y
ff=. gtk_file_filter_new''
gtk_file_filter_add_pattern ff;p
gtk_file_filter_set_name ff;n
gtk_file_chooser_add_filter w,ff
)
coextend=: 3 : 0
n=. ;: :: ] y
p=. ; (, 18!:2) @ < each n
p=. ~. ((18!:2 coname'')-.p) , p
(p /: p = <,'z') 18!:2 coname''
)
direxist=: 3 : 0
d=. (- ({:y) e. '/\') }. y
if. #d=. 1!:0 d do.
  'd' = 4 { > 4 { ,d
else.
  0
end.
)
gconvert=: 3 : 0
'to from dat'=. y
m=. memaz 12
r=. g_convert (,dat);(#dat);to;from;m (<@+)each 8 4 0
err=. memri4 m
if. err do.
  r=. 1;readstring memr err,8 1 4
else.
  r=. 0;readstringfree 0 pick r
end.
r[memf m
)
getallwindows=: 3 : 'get_glist gtk_window_list_toplevels$0'
get_glist=: 3 : 0
p=. y
r=. ''
whilst. p do.
  'd p v'=. memr p,0 3,JPTR
  r=. r,d
end.
)
getlist=: 3 : 0
ad=. y
n=. (JTYPES i. JINT){JSIZES
r=. ''
while. 1 do.
  a=. memr ad,0,1,JINT
  if. 0=a do. r return. end.
  ad=. ad+n
  r=. r,<memr a,0,_1
end.
r
)
getmodifiers=: 3 : 0
p=. memaz 4
w=. getGtkWidgetWindow window
gdk_window_get_pointer w;<each 0 0,p
r=. 0 2 { 2 2 2 #: a.i.{.memr p,0 1
memf p
r
)
getscreenwh=: 3 : 0
s=. gdk_screen_get_default''
(gdk_screen_get_width s),gdk_screen_get_height s
)
getwinpos=: 3 : 0
win=. y
px=. memaz 4
py=. memaz 4
gtk_window_get_position win;(<px);<<py
x=. memri4 px
y=. memri4 py
gtk_window_get_size win;(<px);<<py
w=. memri4 px
h=. memri4 py
m=. * 4 AND gdk_window_get_state getGtkWidgetWindow win
memf px
memf py
x,y,w,h,m
)
gtkeventkey=: 3 : '_2 ic memr y,GdkEventKey,8'
gtkfixf10=: 3 : 0
a=. gtk_settings_get_default''
gtk_settings_set_string_property a;'gtk-menu-bar-accel';'';''
)
isdir=: 3 : 0
d=. 1!:0 y
if. 1 ~: #d do. 0 return. end.
'd' = 4 { 4 pick ,d
)
isesckey=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key~:GDK_Escape do. 0 return. end.
+:/ 0 2 { 2 2 2 #: state
)
log=: '/tmp/tracegtk.log' fappends~ ":
memaz=: 3 : 0
r=. mema y
(y${.a.) memw r,0,y
r
)
noevents=: 3 : 0
NoEvents_jgtk_=: {. 0 >. NoEvents + y{_1 1
)
readstring=: 3 : 0
if. y do. memr y,0 _1 else. '' end.
)
readstringfree=: 3 : 0
if. y do.
  d=. memr y,0 _1
  g_free y
  d
else.
  ''
end.
)
rgb2gtk=: 3 : 0
(0 0 0 0{a.), 1 (3!:4) (256 * y) + 255 * 127 < y
)
setfont=: 3 : 0
'w f'=. y
font=. pango_font_description_from_string <f
gtk_widget_modify_font w,font
pango_font_description_free font
)
setlist=: 3 : 0
len=. 1 + # &> y
t=. ; y ,each {.a.
p=. mema #t
t memw p,0,#t
n=. (JTYPES i. JINT){JSIZES
s=. mema n * 1 + #y
d=. 0 ,~ p + +/\0,}:len
d memw s,0,(#d),JINT
s
)
setwinpos=: 4 : 0
win=. y
if. (win=0) +. 0=#x do. return. end.
'x y w h m'=. 5 {. x
gtk_window_move win,x,y
gtk_window_set_default_size win,w,h
if. m do.
  gtk_window_maximize win
end.
)
showconsole=: 3 : 0
if. IFWIN do.
  hwnd=. 'kernel32 GetConsoleWindow >x'cd''
  'user32.dll ShowWindow > x x x'cd hwnd,y
end.
)
widgetshow=: 3 : 0
'w v'=. y
if. v do.
  gtk_widget_show &> w
else.
  gtk_widget_hide &> w
end.
)
window_destroy=: 3 : 0
if. window do. gtk_widget_destroy window end.
window=: 0
)
writestrings=: 3 : 0
len=. 1 + # &> y
t=. ; y ,each {.a.
p=. mema #t
t memw p,0,#t
p + +/\ 0,}:len
)
fliprgb_z_=: 3 : 0
s=. $y
d=. ((#y),4)$2 (3!:4) y=. ,y
d=. 2 1 0 3{"1 d
s$_2(3!:4),d
)
settimer=: 3 : 0
g_timeout_add_full 200;y;cb1;(cbreg 'sys_timer__');0
)
3 : 0''
decodecesc_z_=: ('\\';'\';'\n';LF;'\r';CR;'\t';TAB;'\0';({.a.)) & stringreplace
if. UNAME-:'Linux' do.
  bindtextdomain_z_=: 'libc.so.6 bindtextdomain > x *c *c'&cd
  bind_textdomain_codeset_z_=: 'libc.so.6 bind_textdomain_codeset > x *c *c'&cd
  textdomain_z_=: 'libc.so.6 textdomain > x *c'&cd
  gettext_z_=: 3 : 'decodecesc memr 0 _1 2,~ ''libc.so.6 gettext > x *c''&cd <y'
  dgettext_z_=: 3 : 'decodecesc memr 0 _1 2,~ ''libc.so.6 dgettext > x *c *c''&cd |.@y'
  ngettext_z_=: 3 : 'decodecesc memr 0 _1 2,~ ''libc.so.6 ngettext > x *c *c x''&cd y'
  dngettext_z_=: 3 : 'decodecesc memr 0 _1 2,~ ''libc.so.6 dngettext > x *c *c *c x''&cd _1 |.y'
  gettext_noop_z_=: decodecesc
elseif. UNAME-:'Win' do.
  if. 1 [ IF64 do.
    bindtextdomain_z_=: 'libintl-8.dll bindtextdomain > + x *c *c'&cd
    bind_textdomain_codeset_z_=: 'libintl-8.dll bind_textdomain_codeset > + x *c *c'&cd
    textdomain_z_=: 'libintl-8.dll textdomain > + x *c'&cd
    gettext_z_=: 3 : 'decodecesc memr 0 _1 2,~ ''libintl-8.dll gettext > + x *c''&cd <y'
    dgettext_z_=: 3 : 'decodecesc memr 0 _1 2,~ ''libintl-8.dll dgettext > + x *c *c''&cd |.@y'
    ngettext_z_=: 3 : 'decodecesc memr 0 _1 2,~ ''libintl-8.dll ngettext > + x *c *c x''&cd y'
    dngettext_z_=: 3 : 'decodecesc memr 0 _1 2,~ ''libintl-8.dll dngettext > + x *c *c *c x''&cd _1 |.y'
    gettext_noop_z_=: decodecesc
  else.
    bindtextdomain_z_=: 'intl.dll bindtextdomain > + x *c *c'&cd
    bind_textdomain_codeset_z_=: 'intl.dll bind_textdomain_codeset > + x *c *c'&cd
    textdomain_z_=: 'intl.dll textdomain > + x *c'&cd
    gettext_z_=: 3 : 'decodecesc helper_g_locale_to_utf8_jgtk_ < ''intl.dll gettext > + x *c''&cd <y'
    dgettext_z_=: 3 : 'decodecesc helper_g_locale_to_utf8_jgtk_ < ''intl.dll dgettext > + x *c *c''&cd |.@y'
    ngettext_z_=: 3 : 'decodecesc helper_g_locale_to_utf8_jgtk_ < ''intl.dll ngettext > + x *c *c x''&cd y'
    dngettext_z_=: 3 : 'decodecesc helper_g_locale_to_utf8_jgtk_ < ''intl.dll dngettext > + x *c *c *c x''&cd _1 |.y'
    gettext_noop_z_=: decodecesc
  end.
elseif. UNAME-:'Darwin' do.
  bindtextdomain_z_=: bind_textdomain_codeset_z_=: textdomain_z_=: 0:
  gettext_z_=: decodecesc
  dgettext_z_=: decodecesc@>@{.
  ngettext_z_=: 3 : 'decodecesc (1<2{::y){::2{.y'
  dngettext_z_=: 3 : 'decodecesc (1<2{::y){::2{.y [[ y=. _1 |.y'
  gettext_noop_z_=: decodecesc
end.
''
)

3 : 0''
if. 0~:nc<'GTKVER_j_' do. GTKVER_j_=: 2 end.
if. 3=GTKVER_j_ do.
  select. UNAME
  case. 'Darwin' do.
    libdir=. jpath '~install/gtk/lib/'
    libcairo=: <dquote libdir,'libcairo.2.dylib'
    libgdk=: <dquote libdir,'libgdk-3.0.dylib'
    libgio=: <dquote libdir,'libgio-2.0.0.dylib'
    libglib=: <dquote libdir,'libglib-2.0.0.dylib'
    libgobject=: <dquote libdir,'libgobject-2.0.0.dylib'
    libgthread=: <dquote libdir,'libgthread-2.0.0.dylib'
    libgtk=: <dquote libdir,'libgtk-3.0.dylib'
    libgtksourceview=: <dquote libdir,'libgtksourceview-3.0.0.dylib'
    libigemac=: <dquote libdir,'libigemacintegration.0.dylib'
    libpango=: <dquote libdir,'libpango-1.0.0.dylib'
    libpangocairo=: <dquote libdir,'libpangocairo-1.0.0.dylib'
    libpixbuf=: <dquote libdir,'libgdk_pixbuf-2.0.0.dylib'
    libxml=: <dquote libdir,'libxml2.2.dylib'
    if. -.fexist '"'-.~>libigemac do. libigemac=: '' end.
  case. 'Linux' do.
    libglib=: <'libglib-2.0.so.0'
    libcairo=: <'libcairo.so.2'
    libgdk=: <'libgdk-3.so.0'
    libgio=: <'libgio-2.0.so.0'
    libgobject=: <'libgobject-2.0.so.0'
    libgthread=: <'libgthread-2.0.so.0'
    libgtk=: <'libgtk-3.so.0'
    libgtksourceview=: <'libgtksourceview-3.0.so.0'
    libpango=: <'libpango-1.0.so.0'
    libpangocairo=: <'libpangocairo-1.0.so.0'
    libpixbuf=: <'libgdk_pixbuf-2.0.so.0'
    libxml=: <'libxml2.so.2'
  case. 'Win' do.
    'kernel32.dll SetDllDirectoryW x *w'cd <uucp jpath'~install/gtk/bin'
    libcairo=: <'libcairo-2.dll'
    libgdk=: <'libgdk-3-0.dll'
    libgio=: <'libgio-2.0-0.dll'
    libglib=: <'libglib-2.0-0.dll'
    libgobject=: <'libgobject-2.0-0.dll'
    libgthread=: <'libgthread-2.0-0.dll'
    libgtk=: <'libgtk-3-0.dll'
    libgtksourceview=: <'libgtksourceview-3.0-0.dll'
    libpango=: <'libpango-1.0-0.dll'
    libpangocairo=: <'libpangocairo-1.0-0.dll'
    libpixbuf=: <'libgdk_pixbuf-2.0-0.dll'
    libxml=: <'libxml2.dll'
  end.
else.
  select. UNAME
  case. 'Darwin' do.
    libdir=. jpath '~install/gtk/lib/'
    libcairo=: <dquote libdir,'libcairo.2.dylib'
    libgdk=: <dquote libdir,'libgdk-quartz-2.0.0.dylib'
    libgio=: <dquote libdir,'libgio-2.0.0.dylib'
    libglib=: <dquote libdir,'libglib-2.0.0.dylib'
    libgobject=: <dquote libdir,'libgobject-2.0.0.dylib'
    libgthread=: <dquote libdir,'libgthread-2.0.0.dylib'
    libgtk=: <dquote libdir,'libgtk-quartz-2.0.0.dylib'
    libgtksourceview=: <dquote libdir,'libgtksourceview-2.0.0.dylib'
    libigemac=: <dquote libdir,'libigemacintegration.0.dylib'
    libpango=: <dquote libdir,'libpango-1.0.0.dylib'
    libpangocairo=: <dquote libdir,'libpangocairo-1.0.0.dylib'
    libpixbuf=: <dquote libdir,'libgdk_pixbuf-2.0.0.dylib'
    libxml=: <dquote libdir,'libxml2.2.dylib'
    if. -.fexist '"'-.~>libigemac do. libigemac=: '' end.
    if. -.fexist '"'-.~>libgtk do.
      libgdk=: <dquote libdir,'libgdk-x11-2.0.0.dylib'
      libgtk=: <dquote libdir,'libgtk-x11-2.0.0.dylib'
    end.
  case. 'Linux' do.
    libcairo=: <'libcairo.so.2'
    libgdk=: <'libgdk-x11-2.0.so.0'
    libgio=: <'libgio-2.0.so.0'
    libglib=: <'libglib-2.0.so.0'
    libgobject=: <'libgobject-2.0.so.0'
    libgthread=: <'libgthread-2.0.so.0'
    libgtk=: <'libgtk-x11-2.0.so.0'
    libgtksourceview=: <'libgtksourceview-2.0.so.0'
    libpango=: <'libpango-1.0.so.0'
    libpangocairo=: <'libpangocairo-1.0.so.0'
    libpixbuf=: <'libgdk_pixbuf-2.0.so.0'
    libxml=: <'libxml2.so.2'
  case. 'Win' do.
    'kernel32.dll SetDllDirectoryW x *w'cd <uucp jpath'~install/gtk/bin'
    libcairo=: <'libcairo-2.dll'
    libgdk=: <'libgdk-win32-2.0-0.dll'
    libgio=: <'libgio-2.0-0.dll'
    libglib=: <'libglib-2.0-0.dll'
    libgobject=: <'libgobject-2.0-0.dll'
    libgthread=: <'libgthread-2.0-0.dll'
    libgtk=: <'libgtk-win32-2.0-0.dll'
    libgtksourceview=: <'libgtksourceview-2.0-0.dll'
    libpango=: <'libpango-1.0-0.dll'
    libpangocairo=: <'libpangocairo-1.0-0.dll'
    libpixbuf=: <'libgdk_pixbuf-2.0-0.dll'
    libxml=: <'libxml2.dll'
  end.
end.
)
3 : 0''
if. IF64 do.
  sizeofGdkEventConfigure=: 40
  GdkEventConfigure_xywh=: 20

  sizeofGdkEventKey=: 56
  GdkEventKey=: 24

  GdkEventButton_state=: 48
  GdkEventButton_button=: 52
  GdkEventScroll_direction=: 44

  sizeofGdkEventMotion=: 80
  GdkEventMotion_xy=: 24

  sizeofGtkStyle=: 984
  GtkStyle_fg_gc=: 544
  GtkStyle_black_gc=: 864
  GtkStyle_white_gc=: 872

  sizeofGtkWidget=: 96
  GtkWidget_state=: 34
  GtkWidget_style=: 48
  GtkWidget_requisition=: 56
  GtkWidget_allocation=: 64
  GtkWidget_window=: 80

else.
  sizeofGdkEventConfigure=: 28
  GdkEventConfigure_xywh=: 12

  sizeofGdkEventKey=: 36
  GdkEventKey=: 16

  GdkEventButton_state=: 36
  GdkEventButton_button=: 40
  GdkEventScroll_direction=: 32

  sizeofGdkEventMotion=: 64
  GdkEventMotion_xy=: 16

  sizeofGtkStyle=: 752
  GtkStyle_fg_gc=: 528
  GtkStyle_black_gc=: 688
  GtkStyle_white_gc=: 692

  sizeofGtkWidget=: 60
  GtkWidget_state=: 18
  GtkWidget_style=: 24
  GtkWidget_requisition=: 28
  GtkWidget_allocation=: 36
  GtkWidget_window=: 52
end.
)

ITERSIZE=: IF64{14 10
G_CHECKSUM_MD5=: 0
G_CHECKSUM_SHA1=: 1
G_CHECKSUM_SHA256=: 2
G_IO_IN=: 1
G_IO_PRI=: 2
G_IO_OUT=: 4
G_IO_ERR=: 8
G_IO_HUP=: 16
G_IO_NVAL=: 32

G_PRIORITY_DEFAULT=: 0
G_PRIORITY_DEFAULT_IDLE=: 200
G_PRIORITY_HIGH=: _100
G_PRIORITY_HIGH_IDLE=: 100

G_TYPE_BOOLEAN=: 20
G_TYPE_INT=: 24
G_TYPE_STRING=: 64
((<'GDK_') ,each n{a.)=: n=. ,65 97 +/ i.26
GDK_F1=: 16bffbe
GDK_FKeys=: GDK_F1 + i.12

GDK_BackSpace=: 16bff08
GDK_Tab=: 16bff09
GDK_Linefeed=: 16bff0a
GDK_Clear=: 16bff0b
GDK_Return=: 16bff0d
GDK_Pause=: 16bff13
GDK_Scroll_Lock=: 16bff14
GDK_Sys_Req=: 16bff15
GDK_Escape=: 16bff1b
GDK_Delete=: 16bffff
GDK_Home=: 16bff50
GDK_Left=: 16bff51
GDK_Up=: 16bff52
GDK_Right=: 16bff53
GDK_Down=: 16bff54
GDK_Prior=: 16bff55
GDK_Page_Up=: 16bff55
GDK_Next=: 16bff56
GDK_Page_Down=: 16bff56
GDK_End=: 16bff57
GDK_Begin=: 16bff58
GDK_Insert=: 16bff63
GDK_Menu=: 16bff67
GDK_Num_Lock=: 16bff7f
GDK_KP_Enter=: 16bff8d
GDK_Shift_L=: 16bffe1
GDK_Shift_R=: 16bffe2
GDK_Control_L=: 16bffe3
GDK_Control_R=: 16bffe4
GDK_Caps_Lock=: 16bffe5
GDK_Shift_Lock=: 16bffe6
GDK_Meta_L=: 16bffe7
GDK_Meta_R=: 16bffe8
GDK_Alt_L=: 16bffe9
GDK_Alt_R=: 16bffea
GDK_Super_L=: 16bffeb
GDK_Super_R=: 16bffec
GDK_Hyper_L=: 16bffed
GDK_Hyper_R=: 16bffee
GDK_EXPOSURE_MASK=: 1 (33 b.)~ 1
GDK_POINTER_MOTION_MASK=: 1 (33 b.)~ 2
GDK_POINTER_MOTION_HINT_MASK=: 1 (33 b.)~ 3
GDK_BUTTON_MOTION_MASK=: 1 (33 b.)~ 4
GDK_BUTTON1_MOTION_MASK=: 1 (33 b.)~ 5
GDK_BUTTON2_MOTION_MASK=: 1 (33 b.)~ 6
GDK_BUTTON3_MOTION_MASK=: 1 (33 b.)~ 7
GDK_BUTTON_PRESS_MASK=: 1 (33 b.)~ 8
GDK_BUTTON_RELEASE_MASK=: 1 (33 b.)~ 9
GDK_KEY_PRESS_MASK=: 1 (33 b.)~ 10
GDK_KEY_RELEASE_MASK=: 1 (33 b.)~ 11
GDK_ENTER_NOTIFY_MASK=: 1 (33 b.)~ 12
GDK_LEAVE_NOTIFY_MASK=: 1 (33 b.)~ 13
GDK_FOCUS_CHANGE_MASK=: 1 (33 b.)~ 14
GDK_STRUCTURE_MASK=: 1 (33 b.)~ 15
GDK_PROPERTY_CHANGE_MASK=: 1 (33 b.)~ 16
GDK_VISIBILITY_NOTIFY_MASK=: 1 (33 b.)~ 17
GDK_PROXIMITY_IN_MASK=: 1 (33 b.)~ 18
GDK_PROXIMITY_OUT_MASK=: 1 (33 b.)~ 19
GDK_SUBSTRUCTURE_MASK=: 1 (33 b.)~ 20
GDK_SCROLL_MASK=: 1 (33 b.)~ 21
GDK_ALL_EVENTS_MASK=: 16b3ffffe
GDK_SHIFT_MASK=: 1 (33 b.)~ 0
GDK_LOCK_MASK=: 1 (33 b.)~ 1
GDK_CONTROL_MASK=: 1 (33 b.)~ 2
GDK_MOD1_MASK=: 1 (33 b.)~ 3
GDK_MOD2_MASK=: 1 (33 b.)~ 4
GDK_MOD3_MASK=: 1 (33 b.)~ 5
GDK_MOD4_MASK=: 1 (33 b.)~ 6
GDK_MOD5_MASK=: 1 (33 b.)~ 7
GDK_BUTTON1_MASK=: 1 (33 b.)~ 8
GDK_BUTTON2_MASK=: 1 (33 b.)~ 9
GDK_BUTTON3_MASK=: 1 (33 b.)~ 10
GDK_BUTTON4_MASK=: 1 (33 b.)~ 11
GDK_BUTTON5_MASK=: 1 (33 b.)~ 12
GDK_SUPER_MASK=: 1 (33 b.)~ 26
GDK_HYPER_MASK=: 1 (33 b.)~ 27
GDK_META_MASK=: 1 (33 b.)~ 28
GDK_MODIFIER_MASK=: 16b5c001fff

GDK_COLORSPACE_RGB=: 0

GDK_WINDOW_TYPE_HINT_NORMAL=: 0
GDK_WINDOW_TYPE_HINT_DIALOG=: 1
GDK_WINDOW_TYPE_HINT_MENU=: 2
GDK_WINDOW_TYPE_HINT_TOOLBAR=: 3
GDK_WINDOW_TYPE_HINT_SPLASHSCREEN=: 4
gdk_WINDOW_TYPE_HINT_UTILITY=: 5
GDK_WINDOW_TYPE_HINT_DOCK=: 6
GDK_WINDOW_TYPE_HINT_DESKTOP=: 7
GDK_WINDOW_TYPE_HINT_DROPDOWN_MENU=: 8
GDK_WINDOW_TYPE_HINT_POPUP_MENU=: 9
GDK_WINDOW_TYPE_HINT_TOOLTIP=: 10
GDK_WINDOW_TYPE_HINT_NOTIFICATION=: 11
GDK_WINDOW_TYPE_HINT_COMBO=: 12
GDK_WINDOW_TYPE_HINT_DND=: 13

GTK_ACCEL_VISIBLE=: 1
GTK_ACCEL_LOCKED=: 2

GTK_DIALOG_MODAL=: 1
GTK_DIALOG_DESTROY_WITH_PARENT=: 2
GTK_DIALOG_NO_SEPARATOR=: 4
GTK_RESPONSE_NONE=: _1

GTK_RESPONSE_NONE=: -1
GTK_RESPONSE_REJECT=: -2
GTK_RESPONSE_ACCEPT=: -3
GTK_RESPONSE_DELETE_EVENT=: -4
GTK_RESPONSE_OK=: -5
GTK_RESPONSE_CANCEL=: -6
GTK_RESPONSE_CLOSE=: -7
GTK_RESPONSE_YES=: -8
GTK_RESPONSE_NO=: -9
GTK_RESPONSE_APPLY=: -10
GTK_RESPONSE_HELP=: -11

GTK_STOCK_CANCEL=: 'gtk-cancel'
GTK_STOCK_DIALOG_INFO=: 'gtk-dialog-info'
GTK_STOCK_DIALOG_QUESTION=: 'gtk_stock_dialog_question'
GTK_STOCK_DIALOG_WARNING=: 'gtk_stock_dialog_warning'
GTK_STOCK_NO=: 'gtk-no'
GTK_STOCK_OK=: 'gtk-ok'
GTK_STOCK_OPEN=: 'gtk-open'
GTK_STOCK_SAVE=: 'gtk-save'
GTK_STOCK_STOP=: 'gtk_stock_stop'
GTK_STOCK_YES=: 'gtk-yes'
GTK_MESSAGE_INFO=: 0
GTK_MESSAGE_WARNING=: 1
GTK_MESSAGE_QUESTION=: 2
GTK_MESSAGE_ERROR=: 3
GTK_MESSAGE_OTHER=: 4
GTK_BUTTONS_NONE=: 0
GTK_BUTTONS_OK=: 1
GTK_BUTTONS_CLOSE=: 2
GTK_BUTTONS_CANCEL=: 3
GTK_BUTTONS_YES_NO=: 4
GTK_BUTTONS_OK_CANCEL=: 5
GTK_FILE_CHOOSER_ACTION_OPEN=: 0
GTK_FILE_CHOOSER_ACTION_SAVE=: 1
GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER=: 2
GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER=: 3
GTK_POS_LEFT=: 0
GTK_POS_RIGHT=: 1
GTK_POS_TOP=: 2
GTK_POS_BOTTOM=: 3

GDK_NONE=: 0
GDK_BUTTON_PRESS=: 4
GDK_2BUTTON_PRESS=: 5

GTK_EXPAND=: 1
GTK_FILL=: 4

GTK_RELIEF_NONE=: 2
GTK_POLICY_ALWAYS=: 0
GTK_POLICY_AUTOMATIC=: 1
GTK_POLICY_NEVER=: 2

GTK_ICON_SIZE_MENU=: 1
GTK_ICON_SIZE_SMALL_TOOLBAR=: 2
GTK_ICON_SIZE_LARGE_TOOLBAR=: 3
GTK_ICON_SIZE_BUTTON=: 4
GTK_ICON_SIZE_DIALOG=: 6

GTK_SELECTION_NONE=: 0
GTK_SELECTION_SINGLE=: 1
GTK_SELECTION_BROWSE=: 2
GTK_SELECTION_MULTIPLE=: 3

GTK_SHADOW_NONE=: 0
GTK_SHADOW_IN=: 1
GTK_SHADOW_OUT=: 2
GTK_SHADOW_ETCHED_IN=: 3
GTK_SHADOW_ETCHED_OUT=: 4

GTK_STOCK_CLOSE=: 'gtk-close'
GTK_STOCK_OK=: 'gtk-ok'
GTK_STOCK_CANCEL=: 'gtk-cancel'
GTK_STOCK_EDIT=: 'gtk-edit'
GTK_STOCK_OPEN=: 'gtk-open'
GTK_STOCK_SAVE=: 'gtk-save'

GTK_TOOLBAR_ICONS=: 0

GTK_WRAP_NONE=: 0
GTK_WRAP_CHAR=: 1
GTK_WRAP_WORD=: 2
GTK_WRAP_WORD_CHAR=: 3

GTK_WIN_POS_CENTER=: 1
GTK_WIN_POS_CENTER_ON_PARENT=: 4
GTK_WINDOW_TOPLEVEL=: 0
GDK_SELECTION_PRIMARY=: 1
GDK_SELECTION_SECONDARY=: 2
GDK_SELECTION_CLIPBOARD=: 69
CAIRO_STATUS_SUCCESS=: 0
CAIRO_FORMAT_ARGB32=: 0
CAIRO_FORMAT_RGB24=: 1
CAIRO_OPERATOR_SOURCE=: 1
CAIRO_OPERATOR_OVER=: 2
GTK_PRINT_CAPABILITY_PAGE_SET=: 1
GTK_PRINT_CAPABILITY_COPIES=: 2
GTK_PRINT_CAPABILITY_COLLATE=: 4
GTK_PRINT_CAPABILITY_REVERSE=: 8
GTK_PRINT_CAPABILITY_SCALE=: 16
GTK_PRINT_CAPABILITY_GENERATE_PDF=: 32
GTK_PRINT_CAPABILITY_GENERATE_PS=: 64
GTK_PRINT_CAPABILITY_PREVIEW=: 128
GTK_PRINT_CAPABILITY_NUMBER_UP=: 256
GTK_PRINT_CAPABILITY_NUMBER_UP_LAYOUT=: 512

GTK_PRINT_STATUS_INITIAL=: 0
GTK_PRINT_STATUS_PREPARING=: 1
GTK_PRINT_STATUS_GENERATING_DATA=: 2
GTK_PRINT_STATUS_SENDING_DATA=: 3
GTK_PRINT_STATUS_PENDING=: 4
GTK_PRINT_STATUS_PENDING_ISSUE=: 5
GTK_PRINT_STATUS_PRINTING=: 6
GTK_PRINT_STATUS_FINISHED=: 7
GTK_PRINT_STATUS_FINISHED_ABORTED=: 8

GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG=: 0
GTK_PRINT_OPERATION_ACTION_PRINT=: 1
GTK_PRINT_OPERATION_ACTION_PREVIEW=: 2
GTK_PRINT_OPERATION_ACTION_EXPORT=: 3

GTK_PRINT_OPERATION_RESULT_ERROR=: 0
GTK_PRINT_OPERATION_RESULT_APPLY=: 1
GTK_PRINT_OPERATION_RESULT_CANCEL=: 2
GTK_PRINT_OPERATION_RESULT_IN_PROGRESS=: 3

GTK_PRINT_PAGES_ALL=: 0
GTK_PRINT_PAGES_CURRENT=: 1
GTK_PRINT_PAGES_RANGES=: 2
GTK_PRINT_PAGES_SELECTION=: 3

GTK_PAGE_SET_ALL=: 0
GTK_PAGE_SET_EVEN=: 1
GTK_PAGE_SET_ODD=: 2

GTK_PAGE_ORIENTATION_PORTRAIT=: 0
GTK_PAGE_ORIENTATION_LANDSCAPE=: 1
GTK_PAGE_ORIENTATION_REVERSE_PORTRAIT=: 2
GTK_PAGE_ORIENTATION_REVERSE_LANDSCAPE=: 3

GTK_PRINT_QUALITY_LOW=: 0
GTK_PRINT_QUALITY_NORMAL=: 1
GTK_PRINT_QUALITY_HIGH=: 2
GTK_PRINT_QUALITY_DRAFT=: 3

GTK_PRINT_DUPLEX_SIMPLEX=: 0
GTK_PRINT_DUPLEX_HORIZONTAL=: 1
GTK_PRINT_DUPLEX_VERTICAL=: 2

GTK_UNIT_PIXEL=: 0
GTK_UNIT_POINTS=: 1
GTK_UNIT_INCH=: 2
GTK_UNIT_MM=: 3
GDK_X_CURSOR=: 0
GDK_ARROW=: 2
GDK_BASED_ARROW_DOWN=: 4
GDK_BASED_ARROW_UP=: 6
GDK_BOAT=: 8
GDK_BOGOSITY=: 10
GDK_BOTTOM_LEFT_CORNER=: 12
GDK_BOTTOM_RIGHT_CORNER=: 14
GDK_BOTTOM_SIDE=: 16
GDK_BOTTOM_TEE=: 18
GDK_BOX_SPIRAL=: 20
GDK_CENTER_PTR=: 22
GDK_CIRCLE=: 24
GDK_CLOCK=: 26
GDK_COFFEE_MUG=: 28
GDK_CROSS=: 30
GDK_CROSS_REVERSE=: 32
GDK_CROSSHAIR=: 34
GDK_DIAMOND_CROSS=: 36
GDK_DOT=: 38
GDK_DOTBOX=: 40
GDK_DOUBLE_ARROW=: 42
GDK_DRAFT_LARGE=: 44
GDK_DRAFT_SMALL=: 46
GDK_DRAPED_BOX=: 48
GDK_EXCHANGE=: 50
GDK_FLEUR=: 52
GDK_GOBBLER=: 54
GDK_GUMBY=: 56
GDK_HAND1=: 58
GDK_HAND2=: 60
GDK_HEART=: 62
GDK_ICON=: 64
GDK_IRON_CROSS=: 66
GDK_LEFT_PTR=: 68
GDK_LEFT_SIDE=: 70
GDK_LEFT_TEE=: 72
GDK_LEFTBUTTON=: 74
GDK_LL_ANGLE=: 76
GDK_LR_ANGLE=: 78
GDK_MAN=: 80
GDK_MIDDLEBUTTON=: 82
GDK_MOUSE=: 84
GDK_PENCIL=: 86
GDK_PIRATE=: 88
GDK_PLUS=: 90
GDK_QUESTION_ARROW=: 92
GDK_RIGHT_PTR=: 94
GDK_RIGHT_SIDE=: 96
GDK_RIGHT_TEE=: 98
GDK_RIGHTBUTTON=: 100
GDK_RTL_LOGO=: 102
GDK_SAILBOAT=: 104
GDK_SB_DOWN_ARROW=: 106
GDK_SB_H_DOUBLE_ARROW=: 108
GDK_SB_LEFT_ARROW=: 110
GDK_SB_RIGHT_ARROW=: 112
GDK_SB_UP_ARROW=: 114
GDK_SB_V_DOUBLE_ARROW=: 116
GDK_SHUTTLE=: 118
GDK_SIZING=: 120
GDK_SPIDER=: 122
GDK_SPRAYCAN=: 124
GDK_STAR=: 126
GDK_TARGET=: 128
GDK_TCROSS=: 130
GDK_TOP_LEFT_ARROW=: 132
GDK_TOP_LEFT_CORNER=: 134
GDK_TOP_RIGHT_CORNER=: 136
GDK_TOP_SIDE=: 138
GDK_TOP_TEE=: 140
GDK_TREK=: 142
GDK_UL_ANGLE=: 144
GDK_UMBRELLA=: 146
GDK_UR_ANGLE=: 148
GDK_WATCH=: 150
GDK_XTERM=: 152
GDK_LAST_CURSOR=: 153
GDK_BLANK_CURSOR=: _2
GDK_CURSOR_IS_PIXMAP=: _1
G_LOG_FLAG_RECURSION=: 0 (33 b.) 1
G_LOG_FLAG_FATAL=: 1 (33 b.) 1
G_LOG_LEVEL_ERROR=: 2 (33 b.) 1
G_LOG_LEVEL_CRITICAL=: 3 (33 b.) 1
G_LOG_LEVEL_WARNING=: 4 (33 b.) 1
G_LOG_LEVEL_MESSAGE=: 5 (33 b.) 1
G_LOG_LEVEL_INFO=: 6 (33 b.) 1
G_LOG_LEVEL_DEBUG=: 7 (33 b.) 1
G_LOG_LEVEL_MASK=: 0 (22 b.) G_LOG_FLAG_RECURSION (23 b.) G_LOG_FLAG_FATAL
GDK_CURRENT_TIME=: 0
PANGO_SCALE=: 1024
PANGO_STYLE_NORMAL=: 0
PANGO_STYLE_OBLIQUE=: 1
PANGO_STYLE_ITALIC=: 2
PANGO_WEIGHT_THIN=: 100
PANGO_WEIGHT_ULTRALIGHT=: 200
PANGO_WEIGHT_LIGHT=: 300
PANGO_WEIGHT_BOOK=: 380
PANGO_WEIGHT_NORMAL=: 400
PANGO_WEIGHT_MEDIUM=: 500
PANGO_WEIGHT_SEMIBOLD=: 600
PANGO_WEIGHT_BOLD=: 700
PANGO_WEIGHT_ULTRABOLD=: 800
PANGO_WEIGHT_HEAVY=: 900
PANGO_WEIGHT_ULTRAHEAVY=: 1000
cddef=: 4 : 0
y=. dtb (y i. ':'){.y
if. 0=#y do. '' return. end.
n=. y i. ' '
f=. n {. y
d=. (_2 * (<_2{.f) e. '_1';'_2';'_3') }. f
if. IFUNIX do.
  p=. n }. y
else.
  p=. (n+1) }. y
  if. '>' = {.p do.
    p=. ' >+', }.p
  else.
    p=. ' +', p
  end.
end.
(f)=: (x,' ',d,p)&(15!:0)
''
)
cddeflog=: 1 : 0
'f p'=. x
if. (<f) e. <;._1 ' gtk_events_pending gtk_main_iteration' do.
  p & (15!:0)
else.
  fl=. > IFWIN{'/tmp/tracegtk.log';'c:\tracegtk.log'
  3 : ('if. Debug do. (''',p,''',LF) 1!:3 <''',fl,''' end.',LF,'''',p,''' 15!:0 y')
end.
)
libgio cddef each <;._2 [ 0 : 0
g_input_stream_close > i x x x
g_memory_input_stream_new_from_data > x *c x x
)
libglib cddef each <;._2 [ 0 : 0
g_compute_checksum_for_string > x x *c x
g_convert *c *c x *c *c * * *
g_free > n x
g_idle_add > x x x
g_idle_add_full >x x x x x
g_io_add_watch > x x x x x : quint GIOChannel GIOCondition GioFunc gpointer
g_io_channel_unix_new > x x : here, not in libgio
g_io_channel_win32_new_socket > x x : here, not in libgio
g_key_file_free > n x
g_key_file_get_string > x x *c *c x
g_key_file_load_from_file > i x *c x *x
g_key_file_new > x
g_list_length > i x
g_list_nth_data > x x x
g_list_free  n x
g_locale_from_utf8 > x *c x *x *x x
g_locale_to_utf8 > x *c x *x *x x
g_log0 > n *c i *c : doamin, loglevel, format with 0 optional arg
g_pattern_match_simple > i *c *c
g_source_remove > i i
g_timeout_add_full > x x x x x x
g_utf8_validate > i *c x x
)
libgthread cddef each <;._2 [ 0 : 0
g_thread_init > n x
)
libgdk cddef each <;._2 [ 0 : 0
gdk_atom_intern > x *c i
gdk_beep > n
gdk_cursor_new > x i
gdk_display_get_default > x
gdk_draw_arc > n x x i x x x x x x
gdk_draw_drawable > n x x x x x x x x x
gdk_draw_layout > n x x x x x
gdk_draw_line > n x x x x x x   : pixamp gc a b c d
gdk_draw_lines > n x x *x x     : pixmap gc pts cnt
gdk_draw_rgb_image > n x x i i i i i *c i
gdk_draw_pixbuf > n x x x x x x x x x x x x
: gtkpx,0,gtkbuf,0,0,0,0,_1,_1,0,0,0 : pixbuf pixbuf_dest,drawable_src,colormap,src_x,src_y,dest_x,dest_y,w,h
gdk_draw_point > n x x x x
gdk_draw_polygon > n x x i *x x
gdk_draw_rectangle > n x x i x x x x
gdk_drawable_get_colormap > x x
gdk_event_get_coords x x *d *d
gdk_event_get_state x x *x
gdk_gc_new > x x
gdk_gc_set_clip_rectangle > n x *c : xwyh in char (2(3!:4)xywh)
gdk_gc_set_line_attributes > n x x x x x
gdk_gc_set_rgb_fg_color > n x *c
gdk_pixbuf_get_from_drawable > x x x x i i i i i i
gdk_pixbuf_get_from_surface > x x i i i i : gtk3
gdk_pixbuf_get_from_window > x x i i i i : gtk3
gdk_pixbuf_new_from_stream > x x x x    : 2.14
gdk_pixmap_new > x x i i i
gdk_screen_get_default > x
gdk_screen_get_display > x x
gdk_screen_get_height > i x
gdk_screen_get_height_mm > i x
gdk_screen_get_width > i x
gdk_screen_get_width_mm > i x
gdk_window_get_geometry > n x *i *i *i *i
gdk_window_get_parent > x x
gdk_window_get_pointer > x x *x *x *i
gdk_window_get_state > x x
gdk_window_set_cursor > n x x
: threads
gdk_threads_init > n
gdk_threads_enter > n
gdk_threads_leave > n
: x11
gdk_x11_colormap_foreign_new > x x x
gdk_x11_colormap_get_xcolormap > x x
gdk_x11_display_get_xdisplay > x x
gdk_x11_drawable_get_xdisplay > x x
gdk_x11_drawable_get_xid > x x
gdk_x11_get_default_xdisplay > x
gdk_x11_screen_lookup_visual > x x x
gdk_x11_screen_get_xscreen > x x
gdk_x11_window_get_xid > x x
gdk_x11_visual_get_xvisual > x x
: win32
gdk_win32_drawable_get_handle > x x
: colormap
gdk_colormap_get_visual > x x
: gdk_window_invalidate_rect > n x x i
: cairo
gdk_cairo_create > x x
gdk_cairo_reset_clip > n x x
gdk_cairo_set_source_color > n x x
gdk_cairo_set_source_pixbuf > n x x d d
gdk_cairo_set_source_pixmap > n x x d d
gdk_cairo_rectangle > n x x
gdk_cairo_region > n x x
)
libgtk cddef each <;._2 [ 0 : 0

: glade
: isigraph

gtk_about_dialog_new > x
gtk_about_dialog_set_comments  n x *c
gtk_about_dialog_set_copyright > n x *c
gtk_about_dialog_set_logo_icon_name > n x *c
gtk_about_dialog_set_name > n x *c              : decommited in 3.0
gtk_about_dialog_set_program_name > n x *c      : 2.12
gtk_about_dialog_set_version > n x *c
gtk_about_dialog_set_website > n x *c

gtk_accel_group_new > x

gtk_accelerator_parse > n *c *i *i
gtk_accelerator_valid > i i i

gtk_adjustment_get_value > d x
gtk_adjustment_new > x d d d d d d

gtk_alignment_new > x f f f f
gtk_alignment_set_padding > n x x x x x

gtk_bin_get_child > x x
gtk_box_pack_start > n x x x x x
gtk_box_pack_end > n x x i i x
gtk_box_reorder_child > n x x i
: gtk_box_set_spacing > n x x

gtk_builder_add_from_file > i x *c *x      : 2.12
gtk_builder_add_from_string > i x *c x *x  : 2.12
gtk_builder_connect_signals_full > n x x x
gtk_builder_get_object > x x *c
gtk_builder_new > x

gtk_button_get_image > x x
gtk_button_new > x
gtk_button_new_from_stock > x *c
gtk_button_new_with_label > x *c
gtk_button_new_with_mnemonic > x *c
gtk_button_set_focus_on_click > n x i
gtk_button_set_image > n x x
gtk_button_set_label > n x *c
gtk_button_set_relief > n x x
gtk_button_set_use_underline > n x i

gtk_cell_layout_pack_end > n x x i
gtk_cell_layout_pack_start > n x x i
gtk_cell_renderer_combo_new > x
gtk_cell_renderer_pixbuf_new > x
gtk_cell_renderer_set_alignment > n x f f
gtk_cell_renderer_spin_new > x
gtk_cell_renderer_text_new > x
gtk_cell_renderer_toggle_new > x
gtk_cell_renderer_toggle_get_active > i x
gtk_cell_renderer_toggle_set_active > n x i

gtk_check_button_new > x
gtk_check_button_new_with_label > x *c
gtk_check_button_new_with_mnemonic > x *c
gtk_check_menu_item_get_active > i x
gtk_check_menu_item_new_with_label > x *c
gtk_check_menu_item_new_with_mnemonic > x *c
gtk_check_menu_item_set_active > n x i

gtk_check_version > x i i i

gtk_clipboard_get > x x
gtk_clipboard_set_image > n x x
gtk_clipboard_set_text > n x *c x
gtk_clipboard_store > n x
gtk_clipboard_wait_for_image > x x
gtk_clipboard_wait_for_text > x x

: color selection dialog
gtk_color_selection_dialog_get_color_selection > x x
gtk_color_selection_dialog_new > x *c
gtk_color_selection_get_current_color n x *x

gtk_combo_box_append_text > x x *c
gtk_combo_box_entry_new > x                     : decommited in 3.0
gtk_combo_box_entry_new_text > x                : decommited in 3.0
gtk_combo_box_entry_new_with_model > x x i      : decommited in 3.0
gtk_combo_box_entry_set_text_column > n x i     : decommited in 3.0
gtk_combo_box_get_active > i x
gtk_combo_box_get_active_text > x x
gtk_combo_box_get_model > x x
gtk_combo_box_new > x
gtk_combo_box_new_text > x
gtk_combo_box_new_with_entry > x                : since 2.24
gtk_combo_box_new_with_model > x x
gtk_combo_box_new_with_model_and_entry > x x    : since 2.24
gtk_combo_box_remove_text > n x i               : decommited in 3.0
gtk_combo_box_set_active > n x i
gtk_combo_box_set_entry_text_column > n x i     : since 2.24
gtk_combo_box_set_model > n x x
gtk_combo_box_get_has_entry > i x               : since 2.24
gtk_combo_box_text_new > x                      : since 2.24
gtk_combo_box_text_get_active_text > x x        : since 2.24

gtk_container_add n x x
gtk_container_get_children > x x
gtk_container_remove > n x x
gtk_container_resize_children > n x
gtk_container_set_border_width n x x

gtk_dialog_add_action_widget > n x x x
gtk_dialog_add_button > x x *c i
gtk_dialog_get_content_area > x x
gtk_dialog_new > x
gtk_dialog_new_with_buttons > x *c x x *c x x : ! varargs
gtk_dialog_response > n x x
gtk_dialog_run > i x
gtk_dialog_set_default_response > n x x

gtk_drawing_area_new > x
gtk_drawing_area_size > n x x

gtk_editable_set_position > n x x     : void widget position
gtk_editable_select_region > n x x x

gtk_entry_get_text > x x
gtk_entry_new > x
gtk_entry_set_editable > n x x
gtk_entry_set_max_length > n x x
gtk_entry_set_text n x *c
gtk_entry_set_visibility n x i

gtk_event_box_new > x
gtk_events_pending > x

gtk_expander_new_with_mnemonic > x *c

: file selection dialog
gtk_file_chooser_add_filter > n x x
gtk_file_chooser_dialog_new > x *c x x *c x *c x x
gtk_file_chooser_get_filename > x x
gtk_file_chooser_get_filename_utf8 > x x          : win64 version
gtk_file_chooser_set_current_folder > x x *c
gtk_file_chooser_set_current_folder_utf8 > x x *c : win64 version
gtk_file_chooser_set_do_overwrite_confirmation > n x x
gtk_file_chooser_set_current_name > n x *c
gtk_file_chooser_set_filename > i x *c
gtk_file_chooser_set_filename_utf8 > i x *c : win64 version

gtk_file_filter_add_pattern > n x *c
gtk_file_filter_new > x
gtk_file_filter_set_name > n x *c

gtk_fixed_move > n x x i i
gtk_fixed_new > x
gtk_fixed_put > n x x x x

gtk_font_button_get_font_name > x x   : gchar* font_button
gtk_font_button_new > x
gtk_font_button_new_with_font > x *c

: font selection dialog
gtk_font_selection_dialog_get_cancel_button > x x
gtk_font_selection_dialog_get_font_name > x x
gtk_font_selection_dialog_get_ok_button > x x
gtk_font_selection_dialog_new > x *c
gtk_font_selection_dialog_set_font_name > n x *c

gtk_frame_new > x *c
gtk_frame_set_label > n x *c
gtk_frame_set_shadow_type > n x x

gtk_get_current_event_time > x

gtk_hbox_new > x i x
gtk_hpaned_new > x
gtk_hseparator_new > x
gtk_vpaned_new > x

gtk_hscrollbar_new > x x
gtk_vscrollbar_new > x x

gtk_image_clear > n x
gtk_image_menu_item_new_from_stock > x *c x
gtk_image_menu_item_new_with_label > x *c
gtk_image_menu_item_new_with_mnemonic > x *c
gtk_image_menu_item_set_image > n x x
gtk_image_new_from_file_utf8 > x *c : win64 version
gtk_image_new_from_file > x *c
gtk_image_new_from_pixbuf > x x
gtk_image_new_from_stock > x *c x
gtk_image_new > x
gtk_image_set_from_file > n x *c
gtk_image_set_from_file_utf8 > n x *c : win64 version
gtk_image_set_from_pixbuf > n x x

gtk_init  n *x x

gtk_label_get_label > x x
gtk_label_new > x *c
gtk_label_new_with_mnemonic > x *c
gtk_label_set_justify > n x x
gtk_label_set_line_wrap > n x i
gtk_label_set_markup > n x *c
gtk_label_set_mnemonic_widget > n x x
gtk_label_set_text > n x *c
gtk_label_set_text_with_mnemonic > n x *c

gtk_layout_new > x x x
gtk_layout_put > n x x x x
gtk_layout_set_size > n x x x

gtk_list_store_append > n x *x
gtk_list_store_clear > n x
gtk_list_store_insert > n x *x x
gtk_list_store_new_1 > x x s
gtk_list_store_new_2 > x x s s
gtk_list_store_newv > x i *x
gtk_list_store_remove > i x *x

gtk_list_store_set_1 > n x *x i *c i
gtk_list_store_set_2 > n x *x i i i
gtk_list_store_set_3 > n x *x i * i *c i

gtk_main > n
gtk_main_iteration > x
gtk_main_level > x
gtk_main_quit > n

: menu;'activate';accel_group;letter;modifier;GTK_ACCEL_VISIBLE
gtk_menu_attach_to_widget > n x x *x
gtk_menu_bar_new > x                  : menu_bar
: gtk_menu_item_get_label > x x
gtk_menu_item_new_with_label > x *c
gtk_menu_item_new_with_label > x *c   : menu lable
gtk_menu_item_new_with_mnemonic > x *c
gtk_menu_item_set_submenu > n x x     : void menu menu
gtk_menu_new > x
gtk_menu_popup > n x *x *x *x *x x x
gtk_menu_shell_append > n x x         : void menu menu_item
gtk_menu_shell_append > n x x         : void menu_bar menu
gtk_menu_shell_prepend > n x x

gtk_message_dialog_new > x x x x x *c *c

gtk_misc_set_alignment > n x f f
gtk_misc_set_padding > n x i i

: notebook
gtk_notebook_append_page > i x x x
gtk_notebook_get_current_page > i x
gtk_notebook_get_n_pages > i x
gtk_notebook_get_nth_page > x x s : widget notebook,page
gtk_notebook_get_tab_label > x x x
gtk_notebook_get_tab_label_text > x x x
gtk_notebook_insert_page > i x x x i
gtk_notebook_insert_page_menu > i x x x x x
gtk_notebook_new > x
gtk_notebook_page_num > i x x
gtk_notebook_popup_enable > n x
gtk_notebook_prepend_page_menu > i x x x x
gtk_notebook_remove_page > n x x
gtk_notebook_reorder_child > n x x x
gtk_notebook_set_current_page > n x x
gtk_notebook_set_group > n x *x              : since 2.12, but unavailable in gtk3
gtk_notebook_set_group_name > n x *c         : since 2.24
gtk_notebook_set_menu_label_text > n x x *c
gtk_notebook_set_scrollable > n x i
gtk_notebook_set_show_tabs > n x i
gtk_notebook_set_tab_detachable > n x x x
gtk_notebook_set_tab_label_text > n x x *c
gtk_notebook_set_tab_pos > n x x
gtk_notebook_set_tab_reorderable > n x x x

gtk_object_destroy > n x

gtk_paned_pack1 > n x x i i
gtk_paned_pack2 > n x x i i
gtk_paned_set_position > n x x
gtk_paned_get_position > x x

gtk_progress_bar_new > x
gtk_progress_bar_set_fraction > n x d

gtk_radio_button_new_with_mnemonic_from_widget > x x *c

gtk_range_get_value > d x
gtk_range_set_increments > n x d d
gtk_range_set_range > n x d d
gtk_range_set_value > n x d

gtk_rc_parse_string > n *c

gtk_settings_get_default > x
gtk_settings_set_string_property > n x *c *c *c

gtk_scrolled_window_add_with_viewport > n x x
gtk_scrolled_window_get_hscrollbar > x x
gtk_scrolled_window_get_vadjustment > x x
gtk_scrolled_window_new > x x x       : widget hadjustment vadjustment
gtk_scrolled_window_set_policy > n x x x
gtk_scrolled_window_set_shadow_type > n x x
gtk_scrolled_window_set_vadjustment > n x x

gtk_separator_menu_item_new > x
gtk_separator_tool_item_new > x

gtk_spin_button_get_value_as_int > i x
gtk_spin_button_get_value > d x
gtk_spin_button_new_with_range > x d d d
gtk_spin_button_set_value > n x d

gtk_statusbar_get_context_id > x x *c
gtk_statusbar_get_has_resize_grip > i x
gtk_statusbar_new > x
gtk_statusbar_pop > n x x
gtk_statusbar_push > x x x *c
gtk_statusbar_remove > n x x x
gtk_statusbar_set_has_resize_grip > n x i

gtk_table_attach > n x x x x x x x x x x
gtk_table_new > x x x i
gtk_table_set_col_spacings > n x x
gtk_table_set_row_spacings > n x x

gtk_text_buffer_add_mark > n x x *x        : n, buffer,mark,iter
gtk_text_buffer_begin_user_action > n x
gtk_text_buffer_copy_clipboard > n x x
gtk_text_buffer_create_mark > x x *c *x i
gtk_text_buffer_cut_clipboard > n x x i
gtk_text_buffer_delete > n x *x *x         : n, buffer,iter,iter
gtk_text_buffer_delete_mark > n x x
gtk_text_buffer_delete_selection > i x i i
gtk_text_buffer_end_user_action > n x
gtk_text_buffer_get_bounds > n x *x *x
gtk_text_buffer_get_end_iter x x *x
gtk_text_buffer_get_insert > x x           : mark,buffer
gtk_text_buffer_get_iter_at_line > n x *x i
gtk_text_buffer_get_iter_at_mark > n x *x x : n, buffer,iter,mark
gtk_text_buffer_get_iter_at_offset > n x *x i
gtk_text_buffer_get_line_count > i x
gtk_text_buffer_get_mark > x x *c
gtk_text_buffer_get_selection_bound > x x
gtk_text_buffer_get_selection_bounds > i x *x *x
gtk_text_buffer_get_start_iter x x *x
gtk_text_buffer_get_text > x x *x *x x
gtk_text_buffer_insert > n x *x *c x       : n, buffer,iter,text,len
gtk_text_buffer_insert_at_cursor > n x *c i : n, buffer,text,len
gtk_text_buffer_insert_pixbuf > n x *x x
gtk_text_buffer_move_mark > n x x *x
gtk_text_buffer_move_mark_by_name > n x *c *x
gtk_text_buffer_new > x x
gtk_text_buffer_paste_clipboard > n x x x i
gtk_text_buffer_place_cursor > n x *x
gtk_text_buffer_select_range > n x *x *x
gtk_text_buffer_set_text > n x *c x

gtk_text_iter_backward_chars > i *x i
gtk_text_iter_backward_word_start > i *x
gtk_text_iter_ends_line > i *x
gtk_text_iter_ends_word > i *x
gtk_text_iter_equal > i *x *x
gtk_text_iter_forward_chars > i *x i
gtk_text_iter_forward_to_line_end > i *x
gtk_text_iter_forward_word_end > i *x
gtk_text_iter_get_char > x *x
gtk_text_iter_get_char i *x
gtk_text_iter_get_line > x *x
gtk_text_iter_get_line_offset > i *x
gtk_text_iter_get_offset > i *x
gtk_text_iter_get_text > x *x *x
gtk_text_iter_set_line > n *x x
gtk_text_iter_set_offset > n *x i
gtk_text_iter_starts_line > i *x

gtk_text_mark_new > x *c x                 : mark,name,gravity

gtk_text_view_buffer_to_window_coords > n x i i i *i *i
gtk_text_view_get_buffer > x x
gtk_text_view_get_iter_at_position > n x *x *i i i
gtk_text_view_get_iter_location > n x *x *c : xwyh in char (_2(3!:4)xywh)
gtk_text_view_get_wrap_mode > x x
gtk_text_view_new > x
gtk_text_view_new_with_buffer > x x
gtk_text_view_place_cursor_onscreen > n x
gtk_text_view_scroll_mark_onscreen > n x x
gtk_text_view_scroll_to_iter > i x *x d i d d
gtk_text_view_scroll_to_mark > n x x d x d d : n,view,mark,d within_margin,use_align,d xalign,d yalign
gtk_text_view_set_editable > n x i
gtk_text_view_set_left_margin > n x i
gtk_text_view_set_right_margin > n x i
gtk_text_view_set_wrap_mode > n x x
gtk_text_view_window_to_buffer_coords > n x x x x *x *x

gtk_toggle_button_get_active > i x
gtk_toggle_button_set_active > n x i

gtk_tool_button_new > x x *c
gtk_tool_item_new > x
gtk_tool_item_set_tooltip > n x x *c *c

gtk_toolbar_insert > n x x i
gtk_toolbar_new > x
gtk_toolbar_set_icon_size > n x x
gtk_toolbar_set_style > n x x

gtk_tool_button_new_from_stock > x *c
: gtk_tool_button_set_label > n x *c
gtk_tool_button_set_stock_id > n x *c

gtk_tooltips_new > x
gtk_tooltips_set_tip > n x x *c *c

gtk_tree_model_get_1 > n x *x x *x x
gtk_tree_model_get_iter > i x *x x
gtk_tree_model_get_iter_first > i x *x
gtk_tree_model_get_iter_from_string > i x *x *c
gtk_tree_model_get_n_columns > x x
gtk_tree_model_get_path > x x *x
gtk_tree_model_get_string_from_iter > x x *x
gtk_tree_model_iter_n_children > x x *x
gtk_tree_model_iter_nth_child > i x *x x i
gtk_tree_model_iter_next > i x *x

gtk_tree_path_free > n x
gtk_tree_path_get_indices * *
gtk_tree_path_new_from_string > x *c
gtk_tree_path_to_string > x x

gtk_tree_selection_count_selected_rows > i x
gtk_tree_selection_get_selected > i x *x *x
gtk_tree_selection_get_tree_view > x x
gtk_tree_selection_iter_is_selected > i x *x
gtk_tree_selection_select_iter > n x *x
gtk_tree_selection_select_path > n x x
gtk_tree_selection_set_mode > n x x
gtk_tree_selection_unselect_all > n x

gtk_tree_view_append_column > x x x
gtk_tree_view_column_add_attribute > n x x *c x
gtk_tree_view_column_get_alignment > f x
gtk_tree_view_column_get_cell_renderers > x x
gtk_tree_view_column_get_clickable > i x
gtk_tree_view_column_get_expand > i x
gtk_tree_view_column_get_max_width > x x
gtk_tree_view_column_get_min_width > x x
gtk_tree_view_column_get_reorderable > i x
gtk_tree_view_column_get_resizable > i x
gtk_tree_view_column_get_sort_indicator > i x
gtk_tree_view_column_get_sort_order > i x
gtk_tree_view_column_get_title > x x
gtk_tree_view_column_get_visible > i x
gtk_tree_view_column_get_widget > x x
gtk_tree_view_column_new > x
gtk_tree_view_column_new_with_attributes > x *c x x
gtk_tree_view_column_pack_start > n x x i
gtk_tree_view_column_set_alignment > n x f
gtk_tree_view_column_set_attributes > n x x x
gtk_tree_view_column_set_clickable > n x i
gtk_tree_view_column_set_expand > n x i
gtk_tree_view_column_set_max_width > n x x
gtk_tree_view_column_set_min_width > n x x
gtk_tree_view_column_set_reorderable > n x i
gtk_tree_view_column_set_resizable > n x i
gtk_tree_view_column_set_sizing > n x x
gtk_tree_view_column_set_sort_indicator > n x i
gtk_tree_view_column_set_sort_order > n x i
gtk_tree_view_column_set_title > n x *c
gtk_tree_view_column_set_visible > n x i
gtk_tree_view_column_set_widget > n x x
gtk_tree_view_get_column > x x x
gtk_tree_view_get_columns > x x
gtk_tree_view_get_cursor > n x x x
gtk_tree_view_get_grid_lines > x x
gtk_tree_view_get_headers_visible > i x
gtk_tree_view_get_iter_from_string > x x *c
gtk_tree_view_get_model > x x
gtk_tree_view_get_reorderable > i x
gtk_tree_view_get_selection > x x
gtk_tree_view_get_tooltip_column > x x
gtk_tree_view_get_visible_range > i x x x
gtk_tree_view_insert_column > x x x i
gtk_tree_view_insert_column_with_attributes > x x x *c x *c x *c
gtk_tree_view_insert_column_with_attributes_1 > x x x *c x *c
gtk_tree_view_new > x
gtk_tree_view_new_with_model > x x
gtk_tree_view_row_activated > n x x x
gtk_tree_view_scroll_to_cell > n x x x i d d
gtk_tree_view_set_cursor > n x x x i
gtk_tree_view_set_enable_search > n x i
gtk_tree_view_set_fixed_height_mode > n x i
gtk_tree_view_set_grid_lines > n x x
gtk_tree_view_set_headers_visible > n x i
gtk_tree_view_set_model > n x x
gtk_tree_view_set_reorderable > n x i
gtk_tree_view_set_rules_hint > n x i
gtk_tree_view_set_tooltip_column > n x x

gtk_ui_manager_add_ui_from_file > i x *c *x
gtk_ui_manager_add_ui_from_file_utf8 > i x *c *x : win64 version
gtk_ui_manager_new > x

gtk_vbox_new > x x x
gtk_vseparator_new > x

: widget,title,parent,action,stock_cancel,response_cancel,stock_ok,response_ok,null
gtk_widget_add_accelerator > n x *c x i x x
gtk_widget_add_events > n x x
gtk_widget_create_pango_context > x x
gtk_widget_create_pango_layout > x x *c
gtk_widget_destroy > n x
gtk_widget_get_allocated_height > i x
gtk_widget_get_allocated_width > i x
gtk_widget_get_allocation > n x *i
gtk_widget_get_can_default > i x
gtk_widget_get_name > x x
gtk_widget_get_pango_context > x x
gtk_widget_get_parent > x x
gtk_widget_get_parent_window > x x
gtk_widget_get_sensitive > i x
gtk_widget_get_size_request > n x *i *i
gtk_widget_get_toplevel > x x
gtk_widget_get_window > x x
gtk_widget_grab_default > n x
gtk_widget_grab_focus > n x
gtk_widget_hide > i x
gtk_widget_hide > n x
gtk_widget_hide_all > n x
gtk_widget_is_ancestor > i x x
gtk_widget_is_toplevel > i x
gtk_widget_modify_base > n x i *c
gtk_widget_modify_font > n x x        : void view font_desc
gtk_widget_modify_text > n x i *c
gtk_widget_queue_draw > n x
gtk_widget_queue_draw_area > n x x x x x
gtk_widget_set_can_focus > n x i
gtk_widget_set_colormap > n x x
gtk_widget_set_double_buffered > n x i
gtk_widget_set_events > n x x
gtk_widget_set_name > n x *c
gtk_widget_set_sensitive > n x i
gtk_widget_set_size_request > n x x x
gtk_widget_set_tooltip_markup > n x *c
gtk_widget_set_tooltip_text > n x *c
gtk_widget_show > n x
gtk_widget_show_all > n x
gtk_widget_show_now > n x
gtk_widget_translate_coordinates > i x x i i *i *i

gtk_window_activate_focus > i x
gtk_window_add_accel_group > n x x
gtk_window_get_focus > x x
gtk_window_get_gravity > i x
gtk_window_get_position > n x *i *i
gtk_window_get_screen > x x
gtk_window_get_size > n x *i *i
gtk_window_get_title > x x
gtk_window_has_toplevel_focus > i x
gtk_window_is_active > i x
gtk_window_list_toplevels > x
gtk_window_maximize > n x
gtk_window_move > n x i i
gtk_window_new > x x
gtk_window_present > n x
gtk_window_present_with_time > n x i
gtk_window_resize > n x i i
gtk_window_set_decorated > n x i
gtk_window_set_default_size > n x x x : void window width height
gtk_window_set_destroy_with_parent > n x i
gtk_window_set_gravity > n x i
gtk_window_set_icon > n x x
gtk_window_set_icon_from_file > i x *c x
gtk_window_set_icon_from_file_utf8 > i x *c x : win64 version
gtk_window_set_keep_above > n x i
gtk_window_set_modal > n x x
gtk_window_set_position > n x x
gtk_window_set_resizable > n x i
gtk_window_set_title > n x *c         : void window title
gtk_window_set_transient_for > n x x
gtk_window_set_type_hint > n x i      : void window GdkWindowTypeHint

: printing
gtk_page_setup_copy > x x
gtk_page_setup_get_bottom_margin > d x i
gtk_page_setup_get_left_margin > d x i
gtk_page_setup_get_orientation > i x
gtk_page_setup_get_page_height > d x i
gtk_page_setup_get_page_width > d x i
gtk_page_setup_get_paper_height > d x i
gtk_page_setup_get_paper_size > x x
gtk_page_setup_get_paper_width > d x i
gtk_page_setup_get_right_margin > d x i
gtk_page_setup_get_top_margin > d x i
gtk_page_setup_load_file > i x *c x
gtk_page_setup_load_key_file > i x x *c x
gtk_page_setup_new > x
gtk_page_setup_new_from_file > x *c x
gtk_page_setup_new_from_key_file > x x *c x
gtk_page_setup_set_bottom_margin > n x d i
gtk_page_setup_set_left_margin > n x d i
gtk_page_setup_set_orientation > n x i
gtk_page_setup_set_paper_size > n x x
gtk_page_setup_set_paper_size_and_default_margins > n x x
gtk_page_setup_set_right_margin > n x d i
gtk_page_setup_set_top_margin > n x d i
gtk_page_setup_to_file > i x *c x
gtk_page_setup_to_key_file > n x x *c
gtk_paper_size_copy > x x
gtk_paper_size_free > n x
gtk_paper_size_get_default > x
gtk_paper_size_get_default_bottom_margin > d x i
gtk_paper_size_get_default_left_margin > d x i
gtk_paper_size_get_default_right_margin > d x i
gtk_paper_size_get_default_top_margin > d x i
gtk_paper_size_get_display_name > x x
gtk_paper_size_get_height > d x i
gtk_paper_size_get_name > x x
gtk_paper_size_get_paper_sizes > x i
gtk_paper_size_get_ppd_name > x x
gtk_paper_size_get_width > d x i
gtk_paper_size_is_custom > i x
gtk_paper_size_is_equal > i x x
gtk_paper_size_new > x *c
gtk_paper_size_new_custom > x *c *c d d i
gtk_paper_size_new_from_key_file > x x *c x
gtk_paper_size_new_from_ppd > x *c *c d d
gtk_paper_size_set_size > n x d d i
gtk_paper_size_to_key_file > n x x *c
gtk_print_context_create_pango_context > x x
gtk_print_context_create_pango_layout > x x
gtk_print_context_get_cairo_context > x x
gtk_print_context_get_dpi_x > d x
gtk_print_context_get_dpi_y > d x
gtk_print_context_get_hard_margins > i x *d *d *d *d
gtk_print_context_get_height > d x
gtk_print_context_get_page_setup > x x
gtk_print_context_get_pango_fontmap > x x
gtk_print_context_get_width > d x
gtk_print_context_set_cairo_context > n x x d d
gtk_print_error_quark > i
gtk_print_operation_cancel > n x
gtk_print_operation_draw_page_finish > n x
gtk_print_operation_get_default_page_setup > x x
gtk_print_operation_get_embed_page_setup > i x
gtk_print_operation_get_error > n x x
gtk_print_operation_get_has_selection > i x
gtk_print_operation_get_n_pages_to_print > i x
gtk_print_operation_get_print_settings > x x
gtk_print_operation_get_status > i x
gtk_print_operation_get_status_string > x x
gtk_print_operation_get_support_selection > i x
gtk_print_operation_is_finished > i x
gtk_print_operation_new > x
gtk_print_operation_preview_end_preview > n x
gtk_print_operation_preview_is_selected > i x i
gtk_print_operation_preview_render_page > n x i
gtk_print_operation_run > i x i x x
gtk_print_operation_set_allow_async > n x i
gtk_print_operation_set_current_page > n x i
gtk_print_operation_set_custom_tab_label > n x *c
gtk_print_operation_set_default_page_setup > n x x
gtk_print_operation_set_defer_drawing > n x
gtk_print_operation_set_embed_page_setup > n x i
gtk_print_operation_set_export_filename > n x *c
gtk_print_operation_set_has_selection > n x i
gtk_print_operation_set_job_name > n x *c
gtk_print_operation_set_n_pages > n x i
gtk_print_operation_set_print_settings > n x x
gtk_print_operation_set_show_progress > n x i
gtk_print_operation_set_support_selection > n x i
gtk_print_operation_set_track_print_status > n x i
gtk_print_operation_set_unit > n x i
gtk_print_operation_set_use_full_page > n x i
gtk_print_run_page_setup_dialog > x x x x
gtk_print_run_page_setup_dialog_async > n x x x x x
gtk_print_settings_copy > x x
gtk_print_settings_foreach > n x x x
gtk_print_settings_get > x x *c
gtk_print_settings_get_bool > i x *c
gtk_print_settings_get_collate > i x
gtk_print_settings_get_default_source > x x
gtk_print_settings_get_dither > x x
gtk_print_settings_get_double > d x *c
gtk_print_settings_get_double_with_default > d x *c d
gtk_print_settings_get_duplex > i x
gtk_print_settings_get_finishings > x x
gtk_print_settings_get_int > i x *c
gtk_print_settings_get_int_with_default > i x *c i
gtk_print_settings_get_length > d x *c i
gtk_print_settings_get_media_type > x x
gtk_print_settings_get_n_copies > i x
gtk_print_settings_get_number_up > i x
gtk_print_settings_get_number_up_layout > i x
gtk_print_settings_get_orientation > i x
gtk_print_settings_get_output_bin > x x
gtk_print_settings_get_page_ranges > x x *i
gtk_print_settings_get_page_set > i x
gtk_print_settings_get_paper_height > d x i
gtk_print_settings_get_paper_size > x x
gtk_print_settings_get_paper_width > d x i
gtk_print_settings_get_print_pages > i x
gtk_print_settings_get_printer > x x
gtk_print_settings_get_printer_lpi > d x
gtk_print_settings_get_quality > i x
gtk_print_settings_get_resolution > i x
gtk_print_settings_get_resolution_x > i x
gtk_print_settings_get_resolution_y > i x
gtk_print_settings_get_reverse > i x
gtk_print_settings_get_scale > d x
gtk_print_settings_get_use_color > i x
gtk_print_settings_has_key > i x *c
gtk_print_settings_load_file > i x *c x
gtk_print_settings_load_key_file > i x x *c x
gtk_print_settings_new > x
gtk_print_settings_new_from_file > x *c x
gtk_print_settings_new_from_key_file > x x *c x
gtk_print_settings_set > n x *c *c
gtk_print_settings_set_bool > n x *c i
gtk_print_settings_set_collate > n x i
gtk_print_settings_set_default_source > n x *c
gtk_print_settings_set_dither > n x *c
gtk_print_settings_set_double > n x *c d
gtk_print_settings_set_duplex > n x i
gtk_print_settings_set_finishings > n x *c
gtk_print_settings_set_int > n x *c i
gtk_print_settings_set_length > n x *c d i
gtk_print_settings_set_media_type > n x *c
gtk_print_settings_set_n_copies > n x i
gtk_print_settings_set_number_up > n x i
gtk_print_settings_set_number_up_layout > n x i
gtk_print_settings_set_orientation > n x i
gtk_print_settings_set_output_bin > n x *c
gtk_print_settings_set_page_ranges > n x x i
gtk_print_settings_set_page_set > n x i
gtk_print_settings_set_paper_height > n x d i
gtk_print_settings_set_paper_size > n x x
gtk_print_settings_set_paper_width > n x d i
gtk_print_settings_set_print_pages > n x i
gtk_print_settings_set_printer > n x *c
gtk_print_settings_set_printer_lpi > n x d
gtk_print_settings_set_quality > n x i
gtk_print_settings_set_resolution > n x i
gtk_print_settings_set_resolution_xy > n x i i
gtk_print_settings_set_reverse > n x i
gtk_print_settings_set_scale > n x d
gtk_print_settings_set_use_color > n x i
gtk_print_settings_to_file > i x *c x
gtk_print_settings_to_key_file > n x x *c
gtk_print_settings_unset > n x *c
: gtk_printer
gtk_printer_new > x *c x i
gtk_printer_get_backend > x x
gtk_printer_get_name > x x
gtk_printer_get_state_message > x x
gtk_printer_get_description > x x
gtk_printer_get_location > x x
gtk_printer_get_icon_name > x x
gtk_printer_get_job_count > i x
gtk_printer_is_active > i x
gtk_printer_is_paused > i x
gtk_printer_is_accepting_jobs > i x
gtk_printer_is_virtual > i x
gtk_printer_is_default > i x
gtk_printer_accepts_ps > i x
gtk_printer_accepts_pdf > i x
gtk_printer_list_papers > x x
gtk_printer_compare > i x x
gtk_printer_has_details > i x
gtk_printer_request_details > n x
gtk_printer_get_capabilities > i x
gtk_printer_get_default_page_size > x x
gtk_printer_get_hard_margins > i x *d *d *d *d
: gboolean (*GtkPrinterFunc) (GtkPrinter *printer, gpointer data);
gtk_enumerate_printers > n x x x i
)
libpixbuf cddef each <;._2 [ 0 : 0
gdk_pixbuf_add_alpha > x x i x x x : buf,use_substitute_color?,r,g,b
gdk_pixbuf_get_bits_per_sample > x x
gdk_pixbuf_get_has_alpha > x x
gdk_pixbuf_get_height > x x
gdk_pixbuf_get_n_channels > x x
gdk_pixbuf_get_pixels > x x
gdk_pixbuf_get_rowstride > x x
gdk_pixbuf_get_width > x x
gdk_pixbuf_new > x x x x x x : GDK_COLORSPACE_RGB,alpha,bits,w,h
gdk_pixbuf_new_from_data > x x x x x x x x x x : ad,cmap,alpha,bits,w,h,rowstride,destroyfn,fndata
gdk_pixbuf_new_from_file > x *c x : filename,errorloc
gdk_pixbuf_new_from_file_at_scale > x *c x x i x
gdk_pixbuf_new_from_file_at_scale_utf8 > x *c x x i x : win64 version
gdk_pixbuf_new_from_file_at_size > x *c x x x
gdk_pixbuf_new_from_file_at_size_utf8 > x *c x x x : win64 version
gdk_pixbuf_new_from_file_utf8 > x *c x : win64 version
gdk_pixbuf_new_subpixbuf > x x i i i i
gdk_pixbuf_save > i x *c *c x x
gdk_pixbuf_save_to_buffer > i x *x *x *c x x
gdk_pixbuf_save_to_buffer_2 > i x *x *x *c x *c *c x
gdk_pixbuf_save_utf8 > i x *c *c x x
)
libgobject cddef each <;._2 [ 0 : 0
g_object_get n x *c *x x : get int property - last arg 0 ends vararg
g_object_get_data > x x *c
g_object_set n x *c x x : set int property - last arg 0 ends vararg
g_object_set_data > n x *c x
g_object_ref > x x
g_object_unref > n x
g_signal_connect_data x x *c x x x x
g_type_init > n
g_type_check_instance_is_a > i x x
g_type_name > x x
g_value_init > x *x s
g_value_set_static_string > n * *
g_value_take_string > n x *c
g_object_ref_sink > x x
)
libpango cddef each <;._2 [ 0 : 0
pango_context_get_font_description > x x
pango_context_get_metrics > x x x x
pango_context_set_font_description > n x x
pango_context_set_matrix > n x *d
pango_create_layout > x x
pango_font_description_free > n x         : font_desc
pango_font_description_from_string > x *c : font_desc font_string
pango_font_description_get_size > i x
pango_font_description_set_size > n x i
pango_font_description_set_style > n x i
pango_font_description_set_weight > n x i : bold=700
pango_font_metrics_get_approximate_char_width > i x
pango_font_metrics_get_approximate_digit_width > i x
pango_font_metrics_get_ascent > i x
pango_font_metrics_get_descent > i x
pango_layout_context_changed > n x
pango_layout_get_context > x x
pango_layout_get_font_description > x x
pango_layout_get_pixel_extents > n x x *x
pango_layout_get_pixel_size n x *x *x
pango_layout_new > x x
pango_layout_set_attributes > n x x
pango_layout_set_font_description > n x x
pango_layout_set_spacing > n x x
pango_layout_set_text > n x *c x
pango_matrix_rotate > n *d d

:pango attribute
pango_attr_list_change > n x x
pango_attr_list_insert > n x x
pango_attr_list_new > x
pango_attr_list_unref > n x
pango_attr_underline_new > x i
pango_attribute_destroy > n x
)
libgtksourceview cddef each <;._2 [ 0 : 0
gtk_source_buffer_new > x x
gtk_source_buffer_new_with_language > x x
gtk_source_buffer_redo > n x
gtk_source_buffer_set_highlight_matching_brackets > n x i
gtk_source_buffer_set_highlight_syntax > n x i
gtk_source_buffer_set_language > n x x
gtk_source_buffer_set_style_scheme > n x x
gtk_source_buffer_undo > n x
gtk_source_buffer_begin_not_undoable_action > n x
gtk_source_buffer_end_not_undoable_action > n x
gtk_source_language_manager_get_default > x
gtk_source_language_manager_get_language > x x *c
gtk_source_language_manager_get_language_ids > x x
gtk_source_language_manager_get_search_path > x x
gtk_source_language_manager_guess_language > x x *c *x
gtk_source_language_manager_set_search_path > n x x
gtk_source_print_compositor_draw_page > n x x i
gtk_source_print_compositor_get_n_pages > i x
gtk_source_print_compositor_new > x x
gtk_source_print_compositor_new_from_view > x x
gtk_source_print_compositor_paginate > i x x
gtk_source_style_scheme_get_id > x x
gtk_source_style_scheme_manager_get_default > x
gtk_source_style_scheme_manager_get_scheme > x x *c
gtk_source_style_scheme_manager_get_scheme_ids > x x
gtk_source_style_scheme_manager_get_search_path > x x
gtk_source_style_scheme_manager_new > x
gtk_source_style_scheme_manager_set_search_path > n x x
gtk_source_view_get_show_line_numbers > i x
gtk_source_view_new > x
gtk_source_view_new_with_buffer > x x
gtk_source_view_set_auto_indent > n x i
gtk_source_view_set_highlight_current_line > n x i
gtk_source_view_set_show_line_numbers > n x i
gtk_source_view_set_tab_width > n x i
)
libcairo cddef each <;._2 [ 0 : 0
cairo_version > i
cairo_version_string > x
cairo_create > x x
cairo_reference > x x
cairo_destroy > n x
cairo_get_reference_count > i x
cairo_get_user_data > x x x
cairo_set_user_data > i x x * x
cairo_save > n x
cairo_restore > n x
cairo_push_group > n x
cairo_push_group_with_content > n x i
cairo_pop_group > x x
cairo_pop_group_to_source > n x
cairo_set_operator > n x i
cairo_set_source > n x x
cairo_set_source_rgb > n x d d d
cairo_set_source_rgba > n x d d d d
cairo_set_source_surface > n x x d d
cairo_set_tolerance > n x d
cairo_set_antialias > n x i
cairo_set_fill_rule > n x i
cairo_set_line_width > n x d
cairo_set_line_cap > n x i
cairo_set_line_join > n x i
cairo_set_dash > n x *d i d
cairo_set_miter_limit > n x d
cairo_translate > n x d d
cairo_scale > n x d d
cairo_rotate > n x d
cairo_transform > n x x
cairo_set_matrix > n x x
cairo_identity_matrix > n x
cairo_user_to_device > n x *d *d
cairo_user_to_device_distance > n x *d *d
cairo_device_to_user > n x *d *d
cairo_device_to_user_distance > n x *d *d
cairo_new_path > n x
cairo_move_to > n x d d
cairo_new_sub_path > n x
cairo_line_to > n x d d
cairo_curve_to > n x d d d d d d
cairo_arc > n x d d d d d
cairo_arc_negative > n x d d d d d
cairo_rel_move_to > n x d d
cairo_rel_line_to > n x d d
cairo_rel_curve_to > n x d d d d d d
cairo_rectangle > n x d d d d
cairo_close_path > n x
cairo_path_extents > n x *d *d *d *d
cairo_paint > n x
cairo_paint_with_alpha > n x d
cairo_mask > n x x
cairo_mask_surface > n x x d d
cairo_stroke > n x
cairo_stroke_preserve > n x
cairo_fill > n x
cairo_fill_preserve > n x
cairo_copy_page > n x
cairo_show_page > n x
cairo_in_stroke > i x d d
cairo_in_fill > i x d d
cairo_stroke_extents > n x *d *d *d *d
cairo_fill_extents > n x *d *d *d *d
cairo_reset_clip > n x
cairo_clip > n x
cairo_clip_preserve > n x
cairo_clip_extents > n x *d *d *d *d
cairo_copy_clip_rectangle_list > x x
cairo_rectangle_list_destroy > n x
cairo_glyph_allocate > x i
cairo_glyph_free > n x
cairo_text_cluster_allocate > x i
cairo_text_cluster_free > n x
cairo_font_options_create > x
cairo_font_options_copy > x x
cairo_font_options_destroy > n x
cairo_font_options_status > i x
cairo_font_options_merge > n x x
cairo_font_options_equal > i x x
cairo_font_options_hash > x x
cairo_font_options_set_antialias > n x i
cairo_font_options_get_antialias > i x
cairo_font_options_set_subpixel_order > n x i
cairo_font_options_get_subpixel_order > i x
cairo_font_options_set_hint_style > n x i
cairo_font_options_get_hint_style > i x
cairo_font_options_set_hint_metrics > n x i
cairo_font_options_get_hint_metrics > i x
cairo_select_font_face > n x *c i i
cairo_set_font_size > n x d
cairo_set_font_matrix > n x x
cairo_get_font_matrix > n x x
cairo_set_font_options > n x x
cairo_get_font_options > n x x
cairo_set_font_face > n x x
cairo_get_font_face > x x
cairo_set_scaled_font > n x x
cairo_get_scaled_font > x x
cairo_show_text > n x *c
cairo_show_glyphs > n x x i
cairo_show_text_glyphs > n x *c i x i x i i
cairo_text_path > n x *c
cairo_glyph_path > n x x i
cairo_text_extents > n x *c x
cairo_glyph_extents > n x x i x
cairo_font_extents > n x x
cairo_font_face_reference > x x
cairo_font_face_destroy > n x
cairo_font_face_get_reference_count > i x
cairo_font_face_status > i x
cairo_font_face_get_type > i x
cairo_font_face_get_user_data > x x x
cairo_font_face_set_user_data > i x x * x
cairo_scaled_font_create > x x x x x
cairo_scaled_font_reference > x x
cairo_scaled_font_destroy > n x
cairo_scaled_font_get_reference_count > i x
cairo_scaled_font_status > i x
cairo_scaled_font_get_type > i x
cairo_scaled_font_get_user_data > x x x
cairo_scaled_font_set_user_data > i x x * x
cairo_scaled_font_extents > n x x
cairo_scaled_font_text_extents > n x *c x
cairo_scaled_font_glyph_extents > n x x i x
cairo_scaled_font_text_to_glyphs > i x d d *c i *x i * *x i * x
cairo_scaled_font_get_font_face > x x
cairo_scaled_font_get_font_matrix > n x x
cairo_scaled_font_get_ctm > n x x
cairo_scaled_font_get_scale_matrix > n x x
cairo_scaled_font_get_font_options > n x x
cairo_toy_font_face_create > x *c i i
cairo_toy_font_face_get_family > x x
cairo_toy_font_face_get_slant > i x
cairo_toy_font_face_get_weight > i x
cairo_user_font_face_create > x
cairo_user_font_face_set_init_func > n x x
cairo_user_font_face_set_render_glyph_func > n x x
cairo_user_font_face_set_text_to_glyphs_func > n x x
cairo_user_font_face_set_unicode_to_glyph_func > n x x
cairo_user_font_face_get_init_func >x x
cairo_user_font_face_get_render_glyph_func >x x
cairo_user_font_face_get_text_to_glyphs_func >x x
cairo_user_font_face_get_unicode_to_glyph_func >x x
cairo_get_operator > i x
cairo_get_source > x x
cairo_get_tolerance > d x
cairo_get_antialias > i x
cairo_has_current_point > i x
cairo_get_current_point > n x *d *d
cairo_get_fill_rule > i x
cairo_get_line_width > d x
cairo_get_line_cap > i x
cairo_get_line_join > i x
cairo_get_miter_limit > d x
cairo_get_dash_count > i x
cairo_get_dash > n x *d *d
cairo_get_matrix > n x x
cairo_get_target > x x
cairo_get_group_target > x x
cairo_copy_path > x x
cairo_copy_path_flat > x x
cairo_append_path > n x x
cairo_path_destroy > n x
cairo_status > i x
cairo_status_to_string > x i
cairo_surface_create_similar > x x i i i
cairo_surface_reference > x x
cairo_surface_finish > n x
cairo_surface_destroy > n x
cairo_surface_get_reference_count > i x
cairo_surface_status > i x
cairo_surface_get_type > i x
cairo_surface_get_content > i x
cairo_surface_write_to_png > i x *c
cairo_surface_write_to_png_stream > i x x *
cairo_surface_get_user_data > x x x
cairo_surface_set_user_data > i x x * x
cairo_surface_get_font_options > n x x
cairo_surface_flush > n x
cairo_surface_mark_dirty > n x
cairo_surface_mark_dirty_rectangle > n x i i i i
cairo_surface_set_device_offset > n x d d
cairo_surface_get_device_offset > n x *d *d
cairo_surface_set_fallback_resolution > n x d d
cairo_surface_get_fallback_resolution > n x *d *d
cairo_surface_copy_page > n x
cairo_surface_show_page > n x
cairo_surface_has_show_text_glyphs > i x
cairo_image_surface_create > x i i i
cairo_format_stride_for_width > i i i
cairo_image_surface_create_for_data > x *c i i i i
cairo_image_surface_get_data > x x
cairo_image_surface_get_format > i x
cairo_image_surface_get_width > i x
cairo_image_surface_get_height > i x
cairo_image_surface_get_stride > i x
cairo_image_surface_create_from_png > x *c
cairo_image_surface_create_from_png_stream > x x *
cairo_pattern_create_rgb > x d d d
cairo_pattern_create_rgba > x d d d d
cairo_pattern_create_for_surface > x x
cairo_pattern_create_linear > x d d d d
cairo_pattern_create_radial > x d d d d d d
cairo_pattern_reference > x x
cairo_pattern_destroy > n x
cairo_pattern_get_reference_count > i x
cairo_pattern_status > i x
cairo_pattern_get_user_data > x x x
cairo_pattern_set_user_data > i x x * x
cairo_pattern_get_type > i x
cairo_pattern_add_color_stop_rgb > n x d d d d
cairo_pattern_add_color_stop_rgba > n x d d d d d
cairo_pattern_set_matrix > n x x
cairo_pattern_get_matrix > n x x
cairo_pattern_set_extend > n x i
cairo_pattern_get_extend > i x
cairo_pattern_set_filter > n x i
cairo_pattern_get_filter > i x
cairo_pattern_get_rgba > i x *d *d *d *d
cairo_pattern_get_surface > i x *x
cairo_pattern_get_color_stop_rgba > i x i *d *d *d *d *d
cairo_pattern_get_color_stop_count > i x i *
cairo_pattern_get_linear_points > i x *d *d *d *d
cairo_pattern_get_radial_circles > i x *d *d *d *d *d *d
cairo_matrix_init > n x d d d d d d
cairo_matrix_init_identity > n x
cairo_matrix_init_translate > n x d d
cairo_matrix_init_scale > n x d d
cairo_matrix_init_rotate > n x d
cairo_matrix_translate > n x d d
cairo_matrix_scale > n x d d
cairo_matrix_rotate > n x d
cairo_matrix_invert > i x
cairo_matrix_multiply > n x x x
cairo_matrix_transform_distance > n x *d *d
cairo_matrix_transform_point > n x *d *d
cairo_debug_reset_static_data > n
)
libpangocairo cddef each <;._2 [ 0 : 0
pango_cairo_font_map_get_type > x
pango_cairo_font_map_new > x
pango_cairo_font_map_new_for_font_type > x i
pango_cairo_font_map_get_default > x
pango_cairo_font_map_set_default > n x
pango_cairo_font_map_get_font_type > i x
pango_cairo_font_map_set_resolution > n x d
pango_cairo_font_map_get_resolution > d x
pango_cairo_font_map_create_context > x x
pango_cairo_font_get_type > x
pango_cairo_font_get_scaled_font > x x
pango_cairo_update_context > n x x
pango_cairo_context_set_font_options > n x x
pango_cairo_context_get_font_options > x x
pango_cairo_context_set_resolution > n x d
pango_cairo_context_get_resolution > d x
pango_cairo_context_set_shape_renderer > n x x x x
pango_cairo_context_get_shape_renderer > x x *x
pango_cairo_create_context > x x
pango_cairo_create_layout > x x
pango_cairo_update_context > n x x
pango_cairo_update_layout > n x x
pango_cairo_show_glyph_string > n x x x
pango_cairo_show_glyph_item > n x *c x
pango_cairo_show_layout_line > n x x
pango_cairo_show_layout > n x x
pango_cairo_show_error_underline > n x d d d d
pango_cairo_glyph_string_path > n x x x
pango_cairo_layout_line_path > n x x
pango_cairo_layout_path > n x x
pango_cairo_error_underline_path > n x d d d d
)
gdk_pixbuf_save_2=: ((>libpixbuf),' gdk_pixbuf_save >',(IFWIN#'+'),' i x *c *c x *c *c x')&(15!:0)
gdk_pixbuf_save_2_utf8=: ((>libpixbuf),' gdk_pixbuf_save_utf8 >',(IFWIN#'+'),' i x *c *c x *c *c x')&(15!:0)
3 : 0''
if. (2=GTKVER_j_) *. IFWIN *. IF64 do.
  gdk_pixbuf_animation_new_from_file=: gdk_pixbuf_animation_new_from_file_utf8
  gdk_pixbuf_new_from_file=: gdk_pixbuf_new_from_file_utf8
  gdk_pixbuf_new_from_file_at_scale=: gdk_pixbuf_new_from_file_at_scale_utf8
  gdk_pixbuf_new_from_file_at_size=: gdk_pixbuf_new_from_file_at_size_utf8
  gdk_pixbuf_save=: gdk_pixbuf_save_utf8
  gdk_pixbuf_save_2=: gdk_pixbuf_save_2_utf8
  gdk_pixbuf_savev=: gdk_pixbuf_savev_utf8
  gtk_accel_map_load=: gtk_accel_map_load_utf8
  gtk_accel_map_save=: gtk_accel_map_save_utf8
  gtk_file_chooser_add_shortcut_folder=: gtk_file_chooser_add_shortcut_folder_utf8
  gtk_file_chooser_get_current_folder=: gtk_file_chooser_get_current_folder_utf8
  gtk_file_chooser_get_filename=: gtk_file_chooser_get_filename_utf8
  gtk_file_chooser_get_filenames=: gtk_file_chooser_get_filenames_utf8
  gtk_file_chooser_get_preview_filename=: gtk_file_chooser_get_preview_filename_utf8
  gtk_file_chooser_list_shortcut_folders=: gtk_file_chooser_list_shortcut_folders_utf8
  gtk_file_chooser_remove_shortcut_folder=: gtk_file_chooser_remove_shortcut_folder_utf8
  gtk_file_chooser_select_filename=: gtk_file_chooser_select_filename_utf8
  gtk_file_chooser_set_current_folder=: gtk_file_chooser_set_current_folder_utf8
  gtk_file_chooser_set_filename=: gtk_file_chooser_set_filename_utf8
  gtk_file_chooser_unselect_filename=: gtk_file_chooser_unselect_filename_utf8
  gtk_file_selection_get_filename=: gtk_file_selection_get_filename_utf8
  gtk_file_selection_get_selections=: gtk_file_selection_get_selections_utf8
  gtk_file_selection_set_filename=: gtk_file_selection_set_filename_utf8
  gtk_icon_info_get_filename=: gtk_icon_info_get_filename_utf8
  gtk_icon_source_get_filename=: gtk_icon_source_get_filename_utf8
  gtk_icon_source_set_filename=: gtk_icon_source_set_filename_utf8
  gtk_icon_theme_append_search_path=: gtk_icon_theme_append_search_path_utf8
  gtk_icon_theme_get_search_path=: gtk_icon_theme_get_search_path_utf8
  gtk_icon_theme_prepend_search_path=: gtk_icon_theme_prepend_search_path_utf8
  gtk_icon_theme_set_search_path=: gtk_icon_theme_set_search_path_utf8
  gtk_image_new_from_file=: gtk_image_new_from_file_utf8
  gtk_image_set_from_file=: gtk_image_set_from_file_utf8
  gtk_rc_add_default_file=: gtk_rc_add_default_file_utf8
  gtk_rc_parse=: gtk_rc_parse_utf8
  gtk_rc_set_default_files=: gtk_rc_set_default_files_utf8
  gtk_ui_manager_add_ui_from_file=: gtk_ui_manager_add_ui_from_file_utf8
  gtk_window_set_default_icon_from_file=: gtk_window_set_default_icon_from_file_utf8
  gtk_window_set_icon_from_file=: gtk_window_set_icon_from_file_utf8
end.
''
)
getGdkEventConfigure_xywh=: 3 : '_2 ic memr y, GdkEventConfigure_xywh, 16, JCHAR'
getGdkEventExposewindow=: 3 : '{. memr y, GdkEventExpose_window, 1 ,JPTR'
getGdkEventKey=: 3 : '_2 ic memr y, GdkEventKey, 8 ,JCHAR'
getGdkEventMotion_xy=: 3 : 'memr y, GdkEventMotion_xy, 2, JFL'
getGtkAdjustment=: 3 : 'memr y, 0, 6, JFL'

getGtkStylefg_gc=: 3 : '{. memr y, GtkStyle_fg_gc, 5, JPTR'
getGtkStyleblack_gc=: 3 : '{. memr y, GtkStyle_black_gc, 1, JPTR'
getGtkStylewhite_gc=: 3 : '{. memr y, GtkStyle_white_gc, 1, JPTR'

getGtkWidgetWindow=: 3 : 0
if. 3=GTKVER_j_ do.
  gtk_widget_get_window_jgtk_ y
else.
  {. memr y, GtkWidget_window, 1, JPTR
end.
)

getGtkWidgetRequisition=: 3 : '_2 ic memr y, GtkWidget_requisition, 8, JCHAR'
getGtkWidgetAllocation=: 3 : 0
if. 3=GTKVER_j_ do.
  xy=. _2 ic memr y, GtkWidget_allocation, 8, JCHAR
  wh=. (gtk_widget_get_allocated_width y), gtk_widget_get_allocated_height y
  xy,wh
else.
  _2 ic memr y, GtkWidget_allocation, 16, JCHAR
end.
)

getGtkWidgetGeometry=: 3 : 0
if. 0= win=. getGtkWidgetWindow y do. 4$_1 return. end.
gdk_window_get_geometry win;(x=.,_1);(y=.,_1);(w=.,_1);(h=.,_1)
x,y,w,h
)

getGtkWidgetstyle=: 3 : '{. memr y, GtkWidget_style, 1, JPTR'
getGtkWidgetstate=: 3 : 'a.&i. {. memr y, GtkWidget_state, 1, JCHAR'

getdagc=: 3 :'getGtkStylefg_gc getGtkWidgetstyle y'
getsha1=: 3 : 'readstringfree g_compute_checksum_for_string 1;(,y);#y'

G_OBJECT_TYPE=: 3 : '{.memr 0 1 4,~ memr y,0 1 4'
helper_g_locale_to_utf8=: 3 : 's [ g_free p [ s=. memr 0 _1 2,~ p=. g_locale_to_utf8 y;_1;(<0);(<0);0'
helper_g_locale_from_utf8=: 3 : 's [ g_free p [ s=. memr 0 _1 2,~ p=. g_locale_from_utf8 y;_1;(<0);(<0);0'
getGtkToplevelWindows=: 3 : 0
z=. 0$0
if. 0~:list=. gtk_window_list_toplevels '' do.
  for_i. i. g_list_length list do.
    if. 'GtkWindow' -: memr 0 _1 2,~ g_type_name G_OBJECT_TYPE r=. g_list_nth_data list,i do.
      z=. z, g_list_nth_data list,i
    end.
  end.
  g_list_free list
end.
z
)
wdfit=: 0:
wdmove=: 3 : 0
'widget x y'=. y
'w h'=. _2{. getGtkWidgetAllocation widget
if. (_1=x) *. _1=y do.
  gtk_window_move widget, getscreenwh''-w,h
elseif. _1=x do.
  gtk_window_move widget,(w-~{.getscreenwh''), y
elseif. _1=y do.
  gtk_window_move widget,x,(h-~{:getscreenwh'')
elseif. do.
  gtk_window_move widget,x,y
end.
EMPTY
)
wdisparent=: 3 : 0
y=. ,>y
z=. 0$0
for_a. getGtkToplevelWindows'' do.
  if. 0~:r=. gtk_widget_get_name a do.
    if. 'GtkWindow' -: memr 0 _1 2,~ r do.
      if. 0~:s=. gtk_widget_get_name a do.
        if. y -: memr 0 _1 2,~ s do.
          z=. z, a
        end.
      end.
    end.
  end.
end.
if. 0=#z do. z=. 0 end.
z
)
gtk_gettypes=: 3 : 0
t=. [;._2 GTKTYPES
s=. > (<;._2 GTKTYPES) ,&.> <'_jgtk_'
0!:110 s ,"1 ' =: ''',"1 ((>libgtk),' ') ,"1 t ,"1 ' >',"1 (2*IFUNIX) }. ' + x''&(15!:0)'
t=. ((>libgtk),' ') ,"1 t ,"1 ' >',"1 (2*IFUNIX) }. ' + x'
t (15!:0 ::0:)"1 ''
EMPTY
)
GTKTYPES=: 0 : 0
gtk_about_dialog_get_type
gtk_accel_flags_get_type
gtk_accel_group_get_type
gtk_accel_label_get_type
gtk_accel_map_get_type
gtk_accessible_get_type
gtk_action_get_type
gtk_action_group_get_type
gtk_activatable_get_type
gtk_adjustment_get_type
gtk_alignment_get_type
gtk_anchor_type_get_type
gtk_arg_flags_get_type
gtk_arrow_get_type
gtk_arrow_placement_get_type
gtk_arrow_type_get_type
gtk_aspect_frame_get_type
gtk_assistant_get_type
gtk_assistant_page_type_get_type
gtk_attach_options_get_type
gtk_bin_get_type
gtk_border_get_type
gtk_box_get_type
gtk_buildable_get_type
gtk_builder_error_get_type
gtk_builder_get_type
gtk_button_action_get_type
gtk_button_box_get_type
gtk_button_box_style_get_type
gtk_button_get_type
gtk_buttons_type_get_type
gtk_calendar_display_options_get_type
gtk_calendar_get_type
gtk_cell_editable_get_type
gtk_cell_layout_get_type
gtk_cell_renderer_accel_get_type
gtk_cell_renderer_accel_mode_get_type
gtk_cell_renderer_combo_get_type
gtk_cell_renderer_get_type
gtk_cell_renderer_mode_get_type
gtk_cell_renderer_pixbuf_get_type
gtk_cell_renderer_progress_get_type
gtk_cell_renderer_spin_get_type
gtk_cell_renderer_spinner_get_type
gtk_cell_renderer_state_get_type
gtk_cell_renderer_text_get_type
gtk_cell_renderer_toggle_get_type
gtk_cell_type_get_type
gtk_cell_view_get_type
gtk_check_button_get_type
gtk_check_menu_item_get_type
gtk_clipboard_get_type
gtk_clist_drag_pos_get_type
gtk_color_button_get_type
gtk_color_selection_dialog_get_type
gtk_color_selection_get_type
gtk_combo_box_entry_get_type
gtk_combo_box_get_type
gtk_container_get_type
gtk_corner_type_get_type
gtk_ctree_expander_style_get_type
gtk_ctree_expansion_type_get_type
gtk_ctree_line_style_get_type
gtk_ctree_pos_get_type
gtk_curve_type_get_type
gtk_debug_flag_get_type
gtk_delete_type_get_type
gtk_dest_defaults_get_type
gtk_dialog_flags_get_type
gtk_dialog_get_type
gtk_direction_type_get_type
gtk_drag_result_get_type
gtk_drawing_area_get_type
gtk_editable_get_type
gtk_entry_buffer_get_type
gtk_entry_completion_get_type
gtk_entry_get_type
gtk_entry_icon_position_get_type
gtk_event_box_get_type
gtk_expander_get_type
gtk_expander_style_get_type
gtk_file_chooser_action_get_type
gtk_file_chooser_button_get_type
gtk_file_chooser_confirmation_get_type
gtk_file_chooser_dialog_get_type
gtk_file_chooser_error_get_type
gtk_file_chooser_get_type
gtk_file_chooser_widget_get_type
gtk_file_filter_flags_get_type
gtk_file_filter_get_type
gtk_fixed_get_type
gtk_font_button_get_type
gtk_font_selection_dialog_get_type
gtk_font_selection_get_type
gtk_frame_get_type
gtk_handle_box_get_type
gtk_hbox_get_type
gtk_hbutton_box_get_type
gtk_hpaned_get_type
gtk_hruler_get_type
gtk_hscale_get_type
gtk_hscrollbar_get_type
gtk_hseparator_get_type
gtk_hsv_get_type
gtk_icon_factory_get_type
gtk_icon_info_get_type
gtk_icon_lookup_flags_get_type
gtk_icon_set_get_type
gtk_icon_size_get_type
gtk_icon_source_get_type
gtk_icon_theme_error_get_type
gtk_icon_theme_get_type
gtk_icon_view_drop_position_get_type
gtk_icon_view_get_type
gtk_identifier_get_type
gtk_im_context_get_type
gtk_im_context_simple_get_type
gtk_im_multicontext_get_type
gtk_im_preedit_style_get_type
gtk_im_status_style_get_type
gtk_image_get_type
gtk_image_menu_item_get_type
gtk_image_type_get_type
gtk_info_bar_get_type
gtk_invisible_get_type
gtk_item_get_type
gtk_justification_get_type
gtk_label_get_type
gtk_layout_get_type
gtk_link_button_get_type
gtk_list_store_get_type
gtk_match_type_get_type
gtk_menu_bar_get_type
gtk_menu_direction_type_get_type
gtk_menu_get_type
gtk_menu_item_get_type
gtk_menu_shell_get_type
gtk_menu_tool_button_get_type
gtk_message_dialog_get_type
gtk_message_type_get_type
gtk_metric_type_get_type
gtk_misc_get_type
gtk_mount_operation_get_type
gtk_movement_step_get_type
gtk_notebook_get_type
gtk_notebook_tab_get_type
gtk_number_up_layout_get_type
gtk_object_flags_get_type
gtk_object_get_type
gtk_offscreen_window_get_type
gtk_orientable_get_type
gtk_orientation_get_type
gtk_pack_direction_get_type
gtk_pack_type_get_type
gtk_page_orientation_get_type
gtk_page_set_get_type
gtk_page_setup_get_type
gtk_paned_get_type
gtk_paper_size_get_type
gtk_path_priority_type_get_type
gtk_path_type_get_type
gtk_plug_get_type
gtk_policy_type_get_type
gtk_position_type_get_type
gtk_preview_type_get_type
gtk_print_context_get_type
gtk_print_duplex_get_type
gtk_print_error_get_type
gtk_print_operation_action_get_type
gtk_print_operation_get_type
gtk_print_operation_preview_get_type
gtk_print_operation_result_get_type
gtk_print_pages_get_type
gtk_print_quality_get_type
gtk_print_settings_get_type
gtk_print_status_get_type
gtk_private_flags_get_type
gtk_progress_bar_get_type
gtk_progress_bar_orientation_get_type
gtk_progress_bar_style_get_type
gtk_radio_action_get_type
gtk_radio_button_get_type
gtk_radio_menu_item_get_type
gtk_radio_tool_button_get_type
gtk_range_get_type
gtk_rc_flags_get_type
gtk_rc_style_get_type
gtk_rc_token_type_get_type
gtk_recent_action_get_type
gtk_recent_chooser_dialog_get_type
gtk_recent_chooser_error_get_type
gtk_recent_chooser_get_type
gtk_recent_chooser_menu_get_type
gtk_recent_chooser_widget_get_type
gtk_recent_filter_flags_get_type
gtk_recent_filter_get_type
gtk_recent_info_get_type
gtk_recent_manager_error_get_type
gtk_recent_manager_get_type
gtk_recent_sort_type_get_type
gtk_relief_style_get_type
gtk_requisition_get_type
gtk_resize_mode_get_type
gtk_response_type_get_type
gtk_ruler_get_type
gtk_scale_button_get_type
gtk_scale_get_type
gtk_scroll_step_get_type
gtk_scroll_type_get_type
gtk_scrollbar_get_type
gtk_scrolled_window_get_type
gtk_selection_data_get_type
gtk_selection_mode_get_type
gtk_sensitivity_type_get_type
gtk_separator_get_type
gtk_separator_menu_item_get_type
gtk_separator_tool_item_get_type
gtk_settings_get_type
gtk_shadow_type_get_type
gtk_side_type_get_type
gtk_signal_run_type_get_type
gtk_size_group_get_type
gtk_size_group_mode_get_type
gtk_socket_get_type
gtk_sort_type_get_type
gtk_spin_button_get_type
gtk_spin_button_update_policy_get_type
gtk_spin_type_get_type
gtk_spinner_get_type
gtk_state_type_get_type
gtk_status_icon_get_type
gtk_statusbar_get_type
gtk_style_get_type
gtk_submenu_direction_get_type
gtk_submenu_placement_get_type
gtk_table_get_type
gtk_target_flags_get_type
gtk_target_list_get_type
gtk_tearoff_menu_item_get_type
gtk_text_attributes_get_type
gtk_text_buffer_get_type
gtk_text_buffer_target_info_get_type
gtk_text_child_anchor_get_type
gtk_text_direction_get_type
gtk_text_iter_get_type
gtk_text_mark_get_type
gtk_text_search_flags_get_type
gtk_text_tag_get_type
gtk_text_tag_table_get_type
gtk_text_view_get_type
gtk_text_window_type_get_type
gtk_toggle_action_get_type
gtk_toggle_button_get_type
gtk_toggle_tool_button_get_type
gtk_tool_button_get_type
gtk_tool_item_get_type
gtk_tool_item_group_get_type
gtk_tool_palette_drag_targets_get_type
gtk_tool_palette_get_type
gtk_tool_shell_get_type
gtk_toolbar_child_type_get_type
gtk_toolbar_get_type
gtk_toolbar_space_style_get_type
gtk_toolbar_style_get_type
gtk_tooltip_get_type
gtk_tree_drag_dest_get_type
gtk_tree_drag_source_get_type
gtk_tree_iter_get_type
gtk_tree_model_filter_get_type
gtk_tree_model_flags_get_type
gtk_tree_model_get_type
gtk_tree_model_sort_get_type
gtk_tree_path_get_type
gtk_tree_row_reference_get_type
gtk_tree_selection_get_type
gtk_tree_sortable_get_type
gtk_tree_store_get_type
gtk_tree_view_column_get_type
gtk_tree_view_column_sizing_get_type
gtk_tree_view_drop_position_get_type
gtk_tree_view_get_type
gtk_tree_view_grid_lines_get_type
gtk_tree_view_mode_get_type
gtk_ui_manager_get_type
gtk_ui_manager_item_type_get_type
gtk_unit_get_type
gtk_update_type_get_type
gtk_vbox_get_type
gtk_vbutton_box_get_type
gtk_viewport_get_type
gtk_visibility_get_type
gtk_volume_button_get_type
gtk_vpaned_get_type
gtk_vruler_get_type
gtk_vscale_get_type
gtk_vscrollbar_get_type
gtk_vseparator_get_type
gtk_widget_flags_get_type
gtk_widget_get_type
gtk_widget_help_type_get_type
gtk_window_get_type
gtk_window_group_get_type
gtk_window_position_get_type
gtk_window_type_get_type
gtk_wrap_mode_get_type
)
3 : 0''
if. 0~: 4!:0 <'gtkInitDone_jgtk_' do.
  gtkInitDone_jgtk_=: 0
end.
''
)
3 : 0''
if. 0~: 4!:0 <'gtkMainLoop_jgtk_' do.
  gtkMainLoop_jgtk_=: 0
end.
''
)
ifMatchBrackets=: 0
DefCmt=: 'NB. '
DefLang=: 'j'
ValExt=: ;: 'ijs'

Debug=: 0

IFSV=: 1
GtkSetEnv=: 0
RGBSEQ_j_=: 1
f=. [: 15!:13 (IFWIN#'+') , ' x' $~ +:
cb1=: f 2
cb2=: f 3
cb3=: f 4
cb4=: f 5
cb5=: f 6
cb6=: f 7
cb7=: f 8
cb8=: f 9
cbuserdata=: 4 : 0
assert. x>1
cb=. (x-2){cb2,cb3,cb4,cb5,cb6,cb7,cb8
'handler locale'=. 2{.boxxopen y
if. 0=#locale do. locale=. >coname'' else. locale=. ,>locale end.
h=. cbreg handler,'_',locale,'_'
cb,h
)
consigs=: 4 : 0
'widget signal handler locale'=. 4{.y
if. 0=#locale do. locale=. >coname'' else. locale=. ,>locale end.
h=. cbreg handler,'_',locale,'_'
g_signal_connect_data widget;signal;x;h;0;0
)

consig=: cb2 & consigs
consig3=: cb3 & consigs
consig4=: cb4 & consigs
consig5=: cb5 & consigs
consig6=: cb6 & consigs
consig7=: cb7 & consigs
consig8=: cb8 & consigs
cbreg=: 3 : 0
i=. cbregs_jgtk_ i. <y
if. i<#cbregs_jgtk_ do. i return. end.
i=. cbregs_jgtk_ i. a:
if. i=#cbregs_jgtk_ do.
  cbregs_jgtk_=: cbregs_jgtk_,<y
else.
  cbregs_jgtk_=: (<y) i} cbregs_jgtk_
end.
i
)
cdcallback=: 3 : 0
q=. {:w=. 15!:17''
z=. 0
if. q>:#cbregs_jgtk_ do.
  z [ smoutput 'callback invalid pointer: ',":w return.
end.
h=. >q{cbregs_jgtk_
if. 3~:4!:0 <h do.
  z [ smoutput 'callback undefined handler: ',h return.
end.
try.
  z=. h~w
catchd.
  z [ smoutput 'callback run error: ',h,LF,13!:12''
end.
z
)
cbfree=: 3 : 0
if. 0=#y do. l=. coname'' else. l=. boxxopen y end.
for_n. l do.
  t=. (-2+#>n){.each cbregs_jgtk_
  a=. <'_',~,'_',>n
  cbregs_jgtk_=: a: ((a=t)#i.#t)} cbregs_jgtk_
end.
EMPTY
)
newiterend=: 3 : 0
i[gtk_text_buffer_get_end_iter y;i=. i.ITERSIZE
)
newitercursor=: 3 : 0
i[gtk_text_buffer_get_iter_at_mark y;(i=. i.ITERSIZE);gtk_text_buffer_get_insert y
)
newiterline=: 3 : 0
i[gtk_text_buffer_get_iter_at_line ({.y);(i=. i.ITERSIZE);{:y
)
newiterlastline=: 3 : 0
newiterline y,gtk_text_buffer_get_line_count y
)
newiterpos=: 3 : 0
i[gtk_text_buffer_get_iter_at_offset ({.y);(i=. i.ITERSIZE);{:y
)
newiterselectionbound=: 3 : 0
i[gtk_text_buffer_get_iter_at_mark y;(i=. i.ITERSIZE);gtk_text_buffer_get_selection_bound y
)
newiterstart=: 3 : 0
i[gtk_text_buffer_get_start_iter y;i=. i.ITERSIZE
)
gtkinit=: 3 : 0
if. gtkInitDone_jgtk_ do. i.0 0 return. end.
if. UNAME-:'Linux' do.
  if. ((2=GTKVER_j_) +. ((3=GTKVER_j_) *. 'broadway' -.@-: 2!:5 'GDK_BACKEND')) *. 0 -: 2!:5 'DISPLAY' do. 13!:8[3 end.
end.
try.
  checkpoint=. 'gtksetenv'
  gtksetenv''
  checkpoint=. 'g_type_init'
  g_type_init''
  checkpoint=. 'g_thread_init'
  if. UNAME-:'Darwin' do.
    if. 1 e. 'libgtk-x11-2.0.0.dylib' E. >libgtk do.
      g_thread_init ::0: 0
    else.
      g_thread_init 0
    end.
  else.
    g_thread_init 0
  end.
  checkpoint=. 'gtk_init'
  gtk_init (,0);0
  checkpoint=. 'setlocale'
  if. UNAME-:'Linux' do.
    Lc_Numeric_jgtk_=: memr 0 _1 2,~ 'libc.so.6 setlocale > x i *c'&cd 1;<<0
    'libc.so.6 setlocale > x i *c'&cd 1;,'C'
  elseif. UNAME-:'Darwin' do.
    Lc_Numeric_jgtk_=: memr 0 _1 2,~ 'libc.dylib setlocale > x i *c'&cd 4;<<0
    'libc.dylib setlocale > x i *c'&cd 4;,'C'
  elseif. UNAME-:'Win' do.
    Lc_Numeric_jgtk_=: memr 0 _1 2,~ 'msvcrt.dll setlocale > + x i *c'&cd 4;<<0
    'msvcrt.dll setlocale > + x i *c'&cd 4;,'C'
  end.
catch.
  erm=. 13!:12'' [ ern=. 13!:11''
  cderr=. cder''
  select. UNAME
  case. 'Win' do. smoutput win_init_failed
  case. 'Linux' do. smoutput linux_init_failed
  case. 'Darwin' do. smoutput mac_init_failed
  end.
  smoutput 'last cder'''': ', ":cderr
  smoutput 'last check point: ', checkpoint
  erm 13!:8 ern
end.
gtk_gettypes''
cbregs_jgtk_=: 'bad0';'bad1'
gtkInitDone_jgtk_=: 1
IFBROADWAY_z_=: (3=GTKVER_j_) *. 'broadway' -: 2!:5 'GDK_BACKEND'
i.0 0
)
gtksetenv=: 3 : 0
if. UNAME-:'Darwin' do.
  1!:44 jpath '~install'
  f=. 'libc.dylib setenv x *c *c x'&cd
  p=. jpath '~install/gtk'
  f 'XDG_CONFIG_DIRS';(p,'/etc/xdg');1
  f 'XDG_DATA_DIRS';(p,'/share');1
  f 'GTK_DATA_PREFIX';p;1
  f 'GTK_EXE_PREFIX';p;1
  f 'GTK_PATH';p;1
  f 'GTK2_RC_FILES';(p,'/etc/gtk-2.0/gtkrc');1
  f 'GDK_PIXBUF_MODULE_FILE';(p,'/etc/gtk-2.0/gdk-pixbuf.loaders');1
elseif. UNAME-:'Win' do.
  p=. jpath '~install/gtk'
  gtksetenv_win 'XDG_CONFIG_DIRS'; p,'/etc/xdg'
  gtksetenv_win 'XDG_DATA_DIRS'; p,'/share'
  gtksetenv_win 'GTK_DATA_PREFIX'; p
  gtksetenv_win 'GTK_EXE_PREFIX'; p
  gtksetenv_win 'GTK_PATH'; p
  gtksetenv_win 'GTK2_RC_FILES'; p,'/etc/gtk-2.0/gtkrc'
  gtksetenv_win 'GTK_IM_MODULE_FILE'; p,'/etc/gtk-2.0/gtk.immodules'
  gtksetenv_win 'GDK_PIXBUF_MODULE_FILE'; p,'/etc/gtk-2.0/gdk-pixbuf.loaders'
  if. GtkSetEnv do.
    HWND_BROADCAST=. _1 [ WM_SETTINGCHANGE=. 26 [ SMTO_ABORTIFHUNG=. 2
    'user32 SendMessageTimeoutA > i x i i *c i i *i'&cd HWND_BROADCAST; WM_SETTINGCHANGE; 0; 'Environment'; SMTO_ABORTIFHUNG; 5000; , _1
  end.
end.
)
gtksetenv_win=: 3 : 0
'value data'=. y

f=. '\'&(('/' I.@:= ])})
value=. uucp ,value
data=. uucp f ,data
'kernel32 SetEnvironmentVariableW > i *w *w'&cd value;data

if. 0=GtkSetEnv do. 0 return. end.

REG_SUCCESS=. 0
REG_ERROR=. _1
REG_SZ=. 1
HKEYCURRENTUSER=. _2147483647
HKEYLOCALMACHINE=. _2147483646
RegCreateKey=. 'advapi32 RegCreateKeyW i x *w *x'&cd
RegCloseKey=. 'advapi32 RegCloseKey i x'&cd
RegSetValueExC=. 'advapi32 RegSetValueExW i x *w i i *w i'&cd

hkey=. HKEYLOCALMACHINE
while. 1 do.
  rc=. REG_SUCCESS
  openkey=. ''
  key=. 'System';'CurrentControlSet';'Control';'Session Manager';'Environment'
  while. #key do.
    subkey=. uucp 0{::key
    key=. }.key
    'a b c d'=. RegCreateKey hkey ; subkey ; (, _1)
    if. REG_SUCCESS= rc=. a do.
      openkey=. openkey, hkey=. {. d
    else.
      break.
    end.
  end.
  if. REG_SUCCESS=rc do.
    rc=. 0{:: RegSetValueExC hkey ; value ; 0 ; REG_SZ ; data ; +: >: #data
  end.
  while. #openkey do.
    RegCloseKey <_1{openkey
    openkey=. }: openkey
  end.
  if. REG_SUCCESS=rc do. rc return. end.
  if. hkey= HKEYLOCALMACHINE do.
    hkey=. HKEYCURRENTUSER
  else.
    rc return.
  end.
end.
)
gtkgetenvmac=: 3 : 0
a=. ' XDG_CONFIG_DIRS XDG_DATA_DIRS GTK_DATA_PREFIX GTK_EXE_PREFIX GTK_PATH'
a=. <;._1 a,' GTK2_RC_FILES GTK_IM_MODULE_FILE GDK_PIXBUF_MODULE_FILE'
e=. ('"' -.~ getenv) each a
a,.e,.dir each e
)
win_init_failed=: 0 : 0

GTK init failed.

GTK libs are in J install folder: ',jpath'~install/gtk
If J install is damaged, a re-install may fix the problem.
)
linux_init_failed=: 0 : 0

GTK init failed: libraries not installed or not found.

Find path to gtk folder with shell command:
...> find / -name libgtk-x11-2.0.so 2> /dev/null

If not found, you need to install GTK
 (binaries probably available from your Linux provider).

If found, the path is not in your library search.
Best solution is to add it to your /etc/ld.so.conf file.
 (you must run /sbin/ldconfig after changes to that file)

If you don't want to change ld.so.conf, edit jgtkide
 (~install/bin/jgtkide) to have the export after #!/bin/sh:

export LD_LIBRARY_PATH="path to the libgtk-x11-2.0.so file"
)
mac_init_failed=: win_init_failed
defaultsearchpath=: 3 : 0
if. IF64*.IFWIN do.
  jpath each '~config';'~addons/gui/gtk/config'
else.
  jpath each '~config';'~addons/gui/gtk/config';'~install/gtk/share/gtksourceview-2.0/language-specs'
end.
)
initsearchpath=: 3 : 0
if. -.IFSV do. return. end.

path=. toHOST each defaultsearchpath''

try.
  lm=. gtk_source_language_manager_get_default ''
catch.
  IFSV_jgtk_=: 0 return.
end.

ss=. getlist gtk_source_language_manager_get_search_path lm
if. *./ path e. toHOST each ss do. return. end.
ss=. ~. path,ss
sp=. setlist (direxist &> ss) # ss
gtk_source_language_manager_set_search_path lm,sp

sm=. gtk_source_style_scheme_manager_get_default''
ss=. getlist gtk_source_style_scheme_manager_get_search_path sm
ss=. ~. ss,|.path
sp=. setlist (direxist &> ss) # ss
gtk_source_style_scheme_manager_set_search_path sm,sp

)
newalign=: 3 : 0
gtk_alignment_new y
:
r=. gtk_alignment_new y
gtk_container_add r,x
r
)
newpad=: 3 : 0
r=. gtk_alignment_new 0 0 1 1
gtk_widget_set_size_request r,y
r
)
newxpad=: 3 : 0
p=. newpad }.y
gtk_box_pack_start ({.y),p,0 0 0
p
)
newbutton=: 3 : 0
'label handler'=. y
button=. gtk_button_new_with_mnemonic <label
consig button;'clicked';handler
button
)
newxbutton=: 3 : 0
button=. newbutton }.y
gtk_box_pack_start ({.y),button;0;0;0
button
)
newstocktextbutton=: 3 : 0
'stock text handler'=. y
image=. gtk_image_new_from_stock stock;GTK_ICON_SIZE_BUTTON
button=. gtk_button_new''
consig button;'clicked';handler
hb=. gtk_hbox_new 0 2
label=. gtk_label_new_with_mnemonic <text
gtk_box_pack_start hb,image,0 0 0
gtk_box_pack_start hb,label,0 0 0
align=. gtk_alignment_new 0.5 0.5 0 0
gtk_container_add align,hb
gtk_container_add button,align
gtk_widget_show_all align
button
)
newstockbutton=: 3 : 0
'stock handler'=. y
button=. gtk_button_new''
image=. gtk_image_new_from_stock stock;GTK_ICON_SIZE_BUTTON
gtk_container_add button,image
consig button;'clicked';handler
button
)
newcheckbox=: 3 : 0
'label handler'=. y
cb=. gtk_check_button_new_with_mnemonic <label
consig cb;'clicked';handler
cb
)

readcheckbox=: gtk_toggle_button_get_active
setcheckbox=: gtk_toggle_button_set_active
clipread=: 3 : 0
cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
readstring gtk_clipboard_wait_for_text cb
)
clipwrite=: 3 : 0
txt=. y
if. L. txt do.
  txt=. }. ; LF&, @ , @ ": each txt
else.
  txt=. ": txt
  if. 1 < #$txt do. txt=. }. , LF ,"1 txt end.
end.
len=. #txt
cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
gtk_clipboard_set_text cb;txt;len
gtk_clipboard_store cb
len
)
clipread_z_=: clipread_jgtk_
clipwrite_z_=: clipwrite_jgtk_
newcombo=: 3 : 0
'text handler select hasentry'=. 4 {. boxopen y
store=. gtk_list_store_new_1 1,G_TYPE_STRING
if. 0=#hasentry do. hasentry=. 1 end.
if. 3=GTKVER_j_ do.
  if. hasentry do.
    cb=. gtk_combo_box_new_with_model_and_entry store
    gtk_combo_box_set_entry_text_column cb,0
  else.
    cb=. gtk_combo_box_text_new''
    gtk_combo_box_set_model cb,store
  end.
else.
  if. hasentry do.
    cb=. gtk_combo_box_entry_new_with_model store,0
    gtk_combo_box_entry_set_text_column cb,0
  else.
    cb=. gtk_combo_box_new_text''
    gtk_combo_box_set_model cb,store
  end.
end.
g_object_unref store
setcombo_text cb;<text
if. #select do.
  setcombo_select cb;select
end.
if. #handler do.
  consig cb;'changed';handler
end.
cb
)
newcombotext=: 3 : 0
'text handler select'=. 3 {. boxopen y
newcombo text;handler;select;0
)
readcombo=: 3 : 0
if. 3=GTKVER_j_ do.
  if. gtk_combo_box_get_has_entry y do.
    getentry gtk_bin_get_child y
  else.
    readstringfree gtk_combo_box_text_get_active_text y
  end.
else.
  readstringfree gtk_combo_box_get_active_text y
end.
)
getcombo=: 3 : 0
store=. gtk_combo_box_get_model y
rows=. gtk_tree_model_iter_n_children store;<<0
iter=. i.ITERSIZE
res=. 0$a:
col=. 0
for_row. i.rows do.
  gtk_tree_model_get_iter_from_string store;iter;":row
  val=. ,_1
  gtk_tree_model_get_1 store;iter;col;val;_1
  res=. res,<readstringfree val
end.
)
appendcombo=: 3 : 0
'cb text'=. 2 {. y
store=. gtk_combo_box_get_model cb
iter=. i.ITERSIZE
gtk_list_store_append store;iter
gtk_list_store_set_1 store;iter;0;text;_1
)
insertcombo=: 3 : 0
'cb text pos'=. 3 {. y
store=. gtk_combo_box_get_model cb
iter=. i.ITERSIZE
gtk_list_store_insert store;iter;pos
gtk_list_store_set_1 store;iter;0;text;_1
)
deletecombo=: 3 : 0
'cb pos'=. 2 {. y
store=. gtk_combo_box_get_model cb
iter=. i.ITERSIZE
gtk_tree_model_get_iter_from_string store;iter;":pos
gtk_list_store_remove store;iter
)
setcombo_text=: 3 : 0
'cb text'=. 2 {. y
store=. gtk_combo_box_get_model cb
setstore store;<text
)
setcombotext=: setcombo_text
setcombo_select=: gtk_combo_box_set_active
getentry=: 3 : 'memr (gtk_entry_get_text y),0,_1'
setentry=: gtk_entry_set_text
setentryposition=: gtk_editable_set_position
setentryselection=: gtk_editable_select_region
newentry=: 3 : 0
'text handler'=. y
entry=. gtk_entry_new''
setfont entry;FONT
setentry entry;text
consig entry;'activate';handler
entry
)
sv_button_press=: 3 : 0
'w e p'=. y
k=. {. _2 ic memr e,0 4
state=. {. _2 ic memr e,GdkEventButton_state,4
cs=. 0 2 { 2 2 2 #: state
select. k
case. GDK_BUTTON_PRESS do.
  sv_click cs
case. GDK_2BUTTON_PRESS do.
  sv_double_click cs
case. do.
  0
end.
)
sv_click=: 0:
sv_double_click=: 0:
newexpander=: 3 : 0
'label child'=. y
ex=. gtk_expander_new_with_mnemonic <label
gtk_container_add ex,child
ex
)


browsebox=: 3 : 0
'entry stock handler'=. y
hb=. gtk_hbox_new 0 6
vb=. gtk_vbox_new 0 0
gtk_box_pack_start vb,entry,1 0 0
btn=. newstockbutton stock;handler
gtk_box_pack_end hb,btn,0 0 0
gtk_box_pack_end hb, vb,1 1 0
hb,btn
)
filechooser=: 3 : 0
window filechooser y
:
'type title pattern path'=. y
window=. x
r=. ''
action=. type{0 1 1 2
stock=. type{GTK_STOCK_OPEN;GTK_STOCK_OK;GTK_STOCK_SAVE;GTK_STOCK_OK
j=. GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL;stock,GTK_RESPONSE_ACCEPT;0
w=. gtk_file_chooser_dialog_new title;window;action;j
if. isdir path do.
  gtk_file_chooser_set_current_folder w;path
else.
  gtk_file_chooser_set_current_folder w;}:0 pick fpathname path
  gtk_file_chooser_set_current_name w;1{fpathname path
end.
for_p. pattern do.
  addpattern w;>p
end.
if. GTK_RESPONSE_ACCEPT = gtk_dialog_run w do.
  r=. jpathsep readstringfree gtk_file_chooser_get_filename w
end.
gtk_widget_destroy w
r
)
fontdialog=: 3 : 0
'title font'=. y
dialog=. gtk_font_selection_dialog_new <title
gtk_font_selection_dialog_set_font_name dialog;font
r=. ''
if. GTK_RESPONSE_OK=gtk_dialog_run dialog do.
  r=. readstringfree gtk_font_selection_dialog_get_font_name dialog
end.
gtk_widget_destroy dialog
r
)
newframe=: 3 : 0
'label shadow'=. 2 {. boxopen y
fm=. gtk_frame_new<''
if. #label do.
  gtk_frame_set_label fm;label
end.
if. #shadow do.
  gtk_frame_set_shadow_type fm,shadow
end.
fm
)

NB, label
newlabel=: 3 : 0
r=. gtk_label_new_with_mnemonic  <,y
gtk_misc_set_alignment r,0 0.5
r
)
newlabelj=: 3 : 0
r=. newlabel y
gtk_label_set_justify r,3
r
)
newlabelr=: 3 : 0
r=. gtk_label_new_with_mnemonic  <,y
gtk_misc_set_alignment r,1 0.5
r
)

setlabel=: gtk_label_set_text_with_mnemonic
makelistbox=: 3 : 0
'id nms sel top flag'=. y
tv=. gtk_tree_view_new''
store=. gtk_list_store_new_1 1,G_TYPE_STRING
setstore store;<nms
gtk_tree_view_set_model tv,store
gtk_tree_view_set_headers_visible tv,0
consig tv;'cursor_changed';id,'_cursor_changed'
consig3 tv;'key-press-event';id,'_key_press'
consig4 tv;'row-activated';id,'_row_activated'
renderer=. gtk_cell_renderer_text_new''
gtk_tree_view_insert_column_with_attributes tv;_1;'input';renderer;'text';0;<<0
listbox_scroll tv,top
listbox_select tv,sel
if. flag AND 1 do.
  gtk_tree_view_set_rules_hint tv,1
end.
tv
)
setlistbox=: 3 : 0
'tv nms'=. 2 {. y
store=. gtk_tree_view_get_model tv
setstore store;<nms
if. 2 < #y do.
  'sel top'=. 2 {. 2 }. y
  listbox_select tv,sel
  listbox_scroll tv,top
end.
)
listbox_getactiverow=: 3 : 0
c=. mema IF64{4 8
d=. mema IF64{4 8
gtk_tree_view_get_cursor y;c;d
p=. {. memr c,0 1 4
if. p=0 do. _1 return. end.
r=. 0 pick gtk_tree_path_get_indices <<p
row=. {. _2 ic memr r,0 4
gtk_tree_path_free p
memf c
memf d
row
)
listbox_getscroll=: 3 : 0
c=. mema IF64{4 8
d=. mema IF64{4 8
gtk_tree_view_get_visible_range y;c;d
p=. {. memr c,0 1 4
r=. 0 pick gtk_tree_path_get_indices <<p
row=. {. _2 ic memr r,0 4
gtk_tree_path_free p
memf c
memf d
row
)
listbox_row_activated=: 3 : 0
'w p c d'=. y
r=. 0 pick gtk_tree_path_get_indices <<p
row=. {. _2 ic memr r,0 4
)
listbox_select=: 3 : 0
'tv sel'=. 2{.y,_1
if. 0>sel do.
  gtk_tree_selection_unselect_all gtk_tree_view_get_selection tv return.
end.
p=. gtk_tree_path_new_from_string <":sel
gtk_tree_view_set_cursor tv;p;0;0
gtk_tree_view_scroll_to_cell tv,p,0 0 0 0
gtk_tree_path_free p
)
listbox_scroll=: 3 : 0
'tv top'=. 2{.y,_1
if. 0>top do. return. end.
p=. gtk_tree_path_new_from_string <":top
gtk_tree_view_scroll_to_cell tv,p,0 0 0 0
gtk_tree_path_free p
)
makelistgrid=: 3 : 0
'id hdr data sel top flag'=. y
tv=. gtk_tree_view_new''
type=. 2 = 3!:0 &> {.data
cls=. #type
ifhdr=. 0<#hdr
if. -.ifhdr do. hdr=. cls$<'' end.
store=. gtk_list_store_newv cls;type{G_TYPE_BOOLEAN,G_TYPE_STRING
setstore store;<data
gtk_tree_view_set_model tv,store
gtk_tree_view_set_headers_visible tv,ifhdr
gtk_tree_view_set_rules_hint tv,flag AND 1
text_renderer=. gtk_cell_renderer_text_new''
check_renderer=. gtk_cell_renderer_toggle_new''
consig4 tv;'row-activated';id,'_row_activated'
consig3 tv;'key-press-event';id,'_key_press'
if. 0 e. type do. consig3 check_renderer;'toggled';id,'_toggled' end.
for_i. i.cls do.
  if. i{type do.
    gtk_tree_view_insert_column_with_attributes tv;i;(i{hdr),text_renderer;'text';i;<<0
  else.
    gtk_tree_view_insert_column_with_attributes tv;i;(i{hdr),check_renderer;'active';i;<<0
  end.
end.
listgrid_scroll tv,top
listgrid_select tv,sel
tv
)
setlistgrid=: 3 : 0
'tv data'=. 2 {. y
store=. gtk_tree_view_get_model tv
setstore store;<data
if. 2 < #y do.
  'sel top'=. 2 {. 2 }. y
  listgrid_select tv,sel
  listgrid_scroll tv,top
end.
)
listgrid_getactiverow=: 3 : 0
c=. mema IF64{4 8
d=. mema IF64{4 8
gtk_tree_view_get_cursor y;c;d
p=. {. memr c,0 1 4
if. p=0 do. _1 return. end.
r=. 0 pick gtk_tree_path_get_indices <<p
row=. {. _2 ic memr r,0 4
gtk_tree_path_free p
memf c
memf d
row
)
listgrid_getscroll=: 3 : 0
c=. mema IF64{4 8
d=. mema IF64{4 8
gtk_tree_view_get_visible_range y;c;d
p=. {. memr c,0 1 4
r=. 0 pick gtk_tree_path_get_indices <<p
row=. {. _2 ic memr r,0 4
gtk_tree_path_free p
memf c
memf d
row
)
listgrid_row_activated=: 3 : 0
'w p c d'=. y
r=. 0 pick gtk_tree_path_get_indices <<p
row=. {. _2 ic memr r,0 4
)
listgrid_select=: 3 : 0
'tv sel'=. 2{.y,_1
if. 0>sel do.
  gtk_tree_selection_unselect_all gtk_tree_view_get_selection tv return.
end.
p=. gtk_tree_path_new_from_string <":sel
gtk_tree_view_set_cursor tv;p;0;0
gtk_tree_view_scroll_to_cell tv,p,0 0 0 0
gtk_tree_path_free p
)
listgrid_scroll=: 3 : 0
'tv top'=. 2{.y,_1
if. 0>top do. return. end.
p=. gtk_tree_path_new_from_string <":top
gtk_tree_view_scroll_to_cell tv,p,0 0 0 0
gtk_tree_path_free p
)
setstore=: 3 : 0
'store data'=. y
gtk_list_store_clear store
iter=. i.ITERSIZE
if. 1=#$data do.
  for_p. data do.
    gtk_list_store_append store;iter
    gtk_list_store_set_1 store;iter;0;p,<_1
  end. return.
end.
typ=. 3!:0 &> {.data
chr=. I. 2 = typ
int=. I. 2 ~: typ
for_p. data do.
  gtk_list_store_append store;iter
  for_i. chr do.
    gtk_list_store_set_1 store;iter;i;(i{p),<_1
  end.
  for_i. int do.
   gtk_list_store_set_2 store;iter;i;(i{p),<_1
  end.
end.
)
ccmenu=: 4 : 0
create_menu_command (x;y),5{.getmenu y
)
create_menu_bar=: 3 : 0
menu_bar=: gtk_menu_bar_new''
)
create_menu_command=: 3 : 0
'menu id icon text letter tip cb'=. y
text=. gettext text
tip=. gettext tip
if. #icon do.
  if. 'check' -: 5{.icon do.
    cb_item=. gtk_check_menu_item_new_with_mnemonic <text
    gtk_check_menu_item_set_active cb_item,{. 0 ". 5 }. icon
  else.
    cb_item=. gtk_image_menu_item_new_with_mnemonic <text
    gtk_image_menu_item_set_image cb_item;gtk_image_new_from_stock icon;1
  end.
else.
  cb_item=. gtk_menu_item_new_with_mnemonic <text
end.
if. #letter do.
  msk=. +/('cs'e.letter)#GDK_CONTROL_MASK,GDK_SHIFT_MASK
  letter=. letter-.'cs'
  if. 1=#letter do.
    key=. a.i.{.letter
  elseif. 'F'={.letter do.
    key=. GDK_F1 + <:0 ". }.letter
  elseif. 6=#letter do.
    key=. GDK_Return
  elseif. 1 do.
    key=. a.i.{:letter
  end.
  create_menu_accel window;cb_item;id;key;msk
end.
if. #tip do.
  if. 0=nc <'menutooltips' do.
    gtk_tooltips_set_tip menutooltips;cb_item;tip;<<0
  end.
end.
if. #cb do.
  consig cb_item;'activate';cb
end.
gtk_menu_shell_append menu,cb_item
cb_item
)
create_menu_accel=: 3 : 0
'window menu id key modifier'=. y
if. UNAME-:'Darwin' do.
  if. _1=4!:0<'macmenushortcuts' do.
    macmenushortcuts=: 0 2$''
    consig3 window;'key-press-event';'macwindowshortcut'
  end.
  if. modifier AND GDK_CONTROL_MASK do.
    m=. (2^28)+modifier-GDK_CONTROL_MASK
  else.
    m=. modifier
  end.
  macmenushortcuts=: macmenushortcuts,id;m,a.i.key
end.
gtk_widget_add_accelerator menu;'activate';accel_group;key;modifier;GTK_ACCEL_VISIBLE
)

create_menu_container=: 3 : 0
container=. gtk_menu_new''
gtk_menu_item_set_submenu y,container
container
)
create_menu_popup=: 3 : 0
'menu label'=. y
root_menu=. gtk_menu_item_new_with_mnemonic <label
gtk_menu_shell_append menu,root_menu
root_menu
)
create_menu_sep=: 3 : 0
menu_item=. gtk_separator_menu_item_new''
gtk_menu_shell_append y,menu_item
menu_item
)
create_menu_sub=: 3 : 0
'menu cb ndx text'=. y
cb_item=. gtk_menu_item_new_with_mnemonic <text
g_signal_connect_data cb_item;'activate';cb2;ndx;0;0
gtk_menu_shell_append menu,cb_item
)
focus_in_event=: 3 : 0
((>libigemac),' ige_mac_menu_set_menu_bar >n x')cd menu_bar
0
)
getmk=: 3 : 0
mk=. 256#.endian"1 [2 4$a.i.memr y,GdkEventKey,8
if. GDK_MOD2_MASK AND {.mk do. mk=. mk-GDK_MOD2_MASK,0 end.
mk
)
macmenu=: 3 : 0
if. UNAME-:'Darwin' do.
  if. -. ''-:libigemac do.
    gtk_widget_hide menu_bar
    consig3 window;'focus_in_event';'focus_in_event'
  end.
end.
)
macwindowshortcut=: 3 : 0
'view keyevent qpointer'=. y
mk=. getmk keyevent
a=. macmenushortcuts
i=. (1{"1 a)i.<mk
if. i<#a do.
  ".'''''',~>{.i{a
  1 return.
end.
0
)

setcheckmenu=: gtk_check_menu_item_set_active
MBtypes=: 0 1 3 2 2 2
MBpress=: 1 1 1 4 5 0
MBdefrs=: 5 5 5 8 5 6
mbox=: 3 : 0
0 mbox y
:
'style title text'=. y
a=. (style{MBtypes);(style{MBpress);'%s';,text
if. 0=x do.
  if. 0>nc<'window' do. win=. 0 else. win=. window end.
else.
  win=. x
end.
w=. gtk_message_dialog_new win;2;a
gtk_window_set_title w;title
select. style
case. 5 do.
  gtk_dialog_add_button w;'gtk-cancel';6
  gtk_dialog_add_button w;'gtk-no';9
  gtk_dialog_add_button w;'gtk-yes';8
end.
r=. |gtk_dialog_run w
gtk_dialog_set_default_response w,style{MBdefrs
gtk_widget_destroy w
select. style
case. 0;1;2 do. i.0 0
case. 3 do. r=8
case. 4 do. r=5
case. 5 do. 6 9 8 i. r
end.
)
mbinfo=: 3 : 0
0 mbinfo y
:
x mbox 0;_2 {. '';boxopen y
)
mbnoyes=: 3 : 0
0 mbnoyes y
:
x mbox 3;_2 {. '';boxopen y
)
mbcancelok=: 3 : 0
0 mbcancelok y
:
x mbox 4;_2 {. '';boxopen y
)
mbcancelnoyes=: 3 : 0
0 mbcancelnoyes y
:
x mbox 5;_2 {. '';boxopen y
)
cocurrent 'jgtk'
get_button=: 3 : 0
256#.endian a.i.memr y,GdkEventButton_button,4
)
get_type=: 3 : 0
memr y,0 1,JINT
)

get_button_event_data=: 3 : 0
gtkda get_button_event_data y
:
mousepos=. <.2 3{;gdk_event_get_coords y;(,0.0);,0.0
state=. 2{;gdk_event_get_state y;,0
(get_button y),(get_type y),mousepos,(2 3{getGtkWidgetAllocation x),state
)

cocurrent 'jgtk'
OR=: 23 b./
NOTALPHA=: 0{_2 ic 255 255 255 0{a.
readimg=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
if. 0= buf=. gdk_pixbuf_new_from_file y;0 do. 0 0$0 return. end.
img=. gdk_pixbuf_add_alpha buf;0;0;0;0
g_object_unref buf
ad=. gdk_pixbuf_get_pixels img
w=. gdk_pixbuf_get_width img
h=. gdk_pixbuf_get_height img
s=. gdk_pixbuf_get_rowstride img
assert. s=4*w
if. IF64 do.
  r=. _2 ic memr ad,0,(w*h*4),JCHAR
else.
  r=. memr ad,0,(w*h),JINT
end.
g_object_unref img
r=. fliprgb^:(RGBSEQ_j_) r (17 b.) NOTALPHA
(h,w)$r
)
getimg=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
if. 0~: s=. g_memory_input_stream_new_from_data y; (#y); 0 do.
  try.
    buf=. gdk_pixbuf_new_from_stream s,0 0
  catch.
    g_input_stream_close s,0 0
    if. IFUNIX do.
      s=. LF -.~ 2!:0 'mktemp'
    else.
      a=. 'kernel32 GetTempPathW i i *w'&cd (256 ; uucp 256{.'')
      s=. '\/' charsub uft8 ((0{::a){. 2{::a)
      s=. '.image',~ s, '/gtkimg_', ":(2!:6)''
    end.
    y 1!:2 <s
    data=. readimg s
    1!:55 <s
    data return.
  end.
  g_input_stream_close s,0 0
  if. 0= buf do. 0 0$0 return. end.
  img=. gdk_pixbuf_add_alpha buf;0;0;0;0
  g_object_unref buf
  ad=. gdk_pixbuf_get_pixels img
  w=. gdk_pixbuf_get_width img
  h=. gdk_pixbuf_get_height img
  s=. gdk_pixbuf_get_rowstride img
  assert. s=4*w
  if. IF64 do.
    r=. _2 ic memr ad,0,(w*h*4),JCHAR
  else.
    r=. memr ad,0,(w*h),JINT
  end.
  g_object_unref img
  r=. fliprgb^:(RGBSEQ_j_) r (17 b.) NOTALPHA
  (h,w)$r
end.
)
writeimg=: 4 : 0
if. -.IFGTK do. gtkinit'' end.
'h w'=. $x
d=. ,x
if. 2> #y=. boxopen y do.
  f=. >@{.y
  type=. tolower }. (}.~ i:&'.') f
  opt=. ''
elseif. 2= #y do.
  f=. >@{.y
  type=. >1{y
  opt=. ''
elseif. do.
  f=. utf8 >@{.y
  type=. >1{y
  opt=. 2{.2}.y
  opt=. (":&.>1{opt) 1}opt
end.
if. 'jpg'-:type do. type=. 'jpeg'
elseif. 'tif'-:type do. type=. 'tiff'
end.
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
if. buf do.
  if. ''-:opt do.
    gdk_pixbuf_save buf;f;type;0;0
  else.
    gdk_pixbuf_save_2 buf;f;type;0;opt,<0
  end.
  g_object_unref buf
end.
EMPTY
)
putimg=: 4 : 0
if. -.IFGTK do. gtkinit'' end.
'h w'=. $x
d=. ,x
if. 2> #y=. boxopen y do.
  type=. >@{.y
  opt=. ''
elseif. do.
  type=. >@{.y
  opt=. 2{.}.y
  opt=. (":&.>1{opt) 1}opt
end.
if. 'jpg'-:type do. type=. 'jpeg'
elseif. 'tif'-:type do. type=. 'tiff'
end.
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
rc=. 0
if. buf do.
  if. ''-:opt do.
    rc=. gdk_pixbuf_save_to_buffer buf;(m=. ,_1);(s=. ,_1);type;0;0
  else.
    rc=. gdk_pixbuf_save_to_buffer_2 buf;(m=. ,_1);(s=. ,_1);type;0;opt,<0
  end.
  g_object_unref buf
end.
if. rc do.
  assert. 0~:m
  z=. memr m,0,s,2
  z [ g_free {.m
else.
  ''
end.
)
clipreadimg=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
if. 0= buf=. gtk_clipboard_wait_for_image cb do. 0 0$0 return. end.
img=. gdk_pixbuf_add_alpha buf;0;0;0;0
assert. 0~:img
g_object_unref buf
ad=. gdk_pixbuf_get_pixels img
w=. gdk_pixbuf_get_width img
h=. gdk_pixbuf_get_height img
s=. gdk_pixbuf_get_rowstride img
assert. s=4*w
assert. 0~:ad
if. IF64 do.
  r=. _2 ic memr ad,0,(w*h*4),JCHAR
else.
  r=. memr ad,0,(w*h),JINT
end.
g_object_unref img
r=. fliprgb^:(RGBSEQ_j_) r (17 b.) NOTALPHA
(h,w)$r
)
clipwriteimg=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
'h w'=. $y
d=. ,y
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
gtk_clipboard_set_image cb,buf
gtk_clipboard_store cb
g_object_unref buf
h,w
)

3 : 0''
if. IF64 do.
  ALPHA=: 0{_3 ic 0 0 0 255 255 255 255 255{a.
else.
  ALPHA=: 0{_2 ic 0 0 0 255{a.
end.
''
)
pixbufpx_setpixels=: 4 : 0
gtkpx=. x
'a b w h'=. 4{.y
d=. 4}.y
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
if. buf do.
  gdk_draw_pixbuf gtkpx,0,buf,0,0,a,b,w,h,0,0,0
end.
g_object_unref buf
EMPTY
)
pixbufcr_setpixels=: 4 : 0
cr=. x
'a b w h'=. 4{.y
d=. 4}.y
d=. fliprgb^:(RGBSEQ_j_) d
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
if. buf do.
  gdk_cairo_set_source_pixbuf cr; buf; a; b
  cairo_paint cr
end.
g_object_unref buf
EMPTY
)
pixbufwin_setpixels=: 4 : 0
(cr=. gdk_cairo_create x) pixbufcr_setpixels y
cairo_destroy cr
EMPTY
)
newradio=: 3 : 0
'button label handler'=. y
rb=. gtk_radio_button_new_with_mnemonic_from_widget button;label
consig rb;'clicked';handler
rb
)
newxradio=: 3 : 0
rb=. newradio }.y
gtk_box_pack_start ({.y),rb;0;0;0
rb
)

readradio=: gtk_toggle_button_get_active
setradio=: gtk_toggle_button_set_active
newsw=: 3 : 0
sw=. gtk_scrolled_window_new 0 0
gtk_scrolled_window_set_policy sw,GTK_POLICY_AUTOMATIC,GTK_POLICY_AUTOMATIC
if. #y do.
  gtk_scrolled_window_set_shadow_type sw,y
end.
sw
)
bufget=: 3 : 0
bgn=. newiterstart y
end=. newiterend y
txt=. ucp readstringfree gtk_text_buffer_get_text y;bgn;end;0
cur=. i. ITERSIZE
bnd=. i. ITERSIZE
if. gtk_text_buffer_get_selection_bounds y;cur;bnd do.
  sel=. #ucp readstringfree gtk_text_buffer_get_text y;bgn;cur;0
  len=. #ucp readstringfree gtk_text_buffer_get_text y;cur;bnd;0
else.
  cur=. newitercursor y
  sel=. #ucp readstringfree gtk_text_buffer_get_text y;bgn;cur;0
  len=. 0
end.
txt;sel;len
)
bufreadlinenumber=: 3 : 0
iter=. i.ITERSIZE
gtk_text_buffer_get_iter_at_mark y;iter;gtk_text_buffer_get_insert y
gtk_text_iter_get_line <iter
)
bufread=: 3 : 0
bgn=. i. ITERSIZE
end=. i. ITERSIZE
gtk_text_buffer_get_bounds y;bgn;end
readstringfree gtk_text_buffer_get_text y;bgn;end;0
)
bufreadcurrentline=: 3 : 0
bufreadline y,bufreadlinenumber y
)
bufreadlastline=: 3 : 0
bgn=. newiterlastline y
end=. newiterend y
readstringfree gtk_text_iter_get_text bgn;end
)
bufreadline=: 3 : 0
bgn=. newiterline y
if. 10 = gtk_text_iter_get_char <bgn do. '' return. end.
end=. newiterline y
gtk_text_iter_forward_to_line_end <end
readstringfree gtk_text_iter_get_text bgn;end
)
bufreadselect=: 3 : 0
bgn=. i. ITERSIZE
end=. i. ITERSIZE
if. 0 = gtk_text_buffer_get_selection_bounds y;bgn;end do.
  '' return.
end.
readstringfree gtk_text_buffer_get_text y;bgn;end;0
)
bufsetselect=: 3 : 0
'buf pos len'=. y
noevents 1
bgn=. newiterpos buf,pos
end=. newiterpos buf,pos
gtk_text_iter_forward_chars end;len
gtk_text_buffer_select_range buf;bgn;end
noevents 0
)
bufwrite=: 3 : 0
'buf txt'=. y
txt=. utf8 txt
gtk_text_buffer_set_text buf;txt;#txt
)
bufwritefile=: 3 : 0
'buf file'=. y
txt=. freads file
if. -. txt -: _1 do.
  bufwrite buf;txt
end.
)
languageids=: 3 : 0
lm=. gtk_source_language_manager_get_default''
getlist gtk_source_language_manager_get_language_ids lm
)
languagepaths=: 3 : 0
lm=. gtk_source_language_manager_get_default''
getlist gtk_source_language_manager_get_search_path lm
)
newsb=: 3 : 0
if. IFSV do.
  sb=. newsb1 y
else.
  sb=. newtb y
end.
iter=. newiterend sb
gtk_text_buffer_create_mark sb;'end';iter;0
gtk_text_buffer_create_mark sb;'scroll';iter;1
sb
)
newsb1=: 3 : 0
'class scheme filename text'=. y
text=. fgets text
sb=. gtk_source_buffer_new 0
gtk_source_buffer_begin_not_undoable_action sb
if. #scheme do.
  sm=. gtk_source_style_scheme_manager_get_default''
  ss=. gtk_source_style_scheme_manager_get_scheme sm;scheme
  gtk_source_buffer_set_style_scheme sb,ss
end.
select. class
fcase. 'edit' do.
  consig sb;'changed';'cb_edit_changed'
  bufwrite sb;text
case. 'term' do.
  lm=. gtk_source_language_manager_get_default''
  if. class -: 'term' do.
    sl=. gtk_source_language_manager_get_language lm;,'j'
  else.
    sl=. 0
    if. #filename do.
      sl=. gtk_source_language_manager_guess_language ::0: lm;filename;<<0
    end.
    if. sl=0 do.
      x=. (filename i:'.')}.filename
      lang=. ' ' -.~ ((<;.1 '.ijs.ijt.jproj.k.q.qproj.rproj') i. <x) { 'jjjkqjj '
      if. #lang do.
        sl=. gtk_source_language_manager_get_language lm;,lang
      end.
    end.
  end.
  if. sl do.
    gtk_source_buffer_set_language sb,sl
    gtk_source_buffer_set_highlight_syntax sb,1
    gtk_source_buffer_set_highlight_matching_brackets sb,ifMatchBrackets
  end.
case. 'view' do.
  bufwrite sb;text
end.
gtk_source_buffer_end_not_undoable_action sb
sb
)
newtb=: 3 : 0
'type scheme filename text'=. y
select. type
case. 'term' do.
  tb=. gtk_text_buffer_new 0
case. 'edit' do.
  tb=. gtk_text_buffer_new 0
  consig tb;'changed';'cb_edit_changed'
  bufwritefile tb;filename
case. 'view' do.
  tb=. gtk_text_buffer_new 0
  bufwrite tb;text
end.
tb
)
styleids=: 3 : 0
sm=. gtk_source_style_scheme_manager_get_default''
getlist gtk_source_style_scheme_manager_get_scheme_ids sm
)
stylepath=: 3 : 0
sm=. gtk_source_style_scheme_manager_get_default''
getlist gtk_source_style_scheme_manager_get_search_path sm
)
newcodeview=: 3 : 0
'class scheme filename text'=. 4 {. y
sb=. newsb class;scheme;filename;text
'sw sv'=. newcodeviewsb sb
sw,sv,sb
)
newcodeviewsb=: 3 : 0
sb=. y
sw=. newsw''
if. IFSV do.
  sv=. gtk_source_view_new_with_buffer sb
  gtk_source_view_set_auto_indent sv,1
  gtk_source_view_set_highlight_current_line sv,1
  gtk_source_view_set_show_line_numbers sv,0
  gtk_source_view_set_tab_width sv,4
else.
  sv=. gtk_text_view_new_with_buffer sb
end.
gtk_container_add sw,sv
consig3 sv;'button-press-event';'sv_button_press'
consig3 sv;'key-press-event';'sv_key_press'
consig3 sv;'populate-popup';'sv_populate_popup'
setfont sv;FixFont
sw;sv
)
sv_key_press=: 0:
sv_populate_popup=: 0:
sview_init=: 3 : 0
initsearchpath''
EMPTY
)
viewgettop=: 3 : 0
px=. memaz 4
py=. memaz 4
iter=. i.ITERSIZE
gtk_text_view_window_to_buffer_coords y;2;0;0;(<px);<<py
cx=. {.memri4 px
cy=. {.memri4 py
memf px
memf py
gtk_text_view_get_iter_at_position y;iter;(<0);cx;cy
gtk_text_iter_get_line <iter
)
viewinsert=: 3 : 0
'w t'=. y
gtk_text_buffer_insert w;(newitercursor w);(octal_j_ t);_1
)
viewlinenumbers=: 3 : 0
if. -.IFSV do. 0 return. end.
'w s'=. 2 {. y,_1
if. s<0 do.
  gtk_source_view_get_show_line_numbers w
else.
  s[gtk_source_view_set_show_line_numbers w,s
end.
)
viewlinewrap=: 3 : 0
'w s'=. 2 {. y,_1
if. s<0 do.
  gtk_text_view_get_wrap_mode w
else.
  s[gtk_text_view_set_wrap_mode w,s*2
end.
)
viewnewselect=: 3 : 0
'view pos fin new set'=. y
new=. utf8 new
top=. viewgettop view
buf=. gtk_text_view_get_buffer view
noevents 1
bgn=. newiterpos buf,pos
end=. newiterpos buf,pos
gtk_text_iter_forward_chars end;fin-pos
gtk_text_buffer_delete buf;bgn;end
gtk_text_buffer_insert buf;end;new;#new
bgn=. newiterpos buf,{.set
end=. newiterpos buf,{.set
gtk_text_iter_forward_chars end;({:set)-{.set
gtk_text_buffer_select_range buf;bgn;end
viewsetscroll view;top
noevents 0
)
viewread=: 3 : 0
bufread gtk_text_view_get_buffer y
)
viewreplacelast=: 3 : 0
'view txt pos len'=. y
txt=. utf8 pos }. txt
buf=. gtk_text_view_get_buffer view
noevents 1
bgn=. newiterpos buf,pos
end=. newiterend buf
gtk_text_buffer_delete buf;bgn;end
sel=. newiterend buf
gtk_text_buffer_insert buf;sel;txt;#txt
sp0=. newiterpos buf,pos
sp1=. newiterpos buf,pos
gtk_text_iter_forward_chars sp1;len
gtk_text_buffer_select_range buf;sp0;sp1
viewscrolliter view;sp1
noevents 0
)
viewreplaceselect=: 3 : 0
'view pos len new'=. y
new=. utf8 new
buf=. gtk_text_view_get_buffer view
noevents 1
bgn=. newiterpos buf,pos
end=. newiterpos buf,pos
gtk_text_iter_forward_chars end;len
gtk_text_buffer_delete buf;bgn;end
sel=. newiterpos buf,pos
gtk_text_buffer_insert buf;sel;new;#new
viewscrolliter view;sel
noevents 0
)
viewreplacetext=: 3 : 0
'view new'=. y
new=. utf8 new
top=. viewgettop view
top=. 0 >. top <. <: +/new = LF
buf=. gtk_text_view_get_buffer view
noevents 1
bufwrite buf;new
viewsetscroll view;top
noevents 0
)
viewsethigh=: 3 : 0
'view row'=. y
if. row<0 do. EMPTY return. end.
noevents 1
buf=. gtk_text_view_get_buffer view
len=. gtk_text_buffer_get_line_count buf
if. row>len do. EMPTY return. end.
bgn=. newiterline buf,row+1
end=. newiterline buf,row+1
gtk_text_iter_forward_to_line_end <end
gtk_text_buffer_select_range buf;bgn;end
noevents 0
EMPTY
)
viewsetrow=: 3 : 0
'view row'=. y
row=. row>.0
noevents 1
buf=. gtk_text_view_get_buffer view
bgn=. newiterline buf,row
gtk_text_buffer_place_cursor buf;bgn
noevents 0
)
viewsetscroll=: 3 : 0
'view row'=. y
buf=. gtk_text_view_get_buffer view
bgn=. newiterline buf,row
mark=. gtk_text_buffer_get_mark buf;'scroll'
gtk_text_buffer_move_mark buf;mark;bgn
gtk_text_view_scroll_to_mark view,mark,0 1 0 0
)
viewsetselect=: 3 : 0
'view pos len'=. y
buf=. gtk_text_view_get_buffer view
noevents 1
bufsetselect buf,pos,len
viewscrolliter view;newiterpos buf,pos
noevents 0
)
viewscrolliter=: gtk_text_view_scroll_to_iter @ (,&(0;0;0;0))
viewwrite=: 3 : 0
'view txt'=. y
bufwrite (gtk_text_view_get_buffer view);txt
)
newwindow=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
windowcaption y
consig3 window;'delete-event';'window_delete'
accel_group=: gtk_accel_group_new''
gtk_window_add_accel_group window,accel_group
)
windowcaption=: 3 : 0
gtk_window_set_title window;y
)

windowcenter=: 3 : 'gtk_window_set_position window,GTK_WIN_POS_CENTER'
windowdefaultsize=: 3 : 0
gtk_window_set_default_size window,y
)
windowborderwidth=: 3 : 0
gtk_container_set_border_width window;y
)
windowfinish=: 3 : 0
gtk_widget_show_all window
macmenu''
)
coclass'jgtkgraph'
coinsert'jgtk'
graph_init=: 3 : 0
'xysize'=. y
gtkbox=: gtk_event_box_new''
gtkda=: gtk_drawing_area_new''
gtk_widget_set_size_request gtkda,xysize
gtk_container_add gtkbox,gtkda
events=. GDK_EXPOSURE_MASK,GDK_BUTTON_PRESS_MASK,GDK_BUTTON_RELEASE_MASK,GDK_POINTER_MOTION_MASK
gtk_widget_add_events gtkda, OR events

gtkpc=: gtk_widget_get_pango_context gtkda
gtkpl=: pango_layout_new gtkpc
gtkplc=: pango_layout_get_context gtkpl

consig3 gtkda;'configure_event';'configure_event'
consig3 gtkda;'expose_event';'expose_event'
consig3 gtkda;'button_press_event';'button_press_event'
consig3 gtkda;'button_release_event';'button_release_event'
consig3 gtkda;'motion_notify_event';'motion_notify_event'
consig gtkda;'destroy';'destroy_event'

gtkwin=: gtkpx=: gtkgc=: gtkdagc=: 0
)
create=: graph_init
destroy=: 3 : 0
cbfree''
codestroy''
0
)
arctan=: _3&o.
dfr=: *&(180%1p1)
OR=: 23 b./
pafc=: 2p1&|@{:@(*.@(j./))
calcAngle=: ([: pafc _1 1 * -)"1

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
degree64=: 0.5 <.@:+ 64 * dfr
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
gtkcolor=: 3 : 0
gdk_gc_set_rgb_fg_color gtkgc;rgb2gtk y
)
gtktextangle=: 3 : 0
mat=. 1 0 0 1 0 0 + 1.1 - 1.1
pango_matrix_rotate mat;y
pango_context_set_matrix gtkplc;mat
pango_layout_context_changed gtkpl
)
gtkarcisi=: 3 : 0
ctr=. (0 1{y) + -: (2 3{y)
'bgn end'=. ctr calcAngle (4 5,:6 7){y
dif=. 2p1 | end - bgn
(4{.y), degree64 bgn,dif
)
rgb2gtk=: 3 : 0
(0 0 0 0{a.), 1 (3!:4) (256 * y) + 255 * 127 < y
)
button_event=: 4 : 0
n=. ,(get_button y){' lmr'
x=. ,>(5=get_type y){x;'dbl'
name=. 'mb',n,x
mousepos=. <.2 3{;gdk_event_get_coords y;(,0.0);,0.0
state=. 2{;gdk_event_get_state y;,0
wh=. glqwh''
sysdata=: 0":mousepos,wh,state
if. _1=nc <name do. 0 return. end.
".name,''''''
0
)
button_press_event=: 3 : 0
'down' button_event 1{y
)
button_release_event=: 3 : 0
'up' button_event 1{y
)
configure_event=: 3 : 0
'widget event data'=. y
if. 0=gtkwin do. gtkwin=: getGtkWidgetWindow gtkda end.
if. 0=gtkdagc do. gtkdagc=: getdagc gtkda end.
gtkwh=: 2 3{gtkxywh=: getGtkWidgetAllocation gtkda
if. gtkpx do. g_object_unref gtkpx end.
gtkpx=: gdk_pixmap_new gtkwin,gtkwh,_1
if. 0=gtkgc do. gtkgc=: gdk_gc_new gtkwin end.
0
)

expose_event=: 0[glpaint
destroy_event=: 3 : 0
'widget data'=. y
if. -.IFGTK do.
 gtk_main_quit ''
end.
destroy ''
0
)
motion_notify_event=: 3 : 0
if. _1=nc <'mmove' do. 0 return. end.
'widget event gpointer'=. y
mousepos=. <.2 3{;gdk_event_get_coords event;(,0.0);,0.0
state=. 2{;gdk_event_get_state event;,0
wh=. glqwh''
sysdata=: 0":mousepos,wh,state
mmove''
0
)
glarc=: 3 : 0 "1
t=. gtkbrushnull
gtkbrushnull=: 1
glarcx gtkarcisi y
gtkbrushnull=: t
)
glarcx=: 3 : 0 "1
if. -.gtkbrushnull do.
  gtkcolor gtkbrushrgb
  gdk_draw_arc gtkpx,gtkgc,1,y
end.
gtkcolor gtkpenrgb
gdk_draw_arc gtkpx,gtkgc,0,y
)
glbrush=: 3 : 0 "1
gtkbrushrgb=: gtkrgb
gtkbrushnull=: 0
)
glbrushnull=: 3 : 0 "1
gtkbrushnull=: 1
)
glclear=: 3 : 0 "1
glwindoworg 0 0
glclipreset''
glrgb 255 255 255
glpen 1 0
glbrush''
glrect 0 0,gtkwh
glrgb 0 0 0
glpen 1 0
glbrushnull''
gltextxy 0 0
gltextcolor''
glfontangle 0
)
glclip=: 3 : 0 "1
gdk_gc_set_clip_rectangle gtkgc;2(3!:4)y
)
glclipreset=: 3 : 0 "1
gdk_gc_set_clip_rectangle gtkgc;2(3!:4)0 0,gtkwh
)
glcmds=: 3 : 0
while. #y do.
  cnt=. 0{y
  cmd=. 1{y
  dat=. 2}.cnt{.y
  if. 2015=cmd do.
    gllines |dat
  else.
  end.
  y=. cnt}.y
end.
)
glellipse=: 3 : 'glarcx y,"1 [ 0,360*64'
glfont=: 3 : 0 "1
if. 1 e. ' bold' E. y=. tolower y do.
  bold=. 1 [ y=. }. ; (<' bold') -.~ <;.1 ' ', y
else.
  bold=. 0
end.
if. 1 e. ' underline' E. y do.
  gtkunderline=: 1 [ y=. }. ; (<' underline') -.~ <;.1 ' ', y
else.
  gtkunderline=: 0
end.
fnt=. pango_font_description_from_string <y
if. bold do. pango_font_description_set_weight fnt, 700 end.
pango_layout_set_font_description gtkpl,fnt
pango_font_description_free fnt
)
glfontangle=: 3 : 0 "1
gtkfontangle=: y
)
glrgb=: 3 : 0 "1
gtkrgb=: y
)
gllines=: 3 : 0 "1
gtkcolor gtkpenrgb
c=. <.-:#y=. <.y
if. IF64 do. y=. _3 ic 2 ic y end.
gdk_draw_lines gtkpx;gtkgc;y;c
)
glpaint=: 3 : 0 "1
glclear''
paint''
gdk_draw_drawable gtkwin,gtkdagc,gtkpx,0 0 0 0 _1 _1
)
glpaintx=: 3 : 0 "1
gtk_widget_queue_draw gtkda
)
glpen=: 3 : 0 "1
gtkpenrgb=: gtkrgb
gtkpenwidth=: {.y
gtkpenstyle=: {:y
gdk_gc_set_line_attributes gtkgc;gtkpenwidth;0;1;0
)
glpie=: 3 : 0 "1
glarcx gtkarcisi y
)
glpixel=: 3 : 0 "1
gtkcolor gtkrgb
gdk_draw_point gtkpx,gtkgc,y
)
glpixels=: 3 : 0 "1
'a b w h'=. 4{.y
d=. 4}.y
d=. d OR ALPHA
if. IF64 do. d=. 2 ic d end.
buf=. gdk_pixbuf_new_from_data (15!:14<'d'),GDK_COLORSPACE_RGB,1,8,w,h,(4*w),0,0
if. buf do.
  gdk_draw_pixbuf gtkpx,0,buf,0,0,a,b,w,h,0,0,0
end.
g_object_unref buf
)
glpolygon=: 3 : 0 "1
c=. <.-:#y=. <.y
if. IF64 do. y=. _3 ic 2 ic y end.
if. -.gtkbrushnull do.
  gtkcolor gtkbrushrgb
  gdk_draw_polygon gtkpx;gtkgc;1;y;c
end.
gtkcolor gtkpenrgb
gdk_draw_polygon gtkpx;gtkgc;0;y;c
)

glqpixels=: 3 : 0 "1
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
r AND NOTALPHA
)
glqwh=: 3 : 0
gtkwh
)
glrect=: 3 : 0 "1
if. 0 e. _2{.y do. return. end.
if. -.gtkbrushnull do.
  gtkcolor gtkbrushrgb
  gdk_draw_rectangle gtkpx,gtkgc,1,y
end.
gtkcolor gtkpenrgb
gdk_draw_rectangle gtkpx,gtkgc,0,y-0 0 1 1
)
glsel=: 3 : 0 "1
''
)
glsetbrush=: glbrush @ glrgb
glsetpen=: glpen @ ((1 0 [ glrgb) :((2 {. [) glrgb))
gltext=: 3 : 0 "1
gtkcolor gtktextrgb
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
  gtktextangle gtkfontangle
  pango_layout_set_text gtkpl;(,y);#y
  gdk_draw_layout gtkpx,gtkgc,gtktextxy,gtkpl
  gtktextangle 0
end.
if. gtkunderline do.
  atl=. pango_attr_list_new ''
  ul=. pango_attr_underline_new 0
  pango_attr_list_insert atl,ul
  pango_layout_set_attributes gtkpl,atl
  pango_attr_list_unref atl
end.
)
gltextcolor=: 3 : 0 "1
gtktextrgb=: gtkrgb
)
gltextxy=: 3 : 0 "1
gtktextxy=: y
)
glqextent=: 3 : 0 "1
pango_layout_set_text gtkpl;(,y);#y
_2 {. ;pango_layout_get_pixel_size gtkpl;(,2);,3
)
glqextentw=: 3 : 0 "1
{."1>glqextent each<;._2 y,LF#~LF~:{:y
)
glwindoworg=: 3 : 0 "1
''
)

0 : 0
glcapture=:      11!:2062
glcaret=:        11!:2065
glcmds=:         11!:2999
glcursor=:       11!:2069
glemfclose=:     11!:2085
glemfopen=:      11!:2084
glemfplay=:      11!:2086
glfile=:         11!:2066
glnodblbuf=:     11!:2070
glpixelsx=:      11!:2075
glprint=:        11!:2089
glprintmore=:    11!:2091
glqhandles=:     11!:2060
glqprintpaper=:  11!:2092
glqprintwh=:     11!:2088
glqtextmetrics=: 11!:2058
glroundr=:       11!:2033
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
pango_layout_set_text x;(,y);#y
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
pango_layout_set_text x;(,y);#y
_2 {. gtkextents ''
)

cocurrent 'jgtk'
gtkglade=: 4 : 0
builder=. gtk_builder_new''
if. 0=builder do. 0 0 return. end.
r=. ''
gerr=: ,-0
if. L.y do.
  rc=. gtk_builder_add_from_string builder;(>y);_1;gerr
else.
  rc=. gtk_builder_add_from_file builder;y;gerr
end.
if. 0= rc do.
  smoutput memr (memr gerr,8 1 4),0 _1
  builder, 0 return.
end.
window=. gtk_builder_get_object builder;x
if. 0=window do. builder, 0 return. end.
GLADESIGNALS=: 0 5$''
h=. cbreg 'gladecallback_',(>coname''),'_'
gtk_builder_connect_signals_full builder,cb7,h
gladeconsig GLADESIGNALS
builder,window
)
gladereport=: 3 : 0
t=. GLADESIGNALS
han=. 2{"1 t
obj=. +/>3{"1 t
flg=. +/>4{"1 t
sig=. ~.1{"1 t
mul=. (1<+/"1 = a)#~.a=. 2{"1 t
r=. ''
if. obj do. r=. r,'row(s) with connect_object - not supported',LF end.
if. flg do. r=. r,'row(s) with flags - not supported',LF end.
r=. r,(0~:#r)#LF
r=. r,'signals: ',gladerepsub sig
r=. r,'handler verbs not defined: ',gladerepsub (3~:nc han)#han
r=. r,'handler verbs defined: ',gladerepsub (3=nc han)#han
)
gladecallback=: 3 : 0
'bulder object psignal phandler connect_object flags qpointer'=. y
signal=. memr psignal,0,_1
handler=. memr phandler,0,_1
t=. (":object),' : ',signal,' : ',handler,LF
GLADESIGNALS=: GLADESIGNALS,object;signal;handler;connect_object;flags
)
gladeconsig=: 3 : 0
for_i. i.#y do.
  'object signal handler connect_object flags'=. i{y
  if. connect_object do.
  elseif. flags do.
  elseif. '_event'-:_6{.signal do.
    consig3 object;signal;handler
  elseif. 1 do.
    consig object;signal;handler
  end.
end.
)
gladerepsub=: 3 : 0
LF,~LF,;' ',each,LF,~each y
)

GTKPRINTERS=: 0$<''
cb_enumerate_printers=: 3 : 0
'printer data'=. y
if. gtk_printer_is_virtual printer do. 0 return. end.
def=. ' *'{~ gtk_printer_is_default printer
prt=. memr (gtk_printer_get_name printer), 0 _1
GTKPRINTERS=: GTKPRINTERS, <def,prt
0
)
gtk_qprinters=: 3 : 0
pcb=. 2 cbuserdata 'cb_enumerate_printers';'jgtk'
GTKPRINTERS_jgtk_=: 0$<''
gtk_enumerate_printers pcb, 0 1
if. #GTKPRINTERS_jgtk_ do.
  def=. }.&.> GTKPRINTERS_jgtk_ {~ '*' i.~ {."1 >GTKPRINTERS_jgtk_
  prn=. /:~ }.&.> GTKPRINTERS_jgtk_
  GTKPRINTERS_jgtk_=: def,prn
end.
GTKPRINTERS_jgtk_
)
