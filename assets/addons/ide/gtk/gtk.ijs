NB. J gtkide

require 'gui/gtk project'

coclass 'jgtkide'
coinsert 'jgtk'
addtilde=: ,~ (0 < #) # '~' -. {.
remtilde=: }.~'~'={.
loadscript=: load
matchparens=: 0:
nc=: 4!:0
spliton=: i.~ ({. ,&< }.@}.) ]
trimWS=: #~ (+./\ *. +./\.)@:-.@(e.&(TAB,CRLF,' '))
bindtextdomain ::0: 'jgtkide';jpath '~install/gtk/share/locale'
bind_textdomain_codeset ::0: 'jgtkide';'UTF-8'
textdomain ::0: <'jgtkide'
cutLF=: 3 : 0
if. L. y do. y return. end.
a: -.~ <;._2 y,LF
)
dialog=: 3 : 0
a=. '' conew 'jgtkdialog'
r=. run__a y
destroy__a''
r
)
getactview=: 3 : 0
select. {.WinFocus
case. window__locTerm do.
  termSV
case. window__locEdit do.
  if. #EditTabs do.
    page_sv EditPage
  else.
    0
  end.
case. do.
  0
end.
)
getcurrentbuf=: 3 : 0
select. {.WinFocus
case. window__locTerm do.
  termSB__locTerm
case. window__locEdit do.
  if. #EditTabs do.
    edit_current_def''
    pSB
  else.
    0
  end.
case. do.
  0
end.
)
getcurrentloc=: 3 : 0
(window__locEdit={.WinFocus) { locTerm,locEdit
)
getmenu=: 3 : 0
ndx=. MENUIDS i. <y
if. ndx=#MENUIDS do.
  ((gettext 'menu not found: '),y) assert 0
end.
ndx pick MENUDEF
)
getselection=: 3 : 0
buf=. getcurrentbuf''
if. buf do. bufreadselect buf else. '' end.
)
getcurrentname=: 3 : 0
buf=. getcurrentbuf''
mark=. newitercursor buf
row=. gtk_text_iter_get_line <mark
bgn=. newiterline buf,row
end=. newiterline buf,row
gtk_text_iter_forward_to_line_end <end
p=. readstringfree gtk_text_iter_get_text bgn;mark
q=. readstringfree gtk_text_iter_get_text bgn;end
'name pos'=. getnameatcursor p;q
name
)
getcurrentccppfx=: 3 : 0
buf=. getcurrentbuf''
mark=. newitercursor buf
row=. gtk_text_iter_get_line <mark
bgn=. newiterline buf,row
end=. newiterline buf,row
gtk_text_iter_forward_to_line_end <end
p=. readstringfree gtk_text_iter_get_text bgn;mark
q=. readstringfree gtk_text_iter_get_text bgn;end
'name pos'=. getccppfxatcursor p;q
name
)
isimagefile=: 3 : 0
if. (<tolower '.' (i:~ }. ]) y) -.@e. '.' ,&.> 'bmp';'gif';'jpg';'jpeg';'png';'svg';'tif';'tiff' do. 0 return. end.
s=. 1!:4 :: _1: f=. fboxname y
if. s>:0 do. 1 return. end.
0
)
istextfile=: 3 : 0
s=. 1!:4 :: _1: f=. fboxname y
if. (s>:0) *. s<MaxText do.
  if. istextfile1 1!:1 :: (''"_) f do. 1 return. end.
end.
f=. tofoldername_jp_ y
t=. (gettext 'open file')
if. s = _1 do.
  mbinfo t;(gettext 'not found: '),f
elseif. s >: 1e6 do.
  mbinfo t;(gettext 'file too big '),f,': ',,'c' 8!:2 s
elseif. do.
  mbinfo t;(gettext 'content is not text: '),f
end.
0
)

istextfile1=: isutf8
ppath=: 3 : 0
if. isroot_j_ y do. y else. jpath '~',y end.
)
setfontall=: 3 : 0
FixFont_jgtkide_=: y
sv=. termSV__locTerm,page_svs''
for_i. sv do. setfont i;y end.
EMPTY
)
cocurrent 'z'

co=: ((] [ 18!:4@[) (>@(18!:5)@(0&$) , ' => ' , >))@((0 ~: #) { 'base'&;)
cofind=: 3 : 0
r=. (<,>y) (4 : 'try. x e. nl__y $0 catch. 0 end.'"0 # ]) 18!:1]0 1
if. 0=#r do. i.0 2 end.
)
cofindv=: 3 : 0
lcs=. cofind y
if. #lcs do.
  lcs ,. ". each (<y,'_') ,each lcs ,each '_'
end.
)
qss=: 3 : 0
r=. y dirss jpath '~Gtk'
r=. r,(0<#r)#LF
r,y dirss jpath '~Ide'
)
show_cbregs=: 3 : 0
smoutput (":,.i.#a),.' ',.>a=. cbregs_jgtk_
)

cocurrent 'jgtkide'
cfdelete=: ]
fpath=: [: }: +./\.@:=&'/' # ]
3 : 0''
if. IFUNIX do. filecase=: [
else. filecase=: tolower end.
0
)
cfsxname=: 3 : 0
(f i: '.') {. f=. 1 pick fpathname y
)
hostcmd=: [: 2!:0 '(' , ,&' || true)'
dquote=: 3 : 0
m=. y='"'
'"',('\' ((+i.@#) I.m) }(1+m)#y),'"'
)
forkcmd=: 3 : 0
if. IFUNIX do.
  2!:0 y, ('&' ~: {:y) # ' &'
else.
  fork_jtask_ y
end.
)
shellcmd=: 3 : 0
if. IFUNIX do.
  hostcmd y
else.
  spawn_jtask_ y
end.
)
setwinfocus=: 3 : 0
WinFocus_jgtkide_=: ~.y,WinFocus
0
)
readwinpos=: 3 : 0
pos=. getwinpos window
if. 0={:pos do.
  (y,'_jgtkide_')=: }:pos
  winpos_save''
end.
)
moveword=: 3 : 0
'dir sb sv'=. y
mark=. i.ITERSIZE
gtk_text_buffer_get_iter_at_mark sb;mark;gtk_text_buffer_get_insert sb
row=. gtk_text_iter_get_line <mark
bgn=. newiterline sb,row
end=. newiterline sb,row
gtk_text_iter_forward_to_line_end <end
p=. readstringfree gtk_text_iter_get_text bgn;mark
q=. readstringfree gtk_text_iter_get_text bgn;end
n=. moveword1 dir;p;q
select. m=. n
case. _3 do. 0 return.
case. _2 do.
  while. 0 <: row=. row-1 do.
    p=. bufreadline sb,row
    n=. moveword1 0;p;p
    if. n ~: _2 do. break. end.
  end.
  if. row=_1 do. 1 return. end.
  if. n=_3 do. 0 return. end.
  bgn=. newiterline sb,row
case. _1 do.
  len=. gtk_text_buffer_get_line_count sb
  while. len > row=. row+1 do.
    p=. bufreadline sb,row
    n=. moveword1 1;'';p
    if. n ~: _1 do. break. end.
  end.
  if. (row=len) +. n=_3 do. 0 return. end.
  bgn=. newiterline sb,row
  mark=. gtk_text_buffer_get_mark sb;'scroll'
  gtk_text_buffer_move_mark sb;mark;bgn
end.
gtk_text_iter_forward_chars bgn;n
gtk_text_buffer_place_cursor sb;bgn
if. m = _1 do.
  gtk_text_view_scroll_to_mark sv,mark,0 0 0 0
else.
  viewscrolliter sv;bgn
end.
1
)
moveword1=: 3 : 0
'dir pfx all'=. y

if. dir=0 do.
  pfx=. dtb pfx
  if. 0 = #pfx do. _2 return. end.
else.
  pfx=. pfx, (0 i.~ ' ' = (#pfx) }. all) # ' '
  if. pfx -: all do. _1 return. end.
end.

try.
  pfx=. ucp pfx
  all=. ucp all
  awf=. ;: all
catch. _3 return. end.

m=. -. @ (-: awf {.~ #) @ (;: ::])
if. dir=0 do.
  while. m pfx=. }:pfx do. end.
else.
  while. m pfx=. pfx,(#pfx){all do. end.
end.

#pfx
)

coclass 'jgtkide'
IFGTK_z_=: 1
LineNos=: 0
LineWrap=: 0
MaxText=: 1e6
conn_init=: 0:

bd=: 9!:6''
jfe_z_=: 0 0$15!:16
TabCloseStyle=: 0 : 0
style "tab-close-button-style" {
 GtkWidget::focus-padding = 0
 GtkWidget::focus-line-width = 0
 xthickness = 2
 ythickness = 2
}
widget "*.tab-close-button" style "tab-close-button-style"
)
ccp_query=: 3 : 0
''-.@-:locCcp__locEdit return.
)
ccp_new=: 3 : 0
assert. ''-:locCcp__locEdit
if. _1=y do.
  if. 0= #name=. getcurrentccppfx'' do.
    0 return.
  end.
else.
  if. 0= #name=. (utf8 u:y),~ getcurrentccppfx'' do.
    0 return.
  end.
end.
if. 0=#t=. ccp_tagcp name do.
  0 return.
else.
  rect=. 16#{.a.
  iter=. i.ITERSIZE
  gtk_text_buffer_get_iter_at_mark pSB;iter;gtk_text_buffer_get_insert pSB
  gtk_text_view_get_iter_location pSV;iter;rect
  bxywh=. _2 (3!:4) rect
  wx=. ,_1 [ wy=. ,_1
  gtk_text_view_buffer_to_window_coords pSV;1;(0{bxywh);(1{bxywh);wx;wy
  svxywh=. getGtkWidgetAllocation pSV
  tx=. ,_1 [ ty=. ,_1
  gtk_window_get_position (gtk_widget_get_toplevel pSV);tx;ty
  xywh=. (((tx,ty)+(2{.svxywh)+wx,wy),_2{.bxywh)

  locCcp__locEdit=: l=. conew 'jgtkccpbox'
  create__l (pSV;xywh;name;<t)
end.
1
)
ccp_renew=: 3 : 0
assert. -. ''-:locCcp__locEdit
l=. locCcp__locEdit
if. 0= #name=. (utf8 u:y),~ getcurrentccppfx'' do.
  close__l''
  0 return.
end.
if. 0=#t=. ccp_tagcp name do.
  close__l''
  0 return.
else.
  renew__l (name;<t)
end.
1
)
ccp_word=: 3 : 0
assert. ''-.@-:locCcp__locEdit
l=. locCcp__locEdit
pfx=. ucp pfx8=. getcurrentname__l''
name=. ucp getcurrentccppfx''
sfx=. (#name)}.pfx
if. 1 e. r=. sfx e. a.-.AlphaNum do.
  n2=. +/ *./\ r}.~ n1=. r i. 1
  sfx=. sfx{.~ n1+n2
end.
sfx=. utf8 sfx
gtk_text_buffer_insert_at_cursor pSB;sfx;#sfx

name=. getcurrentccppfx''
if. pfx8-:name do.
  close__l''
  0 return.
end.
1
)
ccp_destroy=: 3 : 0
if. ''-.@-:l=. locCcp__locEdit do.
  close__l''
end.
1
)
ccp_select=: 3 : 0
assert. ''-.@-:locCcp__locEdit
l=. locCcp__locEdit
select__l''
1
)
ccp_scroll=: 3 : 0
assert. ''-.@-:locCcp__locEdit
l=. locCcp__locEdit
scroll__l y
1
)
ccp_scrollend=: 3 : 0
assert. ''-.@-:locCcp__locEdit
l=. locCcp__locEdit
scrollend__l y
1
)
ccp_tagcp=: 3 : 0
t=. ''
if. 't' e. CodeCompletionOption do.
  t=. t, tagcp_jadetag_ y
end.
if. ('g' e. CodeCompletionOption) *. -. ('t' e. CodeCompletionOption) *. (fexist jpath '~addons/api/gtkinclude/tags') *. (<'~addons/api/gtkinclude/tags') e. Tags_j_ do.
  t=. t, tagcp_jgtkdoctag_ y
end.
if. ('d' e. CodeCompletionOption) do.
  if. (0= nc <'UserDict_j_') *. fexist jpath '~addons/general/userdict/userdict.ijs' do.
    require '~addons/general/userdict/userdict.ijs'
    t=. t, usertagcp y
  end.
end.
/:~ ~. (<'') -.~ t
)
tagtab=: 3 : 0
0 tagtab y
:
if. 0=#n=. tagtag_jadetag_ y do. EMPTY return. end.
file=. tagfile_jadetag_ idx=. x{n
if. -.fexist <file do.
  mbinfo (gettext 'Open');(gettext 'not found: '),file
  EMPTY return.
end.
row=. <:{.file tagss_jadetag_ tagline_jadetag_ idx
edit_opentab_show__locEdit file;row;0
EMPTY
)
tag=: 0&$: : (4 : 0)
if. x do. y=. tagcp y end.
if. 0=#n=. tagtag_jadetag_ y do.
  EMPTY return.
elseif. 1=#n do.
  file=. tagfile_jadetag_ idx=. 0{n
  if. -.fexist <file do.
    mbinfo (gettext 'Open');(gettext 'not found: '),file
    EMPTY return.
  end.
  row=. <:{.file tagss_jadetag_ tagline_jadetag_ idx
  edit_opentab_show__locEdit file;row;0
elseif. do.
  t=. tagselect y
  (y;t) conew 'jgtkctag'
end.
EMPTY
)

tagtab_z_=: tagtab_jgtkide_
tag_z_=: tag_jgtkide_
cx_run_clip=: 3 : 0
txt=. clipread''
if. #txt do.
  runimmex1 txt
end.
)
sv_click=: 3 : 0
s=. 2 #. y
if. s = 2 do.
  buf=. getcurrentbuf''
  setidle 'findname_',(>coname''),'_ ',":buf,s{0 2 1
end.
0
)
sv_double_click=: 3 : 0
buf=. getcurrentbuf''
setidle 'findname_',(>coname''),'_ ',":buf,0
0
)
findname=: 3 : 0
'buf sel'=. y
if. 0=buf do. 0 return. end.
mark=. newitercursor buf
row=. gtk_text_iter_get_line <mark
bgn=. newiterline buf,row
end=. newiterline buf,row
gtk_text_iter_forward_to_line_end <end
p=. readstringfree gtk_text_iter_get_text bgn;mark
q=. readstringfree gtk_text_iter_get_text bgn;end
'name pos'=. getnameatcursor p;q
if. #name do.
  mid=. newiterline buf,row
  gtk_text_iter_forward_chars bgn;pos
  gtk_text_iter_forward_chars mid;pos+#name
  gtk_text_buffer_select_range buf;bgn;mid
  if. sel do. fif name;sel end.
end.
)
inputx=: ''
logged=: 0
inputs=: 0
active=: 1

ifxlog=: 0
xlog=: ''
immex=: 3 : 0
logged=: 0
inputs=: 0
inputline=: y
inputready=: 1
)
immexd=: 3 : 0
logged=: 1
inputs=: 0
inputline=: y
inputready=: 1
)
immexs=: 3 : 0
logged=: 0
inputs=: 1
inputline=: y
inputready=: 1
)
input=: 3 : 0
term_append__locTerm prompt=: y
inputready=: 0
inputs=: 0
logged=: 0
while. 1 do.
  whilst. gtk_events_pending'' do.
    gtk_main_iteration''
  end.
  if. inputready do. break. end.
end.
if. ifxlog do. xlog=: xlog,<0;inputline end.
inputline
)
output=: 4 : 0
if. -.active do. return. end.
if. ifxlog do. xlog=: xlog,<x;y end.
if. 3~:x do.
  term_append__locTerm y
else.
  if. inputs do. return. end.
  if. logged do.
    term_append__locTerm y
  else.
    logged=: 1
    term_append__locTerm LF
  end.
end.
)
3 : 0''
if. -.IFJHS do.
  input_jfe_=: input_jgtkide_
  output_jfe_=: output_jgtkide_
end.
''
)
runimmex0=: 3 : 0
if. #y do.
  inputx_jgtkide_=: y
  immex_jgtkide_ '0!:100 inputx_jgtkide_'
end.
)
runimmex1=: 3 : 0
if. #y do.
  inputx_jgtkide_=: y
  immex_jgtkide_ '0!:101 inputx_jgtkide_'
end.
)
fkey_list=: 3 : 0
a=. cocreate''
coinsert__a coname''
fkey_list1__a coname''
)
fkey_list1=: 3 : 0
locP=: y
ndx=. /: (100|FKeys),.FKeys
ids=. 'F' ,each ": each 100|FKeys
cs=. (<.FKeys % 100){'';' shift';' ctrl';' ctrl+shift'
lab=. 1{"1 FKeyx
ids=. ids ,each cs
nms=. ndx{ids,.lab
Fx=: ndx
window_delete=: fkey_close
newwindow 'Function Keys'
windowdefaultsize 400 300
gtk_window_set_type_hint window,GDK_WINDOW_TYPE_HINT_DIALOG
gtk_window_set_destroy_with_parent window,1
gtk_window_set_modal window,1
windowcenter''
sw=. newsw''
tv=: makelistgrid 'fkey';'';nms;'';'';1
setchildfocus tv
gtk_container_add sw,tv
gtk_container_add window,sw
windowfinish''
)
fkey_key_press=: 3 : 0
if. isesckey y do. fkey_close'' else. 0 end.
)
fkey_close=: 3 : 0
gtk_widget_destroy window
cbfree''
codestroy''
1
)
fkey_row_activated=: 3 : 0
row=. listbox_getactiverow tv
if. row >: 0 do.
  fkey_exec_index__locTerm row { Fx
end.
if. -. 1{getmodifiers'' do.
  fkey_close''
end.
)
idlers=: ''
runidle=: 3 : 0
if. #idlers do.
  0!:100 ; idlers ,each LF
  idlers_jgtkide_=: ''
end.
0
)
setidle=: 3 : 0
if. #idlers do.
  idlers_jgtkide_=: ~.idlers,<y
else.
  idlers_jgtkide_=: <y
  g_idle_add cb1;cbreg 'runidle_jgtkide_'
end.
0
)
lint=: 3 : 0
if. 0=#EditTabs do. return. end.
require PPScript_jp_
edit_current_def''

'old sel len'=. bufget pSB
crs=. +/ LF = sel {. old
FORMAT_j_=: 1 0 2 1 0 0

new=. pplint_jpp_ old
if. 0 = #new do. return. end.
if. new -: old do. return. end.

top=. viewgettop pSV

if. L. new do.
  'lin msg'=. new
  'bgn end'=. 1 0 + (+/\LF = old) i. lin + 0 1
  viewsetscroll pSV,0 >. lin - 10
  viewsetselect pSV,bgn,end-bgn
  mbinfo (gettext 'Format Script');msg
  return.
else.
  old=. sel {. old
  chr=. +/ -. (TAB,' ') e.~ (1 + old i: LF) }. old
  spc=. (*chr) *. ' ' = {: old
  ndx=. crs { 0, 1 + I. LF = new
  sel=. ndx + chr i.~ 0, +/\ -. (TAB,' ') e.~ ndx }. new
  sel=. sel + spc * LF ~: {. sel }. new
  sel=. sel <. <:#new
  bufwrite pSB;new
  viewsetscroll pSV,top
  viewsetselect pSV,sel,0
end.
)
main_run=: jfe bind 1

detach_console=: 3 : 0
if. IFWIN do.
  'kernel32 FreeConsole > i'&cd ''
end.
0
)
main=: 3 : 0
main_init''
if. r=. conf_init'' do. main_quit r return. end.
if. r=. conn_init'' do. main_quit r return. end.
detach_console''
proj_init''
menu_init''
sview_init''
main_open''
main_run''
0
)
main_init=: 3 : 0
if. IFUNIX do.
  hostfilename=: jpathsep
else.
  hostfilename=: tolower @ jpathsep
end.
extdef=: , (ScriptExt_j_ #~ '.'&e. < 0 < #)
main_init_paths''
gtkinit''
gtkfixf10''
gtk_rc_parse_string <TabCloseStyle
EditTabx=: i.0 0
locFif=: locFiw=: locEdits=: locEdit=: locTerm=: ''
SelectFile=: jpath '~temp/selection.'
Swh=: getscreenwh''
Twh=: 0 0
WinFocus=: ''
)
main_init_paths=: 3 : 0
GtkConfig=: jpath '~addons/ide/gtk/config/'
WinPosFile=: jpath '~config/winpos.dat'
)
main_open=: 3 : 0
locTerm=: '' conew 'jgtkterm'
loc0=. conew 'jgtkedit'
loc1=. conew 'jgtkedit'
locEdit=: loc0
locEdits=: loc0,loc1
Visible=: 0 0
create__loc0 0
create__loc1 1
term_open__locTerm''
)
main_quit=: 3 : 0
active=: 0
jfe 0
noevents 1
delete_empty''
locs=. locFif,locFiw,(locEdits-.locEdit),locEdit
for_loc. locs intersect conl 1 do.
  window_destroy__loc''
end.
2!:55 {.0,y
)
proj_init=: 3 : 0
ProjectDat_jgtkide_=: jpath '~config/project.dat'
projreadopen_jgtkedit_''
projinit_jp_''
)
fontdiff=: 3 : 0
fnt=. deb FixFont
ndx=. fnt i: ' '
setfontall (ndx{.fnt),' ',":y + 10 ". ndx}.fnt
)

fontinc=: fontdiff bind 1
fontdec=: fontdiff bind _1

open=: 3 : 0
f=. getscripts_j_ y
b=. fexist f
if. 0 e. b do.
  j=. (b=0)#f
  if. 1=#j do.
    j=. ,>j
  else.
    j=. LF,; LF&, each j
  end.
  mbinfo (gettext 'Open');(gettext 'not found: '),j
end.
if. #f=. b#f do. edit_openfiles__locEdit f;_1 end.
EMPTY
)

open_z_=: open_jgtkide_
recent_run=: 3 : 0
if. 0 e. #RecentFiles_j_ do.
  mbinfo (gettext 'No recent files') return.
end.
a=. cocreate''
coinsert__a coname''
recent_run1__a coname''
)
recent_run1=: 3 : 0
locP=: y
Shift=: 0
Recent=: RecentFiles_j_
window_delete=: recent_close
newwindow (gettext 'Recent Files')
windowdefaultsize 500 400
gtk_window_set_type_hint window,GDK_WINDOW_TYPE_HINT_DIALOG
gtk_window_set_destroy_with_parent window,1
gtk_window_set_modal window,1
windowcenter''
sw=. newsw 1
hb=. gtk_hbox_new 0 0
nms=. remtilde each tofoldername_j_ Recent
tv=: makelistbox 'recent';nms;'';'';1
gtk_container_add sw,tv
gtk_box_pack_start hb,sw,1 1 0
vb=. gtk_vbox_new 0 0
gtk_box_pack_start vb,(newpad 0 4),0 0 0
newxbutton vb;(gettext 'Open');'recent_open_button'
newxbutton vb;(gettext 'View');'recent_view_button'
newxbutton vb;(gettext 'Run');'recent_run_button'
newxbutton vb;(gettext 'Run Display');'recent_rund_button'
gtk_box_pack_start hb,vb,0 0 6
gtk_container_add window,hb
setchildfocus tv
windowfinish''
)
recent_close=: 3 : 0
gtk_widget_destroy window
cbfree''
codestroy''
1
)

recent_cursor_changed=: ]
recent_key_press=: 3 : 0
if. isesckey y do. recent_close'' else. 0 end.
)
recent_open_button=: 3 : 0
if. 0 = #f=. recent_select'' do. 1 return. end.
edit_opentab_show__locEdit f
if. -. Shift do. recent_close'' end.
1
)
recent_row_activated=: 3 : 0
if. 0 = #f=. recent_select'' do. 1 return. end.
recent_open_button''
)
recent_run_button=: 3 : 0
if. 0 = #f=. recent_select'' do. 1 return. end.
term_load_script__locTerm f
if. -. Shift do. recent_close'' end.
)
recent_rund_button=: 3 : 0
if. 0 = #f=. recent_select'' do. 1 return. end.
term_loadd_script__locTerm f
if. -. Shift do. recent_close'' end.
)
recent_select=: 3 : 0
Shift=: 1{getmodifiers''
if. 0 > row=. listbox_getactiverow tv do. '' return. end.
row pick Recent
)
recent_view_button=: 3 : 0
if. 0 = #f=. recent_select'' do. 1 return. end.
fview f
if. -. Shift do. recent_close'' end.
)
delete_empty=: 3 : 0
c=. jpath '~config/'
m=. 0 = ;2{"1 d=. 1!:0 c,'*.cfg'
if. 1 e. m do.
  ferase (<c) ,each {."1 m#d
end.
c=. jpath '~temp/'
m=. 0 = ;2{"1 d=. 1!:0 c,'*.ijs'
t=. {."1 m # d
m=. istempname_j_ &> t
if. 1 e. m do.
  ferase (<c) ,each m#t
end.
1
)
getnameatcursor=: 3 : 0
'pfx all'=. y
bgn=. pfx #~ *./\. pfx e. AlphaNum,'_'
bgn=. bgn #~ +./\ bgn e. Alpha
sfx=. (#pfx) }. all
end=. sfx #~ *./\ sfx e. AlphaNum,'_'
nam=. bgn,end
nam=. (1 i.~ '__' E. nam) {. nam
if. '_' = {:nam do. nam=. ((}:nam) i: '_') {. nam end.
hit=. ((0<#bgn) +. ' '={:pfx) *. (0<#end) +. ({.sfx) e. ' ',LF
if. hit *. 0<#nam do.
  nam;(#pfx)-#bgn
else.
  '';''
end.
)
getccppfxatcursor=: 3 : 0
'pfx all'=. ucp&.> y
bgn=. utf8 pfx #~ *./\. pfx e. ucp CodeCompletionKeyword
sfx=. (#pfx) }. all
hit=. (0<#bgn) *. ({.sfx) -.@e. ucp CodeCompletionKeyword
if. hit do.
  bgn;(#utf8 pfx)-#bgn
else.
  '';''
end.
)
gotodef=: 3 : 0
if. 0=#y do. 1 return. end.
if. -. *./ y e. AlphaNum,'._' do. 0 return. end.
fif y;1
)
gototag=: 3 : 0
if. 0=#y do. 1 return. end.
tag y
)
gtklocs=: 3 : 0
locEdits,locTerm,locFif,locFiw
)
guigtkconfig=: 3 : 0
jpath '~addons/gui/gtk/config/'
)
interrupt=: 3 : 0
promptclear__locTerm''
immexs_jgtkide_ '''exit jfe (native) - to restart: jfe 1'''
jfe 0
1
)
is_shellscript=: 3 : 0
'.sh' -: _3 {. y
)
runlines=: runimmex1
saveopenwindows=: 3 : 0
noevents''
if. window__locEdit do.
  1 tab_saveall__locEdit''
end.
)
tabrun=: 3 : 0
'fl dat'=. tabread__locEdit''
if. 0=#fl do. '' return. end.
if. is_shellscript fl do. hostcmd fl return. end.
cocurrent 'base'
3 : '0!:101 y[4!:55 <''y''' dat
)
tabrunclear=: 3 : 0
term_clear__locTerm''
tabrun''
)
validate=: 3 : 0
b=. 2 }. (3=nc cbregs_jgtk_) +. 0 = #&> cbregs_jgtk_
if. 0 e. b do.
  miss=. (0 0,b=0)#cbregs_jgtk_

  smoutput 'validate missing cdbregs:'
  smoutput copath coname''
  smoutput (;cofind) &> miss

  'missing cbregs' assert 0
end.
for_loc. locEdits_jgtkide_ do.
  if. EditNB__loc do.
    assert. (#EditTabs__loc) = gtk_notebook_get_n_pages EditNB__loc
  end.
end.
EMPTY
)
jgtkide_z_=: main_jgtkide_
cocurrent 'jgtkide'

jdefs=: 0 : 0
Snapshots
SnapshotX
)

jgtkidedefs=: 0 : 0
AutoCompletion
CodeCompletionBox
CodeCompletionKeyword
CodeCompletionOption
CodeCompletionScroll
ConfirmClose
ConfirmSave
ContextHelp
EditIcon
EditPos
EditScheme
EscClose
FifTypes
FixFont
KeepInputLog
SideBar
TermIcon
TermPos
TermScheme
Terminal
)

