NB. timer

NB. allow this many fails before closing window
NB. ~ 1 second for 200ms timer
Timeout=: 5

NB. =========================================================
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

NB. =========================================================
timer=: 3 : 0
new=. fread File
if. new -: Dat do. 1 return. end.
if. new -: _1 do.
  if. 0 < timeout=: timeout-1 do. 1 return. end.
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
timeout=: Timeout
1
)
