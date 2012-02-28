NB. demo - Spirals

require 'isigraph numeric trig ~user/animate/anim.ijs'
coclass 'pshapes1'
coinsert 'jgl2 panim'

create=: create_panim_ f.

setup=: 3 : 0
  setup_panim_ f. ''
  TITLE=: 'Spirals'
  MIN=: 0
  MAX=: 32

  OVER=: 1

  CLEARCLR=: 0 128 255
  CLR=: 0 204 204
)


step=: 3 : 0
  step_panim_ f. y
  glclear ''

  ST=. 0.085 + 0.2*|0.5-STEP%MAX
  LEN=. 40  NB. <.5+10*1-|0.5-STEP (|~ % ]) MAX%2

  w=. 1000%~glqwh ''
  step=. ST&* @ (1&|.) + (1-ST)&*
  a=. (-(tand 30),1), 0 ,: (tand 30),_1
  tri=. step ^: (i.LEN) a
  rot=. +/ . * & ( ((cosd,-@sind),:sind,cosd) 60)
  dat=. rot ^: 0 2 4 tri
  dat=. dat, rot ^: 1 3 5 tri*"1 [ _1 1 ^ OVER
  dat=. ,"2 ,/ dat
  clr=. ((_2 }. (int01 -LEN)^3) */ CLR) , CLEARCLR

  gclear CLEARCLR
  ((($dat)$w)* gscale dat) (gpolygon@[ gbrush)"1 (#dat)$clr
  glpaint''
)


0 : 0 NB. =========================================================
a=: '' conew 'pshapes1'
go__a''
go__a^:10''
step__a 5
)
