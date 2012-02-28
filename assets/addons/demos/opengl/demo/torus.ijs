NB. torus knot

V=. "_
fx=. cos@- + 1.5 V * cos@(3&*)
fy=. sin + 1.5 V * sin@(3&*)
fz=. sin@(4&*) + sin@(2&*) % 3:
fn=: (fx,fy,fz) f.
TORUSKNOT=: fn gsmakefknot (steps 0 2p1 40);11;1

GS_ROTXYZ=: 0 0 325

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsdrawknot makelist 1 TORUSKNOT
end.
glCallList 1
gsfini''
)
