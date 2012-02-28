NB. life configuration

wsize=: 100 _1
setwidth=: [: gtk_widget_set_size_request wsize,~]

NB. =========================================================
cfg_init=: 3 : 0
Nboard=: BOARD
Nscale=: SCALE
Nmaxiter=: MAXITER
Nmaxbuf=: MAXBUF
Nminrun=: MINRUN
Ntimer=: TIMER
)

NB. =========================================================
cfg_make=: 3 : 0
a=. GTK_FILL
b=. GTK_EXPAND + GTK_FILL
newwindow 'Life Config'

if. #locWin do.
  gtk_window_set_transient_for window,window__locWin
  gtk_window_set_destroy_with_parent window,1
  gtk_window_set_modal window,1
end.
gtk_window_set_position window,GTK_WIN_POS_CENTER_ALWAYS

NB. ---------------------------------------------------------
ecols=: newentry '';'cfg_reshow'
emaxbuf=: newentry '';'cfg_reshow'
emaxiter=: newentry '';'cfg_reshow'
eminrun=: newentry '';'cfg_reshow'
erows=: newentry '';'cfg_reshow'
escale=: newcombo (":each 1+i.8);'escale_select';''
etimer=: newentry '';'cfg_reshow'
sbestfit=: newbutton '  Best Fit  ';'bestfit_click'
spixels=: newlabel ''
srestore=: newbutton '  Restore  ';'restore_click'

setwidth ecols
setwidth emaxbuf
setwidth emaxiter
setwidth eminrun
setwidth erows
setwidth escale
setwidth etimer
setwidth spixels

NB. ---------------------------------------------------------
vb=. gtk_vbox_new 0 6
gtk_container_set_border_width vb, 6

NB. ---------------------------------------------------------
hb=. gtk_hbox_new 0 6

vb0=. gtk_vbox_new 0 0
gtk_box_pack_start vb0,srestore,0 0 0
gtk_box_pack_start vb0,sbestfit,0 0 0

f=. gtk_frame_new <'Size'
hb0=. gtk_hbox_new 0 0
t=. gtk_table_new 3 2 0
gtk_table_attach t,(newlabel 'Rows:'),0 1 0 1,a,0 0 0
gtk_table_attach t,(newlabel 'Cols:'),0 1 1 2,a,0 0 0
gtk_table_attach t,(newlabel 'Scale:'),0 1 2 3,a,0 0 0
gtk_table_attach t,(newlabel 'Pixels:'),0 1 3 4,a,0 0 4
gtk_table_attach t,erows,1 2 0 1 0 0 6 0
gtk_table_attach t,ecols,1 2 1 2 0 0 6 0
gtk_table_attach t,escale,1 2 2 3 0 0 6 0
gtk_table_attach t,spixels,1 2 3 4 0 0 6 0
gtk_box_pack_start hb0,t,0 0 3
gtk_box_pack_start hb0,vb0,0 0 3
gtk_container_add f,hb0
gtk_box_pack_start hb,f,0 0 0
gtk_box_pack_start hb,(newlabel ''),0 0 10

vb0=. gtk_vbox_new 0 0
gtk_container_set_border_width vb0,2
ok=. newbutton '   OK   ';'ok_click'
cancel=. newbutton '   Cancel   ';'cancel_click'
gtk_box_pack_start vb0,ok,0 0 0
gtk_box_pack_start vb0,cancel,0 0 0
gtk_box_pack_start hb,(newlabel''),1 1 0
gtk_box_pack_start hb,vb0,0 0 0
gtk_box_pack_start vb,hb,1 1 0

NB. ---------------------------------------------------------

f=. gtk_frame_new <'Counts'
vb0=. gtk_vbox_new 0 0
gtk_container_set_border_width vb0, 6

lab=. newlabelj Counts
gtk_label_set_line_wrap lab,1
align=. gtk_alignment_new 0 0 1 1
gtk_box_pack_start vb0,lab,1 1 0
gtk_box_pack_start vb0,(newpad 0 8),1 1 0

t=. gtk_table_new 2 3 0
gtk_table_attach t,(newlabel 'Max Buffer:'),0 1 0 1,a,0 0 0
gtk_table_attach t,(newlabel 'Max Iterations:'),0 1 1 2,a,0 0 0
gtk_table_attach t,emaxbuf,1 2 0 1 0 0 6 0
gtk_table_attach t,emaxiter,1 2 1 2 0 0 6 0
gtk_table_attach t,(newlabel 'default=100'),2 3 0 1,a,0 0 0
gtk_table_attach t,(newlabel 'empty if none'),2 3 1 2,a,0 0 0
gtk_box_pack_start vb0,t,0 0 0
gtk_container_add f,vb0
gtk_box_pack_start vb,f,1 1 0

NB. ---------------------------------------------------------
fa=. gtk_alignment_new 0 0 1 1
f=. gtk_frame_new <'Run'
vb0=. gtk_vbox_new 0 0
gtk_container_set_border_width vb0, 6
lab=. newlabelj Runs
gtk_label_set_line_wrap lab,1
gtk_box_pack_start vb0,lab,0 0 0
gtk_box_pack_start vb0,(newpad 0 8),1 1 0

t=. gtk_table_new 2 3 0
gtk_table_attach t,(newlabel 'Min Run:'),0 1 0 1,a,0 0 0
gtk_table_attach t,(newlabel 'Delay:'),0 1 1 2,a,0 0 0
gtk_table_attach t,eminrun,1 2 0 1 0 0 6 0
gtk_table_attach t,etimer,1 2 1 2 0 0 6 0
gtk_table_attach t,(newlabel 'default=10'),2 3 0 1,a,0 0 0
gtk_table_attach t,(newlabel 'default=1'),2 3 1 2,a,0 0 0
gtk_box_pack_start vb0,t,0 0 0
gtk_container_add f,vb0
gtk_box_pack_start vb,f,1 1 0

NB. ---------------------------------------------------------
gtk_container_add window,vb
gtk_widget_show_all window
)

NB. =========================================================
cfg_bbcolor_button=: 3 : 0
c=. mbcolor Nbcolor
if. #c do.
  Nbcolor=: c
  cfg_show''
end.

)

NB. =========================================================
cfg_bccolor_button=: 3 : 0
c=. mbcolor Nccolor
if. #c do.
  Nccolor=: c
  cfg_show''
end.
)

NB. =========================================================
cfg_bfd_button=: 3 : 0
Nboard=: |. <. MAXXYWHX % Nscale
cfg_show''
)


NB. =========================================================
cfg_newratio=: 3 : 0
Nboard=: ({.Nboard) * 1,y
cfg_show''
)

NB. =========================================================
cfg_newrows=: 3 : 0
ratio=. 1 1.25 1.5 2 1 {~ (bc1,bc125,bc15,bc2) i. '1'
Nboard=: y * 1,ratio
cfg_show''
)

NB. =========================================================
cfg_run=: 3 : 0
cfg_init''
cfg_make''
cfg_show''
)


