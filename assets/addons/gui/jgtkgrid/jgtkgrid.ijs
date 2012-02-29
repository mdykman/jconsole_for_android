require 'gui/gtk'
coclass 'jgtkgrid'
coinsert 'jgtk'
require 'gui/jgtkgrid/manifest'
9!:7 '+++++++++|-' 

create=: 3 : 0
'' create y
:
x initgrid y
)

destroy=: 3 : 0
cbfree''
codestroy''
)
noss=: 4 : 0
s=. x I.@E. y
i=. s I. s+#x
(i.&_1 {. ]) (s,_1) {~ (i,_1) {~^:a: 0
)

sr=: 4 : 0
'p q'=. x
j=. p noss y
if. ''-:j do. y return. end.
d=. p-&#q
k=. (j+(0>.-d)*i.#j)+/i.#q
select. *d
  case.  1 do. (0 (j+/(#q)+i.d)}1$~#y) # q k}y
  case.  0 do. q k}y
  case. _1 do. q k} (0 (d{."1 k)}1$~(#y)+(#j)*|d) #^:_1 y
end.
)

tostring=: 3 : 0
r=. _1
y=. ,&LF"1 ": y
while. 2 < # $ y do.
  r=. <:r
  y=. (,&LF)@,"2 y
end.
r }. ,y
)

tostring1=: {.@(8!:2)`tostring@.((1 < #) +. 16 32 e.~ 3!:0)
toflat=: }:@:;@:(;L:1^:L.)@:(,&' '@:":L:0)
tofloat=: (1&{.)@:;@:+.@:(0&".)@:toflat
to01=: (0&>.)@:(1&<.)@:tofloat
tocomplex=: (1&{.)@:;@:(0&".)@:toflat
toint=: <.@:tofloat
tobool=: 0&~:@:tofloat
inv2box=: dtb&.>@:|:@:(<"_1&>)
box2inv=: <@(,@>"1)@|:
pack=: [: (, ,&< ".)&> [: /:~ ;: ::]
escape=: (13 : '(TAB;''\t'')sr(CR;''\r'')sr(LF;''\n'')sr(''\'';''\b'')sr y') : (13 : '(x;''\s'')sr $: y')
unescape=: (13 : '(''\b'';''\'')sr(''\n'';LF)sr(''\r'';CR)sr(''\t'';TAB)sr y') : (13 : '$: (''\s'';x)sr y')
isnum=: 1 = [: +/ 0&". = _&".

unpack=: 3 : 0
if. 0 e. $y do. '' return. end.
if. 2 > #@$ y do. y=. ((-:#,y),2)$,y end.
nms=. {."1 y
(nms)=: {:"1 y
nms
)

clipwritej=: 3 : 0
(<TAB) clipwritej y
:
if. 2>#$y do. y=. ,:,y end.
flag=. 0<+/(CR,LF,TAB,'\') #@ss"0 _ toflat y
if. L.x do.
  if. flag do.
    y=. escape@tostring1 each y
  else.
    y=. tostring1 each y
  end.
  x=. {.(tostring >x),TAB
else.
  if. flag do.
    y=. escape each y
  end.
  x=. {.(tostring x),TAB
end.
y=. }:;(,&x each }:"1 y) ,. ,&LF each {:"1 y
len=. #y
cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
gtk_clipboard_set_text cb;y;len
gtk_clipboard_store cb
len
)

clipreadj=: 3 : 0
if. 0=#y do.
  y=. TAB
else.
  y=. {.(tostring y),TAB
end.
cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
txt=. readstring gtk_clipboard_wait_for_text cb
flag=. 0 < # '\' ss txt 
txt=. y&([: <;._2 [ ,~ ]) ;._2 txt,LF
if. flag do.
  txt=. unescape each txt
end.
)

getactive=: 3 : 0
c=. mema IF64{4 8
d=. mema IF64{4 8
gtk_tree_view_get_cursor y;c;d
p=. {. memr c,0 1 4
if. p=0 do.
  row=. _1
else.
  r=. 0 pick gtk_tree_path_get_indices <<p
  row=. {. _2 ic memr r,0 4
  gtk_tree_path_free p
end.
b=. {. memr d,0 1 4
if. b=0 do.
  col=. _1
else.
  cols=. gtk_tree_model_get_n_columns gtk_tree_view_get_model y
  temp=. gtk_tree_view_get_columns y
  list=. 0$0
  for_i. i.cols do.
    list=. list,g_list_nth_data temp,i
  end.
  col=. list i. b
  g_list_free temp
end.
memf c
memf d
iter=. i.ITERSIZE
if. gtk_tree_selection_get_selected (gtk_tree_view_get_selection y);(,_1);iter do.
  s=. gtk_tree_model_get_string_from_iter (gtk_tree_view_get_model y);iter
  sel=. _1 ". memr s,0,_1
  g_free {.s
else.
  sel=. _1
end.
row,col,sel
)

setactive=: 3 : 0
'tv row col sel'=. 4{.y,_1,_1,_1
if. 4>#y do. sel=. row end.
if. _1<col do.
  cols=. gtk_tree_model_get_n_columns gtk_tree_view_get_model tv
  temp=. gtk_tree_view_get_columns tv
  list=. 0$0
  for_i. i.cols do.
    list=. list,g_list_nth_data temp,i
  end.
  c=. col{list
  g_list_free temp
else.
  c=. 0
end.
if. _1<row do.
  p=. gtk_tree_path_new_from_string <":row
  gtk_tree_view_scroll_to_cell tv,p,c,0 0 0
else.
  p=. gtk_tree_path_new_from_string<":#T_BODY
end.
gtk_tree_view_set_cursor tv;p;c;0
gtk_tree_path_free p
gtk_tree_selection_unselect_all gtk_tree_view_get_selection tv
if. _1<sel do.
  s=. gtk_tree_path_new_from_string <":sel
  gtk_tree_view_scroll_to_cell tv,s,c,0 0 0
  gtk_tree_selection_select_path (gtk_tree_view_get_selection tv);s
  gtk_tree_path_free s
else.
  gtk_tree_selection_unselect_all gtk_tree_view_get_selection tv
end.
)

getparent=: gtk_widget_get_parent

getwindow=: 3 : 0
while. 0<y=. gtk_widget_get_parent y do. y end.
)
helpdialog=: 3 : 0
x=. T_MENU
dat=. 'Shortcuts:',LF,LF
dat=. ('Esc',TAB,'unselect all',LF)(,&) dat
dat=. ('Ins',TAB,'insert row',LF)(,&)^:((-.(<'!insertrow')e.x)*.+./('all';'row';'insertrow')e.x) dat
dat=. ('Del',TAB,'delete row',LF)(,&)^:((-.(<'!deleterow')e.x)*.+./('all';'row';'deleterow')e.x) dat
dat=. ('Bks',TAB,'delete column',LF)(,&)^:((-.(<'!deletecol')e.x)*.+./('all';'col';'deletecol')e.x) dat
dat=. ('F1',TAB,'about dialog',LF)(,&) dat
dat=. ('F2',TAB,'set option dialog',LF)(,&)^:((-.(<'!setoption')e.x)*.+./('all';'tools';'setoption')e.x) dat
dat=. ('F3',TAB,'find next text',LF)(,&)^:((-.(<'!findnext')e.x)*.+./('all';'find';'findnext')e.x) dat
dat=. ('F4',TAB,'find next cell',LF)(,&)^:((-.(<'!findnextcell')e.x)*.+./('all';'find';'findnextcell')e.x) dat
dat=. ('F5',TAB,'find and replace dialog',LF)(,&)^:((-.(<'!findreplace')e.x)*.+./('all';'find';'findreplace')e.x) dat
dat=. ('F6',TAB,'open file dialog',LF)(,&)^:((-.(<'!open')e.x)*.+./('all';'tools';'open')e.x) dat
dat=. ('F7',TAB,'save file dialog',LF)(,&)^:((-.(<'!save')e.x)*.+./('all';'tools';'save')e.x) dat
dat=. ('F8',TAB,'font selection dialog',LF)(,&)^:((-.(<'!font')e.x)*.+./('all';'tools';'font')e.x) dat
dat=. ('F9',TAB,'zoom out',LF)(,&)^:((-.(<'!zoomout')e.x)*.+./('all';'tools';'zoomout')e.x) dat
dat=. ('F10',TAB,'zoom in',LF)(,&)^:((-.(<'!zoomin')e.x)*.+./('all';'tools';'zoomin')e.x) dat
dat=. ('F11',TAB,'color selection dialog',LF)(,&)^:((-.(<'!color')e.x)*.+./('all';'tools';'color')e.x) dat
dat=. ('F12',TAB,'print grid dialog',LF)(,&)^:((-.(<'!print')e.x)*.+./('all';'tools';'print')e.x) dat
dat=. dat,LF
dat=. ('Shift+Alt',TAB,'popup menu',LF)(,&) dat
dat=. ('Shift+Ret',TAB,'multi-line edit dialog',LF)(,&)^:((-.(<'!multiedit')e.x)*.+./('all';'grid';'multiedit')e.x) dat
dat=. ('Shift+Ins',TAB,'append row',LF)(,&)^:((-.(<'!appendrow')e.x)*.+./('all';'row';'appendrow')e.x) dat
dat=. ('Shift+Del',TAB,'clear row',LF)(,&)^:((-.(<'!clearrow')e.x)*.+./('all';'row';'clearrow')e.x) dat
dat=. ('Shift+Bks',TAB,'clear column',LF)(,&)^:((-.(<'!clearcol')e.x)*.+./('all';'col';'clearcol')e.x) dat
dat=. ('Shift+F1',TAB,'help dialog',LF)(,&) dat
dat=. ('Shift+F2',TAB,'update grid dialog',LF)(,&)^:((-.(<'!updategrid')e.x)*.+./('all';'tools';'updategrid')e.x) dat
dat=. ('Shift+F3',TAB,'find previous text',LF)(,&)^:((-.(<'!findprev')e.x)*.+./('all';'find';'findprev')e.x) dat
dat=. ('Shift+F4',TAB,'find previous cell',LF)(,&)^:((-.(<'!findprevcell')e.x)*.+./('all';'find';'findprevcell')e.x) dat
dat=. ('Shift+F5',TAB,'filter dialog',LF)(,&)^:((-.(<'!filter')e.x)*.+./('all';'find';'filter')e.x) dat
dat=. dat,LF
dat=. ('Ctrl+C',TAB,'copy row',LF)(,&)^:((-.(<'!copyrow')e.x)*.+./('all';'row';'copyrow')e.x) dat
dat=. ('Ctrl+V',TAB,'paste row',LF)(,&)^:((-.(<'!pasterow')e.x)*.+./('all';'row';'pasterow')e.x) dat
dat=. ('Ctrl+X',TAB,'cut row',LF)(,&)^:((-.(<'!cutrow')e.x)*.+./('all';'row';'cutrow')e.x) dat
dat=. ('Ctrl+Shift+C',TAB,'copy column',LF)(,&)^:((-.(<'!copycol')e.x)*.+./('all';'col';'copycol')e.x) dat
dat=. ('Ctrl+Shift+V',TAB,'paste column',LF)(,&)^:((-.(<'!pastecol')e.x)*.+./('all';'col';'pastecol')e.x) dat
dat=. ('Ctrl+Shift+X',TAB,'cut column',LF)(,&)^:((-.(<'!cutcol')e.x)*.+./('all';'col';'cutcol')e.x) dat
dat=. dat,LF
dat=. dat,'see also:',LF,'http://www.jsoftware.com/jwiki/Addons/gui/jgtkgrid'
mbinfo 'jgtkgrid help';dat
0
)

aboutdialog=: 3 : 0
w=. gtk_about_dialog_new''
gtk_about_dialog_set_program_name w;'jgtkgrid'
gtk_about_dialog_set_version w;VERSION
gtk_about_dialog_set_copyright w;(194 169{a.),'2011 Lorenzo Tomei'
gtk_about_dialog_set_comments w;CAPTION
gtk_about_dialog_set_website w;'http://www.jsoftware.com/jwiki/Addons/gui/jgtkgrid'
gtk_dialog_run w
gtk_widget_destroy w
0
)

findreplacedialog=: 3 : 0
w=. gtk_dialog_new''
gtk_window_set_default_size w,360,180
gtk_window_set_title w;'Find and Replace'
a=. gtk_dialog_get_content_area w
l1=. gtk_label_new_with_mnemonic<'Searc_h for'
f1=: gtk_entry_new''
l2=. gtk_label_new_with_mnemonic<'_Replace by'
f2=: gtk_entry_new''
gtk_label_set_mnemonic_widget l1,f1
gtk_label_set_mnemonic_widget l2,f2
h=. gtk_hbox_new 0 0
c1=: gtk_check_button_new_with_mnemonic <'Whole _cell'
b1=. newbutton 'Find _next';'frnext'
b2=. newbutton 'Find _prev';'frprev'
b3=. newbutton 'Replace _sel';'frsel'
b4=. newbutton 'Replace _all';'frall'
setentry f1;T_FIND
gtk_box_pack_start h,c1,1 1 2
gtk_box_pack_start h,b1,1 1 2
gtk_box_pack_start h,b2,1 1 2
gtk_box_pack_start h,b3,1 1 2
gtk_box_pack_start h,b4,1 1 2
gtk_box_pack_start a,l1,1 1 2
gtk_box_pack_start a,f1,1 1 2
gtk_box_pack_start a,l2,1 1 2
gtk_box_pack_start a,f2,1 1 2
gtk_box_pack_start a,h,1 1 2
gtk_dialog_add_button w;'_Done';0
gtk_widget_show_all w
gtk_dialog_run w
gtk_widget_destroy w
0
)

frnext=: 3 : 0
T_FIND=: getentry f1
(<^:(readcheckbox c1)T_FIND)findnext''
0
)

frprev=: 3 : 0
T_FIND=: getentry f1
(<^:(readcheckbox c1)T_FIND)findprev''
0
)

frsel=: 3 : 0
T_FIND=: getentry f1
if. (_1<T_SELROW)*.(_1<T_SELCOL) do.
  ((T_FIND;getentry f2)sr>(<T_SELROW,T_SELCOL){T_BODY)setcell''
end.
0
)

frall=: 3 : 0
T_FIND=: getentry f1
if. readcheckbox c1 do.
  (((<T_FIND);<<getentry f2)&sr"1 T_BODY)setdata''
else.
  ((T_FIND;getentry f2)&sr each T_BODY)setdata''
end.
0
)

findnexttext=: 3 : 0
if. 0=#T_FIND do. finddialog'' end.
T_FIND findnext''
0
)

findprevtext=: 3 : 0
if. 0=#T_FIND do. finddialog'' end.
T_FIND findprev''
0
)

findnextcell=: 3 : 0
if. 0=#T_FIND do. finddialog'' end.
(<T_FIND)findnext''
0
)

findprevcell=: 3 : 0
if. 0=#T_FIND do. finddialog'' end.
(<T_FIND)findprev''
0
)

finddialog=: 3 : 0
w=. gtk_dialog_new''
gtk_window_set_title w;'Search for'
f=. gtk_entry_new''
setentry f;T_FIND
a=. gtk_dialog_get_content_area w
gtk_box_pack_start a,f,1 1 2
gtk_dialog_add_button w;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL
gtk_dialog_add_button w;GTK_STOCK_OK;GTK_RESPONSE_ACCEPT
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_ACCEPT do.
  T_FIND=: getentry f
end.
gtk_widget_destroy w
0
)

filterdialog=: 3 : 0
w=. gtk_dialog_new''
gtk_window_set_default_size w,640,480
gtk_window_set_title w;'Filter'
a=. gtk_dialog_get_content_area w
bufpreview=: gtk_source_buffer_new 0
q=. gtk_source_view_new_with_buffer bufpreview
s=. gtk_scrolled_window_new 0 0
gtk_scrolled_window_set_policy s,GTK_POLICY_AUTOMATIC,GTK_POLICY_AUTOMATIC
h=. gtk_hbox_new 0 0
l1=. gtk_label_new_with_mnemonic<'_x'
filterx=: newcombotext (((,&': ')@:('Col '&,)@:":each i.1{$T_BODY),each C_HEAD);'';0
gtk_label_set_mnemonic_widget l1,filterx
l2=. gtk_label_new_with_mnemonic<'_y'
filtery=: gtk_entry_new''
gtk_label_set_mnemonic_widget l2,filtery
l3=. gtk_label_new_with_mnemonic<'conditio_n'
filtern=: newcombo ('x = y';'x ~: y';'x > y';'x >: y';'x < y';'x <: y';'x -: y';'-. x -: y';'((#y){.x) -: y';'-. ((#y){.x) -: y';'((-#y){.x) -: y';'-. ((-#y){.x) -: y';'0 < # y ss x';'0 = # y ss x');'';''
gtk_label_set_mnemonic_widget l3,filtern
b=. newbutton '_Preview';'filterview'
gtk_box_pack_start h,l1,0 0 2
gtk_box_pack_start h,filterx,0 0 2
gtk_box_pack_start h,l3,0 0 2
gtk_box_pack_start h,filtern,0 0 2
gtk_box_pack_start h,l2,0 0 2
gtk_box_pack_start h,filtery,0 0 2
gtk_box_pack_start h,b,1 1 2
gtk_container_add s,q
gtk_box_pack_start a,s,1 1 2
gtk_box_pack_start a,h,0 0 2
setfont q;T_PFONT
gtk_dialog_add_button w;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL
gtk_dialog_add_button w;GTK_STOCK_OK;GTK_RESPONSE_ACCEPT
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_ACCEPT do.
  sel=. filterview 1
  copyrows :: 0: sel
end.
gtk_widget_destroy w
0
)

filterview=: 3 : 0
fx=. gtk_combo_box_get_active filterx
fy=. getentry filtery
if. 0<fx{C_ISNUM do. fy=. 0 ". fy end.
dat=. getdata<''
sel=. 'filter=. 4 : 0',LF,(readcombo filtern),LF,')'
0!:0 sel
sel=. ; filter&fy :: 0: each fx{"1 dat
if. 1-:y do.
  sel
  return.
end.
dat=. sel # dat
bufwrite bufpreview;tostring dat
0
)

fold=: 3 : 0
w=. gtk_dialog_new''
gtk_window_set_title w;'Set folding width'
f=. gtk_entry_new''
setentry f;'80'
a=. gtk_dialog_get_content_area w
gtk_box_pack_start a,f,1 1 2
gtk_dialog_add_button w;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL
gtk_dialog_add_button w;GTK_STOCK_OK;GTK_RESPONSE_ACCEPT
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_ACCEPT do.
  sel=. 1>.{.toint getentry f
  if. _1<T_SELCOL do.
    if. (0=T_SELCOL{C_ISNUM)*.(0=T_SELCOL{C_TYPE) do.
      (sel&foldtext each T_SELCOL{"1 T_BODY) setcol T_SELCOL
    end.
  else.
    for_i. i.1{$T_BODY do.
      if. (0=i{C_ISNUM)*.(0=i{C_TYPE) do.
        (sel&foldtext each i{"1 T_BODY) setcol i
      end.
    end.
  end.
end.
gtk_widget_destroy w
0
)

unfold=: 3 : 0
w=. gtk_dialog_new''
gtk_window_set_title w;'Set unfolding char'
f=. gtk_entry_new''
setentry f;,' '
a=. gtk_dialog_get_content_area w
gtk_box_pack_start a,f,1 1 2
gtk_dialog_add_button w;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL
gtk_dialog_add_button w;GTK_STOCK_OK;GTK_RESPONSE_ACCEPT
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_ACCEPT do.
  sel=. getentry f
  if. _1<T_SELCOL do.
    if. (0=T_SELCOL{C_ISNUM)*.(0=T_SELCOL{C_TYPE) do.
      ((LF;sel)&sr each T_SELCOL{"1 T_BODY) setcol T_SELCOL
    end.
  else.
    for_i. i.1{$T_BODY do.
      if. (0=i{C_ISNUM)*.(0=i{C_TYPE) do.
        ((LF;sel)&sr each i{"1 T_BODY) setcol i
      end.
    end.
  end.
end.
gtk_widget_destroy w
0
)

setoptiondialog=: 3 : 0
w=. gtk_dialog_new''
gtk_window_set_default_size w,480,80
gtk_window_set_title w;'Set options'
a=. gtk_dialog_get_content_area w
f=. gtk_entry_new''
setentry f;T_SETOPTION
gtk_box_pack_start a,f,1 1 2
gtk_dialog_add_button w;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL
gtk_dialog_add_button w;GTK_STOCK_OK;GTK_RESPONSE_ACCEPT
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_ACCEPT do.
  T_SETOPTION=: getentry f
  setoption@:". :: 0: T_SETOPTION
end.
gtk_widget_destroy w
0
)

updatedialog=: 3 : 0
w=. gtk_dialog_new''
gtk_window_set_default_size w,480,120
gtk_window_set_title w;'Update grid'
a=. gtk_dialog_get_content_area w
l1=. gtk_label_new_with_mnemonic<'Option_s'
f1=. gtk_entry_new''
setentry f1;T_SETOPTION
l2=. gtk_label_new_with_mnemonic<'_Data'
f2=. gtk_entry_new''
setentry f2;T_SETDATA
gtk_label_set_mnemonic_widget l1,f1
gtk_label_set_mnemonic_widget l2,f2
gtk_box_pack_start a,l1,1 1 2
gtk_box_pack_start a,f1,1 1 2
gtk_box_pack_start a,l2,1 1 2
gtk_box_pack_start a,f2,1 1 2
gtk_dialog_add_button w;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL
gtk_dialog_add_button w;GTK_STOCK_OK;GTK_RESPONSE_ACCEPT
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_ACCEPT do.
  T_SETOPTION=: getentry f1
  T_SETDATA=: getentry f2
  ((,pack T_OPTIONS),". :: ((0$<'')"_) T_SETOPTION) updategrid :: 0: (". :: ((getdata'')"_) T_SETDATA)
end.
gtk_widget_destroy w
0
)

multieditdialog=: 3 : 0
if. (_1<T_SELROW)*.(_1<T_SELCOL) do.
  w=. gtk_dialog_new''
  gtk_window_set_default_size w,480,240
  gtk_window_set_title w;'Multi-line editor'
  a=. gtk_dialog_get_content_area w
  q=. gtk_text_view_new''
  b=. gtk_text_view_get_buffer q
  s=. gtk_scrolled_window_new 0 0
  gtk_scrolled_window_set_policy s,GTK_POLICY_AUTOMATIC,GTK_POLICY_AUTOMATIC
  gtk_text_view_set_wrap_mode q,3
  setfont q;T_SELCOL{C_FONT
  gtk_container_add s,q
  gtk_box_pack_start a,s,1 1 2
  bufwrite b;(<T_SELROW,T_SELCOL){T_BODY
  gtk_dialog_add_button w;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL
  gtk_dialog_add_button w;GTK_STOCK_OK;GTK_RESPONSE_ACCEPT
  gtk_widget_show_all w
  res=. gtk_dialog_run w
  if. res=GTK_RESPONSE_ACCEPT do.
    str=. bufread b
    exe=. >T_SELCOL{C_EXEC
    if. (#exe)*.exe={.str do.
      str=. ". :: ] }.str
    end.
    str setcell''
  end.
  gtk_widget_destroy w
else.
  mbox 1;'Multi-line editor';'select a cell to edit'
end.
0
)

opendialog=: 3 : 0
w=. gtk_file_chooser_dialog_new 'Open grid from file';0;GTK_FILE_CHOOSER_ACTION_OPEN;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL;GTK_STOCK_OPEN;GTK_RESPONSE_ACCEPT;0
if. isdir T_PATH do. path=. T_PATH else. path=. jpath'~user' end.
gtk_file_chooser_set_current_folder w;path
a=. gtk_dialog_get_content_area w
o=. gtk_label_new_with_mnemonic<'C_ustom Options'
f=. gtk_entry_new''
h=. gtk_hbox_new 0 0
c=. gtk_check_button_new_with_mnemonic <'Convert _numeric strings to numbers'
l=. gtk_label_new_with_mnemonic<'Field _delimiter'
d=. gtk_entry_new''
gtk_entry_set_max_length d,1
gtk_widget_set_size_request d,22 22
setentry d;,T_DELIMITER
gtk_label_set_mnemonic_widget o,f
gtk_label_set_mnemonic_widget l,d
gtk_box_pack_start a,o,0 0 2
gtk_box_pack_start a,f,0 0 2
gtk_box_pack_start a,h,0 0 2
gtk_box_pack_start h,l,0 0 2
gtk_box_pack_start h,d,0 0 2
gtk_box_pack_start h,c,0 0 2
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_ACCEPT do.
  filename=. jpathsep readstringfree gtk_file_chooser_get_filename w
  opt=. getentry f
  chk=. readcheckbox c
  delimiter=. {.getentry d
  if. -.delimiter=T_DELIMITER do.
    setoption 'T_DELIMITER';delimiter
  end.
  gtk_widget_destroy w
  if. fexist filename do.
    txt=. }:freads filename
    flag=. 0 < # '\' ss txt 
    txt=. T_DELIMITER&([: <;._2 [ ,~ ]) ;._2 txt,LF
    if. flag do.
      txt=. T_DELIMITER&unescape each txt
    end.
    hdr=. {.txt
    txt=. }.txt
    if. chk do.
      txt=. 0&".^:isnum each txt
    end.
    ('C_HEAD';<hdr) updategrid :: 0: txt
    setoption@:". :: 0: opt
  else.  
    mbox 1;'Open grid from file';'invalid file name'
  end.
else.
  gtk_widget_destroy w
end.
0
)

savedialog=: 3 : 0
w=. gtk_file_chooser_dialog_new 'Save grid to file';0;GTK_FILE_CHOOSER_ACTION_SAVE;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL;GTK_STOCK_SAVE;GTK_RESPONSE_ACCEPT;0
if. isdir T_PATH do. path=. T_PATH else. path=. jpath'~user' end.
gtk_file_chooser_set_current_folder w;path
gtk_file_chooser_set_current_name w;'mygrid_',>coname''
a=. gtk_dialog_get_content_area w
h=. gtk_hbox_new 0 0
l=. gtk_label_new_with_mnemonic<'Field _delimiter'
d=. gtk_entry_new''
gtk_entry_set_max_length d,1
gtk_widget_set_size_request d,22 22
setentry d;,T_DELIMITER
gtk_label_set_mnemonic_widget l,d
gtk_box_pack_start h,l,0 0 2
gtk_box_pack_start h,d,0 0 2
gtk_box_pack_start a,h,0 0 2
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_ACCEPT do.
  filename=. jpathsep readstringfree gtk_file_chooser_get_filename w
  delimiter=. {.getentry d
  if. -.delimiter=T_DELIMITER do.
    setoption 'T_DELIMITER';delimiter
  end.
  gtk_widget_destroy w
  if. fexist filename do.
    res=. (res=GTK_RESPONSE_ACCEPT) *. mbox 3;'Save grid to file';'Confirm overwrite of file ',filename
  end.
  if. res do.
    txt=. C_HEAD,T_BODY
    flag=. 0<+/(T_DELIMITER,CR,LF,TAB,'\') #@ss"0 _ toflat txt
    if. flag do.
      txt=. T_DELIMITER&escape each txt
    end.
    txt=. ;(,&T_DELIMITER each }:"1 txt) ,. ,&LF each {:"1 txt
    txt fwrite filename
  end.  
else.
  gtk_widget_destroy w
end.
0
)

printdialog=: 3 : 0
w=. gtk_dialog_new''
gtk_window_set_default_size w,640,480
gtk_window_set_title w;'Print preview'
a=. gtk_dialog_get_content_area w
bufprint=: gtk_source_buffer_new 0
q=. gtk_source_view_new_with_buffer bufprint
s=. gtk_scrolled_window_new 0 0
gtk_scrolled_window_set_policy s,GTK_POLICY_AUTOMATIC,GTK_POLICY_AUTOMATIC
h=. gtk_hbox_new 0 0
b1=. newbutton '_Boxed';'printbox'
b2=. newbutton '_Inverted';'printinv'
b3=. newbutton '_Data only';'printdat'
b4=. newbutton '_Field delimiter';'printsep'
d1=: gtk_entry_new''
gtk_entry_set_max_length d1,1
gtk_widget_set_size_request d1,22 22
setentry d1;,T_DELIMITER
gtk_box_pack_start h,b1,1 1 2
gtk_box_pack_start h,b2,1 1 2
gtk_box_pack_start h,b3,1 1 2
gtk_box_pack_start h,b4,1 1 2
gtk_box_pack_start h,d1,0 0 2
gtk_container_add s,q
gtk_box_pack_start a,s,1 1 2
gtk_box_pack_start a,h,0 0 2
setfont q;T_PFONT
printinv''
gtk_dialog_add_button w;GTK_STOCK_CANCEL;GTK_RESPONSE_CANCEL
gtk_dialog_add_button w;GTK_STOCK_OK;GTK_RESPONSE_ACCEPT
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_ACCEPT do.
  compositor=: gtk_source_print_compositor_new_from_view q
  operation=: gtk_print_operation_new''
  consig3 operation;'paginate';'paginate'
  consig4 operation;'draw-page';'drawpage'
  gtk_print_operation_run operation,GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG,0 0
  g_object_unref operation
  g_object_unref compositor
end.
gtk_widget_destroy w
0
)

printbox=: 3 : 0
bufwrite bufprint;tostring C_HEAD,T_BODY
0
)

printinv=: 3 : 0
bufwrite bufprint;tostring C_HEAD,:box2inv^:(-.T_INVERTED) getdata''
0
)

printdat=: 3 : 0
bufwrite bufprint;tostring getdata''
0
)

printsep=: 3 : 0
delimiter=. {.getentry d1
if. -.delimiter=T_DELIMITER do.
  setoption 'T_DELIMITER';delimiter
end.
txt=. C_HEAD,T_BODY
flag=. 0<+/(T_DELIMITER,CR,LF,TAB,'\') #@ss"0 _ toflat txt
if. flag do.
  txt=. T_DELIMITER&escape each txt
end.
txt=. ;(,&T_DELIMITER each }:"1 txt) ,. ,&LF each {:"1 txt
bufwrite bufprint;txt
0
)

paginate=: 3 : 0
'operation context data'=. y
if. gtk_source_print_compositor_paginate compositor,context do.
  npages=. gtk_source_print_compositor_get_n_pages compositor
  gtk_print_operation_set_n_pages operation,npages
  1 return.
end.
0
)

drawpage=: 3 : 0
'operation context page_nr data'=. y
gtk_source_print_compositor_draw_page compositor,context,page_nr
0
)

fontdialog=: 3 : 0
fontname=. T_PFONT
whilst. res=GTK_RESPONSE_APPLY do.
  w=. gtk_font_selection_dialog_new<'Grid font selection'
  a=. gtk_dialog_get_content_area w
  h=. gtk_hbox_new 0 0
  c1=. gtk_check_button_new_with_mnemonic <'Column _Header'
  c2=. gtk_check_button_new_with_mnemonic <'Column C_ells'
  c3=. gtk_check_button_new_with_mnemonic <'Index Heade_r'
  c4=. gtk_check_button_new_with_mnemonic <'_Index Cells'
  c5=. gtk_check_button_new_with_mnemonic <'_Printing'
  setcheckbox c1,1
  setcheckbox c2,1
  gtk_box_pack_start h,c1,1 1 2
  gtk_box_pack_start h,c2,1 1 2
  gtk_box_pack_start h,c3,1 1 2
  gtk_box_pack_start h,c4,1 1 2
  gtk_box_pack_start h,c5,1 1 2
  gtk_box_pack_start a,h,0 0 2
  gtk_widget_show_all w
  gtk_font_selection_dialog_set_font_name w;fontname
  res=. gtk_dialog_run w
  if. (res=GTK_RESPONSE_OK)+.res=GTK_RESPONSE_APPLY do.
    c1=. readcheckbox c1
    c2=. readcheckbox c2
    c3=. readcheckbox c3
    c4=. readcheckbox c4
    c5=. readcheckbox c5
    fontname=. readstringfree gtk_font_selection_dialog_get_font_name w
    gtk_widget_destroy w
    if. _1<T_SELCOL do.
      if. c1 do. setoption :: 0: 'C_HFONT';<(<fontname)T_SELCOL}C_HFONT end.
      if. c2 do. setoption :: 0: 'C_FONT';<(<fontname)T_SELCOL}C_FONT end.
    else.
      if. c1 do. setoption :: 0: 'C_HFONT';fontname end.
      if. c2 do. setoption :: 0: 'C_FONT';fontname end.
    end.
    if. c3 do. setoption :: 0: 'T_HFONT';fontname end.
    if. c4 do. setoption :: 0: 'T_FONT';fontname end.
    if. c5 do. setoption :: 0: 'T_PFONT';fontname end.
  else.
    gtk_widget_destroy w
  end.
end.
0
)

colordialog=: 3 : 0
w=. gtk_color_selection_dialog_new<'Color selection'
a=. gtk_dialog_get_content_area w
h1=. gtk_hbox_new 0 0
h2=. gtk_hbox_new 0 0
c1=. gtk_check_button_new_with_mnemonic <'Column Hea_der'
c2=. gtk_check_button_new_with_mnemonic <'Column C_ells'
c3=. gtk_check_button_new_with_mnemonic <'Column Bac_k'
c4=. gtk_check_button_new_with_mnemonic <'Column Back-Se_l'
c5=. gtk_check_button_new_with_mnemonic <'Inde_x Header'
c6=. gtk_check_button_new_with_mnemonic <'_Index Cells'
c7=. gtk_check_button_new_with_mnemonic <'Index B_ack'
setcheckbox c1,1
setcheckbox c2,1
gtk_box_pack_start h1,c1,0 0 2
gtk_box_pack_start h1,c2,0 0 2
gtk_box_pack_start h1,c3,0 0 2
gtk_box_pack_start h1,c4,0 0 2
gtk_box_pack_start h2,c5,0 0 2
gtk_box_pack_start h2,c6,0 0 2
gtk_box_pack_start h2,c7,0 0 2
gtk_box_pack_start a,h1,0 0 2
gtk_box_pack_start a,h2,0 0 2
gtk_widget_show_all w
res=. gtk_dialog_run w
if. res=GTK_RESPONSE_OK do.
  color=. i.4
  gtk_color_selection_get_current_color (gtk_color_selection_dialog_get_color_selection w);color
  c1=. readcheckbox c1
  c2=. readcheckbox c2
  c3=. readcheckbox c3
  c4=. readcheckbox c4
  c5=. readcheckbox c5
  c6=. readcheckbox c6
  c7=. readcheckbox c7
  gtk_widget_destroy w
  color=. '#',(2 3 6 7{4{3!:3]1{color),2 3{4{3!:3]2{color
  if. _1<T_SELCOL do.
    if. c1 do. setoption :: 0: 'C_HFORECOLOR';<(<color)T_SELCOL}C_HFORECOLOR end.
    if. c2 do. setoption :: 0: 'C_FORECOLOR';<(<color)T_SELCOL}C_FORECOLOR end.
    if. c3 do. setoption :: 0: 'C_BACKCOLOR';<(<color)T_SELCOL}C_BACKCOLOR end.
    if. c4 do. setoption :: 0: 'C_BACKSEL';<(<color)T_SELCOL}C_BACKSEL end.
  else.
    if. c1 do. setoption :: 0: 'C_HFORECOLOR';color end.
    if. c2 do. setoption :: 0: 'C_FORECOLOR';color end.
    if. c3 do. setoption :: 0: 'C_BACKCOLOR';color end.
    if. c4 do. setoption :: 0: 'C_BACKSEL';color end.
  end.
  if. c5 do. setoption :: 0: 'T_HFORECOLOR';color end.
  if. c6 do. setoption :: 0: 'T_FORECOLOR';color end.
  if. c7 do. setoption :: 0: 'T_BACKCOLOR';color end.
else.
  gtk_widget_destroy w
  if. res=GTK_RESPONSE_HELP do.
    mbox 0;'Color selection';'pick a color and choose where to apply it',LF,'avoid to set same color for foreground and background'
  end.
end.
0
)

zoomin=: 3 : 0
if. _1<T_SELCOL do.
  i=. T_SELCOL
  p=. >{:;:>i{C_FONT
  c_font=. (<((-#p)}.>i{C_FONT),":96<.>:0".p)i}C_FONT
  p=. >{:;:>i{C_HFONT
  c_hfont=. (<((-#p)}.>i{C_HFONT),":96<.>:0".p)i}C_HFONT
  setoption :: 0: 'C_FONT';c_font;'C_HFONT';<c_hfont
else.
  cols=. 1{$T_BODY
  c_font=. 0$<''
  c_hfont=. 0$<''
  for_i. i.cols do.
    p=. >{:;:>i{C_FONT
    c_font=. c_font,<((-#p)}.>i{C_FONT),":96<.>:0".p
    p=. >{:;:>i{C_HFONT
    c_hfont=. c_hfont,<((-#p)}.>i{C_HFONT),":96<.>:0".p
  end.
  p=. >{:;:T_FONT
  t_font=. ((-#p)}.T_FONT),":96<.>:0".p
  p=. >{:;:T_HFONT
  t_hfont=. ((-#p)}.T_HFONT),":96<.>:0".p
  setoption :: 0: 'C_FONT';c_font;'C_HFONT';c_hfont;'T_FONT';t_font;'T_HFONT';t_hfont
end.
0
)

zoomout=: 3 : 0
if. _1<T_SELCOL do.
  i=. T_SELCOL
  p=. >{:;:>i{C_FONT
  c_font=. (<((-#p)}.>i{C_FONT),":6>.<:0".p)i}C_FONT
  p=. >{:;:>i{C_HFONT
  c_hfont=. (<((-#p)}.>i{C_HFONT),":6>.<:0".p)i}C_HFONT
  setoption :: 0: 'C_FONT';c_font;'C_HFONT';<c_hfont
else.
  cols=. 1{$T_BODY
  c_font=. 0$<''
  c_hfont=. 0$<''
  for_i. i.cols do.
    p=. >{:;:>i{C_FONT
    c_font=. c_font,<((-#p)}.>i{C_FONT),":6>.<:0".p
    p=. >{:;:>i{C_HFONT
    c_hfont=. c_hfont,<((-#p)}.>i{C_HFONT),":6>.<:0".p
  end.
  p=. >{:;:T_FONT
  t_font=. ((-#p)}.T_FONT),":6>.<:0".p
  p=. >{:;:T_HFONT
  t_hfont=. ((-#p)}.T_HFONT),":6>.<:0".p
  setoption :: 0: 'C_FONT';c_font;'C_HFONT';c_hfont;'T_FONT';t_font;'T_HFONT';t_hfont
end.
0
)

expand=: 3 : 0
if. _1<T_SELCOL do.
  setoption 'C_EXPAND';1 T_SELCOL}C_EXPAND
else.
  setoption 'C_EXPAND';1
end.
0
)

collapse=: 3 : 0
if. _1<T_SELCOL do.
  setoption 'C_EXPAND';0 T_SELCOL}C_EXPAND
else.
  setoption 'C_EXPAND';0
end.
0
)

hlines=: 3 : 0
y=. gtk_check_menu_item_get_active {.y
vh=. _2{.#:4+{.T_LINES
h=. {:vh
v=. {.vh
if. -.y=h do.
  setoption 'T_LINES';#.v,y
end.
0
)

vlines=: 3 : 0
y=. gtk_check_menu_item_get_active {.y
vh=. _2{.#:4+{.T_LINES
h=. {:vh
v=. {.vh
if. -.y=v do.
  setoption 'T_LINES';#.y,h
end.
0
)

buttonpress=: 3 : 0
'widget event'=. 2{.y
button=. 256#.endian a.i.memr event,GdkEventButton_button,4
type=. memr event,0 1,JINT
state=. 2{;gdk_event_get_state event;,0
mousepos=. <.2 3{;gdk_event_get_coords event;(,0.0);,0.0
select. button
case. 3 do. 
  time=. gtk_get_current_event_time''
  gtk_menu_popup T_POPUP;(<0);(<0);(<0);(<0);button;time
  1
case. do.
  
  0
end.
)

keypress=: 3 : 0
'widget event'=. 2{.y
'state key'=. gtkeventkey event
x=. T_MENU
select. state
case. 0;2 do.      
  select. key
  case. 65307 do.  
    1[unselectall''
  case. 65379 do.  
    1[insertrow^:((-.(<'!insertrow')e.x)*.+./('all';'row';'insertrow')e.x)''
  case. 65535 do.  
    1[deleterow^:((-.(<'!deleterow')e.x)*.+./('all';'row';'deleterow')e.x)''
  case. 65288 do.  
    1[deletecol^:((-.(<'!deletecol')e.x)*.+./('all';'col';'deletecol')e.x)''
  case. 65470 do.  
    1[aboutdialog''
  case. 65471 do.  
    1[setoptiondialog^:((-.(<'!setoption')e.x)*.+./('all';'tools';'setoption')e.x)''
  case. 65472 do.  
    1[findnexttext^:((-.(<'!findnext')e.x)*.+./('all';'find';'findnext')e.x)''
  case. 65473 do.  
    1[findnextcell^:((-.(<'!findnextcell')e.x)*.+./('all';'find';'findnextcell')e.x)''
  case. 65474 do.  
    1[findreplacedialog^:((-.(<'!findreplace')e.x)*.+./('all';'find';'findreplace')e.x)''
  case. 65475 do.  
    1[opendialog^:((-.(<'!open')e.x)*.+./('all';'tools';'open')e.x)''
  case. 65476 do.  
    1[savedialog^:((-.(<'!save')e.x)*.+./('all';'tools';'save')e.x)''
  case. 65477 do.  
    1[fontdialog^:((-.(<'!font')e.x)*.+./('all';'tools';'font')e.x)''
  case. 65478 do.  
    1[zoomout^:((-.(<'!zoomout')e.x)*.+./('all';'tools';'zoomout')e.x)''
  case. 65479 do.  
    1[zoomin^:((-.(<'!zoomin')e.x)*.+./('all';'tools';'zoomin')e.x)''
  case. 65480 do.  
    1[colordialog^:((-.(<'!color')e.x)*.+./('all';'tools';'color')e.x)''
  case. 65481 do.  
    1[printdialog^:((-.(<'!print')e.x)*.+./('all';'tools';'print')e.x)''
  case. 65360 do.  
    if. -.0=T_SELROW do. selectrow 0 end.
    1
  case. 65361 do.  
    if. 0<T_SELCOL do.
      if. _1<T_SELROW do.
        0
      else.
        1[selectcol <:T_SELCOL
      end.
    else.
      1
    end.
  case. 65362 do.  
    if. 0<T_SELROW do. selectrow <:T_SELROW end.
    1
  case. 65363 do.  
    if. T_SELCOL<<:1{$T_BODY do.
      if. _1<T_SELROW do.
        0
      else.
        1[selectcol >:T_SELCOL
      end.
    else.
      1
    end.
  case. 65364 do.  
    if. T_SELROW<<:#T_BODY do. selectrow >:T_SELROW end.
    1
  case. 65365 do.  
    if. 9<T_SELROW do. selectrow T_SELROW-10 else. selectrow 0 end.
    1
  case. 65366 do.  
    if. (T_SELROW+10)<#T_BODY do. selectrow T_SELROW+10 else. selectrow <:#T_BODY end.
    1
  case. 65367 do.  
    if. T_SELROW<<:#T_BODY do. selectrow <:#T_BODY end.
    1
  case. do.
    0
 end.
case. 1;3 do.      
  select. key
  case. 65511;65513 do.  
    button=. 3
    time=. gtk_get_current_event_time''
    1[gtk_menu_popup T_POPUP;(<0);(<0);(<0);(<0);button;time
  case. 65293 do.  
    1[multieditdialog^:((-.(<'!multiedit')e.x)*.+./('all';'grid';'multiedit')e.x)''
  case. 65379 do.  
    1[appendrow^:((-.(<'!appendrow')e.x)*.+./('all';'row';'appendrow')e.x)''
  case. 65535 do.  
    1[setrow^:((-.(<'!clearrow')e.x)*.+./('all';'row';'clearrow')e.x)''
  case. 65288 do.  
    1[setcol^:((-.(<'!clearcol')e.x)*.+./('all';'col';'clearcol')e.x)''
  case. 65470 do.  
    1[helpdialog''
  case. 65471 do.  
    1[updatedialog^:((-.(<'!updategrid')e.x)*.+./('all';'tools';'updategrid')e.x)''
  case. 65472 do.  
    1[findprevtext^:((-.(<'!findprev')e.x)*.+./('all';'find';'findprev')e.x)''
  case. 65473 do.  
    1[findprevcell^:((-.(<'!findprevcell')e.x)*.+./('all';'find';'findprevcell')e.x)''
  case. 65474 do.  
    1[filterdialog^:((-.(<'!filter')e.x)*.+./('all';'find';'filter')e.x)''
  case. 65360;65361;65362;65363;65364;65365;65366;65367 do.
    1
  case. do.
    0
  end.
case. 4;6 do.      
  select. key
  case. 67;99 do.  
    1[clipcopyrow^:((-.(<'!copyrow')e.x)*.+./('all';'row';'copyrow')e.x)''
  case. 86;118 do. 
    1[clippasterow^:((-.(<'!pasterow')e.x)*.+./('all';'row';'pasterow')e.x)''
  case. 88;120 do. 
    1[cutrow^:((-.(<'!cutrow')e.x)*.+./('all';'row';'cutrow')e.x)''
  case. 65360;65361;65362;65363;65364;65365;65366;65367 do.
    1
 case. do.
    0
  end.
case. 5;7 do.      
  select. key
  case. 67;99 do.  
    1[clipcopycol^:((-.(<'!copycol')e.x)*.+./('all';'col';'copycol')e.x)''
  case. 86;118 do. 
    1[clippastecol^:((-.(<'!pastecol')e.x)*.+./('all';'col';'pastecol')e.x)''
  case. 88;120 do. 
    1[cutcol^:((-.(<'!cutcol')e.x)*.+./('all';'col';'cutcol')e.x)''
  case. 65360;65361;65362;65363;65364;65365;65366;65367 do.
    1
  case. do.
    0
  end.
case. do.
  0
end.
)

celledit=: 3 : 0
'rend path text'=. 3{.y
iter=. i.ITERSIZE
row=. _1 ". memr path,0,_1
col=. C_REND i. rend
exe=. >col{C_EXEC
str=. memr text,0,_1
if. (#exe)*.exe={.str do.
  str=. ". :: ] }.str
end.
str=. (col{C_POS) checknum str
if. gtk_tree_model_get_iter_from_string T_STORE;iter;":row do.
  T_EVENTFLAG=: _1
  T_BODY=: (<str) (<row,col)}T_BODY
  gtk_list_store_set_1 T_STORE;iter;(>:col{C_POS);str;_1
  T_EVENTFLAG=: 0
  T_FOUND=: ''
  if. (<'handler')e.namelist 3 do.
    handler 'cell-changed';row,col
  end.
end.
gtk_widget_grab_focus T_TV
0
)

columnclick=: 3 : 0
'widget data'=. y
i=. C_COL i. widget
chg=. -.i=T_SELCOL
selectrow''
if. chg do.
  selectcol i
else.
  if. i{C_SORTABLE do.
    if. gtk_tree_view_column_get_sort_indicator i{C_COL do.
      sortorder=. -.gtk_tree_view_column_get_sort_order i{C_COL
    else.
      sortorder=. 0
    end.
    sortorder sortcol i
  end.
end.
0
)

selchange=: 3 : 0
if. _1<T_EVENTFLAG do.
  sel=. getactive T_TV
  chgrow=. -.T_SELROW=(0{sel)>.(2{sel)
  T_SELROW=: (0{sel)>.(2{sel)
  chgcol=. -.T_SELCOL=_1>.<:1{sel
  if. chgcol do.
    if. _1<T_SELCOL do.
      ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (T_SELCOL{C_REND);'background';(>T_SELCOL{C_BACKCOLOR);0
      gtk_widget_queue_draw T_TV
    end.
    T_SELCOL=: _1>.<:1{sel
    if. _1<T_SELCOL do.
      ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (T_SELCOL{C_REND);'background';(>T_SELCOL{C_BACKSEL);0
      gtk_widget_queue_draw T_TV
    end.
  end.
  if. (chgrow+.chgcol)*.(<'handler')e.namelist 3 do.
    handler 'sel-changed';T_SELROW,T_SELCOL
  end.
end.
0
)

rowdelete=: 3 : 0
if. _1<T_EVENTFLAG do.
  'widget path'=. 2{.y
  row=. gtk_tree_path_to_string path
  row=. _1 ". memr row,0,_1
  if. _1<T_REORDERED do.
    T_BODY=: (row{T_BODY) T_REORDERED}T_BODY
    T_REORDERED=: _1
  end.
  T_BODY=: ((i.#T_BODY)-.row){T_BODY
  if. T_INDEX+.T_TOOLTIP=__ do.
    updateindex #T_BODY
  end.
  T_FOUND=: ''
  if. (<'handler')e.namelist 3 do.
    handler 'row-deleted';row
  end.
end.
0
)

rowinsert=: 3 : 0
if. _1<T_EVENTFLAG do.
  'widget path'=. 2{.y
  row=. gtk_tree_path_to_string path
  row=. _1 ". memr row,0,_1
  select. T_EVENTFLAG
  case. 0 do. 
    T_REORDERED=: row
    T_BODY=: (row{.T_BODY),(<''),(row}.T_BODY)
  case. 1 do. 
    T_BODY=: (row{.T_BODY),C_EMPTY,(row}.T_BODY)
  case. 2 do. 
    T_BODY=: (row{.T_BODY),(T_SELROW{T_BODY),(row}.T_BODY)
  case. 3 do. 
    T_BODY=: T_BODY,C_EMPTY
  case. 4 do. 
    T_BODY=: T_BODY,T_SELROW{T_BODY
  end.
  if. T_INDEX+.T_TOOLTIP=__ do.
    updateindex #T_BODY
  end.
  T_EVENTFLAG=: 0
  T_FOUND=: ''
  if. (<'handler')e.namelist 3 do.
    handler 'row-inserted';row
  end.
end.
0
)

rowchange=: 3 : 0
if. _1<T_EVENTFLAG do.
  'widget path'=. 2{.y
  row=. gtk_tree_path_to_string path
  row=. _1 ". memr row,0,_1
  T_FOUND=: ''
  if. (<'handler')e.namelist 3 do.
    handler 'row-changed';row
  end.
end.
0
)

columnchange=: 3 : 0
if. _1<T_EVENTFLAG do.
  unselectall''
  cols=. 1{$T_BODY
  temp=. C_POS
  C_COL=: 0$0
  for_i. i.cols do.
    C_COL=: C_COL,gtk_tree_view_get_column T_TV,>:i
  end.
  C_POS=: C_LIST i. C_COL
  chg=. -.temp=C_POS
  temp=. temp i. C_POS
  chg=. chg#temp
  T_BODY=: temp{"1 T_BODY
  C_WIDGET=: temp{C_WIDGET
  C_REND=: temp{C_REND
  C_COMBO=: temp{C_COMBO
  C_ISNUM=: temp{C_ISNUM
  C_EMPTY=: temp{C_EMPTY
  if. _1<T_TOOLTIP do. tip=. temp i. T_TOOLTIP else. tip=. _1 end.
  if. _1<T_SELCOL do. sel=. temp i. T_SELCOL else. sel=. _1 end.
  if. _1<T_SORTCOL do. srt=. temp i. T_SORTCOL else. srt=. _1 end.
  '{'reordoption temp
  T_TOOLTIP=: tip
  T_SELCOL=: sel
  T_SORTCOL=: srt
  T_FOUND=: ''
  if. (<'handler')e.namelist 3 do.
    handler 'columns-reord';chg
  end.
end.
0
)

reordoption=: 4 : 0
C_HEAD=: ".'y',x,'C_HEAD'
C_TYPE=: ".'y',x,'C_TYPE'
C_HALIGN=: ".'y',x,'C_HALIGN'
C_XALIGN=: ".'y',x,'C_XALIGN'
C_YALIGN=: ".'y',x,'C_YALIGN'
C_MAXWIDTH=: ".'y',x,'C_MAXWIDTH'
C_RESIZE=: ".'y',x,'C_RESIZE'
C_EXPAND=: ".'y',x,'C_EXPAND'
C_VISIBLE=: ".'y',x,'C_VISIBLE'
C_REORDCOL=: ".'y',x,'C_REORDCOL'
C_SORTABLE=: ".'y',x,'C_SORTABLE'
C_EDIT=: ".'y',x,'C_EDIT'
C_HFORECOLOR=: ".'y',x,'C_HFORECOLOR'
C_HFONT=: ".'y',x,'C_HFONT'
C_FORECOLOR=: ".'y',x,'C_FORECOLOR'
C_BACKCOLOR=: ".'y',x,'C_BACKCOLOR'
C_BACKSEL=: ".'y',x,'C_BACKSEL'
C_FONT=: ".'y',x,'C_FONT'
C_EXEC=: ".'y',x,'C_EXEC'
C_CHECK=: ".'y',x,'C_CHECK'
if. _1<T_TOOLTIP do. T_TOOLTIP=: __ end.
0
)

updateindex=: 3 : 0
T_ICOL=: ": each i.y
temp=. T_EVENTFLAG
T_EVENTFLAG=: _1
iter=. i.ITERSIZE
for_i. i.y do.
  if. gtk_tree_model_get_iter_from_string T_STORE;iter;":i do.
    gtk_list_store_set_1 T_STORE;iter;0;(>i{T_ICOL);_1
  end.
end.
T_EVENTFLAG=: temp
0
)

checknum=: 4 : 0
if. x{C_CHECK do.
  select. x{C_ISNUM
  case. 1 do.
    tostring1 toint y
  case. 1.5 do.
    tostring1 tofloat y
  case. 2 do.
    tostring1 tocomplex y
  case. do.
    tostring y
  end.
else.
  if. 0<x{C_ISNUM do.
    tostring1 tocomplex y
  else.
    tostring y
  end.
end.
)

exitwin=: 3 : 0
if. 0<window=. getwindow T_TV do.
  gtk_widget_destroy window
end.
0
)
makepopup=: 3 : 0
(,<'all')makepopup y
:
newmenu=. create_menu_container create_menu_popup y;'_Rows'
if. (-.(<'!copyrow')e.x)*.+./('all';'row';'copyrow')e.x do.
  create_menu_command newmenu;'';'gtk-copy';'_Copy row';'';'';'clipcopyrow'
end.
if. (-.(<'!pasterow')e.x)*.+./('all';'row';'pasterow')e.x do.
  create_menu_command newmenu;'';'gtk-paste';'_Paste row';'';'';'clippasterow'
end.
if. (-.(<'!cutrow')e.x)*.+./('all';'row';'cutrow')e.x do.
  create_menu_command newmenu;'';'gtk-cut';'C_ut row';'';'';'cutrow'
end.
if. (-.(<'!deleterow')e.x)*.+./('all';'row';'deleterow')e.x do.
  create_menu_command newmenu;'';'gtk-remove';'_Delete row';'';'';'deleterow'
end.
if. (-.(<'!appendrow')e.x)*.+./('all';'row';'appendrow')e.x do.
  create_menu_command newmenu;'';'gtk-add';'_Append row';'';'';'appendrow'
end.
if. (-.(<'!insertrow')e.x)*.+./('all';'row';'insertrow')e.x do.
  create_menu_command newmenu;'';'gtk-add';'_Insert row';'';'';'insertrow'
end.
if. (-.(<'!appendcopyrow')e.x)*.+./('all';'row';'appendcopyrow')e.x do.
  create_menu_command newmenu;'';'gtk-add';'Appe_ndCopy row';'';'';'appendcopyrow'
end.
if. (-.(<'!insertcopyrow')e.x)*.+./('all';'row';'insertcopyrow')e.x do.
  create_menu_command newmenu;'';'gtk-add';'Inse_rtCopy row';'';'';'insertcopyrow'
end.
if. (-.(<'!takerows')e.x)*.+./('all';'row';'takerows')e.x do.
  create_menu_command newmenu;'';'gtk-goto-bottom';'_Take rows';'';'';'takerows'
end.
if. (-.(<'!droprows')e.x)*.+./('all';'row';'droprows')e.x do.
  create_menu_command newmenu;'';'gtk-goto-top';'Dr_op rows';'';'';'droprows'
end.
if. (-.(<'!clearrow')e.x)*.+./('all';'row';'clearrow')e.x do.
  create_menu_command newmenu;'';'gtk-clear';'C_lear row';'';'';'setrow'
end.
if. (-.(<'!azsortrow')e.x)*.+./('all';'row';'azsortrow')e.x do.
  create_menu_command newmenu;'';'gtk-sort-ascending';'_Sort ascending';'';'';'azsortrow'
end.
if. (-.(<'!zasortrow')e.x)*.+./('all';'row';'zasortrow')e.x do.
  create_menu_command newmenu;'';'gtk-sort-descending';'Sort d_escending';'';'';'zasortrow'
end.
create_menu_command newmenu;'';'gtk-select-all';'Unselect ro_w';'';'';'selectrow'
newmenu=. create_menu_container create_menu_popup y;'_Columns'
if. (-.(<'!copycol')e.x)*.+./('all';'col';'copycol')e.x do.
  create_menu_command newmenu;'';'gtk-copy';'_Copy column';'';'';'clipcopycol'
end.
if. (-.(<'!pastecol')e.x)*.+./('all';'col';'pastecol')e.x do.
  create_menu_command newmenu;'';'gtk-paste';'_Paste column';'';'';'clippastecol'
end.
if. (-.(<'!cutcol')e.x)*.+./('all';'col';'cutcol')e.x do.
  create_menu_command newmenu;'';'gtk-cut';'C_ut column';'';'';'cutcol'
end.
if. (-.(<'!deletecol')e.x)*.+./('all';'col';'deletecol')e.x do.
  create_menu_command newmenu;'';'gtk-remove';'_Delete column';'';'';'deletecol'
end.
if. (-.(<'!takecols')e.x)*.+./('all';'col';'takecols')e.x do.
  create_menu_command newmenu;'';'gtk-goto-last';'_Take columns';'';'';'takecols'
end.
if. (-.(<'!dropcols')e.x)*.+./('all';'col';'dropcols')e.x do.
  create_menu_command newmenu;'';'gtk-goto-first';'Dr_op columns';'';'';'dropcols'
end.
if. (-.(<'!clearcol')e.x)*.+./('all';'col';'clearcol')e.x do.
  create_menu_command newmenu;'';'gtk-clear';'C_lear column';'';'';'setcol'
end.
if. (-.(<'!azsortcol')e.x)*.+./('all';'col';'azsortcol')e.x do.
  create_menu_command newmenu;'';'gtk-sort-ascending';'_Sort ascending';'';'';'azsortcol'
end.
if. (-.(<'!zasortcol')e.x)*.+./('all';'col';'zasortcol')e.x do.
  create_menu_command newmenu;'';'gtk-sort-descending';'Sort d_escending';'';'';'zasortcol'
end.
if. (-.(<'!expand')e.x)*.+./('all';'col';'expand')e.x do.
  create_menu_command newmenu;'';'gtk-fullscreen';'E_xpand columns';'';'';'expand'
end.
if. (-.(<'!collapse')e.x)*.+./('all';'col';'collapse')e.x do.
  create_menu_command newmenu;'';'gtk-leave-fullscreen';'Coll_apse columns';'';'';'collapse'
end.
create_menu_command newmenu;'';'gtk-select-all';'Unselect colum_n';'';'';'selectcol'
create_menu_sep y
newmenu=. create_menu_container create_menu_popup y;'_Grid'
if. (-.(<'!copygrid')e.x)*.+./('all';'grid';'copygrid')e.x do.
  create_menu_command newmenu;'';'gtk-copy';'_Copy grid';'';'';'clipcopygrid'
end.
if. (-.(<'!pastegrid')e.x)*.+./('all';'grid';'pastegrid')e.x do.
  create_menu_command newmenu;'';'gtk-paste';'_Paste grid';'';'';'clippastegrid'
end.
if. (-.(<'!cleargrid')e.x)*.+./('all';'grid';'cleargrid')e.x do.
  create_menu_command newmenu;'';'gtk-clear';'C_lear grid';'';'';'setdata'
end.
if. (-.(<'!multiedit')e.x)*.+./('all';'grid';'multiedit')e.x do.
  create_menu_command newmenu;'';'gtk-edit';'_Multi-line edit';'';'';'multieditdialog'
end.
if. (-.(<'!hlines')e.x)*.+./('all';'grid';'hlines')e.x do.
  h=. create_menu_command newmenu;'';'check1';'_Horizontal lines';'';'';'hlines'
else.
  h=. 0
end.
if. (-.(<'!vlines')e.x)*.+./('all';'grid';'vlines')e.x do.
  v=. create_menu_command newmenu;'';'check1';'_Vertical lines';'';'';'vlines'
else.
  v=. 0
end.
create_menu_command newmenu;'';'gtk-select-all';'Unselect _all';'';'';'unselectall'
create_menu_sep y
newmenu=. create_menu_container create_menu_popup y;'_Find'
if. (-.(<'!findreplace')e.x)*.+./('all';'find';'findreplace')e.x do.
  create_menu_command newmenu;'';'gtk-find-and-replace';'Find + _Replace';'';'';'findreplacedialog'
end.
if. (-.(<'!findnext')e.x)*.+./('all';'find';'findnext')e.x do.
  create_menu_command newmenu;'';'gtk-find';'Find _next';'';'';'findnexttext'
end.
if. (-.(<'!findprev')e.x)*.+./('all';'find';'findprev')e.x do.
  create_menu_command newmenu;'';'gtk-find';'Find _prev';'';'';'findprevtext'
end.
if. (-.(<'!findnextcell')e.x)*.+./('all';'find';'findnextcell')e.x do.
  create_menu_command newmenu;'';'gtk-find';'Find ne_xt cell';'';'';'findnextcell'
end.
if. (-.(<'!findprevcell')e.x)*.+./('all';'find';'findprevcell')e.x do.
  create_menu_command newmenu;'';'gtk-find';'Find pre_v cell';'';'';'findprevcell'
end.
if. (-.(<'!filter')e.x)*.+./('all';'find';'filter')e.x do.
  create_menu_command newmenu;'';'gtk-execute';'_Filter';'';'';'filterdialog'
end.
newmenu=. create_menu_container create_menu_popup y;'_Tools'
if. (-.(<'!open')e.x)*.+./('all';'tools';'open')e.x do.
  create_menu_command newmenu;'';'gtk-open';'_Open grid from file';'';'';'opendialog'
end.
if. (-.(<'!save')e.x)*.+./('all';'tools';'save')e.x do.
  create_menu_command newmenu;'';'gtk-save';'_Save grid to file';'';'';'savedialog'
end.
if. (-.(<'!print')e.x)*.+./('all';'tools';'print')e.x do.
  create_menu_command newmenu;'';'gtk-print';'_Print grid';'';'';'printdialog'
end.
if. (-.(<'!font')e.x)*.+./('all';'tools';'font')e.x do.
  create_menu_command newmenu;'';'gtk-select-font';'_Font selection';'';'';'fontdialog'
end.
if. (-.(<'!color')e.x)*.+./('all';'tools';'color')e.x do.
  create_menu_command newmenu;'';'gtk-select-color';'_Color selection';'';'';'colordialog'
end.
if. (-.(<'!zoomin')e.x)*.+./('all';'tools';'zoomin')e.x do.
  create_menu_command newmenu;'';'gtk-zoom-in';'_Zoom in';'';'';'zoomin'
end.
if. (-.(<'!zoomout')e.x)*.+./('all';'tools';'zoomout')e.x do.
  create_menu_command newmenu;'';'gtk-zoom-out';'Zoo_m out';'';'';'zoomout'
end.
if. (-.(<'!fold')e.x)*.+./('all';'tools';'fold')e.x do.
  create_menu_command newmenu;'';'gtk-indent';'Fo_ld';'';'';'fold'
end.
if. (-.(<'!unfold')e.x)*.+./('all';'tools';'unfold')e.x do.
  create_menu_command newmenu;'';'gtk-indent';'Unfol_d';'';'';'unfold'
end.
if. (-.(<'!setoption')e.x)*.+./('all';'tools';'setoption')e.x do.
  create_menu_command newmenu;'';'gtk-properties';'Se_t options';'';'';'setoptiondialog'
end.
if. (-.(<'!updategrid')e.x)*.+./('all';'tools';'updategrid')e.x do.
  create_menu_command newmenu;'';'gtk-preferences';'_Update grid';'';'';'updatedialog'
end.
create_menu_sep y
create_menu_command y;'';'gtk-help';'_Help';'';'';'helpdialog'
create_menu_command y;'';'gtk-about';'_About';'';'';'aboutdialog'
if. (-.(<'!exit')e.x)*.+./('all';'exit')e.x do.
  create_menu_command y;'';'gtk-quit';'_Exit';'';'';'exitwin'
end.
gtk_widget_show_all y
v,h
)
selectrow=: 3 : 0
T_EVENTFLAG=: _1
gtk_widget_grab_focus T_TV
if. (-.1=#y)+.(y=_1) do.
  setactive T_TV,_1
  T_SELROW=: _1
  if. (<'handler')e.namelist 3 do.
    handler 'sel-changed';T_SELROW,T_SELCOL
  end.
else.
  y=. {.toint y
  if. y e. i.#T_BODY do.
    if. _1<T_SELCOL do.
      setactive T_TV,y,>:T_SELCOL
    else.
      setactive T_TV,y,_1
    end.
    T_SELROW=: y
    if. (<'handler')e.namelist 3 do.
      handler 'sel-changed';T_SELROW,T_SELCOL
    end.
  else.
    T_EVENTFLAG=: 0
    assert. 'invalid selection'
  end.
end.
T_EVENTFLAG=: 0
0
)

selectcol=: 3 : 0
T_EVENTFLAG=: _1
gtk_widget_grab_focus T_TV
if. (-.1=#y)+.(y=_1) do.
  if. _1<T_SELCOL do.
    ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (T_SELCOL{C_REND);'background';(>T_SELCOL{C_BACKCOLOR);0
    gtk_widget_queue_draw T_TV
    if. _1<T_SELROW do.
      setactive T_TV,_1,0,T_SELROW
    else.
      setactive T_TV,_1
    end.
    T_SELCOL=: _1
    if. (<'handler')e.namelist 3 do.
      handler 'sel-changed';T_SELROW,T_SELCOL
    end.
  end.
else.
  y=. {.toint y
  if. y e. i.1{$T_BODY do.
    if. -.y=T_SELCOL do.
      if. _1<T_SELCOL do.
        ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (T_SELCOL{C_REND);'background';(>T_SELCOL{C_BACKCOLOR);0
        gtk_widget_queue_draw T_TV
      end.
      if. _1<T_SELROW do.
        setactive T_TV,T_SELROW,>:y
      else.
        setactive T_TV,_1
      end.
      T_SELCOL=: y
      ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (T_SELCOL{C_REND);'background';(>T_SELCOL{C_BACKSEL);0
      gtk_widget_queue_draw T_TV
      if. (<'handler')e.namelist 3 do.
        handler 'sel-changed';T_SELROW,T_SELCOL
      end.
    end.
  else.
    T_EVENTFLAG=: 0
    assert. 'invalid selection'
  end.
end.
T_EVENTFLAG=: 0
0
)

selectcell=: 3 : 0
if. -.2=#y do.
  unselectall''
else.
  selectcol {:y
  selectrow {.y
end.
0
)

unselectall=: 3 : 0
T_FIND=: ''
if. _1<T_SELCOL do. selectcol'' end.
if. _1<T_SELROW do. selectrow'' end.
0
)

deleterow=: 3 : 0
1 deleterow y
:
iter=. i.ITERSIZE
x=. 1>.toint x
if. -.1=#y do.
  y=. T_SELROW
  for_i. i.x do.
    if. gtk_tree_selection_get_selected T_SELECTION;(,_1);iter do.
      gtk_list_store_remove T_STORE;iter
      if. (y<#T_BODY) do.
        selectrow y
      else.
        break.
      end.
    end.
  end.
else.
  y=. {.toint y
  if. y e. i.#T_BODY do.
    selectrow''
    for_i. i.x do.
      if. gtk_tree_model_get_iter_from_string T_STORE;iter;":y do.
        gtk_list_store_remove T_STORE;iter
      else.
        break.
      end.
    end.
  else.
    assert. 'invalid selection'
  end.
end.
0
)

insertrow=: 3 : 0
1 insertrow y
:
iter=. i.ITERSIZE
x=. 1>.toint x
if. -.1=#y do.
  y=. T_SELROW
  for_i. i.x do.
    if. gtk_tree_selection_get_selected T_SELECTION;(,_1);iter do.
      T_EVENTFLAG=: 1
      gtk_list_store_insert T_STORE;iter;y
      T_EVENTFLAG=: _1
      cols=. #C_EMPTY
      for_i. i.cols do.
        gtk_list_store_set_1 T_STORE;iter;(>:i{C_POS);(>i{C_EMPTY);_1
      end.
      T_EVENTFLAG=: 0
      selectrow y
    end.
  end.
else.
  y=. {.toint y
  if. y e. i.#T_BODY do.
    selectrow''
    for_i. i.x do.
      T_EVENTFLAG=: 1
      gtk_list_store_insert T_STORE;iter;y
      T_EVENTFLAG=: _1
      cols=. #C_EMPTY
      for_i. i.cols do.
        gtk_list_store_set_1 T_STORE;iter;(>:i{C_POS);(>i{C_EMPTY);_1
      end.
      T_EVENTFLAG=: 0
    end.
  else.
    assert. 'invalid selection'
  end.
end.
0
)

appendrow=: 3 : 0
1 appendrow y
:
iter=. i.ITERSIZE
x=. 1>.toint x
for_i. i.x do.
  T_EVENTFLAG=: 3
  gtk_list_store_append T_STORE;iter
  T_EVENTFLAG=: _1
  cols=. #C_EMPTY
  for_i. i.cols do.
    gtk_list_store_set_1 T_STORE;iter;(>:i{C_POS);(>i{C_EMPTY);_1
  end.
  T_EVENTFLAG=: 0
end.
if. -.1=#y do.
  selectrow <:#T_BODY
end.
0
)

insertcopyrow=: 3 : 0
iter=. i.ITERSIZE
if. gtk_tree_selection_get_selected T_SELECTION;(,_1);iter do.
  T_EVENTFLAG=: 2
  record=. T_SELROW{T_BODY
  gtk_list_store_insert T_STORE;iter;T_SELROW
  T_EVENTFLAG=: _1
  cols=. #record
  for_i. i.cols do.
    gtk_list_store_set_1 T_STORE;iter;(>:i{C_POS);(>i{record);_1
  end.
  T_EVENTFLAG=: 0
  T_FOUND=: ''
  if. (<'handler')e.namelist 3 do.
    handler 'row-changed';T_SELROW
  end.
  selectrow T_SELROW
end.
0
)

appendcopyrow=: 3 : 0
iter=. i.ITERSIZE
if. gtk_tree_selection_get_selected T_SELECTION;(,_1);iter do.
  T_EVENTFLAG=: 4
  record=. T_SELROW{T_BODY
  gtk_list_store_append T_STORE;iter
  T_EVENTFLAG=: _1
  cols=. #record
  for_i. i.cols do.
    gtk_list_store_set_1 T_STORE;iter;(>:i{C_POS);(>i{record);_1
  end.
  T_EVENTFLAG=: 0
  T_FOUND=: ''
  if. (<'handler')e.namelist 3 do.
    handler 'row-changed';<:#T_BODY
  end.
  if. -.1=#y do.
    selectrow <:#T_BODY
  end.
end.
0
)

sortcol=: 3 : 0
0 sortcol y
:
cols=. 1{$T_BODY
if. -.1=#y do. y=. T_SELCOL else. y=. {.toint y end.
if. -.y e. i.cols do. assert. 'invalid selection' end.
x=. tobool x
if. _1<T_SORTCOL do.
  gtk_tree_view_column_set_sort_indicator (T_SORTCOL{C_COL),0
  T_SORTCOL=: _1
end.
sortcolumn=. y{"1 T_BODY
if. 0<y{C_ISNUM do.
  sortcolumn=. 0&". each sortcolumn
end.
if. x do. 
  (T_BODY \: sortcolumn) setdata <''
else. 
  (T_BODY /: sortcolumn) setdata <''
end.
if. y{C_SORTABLE do.
  T_SORTCOL=: y
  gtk_tree_view_column_set_sort_indicator (T_SORTCOL{C_COL),1
  gtk_tree_view_column_set_sort_order (T_SORTCOL{C_COL),x
end.
0
)

azsortcol=: 3 : 0
if. _1<T_SELCOL do. 0 sortcol T_SELCOL end.
0
)

zasortcol=: 3 : 0
if. _1<T_SELCOL do. 1 sortcol T_SELCOL end.
0
)

fromrows=: 3 : 0
y=. ,toint"0 y
y=. y{T_BODY
if. _1<T_SORTCOL do.
  gtk_tree_view_column_set_sort_indicator (T_SORTCOL{C_COL),0
  T_SORTCOL=: _1
end.
y setdata <#y
0
)

takerows=: 3 : 0
rows=. #T_BODY
if. -.1=#y do.
  if. _1<T_SELROW do. y=. >:T_SELROW else. y=. rows end.
else.
  y=. {.toint y
end.
if. -.y=rows do.
  y=. y{.T_BODY
  if. _1<T_SORTCOL do.
    gtk_tree_view_column_set_sort_indicator (T_SORTCOL{C_COL),0
    T_SORTCOL=: _1
  end.
  y setdata <#y
end.
0
)

droprows=: 3 : 0
if. -.1=#y do.
  if. _1<T_SELROW do. y=. T_SELROW else. y=. 0 end.
else.
  y=. {.toint y
end.
if. -.0=y do.
  y=. y}.T_BODY
  if. _1<T_SORTCOL do.
    gtk_tree_view_column_set_sort_indicator (T_SORTCOL{C_COL),0
    T_SORTCOL=: _1
  end.
  y setdata <#y
end.
0
)

copyrows=: 3 : 0
y=. ,tocomplex"0 y
y=. y#T_BODY
if. _1<T_SORTCOL do.
  gtk_tree_view_column_set_sort_indicator (T_SORTCOL{C_COL),0
  T_SORTCOL=: _1
end.
y setdata <#y
0
)

sortrow=: 3 : 0
0 sortrow y
:
rows=. #T_BODY
if. -.1=#y do. y=. T_SELROW end.
if. -.y e. i.rows do. assert. 'invalid selection' end.
x=. tobool x
dat=. getdata<''
if. x do.
  y=. \: y{dat
else.
  y=. /: y{dat
end.
if. T_INVERTED do.
  dat=. box2inv :: ] dat
elseif. T_UNBOXED do.
  dat=. > :: ] dat
end.
'{'reordoption y
(pack T_OPTIONS) updategrid y{"1 dat
0
)

azsortrow=: 3 : 0
if. _1<T_SELROW do. 0 sortrow T_SELROW end.
0
)

zasortrow=: 3 : 0
if. _1<T_SELROW do. 1 sortrow T_SELROW end.
0
)

deletecol=: 3 : 0
cols=. 1{$T_BODY
if. -.1=#y do. y=. T_SELCOL else. y=. {.toint y end.
if. y e. i.cols do.
  y=. (i.cols)-.y
  '{'reordoption y
  (pack T_OPTIONS) updategrid y{"1 getdata''
end.
0
)

fromcols=: 3 : 0
y=. ,toint"0 y
'{'reordoption y
(pack T_OPTIONS) updategrid y{"1 getdata''
0
)

takecols=: 3 : 0
cols=. 1{$T_BODY
if. -.1=#y do.
  if. _1<T_SELCOL do. y=. >:T_SELCOL else. y=. cols end.
else.
  y=. {.toint y
end.
if. -.y=cols do.
  '{.'reordoption y
  (pack T_OPTIONS) updategrid y{."1 getdata''
end.
0
)

dropcols=: 3 : 0
if. -.1=#y do.
  if. _1<T_SELCOL do. y=. T_SELCOL else. y=. 0 end.
else.
  y=. {.toint y
end.
if. -.0=y do.
  '}.'reordoption y
  (pack T_OPTIONS) updategrid y}."1 getdata''
end.
0
)

copycols=: 3 : 0
y=. ,tocomplex"0 y
'#'reordoption y
(pack T_OPTIONS) updategrid y#"1 getdata''
0
)

clipcopygrid=: 3 : 0
TAB clipwritej T_BODY
0
)

clipcopyrow=: 3 : 0
rows=. #T_BODY
if. -.1=#y do. flag=. 0 [ y=. T_SELROW else. flag=. 1 [ y=. {.toint y end.
if. flag *. -.y e. i.rows do. assert. 'invalid selection' end.
if. _1<y do.
  TAB clipwritej y{T_BODY
end.
0
)

clipcopycol=: 3 : 0
cols=. 1{$T_BODY
if. -.1=#y do. flag=. 0 [ y=. T_SELCOL else. flag=. 1 [ y=. {.toint y end.
if. flag *. -.y e. i.cols do. assert. 'invalid selection' end.
if. _1<y do.
  TAB clipwritej ,.y{"1 T_BODY
end.
0
)

clipcopycell=: 3 : 0
rows=. #T_BODY
cols=. 1{$T_BODY
if. -.2=#y do. flag=. 0 [ row=. T_SELROW [ col=. T_SELCOL else. flag=. 1 [ row=. {.toint{.y [ col=. {.toint{:y end.
if. flag *. -.(row e. i.rows)*.(col e. i.cols) do. assert. 'invalid selection' end.
if. (_1<row)*.(_1<col) do.
  clipwrite >(<row,col){T_BODY
end.
0
)

clippastegrid=: 3 : 0
dat=. clipreadj TAB
if. (1{$dat)=1{$T_BODY do.
  dat setdata #dat
end.
0
)

clippasterow=: 3 : 0
dat=. ,clipreadj TAB
if. (#dat)=1{$T_BODY do.
  dat setrow y
end.
0
)

clippastecol=: 3 : 0
dat=. ,clipreadj TAB
if. (#dat)=#T_BODY do.
  dat setcol y
end.
0
)

clippastecell=: 3 : 0
(clipread'')setcell y
0
)

cutrow=: 3 : 0
clipcopyrow y
deleterow y
0
)

cutcol=: 3 : 0
clipcopycol y
deletecol y
0
)

findnext=: 4 : 0
if. 0<#x do.
  rows=. #T_BODY
  cols=. 1{$T_BODY
  if. -.2=#y do. flag=. 0 [ row=. T_SELROW [ col=. T_SELCOL else. flag=. 1 [ row=. {.toint{.y [ col=. {.toint{:y end.
  if. flag *. -.(row e. _1,i.rows)*.(col e. _1,i.cols) do. assert. 'invalid selection' end.
  if. x-:T_FOUND do.
    match=. T_MATCH
  else.
    T_FOUND=: x
    if. L.x do.
      x=. tostring >x
      match=. > (x&-:) each T_BODY
    else.
      x=. tostring x
      match=. > 0&<@#@(x&ss) each T_BODY
    end.
    T_MATCH=: match
  end.
  if. _1<row do.
    match=. (cols$0) (i.row)}match
    if. _1<col do.
      match=. ((>:col)$0)(<row;i.>:col)}match
    end.
  else.
    if. _1<col do.
      match=. ((>:col)$0)(<0;i.>:col)}match
    end.
  end.
  mrow=. {. ,&_1 I.+./"1 match
  if. _1<mrow do. 
    mcol=. {. I.mrow{match
    selectcell mrow,mcol
  else.
    mbox 1;'Search result';'not found after this point'
  end.
else.
  mbox 1;'Search result';'set something to search'
end.
0
)

findprev=: 4 : 0
if. 0<#x do.
  rows=. #T_BODY
  cols=. 1{$T_BODY
  if. -.2=#y do. flag=. 0 [ row=. T_SELROW [ col=. T_SELCOL else. flag=. 1 [ row=. {.toint{.y [ col=. {.toint{:y end.
  if. flag *. -.(row e. _1,i.rows)*.(col e. _1,i.cols) do. assert. 'invalid selection' end.
  if. x-:T_FOUND do.
    match=. T_MATCH
  else.
    T_FOUND=: x
    if. L.x do.
      x=. tostring >x
      match=. > (x&-:) each T_BODY
    else.
      x=. tostring x
      match=. > 0&<@#@(x&ss) each T_BODY
    end.
    T_MATCH=: match
  end.
  match=. |.|."1 match
  if. _1<row do.
    row=. (<:rows)-row
    match=. (cols$0) (i.row)}match
    if. _1<col do.
      col=. (<:cols)-col
      match=. ((>:col)$0)(<row;i.>:col)}match
    end.
  else.
    if. _1<col do.
      col=. (<:cols)-col
      match=. ((>:col)$0)(<0;i.>:col)}match
    end.
  end.
  mrow=. {. ,&_1 I.+./"1 match
  if. _1<mrow do. 
    mcol=. {. I.mrow{match
    mrow=. (<:rows)-mrow
    mcol=. (<:cols)-mcol
    selectcell mrow,mcol
  else.
    mbox 1;'Search result';'not found before this point'
  end.
else.
  mbox 1;'Search result';'set something to search'
end.
0
)

setdata=: 3 : 0
'' setdata y
:
rows=. #T_BODY
cols=. 1{$T_BODY
if. L.y do.
  y=. >y
  flag=. 0
else.
  flag=. 1
end.
if. -.1=#y do. y=. rows else. y=. 0>.toint y end.
if. 2<#$x do. assert. 'invalid grid data' end.
if. ''-:x do. x=. ,<'' end.
if. 2>#$x do. x=. ,: cols $ boxopen"0 x end.
x=. y $ cols&$"1 boxopen"0 x
iter=. i.ITERSIZE
T_EVENTFLAG=: _1
if. y>rows do.
  for_i. i.y-rows do.
    gtk_list_store_append T_STORE;iter
  end.
elseif. y<rows do.
  gtk_tree_model_get_iter_from_string T_STORE;iter;,'0'
  for_i. i.rows-y do.
    gtk_list_store_remove T_STORE;iter
  end.
end.
if. flag do.
  x=. |:x
  for_i. i.cols do.
    x=. (i&checknum each i{x) i}x
  end.
  x=. |:x
end.
T_BODY=: x
iter=. i.ITERSIZE
for_r. i.y do.
  gtk_tree_model_get_iter_from_string T_STORE;iter;":r
  for_i. i.cols do.
    gtk_list_store_set_1 T_STORE;iter;(>:i{C_POS);(>i{r{x);_1
  end.
end.
if. T_INDEX+.T_TOOLTIP=__ do.
  updateindex #T_BODY
end.
T_EVENTFLAG=: 0
T_FOUND=: ''
if. (<'handler')e.namelist 3 do.
  handler 'grid-changed';$T_BODY
end.
0
)

setrow=: 3 : 0
'' setrow y
:
rows=. #T_BODY
cols=. 1{$T_BODY
if. -.1=#y do. flag=. 0 [ y=. T_SELROW else. flag=. 1 [ y=. {.toint y end.
if. flag *. -.y e. i.rows do. assert. 'invalid selection' end.
if. x-:'' do. x=. ,<'' end.
if. _1<y do.
  iter=. i.ITERSIZE
  if. gtk_tree_model_get_iter_from_string T_STORE;iter;":y do.
    T_EVENTFLAG=: _1
    record=. cols $ ,boxopen"0 x
    for_i. i.cols do.
      record=. (<i checknum >i{record) i}record
    end.
    T_BODY=: record y} T_BODY
    for_i. i.cols do.
      gtk_list_store_set_1 T_STORE;iter;(>:i{C_POS);(>i{record);_1
    end.
    T_EVENTFLAG=: 0
    T_FOUND=: ''
    if. (<'handler')e.namelist 3 do.
      handler 'row-changed';y
    end.
  end.
end.
0
)

setcol=: 3 : 0
'' setcol y
:
rows=. #T_BODY
cols=. 1{$T_BODY
if. -.1=#y do. flag=. 0 [ y=. T_SELCOL else. flag=. 1 [ y=. {.toint y end.
if. flag *. -.y e. i.cols do. assert. 'invalid selection' end.
if. x-:'' do. x=. ,<'' end.
if. _1<y do.
  T_EVENTFLAG=: _1
  iter=. i.ITERSIZE
  field=. rows $ ,boxopen"0 x
  field=. y&checknum each field
  for_i. i.rows do.
    if. gtk_tree_model_get_iter_from_string T_STORE;iter;":i do.
      T_BODY=: field (<(i.rows);y)} T_BODY
      gtk_list_store_set_1 T_STORE;iter;(>:y{C_POS);(>i{field);_1
    end.
  end.
  T_EVENTFLAG=: 0
  T_FOUND=: ''
  if. (<'handler')e.namelist 3 do.
    handler 'column-changed';y
  end.
end.
0
)

setcell=: 3 : 0
'' setcell y
:
rows=. #T_BODY
cols=. 1{$T_BODY
if. -.2=#y do. flag=. 0 [ row=. T_SELROW [ col=. T_SELCOL else. flag=. 1 [ row=. {.toint{.y [ col=. {.toint{:y end.
if. flag *. -.(row e. i.rows)*.(col e. i.cols) do. assert. 'invalid selection' end.
if. (_1<row)*.(_1<col) do.
  dat=. col checknum x
  iter=. i.ITERSIZE
  if. gtk_tree_model_get_iter_from_string T_STORE;iter;":row do.
    T_EVENTFLAG=: _1
    T_BODY=: (<dat) (<row,col)} T_BODY
    gtk_list_store_set_1 T_STORE;iter;(>:col{C_POS);dat;_1
    T_EVENTFLAG=: 0
    T_FOUND=: ''
    if. (<'handler')e.namelist 3 do.
      handler 'cell-changed';row,col
    end.
  end.
end.
0
)

setoption=: 3 : 0
if. (32~:3!:0 y)+.2|#,y do. assert. 'invalid grid options' end.
y=. unpack y
rows=. #T_BODY
cols=. 1{$T_BODY
options=. ;:T_OPTIONS
for_p. y do.
  select. p
  case. 'C_HEAD' do.
    C_HEAD=: tostring each cols$,boxopen C_HEAD
    for_i. i.cols do.
      gtk_tree_view_column_set_title (i{C_COL);i{C_HEAD
      gtk_label_set_markup (i{C_WIDGET);'<span foreground="',(>i{C_HFORECOLOR),'" font="',(>i{C_HFONT),'">',(>i{C_HEAD),'</span>'
    end.
  case. 'C_HALIGN' do.
    C_HALIGN=: ;to01 each cols$,C_HALIGN
    for_i. i.cols do.
      gtk_tree_view_column_set_alignment (i{C_COL),i{C_HALIGN
    end.
  case. 'C_XALIGN' do.
    C_XALIGN=: ;to01 each cols$,C_XALIGN
    for_i. i.cols do.
      gtk_cell_renderer_set_alignment (i{C_REND),(i{C_XALIGN),(i{C_YALIGN)
      gtk_widget_queue_draw T_TV
    end.
  case. 'C_YALIGN' do.
    C_YALIGN=: ;to01 each cols$,C_YALIGN
    for_i. i.cols do.
      gtk_cell_renderer_set_alignment (i{C_REND),(i{C_XALIGN),(i{C_YALIGN)
      gtk_widget_queue_draw T_TV
    end.
  case. 'C_MAXWIDTH' do.
    C_MAXWIDTH=: ;toint each cols$,C_MAXWIDTH
    for_i. i.cols do.
      gtk_tree_view_column_set_max_width (i{C_COL),i{C_MAXWIDTH
    end.
  case. 'C_RESIZE' do.
    C_RESIZE=: ;tobool each cols$,C_RESIZE
    for_i. i.cols do.
      gtk_tree_view_column_set_resizable (i{C_COL),i{C_RESIZE
    end.
  case. 'C_EXPAND' do.
    C_EXPAND=: ;tobool each cols$,C_EXPAND
    for_i. i.cols do.
      gtk_tree_view_column_set_expand (i{C_COL),i{C_EXPAND
    end.
  case. 'C_VISIBLE' do.
    C_VISIBLE=: ;tobool each cols$,C_VISIBLE
    for_i. i.cols do.
      gtk_tree_view_column_set_visible (i{C_COL),i{C_VISIBLE
      if. 0=i{C_VISIBLE do.
        if. i=T_SELCOL do.
          ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (T_SELCOL{C_REND);'background';(>T_SELCOL{C_BACKCOLOR);0
          T_SELCOL=: _1
        end.
        if. i=T_SORTCOL do.
          gtk_tree_view_column_set_sort_indicator (T_SORTCOL{C_COL),0
          T_SORTCOL=: _1
        end.
      end.
    end.
  case. 'C_REORDCOL' do.
    C_REORDCOL=: ;tobool each cols$,C_REORDCOL
    for_i. i.cols do.
      gtk_tree_view_column_set_reorderable (i{C_COL),i{C_REORDCOL
    end.
  case. 'C_SORTABLE' do.
    C_SORTABLE=: ;tobool each cols$,C_SORTABLE
    if. (_1<T_SORTCOL) do.
      if. -.T_SORTCOL{C_SORTABLE do.
        gtk_tree_view_column_set_sort_indicator (T_SORTCOL{C_COL),0
        T_SORTCOL=: _1
      end.
    end.
  case. 'C_EDIT' do.
    C_EDIT=: ;tobool each cols$,C_EDIT
    for_i. i.cols do.
      ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c i x')&cd (i{C_REND);'editable';(i{C_EDIT);0
    end.
  case. 'C_HFORECOLOR' do.
    C_HFORECOLOR=: tostring each cols$,boxopen C_HFORECOLOR
    for_i. i.cols do.
      gtk_label_set_markup (i{C_WIDGET);'<span foreground="',(>i{C_HFORECOLOR),'" font="',(>i{C_HFONT),'">',(>i{C_HEAD),'</span>'
    end.
  case. 'C_HFONT' do.
    C_HFONT=: tostring each cols$,boxopen C_HFONT
    for_i. i.cols do.
      gtk_label_set_markup (i{C_WIDGET);'<span foreground="',(>i{C_HFORECOLOR),'" font="',(>i{C_HFONT),'">',(>i{C_HEAD),'</span>'
    end.
  case. 'C_FORECOLOR' do.
    C_FORECOLOR=: tostring each cols$,boxopen C_FORECOLOR
    for_i. i.cols do.
      ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (i{C_REND);'foreground';(>i{C_FORECOLOR);0
      gtk_widget_queue_draw T_TV
    end.
  case. 'C_BACKCOLOR' do.
    C_BACKCOLOR=: tostring each cols$,boxopen C_BACKCOLOR
    for_i. i.cols do.
      ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (i{C_REND);'background';(>i{C_BACKCOLOR);0
      gtk_widget_queue_draw T_TV
    end.
  case. 'C_BACKSEL' do.
    C_BACKSEL=: tostring each cols$,boxopen C_BACKSEL
    if. _1<T_SELCOL do.
      ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (T_SELCOL{C_REND);'background';(>T_SELCOL{C_BACKSEL);0
      gtk_widget_queue_draw T_TV
    end.
  case. 'C_FONT' do.
    C_FONT=: tostring each cols$,boxopen C_FONT
    for_i. i.cols do.
      ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd (i{C_REND);'font';(>i{C_FONT);0
      gtk_widget_queue_draw T_TV
    end.
  case. 'C_EXEC' do.
    C_EXEC=: {.@tostring each cols$,boxopen C_EXEC
  case. 'C_CHECK' do.
    C_CHECK=: ;tobool each cols$,C_CHECK
  case. 'C_TYPE' do.
    C_TYPE=: ;tocomplex each cols$,C_TYPE
  case. 'T_LINES' do.
    T_LINES=: ;(0&>.)@:(3&<.)@:toint T_LINES
    gtk_tree_view_set_grid_lines T_TV,T_LINES
    if. 0<{.T_VHCHECK do. gtk_check_menu_item_set_active ({.T_VHCHECK);_2{#:4+{.T_LINES end.
    if. 0<{:T_VHCHECK do. gtk_check_menu_item_set_active ({:T_VHCHECK);_1{#:4+{.T_LINES end.
  case. 'T_HVISIBLE' do.
    T_HVISIBLE=: tobool T_HVISIBLE
    gtk_tree_view_set_headers_visible T_TV,T_HVISIBLE
    if. _1<T_SORTCOL do.
      gtk_tree_view_column_set_sort_indicator (T_SORTCOL{C_COL),0
      T_SORTCOL=: _1
    end.
  case. 'T_REORDROW' do.
    T_REORDROW=: tobool T_REORDROW
    gtk_tree_view_set_reorderable T_TV,T_REORDROW
  case. 'T_TOOLTIP' do.
    T_TOOLTIP=: (<:cols)<.toint T_TOOLTIP
    if. _1<T_TOOLTIP do.
      gtk_tree_view_set_tooltip_column T_TV,>:T_TOOLTIP{C_POS
    else.
      if. T_TOOLTIP=__ do.
        gtk_tree_view_set_tooltip_column T_TV,0
      else.
        gtk_tree_view_set_tooltip_column T_TV,_1
      end.
    end.
  case. 'T_INDEX' do.
    T_INDEX=: tobool T_INDEX
    if. T_INDEX do.
      updateindex rows
    end.
    gtk_tree_view_column_set_visible T_COL,T_INDEX
  case. 'T_HEAD' do.
    T_HEAD=: tostring T_HEAD
    gtk_tree_view_column_set_title T_COL;T_HEAD
    gtk_label_set_markup T_WIDGET;'<span foreground="',T_HFORECOLOR,'" font="',T_HFONT,'">',T_HEAD,'</span>'
  case. 'T_HALIGN' do.
    T_HALIGN=: to01 T_HALIGN
    gtk_tree_view_column_set_alignment T_COL,T_HALIGN
  case. 'T_XALIGN' do.
    T_XALIGN=: to01 T_XALIGN
    gtk_cell_renderer_set_alignment T_REND,T_XALIGN,T_YALIGN
    gtk_widget_queue_draw T_TV
  case. 'T_YALIGN' do.
    T_YALIGN=: to01 T_YALIGN
    gtk_cell_renderer_set_alignment T_REND,T_XALIGN,T_YALIGN
    gtk_widget_queue_draw T_TV
  case. 'T_HFORECOLOR' do.
    T_HFORECOLOR=: tostring T_HFORECOLOR
    gtk_label_set_markup T_WIDGET;'<span foreground="',T_HFORECOLOR,'" font="',T_HFONT,'">',T_HEAD,'</span>'
  case. 'T_HFONT' do.
    T_HFONT=: tostring T_HFONT
    gtk_label_set_markup T_WIDGET;'<span foreground="',T_HFORECOLOR,'" font="',T_HFONT,'">',T_HEAD,'</span>'
  case. 'T_FORECOLOR' do.
    T_FORECOLOR=: tostring T_FORECOLOR
    ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd T_REND;'foreground';T_FORECOLOR;0
    gtk_widget_queue_draw T_TV
  case. 'T_BACKCOLOR' do.
    T_BACKCOLOR=: tostring T_BACKCOLOR
    ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd T_REND;'background';T_BACKCOLOR;0
    gtk_widget_queue_draw T_TV
  case. 'T_FONT' do.
    T_FONT=: tostring T_FONT
    ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c x')&cd T_REND;'font';T_FONT;0
    gtk_widget_queue_draw T_TV
  case. 'T_BOUND' do.
    T_BOUND=: ,boxopen T_BOUND
  case. 'T_DEFSPIN' do.
    T_DEFSPIN=: ;tofloat each T_DEFSPIN
  case. 'T_PFONT' do.
    T_PFONT=: tostring T_PFONT
  case. 'T_MENU' do.
    T_MENU=: tostring each ,boxopen T_MENU
  case. 'T_SETDATA' do.
    T_SETDATA=: tostring T_SETDATA
  case. 'T_SETOPTION' do.
    T_SETOPTION=: tostring T_SETOPTION
  case. 'T_STDOUT' do.
    T_STDOUT=: tobool T_STDOUT
    if. T_STDOUT do.
      handler=: smoutput
    else.
      if. (<'handler')e.namelist 3 do.
        if. 'smoutput'-:5!:5<'handler' do. erase'handler' end.
      end.
    end.
  case. 'T_DELIMITER' do.
    T_DELIMITER=: {.tostring T_DELIMITER
  case. 'T_PATH' do.
    T_PATH=: tostring T_PATH
  end.
  if. p e. options do.
    if. (<'handler')e.namelist 3 do.
      handler 'option-set';p
    end.
  end.
end.
if. ((<'C_CHECK')e.y)+.((<'C_TYPE')e.y)+.((<'T_BOUND')e.y)+.((<'T_DEFSPIN')e.y)+.((<'T_MENU')e.y) do.
  (pack T_OPTIONS) updategrid getdata''
end.
0
)

updategrid=: 3 : 0
'' updategrid y
:
if. ''-:x do. x=. 0$a: end.
cols=. 1{$T_BODY
if. 0<parent=. getparent T_TV do.
  T_EVENTFLAG=: _1
  gtk_widget_hide T_TV
  gtk_list_store_clear T_STORE
  gtk_widget_destroy T_TV
  x initgrid y
  gtk_container_add parent,T_TV
  gtk_widget_show T_TV
  if. (<'handler')e.namelist 3 do.
    handler 'grid-updated';$T_BODY
  end.
end.
)

getdata=: 3 : 0
0 getdata y
:
if. 0<L.y do.
  flag=. 1
  y=. >y
else.
  flag=. 0
end.
if. 0=#y do.
  y=. i.1{$T_BODY
else.
  y=. (,y) (e. # [) i.1{$T_BODY
end.
res=. |: y{"1 T_BODY
num=. 0<y{C_ISNUM
for_i. i.#y do.
  if. i{num do.
    res=. (x&". each i{res)i}res
  end.
end.
if. flag do.
  |: res
elseif. T_INVERTED do.
  box2inv :: ] |: res
elseif. T_UNBOXED do.
  > :: ] |: res
elseif. do.
  |: res
end.
)
getgrid=: 3 : 0
store=. gtk_tree_view_get_model T_TV
rows=. gtk_tree_model_iter_n_children store;<<0
cols=. <:gtk_tree_model_get_n_columns store
res=. (0,cols)$<''
for_i. i.rows do.
  res=. res,getrow i
end.
)

getrow=: 3 : 0
store=. gtk_tree_view_get_model T_TV
rows=. gtk_tree_model_iter_n_children store;<<0
cols=. <:gtk_tree_model_get_n_columns store
if. -.1=#y do. y=. T_SELROW end.
if. -.y e. i.rows do. assert. 'invalid selection' end.
iter=. i.ITERSIZE
res=. 0$<''
if. gtk_tree_model_get_iter_from_string store;iter;":y do.
  arg=. ''
  for_i. C_POS do.
    value=. ,_1
    gtk_tree_model_get_1 store;iter;(>:i{C_POS);value;_1
    if. 0<value do.
      res=. res,<memr value,0,_1
      g_free {.value
    else.
      res=. res,<''
    end.
  end.
end.
res
)

getcol=: 3 : 0
store=. gtk_tree_view_get_model T_TV
rows=. gtk_tree_model_iter_n_children store;<<0
cols=. <:gtk_tree_model_get_n_columns store
if. -.1=#y do. y=. T_SELCOL end.
if. -.y e. i.cols do. assert. 'invalid selection' end.
res=. 0$a:
for_i. i.rows do.
  res=. res,<getcell i,y
end.
,.res
)

getcell=: 3 : 0
store=. gtk_tree_view_get_model T_TV
rows=. gtk_tree_model_iter_n_children store;<<0
cols=. <:gtk_tree_model_get_n_columns store
if. -.2=#y do. y=. T_SELROW,T_SELCOL end.
if. (({.y) e. i.rows)*.(({:y) e. i.cols) do.
  'row col'=. y
else.
  assert. 'invalid selection'
end.
iter=. i.ITERSIZE
if. gtk_tree_model_get_iter_from_string store;iter;":row do.
  value=. ,_1
  gtk_tree_model_get_1 store;iter;(>:col{C_POS);value;_1
  if. 0<value do.
    res=. memr value,0,_1
    g_free {.value
  else.
    res=. ''
  end.
end.
res
)

getoption=: 3 : 0
store=. gtk_tree_view_get_model T_TV
rows=. gtk_tree_model_iter_n_children store;<<0
cols=. <:gtk_tree_model_get_n_columns store
columns=. 0$0
for_i. i.cols do.
  columns=. columns,gtk_tree_view_get_column T_TV,>:i
end.
renderers=. 0$0
for_i. i.cols do.
  temp=. gtk_tree_view_column_get_cell_renderers i{columns
  renderers=. renderers,g_list_nth_data temp,0
  g_list_free temp
end.
widgets=. 0$0
for_i. i.cols do.
  widgets=. widgets,gtk_tree_view_column_get_widget i{columns
end.
res=. 0$0
select. y
case. 'T_TV' do.
  res=. T_TV
case. 'T_STORE' do.
  res=. store
case. 'T_SELECTION' do.
  res=. gtk_tree_view_get_selection T_TV
case. 'T_SELROW' do.
  res=. {.getactive T_TV
case. 'T_SELCOL' do.
  res=. _1>.<:{:getactive T_TV
case. 'C_LIST' do.
  res=. C_LIST
case. 'C_POS' do.
  res=. C_POS
case. 'C_ISNUM' do.
  res=. C_ISNUM
case. 'C_EMPTY' do.
  res=. C_EMPTY
case. 'T_UNBOXED' do.
  res=. T_UNBOXED
case. 'T_INVERTED' do.
  res=. T_INVERTED
case. 'T_EVENTFLAG' do.
  res=. T_EVENTFLAG
case. 'T_REORDERED' do.
  res=. T_REORDERED
case. 'C_COL' do.
  res=. columns
case. 'C_REND' do.
  res=. renderers
case. 'C_WIDGET' do.
  res=. widgets
case. 'C_HEAD' do.
  res=. 0$<''
  for_i. i.cols do.
    temp=. gtk_tree_view_column_get_title i{columns
    res=. res,<memr temp,0,_1
  end.
case. 'C_TYPE' do.
  res=. C_TYPE
case. 'C_COMBO' do.
  res=. C_COMBO
case. 'C_HALIGN' do.
  for_i. i.cols do.
    res=. res,gtk_tree_view_column_get_alignment i{columns
  end.
case. 'C_XALIGN' do.
  res=. C_XALIGN
case. 'C_YALIGN' do.
  res=. C_YALIGN
case. 'C_MAXWIDTH' do.
  for_i. i.cols do.
    res=. res,gtk_tree_view_column_get_max_width i{columns
  end.
case. 'C_RESIZE' do.
  for_i. i.cols do.
    res=. res,gtk_tree_view_column_get_resizable i{columns
  end.
case. 'C_EXPAND' do.
  for_i. i.cols do.
    res=. res,gtk_tree_view_column_get_expand i{columns
  end.
case. 'C_VISIBLE' do.
  for_i. i.cols do.
    res=. res,gtk_tree_view_column_get_visible i{columns
  end.
case. 'C_REORDCOL' do.
  for_i. i.cols do.
    res=. res,gtk_tree_view_column_get_reorderable i{columns
  end.
case. 'C_SORTABLE' do.
  res=. C_SORTABLE
case. 'T_SORTCOL' do.
  res=. T_SORTCOL
case. 'C_EDIT' do.
  for_i. i.cols do.
    temp=. ,_1
    ((>libgobject),' g_object_get >',(2*IFUNIX)}.' + n x *c *i x')&cd (i{renderers);'editable';temp;0
    res=. res,temp
  end.
case. 'C_HFORECOLOR' do.
  res=. C_HFORECOLOR
case. 'C_HFONT' do.
  res=. 0$<''
  for_i. i.cols do.
    temp=. gtk_label_get_label i{widgets
    temp=. memr temp,0,_1
    temp=. (6+'font="'ss temp)}.temp
    temp=. ('">'ss temp){.temp
    res=. res,<temp
  end.
case. 'C_FORECOLOR' do.
  res=. C_FORECOLOR
case. 'C_BACKCOLOR' do.
  res=. C_BACKCOLOR
case. 'C_BACKSEL' do.
  res=. C_BACKSEL
case. 'C_FONT' do.
  res=. 0$<''
  for_i. i.cols do.
    temp=. ,_1
    ((>libgobject),' g_object_get >',(2*IFUNIX)}.' + n x *c *x x')&cd (i{renderers);'font';temp;0
    res=. res,<memr temp,0,_1
    g_free {.temp
  end.
  res
case. 'C_EXEC' do.
  res=. C_EXEC
case. 'C_CHECK' do.
  res=. C_CHECK
case. 'T_LINES' do.
  res=. gtk_tree_view_get_grid_lines T_TV
case. 'T_HVISIBLE' do.
  res=. gtk_tree_view_get_headers_visible T_TV
case. 'T_REORDROW' do.
  res=. gtk_tree_view_get_reorderable T_TV
case. 'T_TOOLTIP' do.
  res=. T_TOOLTIP
case. 'T_MENU' do.
  res=. T_MENU
case. 'T_INDEX' do.
  res=. gtk_tree_view_column_get_visible gtk_tree_view_get_column T_TV,0
case. 'T_HEAD' do.
  res=. gtk_tree_view_column_get_title gtk_tree_view_get_column T_TV,0
  res=. memr res,0,_1
case. 'T_HALIGN' do.
  res=. T_HALIGN
case. 'T_XALIGN' do.
  res=. T_XALIGN
case. 'T_YALIGN' do.
  res=. T_YALIGN
case. 'T_HFORECOLOR' do.
  res=. T_HFORECOLOR
case. 'T_HFONT' do.
  res=. gtk_label_get_label gtk_tree_view_column_get_widget gtk_tree_view_get_column T_TV,0
  res=. memr res,0,_1
  res=. (6+'font="'ss res)}.res
  res=. ('">'ss res){.res
case. 'T_FORECOLOR' do.
  res=. T_FORECOLOR
case. 'T_BACKCOLOR' do.
  res=. T_BACKCOLOR
case. 'T_FONT' do.
  temp=. ,_1
  ((>libgobject),' g_object_get >',(2*IFUNIX)}.' + n x *c *x x')&cd T_REND;'font';temp;0
  res=. memr temp,0,_1
  g_free {.temp
  res
case. 'T_BOUND' do.
  res=. T_BOUND
case. 'T_DEFSPIN' do.
  res=. T_DEFSPIN
case. 'T_PFONT' do.
  res=. T_PFONT
case. 'T_OPTIONS' do.
  res=. T_OPTIONS
case. 'T_ICOL' do.
  res=. T_ICOL
case. 'T_COL' do.
  res=. gtk_tree_view_get_column T_TV,0
case. 'T_REND' do.
  temp=. gtk_tree_view_column_get_cell_renderers gtk_tree_view_get_column T_TV,0
  res=. g_list_nth_data temp,0
  g_list_free temp
  res
case. 'T_WIDGET' do.
  res=. gtk_tree_view_column_get_widget gtk_tree_view_get_column T_TV,0
case. 'T_POPUP' do.
  res=. T_POPUP
case. 'T_FIND' do.
  res=. T_FIND
case. 'T_FOUND' do.
  res=. T_FOUND
case. 'T_MATCH' do.
  res=. T_MATCH
case. 'T_SETDATA' do.
  res=. T_SETDATA
case. 'T_SETOPTION' do.
  res=. T_SETOPTION
case. 'T_STDOUT' do.
  res=. T_STDOUT
case. 'T_DELIMITER' do.
  res=. T_DELIMITER
case. 'T_PATH' do.
  res=. T_PATH
case. 'T_VHCHECK' do.
  res=. T_VHCHECK
end.
)
initgrid=: 3 : 0
'' initgrid y
:
if. 0=#y do. y=. <'' end.
if. (2>#$y)*.(32=3!:0 y)*.1=#~.#each y do. [ y=. inv2box y [ inv=. ; 3!:0 each y else. inv=. '' end.
if. 2>#$y do. y=. ,:,y end.
if. 2<#$y do. assert. 'invalid grid data' end.
if. (''-:x)+.(0=#$x) do. x=. 0 2$a: end.
if. (32~:3!:0 x)+.2|#,x do. assert. 'invalid grid options' end.
cols=. 1{$y
rows=. #y
C_HEAD=: ": each i. cols 
C_TYPE=: 0 
C_HALIGN=: 0.5 
C_XALIGN=: 0 
C_YALIGN=: 0 
C_MAXWIDTH=: 800 
C_RESIZE=: 1 
C_EXPAND=: 1 
C_VISIBLE=: 1 
C_REORDCOL=: 1 
C_SORTABLE=: 1 
C_EDIT=: 1 
C_HFORECOLOR=: '#000000' 
C_HFONT=: 'Sans Bold 10' 
C_FORECOLOR=: '#000000' 
C_BACKCOLOR=: '#ffffff' 
C_BACKSEL=: '#cccccc' 
C_FONT=: 'Monospace 10' 
C_EXEC=: ']' 
C_CHECK=: 1 
T_LINES=: 3 
T_HVISIBLE=: 1 
T_REORDROW=: 1 
T_TOOLTIP=: __ 
T_INDEX=: 1 
T_HEAD=: '' 
T_HALIGN=: 0.5 
T_XALIGN=: 1 
T_YALIGN=: 0 
T_HFORECOLOR=: '#000000' 
T_HFONT=: 'Sans Bold 10' 
T_FORECOLOR=: '#ffffff' 
T_BACKCOLOR=: '#555555' 
T_FONT=: 'Monospace 10' 
T_BOUND=: ,<'' 
T_DEFSPIN=: 0,_2147483647,2147483647,1,100,0 
T_PFONT=: 'Monospace 10' 
T_MENU=: ,<'all' 
T_SETDATA=: 'getdata''''' 
T_SETOPTION=: '''T_LINES'';0' 
T_STDOUT=: 0 
T_DELIMITER=: '|' 
T_PATH=: jpath '~user' 
x=. unpack x
C_HEAD=: tostring each cols$,boxopen C_HEAD
C_TYPE=: ;tocomplex each cols$,C_TYPE
C_HALIGN=: ;to01 each cols$,C_HALIGN
C_XALIGN=: ;to01 each cols$,C_XALIGN
C_YALIGN=: ;to01 each cols$,C_YALIGN
C_MAXWIDTH=: ;toint each cols$,C_MAXWIDTH
C_RESIZE=: ;tobool each cols$,C_RESIZE
C_EXPAND=: ;tobool each cols$,C_EXPAND
C_VISIBLE=: ;tobool each cols$,C_VISIBLE
C_REORDCOL=: ;tobool each cols$,C_REORDCOL
C_SORTABLE=: ;tobool each cols$,C_SORTABLE
C_EDIT=: ;tobool each cols$,C_EDIT
C_HFORECOLOR=: tostring each cols$,boxopen C_HFORECOLOR
C_HFONT=: tostring each cols$,boxopen C_HFONT
C_FORECOLOR=: tostring each cols$,boxopen C_FORECOLOR
C_BACKCOLOR=: tostring each cols$,boxopen C_BACKCOLOR
C_BACKSEL=: tostring each cols$,boxopen C_BACKSEL
C_FONT=: tostring each cols$,boxopen C_FONT
C_EXEC=: {.@tostring each cols$,boxopen C_EXEC
C_CHECK=: ;tobool each cols$,C_CHECK
T_LINES=: ;(0&>.)@:(3&<.)@:toint T_LINES
T_HVISIBLE=: tobool T_HVISIBLE
T_REORDROW=: tobool T_REORDROW
T_TOOLTIP=: (<:cols)<.toint T_TOOLTIP
T_INDEX=: tobool T_INDEX
T_HEAD=: tostring T_HEAD
T_HALIGN=: to01 T_HALIGN
T_XALIGN=: to01 T_XALIGN
T_YALIGN=: to01 T_YALIGN
T_HFORECOLOR=: tostring T_HFORECOLOR
T_HFONT=: tostring T_HFONT
T_FORECOLOR=: tostring T_FORECOLOR
T_BACKCOLOR=: tostring T_BACKCOLOR
T_FONT=: tostring T_FONT
T_BOUND=: ,boxopen T_BOUND
T_DEFSPIN=: ;tofloat each T_DEFSPIN
T_PFONT=: tostring T_PFONT
T_MENU=: tostring each ,boxopen T_MENU
T_SETDATA=: tostring T_SETDATA
T_SETOPTION=: tostring T_SETOPTION
T_STDOUT=: tobool T_STDOUT
T_DELIMITER=: {. tostring T_DELIMITER
T_PATH=: tostring T_PATH
T_BODY=: (rows,0)$<''
T_ICOL=: ": each i.rows 
T_UNBOXED=: (3!:0 y)e.1 4 8 16 64 128 
T_INVERTED=: -.''-:inv 
T_SORTCOL=: _1 
T_SELCOL=: _1 
T_SELROW=: _1 
T_REORDERED=: _1  
T_EVENTFLAG=: 0 
T_FIND=: '' 
T_FOUND=: '' 
T_MATCH=: (rows,cols)$0 
T_OPTIONS=: 'C_HEAD C_TYPE C_HALIGN C_XALIGN C_YALIGN C_MAXWIDTH C_RESIZE C_EXPAND C_VISIBLE C_REORDCOL C_SORTABLE C_EDIT C_HFORECOLOR C_HFONT C_FORECOLOR C_BACKCOLOR C_BACKSEL C_FONT C_EXEC C_CHECK T_LINES T_HVISIBLE T_REORDROW T_TOOLTIP T_MENU T_INDEX T_HEAD T_HALIGN T_XALIGN T_YALIGN T_HFORECOLOR T_HFONT T_FORECOLOR T_BACKCOLOR T_FONT T_BOUND T_DEFSPIN T_PFONT T_SETDATA T_SETOPTION T_STDOUT T_DELIMITER T_PATH'
C_POS=: i.cols 
C_COL=: 0$0 
C_REND=: 0$0 
C_COMBO=: 0$0 
C_WIDGET=: 0$0 
C_ISNUM=: 0$0 
C_EMPTY=: 0$<'' 
T_TV=: gtk_tree_view_new'' 
T_STORE=: gtk_list_store_newv (>:cols);(>:cols) $ G_TYPE_STRING 
gtk_tree_view_set_model T_TV,T_STORE
gtk_tree_view_set_grid_lines T_TV,T_LINES
gtk_tree_view_set_headers_visible T_TV,T_HVISIBLE
gtk_tree_view_set_reorderable T_TV,T_REORDROW
if. _1<T_TOOLTIP do.
  gtk_tree_view_set_tooltip_column T_TV,>:T_TOOLTIP
else.
  if. T_TOOLTIP=__ do.
    gtk_tree_view_set_tooltip_column T_TV,0
  else.
    gtk_tree_view_set_tooltip_column T_TV,_1
  end.
end.
T_SELECTION=: gtk_tree_view_get_selection T_TV 
gtk_tree_selection_set_mode T_SELECTION,1
T_REND=: gtk_cell_renderer_text_new''
gtk_tree_view_insert_column_with_attributes T_TV;0;(<T_HEAD),T_REND;'text';0;<<0
((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c *c *c *c i *c *c x')&cd T_REND;'foreground';T_FORECOLOR;'background';T_BACKCOLOR;'editable';0;'font';T_FONT;0
T_COL=: gtk_tree_view_get_column T_TV,0
T_WIDGET=: gtk_label_new <''
gtk_label_set_markup T_WIDGET;'<span foreground="',T_HFORECOLOR,'" font="',T_HFONT,'">',T_HEAD,'</span>'
gtk_tree_view_column_set_widget T_COL,T_WIDGET
gtk_widget_show T_WIDGET
gtk_tree_view_column_set_resizable T_COL,0
gtk_tree_view_column_set_clickable T_COL,1
gtk_tree_view_column_set_expand T_COL,0
gtk_tree_view_column_set_visible T_COL,T_INDEX
gtk_tree_view_column_set_reorderable T_COL,0
gtk_tree_view_column_set_alignment T_COL,T_HALIGN
gtk_cell_renderer_set_alignment T_REND,T_XALIGN,T_YALIGN
consig T_COL;'clicked';'unselectall'
for_i. i.cols do.
  ii=. >:i
  im=. {:+.i{C_TYPE
  bnd=. ,@>@(im&{) :: (''"_) T_BOUND
  if. T_INVERTED do.
    C_ISNUM=: C_ISNUM,(i{inv)e.1 4 8 16 64 128
  else.
    C_ISNUM=: C_ISNUM,i([: (1 4 8 16 64 128 e.~ ]) [: 3!:0 [: > {"1) :: (0"_)y
  end.
  if. 1=i{C_ISNUM do. 
    C_ISNUM=: (1+i([: ([: -. ] -: +) [: > {"1)y) i}C_ISNUM 
    if. 1=i{C_ISNUM do.
      C_ISNUM=: (1+i([: (0.5 * [: -. ] -: <.) [: > {"1)y) i}C_ISNUM 
    end.
  end.
  C_CHECK=: ((i{C_CHECK)*.0<i{C_ISNUM) i}C_CHECK
  C_EMPTY=: C_EMPTY,<i checknum''
  T_BODY=: T_BODY,.i&checknum each i{"1 y
  if. -.(<'C_XALIGN')e.x do. 
    C_XALIGN=: (0<i{C_ISNUM) i}C_XALIGN
  end.
  if. -.(<'C_TYPE')e.x do.  
    C_TYPE=: (+:1=i{C_ISNUM) i}C_TYPE
  end.
  select. {.+.i{C_TYPE 
  case. 1 do. 
    if. ''-:bnd do. 
      hasentry=. 1
      if. 0<i{C_ISNUM do.
        bnd=. (/:~.i{"1 y){~.i{"1 T_BODY
      else.
        bnd=. /:~~.i{"1 T_BODY
      end. 
    else.
      bnd=. ,tostring1 each bnd
      if. (<'')={.bnd do. 
        hasentry=. 1
        bnd=. }.bnd
      else.
        hasentry=. 0
        C_EMPTY=: ({.bnd)i}C_EMPTY
      end.
    end.
    C_REND=: C_REND,gtk_cell_renderer_combo_new''
    C_COMBO=: C_COMBO,gtk_list_store_new_1 1,G_TYPE_STRING
    setstore (i{C_COMBO);<bnd
    ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c *c *c *c i *c *c *c x *c i *c i x')&cd (i{C_REND);'foreground';(>i{C_FORECOLOR);'background';(>i{C_BACKCOLOR);'editable';(i{C_EDIT);'font';(>i{C_FONT);'model';(i{C_COMBO);'text-column';0;'has-entry';hasentry;0
  case. 2 do. 
    if. ''-:bnd do. 
      digits=. 0
      bnd=. T_DEFSPIN
    else.
      bnd=. ;tofloat each bnd
      digits=. {.toint {:bnd
      bnd=. 6{.bnd
    end.
    C_REND=: C_REND,gtk_cell_renderer_spin_new''
    C_COMBO=: C_COMBO,gtk_adjustment_new bnd
    ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c *c *c *c i *c *c *c x *c x x')&cd (i{C_REND);'foreground';(>i{C_FORECOLOR);'background';(>i{C_BACKCOLOR);'editable';(i{C_EDIT);'font';(>i{C_FONT);'adjustment';(i{C_COMBO);'digits';digits;0
  case. do. 
    C_REND=: C_REND,gtk_cell_renderer_text_new''
    C_COMBO=: C_COMBO,_1
    ((>libgobject),' g_object_set >',(2*IFUNIX)}.' + n x *c *c *c *c *c i *c *c x')&cd (i{C_REND);'foreground';(>i{C_FORECOLOR);'background';(>i{C_BACKCOLOR);'editable';(i{C_EDIT);'font';(>i{C_FONT);0
  end.
  gtk_tree_view_insert_column_with_attributes T_TV;ii;(i{C_HEAD),(i{C_REND);'text';ii;<<0
  C_COL=: C_COL,gtk_tree_view_get_column T_TV,ii
  C_WIDGET=: C_WIDGET,gtk_label_new <''
  gtk_label_set_markup (i{C_WIDGET);'<span foreground="',(>i{C_HFORECOLOR),'" font="',(>i{C_HFONT),'">',(>i{C_HEAD),'</span>'
  gtk_tree_view_column_set_widget (i{C_COL),i{C_WIDGET
  gtk_widget_show i{C_WIDGET
  gtk_tree_view_column_set_max_width (i{C_COL),i{C_MAXWIDTH
  gtk_tree_view_column_set_resizable (i{C_COL),i{C_RESIZE
  gtk_tree_view_column_set_clickable (i{C_COL),1
  gtk_tree_view_column_set_expand (i{C_COL),i{C_EXPAND
  gtk_tree_view_column_set_visible (i{C_COL),i{C_VISIBLE
  gtk_tree_view_column_set_reorderable (i{C_COL),i{C_REORDCOL
  gtk_tree_view_column_set_alignment (i{C_COL),i{C_HALIGN
  gtk_cell_renderer_set_alignment (i{C_REND),(i{C_XALIGN),(i{C_YALIGN)
  consig (i{C_COL);'clicked';'columnclick'
  consig4 (i{C_REND);'edited';'celledit'
end.
C_LIST=: C_COL
setstore T_STORE;<T_ICOL,.T_BODY
consig T_TV;'columns-changed';'columnchange'
consig3 T_TV;'button-press-event';'buttonpress'
consig3 T_TV;'key-press-event';'keypress'
consig T_TV;'cursor-changed';'selchange'
consig3 T_STORE;'row-deleted';'rowdelete'
consig4 T_STORE;'row-inserted';'rowinsert'
consig4 T_STORE;'row-changed';'rowchange'
T_POPUP=: gtk_menu_new''
T_VHCHECK=: T_MENU makepopup T_POPUP
gtk_menu_attach_to_widget T_POPUP;T_TV;<<0
if. T_STDOUT do.
  handler=: smoutput
else.
  if. (<'handler')e.namelist 3 do.
    if. 'smoutput'-:5!:5<'handler' do. erase'handler' end.
  end.
end.
if. 0<rows do. listgrid_scroll T_TV,0 end.
EMPTY
)
grid=: 3 : 0
'' grid y
:
if. -.IFGTK do. gtkinit'' end.
newgrid=. conew 'jgtkgrid'
x create__newgrid y
window=. gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;'jgtkgrid ',>newgrid
gtk_window_set_default_size window,(800<.12*5+(+:1{$ T_BODY__newgrid)+1{$;"1 T_BODY__newgrid),600<.25*2+#T_BODY__newgrid
scrolled=. gtk_scrolled_window_new 0 0
gtk_scrolled_window_set_policy scrolled,GTK_POLICY_AUTOMATIC,GTK_POLICY_AUTOMATIC
gtk_container_add window,scrolled
gtk_container_add scrolled,T_TV__newgrid
gtk_widget_show_all window
gtk_widget_show window
unselectall__newgrid''
consig__newgrid window;'destroy';'windowdestroy'
if. -.IFGTK do. gtk_main'' end.
newgrid
)

windowdestroy=: 3 : 0
T_EVENTFLAG=: _1
gtk_widget_destroy T_TV
destroy''
cbfree''
if. -.IFGTK do. gtk_main_quit'' end.
0
)

grid_z_=: grid_jgtkgrid_
