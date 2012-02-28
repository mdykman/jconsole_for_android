NB. title - OpenGL Graphics

GS_CLEARCOLOR=: 0.2 0 0.2
GS_TRNXYZ=: _1.75 0.25 _3
GS_ROTXYZ=: 0 0 0
GS_VIEWXYZ=: 0 0 3

paint=: 3 : 0
gsinit GS_LIGHT
('arial';80;700;1) glaUseFontOutlines__ogl 32 95 32 0 0.3,WGL_FONT_POLYGONS
lighttext''
gscolor 3 1 # 0.5 1
glaCallLists TEXT1
glPushMatrix''
glTranslate _3.75 _1 0
glaCallLists TEXT2
glPopMatrix''
gsfini''
)

TEXT1=: 'OpenGL'
TEXT2=: 'Graphics'

lighttext=: 3 : 0
glaLight GL_LIGHT0, GL_AMBIENT, 0.6 0.6 0.6 1
glaLight GL_LIGHT0, GL_DIFFUSE, 0.9 0.9 1 1
glaLight GL_LIGHT0, GL_SPECULAR, 1 1 1 1
glaLight GL_LIGHT0, GL_POSITION, 1 1 1.1 1
glaMaterial GL_FRONT_AND_BACK,GL_SPECULAR, 1 1 1 1
glaMaterial GL_FRONT_AND_BACK,GL_SHININESS, 128 0 0 1
)

