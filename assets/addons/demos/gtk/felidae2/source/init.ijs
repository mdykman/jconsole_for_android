NB. init

magic_name00=: ''
UserFolders_j_=: ~. UserFolders_j_,~ ,:'felidae';({.~ i:&'/')^:2 jpathsep >(4!:3''){~ 4!:4 <'magic_name00'
4!:55 <'magic_name00'

coclass 'felidae2'
coinsert 'jgtk'

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

db_lineage=: 8 1 1 1

NB. =========================================================
create=: 3 : 0
if. -.IFGTK do.
  require 'gtk'
  gtkinit_jgtk_''
end.
NB. i18n using gnu gettext
bindtextdomain ::0: 'jfelidae';jpath '~felidae/share/locale'
bind_textdomain_codeset ::0: 'jfelidae';'UTF-8'
textdomain ::0: <'jfelidae'

make_main_window ''

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
