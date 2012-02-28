NB. random triangles
NB.
NB. Change seed for a new random set
NB.
NB. rotate graph, showing the
NB. triangles' intersections

SEED=: 101

paint=: 3 : 0
9!:1[SEED
gsinit''
make_triangles 6
gsfini''
)

make_triangle=: 3 : 0
v=. 35 %~ _50+?3 3$100
glBegin GL_POLYGON
gscolor y
glVertex v
glEnd''
)

make_triangles=: 3 : 0
clr=. y gsdeal GS_STDCLR
make_triangle"1 clr
)
