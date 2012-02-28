NB. provides jtable form

coclass 'jtable'
require 'jtgrid'

NB. =========================================================
TABLE=: 0 : 0
pc table;pn "Table";
xywh 4 5 100 11;cc xp checkbox;cn "extended precision";
xywh 0 19 350 250;cc grid isigraph ws_border rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
create=: 3 : 0
VERB=: y
XPRECISION=: 1
wd TABLE
wd 'set xp 1'
wdfit''
grid=: ''conew'jtgrid'
wd 'pshow;'
show__grid 'verb xprecision'
)

NB. =========================================================
destroy=: 3 : 0
wd'pclose'
destroy__grid''
codestroy''
)

NB. =========================================================
table_close=: destroy

NB. =========================================================
table_xp_button=: 3 : 0
XPRECISION__grid=: ".xp
show__grid ''
)
