NB. addons/demos/opengl/lab/ogl1.ijs

gl3lab_run=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;'gl3lab'
gloc=: 1 glcanvas_jgl2_ 'gl3lab';'g';200 200;coname''
gtk_container_add window, canvas__gloc
consig window;'destroy';'window_destroy'
gtk_widget_show_all window
)

gl3lab_g_paint=: 3 : 0
wh=. wh__ogl
glClearColor 0 0 1 0
glClear GL_COLOR_BUFFER_BIT
glOrtho _1 1 _1 1 _1 1
glColor3d 0 0 0
glBegin GL_POLYGON
 glVertex 1  ,0  ,0,1
 glVertex 0  ,1  ,0,1
 glVertex _1 ,0  ,0,1
glEnd ''
)
