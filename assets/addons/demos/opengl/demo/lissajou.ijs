NB. Lissajous (2,3,7) knot
NB.
NB. ref: College Mathematics Journal Vol28#3 p211

fx=. 0: + 2&*
fy=. 1: + 5&*
fz=. 2.1"_ + 7&*
fn=: cos @ (fx,fy,fz) f.
sp=. o. (<:i.92) % 45
KNOT=: fn gsmakefknot sp;11;0.2

GS_CLEARCOLOR=: SKYBLUE
GS_COLOR=: LIGHTGREEN
GS_AMBIENT=: 0.1
GS_DIFFUSE=: 0.7
GS_SPECULAR=: 0.7
GS_ROTXYZ=: 20 355 0

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsdrawknot makelist 1 [ 2.5 2 2*"1 KNOT
end.
glCallList 1
gsfini''
)
