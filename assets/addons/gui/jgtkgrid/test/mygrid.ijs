require 'gui/jgtkgrid'

coclass 'mytest'
coinsert 'jgtk'
 
3 : 0''
if. -.IFGTK do. gtkinit'' end.
)

showgrid=: 3 : 0
GRID=: y
window=. gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;'mytest'
gtk_window_set_default_size window,640 480
consig window;'destroy';'windowdestroy'
vbox=. gtk_vbox_new 0 0
gtk_container_add window,vbox
hbox1=. gtk_hbox_new 0 0
hbox2=. gtk_hbox_new 0 0

clearcolbutton=. gtk_button_new_with_mnemonic <'C_lear Col'
consig clearcolbutton;'clicked';'clearcolcommand'
clearrowbutton=. gtk_button_new_with_mnemonic <'_Clear Row'
consig clearrowbutton;'clicked';'clearrowcommand'
insertcopybutton=. gtk_button_new_with_mnemonic <'_Insert-Copy Row'
consig insertcopybutton;'clicked';'insertcopycommand'
appendcopybutton=. gtk_button_new_with_mnemonic <'_Append-Copy Row'
consig appendcopybutton;'clicked';'appendcopycommand'
unselectrowbutton=. gtk_button_new_with_mnemonic <'_Unselect Row'
consig unselectrowbutton;'clicked';'unselectrowcommand'
unselectcolbutton=. gtk_button_new_with_mnemonic <'U_nselect Col'
consig unselectcolbutton;'clicked';'unselectcolcommand'
entry1=: gtk_entry_new''
setentry entry1;'''C_TYPE'';1;''T_HEAD'';''mygrid'''
entry2=: gtk_entry_new''
setentry entry2;'''N''&,@": each i.20 10'
updatebutton=. gtk_button_new_with_mnemonic <'Update _Grid'
consig updatebutton;'clicked';'updatecommand'

scrolled=. gtk_scrolled_window_new 0 0
gtk_scrolled_window_set_policy scrolled,GTK_POLICY_AUTOMATIC,GTK_POLICY_AUTOMATIC
gtk_container_add scrolled,T_TV__GRID

gtk_box_pack_start vbox,hbox1,0 0 5
gtk_box_pack_start vbox,hbox2,0 0 5
gtk_box_pack_start vbox,scrolled,1 1 5
gtk_box_pack_start hbox1,clearcolbutton,1 1 5
gtk_box_pack_start hbox1,clearrowbutton,1 1 5
gtk_box_pack_start hbox1,insertcopybutton,1 1 5
gtk_box_pack_start hbox1,appendcopybutton,1 1 5
gtk_box_pack_start hbox1,unselectrowbutton,1 1 5
gtk_box_pack_start hbox1,unselectcolbutton,1 1 5
gtk_box_pack_start hbox2,entry1,1 1 5
gtk_box_pack_start hbox2,updatebutton,0 0 5
gtk_box_pack_start hbox2,entry2,1 1 5
gtk_widget_show_all window
gtk_widget_show window

if. -.IFGTK do. gtk_main'' end.
0 0$0
)

clearcolcommand=: 3 : 0
setcol__GRID''
)

clearrowcommand=: 3 : 0
setrow__GRID''
)

insertcopycommand=: 3 : 0
insertcopyrow__GRID''
)
appendcopycommand=: 3 : 0
appendcopyrow__GRID''
)

unselectrowcommand=: 3 : 0
selectrow__GRID''
)

unselectcolcommand=: 3 : 0
selectcol__GRID''
)

updatecommand=: 3 : 0
(". getentry entry1) updategrid__GRID ". getentry entry2
)

windowdestroy=: 3 : 0
T_EVENTFLAG__GRID=: _1
gtk_widget_destroy T_TV__GRID
destroy__GRID''
cbfree''
if. -.IFGTK do. gtk_main_quit'' end.
0
)

cocurrent'base'

mygrid=: conew 'jgtkgrid'
create__mygrid i.20 10

handler__mygrid=: 3 : 0
'event dat'=. y
smoutput event,': ',tostring dat 
)

showgrid_mytest_ mygrid
