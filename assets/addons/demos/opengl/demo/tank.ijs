NB. Helicopter demo by Alex Kornilovski
NB.
NB. Note that this redefines the movement keys.
NB. use the cursor keys to move around
NB. W,S - move Up-Down
NB. Q,A - Look Up-Down

=========================================================
demo=: verb define
GS_AMBIENT=: 0.75
GS_DIFFUSE=: 0.75
GS_SPECULAR=: 1
Init ''
stdlistlight ''
Piller ''
startnewlist ''
glPushMatrix''
Ground ''
glPopMatrix''
DrawView ''
gsendlist''
getnewXYZ 1
glview''
gsfini''
)

NB. =========================================================
opengl_g_char=: 3 : 0
keyb=. (a.{~128+33 34 37 39 38 40),'qaws'
keyi=. 33 34 37 39 38 40,a.i.'QAWS'
n=. keyi#~keyb=0{sysdata
0 handle_tank_key n
glview''
gsfini''
)

NB. =========================================================
handle_tank_key=: 4 : 0 " 0
s=. x NB. ignored
k=. y

select. k

case. 37;39 do.  NB. Turn left-right
  THETA=: THETA+0.1*gschgsign 1-2*k=39
  VIEWLINE=: GS_VIEWXYZ +GS_SPEED* ((cos GAMMA)*sin THETA),(sin GAMMA),-(cos GAMMA)*cos THETA

case. 38;40 do.  NB. move forward-backward
  getnewXYZ gschgsign 1-2*k=38

case. <@>49+i.10 do. NB. speed
  GS_SPEED=: GS_SPEEDS {~ k-49

case. 81;65 do.    NB. Look UP-Down
  GAMMA=: GAMMA+0.05*gschgsign 1-2*k=81
  if. GAMMA>0.48p1 do. GAMMA=: 0.48p1 end.
  if. GAMMA<_0.48p1 do. GAMMA=: _0.48p1 end.
  VIEWLINE=: GS_VIEWXYZ +GS_SPEED* ((cos GAMMA)*sin THETA),(sin GAMMA),-(cos GAMMA)*cos THETA

case. 87;83 do.  NB. Move UP-Down
  GS_VIEWXYZ=: ((1{GS_VIEWXYZ)+gschgsign 1-2*k=87) (1)}GS_VIEWXYZ
  VIEWLINE=: ((1{VIEWLINE)+gschgsign 1-2*k=87) (1)}VIEWLINE
end.
)

NB. =========================================================
stdview=: verb define
gluLookAt GS_VIEWXYZ,VIEWLINE,GS_VIEWUP
)

NB. =========================================================
Init=: verb define
VIEWLINE=: 0 5 0
GAMMA=: THETA=: 0
GS_VIEWXYZ=: 0 5 0
GS_PERSPECTIVE=: 35 1 1 2000
GS_SPEED=: 4
PILLER=: 2042
Gempos=: _500+?15 2$1000
Stonepos=: _500+?15 2$1000
Pillerpos=: _500+?15 2$1000
TAR=: 99
)

NB. =========================================================
getnewXYZ=: verb define
GS_VIEWXYZ=: GS_VIEWXYZ+ GS_SPEED*y*(sin THETA),0,-cos THETA
VIEWLINE=: GS_VIEWXYZ +GS_SPEED* ((cos GAMMA)*sin THETA),(sin GAMMA),-(cos GAMMA)*cos THETA
)

NB. =========================================================
Ground=: 3 : 0
nStep=. 30
makelist ''

glColor 0,255,0
glNormal 0,1,0
glBegin GL_LINES

r=. _500+20*i. 1+ >.1000%20
h=. r , each <0 _500
s=. h ,each r, each <0 500
s=. ((2*#h),3)$,>s

glVertex s

h=. (<500 0) ,each r
s=. h,each (<_500 0), each r
s=. ((2*#h),3)$,>s

glVertex s


glEnd ''
gsendlist ''
)

NB. =========================================================
DrawView=: verb define

startnewlist ''
for_j. i.#Gempos do.
  glPushMatrix ''
  glTranslate ((<j,0){Gempos) ,22,(<j,1){Gempos
  glScale _5+30 30 30
  gsdrawdodecahedron''
  glPopMatrix ''
end.

for_j. i.#Stonepos do.
  glPushMatrix ''
  glTranslate ((<j,0){Stonepos) ,20,(<j,1){Stonepos
  glScale _5+30 30 30
  gsdrawicosahedron ''
  glPopMatrix ''
end.

for_j. i.#Pillerpos do.
  glPushMatrix ''
  glTranslate ((<j,0){Pillerpos) ,20,(<j,1){Pillerpos
  glCallList PILLER
  glPopMatrix ''
end.
gsendlist ''
)

NB. =========================================================
Piller=: verb define
QUADS=: gluNewQuadric''
vNormal=. 1
fStep=. o.1%4
fHeight=. 20
fRadius=. 5

gsnewlist PILLER
glPushMatrix ''
glColor 100,0,228
glBegin GL_QUAD_STRIP
vNormal=. gsunitnormal fRadius,fHeight,0
glNormal vNormal
glVertex fRadius,fHeight,0
glVertex fRadius,-fHeight,0
for_j. fStep*i.1+>.o.3%fStep do.
  x=. fRadius*sin j
  z=. fRadius*cos j

  vNormal=. gsunitnormal x,fHeight,z
  glNormal vNormal
  glVertex x,fHeight,z
  glVertex x,(-fHeight),z

end.
glEnd ''

glTranslate 0,(fHeight+fRadius%2),0
glColor 0,0,255
gsdrawsphere (fRadius*2.5),20 20
glPopMatrix ''

gsendlist''
)


NB. =========================================================
Target=: verb define
NB. Draw point of look

glColor 255,0,0
glLineWidth 3
glBegin GL_LINES

new=. GS_VIEWXYZ +GS_SPEED* ((cos GAMMA)*sin THETA+0.02),(sin GAMMA),-(cos GAMMA)*cos THETA+0.02
new1=. GS_VIEWXYZ +GS_SPEED* ((cos GAMMA)*sin THETA-0.02),(sin GAMMA),-(cos GAMMA)*cos THETA-0.02
glVertex 2 3$VIEWLINE,new
glVertex 2 3$VIEWLINE,new1

new=. GS_VIEWXYZ +GS_SPEED* ((cos GAMMA+0.02)*sin THETA),(sin GAMMA+0.02),-(cos GAMMA+0.02)*cos THETA
new1=. GS_VIEWXYZ +GS_SPEED* ((cos GAMMA-0.02)*sin THETA),(sin GAMMA-0.02),-(cos GAMMA-0.02)*cos THETA
glVertex 2 3$VIEWLINE,new
glVertex 2 3$VIEWLINE,new1
glEnd ''
glLineWidth 1
)
