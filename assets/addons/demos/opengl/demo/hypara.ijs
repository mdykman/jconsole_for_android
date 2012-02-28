NB. Hyperbolic Paraboloid
NB.
NB. not used in demo

hyperpara=: 3 : 0
P=. steps _1.25 1.25 10
T=. steps _1.1 1.1 10
T=. steps _1.1 1.1 10
X=. -P */ cosh T
Y=. P */ sinh T
Z=. 1-*: P
gsmakexyz X;Y;Z
)

GS_ROTXYZ=: 285 0 335
GS_CLEARCOLOR=: SALMON

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsdrawsurface2 makelist 1 hyperpara''
end.
glCallList 1
gsfini''
)
