require 'gl2 jzopengl'
coinsert 'jgtk jgl3'

a_run=: verb define
window1=: gtk_window_new GTK_WINDOW_TOPLEVEL
gloc=: 1 glcanvas_jgl2_ 'a';'g';300 300;coname''
gtk_container_add window1, canvas__gloc
consig window1;'destroy';'a_close'

R=: 0 0 0
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
if. </wh do.
  glOrtho _5 5,(_5 5*%%/wh), _5 5
else.
  glOrtho (_5 5*%/wh), _5 5 _5 5
end.
glClearColor 0 0 0 0
glClear GL_COLOR_BUFFER_BIT
bezier ''
glFlush''
0
)

bezier=: verb define
ctrlpoints=: _4 _4 0 _2 4 0 2 _4 0 4 4 0
glaMap1 GL_MAP1_VERTEX_3, 0, 1, 3,4, ctrlpoints
glEnable GL_MAP1_VERTEX_3
glColor 1 1 1 1
glBegin GL_LINE_STRIP
glEvalCoord1d"0 (i.30)%30
glEnd''
glPointSize 5
glColor 1 0 0 1
glBegin GL_POINTS
glVertex 4 3$ctrlpoints
glEnd''
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
