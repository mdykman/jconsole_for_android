NB. teapot
NB.
NB. The construction has four parts - zero
NB. out elements of VIEW to remove parts.
NB.
NB. Try uncommenting the GS_DISPLAYMODE assignments.
NB. Try uncommenting GS_COLOR=: RED assignment in demo
NB.
NB. Experiment with part definitions,
NB. e.g. add 10 to LID

NB. GS_DISPLAYMODE=: GLU_OUTLINE_PATCH
NB. GS_DISPLAYMODE=: GLU_OUTLINE_POLYGON

VIEW=: 1 1 1 1

GS_CLEARCOLOR=: SKYBLUE
GS_COLOR=: SPRINGGREEN
GS_ROTXYZ=: 290 0 _10
GS_TRNXYZ=: _0.1 _0.7 0

paint=: 3 : 0
if. gsinit GS_LIGHT do.
  gsnewlist 1
  scale=. 0.03
  4 3 gsdrawsurface (0{VIEW) # BODY*scale
  4 3 gsdrawsurface (1{VIEW) # LID*scale
  4 3 gsdrawsurface (2{VIEW) # HANDLE*scale
  4 3 gsdrawsurface (3{VIEW) # SPOUT*scale
  gsendlist ''
end.
glCallList 1
gsfini''
)

NB. =========================================================
BODY=: gssurfacerev gstonum 0 : 0
27 45
28 48
29 48
31 45
34 35
39 24
39 15
38  6
30  2
30  0
15  0
0   0
)

NB. =========================================================
LID=: gssurfacerev gstonum 0 : 0
 0 59
12 58
 0 54
 4 51
 8 48
26 48
26 45
26 44
)

NB. =========================================================
HANDLE=: gsmaketube gstonum 0 : 0
_35  8 _35 18 6
_46 11 _44 22 6
_55 21 _45 26 6
_57 32 _48 32 6
_56 40 _47 34 6
_41 45 _41 35 6
_28 43 _28 35 6
)

NB. =========================================================
SPOUT=: gsmaketube gstonum 0 : 0
34 27 34 11 10
38 27 39 12 9
40 28 43 14 9
43 29 50 21 8
47 36 56 34 7
49 40 57 38 6
51 44 60 42 6
53 46 64 45 6
)

