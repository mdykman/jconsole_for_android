NB. demo - Plot Wire

require 'plot ~user/animate/anim.ijs'
coclass 'pplotwire'
coinsert 'jgl2 panim'

turn=: +/ . * ((cos , sin) ,: -@sin , cos)

create=: create_panim_ f.

setup=: 3 : 0
  setup_panim_ f. ''
  TITLE=: 'Plot Wire'
  MIN=: 0
  MAX=: 40
  p=: conew 'jzplot'
  PForm__p=: 'f'
  PFormhwnd__p=: HWND
  PId__p=: 'g'

)

step=: 3 : 0
  step_panim_ f. y
  X=. (MAX%~MAX-STEP*2)*| steps _8 8 30
  d=. % + 0: = ]
  X=. (sin d ]) (+/&.*:)/~X

  pd__p 'reset'
  pd__p 'boxed 0'
  pd__p 'type wire'
  pd__p 'backcolor darkgray'
  pd__p 'bandcolor white'
  pd__p 'viewpoint 2.5 3 0.75'
  pd__p X
  isi_show__p 0
)

f_g_size=: 3 : 0
  step STEP
)

0 : 0 NB. =========================================================
a=: '' conew 'pplotwire'
)
