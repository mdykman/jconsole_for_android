NB. addons/demos/opengl/lab/ogl_pickcube.ijs

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
gluPerspective 60, (%/y),1 10
)

g_draw=: 3 : 0
draw''
)

R1 =: R2 =: 20 30 0
S =: 1
NB. glSelectBuffer 100

gl3lab_g_char =: verb define
k=.0{sysdata
if. S=1 do.
 R1 =: 360 | R1 + 2 * 'xyz' = {.sysdata end.
if. S=2 do.
 R2 =: 360 | R2 + 2 * 'xyz' = {.sysdata end.
gtk_widget_queue_draw canvas__gloc
)

gl3lab_g_mbldown =: verb define
wh=. wh__ogl
'xx yy' =. 2{.".sysdata
'w h'=. wh

select=. mema 16            NB. allocate select buffer
(4$2-2)memw select,0,4,JINT NB. clear buffer to 0
glaSelectBuffer 4,select
glRenderMode GL_SELECT
glInitNames''
glPushName _1
glMatrixMode GL_PROJECTION

glPushMatrix''
 glLoadIdentity''
 gluaPickMatrix xx , yy , 20 20, 0 0 , w , h
 gluPerspective 60, (w%h),1 10
 draw''
glPopMatrix''
glFlush''
glRenderMode GL_RENDER
S=: 3{memr select,0,4,JINT
smoutput S
memf select                 NB. free select buffer
)

BLUE=:  0 0 1
GREEN=: 0 1 0
RED=:   1 0 0

drawbox=:verb define
p=. _1 ^ #: i.8
BLUE         polygon 0 1 3 2{p
GREEN        polygon 0 1 5 4{p
RED          polygon 0 2 6 4{p
(RED+BLUE)   polygon 4 5 7 6{p
(RED+GREEN)  polygon 1 3 7 5{p
(BLUE+GREEN) polygon 2 3 7 6{p
)

polygon=: 4 : 0
glColor 4{.x,1
glBegin GL_POLYGON
 glVertex y
glEnd ''
)

draw=:verb define
glClearColor 1 1 1 0
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glEnable GL_DEPTH_TEST
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate 2 0 _8
glRotate R1 ,. 3 3 $ 1 0 0 0
glLoadName 1
drawbox ''
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate _2 0 _8
glRotate R2 ,. 3 3 $ 1 0 0 0
glLoadName 2
drawbox ''
)