cbname=: {.~ i.&' ' <. i.&'='
cbread=: 3 : 0
dat=. 'b' freads y
if. dat -: _1 do. return. end.
dat=. dat #~ (<'NB.') ~: 3 {. each dat
dat=. dat #~ '#' ~: {.&> dat
dat=. deb each dat
cbflatten dat #~ 0 < #&> dat
)
cbflatten=: 3 : 0
msk=. (<'0 : 0') = _5 {.each y
if. -. 1 e. msk do. y return. end.
n=. msk i. 1
(n {. y),;(n }. msk) cbflatten1;.1 n }. y
)
cbflatten1=: 3 : 0
ndx=. 1 + y i. <,')'
<(<;(ndx{.y) ,each LF),ndx}.y
)
cbread1=: 3 : 0
r=. cbread jpath '~config/',y
if. r -: _1 do. cbread GtkConfig,y end.
)
cbread2=: 3 : 0
r0=. cbread GtkConfig,y
if. r0 -: _1 do. r0=. <'' end.
r1=. cbread jpath '~config/',y
if. (0=#r1) +. r1 -: _1 do. r0 return. end.
n0=. cbname each r0
n1=. cbname each r1
if. 0 = #n0 -. n1 do. r1 return. end.
new=. (-.n0 e. n1) # r0
r=. LF2,'NB. ',(50#'='),LF,'NB. new configs',LF,;new,each LF
r fappends jpath '~config/',y
r1,new
)
cutcommas=: 3 : 0
f=. (]`".@.('''' = {.)) @ deb
dat=. ',' , y
msk=. (dat=',') > ~:/\dat=''''
f each msk <;._1 dat
)
conf_fini=: 3 : 0
Pathp=: jpath '~temp'
)
conf_fkeys=: 3 : 0
conf_fkeys1 cbread1 'fkeys.cfg'
)
conf_fkeys1=: 3 : 0
na=. 1 201 5 9 209
FKeys_jgtkide_=: ''
FKeyx_jgtkide_=: i.0 3
dat=. y
if. (0=#dat) +. dat -: _1 do. return. end.
dat=. 4 {."1 cutcommas &> dat
key=. {."1 dat
cs=. 100 * (2 #. 'cs' e. ]) &> key
msk=. -. cs e. na
FKeys_jgtkide_=: msk # cs + 0 ({.@".) &> key -.each <'cs'
out=. 0 ({.@".) each 1{"1 dat
FKeyx_jgtkide_=: msk # out,.2 3{"1 dat
EMPTY
)
conf_fmt=: 3 : 0
v=. ": each ". each ;: y
n=. ;: tolower y
n=. LF ,each n ,each '='
; n,.v
)
conf_fmts=: 3 : 0
n=. (<LF,'r'), each '=' ,~ each ": each i.#y
; n,.y
)
conf_gtkide=: 3 : 0
cocurrent 'jcfgx'
coinsert 'jgtkide'
0!:100 ;LF ,each cbread2 'gtkide.cfg'
0!:100 ;(}:,'_j_=:',]) each <;.2 jdefs
0!:100 ;(}:,'_jgtkide_=:',]) each <;.2 jgtkidedefs
boxdraw_j_ BoxForm
cocurrent 'jgtkide'
FixFontDef=: FixFont
EditIcon=: (#~ fexist) jpath EditIcon
TermIcon=: (#~ fexist) jpath TermIcon
EditPos=: conf_pos EditPos
TermPos=: conf_pos TermPos
coerase <'jcfgx'
)
conf_init=: 3 : 0
conf_fkeys''
conf_gtkide''
conf_menu''
conf_winpos''
conf_fini''
0
)
conf_launch=: 3 : 0
t=. 'b' freads '~config/launch.cfg'
if. t-:_1 do.
  t=. 'b' freads GtkConfig,'launch.cfg'
end.
if. t-:_1 do.
  i. 0 2
else.
  t=. a: -.~ t #~ ('#' = {.&> t) +: (<'NB.') = 3 {.each t
  x=. t i.&> ';'
  deb each (x {.each t),.(x+1) }.each t
end.
)
conf_studio=: 3 : 0
t=. 'b' freads GtkConfig,'studio.cfg'
if. t-:_1 do.
  i. 0 2
else.
  t=. a: -.~ t #~ (<'NB.') ~: 3 {.each t
  x=. t i.&> ';'
  deb each (x {.each t),.(x+1) }.each t
end.
)
conf_menu=: 3 : 0
Launch_jgtkide_=: conf_launch''
Studio_jgtkide_=: conf_studio''
)
conf_pos=: 3 : 0
if. 1 e. y>1 do. y return. end.
<.y * 4$Swh
)
conf_winpos=: 3 : 0
0!:0 <GtkConfig,'winpos.dat'
0!:0 ::] <WinPosFile
)
conf_save=: 3 : 0
recentsave_j_ ''
)
snapwrite=: ]
winpos_save=: 3 : 0
cocurrent 'jgtkide'
n=. ;: 'DirmPos DlogPos FifPos FiwPos PselPos CtagPos ViewPos'
r=. 'NB. gtkide sticky window positions',LF2
r=. r, ; n ,each ('=: ',LF,~":@".) each n
r fwritenew WinPosFile
)
coclass 'jbaselibtag'
coinsert 'ctag'

absolutepath=: 0
Tags=: '~addons/ide/gtk/baselibtags'
cleartags''
coclass 'jgtkctag'
coinsert 'jgtkide'
create=: 3 : 0
'y t'=. y
mytag=: y
coextend COCREATOR
if. 0=#tagtags_jadetag_ do.
  mbinfo (gettext 'tags');(gettext 'Nothing in tags.')
  destroy'' return.
end.
make_ctag <"1 t
)
destroy=: 3 : 0
cbfree''
codestroy''
)
ctag_row_activated=: 3 : 0
row=. listbox_row_activated y
(<.-:row) tagtab mytag
ctag_close''
0
)
ctag_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Escape do. 0 return. end.
'ctrl j shift'=. 2 2 2 #: state
if. ctrl +. shift do. 0 return. end.
ctag_close''
1
)
ctag_close=: 3 : 0
readwinpos 'CtagPos'
WinCTag_jgtkide_=: 0
gtk_widget_destroy window
destroy''
0
)

ctag_cursor_changed=: 1:
window_delete=: ctag_close
delprompt=: ]
make_ctag=: 3 : 0
newwindow (gettext 'Tags')
WinCTag_jgtkide_=: window
CtagPos setwinpos window
gtk_window_set_type_hint window,GDK_WINDOW_TYPE_HINT_DIALOG
gtk_window_set_destroy_with_parent window,1
gtk_window_set_modal window,1
windowcenter''
sw=. newsw''
txt=. delprompt y
tv=. makelistbox 'ctag';txt;0;'';1
setchildfocus tv
gtk_container_add sw,tv
gtk_container_add window,sw
windowfinish''
)
coclass 'jgtkccpbox'
coinsert 'jgtkide'
create=: 3 : 0
'sv cursorxywh mytag alltag'=: y
alltag=: ,alltag
make_ccpbox ''
gtk_widget_show_all window
1
)
destroy=: 3 : 0
cbfree''
codestroy''
)
ccpbox_row_activated=: 3 : 0
row=. listbox_row_activated y
insertproposal row
close''
0
)
ccpbox_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Escape do. 0 return. end.
'ctrl j shift'=. 2 2 2 #: state
if. ctrl +. shift do. 0 return. end.
close''
0
)
ccpbox_close=: 3 : 0
close''
0
)
ccpbox_show=: 3 : 0
gtk_window_present_with_time (t=. gtk_widget_get_toplevel sv), GDK_CURRENT_TIME
gtk_window_activate_focus t
0
)
ccpbox_cursor_changed=: 1:
window_delete=: ccpbox_close
make_ccpbox=: 3 : 0
newwindow (gettext 'Code Completion')
windowdefaultsize boxwh=. CodeCompletionBox_jgtkide_
'w h'=. getscreenwh''
'px py pw ph'=. cursorxywh
ox=. 5 >. (_5 + w-{.boxwh) <. px - <.-:{.boxwh
if. py < -:h do.
  oy=. _5 + ph + py
else.
  oy=. 5 >. _25 + py - {:boxwh
end.
gtk_window_move window,ox,oy
gtk_window_set_transient_for window, gtk_widget_get_toplevel sv
gtk_window_set_decorated window,0
sw=. newsw''
assert. 0<#alltag
txt=. alltag
tv=: makelistbox 'ccpbox';txt;0;'';1
consig window;'show';'ccpbox_show'
setchildfocus tv
gtk_container_add sw,tv
gtk_container_add window,sw
1
)
renew=: 3 : 0
'mytag alltag'=: y
alltag=: ,alltag
assert. 0<#alltag
txt=. alltag
store=. gtk_tree_view_get_model tv
setstore store;<txt
listbox_scroll tv,0
listbox_select tv,0
1
)
scroll=: 3 : 0
listbox_scroll tv,r=. (<:#alltag) <. 0 >. y+listbox_getactiverow tv
listbox_select tv,r
1
)
scrollend=: 3 : 0
listbox_scroll tv,r=. (_1~:y){0, <:#alltag
listbox_select tv,r
1
)
select=: 3 : 0
row=. listbox_getactiverow tv
insertproposal row
close''
)
getcurrentname=: 3 : 0
alltag{::~ listbox_getactiverow tv
)
close=: 3 : 0
locCcp__locEdit=: ''
gtk_widget_destroy window
gtk_window_present_with_time (t=. gtk_widget_get_toplevel sv), GDK_CURRENT_TIME
gtk_window_activate_focus t
destroy''
)
insertproposal=: 3 : 0
name=. y{::alltag
sfx=. (#mytag)}.name
sb=. gtk_text_view_get_buffer sv
gtk_text_buffer_insert_at_cursor sb;sfx;#sfx
)
coclass 'jgtkdoctag'
coinsert 'ctag'

absolutepath=: 0
Tags=: '~addons/ide/gtk/gtkdoctags'
cleartags''
coclass 'jgtkdialog'
coinsert 'jgtkide'

ScriptPatterns=: <'*.ijs';'scripts'
AllPattern=: <'*.*';'all files'
ProjPattern=: <'*.jproj';'jproject'
create=: 3 : 0
coextend COCREATOR
)
destroy=: 3 : 0
cbfree''
codestroy''
0
)
run=: 3 : 0
'type arg'=. 2 {. boxopen y
dialogfile (5}.type);arg
)
dialogfile=: 3 : 0
'type arg'=. y
p=. ScriptPatterns,AllPattern
f=. 0
select. type
case. 'open' do.
  d=. getfilepath ''
  t=. (gettext 'open file')
case. 'opentemp' do.
  d=. jpath '~temp'
  t=. (gettext 'open file')
case. 'openuser' do.
  d=. jpath '~user'
  t=. (gettext 'open file')
case. 'opensystem' do.
  d=. jpath '~system'
  t=. (gettext 'open file')
case. 'saveas' do.
  d=. arg,(0=#arg)#getfilepath ''
  t=. (gettext 'save as')
  f=. 2
case. 'new' do.
  d=. getfilepath ''
  t=. (gettext 'new file')
  f=. 1
case. 'newtemp' do.
  d=. arg
  t=. (gettext 'new file')
  f=. 1
case. 'project_open' do.
  p=. ProjPattern
  d=. getprojnewpath''
  t=. (gettext 'open project')
case. 'project_new' do.
  p=. ''
  d=. getprojnewpath''
  t=. (gettext 'new project folder')
  f=. 3
end.
filechooser f;t;p;d
)
getfilepath=: 3 : 0
if. #y do.
  fpath p
else.
  if. (0=window__locEdit) +. 0=#ProjectPath_jp_ do.
    defaultpath''
  else.
    ProjectPath_jp_
  end.
end.
)
getprojnewpath=: 3 : 0
if. (0=window__locEdit) +. 0=#ProjectPath_jp_ do.
  p=. defaultpath''
else.
  p=. ProjectPath_jp_
end.
}: 0 pick fpathname p
)
defaultpath=: 3 : 0
(0<#Pathp) pick (jpath '~install');Pathp
)
browsebox_proj_file=: 3 : 0
p=. readstring gtk_entry_get_text wfile
if. 0=#p do.
  p=. jpath '~config'
end.
while. 1 do.
  s=. filechooser 2;(gettext 'Project Filename');ProjPattern;p
  if. 0=#s do. return. end.
  s=. extproj_j_ s
  if. fexist s do.
    mbinfo (gettext 'Project already exists: '),s continue.
  end.
  setentry wfile;s return.
end.
)
browsebox_proj_path=: 3 : 0
p=. readstring gtk_entry_get_text wpath
if. 0=#p do.
  p=. defaultpath''
end.
s=. filechooser 3;(gettext 'project path');'';p
if. #s do.
  setentry wpath;s
end.
)
browsebox_proj_run=: 3 : 0
p=. fpath readstring gtk_entry_get_text wrun
if. 0=#p do.
  p=. defaultpath''
end.
s=. filechooser 0;(gettext 'Run Command');AllPattern;p
if. #s do.
  setentry wrun;s
end.
)
newproject=: 3 : 0
window=: gtk_dialog_new''
title=: (gettext 'New Project')
gtk_window_set_title window;title
windowdefaultsize 450 0
vb=. gtk_dialog_get_content_area window
gtk_box_pack_start vb, (newpad 0 6), 0 0 0

hb=. gtk_hbox_new 0 3
label=. (newlabel (gettext 'Folder:')) newalign 0 0.5 0 0
name=: gtk_entry_new ''
setentry name;y
'fileb btn'=. browsebox name;'gtk-open';'newproject_folder'
gtk_box_pack_start hb, label, 0 0 3
gtk_box_pack_start hb, fileb, 1 1 3
gtk_box_pack_start vb, hb, 0 0 3
gtk_box_pack_start vb, (newpad 0 8), 0 0 0

fm=. gtk_frame_new <(gettext 'Create Scripts')
vf=. gtk_vbox_new 0 0
hb=. gtk_hbox_new 0 0
cbbuild=: gtk_check_button_new_with_mnemonic <(gettext 'build')
gtk_box_pack_start hb, cbbuild, 0 0 12
cbrun=: gtk_check_button_new_with_mnemonic <(gettext 'run')
gtk_box_pack_start hb, cbrun, 0 0 12
cbinit=: gtk_check_button_new_with_mnemonic <(gettext 'init')
gtk_box_pack_start hb, cbinit, 0 0 12
gtk_box_pack_start vf, hb, 0 0 3
hb=. gtk_hbox_new 0 0
label=. (newlabel (gettext 'Other Scripts:')) newalign 0 0.5 0 0
scripts=: gtk_entry_new ''
gtk_box_pack_start hb, label,0 0 3
gtk_box_pack_start hb, scripts,1 1 3
gtk_box_pack_start vf, hb, 0 0 3
gtk_container_add fm,vf
gtk_box_pack_start vb, fm, 0 0 3
gtk_box_pack_start vb, (newpad 0 6), 0 0 0

setcheckbox cbbuild,1
setcheckbox cbrun,1
setcheckbox cbinit,1

button=. gtk_button_new''
bbox=. gtk_hbox_new 0 0
image=. gtk_image_new_from_stock 'gtk-new';GTK_ICON_SIZE_BUTTON
label=. gtk_label_new_with_mnemonic <(gettext 'C_reate')
gtk_box_pack_start bbox, image, 0 0 3
gtk_box_pack_start bbox, label, 0 0 3
gtk_container_add button, bbox
gtk_dialog_add_action_widget window,button,GTK_RESPONSE_OK
windowfinish''
setentryposition name,_1

res=. ''
while. 1 do.
  r=. gtk_dialog_run window
  if. r ~: GTK_RESPONSE_OK do. break. end.
  p=. jpath remsep readstring gtk_entry_get_text name
  if. 0=#p do.
    mbinfo title;(gettext 'Folder must be given') continue.
  end.
  if. newproject_exist p do. continue. end.
  if. newproject_subfolder p do. continue. end.
  if. -. mkdir_j_ p do.
    mbinfo titile;(gettext 'Unable to create folder: '),p
    continue. end.
  build=. readcheckbox cbbuild
  run=. readcheckbox cbrun
  init=. readcheckbox cbinit
  other=. readstring gtk_entry_get_text scripts
  res=. p;other;build;run;init
  break.
end.

gtk_widget_destroy window
res
)
newproject_exist=: 3 : 0
f=. path2proj_j_ y
if. fexist f do.
  1 [ mbinfo title;(gettext 'Project already exists: '),y
else.
  0
end.
)
newproject_subfolder=: 3 : 0
'f p'=. ffoldername_jp_ y
if. 0=#f do.
  msg=. title;(gettext 'Not in a Folder: '),y,LF,LF,(gettext 'OK to continue?')
  0=mbnoyes msg return.
end.
if. -. (<remsep }.f) e. {."1 UserFolders_j_ do.
  msg=. title;(gettext 'Not a UserFolder: '),y,LF,LF,(gettext 'OK to continue?')
  0=mbnoyes msg return.
end.
if. 0=#p do.
  1[mbinfo title;(gettext 'Sub folder should be given: '),f return.
end.
0
)
newproject_folder=: 3 : 0
p=. dialog 'file_project_new'
if. #p do.
  if. -. newproject_exist p do.
    setentry name;tofoldername_jp_ p
  end.
end.
)
coclass 'jgtkdirm'
coinsert 'jgtkide j'

matched=: 0
window=: 0
written=: 0

title=: (gettext 'Directory Match')

DMCFGFILE=: ''
DMDIRSOLD=: ''
DMPROJECT=: ''
DMPROJECTS=: ''
DMSNAPS=: ''
DMSOURCE=: ''
DMTARGET=: ''
DMFavorites=: i.0 2

DMFOUNDALL=: DMFOUNDCONTENTS=: ''
NOTINSOURCE=: NOTINTARGET=: ''
DIFFTIME=: DIFFCONT=: i.0 6
DIFFTIMEST=: DIFFCONTST=: ''

DMMSK=: ''
DMTREEX=: ''
DMType=: ''
DMTypes=: 'All *'

DMTAB=: 'std'

DMCONTENTS=: 0
DMTIMESTAMP=: 0

DMSUBDIR=: 1
IGNOREST=: 0
IGNORENS=: 0
IGNORENT=: 0
IGNORESEP=: 1
IGNORELTW=: 0
TEXTBASE=: '/','text-base','/'
dm_init=: 3 : 0
if. 0=#DMCFGFILE do.
  DMCFGFILE=: jpath '~config/dirmatch.cfg'
  dmconfig''
end.

if. #y do.
  p=. boxxopen y
  DMTAB=: 0 pick p
  ('dm_init_',DMTAB)~}.p
end.

DMRUN=: 0
DMCONTENTS=: 0
DMTIMESTAMP=: 0

menu_init''
compare_init''
)
dmconfig=: 3 : 0
0!:0 ::] <GtkConfig,'dirmatch.cfg'
0!:0 ::] <DMCFGFILE
dmconfig1''
)
dmconfig1=: 3 : 0
DMDIRS=: RecentDirmatch
DMMAX=: +:>.-:RecentMax
if. 0=4!:0 <'DirTreeX' do.
  DMTREEX=: boxxopen DirTreeX
end.
'DMTypeT DMTypeN'=: dmtypes DMTypes
DMTypeX=: ((DMTypeN i.&>' ') {.each DMTypeN) i. <DMType
DMFavorites=: _2 ,\ a: -.~ deb each <;._2 termLF DMFavorites
)
dmsaverecent=: 3 : 0
if. DMTAB-:'std' do.
  RecentDirmatch_j_=: DMDIRS
  recentsave''
end.
)
fmtdir=: termsep @ filecase
isempty=: 0: e. $
index=: #@[ (| - =) i.
intersect=: e. # [
quote=: ''''&,@(,&'''')@(#~ >:@(=&''''))
subs=. 2 : 'x I. @(e.&y)@]} ]'
toblank=: ' ' I.@(e.&'_')@]} ]
todelim=: ; @: ((DEL&,) @ (,&DEL) @ , @ ": &.>)
tolist=: }.@;@:(LF&,@,@":&.>)
delBS=: }.~ [: - '/' = {:

termLF=: , (0 < #) # LF -. {:
termSEP=: , (0: < #) # '/'"_ -. _1&{.
termdelSEP=: }.~ [: - 0: i.~ '/'&= @ |.
addtextbase=: 3 : 0
'nms src'=. y
nms=. fpathname &> nms
src=. (<src) ,each ({."1 nms) ,each <'.svn',TEXTBASE
nms=. ({:"1 nms) ,each <'.svn-base'
src ,each nms
)
cleanlist=: 3 : 0
dir=. ~. y -. a:
msk=. (1 e. '.svn'&E.) &> dir
msk=. msk +. (1 e. '.snp'&E.) &> dir
dir #~ -.msk
)
dmenable=: 3 : 0
select. DMTAB
case. 'std' do.
  gtk_widget_show &> wsubdir,wtimestamp,wtype,wtypelabel
case. 'snp' do.
  gtk_widget_show &> wtimestamp,wtype,wtypelabel
  gtk_widget_hide &> wsubdir
case. 'svn' do.
  gtk_widget_hide &> wsubdir,wtimestamp,wtype,wtypelabel
  setlabel wpadding;40$' '
end.
0
)
dmindex=: 4 : 0
if. 0 = #x do. _1 else. x index y end.
)
dminfo=: 3 : 0
mbinfo title;y
)
dmjoin=: 4 : 0
if. 0 = L. y do.
  dat=. y
else.
  dat=. }. , LF ,. (>tohyphen each {."1 y) ,. ' ',. > {:"1 y
end.
dat=. x,'=: 0 : 0',LF,(termLF dat),')',LF
)
dmtypes=: 3 : 0
dat=. dlb each <;._2 termLF y
ndx=. dat i.&> ' '
ids=. toblank each ndx {.each dat
ext=. deb each ndx }. each dat
msk=. 0 < #&> ext
ids=. msk#ids
ext=. msk#ext
ndx=. I. ext = <,'*'
fmt=. ids ,each (<'') ndx} dmtypefmt each ext
ext;<fmt
)
dmtypefmt=: 3 : 0
' (',')',~}.;<@(',*.'&,);._1 ',',y -. ' '
)
dmrep=: 4 : 0
dat=. y
if. (0=#dat) +. 2=3!:0 dat do.
  if. LF e. dat do.
    dat=. dat, LF -. {:dat
    x,'=: 0 : 0', LF, ; <;.2 dat,')',LF
  else.
    x,'=: ',(quote dat),LF
  end.
else.
  x,'=: ',(":dat),LF
end.
)
expandn=: 4 : 0
y #~ (#y)$>:(-x){.0j1
)
filecopy=: 3 : 0
'source dest'=. y
if. 0 = fpathcreate fpath dest do. 0 return.
end.
if. IFWIN do.
  0 pick 'kernel32 CopyFileW i *w *w i' cd (uucp source);(uucp dest);0
else.
  datold=. fread :: 0: dest
  datnew=. fread :: 0: source
  if. -. datold -: datnew do.
    datnew fwrite dest
  end.
end.
1
)
fileread=: 1!:1
filecmp=: 4 : 0
src=. (< @: (1!:1))"0 x
tar=. (< @: (1!:1))"0 y
src = tar
)
fsetrw=: 3 : 0
if. IFWIN do.
  a=. 1!:6 <y
  if. 0=#a do. return. end.
  ('-' 0 } a) 1!:6 <y
else.
  a=. 1!:7 <y
  if. 0=#a do. return. end.
  ('rw' 0 1 } a) 1!:7 <y
end.
)
getsourcename=: 3 : 0
if. (DMTAB-:'svn') do.
  y=. fpathname &> y
  px=. < '.svn',TEXTBASE
  sx=. <'.svn-base'
  y=. ({."1 y) ,each px ,each ({:"1 y) ,each sx
end.
(<fmtdir dmsource) ,each y
)
getsourcename1=: getsourcename&.<
compare_init=: 3 : 0
select. IGNORESEP + 2 * IGNORELTW
case. 0 do.
  compare=: compare_jcompare_
  fcompare=: ('';0;[) fcomp_jcompare_ ]
case. 1 do.
  compare=: compare_jcompare_ & toJ
  fcompare=: ('';1;[) fcomp_jcompare_ ]
case. 2 do.
  compare=: compare_jcompare_ & remltws
  fcompare=: ('';2;[) fcomp_jcompare_ ]
case. 3 do.
  compare=: compare_jcompare_ & remltws & toJ
  fcompare=: ('';3;[) fcomp_jcompare_ ]
end.
i.0 0
)
maxlist=: 3 : '(DMMAX <. #r) {. r=. ~.y'
remltws=: 3 : 0
y=. (toJ y), LF
fn=. #~ ([: (+./\ *. +./\.) -.@(e.&(' ',TAB)))
dat=. fn each <;._2 y
}: ; dat ,each LF
)
requireproject=: 3 : 0
'require'~'~system/util/project.ijs'
)
tolist3=: 3 : 0
}. , LF ,. listfmt y
)
tolist6=: 3 : 0
dat=. ((2 * #y),3) $ ,y
}: tolist 2 expandn <"1 listfmt dat
)
listfmt=: 3 : 0
nm=. > 0 {"1 y
ts=. tsfmt > 1 {"1 y
ts=. ' ' ,. ts ,. ' '
sz=. ": ,. > 2 {"1 y
nm ,. ts ,. sz
)
tsfmt=: 3 : 0
r=. }: $ y
t=. 2 1 0 3 4 5 {"1 [ _6 [\ , 6 {."1 <. y
d=. '--#::' 2 6 11 14 17 }"1 [ 2 4 5 3 3 3 ": t
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
d=. ,((1 {"1 t) { mth) 3 4 5 }"1 d
d=. '0' (I. d=' ') } d
d=. ' ' (I. d='#') } d
(r,20) $ d
)
getdir=: 3 : 0

r=. i.0 3
path=. y
ifsvn=. '.svn' -: _4 {. path
if. ifsvn do.
  fl=. 1!:0 path,TEXTBASE,'*'
  fl=. fl #~ (<'.svn-base') = _9 {. each {."1 fl
  path=. _4 }. path
  r=. r, (path&, each _9 }. each {."1 fl),.1 2{"1 fl
else.
  fl=. 1!:0 path,'*'
  if. #fl do.
    att=. > 4{"1 fl
    fl=. fl #~ ('h' ~: 1{"1 att) *. 'd' ~: 4{"1 att
  end.
  r=. r, (path&, each {."1 fl),.1 2{"1 fl
end.
if. DMSUBDIR do.
  dl=. 1!:0 path,'*'
  if. #dl do.
    att=. > 4{"1 dl
    dl=. dl #~ ('h' ~: 1{"1 att) *. 'd' = 4{"1 att
    dr=. {."1 dl
    dr=. dr -. DMTREEX
    if. #dr do.
      dr=. (path&, @ ,&('/',ifsvn#'.svn')) each dr
      r=. r, ; getdir each dr
    end.
  end.
end.
if. #r do.
  r=. (filecase L:0 {."1 r) 0 }"0 1 r
end.
if. -. (<,'*') e. DMX do.
  fls=. {."1 r
  ndx=. 1 + fls i: &> '.'
  msk=. (ndx }.each fls) e. DMX
  r=. msk # r
end.

sort r
)
dm_cursor_changed=: dm_row_activated=: dm_key_press=: 0:
dm_wsource_changed=: 3 : 0
if. NoEvents do. 0 return. end.
if. DMTAB-:'snp' do. dm_wsource_changed_snp'' end.
)
dm_wtarget_changed=: 3 : 0
if. NoEvents do. 0 return. end.
if. DMTAB-:'snp' do. match_reshow 1 end.
1
)
dm_wtype_changed=: 3 : 0
if. NoEvents do. 0 return. end.
if. _1 = gtk_combo_box_get_active {.y do. 0 return. end.
match_reshow 1
1
)
wdm_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Return do. 0 return. end.
dm_match_button''
)
window_close=: 3 : 0
dmsaverecent''
readwinpos 'DirmPos'
gtk_widget_destroy window
1
)
window_key_press=: 3 : 0
if. isesckey y do.
  window_close''
else.
  0
end.
)
dm_compare_button=: comparefiles
dm_compareall_button=: compareallfiles
dm_copy_button=: copy1
dm_ignore_button=: ignore
dm_match_button=: match
dm_open_button=: openfile
dm_subdir_button=: match_reshow bind 1
dm_timestamp_button=: match_reshow bind 1
dm_view_button=: viewfile
dm_xdiff_button=: xdiff

about_activate=: helpabout
filedir_activate=: swap bind 'std'
filefav_activate=: fav_run
filesnap_activate=: swap bind 'snp'
filesvn_activate=: swap bind 'svn'
help_activate=: help
quit_activate=: window_close
toswap_activate=: swapdirs
tocopysrc_activate=: copysource
tocopylater_activate=: copylater
tocopyall_activate=: copyall
window_delete=: 3 : 0
window=: 0
)

wsource_key_press=: wtarget_key_press=: wtype_key_press=: wdm_key_press
fav_run=: 3 : 0
if. 0=#DMFavorites do.
  msg=. 'No favorites defined.',LF2
  msg=. msg,'See menu Edit|Configure|Directory Match.'
  dminfo msg return.
end.
a=. cocreate''
coinsert__a coname''
fav_run1__a coname''
)
fav_run1=: 3 : 0
locP=: y
window_delete=: fav_close
newwindow (gettext 'dirmatch favorites')
windowdefaultsize 600 300
gtk_window_set_type_hint window,GDK_WINDOW_TYPE_HINT_DIALOG
gtk_window_set_destroy_with_parent window,1
gtk_window_set_modal window,1
windowcenter''
sw=. newsw''
tv=: makelistgrid 'fav';('Source';'Target');DMFavorites;'';'';3
setchildfocus tv
gtk_container_add sw,tv
gtk_container_add window,sw
windowfinish''
)
fav_key_press=: 3 : 0
if. isesckey y do. fav_close'' else. 0 end.
)
fav_close=: 3 : 0
gtk_widget_destroy window
cbfree''
codestroy''
1
)
fav_row_activated=: 3 : 0
row=. listbox_getactiverow tv
sel=. deb each row { DMFavorites
DMDIRS__locP=: ~. sel, DMDIRS
dm_write_std__locP''
fav_close''
)
help=: 3 : 'smoutput ''help not yet'''
helpabout=: 3 : 'smoutput ''helpabout not yet'''
comparefiles=: 3 : 0
if. 0 = #name=. getfoundname2'' do.
  dminfo (gettext 'Nothing to compare')
else.
  textview dmcompare name
end.
1
)
compareallfiles=: 3 : 0
nms=. {."1 DIFFCONT
res=. ''
for_n. nms do.
  src=. getsourcename1 > n
  tar=. (fmtdir DMTARGET), > n
  res=. res, dmcompare src;tar
  res=. res, LF, LF
end.
res=. _2 }. res
if. 0=#res do.
  dminfo (gettext 'Nothing to compare')
else.
  textview res
end.
1
)
copy1=: 3 : 0
if. isempty name=. getfoundname2'' do.
  name=. getfoundname1''
end.
if. isempty name do.
  txt=. (gettext 'No file selected')
  dminfo txt return.
end.

name=. boxopen name
if. 2 = #name do.
  'fm to'=. name
else.
  fm=. 0 pick name
  to=. (fmtdir dmtarget), (#fmtdir dmsource) }. fm
end.

fm=. jpathsep fm
fms=. tofoldername fm
to=. jpathsep to

svn=. (DMTAB-:'svn') # ' Subversion'
txt=. (gettext 'OK to copy from'),svn,(gettext ' source to target: '),LF2,fms

if. -. mbnoyes title; txt do. return. end.
res=. filecopy fm;to
if. res = 0 do.
  txt=. (gettext 'Unable to copy file')
  dminfo txt
else.
  if. DMTAB-:'svn' do.
    fsetrw to
  end.
  remfound fm
end.
1
)
copyall=: 3 : 0
not=. {."1 NOTINTARGET
dif=. ({."1 DIFFCONT), {."1 DIFFTIME
fls=. not, dif
if. 0 = # fls do.
  dminfo (gettext 'No source files to copy')
  1 return.
end.
fm=. getsourcename fls
to=. (fmtdir DMTARGET)&, each fls
to docopy fm
1
)
copylater=: 3 : 0
dif=. DIFFCONT,DIFFTIME
msk=. (4 {"1 dif) earlier 1 {"1 dif
fls=. msk # {."1 dif
if. 0 = # fls do.
  dminfo (gettext 'No source files to copy') return.
end.
fm=. getsourcename fls
to=. (fmtdir DMTARGET)&, each fls
to docopy fm
1
)
copysource=: 3 : 0
if. 0 = # NOTINTARGET do.
  dminfo (gettext 'No source files to copy')
  1 return.
end.
fm=. getsourcename {."1 NOTINTARGET
to=. (fmtdir DMTARGET)&, each {."1 NOTINTARGET
to docopy fm
1
)
deletetarget=: 3 : 0
if. 0 = # NOTINSOURCE do.
  dminfo (gettext 'No target files to delete')
  1 return.
end.
nms=. (fmtdir DMTARGET)&, each {."1 NOTINSOURCE
if. mbnoyes title; (gettext 'OK to delete:'),LF2,tolist nms do.
  ferase nms
  match''
end.
1
)
docopy=: 4 : 0
to=. x
fm=. y
fms=. tofoldername y
msg=. title; (gettext 'OK to copy:'),LF2,tolist fms
if. -. mbnoyes msg do. return. end.
res=. filecopy"1 fm ,. to
if. 0 e. res do.
  txt=. (gettext 'Unable to copy:'),LF2,tolist (res=0)#fms
  dminfo txt
end.
if. 1 e. res do.
  match''
end.
)
enablefound=: 3 : 0
setenable"1 FoundButtons,.y
)
ignore=: 3 : 0
nms=. getignorenames''
if. isempty nms do.
  dminfo (gettext 'No file selected') return.
end.

msk=. -. ({."1 DIFFCONT) e. nms
DIFFCONT=: msk # DIFFCONT
DIFFCONTST=: msk # DIFFCONTST

msk=. -. ({."1 DIFFTIME) e. nms
DIFFTIME=: msk # DIFFTIME
DIFFTIMEST=: msk # DIFFTIMEST

NOTINSOURCE=: nms ignore1 NOTINSOURCE
NOTINTARGET=: nms ignore1 NOTINTARGET
match_fmt''
dm_showfind''
1
)
ignore1=: 4 : 0
y #~ -. ({."1 y) e. x
)
ignoreltw=: 3 : 0
IGNORELTW=: -. IGNORELTW
wd 'set mignoreltw ',":IGNORELTW
compare_init''
i.0 0
)
ignorens=: 3 : 0
IGNORENS=: -. IGNORENS
match_reshow''
)
ignorens_do=: 3 : 0
if. IGNORENS do.
  NOTINTARGET=: 0 # NOTINTARGET
end.
)
ignorent=: 3 : 0
IGNORENT=: -. IGNORENT
match_reshow''
)
ignorent_do=: 3 : 0
if. IGNORENT do.
  NOTINSOURCE=: 0 # NOTINSOURCE
end.
)
ignoresep=: 3 : 0
IGNORESEP=: -. IGNORESEP
wd 'set mignoresep ',":IGNORESEP
compare_init''
EMPTY
)
ignorest=: 3 : 0
IGNOREST=: -. IGNOREST
match_reshow''
)
ignorest_do=: 3 : 0
if. -. IGNOREST do. return. end.
if. -. 1 e. DIFFCONTST, DIFFTIMEST do. return. end.
if. #DIFFCONT do.
  DIFFCONT=: (-. DIFFCONTST) # DIFFCONT
  DIFFCONTST=: (#DIFFCONT) $ 0
end.
if. #DIFFTIME do.
  DIFFTIME=: (-. DIFFTIMEST) # DIFFTIME
  DIFFTIMEST=: (#DIFFTIME) $ 0
end.
)
openfile=: 3 : 0
if. 0=#name=. getfoundname1'' do.
  dminfo (gettext 'No file selected')
else.
  try.
    edit_opentab_show__locEdit name
  catch. dminfo (gettext 'Unable to open: '),name
  end.
end.
1
)
swap=: 3 : 0
if. y -: DMTAB do. return. end.
select. y
case. 'std' do.
  setlabel wtypelabel;<'_Project:'
case. 'snp' do.
case. 'svn' do.
  mbinfo (gettext 'not yet') return.
end.
written=: 0
DMTAB=: y
1
)
swapdirs=: 3 : 0
dm_read''
'DMSOURCE DMTARGET'=: DMTARGET ; DMSOURCE
DMDIRS=: (DMSOURCE;DMTARGET),2}.DMDIRS
dm_write''
match_reshow 1
1
)
viewfile=: 3 : 0
if. 0=#name=. getfoundname1'' do.
  dminfo (gettext 'No file selected')
else.
  dat=. freads name
  if. dat -: _1 do.
    dminfo (gettext 'Unable to view: '),name
  else.
    textview name;dat
  end.
end.
1
)
xdiff=: 3 : 0
if. 0=#XDiff do.
  mbinfo (gettext 'First define an external differencer in the base config')
  1 return.
end.
if. 0=#name=. getfoundname2'' do.
  dminfo (gettext 'Nothing to compare')
else.
  'a b'=. name
  forkcmd XDiff,' "',a,'" "',b,'"'
end.
1
)
getfoundname1=: 3 : 0
if. isempty dat=. getnames '' do. '' return. end.
'prev name next'=. dat
if. isempty name do. '' return. end.
if. prev -: name do.
  DMTARGET joindirname name
elseif. name -: next do.
  getsourcename1 name
elseif. (<name) e. {."1 NOTINSOURCE do.
  DMTARGET joindirname name
elseif. (<name) e. {."1 NOTINTARGET do.
  getsourcename1 name
elseif. do.
  ''
end.
)
getfoundname2=: 3 : 0
if. isempty dat=. getnames '' do. '' return. end.
'prev name next'=. dat
if. prev -: name do.
  'first second'=. prev;name
elseif. name -: next do.
  'first second'=. name;next
elseif. do.
  '' return.
end.
(getsourcename1 first);DMTARGET joindirname second
)
getignorenames=: 3 : 0
dat=. getnames ''
if. isempty dat do. '' return. end.
if. isempty 1 pick dat do. '' return. end.
dat -. a:
)
getnames=: 3 : 0
if. 0=#found do. '' return. end.
ndx=. listbox_getactiverow wfound
if. ndx=_1 do. '' return. end.
ndx=. ndx + 0 1 2
dat=. a: , found , a:
if. 0 e. ndx e. i. # dat do. '' return. end.
res=. getname1 each ndx { dat
if. 0=#;res do. '' end.
)
joindirname=: 4 : 0
(fmtdir x), y
)
getname1=: 3 : 0
dat=. deb |. y
ndx=. I. dat = ' '
if. 2 < # ndx do.
  |. (1 + 2 { ndx) }. dat
else.
  ''
end.
)
remfound=: 3 : 0
fm=. <y
dms=. jpathsep dmsource, '/'

msk=. fm ~: dms&, each {."1 DIFFCONT
if. 0 e. msk do.
  DIFFCONT=: msk # DIFFCONT
  DIFFCONTST=: msk # DIFFCONTST
end.

msk=. fm ~: dms&, each {."1 DIFFTIME
if. 0 e. msk do.
  DIFFTIME=: msk # DIFFTIME
  DIFFTIMEST=: msk # DIFFTIMEST
end.

msk=. fm ~: dms&, each {."1 NOTINTARGET
if. 0 e. msk do.
  NOTINTARGET=: msk # NOTINTARGET
end.

match_fmt''
dm_showfind listbox_getscroll wfound
)
match=: 3 : 0
dm_read''
if. isempty DMSOURCE do.
  dminfo (gettext 'Enter the source directory') return.
end.
if. isempty DMTARGET do.
  dminfo (gettext 'Enter the target directory') return.
end.
DMDIRS=: ~. filecase each (DMSOURCE;DMTARGET),DMDIRS
matches 0
noevents 1
dm_showfind''
dmsaverecent''
dm_write''
matched=: 1
noevents 0
)
matches=: 3 : 0
DMFOUNDCONTENTS=: DMFOUNDALL=: ''
if. match_do '' do.
  match_fmt y
end.
)
matchclear=: 3 : 0
DMFOUNDCONTENTS=: DMFOUNDALL=: ''
dm_showfind''
)
match_do=: 3 : 0

NOTINSOURCE=: NOTINTARGET=: ''
DIFFTIME=: DIFFCONT=: i.0 6
DIFFTIMEST=: DIFFCONTST=: ''

DMX=: ' ,' cutopen DMTypeX pick DMTypeT
dmsource=: DMSOURCE
dmtarget=: DMTARGET

src=. fmtdir dmsource
tar=. fmtdir dmtarget

dx=. getdir src, (DMTAB-:'svn') # '.svn'
dy=. getdir tar

if. (0=#dx) *. 0=#dy do.
  0 [ dminfo (gettext 'Both directories are empty') return.
end.
fx=. {."1 dx
fy=. {."1 dy

fx=. (#src) }. each fx
fy=. (#tar) }. each fy
dx=. fx ,. }."1 dx
dy=. fy ,. }."1 dy
NOTINTARGET=: (-. fx e. fy) # dx
NOTINSOURCE=: (-. fy e. fx) # dy

dx=. (fx e. fy) # dx
dy=. (fy e. fx) # dy
dxy=. dx ,. dy

if. 0 e. #dx do. 1 return. end.
msk=. (2 {"1 dx) ~: 2 {"1 dy
if. 1 e. msk do.
  DIFFCONT=: msk # dxy
  msk=. -. msk
  dx=. msk # dx
  dy=. msk # dy
  dxy=. msk # dxy
end.
nms=. {."1 dx

if. DMTAB-:'svn' do.
  snm=. addtextbase nms;src
else.
  snm=. src&, each nms
end.

cmp=. snm filecmp tar&, each nms
DIFFCONT=: sort DIFFCONT, (cmp = 0) # dxy
DIFFCONTST=: (1 {"1 DIFFCONT) earlier 4 {"1 DIFFCONT
if. DMTIMESTAMP do.
  dx=. cmp # dx
  dy=. cmp # dy
  dxy=. cmp # dxy
  msk=. -. dx e. dy
  if. 1 e. msk do.
    DIFFTIME=: msk # dxy
    DIFFTIMEST=: (1 {"1 DIFFTIME) earlier 4 {"1 DIFFTIME
  end.
end.
1
)
earlier=: 4 : 0
_2 </ \ /: /: , x ,. y
)
match_fmt=: 3 : 0
ignorens_do''
ignorent_do''
ignorest_do''

count=. {. y,1
DMFOUNDCONTENTS=: DMFOUNDALL=: ''

hit=. +/ (#DIFFCONT),(#DIFFTIME),(#NOTINSOURCE),#NOTINTARGET

if. 0 = hit do.
  dminfo count pick (gettext 'Contents match');(gettext 'Contents now match')
  return.
end.

if. #DIFFCONT do.
  DMFOUNDCONTENTS=: (gettext 'different contents - source,target: '),LF,(tolist6 DIFFCONT),LF2
end.

txt=. ''
if. #NOTINSOURCE do.
  txt=. txt, (gettext 'not in source: '),LF,(tolist3 NOTINSOURCE),LF2
end.

if. #NOTINTARGET do.
  txt=. txt, (gettext 'not in target: '),LF,(tolist3 NOTINTARGET),LF2
end.

if. #DIFFTIME do.
  txt=. txt, (gettext 'different timestamp - source,target: '),LF,(tolist6 DIFFTIME),LF2
end.

DMFOUNDALL=: txt, DMFOUNDCONTENTS
)
match_reshow=: 3 : 0
if. -. matched do. 1 return. end.
force=. {.y,0
if. force +. (dmsource-:DMSOURCE) *: dmtarget-:DMTARGET do.
  match''
else.
  dm_read''
  match_fmt 0
  dm_showfind''
end.
1
)
menu_init=: 3 : 0
f=. < @ (<;._1) @ (','&,)
j=. f;._2 Menus
MENUIDS=: {.&> j
MENUDEF=: }.each j
0
)
Menus=: fixNB_jp_ 0 : 0
about,gtk-about,_About,,Help About,about_activate
filedir,check1,Source from _Directory,,Source from Directory,filedir_activate
filefav,,Select from _Favorites,,Select from Favorites,filefav_activate
filesnap,check0,Source from _Snapshot,,Source from Snapshot,filesnap_activate
filesvn,check0,Source from _Subversion,,Source from Subversion,filesvn_activate
help,,_Help,,Help,help_activate
quit,gtk-quit,_Quit,cQ,Quit the program,quit_activate
toswap,,Swap source and target directories,,Swap source and target directories,toswap_activate
tocopysrc,,Copy source files not in target,,Copy source files not in target,tocopysrc_activate
tocopylater,,Copy source files later than target,,Copy source files later than target,tocopylater_activate
tocopyall,,Copy all source files,,Copy all source files,tocopyall_activate
)
dm_menu=: 3 : 0
mb=. create_menu_bar''
pop=. create_menu_popup mb;(gettext '_File')
con=. create_menu_container pop
if. DMTAB-:'std' do.
  mnFav=: con ccmenu 'filefav'
  create_menu_sep con
end.

con ccmenu 'quit'
pop=. create_menu_popup mb;(gettext '_Tools')
con=. create_menu_container pop
con ccmenu 'toswap'
con ccmenu 'tocopysrc'
con ccmenu 'tocopylater'
con ccmenu 'tocopyall'
gtk_widget_show_all mb
mb
)
Labstd=: (gettext '_Source:');(gettext '_Target:');(gettext 'T_ype:')
Labsnp=: (gettext '_Project:');(gettext '_Source:');(gettext '_Target:')
dm_open=: 3 : 0
if. window do.
  setwindowfocus window return.
end.
written=: matched=: 0
found=: ''
a=. GTK_FILL
b=. GTK_EXPAND + GTK_FILL
noevents 1
newwindow title
DirmPos setwinpos window
consig3 window;'key-press-event';'window_key_press'
gtk_window_set_icon_from_file window;EditIcon;0
tb=. gtk_table_new 3 3 0
labs=. (DMTAB-:'snp') pick Labstd;<Labsnp
tc=. gtk_table_new 2 3 0
label=. gtk_label_new_with_mnemonic 0{labs
gtk_misc_set_alignment label, 1 0.5
wsource=: newcombo '';'dm_wsource_changed'
w=. gtk_bin_get_child wsource
consig3 w;'key-press-event';'wsource_key_press'
gtk_table_attach tc,label,0 1 0 1,a,0 3 0
gtk_table_attach tc,wsource,2 3 0 1,b,0 3 0

label=. gtk_label_new_with_mnemonic 1{labs
gtk_misc_set_alignment label, 1 0.5
wtarget=: newcombo '';'dm_wtarget_changed'
w=. gtk_bin_get_child wtarget
consig3 w;'key-press-event';'wtarget_key_press'
gtk_table_attach tc,label,0 1 1 2,a,0 3 0
gtk_table_attach tc,wtarget,2 3 1 2,b,0 3 0

wtypelabel=: gtk_label_new_with_mnemonic 2{labs
gtk_misc_set_alignment wtypelabel, 1 0.5
wtype=: newcombo '';'dm_wtype_changed'
w=. gtk_bin_get_child wtype
consig wtype;'changed';'dm_wtype_changed'
gtk_table_attach tc,wtypelabel,0 1 2 3,a,0 3 0
gtk_table_attach tc,wtype,2 3 2 3,b,0 3 0
gtk_table_attach tb,tc,0 1 0 1,b,0 6 6
align=. gtk_alignment_new 0 0 0 0
vb=. gtk_vbox_new 0 0
wtimestamp=: newcheckbox (gettext 'Compare timestamps');'dm_timestamp_button'
wsubdir=: newcheckbox (gettext 'Include subdirectories');'dm_subdir_button'
wpadding=: newlabel ' '
gtk_box_pack_start vb,wtimestamp,0 0 0
gtk_box_pack_start vb,wsubdir,0 0 0
gtk_box_pack_start vb,wpadding,0 0 0
gtk_container_add align,vb
gtk_table_attach tb,align,1 2 0 1,a,a,15 8
hb=. gtk_vbox_new 0 0
bt=. newbutton (gettext '_Match');'dm_match_button'
gtk_box_pack_start hb,bt,0 0 0
gtk_table_attach tb,hb,2 3 0 1,a,a,6 8
hs=. gtk_hseparator_new ''
gtk_table_attach tb,hs,0 3 1 2,b,0 0 3
sw=. newsw''
wfound=: makelistbox 'dm';'';'';'';1
gtk_container_add sw,wfound
gtk_table_attach tb,sw,0 2 2 3,b,b,0 0
vb=. gtk_vbox_new 0 0
r=. $0
r=. r,newxbutton vb;(gettext '_Compare All');'dm_compareall_button'
r=. r,newxbutton vb;(gettext 'Compare Se_lect');'dm_compare_button'
if. #XDiff_j_ do.
  r=. r,newxbutton vb;(gettext 'E_xternal Diff');'dm_xdiff_button'
end.
r=. r,newxbutton vb;(gettext '_Open');'dm_open_button'
r=. r,newxbutton vb;(gettext '_View');'dm_view_button'
r=. r,newxbutton vb;(gettext 'Co_py');'dm_copy_button'
r=. r,newxbutton vb;(gettext '_Ignore');'dm_ignore_button'
gtk_table_attach tb,vb,2 3 2 3,a,a, 6 0
FoundButtons=: r
vb=. gtk_vbox_new 0 0
gtk_container_set_border_width vb,0
mb=. dm_menu ''
gtk_box_pack_start vb,mb,0 0 0
gtk_box_pack_start vb,tb,1 1 0
gtk_container_add window,vb
windowfinish''
enablefound 0
noevents 0
)
dm_compare_snp=: 3 : 0
's t'=. y
p=. 1 i.~ '/snap/.snp/' E. ]
s=. '~snapshot',(51 + p s) }. s
ndx=. p t
if. ndx < #t do.
  t=. '~snapshot',(51 + ndx) }. t
else.
  t=. tofoldername_j_ t
end.
(<s;t) fcompare y
)

dm_init_snp=: 3 : 0
DMSUBDIRS=: 1
DMPROJECTS=: DMPROJECT=: DMSNAPS=: ''
if. 0=#Folder do.
  dminfo (gettext 'No Folder defined')
  0 return.
end.
DMPROJECTS=: (<Folder,'/') ,each FolderIds
if. 0=#DMPROJECTS do.
  dminfo (gettext 'No projects in folder')
  0 return.
end.
if. #y do.
  DMPROJECT=: 0 pick y
else.
  if. 0=nc <'ProjectName_jp_' do.
    DMPROJECT=: ProjectName_jp_
  else.
    DMPROJECT=: 0 pick DMPROJECTS
  end.
end.
dmcompare=: dm_compare_snp
dm_proj_snp''
1
)
dm_proj_snp=: 3 : 0
DMSNAPS=: ss_list_jp_ DMPROJECT
DMSNAPTGT=: 'Current'
if. 0=#DMSNAPS do.
  dminfo (gettext 'No snapshots in project')
  DMSNAPSRC=: ''
  0 return.
end.
DMSNAPSRC=: 0 pick DMSNAPS
)
dm_read_snp=: 3 : 0
if. NoEvents do. 0 return. end.
DMPROJECT=: readcombo wsource
DMSNAPSRC=: readcombo wtarget
DMSNAPTGT=: readcombo wtype
DMPROJECTS=: maxlist (<DMPROJECT),DMPROJECTS
p=. projname2path_jp_ DMPROJECT
s=. snappath_jp_ p
DMSOURCE=: s,'/',DMSNAPSRC
if. DMSNAPTGT-:'Current' do.
  DMTARGET=: p
else.
  DMTARGET=: s,'/',DMSNAPTGT
end.
)
dm_write_snp=: 3 : 0
dmenable''
if. 0=#DMSNAPS do.
  dminfo (gettext 'No snapshots') return.
end.
if. written=0 do.
  setcombo_text wsource;<DMPROJECTS
  setcombo_select wsource;DMPROJECTS index <DMPROJECT
  written=: 1
end.
setcombo_text wtarget;<DMSNAPS
setcombo_select wtarget;DMSNAPS i. <DMSNAPSRC
a=. (<'Current'),DMSNAPS
setcombo_text wtype;<a
setcombo_select wtype;a i. <DMSNAPTGT
)
dm_wsource_changed_snp=: 3 : 0
p=. readcombo wsource
if. DMPROJECT -: p do. return. end.
noevents 1
DMPROJECT=: p
dm_proj_snp''
dm_write_snp''
noevents 0
match''
)
dm_compare_std=: 3 : 0
(<tofoldername each y) fcompare y
)
dm_init_std=: 3 : 0
DMDIRS=: ~.y,DMDIRS
dmcompare=: dm_compare_std
EMPTY
)
dm_read_std=: 3 : 0
DMSOURCE=: jpath readcombo wsource
DMTARGET=: jpath readcombo wtarget
t=. deb readcombo wtype
if. -. (<t) e. DMTypeN do.
  s=. t #~ *./\. t~:'.'
  DMTypeN=: DMTypeN,<t
  DMTypeT=: DMTypeT,<s
end.
DMTypeX=: DMTypeN i. <t
DMTIMESTAMP=: readcheckbox wtimestamp
DMSUBDIR=: readcheckbox wsubdir
DMDIRS=: maxlist (DMSOURCE;DMTARGET),DMDIRS
)
dm_write_std=: 3 : 0
dmenable''
setcheckbox wsubdir,DMSUBDIR
setcheckbox wtimestamp,DMSTIMESTAMP
if. written=0 do.
  setcombo_text wtype;<DMTypeN
  setcombo_select wtype;DMTypeX
  written=: 1
end.
if. -. DMDIRS -: DMDIRSOLD do.
  setcombo_text wsource;<DMDIRS
  setcombo_text wtarget;<DMDIRS
end.
if. #DMDIRS do.
  setcombo_select wsource;0
  setcombo_select wtarget;1
end.
)
dm_showfind=: 3 : 0
found=: <;._2 DMCONTENTS pick DMFOUNDALL;DMFOUNDCONTENTS
setlistbox wfound;found;_1;y
enablefound 1
)
dm_read=: 3 : 0
('dm_read_',DMTAB)~''
)
dm_write=: 3 : 0
('dm_write_',DMTAB)~''
)
dmrun=: 3 : 0
dm_init y
dm_open''
dm_write''
if. DMRUN do. match'' end.
)
dmrunstd=: 3 : 0
empty dmrun (<'std'),y
)
dirmatch_z_=: dmrunstd_jgtkdirm_
coclass 'jgtkdlog'
coinsert 'jgtkide'
create=: 3 : 0
coextend COCREATOR
if. 0=#InputLog do.
  mbinfo (gettext 'Input Log');(gettext 'Nothing in input log.')
  destroy'' return.
end.
make_dlog''
)
destroy=: 3 : 0
cbfree''
codestroy''
)
dlog_row_activated=: 3 : 0
row=. listbox_row_activated y
txt=. 0 delmode row pick InputLog
promptnewlog__COCREATOR txt
dlog_close''
)
dlog_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Escape do. 0 return. end.
'ctrl j shift'=. 2 2 2 #: state
if. ctrl +. shift do. 0 return. end.
dlog_close''
1
)
dlog_close=: 3 : 0
readwinpos 'DlogPos'
setchildfocus window__locTerm
WinDLog_jgtkide_=: 0
gtk_widget_destroy window
destroy''
1
)

dlog_cursor_changed=: 1:
window_delete=: dlog_close
delprompt=: ]
make_dlog=: 3 : 0
newwindow (gettext 'Input Log')
WinDLog_jgtkide_=: window
windowdefaultsize 300 300 >. 2 3{DlogPos
gtk_window_set_type_hint window,GDK_WINDOW_TYPE_HINT_DIALOG
gtk_window_set_destroy_with_parent window,1
gtk_window_set_modal window,1
windowcenter''
sw=. newsw''
txt=. delprompt InputLog
tv=. makelistbox 'dlog';txt;(<:#txt);'';0
setchildfocus tv
gtk_container_add sw,tv
gtk_container_add window,sw
windowfinish''
)
coclass 'jgtkedit'
coinsert 'jgtkide jp'

NBgroup=: mema IF64{4 8
Comment=: 'NB.'
create=: 3 : 0
windex=: y
Class=: 'edit'
locEdit0=: y{locEdits
locEdit1=: (-.y){locEdits
EditNB=: 0
EditPage=: _1
EditTabs=: i.0 11
SideDir=: ''
VisPos=: ''
sbShow=: 1
window=: 0
autoCp=: 0
locCcp=: ''
)
destroy=: 3 : 0
cbfree''
codestroy''
0
)
Gray=: rgb2gtk 232 232 232
getselext=: 3 : 0
r=. (1 + y i: '.') }. y
if. 0=#r do. 0 pick ValExt end.
)
getdirscripts=: 3 : 0
p=. termsep_j_ y
d=. 1!:0 p,'/*'
if. 0=#d do. '' return. end.
f=. ({."1 d) #~ '--' -:"1 [ 1 4 {"1 > 4{"1 d
f=. f #~ ((1 + f i:&> '.') }.each f) e. ValExt
fexists (<p) ,each f
)
getdirtext=: 3 : 0
p=. termsep_j_ y
d=. 1!:0 p,'/*'
if. 0=#d do. '' return. end.
d=. d #~ '--' -:"1 [ 1 4 {"1 > 4{"1 d
ex=. <'svg'
d=. d #~ ex ~: (}.~ 1 + i:&'.') each {."1 d
f=. ({."1 d) #~ MaxText>;2 {"1 d
f=. (<p) ,each f
istext=. isutf8 @ (1!:1) :: 0:
f #~ istext"0 f
)
gettabx=: 3 : '(0{"1 EditTabs) index <y'
gettabn=: 3 : '(1{"1 EditTabs) index <y'
readline=: 3 : 'bufreadline pSB,y'
readentry=: 3 : '1;bufreadline pSB,y'
getxpage=: 3 : '(1{"1 EditTabs__locEdit1) index <y'
edit_sname=: 3 : 0
'f p'=. fpathname y
if. y -: ProjectPath_jp_,'/',p do. p return. end.
remtilde tofoldername_j_ y
)
is_script=: 3 : 0
(<(1+y i: '.') }. y) e. ValExt
)
movewordsv=: 3 : 0
edit_current_def''
moveword y,pSB,pSV
)
pageswitched=: 3 : 0
tab_refresh''
0
)
selectopenfile=: 3 : 0
p=. gettabn y
setcurrentpage p
p
)
showsidebar=: 3 : 0
if. sbShow do.
  gtk_widget_show EditSB
else.
  gtk_widget_hide EditSB
end.
)
tab_addtab=: 3 : 0
edit_open''
EditPage=: edit_opentab1 y
gtk_notebook_set_current_page EditNB,EditPage
script_menu_enable''
edit_current_def''
)
tabread=: 3 : 0
2 tab_save''
edit_current_def''
if. EditPage<0 do. '';'' return. end.
pFL;tab_readall''
)
tab_readall=: 3 : 0
if. 0>p=. {.y,EditPage do. '' return. end.
bufread page_buf p
)
tab_readfile=: 3 : 0
ndx=. (1{"1 EditTabs) i. <y
if. ndx=#EditTabs do.
  freads y
else.
  bufread page_buf ndx
end.
)
tab_readselect=: 3 : 0
if. 0>p=. {.y,EditPage do. '' return. end.
bufreadselect page_buf p
)
tab_restore=: 3 : 0
buf=. page_buf EditPage
bufwrite buf;y
setmodified EditPage,0
1
)
tab_writefile=: 3 : 0
'file text'=. y
ndx=. (1{"1 EditTabs) i. <file
buf=. page_buf ndx
old=. fread file
cur=. fputs bufread buf
if. -. old -: cur do.
  cur pic_jp_ file
end.
bufwrite buf;fgets text
setmodified ndx,1
)
edit_hide=: 3 : 0
if. window=0 do. 1 return. end.
if. -. windex{Visible do. 1 return. end.
ccp_destroy''
if. -. 0 tab_saveall'' do. 0 return. end.
projsaveopen''
tab_closeall''
setchildfocus window__locTerm
setvisible 0
if. (-.windex){Visible do.
  window_focus_in__locEdit1''
else.
  locEdit_jgtkide_=: {. locEdits
end.
1
)
tab_close=: 3 : 0
ccp_destroy''
if. -.tab_close1 y do. 0 return. end.
tab_refresh''
1
)
tab_close1=: 3 : 0
noevents 1
r=. tab_closeit y
noevents 0
r
)
tab_closeit=: 3 : 0
if. y<0 do. 1 return. end.
f=. page_file y
sv=. page_sv y
if. tab_close_empty f do.
  setpos f;viewgettop sv
end.
gtk_notebook_remove_page EditNB,y
EditTabs=: (<<<y){EditTabs
1
)
tab_close_empty=: 3 : 0
if. (istempscript y) +. isconfigfile y do.
  if. 0=#fread y do. 0 [ ferase y return. end.
end.
1
)
tab_closes=: 3 : 0
if. 0=#y do. 1 return. end.
noevents 1
for_i. |. y do. tab_closeit i end.
tab_refresh''
noevents 0
1
)

tab_closeall=: 3 : 'tab_closes i.#EditTabs'
tab_closeother=: 3 : 'tab_closes EditPage -.~ i.#EditTabs'
tab_refresh=: 3 : 0
edit_current_def''
settitle''
sidebar_refresh''
script_menu_enable''
validate''
)
tab_remove=: 3 : 0
r=. y{EditTabs
gtk_notebook_remove_page EditNB,y
EditTabs=: (<<<y){EditTabs
tab_refresh''
r
)
checkdisk1=: (10 {:: ]) -: [: 1!:1 ::(''"_) 1 { ]
dontcheckdisk=: 0
checkdiskall=: 3 : 0
t=. (~:1{"1 t) # t=. EditTabs,EditTabs__locEdit1
b=. checkdisk1"1 t
if. *./b do. return. end.
checkdiskquery"1 (-.b)#t
)
checkdisk=: 3 : 0
if. checkdisk1 y do. return. end.
checkdiskquery y
)
checkdiskquery=: 3 : 0
if. dontcheckdisk do. return. end.
dontcheckdisk=: 1
(PageIds)=. y
new=. 1!:1 :: (''"_) <pFL
id=. pSN,(0=#pSN)#pFL
msg=. 'File contents changed on disk: ',id
msg=. msg,LF2,'Reload from disk?'
rel=. mbnoyes 'File changed';msg
setfiletext pFL;new;rel
setfiletext__locEdit1 pFL;new;rel
dontcheckdisk=: 0
)
cb_edit_changed=: 3 : 0
if. NoEvents do. 0 return. end.
setmodified EditPage,1
0
)
cb_edit_focus_in=: 3 : 0
n=. gtk_notebook_get_current_page {.y
if. n >: 0 do. checkdisk n{EditTabs end.
0
)
cb_edit_page_added=: 3 : 0
if. NoEvents do. 0 return. end.
ccp_destroy''
'n w p d'=. y
ndx=. ({."1 EditTabs) i. <w
if. ndx<#EditTabs do. 0 return. end.
ndx=. ({."1 EditTabx) i. <w
if. ndx=#EditTabx do. 0 return. end.
EditTabs=: (ndx{EditTabx),EditTabs
EditTabx_jgtkide_=: (<<<ndx){EditTabx
script_menu_enable''
1
)
cb_edit_page_removed=: 3 : 0
if. NoEvents do. 0 return. end.
ccp_destroy''
'n w p d'=. y
ndx=. ({."1 EditTabs) i. <w
if. ndx=#EditTabs do. 0 return. end.
EditTabx_jgtkide_=: EditTabx,ndx{EditTabs
EditTabs=: (<<<ndx){EditTabs
script_menu_enable''
setidle 'sidebar_refresh_',(>coname''),'_$0'
1
)
cb_edit_page_reordered=: 3 : 0
ccp_destroy''
'n w new d'=. y
old=. gettabx w
if. old=new do. 0 return. end.
p=. old{EditTabs
t=. (<<<old){EditTabs
EditTabs=: (new{.t),p,new}.t
EditPage=: new
0
)
cb_edit_switch_page=: 3 : 0
if. NoEvents do. 0 return. end.
ccp_destroy''
setidle 'pageswitched_',(>coname''),'_$0'
)
cb_edit_tab_close=: 3 : 0
noevents 1
ccp_destroy''
ndx=. page_index {.y
if. 0 = 0 tab_save ndx do. 1 return. end.
tab_close ndx
noevents 0
sidebar_refresh''
1
)
cb_toolbar_sidebar=: 3 : 0
setcheckmenu mnSideBar,-. sbShow
setcheckmenu mnAutoCp,-. autoCp
1
)
cx_edit_openedit=: 3 : 0
if. NoEvents do. 1 return. end.
ccp_destroy''
edit_open''
cx_edit_openeditp''
edit_current_def''
gtk_widget_show_all EditNB
seteditfocus''
sidebar_refresh''
showsidebar''
1
)
cx_edit_openeditp=: 3 : 0
if. #ProjOpen_jp_ do.
  po=. >{.ProjOpen
  if. (#>{.po) *. fexist Project_jp_ do.
    proj_openfiles''
    proj_fini'' return.
  end.
else.
  po=. ''
end.
proj_close''
sbfiles_open_folder Pathp
if. #po do.
  edit_openfiles (2}.po);0 ". 1 pick po
end.
)
cx_file_close=: 3 : 0
if. -.0 tab_save EditPage do. 0 return. end.
tab_close EditPage
1
)
cx_file_closeall=: 3 : 0
if. -.0 tab_saveall'' do. 0 return. end.
tab_closeall''
)
cx_file_closeother=: 3 : 0
if. -.0 tab_saveother'' do. 0 return. end.
tab_closeother''
)
cx_file_delete=: 3 : 0
if. 0=#EditTabs do. return. end.
'f s'=. 1 2 {EditPage{EditTabs
if. #f do.
  s=. remtilde toprojectfolder_jp_ f
end.
msg=. (gettext 'OK to delete '),s,'?'
if. mbcancelok (gettext 'File Delete');msg do.
  EditTabs=: (<0) (<EditPage;4)} EditTabs
  tab_close EditPage
  ferase ::] f
  sidebar_refresh''
end.
1
)
cx_file_new=: 3 : 0
if. 0=window__locEdit do. proj_close__locEdit'' end.
ccp_destroy''
f=. dialog 'file_new';''
if. 0=#f do. 1 return. end.
cx_file_newfini extdef f
)
cx_file_newtemp=: 3 : 0
if. 0=window__locEdit do. proj_close__locEdit'' end.
ccp_destroy''
p=. jpath '~temp/'
d=. {."1 [ 1!:0 jpath extdef p,'*'
if. 0=#d do.
  def=. extdef '1'
else.
  d=. d #~ istempname_j_ &> d
  d=. 0, (0 {.@". _4 }. ]) &> d
  def=. extdef ": {. (i. >: #d) -. d
end.
cx_file_newfini p,def
)
cx_file_newfini=: 3 : 0
'' fwrite y
recentfiles_add_j_ y
edit_opentab_show y;0;1
)
cx_file_open1=: 3 : 0
r=. dialog y
if. 0 = #r do. 0 return. end.
if. 0=window__locEdit do. proj_close__locEdit'' end.
recentfiles_add_j_ r
edit_opentab_show__locEdit r
1
)

cx_file_open=: cx_file_open1 bind 'file_open'
cx_file_openuser=: cx_file_open1 bind 'file_openuser'
cx_file_opensystem=: cx_file_open1 bind 'file_opensystem'
cx_file_opentemp=: cx_file_open1 bind 'file_opentemp'
cx_file_print=: 3 : 0
edit_current_def''
p=. conew 'jgtkideprint'
print__p pSV
destroy__p''
0
)
cx_file_restore=: 3 : 0
edit_current_def''
if. EditPage = _1 do. 1 return. end.
if. pMOD=0 do. 1 return. end.
s=. remtilde toprojectfolder_jp_ pFL
msg=. (gettext 'OK to restore to saved: '),s,'?'
if. -. mbcancelok (gettext 'File Restore');msg do. 1 return. end.
dat=. freads pFL
if. dat -: _1 do.
  mbinfo (gettext 'File Restore');(gettext 'Unable to read original file: '),s
  1 return.
end.
tab_restore dat
)
cx_file_saveas=: 3 : 0
edit_current_def''
f=. dialog 'file_saveas';pFL
if. 0=#f do. 1 return. end.
f=. extdef f
s=. 1 pick fpathname f
new=. pSW;f;s;0;1;1;pBTN;pLAB;pSV;pSB;''
EditTabs=: new EditPage} EditTabs
gtk_label_set_text pLAB;s
gtk_notebook_set_menu_label_text EditNB;pSW;s
file_save1 EditPage
tab_refresh''
1
)
sv_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. (key=GDK_Control_L) +. key=GDK_Shift_L do. 0 [ ccp_destroy'' return. end.
'ctrl j shift'=. 2 2 2 #: state
if. ccp_query'' do.
  if. ctrl do. 1 [ ccp_destroy'' return. end.
  select. key
  case. GDK_Escape do.
    1 [ ccp_destroy'' return.
  case. GDK_Up do.
    1 [ ccp_scroll _1 return.
  case. GDK_Down do.
    1 [ ccp_scroll 1 return.
  case. GDK_Page_Up do.
    1 [ ccp_scroll - CodeCompletionScroll return.
  case. GDK_Page_Down do.
    1 [ ccp_scroll CodeCompletionScroll return.
  case. GDK_Home do.
    1 [ ccp_scrollend _1 return.
  case. GDK_End do.
    1 [ ccp_scrollend 1 return.
  case. GDK_Tab do.
    1 [ ccp_word'' return.
  case. GDK_Return do.
    1 [ ccp_select'' return.
  case. <"0[3 u: ucp CodeCompletionKeyword do.
    ccp_renew key
  case. do.
    ccp_destroy''
  end.
end.
if. key e. GDK_FKeys do.
  fkey_exec__locTerm key,ctrl,shift return.
end.
if. ctrl > shift do.
  select. key
  case. GDK_Left do. movewordsv 0
  case. GDK_Right do. movewordsv 1
  case. GDK_Return do. cx_run_line''
  case. GDK_y do.
    edit_current_def''
    gtk_source_buffer_redo pSB
  case. 91 do.
    1 [ ccp_new _1 return.
  end.
end.
if. ctrl *. shift do.
  select. key
  case. GDK_Return do.
    cx_run_line_show 0 return.
  end.
end.
if. autoCp *. (-.ctrl) *. (key e. 3 u: ucp CodeCompletionKeyword) *. -.ccp_query'' do.
  if. (3>.AutoCompletion)<:1+#getcurrentccppfx'' do.
    ccp_new key
  end.
end.
if. ctrl +. shift do. 0 return. end.
select. key
case. GDK_Escape do.
  if. EscClose do. 1 [ edit_hide'' return. end.
end.
0
)
sv_populate_popup=: 3 : 'popup_init y'
window_focus_in=: 3 : 0
if. window = {.WinFocus do. return. end.
checkdiskall''
ppdef''
locEdit_jgtkide_=: locEdit0
setwinfocus window
)
window_focus_out=: 3 : 0
ppack''
)
window_key_press=: 3 : 0
if. isesckey y do.
  if. ccp_query'' do. 1 [ ccp_destroy'' return. end.
  if. EscClose do. 1 [ edit_hide'' return. end.
else.
  0
end.
)
window_delete=: edit_hide
window_destroy=: 3 : 0
if. window do.
  edit_hide''
  window=: 0
end.
1
)
export=: 3 : 0
smoutput 'export not yet'
1
)
edit_maketablabel=: 3 : 0
name=. y
hbox=. gtk_hbox_new 0 2
lb=. gtk_label_new <name
gtk_box_pack_start hbox,lb,0 0 0
btn=. gtk_button_new''
consig btn;'clicked';'cb_edit_tab_close'
gtk_button_set_relief btn,GTK_RELIEF_NONE
gtk_button_set_focus_on_click btn,0
gtk_widget_set_name btn;'tab-close-button'
image=. gtk_image_new_from_stock GTK_STOCK_CLOSE;GTK_ICON_SIZE_MENU
gtk_button_set_image btn,image
align=. btn newalign 1 0 0 0
gtk_box_pack_start hbox,align,1 1 0
hbox,btn,lb
)
edit_open=: 3 : 0
if. window do. edit_show'' return. end.
noevents 1

newwindow (gettext 'Edit')
seteditpos ''

consig3 window;'key-press-event';'window_key_press'
consig3 window;'focus-in-event';'window_focus_in'
consig3 window;'focus-out-event';'window_focus_out'

if. -.UNAME-:'Darwin' do.
  gtk_window_set_icon_from_file window;EditIcon;0
end.
EditSB=: sidebar_init''

vb=. gtk_vbox_new 0 0
tb=. make_edittoolbar''
EditNB=: gtk_notebook_new''
consig3 EditNB;'focus_in_event';'cb_edit_focus_in'
consig4 EditNB;'switch_page';'cb_edit_switch_page'
consig4 EditNB;'page_reordered';'cb_edit_page_reordered'
consig4 EditNB;'page_removed';'cb_edit_page_removed'
consig4 EditNB;'page_added';'cb_edit_page_added'

consig5 EditNB;'create_window';'create_window'
gtk_notebook_set_group :: gtk_notebook_set_group_name ::0: EditNB;<<NBgroup
gtk_notebook_set_scrollable EditNB,1
gtk_notebook_popup_enable EditNB
gtk_box_pack_start vb,tb,0 0 0
gtk_box_pack_start vb,EditNB, 1 1 0

hb=. gtk_hpaned_new''
gtk_container_set_border_width hb,0
if. SideBar do.
  gtk_paned_pack1 hb, vb, 1 1
  gtk_paned_pack2 hb, EditSB, 0 1
else.
  gtk_paned_pack1 hb, EditSB, 0 1
  gtk_paned_pack2 hb, vb, 1 1
end.

vb=. gtk_vbox_new 0 0
gtk_container_set_border_width vb,0
mb=. edit_menu''
gtk_box_pack_start vb,mb,0 0 0
gtk_box_pack_start vb,hb,1 1 0
gtk_container_add window,vb
windowfinish''
setvisible 1
window_focus_in window
script_menu_enable''
noevents 0
)
edit_opencopy=: 3 : 0
'tab txt'=. y
'fname mod'=. (ipFL,ipMOD) { tab
edit_opentab_show fname
edit_current_def''
setmodified EditPage,mod
viewreplacetext pSV;txt
tab_refresh''
1
)
edit_openfiles=: 3 : 0
'files page'=. y
noevents 1
edit_open''
for_f. |.boxxopen files do.
  p=. edit_opentab jpath >f
end.
noevents 0
if. page<0 do. page=. p end.
windowfinish__locEdit''
if. #EditTabs do.
  EditPage=: (<:#EditTabs) <. 0 >. page
  gtk_notebook_set_current_page EditNB;EditPage
else.
  EditPage=: _1
end.
tab_refresh''
seteditfocus''
conf_save''
)

edit_openset=: 3 : 0
'fname sv high'=. y
if. high >: 0 do.
  viewsethigh sv,high
  scroll=. 0 >. high - 5
else.
  scroll=. getpos fname
end.
if. scroll>:0 do.
  setidle 'viewsetscroll_',(>coname''),'_ ',":sv,scroll
end.
)
edit_show=: 3 : 0
if. window=0 do.
  edit_open''
elseif. -. windex{Visible do.
  tab_reopenall''
  setvisible 1
end.
tab_refresh''
seteditfocus''
window_focus_in window
)
edit_opentab=: 3 : 0
noevents 1
edit_open ''
mod=. saved=. 0
high=. _1
if. L. y do.
  'fname high saved'=. y
else.
  fname=. y
end.
if. -. fexist fname do.
  mbinfo (gettext 'File Open');(gettext 'File not found: '),fname
  noevents 0
  _1 return.
end.
p=. selectopenfile fname
if. p >: 0 do.
  edit_openset fname;(page_sv p);high
  noevents 0
  p return.
end.
if. isimagefile fname do.
  noevents 0
  fname conew 'jgtkimage'
  _1 return.
elseif. '.glade'-:tolower _6{.fname do.
  noevents 0
  if. IFUNIX do.
    try. 2!:0 'which glade'
      2!:1 'glade ', (dquote fname), ' &'
      _1 return.
    catch. end.
  else.
    if. 32< 'shell32 ShellExecuteW > i x *w *w *w *w i'&cd 0;(uucp 'open');(uucp fname);(<0);(<0);1 do.
      _1 return.
    end.
  end.
  mbinfo (gettext 'Glade');(gettext 'Glade designer not found')
end.
if. -. istextfile fname do. _1 [ noevents 0 return. end.
sname=. edit_sname fname
ndx=. getxpage fname
if. ndx >: 0 do.
  (PageIds)=. ndx{EditTabs__locEdit1
  sname=. pSN [ ro=. pRO [ mod=. pMOD [ sb=. pSB [ txt=. pTXT
  'sw sv'=. newcodeviewsb sb
else.
  ro=. 0
  txt=. fread fname
  if. txt -: _1 do. txt=. '' end.
  es=. ('.ijs' -: _4 {. fname) # EditScheme
  'sw sv sb'=. newcodeview 'edit';es;fname;txt
end.
edit_openset fname;sv;high
'ebox btn lb'=. edit_maketablabel sname
p=. edit_opentab1 sw;fname;sname;ro;mod;saved;btn;lb;sv;sb;txt;ebox
noevents 0
p
)
edit_opentab_show=: 3 : 0
if. _1= ndx=. edit_opentab y do. EMPTY return. end.
EditPage=: ndx
gtk_widget_show_all page_sw ndx
gtk_widget_show_all EditNB
gtk_notebook_set_current_page EditNB,ndx
edit_current_def''
setchildfocus page_sv ndx
script_menu_enable''
validate''
conf_save''
EMPTY
)
edit_opentab1=: 3 : 0
noevents 1
(PageIds,' ebox')=. y
p=. 0 >. EditPage <. <: #EditTabs
EditTabs=: (p{.EditTabs),(}:y),p}.EditTabs
gtk_widget_show_all ebox
p=. gtk_notebook_insert_page_menu EditNB,pSW,ebox,0,p
gtk_notebook_set_tab_detachable EditNB,pSW,1
gtk_notebook_set_tab_reorderable EditNB,pSW,1
gtk_notebook_set_menu_label_text EditNB;pSW;pSN
viewlinenumbers pSV,LineNos
viewlinewrap pSV,LineWrap
setchildfocus pSV
if. istempscript_j_ pFL do. setsaved 0 end.
setmodified1 pSN;pLAB;pMOD
noevents 0
p
)
tab_open=: 3 : 0
if. 0=#y do. return. end.
edit_current_def''
if. EditPage<0 do. act=. 0 else. act=. 1{EditPage{EditTabs end.
noevents 1
n=. y -. 1 {"1 EditTabs
for_f. n do.
  edit_opentab >f
end.
m=. ProjectPath_jp_&matchhead_jp_ each 1{"1 EditTabs
EditTabs=: EditTabs /: (m{'10') ,each 1{"1 EditTabs
for_w. ;0{"1 EditTabs do.
  gtk_notebook_reorder_child EditNB,w,w_index
end.
ndx=. 0 >. (1{"1 EditTabs) index act
EditPage=: ndx
gtk_widget_show_all page_sw ndx
gtk_widget_show_all EditNB
gtk_notebook_set_current_page EditNB,ndx
edit_current_def''
setchildfocus pSV
validate''
conf_save''
noevents 0
EMPTY
)
tab_reopen1=: 3 : 0
(PageIds)=. y{EditTabs
old=. freads pFL
new=. bufread pSB
if. -. old -: new do.
  viewreplacetext pSV;old
end.
)
tab_reopenall=: 3 : 0
if. 0=#EditTabs do. 1 return. end.
tab_closes I. -. fexist 1{"1 EditTabs
noevents 1
for_i. i.#EditTabs do. tab_reopen1 i end.
noevents 0
validate''
1
)
PageIds=: 'pSW pFL pSN pRO pMOD pSAV pBTN pLAB pSV pSB pTXT'
('i',each ;:PageIds)=: i.11
page_sw=: 3 : '>(<y;0) { EditTabs'
page_file=: 3 : '>(<y;1) { EditTabs'
page_mod=: 3 : '>(<y;4) { EditTabs'
page_sav=: 3 : '>(<y;5) { EditTabs'
page_but=: 3 : '>(<y;6) { EditTabs'
page_sv=: 3 : '>(<y;8) { EditTabs'
page_buf=: 3 : '>(<y;9) { EditTabs'
page_bufx=: [: > 9&{
page_index=: 3 : 0
(;6 {"1 EditTabs) i. {.y
)
page_svs_jgtkide_=: 3 : 0
l0=. {.locEdits
l1=. {:locEdits
(;8 {"1 EditTabs__l0),;8 {"1 EditTabs__l1
)
edit_current_page=: 3 : 'gtk_notebook_get_current_page EditNB'
edit_current_def=: 3 : 0
EditPage=: edit_current_page''
if. EditPage<0 do.
  p=. <''
else.
  p=. EditPage{EditTabs
end.
(PageIds)=: p
EMPTY
)
readline=: 3 : 'bufreadline pSB,y'
readlastline=: 3 : 'bufreadlastline pSB'
Files_jgtkide_=: ''
Filex_jgtkide_=: $0
setpos=: 3 : 0
cocurrent 'jgtkide'
'f p'=. y
if. 0=#f do. return. end.
ndx=. Files i. <f
if. ndx=#Files do.
  if. p do.
    Files=: Files,<f
    Filex=: Filex,p
  end.
else.
  if. p do.
    Filex=: p (<ndx)} Filex
  else.
    ndx=. <<<ndx
    Files=: ndx{Files
    Filex=: ndx{Filex
  end.
end.
)
getpos=: 3 : 0
(Files i. boxxopen y) { Filex,0
)
cx_load_script=: 3 : 0
if. cx_run_save'' do. 1 return. end.
name=. page_file EditPage
if. is_script name do.
  term_load_script__locTerm name
elseif. is_shellscript name do.
  hostcmd name
elseif. do.
  mbinfo (gettext 'Run Script');(gettext 'Not a valid scriptname: '),name
end.
1
)
cx_run_save=: 3 : 0
if. -. 1 tab_save '' do. 1 return. end.
-. 1 tab_saveall''
)
cx_run_all=: 3 : 0
if. cx_run_save'' do. 1 return. end.
edit_current_def''
if. is_shellscript pFL do.
  hostcmd pFL
else.
  runlines termLF trimWS tab_readall''
end.
1
)
cx_run_line1=: 3 : 0
if. cx_run_save'' do. 1 return. end.
edit_current_def''
row=. bufreadlinenumber pSB
'cnt txt'=. readentry row
if. #txt do.
  term_append_run__locTerm txt
end.
if. -.y do. 1 return. end.
if. row = gtk_text_buffer_get_line_count pSB do. 1 return. end.
bgn=. newiterline pSB,row
gtk_text_iter_set_line bgn;row+cnt
mark=. gtk_text_buffer_create_mark pSB;'';bgn;1
gtk_text_view_scroll_mark_onscreen pSV;mark
gtk_text_buffer_delete_mark pSB;mark
if. #readline row+cnt do.
  gtk_text_iter_forward_to_line_end <bgn
end.
gtk_text_buffer_place_cursor pSB;bgn
1
)
cx_run_line_show=: 3 : 0
r=. 0
Show_jgtkide_=: 1
try. r=. cx_run_line1 y catch. end.
Show_jgtkide_=: 0
r
)
cx_run_select=: 3 : 0
if. 0=#EditTabs do. return. end.
edit_current_def''
runimmex1 bufreadselect pSB
)
cx_run_line=: cx_run_line1 bind 0
cx_run_line_advance=: cx_run_line1 bind 1
file_save=: 4 : 0
checkdiskall''
if. 0=#EditTabs do. 1 return. end.
cx=. y #~ ; y { 4 {"1 EditTabs
if. 0=#cx do. 1 return. end.
if. ConfirmSave <: x=2 do. 1[file_save1 &> cx return. end.

fl=. cx { 1{"1 EditTabs
tx=. (istempscript_j_ &> fl) +. isconfigfile_j_ &> fl
if. *./ tx do. 1[file_save1 &> cx return. end.

if. x do.
  px=. cx #~ tx < 0 = page_sav cx
else.
  px=. cx #~ -.tx
end.
if. 0=#px do. 1[file_save1 &> cx return. end.

if. 3>#px do.
  m=. (gettext 'OK to save: '),}. ;' ',each px { 2 {"1 EditTabs
else.
  m=. (gettext 'OK to save changed files?')
end.
r=. mbcancelnoyes (gettext 'edit');m
if. r=0 do. 0 return. end.
nx=. (r=1)#px
if. #nx do.
  file_savenot1 &> nx
end.
sx=. px -. nx
if. #sx do.
  r=. *./ file_save1 &> sx
end.
r
)
file_save1=: 3 : 0
(PageIds)=. y{EditTabs
if. -.pMOD do. 1 return. end.
old=. fread pFL
new=. fputs bufread pSB
if. -. old -: new do.
  new pic_jp_ pFL
  new fwrite pFL
  recentfiles_add_j_ pFL
end.
settxt y;new
setmodified y,0
setsaved y
1
)
file_savenot1=: 3 : 0
(PageIds)=. y{EditTabs
if. -.pMOD do. 1 return. end.
(fputs bufread pSB) pic_jp_ pFL
txt=. fread pFL
if. -.txt -: _1 do.
  bufwrite pSB;fgets txt
end.
settxt y;txt
setmodified y,0
1
)
tab_save=: 4 : 0
if. 0=#y do.
  edit_current_def''
  y=. EditPage
end.
r=. x file_save y
r[sidebar_refresh''
)
tab_saveall=: 4 : 0
r=. x file_save i.#EditTabs
r[sidebar_refresh''
)
tab_saveother=: 4 : 0
r=. x file_save EditPage -.~ i.#EditTabs
r[sidebar_refresh''
)
select_line=: 3 : 0
edit_current_def''
if. EditPage<0 do. return. end.
'txt bgn len'=. bufget pSB
if. 0 = #txt do.
  mbinfo 'Selection';'No text selected' return.
end.

end=. bgn+len
oldsel=. bgn,end

sel=. bgn }. end {. txt
ndx=. LF i.~ |. bgn {. txt
bgn=. bgn - ndx
if. LF ~: {: sel do.
  txt=. txt, LF
  ndx=. 1 + LF i.~ end }. txt
  end=. end + ndx
end.

sel=. bgn }. end {. txt
csl=. <;.2 sel

len=. #Comment
com=. Comment,' '

select. y
case. 'minus' do.
  msk=. -. ((len+5) {. each csl) e. (com,'----');com,'===='
  csl=. msk # csl
  msk4=. (<com) = (len+1) {. each csl
  msk3=. msk4 < (<Comment) = len {. each csl
  new=. ; ((msk4 * len+1) + msk3 * len) }. each csl
  set=. bgn + 0, <: #new
case. 'plus' do.
  msk=. 1 < # &> csl
  if. 1<len do.
    hdr=. msk{Comment;com
  else.
    hdr=. msk{'';com
  end.
  new=. ; hdr ,each csl
  set=. bgn + 0, <: #new
case. 'plusline1' do.
  cmt=. com,(57#'-'),LF
  new=. ; cmt ; csl
  set=. oldsel + #cmt
case. 'plusline2' do.
  cmt=. com,(57#'='),LF
  new=. ; cmt ; csl
  set=. oldsel + #cmt
case. 'sort' do.
  new=. ; /:~ csl
  set=. bgn + 0, <: #new
end.

if. -. new -: sel do.
  viewnewselect pSV;bgn;end;new;set
  setmodified EditPage,1
end.
)
select_text=: 3 : 0
edit_current_def''
if. EditPage<0 do. return. end.
'txt bgn len'=. bufget pSB
end=. bgn+len

if. bgn = end do.
  mbinfo (gettext 'Selection');(gettext 'No text selected') return.
end.

sel=. bgn }. end {. txt
select. y
case. 'lower' do.
  new=. tolower sel
case. 'toggle' do.
  lwr=. a. {~ (i.26) + a. i. 'a'
  upr=. a. {~ (i.26) + a. i. 'A'
  ndx=. (lwr,upr,a.) i. sel
  new=. ndx { upr,lwr,a.
case. 'upper' do.
  new=. toupper sel
case. 'wrap' do.
  new=. 70 foldtext sel
end.

if. -. new -: sel do.
  viewnewselect pSV;bgn;end;new;bgn,end
  setmodified EditPage,1
end.

)
setcurrentpage=: 3 : 0
if. y e. i.#EditTabs do.
  EditPage=: y
  gtk_notebook_set_current_page EditNB,EditPage
else.
  EditPage=: gtk_notebook_get_current_page EditNB
end.
)
seteditfocus=: 3 : 0
setwindowfocus window
if. #pSV do. setchildfocus pSV end.
)
seteditpos=: 3 : 0
if. windex do.
  'x y w h m'=. getwinpos window__locEdit1
  wid=. {.Swh
  x=. (wid>w++:x) { 0, wid - w
  pos=. x,y,w,h,m
else.
  pos=. EditPos
end.
pos setwinpos window
)
setfiletext=: 3 : 0
'fl txt buf'=. y
page=. (1{"1 EditTabs) i. <fl
if. page=#EditTabs do. return. end.
EditTabs=: (1;txt) (<page;4 10)} EditTabs
if. buf do.
  bufwrite (page_buf page);toJ txt
end.
)
setmodified=: 3 : 0
'page ifmod'=. y
if. page<0 do. 0 return. end.
(PageIds)=. page{EditTabs
if. ifmod = pMOD do. 0 return. end.
setmodified1 pSN;pLAB;ifmod
EditTabs=: (<ifmod) (<page;4)} EditTabs
if. page = EditPage do.
  settitle''
end.
if. 0 <: page=. getxpage pFL do.
  setmodified__locEdit1 page;ifmod
end.
EMPTY
)
setmodified1=: 3 : 0
's l ifmod'=. y
if. ifmod do.
  s=. '<span foreground="red">',s,'</span>'
end.
gtk_label_set_markup l;s
)
setsaved=: 3 : 0
EditTabs=: (<1) (<y;5)} EditTabs
EMPTY
)
settxt=: 3 : 0
'page txt'=. y
EditTabs=: (<txt) (<page;10)} EditTabs
EMPTY
)
settitle=: 3 : 0
if. EditPage < 0 do.
  f=. settitle1 '';'';0
else.
  (PageIds)=. EditPage{EditTabs
  f=. settitle1 pFL;pSN;pMOD
end.
windowcaption f
)
settitle1=: 3 : 0
'file sname changed'=. y
c=. changed#'*'
n=. ProjectName_jp_
n=. (0<#n)#settitlep n
if. 0=#file do.
  f=. (0<#sname)#sname,' - '
else.
  s=. remtilde toprojectfolder_jp_ file
  'p f'=. fpathname s
  if. ProjectName_jp_ -: }:p do.
    s=. f
  end.
  f=. s,' - '
end.
c,f,n,'Edit'
)

settitlep=: '[' , '] - ' ,~ remtilde
setvisible=: 3 : 0
if. y do.
  VisPos setwinpos window
  gtk_widget_show window
else.
  VisPos=: getwinpos window
  gtk_widget_hide window
end.
Visible_jgtkide_=: y windex} Visible
)
make_edittoolbar=: 3 : 0

tb=. gtk_toolbar_new''
gtk_toolbar_set_icon_size tb, GTK_ICON_SIZE_MENU
gtk_toolbar_set_style tb, GTK_TOOLBAR_ICONS

wid=. gtk_tool_button_new_from_stock <'gtk-media-previous'
gtk_widget_set_tooltip_text wid;(gettext 'Open Last Project')
consig wid;'clicked';'projectlast_activate'
gtk_container_add tb, wid

wid=. gtk_tool_button_new_from_stock <'gtk-directory'
gtk_widget_set_tooltip_text wid;(gettext 'Open Project')
consig wid;'clicked';'projectopen_activate'
gtk_container_add tb, wid

gtk_container_add tb, gtk_separator_tool_item_new''

wid=. gtk_tool_button_new_from_stock <'gtk-execute'
gtk_widget_set_tooltip_text wid;(gettext 'Run All Lines')
consig wid;'clicked';'runall_activate'
gtk_container_add tb, wid

tb
)
globals=: 3 : 0
edit_current_def''
nms=. globalassigns bufread pSB
f=. toprojectfolder_jp_ pFL
txt=. 'in file: ',f,LF2,;nms ,each LF
textview txt
1
)
globalassigns=: 3 : 0
rx=. Rxnna_jregex_,'([[:alpha:]][[:alnum:]_]*) *=:'
hit=. rx rxmatches y
if. 0=#hit do. '' return. end.
nms=. ({:"2 hit) rxfrom y
tagcount sort nms
)
tagparen=: ' ('&, @ (,&')') @ ":
tagcount=: 3 : 0
cnt=. #/.~ y
nms=. ~. y
if. 1 e. b=. cnt > 1 do.
  tag=. tagparen each b#cnt
  tag=. (b#nms) ,each tag
  tag (I. b)} nms
end.
)
create_window=: 3 : 0
noevents 1
edit_current_def''
tab_remove EditPage
noevents 0
)
window_closex=: 3 : 0
f=. (0 pick fpathname) each 1{"1 EditTabs
tab_closes I. f ~: <ProjectPath,'/'
1
)
window_dup=: 3 : 0
noevents 1
edit_current_def''
edit_show__locEdit1''
if. -. 0 tab_saveall__locEdit1'' do. 0 return. end.
tab_closeall__locEdit1''
for_t. |. EditTabs do.
  edit_opencopy__locEdit1 t;bufread page_bufx t
end.
setcurrentpage__locEdit1 EditPage
locEdit_jgtkide_=: locEdit0
seteditfocus''
noevents 0
sidebar_refresh__locEdit1''
1
)
window_new=: 3 : 0
edit_show__locEdit1''
)
window_project=: 3 : 0
edit_current_def''
fl=. pFL
'f p'=. fpathname fl
pn=. f,(spath }: f),ProjExt
if. pn -: Project do. 1 return. end.
if. -. fexist pn do. 1 return. end.
if. -. proj_open pn do. 1 return. end.
edit_opentab_show fl
)
window_scripts=: 3 : 0
tab_open |. getdirscripts ProjectPath_jp_
)
window_source=: 3 : 0
tab_open |. fexists Source_jp_
)
window_text=: 3 : 0
tab_open |. getdirtext ProjectPath_jp_
)
window_throw=: 3 : 0
noevents 1
edit_current_def''
txt=. bufread pSB
old=. tab_remove EditPage
edit_opencopy__locEdit1 old;txt
setidle 'pageswitched_',(>locEdit1),'_$0'
locEdit_jgtkide_=: locEdit0
seteditfocus''
noevents 0
1
)
coclass 'jgtkfif'
coinsert 'j'

Assign=: 0
Filename=: 0
Matchcase=: 1
Name=: 0
Path=: ''
Regex=: 0
Search=: ''
SearchList=: 0
Types=: 0
Subdir=: 1

Vars=: 'Assign Filename Matchcase Name Path Regex SearchList Subdir Types'

ifResults=: 0
locP=: 0
window=: 0
Max=: 15
Title=: (gettext 'Find in Files')
create=: 3 : 0
if. SearchList-:0 do.
  SearchList_jgtkfif_=: RecentFif
end.
if. Types-:0 do.
  Types_jgtkfif_=: a: -.~ <;._2 FifTypes_jgtkide_,LF
  Type_jgtkfif_=: >{.Types
end.
setactivewin''
PathList=: {."1 UserFolders
'text ifname'=. 2 {. (boxopen y),<0
p=. ProjectName_jp_
if. #text do.
  Search=: text
  if. ifname do.
    if. '/' e. p do. p=. (p i: '/') {. p end.
    Path=: p
    fif_refresh''
    setcheckbox wassign,ifname-1
    fif_find'' return.
  end.
end.
if. #p do.
  setpathlist remsep 0 pick fpathname p
  Path=: p
end.
fif_refresh''
1
)
destroy=: 3 : 0
cbfree''
codestroy''
)
finfo=: 3 : 'mbinfo Title;y'
fifplain=: ; @ (,~each e.&'[](){}$^.*+?|\' #each '\'"_)
fifmatches=: {.@{."2 @ rxmatches_jregex_

toblank=: ' ' I.@(e.&'_')@]} ]
fifmatch=: ({.@{. + {:@(1&{))@rxmatch_jregex_
groupndx=: [: <: I. + e.~
maxlist=: 3 : '(Max <. #r) {. r=. ~.y'
FifExPaths=: ;: 'release'
fiffilter=: 3 : 0
xt=. '.' ,each <;._1 ' ',Type
if. (<'.*') e. xt do. y return. end.
y #~ (tolower each (}.~i:&'.') each y) e. xt
)
fifsplit=: 3 : 0
dat=. <;._2 y
g=. i.&' '
h=. g (toblank@{. ; deb@}.) ]
h &> dat
)
saverecentfif=: 3 : 0
if. #Search do.
  RecentFif_j_=: recentmax (<Search),RecentFif
  recentsave_j_''
end.
EMPTY
)
setactivewin=: 3 : 0
if. locP ~: loc=. getcurrentloc_jgtkide_ '' do.
  locP=: loc
  ('jgtkfif';(,copath) locP) copath coname''
end.
)
setpathlist=: 3 : 0
if. 0=#y do.
  p=. (0=#Path){Path;Folder
else.
  p=. y
end.
p=. (boxxopen p) -. <''
p=. ~.p,PathList
m=. -. p e. {."1 UserFolders
PathList=: p #~ Max >: m * +/\ m
Path=: 0 pick PathList,<''
)
settypelist=: 3 : 0
if. -. (<y) e. Types do.
  Types=: maxlist ~.(<y),Types
end.
)
setsearchlist=: 3 : 0
SearchList=: maxlist ~. (boxxopen y),SearchList
)
fif_assign_button=: 3 : 0
Assign=: readcheckbox wassign
if. Assign do.
  Name=: 0
  fif_setbuttons''
end.
fif_research''
1
)
fif_close=: 3 : 0
fif_readpos''
locFif_jgtkide_=: ''
pdef_jgtkfif_ pack Vars
gtk_widget_destroy window
destroy''
1
)
fif_find=: 3 : 0
fif_read''
fif_search''
1
)
fif_name_button=: 3 : 0
Name=: readcheckbox wname
if. Name do.
  Assign=: 0
  fif_setbuttons''
end.
fif_research''
1
)
fif_regex_button=: 3 : 0
Regex=: readcheckbox wregex
fif_setenable''
fif_research''
1
)
fif_research=: 3 : 0
if. NoEvents do. 1 return. end.
fif_read''
if. ifResults *. 0 < #Search do. fif_search'' end.
1
)
fif_cursor_changed=: 1:
fif_filename_button=: fif_research
fif_matchcase_button=: fif_research
fif_subdir_button=: fif_research
fif_row_activated=: 3 : 0
'w p c d'=. y
r=. 0 pick gtk_tree_path_get_indices <<p
row=. {. _2 ic memr r,0 4
fif_show_text row pick Text
)
fif_show_text=: 3 : 0
txt=. y
ndx=. txt i. ':'
file=. (projname2path_jp_ TextPath),'/',ndx{.txt
if. Filename do.
  row=. _1
else.
  txt=. (ndx+1)}.txt
  row=. <: 0 ". (txt i.':'){.txt
end.
edit_opentab_show__locEdit file;row;0
1
)
fif_key_press=: 0:
window_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
'ctrl j shift'=. 2 2 2 #: state
if. shift +. ctrl do. 0 return. end.
if. key=GDK_Escape do. fif_close '' return. end.
0
)
wfif_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Return do. 0 return. end.
fif_find''
)
wfolder_key_press=: wsearch_key_press=: wtype_key_press=: wfif_key_press
window_destroy=: window_delete=: fif_close
fif_align=: 3 : 0
a=. gtk_alignment_new 0 0.5 0 0
gtk_container_add a,y
a
)
fif_getdirpath=: 3 : 0
p=. }: 0 pick fpathname projname2path_jp_ readcombo wfolder
s=. filechooser 3;(gettext 'folder');'';p
if. #s do.
  w=. gtk_bin_get_child wfolder
  setentry w;s
end.
)
fif_getinsert=: 3 : 0
s=. readcombo wsearch
w=. gtk_bin_get_child wsearch
setentry w;s,' elmo'
)
fif_open=: 3 : 0
if. window do.
  setwindowfocus window return.
end.
a=. GTK_FILL
b=. GTK_EXPAND + GTK_FILL
noevents 1
newwindow Title
consig3 window;'key-press-event';'window_key_press'
p=. _1 (3)} FifPos
gtk_window_move window,0 1 {p
windowdefaultsize 2 3{p
vb=. gtk_vbox_new 0 0
tb=. gtk_table_new 3 2 0
gtk_container_set_border_width tb, 6
gtk_table_set_row_spacings tb,5
gtk_table_set_col_spacings tb,6

label=. gtk_label_new_with_mnemonic <gettext '_Search for:'
gtk_misc_set_alignment label, 1 0.5
wsearch=: newcombo''
w=. gtk_bin_get_child wsearch
consig3 w;'key-press-event';'wsearch_key_press'
gtk_label_set_mnemonic_widget label,wsearch
gtk_table_attach tb,label,0 1 0 1,a,0 0 0
gtk_table_attach tb,wsearch,1 2 0 1,b,0 0 0

label=. gtk_label_new_with_mnemonic <gettext 'In _folder:'
gtk_misc_set_alignment label, 1 0.5
wfolder=: newcombo''
w=. gtk_bin_get_child wfolder
consig3 w;'key-press-event';'wfolder_key_press'
gtk_label_set_mnemonic_widget label,wfolder
gtk_table_attach tb,label,0 1 1 2,a,0 0 0
gtk_table_attach tb,wfolder,1 2 1 2,b,0 0 0

label=. gtk_label_new_with_mnemonic <gettext 'File _types:'
gtk_misc_set_alignment label, 1 0.5
wtype=: newcombo ''
w=. gtk_bin_get_child wtype
consig3 w;'key-press-event';'wtype_key_press'
gtk_label_set_mnemonic_widget label,wtype
gtk_table_attach tb,label,0 1 2 3,a,0 0 0
gtk_table_attach tb,wtype,1 2 2 3,b,0 0 0
gtk_box_pack_start vb,tb,0 0 0
wmatchcase=: newcheckbox (gettext '_Match case');'fif_matchcase_button'
wassign=: newcheckbox (gettext '_Assigned');'fif_assign_button'
wname=: newcheckbox (gettext '_Name only');'fif_name_button'
wregex=: newcheckbox (gettext '_Regex');'fif_regex_button'
wsubdir=: newcheckbox (gettext 'Search su_bfolders');'fif_subdir_button'
wfilename=: newcheckbox (gettext '_Filen_ames only');'fif_filename_button'

hb=. gtk_hbox_new 0 0
sb=. gtk_table_new 3 2 0
gtk_container_set_border_width sb, 6
gtk_table_set_row_spacings sb,0

gtk_table_attach sb,(fif_align wmatchcase),0 1 0 1,b,0 0 0
gtk_table_attach sb,(fif_align wsubdir),0 1 1 2,b,0 0 0
gtk_table_attach sb,(fif_align wfilename),0 1 2 3,b,0 0 0
gtk_table_attach sb,(fif_align wassign),1 2 0 1,b,0 0 0
gtk_table_attach sb,(fif_align wname),1 2 1 2,b,0 0 0
gtk_table_attach sb,(fif_align wregex),1 2 2 3,b,0 0 0

gtk_box_pack_start hb,sb,1 1 0

sb=. gtk_vbox_new 0 0
bt=. newstocktextbutton 'gtk-find';(gettext '_Find  ');'fif_find'
gtk_box_pack_start sb,bt,0 0 0
gtk_box_pack_start hb,sb,0 0 0

align=. gtk_alignment_new 0.5 0.5 0 0
gtk_widget_set_size_request align,6 0
gtk_box_pack_start hb,align,0 0 0
gtk_box_pack_start vb,hb,0 0 0
Rvb=: vb
Svb=: 0
fif_write ''
gtk_container_add window, vb
windowfinish''
noevents 0
)
fif_open_assign=: 3 : 0
'Text Search'=: y
Assign=: 1
setsearchlist Search
Path=: 0 pick PathList,<''
fif_showresult Text;Path
)
fif_read=: 3 : 0
noevents 1
Search=: readcombo wsearch
Path=: readcombo wfolder
Type=: readcombo wtype
Matchcase=: readcheckbox wmatchcase
Filename=: readcheckbox wfilename
Subdir=: readcheckbox wsubdir
Regex=: readcheckbox wregex
Name=: readcheckbox wname
Assign=: readcheckbox wassign
fif_readpos''
fif_refresh''
noevents 0
0
)
fif_readpos=: 3 : 0
readwinpos 'FifPos'
)
fif_refresh=: 3 : 0
setsearchlist Search
setpathlist Path
settypelist Type
if. window do.
  fif_write ''
else.
  fif_open''
end.
setwindowfocus window
)
fif_setactive=: 3 : 0
setcombo_select wsearch,<:0<#Search
setcombo_select wfolder,<:0<#PathList
fif_setbuttons''
)
fif_setbuttons=: 3 : 0
setcheckbox wregex,Regex
setcheckbox wfilename,Filename
setcheckbox wmatchcase,Matchcase
setcheckbox wsubdir,Subdir
setcheckbox wname,Name
setcheckbox wassign,Assign
)
fif_setenable=: 3 : 0
setenable wname,-.Regex
setenable wassign,-.Regex
)
fif_show=: 3 : 0
setwindowfocus window
)
fif_showresult=: 3 : 0
if. y-:0 do.
  Text=: TextPath=: '' return.
end.
'Text TextPath'=: y
if. Svb=0 do.
  Svb=: gtk_vbox_new 0 0
  hs=. gtk_hseparator_new ''
  sw=. newsw''
  Rtv=: makelistbox 'fif';Text;'';'';1
  gtk_container_add sw,Rtv
  gtk_box_pack_start Svb,hs,0 0 0
  gtk_box_pack_start Svb,sw,1 1 0
  gtk_box_pack_start Rvb,Svb,1 1 0
  min=. 0 500
  gtk_window_resize window,min >. 2 3{FifPos
else.
  setlistbox Rtv;<Text
end.
windowfinish''
ifResults=: 1
)
fif_write=: 3 : 0
setcombo_text wsearch;<SearchList
setcombo_text wfolder;<PathList
setcombo_text wtype;<Types
setcombo_select wtype,Types i. <Type
fif_setactive''
fif_setenable''
)
dirfilter=: 3 : 0
d=. 1!:0 y
if. 0=#d do. return. end.
f=. {."1 d
m=. ('~' = {: &> f) +. ({.&> f) e. '.~'
d=. d #~ -. m
if. 0=#d do. return. end.
d #~ 'h' ~: 1 {"1 > 4 {"1 d
)
fif_getfiles=: 3 : 0
p=. filecase termsep y
d=. dirfilter p,'*'
if. 0 = #d do. '' return. end.
m=. 'd' = 4 {"1 > 4{"1 d
n=. {."1 d
f=. (<p) ,each n
r=. (-.m)#f
m=. m > n e. FifExPaths
if. Subdir *. 1 e. m do.
  r=. r, ;fif_getfiles each m#f
end.
fiffilter r
)
fif_search=: 3 : 0
if. 0=#Search do.
  finfo (gettext 'No search defined')
  0 return.
end.
r=. fifss''
fif_showresult r;Path
if. 0=#r do.
  finfo (gettext 'No match found')
  ifResults pick 0;''
end.
saverecentfif ''
)
fifss=: 3 : 0
if. 0=#Search do. '' return. end.
path=. termsep projname2path_jp_ Path
fls=. fif_getfiles path
if. 0=#fls do. '' return. end.

if. Matchcase do. case=. ] else. case=. tolower end.
what=. case Search
if. 0=fifss_init what do. '' return. end.

r=. ''
for_f. fls do.
  dat=. freads f
  if. dat -: _1 do. continue. end.
  txt=. case dat
  if. RX do.
    ndx=. FIFCOMP fifmatches txt
  else.
    ndx=. I. what E. txt
  end.
  if. 0=#ndx do. continue. end.
  if. Filename do.
    r=. r, <(>f),':',":#ndx
  else.
    ind=. ~. (0,}:I. dat = LF) groupndx ndx
    txt=. ind { <;._2 dat
    inx=. ':' ,each (":each ind) ,each <': '
    r=. r, f ,each inx ,each txt
  end.
end.

if. RX do. rxfree_jregex_ FIFCOMP end.
(#path) }.each r
)
fifss_init=: 3 : 0

RX=: +./ Assign,Name,Regex
if. -.RX do. 1 return. end.

if. Regex do.
  p=. y
elseif. Assign do.
  p=. Rxnna_jregex_,(fifplain y),Rxass_jregex_
elseif. Name do.
  p=. Rxnna_jregex_,(fifplain y),Rxnnz_jregex_
end.

FIFCOMP=: rxcomp_jregex_ :: _1: p
if. FIFCOMP -: _1 do.
  finfo (gettext 'Unable to compile regular expression')
  rxfree_jregex_ FIFCOMP
  0
else.
  1
end.
)
fif_jgtkide_=: 3 : 0
if. 0=#locFif do.
  locFif_jgtkide_=: conew 'jgtkfif'
end.
create__locFif y
)
coclass 'jgtkfilem'
coinsert 'jgtkide j'

Title=: (gettext 'File Snapshots')
create=: 3 : 0
if. -. fexist y do.
  mbinfo (gettext 'File Snapshots');(gettext 'not found: '),y
  destroy'' return.
end.
'Path File'=: fpathname y
f=. pic_files_jp_ Path
f=. sort ~. f,<File
m=. fexist (<Path) ,each f
Files=: m#f
Temps=: ''
fm_init File
fm_open''
fm_compare 0
)
destroy=: 3 : 0
cbfree''
codestroy''
)
fm_close=: 3 : 0
ferase Temps
gtk_widget_destroy window
destroy''
1
)
fm_restore_button=: 3 : 0
ndx=. listbox_getactiverow wsnaps
ss=. ndx pick Stamps
msg=. (gettext 'OK to restore file snapshot: '),File,' ',ss,'?'
if. -. mbnoyes Title;msg do. 1 return. end.
tab_writefile__locEdit (Path,File);ndx{Texts
fm_close''
1
)
fm_view_button=: 3 : 0
ndx=. listbox_getactiverow wsnaps
if. ndx>:0 do.
  textview fgets ndx pick Texts
end.
)
fm_wfile_changed=: 3 : 0
if. -. NoEvents do.
  fm_init readcombo wfile
  setlistbox wsnaps;<Stamps
  if. #Stamps do.
    listbox_select wsnaps,0
    listbox_scroll wsnaps,0
  end.
  fm_compare 0
  setchildfocus wsnaps
end.
1
)
fm_xdiff_button=: 3 : 0
if. -. 0 tab_save__locEdit '' do. 1 return. end.
f=. newtempscript''
Temps=: Temps,<f
ndx=. listbox_getactiverow wsnaps
if. ndx=_1 do. '' return. end.
(ndx pick Texts) fwrite f
forkcmd XDiff,' "',f,'" "',(Path,File),'"'
)
snaps_cursor_changed=: 3 : 0
if. -. NoEvents do.
  fm_compare listbox_getactiverow wsnaps
end.
1
)
fm_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Return do. 0 return. end.
fm_match_button''
)
window_key_press=: 3 : 0
if. isesckey y do.
  fm_close''
else.
  0
end.
)
snaps_key_press=: fm_key_press
snaps_row_activated=: 0:
window_delete=: fm_close
fm_compare=: 3 : 0
old=. y pick Texts
r=. (gettext 'comparing:'),LF
r=. r,File,'  ',(y pick Stamps),'  ',(":#old),LF
r=. r,File,(gettext '  current   '),(":#Text),LF
r=. r,(fgets old) compare Text
fm_write r
)
fm_init=: 3 : 0
File=: y
file=. Path,File
Text=: tab_readfile__locEdit file
dat=. pic_read_jp_ file
if. 0=#dat do.
  dat=. fread file
  if. dat-:_1 do.
    mbinfo Title;(gettext 'No previous saves for: '),File
    0 return.
  end.
  Stamps=: ,<'start   '
  Texts=: ,<dat
else.
  Stamps=: |. (<'start   ') 0} <"1 ": pp_unstamp_jp_ dat
  Texts=: |. _6 }. each dat
  if. (1<#Texts) *. Text -: 0 pick Texts do.
    Stamps=: }. Stamps
    Texts=: }. Texts
  end.
end.
1
)
fm_write=: 3 : 0
gtk_text_buffer_set_text Buf;y;#y
viewsetrow View,4
)
fm_open=: 3 : 0

a=. GTK_FILL
b=. GTK_EXPAND + GTK_FILL

noevents 1
newwindow Title
FilemPos setwinpos window
consig3 window;'key-press-event';'window_key_press'
gtk_window_set_icon_from_file window;EditIcon;0

vb=. gtk_vbox_new 0 0
hb=. gtk_hbox_new 0 0
label=. newlabel (gettext ' _File: ')
wfile=: newcombo Files;'fm_wfile_changed';0

gtk_box_pack_start hb,label,0 0 3
gtk_box_pack_start hb,wfile,0 0 0
label=. newlabel ' '
label2=. newlabel ' '
wview=: newbutton (gettext ' _View ');'fm_view_button'
wxdiff=: newbutton (gettext ' _External Diff ');'fm_xdiff_button'
wrestore=: newbutton (gettext ' _Restore ');'fm_restore_button'
gtk_box_pack_start hb,label,1 1 0
gtk_box_pack_start hb,wview,0 0 0
gtk_box_pack_start hb,wxdiff,0 0 0
gtk_box_pack_start hb,wrestore,0 0 0
gtk_box_pack_start hb,label2,0 0 3

gtk_box_pack_start vb,hb,0 0 8
hs=. gtk_hseparator_new ''
gtk_box_pack_start vb,hs,0 0 3
hb=. gtk_hpaned_new''
gtk_container_set_border_width hb,0
sw=. newsw''
wsnaps=: makelistbox 'snaps';Stamps;0;'';1
gtk_container_add sw,wsnaps
gtk_widget_set_size_request sw,90 0
gtk_paned_pack1 hb,sw,0 0

'sw sv sb'=. newcodeview 'view';EditScheme;'';''
View=: sv
Buf=: sb
gtk_paned_pack2 hb,sw,1 0
gtk_box_pack_start vb,hb,1 1 0
gtk_container_add window,vb
windowfinish''
noevents 0
setchildfocus wsnaps
)
coclass 'jgtkfiw'
coinsert 'j'

Assign=: 0
Matchcase=: 1
Name=: 0
ReplaceList=: ''
SearchList=: ''

Vars=: 'Assign Matchcase Name ReplaceList SearchList'

Max=: 15
Title=: (gettext 'Find')
locP=: ''
create=: 3 : 0
FiwInc=: 0
FiwLast=: ''
ifReplace=: 0
setsearchlist y
setactivewin''
fiw_open ''
1
)
destroy=: 3 : 0
cbfree''
codestroy''
)
finfo=: 3 : 'mbinfo Title;y'
groupndx=: [: <: I. + e.~
maxlist=: 3 : '(Max <. #r) {. r=. ~.y'
setactivewin=: 3 : 0
if. locP ~: loc=. getcurrentloc_jgtkide_ '' do.
  locP=: loc
  ('jgtkfiw';(,copath) locP) copath coname''
end.
if. 'term' -: Class__locP do.
  SB=: termSB
  SV=: termSV
else.
  edit_current_def''
  SB=: pSB
  SV=: pSV
end.
)
setreplacelist=: 3 : 0
ReplaceList=: maxlist ~. (boxopen y),ReplaceList -. <''
)
setsearchlist=: 3 : 0
SearchList=: maxlist ~. (boxxopen y),SearchList
)
fiw_assign_button=: 3 : 0
Assign=: readcheckbox wassign
if. Assign do.
  Name=: 0
  fiw_setbuttons''
end.
1
)
fiw_close=: 3 : 0
fiw_readpos''
locFiw_jgtkide_=: ''
pdef_jgtkfiw_ pack Vars
gtk_widget_destroy window
destroy''
1
)
fiw_findback=: 3 : 0
fiw_read''
fiw_search _1
1
)
fiw_find=: 3 : 0
fiw_read''
fiw_search 1
1
)
fiw_findtop=: 3 : 0
fiw_read''
fiw_search 0
1
)
fiw_name_button=: 3 : 0
Name=: readcheckbox wname
if. Name do.
  Assign=: 0
  fiw_setbuttons''
end.
1
)
fiw_replace_one=: 3 : 0
fiw_read''
fiw_search_replace 0
)
fiw_replace_forward=: 3 : 0
fiw_read''
fiw_search_replace 1
)
fiw_showreplace=: 3 : 0
if. ifReplace do. 0 return. end.
fiw_read''
fiw_open_replace''
)
fiw_undo_last=: 3 : 0
fiw_read''
viewreplacelast SV;FiwLast
FiwLast=: ''
fiw_show''
)
window_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
'ctrl j shift'=. 2 2 2 #: state
if. shift do. 0 return. end.
if. ctrl do.
  if. key=GDK_r do. fiw_showreplace'' return. end.
else.
  if. key=GDK_Escape do. fiw_close '' return. end.
end.
0
)
wreplace_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Return do. 0 return. end.
fiw_replace_one''
)
wfind_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Return do. 0 return. end.
fiw_findtop''
)
window_destroy=: window_delete=: fiw_close
wfolder_key_press=: wsearch_key_press=: wtype_key_press=: wfind_key_press
fiw_open=: 3 : 0
Title=: gettext 'Find'

a=. GTK_FILL
b=. GTK_EXPAND + GTK_FILL
noevents 1
newwindow Title
consig3 window;'key-press-event';'window_key_press'

gtk_window_set_type_hint window,GDK_WINDOW_TYPE_HINT_DIALOG
gtk_window_set_destroy_with_parent window,1
p=. _1 (3)} FiwPos
gtk_window_move window,0 1 {p
windowdefaultsize 2 3{p
vb=. gtk_vbox_new 0 0
tb=. gtk_table_new (1+ifReplace),2 0
gtk_container_set_border_width tb, 6
gtk_table_set_row_spacings tb,5
gtk_table_set_col_spacings tb,6

label=. newlabelr gettext '_Search for:'
wsearch=: newcombo''
w=. gtk_bin_get_child wsearch

consig3 w;'key-press-event';'wsearch_key_press'
gtk_label_set_mnemonic_widget label,wsearch
gtk_table_attach tb,label,0 1 0 1,a,0 0 0
gtk_table_attach tb,wsearch,1 2 0 1,b,0 0 0
gtk_box_pack_start vb,tb,0 0 0
Rtb=: tb
wmatchcase=: gtk_check_button_new_with_mnemonic <gettext '_Match case'
wassign=: gtk_check_button_new_with_mnemonic <gettext '_Assigned'
wname=: gtk_check_button_new_with_mnemonic <gettext '_Name only'
consig wassign;'clicked';'fiw_assign_button'
consig wname;'clicked';'fiw_name_button'

hb=. gtk_hbox_new 0 0
align=. gtk_alignment_new 0 0 0 0
gtk_widget_set_size_request align,6 0
gtk_box_pack_start hb,align,0 0 0

bb=. gtk_vbox_new 0 0
align=. gtk_alignment_new 0 0 0 0
gtk_widget_set_size_request align,0 10
gtk_box_pack_start bb,align,1 1 0
gtk_box_pack_start bb,wmatchcase,0 0 0
gtk_box_pack_start bb,wassign,0 0 0
gtk_box_pack_start bb,wname,0 0 0
align=. gtk_alignment_new 0 0 0 0
gtk_widget_set_size_request align,0 10
gtk_box_pack_start bb,align,1 1 0
gtk_box_pack_start hb,bb,0 0 0

Ftb=: tb=. gtk_table_new 2 3 0
gtk_container_set_border_width tb, 6
gtk_table_set_row_spacings tb,4
gtk_table_set_col_spacings tb,4

bt=. newstocktextbutton 'gtk-go-back';(gettext 'Find _Back ');'fiw_findback'
gtk_table_attach tb,bt,0 1 0 1,b,0 0 0
bt=. newstocktextbutton 'gtk-goto-top';(gettext '_Find Top ');'fiw_findtop'
gtk_table_attach tb,bt,1 2 0 1,b,0 0 0
bt=. newstocktextbutton 'gtk-go-forward';(gettext 'Find _Next ');'fiw_find'
gtk_table_attach tb,bt,2 3 0 1,b,0 0 0
bt=. newstocktextbutton 'gtk-find-and-replace';(gettext '_Replace');'fiw_showreplace'
gtk_table_attach tb,bt,2 3 1 2,b,0 0 0
Btb=: tb
SRbt=: bt

gtk_box_pack_end hb,tb,0 1 6
gtk_box_pack_start vb,hb,0 0 0
fiw_write ''
gtk_container_add window, vb
windowfinish''
gtk_widget_hide &> Rep
gtk_window_resize window,(2{getwinpos window),1
noevents 0
)
fiw_open_replace=: 3 : 0
a=. GTK_FILL
b=. GTK_EXPAND + GTK_FILL
windowcaption 'Find and Replace'
ifReplace=: 1

label=. gtk_label_new_with_mnemonic <gettext '_Replace by:'
gtk_misc_set_alignment label, 1 0.5
wreplace=: newcombo''
w=. gtk_bin_get_child wreplace
consig3 w;'key-press-event';'wreplace_key_press'
gtk_label_set_mnemonic_widget label,wreplace
gtk_table_attach Rtb,label,0 1 1 2,a,0 0 0
gtk_table_attach Rtb,wreplace,1 2 1 2,b,0 0 0

wundo=: newstocktextbutton 'gtk-undo';(gettext '_Undo Last');'fiw_undo_last'
gtk_table_attach Btb,wundo,0 1 1 2,b,0 0 0
bt=. newstocktextbutton 'gtk-find-and-replace';(gettext 'Re_place');'fiw_replace_one'
gtk_table_attach Btb,bt,1 2 1 2,b,0 0 0
bt=. newstocktextbutton 'gtk-go-forward';(gettext 'Replace For_ward');'fiw_replace_forward'
gtk_table_attach Btb,bt,2 3 1 2,b,0 0 0

windowfinish''
gtk_widget_hide SRbt
setchildfocus wreplace
)
fiw_read=: 3 : 0
Search=: readcombo wsearch
Matchcase=: readcheckbox wmatchcase
Assign=: readcheckbox wassign
Name=: readcheckbox wname
if. ifReplace do.
  Replace=: readcombo wreplace
end.
fiw_readpos''
fiw_refresh''
0
)
fiw_readpos=: 3 : 0
readwinpos 'FiwPos'
)
fiw_refresh=: 3 : 0
setsearchlist Search
if. ifReplace do.
  setreplacelist Replace
end.
fiw_write ''
)
fiw_setactive=: 3 : 0
setcombo_select wsearch,<:0<#SearchList
if. ifReplace do.
  setcombo_select wreplace,<:0<#ReplaceList
end.
fiw_setbuttons''
)
fiw_setbuttons=: 3 : 0
setcheckbox wmatchcase,Matchcase
setcheckbox wassign,Assign
setcheckbox wname,Name
)
fiw_setenable=: 3 : 0
if. -.ifReplace do. return. end.
setenable wundo,#FiwLast
)
fiw_show=: 3 : 0
fiw_setenable''
setwindowfocus window
)
fiw_showhit=: 3 : 0
viewsetselect SV,TextPos,#ucp Search
)
fiw_write=: 3 : 0
setcombo_text wsearch;<SearchList
if. ifReplace do.
  setcombo_text wreplace;<ReplaceList
end.
fiw_setactive''
fiw_setenable''
)
fiw_search=: 3 : 0
if. 0=#SB do. return. end.
'Text TextPos TextSel'=: bufget SB
hit=. fiwss y
if. hit=_1 do.
  finfo (gettext 'not found: '),Search
else.
  TextPos=: hit
  FiwInc=: 1
  fiw_showhit''
end.
fiw_show''
)
fiwss=: 3 : 0
if. Matchcase do.
  txt=. Text
  search=. ucp Search
else.
  txt=. tolower Text
  search=. ucp tolower Search
end.
if. Assign do.
  f=. fiwss_assign
elseif. Name do.
  f=. fiwss_name
elseif. do.
  f=. fiwss_plain
end.
if. y<0 do.
  {: _1, search f TextPos {. txt return.
end.
if. y=0 do.
  TextPos=: FiwInc=: 0
end.
p=. TextPos + FiwInc
{. (p + search f p }. txt), _1
)
fiwss_assign=: 4 : 0
x=. Rxnna_jregex_,x,Rxass_jregex_
x fiwss_regex y
)
fiwss_name=: 4 : 0
x=. Rxnna_jregex_,x,Rxnnz_jregex_
x fiwss_regex y
)
fiwss_plain=: I. @ E.
fiwss_regex=: ({.@{.+{:@(1&{))"2 @ rxmatches
fiw_search_replace=: 3 : 0
if. 0=#SB do. return. end.
'Text TextPos TextSel'=: bufget SB
FiwInc=: 0
FiwLast=: ''
sel=. #ucp Search
select. hit=. fiwss 1
case. _2 do.
  mbinfo (gettext 'Replace');(gettext 'No match found')
case. _1 do.
case. do.
  TextPos=: hit
  FiwLast=: Text;TextPos;sel
  FiwInc=: 1
  viewreplaceselect SV;TextPos;sel;Replace
  Text=: (hit{.Text),(ucp Replace),(hit+sel)}.Text
  if. Class-:'edit' do.
    setmodified__locEdit0 EditPage,1
  end.
  if. y=0 do.
    if. 0 <: hit=. fiwss 1 do.
      TextPos=: hit
      fiw_showhit''
    end.
  else.
    count=. 1
    pad=. <: #ucp Replace
    TextPos=: TextPos + pad
    while. 0 <: hit=. fiwss 1 do.
      viewreplaceselect SV;hit;sel;Replace
      Text=: (hit{.Text),(ucp Replace),(hit+sel)}.Text
      TextPos=: hit + pad
      count=. >:count
    end.
    finfo (":count),(ngettext ' replacement';' replacements';count),(gettext ' made')
  end.
end.
fiw_show''
)
fiw_jgtkide_=: 3 : 0
if. 0=#locFiw do.
  locFiw_jgtkide_=: conew 'jgtkfiw'
end.
create__locFiw y
)
coclass 'jgtkide'
helpabout_activate=: 3 : 0
w=. gtk_about_dialog_new''
gtk_about_dialog_set_copyright w;'Copyright ',(194 169{a.),' 1994-2011 Jsoftware'
gtk_about_dialog_set_website w;'www.jsoftware.com'
gtk_about_dialog_set_program_name ::gtk_about_dialog_set_name w;'J701'
gtk_about_dialog_set_comments w;JVERSION
gtk_dialog_run w
gtk_widget_destroy w
)
helpcontext_activate=: 3 : 0
if. 0=buf=. getcurrentbuf'' do. 0 return. end.
sel=. bufreadselect buf
if. 0=#sel do. sel=. helppos buf end.
if. 0=#sel do. 0 return. end.
helpsel sel
1
)
helpconstants_activate=: 3 : 'htmlhelp ''dictionary/dcons.htm'''
helpcontrols_activate=: 3 : 'htmlhelp ''dictionary/ctrl.htm'''
helpdictionary_activate=: 3 : 'htmlhelp ''dictionary/contents.htm'''
helpforeigns_activate=: 3 : 'htmlhelp ''dictionary/xmain.htm'''
helpgeneral_activate=: 3 : 'htmlhelp ''user/product.htm'''
helphelp_activate=: 3 : 'htmlhelp ''index.htm'''
helprelease_activate=: 3 : 'htmlhelp ''user/relhigh.htm'''
helprelnotes_activate=: 3 : 'htmlhelp ''release/contents.htm'''
helpvocab_activate=: 3 : 'htmlhelp ''dictionary/vocabul.htm'''
helpgtkide_activate=: 3 : 0
if. fexist f=. jpath '~addons/docs/gtkide/index.htm' do.
  browse 'file://', f
else.
  browse 'http://www.jsoftware.com/jwiki/Guides/Gtk%20IDE'
end.
0
)
helpcairo_activate=: 3 : 'htmlhelpgtk ''cairo/'''
helpgdk_activate=: 3 : 'htmlhelpgtk ''gdk/'''
helpgdkpixbuf_activate=: 3 : 'htmlhelpgtk ''gdk-pixbuf/'''
helpgio_activate=: 3 : 'htmlhelpgtk ''gio/'''
helpglib_activate=: 3 : 'htmlhelpgtk ''glib/'''
helpgobject_activate=: 3 : 'htmlhelpgtk ''gobject/'''
helpgtk_activate=: 3 : 'htmlhelpgtk ''gtk/'''
helpgtksourceview_activate=: 3 : 'htmlhelpgtk ''gtksourceview-2.0/'''
helppango_activate=: 3 : 'htmlhelpgtk ''pango/'''
helpcairodocumentation_activate=: 3 : 0
browse 'http://cairographics.org/documentation/'
0
)

helpgtkdocumentation_activate=: 3 : 0
browse 'http://www.gtk.org/documentation.html'
0
)

helpgtktutorial_activate=: 3 : 0
if. fexist f=. jpath '~addons/docs/gtk/tutorial/book1.html' do.
  browse 'file://', f
else.
  browse 'http://library.gnome.org/devel/gtk-tutorial/stable/'
end.
0
)
helppos=: 3 : 0
buf=. y
mark=. i.ITERSIZE
gtk_text_buffer_get_iter_at_mark buf;mark;gtk_text_buffer_get_insert buf
row=. gtk_text_iter_get_line <mark
bgn=. newiterline buf,row
end=. newiterline buf,row
gtk_text_iter_forward_to_line_end <end
p=. readstringfree gtk_text_iter_get_text bgn;mark
q=. readstringfree gtk_text_iter_get_text bgn;end
r=. p
if. Class-:'term' do. r=. 1 delmode r end.
off=. (#p) - len=. #r
q=. off }. q
if. 0=#deb q do. '' return. end.
helppos1 q;len
)
helppos1=: 3 : 0
'txt pos'=. y
if. '[-' -: }. 3 {. txt do.
  if. helperror txt do. '' return. end.
end.
if. Class-:'term' do.
  at=. pos{txt,LF
  as=. pos{LF,txt
  if. *./ (at,as) e. ' ',CRLF do.
    '' [ helpword txt return.
  end.
end.
sep=. {.~ <./ @ (i.&('() ''',{.a.))
beg=. sep&.|. pos{.txt
bit=. beg,sep pos}.txt

if. 0=#bit-.' ' do.
  txt=. ''
else.
  wds=. ;:bit
  len=. #&>}:wds
  txt=. > wds {~ 0 i.~ (#beg)>:+/\len
end.

txt
)
helpsel=: 3 : 0
assert. 2=3!:0 y
s=. dlb@dtb y
if. 0=#s do. return. end.
if. 0=#ContextHelp do. return. end.
for_h. ,ContextHelp do.
  select. h
  case. 'j' do.
    if. #ndx=. helpndx s do.
      htmlhelp 'dictionary/',ndx return.
    end.
  case. 'b' do.
    if. #n=. tagtag_jbaselibtag_ s do.
      htmlhelpbaselib tagfile_jbaselibtag_ {.n return.
    end.
  case. 'g' do.
    if. #n=. tagtag_jgtkdoctag_ s do.
      htmlhelpgtkdoc tagfile_jgtkdoctag_ {.n return.
    end.
  end.
end.
mbinfo 'Help';'Help topic not found: ', y
)
helpndx=: 3 : 0
y=. ,y
if. 2 = 3!:0 y do.
  if. 'goto_' -: 5{.y do. y=. 'goto_?'
  elseif. 'for_' -: 4{.y do. y=. 'for_?'
  elseif. 'label_' -: 6{.y do. y=. 'label_?'
  end.
  top=. <y
  if. top e. DICT do.
    (>DICTX {~ DICT i.top),'.htm'
  else.
    ''
  end.
else.
  ''
end.
)
helpword=: 3 : 0
r=. ;: :: 0: y
if. r -: 0 do.
  smoutput LF,'word formation failed: ',dlb y
else.
  smoutput ,LF,.":r
end.
)
htmlhelpbaselib=: 3 : 0
  if. fexist f=. jpath '~.Main/', y do.
    open f
  else.
    browse_j_ 'http://www.jsoftware.com/trac/base7/browser/trunk/', y
  end.
0
)
htmlhelpgtk=: 3 : 0
lib=. ({.~ i.&'/') y
f1=. (f;'index.html'){::~ 0=#f=. }.(}.~ i.&'/') y
select. lib 
case. 'gtk' do.
  if. fexist ({.~ i.&'#') f2=. jpath '~addons/docs/gtk/gtk/', f1 do.
    browse_j_ 'file://', f2
  else.
    browse_j_ 'http://library.gnome.org/devel/gtk/stable/', f
  end.
case. 'gdk' do.
  if. fexist ({.~ i.&'#') f2=. jpath '~addons/docs/gtk/gdk/', f1 do.
    browse_j_ 'file://', f2
  else.
    browse_j_ 'http://library.gnome.org/devel/gdk/stable/', f
  end.
case. 'gdk-pixbuf' do.
  if. fexist ({.~ i.&'#') f2=. jpath '~addons/docs/gtk/gdk-pixbuf/', f1 do.
    browse_j_ 'file://', f2
  else.
    browse_j_ 'http://library.gnome.org/devel/gdk-pixbuf/stable/', f
  end.
case. 'glib' do.
  if. fexist ({.~ i.&'#') f2=. jpath '~addons/docs/gtk/glib/', f1 do.
    browse_j_ 'file://', f2
  else.
    browse_j_ 'http://library.gnome.org/devel/glib/stable/', f
  end.
case. 'gobject' do.
  if. fexist ({.~ i.&'#') f2=. jpath '~addons/docs/gtk/gobject/', f1 do.
    browse_j_ 'file://', f2
  else.
    browse_j_ 'http://library.gnome.org/devel/gobject/stable/', f
  end.
case. 'gio' do.
  if. fexist ({.~ i.&'#') f2=. jpath '~addons/docs/gtk/gio/', f1 do.
    browse_j_ 'file://', f2
  else.
    browse_j_ 'http://library.gnome.org/devel/gio/stable/', f
  end.
case. 'pango' do.
  if. fexist ({.~ i.&'#') f2=. jpath '~addons/docs/gtk/pango/', f1 do.
    browse_j_ 'file://', f2
  else.
    browse_j_ 'http://library.gnome.org/devel/gtk/stable/', f
  end.
case. 'cairo' do.
  if. fexist ({.~ i.&'#') f2=. jpath '~addons/docs/gtk/cairo/', f1 do.
    browse_j_ 'file://', f2
  else.
    browse_j_ 'http://cairographics.org/manual/', f
  end.
case. 'gtksourceview-2.0' do.
  if. fexist ({.~ i.&'#') f2=. jpath '~addons/docs/gtk/gtksourceview-2.0/', f1 do.
    browse_j_ 'file://', f2
  else.
    browse_j_ 'http://library.gnome.org/devel/gtksourceview/stable/', f
  end.
end.
0
)
j=. <;._2 (0 : 0)
= d000
=. d001
=: d001
< d010
<. d011
<: d012
> d020
>. d021
>: d022
_ d030
_. d031
_: d032
+ d100
+. d101
+: d102
* d110
*. d111
*: d112
- d120
-. d121
-: d122
% d130
%. d131
%: d132
^ d200
^. d201
^: d202n
$ d210
$. d211
$: d212
~ d220n
~. d221
~: d222
| d230
|. d231
|: d232
. d300
.. d301
.: d301
: d310n
:. d311
:: d312
, d320
,. d321
,: d322
; d330
;. d331
;: d332
# d400
#. d401
#: d402
! d410
!. d411
!: d412
/ d420
/. d421
/: d422
\ d430
\. d431
\: d432
[ d500
[: d502
] d500
{ d520
{. d521
{: d522
{:: d523
} d530n
}. d531
}: d532
" d600n
". d601
": d602
` d610
`: d612
@ d620
@. d621
@: d622
& d630n
&. d631
&: d632
&.: d631c
? d640
?. d640
__ d030
a. dadot
a: dadot
A. dacapdot
b. dbdotn
C. dccapdot
d. dddot
D. ddcapdot
D: ddcapco
e. dedot
E. decapdot
f. dfdot
H. dhcapdot
i. didot
i: dico
I. dicapdot
j. djdot
L. dlcapdot
L: dlcapco
M. dmcapdot
o. dodot
p. dpdot
p.. dpdotdot
p: dpco
q: dqco
r. drdot
s: dsco
S: dscapco
t. dtdotm
t: dtco
T. dtcapdot
u: duco
x: dxco
assert. cassert
break. cbreak
catch. ctry
do. ctrl
else. cif
elseif. cif
end. ctrl
label_? cgoto
case. csel
continue. ccont
fcase. csel
for. cfor
for_? cfor
goto_? cgoto
if. cif
return. cret
select. csel
throw. cthrow
try. ctry
while. cwhile
whilst. cwhile
0: dconsf
1: dconsf
2: dconsf
3: dconsf
4: dconsf
5: dconsf
6: dconsf
7: dconsf
8: dconsf
9: dconsf
_1: dconsf
_2: dconsf
_3: dconsf
_4: dconsf
_5: dconsf
_6: dconsf
_7: dconsf
_8: dconsf
_9: dconsf
)

n=. j i.&> ' '
DICT=: n {.each j
DICTX=: (n+1) }.each j
coclass 'jgtkimage'
coinsert 'jgtk'
create=: 3 : 0
File=: y
Dat=: fread File
if. Dat-:_1 do.
  smoutput 'not found: ',File
  destroy'' return.
end.
Pwh=: Twh=: 0
Resize=: (<(1+File i:'.')}.File) e. ;: 'svg'
make_win ''
make_timer 2000
1
)
destroy=: 3 : 0
cbfree''
codestroy''
)
rescale=: 3 : 0
p=. gdk_pixbuf_new_from_file_at_scale File;;/y,0 0
gtk_image_set_from_pixbuf image,p
)
make_timer=: 3 : 0
if. y do.
  sys_timer_z_=: ('timer_',(>coname''),'_')~
  settimer y
else.
  sys_timer_z_=: 0:
end.
0
)
timer=: 3 : 0
new=. fread File
if. new -: Dat do. 1 return. end.
if. new -: _1 do.
  smoutput 'not found: ',File
  window_delete''
  0 return.
end.
Dat=: new
if. Resize > Pwh-:Twh do.
  rescale Twh
else.
  gtk_image_set_from_file image;<File
end.
gtk_window_present window
1
)
Pwh=: Twh=: 0
make_win=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;'view'
consig3 window;'delete-event';'window_delete'
consig3 window;'key-press-event';'window_key_press'
if. Resize do.
  consig3 window;'configure_event';'window_configure'
else.
  gtk_window_set_resizable window,0
end.
image=: gtk_image_new_from_file <File
gtk_container_add window,image
windowfinish''
)
window_configure=: 3 : 0
e=. 1{y
wh=. _2 ic memr e,(GdkEventConfigure_xywh+8),8
if. Twh-:wh do. 0 return. end.
if. Twh-:0 do.
  Pwh=: wh
  gtk_widget_set_size_request window,0 0
else.
  rescale wh
end.
Twh=: wh
0
)
window_delete=: 3 : 0
make_timer 0
gtk_widget_destroy window
destroy''
1
)
window_key_press=: 3 : 0
if. -. isesckey y do. 0 return. end.
window_delete''
)
coclass 'jgtkide'
menu_init=: 3 : 0
f=. < @ (<;._1) @ (','&,)
j=. f;._2 Menus
MENUIDS=: {.&> j
MENUDEF=: }.each j
Launch=: menu_fexist Launch
Studio=: menu_fexist Studio
0
)
menu_fexist=: 3 : 0
t=. y #~ (fexist +. 0 = #) &> {:"1 y
t #~ (+. 1 |. (> </\)) 0 < # &> {:"1 t
)
j=. <;._2 (0 : 0)
0base.cfg
1dirmatch.cfg
1fkeys.cfg
0folders.cfg
1gtkide.cfg
1launch.cfg
0pacman.cfg
0startup.ijs
)

CDirs=: '1'={.&>j
CFiles=: }.each j
cb_cfg_open=: 3 : 0
if. y -: 'all' do.
  drs=. CDirs
  fls=. CFiles
else.
  ind=. (<y) i.~ (#y) {.each CFiles
  drs=. ind{CDirs
  fls=. ind{CFiles
end.
d=. (jpath '~system/config/');GtkConfig
cfg=. (<jpath '~config/') ,each fls
src=. (drs{d) ,each fls
for_f. cfg do.
  if. (fsize f) e. _1 0 do.
    s=. f_index pick src
    if. '.ijs' -: _4 {. s do.
      dat=. ''
    else.
      dat=. fread s
      if. dat -: _1 do.
        mbinfo (gettext 'Could not read: '),s
        1 return.
      end.
    end.
    dat fwrite f
  end.
end.
edit_openfiles__locEdit cfg;_1
1
)
config_menu=: 3 : 0
con=. gtk_menu_new''
m=. (<'cfg') ,each (CFiles i.&> '.') {.each CFiles
con&ccmenu each _1 }. m
create_menu_sep con
con&ccmenu each _1 {. m
create_menu_sep con
con ccmenu 'cfgall'
con
)
cfg_base_activate=: cb_cfg_open bind 'base'
cfg_dirmatch_activate=: cb_cfg_open bind 'dirmatch'
cfg_fkeys_activate=: cb_cfg_open bind 'fkeys'
cfg_folders_activate=: cb_cfg_open bind 'folders'
cfg_gtkide_activate=: cb_cfg_open bind 'gtkide'
cfg_launch_activate=: cb_cfg_open bind 'launch'
cfg_pacman_activate=: cb_cfg_open bind 'pacman'
cfg_startup_activate=: cb_cfg_open bind 'startup'
cfg_all_activate=: cb_cfg_open bind 'all'
proj_menu_enable=: 3 : 0
if. window__locEdit do.
  setenable mnProjectEnable__locEdit,.y
end.
setenable mnProjectEnable__locTerm,.y
)
script_menu_enable=: 1:
clearterm_activate=: 3 : 'term_clear__locTerm y'
editascii_activate=: 3 : 'boxdraw_j_ -. ''+'' e. 9!:6$0'
editfif_activate=: 3 : 'fif getselection$0'
editinputlog_activate=: 3 : 'cx_edit_inputlog__locTerm y'
fileclose_activate=: 3 : 'cx_file_close__locEdit y'
filecloseall_activate=: 3 : 'cx_file_closeall__locEdit y'
filecloseother_activate=: 3 : 'cx_file_closeother__locEdit y'
filedelete_activate=: 3 : 'cx_file_delete__locEdit y'
filenew_activate=: 3 : 'cx_file_new__locEdit y'
filenewtemp_activate=: 3 : 'cx_file_newtemp__locEdit y'
fileopen_activate=: 3 : 'cx_file_open__locEdit y'
fileopensystem_activate=: 3 : 'cx_file_opensystem__locEdit y'
fileopentemp_activate=: 3 : 'cx_file_opentemp__locEdit y'
fileopenuser_activate=: 3 : 'cx_file_openuser__locEdit y'
filerecent_activate=: 3 : '1[recent_run_jgtkide_ y'
filerestore_activate=: 3 : 'cx_file_restore__locEdit y'
filesave_activate=: 3 : '2 tab_save__locEdit$0'
filesaveall_activate=: 3 : '2 tab_saveall__locEdit$0'
filesaveas_activate=: 3 : 'cx_file_saveas__locEdit$0'
openedit_activate=: 3 : 'cx_edit_openedit__locEdit y'
openterm_activate=: 3 : 'cx_edit_openterm__locTerm y'
openterminal_activate=: 3 : 'cx_project_openterminal__locEdit y'
projectbuild_activate=: 3 : 'cx_project_build__locEdit y'
projectclose_activate=: 3 : 'cx_project_close__locEdit y'
projectlast_activate=: 3 : 'cx_project_last__locEdit y'
projectnew_activate=: 3 : 'make_project_new__locEdit y'
projectopen_activate=: 3 : 'cx_project_open__locEdit y'
projectprops_activate=: 3 : 'cx_project_props__locEdit y'
projectrun_activate=: 3 : 'cx_project_run__locEdit y'
runall_activate=: 3 : 'cx_run_all__locEdit y'
runclip_activate=: 3 : 'cx_run_clip y'
rundebug_activate=: 3 : 'cx_run_debug__locTerm$0'
runline_activate=: 3 : 'cx_run_line__locEdit y'
runlineadvance_activate=: 3 : 'cx_run_line_advance__locEdit y'
runscript_activate=: 3 : 'cx_load_script__locEdit y'
runselect_activate=: 3 : 'cx_run_select__locEdit y'
snapcompare_activate=: 3 : 'cx_project_snapcompare__locEdit y'
snapmake_activate=: 3 : 'cx_project_snapmake__locEdit y'
toexportscript_activate=: 3 : 'export__locEdit y'
toformatscript_activate=: 3 : 'lint__locEdit y'
toglobals_activate=: 3 : 'globals__locEdit y'
toolsdirm_activate=: 3 : '1[dmrun_jgtkdirm_ ''std'''
toolsfilesnaplist_activate=: 3 : 'smoutput pic_list_jp_$0'
toolsfkeys_activate=: 3 : 'fkey_list_jgtkide_$0'
tosellower_activate=: 3 : 'select_text__locEdit ''lower'''
toselminus_activate=: 3 : 'select_line__locEdit ''minus'''
toselplus_activate=: 3 : 'select_line__locEdit ''plus'''
toselplusline1_activate=: 3 : 'select_line__locEdit ''plusline1'''
toselplusline2_activate=: 3 : 'select_line__locEdit ''plusline2'''
toselsort_activate=: 3 : 'select_line__locEdit ''sort'''
toseltoggle_activate=: 3 : 'select_text__locEdit ''toggle'''
toselupper_activate=: 3 : 'select_text__locEdit ''upper'''
toselwrap_activate=: 3 : 'select_text__locEdit ''wrap'''
winclosex_activate=: 3 : 'window_closex__locEdit$0'
windup_activate=: 3 : 'window_dup__locEdit$0'
winnew_activate=: 3 : 'window_new__locEdit$0'
winproj_activate=: 3 : 'window_project__locEdit$0'
winscripts_activate=: 3 : 'window_scripts__locEdit$0'
winsource_activate=: 3 : 'window_source__locEdit$0'
wintext_activate=: 3 : 'window_text__locEdit$0'
winthrow_activate=: 3 : 'window_throw__locEdit$0'

create_menu_popup_gotodef=: popup_gotodef
create_menu_popup_gototag=: popup_gototag
cb_filer_recent_open=: 3 : 0
ndx=. {:y
fn=. 'cb_filer_recent_open_',(>coname''),'_'
ndx=. ndx - cbregs_jgtk_ i. <fn
if. 0=window__locEdit do. proj_close__locEdit'' end.
edit_opentab_show__locEdit ndx pick RecentFiles_j_
1
)
cb_project_recent=: 3 : 0
if. -.proj_closeok__locEdit'' do. 0 return. end.
ndx=. {:y
fn=. 'cb_project_recent_',(>coname''),'_'
ndx=. ndx - cbregs_jgtk_ i. <fn
proj_open__locEdit ndx pick RecentProjects_j_
1
)
clipcopy_activate=: 3 : 0
if. 0=buf=. getcurrentbuf'' do. 1 return. end.
gtk_text_buffer_copy_clipboard buf,gtk_clipboard_get 0
1
)
clipcut_activate=: 3 : 0
if. 0=buf=. getcurrentbuf'' do. 1 return. end.
gtk_text_buffer_cut_clipboard buf,(gtk_clipboard_get 0),1
1
)
clippaste_activate=: 3 : 0
if. 0=buf=. getcurrentbuf'' do. 1 return. end.
gtk_text_buffer_paste_clipboard buf,(gtk_clipboard_get 0),0 1
1
)
editfiw_activate=: 3 : 0
if. Class -: 'term' do.
  cx_edit_fiw__locTerm, y
else.
  cx_edit_fiw__locEdit y
end.
1
)
cx_edit_fiw=: 3 : 0
sel=. getselection''
if. #sel do.
  pos=. 1 pick bufget pSB
  bufsetselect pSB,pos,0
end.
fiw sel
1
)
editfont_activate=: 3 : 0
r=. fontdialog (gettext 'Session Font');FixFont
if. #r do. setfontall r end.
1
)
edittag_activate=: 3 : 0
if. 0= #name=. getselection'' do.
  if. 0= #name=. getcurrentname'' do.
    0 return.
  end.
end.
tag name
1
)
editccp_activate=: 3 : 0
if. ccp_query'' do. 1 return. end.
ccp_new _1
1
)
editacp_activate=: 3 : 0
autoCp=: -. autoCp
1
)
gitgui_activate=: 3 : 0
gitgui_jp_''
1
)
gitstatus_activate=: 3 : 0
gitstatus_jp_''
1
)
editsidebar_activate=: 3 : 0
sbShow=: -. sbShow
showsidebar''
1
)
fileload_activate=: 3 : 0
if. 0<#EditTabs__locEdit do.
  cx_load_script__locEdit''
end.
1
)
fileprint_activate=: 3 : 0
if. locEdit=coname'' do.
  cx_file_print__locEdit''
else.
  cx_file_print__locTerm''
end.
0
)
filequit_activate=: 3 : 0
if. locEdit=coname'' do.
  edit_hide''
else.
  term_close''
end.
0
)
filerecent_activate_open=: 3 : 0
ndx=. {:y
fn=. 'filerecent_activate_open_',(>coname''),'_'
ndx=. ndx - cbregs_jgtk_ i. <fn
if. 0=window__locEdit do. proj_close__locEdit'' end.
edit_opentab_show__locEdit ndx pick RecentFiles_j_
1
)
svncompare_activate=: 3 : 0
smoutput 'svn compare'
1
)
svnstatus_activate=: 3 : 0
smoutput 'svn status'
1
)
testrun_activate=: 3 : 0
if. Class-:'edit' do.
  edit_current_def''
  f=. pFL
else.
  f=. ''
end.
cx_test_run__locTerm f
1
)
tofilesnaps_activate=: 3 : 0
if. EditPage>:0 do.
  edit_current_def''
  pFL conew 'jgtkfilem'
end.
1
)
toolsjtags_activate=: 3 : 0
if. fexist jpath '~addons/general/jtags/jtags.ijs' do.
  require 'jtags ~addons/general/jtags/jtags.ijs'
  mbinfo 'jtags';(gettext 'This may take several minutes to finish')
  jtags''
  mbinfo 'jtags';(gettext 'Done')
else.
  mbinfo 'jtags';(gettext 'Please install addons general/jtags to run')
end.
0
)
toolslabsadvance_activate=: 3 : 0
if. (<'jlab')e.conl 0 do. labnext_jlab_'' end.
0
)
toolspacman_activate=: 3 : 0
require 'pacman ~addons/ide/gtk/pacman.ijs'
'' conew 'jpacman'
1
)
viewlinenos_activate=: 3 : 0
if. locTerm=coname'' do.
  viewlinenumbers termSV,-.viewlinenumbers termSV
else.
  LineNos_jgtkide_=: -.LineNos_jgtkide_
  edit_current_def''
  if. EditPage>:0 do.
    viewlinenumbers"1 (page_svs''),.LineNos_jgtkide_
  end.
end.
1
)
viewlinewrap_activate=: 3 : 0
if. locTerm=coname'' do.
  viewlinewrap termSV,-.viewlinewrap termSV
else.
  LineWrap_jgtkide_=: -.LineWrap_jgtkide_
  edit_current_def''
  if. EditPage>:0 do.
    viewlinewrap"1 (page_svs''),.LineWrap_jgtkide_
  end.
end.
1
)
launch_menu=: 3 : 0
if. 0 = #Launch do. return. end.
create_menu_sep y
r=. y ccmenu 'toolslaunch'
m=. I. 0 < # &> {:"1 Launch
cb=. 'cb_launch_run'
n=. #cbregs_jgtk_
cbregs_jgtk_=: cbregs_jgtk_, (#m)#<cb,'_',(>coname''),'_'
con=. gtk_menu_new''
for_d. {."1 Launch do.
  if. d_index e. m do.
    create_menu_sub con;cb;(n+m i. d_index);d
  else.
    create_menu_sep con
  end.
end.
gtk_menu_item_set_submenu r,con
)
cb_launch_run=: 3 : 0
ndx=. 1{y
ndx=. ndx - cbregs_jgtk_ i. ndx{cbregs_jgtk_
ndx=. ndx { I. 0 < # &> {:"1 Launch
load (<ndx;1){Launch
)
Menus=: fixNB_jp_ 0 : 0
cfgall,,Open All,,Open All,cfg_all_activate
cfgbase,,Base,,Base,cfg_base_activate
cfgdirmatch,,Directory Match,,Directory Match,cfg_dirmatch_activate
cfgfkeys,,Function Keys,,Function Keys,cfg_fkeys_activate
cfgfolders,,Folders,,Folders,cfg_folders_activate
cfggtkide,,Gtk Ide,,Gtk Ide,cfg_gtkide_activate
cfglaunch,,Launch Pad,,Launch,cfg_launch_activate
cfgpacman,,Pacman,,Pacman,cfg_pacman_activate
cfgprofile,,Profile Script,,Profile Script,cfg_profile_activate
cfgstartup,,Startup Script,,Startup Script,cfg_startup_activate

clearterm,gtk-execute,Clear Terminal,csT,Clear Terminal,clearterm_activate

clipcopy,gtk-copy,_Copy,cC,Copy,clipcopy_activate
clipcut,gtk-cut,Cu_t,cX,Cut,clipcut_activate
clippaste,gtk-paste,_Paste,cV,Paste,clippaste_activate

editascii,check0,_Toggle Ascii Box Drawing,,Toggle Ascii Box Drawing,editascii_activate
editconfig,,Configure,,Configure,
editfif,gtk-find,_Find in Files,csF,Find in Files,editfif_activate
editfiw,gtk-find,_Find,cF,Find,editfiw_activate
edittag,gtk-find,Find _Tag,c],Find Tag,edittag_activate
editccp,gtk-find,Code Completion,c[,Code Completion,editccp_activate
editacp,check0,Auto Completion,cU,Auto Completion,editacp_activate
editfont,gtk-select-font,_Session Font,,Set Session Font,editfont_activate
editinputlog,gtk-index,_Input Log,cD,Input Log,editinputlog_activate
editsidebar,check1,_Sidebar,cB,Sidebar,editsidebar_activate

fileclose,gtk-close,_Close,cW,Close window,fileclose_activate
filecloseall,gtk-close,C_lose All,,Close all windows,filecloseall_activate
filecloseother,gtk-close,C_lose Other,csW,Close other open documents,filecloseother_activate
filedelete,gtk-delete,_Delete,,Delete file,filedelete_activate
fileload,gtk-execute,_Load,cL,Load a script,fileload_activate
fileloadd,gtk-execute,_Load Display,cL,Load a script,fileloadd_activate
filenew,gtk-new,_New,,Create new script,filenew_activate
filenewtemp,gtk-new,_New temp,cN,Create a new temp script,filenewtemp_activate
fileopen,gtk-open,_Open,,Open a script,fileopen_activate
fileopensystem,gtk-open,_Open system,,Open a temp script,fileopensystem_activate
fileopentemp,gtk-open,_Open temp,cO,Open a temp script,fileopentemp_activate
fileopenuser,gtk-open,_Open user,,Open a user script,fileopenuser_activate
fileprint,gtk-print,_Print,,Print,fileprint_activate
filequit,gtk-quit,_Quit,cQ,Quit the program,filequit_activate
filerecent,,Recent,cG,Recent scripts,filerecent_activate
filerestore,,Restore,,Restore to Saved,filerestore_activate
filerun,gtk-execute,_Run,,Run a script,fileload_activate
filerund,gtk-execute,_Run Display,,Run script with display,fileloadd_activate
filesave,gtk-save,_Save,cS,Save,filesave_activate
filesaveall,gtk-save,_Save A_ll,csS,Save All,filesaveall_activate
filesaveas,gtk-save-as,Save _As,,Save As,filesaveas_activate

gitgui,,Git Gui,,Git Gui,gitgui_activate
gitstatus,,Git Status,,Git Status,gitstatus_activate

gotodef,gtk-open,Find _Definition,,Find Definition,create_menu_popup_gotodef
gototag,gtk-find,Find _Tag,,Find Tag,create_menu_popup_gototag

help,,_Help,,Help,helphelp_activate
helpabout,gtk-about,_About,,Help About,helpabout_activate
helpconstants,,Constants,,Constants,helpconstants_activate
helpcontext,,_Context Sensitive,cF1,Context Sensitive,helpcontext_activate
helpcontrols,,Control _Structures,,Control Structures,helpcontrols_activate
helpdictionary,,_Dictionary,,Dictionary,helpdictionary_activate
helpforeigns,,_Foreign Conjunction,,Foreign Conjunction,helpforeigns_activate
helpgeneral,,_General Info,,General Info,helpgeneral_activate
helpgtkapi,,GTK,,Helpgtkapi,
helpgtkide,,GTK IDE,,Helpgtkide,helpgtkide_activate
helprelease,,Release Highlights,,Release Highlights,helprelease_activate
helprelnotes,,Release _Notes,,Release _Notes,helprelnotes_activate
helpvocab,,Vocabulary,F1,Vocabulary,helpvocab_activate

helpcairo,,Cairo,,Cairo,helpcairo_activate
helpcairodocumentation,,On-line Cairo Documentation,,On-line Cairo Documentation,helpcairodocumentation_activate
helpgdk,,GDK,,GDK,helpgdk_activate
helpgdkpixbuf,,GDK Pixbuf,,GDK Pixbuf,helpgdkpixbuf_activate
helpgio,,GIO,,GIO,helpgio_activate
helpglib,,GLib,,GLib,helpglib_activate
helpgobject,,GObject,,GObject,helpgobject_activate
helpgtk,,GTK,,GTK,helpgtk_activate
helpgtkdocumentation,,On-line GTK Documentation,,On-line GTK Documentation,helpgtkdocumentation_activate
helpgtksourceview,,GtkSourceView,,GtkSourceView,helpgtksourceview_activate
helpgtktutorial,,GTK Tutorial,,Gtk Tutorial,helpgtktutorial_activate
helppango,,Pango,,Pango,helppango_activate

interrupt,,j console,,j console,interrupt

load_script,,_Load Script,cL,Load Script,runscript_activate

openedit,,Editor,cM,Editor,openedit_activate
openterm,,Terminal,cT,Terminal,openterm_activate
openterminal,,Open in Terminal,,Open in Terminal,openterminal_activate
openview,,Viewer,cK,Viewer,openview_activate

projectbuild,gtk-execute,_Build,cF9,Build Project,projectbuild_activate
projectclose,gtk-close,Close,,Close Project,projectclose_activate
projectlast,gtk-open,Open _Last,,Open Last Project,projectlast_activate
projectnew,gtk-new,New,,Create New Project,projectnew_activate
projectopen,gtk-open,Open,,Open Project,projectopen_activate
projectprops,gtk-properties,Properties,,Project Properties,projectprops_activate
projectrun,gtk-execute,_Run,F9,Run Project,projectrun_activate

runalllines,,All Lines,csR,All Lines,runall_activate
runclip,,_Clipboard,F8,Clipboard,runclip_activate
rundebug,,_Debug...,cK,Debug,rundebug_activate
runline,,_Line,cReturn,Line,runline_activate
runlineadvance,,Line and _Advance,cR,Line Advance,runlineadvance_activate
runproject,gtk-execute,_Run Project,F9,Run Project,projectrun_activate
runscript,,_Load Script,cL,Load Script,runscript_activate
runselect,,Run S_election,cE,Run Selection,runselect_activate
runtest,gtk-execute,_Test,F5,Run test verb,testrun_activate

snapcompare,,Project Snapshots,,Compare Project Snapshots,snapcompare_activate
snapmake,,Make Snapshot,,Make Snapshot,snapmake_activate

svncompare,,Compare SVN...,,Compare SVN,svncompare_activate
svnstatus,,Status SVN...,,Status SVN,svnstatus_activate

toexport,'',_Export,,Export Script,toexportscript_activate
tofilesnaps,'',_Script Snapshots,,Script Snapshots,tofilesnaps_activate
toglobals,'',_Global Assignments,,Global Assignments in File,toglobals_activate
tolint,'',_Format,csP,Format Script,toformatscript_activate
toselection,,Selection,,Selection,
tosellower,'',_Lower Case,,Lower Case,tosellower_activate
toselminus,'',_Remove nb.,csB,Remove nb.,toselminus_activate
toselplus,'',_Add nb.,csN,Add nb.,toselplus_activate
toselplusline1,'',_Add nb. ---,csK,Add nb. ---,toselplusline1_activate
toselplusline2,'',_Add nb. ===,csL,Add nb. ===,toselplusline2_activate
toselsort,'',_Sort,,Sort,toselsort_activate
toseltoggle,'',_Toggle Case,,Toggle Case,toseltoggle_activate
toselupper,'',_Upper Case,,Upper Case,toselupper_activate
toselwrap,'',_Wrap,,Wrap,toselwrap_activate

toolsdirm,,_Directory Match,,Directory Match,toolsdirm_activate
toolsfkeys,,Function Keys,,Function Keys,toolsfkeys_activate
toolsjtags,,Generate _Tags,,Generate Tags,toolsjtags_activate
toolspacman,,_Package Manager,,Package Manager,toolspacman_activate
toolslaunch,,Launch Pad,,Launch Pad,
toolsstudio,,Studio,,Studio,

viewlinenos,check0,Toggle Line _Numbers,,Toggle Line Numbers,viewlinenos_activate
viewlinewrap,check0,Toggle Line _Wrapping,,Toggle Line Wrapping,viewlinewrap_activate

winclosex,,_Close non-Project Files,,Close non-Project Files,winclosex_activate
windup,,_Duplicate Window,,Duplicate Edit Window,windup_activate
winnew,,_Other Window,csM,Other Edit Window,winnew_activate
winproj,,_Switch to Project at Tab,,Switch to Project at Tab,winproj_activate
winscripts,,Open All Scri_pts,,Open All Scripts,winscripts_activate
winsource,,Open All _Source,,Open All Source,winsource_activate
wintext,,Open All Te_xt,,Open All Text,wintext_activate
winthrow,,_Throw Tab,,Throw Tab to other Window,winthrow_activate
)
edit_menu=: 3 : 0
mb=. create_menu_bar''
file_menu mb
editx_menu mb;'edit'
view_menu mb;'edit'
run_menu mb
tools_menu mb
script_menu mb
project_menu mb
window_menu mb
help_menu mb
gtk_widget_show_all mb
widgetshow mnGit;0
mb
)
term_menu=: 3 : 0
mb=. create_menu_bar''
pop=. create_menu_popup mb;'_File'
con=. create_menu_container pop
con ccmenu 'filenewtemp'
create_menu_sep con
con ccmenu 'fileopentemp'
con ccmenu 'fileopenuser'
con ccmenu 'fileopensystem'
create_menu_sep con
con ccmenu 'filerecent'
if. IFSV do.
  create_menu_sep con
  con ccmenu 'fileprint'
end.
create_menu_sep con
con ccmenu 'filequit'
editx_menu mb;'term'
viewx_menu mb;'term'
runx_menu mb
tools_menu mb
projectx_menu mb
help_menu mb
gtk_widget_show_all mb
mb
)
editx_menu=: 3 : 0
'm s'=. 2 {. y
pop=. create_menu_popup m;(gettext '_Edit')
con=. create_menu_container pop
con ccmenu 'clipcut'
con ccmenu 'clipcopy'
con ccmenu 'clippaste'
create_menu_sep con
con ccmenu 'editfiw'
con ccmenu 'editfif'
if. s-:'edit' do.
  create_menu_sep con
  con ccmenu 'edittag'
  con ccmenu 'editccp'
  mnAutoCp=: con ccmenu 'editacp'
end.
if. s-:'edit' do.
  create_menu_sep con
  r=. con ccmenu 'toselection'
  gtk_menu_item_set_submenu r,selection_menu''
end.
create_menu_sep con
con ccmenu 'editfont'
r=. con ccmenu 'editconfig'
gtk_menu_item_set_submenu r,config_menu''
con
)
file_menu=: 3 : 0
pop=. create_menu_popup y;(gettext '_File')
con=. create_menu_container pop
con ccmenu 'filenew'
con ccmenu 'fileopen'
create_menu_sep con
con ccmenu 'filenewtemp'
con ccmenu 'fileopentemp'
create_menu_sep con
con ccmenu 'filerecent'
create_menu_sep con
con ccmenu 'filesave'
con ccmenu 'filesaveas'
con ccmenu 'filesaveall'
if. IFSV do.
  create_menu_sep con
  con ccmenu 'fileprint'
end.
create_menu_sep con
con ccmenu 'fileclose'
con ccmenu 'filecloseother'
con ccmenu 'filecloseall'
create_menu_sep con
con ccmenu 'filedelete'
create_menu_sep con
con ccmenu 'filequit'
)
gtkapi_menu=: 3 : 0
con=. gtk_menu_new''
m=. (<'help') ,&.> ;:'gtktutorial'
con&ccmenu &.> m
create_menu_sep con
m=. (<'help') ,&.> ;:'gtk gdk gdkpixbuf glib gobject gio pango gtksourceview'
con&ccmenu &.> m
create_menu_sep con
m=. (<'help') ,&.> ;:'cairo'
con&ccmenu &.> m
create_menu_sep con
m=. (<'help') ,&.> ;:'gtkdocumentation cairodocumentation'
con&ccmenu &.> m
con
)
help_menu=: 3 : 0
pop=. create_menu_popup y;(gettext '_Help')
con=. create_menu_container pop
con ccmenu 'help'
create_menu_sep con
con ccmenu 'helpgeneral'
con ccmenu 'helprelease'
create_menu_sep con
con ccmenu 'helpvocab'
con ccmenu 'helpconstants'
con ccmenu 'helpcontrols'
con ccmenu 'helpforeigns'
create_menu_sep con
con ccmenu 'helprelnotes'
con ccmenu 'helpdictionary'
studio_menu con
create_menu_sep con
con ccmenu 'helpgtkide'
create_menu_sep con
r=. con ccmenu 'helpgtkapi'
gtk_menu_item_set_submenu r,gtkapi_menu''
create_menu_sep con
con ccmenu 'helpcontext'
create_menu_sep con
con ccmenu 'helpabout'
)
project_menu=: 3 : 0
pop=. create_menu_popup y;(gettext '_Project')
con=. create_menu_container pop
con ccmenu 'projectnew'
con ccmenu 'projectopen'
con ccmenu 'projectlast'
create_menu_sep con
r=. con ccmenu 'projectclose'
create_menu_sep con
r=. r,con ccmenu 'projectrun'
r=. r,con ccmenu 'projectbuild'
create_menu_sep con
r=. r,con ccmenu 'projectprops'
create_menu_sep con
r=. r,con ccmenu 'snapcompare'
r=. r,con ccmenu 'snapmake'
s=. create_menu_sep con
s=. s,con ccmenu 'gitgui'
mnGit=: s,con ccmenu 'gitstatus'
r=. r,}.mnGit
s=. create_menu_sep con
s=. s,con ccmenu 'svncompare'
mnSVN=: s,con ccmenu 'svnstatus'
r=. r,}.mnSVN
create_menu_sep con
r=. r,con ccmenu 'openterminal'
mnProjectEnable=: mnProjectEnable,r
)
projectx_menu=: 3 : 0
pop=. create_menu_popup y;(gettext '_Project')
con=. create_menu_container pop
con ccmenu 'projectnew'
con ccmenu 'projectopen'
mnProjectEnable=: mnProjectEnable,con ccmenu 'projectclose'
)
run_menu=: 3 : 0
pop=. create_menu_popup y;(gettext '_Run')
con=. create_menu_container pop
con ccmenu 'runline'
con ccmenu 'runlineadvance'
con ccmenu 'runselect'
con ccmenu 'runalllines'
create_menu_sep con
con ccmenu 'runclip'
create_menu_sep con
con ccmenu 'load_script'
create_menu_sep con
con ccmenu 'runtest'
mnProjectEnable=: con ccmenu 'runproject'
launch_menu con
)
runx_menu=: 3 : 0
pop=. create_menu_popup y;(gettext '_Run')
con=. create_menu_container pop
con ccmenu 'runclip'
create_menu_sep con
con ccmenu 'runtest'
mnProjectEnable=: con ccmenu 'runproject'
launch_menu con
)
script_menu=: 3 : 0
pop=. create_menu_popup y;(gettext '_Script')
con=. create_menu_container pop
r=. ''
r=. r,con ccmenu 'tolint'
create_menu_sep con
r=. r,con ccmenu 'filerestore'
create_menu_sep con
r=. r,con ccmenu 'tofilesnaps'
create_menu_sep con
r=. r,con ccmenu 'toglobals'
mnScriptEnable=: r
)
selection_menu=: 3 : 0
con=. gtk_menu_new''
con ccmenu 'toselminus'
con ccmenu 'toselplus'
con ccmenu 'toselplusline1'
con ccmenu 'toselplusline2'
create_menu_sep con
con ccmenu 'tosellower'
con ccmenu 'toselupper'
con ccmenu 'toseltoggle'
create_menu_sep con
con ccmenu 'toselsort'
create_menu_sep con
con ccmenu 'toselwrap'
con
)
tools_menu=: 3 : 0
pop=. create_menu_popup y;(gettext '_Tools')
con=. create_menu_container pop
con ccmenu 'toolsdirm'
create_menu_sep con
con ccmenu 'toolspacman'
create_menu_sep con
con ccmenu 'toolsjtags'
create_menu_sep con
con ccmenu 'toolsfkeys'
con
)
view_menu=: 3 : 0
'mb asc'=. y
pop=. create_menu_popup mb;(gettext '_View')
con=. create_menu_container pop
con ccmenu 'editinputlog'
create_menu_sep con
mnSideBar=: con ccmenu 'editsidebar'
con ccmenu 'openterm'
create_menu_sep con
con ccmenu 'clearterm'
create_menu_sep con
if. asc do. con ccmenu 'editascii' end.
if. IFSV do. con ccmenu 'viewlinenos' end.
con ccmenu 'viewlinewrap'
)
viewx_menu=: 3 : 0
'mb asc'=. y
pop=. create_menu_popup mb;(gettext '_View')
con=. create_menu_container pop
con ccmenu 'editinputlog'
create_menu_sep con
con ccmenu 'openedit'
create_menu_sep con
con ccmenu 'clearterm'
create_menu_sep con
if. asc do. con ccmenu 'editascii' end.
if. IFSV do. con ccmenu 'viewlinenos' end.
)
window_menu=: 3 : 0
pop=. create_menu_popup y;(gettext '_Window')
con=. create_menu_container pop
con ccmenu 'winnew'
con ccmenu 'windup'
create_menu_sep con
con ccmenu 'winthrow'
create_menu_sep con
con ccmenu 'winproj'
create_menu_sep con
con ccmenu 'winsource'
con ccmenu 'winscripts'
con ccmenu 'wintext'
create_menu_sep con
con ccmenu 'winclosex'
)
submenu=: 3 : 0
'cb len val hnd'=. y
t=. <cb,'_',(>coname''),'_'
if. len<0 do.
  n=. 0 >. (#val) - +/ cbregs_jgtk_ = t
  cbregs_jgtk_=: cbregs_jgtk_, n#t
else.
  cbregs_jgtk_=: cbregs_jgtk_, (len * -. t e. cbregs_jgtk_)#t
end.
n=. cbregs_jgtk_ i. t
sub=. gtk_menu_new''
for_d. val do.
  create_menu_sub sub;cb;(n+d_index);d
end.
gtk_menu_item_set_submenu hnd,sub
setenable hnd,0<#val
gtk_widget_show_all sub
)
popup_init=: 3 : 0
ccp_destroy''
menu=. 1{y
c=. get_glist gtk_container_get_children menu
for_w. _2 {. c do.
  gtk_container_remove menu,w
end.
w=. menu ccmenu 'gotodef'
w=. menu ccmenu 'gototag'
gtk_widget_show_all menu
0
)
popup_gotodef=: 3 : 0
gotodef bufreadselect getcurrentbuf''
)
popup_gototag=: 3 : 0
if. 0= #name=. getselection'' do.
  if. 0= #name=. getcurrentname'' do.
    0 return.
  end.
end.
gototag name
0
)
studio_menu=: 3 : 0
if. 0 = #Studio do. return. end.
create_menu_sep y
r=. y ccmenu 'toolsstudio'
m=. I. 0 < # &> {:"1 Studio
cb=. 'cb_studio_run'
n=. #cbregs_jgtk_
cbregs_jgtk_=: cbregs_jgtk_, (#m)#<cb,'_',(>coname''),'_'
con=. gtk_menu_new''
for_d. {."1 Studio do.
  if. d_index e. m do.
    create_menu_sub con;cb;(n+m i. d_index);d
  else.
    create_menu_sep con
  end.
end.
gtk_menu_item_set_submenu r,con
)
cb_studio_run=: 3 : 0
ndx=. 1{y
ndx=. ndx - cbregs_jgtk_ i. ndx{cbregs_jgtk_
ndx=. ndx { I. 0 < # &> {:"1 Studio
load (<ndx;1){Studio
)
coclass 'jgtkpairsel'
coinsert 'jgtk'
MinSize=: 400 300
create=: 3 : 0
'ids cat list ind callback title header wrap'=. 8 {. y
hit=. (i. 1 + >./ind) e. ind
assert. (#cat) = #hit
cat=. hit#cat
ind=. (I.hit) i. ind
ndx=. /:cat
Cat=: ndx{cat
ind=. ndx i. ind

ndx=. /:list
List=: ndx{list
Ind=: ndx{ind

Ctx=: 0
Plist=: List
Ptx=: 0

Callback=: callback
Title=: title,(0=#title)#'Select'
Header=: header
Wrap=: {.wrap,0

make_select ids

1
)
destroy=: 3 : 0
cbfree''
codestroy''
)
csel_key_press=: 0:
csel_row_activated=: 0:
psel_cursor_changed=: 0:
psel_key_press=: 0:
csel_cursor_changed=: 3 : 0
if. NoEvents do. 1 return. end.
noevents 1
Ctx=: listbox_getactiverow Ctv
Ptx=: listbox_getactiverow Ptv
sel=. Ptx { Plist
if. Ctx=0 do.
  Plist=: List
else.
  Plist=: List #~ Ind = Ctx - 1
end.
ndx=. (#Plist) | Plist i. sel
setlistbox Ptv;Plist;ndx
noevents 0
1
)
size_allocate=: 3 : 0
if. NoEvents do. 0 return. end.
wid=. _2 ic memr (1{y),8 4
if. wid-:Hwid do. 0 return. end.
Hwid=: wid
noevents 1
gtk_widget_set_size_request Hlabel,(wid-5),_1
noevents 0
0
)
select_button=: 3 : 0
Callback~ Plist pick~ listbox_getactiverow Ptv
if. -. 1 { getmodifiers'' do. window_delete'' end.
1
)
window_delete=: 3 : 0
gtk_widget_destroy window
destroy''
1
)
psel_row_activated=: select_button
make_select=: 3 : 0

newwindow (gettext Title)
windowdefaultsize MinSize
gtk_window_set_modal window,1
gtk_window_set_type_hint window,GDK_WINDOW_TYPE_HINT_DIALOG
windowcenter''

sel=. make_select_lists y
if. #Header do.
  vb=. gtk_vbox_new 0 4
  Hlabel=: label=. newlabel (gettext Header)
  if. Wrap do.
    Hwid=: 0
    consig3 label;'size-allocate';'size_allocate'
    gtk_label_set_line_wrap label,1
  end.
  gtk_box_pack_start vb,label,0 0 4
  gtk_box_pack_start vb,(gtk_hseparator_new ''),0 0 0
  gtk_box_pack_start vb,sel,1 1 4
  gtk_container_add window,vb
else.
  gtk_container_add window,sel
end.
windowfinish''
listbox_select Ctv,0
listbox_select Ptv,0
setchildfocus Ptv
)
make_select_lists=: 3 : 0
hb=. gtk_hbox_new 0 6
vb=. gtk_vbox_new 0 0
label=. gtk_label_new <(gettext 0 pick y)
gtk_misc_set_alignment label, 0 0.5
gtk_box_pack_start vb,label,0 0 4
sw=. newsw''
Ctv=: tv=. makelistbox 'csel';('All';Cat);'';'';0
gtk_container_add sw,tv
gtk_box_pack_start vb,sw,1 1 0
gtk_box_pack_start hb,vb,1 1 0

vb=. gtk_vbox_new 0 0
label=. gtk_label_new <(gettext 1 pick y)
gtk_misc_set_alignment label, 0 0.5
gtk_box_pack_start vb,label,0 0 4
sw=. newsw''
Ptv=: tv=. makelistbox 'psel';List;'';'';0
gtk_container_add sw,tv
gtk_box_pack_start vb,sw,1 1 0
gtk_box_pack_start hb,vb,1 1 0

vb=. gtk_vbox_new 0 0
label=. gtk_label_new <''
gtk_box_pack_start vb,label,0 0 4
button=. newbutton ('  ','  ',~gettext 2 pick y);'select_button'
gtk_box_pack_start vb,button,0 0 0
gtk_box_pack_start hb,vb,0 0 5
hb
)
coclass 'jgtkideprint'
coinsert 'jgtk'

compositor=: 0
operation=: 0

paginate=: 3 : 0
'operation context data'=. y
if. gtk_source_print_compositor_paginate compositor, context do.
  npages=. gtk_source_print_compositor_get_n_pages compositor
  gtk_print_operation_set_n_pages operation, npages
  1 return.
end.
0
)

draw_page=: 3 : 0
'operation context page_nr data'=. y
gtk_source_print_compositor_draw_page compositor, context, page_nr
0
)

end_print=: 3 : 0
'operation context data'=. y
g_object_unref print_compositor
0
)

create=: 0:

destroy=: 3 : 0
cbfree''
codestroy''
)

print=: 3 : 0
compositor=: gtk_source_print_compositor_new_from_view y
operation=: gtk_print_operation_new ''
consig3 operation;'paginate';'paginate'
consig4 operation;'draw-page';'draw_page'
consig3 operation;'end-print';'end_print'

gtk_print_operation_run operation, GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG, 0 0

g_object_unref operation

EMPTY
)

coclass 'jgtkedit'
make_script_new=: 4 : 0
if. -. fexist x,y do.
  (DefCmt,(extnone_j_ y),LF2) fwrite x,y
end.
)
make_project_new=: 3 : 0
parent=. tofoldername_j_ fpath_j_ ProjectPath_jp_
r=. newproject_jgtkdialog_ termsep parent
if. 0=#r do. 1 return. end.
'path other build run init'=. r
p=. path2proj_j_ path
if. -.proj_closeok'' do. 1 return. end.
projwritenew_jp_ p
f=. (build,run,init)#;:'build run init'
f=. f, cutopen other
if. #f do.
  f=. sort ~. extsrc each f
  (<path,'/') make_script_new each f
  f=. f -. ('build';'run') ,each <ScriptExt
end.
proj_open__locEdit p
if. #f do.
  Source_jp_=: (<path,'/') ,each f
  (;LF,~each projsname each Source) fappends Project
  tab_open__locEdit |. fexists Source_jp_
end.
1
)
cx_project_props=: 3 : '1[edit_opentab_show Project_jp_'
cx_project_build=: 3 : 0
if. 0=#Build_jp_ do.
  mbinfo (gettext 'Project Build');(gettext 'First set the project build script.')
  1 return.
end.
if. -.fexist jpath Build_jp_ do.
  mbinfo (gettext 'Project Build');(gettext 'Project build script not found:'),LF2,Build_jp_
  1 return.
end.
if. 1 tab_saveall'' do.
  term_load_script__locTerm Build_jp_
end.
1
)
cx_project_close=: 3 : 0
proj_closeok''
tab_refresh''
1
)
cx_project_last=: 3 : 0
ndx=. (0 ~: window__locEdit) *. 0 < #Project_jp_
if. ndx < #RecentProjects_j_ do.
  if. proj_closeok'' do.
    proj_open ndx pick RecentProjects_j_
  end.
end.
1
)
cx_project_open=: 3 : 0
'' conew 'jgtkpsel'
1
)
cx_project_openterminal=: 3 : 0
if. 0=#ProjectPath_jp_ do. return. end.
if. -.IFUNIX do.
  smoutput (gettext 'not yet in windows') return.
end.
term=. Terminal_jgtkide_
if. 0=#term do.
  mbinfo (gettext 'Terminal');gettext 'Terminal not defined in gtkide configuration.'
  1 return.
end.
ndx=. 1 i.~ '%1' E. term
2!:1 (ndx{.term),ProjectPath_jp_,(ndx+2)}.term
0
)
cx_project_run=: 3 : 0
if. 0=#Run_jp_ do.
  mbinfo (gettext 'Project Run');(gettext 'No project run script.')
  1 return.
end.
if. -.fexist jpath Run_jp_ do.
  f=. toprojectfolder_jp_ Run_jp_
  mbinfo (gettext 'Project Run');(gettext 'Project run script not found:'),LF2,f
  1 return.
end.
if. 1 tab_saveall'' do.
  if. fexist jpath Build_jp_ do.
    loadscript Build_jp_
  end.
  term_load_script__locTerm Run_jp_
end.
1
)
cx_project_snapcompare=: 3 : 0
p=. ProjectName_jp_
if. 0=#p do.
  mbinfo (gettext 'Compare Snapshots');(gettext 'First open a project.')
  1 return.
end.
if. 0=#ss_list_jp_ p do.
  mbinfo (gettext 'Compare Snapshots');(gettext 'No snapshots for this project.')
  1 return.
end.
dmrun_jgtkdirm_ 'snp'
)
cx_project_snapmake=: 3 : 'snapshot_jp_ 1'
proj_close=: 3 : 0
projclose_jp_''
conf_save''
proj_menu_enable 0
)
proj_closeok=: 3 : 0
if. 0=#Project_jp_ do. 1 return. end.
if. window__locEdit do.
  if. -.0 tab_saveall'' do. 0 return. end.
  projsaveopen''
  tab_closeall__locEdit''
end.
proj_close''
1
)
proj_fini=: 3 : 0
sbfiles_open_folder ProjectPath_jp_
widgetshow mnGit;gitcheck_jp_''
widgetshow mnSVN;0
proj_menu_enable 1
)
proj_open=: 3 : 0
if. -. proj_closeok'' do. 0 return. end.
noevents 1
edit_show''
projopen_jp_ y
conf_save''
sidebar_set_page 0
if. -. fexist Project_jp_ do.
  EditPage=: _1
  proj_menu_enable 0
  script_menu_enable''
  noevents 0
  sidebar_refresh''
  0 return.
end.
proj_openfiles''
proj_fini''
gtk_widget_show_all EditNB__locEdit
noevents 0
sidebar_refresh''
1
)
proj_openfiles=: 3 : 0
edit_openfiles projgetopen''
)
PJdef=: PPdef=: i.0 2

PJnames=: <;._2 (0 : 0)
Folder
FolderIds
FolderTree
)

PPnames=: <;._2 (0 : 0)
Project
ProjectPath
ProjectName
Build
Run
Source
)
ppack=: 3 : 0
PJdef=: pack_j_ PJnames
PPdef=: pack_jp_ PPnames
EMPTY
)
ppdef=: 3 : 0
pdef_j_ PJdef
pdef_jp_ PPdef
)
projgetopen=: 3 : 0
ndx=. ({.&>ProjOpen) i. <getprojname''
if. ndx<#ProjOpen do.
  dat=. ndx pick ProjOpen
  open=. (#~ fexist) projfname each 2 }. dat
  page=. (<: #open) <. 0 ". 1 pick dat
else.
  open=. ''
  page=. _1
end.
open;page
)
projreadopen=: 3 : 0
ProjOpen_jp_=: ''
dat=. 'b' freads ProjectDat
if. dat -: _1 do. return. end.
dat=. a: -.~ deb each dat
dat=. dat #~ (<'NB.') ~: 3 {.each dat
if. 0=#dat do. return. end.
sep=. {. 0 pick dat
dat=. (-sep={:&>dat) }.each dat
ProjOpen_jp_=: <;._1 each dat
)
projsaveopen=: 3 : 0
f=. 1{"1 EditTabs
open=. projsname each f #~ 0 < #&> f
page=. EditPage <. <:#open
id=. getprojname''
ndx=. ({.&>ProjOpen) i. <id
if. ndx<#ProjOpen do.
  ProjOpen_jp_=: (<<<ndx){ProjOpen
end.
msk=. 0 < #&> 0 pick each ProjOpen
ProjOpen_jp_=: msk # ProjOpen
new=. (<id;(":page);open),ProjOpen
new=. new #~ ~: {.&> new
ProjOpen_jp_=: ((RecentMax<.#){.]) new
sep=. '|!@#$%^&*+-=?~`' -. ;ProjOpen
if. #sep do.
  sep=. {. sep
else.
  sep=. {.(32}.a.) -. ;ProjOpen
end.
p=. ([: ; sep ,each ]) each ProjOpen
txt=. 'NB. gtkide open files',LF2,;p ,each LF
txt fwrites ProjectDat
)
coclass 'jgtkpsel'
coinsert 'jgtkide'

MinSize=: 350 400
Root=: '{root}'
getrecent=: 3 : 0
if. 0=#y do. '' return. end.
r=. touserfolder @ }: @ (0 pick fpathname) each y
a: -.~ ('~'={.&> r) }.each r
)
create=: 3 : 0
coextend COCREATOR

