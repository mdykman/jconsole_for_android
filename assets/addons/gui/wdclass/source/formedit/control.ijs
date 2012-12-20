NB. control

NB. FMS - fix|move|scale
FMSTYLE=: , ; each { (;<;:'left top right bottom') ; <;:'move scale'

NB. =========================================================
WCONTROL=: 0 : 0
pc wcontrol nomax nomin nosize owner;pn "Control";
xywh 4 7 21 9;cc s0 static;cn "Class:";
xywh 28 7 55 9;cc sclass static;
xywh 4 19 34 10;cc s1 static;cn "Id:";
xywh 39 18 90 11;cc id edit ws_border es_autohscroll;
xywh 4 31 34 10;cc scaption static;cn "Caption:";
xywh 39 30 90 11;cc caption edit ws_border es_autohscroll;
xywh 4 46 125 39;cc g0 groupbox;cn "Size rules";
xywh 13 63 33 11;cc wz button;cn "Fix";
xywh 48 56 33 11;cc nz button;cn "Fix";
xywh 83 63 33 11;cc ez button;cn "Fix";
xywh 48 69 33 11;cc sz button;cn "Fix";
xywh 4 93 34 10;cc sposition static;cn "Position:";
xywh 39 92 90 11;cc position edit ws_border es_autohscroll;
xywh 136 7 40 10;cc s3 static;cn "Styles:";
xywh 136 17 54 90;cc style listbox lbs_multiplesel lbs_sort;
xywh 195 7 40 10;cc s4 static;cn "Class Styles:";
xywh 195 17 54 90;cc class listbox lbs_multiplesel lbs_sort;
xywh 257 7 38 12;cc ok button;cn "OK";
xywh 257 20 38 12;cc cancel button;cn "Cancel";
xywh 257 36 38 12;cc apply button;cn "&Apply";
xywh 257 51 38 12;cc code button;cn "&Code...";
xywh 257 66 38 12;cc help button;cn "&Help";
pas 3 3;pcenter;
rem form end;
)

NB. =========================================================
wcontrol_run=: 3 : 0
if. 0 = #SELECT do.
  info 'First select a control' return.
end.
if. 1 < #SELECT do.
  info 'Select a single control' return.
end.

sel=. {. SELECT
class=. sel pick CLS
pos=. sel { CCS
styles=. ;: sel pick STY
ndx=. ({."1 CONTROLS) i. < class
'sty cst cap evt'=. 2 3 5 6 { ndx { CONTROLS
evt=. > {. evt
ocx=. class-:'ocx'
cap=. cap +. ocx

design_enable ''
wd WCONTROL
wd 'pn "Control - ',PID,'"'
wd 'setcaption sclass ',class
wd 'set id *',sel pick IDS
wd 'set position *',": pos
wd 'set caption *',sel pick CPS
wd 'setshow scaption ',":cap
wd 'setshow caption ',":cap
wd 'setenable code ',":0 < #evt
wd 'setcaption scaption ',ocx pick 'Caption:';'ocx:'
FMS=: (_2 [\ FMSTYLE e. styles) i."1 [ 1
wcontrol_setmoves''

wd 'set style ',delprefix sty
for_n. I. sty e. styles do.
  wd 'setselect style ',":n
end.
wd 'set class ',delprefix cst
for_n. I. cst e. styles do.
  wd 'setselect class ',":n
end.

wd 'pshow;'
MOUSEIGNORE=: 1
)

NB. =========================================================
wcontrol_close=: 3 : 0
if. 0 = wcontrol_read'' do. return. end.
wcontrol_cancel''
drawpaint''
)

NB. =========================================================
wcontrol_cancel=: 3 : 0
MOUSEIGNORE=: 0
wd'pclose'
)

NB. =========================================================
wcontrol_read=: 3 : 0
if. 0 = validatecc id do. 0 return. end.
sel=. {. SELECT
if. (<id) e. (<<<sel) { IDS do.
  msg=. 'The id "',id,'" is used for another control in this form'
  info msg
  0 return.
end.
cls=. sel pick CLS
ndx=. ({."1 CONTROLS) i. <cls
pos=. 0 ". position
if. 4 ~: #pos do.
  info 'Position should be 4 numbers: x y w h'
else.
  CCS=: pos sel } CCS
end.
pfx=. 1 pick ndx { CONTROLS
fms=. FMSTYLE {~ (FMS < 2) # FMS + 0 2 4 6
s=. 'ws_'&, each cutopen style
s=. s, (pfx,'_')&, each cutopen class
s=. towords s,fms
STY=: (<s) sel } STY
IDS=: (<id) sel } IDS
CPS=: (<caption) sel } CPS
1
)

NB. =========================================================
wcontrol_setmoves=: 3 : 0
if. #y do.
  FMS=: 3 | FMS + y = i. 4
end.
dat=. FMS { ;: 'Move Scale Fix'
wd 'setcaption wz ', 0 pick dat
wd 'setcaption nz ', 1 pick dat
wd 'setcaption ez ', 2 pick dat
wd 'setcaption sz ', 3 pick dat
)

wcontrol_wz_button=: wcontrol_setmoves bind 0
wcontrol_nz_button=: wcontrol_setmoves bind 1
wcontrol_ez_button=: wcontrol_setmoves bind 2
wcontrol_sz_button=: wcontrol_setmoves bind 3

wcontrol_ok_button=: wcontrol_close
wcontrol_cancel_button=: wcontrol_cancel

NB. =========================================================
wcontrol_apply_button=: 3 : 0
if. 0=wcontrol_read'' do. 0 return. end.
drawpaint''
1
)

NB. =========================================================
wcontrol_code_button=: 3 : 0
if. 0 = wcontrol_apply_button'' do. 0 return. end.
selectcode ''
1
)

NB. =========================================================
wcontrol_help_button=: 3 : 0
htmlhelp_j_ 'user\form_editor_overview.htm'
)
