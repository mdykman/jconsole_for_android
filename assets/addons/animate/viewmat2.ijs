NB. demo - Viewmat sin(y) + cos(a x)

require 'viewmat trig ~user/animate/anim.ijs'
coclass 'pviewmat2'
coinsert 'jgl2 panim'

create=: create_panim_ f.

setup=: 3 : 0
  setup_panim_ f. ''
  TITLE=: 'Viewmat sin(y) + cos(a x)'
  MIN=: 0
  MAX=: 30
)

step=: 3 : 0
  step_panim_ f. y
  par=. 1+4*|0.5-STEP%MAX
  viewmatcc_jviewmat_ 'g';~(sin@[ + cos@(par&*)@])"0/~(%~ i:) 40
  glpaint''
)


0 : 0 NB. =========================================================
a=: '' conew 'pviewmat2'
go__a''
go__a^:10''
step__a 5
)