Folders=: 0{"1 UserFolders_j_
Recent=: getrecent RecentProjects_j_

if. (0=#Folders) *. 0=#Recent do.
  projbrowse'' return.
end.

Paths=: jpath each 1{"1 UserFolders_j_
Ids=: (#Folders)#<0
Idx=: (#Folders)#_1

msk=. -. isroot_j_ &> Recent
ndx=. msk * Recent i. &> '/'
Recent2=: (ndx {.each Recent) ,. (ndx+msk) }.each Recent

Predraw=: 0

initsel''
noevents 1
make_psel''
noevents 0
1
)
destroy=: 3 : 0
cbfree''
codestroy''
)
initsel=: 3 : 0
if. #Recent do.
  Rtx=: 0
  Ftx=: Folders index {.{.Recent2
  if. Ftx>:0 do.
    getids Ftx
    t=. Ftx pick Ids
    ndx=. t index {:{.Recent2
    Idx=: ndx Ftx} Idx
  end.
else.
  Rtx=: _1
  Ftx=: 0 >. Folders index <Folder_j_
  getids Ftx
  t=. Ftx pick Ids
  ndx=. t index <ProjectPath_jp_,'/'
  Idx=: ndx Ftx} Idx
end.
)
getids=: 3 : 0
if. 0 -: y pick Ids do.
  ndx=. _1
  p=. 1 pick getfolderdefs_j_ y pick Paths
  p=. (<Root) (I.p=<'')} p
  Ids=: (<p) y} Ids
  if. (0<#p) *. 0<#Recent2 do.
    ind=. ({."1 Recent2) i. Ftx{Folders
    if. ind < #Recent2 do.
      ndx=. p index {:ind{Recent2
    end.
  end.
  if. 1=#p do. ndx=. 0 end.
  Idx=: ndx Ftx} Idx
end.
EMPTY
)
getrecentx=: 3 : 0
ndx=. Ftx{Idx
if. (ndx<0) +. Ftx<0 do.
  Rtx=: _1
else.
  Rtx=: Recent2 index (Ftx{Folders),ndx{Ftx pick Ids
end.
)
predraw=: 3 : 0
if. -. Predraw do. return. end.
if. Ftx<0 do. return. end.
getids Ftx
nms=. Ftx pick Ids
setlistbox Ptv;nms;Ftx{Idx
Predraw=: 0
)
projbrowse=: 3 : 0
r=. dialog 'file_project_open'
if. #r do.
  proj_open__locEdit r
end.
destroy''
)
escape_close=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Escape do. 0 return. end.
'ctrl j shift'=. 2 2 2 #: state
if. ctrl +. shift do. 0 return. end.
projsel_close''
1
)
fsel_cursor_changed=: 3 : 0
if. NoEvents do. 1 return. end.
noevents 1
Ftx=: listbox_getactiverow Ftv
getids Ftx
setlistbox Ptv;(Ftx pick Ids);Ftx{Idx
getrecentx''
listbox_select Rtv,Rtx
noevents 0
1
)
projsel_close=: 3 : 0
readwinpos 'PselPos'
gtk_widget_destroy window
destroy''
1
)
psel_cursor_changed=: 3 : 0
if. NoEvents do. 1 return. end.
noevents 1
row=. listbox_getactiverow Ptv
Idx=: row Ftx} Idx
getrecentx''
listbox_select Rtv,Rtx
noevents 0
1
)
rsel_cursor_changed=: 3 : 0
if. NoEvents do. 1 return. end.
noevents 1
Rtx=: listbox_getactiverow Rtv
Ftx=: Folders index {. Rtx{Recent2
if. Ftx<0 do.
  setlistbox Ptv;''
  Predraw=: 1
else.
  getids Ftx
  setlistbox Ptv;(Ftx pick Ids);Ftx{Idx
  t=. Ftx pick Ids
  ndx=. t index {:Rtx{Recent2
  Idx=: ndx Ftx} Idx
  listbox_select Ftv,Ftx
  listbox_select Ptv,Ftx{Idx
  predraw''
end.
noevents 0
1
)
fsel_row_activated=: psel_row_activated=: rsel_row_activated=: open
fsel_key_press=: psel_key_press=: rsel_key_press=: escape_close
projsel_button=: open
window_delete=: projsel_close
make_psel=: 3 : 0
newwindow (gettext 'select project')
size=. MinSize >. 2 3{PselPos
windowdefaultsize size
gtk_window_set_modal window,1
gtk_window_set_type_hint window,GDK_WINDOW_TYPE_HINT_DIALOG
windowcenter''

vbox=. gtk_vbox_new 0 0
hb=. gtk_hpaned_new''
hp=. gtk_hpaned_new''
vb=. gtk_vbox_new 0 0
Flb=: label=. gtk_label_new <(gettext 'Folder:')
gtk_misc_set_alignment label, 0 0.5
gtk_box_pack_start vb, label, 0 1 3
sw=. newsw''
Ftv=: tv=. makelistbox 'fsel';Folders;Ftx;'';0
gtk_container_add sw,tv
gtk_box_pack_start vb, sw, 1 1 3
gtk_paned_pack1 hp, vb, 1 1
vb=. gtk_vbox_new 0 0
label=. gtk_label_new <(gettext 'Project:')
gtk_misc_set_alignment label, 0 0.5
gtk_box_pack_start vb, label, 0 1 3
sw=. newsw''
if. Ftx<0 do.
  ids=. ''
  idx=. _1
else.
  ids=. Ftx pick Ids
  idx=. Ftx{Idx
end.
Ptv=: tv=. makelistbox 'psel';ids;idx;'';0
gtk_container_add sw,tv
gtk_box_pack_start vb, sw, 1 1 3
gtk_paned_pack2 hp, vb, 1 1

fex=. hp
gtk_paned_pack1 hb, hp, 1 1
hx=. gtk_hbox_new 0 0
vb=. gtk_vbox_new 0 0
label=. gtk_label_new <(gettext 'Recent:')
gtk_misc_set_alignment label, 0 0.5
gtk_box_pack_start vb, label, 0 1 3
sw=. newsw''
Rtv=: tv=. makelistbox 'rsel';Recent;Rtx;'';0
gtk_container_add sw,tv
gtk_box_pack_start vb, sw, 1 1 3
rex=. vb

gtk_paned_pack2 hb, vb, 1 1
gtk_box_pack_start vbox, hb, 1 1 3
hbox=. gtk_hbox_new 0 3
lab=. gtk_label_new <''
gtk_box_pack_start hbox,lab,1 0 0

button=. gtk_button_new''
bbox=. gtk_hbox_new 0 0
image=. gtk_image_new_from_stock 'gtk-open';GTK_ICON_SIZE_BUTTON
label=. gtk_label_new_with_mnemonic <(gettext 'Open')
gtk_box_pack_start bbox, image, 0 0 3
gtk_box_pack_start bbox, label, 0 0 3
gtk_container_add button, bbox
gtk_box_pack_start hbox,button,0 0 3
consig button;'clicked';'projsel_button'
gtk_box_pack_start vbox,hbox,0 0 3
gtk_container_add window,vbox
gtk_paned_set_position hb,<.0.6*{.size
windowfinish''
if. Rtx>:0 do.
  setchildfocus Rtv
else.
  setchildfocus Ftv
end.
if.0=#Folders do.
  gtk_widget_hide fex
elseif. 0=#Recent do.
  gtk_widget_hide rex
end.

)
open=: 3 : 0
if. open1'' do. projsel_close'' else. 1 end.
)
open1=: 3 : 0
r=. open2''
if. 0 -: r do.
  mbinfo (gettext 'select project');(gettext 'No project selected')
  0 return.
end.
if. 0=+/Visible do.
  mod=. 0
  edit_show__locEdit''
else.
  mod=. 1{getmodifiers''
  if. mod do. window_new'' end.
end.
'f p'=. r
n=. (termsep f),p
if. (n -: ProjectName_jp_) *: f -: Folder_j_ do.
  if. -.proj_closeok'' do. 1 return. end.
end.
if. -. f -: Folder_j_ do.
  setfolder_j_ f
end.
edit=. mod{locEdit0,locEdit1
proj_open__edit ppath n
1
)
open2=: 3 : 0
if. Rtx>:0 do.
  Rtx{Recent2 return.
end.
ndx=. Ftx{Idx
if. _1 e. Ftx,ndx do. 0 return. end.
id=. ndx{Ftx pick Ids
if. id -: Root do.
  id=. ''
else.
  (Ftx{Folders),id
end.
)
coclass 'jgtkedit'

SideAss=: ''
SideList=: ''
SidePos=: 0
SideRow=: _1
SideIds=: ''
SideSrc=: ''
SideTabs=: 'sbfiles';'sbsource';'sbdefs'
fv_getfiles=: 3 : 0
d=. fv_getfilelist SidePath,'/*'
e=. (,<'..');''
if. 0=#d do. e return. end.
f=. {."1 d
m=. 'd' = 4 {"1 > 4 {"1 d
ndx=. /: tolower each f
f=. ndx{f
m=. ndx{m
((<'..'),m#f);<(-.m)#f
)
fv_getfilelist=: 3 : 0
d=. 1!:0 y
if. 0=#d do. return. end.
f=. {."1 d
d=. d #~ -. ('~' = {: &> f) +. ({.&> f) e. '.~'
if. 0=#d do. return. end.
d #~ 'h' ~: 1 {"1 > 4 {"1 d
)
sbdefs_init=: 3 : 0
vb=. gtk_vbox_new 0 0
tb=. make_sbdefs_toolbar''
gtk_box_pack_start vb, tb, 0 0 0
sd=. makelistbox 'sbdefs';'';'';'';0
sw=. newsw''
gtk_container_add sw,sd
gtk_box_pack_start vb, sw, 1 1 0
SideDefs=: sd
vb
)

sbdefs_cursor_changed=: 1:
sbdefs_row_activated=: 3 : 0
sbdefs_select listbox_row_activated y
)
sbdefs_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Return do. 0 return. end.
sbdefs_select listbox_getactiverow w
)
sbdefs_refresh=: 3 : 0
edit_current_def''
if. EditPage<0 do.
  nms=. ''
else.
  nms=. globalassigns bufread page_buf EditPage
  nms=. nms /: (a.,~(97+i.26){a.)&i. each nms
end.
if. -. nms -: SideAss do.
  setlistbox SideDefs;<nms
  SideAss=: nms
  SideRow=: _1
  SidePos=: 0
end.
)
sbdefs_select=: 3 : 0
edit_current_def''
ass=. y pick SideAss
nam=. (ass i. ' ') {. ass
if. (nam -: ass) +. y ~: SideRow do.
  SidePos=: 0
end.
SideRow=: y
txt=. bufread pSB
pos=. sbdefs_select_do nam;SidePos;txt
if. pos = _1 do.
  SidePos=: 0
  mbinfo (gettext 'Not found: '),nam return.
end.
SidePos=: pos + #nam
viewsetselect pSV,pos,#nam
1
)
sbdefs_select_do=: 3 : 0
'nam pos txt'=. y
hit=. nam fiwss_assign_jgtkfiw_ pos }. txt
if. #hit do. pos + {.hit return. end.
{. _1 ,~ nam fiwss_assign_jgtkfiw_ txt
)
fb_activate=: 3 : 0
sidebar_refresh''
1
)
fv_project_path=: 3 : 0
if. #ProjectPath_jp_ do.
  p=. ProjectPath_jp_
else.
  p=. Pathp
end.
assert. 0=nc<'p'
sbfiles_open_folder p
1
)
fv_row_activated=: 3 : 0
'w p c d'=. y
r=. 0 pick gtk_tree_path_get_indices <<p
row=. {. _2 ic memr r,0 4
'dir file'=. SideList
if. row=0 do.
  ftb_go_up''
elseif. row<#dir do.
  sbfiles_open_folder SidePath,'/',row pick dir
elseif. 1 do.
  edit_opentab_show SidePath,'/',(row-#dir) pick file
end.
1
)
ftb_current_path=: 3 : 0
file=. page_file EditPage
if. 0=#file do.
  sidebar_project_path'' return.
end.
sbfiles_open_folder fpath file
)
ftb_go_home=: 3 : 0
sbfiles_open_folder jpath '~home'
)
ftb_go_up=: 3 : 0
SidePath=: (SidePath i: '/') {. SidePath
sidebar_refresh''
)
path_entry_activate=: 3 : 0
p=. getentry sidePathEntry
sp=. jpath p
if. -. isdir sp do.
  sp=. jpath addtilde p
end.
SidePath=: sp
sidebar_refresh''
)
sbfiles_init=: 3 : 0
vb=. gtk_vbox_new 0 0
tb=. make_sbfiles_toolbar''
gtk_box_pack_start vb, tb, 0 0 0
sidePathEntry=: path=. gtk_entry_new''
gtk_box_pack_start vb, path, 0 0 2
consig path;'activate';'path_entry_activate'
fv=. make_fileview''
sw=. newsw''
gtk_container_add sw,fv
gtk_container_add vb,sw
vb
)
sbfiles_clear_filter=: 3 : 0
sidebar_refresh''
)
sbfiles_open_folder=: 3 : 0
SidePath=: y
sidebar_refresh''
)
sbfiles_refresh=: 3 : 0
p=. remtilde toprojectfolder_jp_ SidePath
setentry sidePathEntry;p
fv_refresh''
)
sidebar_init=: 3 : 0
nb=. gtk_notebook_new''
consig4 nb;'switch_page';'sidebar_switch_page'

fs=. sbfiles_init''
lab=. newlabel (gettext 'files')
gtk_notebook_append_page nb,fs,lab

ss=. sbsource_init''
lab=. newlabel (gettext 'source')
gtk_notebook_append_page nb,ss,lab

ds=. sbdefs_init''
lab=. newlabel (gettext 'defs')
gtk_notebook_append_page nb,ds,lab

SidePage=: 0

nb
)
sidebar_refresh=: 3 : 0
if. NoEvents do. 0 return. end.
edit_current_def''
((SidePage pick SideTabs),'_refresh')~''
widgetshow SideTB,0<#ProjectName_jp_
0
)
sidebar_set_page=: 3 : 0
gtk_notebook_set_current_page EditSB,SidePage=: y
sidebar_refresh''
)
sidebar_switch_page=: 3 : 0
if. NoEvents do. 0 return. end.
SidePage=: 2 pick y
sidebar_refresh''
)
sbsource_init=: 3 : 0
vb=. gtk_vbox_new 0 0
tb=. make_sbsource_toolbar''
gtk_box_pack_start vb, tb, 0 0 0
sd=. makelistbox 'sbsource';'';'';'';0
sw=. newsw''
gtk_container_add sw,sd
gtk_box_pack_start vb, sw, 1 1 0
SideLB=: sd
SideTB=: vb
vb
)

