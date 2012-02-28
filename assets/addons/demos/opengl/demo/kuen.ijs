NB. Kuen's  surface of constant negative curvature

kuen=: 3 : 0
u=. steps _4 4 10
v=. }. }: steps 0 1p1 10

w=. %"1 & (1 + *: u */ sin v)
x=. (w sin v) * (cos u) + u * sin u
y=. (w sin v) * (sin u) - u * cos u
z=. (2 * w cos v) + (u * 0) +/ ^. tan v%2

gscleanz 2.5 2.5 1 *"1 gsfit11 gsmakexyz x;y;z
)

TDATA=: kuen''
TCLR=: (0 0 0 ,: 1 1 1) gshue gsfit01 2{"1 TDATA
TPATTERN=: 256 256$, gsrgba WHITE,GRAY,YELLOW,:WHITE
TPATPOS=: */~ gsint01 <:#TDATA
GS_ROTXYZ=: 300 185 325
GS_TRNXYZ=: 0.3 0.125 0
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
