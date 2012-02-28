NB. Klein bottle
NB.
NB. 2=left argument to surface verb
NB. for double sided lighting

GS_SHOWPOINTS=: 0   NB. 1=see nurbs points

klein=: 3 : 0
stp=. 19
u1=. steps 0 1p1, stp
u2=. }. steps 1p1 2p1, stp
u=. v=. u1,u2
r=. 4 * -. 0.5 * cos u
j=. ((cos u1) */ cos v) , (0 * u2) +/ cos v + 1p1
x=. (6 * (cos u) * 1 + sin u) + r * j
y=. (16 * sin u) + r * ((sin u1), 0 * u2) */ cos v
z=. r * (0 * u) +/ sin v
1.6 * gsfit11 gsmakexyz x;y;z
)

GS_ROTXYZ=: 225 10 320
GS_COLOR=: 1 1 0.5
GS_CLEARCOLOR=: SKYBLUE

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsdrawsurface2 makelist 1 klein''
end.
glCallList 1
gsfini''
)
