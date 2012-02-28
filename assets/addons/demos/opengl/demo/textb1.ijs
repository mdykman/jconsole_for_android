NB. texture basic demo with bitmap
NB.
NB. the J bitmap is read from file, and
NB. set as a texture for a gscube face.

CLR=: gsrgba BLUE,:WHITE
PATTERN=: CLR {~ 0 < readbmp jpath '~addons/demos/opengl/demo/jbw.bmp'

GS_CLEARCOLOR=: GRAY
GS_COLOR=: 0 0.75 0.75
GS_ROTXYZ=: 25 25 0
GS_VIEWXYZ=: 0 0 7

paint=: 3 : 0
gsinit GS_LIGHT
gsgentexture2D PATTERN
bcube ''
jface ''
gsfini''
)

jface=: 3 : 0
glBegin GL_QUADS
glNormal 0 0 1
glTexCoord 0 0 0 1
glVertex _1 1 1
glTexCoord 0 1 0 1
glVertex _1 _1 1
glTexCoord 1 1 0 1
glVertex 1 _1 1
glTexCoord 1 0 0 1
glVertex 1 1 1
glEnd''
)

bcube=: 3 : 0
a=. 1 1 0 1 1 1#gscubeface ''
a=. (% |@{.@,) a
a=. (; gsunitnormal) a
glPushAttrib GL_ENABLE_BIT
glDisable GL_TEXTURE_2D
gsdrawsolid a,<GS_COLOR
glPopAttrib ''
)
