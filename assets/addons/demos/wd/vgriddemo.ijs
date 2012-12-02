NB. vgridemo
NB.
NB. This demo shows a virtual grid where data is given
NB. via a get event handler

require 'jzgrid pack'

coclass 'vgriddemo'

size=. 10000 200
MYDATA=: (10 * 1 + i.size) + size $ 0.01*?~100

NB. =========================================================
VGRID=: 0 : 0
pc vgrid;pn "Virtual Grid";
xywh 0 0 300 250;cc grid isigraph ws_border rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
vgrid_run=: 3 : 0
wd VGRID
gridvirtualmode=. 1
cellrange=. <: |. $ MYDATA
hdrrow=: hdrcol=: 0
grid=: conew 'jzgrid'
wd 'pshow'
show__grid pack 'cellrange gridvirtualmode hdrrow hdrcol'
evtloop^:(-.IFJ6)''
)

NB. =========================================================
vgrid_close=: vgrid_cancel=: 3 : 0
destroy__grid''
wd 'pclose'
)

NB. =========================================================
grid_gridhandler=: 3 : 0
select. y
case. 'get' do.
  vgridget'' return.
end.
1
)

NB. =========================================================
vgridget=: 3 : 0
cls=. Cls__grid
rws=. Rws__grid
rws=. rws #~ (rws >: 0) *. rws < # MYDATA
cls=. cls #~ (cls >: 0) *. cls < {:$ MYDATA
celldata=. (<rws;cls) { MYDATA
set__grid 'celldata';celldata
0
)

NB. =========================================================
vgrid_run''
