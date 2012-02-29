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
button1_clicked=: 3 : 0
'widget data'=. y
display_cat this_cat 0
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
display_cat this_cat <:#db_name
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
  if. 0<current_cat do.
    display_cat this_cat <:current_cat
  else.
    clear_cat''
  end.
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
(name;genus;lineage) update_cat <name
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
if. #r=. this_cat <t=. tolower dltb memr 0 _1,~ gtk_entry_get_text ui_name do.
  display_cat r
else.
  saynotfound t
end.
0
)
