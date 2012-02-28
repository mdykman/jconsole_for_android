NB. addons/demos/opengl/lab/ogl_cube.ijs

require'opengl gl2 gl3'
coinsert'jgtk jgl3'

gl3lab_run=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;'gl3lab'
gloc=: 1 glcanvas_jgl2_ 'gl3lab';'g';200 200;coname''
gtk_container_add window, canvas__gloc
consig window;'destroy';'window_destroy'
gtk_widget_show_all window
)

window_destroy=: 3 : 0
'widget data'=. y
gl3lab_close''
0
)

gl3lab_close=: 3 : 0
gtk_widget_destroy ::0: window
window=: 0
cbfree''
)

gl3lab_g_paint=: 3 : 0
wh=. wh__ogl
if. newsize__gloc do. g_draw_init wh end.
newsize__gloc=: 0
g_draw''
)

gl3lab_g_char =: 3 : 0
dorot 360 | R + 2 * 'xyz' = {.sysdata
gtk_widget_queue_draw canvas__gloc
)

R=: 0 0 0

dorot=: 3 : 0
R=: y
)

NB. y is wh - cmds required for new render context
g_draw_init=: 3 : 0
glViewport 0 0,y
glMatrixMode GL_PROJECTION
glLoadIdentity''
gluPerspective 30, (%/y),1 10
)

g_draw=: 3 : 0
glClearColor 1 1 1 0
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glEnable GL_DEPTH_TEST
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslated 0 0 _8
glRotated R ,. 3 3 $ 1 0 0 0
drawbox ''
)

BLUE=:  0 0 1 0
GREEN=: 0 1 0 0
RED=:   1 0 0 0

drawbox=:3 : 0
p=. _1 ^ #: i.8
BLUE         polygon 0 1 3 2{p
GREEN        polygon 0 1 5 4{p
RED          polygon 0 2 6 4{p
(RED+BLUE)   polygon 4 5 7 6{p
(RED+GREEN)  polygon 1 3 7 5{p
(BLUE+GREEN) polygon 2 3 7 6{p
)

polygon=: 4 : 0
glColor4d x
glBegin GL_POLYGON
 glVertex y
glEnd ''
)
