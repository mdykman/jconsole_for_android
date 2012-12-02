NB. Spirals
NB.
NB. try: OVER=: 1, and experiment with LEN and STEP

OVER=: 0
LEN=: 30
STEP=: 0.075

CLEARCLR=: 0 128 255
CLR=: 0 204 204

w=. 2 3{GSIZE%1000
step=. STEP&* @ (1&|.) + (1-STEP)&*
a=. (-(tand 30),1), 0 ,: (tand 30),_1
tri=. step ^: (i.LEN) a
rot=. +/ . * & ( ((cosd,-@sind),:sind,cosd) 60)
dat=. rot ^: 0 2 4 tri
dat=. dat, rot ^: 1 3 5 tri*"1 [ _1 1 ^ OVER
dat=. ,"2 ,/ dat
clr=. ((_2 }. (int01 -LEN)^3) */ CLR) , CLEARCLR

gclear CLEARCLR
((($dat)$w)* gscale dat) (gpolygon@[ gbrush)"1 (#dat)$clr
