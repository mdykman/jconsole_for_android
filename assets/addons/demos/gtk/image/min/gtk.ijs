NB. gtk

3 : 0''
if. IFWIN do. UNAME=. 'Win' else. UNAME=. LF -.~ 2!:0 'uname' end.
select. UNAME
case. 'Darwin' do.
  libdir=. GTKPATH,'lib/'
  libglib=: <libdir,'libglib-2.0.0.dylib'
  libgtk=: <libdir,'libgtk-quartz-2.0.0.dylib'
  libpixbuf=: <libdir,'libgdk_pixbuf-2.0.0.dylib'
  libgobject=: <libdir,'libgobject-2.0.0.dylib'
case. 'Linux' do.
  libglib=: <'libglib-2.0.so.0'
  libgtk=: <'libgtk-x11-2.0.so.0'
  libpixbuf=: <'libgdk_pixbuf-2.0.so.0'
  libgobject=: <'libgobject-2.0.so.0'
case. 'Win' do.
  'kernel32.dll SetDllDirectoryW x *w'cd <uucp GTKPATH,'bin'
  libglib=: <'libglib-2.0-0.dll'
  libgtk=: <'libgtk-win32-2.0-0.dll'
  libpixbuf=: <'libgdk_pixbuf-2.0-0.dll'
  libgobject=: <'libgobject-2.0-0.dll'
end.
)

GDK_Escape=: 65307
GdkEventConfigure_xywh=: IF64{12 20
GdkEventKey=: IF64{16 24

f=. [: 15!:13 (IFWIN#'+') , ' x' $~ +:
cb1=: f 2
cb3=: f 4

NB. =========================================================
NB. connect signal to handler
consigs=: 4 : 0
'widget signal handler'=. y
h=. cbreg handler,'_base_'
g_signal_connect_data widget;signal;x;h;0;0
)

consig3=: cb3 & consigs

NB. =========================================================
NB. register new object handler (selected by qpointer in callback)
cbreg=: 3 : 0
i=. cbregs i. <y
if. i<#cbregs do. return. end.
i=. cbregs i. a:
if. i=#cbregs do.
  cbregs=: cbregs,<y
else.
  cbregs=: (<y) i} cbregs
end.
i
)

NB. =========================================================
NB. callbacks run cdcallback in current locale
cdcallback=: 3 : 0
try.
  w=. 15!:17''
  h=. >({:w){cbregs
  h~w
catchd.
  smoutput 1;'callback';'xxx signal: ',h,LF,LF,13!:12''
  0
end.
)

NB. =========================================================
cddef=: 4 : 0
n=. y i. ' '
f=. n {. y
p=. n }. y
s=. ' > ',IFWIN#'+ '
(f)=: (x,' ',f,s,p)&cd
''
)

NB. =========================================================
gtkeventkey=: 3 : '_2 ic memr y,GdkEventKey,8'

NB. =========================================================
gtkinit=: 3 : 0
gtk_init (,0);0
cbregs=: 'bad0';'bad1'
)

NB. =========================================================
libglib cddef each <;._2 [ 0 : 0
g_timeout_add_full x x x x x x
)

NB. =========================================================
libgobject cddef each <;._2 [ 0 : 0
g_signal_connect_data x x *c x x x x
)

NB. =========================================================
libgtk cddef each <;._2 [ 0 : 0
gtk_container_add n x x
gtk_image_new_from_file x *c
gtk_image_set_from_file n x *c
gtk_image_set_from_pixbuf n x x
gtk_init n *x x
gtk_main n
gtk_main_quit n
gtk_widget_destroy n x
gtk_window_present n x
gtk_widget_show_all n x
gtk_window_new x x
gtk_window_set_resizable n x i
gtk_widget_set_size_request n x x x
gtk_window_set_title n x *c
gtk_image_new_from_file_utf8 x *c
gtk_image_set_from_file_utf8 n x *c
)

NB. =========================================================
libpixbuf cddef each <;._2 [ 0 : 0
gdk_pixbuf_new_from_file_at_scale x *c x x i x
gdk_pixbuf_new_from_file_at_scale_utf8 x *c x x i x
)

NB. =========================================================
3  : 0''
if. IFWIN *. IF64 do.
  gtk_image_new_from_file=: gtk_image_new_from_file_utf8
  gtk_image_set_from_file=: gtk_image_set_from_file_utf8
  gdk_pixbuf_new_from_file_at_scale=: gdk_pixbuf_new_from_file_at_scale_utf8
end.
EMPTY
)

NB. =========================================================
settimer=: 3 : 0
g_timeout_add_full 200;y;cb1;(cbreg 'sys_timer__');0
)
