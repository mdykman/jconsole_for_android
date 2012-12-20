NB. select - initial form selection

WSELECT=: 0 : 0
pc wselect nomax nomenu nosize owner;
xywh 4 5 72 58;cc slist listbox ws_vscroll;
xywh 84 6 36 12;cc ok button bs_defpushbutton;cn "OK";
xywh 84 20 36 12;cc cancel button;cn "Cancel";
xywh 84 36 36 12;cc new button;cn "New...";
pas 4 4;pcenter;
rem form end;
)

NB. =========================================================
wselect_run=: 3 : 0
wd WSELECT
wd 'set slist ', ; y ,each LF
wd 'setselect slist 0'
wd 'pshow'
)

NB. =========================================================
wselect_new_button=: 3 : 0
wd 'pclose'
newform''
)

NB. =========================================================
wselect_ok_button=: 3 : 0
wd 'pclose'
openform slist
)

NB. =========================================================
wselect_cancel=: 3 : 0
wd 'pclose'
destroy''
)

NB. =========================================================
wselect_cancel_button=: wselect_close=: wselect_cancel
wselect_slist_button=: wselect_enter=: wselect_ok_button
pickform=: wselect_run
