require 'gui/gtk gl2'
require '~addons/gui/gtkwd/isigraph.ijs'

IFJAVA_z_=: 0
IFWINCE_z_=: 0

coclass 'gtkwd'
coinsert 'jgtk'

gtkcv=: IFUNIX{::'>+ ';'>  '
wdqdata=: 0 0$0

Debugwd=: 0
TileWM=: 0
LASTCMD=: ''
WDERR=: ''
WDERRN=: 0
WDLOC=: 'base'
wdptr0=: wdptr=: 0
wdstr=: ''
sysmodifiers=: ,'0'
sysdata=: ''

lasterrcmd=: lastcmd=: ''
cWindow=: 0
cChild=: 0
cRadio=: 0
cContainer=: 0
cSubform=: ''
windowList=: 0 16$<''
WindowListHandle=: 0
WindowListId=: 1
WindowListLocale=: 2
WindowListPgroup=: 3
WindowListActiveidx=: 4
WindowListGlx=: 5
WindowListFontdef=: 6
WindowListToolbar=: 7
WindowListStatusbar=: 8
WindowListMenubar=: 9
WindowListToolip=: 10
WindowListAccel=: 11
WindowListWhwh0=: 12
WindowListOwner=: 13
WindowListTbimg=: 14
WindowListCloseok=: 15

containerList=: 0 3$<''
subformList=: 0 4$<''
childList=: 0 12$<''
ChildListContainer=: 6
ChildListSubform=: 7
ChildListWywh0=: 8
ChildListNotrigger=: 9
ChildListLocalec=: 10
ChildListUserdata=: 11

menuList=: 0 4$<''
toolbarList=: 0 5$<''
statusbarList=: 0 3$<''
glxList=: 0 14$<''
GLXLISTHANDLEP=: 0
GLXLISTHANDLE=: 1
GLXLISTHANDLEV=: 2
GLXLISTGLXTYPE=: 3
GLXLISTFONT=: 4
GLXLISTRGB=: 5
GLXLISTPENCOLOR=: 6
GLXLISTPENSTYLE=: 7
GLXLISTNULLBRUSH=: 8
GLXLISTBRUSHCOLOR=: 9
GLXLISTTEXTXY=: 10
GLXLISTTEXTCOLOR=: 11
GLXLISTCLIPRECT=: 12
GLXLISTWINDORG=: 13

activeidx=: 0
cxywh=: 0 0 100 100
cFontdef=: ''
cSetFont=: ''
tbimg=: 0
3 : 0''
if. 0 = 4!:0 <'systimerid_gtkwd_' do.
  if. 0~:systimerid do. systimerid=: 0 [ g_source_remove systimerid end.
end.
''
)
systimerid=: timerdelay=: 0

jloc=: 3 : 0
WDLOC
)
wdcc=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 2> #args do. seterr 'bad class : ' return.
end.
id=. 0{::args [ class=. 1{::args
localec=. userdata=. '' [ notrigger=. 0
if. (<class) -.@e. {."1 CONTROLS do. seterr 'bad class : ' return. end.
iclass=. (<class) i.~ {."1 CONTROLS
if. 2< #args do.
  styles=. ~. 2}.args
  stylen=. 2#. |. styles e.~ FMSTYLE
else.
  stylen=. 0
  styles=. 0$<''
end.

if. 0 e. styles e. (;:'group nopas'), FMSTYLE, ;2 3{ iclass{CONTROLS do. seterr 'bad style : ' return. end.
if. 0= cContainer do.
  vbox=. gtk_bin_get_child <cWindow
  g=. gtk_container_get_children <vbox
  align1=. 0
  for_i. i. g_list_length <g do.
    align1=. g_list_nth_data g ;< i
    if. g_type_check_instance_is_a align1 ;< gtk_alignment_get_type '' do. break. end.
  end.
  assert. 0~:align1
  g_list_free <g
  fixed1=. gtk_bin_get_child <align1
else.
  if. 1 e. f=. (cContainer = >1{"1 subformList) *. (<cSubform) = 2{"1 subformList do.
    fixed1=. 3{:: ({.I.f){subformList
    assert. 0~:fixed1
  else.
    seterr 'todomsg1 : ' return.
  end.
  assert. 0~:fixed1
  assert. fixed1 e. 3{::"1 subformList
end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  cParentId=. (handle i. cWindow){ >WindowListId{"1 windowList
  cParentLoc=. (handle i. cWindow){ >WindowListLocale{"1 windowList
else.
  cParentId=. ''
  cParentLoc=. ''
end.
select. iclass
case. wdcl_button do.
  window=. gtk_button_new ''
  if. (<'bs_ownerdraw') e. styles do.
    image=. gtk_image_new ''
    gtk_button_set_image window ; image
  else.
    gtk_button_set_use_underline window ; 1
    gtk_button_set_label window ; id
  end.
  consig window ; 'clicked' ; 'button_clicked'
case. wdcl_checkbox do.
  window=. gtk_check_button_new ''
  gtk_button_set_label window ; id
  consig window ; 'toggled' ; 'button_toggled'
  consig3 window ; 'key-press-event' ; 'edit_key_press'
case. wdcl_combobox do.
  if. 3=GTKVER_j_ do.
    window=. gtk_combo_box_new_with_entry ''
  else.
    window=. gtk_combo_box_entry_new ''
  end.
  consig window ; 'changed' ; 'combobox_changed'
case. wdcl_combodrop do.
  if. 3=GTKVER_j_ do.
    window=. gtk_combo_box_new_with_entry ''
  else.
    window=. gtk_combo_box_entry_new ''
  end.
  consig window ; 'changed' ; 'combobox_changed'
case. wdcl_combolist do.
  window=. gtk_combo_box_new ''
  renderer=. gtk_cell_renderer_text_new ''
  gtk_cell_layout_pack_start window ; renderer ;< 0
  ((>libgtk), ' gtk_cell_layout_set_attributes ', gtkcv, 'n x x *c x x')&cd window ; renderer ; 'text' ; 0 ; 0
  consig window ; 'changed' ; 'combobox_changed'
  consig3 window ; 'key-press-event' ; 'combolist_key_press'
fcase. wdcl_richedit do.
case. wdcl_edit do.
  iclass=. wdcl_edit
  window=. gtk_entry_new ''
  if. (<'es_readonly') e. styles do. gtk_widget_set_sensitive window, 0 end.
  if. (<'es_password') e. styles do. gtk_entry_set_visibility window, 0 end.
  consig3 window ; 'key-press-event' ; 'edit_key_press'
fcase. wdcl_editijs;wdcl_editijx;wdcl_richeditm do.
case. wdcl_editm do.
  iclass=. wdcl_editm
  buf=. gtk_text_buffer_new <0
  window=. gtk_text_view_new_with_buffer <buf
  if. (<'es_readonly') e. styles do. gtk_widget_set_sensitive window, 0 end.
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x *c x x')&cd window ; 'wrap-mode' ; GTK_WRAP_NONE ; 'left-margin' ; 0 ;< 0
  if. (hsc=. (<'es_autohscroll') e. styles) +. vsc=. (<'es_autovscroll') e. styles do.
    scrolledwindow=. gtk_scrolled_window_new 0,0
    gtk_scrolled_window_set_policy scrolledwindow, (hsc{GTK_POLICY_NEVER,GTK_POLICY_AUTOMATIC), (vsc{GTK_POLICY_NEVER,GTK_POLICY_AUTOMATIC)
    gtk_container_add scrolledwindow ;< window
    gtk_widget_show <scrolledwindow
  end.
case. wdcl_groupbox do.
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_frame_get_type '') ; 'shadow-type' ; GTK_SHADOW_NONE ;< 0
case. wdcl_isigraph do.
  styleOpengl=. (<'opengl') e. styles
  size=. 2}. cxywh
  canvasloc=. glcanvas_jgl2_ '';'gtkwd';size;< coname''
  gloption__canvasloc=: styleOpengl
  window=. canvas__canvasloc
  userdata=. >canvasloc
case. wdcl_listbox do.
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_tree_view_get_type '') ; 'headers_visible' ; 0 ;< 0
  renderer=. gtk_cell_renderer_text_new ''
  col=. ((>libgtk), ' gtk_tree_view_column_new_with_attributes ', gtkcv, 'x *c x *c x x')&cd '' ; renderer ; 'text' ; 0 ; 0
  gtk_tree_view_append_column window ;< col
  select=. gtk_tree_view_get_selection <window
  if. (<'lbs_multiplesel') e. styles do. gtk_tree_selection_set_mode select ;< GTK_SELECTION_MULTIPLE
  elseif. (<'lbs_extendedsel') e. styles do. gtk_tree_selection_set_mode select ;< GTK_SELECTION_MULTIPLE
  elseif. do. gtk_tree_selection_set_mode select ;< GTK_SELECTION_SINGLE
  end.
  if. 1 do.
    scrolledwindow=. gtk_scrolled_window_new 0,0
    gtk_scrolled_window_set_policy scrolledwindow, GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC
    gtk_container_add scrolledwindow ;< window
    gtk_widget_show <scrolledwindow
  end.
  consig select ; 'changed' ; 'listbox_changed'
  consig4 window ; 'row-activated' ; 'listbox_activated'
case. wdcl_radiobutton do.
  samegroup=. (<'group') e. styles
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x x')&cd ( gtk_radio_button_get_type '') ;< 0
  consig window ; 'toggled' ; 'button_toggled'
  consig3 window ; 'key-press-event' ; 'edit_key_press'
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c *c x')&cd window ; 'label' ; id ;< 0
  if. 0= samegroup do. cRadio=: 0 end.
  if. 0~:cRadio do.
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd window ; 'group' ; cRadio ;< 0
  end.
  cRadio=: window
case. wdcl_scrollbar do.
  adjust=. gtk_adjustment_new <("0) (0.5-0.5)&+ 0 0 100 1 10 5
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_hscrollbar_get_type '') ; 'adjustment' ; adjust ;< 0
  consig window ; 'value-changed' ; 'scrollbar_change'
case. wdcl_scrollbarv do.
  adjust=. gtk_adjustment_new <("0) (0.5-0.5)&+ 0 0 100 1 10 5
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_vscrollbar_get_type '') ; 'adjustment' ; adjust ;< 0
  consig window ; 'value-changed' ; 'scrollbar_change'
case. wdcl_static do.
  window=. gtk_label_new <<0
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c *c x')&cd window ; 'label' ; id ;< 0
case. wdcl_staticbox do.
  if. (<'ss_blackframe') e. styles do.
    if. (<'ss_sunken') e. styles do.
      sty=. GTK_SHADOW_IN
    else.
      sty=. GTK_SHADOW_OUT
    end.
  elseif. (<'ss_etchedframe') e. styles do.
    if. (<'ss_sunken') e. styles do.
      sty=. GTK_SHADOW_ETCHED_IN
    else.
      sty=. GTK_SHADOW_ETCHED_OUT
    end.
  elseif. do.
    sty=. GTK_SHADOW_NONE
  end.
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_frame_get_type '') ; 'shadow-type' ; sty ;< 0
case. wdcl_progress do.
  window=. gtk_progress_bar_new ''
case. wdcl_spin ; wdcl_spinv do.
  adjust=. gtk_adjustment_new <("0) (0.5-0.5)&+ 0 0 100 1 10 0
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x *c d x')&cd ( gtk_spin_button_get_type '') ; 'adjustment' ; adjust ; 'value' ; (0.5-0.5) ;< 0
  consig window ; 'value-changed' ; 'spin_change'
case. wdcl_tab do.
  window=. gtk_notebook_new ''
  consig4 window ; 'switch-page' ; 'tab_switch_page'
  consig4 window ; 'page-removed' ; 'tab_page_removed'
  userdata=. 0
case. wdcl_trackbar do.
  adjust=. gtk_adjustment_new <("0) (0.5-0.5)&+ 0 0 100 1 10 0
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_hscale_get_type '') ; 'adjustment' ; adjust ;< 0
  consig window ; 'value-changed' ; 'trackbar_change'
case. wdcl_trackbarv do.
  adjust=. gtk_adjustment_new <("0) (0.5-0.5)&+ 0 0 100 1 10 0
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_vscale_get_type '') ; 'adjustment' ; adjust ;< 0
  consig window ; 'value-changed' ; 'trackbar_change'
case. do.
  seterr 'bad class : ' return.
end.
if. '' -.@-: cSetFont do.
  fontdef=. cFontdef
else.
  if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
    fontdef=. (handle i. cWindow){:: WindowListFontdef{"1 windowList
  else.
    assert. 0
  end.
end.
if. '' -.@-: fontdef do.
  'font asize style angle'=. fontdef
  st=. (|. 2 2 2#:style)#'italic' ; 'bold' ; ''
  fd=. pango_font_description_from_string <'', font, '', (;' ' ,&.> st), ' ', (":asize)
  gtk_widget_modify_font window ;< fd
  pango_font_description_free <fd
else.
  asize=. 10
end.
if. iclass e. wdcl_combobox, wdcl_combodrop, wdcl_combolist do.
  cxywh1=. (3{.cxywh) , >.12 * asize % 10
else.
  cxywh1=. cxywh
end.
if. (0~: g_type_check_instance_is_a wg, gtk_scrolled_window_get_type '') *. 0~: wg=. gtk_widget_get_parent window do.
  gtk_fixed_put fixed1 ; wg ; <("0) D2P 2{.cxywh1
  gtk_widget_set_size_request wg ; <("0) D2P 2}.cxywh1
else.
  gtk_fixed_put fixed1 ; window ; <("0) D2P 2{.cxywh1
  gtk_widget_set_size_request window ; <("0) D2P 2}.cxywh1
end.
gtk_widget_show <window
cChild=: window
assert. 0~:cChild
if. 0&= cChild do. seterr 'cannot create child : ' return. end.
childList=: childList, cWindow ; cChild ; id ; iclass ; stylen ; 0 ; cContainer ; ((0~:cContainer){::'';cSubform) ; (D2P cxywh1) ; notrigger ; localec ;< userdata
if. (<'nopas') -.@e. styles do.
  if. 0= cContainer do.
    idx=. windowlistidx cWindow
    assert. _1~:idx
    whwh0=. (<idx, WindowListWhwh0){::windowList
    whwh0=. (2{.whwh0), (_2{.whwh0) >. D2P +/ 2 2$cxywh
    windowList=: (<whwh0) (<idx, WindowListWhwh0)} windowList
  else.
    idx=. (>1{"1 containerList) i. cContainer
    assert. idx < #containerList
    wh0=. (<idx, 2){::containerList
    wh0=. wh0 >. D2P +/ 2 2$cxywh
    containerList=: (<wh0) (<idx, 2)} containerList
  end.
end.
if. iclass = wdcl_isigraph do.
  idx=. windowlistidx cWindow
  glxList=: glxList, cWindow ; cChild ; (>canvasloc) ; styleOpengl ; fontdef ; 0 ; 0 ; 1 0 ; 1 ; 0 ; 0 0 ; 0 ; 0 0 _1 _1 ; 0 0
  windowList=: (<cChild) (<idx, WindowListGlx) } windowList
else.
  consig window ; 'realize' ; 'widget_realize'
end.
)

wdcn=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= window=. cChild do. seterr 'no child selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ''
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. g_type_check_instance_is_a window ;< gtk_label_get_type '' do.
  gtk_label_set_text window ;< s
elseif. g_type_check_instance_is_a window ;< gtk_button_get_type '' do.
  if. 0= image=. gtk_button_get_image <window do.
    gtk_button_set_label window ; '&_' charsub s
  else.
    setbuttonimage window ; image ;< s
  end.
elseif. g_type_check_instance_is_a window ;< gtk_frame_get_type '' do.
  gtk_frame_set_label window ;< s
end.
)

wdqchildxywh=: 3 : 0
if. 2= 3!:0 z=. qchildxywhx '' do. z return. end.
": P2D z
)

wdqchildxywhx=: 3 : 0
if. 2= 3!:0 z=. qchildxywhx '' do. z return. end.
": z
)

qchildxywhx=: 3 : 0
z=. 4$_1
if. 0= cWindow do. z [ seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. z [ seterr 'bad id : ' return.
elseif. 1< #args do. z [ seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. z [ seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. z [ seterr 'bad id : ' return. end.
win=. getchildwin window
if. _1= {. wh=. getchildwh win do.
  ix=. getcchildidx window
  wh=. _2{. (<ix,ChildListWywh0){:: childList
end.
if. _1= {. xy=. getchildxy win do.
  ix=. getcchildidx window
  xy=. 2{. (<ix,ChildListWywh0){:: childList
end.
xy,wh
)

wdqhwndc=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
":window
)
wdset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do.
  menu=. cWindow getmenu id
  tbar=. cWindow gettoolbar id
  if. (0=menu) *. 0=tbar do. seterr 'bad id : ' return. end.
  if. 1= #args do. s=. ,'1'
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
  if. 0~: menu do.
    ix=. (>1{"1 menuList) i. menu
    menuList=: (<1) (<ix ,3)}menuList
    gtk_check_menu_item_set_active menu ;< flag
  end.
  if. 0~: tbar do. ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd tbar ; 'active' ; flag ;< 0 end.
  return.
end.
select. iclass=. getcchildclass window
case. wdcl_edit ; wdcl_editm ; wdcl_static do.
  if. 1= #args do. s=. ''
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  select. iclass
  case. wdcl_edit do.
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c *c x')&cd window ; 'text' ; s ;< 0
  case. wdcl_editm do.
    buf=. gtk_text_view_get_buffer <window
    gtk_text_buffer_set_text buf ; s ;< _1
  case. wdcl_static do.
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c *c x')&cd window ; 'label' ; s ;< 0
  end.
case. wdcl_checkbox ; wdcl_radiobutton do.
  if. 1= #args do. s=. ,'1'
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
  if. _1~: ix=. getcchildidx window do. childList=: (<1) (<ix,ChildListNotrigger)}childList end.
  gtk_toggle_button_set_active window, flag
  if. _1~: ix=. getcchildidx window do. childList=: (<0) (<ix,ChildListNotrigger)}childList end.
case. wdcl_combobox ; wdcl_combodrop ; wdcl_combolist ; wdcl_listbox do.
  pa=. 0$<''
  for_s1. }.args do.
    s=. >s1
    if. LF e. s do.
      pa=. pa, <;._2 s, (LF~:{:s)#LF
    else.
      pa=. pa, s1
    end.
  end.
  ls=. gtk_list_store_new_1 1,G_TYPE_STRING
  iter=. i.ITERSIZE
  for_item. pa do.
    gtk_list_store_append ls ;< iter
    ((>libgtk), ' gtk_list_store_set ', gtkcv, 'n x *x x *c x')&cd ls ; iter ; 0 ; (>item) ;< _1
  end.
  if. _1~: ix=. getcchildidx window do. childList=: (<1) (<ix,ChildListNotrigger)}childList end.
  if. iclass e. wdcl_listbox do.
    gtk_tree_view_set_model window ;< ls
  elseif. iclass e. wdcl_combolist do.
    gtk_combo_box_set_model window ;< ls
  elseif. do.
    if. 3=GTKVER_j_ do.
      gtk_combo_box_set_model window ;< ls
      gtk_combo_box_set_entry_text_column window ;< 0
    else.
      gtk_combo_box_set_model window ;< ls
      gtk_combo_box_entry_set_text_column window ;< 0
    end.
  end.
  g_object_unref <ls
  if. _1~: ix=. getcchildidx window do. childList=: (<0) (<ix,ChildListNotrigger)}childList end.
case. wdcl_progress do.
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  item1=. {.@(0&".) s
  gtk_progress_bar_set_fraction window ; (1 <. 0>.item1%100)
case. wdcl_scrollbar ; wdcl_scrollbarv do.
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 3 4 e.~ #args do. seterr 'extra parameter : ' return.
  elseif. 5< #args do. seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
  if. 2= #args do.
    item1=. {.@(0&".) 1{::args
    gtk_range_set_value window ;< (0.5-0.5)&+ item1
  else.
    'item1 item2 item3 item4'=. {.@(0&".)&> 2}.args
    gtk_range_set_range window ; <("0) (0.5-0.5)&+ item1, item3
    gtk_range_set_increments window ; <("0) (0.5-0.5)&+ 1, item4
    gtk_range_set_value window ;< (0.5-0.5)&+ item2
  end.
case. wdcl_spin ; wdcl_spinv do.
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
  item1=. {.@(0&".) 1{::args
  gtk_spin_button_set_value window ;< (0.5-0.5)&+ item1
case. wdcl_trackbar ; wdcl_trackbarv do.
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 3 4 5 e.~ #args do. seterr 'extra parameter : ' return.
  elseif. 6< #args do. seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
  if. 2= #args do.
    item1=. {.@(0&".) 1{::args
    gtk_range_set_value window ;< (0.5-0.5)&+ item1
  else.
    'item1 item2 item3 item4 item5'=. 5{. {.@(0&".)&> 2}.args
    gtk_range_set_range window ; <("0) (0.5-0.5)&+ item1, item3
    gtk_range_set_increments window ; <("0) (0.5-0.5)&+ 1, item4
    gtk_range_set_value window ;< (0.5-0.5)&+ item2
  end.
case. wdcl_tab do.
  if. 1= #args do. seterr 'bad id : ' return. end.
  if. _1~: ix=. getcchildidx window do. childList=: (<1) (<ix,ChildListNotrigger)}childList end.
  for_item. }.args do.
    lb=. gtk_label_new <>item
    fixed1=. gtk_fixed_new ''
    gtk_widget_show <fixed1
    if. _1&= gtk_notebook_append_page window ; fixed1 ;< lb do.
      g_object_unref <lb
      g_object_unref <fixed1
      seterr 'todomsg2 : ' return.
    end.
  end.
  if. _1~: ix=. getcchildidx window do. childList=: (<0) (<ix,ChildListNotrigger)}childList end.
case. do. seterr 'bad class : ' return.
end.
cChild=: window
)
wdsetscroll=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
select. iclass=. getcchildclass window
case. wdcl_editm ; wdcl_richeditm do.
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  elseif. do. s=. 1{::args
  end.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  line=. {.@(0&".) s
case. do. seterr 'bad class : ' return.
end.
cChild=: window
)

wdsetlimit=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 2= #args do. s=. 1{::args
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 > len=. <.@{.@(0&".) s do. seterr 'bad number : ' return. end.
select. iclass=. getcchildclass window
case. wdcl_edit do. gtk_entry_set_max_length window, len
end.
cChild=: window
)

wdsetlocale=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
localec=. ,>{.}.args
ix=. getcchildidx window
childList=: (<localec) (<ix,ChildListLocalec)}childList
cChild=: window
)

wdsetcaption=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
s=. >{.}.args
if. g_type_check_instance_is_a window ;< gtk_button_get_type '' do.
  if. 0= image=. gtk_button_get_image <window do.
    gtk_button_set_label window ; '&_' charsub s
  else.
    setbuttonimage window ; image ;< s
  end.
else.
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c *c x')&cd window ; 'label' ; s ;< 0
end.
cChild=: window
)

wdsetdelete=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
if. -.@isnum ax=. 1{::args do. seterr 'bad number : ' return. end.
tabn=. {.@(0&".) ax
if. g_type_check_instance_is_a window ;< gtk_notebook_get_type '' do.
  if. pg=. gtk_notebook_get_nth_page window ;< tabn do.
    for_child. > (window = >6{"1 childList) # 1{"1 childList do.
      if. gtk_widget_is_ancestor pg ;< child do.
        cWindow delcchild child
      end.
    end.
  end.
  gtk_notebook_remove_page window ;< tabn
end.
cChild=: window
)
wdsetedit=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
select. getcchildclass window
case. wdcl_edit ; wdcl_editm do.
  if. 1= #args do. seterr 'bad parameter : ' return
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  end.
  s=. 1{::args
  if. (<s) -.@e. ;:'z x c v y' do. seterr 'bad data : ' return. end.
  if. g_type_check_instance_is_a window ;< gtk_text_view_get_type '' do.
    buf=. gtk_text_view_get_buffer <window
    clip=. gtk_clipboard_get <GDK_NONE
    select. {.s
    case. 'z' do. gtk_source_buffer_undo <buf
    case. 'x' do. gtk_text_buffer_cut_clipboard buf ; clip ;< 1
    case. 'c' do. gtk_text_buffer_copy_clipboard buf ;< clip
    case. 'v' do.
      mark=. gtk_text_buffer_get_insert <buf
      gtk_text_buffer_get_iter_at_mark buf ; (iter=. i.ITERSIZE) ; mark
      gtk_text_buffer_paste_clipboard buf ; clip ; iter ;< 1
    case. 'y' do. gtk_source_buffer_redo <buf
    end.
  else.
    select. {.s
    case. 'z' do.
    case. 'x' do. gtk_editable_cut_clipboard <window
    case. 'c' do. gtk_editable_copy_clipboard <window
    case. 'v' do. gtk_editable_paste_clipboard <window
    case. 'y' do.
    end.
  end.
case. do. seterr 'bad class : ' return.
end.
cChild=: window
)

wdsetenable=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. s=. ,'1'
elseif. 2= #args do. s=. 1{::args
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
window=. cWindow getcchild id
menu=. cWindow getmenu id
tbar=. cWindow gettoolbar id
if. (0=menu) *. (0=tbar ) *. (0=window) do. seterr 'bad id : ' return. end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
if. 0~: window do. ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd window ; 'sensitive' ; flag ;< 0 end.
if. 0~: menu do. ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd menu ; 'sensitive' ; flag ;< 0 end.
if. 0~: tbar do. ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd tbar ; 'sensitive' ; flag ;< 0 end.
if. 0~: window do. cChild=: window end.
)

wdsetfocus=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
gtk_widget_grab_focus <window
cChild=: window
)

wdsetinsert=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 2= #args do. seterr 'missing parameter : ' return.
elseif. 3< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
if. -.@isnum ax=. 1{::args do. seterr 'bad number : ' return. end.
tabn=. {.@(0&".) ax
s=. 2{::args
if. g_type_check_instance_is_a window ;< gtk_notebook_get_type '' do.
  lb=. gtk_label_new <s
  fixed1=. gtk_fixed_new ''
  gtk_widget_show <fixed1
  if. _1&= pg=. gtk_notebook_insert_page window ; fixed1 ; lb ;< tabn do.
    g_object_unref <lb
    g_object_unref <fixed1
    seterr 'todomsg3 : ' return.
  end.
end.
cChild=: window
)

wdsetinvalid=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
gtk_widget_queue_draw window
cChild=: window
)
wdsetreadonly=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. s=. ,'1'
elseif. 2= #args do. s=. 1{::args
elseif. 2< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
select. getcchildclass window
case. wdcl_edit ; wdcl_editm do.
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
  if. g_type_check_instance_is_a window ;< gtk_text_view_get_type '' do.
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd window ; 'editable' ; (-.flag) ;< 0
  else.
    gtk_editable_set_editable window ;< (-.flag)
  end.
case. do. seterr 'bad class : ' return.
end.
cChild=: window
)
wdsetreplace=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
select. getcchildclass window
case. wdcl_editm do.
  if. 2< #args do. seterr 'extra parameter : ' return. end.
  s=. >@{.}.args
  if. g_type_check_instance_is_a window ;< gtk_text_view_get_type '' do.
    buf=. gtk_text_view_get_buffer <window
    gtk_text_buffer_delete_selection buf ; 0 ;< 1
    gtk_text_buffer_insert_at_cursor buf ; s ; #s
  else.
    gtk_editable_delete_selection <window
    p=. gtk_editable_get_position <window
    gtk_editable_insert_text window ; s ; (#s) ;< ,p
  end.
case. wdcl_tab do.
  if. 1= #args do. seterr 'bad number : ' return.
  elseif. 2= #args do. s=. ''
  elseif. 3= #args do. s=. 2{::args
  elseif. 3< #args do. seterr 'extra parameter : ' return.
  end.
  if. -.@isnum aitem1=. 1{::args do. seterr 'bad number : ' return. end.
  item1=. {.@(0&".) aitem1
  if. 0~: page=. gtk_notebook_get_nth_page window ;< item1 do.
    gtk_notebook_set_tab_label_text window ; page ;< s
  end.
case. do. seterr 'bad class : ' return.
end.
cChild=: window
)
wdsetselect=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
select. iclass=. getcchildclass window
case. wdcl_edit ; wdcl_editm do.
  if. 4< #args do. seterr 'extra parameter : ' return.
  elseif. 1 3 4 -.@e.~ #args do. seterr 'bad number : ' return.
  end.
  if. 1= #args do.
    allsel=. 1 [ noscroll=. 1
  else.
    allsel=. 0
    if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
    'startsel endsel noscroll'=. 3{. {.@(0&".)&> }.args
    if. 3= #args do. noscroll=. 1 end.
  end.
  if. g_type_check_instance_is_a window ;< gtk_text_view_get_type '' do.
    buf=. gtk_text_view_get_buffer <window
    if. allsel do.
      gtk_text_buffer_get_iter_at_offset buf ; (iter1=. i.ITERSIZE) ;< 0
      gtk_text_buffer_get_iter_at_offset buf ; (iter2=. i.ITERSIZE) ;< _1
    else.
      gtk_text_buffer_get_iter_at_offset buf ; (iter1=. i.ITERSIZE) ;< startsel
      gtk_text_buffer_get_iter_at_offset buf ; (iter2=. i.ITERSIZE) ;< endsel
    end.
    gtk_text_buffer_select_range buf ; iter1 ;< iter2
    if. 0= noscroll do.
      mark=. gtk_text_buffer_create_mark buf ; (<0) ; iter2 ;< 0
      gtk_text_view_scroll_mark_onscreen buf ;< mark
      gtk_source_buffer_delete_marker buf ;< mark
    end.
  else.
    if. allsel do.
      gtk_editable_select_region window ; 0 ;< _1
    else.
      gtk_editable_select_region window ; startsel ;< endsel
    end.
  end.
case. wdcl_tab ; wdcl_combobox ; wdcl_combodrop ; wdcl_combolist ; wdcl_listbox do.
  if. 2> #args do. seterr 'bad number : ' return.
  elseif. 2< #args do. seterr 'extra parameter : ' return.
  end.
  s=. 1{::args
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  item=. {.@(0&".) s
  if. _1~: ix=. getcchildidx window do. childList=: (<1) (<ix,ChildListNotrigger)}childList end.
  if. wdcl_tab = iclass do.
  elseif. wdcl_combolist = iclass do.
    gtk_combo_box_set_active window,item
  elseif. iclass e. wdcl_listbox do.
    if. _1&= item do.
      select=. gtk_tree_view_get_selection <window
      gtk_tree_selection_unselect_all <select
    else.
      if. g_type_check_instance_is_a window ;< gtk_tree_view_get_type '' do.
        model=. gtk_tree_view_get_model window
        assert. 0~:model
        gtk_tree_model_iter_nth_child model ; (iter=. i.ITERSIZE) ; 0 ; item
        select=. gtk_tree_view_get_selection <window
        assert. 0~:select
        gtk_tree_selection_select_iter select ; iter
      end.
    end.
  elseif. do.
    if. 3=GTKVER_j_ do.
      gtk_combo_box_set_active window,item
    else.
      gtk_combo_box_set_active window,item
    end.
  end.
  if. _1~: ix=. getcchildidx window do. childList=: (<0) (<ix,ChildListNotrigger)}childList end.
case. wdcl_trackbar ; wdcl_trackbarv do.
  allsel=. 0
  if. 1= #args do. allsel=. 1
  elseif. 2= #args do. seterr 'bad number : ' return.
  elseif. 3< #args do. seterr 'extra parameter : ' return.
  end.
  if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
  'startsel endsel'=. {.@(0&".)&> }.args
  gtk_window_set_select window ; startsel ; endsel
case. do. seterr 'bad class : ' return.
end.
cChild=: window
)

wdsetshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. s=. ,'1'
elseif. 2= #args do. s=. 1{::args
elseif. 2< #args do. seterr 'extra paramenter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
if. 0= window=. cWindow getcchild id do.
else.
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd window ; 'visible' ; flag ;< 0
  select. getcchildclass window
  case. wdcl_editm do.
    win=. gtk_widget_get_parent <window
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd win ; 'visible' ; flag ;< 0
  end.
  cChild=: window
end.
)

wdsetxywh=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 5> #args do. seterr 'bad number : ' return.
elseif. 5< #args do. seterr 'extra paramenter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> }.args
setxywhx id ; D2P xywh
)

wdsetxywhx=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 5> #args do. seterr 'bad number : ' return.
elseif. 5< #args do. seterr 'extra paramenter : ' return.
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0 e. isnum&> }.args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> }.args
setxywhx id ; xywh
)

setxywhx=: 3 : 0
'id xywh'=. y
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
win=. getchildwin window
fixed1=. gtk_widget_get_parent <win
assert. 0~:fixed1
assert. 0~: g_type_check_instance_is_a fixed1, gtk_fixed_get_type ''
gtk_fixed_move fixed1 ; win ; <("0) 2{.xywh
gtk_widget_set_size_request win ; <("0) 2}.xywh
gtk_container_resize_children <fixed1
)

wdxywh=: 3 : 0
if. 4> #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 4< #args do. seterr 'extra paramenter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
cxywh=: <. {.@(0&".)&> args
)


FMSTYLE=: , ; each { (;<;:'left top right bottom') ; <;:'move scale'
j=. 0 : 0
button
bs
group
defpushbutton ownerdraw
0 1
1
button
checkbox
bs
group
lefttext
2 4
1
button
combobox
cbs
group vscroll
autohscroll sort
2 2
0
button select
combodrop
cbs
group vscroll
autohscroll sort
2 2
0
button select
combolist
cbs
group vscroll
sort
2 2
0
button select
edit
es
group thickframe
autohscroll lowercase nohidesel password readonly right uppercase
2 3
0
button
editm
es
group hscroll thickframe vscroll
autohscroll autovscroll center lowercase nohidesel readonly right uppercase
2 2
0

groupbox
-
group
-
2 2
1

isigraph
gs
-
opengl
2 2
0
char copy cut focus focuslost mbldbl mbldown mblup mblmdown mblmdbl mblmup mbrdbl mbrdown mbrup mmove mwheel paint paste undo
listbox
lbs
group hscroll vscroll
extendedsel multicolumn multiplesel ownerdrawfixed sort
2 2
0
button select
progress
-
group
-
2 3
0
button
radiobutton
bs
-
lefttext
2 4
1
button
richedit
es
group thickframe
autohscroll nohidesel readonly sunken
2 3
0
button
richeditm
es
group hscroll thickframe vscroll
autohscroll autovscroll center nohidesel readonly right sunken
2 2
0

scrollbar
sbs
group
-
2 3
0
button
scrollbarv
sbs
group
-
3 2
0
button
spin

group
-
1 1
0
button
spinv

group
-
1 1
0
button
static
ss
group
center leftnowordwrap noprefix right simple
2 4
1

staticbox
ss
group
blackframe blackrect etchedframe etchedhorz etchedvert grayframe grayrect sunken whiteframe whiterect
2 2
0

tab
tcs
group
buttons multiline
2 2
0
button
trackbar
tbs
group
autoticks both enableselrange nothumb noticks top
2 3
0
button
trackbarv
tbs
group
autoticks both enableselrange left nothumb noticks
3 2
0
button
ocx
ocx
group

2 2
0
button
editijs
es
group hscroll thickframe vscroll
autohscroll autovscroll center lowercase nohidesel readonly right uppercase
2 2
0

editijx
es
group hscroll thickframe vscroll
autohscroll autovscroll center lowercase nohidesel readonly right uppercase
2 2
0

)
j=. _7 [\ <;._2 j -. '-'
s=. 'border disabled '
std=. ([: 'ws_'&, each [: ;: s&,) each 2 {"1 j
sty=. (1 {"1 j) ,each '_'
cls=. (< each sty) ,each each ;: each 3 {"1 j
siz=. 0 ". each 4 {"1 j
cap=. 0 ". each 5 {"1 j
evt=. ;: each 6 {"1 j
CONTROLS=: (2 {."1 j) ,. std ,. cls ,. siz ,. cap ,. evt
JAVASTYLES=: (<;._2) 0 : 0
bs_defpushbutton
bs_lefttext
bs_ownerdraw
cbs_autohscroll
cbs_sort
es_autohscroll
es_autovscroll
es_center
es_lowercase
es_nohidesel
es_password
es_readonly
es_right
es_sunken
es_uppercase
gs_opengl
lbs_extendedsel
lbs_multicolumn
lbs_multiplesel
lbs_ownerdrawfixed
lbs_sort
sbs_vert
ss_blackframe
ss_blackrect
ss_center
ss_etchedframe
ss_etchedhorz
ss_etchedvert
ss_grayframe
ss_grayrect
ss_leftnowordwrap
ss_noprefix
ss_right
ss_simple
ss_sunken
ss_whiteframe
ss_whiterect
tbs_autoticks
tbs_both
tbs_enableselrange
tbs_left
tbs_nothumb
tbs_noticks
tbs_top
tcs_buttons
tcs_multiline
ws_border
ws_disabled
ws_group
ws_hscroll
ws_thickframe
ws_vscroll
)
3 : 0''
std=. 2 {"1 CONTROLS
cls=. 3 {"1 CONTROLS
if. IFJAVA=. 1 do.
  std=. std (e. # [) each <JAVASTYLES
  cls=. cls (e. # [) each <JAVASTYLES
end.
CONTROLS=: (std ,. cls) 2 3 }"1 CONTROLS
STDCONTROLS=: CONTROLS #~ (<'ocx') ~: {."1 CONTROLS
)

(a)=: i.# a=. (<'wdcl_') ,&.> {."1 CONTROLS
qcolor=: ".;._2 [ 0 : 0
212 208 200
58 110 165
10 36 106
128 128 128
212 208 200
255 255 255
0 0 0
0 0 0
0 0 0
255 255 255
212 208 200
212 208 200
128 128 128
10 36 106
255 255 255
212 208 200
128 128 128
128 128 128
0 0 0
212 208 200
255 255 255
64 64 64
212 208 200
0 0 0
255 255 225
181 181 181
0 0 200
166 202 240
192 192 192
10 36 106
212 208 200
)

wdbeep=: 3 : 0
if. 1< #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
)

wdq=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. wdqdata-: 0 0$0 do. seterr 'invalid command(wdq) : ' return. end.
t=. wdqdata
smoutput^:(1<Debugwd) t
t [ wdqdata=: 0 0$0
)

wdqcolor=: 3 : 0
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum ax=. >@{.args do. seterr 'bad number : ' return. end.
if. 0 > c=. <. {.@(0&".) ax do.seterr 'bad number : ' return. end.
if. c >: #qcolor do.
  z=. 3$0
else.
  z=. c{qcolor
end.
":z
)

wdqd=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
pa=. {.(cWindow = >{."1 windowList)#windowList
syslocalep=. >WindowListLocale{pa
syslocalec=. ''
syshwndp=. ":cWindow
syshwndc=. ":cChild
sysfocus=. getcchildid gtk_window_get_focus <cWindow
syslastfocus=. ''
sysmodifiers=. ''
wdd=. ;: 'syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers'
wddata=. ".&.>wdd
qdata=. 0 2$<''
for_ls. (cWindow = >{."1 childList)#childList do.
  qdata=. qdata, childevtdata 1 2 3{ls
end.
(wdd ,. wddata), qdata
)

wdqiox=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
,'0'
)

wdqer=: 3 : 0
z=. WDERR
if. ''-: z do.
  'no error : 0'
else.
  z, ": wdptr0
end.
)

wdqm=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
scr=. gdk_screen_get_default ''
w=. gdk_screen_get_width <scr
h=. gdk_screen_get_height <scr
": w, h, 8 16, 1 1 3 3 4 4 19 19 0 0, w, h
)

wdqp=: 3 : 0
if. 0= #args=. shiftargs'' do. s=. ''
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. 0= #windowList do. '' return. end.
ws=. WindowListPgroup{"1 windowList
;LF ,&.>~ (WindowListId{"1 windowList)#~(<s)=ws
)
wdqpx=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. 0= #windowList do. '' return. end.
z=. ''
for_i. i.#windowList do.
  'w id loc grp act'=. (WindowListHandle, WindowListId, WindowListLocale, WindowListPgroup, WindowListActiveidx){i{windowList
  if. 0~: s=. gtk_window_get_title <w do.
    cap=. memr s,0 _1 2
  else.
    cap=. ''
  end.
  z=. z, id, ({.a.), (":w), ({.a.), loc, ({.a.), grp, ({.a.), (":act), ({.a.), (cap), ({.a.), LF
end.
z
)

wdqscreen=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
scr=. gdk_screen_get_default ''
wmm=. gdk_screen_get_width_mm <scr
hmm=. gdk_screen_get_height_mm <scr
w=. gdk_screen_get_width <scr
h=. gdk_screen_get_height <scr
dpi=. <. (w, h)%(wmm, hmm)%25.4
pxsiz=. <. 0.5 + 36*96%dpi
": wmm, hmm, w, h, dpi, 32 1 _1, pxsiz, <. 0.5 + %: +/ *: pxsiz
)

wdqwd=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
'jgtk'
)
wdreset=: 3 : 0
if. 1< #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
for_pa. |. WindowListHandle{::"1 windowList do.
  gtk_widget_destroy <pa
end.
cleanup''
)

wdclipcopy=: 3 : 0
if. 0= #args=. shiftargs'' do. txt=. ''
elseif. 1= #args do. txt=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
len=. #txt
cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
gtk_clipboard_set_text cb;txt;len
gtk_clipboard_store cb
)

wdclippaste=: 3 : 0
if. 0= #args=. shiftargs'' do. ax=. ,'0'
elseif. 1= #args do. ax=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum ax do. seterr 'bad number : ' return. end.
if. -. 0 1 2 e.~ ty=. <. {.@(0&".) ax do. seterr 'bad number : ' return. end.
cb=. gtk_clipboard_get gdk_atom_intern 'CLIPBOARD';0
p=. gtk_clipboard_wait_for_text cb
if. p do. txt=. memr p,0 _1 else. txt=. '' end.
if. 2= ty do. seterr 'command fail : ' return.
elseif. (0= #txt) *. 1= ty do. seterr 'command fail : ' return.
end.
txt
)

wdtimer=: 3 : 0
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. -.@isnum ax=. >@{.args do. seterr 'bad number : ' return. end.
if. 0 > delay=. <. {.@(0&".) ax do.seterr 'bad number : ' return. end.
timerdelay=: delay
if. 0~:systimerid do. systimerid=: 0 [ g_source_remove systimerid end.
if. timerdelay>0 do.
  systimerid=: g_timeout_add_full G_PRIORITY_DEFAULT_IDLE;timerdelay;cb1;(cbreg 'timer_event','_',(>coname''),'_');0
end.
)

form_evt=: 3 : 0
'widget event child'=. y
if. _1= ix=. windowlistidx widget do. return. end.
if. cWindow~:widget do.
  cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: widget
end.
'parentid locale'=. (WindowListId, WindowListLocale){ix{windowList
syshandler=. parentid, '_handler'
sysevent=. parentid, ((child-.@-:'')#'_', child), '_', event
sysdefault=. parentid, '_default'
sysparent=. parentid
syschild=. child
systype=. event
syslocalep=. locale
syslocalec=. ''
syshwndp=. ":widget
syshwndc=. ":cChild
sysfocus=. getcchildid ::(''"_) gtk_window_get_focus <widget
syslastfocus=. ''
wdd=. ;: 'syshandler sysevent sysdefault sysparent syschild systype syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers', (0<#sysdata)#' sysdata'
wddata=. ".&.>wdd
qdata=. 0 2$<''
for_ls. (widget = >{."1 childList)#childList do.
  qdata=. qdata, childevtdata 1 2 3{ls
end.
sysdata=: ''
wdqdata=: (wdd ,. wddata) , qdata
if. (0: <: 18!:0) <locale do.
  if. 3= 4!:0 <fn=. 'wdhandler_',locale,'_' do.
    fn~ ''
  end.
end.
)

system_evt=: 3 : 0
'event handler'=. y
parentid=. 'sys'
syshandler=. parentid, '_handler'
sysevent=. parentid, '_', event
sysdefault=. parentid, '_default'
wdd=. ;: 'syshandler sysevent sysdefault'
wddata=. ".&.>wdd
qdata=. 0 2$<''
wdqdata=: (wdd ,. wddata) , qdata
if. 3= 4!:0 <fn=. handler, '_z_' do.
  fn~ ''
elseif. 3= 4!:0 <fn=. handler, '__' do.
  fn~ ''
end.
)

child_evt=: 4 : 0
eventcat=. x
'widget event'=. y
childdata=. 0 2$0
if. 0=eventcat do.
  if. 0&= #ls=. (widget = >1{"1 childList)#childList do. return. end.
  'pawin childid iclass'=. 0 2 3{ {.ls
  for_ls. (pawin = >{."1 childList)#childList do.
    childdata=. childdata, childevtdata 1 2 3{ls
  end.
elseif. 1=eventcat do.
  if. 0&= #ls=. (widget = >1{"1 menuList)#menuList do. return. end.
  'pawin childid'=. 0 2{ {.ls
elseif. 2=eventcat do.
  if. 0&= #ls=. (widget = >1{"1 toolbarList)#toolbarList do. return. end.
  'pawin childid'=. 0 2{ {.ls
elseif. do. assert. 0
end.
if. 0&= #pals=. (pawin = >{."1 windowList)#windowList do. return. end.
'parentid locale'=. (WindowListId, WindowListLocale){ {.pals
syslocalec=. ''
if. 0=eventcat do.
  if. _1~: ix=. getcchildidx widget do.
    if. #subform=. (<ix,ChildListSubform){::childList do. parentid=. subform end.
    syslocalec=. (<ix,ChildListLocalec){::childList
  end.
end.
syshandler=. parentid, '_handler'
sysevent=. parentid, '_', childid, '_', event
sysdefault=. parentid, '_default'
sysparent=. parentid
syschild=. childid
systype=. event
syslocalep=. locale
syshwndp=. ":pawin
syshwndc=. ":widget
sysfocus=. getcchildid ::(''"_) gtk_window_get_focus <pawin
syslastfocus=. ''
wdd=. ;: 'syshandler sysevent sysdefault sysparent syschild systype syslocalep syslocalec syshwndp syshwndc sysfocus syslastfocus sysmodifiers', (0<#sysdata)#' sysdata'
wdqdata=: (wdd ,. ".&.>wdd) , childdata
sysdata=: ''
locale=. (''-:syslocalec){::syslocalec;syslocalep
if. (0: <: 18!:0) <locale do.
  if. 3= 4!:0 <fn=. 'wdhandler_',locale,'_' do.
    chgparent=. 0
    if. cWindow~:pawin do.
      chgparent=. 1
      oldcSubform=. cSubform [ oldcSetFont=. cSetFont [ oldcContainer=. cContainer [ oldcRadio=. cRadio [ oldcChild=. cChild [ oldcWindow=. cWindow
      cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: pawin
    end.
    fn~ ''
    if. chgparent do.
      cSubform=: oldcSubform [ cSetFont=: oldcSetFont [ cContainer=: oldcContainer [ cRadio=: oldcRadio [ cChild=: oldcChild [ cWindow=: oldcWindow
    end.
  end.
end.
)

childevtdata=: 3 : 0
'widget id iclass'=. y
wdd=. wddata=. 0$<''
select. iclass
case. wdcl_spin ; wdcl_spinv do.
  wdd=. wdd, <id
  wddata=. wddata, < ": gtk_spin_button_get_value_as_int widget
fcase. wdcl_trackbar ; wdcl_trackbarv do.
case. wdcl_scrollbar ; wdcl_scrollbarv do.
  wdd=. wdd, <id
  wddata=. wddata, < ": <. gtk_range_get_value widget
case. wdcl_edit do.
  wdd=. wdd, <id
  wddata=. wddata, <memr (gtk_entry_get_text widget), 0 _1 2
case. wdcl_editm do.
  buf=. gtk_text_view_get_buffer <widget

  mark=. gtk_text_buffer_get_insert <buf
  gtk_text_buffer_get_iter_at_mark buf ; (iter0=. i.ITERSIZE) ;< mark
  offset=. gtk_text_iter_get_offset <iter0

  gtk_text_buffer_get_bounds buf ; (iter1=. i.ITERSIZE) ;< (iter2=. i.ITERSIZE)
  ptxt=. gtk_text_buffer_get_text buf ; iter1 ; iter2 ;< 0
  wdd=. wdd, <id
  wddata=. wddata, <memr ptxt, 0 _1, JCHAR
  gtk_text_buffer_get_selection_bounds buf ; iter1 ;< iter2
  if. 0~: gtk_text_iter_equal iter1 ;< iter2 do.
    sel=. offset, offset
  else.
    offset1=. gtk_text_iter_get_offset <iter1
    offset2=. gtk_text_iter_get_offset <iter2
    sel=. offset1, offset2
  end.
  wdd=. wdd, <id, '_select'
  wddata=. wddata, < ": sel
  wdd=. wdd, <id, '_scroll'
  scrollwin=. gtk_widget_get_parent <widget
  vadj=. gtk_scrolled_window_get_vadjustment <scrollwin
  vvalue=. ,0.5-0.5
  vupper=. ,0.5-0.5
  ((>libgobject), ' g_object_get ', gtkcv, 'n x *c *d *c *d x')&cd vadj ; 'value' ; vvalue ; 'upper' ; vupper ;< 0
  linecount=. gtk_text_buffer_get_line_count <buf
  wddata=. wddata, < ": (0), (<.linecount*vvalue%vupper)
case. wdcl_checkbox ; wdcl_radiobutton do.
  wdd=. wdd, <id
  wddata=. wddata, < ": gtk_toggle_button_get_active widget
case. wdcl_combobox ; wdcl_combodrop ; wdcl_combolist do.
  if. _1&= irow=. gtk_combo_box_get_active <widget do.
    wdd=. wdd, <id
    wddata=. wddata, <''
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": _1
  else.
    liststore=. gtk_combo_box_get_model <widget
    idx=. 0
    nsel=. $0 [ ssel=. ''
    str_data=. ,_1
    valid=. gtk_tree_model_get_iter_first liststore ;< (iter=. i.ITERSIZE)
    while. (idx<irow) *. 0~:valid do.
      idx=. >:idx
      valid=. gtk_tree_model_iter_next liststore ;< iter
    end.
    if. (idx=irow) *. 0~:valid do.
      ((>libgtk), ' gtk_tree_model_get ', gtkcv, 'n x *x x *x x')&cd liststore ; iter ; 0 ; str_data ; _1
      ssel=. memr str_data, 0 _1
      g_free <{.str_data
      wdd=. wdd, <id
      wddata=. wddata, <ssel
      wdd=. wdd, <id, '_select'
      wddata=. wddata, < ": irow
    else.
      wdd=. wdd, <id
      wddata=. wddata, <''
      wdd=. wdd, <id, '_select'
      wddata=. wddata, < ": _1
    end.
  end.
case. wdcl_listbox do.
  select=. gtk_tree_view_get_selection <widget
  if. 0&= nrow=. gtk_tree_selection_count_selected_rows <select do.
    wdd=. wdd, <id
    wddata=. wddata, <''
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": _1
  else.
    liststore=. gtk_tree_view_get_model <widget
    idx=. 0
    nsel=. $0 [ ssel=. ''
    str_data=. ,_1
    valid=. gtk_tree_model_get_iter_first liststore ;< (iter=. i.ITERSIZE)
    while. 0~:valid do.
      if. 0~: gtk_tree_selection_iter_is_selected select ;< iter do.
        ((>libgtk), ' gtk_tree_model_get ', gtkcv, 'n x *x x *x x')&cd liststore ; iter ; 0 ; str_data ; _1
        ssel=. ssel , LF, memr str_data, 0 _1
        g_free <{.str_data
        if. nrow&= #nsel=. nsel, idx do. break. end.
      end.
      idx=. >:idx
      valid=. gtk_tree_model_iter_next liststore ;< iter
    end.
    wdd=. wdd, <id
    wddata=. wddata, <}.ssel
    wdd=. wdd, <id, '_select'
    wddata=. wddata, < ": nsel
  end.
case. wdcl_tab do.
  ix=. getcchildidx widget
  assert. _1~: ix
  if. 0~: page=. > (<ix,ChildListUserdata){childList do.
    pagenum=. gtk_notebook_page_num widget, page
    pagelabel=. memr (gtk_notebook_get_tab_label_text widget, page), 0 _1 2
  else.
    pagenum=. _1
    pagelabel=. ''
  end.
  wdd=. wdd, <id
  wddata=. wddata, < ": pagelabel
  wdd=. wdd, <id,'_select'
  wddata=. wddata, < ": pagenum
end.
assert. 1= (2:=(3!:0))&> wdd
assert. 1= (2:=(3!:0))&> wddata
wdd ,. wddata
)

window_configure=: 3 : 0
'widget event data'=. y
if. _1= idx=. windowlistidx widget do. 0 return. end.
wh=. _2{. getGdkEventConfigure_xywh event
if. wh -.@-: 2{.whwh0=. (<idx, WindowListWhwh0) {:: windowList do.
  windowList=: (<whwh0=. wh, _2{.whwh0) (<idx, WindowListWhwh0) } windowList
  whwh0 resizechild widget
end.
0
)

window_key_press=: 3 : 0
'widget event data'=. y
if. 0> ix=. windowlistidx widget do. 0 return. end.
'state key'=. gtkeventkey event
'ctrl j shift'=. 2 2 2 #: state
keyevent=. '' [ child=. ''
if. (GDK_Return = key) *. 0 = ctrl do.
  if. _1= getcchildidx w=. gtk_window_get_focus widget do.
    if. _1= getcchildidx w=. gtk_widget_get_parent w do.
      keyevent=. 'enter'
    end.
  end.
elseif. (GDK_Escape = key) *. 0=ctrl do. keyevent=. 'cancel'
elseif. key e. GDK_FKeys do.
  keyevent=. 'fkey'
  child=. ('f',":(>: key - GDK_F1)),(ctrl#'ctrl'),(shift#'shift')
elseif. (key e. GDK_a + i.26) *. 1=ctrl do.
  keyevent=. 'fkey'
  child=. (key{a.),(ctrl#'ctrl')
elseif. (key e. GDK_A + i.26) *. 1=ctrl do.
  keyevent=. 'fkey'
  child=. (((a.i.'a')+(key - GDK_A)){a.),(ctrl#'ctrl'),'shift'
end.
if. #keyevent do.
  sysdata=: utf8 u: key
  sysmodifiers=: ,":shift+2*ctrl
  1 [ form_evt widget ; keyevent ; child
end.
0
)

window_grab_focus=: 3 : 0
'widget data'=. y
0
)

window_delete=: 3 : 0
'widget event data'=. y
if. _1= ix=. windowlistidx widget do. 0 return. end.
if. 0= gtk_widget_get_sensitive widget do. 1 return. end.
if. 1= (<ix, WindowListCloseok) {:: windowList do. 0 return. end.
form_evt widget ; 'close' ; ''
1
)

window_destroy=: 3 : 0
'widget data'=. y
if. _1~: ix=. windowlistidx widget do.
  if. 0~: tbimg=. (<ix, WindowListTbimg) {:: windowList do. g_object_unref tbimg end.
  if. 0~: pawin=. (<ix, WindowListOwner) {:: windowList do. gtk_widget_set_sensitive pawin, 1 end.
  windowList=: (<<<ix){windowList
end.
if. 1 e. ix=. (widget = (>{."1 containerList)) do. containerList=: (-.ix)#containerList end.
if. 1 e. ix=. (widget = (>{."1 subformList)) do. subformList=: (-.ix)#subformList end.
if. 1 e. ix=. (widget = (>{."1 childList)) do. childList=: (-.ix)#childList end.
if. 1 e. ix=. (widget = (>{."1 menuList)) do. menuList=: (-.ix)#menuList end.
if. 1 e. ix=. (widget = (>{."1 toolbarList)) do. toolbarList=: (-.ix)#toolbarList end.
if. 1 e. ix=. (widget = (>{."1 statusbarList)) do. statusbarList=: (-.ix)#statusbarList end.
if. 1 e. ix=. (widget = (>{."1 glxList)) do. glxList=: (-.ix)#glxList end.
if. (widget=cWindow) +. 0=#windowList do.
  cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: cWindow=: 0
end.
if. 0=#windowList do.
  cleanup''
end.
0
)

window_realize=: 3 : 0
'widget data'=. y
0
)
widget_realize=: 3 : 0
'widget data'=. y
0
)

combobox_changed=: 3 : 0
'widget data'=. y
if. _1= ix=. getcchildidx widget do. 0 return. end.
if. 0= flag=. (<ix,ChildListNotrigger){::childList do.
  0 child_evt widget ; 'select'
else.
  childList=: (<0) (<ix,ChildListNotrigger)}childList
end.
0
)

listbox_changed=: 3 : 0
'widget data'=. y
if. 0= widget=. gtk_tree_selection_get_tree_view <widget do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
if. 0= flag=. (<ix,ChildListNotrigger){::childList do.
  0 child_evt widget ; 'select'
else.
  childList=: (<0) (<ix,ChildListNotrigger)}childList
end.
0
)

listbox_activated=: 3 : 0
'widget path column data'=. y
if. _1= ix=. getcchildidx widget do. 0 return. end.
if. 0= flag=. (<ix,ChildListNotrigger){::childList do.
  0 child_evt widget ; 'button'
else.
  childList=: (<0) (<ix,ChildListNotrigger)}childList
end.
0
)

button_toggled=: 3 : 0
'widget data'=. y
if. _1= ix=. getcchildidx widget do. 0 return. end.
if. 0= flag=. (<ix,ChildListNotrigger){::childList do.
  0 child_evt widget ; 'button'
else.
  childList=: (<0) (<ix,ChildListNotrigger)}childList
end.
0
)

spin_change=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0
)

trackbar_change=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0
)

scrollbar_change=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0
)

button_clicked=: 3 : 0
'widget data'=. y
0 child_evt widget ; 'button'
0
)

edit_key_press=: 3 : 0
'widget event data'=. y
if. widget -.@e. ls=. >1{"1 childList do. 0 return. end.
'state key'=. gtkeventkey event
'ctrl j shift'=. 2 2 2 #: state
if. (GDK_Return = key) *. 0 = ctrl do.
  sysdata=: utf8 u: key
  sysmodifiers=: ,":shift+2*ctrl
  0 child_evt widget ; 'button'
  1 return.
end.
0
)

combolist_key_press=: 3 : 0
'widget event data'=. y
if. widget -.@e. ls=. >1{"1 childList do. 0 return. end.
'state key'=. gtkeventkey event
'ctrl j shift'=. 2 2 2 #: state
if. (GDK_Return = key) *. 0 = ctrl do.
  sysdata=: utf8 u: key
  sysmodifiers=: ,":shift+2*ctrl
  0 child_evt widget ; 'button'
  1 return.
end.
0
)

tab_switch_page=: 3 : 0
'widget page page_num data'=. y
if. _1= ix=. getcchildidx widget do. 0 return. end.
if. 0= flag=. (<ix,ChildListNotrigger){::childList do.
  childList=: (<page) (<ix,ChildListUserdata)}childList
  0 child_evt widget ; 'button'
else.
  childList=: (<0) (<ix,ChildListNotrigger)}childList
end.
0
)

tab_page_removed=: 3 : 0
'widget page page_num data'=. y
if. _1= ix=. getcchildidx widget do. 0 return. end.
if. _1= n=. gtk_notebook_get_current_page widget do.
  userdata=. 0
else.
  userdata=. gtk_notebook_get_nth_page widget, n
end.
childList=: (<userdata) (<ix,ChildListUserdata)}childList
0
)

menu_activate_event=: 3 : 0
'widget data'=. y
if. widget -.@e. ls=. >1{"1 menuList do. 0 return. end.
ix=. ls i. widget
if. 1= revertmenu=. (<ix ,3){::menuList do.
  menuList=: (<0) (<ix ,3)}menuList
else.
  menuList=: (<1) (<ix ,3)}menuList
  gtk_check_menu_item_set_active widget ;< -. gtk_check_menu_item_get_active widget
  1 child_evt widget ; 'button'
end.
0
)

toolbar_clicked_event=: 3 : 0
'widget data'=. y
if. widget -.@e. ls=. >1{"1 toolbarList do. 0 return. end.
2 child_evt widget ; 'button'
0
)

isigraph_event=: 4 : 0
canvas=. y
if. canvas -.@e. ls=. 2{"1 glxList do. 0 return. end.
widget=. >1{(ls i. canvas){glxList
select. evt=. >@{.x
case. 'paint';'focus';'focuslost' do.
  0 child_evt widget ; evt
case. 'print' do.
  sysdata=: >1{x
  0 child_evt widget ; evt
case. do.
  sysdata=: >1{x
  sysmodifiers=: >2{x
  0 child_evt widget ; evt
end.
0
)

timer_event=: 3 : 0
system_evt 'timer';'sys_timer'
if. 0~:systimerid do. systimerid=: 0 [ g_source_remove systimerid end.
if. timerdelay>0 do.
  systimerid=: g_timeout_add_full G_PRIORITY_DEFAULT_IDLE;timerdelay;cb1;(cbreg 'timer_event','_',(>coname''),'_');0
end.
0
)
wdfontdef=: 3 : 0
f=. getfontspec args=. shiftargs''
if. 0=WDERRN do. cFontdef=: f end.
)
wdsetfont=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return. end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
f=. getfontspec }.args
if. 0=WDERRN do.
  'font asize style angle'=. f
  st=. (|. 2 2 2#:style)#'italic' ; 'bold' ; ''
  fd=. pango_font_description_from_string <'', font, '', (;' ' ,&.> st), ' ', (":asize)
  gtk_widget_modify_font window ;< fd
  pango_font_description_free <fd
end.
)
getfontspec=: 3 : 0
if. 0= #args=. y do. seterr 'bad font name : ' return.
elseif. 2> #args do. seterr 'bad number : ' return.
elseif. 7< #args do. seterr 'extra parameter : ' return.
end.
font=. >@{.args
if. -.@isnum asize=. 1{::args do. seterr 'bad number : ' return. end.
'style angle'=. 0 0
for_s1. 2}.args do.
  s=. >s1
  if. s1 e. <'default' do. continue.
  elseif. s1 e. 'italic' ; 'bold' ; 'underline' do. style=. style (23 b.) <. 2 ^ (<s) i.~ 'italic' ; 'bold' ; 'underline'
  elseif. 'angle'-:5{.s do. if. isnum 5}.s do. angle=. <. {.@(0&".) 5}.s else. seterr 'bad style : ' return. end.
  elseif. do. seterr 'bad style : ' return.
  end.
end.
font ; (0&". asize) ; style ; angle
)
wdmb=: 3 : 0
args=. shiftargs''
title=. >@{.args
txt=. >@{.}.args
if. 2< #args do.
  styles=. 2}.args
else.
  styles=. 0$<''
end.
if. (<'mb_yesno') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_YES ; GTK_RESPONSE_YES ; GTK_STOCK_NO ; GTK_RESPONSE_NO ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_NO
  end.
elseif. (<'mb_yesnocancel') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_YES ; GTK_RESPONSE_YES ; GTK_STOCK_NO ; GTK_RESPONSE_NO ; GTK_STOCK_CANCEL ; GTK_RESPONSE_CANCEL ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_NO
  elseif. (<'mb_defbutton3') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_CANCEL
  end.
elseif. (<'mb_okcancel') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_OK ; GTK_RESPONSE_OK ; GTK_STOCK_CANCEL ; GTK_RESPONSE_CANCEL ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_CANCEL
  end.
elseif. (<'mb_yesnocancel') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_YES ; GTK_RESPONSE_YES ; GTK_STOCK_NO ; GTK_RESPONSE_NO ; GTK_STOCK_CANCEL ; GTK_RESPONSE_CANCEL ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_NO
  elseif. (<'mb_defbutton3') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_CANCEL
  end.
elseif. (<'mb_retrycancel') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; 'Retry' ; 2 ; GTK_STOCK_CANCEL ; GTK_RESPONSE_CANCEL ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, GTK_RESPONSE_CANEL
  end.
elseif. (<'mb_arbortretryignore') e. styles do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x *c x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; 'Abort' ; 1 ; 'Retry' ; 2 ; 'Ignore' ; 3 ; 0
  if. (<'mb_defbutton2') e. styles do.
    gtk_dialog_set_default_response dialog, 2
  elseif. (<'mb_defbutton3') e. styles do.
    gtk_dialog_set_default_response dialog, 3
  end.
elseif. do.
  dialog=. ((>libgtk), ' gtk_dialog_new_with_buttons ', gtkcv, 'x *c x x *c x x')&cd title ; cWindow ;(GTK_DIALOG_MODAL + GTK_DIALOG_DESTROY_WITH_PARENT) ; GTK_STOCK_OK ; GTK_RESPONSE_OK ; 0
end.

hbox=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x x')&cd ( gtk_hbox_get_type '') ; 'border-width' ; 8 ;< 0

gtk_box_pack_start (gtk_dialog_get_content_area dialog) ; hbox ; 0 ; 0 ;< 0
if. +./ (<;._1 ' mb_iconasterisk mb_iconhand mb_iconinformation') e. styles do.
  stock=. gtk_image_new_from_stock GTK_STOCK_DIALOG_INFO ;< GTK_ICON_SIZE_DIALOG
  gtk_box_pack_start hbox ; stock ; 0 ; 0 ;< 0
elseif. (<'mb_iconquestion') e. styles do.
  stock=. gtk_image_new_from_stock GTK_STOCK_DIALOG_QUESTION ;< GTK_ICON_SIZE_DIALOG
  gtk_box_pack_start hbox ; stock ; 0 ; 0 ;< 0
elseif. (<'mb_iconexclamation') e. styles do.
  stock=. gtk_image_new_from_stock GTK_STOCK_DIALOG_WARNING ;< GTK_ICON_SIZE_DIALOG
  gtk_box_pack_start hbox ; stock ; 0 ; 0 ;< 0
elseif. (<'mb_iconstop') e. styles do.
  stock=. gtk_image_new_from_stock GTK_STOCK_STOP ;< GTK_ICON_SIZE_DIALOG
  gtk_box_pack_start hbox ; stock ; 0 ; 0 ;< 0
end.
lb=. gtk_label_new <txt
gtk_box_pack_start hbox ; lb ; 1 ; 1 ;< 0
gtk_widget_show_all <hbox
result=. gtk_dialog_run <dialog
gtk_widget_destroy <dialog
>('CANCEL' ; 'CANCEL' ; 'CANCEL' ; 'OK' ; 'YES' ; 'NO' ; 'ABORT' ; 'RETRY' ; 'IGNORE'){~result i.~ GTK_RESPONSE_DELETE_EVENT, GTK_RESPONSE_NONE, GTK_RESPONSE_CANCEL, GTK_RESPONSE_OK, GTK_RESPONSE_YES, GTK_RESPONSE_NO, 1 2 3
)
wdmbopen=: mbopensave bind 0
wdmbsave=: mbopensave bind 2
mbopensave=: 3 : 0
args=. shiftargs''
title=. >@{.args
dir=. dltb >@{.}.args
fil=. dltb >@{.2}.args
filter=. dltb >@{.3}.args
ofn_style=. <;._1 ' ofn_createprompt ofn_filemustexist ofn_nochangedir ofn_overwriteprompt ofn_pathmustexist'
if. 4 <#args do.
  for_a. 4}.args do.
    if. a -.@e. ofn_style do. seterr 'bad style : ' return. end.
  end.
end.
path=. dir, ('/'#~(0<#dir)*.0<#fil), fil
if. #filter do.
  if. 0=2| +/ '|'=filter do. seterr 'bad filter : ' return. end.
  pattern=. |. L: 1 [ _2<\ <;._1 '|',filter
else.
  pattern=. ''
end.
cWindow filechooser_jgtk_ y ; title ; pattern ; path
)
wdmenu=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 5< #args do. seterr 'extra parameter : ' return.
end.
if. 0~: checkbadname id=. 0{::args do. seterr 'bad id : ' return. end.
txt=. 1{::args,5#<''
shortcut=. 2{::args,5#<''
statushelp=. 3{::args,5#<''
tooltip=. 4{::args,5#<''
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  mn=. (handle i. cWindow){ >WindowListMenubar{"1 windowList
  acl=. (handle i. cWindow){ >WindowListAccel{"1 windowList
else.
  assert. 0
end.
if. 0= {.mn do. mn=. , createmenubar cWindow end.
if. '&' e. txt do.
  window=. gtk_check_menu_item_new_with_mnemonic <'&_'&charsub txt
else.
  window=. gtk_check_menu_item_new_with_label <txt
end.
if. '' -.@-: tooltip do.
  gtk_widget_set_tooltip_text window ; tooltip
end.
if. '' -.@-: shortcut do.
  shortcut=. toupper shortcut
  if. '+' e. shortcut do.
    ks=. <;._1 '+', shortcut
    shortcut=. (_1{::ks) ,~ ; ('<') ,&.> (}:ks) ,&.> ('>')
  end.
  gtk_accelerator_parse shortcut ; (key=. ,_1) ;< (modifiers=. ,_1)
  key=. {.key [ modifiers=. {.modifiers
  if. gtk_accelerator_valid key ;< modifiers do.
    gtk_widget_add_accelerator window ; 'activate' ; acl ; key ; modifiers ;< GTK_ACCEL_VISIBLE (23 b.) GTK_ACCEL_LOCKED
  end.
end.
gtk_menu_shell_append ({:mn) ;< window
gtk_widget_show <window
consig window ; 'activate' ; 'menu_activate_event'
windowList=: (<mn) (<(handle i. cWindow) ; WindowListMenubar) } windowList
menuList=: menuList, cWindow ; window ; id ; 0
)

wdmenupop=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. txt=. ''
elseif. 1< #args do. seterr 'extra parameter : ' return.
elseif. do. txt=. >@{.args
end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  mn=. (handle i. cWindow){ >WindowListMenubar{"1 windowList
else.
  assert. 0
end.
if. 0= {.mn do. mn=. , createmenubar cWindow end.
window=. gtk_menu_item_new_with_mnemonic <'&_'&charsub txt
gtk_menu_shell_append ({:mn) ;< window
gtk_widget_show <window
submn=. gtk_menu_new ''
gtk_menu_item_set_submenu window ;< submn
mn=. mn , submn
windowList=: (<mn) (<(handle i. cWindow) ; WindowListMenubar) } windowList
)

wdmenupopz=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  mn=. (handle i. cWindow){ >WindowListMenubar{"1 windowList
else.
  assert. 0
end.
if. 1 < #mn do. mn=. }:mn end.
windowList=: (<mn) (<(handle i. cWindow) ; WindowListMenubar) } windowList
)

wdmenusep=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  mn=. (handle i. cWindow){ >WindowListMenubar{"1 windowList
else.
  assert. 0
end.
if. 0= {.mn do. mn=. , createmenubar cWindow end.
window=. gtk_separator_menu_item_new ''
gtk_menu_shell_append ({:mn) ;< window
gtk_widget_show <window
windowList=: (<mn) (<(handle i. cWindow) ; WindowListMenubar) } windowList
)
createmenubar=: 3 : 0
cWindow=. y
vbox1=. gtk_bin_get_child <cWindow
menubar1=. gtk_menu_bar_new ''
gtk_widget_show <menubar1
gtk_box_pack_start vbox1 ; menubar1 ; 0 ; 0 ;< 0
gtk_box_reorder_child vbox1 ; menubar1 ;< 0
menubar1
)
wdcreategroup=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do.
  cSubform=: '' [ cContaineri=: _1 [ cContainer=: 0
else.
  if. 1< #args do. seterr 'extra parameter : ' return. end.
  id=. 0{::args
  if. 0= window=. cWindow getcchild id do. seterr 'bad id : ' return. end.
  cContaineri=: _1 [ cContainer=: window
  containerList=: containerList, (cWindow ; window ; 0 0)
end.
)

wdpactive=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr' extra parameter : ' return. end.
gtk_window_activate_focus <cWindow
)

wdpas=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 2> #args=. shiftargs'' do. seterr' bad number : ' return.
elseif. 2< #args do. seterr' extra parameter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
if. 0~: cContainer do. return. end.
pasij=. <. {.@(0&".)&> args
vbox=. gtk_bin_get_child <cWindow
g=. gtk_container_get_children <vbox
align1=. 0
for_i. i. g_list_length <g do.
  align1=. g_list_nth_data g ;< i
  if. g_type_check_instance_is_a align1 ;< gtk_alignment_get_type '' do. break. end.
end.
assert. 0~:align1
g_list_free <g
((>libgobject), ' g_object_set ', gtkcv, 'n x *c x *c x x')&cd align1 ; 'right-padding'; ({.D2P pasij) ; 'bottom-padding'; ({:D2P pasij) ;< 0
)

wdpc=: 3 : 0
pcstyle=. ;:'nomenu nomin nomax nosize dialog owner closeok'
args=. shiftargs''
if. 0= #args do. seterr 'bad id : ' return. end.
styles=. ~. }.args [ id=. >@{.args
if. 0 e. styles e. pcstyle do. seterr 'bad style : ' return. end.
style=. 0
closeok=. (<'closeok') e. styles
owner=. (<'owner') e. styles
for_s. styles do.
  style=. style (23 b.) <. 2 ^ s i.~ pcstyle
end.
if. 0= cContainer do.
  window=. gtk_window_new GTK_WINDOW_TOPLEVEL
  gtk_window_set_title window ; id
  if. 3>GTKVER_j_ do.
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x *c x x')&cd window ; 'allow-shrink'; 1 ; 'resizable' ; 1 ;< 0
  end.
  vbox1=. gtk_vbox_new 0 0
  gtk_widget_show <vbox1
  gtk_container_add window ;< vbox1
  align1=. gtk_alignment_new (1.1-1.1) ; (1.1-1.1) ; (1+1.1-1.1) ; (1+1.1-1.1)
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c f *c f *c f *c f *c x *c x *c x *c x x')&cd align1 ; 'xalign'; (1.1-1.1) ; 'yalign' ; (1.1-1.1) ; 'xscale'; (1+1.1-1.1) ; 'yscale' ; (1+1.1-1.1) ; 'bottom-padding'; 0 ; 'left-padding' ; 0 ; 'right-padding'; 0 ; 'top-padding' ; 0 ;< 0
  gtk_widget_show <align1
  gtk_box_pack_start vbox1 ; align1 ; 1 ; 1 ;< 0
  fixed1=. gtk_fixed_new ''
  gtk_widget_show <fixed1
  gtk_container_add align1 ; fixed1
  acl=. gtk_accel_group_new ''
  gtk_window_add_accel_group window ;< acl
  consig window ; 'grab-focus' ; 'window_grab_focus'
  consig3 window ; 'key-press-event' ; 'window_key_press'
  consig3 window ; 'configure-event' ; 'window_configure'
  consig window ; 'realize' ; 'window_realize'
  consig3 window ; 'delete-event' ; 'window_delete'
  consig window;'destroy';'window_destroy'
else.
  if. 0= cWindow do. seterr 'no parent selected : ' return. end.
  npage=. gtk_notebook_get_n_pages <cContainer
  for_i. i.npage do.
    if. 0~: page=. gtk_notebook_get_nth_page cContainer ;< i do.
      if. 0~: g=. gtk_container_get_children <page do.
        g_list_free <g
      else.
        cContaineri=: i break.
      end.
    end.
  end.
  if. _1&= cContaineri do. seterr 'todomsg4 : ' return. end.
  if. 0&= fixed1=. gtk_notebook_get_nth_page cContainer ;< cContaineri do.
    seterr 'todomsg5 : ' return.
  end.
end.
if. 0= cContainer do.
  windowList=: windowList, window ; id ; (jloc '') ; '' ; 0 ; 0 ; cFontdef ; 0 ; (,0) ; (,0) ; 0 ; acl ; 0 0 0 0 ; (owner{0, cWindow) ; 0 ; closeok
  if. owner *. 0~:cWindow do. gtk_widget_set_sensitive cWindow, 0 end.
  cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: window
else.
  cSubform=: id
  subformList=: subformList, (cWindow ; cContainer ; id ; fixed1)
end.
)

wdpcenter=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr' extra parameter : ' return. end.
gtk_window_set_position cWindow ;< GTK_WIN_POS_CENTER
)

wdpclose=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr' extra parameter : ' return. end.
gtk_widget_destroy <cWindow
)

wdpgroup=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 1> #args=. shiftargs'' do. seterr'bad id : ' return.
elseif. 1< #args do. seterr' extra parameter : ' return.
end.
s=. 0{::args
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  windowList=: (<s) (<(handle i. cWindow) ; WindowListPgroup) } windowList
else.
  assert. 0
end.
)

wdpmove=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 4> #args=. shiftargs'' do. seterr' bad number : ' return.
elseif. 4< #args do. seterr' extra parameter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> args
gtk_window_move cWindow ; <("0) D2P 2{.xywh
gtk_window_resize cWindow ; <("0) D2P 2}.xywh
gtk_container_resize_children <cWindow
)

wdpmovex=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 4> #args=. shiftargs'' do. seterr' bad number : ' return.
elseif. 4< #args do. seterr' extra parameter : ' return.
end.
if. 0 e. isnum&> args do. seterr 'bad number : ' return. end.
xywh=. <. {.@(0&".)&> args
gtk_window_move cWindow ; <("0) 2{.xywh
gtk_window_resize cWindow ; <("0) 2}.xywh
gtk_container_resize_children <cWindow
)

wdpn=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0=#args=. shiftargs'' do. s=. ''
elseif. 1<#args do. seterr 'extra parameter : ' return.
elseif. 1=#args do. s=. 0{::args
end.
gtk_window_set_title cWindow ;< s
)

wdpsel=: 3 : 0
if. 0= #args=. shiftargs'' do. cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: cWindow=: 0 return.
elseif. 1<#args do. seterr 'extra parameter : ' return.
elseif. 1=#args do. id=. 0{::args
end.
if. 0= #windowList do. return. end.
if. '_0123456789' e.~ {.id do.
  if. (w=. 0&". id) -.@e. (>WindowListHandle{"1 windowList) do. seterr 'bad id : ' return. end.
  if. w~: cWindow do.
    cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: w
  end.
else.
  if. 0~: checkbadname id do. seterr 'bad id : ' return. end.
  if. (<id) -.@e. (WindowListId{"1 windowList) do. seterr 'bad id : ' return. end.
  w=. (>WindowListHandle{"1 windowList){~ (<id) i.~ (WindowListId{"1 windowList)
  if. w~: cWindow do.
    cSubform=: '' [ cSetFont=: '' [ cContainer=: cRadio=: cChild=: 0 [ cWindow=: w
  end.
end.
)

showStyle=: ;:'sw_hide sw_minimize sw_restore sw_show sw_showmaximized sw_showminimized sw_showminnoactive sw_showna sw_shownoactivate sw_shownormal'
wdpshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0=#args=. shiftargs'' do. style=. 'sw_shownormal'
elseif. 1<#args do. seterr 'extra parameter : ' return.
elseif. do. style=. 0{::args
end.
select. style
case. 'sw_hide' do. gtk_widget_hide <cWindow return.
case. 'sw_maximize' do. gtk_window_maximize <cWindow
case. 'sw_minimize' do. gtk_window_iconify <cWindow
case. 'sw_restore' do. gtk_window_present <cWindow
case. 'sw_show' do. ''
case. 'sw_showmaximized' do. gtk_window_maximize <cWindow
case. 'sw_showminimized' do. gtk_window_iconify <cWindow
case. 'sw_showminnoactive' do. gtk_window_iconify <cWindow
case. 'sw_showna' do. ''
case. 'sw_shownoactive' do. ''
case. 'sw_shownormal' do. ''
case. do. seterr 'bad style : ' return.
end.
if. 'sw_show'-:7{.style do.
  gtk_widget_show_all <cWindow
end.
if. (<style) e. ;:'sw_restore sw_show sw_shownormal sw_showmaximized sw_showminimized' do.
  if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
    windowList=: (<activeidx=: >:activeidx) (<(handle i. cWindow) ; WindowListActiveidx) } windowList
  else.
    assert. 0
  end.
end.
)

wdptop=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1< #args do. seterr' extra parameter : ' return.
elseif. do. s=. 0{::args
end.
if. 0 e. isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
flag=. flag > TileWM
gtk_window_set_keep_above cWindow ;< flag
)

wdqformx=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
gtk_window_get_position cWindow ; (x=. ,_1) ; (y=. ,_1)
gtk_window_get_size cWindow ; (w=. ,_1) ; (h=. ,_1)
": x,y,w,h
)

wdqhwndp=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
":cWindow
)
form_realize=: 4 : 0
'widget event data'=. y
menuList=: (widget ~: >0{"1 menuList)#menuList
toolbarList=: (widget ~: >0{"1 toolbarList)#toolbarList
statusbarList=: (widget ~: >0{"1 statusbarList)#statusbarList
childList=: (widget ~: >0{"1 childList)#childList
glxList=: (widget ~: >GLXLISTPARENT{"1 glxList)#glxList
windowList=: (widget ~: >WindowListHandle{"1 windowList)#windowList
0
)
wd=: 3 : 0
z=. ''
wdptr0=: 0
while. #y do.
  if. 0<s1=. clws y do.
    wdptr0=: wdptr0 + s1
    y=. s1}. y continue.
  end.
  s=. y e. ';'
  a=. y e. '*'
  q=. 2| +/\ y e. '"'
  d=. 2| +/\ y e. DEL
  s=. s *. -.q+.d
  a=. a *. -.q+.d
  if. (1 e. a) *. 1 e. s do.
    s1=. {.I.s [ a1=. {.I.a
    if. s1<a1 do.
      z=. wd1 s1{.y
      wdptr0=: wdptr0 + 1 + s1
      y=. (1+s1)}. y continue.
    else.
      z=. wd1 y break.
    end.
  elseif. 1 e. s do.
    s1=. {.I.s
    z=. wd1 s1{.y
    wdptr0=: wdptr0 + 1 + s1
    y=. (1+s1)}. y continue.
  elseif. do.
    z=. wd1 y break.
  end.
end.
z
)

wd1=: 3 : 0
if. 0=#y do. '' return. end.
smoutput^:(1<Debugwd) y
wdptr=: 0 [ wdstr=: y
t=. EMPTY
if. (<'qer') -.@e.~ cmd=. shiftarg'' do. LASTCMD=: y [ WDERRN=: 0 end.
select. cmd
case. 'beep' do. wdbeep ''
case. 'cc' do. wdcc ''
case. 'clipcopy' do. wdclipcopy ''
case. 'clippaste' do. t=. wdclippaste ''
case. 'cn' do. wdcn ''
case. 'creategroup' do. wdcreategroup ''
case. 'fontdef' do. wdfontdef ''
case. 'mb' do. t=. wdmb ''
case. 'mbcolor' do. t=. ": 51$255
case. 'mbfont' do. t=. ''
case. 'mbopen' do. t=. wdmbopen ''
case. 'mbprinter' do. t=. wdmbprinter ''
case. 'mbsave' do. t=. wdmbsave ''
case. 'menu' do. wdmenu ''
case. 'menupop' do. wdmenupop ''
case. 'menupopz' do. wdmenupopz ''
case. 'menusep' do. wdmenusep ''
case. 'pactive' do. wdpactive ''
case. 'pas' do. wdpas ''
case. 'pc' do. wdpc ''
case. 'pcenter' do. wdpcenter ''
case. 'pclose' do. wdpclose ''
case. 'pgroup' do. wdpgroup ''
case. 'pmove' do. wdpmove ''
case. 'pmovex' do. wdpmovex ''
case. 'pn' do. wdpn ''
case. 'psel' do. wdpsel ''
case. 'pshow' do. wdpshow ''
case. 'ptop' do. wdptop ''
case. 'qchildxywh' do. t=. wdqchildxywh ''
case. 'qchildxywhx' do. t=. wdqchildxywhx ''
case. 'qcolor' do. t=. wdqcolor ''
case. 'qd' do. t=. wdqd ''
case. 'qer' do. t=. wdqer ''
case. 'qformx' do. t=. wdqformx ''
case. 'qhwndc' do. t=. wdqhwndc ''
case. 'qhwndp' do. t=. wdqhwndp ''
case. 'qiox' do. t=. wdqiox ''
case. 'qm' do. t=. wdqm ''
case. 'qp' do. t=. wdqp ''
case. 'qprinters' do. t=. wdqprinters ''
case. 'qpx' do. t=. wdqpx ''
case. 'qscreen' do. t=. wdqscreen ''
case. 'qwd' do. t=. wdqwd ''
case. 'rem' do. ''
case. 'reset' do. wdreset ''
case. 'sbar' do. wdsbar ''
case. 'sbarset' do. wdsbarset ''
case. 'sbarshow' do. wdsbarshow ''
case. 'set' do. wdset ''
case. 'setcaption' do. wdsetcaption ''
case. 'setdelete' do. wdsetdelete ''
case. 'setedit' do. wdsetedit ''
case. 'setenable' do. wdsetenable ''
case. 'setfocus' do. wdsetfocus ''
case. 'setfont' do. wdsetfont ''
case. 'setinsert' do. wdsetinsert ''
case. 'setinvalid' do. wdsetinvalid ''
case. 'setlimit' do. wdsetlimit ''
case. 'setlocale' do. wdsetlocale ''
case. 'setmodified' do. wdsetmodified ''
case. 'setreadonly' do. wdsetreadonly ''
case. 'setreplace' do. wdsetreplace ''
case. 'setscroll' do. wdsetscroll ''
case. 'setselect' do. wdsetselect ''
case. 'setshow' do. wdsetshow ''
case. 'setxywh' do. wdsetxywh ''
case. 'setxywhx' do. wdsetxywhx ''
case. 'tbar' do. wdtbar ''
case. 'tbarset' do. wdtbarset ''
case. 'tbarshow' do. wdtbarshow ''
case. 'timer' do. wdtimer ''
case. 'xywh' do. wdxywh ''
case. ,'q' do. t=. wdq ''
case. 'setwrap' do. wdsetwrap ''
case. ;:'setbkgnd' do. ''
case. ;:'smcolor smkeywords smsetlog' do. ''
case. 'sminputlog' do. t=. ''
case. ;:'oleget olegetlic oleinfo' do. t=. ''
case. ;:'oledlg oleenable oleid oleload olemethod olemethodx oleocx olerelease olesave oleset olesetlic' do. ''
case. ;:'qhinst qhwndx qkeystate qrtf' do. t=. ''
case. ;:'clipcopyx clippastex msgs pcolor picon security setcolor setcolwidth setpclip setupdate settabstops tnomsgs wait' do. ''

case. do. seterr 'invalid command : '
end.
if. ((<'qer') -.@e.~ cmd) *. 0~:WDERRN do. 13!:8[3 end.
(EMPTY-:t){::t;''
)
session_printer=: ''
wdqprinters=: 3 : 0
if. 0~: #args=. shiftargs'' do. seterr 'extra parameter : ' return. end.
if. 0= #prn=. gtk_qprinters'' do. session_printer=: '' return. end.
ses=. {.prn
if. #session_printer do. ses=. <session_printer end.
; (ses,prn) ,&.> <LF
)

wdmbprinter=: 3 : 0
if. 0= #args=. shiftargs'' do. opt=. ''
elseif. 1= #args do. opt=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. (<opt) -.@e. '';'pd_pagesetup' do. seterr 'bad style : ' return. end.
if. 1= cairo_printer_dialog_jglcanvas_ '' do.
  session_printer=: cairo_settings_printer_jglcanvas_ ''
else.
  ''
end.
)
wdsbar=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad number : ' return.
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  if. 0~: {. sb=. (handle i. cWindow){ >WindowListStatusbar{"1 windowList do. seterr 'command failed : ' return. end.
else.
  assert. 0
end.
if. -.@isnum s=. >@{.args do. seterr 'bad number : ' return. end.
if. 0>: count=. {.@(0&".) s do. seterr 'bad number : ' return. end.
vbox1=. gtk_bin_get_child <cWindow
sbarwin=. ((>libgobject), ' g_object_new ', gtkcv, 'x x *c x *c x x')&cd ( gtk_hbox_get_type '') ; 'spacing' ; 2 ; 'visible' ; 0 ;< 0
gtk_widget_show <sbarwin
for_i. i. count do.
  st=. gtk_statusbar_new ''
  gtk_widget_show <st
  gtk_box_pack_start sbarwin ; st ; ((i=0){0 1) ; ((i=0){0 1) ;< 0
end.
gtk_box_pack_end vbox1 ; sbarwin ; 0 ; 0 ;< 0
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  windowList=: (<sbarwin, count, 0) (<(handle i. cWindow) ; WindowListStatusbar) } windowList
else.
  assert. 0
end.
)
wdsbarset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 1= #args do. seterr 'bad number : ' return.
elseif. 3< #args do. seterr 'extra parameter : ' return.
end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  if. 0= {. sb=. (handle i. cWindow){ >WindowListStatusbar{"1 windowList do. seterr 'command failed : ' return. end.
else.
  assert. 0
end.
if. 0~: checkbadname id=. >@{.args do. seterr 'bad id : ' return. end.
if. -.@isnum awidth=. 1{::args do. seterr 'bad number : ' return. end.
width=. {.@(0&".) awidth
txt=. >@{.2}.args
'sbarwin count next'=. 3{.sb
if. 0> width do.
  if. 1 e. ls=. (cWindow = >{."1 statusbarList) *. (2{"1 statusbarList) e. <id do.
    window=. 1{::({.I.ls){statusbarList
    msgid=. gtk_statusbar_push window ; 0 ;< txt
  else.
    seterr 'bad id : ' return.
  end.
else.
  if. count<:next do. seterr 'bad number : ' return. end.
  g=. gtk_container_get_children <sbarwin
  window=. g_list_nth_data g ;< next
  gtk_statusbar_pop window ;< 0
  msgid=. gtk_statusbar_push window ; 0 ;< txt
  if. 0~:next do.
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd window ; 'width-request' ; (D2P width) ;< 0
  end.
  g_list_free <g
  if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
    windowList=: (<sbarwin, count, >:next) (<(handle i. cWindow) ; WindowListStatusbar) } windowList
  else.
    assert. 0
  end.
  statusbarList=: statusbarList, cWindow ; window ; id
end.
)
wdsbarshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1< #args do. seterr 'extra parameter : ' return.
elseif. do. s=. >@{.args
end.
if. cWindow e. handle=. >WindowListHandle{"1 windowList do.
  if. 0= sbarwin=. {. sb=. (handle i. cWindow){ >WindowListStatusbar{"1 windowList do. seterr 'command failed : ' return. end.
else.
  assert. 0
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd sbarwin ; 'visible' ; flag ;< 0
)
wdtbar=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs '' do. seterr 'bad filename : ' return.
elseif. 3< #args do. seterr 'extra parameter : ' return.
end.
fn=. >@{.args
count=. _1
if. 1< #args do.
  s=. 1{::args
  if. -.@isnum s do. seterr 'bad number : ' return. end.
  count=. {.@(0&".) s
end.
style=. ''
if. 2< #args do.
  style=. 2{::args
  if. 'tbstyle_flat' -.@-: style do. seterr 'bad style : ' return. end.
end.
if. _1~: idx=. windowlistidx cWindow do.
  if. 0~: tbarwin=. WindowListToolbar{::idx{windowList do. seterr 'command failed : ' return. end.
  mn=. WindowListMenubar{:: idx{windowList
else.
  seterr 'no parent selected : ' return.
end.
if. 0~: tbimg=. (<idx, WindowListTbimg) {:: windowList do. seterr 'command failed : ' return. end.
if. 0~: pix=. gdk_pixbuf_new_from_file fn ;< 0 do.
  w=. gdk_pixbuf_get_width <pix
  h=. gdk_pixbuf_get_height <pix
  if. -. (0=16|w) do. seterr 'picture width not 16x : ' return. end.
  tbimg=. pix
  assert. 0~:tbimg
else.
  seterr 'wrong file type : ' return.
end.
tbarwin=. gtk_toolbar_new ''
((>libgobject), ' g_object_set ', gtkcv, 'n x *c x *c x x')&cd tbarwin ; 'visible' ; 0 ; 'toolbar-style' ; GTK_TOOLBAR_ICONS ;< 0
vbox1=. gtk_bin_get_child <cWindow
gtk_box_pack_start vbox1 ; tbarwin ; 0 ; 0 ;< 0
gtk_box_reorder_child vbox1 ; tbarwin ;< (0={.mn){1 0
gtk_widget_show <tbarwin
windowList=: (<tbimg) (<idx, WindowListTbimg) } windowList
windowList=: (<tbarwin) (<idx, WindowListToolbar) } windowList
)
wdtbarset=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. seterr 'bad id : ' return.
elseif. 3> #args do. seterr 'bad number : ' return.
elseif. 5< #args do. seterr 'extra parameter : ' return.
end.
if. _1~: idx=. windowlistidx cWindow do.
  if. 0= tbarwin=. WindowListToolbar{:: idx{windowList do. seterr 'no control bar : ' return. end.
else.
  seterr 'command3 failed : ' return.
end.
id=. >@{.args
if. 0 e. isnum&> 2{. }.args do. seterr 'bad number : ' return. end.
'index image'=. {.@(0&".)&> 2{. }.args
'statushelp tooltip'=. 2{. 3}.args
if. 0=#id do.
  window=. gtk_separator_tool_item_new ''
else.
  window=. ((>libgobject), ' g_object_new ', gtkcv, 'x x x')&cd ( gtk_tool_button_get_type '') ;< 0
  if. '' -.@-: tooltip do.
    gtk_widget_set_tooltip_text window ; tooltip
  end.
  if. 0~:tbimg=. (<idx, WindowListTbimg){:: windowList do.
    w=. gdk_pixbuf_get_width <tbimg
    h=. gdk_pixbuf_get_height <tbimg
    if. w<16*image do. seterr 'picture too narrow : ' return. end.
    pix=. gdk_pixbuf_new_subpixbuf tbimg ; (16*image) ; 0 ; 16 ;< h

    icon=. gtk_image_new_from_pixbuf <pix
    gtk_widget_show <icon
    ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd window ; 'icon-widget' ; icon ;< 0
    g_object_unref <pix
  else.
    seterr 'command failed : ' return.
  end.
  consig window ; 'clicked' ; 'toolbar_clicked_event'
end.
gtk_toolbar_insert tbarwin ; window ;< _1
gtk_widget_show <window
if. 0~:#id do.
  toolbarList=: toolbarList, cWindow ; window ; id ; index ; image
end.
)
wdtbarshow=: 3 : 0
if. 0= cWindow do. seterr 'no parent selected : ' return. end.
if. 0= #args=. shiftargs'' do. s=. ,'1'
elseif. 1= #args do. s=. >@{.args
elseif. 1< #args do. seterr 'extra parameter : ' return.
end.
if. _1~: idx=. windowlistidx cWindow do.
  if. 0= tbarwin=. WindowListToolbar{:: idx{windowList do. seterr 'no control bar : ' return. end.
else.
  seterr 'no parent selected : ' return.
end.
if. -.@isnum s do. seterr 'bad number : ' return. end.
if. 0 1 -.@e.~ flag=. {.@(0&".) s do. seterr 'bad number : ' return. end.
((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd tbarwin ; 'visible' ; flag ;< 0
)
D2P=: +:
P2D=: <.@-:

isnum=: 3 : 0
if. '-_0123456789' e.~ {.y do.
  try.
    if. 0~:$$a=. ".y do.
      0
    else.
      1 4 8 e.~ (3!:0) a
    end.
  catch. 0 end.
else.
  0
end.
)
windowlistidx=: 3 : 0
window=. y
z=. _1
if. 0= #windowList do. z return. end.
if. window e. ls=. >WindowListHandle{"1 windowList do.
  z=. ls i. window
end.
z
)
dlws=: 3 : 0
y }.~ +/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)
clws=: 3 : 0
+/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)
shiftarg=: 3 : 0
if. (#wdstr) = wdptr=: wdptr + clws wdptr}. wdstr do. '' return. end.
y=. wdptr}.wdstr
b=. y e. ' '
a=. y e. '*'
q=. 2| +/\ y e. '"'
d=. 2| +/\ y e. DEL
b=. b *. -.q+.d
a=. a *. -.q+.d
if. 1={.a do.
  z=. }.y
  wdptr=: #wdstr
elseif. (1={.d)+.(1={.q) do.
  p2=. 1+ (}.y) i. {.y
  z=. }.p2{.y
  wdptr=: wdptr+ p2+1
elseif. 1 e. b do.
  p2=. {.I.b
  z=. p2{.y
  wdptr=: wdptr+ 1+p2
elseif. do.
  z=. y
  wdptr=: #wdstr
end.
<z
)
shiftargs=: 3 : 0
z=. 0$<''
while. wdptr < #wdstr do. z=. z, shiftarg'' end.
z
)

seterr=: 3 : 0
WDERR=: y [ WDERRN=: 3
smoutput^:(0<Debugwd) '**ERROR: ', y
smoutput^:(0<Debugwd) wdstr
if. 2<Debugwd do. 13!:8[3 end.
EMPTY
)
setbuttonimage=: 3 : 0
'window image s'=. y
if. ''-: s do. return. end.
if. _1&~: {. alloc=. getGtkWidgetAllocation image do.
  wh=. _2{. alloc
  'w h'=. 1 >. wh
else.
  if. _1&~: {. alloc=. getGtkWidgetAllocation window do.
    wh=. _2{. alloc
  else.
    wh=. _2{. getAllocation window
  end.
  'w h'=. 1 >. _12 _3 + wh
end.
if. 0~: pix=. gdk_pixbuf_new_from_file_at_size s ; w ; h ;< 0 do.
  ((>libgobject), ' g_object_set ', gtkcv, 'n x *c x x')&cd image ; 'pixbuf' ; pix ;< 0
  g_object_unref <pix
end.
)

getAllocation=: 3 : 0
widget=. y
_1 _1, w,h [ gtk_widget_get_size_request widget ; (w=. ,_1) ; (h=. ,_1)
)

delcchild=: 4 : 0
parent=. x
widget=. y
if. 0= #childList do. return. end.
childList=: (widget ~: >1{"1 childList)#childList
)
getcchild=: 4 : 0
parent=. x
id=. ,y
z=. 0
if. 0= #childList do. z return. end.
if. #winid=. (parent = >{."1 childList)#(1 2{"1 childList) do.
  z=. (0,~ >{."1 winid) {~ ((<id),~ {:"1 winid) i. <id
end.
z
)
getcchildid=: 3 : 0
widget=. y
if. _1= ix=. getcchildidx widget do. '' return. end.
2{:: ix{childList
)

getcchildclass=: 3 : 0
widget=. y
if. _1= ix=. getcchildidx widget do. _1 return. end.
3{:: ix{childList
)
getcchildidx=: 3 : 0
widget=. y
z=. _1
if. 0= #childList do. z return. end.
if. widget e. ls=. >1{"1 childList do.
  z=. ls i. widget
end.
z
)
getcparent=: 3 : 0
widget=. y
if. 0= #windowList do. 0 return. end.
if. _1= ix=. getcchildidx widget do. 0 return. end.
0{:: ix{childList
)

getccontaineridx=: 3 : 0
widget=. y
z=. _1
if. 0= #containerList do. z return. end.
if. widget e. ls=. >1{"1 containerList do. z=. ls i. widget end.
z
)

getmenu=: 4 : 0
parent=. x
id=. y
if. 0= #menuList do. 0 return. end.
rz=. {. (>1{"1 menuList) #~ (parent = >{."1 menuList) *. ((<id) = 2{"1 menuList)
)

gettoolbar=: 4 : 0
parent=. x
id=. y
if. 0= #toolbarList do. 0 return. end.
rz=. {. (>1{"1 toolbarList) #~ (parent = >{."1 toolbarList) *. ((<id) = 2{"1 toolbarList)
)

getstatusbar=: 4 : 0
parent=. x
id=. y
if. 0= #statusbarList do. 0 return. end.
rz=. {. (>1{"1 statusbarList) #~ (parent = >{."1 statusbarList) *. ((<id) = 2{"1 statusbarList)
)

checkbadname=: 3 : 0
rz=. 1
if. ({.y) e. a.{~(65+i.26),(97+i.26) do.
  rz=. 0 e. (}.y) e. '0123456789', a.{~(65+i.26),(97+i.26)
end.
rz
)

getchildwh=: 3 : 0
widget=. y
wh=. _1 _1
if. _1= {. wh=. _2{. getGtkWidgetAllocation widget do.
  wh=. _2{. getGtkWidgetGeometry widget
end.
wh
)
getchildxy=: 3 : 0
widget=. y
if. _1= {. xy=. 2{. getGtkWidgetAllocation widget do.
  if. _1= {. xy=. 2{. getGtkWidgetGeometry widget do. xy return. end.
end.
while. (0= gtk_widget_is_toplevel widget) *. (0= g_type_check_instance_is_a widget, gtk_fixed_get_type '') *. 0~: widget=. gtk_widget_get_parent widget do.
  if. _1= {. xy1=. 2{. getGtkWidgetAllocation widget do.
    xy1=. 0 >. 2{. getGtkWidgetGeometry widget
  end.
  xy=. xy + xy1
end.
xy
)
getchildwin=: 3 : 0
widget=. win=. y
while. (0= gtk_widget_is_toplevel widget) *. (0= g_type_check_instance_is_a widget, gtk_fixed_get_type '') *. 0~: widget=. gtk_widget_get_parent widget do.
  win=. widget
end.
win
)
getlocgl2=: 3 : 0
z=. 0$<''
if. 0= #windowList do. z return. end.
if. 0= #childList do. z return. end.
if. ({.y) e. '_0123456789' do.
  widget=. {. 0".y
else.
  widget=. cWindow getcchild y
end.
if. _1= ix=. getcchildidx widget do. z return. end.
'parent userdata'=. (0,ChildListUserdata){ix{childList
assert. parent e. >@{."1 windowList
assert. 0< #userdata
cWindow=: parent
z=. boxxopen userdata
)
cleanup=: 3 : 0
wdqdata=: 0 0$0
WDERR=: ''
WDLOC=: 'base'
sysmodifiers=: ,'0'
sysdata=: ''
lasterrcmd=: lastcmd=: ''
cWindow=: 0
cChild=: 0
cRadio=: 0
cContainer=: 0
cContaineri=: _1
cSubform=: ''
windowList=: 0 16$<''
containerList=: 0 3$<''
subformList=: 0 4$<''
childList=: 0 12$<''
menuList=: 0 4$<''
toolbarList=: 0 5$<''
statusbarList=: 0 3$<''
glxList=: 0 14$<''
activeidx=: 0
cxywh=: 0 0 100 100
cFontdef=: ''
cSetFont=: ''
tbimg=: 0
if. 0~:systimerid do. systimerid=: 0 [ g_source_remove systimerid end.
systimerid=: timerdelay=: 0
)

resizechild=: 4 : 0
'wh wh0'=. 1 >. 2 2$x
assert. 0~:y
parent=. y
scr=. gdk_screen_get_default ''
w=. gdk_screen_get_width <scr
h=. gdk_screen_get_height <scr
wh=. wh <. whs=. w,h
vbox=. gtk_bin_get_child <parent
whv=. whs <. _2{. getGtkWidgetAllocation vbox
g=. gtk_container_get_children <vbox
align1=. 0
for_i. i. g_list_length <g do.
  align1=. g_list_nth_data g ;< i
  if. g_type_check_instance_is_a align1 ;< gtk_alignment_get_type '' do. break. end.
end.
assert. 0~:align1
g_list_free <g
fixed1=. gtk_bin_get_child <align1
assert. 0~:fixed1
whf=. whs <. _2{. getGtkWidgetAllocation fixed1
fixed1wh=. wh=. wh - 0 >. whv - whf
minpad=. 0

chg=. 0
for_wx. ((0&~: >4{"1 childList) *. (0= >6{"1 childList) *. (parent = >{."1 childList))#childList do.
  'parent window id iclass stylen hide container subform xywh0 '=. 9{.wx
  'cx cy cw ch'=. 'cx0 cy0 cw0 ch0'=. xywh0
  ex=. ex0=. cx0 + cw0
  ey=. ey0=. cy0 + ch0
  W0=. {.wh0 [ H0=. {:wh0
  W=. {.wh [ H=. {:wh
  (FMSTYLE)=. |. (8#2) #: stylen
  if. leftmove do. cx=. cx0 + (W-W0) end.
  if. leftscale do. cx=. <. cx0 * W%W0 end.
  if. rightmove do. ex=. (W-minpad) <. (cx0+cw0) + (W-W0) end.
  if. rightscale do. ex=. (W-minpad) <. <. W - (W0 - cx0+cw0) * W%W0 end.

  if. topmove do. cy=. cy0 + (H-H0) end.
  if. topscale do. cy=. <. cy0 * H%H0 end.
  if. bottommove do. ey=. (H-minpad) <. (cy0+ch0) + (H-H0) end.
  if. bottomscale do. ey=. (H-minpad) <. <. H - (H0 - cy0+ch0) * H%H0 end.

  cw=. 0 >. ex - cx
  ch=. 0 >. ey - cy
  if. +./ 2 < | xywh0 - cx,cy,cw,ch do.
    win=. getchildwin window
    gtk_fixed_move fixed1 ; win ; cx ;< cy
    gtk_widget_set_size_request win ; cw ;< ch
    chg=. 1
  end.
end.
if. 1=chg do. gtk_container_resize_children <parent end.
chg=. 0
for_wx. ((0&~: >4{"1 childList) *. (0~: >6{"1 childList) *. (parent = >{."1 childList))#childList do.
  'parent window id iclass stylen hide container subform xywh0 '=. 9{.wx

  if. _1= ix=. getccontaineridx container do. continue. end.
  wh0=. 2{:: ix{containerList
  if. 1 e. f=. (container = >1{"1 subformList) *. (<subform) = 2{"1 subformList do.
    fixed1=. 3{:: ({.I.f){subformList
  else.
    continue.
  end.
  wh=. fixed1wh <. _2{. getGtkWidgetAllocation fixed1
  (FMSTYLE)=. |. (8#2) #: stylen

  'cx cy cw ch'=. 'cx0 cy0 cw0 ch0'=. xywh0
  ex=. ex0=. cx0 + cw0
  ey=. ey0=. cy0 + ch0
  W0=. {.wh0 [ H0=. {:wh0
  W=. {.wh [ H=. {:wh

  if. leftmove do. cx=. cx0 + (W-W0) end.
  if. leftscale do. cx=. <. cx0 * W%W0 end.
  if. rightmove do. ex=. (W-minpad) <. (cx0+cw0) + (W-W0) end.
  if. rightscale do. ex=. (W-minpad) <. <. W - (W0 - cx0+cw0) * W%W0 end.

  if. topmove do. cy=. cy0 + (H-H0) end.
  if. topscale do. cy=. <. cy0 * H%H0 end.
  if. bottommove do. ey=. (H-minpad) <. (cy0+ch0) + (H-H0) end.
  if. bottomscale do. ey=. (H-minpad) <. <. H - (H0 - cy0+ch0) * H%H0 end.

  cw=. 0 >. ex - cx
  ch=. 0 >. ey - cy
  if. +./ 2 < | xywh0 - cx,cy,cw,ch do.
    win=. getchildwin window
    gtk_fixed_move fixed1 ; win ; cx ;< cy
    gtk_widget_set_size_request win ; cw ;< ch
    chg=. 1
  end.
end.
if. 1=chg do. gtk_container_resize_children <parent end.
)
18!:4 <'z'
wd_z_=: 3 : 0"1
if. gtkInitDone_jgtk_ do.
  wd_gtkwd_ y [ WDLOC_gtkwd_=: >coname''
else.
  ''
end.
)
wdreset=: wd bind 'reset'
wdclipread=: toJ @ wd bind 'clippaste'
wdbox=: 3 : 0
whs=. 8 9 10 13 32{a.
del=. 127{a.
dat=. ' ',y
msk=. ~:/\ dat e. del
mqt=. 2: +./\ 0: , 2: | +/\ @ (=&'"')
mquote=. -. mqt dat
msk=. mquote *. msk
ndx=. 1 i.~ msk < dat='*'
end=. < }. ndx }. dat
dat=. ndx{.dat
msk=. mquote *.(ndx {. msk) < dat e. whs
dat=. (msk <;._1 dat) , end
a: -.~ dat -. each <del
)
wdcenter=: 3 : 0
'fx fy fw fh'=. 0&". :: ] y
'sx sy'=. sxy=. 2 {. 0 ". wd 'qm'
'w h'=. sxy <. _2 {. 0 ". wd 'qformx'
x=. 0 >. (sx-w) <. fx + <. -: fw-w
y=. 0 >. (sy-h) <. fy + <. -: fh-h
wd 'pmovex ',": x,y,w,h
)
wdclipwrite=: 3 : 0
txt=. y
if. L. txt do.
  txt=. }. ; (LF&, @ , @ ": each) txt
else.
  txt=. ": txt
  if. 1 < #$txt do. txt=. }. , LF,"1 txt end.
end.
wd 'clipcopy *',toHOST txt
#txt
)
wde=: 3 : 0
try. res=. wd y
catch.
  err=. wd 'qer'
  ndx=. >: err i. ':'
  msg=. ndx {. err
  pos=. {.". ndx }. err
  cmd=. (>:j i.';') {. j=. pos}.y
  if. 50 < #cmd do.
    cmd=. (47{.cmd),'...' end.
  wdinfo 'Window Driver';'wd error ',msg,LF,cmd
  wderr=. 13!:8@1:
  wderr ''
end.
)
wdfit=: 3 : 0
'mx my'=. 2{.y,(#y)}.1 1
'x y w h'=. 0 ". wd 'qformx'
'fx fy zx zy yc ym sx sy sw sh'=. 6 }. 0 ". wd 'qm'

select. mx
case. 0 do.
  w=. w - 0 <. sx - x
  x=. x >. sx
  w=. 0 >. w <. sx + sw - x
case. 1 do.
  x=. sx >. x <. (sx+sw) - w
  w=. 0 >. w <. sx + sw - x
case. 2 do.
  x=. sx
  w=. sw
case. 3 do.
  x=. - fx
  w=. sw + 2 * fx
end.

select. my
case. 0 do.
  h=. h - 0 <. sy - y
  y=. y >. sy
  h=. 0 >. h <. sy + sh - y
case. 1 do.
  y=. sy >. y <. (sy+sh) - h
  h=. 0 >. h <. sy + sh - y
case. 2 do.
  y=. sy
  h=. sh
case. 3 do.
  y=. - yc + fy
  h=. sh + yc + 2 * fy
end.

wd 'pmovex ',":x,y,w,h
)
wdforms=: 3 : 0
if. 0=# z=. <;._2;._2 @ wd 'qpx' do. z=. 0 6$<'' end.
z
)
wdget=: 4 : 0
nms=. {."1 y
vls=. {:"1 y
if. L. x do. vls {~ nms i. ,&.>x
else. > vls {~ nms i. <,x
end.
)

SYSPPC=: (<'syschild'),.'ppcnext';'ppcprevious'
wdhandler=: 3 : 0
wdq=: wd 'q'
wd_val=. {:"1 wdq
({."1 wdq)=: wd_val
if. 3=4!:0<'wdhandler_debug' do.
  try. wdhandler_debug'' catch. end.
end.
wd_ndx=. 1 i.~ 3 = 4!:0 [ 3 {. wd_val
if. 3 > wd_ndx do.
  wd_fn=. > wd_ndx { wd_val
  if. 13!:17'' do.
    wd_fn~''
  else.
    try. wd_fn~''
    catch.
      wd_err=. 13!:12''
      if. 0=4!:0 <'ERM_j_' do.
        wd_erm=. ERM_j_
        ERM_j_=: ''
        if. wd_erm -: wd_err do. i.0 0 return. end.
      end.
      wd_err=. LF,,LF,.}.;._2 wd_err
      wdinfo 'wdhandler';'error in: ',wd_fn,wd_err
    end.
  end.
end.
i.0 0
)
wdinfo=: 3 : 0
'a b'=. _2{. boxopen y
if. 0<Debugwd_gtkwd_ do.
  smoutput b return.
end.
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
empty wd 'mb ',(f a),' ',(f b),' mb_iconinformation'
)
wdisparent=: boxopen e. <;._2 @ wd bind 'qp'
wdishandle=: boxopen e. 1: {"1 wdforms
wdmove=: 3 : 0
'' wdmove y
:
'px py'=. y
'sx sy sw sh'=. 12 13 14 15 { 0 ". wd 'qm'
if. #x do. wd 'psel ',x end.
'x y w h'=. 0 ". wd 'qformx'
if. px < 0 do. px=. sw - w - 1 + px end.
if. py < 0 do. py=. sh - h - 1 + py end.
wd 'pmovex ',": (px+sx),(py+sy),w,h
)
wdpclose=: [: wd :: empty 'psel ' , ,&';pclose'
wdqshow=: 3 : 0
txt=. (>{."1 wdq),.TAB,.>{:"1 wdq
wdinfo 'wdq';(60 <. {:$txt) {."1 txt
)
wdquery=: 3 : 0
0 wdquery y
:
msg=. ;:'okcancel retrycancel yesno yesnocancel abortretryignore'
res=. ;:'OK CANCEL RETRY YES NO ABORT IGNORE'
ndx=. 0 1;2 1;3 4;3 4 1;5 2 6
't d'=. 2{.x [ 'a b'=. _2{. boxopen y
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
m=. 'mb ',(f a),' ',(f b),' mb_iconquestion mb_',>t{msg
if. d e. 1 2 do. m=. m,' mb_defbutton',":>:d end.
(res {~ >t{ndx) i. <wd m
)
wdselect=: 3 : 0
0 wdselect y
:
if. 0=#y do.
  empty wd 'psel wdselect;pclose' return.
end.

'n s e'=. 3{.x

if. 2=L.y do. 'hdr sel'=. y
else. hdr=. '' [ sel=. y
end.

'r c'=. $,.>sel
sel=. ;sel ,each LF

'c r'=. (12,5*6>r) + >. 4 8 * >. c,r
c=. 205 <. 80 >. (4*#hdr) >. c
r=. 128 <. r

if. (<'wdselect') e. <;._2 wd 'qp' do.
  wd 'psel wdselect;pn '",hdr,'";'
else.
  wd 'pc wdselect;pn *',hdr
  wd 'xywh 4 4 ',":c,r
  wd 'cc l0 listbox ws_vscroll rightmove bottommove',s#' lbs_multiplesel'
  wd 'setfont l0 ',PROFONT
  wd 'cc e0 editm; setshow e0 0'
  wd 'xywh ',(":14+c),' 6 36 12;cc ok button leftmove rightmove bottommove;cn "OK";'
  wd 'xywh ',(":14+c),' 21 36 12;cc cancel button leftmove rightmove bottommove;cn "Cancel";'
  wd 'pas 4 2;pcenter;'
end.

wd 'set e0 *',sel
wd 'set l0 *',sel
wd (_1 ~: n) # 'setselect l0 ',":n
wd 'setfocus l0'
wd 'pshow'

while. 1 do.
  wdq=. wd 'wait;q'
  ({."1 wdq)=. {:"1 wdq
  done=. (<'cancel') e. systype;syschild
  button=. systype -: 'button'
  ok=. button *. (<syschild) e. ;:'l0 ok enter'
  if. ok +. done do.
    wd (ok *: e)#'pclose'
    ok;".l0_select
    break.
  end.
end.
)
wdstatus=: 3 : 0
'' wdstatus y
:
if. 0 e. $y do.
  empty wd :: [ 'psel status;pclose'
  return.
end.

msg=. y
if. 2=#$msg=. ":msg do. msg=. }.,LF,.msg
else. msg=. toJ (-LF={:msg)}.msg
end.

pn=. (*#x)#'pn ',DEL,x,DEL,';'

if. (<'status') e. <;._2 wd 'qp;' do.
  wd 'psel status;',pn
else.
  size=. |. 0 100 >. 8 4*$];._2 msg,LF
  wd 'pc status closeok;',pn
  wd 'xywh 10 10 ',(":size),';'
  wd 'cc s0 static;'
  wd 'pas 10 10;pcenter;'
end.

wd 'set s0 *',msg
wd 'pshow;'
)
mbopen=: 3 : 0
jpathsep wd 8 u: 'mbopen ',y
)
mbsave=: 3 : 0
jpathsep wd 8 u: 'mbsave ',y
)
wdformedit=: 3 : 0
require '~addons/gui/gtkwd/formedit.ijs'
y conew 'jformedit'
)

