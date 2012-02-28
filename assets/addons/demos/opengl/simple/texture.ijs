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

R=: 120 30 0
gtk_widget_show_all window1
)

a_g_char=: verb define
R=: 360 | R + 2 * 'xyz' = {.sysdata
gtk_widget_queue_draw canvas__gloc
)

a_g_paint=: verb define
wh=. wh__ogl
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
gluPerspective 60 1 1 30
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate 0 0 _3.6
texture ''
glFlush''
0
)

w=. 8 8$_1
b=. 8 8$0
pattern=: ,64 64$, (8 64$,w,.b),8 64$,b,.w

NB. note GL_RGBA so that pattern is 1 integer per texel
texture=: verb define
glClearColor 0 0 0 0
glEnable GL_DEPTH_TEST
glDepthFunc GL_LEQUAL
glPixelStorei GL_UNPACK_ALIGNMENT, 1

glaTexImage GL_TEXTURE_2D, 0 3 64 64 0, GL_RGBA, GL_UNSIGNED_BYTE,pattern

glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_WRAP_S,GL_CLAMP
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_WRAP_T,GL_CLAMP
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER,GL_NEAREST
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,GL_NEAREST

glTexEnvi GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL
glEnable GL_TEXTURE_2D
glShadeModel GL_FLAT

glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glBegin GL_QUADS

glTexCoord4d 0 0 0 1
glVertex _2 _1 0

glTexCoord4d 0 1 0 1
glVertex _2 1 0

glTexCoord4d 1 1 0 1
glVertex 0 1 0

glTexCoord4d 1 0 0 1
glVertex 0 _1 0


glTexCoord4d 0 0 0 1
glVertex 1 _1 0

glTexCoord4d 0 1 0 1
glVertex 1 1 0

glTexCoord4d 1 1 0 1
glVertex 2.41421 1 _1.41421

glTexCoord4d 1 0 0 1
glVertex 2.41421 _1 _1.41421

glEnd''
)

a_help_button=: verb define
mbox 1;'OpenGL';'Press the x y and z keys to rotate the texture.'
gtk_widget_grab_focus canvas__gloc
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
