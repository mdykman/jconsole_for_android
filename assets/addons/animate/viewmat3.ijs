NB. demo - Viewmat IFS

require 'viewmat ~user/animate/anim.ijs'
coclass 'pviewmat3'
coinsert 'jgl2 panim'

create=: create_panim_ f.

setup=: 3 : 0
  setup_panim_ f. ''
  TITLE=: 'Viewmat IFS'
  MIN=: 0
  MAX=: 23
)

f1=: +/ . * |:
f2=: >: @ (4&*)
f3=: (*/ . + |:) @ (6&+)
f4=: (*./ . + |:) @ (3&+)
f5=: (+/ . * |:) @: >:

step=: 3 : 0
  step_panim_ f. y
  viewmatcc_jviewmat_ 'g';~f1 #: i. 96+4*MAX-STEP
  glpaint''
)


0 : 0 NB. =========================================================
a=: '' conew 'pviewmat3'
go__a''
go__a^:10''
step__a 5
)
