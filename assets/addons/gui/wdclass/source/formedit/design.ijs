NB. design

DESIGN_NOTMAC=: 0 : 0
pc design nomax nomin nosize;
menupop "File";
menu save "Save" "" "" "";
menusep ;
menu exit "Exit" "" "" "";
menupopz;
menupop "Window";
menu winnew "New  Control" "" "" "";
menu wincontrol "Control" "" "" "";
menu winparent "Parent" "" "" "";
menusep ;
menu windel "Delete Control" "" "" "";
menusep ;
menu winmenu "Menu" "" "" "";
menu wintoolbar "Toolbar" "" "" "";
menu winstatus "Statusbar" "" "" "";
menusep ;
menu wincode "Code" "" "" "";
menu winscript "Script" "" "" "";
menupopz;
menupop "Help";
menu helpformedit "Form Edit" "" "" "";
menupopz;
xywh 14 4 11 11;cc n button;cn "";
xywh 3 15 11 11;cc w button;cn "";
xywh 14 15 11 11;cc c button;cn "1";
xywh 25 15 11 11;cc e button;cn "";
xywh 14 26 11 11;cc s button;cn "";
xywh 39 4 28 11;cc new button;cn "New...";
xywh 39 15 28 11;cc view button;cn "View";
xywh 39 26 28 11;cc script button;cn "Script";
xywh 70 4 28 11;cc undo button;cn "Undo";
xywh 70 15 28 11;cc redo button;cn "Redo";
xywh 70 26 28 11;cc lock button;cn "Lock";
xywh 98 4 28 11;cc center button;cn "Center";
xywh 98 15 28 11;cc size button;cn "Size";
xywh 126 4 28 11;cc space button;cn "Space";
xywh 126 15 28 11;cc touch button;cn "Touch";
xywh 154 4 28 11;cc minus button;cn "Minus";
xywh 154 15 28 11;cc plus button;cn "Plus";
xywh 185 4 36 11;cc ok button;cn "OK";
xywh 185 15 36 11;cc cancel button;cn "Cancel";
xywh 102 28 50 11;cc id static;cn "";
xywh 152 28 56 11;cc pos static ss_center;cn "";
pas 3 1;pcenter;
rem form end;
)

DESIGN_MAC=: 0 : 0
pc design nomax nomin nosize;
menupop "File";
menu save "Save" "" "" "";
menusep ;
menu exit "Exit" "" "" "";
menupopz;
menupop "Window";
menu winnew "New  Control" "" "" "";
menu wincontrol "Control" "" "" "";
menu winparent "Parent" "" "" "";
menusep ;
menu windel "Delete Control" "" "" "";
menusep ;
menu winmenu "Menu" "" "" "";
menu wintoolbar "Toolbar" "" "" "";
menu winstatus "Statusbar" "" "" "";
menusep ;
menu wincode "Code" "" "" "";
menu winscript "Script" "" "" "";
menupopz;
menupop "Help";
menu helpformedit "Form Edit" "" "" "";
menupopz;
xywh 21 4 18 13;cc n button;cn "";
xywh 3 17 18 13;cc w button;cn "";
xywh 21 17 18 13;cc c button;cn "1";
xywh 39 17 18 13;cc e button;cn "";
xywh 21 30 18 13;cc s button;cn "";
xywh 60 4 34 13;cc new button;cn "New...";
xywh 60 17 34 13;cc view button;cn "View";
xywh 60 30 34 13;cc script button;cn "Script";
xywh 97 4 34 13;cc undo button;cn "Undo";
xywh 97 17 34 13;cc redo button;cn "Redo";
xywh 97 30 34 13;cc lock button;cn "Lock";
xywh 131 4 34 13;cc center button;cn "Center";
xywh 131 17 34 13;cc size button;cn "Size";
xywh 165 4 34 13;cc space button;cn "Space";
xywh 165 17 34 13;cc touch button;cn "Touch";
xywh 199 4 34 13;cc minus button;cn "Minus";
xywh 199 17 34 13;cc plus button;cn "Plus";
xywh 236 4 36 13;cc ok button;cn "OK";
xywh 236 17 36 13;cc cancel button;cn "Cancel";
xywh 134 34 50 13;cc id static;cn "";
xywh 185 34 56 13;cc pos static ss_center;cn "";
pas 3 1;pcenter;
rem form end;
)