sbsource_cursor_changed=: 1:
sbsource_row_activated=: 3 : 0
sbsource_select listbox_row_activated y
)
sbsource_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key ~: GDK_Return do. 0 return. end.
sbsource_select listbox_getactiverow w
)
sbsource_refresh=: 3 : 0
'nms ids'=. projssource_jp_''
SideSrc=: nms
if. SideIds -: ids do. return. end.
SideIds=: ids
setlistbox SideLB;<ids
)
sbsource_select=: 3 : 0
edit_opentab_show y pick SideSrc
)
make_sbdefs_toolbar=: 3 : 0
tb=. gtk_toolbar_new''
gtk_toolbar_set_icon_size tb, GTK_ICON_SIZE_MENU
gtk_toolbar_set_style tb, GTK_TOOLBAR_ICONS
wid=. gtk_tool_button_new_from_stock <'gtk-refresh'
gtk_widget_set_tooltip_text wid;(gettext 'Refresh')
consig wid;'clicked';'sidebar_refresh'
gtk_container_add tb, wid
tb
)
make_sbfiles_toolbar=: 3 : 0

tb=. gtk_toolbar_new''
gtk_toolbar_set_icon_size tb, GTK_ICON_SIZE_MENU
gtk_toolbar_set_style tb, GTK_TOOLBAR_ICONS

