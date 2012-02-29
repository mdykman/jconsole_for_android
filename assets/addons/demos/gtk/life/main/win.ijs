NB. win

NB. =========================================================
life_win=: 3 : 0
newwindow 'Life'
gtk_window_set_resizable window,0
gtk_window_set_position window,GTK_WIN_POS_CENTER_ALWAYS
consig3 window;'key-press-event';'life_key_press'
vb=. gtk_vbox_new 0 0
gtk_container_set_border_width vb,0
gtk_box_pack_start vb,(life_menu''),0 0 0
gtk_box_pack_start vb,(life_toolbar''),0 0 0
gtk_box_pack_start vb,(life_graph''),0 0 0
gtk_container_add window,vb
windowfinish''
)

NB. =========================================================
life_graph=: 3 : 0
locGB=: glcanvas 'life';'g';(SCALE*|.BOARD);coname''
canvas__locGB
)

NB. =========================================================
life_toolbar=: 3 : 0
hb=. gtk_hbox_new 0 0
newxbutton hb;' Run ';'life_run_button'
newxbutton hb;' Pause ';'life_pause_button'
stepback=: newxbutton hb;' Back ';'life_back_button'
newxbutton hb;' Step ';'life_step_button'
gtk_box_pack_start hb,(newpad 15 0),0 0 0
labSize=: newlabel '1280x1024'
align=. gtk_alignment_new 0 0.5 0 0
gtk_container_add align,labSize
gtk_box_pack_start hb,align,0 0 0
gtk_box_pack_start hb,(newpad 15 0),0 0 0
labCount=: newlabel '12345'
align=. gtk_alignment_new 0 0.5 0 0
gtk_container_add align,labCount
gtk_box_pack_start hb,align,0 0 0
gtk_widget_show_all hb
hb
)

