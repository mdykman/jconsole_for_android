NB. GTK+2.0 tutorial example 1
NB.

require 'gui/gtk'

coclass 'm1'
coinsert 'jgtk'

main_quit=: 3 : 0
'widget event data'=. y
if. -.IFGTK do. gtk_main_quit '' end.
0
)

main=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
consig3 window;'delete-event';'main_quit'  NB. otherwise it may need to kill J session
gtk_widget_show window
if. -.IFGTK do. gtk_main '' end.
0
)

cocurrent 'base'
main_m1_''

