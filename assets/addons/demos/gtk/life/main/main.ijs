NB. life

NB. =========================================================
life=: 3 : 0
whilst. RUN | COUNT do.
  buffer''
  step''
  glsel locGB
  paint''
  glpaintx''
end.
1
)

NB. =========================================================
NB. first called in windowfinish
paint=: 3 : 0
glrgb BOARDCOLOR
glbrush''
glrect 0 0,SCALE*|.BOARD
glrgb CELLCOLOR
glbrush''
glpen 1 0
if. SCALE > 1 do.
  glrect STATE#RECTS
else.
  glpixel 2 {."1 STATE#RECTS
end.
setlabel labCount;":COUNT
enableback HASBUF
if. COUNT >: MAXITER do.
  lifetimer 0 return.
end.
)

NB. =========================================================
NB. step - single step of life
step=: 3 : 0
STATE=: TRANS {~ #. INDEX { STATE
COUNT=: >: COUNT
)
