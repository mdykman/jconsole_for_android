NB. roman.ijs   Steiner's Roman surface

roman=: 3 : 0
u=. steps 0 1p1 25
v=. steps 0 1p1 15
x=. (*: sin u) */ sin 2*v
y=. (sin 2*u) */ sin v
z=. (sin 2*u) */ cos v
1.25 * gsmakexyz x;y;z
)

GS_ROTXYZ=: 315 15 40
GS_COLOR=: 0.75 1 0.75
GS_CLEARCOLOR=: SKYBLUE
TDATA=: roman''
TCLR=: (0 0 0 ,: 1 1 1) gshue gsfit01 2{"1 TDATA
TPATTERN=: 128 128$, gsrgba WHITE,LIMEGREEN,YELLOW,:WHITE
TPATPOS=: */~ gsint01 <:#TDATA
SHOWPATTERN=: 0

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsnewlist 1
  if. 0=SHOWPATTERN do.
    gsdrawsurface2 TDATA
  else.
    gsgentexture2D TPATTERN
    gsdrawsurface2 TDATA;TCLR;TPATPOS
  end.
  gsendlist ''
end.
glCallList 1
gsfini''
)
