NB. init

3 : 0''
if. _1= 4!:0 <'StandAlone_j_' do. StandAlone_j_=: 0 end.   NB. for standalone script
magic_name00=: ''
NB. fix relative path
if. -. (':'={:2{.p) +. '/'={.p=. jpathsep >(4!:3''){~ 4!:4 <'magic_name00' do.
  p=. (1!:43''),'/',p
end.
4!:55 <'magic_name00'
UserFolders_j_=: ~. UserFolders_j_,~ ,:'felidae';({.~ i:&'/')^:2 p
''
)

require 'data/jdb'

coclass 'felidae3'
coinsert 'jgtk'

NB. current record key
NB. '' if no active record
current_cat=: ''
current_imagedata=: ''

NB. =========================================================
create=: 3 : 0
if. -.IFGTK do.
  require^:(-.StandAlone_j_) 'gtk'
  gtkinit_jgtk_''
end.
NB. i18n using gnu gettext
bindtextdomain ::0: 'jfelidae';jpath '~felidae/share/locale'
bind_textdomain_codeset ::0: 'jfelidae';'UTF-8'
textdomain ::0: <'jfelidae'

NB. open database
locfd=: Open_jdb_ jpath '~temp'
locdb=: Open__locfd 'felidae'

make_main_window ''

NB. show top-level and all its widgets inside
gtk_widget_show_all window

NB. display first record
display_cat first_cat ''

if. -.IFGTK do.
  gtk_main''
end.
0
)

NB. =========================================================
destroy=: 3 : 0
destroy__locdb ''   NB. close database
Close_jdb_ locfd    NB. close folder
if. -.IFGTK do.
  gtk_main_quit''
end.
cbfree''
codestroy''
exit^:StandAlone_j_ 0
)
