NB. OpenGL viewer

require 'gl2 jzopengl'

cocurrent 'jgldemo'
coinsert 'jgtk jgl2 jgl3'

j=. 'TITLE BASIC1 BASIC2 BASIC3 BASIC4 BASIC5'
j=. j,' COLORED JBOX MODEL TEAPOT TRIANGLE'
j=. j,' TEXTB1'
NB. j=. j,' TANK SOLAR'
j=. j,' SOLAR'
j=. j,' BRAID LISSAJOU TREFOIL TORUS'
j=. j,' BUCKY SOCCER'
j=. j,' DINI ENNEPERS KUEN MOEBIUS SELLIPSE UMBTORUS WHITNEY'
j=. j,' HELIX INTSECT1 SEASHELL'
j=. j,' BOYS CROSSCAP KLEIN ROMAN CUPS DRUM'
GLDEMONAMES=: ;:j

GLDEMOVER=: 7.01
GLDEMOPATH=: jpath '~addons/demos/opengl/demo/'
GLSLIDES=: 0
gledit=: 0
RUNID1=: RUNID2=: 0

menu_button=: 0 : 0
opengl_Mxxx_button=: (3) : 0
'widget data'=. y
name=. 'xxx'
if. name -: GLDEMOSEL do.
  0 return.
end.
if. (<name) e. GLDEMONAMES do.
  if. 0~:RUNID1 do. RUNID1=: 0 [ g_source_remove RUNID1 end.
  GLSLIDES=: 0
  opengl_showname name return.
end.
0
)

NB. menu button event handler
3 : 0''
for_i. GLDEMONAMES do.
  0!:0 (')',LF),~ ('xxx';>i) stringreplace menu_button
end.
''
)

NB. =========================================================
make_main_window=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;(gettext 'OpenGL')
box1=. gtk_vbox_new 0 0
gloc=: 1 glcanvas_jgl2_ 'opengl';'g';480 360;coname''

NB. create a menu-bar to hold the menus
menu_bar=. gtk_menu_bar_new ''
NB. mac look-and-feel, moved to the top of desktop
if. UNAME-:'Darwin' do. ((>libigemac),' ige_mac_menu_set_menu_bar >n x')&cd ::0: menu_bar end.

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Options')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, opengl_view=. gtk_menu_item_new_with_mnemonic <(gettext '_View Definition')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, opengl_views=. gtk_menu_item_new_with_mnemonic <(gettext '_View Standalone Script')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, opengl_slides=. gtk_menu_item_new_with_mnemonic <(gettext '_Slide Show')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, opengl_exit=. gtk_menu_item_new_with_mnemonic <(gettext 'E_xit')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Basic')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MTITLE=: gtk_menu_item_new_with_mnemonic <(gettext 'OpenGL Graphics')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MBASIC1=: gtk_menu_item_new_with_mnemonic <(gettext '_Simple')
gtk_menu_shell_append menu, MBASIC2=: gtk_menu_item_new_with_mnemonic <(gettext '_Lighting')
gtk_menu_shell_append menu, MBASIC3=: gtk_menu_item_new_with_mnemonic <(gettext '_Two Objects')
gtk_menu_shell_append menu, MBASIC4=: gtk_menu_item_new_with_mnemonic <(gettext '_Viewing')
gtk_menu_shell_append menu, MBASIC5=: gtk_menu_item_new_with_mnemonic <(gettext '_Cylinders')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MCOLORED=: gtk_menu_item_new_with_mnemonic <(gettext 'C_olors')
gtk_menu_shell_append menu, MJBOX=: gtk_menu_item_new_with_mnemonic <(gettext '_J Logo')
gtk_menu_shell_append menu, MMODEL=: gtk_menu_item_new_with_mnemonic <(gettext '_Model')
gtk_menu_shell_append menu, MTEAPOT=: gtk_menu_item_new_with_mnemonic <(gettext 'Tea_pot')
gtk_menu_shell_append menu, MTRIANGLE=: gtk_menu_item_new_with_mnemonic <(gettext 'T_riangles')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''

