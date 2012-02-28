NB. trefoil knot
NB.
NB. Uncomment the assignment of
NB. GS_DISPLAYMODE to see user-defined
NB. values provided to the renderer.

GS_DISPLAYMODE=: GLU_OUTLINE_POLYGON

V=. "_
r=. 1: + 0.4 V * cos@(1.5&*)
fx=. r * cos
fy=. r * sin
fz=. 0.5 V * sin@(1.5&*)
fn=: (1.7 V * fx,fy,fz) f.
TREFOIL=: fn gsmakefknot (steps 0 16r4p1 25);11;2

GS_ROTXYZ=: 0 0 325

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsdrawknot makelist 1 TREFOIL
end.
glCallList 1
gsfini''
)
