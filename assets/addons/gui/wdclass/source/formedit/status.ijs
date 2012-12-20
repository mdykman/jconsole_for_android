NB. status

WSTATUS=: 0 : 0
pc wstatus nosize owner;
xywh 1 20 128 9;cc s0 static;cn "Definition: id width text";
xywh 0 31 200 100;cc statusdef editm ws_vscroll;
xywh 132 3 36 12;cc apply button;cn "&Apply";
xywh 132 17 36 12;cc help button;cn "&Help";
xywh 171 3 36 12;cc ok button;cn "OK";
xywh 171 17 36 12;cc cancel button;cn "Cancel";
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
wstatus_run=: 3 : 0
wd WSTATUS
wd 'pn "Status - ',PID,'"'
selectstatus=: wd bind ('psel ',wd 'qhwndp')
wd 'set statusdef *',getstatusdef SBR
wd 'pshow;'
)

NB. =========================================================
wstatus_apply_button=: 3 : 0
applystatusdef ''
wd 'set statusdef *',getstatusdef SBR
wd 'setfocus statusdef'
)

NB. =========================================================
wstatus_help_button=: 3 : 0
htmlhelp_j_ 'user\form_editor_overview.htm'
)

NB. =========================================================
wstatus_close=: 3 : 0
applystatusdef ''
wd 'pclose'
)

NB. =========================================================
wstatus_cancel_button=: 3 : 0
wd 'pclose'
)

NB. =========================================================
wstatus_ok_button=: wstatus_close
wstatus_cancel=: wstatus_cancel_button

NB. =========================================================
applystatusdef=: 3 : 0
new=. readstatusdef statusdef
if. SBR -: new do. return. end.
SBR=: new
drawpaint''
selectstatus ''
)

NB. =========================================================
NB. getstatusdef
NB.
NB. get status definition in design display form
getstatusdef=: 3 : 0
r=. ''
if. 0 = # y do. return. end.
sbr=. cutopen y
sbr=. deb each (sbr i.&> ';') {. each sbr
msk=. (<'sbarset') = 7 {. each sbr
sbr=. 7 }. each msk # sbr
for_s. sbr do.
  txt=. > s
  sep=. (txt = ' ') > ~:/\ txt = '"'
  'id wd tx'=. 3 {. (sep <;._1 txt) -. each '"'
  wd=. ": {. 0 ". wd
  r=. r, addLF id,' ',wd,' ',tx
end.
r
)

NB. =========================================================
readstatusdef=: 3 : 0
sbr=. a: -.~ deb each LF cutopen y
r=. ''
if. 0 = # sbr do. return. end.
r=. <'sbar ',": # sbr
for_s. sbr do.
  txt=. > s
  x=. txt i. ' '
  id=. x {. txt
  txt=. (x + 1) }. txt
  x=. txt i. ' '
  wd=. ": {. 0 ". x {. txt
  txt=. (x + 1) }. txt
  r=. r , <'sbarset ',id,' ',wd,' "',txt,'"'
end.
r=. r, <'sbarshow'
; r ,each (<';',LF)
)
