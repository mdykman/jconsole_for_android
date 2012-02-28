NB. demo - Rotation

require 'gl2 trig ~user/animate/anim.ijs'
coclass 'pgl2test1'
coinsert 'jgl2 panim'

mp=: +/ . *
turn=: mp ((cos , sin) ,: -@sin , cos)

create=: create_panim_ f.

setup=: 3 : 0
  setup_panim_ f. ''
  TITLE=: 'Rotation'
  MIN=: 0
  MAX=: 30
)

step=: 3 : 0
  step_panim_ f. y
  glclear''
  glpen 3 0 [ glrgb 0 128 255
  P=. _1 _1 , 1 _1 , 1 1 , _1 1 ,: _1 _1
  P=. 120+80*,P turn STEP*12p1%360
  gllines P
  glpaint''
)


0 : 0 NB. =========================================================
a=: '' conew 'pgl2test1'
go__a''
go__a^:10''
step__a 5
)
