NB. Umbilic Torus
NB.
NB. ref Helaman Ferguson, Math Monthly 97 #7 589-610
NB.
NB. Change GS_DISPLAYMODE to see user-defined
NB. values provided to the renderer.

GS_DISPLAYMODE=: GLU_FILL NB. GLU_OUTLINE_PATCH, GLU_OUTLINE_POLYGON

GS_CLEARCOLOR=: 0
GS_COLORMATERIAL=: 0
GS_AMBIENT=: 0.8
GS_DIFFUSE=: 0.75 0.75 1
GS_SPECULAR=: GS_DIFFUSE
GS_SHININESS=: 100 0 0 1
GS_ROTXYZ=: 10 130 100

makefumbtorus=: 1 : 0
't p r w'=. 4{. y,<0
rn=. (0.5*r)*umbtorus p
rl=. 1 1 1.5
u gsmakefloop t;rn;w;rl
)

umbtorus=: 3 : 0
t=. steps (o. 1 5r3), y
t=. t, steps (o. _1r3 1r3), y
t=. t, steps (o. 1r3 1), y
x=. +: ^ j. t
y=. ^ - +: j. t
gscleanz (+. x-y) % 3
)

fn=: (2: * cos,sin,0:) f.
UMBTORUS=: fn makefumbtorus (steps 0 2p1 15);11;2;1r3

r3=. 3 %~ #UMBTORUS
TDATA=: UMBTORUS ,"2 [ r3 |. 1 2 { "2 UMBTORUS
TCLR=: (0 0 0 ,: 1 1 1) gshue gsfit01 -0{"1 TDATA
TPATTERN=: 256 256$, gsrgba 1 1# WHITE ,: LIGHTGRAY
TPATPOS=: */~ gsint01 <:#TDATA

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsnewlist 1
  gsgentexture2D TPATTERN
  4 3 gsdrawsurface2 TDATA;TCLR;TPATPOS
  gsendlist''
end.
glCallList 1
gsfini''
)
