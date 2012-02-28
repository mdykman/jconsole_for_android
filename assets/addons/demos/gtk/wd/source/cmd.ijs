NB. cmd

wdccbutton=: 3 : 0
c=. gtk_button_new ''
gtk_widget_set_name c;y
gtk_widget_set_size_request c,_2{.Cxywh
addchild c;2{.Cxywh
Cchild=: c
Cchildname=: y
consig__Cparentloc c;'clicked';(Cparentname,'_',Cchildname,'_button')
)

wdccedit=: 3 : 0
c=. gtk_entry_new ''
gtk_widget_set_name c;y
gtk_widget_set_size_request c,_2{.Cxywh
addchild c;2{.Cxywh
Cchild=: c
Cchildname=: y
consig3__Cparentloc c;'key-press-event';(Cparentname,'_',Cchildname,'_button')
)

wdcn=: 3 : 0
gtk_button_set_label Cchild;y
)

wdpc=: 3 : 0
'loc name'=. y
loc=. <loc
c=. gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_widget_set_name c;name
vb=. gtk_vbox_new 0 0
fb=. gtk_fixed_new''
gtk_container_add c,vb
gtk_box_pack_start vb,fb,1 1 0
FormList=: FormList, c;fb;0$0
Cparent=: c
Cparentname=: name 
Cparentloc=: loc
Cchild=: 0
Cxywh=: defxywh
consig__loc c;'destroy';(Cparentname,'_close')
)

wdpclose=: 3 : 0
gtk_widget_destroy Cparent
window_destroy Cparent,0
)

wdpn=: 3 : 0
gtk_window_set_title Cparent;y
)

wdpshow=: 3 : 0
gtk_widget_show_all Cparent
if. -.IFGTK do.
  gtk_main''
end.
)

wdxywh=: 3 : 0
Cxywh=: y
)
