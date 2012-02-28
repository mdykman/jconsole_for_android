NB. GTK+2.0 tutorial example 8
NB.
NB. treeview
NB. the first and the last column are editable

require 'gui/gtk'

coclass 'm8'
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
NB. =========================================================
main=: 3 : 0
if. -.IFGTK do. gtkinit'' end.
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window ; 'Edit Items in GtkTreeView'
gtk_window_set_default_size window,800 600
consig3 window;'delete-event';'window_delete'
consig window;'destroy';'Destroy'
gtk_container_set_border_width window, 10

vbox1=. gtk_vbox_new 0 0
gtk_widget_show vbox1
gtk_container_add window , vbox1
scrolled=. gtk_scrolled_window_new 0 0
treeview=: setup_tree ''          NB. global treeview for reference inside callback verbs
gtk_widget_show treeview
gtk_container_add scrolled , treeview
gtk_widget_show scrolled
gtk_box_pack_start vbox1 , scrolled , 1 1 0

gtk_widget_show window
if. -.IFGTK do. gtk_main '' end.
0
)

NB. =========================================================
destroy=: 3 : 0
cbfree ''
codestroy ''
)

NB. =========================================================
NB. treeview code

'TITLE_COLUMN AUTHOR_COLUMN CHECKED_COLUMN N_COLUMNS'=: i.4

setup_tree=: 3 : 0

NB. Create a model.  We are using the store model for now, though we
NB. could use any other GtkTreeModel
store=. gtk_list_store_newv N_COLUMNS; G_TYPE_STRING, G_TYPE_STRING, G_TYPE_BOOLEAN

NB. fill the model with data
iter=. i.ITERSIZE
for_bk. books do.
  gtk_list_store_append store; iter
  ((>libgtk), ' gtk_list_store_set >', (2*IFUNIX) }. ' + n x *x i *c i *c i i x')&cd store; iter; TITLE_COLUMN; (0{::bk); AUTHOR_COLUMN; (1{::bk); CHECKED_COLUMN; (?2); _1
end.

NB. Create a view
tree=. gtk_tree_view_new_with_model store

NB. The view now holds a reference.  We can get rid of our own reference
g_object_unref store

NB. Create a cell render and arbitrarily make it red for demonstration purposes
renderer=. gtk_cell_renderer_text_new ''
((>libgobject), ' g_object_set >', (2*IFUNIX) }. ' + n x *c *c *c i *c i x')&cd renderer; 'foreground'; 'red'; 'editable'; 1; 'editable-set'; 1; 0

NB. Setup the renderer handler
consig4 renderer;'edited';'cell_edited'

NB. Create a column, associating the "text" attribute of the
NB. cell_renderer to the first column of the model
NB. First column.. title of the book.
column=. ((>libgtk), ' gtk_tree_view_column_new_with_attributes >', (2*IFUNIX) }. ' + x *c x *c i x')&cd 'Title'; renderer; 'text'; TITLE_COLUMN; 0

NB. Add the column to the view.
gtk_tree_view_append_column tree, column

NB. Second column.. author of the book
renderer=. gtk_cell_renderer_text_new ''
column=. ((>libgtk), ' gtk_tree_view_column_new_with_attributes >', (2*IFUNIX) }. ' + x *c x *c i x')&cd 'Author'; renderer; 'text'; AUTHOR_COLUMN; 0
gtk_tree_view_append_column tree, column

NB. Last column.. whether a book is checked out.
renderer=. gtk_cell_renderer_toggle_new ''
column=. ((>libgtk), ' gtk_tree_view_column_new_with_attributes >', (2*IFUNIX) }. ' + x *c x *c i x')&cd 'Checked out'; renderer; 'active'; CHECKED_COLUMN; 0
gtk_tree_view_append_column tree, column

NB. Setup the renderer handler
consig3 renderer;'toggled';'cell_toggled'

NB. Setup the selection handler
select=. gtk_tree_view_get_selection tree
gtk_tree_selection_set_mode select, GTK_SELECTION_SINGLE
consig select;'changed';'tree_selection_changed'

tree
)

NB. =========================================================
NB. callback verbs for treeview

tree_selection_changed=: 3 : 0
selection=. {.y
iter=. i.ITERSIZE [ model=. ,_1 [ author=. ,_1  NB. no multiple assignment
if. gtk_tree_selection_get_selected selection; model; iter do.
  ((>libgtk), ' gtk_tree_model_get >', (2*IFUNIX) }. ' + n x *x i *x x')&cd ({.model); iter; AUTHOR_COLUMN; author; _1
  smoutput 'You selected a book by ', memr author,0 _1
  g_free {.author
end.
)

cell_edited=: 3 : 0
'renderer path text'=. 3{.y
model=. gtk_tree_view_get_model treeview
assert. 0~: model
iter=. i.ITERSIZE
if. gtk_tree_model_get_iter_from_string model; iter; (memr path, 0 _1) do.
  ((>libgtk), ' gtk_list_store_set >', (2*IFUNIX) }. ' + n x *x i x x')&cd model; iter; TITLE_COLUMN; text; _1
end.
)

cell_toggled=: 3 : 0
'renderer path'=. 2{.y
model=. gtk_tree_view_get_model treeview
assert. 0~: model
iter=. i.ITERSIZE
if. gtk_tree_model_get_iter_from_string model; iter; (memr path, 0 _1) do.
  val=. ,_1
  ((>libgtk), ' gtk_tree_model_get >', (2*IFUNIX) }. ' + n x *x i *i x')&cd model; iter; CHECKED_COLUMN; val; _1
  ((>libgtk), ' gtk_list_store_set >', (2*IFUNIX) }. ' + n x *x i i x')&cd model; iter; CHECKED_COLUMN; (-.{.val); _1
end.
)

NB. =========================================================
NB. sample data

books=: _2]\a:-.~<;._2[0 : 0
Learning J
Roger Stoke

J for C Programmer
Henry Rich

J Reference Card
Henry Rich

Brief Reference
Chris Burke et al

Computers and Mathematical Notation
Kenneth E Iverson

Easy J
Linda Alvord et al

Fractals, Visualization & J
Clifford A. Reiter

J - The Natural Language for Analytic Computing
Norman J Thomson

Mathematical Computing in J: Volume 1, Introduction
Howard A. Peelle

Network Performance Analysis
Alan Holt

Math for the Layman
Kenneth E Iverson

Exploring Math
Kenneth E Iverson

Arithmetic
Kenneth E Iverson

Calculus
Kenneth E Iverson

Concrete Math Companion
Kenneth E Iverson

J Phrases
Chris Burke et al
)

cocurrent'base'
main_m8_''

