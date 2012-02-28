NB. Ennepers surface
NB.
NB. experiment with texture pattern, e.g.
NB. replace any WHITE with another color

enneper=: 3 : 0
u=. steps _2.4 2.4 25
x=. (u - (u^3)%3) + u */ u^2
y=. |: x
z=. -/~ u^2
gscleanz 1.3 1.3 2.4*"1 gsfit11 gsmakexyz x;y;z
)

TDATA=: enneper''
TCLR=: (0 0 0 ,: 1 1 1) gshue gsfit01 -0{"1 TDATA
TPATTERN=: 256 256 $, gsrgba BROWN,WHITE,WHITE,:WHITE
TPATPOS=: */~ gsint01 <:#TDATA

GS_ROTXYZ=: 288 5 10
GS_TRNXYZ=: _0.15 0 0
GS_CLEARCOLOR=: 0.9 1 0.9
GS_COLORMATERIAL=: 0
GS_AMBIENT=: 0.8
GS_DIFFUSE=: 0.75 0.75 1
GS_SPECULAR=: GS_DIFFUSE
GS_SHININESS=: 50 0 0 1
GS_POSITION=: _3 _5 _1 0

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
