NB. demo - Blank Timer Test

require '~user/animate/anim.ijs'
coclass 'panimtest'
coinsert 'panim'

create=: create_panim_ f.

setup=: 3 : 0
  setup_panim_ f. ''
  TITLE=: 'Blank Timer Test'
  MIN=: 30
  MAX=: 60
  STEP=: 35
  DELAY=: 150
  RUN=: 0
)

step=: 3 : 0
  step_panim_ f. y
  NB.  do stuff''
)

0 : 0
a=: '' conew 'panimtest'
go__a''
go__a^:10''
step__a 5
)
