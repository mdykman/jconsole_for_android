require 'gl2 jzopengl'
coinsert 'jgtk jgl3'

a_run=: verb define
window1=: gtk_window_new GTK_WINDOW_TOPLEVEL
gloc=: 1 glcanvas_jgl2_ 'a';'g';300 300;coname''
gtk_container_add window1, canvas__gloc
consig window1;'destroy';'a_close'

R=: 20 30 0
gtk_widget_show_all window1
)

a_g_paint=: verb define
wh=. wh__ogl
glMatrixMode GL_PROJECTION
glLoadIdentity''
glPixelStorei GL_UNPACK_ALIGNMENT,1
glClearColor 1 1 1 1
glClear GL_COLOR_BUFFER_BIT
glColor 0 0 0 1
glRasterPos 20 20 0
glaBitmap 8 8 0 0 0 0 ;2#".'2b',32$'01'
glRasterPos 80 80 0
glaBitmap 8 8 0 0 0 0 ;_1 _1
glRasterPos 180 180 0
glaBitmap 8 8 2.5 2.5 2.5 2.5;_1 _1

glRasterPos 20 150 0
glPixelZoom 1 1
glaDrawPixels (20 20,GL_BLUE,GL_INT); 400 $ 2147482496

glPixelZoom 2 2
glRasterPos 0 200 0
glCopyPixels 0 0 100 100,GL_COLOR

NB. !!!remove ReadPixels for nonce
glPixelZoom 1 1
d=. glaReadPixels 0 0 100 100,GL_RGBA,GL_INT
glRasterPos 200 0 0
glaDrawPixels (100 100,GL_RGBA,GL_INT);d

glFlush''
0
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
