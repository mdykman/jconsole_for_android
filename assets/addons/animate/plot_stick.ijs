NB. demo - Plot Stick

require 'plot ~user/animate/anim.ijs'
coclass 'pplotstick'
coinsert 'jgl2 panim'

turn=: +/ . * ((cos , sin) ,: -@sin , cos)

create=: create_panim_ f.

setup=: 3 : 0
  setup_panim_ f. ''
  TITLE=: 'Plot Stick'
  MIN=: 0
  MAX=: 59
  p=: conew 'jzplot'
  PForm__p=: 'f'
  PFormhwnd__p=: HWND
  PId__p=: 'g'

)

step=: 3 : 0
  step_panim_ f. y
u=. steps 0 6.5 150
r=. sin steps (o. (,-.)0.1), <:#u
X=. r*cos u
Y=. r*(sin*cos) u
Z=. 0.1*u

pd__p 'reset'
pd__p 'type stick'
pd__p 'backcolor lightgray'
pd__p 'color darkblue'
pd__p 'viewpoint ',":1,~_1.5 1.5 turn STEP*12p1%360
pd__p 'viewsize 1 1 0.75'
pd__p X;Y;Z
isi_show__p 0
)

f_g_size=: 3 : 0
  step STEP
)

0 : 0 NB. =========================================================
a=: '' conew 'pplotstick'
go__a''
go__a^:10''
step__a 5
)
