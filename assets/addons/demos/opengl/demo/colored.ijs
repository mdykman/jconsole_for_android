NB. colored solid
NB.
NB. the vertices are colored according to
NB. their position, and the faces filled in.

SOLID=: gscube''    NB. try gsdodecahedron''

GS_ROTXYZ=: 45 60 0
GS_CLEARCOLOR=: 0.1 0 0.2 1

paint=: 3 : 0
gsinit''
face=. 2 pick SOLID
vtx=. 1.5*_3 [\"1 face
clr=. gsfit01 vtx
vtx make_colored"2 clr
gsfini''
)

colorit=: (glVertex@[ gscolor)"1

make_colored=: 4 : 0
glBegin GL_POLYGON
x colorit y
glEnd ''
)
