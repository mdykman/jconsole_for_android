NB. crosscap
NB.
NB. for a doubled crosscap, try:
NB. x=. (sin +: u) */ sin +: v

crosscap=: 3 : 0
u=. steps 0 1p1 15
v=. steps _1r2p1 1r2p1 15
x=. (sin u) */ sin +: v
y=. (sin +: u) */ *: cos v
z=. (cos +: u) */ *: cos v
1.25*gsmakexyz x;y;z
)

TDATA=: crosscap''
TCLR=: (0 0 0 ,: 1 1 1) gshue gsfit01 2{"1 TDATA
TPATTERN=: 32 32$, gsrgba WHITE,LIMEGREEN,YELLOW,:WHITE
TPATPOS=: */~ gsint01 <:#TDATA

GS_ROTXYZ=: 25 350 180
GS_CLEARCOLOR=: SKYBLUE
GS_COLOR=: TEAL
SHOWPATTERN=: 1

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
