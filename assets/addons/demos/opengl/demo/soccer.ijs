NB. Socccer Ball
NB.
NB. constructed as a bucky ball (see bucky demo)

0!:0 <GLDEMOPATH,'bucky.ijs'

GS_CLEARCOLOR=: BLUE
PENCOLOR=: BLACK
HEXGS_COLOR=: WHITE
LINEGS_COLOR=: GRAY
GS_VIEWXYZ=: 0 0 4
bucky''

NB. =========================================================
paint=: 3 : 0
gsinit''
hex=. ; ,each HEX

gsnewlist SPHERE
gsdrawpolygon PEN;'';PENCOLOR
gsdrawpolygon hex;'';HEXGS_COLOR
gsdrawlines hex;2;LINEGS_COLOR
gsendlist''

gsnewlist HALF
SPHERE make_vertices ICOSA
gsendlist''

HALF make_halves 0 1
gsfini''
)
