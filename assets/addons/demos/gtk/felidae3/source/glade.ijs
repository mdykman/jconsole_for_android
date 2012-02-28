NB. form designer

NB.    box1
NB.    +-------------------------------------+
NB.    |   +---------------------------+     |
NB.    |   | |< << >> >| C X S felidae |     |  toolbar1
NB.    |   +---------------------------+     |
NB.    | +--------------------------------+  |  noteboook1
NB.    | | notebookpage 0                 |  |
NB.    | |  +-------+-------------------+ |  |  table1
NB.    | |  |       | +---------------+ | |  |
NB.    | |  |  name | |  __________ ! | | |  |  box2
NB.    | |  |       | +---------------+ | |  |
NB.    | |  +-------+-------------------+ |  |
NB.    | |  |  genus|   VVVVVVVVVVVV    | |  |
NB.    | |  +-------+-------------------+ |  |
NB.    | |  |lineage|    ___________    | |  |
NB.    | |  +-------+-------------------+ |  |
NB.    | |    filechooser                 |  |
NB.    | |  +---------------------------+ |  |
NB.    | |  | picture,eventbox1         | |  | frame1
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  +---------------------------+ |  |
NB.    | +--------------------------------+  |
NB.    +-------------------------------------+
NB.
NB.    | +--------------------------------+  |  noteboook1
NB.    | | notebookpage 1                 |  |
NB.    | |  +-------+--------+----------+ |  |
NB.    | |  |  label|        | checkbox | |  |  box3
NB.    | |  +-------+--------+----------+ |  |
NB.    | |  +---------------------------+ |  |
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |  sypnosis
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  |                           | |  |
NB.    | |  +---------------------------+ |  |
NB.    | +--------------------------------+  |
NB.    +-------------------------------------+

NB. =========================================================
make_main_window=: 3 : 0
NB. top-level window
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;(gettext 'felidae')  NB. gettext for i18n, optional
gtk_window_set_icon_from_file window;(jpath '~felidae/data/felidae.png');0

NB. use either one
NB. gtk_widget_set_size_request window, 400 500     NB. set the minimum size that cannot be shrinked smaller
NB. gtk_window_set_default_size window, 400 500     NB. set the initial size

gtk_container_set_border_width window, 10

