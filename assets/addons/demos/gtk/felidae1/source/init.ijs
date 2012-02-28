NB. init

coclass 'felidae1'
coinsert 'jgtk'

NB. there are 2 ways to design a window
NB. 1. use api call directly
NB. 2. use a RAD tool called 'Glade' to design and generate a xml format file
NB.    website http://glade.gnome.org

NB. both methods will be demonstrated, change the following name 'UseGlade'
NB. to 1 if you want to use the file from Glade
UseGlade=: 0

NB. current record position, 0-based
NB. _1 if no active record
current_cat=: _1

NB. preload database
db_name=: <;._2 [ 0 : 0
domestic cat
lion
tiger
snow leopard
)

db_genus=: <;._2 [ 0 : 0
felis
panthera
panthera
uncia
)

NB. =========================================================
create=: 3 : 0
if. -.IFGTK do.
  require 'gtk'
  gtkinit_jgtk_''
end.
NB. i18n using gnu gettext
bindtextdomain ::0: 'jfelidae';jpath '~install/gtk/share/locale'
bind_textdomain_codeset ::0: 'jfelidae';'UTF-8'
textdomain ::0: <'jfelidae'

if. UseGlade do.
  assert 0 -.@e. 'GtkBuilder window'=: 'window' gtkglade jpath '~Demos/gtk/felidae1/source/felidae.glade'
  assert. 0~: ui_name=: gtk_builder_get_object GtkBuilder;'ui_name'          NB. get id 
  assert. 0~: ui_genus=: gtk_builder_get_object GtkBuilder;'ui_genus'        NB. get id 
else.
  make_main_window ''
end.

NB. show top-level and all its widgets inside
gtk_widget_show_all window

NB. display first record
if. #db_name do.
  display_cat this_cat 0
else.
  clear_cat ''
end.

if. -.IFGTK do.
  gtk_main''
end.
0
)

NB. =========================================================
destroy=: 3 : 0
if. -.IFGTK do.
  gtk_main_quit''
end.
cbfree''
codestroy''
1
)
