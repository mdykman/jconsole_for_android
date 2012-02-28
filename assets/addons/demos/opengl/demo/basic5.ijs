NB. basic demo 5
NB.
NB. shows transparent cylinders
NB.
NB. experiment with OPAQUE in range 0-1.

OPAQUE=: 0.75

GS_ROTXYZ=: 310 0 45
GS_AMBIENT=: 0.2
GS_DIFFUSE=: 0.75
GS_SPECULAR=: 1
GS_CLEARCOLOR=: 0.6
CYLINDER=: 101

paint=: 3 : 0
gsinit GS_LIGHT,GS_BLEND
drawcylinders ''
gsfini''
)

makecylinder=: 3 : 0
gsnewlist CYLINDER
glTranslate 0 0,- -: 2{y
gluQuadricDrawStyle QUADS,GLU_FILL
gluQuadricNormals QUADS,GLU_SMOOTH
gluCylinder <&> QUADS,y
gsendlist ''
)

drawcylinders=: 3 : 0
QUADS=: {. > gluNewQuadric''
makecylinder 0.6 0.6 2.5 40 1

glPushMatrix''
gscolor RED,OPAQUE
glCallList CYLINDER
glPopMatrix''

glPushMatrix''
glRotate 90 1 0 0
gscolor BLUE,OPAQUE
glCallList CYLINDER
glPopMatrix''

glPushMatrix''
glRotate 90 0 1 0
gscolor LIMEGREEN,OPAQUE
glCallList CYLINDER
glPopMatrix''

gluDeleteQuadric QUADS
)