wid=. gtk_tool_button_new_from_stock <'gtk-refresh'
gtk_widget_set_tooltip_text wid;(gettext 'Refresh')
consig wid;'clicked';'sidebar_refresh'
gtk_container_add tb, wid

wid=. gtk_tool_button_new_from_stock <'gtk-home'
gtk_widget_set_tooltip_text wid;(gettext 'Home')
consig wid;'clicked';'ftb_go_home'
gtk_container_add tb, wid

wid=. gtk_tool_button_new_from_stock <'gtk-jump-to'
gtk_widget_set_tooltip_text wid;(gettext 'Set path from document')
consig wid;'clicked';'ftb_current_path'
gtk_container_add tb, wid

tb
)
make_sbsource_toolbar=: 3 : 0
tb=. gtk_toolbar_new''
gtk_toolbar_set_icon_size tb, GTK_ICON_SIZE_MENU
gtk_toolbar_set_style tb, GTK_TOOLBAR_ICONS
wid=. gtk_tool_button_new_from_stock <'gtk-refresh'
gtk_widget_set_tooltip_text wid;(gettext 'Refresh')
consig wid;'clicked';'sidebar_refresh'
gtk_container_add tb, wid
tb
)

fv_clear=: 3 : 0
gtk_list_store_clear SideFS
if. last_dir_iter do.
  gtk_tree_iter_free last_dir_iter
  last_dir_iter = 0
