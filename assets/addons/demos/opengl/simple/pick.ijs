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

gtk_widget_show_all window1
)

board=: 3 3 $ 0

a_g_paint=: verb define
wh=. wh__ogl
glViewport 0 0 ,wh
mm GL_PROJECTION
gluOrtho2D 0 3 0 3
mm GL_MODELVIEW
glaSelectBuffer 100
glClearColor 0 0 0 0
glClear GL_COLOR_BUFFER_BIT
drawsquares GL_RENDER
glFlush''
0
)

mm=: verb define
glMatrixMode y
glLoadIdentity''
)

drawsquares=: verb define
b=. y=GL_SELECT
i=. 0
while. i<3 do.
  if. b do. glLoadName i end.
  j=. 0
  while. j<3 do.
    if. b do. glPushName j end.
    glColor (i%3), (j%3) , (i{j{board) , 0
    glRect i,j, 1+i,j
    if. b do. glPopName'' end.
    j=. >:j
  end.
  i=. >:i
end.
)

a_g_mbldown=: verb define
wh=. wh__ogl
'w h'=. wh
'x y'=. 2{.".sysdata

len=. 20  NB. max 4 selections, 5 values each
select=. mema len*4     NB. allocate select buffer
(2 ic len$2-2)memw select,0,(len*4),JCHAR NB. clear buffer to 0 , GLunit is unsigned int
glaSelectBuffer len,select
glRenderMode GL_SELECT

glInitNames''
glPushName _1
glMatrixMode GL_PROJECTION

glPushMatrix''
glLoadIdentity''
gluaPickMatrix x , y , 5 5 , 0 0 , w , h
gluOrtho2D 0 3 0 3
drawsquares GL_SELECT
glPopMatrix''
glFlush''
glRenderMode GL_RENDER
selbuf=. _2 ic memr select,0,(len*4),JCHAR
memf select            NB. free select buffer

NB. we know each hit has 5 values (count, min, max, row, col)
selbuf=. _5[\ selbuf
selbuf=. selbuf #~ +./"1 selbuf ~: 0
selbuf=. _2 {."1 selbuf
mbox 1;'selected cell(s) row,col';,(":selbuf),.LF
)

a_help_button=: verb define
mbox 1;'OpenGL';'Click mouse on square or at corners.'
gtk_widget_grab_focus canvas__gloc
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
