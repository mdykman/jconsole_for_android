NB. iterated function system

S=: 4

mid=. -: @ + "1
nor=. 1 _1&* @: |.
bump=. mid + (%:3r4)&* @ nor @: -
bump1=. [ bump mid
bump2=. mid bump ]
tri=. 0 0, 1000 0,: 500 866
segdiv=. [ , mid , bump1 , bump2 ,: mid
refine=. ,/ @ (] segdiv"1 (1&|.))

gclear 0 128 255
dat=. 0 >. 1000 <. refine ^:4 tri
dat=. ({."1 dat),.1000-{:"1 dat
dat=. dat *"1 [ 2 3{GSIZE%1000
YELLOW gpolygon ,dat
