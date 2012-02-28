NB. Superellipse
NB.
NB. Experiment with N01, RXYZ and MODE

NB. N01 = exponent in x-y plane, z-plane
NB. good choices are in range 0 - 5, e.g.
NB.  0 0      box (gscube if RXYZ all same)
NB.  1 1      ellipsoid (sphere if RXYZ all same)
NB.  2 2      gsoctahedron (RXYZ all same)
NB.  0.5 1
NB.  1 2
NB.  2 1
NB.  1 3
N01=: 3 1

NB. Axis lengths for x,y,z
RXYZ=: 1 1 1

NB. Display MODE
NB. GLU_OUTLINE_PATCH    supplied coordinates
NB. GLU_FILL             surface fill
NB. GLU_OUTLINE_POLYGON  generated coordinates
GS_DISPLAYMODE=: GLU_OUTLINE_POLYGON

LENXYZ=: 13 21    NB. number of xy, z steps

GS_COLOR=: 1 1 0.5
GS_CLEARCOLOR=: SKYBLUE
GS_ROTXYZ=: 110 150 0
GS_SPECULAR=: 0.4 0.4 0.4 1

NB. =========================================================
superellipse=: 3 : 0
pwr=. *@] * (|@]) ^ [
cosp=. pwr cos
sinp=. pwr sin

'rx ry rz'=. RXYZ
'n0 n1'=. N01
'lxy lz'=. LENXYZ

u=. steps _0.5p1 0.5p1,lz
v=. (, 1 &{) steps _1p1 1p1,lxy

x=. rx * (n0 cosp u) */ n1 cosp v
y=. ry * (n0 cosp u) */ n1 sinp v
z=. - rz * n0 sinp u

(x ,"0 y) ,"1 0 z
)

NB. =========================================================
paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsnewlist 1
  glaLight GL_LIGHT0, GL_POSITION, 1 1 1 0.75
  4 3 gsdrawsurface 1.3 * gscleanz superellipse''
  gsendlist ''
end.
glCallList 1
gsfini''
)
