NB. GTK+2.0 tutorial example 3
NB.
NB. expanded "An Upgraded Hello World" with Quit button

require 'gui/gtk'

coclass 'm3'
coinsert 'jgtk'

NB. =========================================================
button1_click=: 3 : 0
'widget data'=. y
smoutput 'Hello again - button1 was pressed'
0
)

button2_click=: 3 : 0
'widget data'=. y
smoutput 'Hello again - button2 was pressed'
0
)

quitbutton_click=: 3 : 0
'widget data'=. y
gtk_widget_destroy window
)

NB. =========================================================
window_delete=: 3 : 0
'widget event data'=. y
smoutput 'window delete event occurred'
0 NB. 0=do delete, 1=cancel delete
)

Destroy=: 3 : 0
'widget data'=. y
smoutput 'destroy event occurred'
if. -.IFGTK do. gtk_main_quit '' end.
destroy ''
0
)

NB. =========================================================
main=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window ; 'Hello Buttons!'
consig3 window;'delete-event';'window_delete'
consig window;'destroy';'Destroy'
gtk_container_set_border_width window, 10
box1=. gtk_hbox_new 0 0
gtk_container_add window, box1

NB. ---------------------------------------------------------
button=. gtk_button_new_with_label <'Button 1'
consig button;'clicked';'button1_click'
gtk_box_pack_start box1, button, 1 1 0
gtk_widget_show button

NB. ---------------------------------------------------------
button=. gtk_button_new_with_label <'Button 2'
consig button;'clicked';'button2_click'
gtk_box_pack_start box1, button, 1 1 0
gtk_widget_show button

NB. additional Quit button
button=. gtk_button_new_with_label <'Quit'
consig button;'clicked';'quitbutton_click'
gtk_box_pack_start box1 , button , 1 1 0
gtk_widget_show button

NB. ---------------------------------------------------------
gtk_widget_show box1
gtk_widget_show window
if. -.IFGTK do. gtk_main '' end.
0
)

NB. =========================================================
destroy=: 3 : 0
cbfree ''
codestroy ''
)

NB. =========================================================
cocurrent 'base'
main_m3_''
