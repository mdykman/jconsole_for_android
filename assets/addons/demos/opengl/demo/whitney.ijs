NB. Whitney's Umbrella

whitney=: */~ ; (+/~:~) ; *:

TDATA=: 1.25 * gsfit11 gsmakexyz whitney steps _1 1 15
TCLR=: (0 0 0 ,: 1 1 1) gshue gsfit01 -2{"1 TDATA
TPATTERN=: 4 4$, gsrgba WHITE,GRAY,WHITE,:WHITE
TPATPOS=: */~ gsint01 <:#TDATA

GS_ROTXYZ=: 50 0 195
GS_TRNXYZ=: 0 0.25 0
GS_CLEARCOLOR=: 0.9 1 0.9
GS_COLORMATERIAL=: 0
GS_AMBIENT=: 0.8
GS_DIFFUSE=: LIGHTSKYBLUE
GS_SPECULAR=: GS_DIFFUSE
GS_SHININESS=: 50 0 0 1

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsnewlist 1
  gsgentexture2D TPATTERN
  gsdrawsurface2 TDATA;TCLR;TPATPOS
  gsendlist ''
end.
glCallList 1
gsfini''
)
