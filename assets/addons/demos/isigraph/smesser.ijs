NB. screen messer

COUNT=: 0
SIZE=: 40 40
DIR=: 1 1
MAX=: 1000-SIZE
POS=: ?MAX
COLORS=: ?500 3$255

NB. =========================================================
smupdate=: 3 : 0
w=. 2 3{GSIZE%1000
COUNT=: >:COUNT
POS=: POS+DIR*?40 36
DIR=: DIR*_1^(POS<0)+.MAX<POS
POS=: POS+(+: 0>.-POS)-+:0>.POS-MAX
glbrush glrgb (?500){COLORS
glellipse (POS*($POS)$w),SIZE
glpaint''
)

NB. =========================================================
smesser=: 3 : 0
gback 255 255 255
while. COUNT<2000 do.
  try. smupdate''
  catch. break.
  end.
end.
)

smesser''
