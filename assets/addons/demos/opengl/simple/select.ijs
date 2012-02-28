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

R=: 20 30 0
gtk_widget_show_all window1
)

t1=: 2 2 _5 ; 3 2 _5 ; 2.5 3 _5
t2=: 2 7 _5 ; 3 7 _5 ; 2.5 8 _5
t3=: 2 2 0 ; 3 2 0 ; 2.5 3 0
t4=: 2 2 _2 ; 3 2 _2 ; 2.5 3 _2

mm=: verb define
glMatrixMode y
glLoadIdentity''
)

a_g_paint=: verb define
wh=. wh__ogl
glDepthFunc GL_LEQUAL
glEnable GL_DEPTH_TEST
glShadeModel GL_FLAT
glaSelectBuffer 100
glViewport 0 0 ,wh
glClearColor 0 0 0 0
glClear GL_COLOR_BUFFER_BIT+GL_DEPTH_BUFFER_BIT
drawscene''
glFlush''
0
)

drawscene=: verb define
mm GL_PROJECTION
gluPerspective 40 1 0.01 100
mm GL_MODELVIEW
gluLookAt 7.5 7.5 12.5 2.5 2.45 _5 0 1 0
glColor 0 1 0 0
drawtriangle t1
glColor 1 0 0 0
drawtriangle t2
glColor 1 1 0 0
drawtriangle t3
drawtriangle t4
drawviewvolume 0 5 0 5 0 10
)

drawtriangle=: verb define
glBegin GL_TRIANGLES
glVertex >y
glEnd''
)

drawviewvolume=: verb define
'x1 x2 y1 y2 z1 z2'=. y
glColor 1 1 1 0
glBegin GL_LINE_LOOP
glVertex x1,y1,-z1
glVertex x2,y1,-z1
glVertex x2,y2,-z1
glVertex x1,y2,-z1
glEnd''

glBegin GL_LINE_LOOP
glVertex x1,y1,-z2
glVertex x2,y1,-z2
glVertex x2,y2,-z2
glVertex x1,y2,-z2
glEnd''

glBegin GL_LINES
glVertex x1,y1,-z1
glVertex x1,y1,-z2
glVertex x1,y2,-z1
glVertex x1,y2,-z2
glVertex x2,y1,-z1
glVertex x2,y1,-z2
glVertex x2,y2,-z1
glVertex x2,y2,-z2
glEnd''
)

selectobjects_z_=: verb define
wh=. wh__ogl
'w h'=. wh
len=. 15  NB. 3 selections, 5 values each
select=. mema len*4     NB. allocate select buffer
(2 ic len$2-2)memw select,0,(len*4),JCHAR NB. clear buffer to 0 , GLunit is unsigned int
glaSelectBuffer len,select
glRenderMode GL_SELECT
glInitNames ''
glPushName 0
glPushMatrix ''
mm GL_PROJECTION
glOrtho 0 5 0 5 0 5
mm GL_MODELVIEW
glLoadName 1
drawtriangle t1
glLoadName 2
drawtriangle t2
glLoadName 3
drawtriangle t3
glPushName 4
drawtriangle t4
glPopMatrix''
glFlush''
glRenderMode GL_RENDER
selbuf=. _2 ic memr select,0,(len*4),JCHAR
memf select            NB. free select buffer
NB. gtk_widget_queue_draw canvas__gloc
_5[\selbuf
)

feedback=: verb define
glFeedbackBuffer 1000, GL_3D_COLOR
glRenderMode GL_FEEDBACK
mm GL_PROJECTION
glOrtho 0 5 0 5 0 5
mm GL_MODELVIEW
drawtriangle t1
glPassThrough 3.3
drawtriangle t2
drawtriangle t3
drawtriangle t4
glFlush''
glRenderMode GL_RENDER
)

a_help_button=: verb define
mbox 1;'OpenGL';'Run selectobjects_jdemos_'''' in J Term window.'
gtk_widget_grab_focus canvas__gloc
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
