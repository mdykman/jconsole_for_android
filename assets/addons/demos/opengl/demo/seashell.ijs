NB. Seashell
NB.
NB. experiment with parameters to seashell
NB.
NB. e.g.
NB.   SEAPARMS=: 0.2 3 0.4 4

SEAPARMS=: 0.2 1 0.1 2

seashell=: 3 : 0
'a b c n'=. y
u=. steps 0 9r4p1 20
v=. steps 0 2p1 20
nv=. n * v
vp=. v % 2p1
vp1=. 1 - vp
x=. -((a * 1+cos u) */ vp1 * cos nv) +"1 c * cos nv
y=. ((a * 1+cos u) */ vp1 * sin nv) +"1 c * sin nv
z=. ((a * sin u) */ vp1) +"1 b * vp
1.4*gsfit11 gsmakexyz gsmid11 each x;y;z
)

TDATA=: seashell SEAPARMS
TPATTERN=: 256 256 $, gsrgba (10<?100$100){0.99 0.75 0.5,:1
TPATPOS=: gsfit01 TDATA
GS_ROTXYZ=: 295 275 75
GS_COLOR=: 1 1 0.5
GS_CLEARCOLOR=: SKYBLUE
GS_COLORMATERIAL=: 1

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsnewlist 1
  gsgentexture2D TPATTERN
  gsdrawsurface2 TDATA;'';TPATPOS
  gsendlist ''
end.
glCallList 1
gsfini''
)
