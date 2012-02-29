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
if. UseGlade do.
  g_object_unref GtkBuilder
end.
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
button1_clicked=: 3 : 0
'widget data'=. y
display_cat previous_cat''
0
)

NB. =========================================================
button2_clicked=: 3 : 0
'widget data'=. y
display_cat next_cat''
0
)

NB. =========================================================
button3_clicked=: 3 : 0
'widget data'=. y
if. #r=. this_cat <t=. tolower dltb memr 0 _1,~ gtk_entry_get_text ui_name do.
  display_cat r
else.
  saynotfound t
end.
0
)