NB. container
box1=. gtk_vbox_new 0 0        NB. vbox (the only direct child of top-level window
toolbar1=. gtk_toolbar_new ''  NB. the top toolbar
box2=. gtk_hbox_new 0 0        NB. contain ui_name and button3 as a single child
box3=. gtk_hbox_new 0 0        NB. contain filechooser button
box4=. gtk_hbox_new 0 0        NB. contain sypnosis label and checkbox
table1=. gtk_table_new 2 2 0   NB. column row homogenious
frame1=. gtk_frame_new <(gettext 'picture')    NB. frame for picture1
eventbox1=. gtk_event_box_new ''  NB. gtkimage cannot receive window events
notebook1=. gtk_notebook_new ''
nb0=. gtk_vbox_new 0 0        NB. vbox for notebook page 0
nb1=. gtk_vbox_new 0 0        NB. vbox for notebook page 1

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
label5=. gtk_label_new <(gettext 'sypnosis')

NB. some widgets need global name
ui_name=: gtk_entry_new ''                   NB. single line text
ui_genus=: gtk_entry_new ''
ui_lineage=: gtk_spin_button_new_with_range (1.1-1.1)+0 999 1   NB. widget for number
ui_picture=: gtk_image_new ''
gtk_misc_set_alignment ui_picture; ;~ (1.1-1.1)   NB. make sure coordinate same as its container
gtk_misc_set_padding ui_picture, 0 0
gtk_widget_set_size_request ui_picture, 400 400 NB. set the minimum size that cannot be shrinked smaller
ui_sypnosis=: gtk_text_view_new ''                NB. each textview has a buffer
ui_sypnosis_buffer=: gtk_text_view_get_buffer ui_sypnosis

button9=. gtk_tool_button_new_from_stock <'gtk-find'
button10=. gtk_tool_button_new_from_stock <'gtk-open'
button11=. gtk_check_button_new_with_label <(gettext 'read only')

NB. ============================================================
NB. tooltip

NB. simple tooltip
gtk_widget_set_tooltip_text label1; gettext 'cat family'
gtk_widget_set_tooltip_text button8; gettext 'bind to F12'
NB. tooltip using pango markup
gtk_widget_set_tooltip_markup button6; gettext 'do <i>you</i> want to <span fgcolor="red"><b>delete</b></span> <u>this record</u>?'

NB. ============================================================
NB. menu

NB. menubar

NB. menu accelerator for main window
accel_group=. gtk_accel_group_new ''
gtk_window_add_accel_group window, accel_group

NB. create a menu-bar to hold the menus
menu_bar=. gtk_menu_bar_new ''
NB. mac look-and-feel, moved to the top of desktop
if. UNAME-:'Darwin' do. ((>libigemac),' ige_mac_menu_set_menu_bar >n x')&cd ::0: menu_bar end.

NB. a root menu inside menu-bar for file menu item
gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_File')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

NB. create a new image menu-item from stock and add it to the menu
gtk_menu_shell_append menu, menu_item_quit=. gtk_image_menu_item_new_from_stock 'gtk-quit'; 0
NB. set menu accelerator
ctrl_mask=. (UNAME-:'Darwin'){GDK_CONTROL_MASK,GDK_META_MASK   NB. mac look-and-feel
gtk_widget_add_accelerator menu_item_quit; 'activate'; accel_group; GDK_q; ctrl_mask; GTK_ACCEL_VISIBLE

NB. another root menu inside menu-bar for navigate menu item
gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Navigate')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

NB. create some new image menu-items from stock and add them to the menu
gtk_menu_shell_append menu, menu_item_first=. gtk_image_menu_item_new_from_stock 'gtk-goto-first'; 0
gtk_menu_shell_append menu, menu_item_back=. gtk_image_menu_item_new_from_stock 'gtk-go-back'; 0
gtk_menu_shell_append menu, menu_item_forward=. gtk_image_menu_item_new_from_stock 'gtk-go-forward'; 0
gtk_menu_shell_append menu, menu_item_last=. gtk_image_menu_item_new_from_stock 'gtk-goto-last'; 0

NB. another root menu inside menu-bar for edit menu item
gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Edit')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

NB. create some new image menu-items from stock and add them to the menu
gtk_menu_shell_append menu, menu_item_clear=. gtk_image_menu_item_new_from_stock 'gtk-clear'; 0
gtk_menu_shell_append menu, menu_item_delete=. gtk_image_menu_item_new_from_stock 'gtk-delete'; 0
gtk_menu_shell_append menu, menu_item_save=. gtk_image_menu_item_new_from_stock 'gtk-save'; 0

NB. another root menu inside menu-bar for help menu item
gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Help')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

NB. Create a new menu-item with a name (without the _ character) and set an image to it
menu_item_about=. gtk_image_menu_item_new_with_label <(gettext 'about')
gtk_image_menu_item_set_image menu_item_about, gtk_image_new_from_stock 'gtk-about'; GTK_ICON_SIZE_MENU
gtk_menu_shell_append menu, menu_item_about


NB. ============================================================
NB. packing widgets into containers

gtk_container_add window, box1

gtk_box_pack_start box1, menu_bar, 0 0 2
gtk_box_pack_start box1, toolbar1, 0 0 0
gtk_box_pack_start box1, notebook1, 1 1 0

gtk_box_pack_start nb0, table1, 0 0 0
gtk_box_pack_start nb0, box3, 0 0 0
gtk_box_pack_start nb0, frame1, 1 1 0    NB. take up remaining space

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

gtk_box_pack_start box2, ui_name, 1 1 0
gtk_box_pack_start box2, button9, 0 0 0

gtk_table_attach table1, label2, 0 1 0 1, GTK_FILL, 0 0 0   NB. colums rows options
gtk_table_attach table1, label3, 0 1 1 2, GTK_FILL, 0 0 0
gtk_table_attach table1, label4, 0 1 2 3, GTK_FILL, 0 0 0
gtk_table_attach table1, box2, 1 2 0 1, (GTK_FILL+GTK_EXPAND), 0 0 0
gtk_table_attach table1, ui_genus, 1 2 1 2, (GTK_FILL+GTK_EXPAND), 0 0 0
gtk_table_attach table1, ui_lineage, 1 2 2 3, (GTK_FILL+GTK_EXPAND), 0 0 0

gtk_container_add frame1, eventbox1
gtk_container_add eventbox1, ui_picture

gtk_box_pack_start box3, button10, 0 0 0

NB. another notebook page
gtk_box_pack_start nb1, box4, 0 0 0
gtk_box_pack_start nb1, ui_sypnosis, 1 1 0    NB. take up remaining space

gtk_box_pack_start box4, label5, 0 0 0
gtk_box_pack_end box4, button11, 0 0 0     NB. pack end, leaving space in between

NB. append notebook page
gtk_notebook_append_page notebook1, nb0, 0
gtk_notebook_set_tab_label_text notebook1; nb0; <(gettext 'general')  NB. gtklabel will be created automatically
gtk_notebook_append_page notebook1, nb1, 0
gtk_notebook_set_tab_label_text notebook1; nb1; <(gettext 'sypnosis')

NB. ============================================================
NB. associate events with J handler verbs

consig3 window;'delete-event';'window_delete'          NB. before delete
consig window;'destroy';'window_destroy'               NB. window destroyed
consig3 window;'configure-event';'window_configure'    NB. resize
consig3 window;'key-press-event';'window_key_press'    NB. key down, demostrate function key binding
consig button1;'clicked';'button1_clicked'
consig button2;'clicked';'button2_clicked'
consig button3;'clicked';'button3_clicked'
consig button4;'clicked';'button4_clicked'
consig button5;'clicked';'button5_clicked'
consig button6;'clicked';'button6_clicked'
consig button7;'clicked';'button7_clicked'
consig button8;'clicked';'button8_clicked'
consig button9;'clicked';'button9_clicked'
consig button10;'clicked';'button10_clicked'
consig button11;'clicked';'button11_clicked'

NB. event of menu
NB. reuse handler for buttons
NB. beware if the number of arguments of signal callback function is different
consig menu_item_quit;'activate';'quit_activate'
consig menu_item_first;'activate';'button1_clicked'
consig menu_item_back;'activate';'button2_clicked'
consig menu_item_forward;'activate';'button3_clicked'
consig menu_item_last;'activate';'button4_clicked'
consig menu_item_clear;'activate';'button5_clicked'
consig menu_item_delete;'activate';'button6_clicked'
consig menu_item_save;'activate';'button7_clicked'
consig menu_item_about;'activate';'button8_clicked'

0
)

