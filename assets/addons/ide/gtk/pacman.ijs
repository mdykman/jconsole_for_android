coclass 'jpacman'
coinsert 'jgtkide j'

Status=: cutopen 0 : 0
All
Upgrades
Not installed
Installed
)

PackHdr=: '';'Package';'Installed';'Latest';'Caption'
create=: 3 : 0
info=: mbinfo@(SYSNAME&;)
log=: loggui
window=: 0
written=: matched=: 0
DATAMASK=: 0
DATAX=: 0
IFSECTION=: 0
ISGUI=: 1
LOGTXT=: ''
MSGX=: 0
LASTMSG=: ''
SECTION=: ,<'All'
SELNDX=: 0 0
if. -. pmview_init'' do. destroy'' end.
)
destroy=: 3 : 0
cbfree''
codestroy''
)
pm_category_button=: 3 : 0
if. NoEvents do. 0 return. end.
IFSECTION=: readradio {.y
pmview_show''
)
pm_clearall_button=: 3 : 0
setshowall 0
pmview_show''
)
pm_doinstall_button=: 3 : 0
dat=. pmview_selected''
if. 0 = #dat do.
  info 'No packages selected for installation.' return.
end.
if. -. ONLINE do.
  if. -. getonline 'Install Packages';CHECKONLINE do. return. end.
end.
install dat
pmview_show''
)
pm_doremove_button=: 3 : 0
dat=. pmview_selected''
if. 0 = #dat do.
  info 'No packages selected for removal.' return.
end.
remove_console 1{"1 pmview_selected''
pmview_show''
)
pm_msg_button=: 3 : 0
MSGX=: y
pmview_show''
)

pm_summary_button=: pm_msg_button bind 0
pm_history_button=: pm_msg_button bind 1
pm_manifest_button=: pm_msg_button bind 2
pm_log_button=: pm_msg_button bind 3
pm_notinstalled_button=: 3 : 0
setshownew 1
pmview_show''
)
pm_prebuild_button=: 3 : 0
if. -. ONLINE do.
  getonline 'Read Catalog from Server';CHECKASK
end.
if. ONLINE do.
  log 'Updating server catalog...'
  refreshjal''
end.
log 'Rebuilding local file list...'
refreshaddins''
readlocal''
log 'Done.'
pacman_init''
pmview_show''
)
pm_pupcat_button=: 3 : 0
if. -. ONLINE do.
  if. 0 = getonline 'Read Catalog from Server';CHECKASK do. return. end.
end.
log 'Updating server catalog...'
if. refreshweb'' do.
  log 'Done.'
end.
pacman_init''
pmview_show''
)
pm_selectall_button=: 3 : 0
setshowall 1
pmview_show''
)
pm_upgrades_button=: 3 : 0
setshowups 1
pmview_show''
)

