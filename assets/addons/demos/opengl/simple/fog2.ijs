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

MODE=: GL_EXP
gtk_widget_show_all window1
)

a_g_char=: verb define
MODE=: (1 i.~'123' = {.sysdata){GL_EXP,GL_EXP2,GL_LINEAR,MODE
gtk_widget_queue_draw canvas__gloc
)

a_g_paint=: verb define
wh=. wh__ogl
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
wh=. \:~wh
glOrtho _2.5 2.5,(_2.5*%~/wh),(2.5*%~/wh),_10 10
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glClearColor 0.5 0.5 0.5 1
glClear GL_COLOR_BUFFER_BIT+GL_DEPTH_BUFFER_BIT
fog''
sphere''
3 : 'glCallList SPHERE[glTranslate y[glLoadIdentity$0'"1] (i:2),.0,.->:i.5
glFlush''
0
)

fog=: verb define
glEnable GL_DEPTH_TEST
glaLight GL_LIGHT0, GL_POSITION, 0.5 0.5 3 0
glEnable GL_LIGHTING
glEnable GL_LIGHT0

glEnable GL_FOG
glaFog GL_FOG_MODE, MODE
glaFog GL_FOG_COLOR,0.5 0.5 0.5 1
glaFog GL_FOG_DENSITY,0.35
glHint GL_FOG_HINT, GL_DONT_CARE
glaFog GL_FOG_START, 1
glaFog GL_FOG_END, 5
)

sphere=: verb define
obj=. 0 pick gluNewQuadric''
glNewList (SPHERE=: 1 pick glGenLists 1),GL_COMPILE
glaMaterial GL_FRONT,GL_AMBIENT, 0.1745 0.01175 0.01175 0
glaMaterial GL_FRONT,GL_DIFFUSE, 0.61424 0.04136 0.04136 0
glaMaterial GL_FRONT,GL_SPECULAR, 0.727811 0.626959 0.626959 0
glaMaterial GL_FRONT,GL_SHININESS, (0.6*128), 0 0 0
gluQuadricNormals obj,GLU_SMOOTH
gluQuadricDrawStyle obj,GLU_FILL
gluSphere obj,0.4 32 32
glEndList''
gluDeleteQuadric obj
)

a_help_button=: verb define
mbox 1;'OpenGL';'Press 1, 2, and 3 to switch between fog functions.'
gtk_widget_grab_focus canvas__gloc
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
