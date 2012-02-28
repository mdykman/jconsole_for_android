NB. note glaUseFontBitmaps supported in Windows only

require 'gl2 jzopengl'
coinsert 'jgtk jgl3'

a_run=: verb define
window1=: gtk_window_new GTK_WINDOW_TOPLEVEL
gloc=: 1 glcanvas_jgl2_ 'a';'g';300 300;coname''
gtk_container_add window1, canvas__gloc
consig window1;'destroy';'a_close'

TEXT=: 'Type stuff here: '
gtk_widget_show_all window1
)

a_g_char=: verb define
TEXT=: TEXT, utf8 {.sysdata
gtk_widget_queue_draw canvas__gloc
)

a_g_paint=: verb define
wh=. wh__ogl
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
glOrtho 0 2 0 2 0 2
glClearColor 1 1 1 0
glClear GL_COLOR_BUFFER_BIT
glColor 1 0 0 1
glMatrixMode GL_MODELVIEW
glLoadIdentity ''
glRasterPos 0 1 0
('arial';30) glaUseFontBitmaps__ogl 32 95 32
glaCallLists TEXT
glFlush''
0
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
