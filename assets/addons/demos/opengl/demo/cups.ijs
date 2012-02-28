NB. cups surface - colored by height

j=. steps _2.4 2.4 35
f=. (5: * ] % ^@+&*:)"0/~
CUPS=: 1.4*gsfit11 gsmakexyz (];];f) j

j=. (1r4"_ ,. |. ,. ]) _2}.8}. gsint01 16
CUPCLR=: j gshue gsfit01 {:"1 CUPS

GS_ROTXYZ=: 285 0 335
GS_CLEARCOLOR=: IVORY

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsdrawsurface2 makelist 1 CUPS;CUPCLR
end.
glCallList 1
gsfini''
)

