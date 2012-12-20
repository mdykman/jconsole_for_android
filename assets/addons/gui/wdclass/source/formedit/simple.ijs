NB. simple

WMENU=: 0 : 0
menupop "File";
menu new "&New" "" "" "";
menu open "&Open" "" "" "";
menusep ;
menu exit "&Exit" "" "" "";
menupopz;
)

WSBAR=: 0 : 0
sbar 3;
sbarset st0 100 "Press F1 for help";
sbarset st1 50 "Ready";
sbarset st2 75 "Option";
sbarshow;
)

WTBAR=: 0 : 0
tbar "system\examples\data\isitbar8.bmp";
tbarset bleh 0 3  "foo" "moo";
tbarset "" 1 15;
tbarset moo 2 6  "joo" "loo";
tbarshow;
)

WBUTTONS=: 0 : 0
pc wform;
xywh 10 10 50 12;cc b0 button;
xywh 10 25 50 12;cc b1 button;
xywh 10 41 50 12;cc b2 button;
xywh 10 57 50 12;cc b3 button;
xywh 10 73 50 12;cc b4 button;
pas 10 10;pcenter;
rem form end;
)

WCONTROLS=: 0 : 0
xywh 7 15 100 12;cc text edit;
xywh 7 34 102 46;cc textm editm;
xywh 7 92 103 46;cc g0 groupbox;cn "grouper";
xywh 12 106 79 12;cc cb checkbox;cn "checkme";
xywh 12 120 79 12;cc rb radiobutton;cn "push me";
xywh 125 65 74 68;cc cbd combodrop;
xywh 125 81 74 50;cc cbl combolist;
xywh 149 11 50 12;cc ok button;cn "OK";
xywh 149 25 50 12;cc close button;cn "Close";
xywh 149 39 50 12;cc help button;cn "Help";
pas 10 10;pcenter;
rem form end;
)

WCONTROLS=: 0 : 0
xywh 12 106 79 12;cc cb checkbox;cn "checkme";
xywh 125 65 74 68;cc cbd combodrop;
xywh 125 81 74 50;cc cbl combolist;
xywh 149 11 50 12;cc ok button;cn "OK";
xywh 149 25 50 12;cc close button;cn "Close";
xywh 149 39 50 12;cc help button;cn "Help";
pas 10 10;pcenter;
rem form end;
)

WCONTROLSX=: 0 : 0
 xywh  12  106  79  12  ; cc  cb  checkbox;cn   " check    me  "  ;
xywh 125 65 74 68; cc   cbd  combodrop   ;
xywh 125 81 74 50;cc cbl combolist;
xywh 149 11   50 12 ;  cc ok button;cn "OK";
  xywh 149 25 50 12;cc close button;cn "Close";
xywh 149 39 50 12;cc help button;cn "Help";
pas 10 10;pcenter;
rem form end;
  more  stuff   here


 and   again   here ...  123

123
)


WFORM=: 'pc wform;',LF,WMENU,WSBAR,WTBAR,WCONTROLS
WFORM=: 'pc wform;',LF,WCONTROLS
WFORM=: 'pc wform;',LF,WCONTROLSX

wform_run=: 3 : 0
wd WFORM
wd 'pshow'
)
