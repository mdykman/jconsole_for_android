NB. GTK+2.0 tutorial example 5
NB.
NB. uses pango to draw text
NB.
NB. underline and angle not supported

require 'gui/gtk'

coclass 'm5'
coinsert 'jgtk'


cFontdef=: 'serif' ; 20 ; 3 ; 0

window_delete=: 3 : 0
'widget event data'=. y
smoutput 'window delete event occurred'
0 NB. 0=do delete, 1=cancel delete
)

Destroy=: 3 : 0
'widget data'=. y
smoutput 'destroy event occurred'
if. -.IFGTK do. gtk_main_quit '' end.
destroy ''
0
)
NB. =========================================================
main=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window ; 'Hello!'
windowdefaultsize 260 120
consig3 window;'delete-event';'window_delete'
consig window;'destroy';'Destroy'
gtk_container_set_border_width window, 10

vbox1=. gtk_vbox_new 0 0
gtk_widget_show vbox1
gtk_container_add window , vbox1
fixed1=. gtk_fixed_new ''
gtk_widget_show fixed1
gtk_box_pack_start vbox1 , fixed1 , 0 0 0

button=. gtk_button_new_with_label <'Button 2'
'font asize style angle'=. cFontdef
st=. (|. 2 2 2#:style)#'italic' ; 'bold' ; ''
fd=. pango_font_description_from_string <'"', font, '"', (;' ' ,&.> st), ' ', (":asize)
children=. gtk_container_get_children button
label=. g_list_nth_data children,0
gtk_widget_modify_font label,fd
g_list_free children
gtk_widget_show button
cxywh=. 10 15 100 20
gtk_fixed_put fixed1, button , +: 2{.cxywh
gtk_widget_set_size_request button , +: 2}.cxywh
pango_font_description_free fd

gtk_widget_show ,window
if. -.IFGTK do. gtk_main '' end.
0
)

NB. =========================================================
destroy=: 3 : 0
cbfree ''
codestroy ''
)

cocurrent'base'
main_m5_''