end.
)
fv_refresh=: 3 : 0
if. -. isdir SidePath do.
  SideList=: ''
  gtk_list_store_clear SideFS
  EMPTY return.
end.
df=. fv_getfiles ''
if. df -: SideList do. EMPTY return. end.
SideList=: df
gtk_list_store_clear SideFS
iter=. i.ITERSIZE
for_i. 0 1 do.
  icon=. i pick 'gtk-directory';'gtk-file'
  for_d. i pick df do.
    gtk_list_store_append SideFS;iter
    gtk_list_store_set_3 SideFS;iter;0;icon;1;d,<_1
  end.
end.
EMPTY
)
make_fileview=: 3 : 0
SideFV=: fv=. gtk_tree_view_new''
SideFS=: fs=. gtk_list_store_new_2 2,2#G_TYPE_STRING
gtk_tree_view_set_model fv,fs
g_object_unref fs
icon_renderer=. gtk_cell_renderer_pixbuf_new''
text_renderer=. gtk_cell_renderer_text_new''
column=. gtk_tree_view_column_new ''
gtk_tree_view_column_pack_start column,icon_renderer,0
gtk_tree_view_column_add_attribute column;icon_renderer;'stock-id';0
gtk_tree_view_column_pack_start column,text_renderer,1
gtk_tree_view_column_add_attribute column;text_renderer;'text';1
gtk_tree_view_append_column fv,column
gtk_tree_view_set_headers_visible fv,0
gtk_tree_view_set_enable_search fv,0
select=. gtk_tree_view_get_selection fv
gtk_tree_selection_set_mode select, GTK_SELECTION_MULTIPLE
consig fv;'realize';'fv_project_path'
consig4 fv;'row-activated';'fv_row_activated'
fv
)