gtk_menu_shell_append menu, menu1=. gtk_menu_item_new_with_mnemonic <(gettext 'Te_xtures')
gtk_menu_item_set_submenu menu1, menu2=. gtk_menu_new ''
gtk_menu_shell_append menu2, MTEXTB1=: gtk_menu_item_new_with_mnemonic <(gettext '_Basic')

gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MSOLAR=: gtk_menu_item_new_with_mnemonic <(gettext 'So_lar')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Knots')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MBRAID=: gtk_menu_item_new_with_mnemonic <(gettext '_Braid')
gtk_menu_shell_append menu, MLISSAJOU=: gtk_menu_item_new_with_mnemonic <(gettext '_Lissajous')
gtk_menu_shell_append menu, MTREFOIL=: gtk_menu_item_new_with_mnemonic <(gettext '_Trefoil')
gtk_menu_shell_append menu, MTORUS=: gtk_menu_item_new_with_mnemonic <(gettext 'T_orus')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Models')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MBUCKY=: gtk_menu_item_new_with_mnemonic <(gettext '_Bucky Ball')
gtk_menu_shell_append menu, MSOCCER=: gtk_menu_item_new_with_mnemonic <(gettext '_Soccer Ball')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Surface')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MDINI=: gtk_menu_item_new_with_mnemonic <(gettext '_Dini')
gtk_menu_shell_append menu, MENNEPERS=: gtk_menu_item_new_with_mnemonic <(gettext '_Enneper')
gtk_menu_shell_append menu, MKUEN=: gtk_menu_item_new_with_mnemonic <(gettext '_Kuen')
gtk_menu_shell_append menu, MMOEBIUS=: gtk_menu_item_new_with_mnemonic <(gettext '_Moebius')
gtk_menu_shell_append menu, MSELLIPSE=: gtk_menu_item_new_with_mnemonic <(gettext '_Super Ellipse')
gtk_menu_shell_append menu, MUMBTORUS=: gtk_menu_item_new_with_mnemonic <(gettext '_Umbilic Torus')
gtk_menu_shell_append menu, MWHITNEY=: gtk_menu_item_new_with_mnemonic <(gettext '_Whitney')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MHELIX=: gtk_menu_item_new_with_mnemonic <(gettext '_Helix')
gtk_menu_shell_append menu, MINTSECT1=: gtk_menu_item_new_with_mnemonic <(gettext '_Intersection')
gtk_menu_shell_append menu, MSEASHELL=: gtk_menu_item_new_with_mnemonic <(gettext '_Seashell')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MBOYS=: gtk_menu_item_new_with_mnemonic <(gettext '_Boys')
gtk_menu_shell_append menu, MCROSSCAP=: gtk_menu_item_new_with_mnemonic <(gettext '_Crosscap')
gtk_menu_shell_append menu, MKLEIN=: gtk_menu_item_new_with_mnemonic <(gettext '_Klein')
gtk_menu_shell_append menu, MROMAN=: gtk_menu_item_new_with_mnemonic <(gettext '_Roman')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MCUPS=: gtk_menu_item_new_with_mnemonic <(gettext 'Cu_ps')
gtk_menu_shell_append menu, MDRUM=: gtk_menu_item_new_with_mnemonic <(gettext '_Drum')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Help')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MF12=. gtk_menu_item_new_with_label <(gettext 'F12 Next')
gtk_menu_shell_append menu, MF12S=. gtk_menu_item_new_with_label <(gettext 'Shift F12 Previous')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, opengl_movement=. gtk_menu_item_new_with_mnemonic <(gettext '_Movement')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, opengl_about=. gtk_menu_item_new_with_mnemonic <(gettext '_About')

gtk_container_add window, box1
gtk_box_pack_start box1, menu_bar, 0 0 2
gtk_box_pack_start box1, canvas__gloc, 1 1 0    NB. take up remaining space

consig window;'destroy';'opengl_destroy'         NB. window destroyed

