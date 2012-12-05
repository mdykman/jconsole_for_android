NB. Windows Controls
NB. examples of  windows controls
NB. control3.ijs

SELECTS=: 0 : 0
pc selects;
xywh 8 9 57 35;cc bxlist listbox ws_vscroll lbs_multiplesel;
xywh 70 9 5 5;cc blist button;cn "";
xywh 8 46 57 40;cc combolist combolist ws_vscroll;
xywh 70 47 5 5;cc bclist button;cn "";
xywh 8 64 57 40;cc combodrop combodrop;
xywh 70 64 5 5;cc bcd button;cn "";
xywh 8 82 57 39;cc combobox combobox ws_vscroll;
xywh 69 83 5 5;cc bcombo button;cn "";
xywh 96 12 50 9;cc pay static ws_border;cn "";
xywh 150 10 14 12;cc spinv spinv;
xywh 169 12 5 5;cc bspinv button;cn "";
xywh 93 44 64 14;cc trackbar trackbar tbs_autoticks tbs_both tbs_enableselrange tbs_top;
xywh 156 44 5 5;cc btrack button;cn "";
xywh 95 65 60 10;cc spin spin;
xywh 157 63 5 5;cc bspin button;cn "";
xywh 172 43 16 44;cc trackbarv trackbarv tbs_autoticks;
xywh 189 49 5 5;cc btrackv button;cn "";
xywh 94 105 11 10;cc setprogress button;cn "<>";
xywh 108 104 87 12;cc progress2 progress ws_border;
xywh 198 104 5 5;cc bprog button;cn "";
pas 6 2;pcenter;
rem form end;
)

wdselects=: sminfo @ ('select definition'&;)

selects_run=: 3 : 0
if. 'Android'-:UNAME do. SELECTS=: ('spinv;';'static;';'spin;';'static;';'trackbarv tbs_autoticks;';'static;') stringreplace SELECTS end.
wd SELECTS
setlistbox''
setcombolist''
setcombodrop''
setcombobox''
setprogress''
setspinbox''
wd 'pshow;'
)

selects_cancel_button=: wd bind 'pclose'

setlistbox=: 3 : 0
NB. multiple select listbox with 4 items, initial selection=1
list=. ;:'apples bananas cherries dates'
wd 'set bxlist ',;list ,each LF
)

setcombolist=: 3 : 0
NB. combobox with dropdownlist, initial selectsion=0
j=. 'January February March April May June July August'
mos=. ;:j,' September October November December'
wd 'set combolist ',;mos,&.>LF
wd 'setselect combolist 0;'
)

setcombodrop=: 3 : 0
NB. dropdown combobox with edit field, initial selectsion=0
j=. 'Antwerp Brussels Copenhagen Danzig Essen Frankfurt Gstaad'
city=. ;:j,' Hamburg Ilford Krakow Lausanne'
wd 'set combodrop ',;city ,each LF
wd 'setselect combodrop 0;'
)

setcombobox=: 3 : 0
NB. combobox with edit field, initial selectsion=0
words=. ;:'Goose Geese Moose Meese Tooth Teeth Booth Beeth'
wd 'set combobox ',;words ,each LF
wd 'setselect combobox 0;'
)

setprogress=: 3 : 0
NB. initial progress button
PROGRESS=: 0
)

setspinbox=: 3 : 0
NB. initialise spinbox
PAY=: 'Annual';'Semi Annual';'Quarterly';'Monthly'
PAYNDX=: 0
wd 'set pay *',PAYNDX pick PAY
)

selects_spinv_button=: 3 : 0
PAYNDX=: (#PAY) | PAYNDX+".spinv
wd 'set pay *',PAYNDX pick PAY
)

selects_spin_button=: 3 : 0
j=. 0 >. 10 <. (".trackbar)+".spin
wd 'set trackbar ',":j
j=. 0 >. 10 <. (".trackbarv)+".spin
wd 'set trackbarv ',":j
)

selects_setprogress_button=: 3 : 0
PROGRESS=: 100 <. PROGRESS+8
wd 'set progress2 ',":PROGRESS
)

selects_blist_button=: wdselects bind (0 : 0)
wd 'cc bxlist listbox ws_vscroll lbs_multiplesel'
list=. ;:'apples bananas cherries dates'
wd 'set bxlist ',;list ,each LF
)

selects_bclist_button=: wdselects bind (0 : 0)
wd 'cc combolist combolist ws_vscroll'
j=. 'January February March April May June July August'
mos=. ;:j,' September October November December'
wd  'set combolist ',;mos,&.>LF
wd  'setselect combolist 0;'
)

selects_bcd_button=: wdselects bind (0 : 0)
wd 'cc combodrop combodrop'
j=. 'Antwerp Brussels Copenhagen Danzig Essen Frankfurt Gstaad'
city=. ;:j,' Hamburg Ilford Krakow Lausanne'
wd  'set combodrop ',;city ,each LF
wd  'setselect combodrop 0;'
)

selects_bcombo_button=: wdselects bind (0 : 0)
wd 'cc combobox combobox ws_vscroll'
words=. ;:'Goose Geese Moose Meese Tooth Teeth Booth Beeth'
wd  'set combobox ',;words ,each LF
wd  'setselect combobox 0;'
)

selects_bspinv_button=: wdselects bind (0 : 0)
wd 'cc spinv spinv'

NB. initialise spinbox text:
PAY=: 'Annual';'Semi Annual';'Quarterly';'Monthly'
PAYNDX=: 0
wd  'set pay *',PAYNDX pick PAY

NB. selects_spinv_button is defined as:
  PAYNDX=: (#PAY) | PAYNDX+".spinv
  wd  'set pay *',PAYNDX pick PAY
)

selects_btrack_button=: wdselects bind (0 : 0)
wd 'cc trackbar trackbar tbs_autoticks tbs_both tbs_enableselrange tbs_top'
)

selects_bspin_button=: wdselects bind (0 : 0)
wd 'cc spin spin'

NB. selects_spin_button is defined as:
  j=. 0 >. 10 <. (".trackbar)+".spin
  wd  'set trackbar ',":j
  j=. 0 >. 10 <. (".trackbarv)+".spin
  wd  'set trackbarv ',":j
)

selects_btrackv_button=: wdselects bind (0 : 0)
wd 'cc trackbarv trackbarv tbs_autoticks'
)

selects_bprog_button=: wdselects bind (0 : 0)
wd 'cc progress2 progress ws_border'

NB. selects_setprogress_button is defined as:
  PROGRESS=: 100 <. PROGRESS+8
  wd  'set progress2 ',":PROGRESS
)
