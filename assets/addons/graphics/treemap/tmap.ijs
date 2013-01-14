NB. tmap
NB.
NB. defines treemap utility
NB.
NB. for nonce, only monadic use

require 'gtkwd'

TMAP=: 0 : 0
pc tmap;pn "Treemap";
xywh 0 0 300 200;cc tm isigraph ws_border rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
tmapdestroy=: 3 : 0
wd 'pclose'
destroy__tm''
codestroy''
)

NB. =========================================================
tmap_close=: tmap_cancel=: tmapdestroy

NB. =========================================================
treemap_z_=: 3 : 0
tmap_ptreemap_ y
:
(x;coname'') tmap_ptreemap_ y
)

NB. =========================================================
tmap=: 3 : 0
'' tmap y
:
a=. conew 'ptreemap'
x tmapshow__a y
)

NB. =========================================================
tmapshow=: 4 : 0
DATA=: y
LABEL=: NOTE=: 8!:0 DATA
wd TMAP
destroy=: tmapdestroy
wd^:(-.IFJ6) 'pshow;pshow sw_hide'
tm=: '' conew 'ptreemap'
show__tm pack 'DATA LABEL NOTE'
wd 'pshow;'
evtloop^:(-.IFJ6)''
)
