coclass 'pimage'
coinsert 'jgtk'
create=: 3 : 0
File=: y
Dat=: fread File
if. Dat-:_1 do.
  smoutput 'not found: ',File
  destroy'' return.
end.
if. -.IFGTK do.
  require 'gtk'
  gtkinit_jgtk_''
end.
Pwh=: Twh=: 0
Resize=: (<(1+File i:'.')}.File) e. ;: 'svg'
make_win ''
make_timer 2000
if. -.IFGTK do.
  gtk_main''
end.
1
)
destroy=: 3 : 0
cbfree''
codestroy''
)
rescale=: 3 : 0
p=. gdk_pixbuf_new_from_file_at_scale File;;/y,0 0
gtk_image_set_from_pixbuf image,p
)
make_timer=: 3 : 0
if. y do.
  sys_timer_z_=: ('timer_',(>coname''),'_')~
  settimer y
else.
  sys_timer_z_=: 0:
end.
0
)
timer=: 3 : 0
new=. fread File
if. new -: Dat do. 1 return. end.
if. new -: _1 do.
  smoutput 'not found: ',File
  window_delete''
  0 return.
end.
Dat=: new
if. Resize > Pwh-:Twh do.
  rescale Twh
else.
  gtk_image_set_from_file image;<File
end.
gtk_window_present window
1
)
Pwh=: Twh=: 0
make_win=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
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
if. -.IFGTK do.
  gtk_main_quit''
end.
gtk_widget_destroy window
destroy''
1
)
window_key_press=: 3 : 0
if. -. isesckey y do. 0 return. end.
window_delete''
)
