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
metrics=: ('arial';30) glaUseFontOutlines__ogl 32 95 32 0 0.3,WGL_FONT_POLYGONS
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
gluPerspective 30, (%/wh), 1 10
glOrtho 0 2 0 2 0 2
glClearColor 0 0 1 0
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glRotated 20 0 1 0
glEnable GL_LIGHTING
glEnable GL_LIGHT0
lighttext''
glTranslate _1.5 1 5
glColor 1 1 1 0
glRasterPos 0 1 0
glaCallLists 'ABC'
glFlush''
0
)

lighttext=: 3 : 0
glaLight GL_LIGHT0, GL_AMBIENT, 0.6 0.6 0.6 1
glaLight GL_LIGHT0, GL_DIFFUSE, 0.9 0.9 1 1
glaLight GL_LIGHT0, GL_SPECULAR, 1 1 1 1
glaLight GL_LIGHT0, GL_POSITION, 1 1 1.1 1
glaMaterial GL_FRONT_AND_BACK,GL_SPECULAR, 1 1 1 1
glaMaterial GL_FRONT_AND_BACK,GL_SHININESS, 128 0 0 1
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
