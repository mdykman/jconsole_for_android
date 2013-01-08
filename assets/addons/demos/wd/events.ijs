NB. illustrates events in J

require 'droidwd gtkwd gl2 numeric trig wdclass'
coclass 'jevents'
coinsert 'jgl2 wdbase'
droidwd_run=: events_run

TEXT=: 0 : 0
This form illustrates various events in J. Click the controls or press Enter to see the event messages generated.

A listbox or combobox generates select events when you scroll through the entries, and button events when an entry is double-clicked, or when you press Enter in the control. Turn off the select checkbox to see the listbox button events.

The isigraph window shows mouse events. Turn off the checkboxes to see more mouse events.
)

SHOWSEL=: 1
SHOWMMOVE=: 1
SHOWMBLDOWN=: 1
SHOWMBRDOWN=: 1
SHOWMBLUP=: 1
SHOWMBRUP=: 1
syseventlast=: ''

wceview=: 3 : 0
a=. conew 'jview'
create__a y
)

wceshow=: 3 : 0
txt=. (>{."1 wdq),.TAB,.>{:"1 wdq
wceview 'wdq';'';(60 <. {:$txt) {."1 txt
)

showme=: IFWINCE pick wdqshow`wceshow

EVENTS=: 0 : 0
pc events nomax nosize qtwd;pn "Events";
menupop "File";
menu new "&New" "" "" "";
menu open "&Open" "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
bin v;
xywh 7 6 239 93;cc g0 groupbox;cn "";
xywh 11 13 231 82;cc s0 static;
xywh 7 107 133 25;cc g2 groupbox;cn "Edit";
bin h;
xywh 10 116 123 12;cc text edit ws_border es_autohscroll;
bin h;
xywh 152 107 93 25;cc g1 groupbox;cn "Options";
xywh 160 117 28 11;cc red radiobutton;cn "Red";
xywh 192 117 34 11;cc blue radiobutton group;cn "Blue";
bin zzhv;
xywh 7 143 75 87;cc g3 groupbox;cn "Listbox";
xywh 12 154 61 59;cc list listbox ws_vscroll;
xywh 12 212 57 11;cc showselect checkbox;cn "select";
bin zv;
xywh 104 143 141 87;cc g4 groupbox;cn "Isigraph";
xywh 111 152 42 11;cc showmmove checkbox bs_lefttext;cn "mmove";
xywh 111 166 42 11;cc showmbldown checkbox bs_lefttext;cn "mbldown";
xywh 111 180 42 11;cc showmblup checkbox bs_lefttext;cn "mblup";
xywh 111 194 42 11;cc showmbrdown checkbox bs_lefttext;cn "mbrdown";
xywh 111 208 42 11;cc showmbrup checkbox bs_lefttext;cn "mbrup";
bin sz;
xywh 164 155 74 67;cc g isigraph ws_border rightmove bottommove;
bin zhs;
xywh 150 231 40 11;cc cancel button;cn "Cancel";
xywh 192 231 40 11;cc ok button;cn "OK";
bin zz;
pas 4 2;pcenter;
rem form end;
)

EVENTSCE=: 0 : 0
pc eventsce nomax nosize;pn "Events";
menupop "File";
menu new "&New" "" "" "";
menu open "&Open" "" "" "";
menusep ;
menu exit "&Exit" "" "" "";
menupopz;
xywh 9 81 98 10;cc text edit ws_border es_autohscroll;
xywh 4 73 105 21;cc g2 groupbox;cn "Edit";
xywh 134 81 26 11;cc red radiobutton;cn "Red";
xywh 160 81 27 11;cc blue radiobutton group;cn "Blue";
xywh 127 73 63 21;cc g1 groupbox;cn "Options";
xywh 9 11 50 48;cc list listbox ws_vscroll;
xywh 9 58 45 11;cc showselect checkbox;cn "select";
xywh 4 2 60 69;cc g3 groupbox;cn "Listbox";
xywh 72 13 41 11;cc showmmove checkbox bs_lefttext;cn "mmove";
xywh 72 23 41 11;cc showmbldown checkbox bs_lefttext;cn "mbldown";
xywh 72 33 41 11;cc showmblup checkbox bs_lefttext;cn "mblup";
xywh 72 43 41 11;cc showmbrdown checkbox bs_lefttext;cn "mbrdown";
xywh 72 53 41 11;cc showmbrup checkbox bs_lefttext;cn "mbrup";
xywh 123 13 62 52;cc g isigraph ws_border rightmove bottommove;
xywh 68 2 122 69;cc g4 groupbox;cn "Isigraph";
xywh 196 24 40 11;cc cancel button;cn "Cancel";
xywh 196 8 40 11;cc ok button;cn "OK";
pas 4 2;pcenter;
rem form end;
)

j=. 1 i.~ 'eventsce' E. EVENTSCE
EVENTSCE=: ((j+6) {. EVENTSCE),(j+8)}.EVENTSCE

events_run=: 3 : 0
if. wdisparent 'events' do.
  wd^:('Android'-.@-:UNAME) 'psel events;pactive;pshow' return.
end.
if. IFWINCE do.
  wd EVENTSCE
else.
  wd EVENTS
  wd 'set s0 *',TEXT
end.

wd 'set list January February March April May June July August September October November December'
wd 'setselect list 5'
wd 'set showselect 1'
wd 'set showmmove 1'
wd 'set showmbldown 1'
wd 'set showmbrdown 1'
wd 'set showmblup 1'
wd 'set showmbrup 1'
wd 'set red 0'
wd 'set blue 1'
wd 'pshow;'
events_isigraph''

if. IFWINCE do. wceview 'Events';'';TEXT;1 end.
evtloop^:(-.IFJ6)''
)

NB. =========================================================
events_isigraph=: 3 : 0
wh=. 2}.wdqchildxywhx 'g'
wh=. glqwh''
glrgb 0 255 255
glbrush''
glrect 0 0,wh
NB. glpaint ''
)

NB. =========================================================
events_default=: 3 : 0

if. (sysevent -: 'events_g_focus') +. sysevent -: 'events_g_focuslost' do.
  if. sysevent -: syseventlast do. return. end.
end.

if. sysevent-:'events_showselect_button' do. SHOWSEL=: -. SHOWSEL end.
if. SHOWSEL < sysevent-:'events_list_select' do. return. end.

if. sysevent-:'events_showmmove_button' do. SHOWMMOVE=: -. SHOWMMOVE end.
if. SHOWMMOVE < sysevent-:'events_g_mmove' do. return. end.

if. sysevent-:'events_showmbldown_button' do. SHOWMBLDOWN=: -. SHOWMBLDOWN end.
if. SHOWMBLDOWN < sysevent-:'events_g_mbldown' do. return. end.

if. sysevent-:'events_showmbrdown_button' do. SHOWMBRDOWN=: -. SHOWMBRDOWN end.
if. SHOWMBRDOWN < sysevent-:'events_g_mbrdown' do. return. end.

if. sysevent-:'events_showmblup_button' do. SHOWMBLUP=: -. SHOWMBLUP end.
if. SHOWMBLUP < sysevent-:'events_g_mblup' do. return. end.

if. sysevent-:'events_showmbrup_button' do. SHOWMBRUP=: -. SHOWMBRUP end.
if. SHOWMBRUP < sysevent-:'events_g_mbrup' do. return. end.

if. -. sysevent -: 'events_cancel_button' do.
NB.   showme~''
smoutput wdq
end.

if. (<sysevent) e. 'events_close';'events_cancel_button';'events_exit_button' do.
  if. 0=2 wdquery`0:@.(IFQT+.'Android'-:UNAME) 'Events';'OK to close form?' do.
    try. wd 'psel events;pclose' catch. end.
  end.
end.

syseventlast=: sysevent
)

events_run`start_droidwd@.('Android'-:UNAME) coname''
