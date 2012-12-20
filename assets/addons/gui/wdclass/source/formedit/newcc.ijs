NB. new

NB. =========================================================
NEWCC=: 0 : 0
pc newcc nomax nomin nosize owner;pn "New Control";
xywh 4 6 171 143;cc g0 groupbox;cn "Class";
xywh 12 17 47 11;cc standard radiobutton;cn "Standard";
xywh 60 17 33 11;cc ocx radiobutton group;cn "OCX";
xywh 9 30 160 112;cc class listbox ws_vscroll;
xywh 180 13 31 11;cc s0 static;cn "Id:";
xywh 212 12 56 12;cc id edit;
xywh 180 26 31 11;cc scaption static;cn "Caption:";
xywh 212 25 56 12;cc caption edit es_autohscroll;
xywh 274 7 42 12;cc ok button;cn "OK";
xywh 274 20 42 12;cc cancel button;cn "Cancel";
xywh 274 36 42 12;cc apply button;cn "Apply";
xywh 274 50 42 12;cc help button;cn "Help";
pas 5 5;pcenter;
rem form end;
)

NB. =========================================================
newcc_run=: 3 : 0
wd NEWCC
if. IFJAVA do.
  wd 'setenable ocx 0'
end.
selectnewcc=: wd bind ('psel ',wd 'qhwndp')
newcc_standard_button ''
wd 'setfocus class'
wd 'pshow'
MOUSEIGNORE=: 1
)

toDEL=: [: ; (DEL&, @ (,&DEL)) each

NB. =========================================================
newcc_standard_button=: 3 : 0
OCX=: 0
wd 'set standard 1'
wd 'set ocx 0'
wd 'set class ', toDEL {."1 STDCONTROLS
wd 'setselect class 0'
newcc_enable 0
)

NB. =========================================================
newcc_enable=: 3 : 0
if. -.OCX do.
  if. (<y;5) pick STDCONTROLS do.
    wd 'setshow scaption 1;setshow caption 1' return.
  end.
end.
wd 'set caption'
wd 'setshow scaption 0;setshow caption 0'
)

NB. =========================================================
newcc_class_select=: 3 : 0
newcc_enable 0 ". class_select
)

NB. =========================================================
newcc_ocx_button=: 3 : 0
OCX=: 1
getoleocx''
wd 'set standard 0'
wd 'set ocx 1'
wd 'set caption'
wd 'setshow scaption 0;setshow caption 0'
wd 'set class ', toDEL {."1 OLEOCX
)

NB. =========================================================
newcc_apply_button=: 3 : 0
if. 0 = #class do.
  info 'First select a class'
  0 return.
end.

if. 0 = #id do.
  id=. 'cc', class
end.

if. 0 = validatecc id do. 0 return. end.

if. (<id) e. IDS do.
  msg=. 'The id "',id,'" is already used in this form'
  info msg
  0 return.
end.

if. 0 = #caption do.
  caption=. id
end.

if. OCX do.
  caption=. (({."1 OLEOCX) i. <class) pick {:"1 OLEOCX
  class=. 'ocx'
end.

ndx=. ({."1 CONTROLS) i. <class
siz=. ((<ndx;4) pick CONTROLS) { FORMSIZES
CCS=: CCS, 0 0,siz
IDS=: IDS, <id
CPS=: CPS, <caption
CLS=: CLS, <class
STY=: STY, <''
drawpaint ''
bufsnap''
1
)

NB. =========================================================
newcc_cancel=: 3 : 0
MOUSEIGNORE=: 0
wd 'pclose'
)

NB. =========================================================
newcc_close=: 3 : 0
if. newcc_apply_button'' do.
  selectnewcc''
  newcc_cancel''
end.
)

NB. =========================================================
newcc_help_button=: 3 : 0
htmlhelp_j_ 'user\form_editor_overview.htm'
)

NB. =========================================================
newcc_ok_button=: newcc_close
newcc_cancel_button=: newcc_cancel

