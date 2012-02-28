NB. J in a Box
NB.
NB. If FIXBOX is 1, the box is fixed while
NB. the J can move around.

NB. Use the J K L keyboard keys to move it
NB. out of the box, and F4 to restore.

FIXBOX=: 1

INIROT=: 20 25 0
INIVIEW=: 0 0 2.5

GS_CLEARCOLOR=: 0.2 0 0.2

BOX=: 0.65 * 1 pick gscube''
GS_ROTXYZ=: INIROT
GS_VIEWXYZ=: INIVIEW

paint=: 3 : 0
gsinit GS_LIGHT
if. IFUNIX do.
  glaFont'serif 50 bold'
else.
  metrics=. ('Times New Roman';10;700) glaUseFontOutlines__ogl 74 1 74 0 0.3,WGL_FONT_POLYGONS
  'x y w h'=. 4{.,metrics
end.
OFF=: (-w+0.5*x),(-h-0.5*y),0.15
drawJ ''
drawBox ''
gsfini''
)

drawJ=: 3 : 0
glPushMatrix''
glTranslate OFF
gscolor LIMEGREEN
glaCallLists 'J'
glPopMatrix''
)

drawBox=: 3 : 0
if. FIXBOX do.
  glPushMatrix''
  glLoadIdentity''
  gluLookAt INIVIEW,0 0 0 0 1 0
  glRotate INIROT,.GS_ID3
end.
glPushAttrib GL_LIGHTING_BIT
glDisable GL_LIGHTING
gsdrawlines BOX;'';BLUE
glEnable GL_LIGHTING
glPopAttrib''
if. FIXBOX do. glPopMatrix'' end.
)

