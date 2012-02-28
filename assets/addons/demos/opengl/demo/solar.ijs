NB. solar system

xyz=: (cos,0:,sin) @ rfd

GS_CLEARCOLOR=: 0 0 0
RUNLENGTH=: 400
RUNDELAY=: 1 NB. milliseconds

GS_PERSPECTIVE=: 45 1 1 30
LEarthRAD=: 2.5
LEarthROT=: 2
LEarthXYZS=: -LEarthRAD * xyz"0 LEarthROT * i.RUNLENGTH
LEarthXYZ=: {:LEarthXYZS
LMoonRAD=: 0.75
LMoonROT=: 5
LMoonXYZS=: LMoonRAD * xyz"0 LMoonROT * i.RUNLENGTH
LMoonXYZ=: {:LMoonXYZS

NB. =========================================================
paint=: 3 : 0
gsinit''
LQuad=: {.>gluNewQuadric''
solarlight''
sun''
earth''
gluDeleteQuadric LQuad
gsfini''
)

NB. =========================================================
sun=: 3 : 0
gscolor YELLOW
gluSphere LQuad,0.4 30 30
)

NB. =========================================================
earth=: 3 : 0
glPushMatrix''
glRotate _5 0 0 1
glTranslate LEarthXYZ
gscolor BLUE
gluSphere LQuad,0.25 20 20
moon''
glPopMatrix''
)

NB. =========================================================
moon=: 3 : 0
glPushMatrix''
glRotate 30 0 0 1
glTranslate LMoonXYZ
gscolor GRAY
gluSphere LQuad,0.1 20 20
glPopMatrix''
)

NB. =========================================================
solarlight=: 3 : 0
glaLight GL_LIGHT0, GL_AMBIENT, 0.15 0.15 0.15 1
glaLight GL_LIGHT0, GL_DIFFUSE, 0.7 0.7 0.7 1
glaLight GL_LIGHT0, GL_SPECULAR, 0.3 0.3 0.3 1
glEnable GL_LIGHTING
glEnable GL_LIGHT0
glEnable GL_COLOR_MATERIAL
glColorMaterial GL_FRONT_AND_BACK,GL_AMBIENT_AND_DIFFUSE
glaMaterial GL_FRONT_AND_BACK,GL_SPECULAR, 1 1 1 1
glaMaterial GL_FRONT_AND_BACK,GL_SHININESS, 100 0 0 1
)

NB. =========================================================
solarstep=: 3 : 0
glpaint_jgl2_''
if. RUNLENGTH do.
  RUNLENGTH=: <:RUNLENGTH
  LEarthXYZ=: RUNLENGTH{LEarthXYZS
  LMoonXYZ=: RUNLENGTH{LMoonXYZS
  1
else.
 RUNID2=: 0
 0
end.
)

RUNID2=: g_timeout_add_full G_PRIORITY_DEFAULT_IDLE;RUNDELAY;cb1;(cbreg 'solarstep','_',(>coname''),'_');0
