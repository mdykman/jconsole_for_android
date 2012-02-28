NB. ui dependent

NB. clear screen
clear_cat=: display_cat bind (_1;'';'';0)

NB. display record and update current position
display_cat=: 3 : 0
if. 0=#y do. EMPTY return. end.
'p a b c'=. y
current_cat=: p
gtk_entry_set_text ui_name;a
gtk_entry_set_text ui_genus;b
gtk_spin_button_set_value ui_lineage;(1.1-1.1)+c
ui_picture dispimage~ (0~: #a) {:: '' ; jpath '~felidae/data/', '_'&((' ' I.@:= ])}) a, '.jpg'
EMPTY
)

NB. y widget
NB. x file name
dispimage=: 4 : 0
if. 0= y do. 1 return. end.
if. 0= #x do.
NB. just for demostration, gtk 2.8 is very old
  if. 0= gtk_check_version 2 8 0 do.    NB. 0 if gtk (not gdk) requirement met
    gtk_image_clear y
  else.
    gtk_image_set_from_pixbuf y, 0
  end.
  0 return.
end.
gtk_image_set_from_file y; x
0
)

NB. ask confirmation to delete
NB. return 0 if response if yes or ok
yesnoquestion=: 3 : 0
dialog=. ((>libgtk) ,' gtk_message_dialog_new >',(IFWIN#' +'),' x x i i i *c *c')&cd window ; GTK_DIALOG_DESTROY_WITH_PARENT ; GTK_MESSAGE_QUESTION ;  GTK_BUTTONS_YES_NO ; (gettext 'delete record for name: ''%s''') ; ,y
res=. gtk_dialog_run dialog
gtk_widget_destroy dialog
res -.@e. GTK_RESPONSE_YES, GTK_RESPONSE_OK
)

NB. error dialog box
saynotfound=: 3 : 0
dialog=. ((>libgtk) ,' gtk_message_dialog_new >',(IFWIN#' +'),' x x i i i *c *c')&cd window ; GTK_DIALOG_DESTROY_WITH_PARENT ; GTK_MESSAGE_INFO ; GTK_BUTTONS_CLOSE ; (gettext 'no record for name: ''%s''') ; ,y
res=. gtk_dialog_run dialog
gtk_widget_destroy dialog
EMPTY
)

NB. about box
aboutbox=: 3 : 0
logo=. gdk_pixbuf_new_from_file (jpath '~felidae/data/felidae.png');0
((>libgtk) ,' gtk_show_about_dialog >',(IFWIN#' +'),' n x *c *c *c x *c *c x')&cd window ; 'program-name'; 'felidae'; 'logo'; logo; 'title'; (gettext 'About felidae'); 0
g_object_unref logo
EMPTY
)