DESIGN=: >(UNAME-:'Darwin'){DESIGN_NOTMAC;DESIGN_MAC

NB. =========================================================
design_align=: 3 : 0
if. 2 > #SELECT do. return. end.
anc=. {. SELECT
bal=. }. SELECT
select. y
case. 'w' do.
  CCS=: ((<anc;0) { CCS) (<bal;0) } CCS
case. 'n' do.
  CCS=: ((<anc;1) { CCS) (<bal;1) } CCS
case. 'e' do.
  lef=. 0 >. (+/ (<anc;0 2) { CCS) - (<bal;2) { CCS
  CCS=: lef (<bal;0) } CCS
case. 's' do.
  top=. 0 >. (+/ (<anc;1 3) { CCS) - (<bal;3) { CCS
  CCS=: top (<bal;1) } CCS
end.
drawpaint ''
bufsnap''
)

NB. =========================================================
design_close=: 3 : 0
try.
  saveform''
  smfocus''
catch. end.
destroy''
)

NB. =========================================================
design_c_button=: 3 : 0
STEP=: (STEP = 1) { 1 4
wd 'setcaption c ',": STEP
)

NB. =========================================================
design_cancel_button=: 3 : 0
smfocus''
destroy''
)

NB. =========================================================
design_center_button=: 3 : 0
if. isempty SELECT do. return. end.
if. 0 = # (i.#CCS) -. SELECT do. return. end.
if. ifshiftkey '' do.
  hit=. (1 { PAS) + >./ +/"1 (<(<SELECT);1 3) { CCS
  top=. roundint -: hit - (<SELECT;3) { CCS
  CCS=: top (<SELECT;1) } CCS
else.
  wid=. (0 { PAS) + >./ +/"1 (<(<SELECT);0 2) { CCS
  lef=. roundint -: wid - (<SELECT;2) { CCS
  CCS=: lef (<SELECT;0) } CCS
end.
drawpaint ''
bufsnap''
)

NB. =========================================================
design_enable=: 3 : 0
selectdesign''
select. # SELECT
case. 0 do.
  cmd=. '/minus 0/plus 0/size 0/space 0/touch 0'
case. 1 do.
  cmd=. '/minus 0/plus 0/size 0/space 0/touch 0'
case. 2 do.
  cmd=. '/minus 1/plus 1/size 1/space 0/touch 1'
case. do.
  cmd=. '/minus 1/plus 1/size 1/space 1/touch 1'
end.
wd ;'setenable '&, each (<;._1 cmd) ,each ';'
wd 'setenable center ',":(#SELECT) e. }. i.#CCS
)

NB. =========================================================
design_helpformedit_button=: 3 : 0
htmlhelp_j_ 'user\form_editor_overview.htm'
)

NB. =========================================================
design_lock_button=: 3 : 0
LOCK=: -.LOCK
wd 'setcaption lock ',LOCK pick 'Lock';'Unlock'
if. LOCK do.
  if. #SELECT do.
    SELECT=: ,{. SELECT
  end.
  CURSOR=: IDC_ARROW
  CAPTURE=: CAPNONE
  drawpaint''
  design_enable''
end.
)

NB. =========================================================
design_move=: 3 : 0
if. ifshiftkey'' do.
  design_align y
else.
  design_move1 y
end.
)

NB. =========================================================
design_move1=: 3 : 0
if. # SELECT do.
  m=. (y = 'es') - y = 'wn'
  c=. SELECT { CCS
  c=. c +"1 m, 0 0
  if. STEP > 1 do.
    ndx=. y e. 'sn'
    if. y e. 'es' do.
      c=. (STEP roundup ndx {"1 c) ndx }"0 1 c
    else.
      c=. (STEP rounddown ndx {"1 c) ndx }"0 1 c
    end.
  end.
  c=. 0 >. c
  CCS=: c SELECT } CCS
  drawpaint ''
  bufsnap''
end.
)

NB. =========================================================
design_save_button=: 3 : 0
saveform''
)

NB. =========================================================
design_script_button=: 3 : 0
smopen FNAME
smfocus''
)

NB. =========================================================
design_size_button=: 3 : 0
if. 2 > #SELECT do. return. end.
anc=. {. SELECT
bal=. }. SELECT
if. ifshiftkey '' do.
  h=. (<anc;3) { CCS
  CCS=: h (<bal;3) } CCS
else.
  w=. (<anc;2) { CCS
  CCS=: w (<bal;2) } CCS
end.
drawpaint ''
bufsnap''
)

