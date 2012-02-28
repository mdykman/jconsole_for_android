NB. GTK+2.0 tutorial example 6
NB.
NB. gtkhtml2 layout engine
NB. this demo only run under linux with package libgtkhtml-2 installed

require 'gui/gtk'

cocurrent 'z'
libgtkhtml=. 'libgtkhtml-2.so.0'
html_document_new=: (libgtkhtml, ' html_document_new > x')&cd
html_document_open_stream=: (libgtkhtml, ' html_document_open_stream > i x *c')&cd
html_document_write_stream=: (libgtkhtml, ' html_document_write_stream > n x *c x')&cd
html_document_close_stream=: (libgtkhtml, ' html_document_close_stream > n x')&cd
html_view_new=: (libgtkhtml, ' html_view_new > x')&cd
html_view_set_document=: (libgtkhtml, ' html_view_set_document > n x x')&cd
html_stream_write=: (libgtkhtml, ' html_stream_write > n x *c x')&cd
html_stream_close=: (libgtkhtml, ' html_stream_close > n x')&cd

coclass 'm6'
coinsert 'jgtk'

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

getserver=: 4 : 0
if. '.'={. y do.
  y,~ (,&'/') 'http://', ({.~ i.&'/') (#'http://') }. (,&'/'^:('/'~:{:) x)
else.
  y
end.
)

request_url=: 3 : 0
'doc url stream data'=. y
try.
  html_stream_write stream ; (];#) 2!:0 ((UNAME-:'Darwin'){::'wget -q -O - ';'curl -s -S -o - '), u=. website getserver memr url, 0 _1
catch.
  smoutput 'error reading: ', u
end.
html_stream_close <stream
0
)

main=: 3 : 0
website=: y
if. -.IFGTK do. gtkinit'' end.
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
consig3 window;'delete-event';'window_delete'
consig window;'destroy';'Destroy'
gtk_container_set_border_width window, 10
try.
  doc=. html_document_new ''
catch.
  smoutput 'cannot load libgtkhtml'
  destroy ''
  0 return.
end.
consig4 doc;'request-url';'request_url'
html_document_open_stream doc ; 'text/html'
try.
  html_document_write_stream doc ; (];#) 2!:0 ((UNAME-:'Darwin'){::'wget -q -O - ';'curl -s -S -o - '), website
catch.
  smoutput 'error reading: ', website
end.
html_document_close_stream <doc
view=. html_view_new ''
html_view_set_document view ; doc
gtk_container_add window, view
gtk_widget_set_size_request view, 800 600
gtk_widget_show view
gtk_widget_show window
if. -.IFGTK do. gtk_main '' end.
0
)

NB. =========================================================
destroy=: 3 : 0
cbfree ''
codestroy ''
)

cocurrent 'base'
main_m6_ 'http://www.jsoftware.com'

