NB. demo - GL2 Test 2

require 'gl2 trig ~user/animate/anim.ijs'
coclass 'pgl2test2'
coinsert 'jgl2 panim'

mp=: +/ . *
turn=: mp~ ((cos , sin) ,: -@sin , cos)

create=: create_panim_ f.

setup=: 3 : 0
  setup_panim_ f. ''
  TITLE=: 'GL2 Test 2'
  MIN=: 0
  MAX=: 30
)

step=: 3 : 0
  step_panim_ f. y
  glclear''
  glpen 3 0 [ glrgb 0 128 255
  'x1 y1 x2 y2'=: 120+0.8*,(_100 _100,:100 100) turn STEP*12p1%360
  gllines x1,y1,x2,y1,x2,y2,x1,y2,x1,y1
  glpaint''
)


0 : 0 NB. =========================================================
a=: '' conew 'pgl2test2'
go__a''
go__a^:10''
step__a 5
)
