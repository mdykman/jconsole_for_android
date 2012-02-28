NB. Maeder's Minimal Surface

maeder=: 3 : 0
u=. steps 0 4p1 25
v=. steps 0 1 25
x=. ((cos u) */ v) - -: (cos +: u) */ *: v
y=. - ((sin u) */ v) + -: (sin +: u) */ *: v
z=. 4r3 * (cos u * 3r2) */ v ^ 1.5
gscleanz 1.5 *"1 gsfit11 gsmakexyz x;y;z
gsfini''
)

TDATA=: maeder''
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
NB. gsgentexture2D TPATTERN
NB. gsdrawsurface2 makenewlist TDATA;TCLR;TPATPOS
  GS_DISPLAYMODE=: GLU_OUTLINE_POLYGON
  GS_DISPLAYMODE=: GLU_OUTLINE_PATCH
  gsdrawsurface2 makenewlist TDATA
  gsendlist ''
end.
glCallList 1
gsfini''
)

require 'gl2 opengl numeric trig'
('jzopengl';'z') copath 'base'
glinit''
