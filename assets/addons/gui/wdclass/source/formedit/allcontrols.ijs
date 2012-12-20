NB. allcontrols

WFORM=: 0 : 0
pc wform;
xywh 5 8 100 12;cc text edit;
xywh 5 22 100 46;cc textm editm;
xywh 5 73 100 73;cc g0 groupbox;cn "grouper";
xywh 11 85 79 12;cc cb checkbox;cn "checkme";
xywh 11 99 79 12;cc cbr checkbox ws_border bs_lefttext;cn "checkme right";
xywh 11 113 79 12;cc rb radiobutton;cn "push me";
xywh 11 127 79 12;cc rbr radiobutton ws_border bs_lefttext group;cn "push me right";
xywh 116 8 74 68;cc cbd combodrop;
xywh 116 24 74 50;cc cbl combolist;
xywh 116 40 74 68;cc cbx combobox;
xywh 116 110 74 50;cc lbx listbox;
xywh 116 162 74 12;cc sb scrollbar;
xywh 227 11 50 12;cc ok button;cn "OK";
xywh 227 25 50 12;cc close button;cn "Close";
xywh 227 39 50 12;cc help button;cn "Help";
xywh 198 79 68 25;cc st static;cn "static";
xywh 198 108 68 25;cc sbx staticbox ss_blackframe;
xywh 198 140 12 74;cc sbvv scrollbarv;
xywh 5 155 100 11;cc pb progress ws_border;
xywh 136 195 22 14;cc spin spin;
xywh 118 195 14 22;cc spinv spinv;
xywh 5 170 100 52;cc tab tab;
xywh 116 176 74 12;cc tb trackbar;
xywh 220 140 12 74;cc tbv trackbarv;
xywh 233 144 53 69;cc cal ocx:MSCAL.Calendar.7;
pas 6 6;pcenter;
rem form end;
)

NB. =========================================================
wform_run=: 3 : 0
wd WFORM
wd 'pshow'
)
