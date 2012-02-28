NB. Dini's Surface
NB. - constant negative curvature.

dini=: 3 : 0
u=. steps 0 4p1 40
v=. steps 0.05 2 20
x=. (cos u) */ sin v
y=. (sin u) */ sin v
z=. (0.4 * u) +/ (cos v) + ^. tan v%2
gscleanz 3 3 1.5 *"1 gsfit11 gsmakexyz x;y;z
)

TDATA=: dini''
TCLR=: (0 0 0 ,: 1 1 1) gshue gsfit01 2{"1 TDATA
TPATTERN=: 8 8 $, gsrgba WHITE,GRAY,YELLOW,:WHITE
TPATPOS=: */~ gsint01 <:#TDATA
GS_ROTXYZ=: 310 0 0
GS_TRNXYZ=: 0.75 0.25 0
GS_CLEARCOLOR=: 1 0.9 0.9
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
