NB. addons/demos/opengl/lab/ogl_simple.ijs

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

NB. y is wh - cmds required for new render context
g_draw_init=: 3 : 0
glViewport 0 0,y
)

g_draw=: 3 : 0
glClearColor 0 0 1 0
glClear GL_COLOR_BUFFER_BIT
glOrtho _1 1 _1 1 _1 1
glColor3d ?0 0 0
glBegin GL_POLYGON
 glVertex  1,0,0
 glVertex  0,1,0
 glVertex _1,0,0
glEnd ''
)

NB. press Ctrl+f to report frames/second
gl3lab_fctrl_fkey=: 3 : 0
glsel_jgl2_ gloc   NB. select canvas as target
start=. 6!:1''
for. i.100 do.
 gl3lab_g_paint''
end.
time=. (6!:1'')-start
smoutput 'w h: ',(":glqwh''),' frames/sec: ',":100%time
)

NB. y is wh
NB. get pixels from pixel buffer render context
get_pixels=: 3 : 0
wh=. wh__ogl
g_draw_init wh
g_draw''
r=. qpixels__qloc
r
)
