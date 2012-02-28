NB. addons/demos/opengl/lab/ogl7.ijs

gl3lab_run=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;'gl3lab'
gloc=: 1 glcanvas_jgl2_ 'gl3lab';'g';200 200;coname''
gtk_container_add window, canvas__gloc
consig window;'destroy';'window_destroy'
gtk_widget_show_all window
)

gl3lab_g_char =: 3 : 0
dorot 360 | R + 2 * 'xyz' = {.sysdata
gtk_widget_queue_draw canvas__gloc
)

gl3lab_g_paint =: 3 : 0
wh=. wh__ogl
glClearColor 0 0 1 0
glClear GL_COLOR_BUFFER_BIT
glOrtho 0 2 0 2 0 2   NB. view is a box, xyz coords of 0 to 2
glMatrixMode GL_MODELVIEW
drawtriangle ''
)

drawtriangle =: verb define
glTranslated 1 1 _1            NB. shift triangle so it is in view
glRotated R ,. 3 3 $ 1 0 0 0          NB. rotate xyz
glColor4d 1 0 0 0
glBegin GL_POLYGON
 glVertex  1 0 0 , 0 1 0 ,: _1 0 0   NB. triangle
glEnd ''
)

R=: 0 0 0

dorot=: 3 : 0
R=: y
)