NB. =========================================================
design_space_button=: 3 : 0
if. 3 > len=. #SELECT do. return. end.
if. ifshiftkey '' do.
  ccs=. viewccs''
  ndx=. SELECT /: (<SELECT;1) { ccs
  top=. (<ndx;1) { ccs
  hit=. (<ndx;3) { ccs
  spc=. ({:top) - ({.top) + +/ }: hit
  dif=. 0 >. roundint spc % <: len
  new=. ({.top) + }: +/\ hit + dif
  CCS=: new (<(}.ndx);1) } CCS
else.
  ndx=. SELECT /: (<SELECT;0) { CCS
  lef=. (<ndx;0) { CCS
  wid=. (<ndx;2) { CCS
  spc=. ({:lef) - ({.lef) + +/ }: wid
  dif=. 0 >. roundint spc % <: len
  new=. ({.lef) + }: +/\ wid + dif
  CCS=: new (<(}.ndx);0) } CCS
end.
drawpaint ''
bufsnap''
)

NB. =========================================================
design_spread=: 3 : 0
if. 2 > #SELECT do. return. end.
bal=. }. SELECT
if. ifshiftkey '' do.
  bal=. bal /: (<bal;1) { CCS
  y=. (y * 1 + i.#bal) + (<bal;1) { CCS
  CCS=: y (<bal;1) } CCS
else.
  bal=. bal /: (<bal;0) { CCS
  x=. (y * 1 + i.#bal) + (<bal;0) { CCS
  CCS=: x (<bal;0) } CCS
end.
drawpaint ''
bufsnap''
)

NB. =========================================================
design_touch_button=: 3 : 0
if. 2 > #SELECT do. return. end.
anc=. {. SELECT
bal=. }. SELECT
if. ifshiftkey '' do.
  ccs=. viewccs''
  top=. (<anc;1) { ccs
  bal=. bal /: (<bal;1) { ccs
  hit=. (<(anc,}:bal);3) { ccs
  y=. top + 0, +/\ >:hit
  CCS=: y (<(anc,bal);1) } CCS
else.
  lef=. (<anc;0) { CCS
  bal=. bal /: (<bal;0) { CCS
  x=. lef + 0, +/\ >:(<(anc,}:bal);2) { CCS
  CCS=: x (<(anc,bal);0) } CCS
end.
drawpaint ''
bufsnap''
)

NB. =========================================================
design_view_button=: 3 : 0
if. #TESTLOC do.
  open=. wd :: 0: 'psel ',TESTHWNDP,';pclose'
  coerase :: ] TESTLOC
  TESTLOC=: TESTHWNP=: ''
  if. open do. return. end.
end.
TESTLOC=: cocreate ''
a=. form_create 1
try. wd__TESTLOC a
catch.
  err=. wd 'qer'
  ndx=. >: err i. ':'
  msg=. ndx {. err
  pos=. {.". ndx }. err
  cmd=. (>:j i.';') {. j=. pos}. a
  if. 50 < #cmd do.
    cmd=. (47{.cmd),'...' end.
  info 'wd error ',msg,LF,cmd
  coerase :: ] TESTLOC
  TESTLOC=: ''
  return.
end.
wd 'pshow'
TESTHWNDP=: wd 'qhwndp'
selectdesign''
)

NB. =========================================================
design_ok_button=: design_close

design_e_button=: design_move bind 'e'
design_n_button=: design_move bind 'n'
design_s_button=: design_move bind 's'
design_w_button=: design_move bind 'w'

design_minus_button=: design_spread bind _1
design_plus_button=: design_spread bind 1

design_new_button=: newcc_run
design_exit_button=: design_close
design_redo_button=: bufredo
design_undo_button=: bufundo
design_wincode_button=: wcode_run
design_wincontrol_button=: wcontrol_run
design_windel_button=: deletecc
design_winmenu_button=: wmenu_run
design_winnew_button=: newcc_run
design_winparent_button=: wparent_run
design_winscript_button=: design_script_button
design_winstatus_button=: wstatus_run
design_wintoolbar_button=: wtbar_run

