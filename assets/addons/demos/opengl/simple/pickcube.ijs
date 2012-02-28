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

R1=: R2=: 20 30 0
S=: 1
gtk_widget_show_all window1
)

a_g_char=: verb define
if. S=1 do. R1=: 360 | R1 + 2 * 'xyz' = {.sysdata end.
if. S=2 do. R2=: 360 | R2 + 2 * 'xyz' = {.sysdata end.
gtk_widget_queue_draw canvas__gloc
)

a_g_paint=: verb define
wh=. wh__ogl
glaSelectBuffer 100
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
gluPerspective 60, (%/wh),1 10
draw''
glFlush''
0
)

a_g_mbldown=: verb define
wh=. wh__ogl
'w h'=. wh
'x y'=. 2{.".sysdata

len=. 5
select=. mema len*4     NB. allocate select buffer
(2 ic len$2-2)memw select,0,(len*4),JCHAR NB. clear buffer to 0 , GLunit is unsigned int
glaSelectBuffer len,select
glRenderMode GL_SELECT

glInitNames''
glPushName _1
glMatrixMode GL_PROJECTION

glPushMatrix''
glLoadIdentity''
gluaPickMatrix x , (h-y) , 5 5 , 0 0 , w , h
gluPerspective 60, (w%h),1 10
draw''
glPopMatrix''
glFlush''
glRenderMode GL_RENDER
selbuf=. _2 ic memr select,0,(len*4),JCHAR
memf select            NB. free select buffer
S=: 3 { selbuf
)

BLUE=: 0 0 1
GREEN=: 0 1 0
RED=: 1 0 0

drawbox=: verb define
p=. _1 ^ #: i.8
BLUE polygon 0 1 3 2{p
GREEN polygon 0 1 5 4{p
RED polygon 0 2 6 4{p
(RED+BLUE) polygon 4 5 7 6{p
(RED+GREEN) polygon 1 3 7 5{p
(BLUE+GREEN) polygon 2 3 7 6{p
)

polygon=: 4 : 0
glColor 4{.x,1
glBegin GL_POLYGON
glVertex y
glEnd ''
)

draw=: verb define
glClearColor 1 1 1 0
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glEnable GL_DEPTH_TEST
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate 2 0 _8
glRotate R1 ,. 3 3 $ 1 0 0 0
glLoadName 1
drawbox ''
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate _2 0 _8
glRotate R2 ,. 3 3 $ 1 0 0 0
glLoadName 2
drawbox ''
)

a_help_button=: verb define
mbox 1;'OpenGL';'Rotate selected cube with x y z keys. Select cube with mouse click.'
gtk_widget_grab_focus canvas__gloc
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
