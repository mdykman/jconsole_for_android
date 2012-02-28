NB. Moebius Strip

moebius=: 3 : 0
u=. steps 0 2p1 20
v=. steps _0.3 0.3 20
x=. (cos u) + ((cos u) * cos u%2) */ v
y=. (sin u) + ((sin u) * cos u%2) */ v
z=. (sin u%2) */ v
gscleanz 1.5 *"1 gsfit11 gsmakexyz x;y;z
)

TDATA=: moebius''

TCLR=: (0 0 0 ,: 1 1 1) gshue gsfit01 2{"1 TDATA
TPATTERN=: 16 16$, gsrgba WHITE,GRAY,YELLOW,:WHITE
TPATPOS=: */~ gsint01 <:#TDATA
GS_ROTXYZ=: 325 205 155
GS_CLEARCOLOR=: 0.9 0.9 1
GS_COLORMATERIAL=: 0
GS_AMBIENT=: 0.8
GS_DIFFUSE=: LIMEGREEN
GS_SPECULAR=: GS_DIFFUSE
GS_SHININESS=: 50 0 0 1

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsnewlist 1
  gsgentexture2D TPATTERN
  gsdrawsurface2 TDATA;TCLR;TPATPOS
  gsendlist ''
end.
glCallList 1
gsfini''
)

NB. =========================================================
NB. also?
Another_moebius=: 3 : 0
r=. 5
a=. 1
u=. steps 0 4p1 20
u2=. -: u
x=. ((r-a) * sin u2) */ sin u
y=. ((r-a) * sin u2) */ cos u
z=. (a * cos u2) +/ u*0
gscleanz 1.5 *"1 gsfit11 gsmakexyz x;y;z
)
