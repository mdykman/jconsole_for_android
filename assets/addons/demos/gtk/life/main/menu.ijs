NB. life

NB. =========================================================
menu_init=: 3 : 0
f=. < @ (<;._1) @ (','&,)
j=. f;._2 Menus
MENUIDS=: {.&> j
MENUDEF=: }.each j
getmenu=: [: > MENUDEF {~ MENUIDS i. <
0
)

NB. =========================================================
Menus=: 0 : 0
fileload,gtk-open,Load Pattern File...,,Load Pattern File...,life_file_load
fileconfig,gtk-properties,Configure,,Configure,life_cfg_button
fileexit,gtk-quit,Exit,,Exit,cb_file_exit
patacorn,,Acorn,,Acron,cb_pat_acorn
patbigun,,Bi-Gun,,Bi-Gun,cb_pat_bigun
patglidergun,,Glider Gun,,Glider Gun,cb_pat_glidergun
patpuftrain,,Puffer Train,,Puffer Train,cb_pat_puftrain
patrabbits,,Rabbits,,Rabbits,cb_pat_rabbits
patcoerake1,,Rake,,Rake,cb_pat_coerake1
patrelay,,Relay,,Relay,cb_pat_relay
patspacegun,,Space Gun,,Space Gun,cb_pat_spacegun
patspiral,,Spiral Decay,,Spiral Decay,cb_pat_spiral
patrandom,,Random,,Random,cb_pat_random
helphelp,,Help,,Help,life_help_help
helpabout,gtk-about,About,,Help About,life_help_about
)

NB. =========================================================
life_menu=: 3 : 0
mb=. gtk_menu_bar_new''

pop=. create_menu_popup mb;'_File'
con=. create_menu_container pop
con ccmenu 'fileload'
create_menu_sep con
con ccmenu 'fileconfig'
create_menu_sep con
con ccmenu 'fileexit'

pop=. create_menu_popup mb;'_Patterns'
con=. create_menu_container pop
con ccmenu 'patacorn'
con ccmenu 'patbigun'
con ccmenu 'patglidergun'
con ccmenu 'patpuftrain'
con ccmenu 'patrabbits'
con ccmenu 'patcoerake1'
con ccmenu 'patrelay'
con ccmenu 'patspacegun'
con ccmenu 'patspiral'
create_menu_sep con
con ccmenu 'patrandom'

pop=. create_menu_popup mb;'_Help'
con=. create_menu_container pop
con ccmenu 'helphelp'
con ccmenu 'helpabout'

mb
)
