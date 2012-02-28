NB. demo - OpenGL

NB. Based on "[Jprogramming] opengl" posts circa Feb 06, 2006
NB. from Brian Schott, Chris Burke and Eric Iverson

require 'opengl ~user/animate/anim.ijs'
coclass 'pgl3test'
coinsert 'jgl2 jzopenglutil panim'

create=: 3 : 0
  create_panim_ f. 1
)

destroy=: 3 : 0
  destroy__ogl''
  ogl=: ''
  destroy_panim_ f. ''
)

gsetdefaults''

GS_AMBIENT=: 0.15
GS_DIFFUSE=: 0.7
GS_SPECULAR=: 0.7
GS_ROTXYZ=: 45 60 0

setup=: 3 : 0
  setup_panim_ f. ''
  ogl=: '' conew 'jzopengl'
  
  TITLE=: 'Test'
  MIN=: 0
  MAX=: 90
  DELAY=: 150
  RUN=: 0
)

step=: 3 : 0
  step_panim_ f. y
  GS_ROTXYZ=: 360 | 2 3 5*STEP
  gsinit GS_LIGHT
  1.4 gsdrawcube SKYBLUE
  gsfini''
)

0 : 0 NB. =========================================================
a=: '' conew 'pgl3test'
go__a''
go__a^:10''
step__a 5
)
