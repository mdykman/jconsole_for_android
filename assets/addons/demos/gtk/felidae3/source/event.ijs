NB. event handler

NB. =========================================================
NB. not used for this demo
window_delete=: 3 : 0
'widget event data'=. y
NB. return 1 if cancel delete
0
)

NB. =========================================================
window_destroy=: 3 : 0
'widget data'=. y
destroy''
0
)

NB. =========================================================
NB. not used for this demo
window_configure=: 3 : 0
'widget event data'=. y
0
)

NB. =========================================================
NB. bind F12 to aboutbox
window_key_press=: 3 : 0
'widget event data'=. y
'state key'=. _2 ic memr event, GdkEventKey, 8 ,JCHAR
NB. mod1 is usually alt
'shift lock control mod1 mod2 mod3 mod4 mod5 button1 button2 button3 button4 button5'=. 13{. state=. |.(32#2) #: GDK_MODIFIER_MASK (17 b.) state
'super hyper meta'=. 26 27 28{state
if. key = GDK_F1 + <:12 do.
  if. 0 0 0 -: control, shift, meta do.
    aboutbox''
    1 return. NB. do not continue to process
  end.
end.
0
)

NB. =========================================================
NB. not used for this demo
quit_activate=: 3 : 0
'widget data'=. y
gtk_widget_destroy window
0
)

NB. =========================================================
button1_clicked=: 3 : 0
'widget data'=. y
display_cat first_cat ''
0
)

NB. =========================================================
button2_clicked=: 3 : 0
'widget data'=. y
display_cat previous_cat''
0
)

NB. =========================================================
button3_clicked=: 3 : 0
'widget data'=. y
display_cat next_cat''
0
)

NB. =========================================================
button4_clicked=: 3 : 0
'widget data'=. y
display_cat last_cat ''
0
)

NB. =========================================================
button5_clicked=: 3 : 0
'widget data'=. y
clear_cat ''
0
)

NB. =========================================================
button6_clicked=: 3 : 0
'widget data'=. y
if. 1= yesnoquestion t=. tolower dltb memr 0 _1,~ gtk_entry_get_text ui_name do. 0 return. end.
if. 0= delete_cat <t do.
  current_cat=: ''
  clear_cat''
else.
  clear_cat''
end.
0
)

NB. =========================================================
button7_clicked=: 3 : 0
'widget data'=. y
if. 0= #name=. tolower dltb memr 0 _1,~ gtk_entry_get_text ui_name do. 0 return. end.
genus=. tolower dltb memr 0 _1,~ gtk_entry_get_text ui_genus
lineage=. <. gtk_spin_button_get_value ui_lineage
picture=. current_imagedata
m1=. i.ITERSIZE [ m2=. i.ITERSIZE   NB. no multiple assignment
gtk_text_buffer_get_start_iter ui_sypnosis_buffer;m1
gtk_text_buffer_get_end_iter ui_sypnosis_buffer;m2
sypnosis=. memr 0 _1,~ g=. gtk_text_buffer_get_text ui_sypnosis_buffer;m1;m2;1
g_free g
(name;genus;lineage;picture;sypnosis) update_cat <name
display_cat this_cat <name
0
)

NB. =========================================================
button8_clicked=: 3 : 0
'widget data'=. y
aboutbox''
0
)

NB. =========================================================
button9_clicked=: 3 : 0
'widget data'=. y
'selectlist' conew~ ('callb', '_',(>coname''),'_') ; 0 0 1 ; ('name';'genus';'lineage') ; < db_name ,. db_genus ,. <"0 db_lineage
0
)

NB. =========================================================
callb=: 3 : 0
if. #r=. this_cat <y do.
  display_cat r
  gtk_widget_queue_draw window
else.
  saynotfound y
end.
0
)

NB. =========================================================
NB. dialogbox for choosing picture file
button10_clicked=: 3 : 0
'widget data'=. y
file_chooser=. gtk_file_chooser_dialog_new (gettext 'select a picture'); window; GTK_FILE_CHOOSER_ACTION_OPEN; GTK_STOCK_OPEN;GTK_RESPONSE_ACCEPT; GTK_STOCK_CANCEL; GTK_RESPONSE_CANCEL; 0
gtk_file_chooser_set_current_folder file_chooser; jpath '~felidae/data'
file_filter1=. gtk_file_filter_new ''
gtk_file_filter_set_name file_filter1; (gettext 'picture file(*.jpg, *.png)')
gtk_file_filter_add_pattern"1 file_filter1;"0 (toupper&.> , ]) '*.jpg';'*.png'
gtk_file_chooser_add_filter file_chooser, file_filter1
res=. gtk_dialog_run file_chooser
if. GTK_RESPONSE_ACCEPT = res do.
  file_name=. gtk_file_chooser_get_filename file_chooser
  if. _1 -.@-: data=. 1!:1 ::_1: < memr file_name, 0 _1 do.
    current_imagedata=: data
    data dispimagedata ui_picture
  end.
  g_free file_name
end.
gtk_widget_destroy file_chooser
0
)

NB. =========================================================
NB. toggle sypnosis read only
button11_clicked=: 3 : 0
'widget data'=. y
gtk_widget_set_sensitive ui_sypnosis, -.gtk_toggle_button_get_active widget
0
)

