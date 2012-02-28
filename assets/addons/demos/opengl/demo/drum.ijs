NB. Vibrating drum

drum=: 3 : 0
R=. steps 0 1 21
T=. steps 0 36r16p1 21
X=. R */ cos T
Y=. R */ sin T
Z=. 0.1+0.4 * (BesselJ2 R*11.6) */ cos +:T
1.8 * gsmakexyz X;Y;Z
)

BesselJ2=: 3 : 0
t=. 1r128p1 * i.129
r=. (cos +:t) * cos (sin t) */ y
(+/ r * 1,(127$4 2),1) % 384
)

GS_ROTXYZ=: 310 0 340
GS_COLOR=: PALEGREEN
GS_CLEARCOLOR=: SKYBLUE

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  4 3 gsdrawsurface2 makelist 1 drum''
end.
glCallList 1
gsfini''
)

