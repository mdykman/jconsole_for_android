require 'gl2 jzopengl'
coinsert 'jgtk jgl3'

a_run=: verb define
window1=: gtk_window_new GTK_WINDOW_TOPLEVEL
box1=. gtk_vbox_new 0 0
gloc=: 1 glcanvas_jgl2_ 'a';'g';300 300;coname''

NB. create a menu-bar to hold the menus
menu_bar=. gtk_menu_bar_new ''
NB. mac look-and-feel, moved to the top of desktop
if. UNAME-:'Darwin' do. ((>libigemac),' ige_mac_menu_set_menu_bar >n x')&cd ::0: menu_bar end.

NB. another root menu inside menu-bar for help menu item
gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Help')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

NB. Create a new menu-item with a name (without the _ character) and set an image to it
menu_item_help=. gtk_image_menu_item_new_with_label <(gettext 'help')
gtk_image_menu_item_set_image menu_item_help, gtk_image_new_from_stock 'gtk-help'; GTK_ICON_SIZE_MENU
gtk_menu_shell_append menu, menu_item_help

gtk_container_add window1, box1
gtk_box_pack_start box1, menu_bar, 0 0 2
gtk_box_pack_start box1, canvas__gloc, 1 1 0    NB. take up remaining space

consig window1;'destroy';'a_close'

consig menu_item_help;'activate';'a_help_button'

FILL=: 0
STEPS=: 4
gtk_widget_show_all window1
)

a_g_char=: verb define
STEPS=: 100 <. STEPS + 's' = k=. {.sysdata 
STEPS=: 0 >. STEPS - 'a' = k
FILL=: ('f'=k) { FILL,-.FILL
gtk_widget_queue_draw canvas__gloc
)

a_g_paint=: verb define
wh=. wh__ogl
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
if. </wh do.
  glOrtho _5 5,(_5 5*%%/wh), _5 5
else.
  glOrtho (_5 5*%/wh), _5 5 _5 5
end.
light''
surface ''
glFlush''
0
)

b2dpts=: noun define
_1.5 _1.5  4
_0.5 _1.5  2
 0.5 _1.5 _1
 1.5 _1.5  2
_1.5 _0.5  1
_0.5 _0.5  3
 0.5 _0.5  0
 1.5 _0.5 _1
_1.5  0.5  4
_0.5  0.5  0
 0.5  0.5  3
 1.5  0.5  4
_1.5  1.5 _2
_0.5  1.5 _2
 0.5  1.5  0
 1.5  1.5 _1
)

surface=: verb define
x=. b2dpts
x=. ' ' ((x=LF)#i.#x)} x
points=: ".x
glClearColor 0 0 0 1
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glColor 1 1 1 1
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glaMap2 GL_MAP2_VERTEX_3,0 1 3 4 0 1 12 4, points
glEnable GL_MAP2_VERTEX_3
glEnable GL_AUTO_NORMAL
glMapGrid2d STEPS,0 1,STEPS,0 1
glEnable GL_DEPTH_TEST
glShadeModel GL_FLAT
glRotate 85 1 1 1
glEvalMesh2 (FILL{GL_LINE,GL_FILL),0,STEPS,0,STEPS
)

light=: verb define
if. FILL do.
  glaLight GL_LIGHT0, GL_AMBIENT, 0.1 0.1 0.1 1
  glaLight GL_LIGHT0, GL_DIFFUSE, 0.7 0.7 0.7 1
  glaLight GL_LIGHT0,GL_SPECULAR, 0.0 0.0 0.0 1
  glEnable GL_LIGHTING
  glEnable GL_LIGHT0
  glaMaterial GL_FRONT,GL_AMBIENT_AND_DIFFUSE, 1 0 0 1
else.
  glDisable GL_LIGHTING
end.
)

a_help_button=: verb define
mbox 1;'OpenGL';'Press a and s keys to changes steps, f key to toggle line and fill.'
gtk_widget_grab_focus canvas__gloc
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