coclass 'jgtkterm'
coinsert 'jgtkide j'
create=: 3 : 0
locTerm_jgtkide_=: coname''
Class=: 'term'
ifOutput=: 0
ifResized=: 1
MaxBufLines=: 1000
InputLogDat=: jpath '~config/inputlog.dat'
InputLogMax=: 100
InputLog=: dlog_read''
InputLogPos=: #InputLog
window=: 0
)
destroy=: 3 : 0
cbfree''
codestroy''
)
CheckMoves=: GDK_Home

delmode=: ]
getcmd=: ]
prompt_init=: ]

begin_action=: 3 : 'gtk_text_buffer_begin_user_action termSB'
end_action=: 3 : 'gtk_text_buffer_end_user_action termSB'
bufiterbounds=: 3 : 'y;(newiterstart y);newiterend y'
docmd=: 3 : 0
settermsize''
s=. dltb y
dlog_add s
immex_jgtkide_ s
)

exec=: docmd
fkey_exec=: 3 : 0
'key c s'=. y
ndx=. FKeys i. 1 + (key-GDK_F1) + 100 * 2 #. c,s
if. ndx=#FKeys do. return. end.
fkey_exec_index ndx
)
fkey_exec_index=: 3 : 0
'out lab code'=. y{FKeyx
select. out
case. 0 do.
  promptclear''
  runimmex0 code
case. 1 do.
  promptclear''
  runimmex1 code
case. 2 do.
  promptnew (getprompt''),code
case. 3 do.
  0!:100 code
end.
1
)
getfontsize=: 3 : 0
rect=. i.4
layout=. gtk_widget_create_pango_layout termSV;,'W'
pango_layout_get_pixel_extents layout;0;rect
if. IF64 do.
  Fwh=: |.(0,256^4)#:1{rect
