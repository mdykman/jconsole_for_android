NB. addons/demos/opengl/lab/oglut2.ijs

cocurrent 'plab'
require 'gl2 opengl'
coinsert 'jgtk jzopenglutil'

openglut_run=: 3 : 0
if. 0~:window_base_ do.
  gtk_window_present_with_time window,GDK_CURRENT_TIME
  gtk_widget_grab_focus canvas__gloc
  gtk_widget_queue_draw canvas__gloc
else.
  window_base_=: window=: gtk_window_new GTK_WINDOW_TOPLEVEL
  gtk_window_set_title window;'openglut'
  gloc=: 1 glcanvas_jgl2_ 'openglut';'g';400 300;coname''
  gtk_container_add window, canvas__gloc
  consig window;'destroy';'window_destroy'
  gtk_widget_show_all window
  wdmove window,_1 0   NB.! win32 requires wdmove after show
end.
)

window_destroy=: 3 : 0
'widget data'=. y
openglut_close''
0
)

openglut_close=: 3 : 0
gtk_widget_destroy ::0: window
window_base_=: 0
cbfree''
)

NB. =========================================================
paint=: 3 : 0
gsinit ''
gsdrawcube ''
gsfini ''
)

openglut_g_paint=: paint
openglut_g_char=: gschar
openglut_default=: gsdefault

NB. =========================================================
gsetdefaults''
GS_ROTXYZ=: 45 45 90
GS_TRNXYZ=: 0 1 0
openglut_run''
