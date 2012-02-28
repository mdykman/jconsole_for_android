NB. ui dependent

NB. clear screen
clear_cat=: display_cat bind (_1;'';'')

NB. display record and update current position
display_cat=: 3 : 0
if. 0=#y do. EMPTY return. end.
'p a b'=. y
current_cat=: p
gtk_entry_set_text ui_name;a
gtk_entry_set_text ui_genus;b
EMPTY
)

NB. error dialog box
saynotfound=: 3 : 0
dialog=. ((>libgtk) ,' gtk_message_dialog_new >',(IFWIN#' +'),' x x i i i *c *c')&cd window ; GTK_DIALOG_DESTROY_WITH_PARENT ; GTK_MESSAGE_INFO ; GTK_BUTTONS_CLOSE ; (gettext 'no record for name: ''%s''') ; ,y
res=. gtk_dialog_run dialog
gtk_widget_destroy dialog
EMPTY
)
