NB. basic demo 3, with 2 objects
NB.
NB. use the i/o keys to move out so that
NB. both objects are fully visible

paint=: 3 : 0
gsinit''
gsdrawdodecahedron ''
glTranslate 1.5 0 0
gsdrawicosahedron''
gsfini''
)
