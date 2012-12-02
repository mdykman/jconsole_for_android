NB. control1.ijs  - buttons
NB.
NB. standard controls, called by control.ijs

PATH=. jpath '~addons/demos/wd/'

BUTTONS=: 0 : 0
pc buttons;
xywh 11 12 79 40;cc radios groupbox;cn "Radio Buttons";
xywh 16 20 40 10;cc active radiobutton;cn "Active";
xywh 16 30 40 10;cc inactive radiobutton group;cn "Inactive";
xywh 16 40 40 10;cc done radiobutton group;cn "Done";
xywh 78 19 5 5;cc bradios button;cn "";
xywh 11 68 79 40;cc groupcheck groupbox;cn "Check Buttons";
xywh 16 80 57 10;cc checkin checkbox;cn "Checked In";
xywh 16 92 57 10;cc checkout checkbox;cn "Checked Out";
xywh 78 75 5 5;cc bcheck button;cn "";
xywh 116 15 72 12;cc defpushbutton button bs_defpushbutton;cn "Default Pushbutton";
xywh 116 29 72 12;cc ordpushbutton button;cn "Pushbutton";
xywh 116 51 72 59;cc odpushbutton button bs_ownerdraw;cn "j.bmp";
xywh 195 17 5 5;cc bdefault button;cn "";
xywh 195 30 5 5;cc bpush button;cn "";
xywh 195 54 5 5;cc bod button;cn "";
pas 5 5;pcenter;
rem form end;
)

BUTTOD=. 0 : 0
wd 'cc odpushbutton button bs_ownerdraw;cn "j.bmp"'
)

ndx=. I. 'j.bmp' E. BUTTONS
BUTTONS=: (ndx {. BUTTONS),PATH,ndx }. BUTTONS

ndx=. I. 'j.bmp' E. BUTTOD
BUTTOD=. (ndx {. BUTTOD),PATH,ndx }. BUTTOD

NB. =========================================================
wdbuttons=: wdinfo @ ('button definition'&;)

buttons_run=: 3 : 0
wd BUTTONS
NB. initialize form here
wd 'pshow;'
)

buttons_cancel_button=: 3 : 0
wd 'pclose;'
)

buttons_bradios_button=: wdbuttons bind (0 : 0)
wd 'cc radios groupbox;cn "Radio Buttons"'
wd 'cc active radiobutton;cn "Active"'
wd 'cc inactive radiobutton group;cn "Inactive"'
wd 'cc done radiobutton group;cn "Done"'
)

buttons_bcheck_button=: wdbuttons bind (0 : 0)
wd 'cc groupcheck groupbox;cn "Check Buttons"'
wd 'cc checkin checkbox;cn "Checked In"'
wd 'cc checkout checkbox;cn "Checked Out"'
)

buttons_bdefault_button=: wdbuttons bind (0 : 0)
wd 'cc defpushbutton button bs_defpushbutton;cn "Default Pushbutton"'
)

buttons_bpush_button=: wdbuttons bind (0 : 0)
wd 'cc ordpushbutton button;cn "Pushbutton"'
)

buttons_bod_button=: wdbuttons bind BUTTOD