NB. ---------------------------------------------------------
NB. menu
consig opengl_view;'activate';'opengl_view_button'
consig opengl_views;'activate';'opengl_views_button'
consig opengl_slides;'activate';'opengl_slides_button'
consig opengl_exit;'activate';'opengl_exit_button'
consig MTITLE;'activate';'opengl_MTITLE_button'
consig MBASIC1;'activate';'opengl_MBASIC1_button'
consig MBASIC2;'activate';'opengl_MBASIC2_button'
consig MBASIC3;'activate';'opengl_MBASIC3_button'
consig MBASIC4;'activate';'opengl_MBASIC4_button'
consig MBASIC5;'activate';'opengl_MBASIC5_button'
consig MCOLORED;'activate';'opengl_MCOLORED_button'
consig MJBOX;'activate';'opengl_MJBOX_button'
consig MMODEL;'activate';'opengl_MMODEL_button'
consig MTEAPOT;'activate';'opengl_MTEAPOT_button'
consig MTRIANGLE;'activate';'opengl_MTRIANGLE_button'
consig MTEXTB1;'activate';'opengl_MTEXTB1_button'
consig MSOLAR;'activate';'opengl_MSOLAR_button'
consig MBRAID;'activate';'opengl_MBRAID_button'
consig MLISSAJOU;'activate';'opengl_MLISSAJOU_button'
consig MTREFOIL;'activate';'opengl_MTREFOIL_button'
consig MTORUS;'activate';'opengl_MTORUS_button'
consig MBUCKY;'activate';'opengl_MBUCKY_button'
consig MSOCCER;'activate';'opengl_MSOCCER_button'
consig MDINI;'activate';'opengl_MDINI_button'
consig MENNEPERS;'activate';'opengl_MENNEPERS_button'
consig MKUEN;'activate';'opengl_MKUEN_button'
consig MMOEBIUS;'activate';'opengl_MMOEBIUS_button'
consig MSELLIPSE;'activate';'opengl_MSELLIPSE_button'
consig MUMBTORUS;'activate';'opengl_MUMBTORUS_button'
consig MWHITNEY;'activate';'opengl_MWHITNEY_button'
consig MHELIX;'activate';'opengl_MHELIX_button'
consig MINTSECT1;'activate';'opengl_MINTSECT1_button'
consig MSEASHELL;'activate';'opengl_MSEASHELL_button'
consig MBOYS;'activate';'opengl_MBOYS_button'
consig MCROSSCAP;'activate';'opengl_MCROSSCAP_button'
consig MKLEIN;'activate';'opengl_MKLEIN_button'
consig MROMAN;'activate';'opengl_MROMAN_button'
consig MCUPS;'activate';'opengl_MCUPS_button'
consig MDRUM;'activate';'opengl_MDRUM_button'
consig MF12;'activate';'opengl_MF12_button'
consig MF12S;'activate';'opengl_MF12S_button'
consig opengl_movement;'activate';'opengl_movement_button'
consig opengl_about;'activate';'opengl_about_button'

)

NB. =========================================================
opengl_about_button=: 3 : 0
j=. 'OpenGL Graphics Demo V',4j2 ": GLDEMOVER
mbox 1;'OpenGL Graphics';j
0
)

opengl_g_paint=: paint
opengl_g_char=: gschar

NB. =========================================================
opengl_fctrl_fkey=: 3 : 0
start=. 6!:1''
for. i.100 do.
  0 gskey 88
  gspaint''
end.
time=. (6!:1'')-start
smoutput 'w h: ',(":glqwh_jgl2_''),' frames/sec: ',":100%time
)

NB. =========================================================
opengl_f12_fkey=: 3 : 0
ndx=. (#GLDEMONAMES) | >: GLDEMONAMES i. <GLDEMOSEL
opengl_showname ndx pick GLDEMONAMES
0
)

NB. =========================================================
opengl_f12shift_fkey=: 3 : 0
ndx=. (#GLDEMONAMES) | <: GLDEMONAMES i. <GLDEMOSEL
opengl_showname ndx pick GLDEMONAMES
0
)

NB. =========================================================
opengl_MF12_button=: opengl_f12_fkey
opengl_MF12S_button=: opengl_f12shift_fkey

NB. =========================================================
opengl_nextslide=: 3 : 0
ndx=. GLDEMONAMES i. <GLDEMOSEL
ndx=. (#GLDEMONAMES) | >:ndx
opengl_showname ndx pick GLDEMONAMES
)

NB. =========================================================
opengl_showname=: 3 : 0
GLDEMOSEL=: y
opengl_run''
)

