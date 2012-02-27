NB. edit graph definition

coclass 'jdplot'

graftext=: ''

NB. =========================================================
make_plotedit=: 3 : 0
plotedit=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title plotedit;'View Definition'
gtk_window_set_transient_for plotedit,window
gtk_window_set_destroy_with_parent plotedit,1
box1=. gtk_vbox_new 0 0
box2=. gtk_hbox_new 0 0
redisplay=. gtk_button_new_with_mnemonic <'_Redisplay'
help=. gtk_button_new_with_mnemonic <'_Help'
close=. gtk_button_new_with_mnemonic <'_Close'
graf=: gtk_text_view_new''
gtk_widget_set_size_request graf,416 200
gtk_container_add plotedit,box1
gtk_box_pack_start box1,box2,0 0 0
gtk_box_pack_start box1,graf,1 1 0
gtk_box_pack_start box2,redisplay,0 0 0
gtk_box_pack_end box2,close,0 0 0
gtk_box_pack_end box2,help,0 0 0
consig plotedit;'destroy';'window_destroy'
consig redisplay;'clicked';'plotedit_redisplay_button'
consig help;'clicked';'plotedit_help_button'
consig close;'clicked';'plotedit_close_button'
0
)

NB. =========================================================
NB. argument is name of definition
plotedit_run=: 3 : 0
GNAME=: 'D',y,(0=#y)#'JGRAPHICS'
if. 0~:plotedit do.
  gtk_window_present_with_time plotedit,GDK_CURRENT_TIME
else.
  make_plotedit''
end.
buf=. gtk_text_view_get_buffer graf
gtk_text_buffer_set_text buf; (graftext=: utf8 ".GNAME); _1
gtk_widget_grab_focus graf
gtk_widget_show_all plotedit
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
plotedit_close_button=: 3 : 0
graftext=: getgraftext''
GRAF=: graftext
GNAME assign graftext
gtk_widget_destroy ::0: plotedit
0
)

NB. =========================================================
window_destroy=: 3 : 0
plotedit=: 0
0
)

NB. =========================================================
plotedit_close=: plotedit_close_button

NB. =========================================================
PLOTEDITHELP=: 0 : 0
To experiment, modify the commands, then Redisplay.

To run a demo by itself, wrap the commands in reset and show.
In some cases, you need to reference data in locale jdplot.

For example, to run the 2D|Bar demo:

pd 'reset'
)

plotedit_help_button=: 3 : 0
sminfo 'Plot Demo';PLOTEDITHELP,DBAR,'pd ''show'''
0
)

NB. =========================================================
plotedit_redisplay_button=: 3 : 0
graftext=: getgraftext''
GRAF=: graftext
try.
  gtk_window_present_with_time PFormhwnd,GDK_CURRENT_TIME
  pd 'reset ',PForm
  plotrun graftext
  gtk_window_present_with_time plotedit,GDK_CURRENT_TIME
catch.
  sminfo 'error in graph definition'
  0 return.
end.
0
)

NB. =========================================================
NB. plotedit_sctrlshift_fkey
NB. ... development only
plotedit_sctrlshift_fkey=: 3 : 0
grf=. toJ graftext
grf=. (+./\. grf ~: LF) # grf
grf=. grf,LF
f=. jpath '~Plot/dev/demo/plexam.ijs'
dat=. freads f
sel=. GNAME,'=: 0 : 0',LF
ndx=. (#sel) + 1 i.~ sel E. dat
hdr=. ndx {. dat
dat=. ndx }. dat
ndx=. 1 + 1 i.~ (LF,')',LF) E. dat
mid=. ndx {. dat
ftr=. ndx }. dat
ftr=. ftr, LF -. {:ftr
new=. hdr,grf,ftr
new fwrites f
sminfo 'Plot';'Saved: ',GNAME
0
)
