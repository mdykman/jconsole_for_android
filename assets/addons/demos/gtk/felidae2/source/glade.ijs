NB. form designer

NB.    box1
NB.    +-------------------------------+
NB.    | +---------------------------+ |
NB.    | | |< << >> >| C X S felidae | |  toolbar1
NB.    | +---------------------------+ |
NB.    | +-------+-------------------+ |  table1
NB.    | |       | +---------------+ | |
NB.    | |  name | |  __________ ! | | |    box2
NB.    | |       | +---------------+ | |
NB.    | +-------+-------------------+ |
NB.    | |  genus|    ___________    | |
NB.    | +-------+-------------------+ |
NB.    | |lineage|    ___________    | |
NB.    | +-------+-------------------+ |
NB.    | +---------------------------+ |
NB.    | | picture,eventbox1         | | frame1
NB.    | |                           | |
NB.    | |                           | |
NB.    | |                           | |
NB.    | |                           | |
NB.    | +---------------------------+ |
NB.    +-------------------------------+

NB. =========================================================
make_main_window=: 3 : 0
NB. top-level window
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;(gettext 'felidae')  NB. gettext for i18n, optional
gtk_window_set_icon_from_file window;(jpath '~felidae/data/felidae.png');0

NB. use either one
NB. gtk_widget_set_size_request window, 400 500 NB. set the minimum size that cannot be shrinked smaller
gtk_window_set_default_size window, 400 500     NB. set the initial size

gtk_container_set_border_width window, 10

NB. container
box1=. gtk_vbox_new 0 0        NB. vbox (the only direct child of top-level window
toolbar1=. gtk_toolbar_new ''  NB. the top toolbar
box2=. gtk_hbox_new 0 0        NB. contain ui_name and button3 as a single child
table1=. gtk_table_new 2 2 0   NB. column row homogenious
frame1=. gtk_frame_new <(gettext 'picture')    NB. frame for picture1
eventbox1=. gtk_event_box_new ''  NB. gtkimage cannot receive window events

NB. widget
button1=. gtk_tool_button_new_from_stock <'gtk-goto-first'     NB. ! not gtk_button
button2=. gtk_tool_button_new_from_stock <'gtk-go-back'
button3=. gtk_tool_button_new_from_stock <'gtk-go-forward'
button4=. gtk_tool_button_new_from_stock <'gtk-goto-last'
button5=. gtk_tool_button_new_from_stock <'gtk-clear'
button6=. gtk_tool_button_new_from_stock <'gtk-delete'
button7=. gtk_tool_button_new_from_stock <'gtk-save'
button8=. gtk_tool_button_new_from_stock <'gtk-about'
label1=. gtk_label_new <(gettext 'felidae')
label2=. gtk_label_new <(gettext 'name')
label3=. gtk_label_new <(gettext 'genus')
label4=. gtk_label_new <(gettext 'lineage')

NB. some widgets need global name
ui_name=: gtk_entry_new ''                   NB. single line text
ui_genus=: gtk_entry_new ''
ui_lineage=: gtk_spin_button_new_with_range (1.1-1.1)+0 999 1   NB. widget for number
ui_picture=: gtk_image_new ''
gtk_misc_set_alignment ui_picture; ;~ (1.1-1.1)   NB. make sure coordinate same as its container
gtk_misc_set_padding ui_picture, 0 0

button9=. gtk_tool_button_new_from_stock <'gtk-find'

NB. packing widgets into containers
gtk_container_add window, box1

gtk_box_pack_start box1, toolbar1, 0 0 0
gtk_box_pack_start box1, table1, 0 0 0
gtk_box_pack_start box1, frame1, 1 1 0    NB. take up remaining space

NB. insert tool_item  0= begin _1=end ; 1... position
gtk_toolbar_insert toolbar1, button1, _1
gtk_toolbar_insert toolbar1, button2, _1
gtk_toolbar_insert toolbar1, button3, _1
gtk_toolbar_insert toolbar1, button4, _1
gtk_toolbar_insert toolbar1, button5, _1
gtk_toolbar_insert toolbar1, button6, _1
gtk_toolbar_insert toolbar1, button7, _1
gtk_toolbar_insert toolbar1, _1,~ gtk_separator_tool_item_new ''   NB. extra space between groups
gtk_toolbar_insert toolbar1, button8, _1
gtk_toolbar_insert toolbar1, _1,~ gtk_separator_tool_item_new ''
gtk_container_add (item=. gtk_tool_item_new ''), label1  NB. toolbar requires tool_item except button
gtk_toolbar_insert toolbar1, item, _1

gtk_box_pack_start box2 , ui_name, 1 1 0
gtk_box_pack_start box2 , button9, 0 0 0

gtk_table_attach table1, label2, 0 1 0 1, GTK_FILL, 0 0 0   NB. colums rows options
gtk_table_attach table1, label3, 0 1 1 2, GTK_FILL, 0 0 0
gtk_table_attach table1, label4, 0 1 2 3, GTK_FILL, 0 0 0
gtk_table_attach table1, box2, 1 2 0 1, (GTK_FILL+GTK_EXPAND), 0 0 0
gtk_table_attach table1, ui_genus, 1 2 1 2, (GTK_FILL+GTK_EXPAND), 0 0 0
gtk_table_attach table1, ui_lineage, 1 2 2 3, (GTK_FILL+GTK_EXPAND), 0 0 0

gtk_container_add frame1, eventbox1
gtk_container_add eventbox1, ui_picture

NB. associate events with J handler verbs
consig3 window;'delete-event';'window_delete'          NB. before delete
consig window;'destroy';'window_destroy'               NB. window destroyed
consig3 window;'configure-event';'window_configure'    NB. resize
consig button1;'clicked';'button1_clicked'
consig button2;'clicked';'button2_clicked'
consig button3;'clicked';'button3_clicked'
consig button4;'clicked';'button4_clicked'
consig button5;'clicked';'button5_clicked'
consig button6;'clicked';'button6_clicked'
consig button7;'clicked';'button7_clicked'
consig button8;'clicked';'button8_clicked'
consig button9;'clicked';'button9_clicked'

0
)

