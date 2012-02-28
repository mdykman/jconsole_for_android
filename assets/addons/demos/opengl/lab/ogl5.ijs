NB. addons/demos/opengl/lab/ogl5.ijs

gl3lab_run=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;'gl3lab'
gloc=: 1 glcanvas_jgl2_ 'gl3lab';'g';200 200;coname''
gtk_container_add window, canvas__gloc
consig window;'destroy';'window_destroy'
gtk_widget_show_all window
)

gl3lab_g_paint =: verb define
wh=. wh__ogl
glClearColor 0 0 1 0
glClear GL_COLOR_BUFFER_BIT
glOrtho 0 2 0 2 0 2   NB. view is a box, xyz coords of 0 to 2
glMatrixMode GL_MODELVIEW
drawtriangle ''
)

drawtriangle =: verb define
glTranslated 1 1 _1            NB. shift triangle so it is in view
glRotated (0{R) , 1 0 0        NB. rotate x axes
glRotated (1{R) , 0 1 0        NB. rotate y axes
glRotated (2{R) , 0 0 1        NB. rotate z axes
glColor4d 1 0 0 0
glBegin GL_POLYGON
 glVertex  1 0 0
 glVertex 0 1 0
 glVertex _1 0 0
glEnd ''
)

R=: 0 0 0 NB. x y z rotations

dorot=: 3 : 0
R=: y
)
