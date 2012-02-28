NB. basic demo 2, with lighting
NB.
NB. experiment with GS_AMBIENT, GS_DIFFUSE, GS_SPECULAR
NB. (initially set to default values)
NB.
NB. try changing gsinit GS_LIGHT to gsinit ''

GS_AMBIENT=: 0.15
GS_DIFFUSE=: 0.7
GS_SPECULAR=: 0.7
GS_ROTXYZ=: 45 60 0

NB. =========================================================
paint=: 3 : 0
gsinit GS_LIGHT
1.4 gsdrawcube SKYBLUE
gsfini''
)
