NB. spinner.ijs   - isigraph demo

rot=. 1r36p1 & rotate
start=. polygon 5
turns=: 500

dat=. ,"2 roundint gscale rot^: (i.turns) start

gopen''
gclear''
gbrush 255 0 0

3 : 0 ] dat
dat=. y
while. #dat do.
  glpaint glpolygon {.dat
  dat=. }.dat
end.
)
