18!:4 <'z'

IFWIN=: 6=9!:12''

jpathsep_z_=: '/'&(('\' I.@:= ])})
GTKPATH=: '/gtk/' ,~ ({.~ i:&'/') jpathsep BINPATH
log=: 3 : 0
((":y),10{a.) 1!:3 <'/tmp/t1.txt'
)
run=: 3 : 0
gtkinit_z_''
File=: y
Dat=: fread File
if. Dat-:_1 do. return. end.
Resize=: (<(1+File i:'.')}.File) e. ;: 'svg'
make_win ''
make_timer 200
gtk_main''
1
)
LF=: 10{a.
IF64=: 16={:$3!:3[2

boxxopen=: <^:(L. < *@#)
cd=: 15!:0
cocurrent=: 18!:4@boxxopen
dtb=: #~ ([: +./\. ' '&~:)
each=: &.>
exit=: 2!:55
fread=: 1!:1 @ < :: _1:
ic=: 3!:4
memr=: 15!:1
pick=: >@{
smoutput=: 0 0 $ 1!:2&2
uucp=: u:@(7&u:)
rescale=: 3 : 0
p=. gdk_pixbuf_new_from_file_at_scale File;;/y,0,0
gtk_image_set_from_pixbuf image,p
)


3 : 0''
if. IFWIN do. 
  UNAME=: 'Win' 
elseif. IFDEF'android' do.
  UNAME=: 'Linux' 
elseif.
  UNAME=: LF -.~ 2!:0 'uname' 
end.
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
consigs=: 4 : 0
'widget signal handler'=. y
h=. cbreg handler,'_base_'
g_signal_connect_data widget;signal;x;h;0;0
)

consig3=: cb3 & consigs
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
cddef=: 4 : 0
n=. y i. ' '
f=. n {. y
p=. n }. y
s=. ' > ',IFWIN#'+ '
(f)=: (x,' ',f,s,p)&cd
''
)
gtkeventkey=: 3 : '_2 ic memr y,GdkEventKey,8'
gtkinit=: 3 : 0
gtksetenv''
gtk_init (,0);0
cbregs=: 'bad0';'bad1'
)
gtksetenv=: 3 : 0
if. UNAME-:'Darwin' do.
  1!:44 jpath '~install'
  f=. 'libc.dylib putenv i *c' cd <
  p=. jpath '~install/gtk'
  f 'XDG_CONFIG_DIRS="',p,'/etc/xdg"'
  f 'XDG_DATA_DIRS="',p,'/share"'
  f 'GTK_DATA_PREFIX="',p,'"'
  f 'GTK_EXE_PREFIX="',p,'"'
  f 'GTK_PATH="',p,'"'
  f 'GTK2_RC_FILES="',p,'/etc/gtk-2.0/gtkrc"'
  f 'GTK_IM_MODULE_FILE='
  f 'GDK_PIXBUF_MODULE_FILE="',p,'/etc/gtk-2.0/gdk-pixbuf.loaders"'
end.
)
libglib cddef each <;._2 [ 0 : 0
g_timeout_add_full x x x x x x
)
libgobject cddef each <;._2 [ 0 : 0
g_signal_connect_data x x *c x x x x
)
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
)
libpixbuf cddef each <;._2 [ 0 : 0
gdk_pixbuf_new_from_file_at_scale x *c x x i x
)
settimer=: 3 : 0
g_timeout_add_full 200;y;cb1;(cbreg 'sys_timer__');0
)
Timeout=: 5
make_timer=: 3 : 0
if. y do.
  sys_timer_z_=: timer
  settimer y
  timeout=: Timeout
else.
  sys_timer_z_=: 0:
end.
0
)
timer=: 3 : 0
new=. fread File
if. new -: Dat do. 1 return. end.
if. new -: _1 do.
  if. 0 < timeout=: timeout-1 do. 1 return. end.
  window_delete''
  0 return.
end.
Dat=: new
if. 10 >: {:Twh do.
  make_timer 0
  gtk_widget_destroy window
  make_win''
  make_timer 200 return.
end.
if. Resize do.
  rescale Twh
else.
  gtk_image_set_from_file image;<File
end.
gtk_window_present window
timeout=: Timeout
1
)
make_win=: 3 : 0
Pwh=: Twh=: 0
window=: gtk_window_new 0
gtk_window_set_title window;'view'
consig3 window;'delete-event';'window_delete'
consig3 window;'key-press-event';'window_key_press'
if. Resize do.
  consig3 window;'configure_event';'window_configure'
else.
  gtk_window_set_resizable window,0
end.
image=: gtk_image_new_from_file <File
gtk_container_add window,image
gtk_widget_show_all window
)
window_configure=: 3 : 0
e=. 1{y
wh=. _2 ic memr e,(GdkEventConfigure_xywh+8),8
if. Twh-:wh do. 0 return. end.
if. Twh-:0 do.
  Pwh=: wh
  gtk_widget_set_size_request window,0 0
else.
  rescale wh
end.
Twh=: wh
0
)
window_delete=: 3 : 0
make_timer 0
gtk_main_quit''
gtk_widget_destroy window
1
)
window_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key~:GDK_Escape do. 0 return. end.
if. +:/ 0 2 { 2 2 2 #: state do.
  window_delete''
end.
)
cocurrent 'base'

run 3 pick ARGV
