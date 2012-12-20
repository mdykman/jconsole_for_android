NB. new form

NEWFORM=: 0 : 0
pc newform nomax nomin nosize owner;pn "Form Edit - Id";
xywh 120 7 40 12;cc ok button;cn "OK";
xywh 120 21 40 12;cc cancel button;cn "Cancel";
xywh 8 10 38 10;cc label static;cn "Form Id:";
xywh 52 10 60 12;cc formid edit ws_border es_autohscroll;
xywh 8 25 38 10;cc label static;cn "Form Type:";
xywh 52 25 60 42;cc formtype listbox ws_vscroll;
pas 4 2;pcenter;
rem form end;
)

NB. =========================================================
newform_run=: 3 : 0
frm=. {."1 [ 1!:0 jpath '~addons/gui/wdclass/forms/*.ijs'
wd NEWFORM
NEWFORMHWNDP=: wd 'qhwndp'
wd 'set formtype ', ; frm ,each LF
wd 'setselect formtype 0'
wd 'setfocus formid'
wd 'pshow;'
)

NB. =========================================================
newform_ok_button=: 3 : 0
if. 0 = #formid do.
  info 'First enter the Form Id'
  wd 'setfocus formid'
  return.
end.
if. 0 = #formtype do.
  info 'First select the Form Type'
  wd 'setfocus formtype'
  return.
end.
dat=. freads jpath '~addons/gui/wdclass/forms/',formtype
ndx=. 1 i.~ (LF,'pc ') E. dat
j=. (ndx + 4) }. dat
formname=. deb (j i. ';') {. j
if. formid -: toupper formid do.
  formid=. tolower formid
end.
dat=. dat rplc ('pc ',formname) ; 'pc ',formid
dat=. dat rplc (toupper formname) ; toupper formid
dat=. dat rplc (formname,'_') ; formid,'_'
txt=. freads FNAME
if. #txt do.
  dat=. txt, LF, dat
end.
fdata=. file_read1 dat
nms=. a: -.~ {."1 fdata
newform_close ''
smopen FNAME
smwrite dat
NB. TODO integrate with ide
FNAME fwrite~ toHOST dat
openform _1 pick nms
)

NB. =========================================================
newform_close=: 3 : 0
wd 'psel ',NEWFORMHWNDP
wd 'pclose'
)

NB. =========================================================
newform_cancel=: newform_cancel_button=: newform_close
newform=: newform_run
newform_enter=: newform_ok_button
