FORM=: 0 : 0
pc form closeok;
menupop "File";
menu new "&New" "" "" "";
menu open "&Open" "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
xywh 2 7 80 39;cc editm editm;
xywh 1 50 80 99;cc combo combodrop;
xywh 86 8 34 12;cc ok button;cn "OK";
xywh 86 23 34 11;cc cancel button;cn "Cancel";
pas 4 4;pcenter;
rem form end;
)

FORMTEXT=: 0 : 0
j=. <;._2 y
ndx=. j i.&> ' '
nms=. ndx {.each j
pth=. jpath each deb each (ndx+1) }.each j
nms,.pth
)

form_run=: 3 : 0
wd FORM
wd 'setfont editm "Courier New" 10'
wd 'setfont combo "Tahoma" 10'
wd 'setfont ok "Tahoma" 10'
wd 'setfont cancel "Tahoma" 10'
wd 'set editm *cutfolders=: 3 : 0',LF,FORMTEXT,LF,')'
wd 'set combo france germany holland belgium'
wd 'setselect combo 0'
wd 'pshow;'
)

form_close=: 3 : 0
wd'pclose'
)

form_cancel_button=: 3 : 0
form_close''
)

wdpclose 'form'
form_run''
