NB. gldemos.ijs

cocurrent 'jdemos'

require 'gl2 jzopengl'
coinsert 'jgtk jgl3'

3 : 0''
if. -.IFGTK do. gtkinit_jgtk_'' end.
)

GLHANDLERS=: <;._2 (0 : 0)
a_actrl_fkey
a_button
a_close
a_destroy
a_g_char
a_g_configure
a_g_mbldown
a_g_paint
a_g_size
a_help_button
a_run
)

GLTITLES=: 3 : 0 ''
j=. 1!:0 <jpath '~addons/demos/opengl/simple/*.ijs'
j=. tolower each ({.~i.&'.') each {."1 j
j=. j -. 'gldemos';'bitmap';'build';'test';'run'
if. IFUNIX do.
  j=. j -. 'font';'font3d'
end.
/:~ j
)

gldemos_run=: 3 : 0
window1=: 0
files_select=: ''
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_container_set_border_width window, 5
vbox1=. gtk_vbox_new 0 0
vbox2=. gtk_vbox_new 0 0
hbox1=. gtk_hbox_new 0 0
scrolled=. gtk_scrolled_window_new 0 0
s0=. gtk_label_new (<gettext 'Select Demo:')
run=. gtk_button_new_with_mnemonic <gettext '_Run'
view=. gtk_button_new_with_mnemonic <gettext '_View'
cancel=. gtk_button_new_with_mnemonic <gettext '_Cancel'

files=: make_treeview ''

gtk_window_set_default_size window, 160 450

gtk_container_add window, vbox1
gtk_box_pack_start vbox1, s0, 0 0 0
gtk_box_pack_start vbox1, hbox1, 1 1 0
gtk_box_pack_start hbox1, scrolled, 1 1 0
gtk_container_add scrolled, files
gtk_box_pack_start hbox1, vbox2, 0 0 0
gtk_box_pack_start vbox2, run, 0 0 0
gtk_box_pack_start vbox2, view, 0 0 0
gtk_box_pack_start vbox2, cancel, 0 0 0

consig window;'destroy';'gldemos_destroy'              NB. window destroyed
consig run;'clicked';'gldemos_run_button'
consig view;'clicked';'gldemos_view_button'
consig cancel;'clicked';'gldemos_cancel_button'

gtk_widget_show_all window
wdmove window,_1 0   NB.! win32 requires wdmove after show

NB. fill the model with data
store=. gtk_tree_view_get_model files
iter=. i.ITERSIZE
for_r. GLTITLES do.
  gtk_list_store_append store; iter
  ((>libgtk), ' gtk_list_store_set >',(IFWIN#' +'),' n x *x i *c x')&cd store; iter; 0; (>r); _1
end.
path=. ((>libgtk), ' gtk_tree_path_new_from_indices >',(IFWIN#' +'),' x i i')&cd 0 _1   NB. terminated by _1
select=. gtk_tree_view_get_selection files
gtk_tree_selection_select_path select, path
gtk_tree_path_free path
gtk_widget_grab_focus files

if. -.IFGTK do. gtk_main'' end.
)

gldemos_destroy=: 3 : 0
'widget data'=. y
if. 0~: window1 do.
  gtk_widget_destroy window1
  window1=: 0
end.
if. -.IFGTK do. gtk_main_quit'' end.
cbfree''
0
)

gldemos_cancel_button=: 3 : 0
gtk_widget_destroy window
0
)

gldemos_run_button=: 3 : 0
file=. files_select
if. 0~: window1 do.
  gtk_widget_destroy window1
  window1=: 0
end.
4!:55 GLHANDLERS
0!:0 <jpath '~addons/demos/opengl/simple/',file,'.ijs'
gtk_window_set_title window1;file
0
)

gldemos_view_button=: 3 : 0
if. IFGTK do.
  textview 'View Definition';freads jpath '~addons/demos/opengl/simple/',files_select,'.ijs'
else.
  file=. files_select
  xedit jpath '~addons/demos/opengl/simple/',file,'.ijs'
end.
0
)

NB. =========================================================
NB. treeview code

make_treeview=: 3 : 0

NB. Create a model
store=. gtk_list_store_newv 1 ; ,G_TYPE_STRING

NB. Create a view
tree=. gtk_tree_view_new_with_model store

NB. The view now holds a reference.  We can get rid of our own reference
g_object_unref store

renderer=. gtk_cell_renderer_text_new ''
column=. ((>libgtk), ' gtk_tree_view_column_new_with_attributes >',(IFWIN#' +'),' x *c x *c i x')&cd (gettext 'Demo'); renderer; 'text'; 0; 0
gtk_tree_view_append_column tree, column

consig4 tree;'row-activated';'tree_row_activated'   NB. double click

NB. Setup the selection handler
select=. gtk_tree_view_get_selection tree
gtk_tree_selection_set_mode select, GTK_SELECTION_SINGLE
consig select;'changed';'tree_selection_changed'

tree
)

NB. =========================================================
NB. callback verbs

tree_row_activated=: 3 : 0
'widget path column data'=. y
gldemos_run_button ''
0
)

tree_selection_changed=: 3 : 0
'selection data'=. y
iter=. i.ITERSIZE [ model=. ,_1 [ key=. ,_1  NB. no multiple assignment
if. gtk_tree_selection_get_selected selection; model; iter do.
  ((>libgtk), ' gtk_tree_model_get >',(IFWIN#' +'),' n x *x i *x x')&cd ({.model); iter; 0; key; _1   NB. terminated by _1
  files_select=: memr key,0 _1
  g_free {.key
end.
0
)

gldemos_run''
