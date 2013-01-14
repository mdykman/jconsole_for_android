NB. util

EMPTY=: i. 0 0
HWNDP=: 0

finished=: info bind 'Game completed.'
unfinished=: info bind 'Game not yet completed.'
gethit=: 3 : 'POS inrect 2 {. 0 ". sysdata'
info=: wdinfo @ ('Nurikabe'&;)
ischar=: 3!:0 e. 2 131072"_
pathname=: 3 : '(b#y);(-.b=.+./\.y=PATHSEP_j_)#y'
query=: wdquery 'Nurikabe'&;
quote=: ''''&,@(,&'''')@(#~ >:@(=&''''))

NB. =========================================================
bufinit=: 3 : 0
BUF=: ,<BOARD
BUFPOS=: 0
)

NB. =========================================================
buffer=: 3 : 0
if. BUFPOS < <:#BUF do.
  BUF=: (BUFPOS+1) {. BUF
end.
new=. <BOARD
if. new -: {:BUF do. return. end.
BUFPOS=: #BUF
BUF=: BUF,new
EMPTY
)

NB. =========================================================
NB. 0=check when draw
NB. 1=check from button
checkdone=: 3 : 0
board=. SHAPE$BOARD
if. y do. board=. board >. _1 end.
try.
  check board
catch.
  0
end.
)

NB. =========================================================
NB. inrect v test rectangles for hit or _1 if none
NB. form: rect inrect pos
inrect=: 4 : 0
'px py'=. y
'x y w h'=. |: x
msk=. (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
(ndx<#msk){_1,ndx=. msk i. 1
)
