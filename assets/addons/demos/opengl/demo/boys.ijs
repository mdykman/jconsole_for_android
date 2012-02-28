NB. Boy's surface

boys=: 3 : 0
u=. steps 0 1p1 25
v=. steps 0 1p1 25
s2=. %:2
sin2=. sin @ (2&*)
sin3=. sin @ (3&*)
cos2=. cos @ (2&*)
d=. s2 - (sin2 u) */ (sin3 v)
r=. 2r3 * (cos u) % d
x=. r * ((cos u) */ (cos2 v)) + s2 * (sin u) */ (cos v)
y=. r * ((cos u) */ (sin2 v)) - s2 * (sin u) */ (sin v)
z=. s2 * (*: cos u) % s2 - (sin2 u) */ (sin2 v)
1.25*gsmakexyz gsfit11 each x;y;z
)

GS_ROTXYZ=: 175 5 _15
GS_TRNXYZ=: 0.05 0.075 0
GS_COLOR=: ORCHID
GS_CLEARCOLOR=: IVORY

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsdrawsurface2 makelist 1 boys''
end.
glCallList 1
gsfini''
)
