NB. GTK+2.0 tutorial example 2
NB.
NB. note the connect_swapped call to destroy the window is moved
NB. into the connect handler.

require 'gui/gtk'

coclass 'm2'
coinsert 'jgtk'

hello=: 3 : 0
'widget data'=. y
smoutput 'Hello World'
0
)

window_delete=: 3 : 0
'widget event data'=. y
smoutput 'delete event occurred'
0 NB. 0=do delete, 1=cancel delete
)

Destroy=: 3 : 0
'widget data'=. y
smoutput 'destroy event occurred'
if. -.IFGTK do. gtk_main_quit '' end.
destroy ''
0
)

main=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
consig3 window;'delete-event';'window_delete'
consig window;'destroy';'Destroy'
gtk_container_set_border_width window, 10
button=. gtk_button_new_with_label <'Hello World'
consig button;'clicked';'hello'
gtk_container_add window, button
gtk_widget_set_size_request button, 200 100
gtk_widget_show button
gtk_widget_show window
if. -.IFGTK do. gtk_main '' end.
0
)

NB. =========================================================
destroy=: 3 : 0
cbfree ''
codestroy ''
)

cocurrent 'base'
main_m2_''

