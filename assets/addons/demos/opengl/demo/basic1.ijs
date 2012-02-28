NB. basic demo - simple
NB.
NB. draws gsdodecahedron and viewing box
NB.
NB. see Help/Movement for movement options
NB.
NB. options can be set gsfirst
NB. for example try uncommenting the line:

NB.    GS_CLEARCOLOR=: WHITE

paint=: 3 : 0
gsinit''
gsdrawviewbox RED
gsdrawdodecahedron ''
gsfini''
)
