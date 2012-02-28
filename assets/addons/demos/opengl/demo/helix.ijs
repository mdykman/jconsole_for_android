NB. helix
NB.
NB. the y-axis is vertical
NB. press the Y key to rotate.

helix=: 3 : 0
u=. steps 0,(o. +:y), 20
v=. steps _1 1 20
x=. (cos u) */ v
y=. u +/ v * 0
z=. (sin u) */ v
1.25*gsmakexyz gsfit11 each x;y;z
)

GS_COLOR=: ORCHID
GS_CLEARCOLOR=: IVORY

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsdrawsurface2 makelist 1 helix 1.5
end.
glCallList 1
gsfini''
)