pm_wiki_button=: addon_info
pmpack_cursor_changed=: 3 : 0
if. NoEvents do. 0 return. end.
DATAX=: listbox_getactiverow {.y
pmview_show''
0
)
pmsel_cursor_changed=: 3 : 0
if. NoEvents do. 0 return. end.
sel=. listbox_getactiverow {.y
SELNDX=: sel IFSECTION } SELNDX
pmview_show''
0
)
pmpack_toggled=: 3 : 0
path=. readstring 1{y
DATAX=: ({. 0 ". path) { I.DATAMASK
store=. gtk_tree_view_get_model pmpack
ndx=. <DATAX;0
new=. -. ndx pick PKGDATA
PKGDATA=: (<new) ndx} PKGDATA
iter=. i.ITERSIZE
gtk_tree_model_get_iter_from_string store;iter;path
gtk_list_store_set_2 store;iter;0;new;_1
pmview_show''
0
)
pmpack_key_press=: 1:
pmpack_row_activated=: 1:
pmsel_key_press=: 1:
pmsel_row_activated=: 1:
pm_status_button=: 1:
window_delete=: pm_quit=: pmview_close
window_key_press=: 3 : 0
if. -.isesckey y do. 0 return. end.
pmview_close''
1
)
pmview_applycounts=: 3 : 0
dat=. y
if. 0=#dat do. 0 0 return. end.
'lib dat'=. splitlib dat
cnt=. 0 < #lib
siz=. cnt * 2 pick LIB
ind=. ({."1 ZIPS) i. 1 {"1 dat
(cnt + #ind),siz + +/>(<ind;4){ZIPS
)
pmview_close=: 3 : 0
gtk_widget_destroy window
destroy''
1
)
pmview_getmask=: 3 : 0
ndx=. IFSECTION { SELNDX
if. IFSECTION do.
  sel=. ndx pick SECTION
  select. sel
  case. 'All' do.
    DATAMASK=: (#PKGDATA) $ 1
  case. BASELIB do.
    DATAMASK=: (1 {"1 PKGDATA) = <BASELIB
  case. do.
    DATAMASK=: (<sel,'/') = (1+#sel) {.each 1 {"1 PKGDATA
  end.
else.
  select. ndx pick Status
  case. 'All' do.
    DATAMASK=: (#PKGDATA) $ 1
  case. 'Not installed' do.
    DATAMASK=: pkgnew''
  case. 'Upgrades' do.
    DATAMASK=: pkgups''
  case. 'Installed' do.
    DATAMASK=: -. pkgnew''
  end.
end.
DATAX=: DATAX <. <: +/DATAMASK
)
pmview_init=: 3 : 0
if. -. checkaccess'' do. 0 return. end.
readconfig''
if. -. checkaddonsdir'' do. 0 return. end.
setfiles ''
readlocal''
if. -. checkonline'' do. 0 return. end.
pacman_init 1
pmview_show''
1
)
pmview_selected=: 3 : 'PKGDATA #~ > {."1 PKGDATA'
pmview_show=: 3 : 0
pmview_getmask ''
if. window do.
  setwindowfocus window
  pmview_write'' return.
else.
  pmview_open''
end.
)
pmview_write=: 3 : 0
noevents 1
setlistgrid pmpack;(pmgetdata'');DATAX
setlistbox pmsel;(IFSECTION{Status;<SECTION),<IFSECTION{SELNDX
setmsg ''
noevents 0
1
)
pmview_menu=: 3 : 0
mb=. create_menu_bar''

pop=. create_menu_popup mb;(gettext '_File')
con=. create_menu_container pop
create_menu_command con;'quit';'gtk-quit';'_Quit';'cQ';'Quit pacman';'pm_quit'

pop=. create_menu_popup mb;(gettext '_Tools')
con=. create_menu_container pop
create_menu_command con;'pupcat';'';'_Update Catalog from Server';'';'Update Catalog from Server';'pm_pupcat_button'
create_menu_command con;'prebuild';'';'_Rebuild all Repository Catalogs';'';'Rebuild all Repository Catalogs';'pm_prebuild_button'
create_menu_sep con
create_menu_command con;'remove';'';'Re_move Selected Packages';'';'Remove Selected Packages';'pm_doremove_button'

gtk_widget_show_all mb
mb
)
addon_info=: 3 : 0
if. 0=#PKGDATA do. return.end.
row=. DATAX{(I.DATAMASK),_1
if. row<0 do. return. end.
a=. (<row;1){:: PKGDATA
if. 'base library'-:a do. a=. 'JAL' else. a=. 'Addons/',a end.
browse_j_ 'http://www.jsoftware.com/jwiki/',a
)
loggui=: 3 : 0
LOGTXT=: LOGTXT,<;.2 y,LF -. {: y
del=. (#LOGTXT) - LOGMAX
if. del > 0 do.
  LOGTXT=: del }. LOGTXT
end.
if. window=0 do. return. end.
noevents 1
setradio pmlog,1
MSGX=: 3
pm_showmsg LOGTXT
noevents 0
)
pm_showmsg=: 3 : 0
txt=. y
if. L.txt do. txt=. }:;txt end.
t=. txt;MSGX
if. LASTMSG -: t do. return. end.
LASTMSG=: t
buf=. gtk_text_view_get_buffer pmmsg
noevents 1
bufwrite buf;txt
if. MSGX~:3 do.
  viewsetselect pmmsg;0;0
else.
  viewsetselect pmmsg;(#txt);0
  gtk_text_view_scroll_to_mark pmmsg,pmend,0 0 0 0
end.
noevents 0
)
setmsg=: 3 : 0
if. MSGX=3 do.
  t=. LOGTXT
else.
  ndx=. DATAX{(I.DATAMASK),_1
  if. ndx<0 do.
    t=. ''
  else.
    p=. '~addons/',(<ndx;1){:: PKGDATA
    select. MSGX
    case. 0 do.
      t=. ndx pick 5{"1 PKGDATA
    case. 1 do.
      t=. }.^:(_1&-:) fread jpath p,'/history.txt'
    case. 2 do.
      t=. }.^:(_1&-:) fread jpath p,'/manifest.ijs'
    end.
  end.
end.
pm_showmsg t
)
pmview_open=: 3 : 0
a=. GTK_FILL
b=. GTK_EXPAND + GTK_FILL
noevents 1
newwindow SYSNAME
windowdefaultsize 900 700
windowcenter''
consig3 window;'key-press-event';'window_key_press'
gtk_window_set_icon_from_file window;EditIcon;0
vb=. gtk_vbox_new 0 0
gtk_container_set_border_width vb,0
gtk_box_pack_start vb,(pmview_menu ''),0 0 0
gtk_box_pack_start vb,(pmview_main ''),1 1 0
gtk_container_add window,vb
windowfinish''
noevents 0
setmsg''
)
pmview_main=: 3 : 0
hp=. gtk_hpaned_new''
f1=. newframe'';GTK_SHADOW_IN
f2=. newframe'';GTK_SHADOW_IN
gtk_container_add f1,pmview_leftpanel''
gtk_container_add f2,pmview_rightpanel''
gtk_paned_pack1 hp, f1, 0 1
gtk_paned_pack2 hp, f2, 1 1
hp
)
pmview_leftpanel=: 3 : 0
a=. GTK_FILL
b=. GTK_EXPAND + GTK_FILL
tb=. gtk_table_new 4 1 0
pmsel=: makelistbox 'pmsel';Status;0;'';0
sw=. newsw 1
gtk_container_add sw,pmsel
gtk_table_attach tb,sw,0 1 0 1,b,b,3 0
hb=. gtk_hbox_new 0 0
rb1=. newradio 0;'Status';'pm_status_button'
rb2=. newradio rb1;'Category';'pm_category_button'
gtk_box_pack_start hb,rb1,0 0 0
gtk_box_pack_start hb,rb2,0 0 0
gtk_table_attach tb,hb,0 1 1 2,b,0 3 10
fm=. newframe 'Selections'
vb=. gtk_vbox_new 0 0
newxbutton vb;'Clear All';'pm_clearall_button'
newxbutton vb;'Upgrades';'pm_upgrades_button'
newxbutton vb;'Not Installed';'pm_notinstalled_button'
newxbutton vb;'Select All';'pm_selectall_button'
gtk_container_add fm,vb
gtk_table_attach tb,fm,0 1 2 3,b,0,3 4
vb=. gtk_vbox_new 0 0
newxpad vb,0 4
newxbutton vb;'Install';'pm_doinstall_button'
gtk_table_attach tb,vb,0 1 3 4,b,0,3 4
tb
)
pmview_rightpanel=: 3 : 0
vp=. gtk_vpaned_new''
gtk_container_set_border_width vp,0
pmpack=: makelistgrid 'pmpack';PackHdr;(pmgetdata'');0;'';1
consig pmpack;'cursor_changed';'pmpack_cursor_changed'
sw=. newsw 1
gtk_container_add sw,pmpack
gtk_paned_pack1 vp,sw, 1  1
gtk_paned_pack2 vp,(pmview_bottom''), 1 1
gtk_paned_set_position vp,475
vp
)
pmview_bottom=: 3 : 0
vb=. gtk_vbox_new 0 0
'sw sv sb'=. newcodeview 'view';EditScheme;'';''
pmmsg=: sv
pmend=: gtk_text_buffer_get_mark sb;'end'
gtk_text_view_set_editable sv,0
gtk_scrolled_window_set_shadow_type sw,1
gtk_box_pack_start vb,sw,1 1 0
hb=. gtk_hbox_new 0 0
hr=. gtk_hbox_new 0 0
rb=. newxradio hr;0;'Summary   ';'pm_summary_button'
newxradio hr;rb;'History   ';'pm_history_button'
newxradio hr;rb;'Manifest   ';'pm_manifest_button'
pmlog=: newxradio hr;rb;'Log';'pm_log_button'
gtk_box_pack_start hb,hr,0 0 5
gtk_box_pack_start hb,(newlabel ''),1 0 0
newxbutton hb;'Wiki';'pm_wiki_button'
gtk_box_pack_start hb,(newlabel ''),0 0 5
gtk_box_pack_start vb,hb,0 0 5
vb
)
pmgetdata=: 3 : '5{."1 DATAMASK#PKGDATA'
masklib=: 3 : 0
(1 {"1 y) = <BASELIB
)
pkglater=: 3 : 0
if. 0=#PKGDATA do. $0 return. end.
loc=. fixvers > 2 {"1 PKGDATA
srv=. fixvers > 3 {"1 PKGDATA
{."1 /:"2 srv ,:"1 loc
)
pkgnew=: 3 : 0
0 = # &> 2 {"1 PKGDATA
)
pkgups=: 3 : 0
(pkgnew'') < pkglater''
)
pkgsearch=: 3 : 0
+./"1 +./ y E."1&>"(0 _) 1{"1 PKGDATA
)
pkgshow=: 3 : 0
y e.~ 1{"1 PKGDATA
)
pmsetselect=: 4 : 0
PKGDATA=: (<y) (<(x{I.DATAMASK);0) } PKGDATA
)
setshowall=: 3 : 0
PKGDATA=: (<y) (<(I.DATAMASK);0) } PKGDATA
)
setshownew=: 3 : 0
ndx=. I. DATAMASK *. pkgnew''
PKGDATA=: (<y) (<ndx;0) } PKGDATA
)
setshowups=: 3 : 0
ndx=. I. DATAMASK *. pkgups''
PKGDATA=: (<y) (<ndx;0) } PKGDATA
)
splitlib=: 3 : 0
if. 0=#y do.
  2 $ <y return.
end.
msk=. masklib y
(msk#y) ; <(-.msk)#y
)
