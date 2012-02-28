NB. edit graph definition

cocurrent 'jgldemo'

GLEDTEXT=: ''

NB. =========================================================
make_gledit=: 3 : 0
gledit=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title gledit;'View Definition'
gtk_window_set_transient_for gledit,window
gtk_window_set_destroy_with_parent gledit,1
box1=. gtk_vbox_new 0 0
box2=. gtk_hbox_new 0 0
redisplay=. gtk_button_new_with_mnemonic <'_Redisplay'
recover=. gtk_button_new_with_mnemonic <'R_ecover'
save=. gtk_button_new_with_mnemonic <'_Save'
help=. gtk_button_new_with_mnemonic <'_Help'
close=. gtk_button_new_with_mnemonic <'_Close'
graf=: gtk_text_view_new''
gtk_widget_set_size_request graf,416 200
gtk_container_add gledit,box1
gtk_box_pack_start box1,box2,0 0 0
gtk_box_pack_start box1,graf,1 1 0
gtk_box_pack_start box2,redisplay,0 0 0
gtk_box_pack_start box2,recover,0 0 0
gtk_box_pack_start box2,save,0 0 0
gtk_box_pack_end box2,close,0 0 0
gtk_box_pack_end box2,help,0 0 0
consig gledit;'destroy';'window_destroy'
consig redisplay;'clicked';'gledit_redisplay_button'
consig recover;'clicked';'gledit_recover_button'
consig save;'clicked';'gledit_save_button'
consig help;'clicked';'gledit_help_button'
consig close;'clicked';'gledit_close_button'
0
)

NB. =========================================================
NB. argument is definition
gledit_run=: 3 : 0
if. 0~:gledit do.
  gtk_window_present_with_time gledit,GDK_CURRENT_TIME
else.
  make_gledit''
end.
buf=. gtk_text_view_get_buffer graf
gtk_text_buffer_set_text buf; (graftext=: y); _1
gtk_widget_grab_focus graf
gtk_widget_show_all gledit
)

NB. =========================================================
getgraftext=: 3 : 0
iter1=. i.ITERSIZE [ iter2=. i.ITERSIZE
buf=. gtk_text_view_get_buffer graf
gtk_text_buffer_get_start_iter buf;iter1
gtk_text_buffer_get_end_iter buf;iter2
memr 0 _1 2,~ gtk_text_buffer_get_text buf;iter1;iter2;0
)

NB. =========================================================
gledit_close_button=: 3 : 0
graftext=: getgraftext''
GLEDTEXT=: graftext
gtk_widget_destroy ::0: gledit
gtk_window_present_with_time window,GDK_CURRENT_TIME
)

NB. =========================================================
window_destroy=: 3 : 0
gledit=: 0
0
)

NB. =========================================================
gledit_close=: gledit_close_button

NB. =========================================================
GEDITHELP=: 0 : 0
To experiment, modify the commands, then Redisplay.

See the OpenGL Utilities lab for examples of standalone scripts.
)

NB. =========================================================
gledit_help_button=: 3 : 0
sminfo 'OpenGL Demo';GEDITHELP
0
)

NB. =========================================================
gledit_redisplay_button=: 3 : 0
graftext=: getgraftext''
GLEDTEXT=: graftext
if. 0=window do.
  sminfo 'Cannot redisplay - OpenGL graphics window has been closed'
  0 return.
end.
try.
  gtk_window_present_with_time window,GDK_CURRENT_TIME
  gsetdefaults''
  0!:100 GLDEMODAT=: graftext
  gspaint''
  gtk_window_present_with_time gledit,GDK_CURRENT_TIME
catch.
  err=. LF,,LF,.}.;._2 [ 13!:12''
  sminfo 'error in OpenGL definition:',err
  0 return.
end.
0
)

NB. =========================================================
gledit_recover_button=: 3 : 0
graftext=: getgraftext''
if. 1= mbox 3; 'gledit';'OK to recover definition?' do.
  graftext=: freads tolower GLDEMOPATH,GLDEMOSEL,'.ijs'
  buf=. gtk_text_view_get_buffer graf
  gtk_text_buffer_set_text buf; graftext; _1
end.
0
)

NB. =========================================================
gledit_save_button=: 3 : 0
graftext=: getgraftext''
if. 1= mbox 3; 'gledit';'OK to save definition?' do.
  graftext fwrites tolower GLDEMOPATH,GLDEMOSEL,'.ijs'
end.
0
)
