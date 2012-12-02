NB. view 3d  - view 3d object
NB.
NB. illustrates viewpoint system used in Plot

require 'droidwd gtkwd'
NB. GTKOUTPUT_jzplot_=: 'isi'

PForm=: 'v3d'
PId=: 'gp'

V3D=: 0 : 0
pc v3d closeok;
menupop "File";
menusep ;
menu exit "&Exit" "" "" "";
menupopz;
xywh 233 4 30 12;cc cancel button leftmove rightmove;cn "Close";
xywh 198 4 30 12;cc default button leftmove rightmove;cn "Default";
xywh 5 6 6 8;cc xlabel static;cn "x:";
xywh 12 5 18 10;cc xedit edit ws_border es_autohscroll;
xywh 32 4 10 11;cc xspin spinv;
xywh 49 6 6 8;cc ylabel static;cn "y:";
xywh 55 5 18 10;cc yedit edit ws_border es_autohscroll;
xywh 74 4 10 11;cc yspin spinv;
xywh 93 6 6 8;cc zlabel static;cn "z:";
xywh 99 5 18 10;cc zedit edit ws_border es_autohscroll;
xywh 118 4 10 11;cc zspin spinv;
xywh 252 32 6 8;cc xlabel static leftmove rightmove;cn "x:";
xywh 246 40 19 10;cc uxedit edit ws_border es_autohscroll leftmove rightmove;
xywh 252 64 6 8;cc ylabel static leftmove rightmove;cn "y:";
xywh 246 72 19 10;cc uyedit edit ws_border es_autohscroll leftmove rightmove;
xywh 252 96 6 8;cc zlabel static leftmove rightmove;cn "z:";
xywh 246 104 19 10;cc uzedit edit ws_border es_autohscroll leftmove rightmove;
xywh 0 20 243 162;cc gp isigraph ws_border rightmove bottommove;
xywh 248 116 12 9;cc uzspin spin leftmove rightmove;
xywh 249 84 12 9;cc uyspin spin leftmove rightmove;
xywh 249 52 12 9;cc uxspin spin leftmove rightmove;
pas 2 0;pcenter;
rem form end;
)

setedits=: 3 : 0
wd 'set xedit ',pfmt VIEWX
wd 'set yedit ',pfmt VIEWY
wd 'set zedit ',pfmt VIEWZ
)

setuedits=: 3 : 0
wd 'set uxedit ',pfmt VIEWUPX
wd 'set uyedit ',pfmt VIEWUPY
wd 'set uzedit ',pfmt VIEWUPZ
)

v3d_run=: 3 : 0
VIEWX=: 0{VIEWPOINT
VIEWY=: 1{VIEWPOINT
VIEWZ=: 2{VIEWPOINT

VIEWUPX=: 0{VIEWUP
VIEWUPY=: 1{VIEWUP
VIEWUPZ=: 2{VIEWUP

DEFAULT=: VIEWPOINT
DEFAULTUP=: VIEWUP

wd V3D
PIdhwnd=: wdqhwndc 'gp'
setedits''
setuedits''
viewit''
wd 'pshow;'
)

viewit=: 3 : 0
Init=: 0
VIEWPOINT=: VIEWX,VIEWY,VIEWZ
VIEWUP=: VIEWUPX,VIEWUPY,VIEWUPZ

Plot=: 0#Plot
pd VIEWDATA
plotmake''
Plot=: Plot /: {."1 Plot
PForm=: 'v3d'
plotshow Plot
)

v3d_xedit_button=: viewenter
v3d_yedit_button=: viewenter
v3d_zedit_button=: viewenter
v3d_uxedit_button=: viewenter
v3d_uyedit_button=: viewenter
v3d_uzedit_button=: viewenter

v3d_cancel_button=: 3 : 0
wd 'pclose;'
)

v3d_xspin_button=: 3 : 0
VIEWX=: clean VIEWX+0.2*".xspin
wd 'set xedit ',pfmt VIEWX
viewit''
)

viewenter=: 3 : 0
VIEWX=: ".xedit
VIEWY=: ".yedit
VIEWZ=: ".zedit
VIEWUPX=: ".uxedit
VIEWUPY=: ".uyedit
VIEWUPZ=: ".uzedit
viewit''
)

v3d_yspin_button=: 3 : 0
VIEWY=: clean VIEWY+0.2*".yspin
wd 'set yedit ',pfmt VIEWY
viewit''
)

v3d_zspin_button=: 3 : 0
VIEWZ=: clean VIEWZ+0.2*".zspin
wd 'set zedit ',pfmt VIEWZ
viewit''
)

v3d_uxspin_button=: 3 : 0
VIEWUPX=: clean VIEWUPX+0.05*".uxspin
wd 'set uxedit ',pfmt VIEWUPX
viewit''
)

v3d_uyspin_button=: 3 : 0
VIEWUPY=: clean VIEWUPY+0.05*".uyspin
wd 'set uyedit ',pfmt VIEWUPY
viewit''
)

v3d_uzspin_button=: 3 : 0
VIEWUPZ=: clean VIEWUPZ+0.05*".uzspin
wd 'set uzedit ',pfmt VIEWUPZ
viewit''
)

v3d_default_button=: 3 : 0
(;:'VIEWX VIEWY VIEWZ')=: DEFAULT
(;:'VIEWUPX VIEWUPY VIEWUPZ')=: DEFAULTUP
setedits''
setuedits''
viewit''
)

view3d=: v3d_run
