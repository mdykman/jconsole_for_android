require 'gl2 jzopengl'
coinsert 'jgtk jgl3'

a_run=: verb define
window1=: gtk_window_new GTK_WINDOW_TOPLEVEL
gloc=: 1 glcanvas_jgl2_ 'a';'g';300 300;coname''
gtk_container_add window1, canvas__gloc
consig window1;'destroy';'a_close'

gtk_widget_show_all window1
)

a_g_paint=: verb define
wh=. wh__ogl
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
glOrtho 0 1 0 1 _1 1
glEnable GL_BLEND
glBlendFunc GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA
glShadeModel GL_FLAT
glClearColor 0 0 0 0
glClear GL_COLOR_BUFFER_BIT

glColor 1 1 0 0.75
glRect 0 0 0.5 1

glColor 0 1 1 0.75
glRect 0 0 1 0.5

glColor 0 1 1 0.75
glRect 0.5 0.5 1 1

glColor 1 1 0 0.75
glRect 0.5 0.5 1 1

glFlush''
1
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
