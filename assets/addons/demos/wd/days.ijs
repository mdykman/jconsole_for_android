NB. days.ijs
NB.
NB. example of use of tab control
NB. selects data for form by day of week.

DAYS=: ;:'Monday Tuesday Wednesday Thursday Friday Saturday Sunday'
DAYSDATA=: 'this is the text for '&, each DAYS

WEEK=: 0 : 0
pc week;
xywh 178 8 34 12;cc ok button leftmove rightmove;cn "OK";
xywh 178 23 34 12;cc cancel button leftmove rightmove;cn "Cancel";
xywh 8 8 164 88;cc tab tab tcs_multiline rightmove bottommove;
xywh 11 29 157 64;cc eddays editm ws_border es_autovscroll rightmove bottommove;
pas 6 6;pcenter;
rem form end;
)

week_run=: 3 : 0
if. -. IFWIN do.
  sminfo 'Days';'This demo is for Windows 95/NT only'
  return.
end.
wd WEEK
wd 'set tab ',;DAYS ,each LF
LASTDAY=: 0
setdaysdata''
wd 'pshow;'
)

week_cancel_button=: 3 : 0
wd 'pclose;'
)

week_ok_button=: 3 : 0
DAYSDATA=: (<eddays) LASTDAY} DAYSDATA
)

week_tab_button=: 3 : 0
DAYSDATA=: (<eddays) LASTDAY} DAYSDATA
LASTDAY=: ".tab_select
setdaysdata''
)

setdaysdata=: 3 : 0
wd 'set eddays *',LASTDAY pick DAYSDATA
)

week_run''
