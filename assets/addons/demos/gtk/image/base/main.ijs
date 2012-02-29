NB. main

NB. =========================================================
rescale=: 3 : 0
p=. gdk_pixbuf_new_from_file_at_scale File;;/y,0 0
gtk_image_set_from_pixbuf image,p
)

NB. =========================================================
make_timer=: 3 : 0
if. y do.
  sys_timer_z_=: ('timer_',(>coname''),'_')~
  settimer y
else.
  sys_timer_z_=: 0:
end.
0
)

NB. =========================================================
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
