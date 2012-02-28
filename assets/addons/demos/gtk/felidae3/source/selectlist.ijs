coclass 'selectlist'
coinsert 'jgtk'

retval=: ''
storetype=: 3 : 'G_TYPE_STRING'

NB. =========================================================
destroy=: 3 : 0
cbfree ''
codestroy ''
)

create=: 3 : 0
'cb dbtype dbheader dbdata'=: y
make_main_window ''
NB. fill the model with data
store=. gtk_tree_view_get_model treeview
iter=. i.ITERSIZE
for_r. dbdata do.
  gtk_list_store_append store; iter
NB. !!! only works for 3 columns
  ((>libgtk), ' gtk_list_store_set >',(IFWIN#' +'),' n x *x i *c i *c i *c x')&cd store; iter; 0; (0{::r); 1; (1{::r); 2; (": 2{::r); _1
end.
)

NB. =========================================================
make_main_window=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window ; gettext ('select a row')
gtk_window_set_default_size window,800 480
gtk_window_set_modal window, 1               NB. disable parent main window
consig window;'destroy';'window_destroy'
gtk_container_set_border_width window, 10

vbox1=. gtk_vbox_new 0 0
gtk_widget_show vbox1
gtk_container_add window, vbox1
scrolled=. gtk_scrolled_window_new 0 0
treeview=: make_treeview ''
gtk_container_add scrolled, treeview
gtk_box_pack_start vbox1, scrolled, 1 1 0

gtk_widget_show_all window
0
)

NB. =========================================================
NB. treeview code

make_treeview=: 3 : 0

NB. Create a model
store=. gtk_list_store_newv (# ; storetype"0) dbtype

NB. Create a view
tree=. gtk_tree_view_new_with_model store

NB. The view now holds a reference.  We can get rid of our own reference
g_object_unref store

for_i. i.#dbtype do.
  renderer=. gtk_cell_renderer_text_new ''
  column=. ((>libgtk), ' gtk_tree_view_column_new_with_attributes >',(IFWIN#' +'),' x *c x *c i x')&cd (gettext i{::dbheader); renderer; 'text'; i; 0
  gtk_tree_view_append_column tree, column
end.

consig4 tree;'row-activated';'tree_row_activated'   NB. double click

NB. Setup the selection handler
select=. gtk_tree_view_get_selection tree
gtk_tree_selection_set_mode select, GTK_SELECTION_SINGLE
consig select;'changed';'tree_selection_changed'

tree
)

NB. =========================================================
NB. callback verbs

window_destroy=: 3 : 0
'widget data'=. y
destroy ''
0
)

tree_row_activated=: 3 : 0
'widget path column data'=. y
iter=. i.ITERSIZE [ key=. ,_1
model=. gtk_tree_view_get_model widget
if. gtk_tree_model_get_iter model; iter; path do.
  ((>libgtk), ' gtk_tree_model_get >',(IFWIN#' +'),' n x *x i *x x')&cd model; iter; 0; key; _1   NB. terminated by _1
NB. should already processed by selection_changed, otherwise decomment the following line
NB.   cb~ ::0: retval=: memr key,0 _1
  g_free {.key
end.
gtk_widget_destroy window
0
)

tree_selection_changed=: 3 : 0
'selection data'=. y
iter=. i.ITERSIZE [ model=. ,_1 [ key=. ,_1  NB. no multiple assignment
if. gtk_tree_selection_get_selected selection; model; iter do.
  ((>libgtk), ' gtk_tree_model_get >',(IFWIN#' +'),' n x *x i *x x')&cd ({.model); iter; 0; key; _1   NB. terminated by _1
  cb~ ::0: retval=: memr key,0 _1
  g_free {.key
end.
0
)