else.
  Fwh=: 2 3{rect
end.
EMPTY
)
getprompt=: 3 : 0
prompt_jgtkide_
)
moveit=: 3 : 0
if. y ~: GDK_Home do. 0 return. end.
mark=. i.ITERSIZE
gtk_text_buffer_get_iter_at_mark termSB;mark;gtk_text_buffer_get_insert termSB
bgn=. newiterline termSB,gtk_text_iter_get_line <mark
p=. readstringfree gtk_text_iter_get_text bgn;mark
viewscrolliter termSV;bgn
if. n=. (#p) | (p=' ')i.0 do.
  gtk_text_iter_forward_chars bgn;n
end.
gtk_text_buffer_place_cursor termSB;bgn
1
)
setmaxbuflines=: 3 : 0
len=. gtk_text_buffer_get_line_count termSB
if. len <: MaxBufLines do. return. end.
bgn=. newiterstart termSB
end=. newiterline termSB,len-MaxBufLines
gtk_text_buffer_delete termSB;bgn;end
)
settermsize=: 3 : 0
if. -.ifResized do. return. end.
settermsize1 0 >. <.(Twh-1) % Fwh
ifResized=: 0
)
settermsize1=: 3 : 0
Cwh_j_=: 0 >. <: y
)
dlog_add=: 3 : 0
if. (0=#y) +. 'NB. ' -: 4 {. y do. return. end.
dlog_add1 y
)
dlog_add1=: 3 : 0
InputLog=: (InputLog-.<y),<y
if. KeepInputLog do.
 (y,LF) 1!:3 ::] <InputLogDat
end.
dlog_max''
)
dlog_max=: 3 : 0
if. InputLogMax < #InputLog do.
  InputLog=: (-InputLogMax){.InputLog
end.
InputLogPos=: #InputLog
)
dlog_read=: 3 : 0
if. -.KeepInputLog do. '' return. end.
dat=. 'b' freads InputLogDat
if. (dat -: _1) +. 0 = #dat do. '' return. end.
dat=. ~.&.|. a: -.~ ('NB.' -: 3 {. 0 pick dat) }. dat
(- InputLogMax <. #dat) {. dat
)
dlog_scroll=: 3 : 0
if. 0=#InputLog do. 1 return. end.
new=. 0 >. (#InputLog) <. InputLogPos + y
if. new=InputLogPos do. 1 return. end.
InputLogPos=: new
if. InputLogPos=#InputLog do.
  p=. _1 pick InputLog
else.
  p=. InputLogPos pick InputLog
end.
promptnewlog p
1
)
dlog_write=: 3 : 0
if. -.KeepInputLog do. '' return. end.
dat=. ~.&.|. (dlog_read''),InputLog
dat=. (- InputLogMax <. #dat) {. dat
('NB. gtkide inputlog',LF,; dat ,each LF) fwrites InputLogDat
)
cx_edit_inputlog=: 3 : 0
'' conew 'jgtkdlog'
)
cx_edit_openterm=: 3 : 0
setwindowfocus window
setchildfocus termSV
)
cx_file_print=: 3 : 0
p=. conew 'jgtkideprint'
print__p termSV
destroy__p''
0
)
cx_test_run=: 3 : 0
exec 'test''',y,''''
)
cx_run_debug=: 3 : 0
dbgtk 1
)
dbgtk=: 3 : 0
if. y do.
  if. _1 = 4!:0 <'jdb_open_jdebug_' do.
    0!:0 <jpath '~addons/ide/gtk/debugs.ijs'
  end.
  jdb_open_jdebug_''
  13!:0 [ 1
else.
  jdb_close_jdebug_ :: ] ''
  13!:15 ''
  13!:0 [ 0
end.
)
hs_changed=: 3 : 0
smoutput 'hschanged'
0
)
sv_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. (key=GDK_Control_L) +. key=GDK_Shift_L do. 0 return. end.
'ctrl j shift'=. 2 2 2 #: state
if. key e. GDK_FKeys do.
  fkey_exec__locTerm key,ctrl,shift return.
end.
if. ctrl > shift do.
  select. key
  case. GDK_Left do. moveword 0,termSB,termSV
  case. GDK_Right do. moveword 1,termSB,termSV
  case. GDK_d do. cx_edit_inputlog''
  case. GDK_j do. lab_jlab_ ::] 0
  case. GDK_k do. cx_run_debug''
  case. GDK_y do. gtk_source_buffer_redo termSB
  case. GDK_Return;GDK_KP_Enter do. term_key_enter 1
  end.
  return.
end.
if. shift > ctrl do. 0 return. end.
if. shift do.
  select. key
  case. GDK_Up do. dlog_scroll _1
  case. GDK_Down do. dlog_scroll 1
  end.
  return.
end.
if. key e. CheckMoves do.
  if. moveit key do. 1 return. end.
end.
select. key
case. GDK_Return;GDK_KP_Enter do. term_key_enter 0 return.
case. GDK_Escape do.
  if. EscClose do. term_close'' return. end.
end.
0
)
sv_populate_popup=: 3 : 'popup_init y'
term_close=: 3 : 0
if. IFBROADWAY do. 1 return. end.
if. ConfirmClose do.
  if. 0=mbnoyes 'term';(gettext 'OK to exit J?') do. 1 return. end.
end.
if. -. edit_hide__locEdit'' do. 0 return. end.
dlog_write''
main_quit_jgtkide_''
1
)
term_key_enter=: 3 : 0
len=. gtk_text_buffer_get_line_count termSB
row=. bufreadlinenumber termSB
txt=. readline row
if. row < len-1 do.
  promptnew getcmd txt
else.
  if. y do. 0 return. end.
  docmd txt
end.
1
)
window_configure=: 3 : 0
e=. 1{y
wh=. _2 ic memr e,(GdkEventConfigure_xywh+8),8
if. -. Twh -: wh do.
  Twh=: wh
  ifResized=: 1
end.
0
)
window_focus_in=: 3 : 'setwinfocus {.y'
window_delete=: term_close
term_open=: 3 : 0
newwindow 'Term'
TermPos setwinpos window
if. -.UNAME-:'Darwin' do.
  gtk_window_set_icon_from_file window;TermIcon;0
end.
consig3 window;'configure_event';'window_configure'
consig3 window;'focus-in-event';'window_focus_in'
vb=. gtk_vbox_new 0 0
gtk_container_set_border_width vb,0
termMenu=: term_menu window
proj_menu_enable 0
'termSW termSV termSB'=: newcodeview 'term';TermScheme;'';''
termEnd=: gtk_text_buffer_get_mark termSB;'end'
termScroll=: gtk_text_buffer_get_mark termSB;'scroll'
prompt_init''
gtk_box_pack_start vb, termMenu, 0 0 0
gtk_box_pack_start vb, termSW, 1 1 0
gtk_container_add window,vb
windowfinish''
gtk_window_present window
getfontsize''
)
readline=: 3 : 0
bgn=. newiterline termSB,y
end=. newiterline termSB,y
gtk_text_iter_forward_to_line_end <end
readstringfree gtk_text_iter_get_text bgn;end
)
readlastline=: 3 : 0
bgn=. newiterlastline termSB
end=. newiterend termSB
readstringfree gtk_text_iter_get_text bgn;end
)
readtext=: 3 : 0
readstringfree gtk_text_iter_get_text (newiterstart termSB);newiterend termSB
)
term_exec_script=: 4 : 0
f=. deb y
if. 0 = #f do. return. end.
if. 0 = fexist jpath f do. return. end.
c=. (x=2) term_load_script_fmt f
if. x=0 do.
  exec c return.
end.
promptnew c
exec c
conf_save''
gtk_widget_show_all termMenu
macmenu''
)
term_load_script=: 1 & term_exec_script
term_loadd_script=: 2 & term_exec_script
term_load_script_fmt=: 4 : 0
'   load',(x#'d'),' ''',y,''''
)
term_newscript=: 3 : 0
edit_opentab_show ''
)
appendtext=: 3 : 0
t=. octal_j_ y
gtk_text_buffer_insert termSB;(newiterend termSB);t;_1
)
movecursorend=: 3 : 0
gtk_text_buffer_place_cursor termSB;newiterend termSB
)
promptclear=: 3 : 0
bgn=. newiterlastline termSB
end=. newiterend termSB
gtk_text_buffer_delete termSB;bgn;end
)
promptnew=: 3 : 0
promptclear''
term_append y,(0=#y)#getprompt''
)
promptnewlog=: 3 : 0
promptnew (getprompt''),y
)
showlastline=: 3 : 0
if. 0~: termScroll do.
  iter=. newiterlastline termSB
  gtk_text_buffer_move_mark termSB;termScroll;iter
  gtk_text_view_scroll_mark_onscreen termSV,termScroll
end.
)
showprompt=: 3 : 0
if. ifOutput do.
  ifOutput=: 0
  if. 0~: termEnd do.
    gtk_text_view_scroll_to_mark termSV,termEnd,0 0 0 0
  end.
end.
EMPTY
)
term_append=: 3 : 0
begin_action''
appendtext y
setmaxbuflines''
showlastline''
movecursorend''
end_action''
ifOutput=: 1
setidle 'showprompt_',(>locTerm),'_$0'
)
term_append_run=: 3 : 0
promptclear''
appendtext (getprompt''),y
exec readline termSB,gtk_text_buffer_get_line_count termSB
)
term_clear=: 3 : 0
gtk_text_buffer_delete bufiterbounds termSB
term_append getprompt''
)
coclass 'jtextview'
coinsert 'jgtkide'
create=: makeview
destroy=: 3 : 0
cbfree''
codestroy''
0
)
makeview=: 3 : 0
'title text'=. _2 {. 'view';y
text=. octal_j_ text
newwindow title
windowdefaultsize 700 500
consig3 window;'key-press-event';'window_key_press'
windowcenter''
'sw sv sb'=. newcodeview 'view';EditScheme;'';text
gtk_container_add window,sw
gtk_text_view_set_editable sv,0
windowfinish''
EMPTY
)
sv_key_press=: 0:
sv_button_press=: 0:
sv_populate_popup=: 0:
view_close=: 3 : 0
gtk_widget_destroy window
destroy''
1
)
window_key_press=: 3 : 0
if. -.isesckey y do. 0 return. end.
view_close''
1
)
textview_z_=: 3 : 0
empty y conew 'jtextview'
)

window_delete=: view_close

cocurrent 'base'
jgtkide''
