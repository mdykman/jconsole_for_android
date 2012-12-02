NB. iterated function systems   - isigraph demo
NB.
NB. square mapped to 3 smaller squares

SQUARE=: _1 _1 1,_1 1 1,1 1 1,:1 _1 1

w=. 2 3 { GSIZE%1000

bl=. _1 _1 1,_1 0 1,0 0 1,:0 _1 1   NB. bottom left
br=. _0 _1 1,0 0 1,1 0 1,:1 _1 1    NB. bottom right
tl=. _1 0 1,_1 1 1,0 1 1,:0 0 1     NB. top left

t0=. mp&(clean bl %. SQUARE)
t1=. mp&(clean br %. SQUARE)
t2=. mp&(clean tl %. SQUARE)
step=. t0`t1`t2`:0 "2

gback 255 255 255
gbrush 255 0 255
glpolygon ,"2 roundint w *"1 gscale }:"1 [ step ^: 7 SQUARE
