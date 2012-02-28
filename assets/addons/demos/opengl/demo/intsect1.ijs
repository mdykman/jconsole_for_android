NB. intersection 1
NB.
NB. experiment with OPAQUE values
NB. from 0 to 1
NB.
NB. assign GS_DISPLAYMODE as below
NB. to see the tessellation.

NB. GS_DISPLAYMODE=: GLU_OUTLINE_POLYGON

OPAQUE=: 0.8

GS_VIEWXYZ=: 0 0 5.33
GS_ROTXYZ=: 325 347 167
GS_TRNXYZ=: 0.2 _0.175 0.05
GS_CLEARCOLOR=: NAVY

paint=: 3 : 0
gsinit GS_LIGHT
drawS1 ''
drawS2 ''
gsfini''
)

drawS1=: 3 : 0
glPushMatrix''
GS_COLOR=: SALMON
glTranslate 0 0.2 0.2
glRotate 95 240 40 ,. GS_ID3
gsdrawsurface2 stube''
glPopMatrix''
)

drawS2=: 3 : 0
GS_COLOR=: LEMONCHIFFON,OPAQUE
dat=. gsfit11 gsmakexyz (];];sin@+/~) steps 0 1 25
gsdrawsurface2 dat
)

stube=: 3 : 0
T=. steps _0.3 1p1 25
S=. 0.75
X=. (sin S*T) */ 1+sin T
Y=. (cos S*T) */ 1+sin T
Z=. (T*0) +/ cos T
Z=. Z * 0.5+0.5*|0.5*T-1r2p1
1.1*gsfit11 gsmakexyz X;Y;Z
)
