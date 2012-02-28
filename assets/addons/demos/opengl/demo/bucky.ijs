NB. Bucky Ball
NB.
NB. constructed as a truncated gsicosahedron.
NB. ball has 12 pentagons, 20 hexagons.
NB. edges are blue (single bond), yellow (double bond).
NB.
NB. set VIEW elements to 0 to suppress building blocks
NB. set BOTHSIDES to 0 to show only one half
NB.
NB. Experiment with sizes, e.g.
NB.   SPHERESIZE=: 0.25 [ CYLINDERSIZE=: 0
NB.   SPHERESIZE=: 0.25 [ CYLINDERSIZE=: 0.225

VIEW=: 1 1 1
BOTHSIDES=: 1

SPHERESIZE=: 0.06
CYLINDERSIZE=: 0.015

GS_VIEWXYZ=: 0 0 4
GS_ROTXYZ=: 0 25 15
SPHERE=: 2041
CYLINDER1=: 2042
CYLINDER2=: 2043
VERTEX=: 2044
HALF=: 2045

NB. =========================================================
genhex=: 3 : 0
s=. +: y
2 <\ (,{.) 3 %~ ,/ 0 2 |: (s+1|.y) ,: y+1|.s
)

NB. =========================================================
NB. generates pentagon and 2 attached hexagons
bucky=: 3 : 0
j=. (-:%:5) %~ |: 0.5 ,~ 2 1 o./ o. +: 5 %~ i.5
ICOSA=: 0 0 1, j
NB. offset so lower vertices have z=0:
off=. 0 0,(<2;2){ICOSA
vz=. ICOSA -"1 off
NB. generate pentagon round central vertex:
x=. }.vz
t=. {.vz
p=. (,{.) 3 %~ x +"1 +: t
NB. generate hexagons for two sides:
h=. genhex t, 0 1 { x
h1=. genhex t, 1 2 { x
NB. restore offset and define globals:
PEN=: p +"1 off
HEX=: (h ,. h1) +"1 each <off
)

bucky''

NB. =========================================================
paint=: 3 : 0
if. gsinit GS_LIGHT do.
  len=. gsdist -/ 2{.PEN
  quad=. {.>gluNewQuadric''

  gsnewlist SPHERE
  gscolor RED
  gluSphere quad,SPHERESIZE,20 20
  gsendlist''

  gsnewlist CYLINDER1
  gscolor SKYBLUE
  gluCylinder quad,(2$CYLINDERSIZE),len,10 1
  gsendlist''

  gsnewlist CYLINDER2
  gscolor YELLOW
  gluCylinder quad,(2$CYLINDERSIZE),len,10 1
  gsendlist''

  gsnewlist VERTEX
  if. 0{VIEW do. SPHERE make_spheres PEN end.
  if. 1{VIEW do.
    CYLINDER1 make_tubes 5{.PEN ,. 1|.PEN
    CYLINDER1 make_tubes ,&> , 1 3 { HEX
  end.
  if. 2{VIEW do. CYLINDER2 make_tubes ,&> , 0 2 4 { HEX end.
  gsendlist''

  gsnewlist HALF
  VERTEX make_vertices ICOSA
  gsendlist''

  HALF make_halves 0, BOTHSIDES#1

  gluDeleteQuadric quad
end.
HALF make_halves 0, BOTHSIDES#1
gsfini''
)

NB. =========================================================
NB. make spheres:
make_spheres=: 4 : 0 "1
glPushMatrix ''
glTranslate y
glCallList x
glPopMatrix ''
)

NB. =========================================================
NB. make tubes:
make_tubes=: 4 : 0 "1
glPushMatrix ''
'f t'=. _3 <\ y
glTranslate f
'rx ry rz'=. 1 1 _1 * gsunitvec f-t
angle=. dfr arccos rz
axis=. ry,-rx,0
glRotate angle,axis
glCallList x
glPopMatrix ''
)

NB. =========================================================
NB. make vertices:
make_vertices=: 4 : 0 "1
glPushMatrix ''
'rx ry rz'=. y
angle=. dfr arccos rz
axis=. ry,-rx,0
if. 1 > angle do.
  angle=. 36
  axis=. 0 0 1
end.
glRotate angle,axis
glCallList x
glPopMatrix ''
)

NB. =========================================================
NB. make halves
make_halves=: 4 : 0 "0
glPushMatrix ''
if. y do. glMultMatrix _1 0 0 0 0 _1 0 0 0 0 _1 0 0 0 0 1 end.
glCallList x
glPopMatrix ''
)

