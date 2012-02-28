NB. GTK+2.0 example
NB.
NB. draws some graphics
NB. reports mouse position in the session

require 'gui/gtk'

coclass 'm5'
coinsert 'jgtk'

GDK_CONFIGURE=: 13
GDK_EXPOSURE_MASK=: 2
GDK_KEY_PRESS_MASK=: 16b400
GDK_LEAVE_NOTIFY_MASK=: 16b2000
GDK_POINTER_MOTION_HINT_MASK=: 8

NB. =========================================================
configure_event=: 3 : 0
'widget event data'=. y
pxywh=: getGdkEventConfigure_xywh event
if. pixmap do.
  g_object_unref pixmap
end.
pixmap=: gdk_pixmap_new (getGtkWidgetWindow widget);(2{pxywh);(3{pxywh);_1
if. gc=0 do.
  win=. getGtkWidgetWindow graph
  gc=: gdk_gc_new <win
end.
paint''
0
)

NB. =========================================================
window_delete=: 3 : 0
'widget event data'=. y
smoutput 'window delete event occurred'
0
)

Destroy=: 3 : 0
'widget data'=. y
smoutput 'destroy event occurred'
if. -.IFGTK do. gtk_main_quit '' end.
destroy ''
0
)

NB. =========================================================
NB. redraw screen from backing pixmap
expose_event=: 3 : 0
'widget event data'=. y
fg_gc=. getGtkStylefg_gc getGtkWidgetstyle widget
win=. getGtkWidgetWindow widget
gdk_draw_drawable win;fg_gc;pixmap;0;0;;/pxywh
0
)

NB. =========================================================
motion_notify=: 3 : 0
'widget event data'=. y
mxy=: getGdkEventMotion_xy event
smoutput 'mouse: ',":mxy
0
)

NB. =========================================================
destroy=: 3 : 0
nms=. ;: 'button_press delete_event expose_event motion_notify'
removecallback each nms
codestroy ''
)

NB. =========================================================
setcolor=: 3 : 0
clr=. (0 0 0 0{a.), 1 (3!:4) (256 * y) + 255 * 127 < y
colormem=: clr
gdk_gc_set_rgb_fg_color gc;colormem
)

NB. =========================================================
main=: 3 : 0
gc=: 0
pixmap=: 0
colormem=: 10#' '
if. -.IFGTK do. gtkinit'' end.
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window ; 'GTK Drawing'
consig3 window;'delete-event';'window_delete'
consig window;'destroy';'Destroy'
gtk_container_set_border_width window,10

eventbox=: gtk_event_box_new ''
gtk_container_add window ;eventbox
events=. OR GDK_CONFIGURE,GDK_EXPOSURE_MASK,GDK_POINTER_MOTION_HINT_MASK
gtk_widget_set_events eventbox,events

graph=: gtk_drawing_area_new''
gtk_container_add eventbox,graph
gtk_widget_set_events graph,events
gtk_widget_set_size_request graph, 400 300
consig3 graph;'expose-event';'expose_event'
consig3 graph;'configure-event';'configure_event'
consig3 graph;'motion-notify-event';'motion_notify'

windowfinish''
if. -.IFGTK do. gtk_main '' end.

0
)

NB. =========================================================
destroy=: 3 : 0
cbfree ''
codestroy ''
)

NB. =========================================================
NB. this is the main drawing program
paint=: 3 : 0
setcolor 255 255 255
gdk_draw_rectangle pixmap,gc,1,pxywh

setcolor 255 0 0
gdk_draw_rectangle pixmap,gc,1,<.50 50,0.25 * _2 {. pxywh

setcolor 0 128 128
gdk_draw_arc pixmap,gc,1,100 100 200 200 0 14400

gtk_widget_queue_draw_area graph;;/pxywh
)

cocurrent 'base'
main_m5_''
