NB. Windows Controls
NB.
NB. examples of windows controls

require 'droidwd gtkwd'
coclass 'wincontroldemo'
coinsert 'wdbase'
droidwd_run=: wincontrol_run

p=. jpath '~addons/demos/wd/control'
0!:0 p&, each '1.ijs';'2.ijs';'3.ijs'

WINCONTROL=: 0 : 0
pc wincontrol;
menupop "File";
menu new "&New" "Ctrl+N" "help for new" "new tip";
menu open "&Open" "Ctrl+O" "help for open" "open tip";
menusep;
menu exit "&Exit" "" "exit" "exit tip";
menupopz;
sbar 3;
sbarset status 50 "basic help message";
sbarset sinfo 50 "";
sbarset scrud 50 "";
sbarshow;
tbar "TOOLBAR";
tbarset new 0 0 "new" "new";
tbarset open 1 1 "open" "open";
tbarset "" 2 20;
tbarset print 3 6 "print" "print it";
tbarset query 4 7 "what would you like to know" "query";
tbarshow;
xywh 5 17 220 141;cc tabs tab tcs_multiline;
xywh 189 2 34 12;cc ok button;cn "OK";
xywh 152 2 34 12;cc cancel button;cn "Cancel";
pas 6 6;pcenter;
rem form end;
)

NB. =========================================================
wincontrol_run=: 3 : 0

TABNDX=: 0

wd WINCONTROL rplc '"TOOLBAR"';'"','"',~jpath '~addons/demos/wd/isitbar8.bmp'

tabgroups=: 'buttons';'edits';'selects'
wd 'set tabs "buttons" "edits" "selects"'
wd 'creategroup tabs'
buttons_run''
edits_run''
selects_run''
wd 'creategroup'
wd 'setshow buttons 1'
wd 'pshow'
evtloop^:(-.IFJ6)''
)

wincontrol_close=: wd bind 'pclose'
wincontrol_cancel_button=: wincontrol_close
wincontrol_ok_button=: wincontrol_cancel_button

wincontrol_tabs_button=: 3 : 0
wd 'setshow ',(>TABNDX{tabgroups),' 0'
TABNDX=: ".tabs_select
wd 'setshow ',(>TABNDX{tabgroups),' 1'
)

wincontrol_new_button=: 3 : 0
wd 'sbarset sinfo -1 ',syschild
)

wincontrol_open_button=: 3 : 0
wd 'sbarset sinfo -1 ',syschild
)

wincontrol_exit_button=: 3 : 0
wd 'sbarset sinfo -1 ',syschild
)

wincontrol_print_button=: 3 : 0
wd 'sbarset sinfo -1 ',syschild
)

wincontrol_query_button=: 3 : 0
wd 'sbarset sinfo -1 ',syschild
)

wincontrol_run`start_droidwd@.(('Android'-:UNAME)>IFQT) coname''
