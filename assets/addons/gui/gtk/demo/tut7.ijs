NB. GTK+2.0 tutorial example 7
NB.
NB. gtkbuilder / glade

require 'gui/gtk'

coclass 'm7'
coinsert 'jgtk'

create=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
'builder window'=: 'window' gtkglade jpath'~addons/gui/gtk/demo/tut7.glade'
assert. 0~:builder
assert. 0~:window
NB. get view widget from builder
view=: gtk_builder_get_object builder;'text_view'
NB. get buffer widget from view
buffer=: gtk_text_view_get_buffer view
NB. display gladreport
smoutput gladereport''

gtk_widget_show window
if. -.IFGTK do. gtk_main'' end.
)

on_new_menu_item_activate=: 3 : 0
mbinfo'new'
)

on_open_menu_item_activate=: 3 : 0
mbinfo'open'
)

on_window_delete_event=: 3 : 0
0 NB. 0 allows delete to continue
)

on_quit_menu_item_activate=: 3 : 0
gtk_widget_destroy window
)

on_window_destroy=: 3 : 0
g_object_unref builder
if. -.IFGTK do. gtk_main_quit '' end.
destroy ''
)

destroy=: 3 : 0
NB.! remove cbreg entries
cbfree''
codestroy''
)

cocurrent 'base'
'' conew 'm7'
