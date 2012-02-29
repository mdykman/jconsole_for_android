NB. form designer

NB. If you are totally new to gtk programming, you might want to first read
NB. the chapter 'Packing Widgets' in gtkide Help|GTK|GTK Tutorial

NB.    box1
NB.    +-------------------------------+
NB.    | +---------------------------+ |
NB.    | | <<  >>      felidae       | |  box2
NB.    | +---------------------------+ |
NB.    | +-------+-------------------+ |  table1
NB.    | |       | +---------------+ | |
NB.    | |  name | |  __________ ! | | |    box3
NB.    | |       | +---------------+ | |
NB.    | +-------+-------------------+ |
NB.    | |  genus|    ___________    | |
NB.    | +-------+-------------------+ |
NB.    +-------------------------------+

NB. =========================================================
make_main_window=: 3 : 0
NB. top-level window
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;(gettext 'felidae')  NB. gettext for i18n, optional
gtk_container_set_border_width window, 10

NB. container
box1=. gtk_vbox_new 0 0        NB. vbox (the only direct child of top-level window
box2=. gtk_hbox_new 0 0        NB. the top bar
box3=. gtk_hbox_new 0 0        NB. contain ui_name and button3 as a single child
table1=. gtk_table_new 2 2 0   NB. column row homogenious

NB. widget
button1=. gtk_button_new_with_label <(gettext '<<')  NB. previous record
button2=. gtk_button_new_with_label <(gettext '>>')  NB. next record
label1=. gtk_label_new <(gettext 'felidae')
label2=. gtk_label_new <(gettext 'name')
label3=. gtk_label_new <(gettext 'genus')

NB. some widgets need global name
ui_name=: gtk_entry_new ''                   NB. single line text
ui_genus=: gtk_entry_new ''

button3=. gtk_button_new_with_label <(gettext ,'!')   NB. find record

NB. packing widgets into containers
gtk_container_add window, box1

gtk_box_pack_start box1, box2, 0 0 0
gtk_box_pack_start box1, table1, 1 1 0    NB. take up remaining space

gtk_box_pack_start box2 , button1, 0 0 0
gtk_box_pack_start box2 , button2, 0 0 0
gtk_box_pack_start box2 , label1, 1 1 0

gtk_box_pack_start box3 , ui_name, 1 1 0
gtk_box_pack_start box3 , button3, 0 0 0

gtk_table_attach table1, label2, 0 1 0 1, GTK_FILL, 0 0 0   NB. colums rows options
gtk_table_attach table1, label3, 0 1 1 2, GTK_FILL, 0 0 0
gtk_table_attach table1, box3, 1 2 0 1, (GTK_FILL+GTK_EXPAND), 0 0 0
gtk_table_attach table1, ui_genus, 1 2 1 2, (GTK_FILL+GTK_EXPAND), 0 0 0

NB. associate events with J handler verbs
consig3 window;'delete-event';'window_delete'          NB. before delete
consig window;'destroy';'window_destroy'               NB. window destroyed
consig3 window;'configure-event';'window_configure'    NB. resize
consig button1;'clicked';'button1_clicked'
consig button2;'clicked';'button2_clicked'
consig button3;'clicked';'button3_clicked'

0
)

