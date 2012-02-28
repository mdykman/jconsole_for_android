NB. basic demo 4 - movement keys
NB.
NB. viewbox in red
NB. positive viewbox in blue, xy plane is shown.
NB.
NB. initial axes (positive direction):
NB.   x points right
NB.   y points upwards
NB.   z points out of screen, towards user
NB.
NB. experiment with movement keys, use F4 to reset.
NB. see Help/Movement for description.

CUBEVERTEX=: _3 [\ ,(%{.@,) 1 pick gscube''
GS_CLEARCOLOR=: WHITE
GS_COLOR=: BLACK

paint=: 3 : 0
gsinit''
gsfontbmpw 'arial';16
demodrawing 0.75
demoposition''
gsfini''
)

demodrawing=: 3 : 0
glBegin GL_LINES
gscolor BLUE
glVertex y * 0.5+0.5*CUBEVERTEX
glEnd''
glBegin GL_LINES
gscolor RED
glVertex y * CUBEVERTEX
glEnd''
glBegin GL_POLYGON
gscolor BLUE
glVertex y * _3[\0 0 0 1 0 0 1 1 0 0 1 0
glEnd''
)

demoposition=: 3 : 0
gscolor 0 0 0 0
glLoadIdentity''
glTranslate 0 0 _0.01
glRasterPos _0.32 0.23 _1
glaCallLists 'GS_TRNXYZ: ',gstominus ":0.01 round GS_TRNXYZ
glRasterPos 0.07 0.23 _1
glaCallLists 'GS_SPEED: ',":GS_SPEED
glRasterPos _0.32 _0.22 _1
glaCallLists 'GS_VIEWXYZ: ',gstominus ":0.1 round GS_VIEWXYZ
glRasterPos _0.32 _0.25 _1
glaCallLists 'GS_VIEWUP:  ',":0.1 round GS_VIEWUP
glRasterPos 0.07 _0.22 _1
glaCallLists 'GS_ROTXYZ: ',":roundint GS_ROTXYZ
glRasterPos 0.07 _0.25 _1
glaCallLists 'GS_ROTNDX:  ',":GS_ROTNDX
)

