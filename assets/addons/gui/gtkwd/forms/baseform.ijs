MYFORM=: 0 : 0
pc myform;
menupop "File";
menu new "&New" "" "" "";
menu open "&Open" "" "" "";
menusep ;
menu exit "&Exit" "" "" "";
menupopz;
xywh 136 8 44 12;cc ok button;cn "OK";
xywh 136 23 44 12;cc cancel button;cn "Cancel";
pas 6 6;pcenter;
rem form end;
)

myform_run=: 3 : 0
wd MYFORM
NB. initialize form here
wd 'pshow;'
)

myform_close=: 3 : 0
wd'pclose'
)

myform_cancel_button=: 3 : 0
myform_close''
)
