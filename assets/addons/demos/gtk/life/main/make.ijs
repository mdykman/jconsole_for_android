NB. make

NB. =========================================================
boardinit=: 3 : 0
INDEX=: buildneighbor BOARD
RECTS=: buildrect BOARD
)

NB. =========================================================
NB. buildlife
NB.
NB. build definition from *.lif file into a board
buildlife=: 3 : 0
if. L. y do.
  dat=. y
else.
  dat=. a: -.~ <;._2 (toJ y),LF
end.
dat=. ((<'#P') = 2 {.each dat) <;.1 dat
pos=. (<.-:BOARD) (+|.) ("1) 0 ". 2 }. &> {.&> dat
blk=. ('*'"_ = >) @ }. each dat
m=. BOARD $ 0
for_i. i. # pos do.
  m=. put m;(i{pos);i{blk
end.
)

NB. =========================================================
NB. buildneighbor
NB.
NB. build neighbor index array
buildneighbor=: 3 : 0
m=. i. y
m=. ({:m),m,{.m
m=. ({:"1 m),.m,.{."1 m
m=. ,/ 3 [\"1 m
c2=. +: c=. {:y
((-c2) }. m) ,. (c }. (-c) }. m) ,. c2 }. m
)

NB. =========================================================
NB. buildrect
buildrect=: 3 : 0
'r c'=. y
ndx=. ((r*c) $ i. c),.c # i. r
SCALE * ndx ,"1 [ 1 1
)

NB. =========================================================
NB. build life table
buildtrans=: 3 : 0
tab=. #: i. 2 ^ 9
cnt=. +/"1 tab
ctr=. 4 {"1 tab
new=. (ctr=0) *. cnt = 3
old=. (ctr=1) *. cnt e. 3 4
new +. old
)

