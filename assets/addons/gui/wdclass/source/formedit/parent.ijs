NB. parent

WPARENT=: 0 : 0
pc wparent owner;pn "Parent";
xywh 5 10 31 12;cc label static;cn "Id:";
xywh 38 10 69 11;cc id static rightmove;
xywh 5 25 31 12;cc label static;cn "Caption:";
xywh 38 24 69 12;cc caption edit ws_border es_autohscroll;
xywh 5 43 40 11;cc label static;cn "Styles:";
xywh 4 54 60 89;cc styles listbox lbs_multiplesel rightscale;
xywh 68 43 40 11;cc label static leftmove rightmove;cn "Options:";
xywh 67 54 60 89;cc options listbox lbs_multiplesel leftscale rightscale;
xywh 125 10 56 11;cc label1 static;cn "Right margin:";
xywh 125 25 56 11;cc label static;cn "Bottom margin:";
xywh 182 10 25 80;cc rmargin combodrop ws_vscroll;
xywh 182 24 25 80;cc bmargin combodrop ws_vscroll;
xywh 143 50 36 12;cc bpmove button leftmove rightmove;cn "pmove";
xywh 142 63 65 13;cc pmove static leftmove rightmove;
xywh 216 10 36 12;cc ok button leftmove rightmove;cn "OK";
xywh 216 26 36 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 216 50 36 12;cc apply button leftmove rightmove;cn "&Apply";
xywh 216 65 36 12;cc help button leftmove rightmove;cn "&Help";
pas 3 3;pcenter;
rem form end;
)

NB. =========================================================
wparent_run=: 3 : 0
sty=. 'closeok dialog nomax nomenu nomin nosize owner'
opt=. 'pcenter ptop'
Wpmv=: PMV
wd WPARENT
selectparent=: wd bind ('psel ',wd 'qhwndp')
wd 'set styles ',sty
for_n. I. (;:sty) e. ;: PST do.
  wd 'setselect styles ',":n
end.
wd 'set options ',opt
for_n. I. (;:opt) e. POP do.
  wd 'setselect options ',":n
end.
wd 'setcaption id *',PID
wd 'set caption *',PCN
wd 'set rmargin ',": i.21
wd 'setselect rmargin ',": 0 { PAS
wd 'set bmargin ',": i.21
wd 'setselect bmargin ',": 1 { PAS
wd 'setcaption pmove *',":Wpmv
wd 'pshow;'
MOUSEIGNORE=: 1
)

NB. =========================================================
wparent_apply_button=: 3 : 0
wparent_read''
drawpaint ''
)

NB. =========================================================
wparent_bpmove_button=: 3 : 0
if. #Wpmv do.
  Wpmv=: ''
else.
  selectform''
  Wpmv=: roundint (0 ". wd 'qformx') % GSCALE
end.
selectparent''
wd 'setcaption pmove *',": Wpmv
)

NB. =========================================================
wparent_close=: 3 : 0
wparent_read ''
wparent_cancel ''
selectform''
cap=. (*#PCN) pick PID;PCN
wd 'pn "',cap,'"'
)

NB. =========================================================
wparent_cancel=: 3 : 0
MOUSEIGNORE=: 0
wd 'pclose'
)

NB. =========================================================
wparent_help_button=: 3 : 0
htmlhelp_j_ 'user\form_editor_overview.htm'
)

NB. =========================================================
wparent_cancel_button=: wparent_cancel
wparent_ok_button=: wparent_close

NB. =========================================================
wparent_read=: 3 : 0
PAS=: (0 ". rmargin), 0 ". bmargin
PCN=: caption
PMV=: Wpmv
POP=: cutopen options
PST=: towords cutopen styles
)