NB. =========================================================
opengl_slides_button=: 3 : 0
GLSLIDES=: -. GLSLIDES
if. GLSLIDES do.
  RUNID1=: g_timeout_add_full G_PRIORITY_DEFAULT_IDLE;3000;cb1;(cbreg 'gldemo_slides','_',(>coname''),'_');0
else.
  if. 0~:RUNID1 do. RUNID1=: 0 [ g_source_remove RUNID1 end.
end.
0
)

NB. =========================================================
gldemo_slides=: 3 : 0
try.
  opengl_nextslide''
  1
catch.
  RUNID1=: 0
  0
end.
)

NB. =========================================================
opengl_exit_button=: 3 : 0
gtk_widget_destroy window
0
)

NB. =========================================================
MMKEYS=: 0 : 0
The following keys are active when an OpenGL graphic is displayed and has the current focus.

Keys!!Movement
i o!!in / out (shift = 5 steps at a time)
x y z!!Rotate about axis (shift = rotate back)
F5 F6 F7!!Rotate about axis by 45% (shift = rotate back)
Ctrl F5 F6 F7!Rotate about axis by 180%
j k l!!Move object in x, y, z direction (shift = move back)
up/down/left/right!Move view position (fly around)
PageUp/PageDown!Spin view position
1-9!!Change speed (1=slowest, 5=default, 9=fastest)
F3!!Snap current state
F4!!Return to snap state.
)

NB. =========================================================
opengl_movement_button=: 3 : 0
mbox 1;'OpenGL Graphics';TAB (I.MMKEYS='!') } MMKEYS
0
)

NB. =========================================================
opengl_run=: 3 : 0
opengl_run1 GLDEMODAT=: freads GLDEMOPATH,tolower GLDEMOSEL,'.ijs'
)

NB. =========================================================
opengl_run1=: 3 : 0
if. 0~:RUNID2 do. RUNID2=: 0 [ g_source_remove RUNID2 end.
gsetdefaults''
openglut_newsize=: 1
0!:100 y
gspaint''
gtk_widget_grab_focus canvas__gloc
)

NB. =========================================================
opengl_view_button=: 3 : 0
gledit_run GLDEMODAT
0
)

NB. =========================================================
opengl_views_button=: 3 : 0
dat=. freads GLDEMOPATH,'glviews.ijs'
new=. GLDEMODAT
new=. new #~ +./\ new ~: LF
new=. new #~ +./\. new ~: LF
ndx=. 1 i.~ 'XX' E. dat
txt=. (ndx{.dat),new,(2+ndx)}. dat
if. IFGTK do.
  textview 'View Definition';txt
else.
  (toHOST txt) 1!:2 <jpath '~temp/glviewtmp.ijs'
  xedit '~temp/glviewtmp.ijs'
end.
0
)

NB. =========================================================
opengl_destroy=: 3 : 0
'widget data'=. y
if. 0~:RUNID1 do. RUNID1=: 0 [ g_source_remove RUNID1 end.
if. 0~:RUNID2 do. RUNID2=: 0 [ g_source_remove RUNID2 end.
if. 0~:gledit do. gtk_widget_destroy ::0: gledit end.
if. -.IFGTK do. gtk_main_quit'' end.
cbfree''
0
)

NB. =========================================================
NB. opengl_clip_button=: 0 & opengl_clipper bind ''
NB. opengl_print_button=: 1 & opengl_clipper bind (jpath '~temp/gltemp.bmp')

opengl_clip_button=: ]
opengl_print_button=: ]

opengl_savebmp_button=: gswritebmp

NB. =========================================================
opengldemo=: 3 : 0

if. 0 ~: 4!:0 <'GLDEMOSEL' do.
  GLDEMOSEL=: 0 pick GLDEMONAMES
end.
gsetdefaults''
make_main_window''
NB. remove font demos from unix:
if. IFUNIX do.
  GLDEMONAMES=: GLDEMONAMES -. 'TITLE';'BASIC4';'JBOX'
  gtk_widget_set_sensitive MTITLE, 0
  gtk_widget_set_sensitive MBASIC4, 0
  gtk_widget_set_sensitive MJBOX, 0
end.

opengl_showname >@{.GLDEMONAMES
gtk_widget_show_all window

if. -.IFGTK do. gtk_main'' end.
)
