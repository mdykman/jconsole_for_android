NB. addons/demos/opengl/lab/ogl_outlinefont_windows.ijs

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
metrics=: ('arial';30) glaUseFontOutlines__ogl 32 95 32 0 0.3,WGL_FONT_POLYGONS
)

g_draw=: 3 : 0
glMatrixMode GL_PROJECTION
glLoadIdentity ''
glOrtho 0 2 0 2 0 2
glClearColor 0 0 1 0
glClear GL_COLOR_BUFFER_BIT

glMatrixMode GL_MODELVIEW
glLoadIdentity ''

glRotated 20 0 1 0

glEnable GL_LIGHTING
glEnable GL_LIGHT0

lighttext''
glColor 1 1 1 0
glRasterPos 0 1 0
glaCallLists 'iiiiwwww'
)

lighttext=: 3 : 0
glaLight GL_LIGHT0, GL_AMBIENT, 0.6 0.6 0.6 1
glaLight GL_LIGHT0, GL_DIFFUSE, 0.9 0.9 1 1
glaLight GL_LIGHT0, GL_SPECULAR, 1 1 1 1
glaLight GL_LIGHT0, GL_POSITION, 1 1 1.1 1
glaMaterial GL_FRONT_AND_BACK,GL_SPECULAR, 1 1 1 1
glaMaterial GL_FRONT_AND_BACK,GL_SHININESS, 128 0 0 1
)
