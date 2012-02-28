NB. model
NB.
NB. move into the solid (press i or Shift i),
NB. to see inside the balls and cylinders.
NB.
NB. use speed keys to control the speed of
NB. movement (1=slowest)

SOLID=: gsdodecahedron''  NB. try gscube'' etc.

GS_ROTXYZ=: 30 5 _5
GS_VIEWXYZ=: 0 0 4.5
SPHERE=: 2042
CYLINDER=: 2043

paint=: 3 : 0
gsinit GS_LIGHT
len=. gsdist -/ _3[\ {.1 pick SOLID
quad=. {.>gluNewQuadric''
gsnewlist SPHERE
gscolor RED
gluSphere quad,0.11 20 20
gsendlist''
gsnewlist CYLINDER
gscolor SILVER
gluCylinder quad,0.025 0.025,len ,10 1
gsendlist''
make_spheres 0 pick SOLID
make_tubes 1 pick SOLID
gluDeleteQuadric quad
gsfini''
)

NB. =========================================================
NB. make spheres:
make_spheres=: 3 : 0 "1
glPushMatrix ''
glTranslate y
glCallList SPHERE
glPopMatrix ''
)

NB. =========================================================
NB. make tubes:
make_tubes=: 3 : 0 "1
glPushMatrix ''
'f t'=. _3 <\ y
glTranslate f
'x y z'=. 1 1 _1 * gsunitvec f-t
angle=. dfr arccos z
axis=. y,-x,0
glRotate angle,axis
glCallList CYLINDER
glPopMatrix ''
)
