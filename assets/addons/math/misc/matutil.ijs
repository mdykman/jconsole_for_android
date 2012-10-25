NB. math/misc/matutil
NB. Matrix utilities
NB. version: 1.0.0

NB. band          b band M = zero all but b band of M
NB. cond          condition number of matrix
NB. diag          diagonal of matrix
NB. invsut        invert square upper-triangular matrix
NB. minors        minors of matrix
NB.
NB. pivot         (r,c) pivot M       - pivot at row, column
NB. ppivot        (r,c) ppivot M      - partial pivot at row, column
NB.
NB. coldrop       cols coldrop M      - drop cols from M
NB. coltake       cols coltake M      - take cols from M
NB. rowdrop       rows rowdrop M      - drop rows from M
NB. rowdrop       rows rowtake M      - take rows from M
NB.
NB. rowswap       (i,j) rowswap M     - swap rows i and j
NB. rowscale      (i,n) rowscale M    - multiply row i by n
NB. rowshear      (i,j,n) rowshear M  - multiply row j by n and add to row i

require 'math/misc/mathutil'
require 'math/misc/makemat'

NB.*diag v Diagonal of matrix
diag=: (<0 1)&|:

NB.*invsut v Invert square upper-triangular matrix
invsut=: 128!:1

NB.*minors v minors of matrix
minors=: 1&(|:\.)"2^:2	

NB. =========================================================
NB.*band v b band M  - zero all but x bands of matrix y
NB. eg:
NB.     0 1 band 3 3$5
NB.  5 5 0
NB.  0 5 5
NB.  0 0 5
band=: ] * +./@((,@[ +"0 1 i.@#@]) =/ i.@#@])

NB.*cond v Condition number of matrix
NB. large when matrix is ill-conditioned
NB. eg: 480849 = cond hilbertmat 5
cond=: *&(+/&.(*:"_)@,) %.

NB. =========================================================

NB.*pivot v Pivot at row, column
NB. form: (row,col) pivot M
pivot=: 4 : 0
'r c'=. x
col=. c{"1 y
y - (col-r=i.#y) */ (r{y)%r{col
)

NB. ppivot v Partial pivot at row, column
NB. form: (row,col) ppivot M
NB. differences from pivot:
NB.   - the pivot element is left unchanged (pivot sets it to 1)
NB.   - only columns below the pivot element are modifed
ppivot=: 4 : 0
'r c'=. x
r1=. >:r
col=. c{"1 y
(r1{.y),(r1}.y)-(r1}.col) */ (r{y)%r{col
)

NB. =========================================================
NB. coldrop       cols coldrop M      - drop cols from M
NB. coltake       cols coltake M      - take cols from M
NB. rowdrop       rows rowdrop M      - drop rows from M
NB. rowdrop       rows rowtake M      - take rows from M

NB.*coldrop v Drop cols from M
NB. form: cols coldrop M
coldrop=: <@<@<@[ {"1 ]

NB.*coltake v Take cols from M
NB. form: cols coltake M
coltake=: {"1

NB.*rowdrop v Drop rows from M
NB. form: rows rowdrop M
rowdrop=: <@<@<@[ { ]

NB.*rowtake v Take rows from M
NB. form: rows rowtake M
rowtake=: {

NB. =========================================================

NB.*rowswap v Swap rows i and j
NB. form: (i,j) rowswap M
rowswap=: <@[ C. ]

NB.*rowscale v Multiply row i by n
NB. form: (i,n) rowscale M
NB. or: ({:@[ * {.@[ { ])`({.@[)`]}
rowscale=: 4 : 0
'i n'=. x
(n * i{y) i } y
)

NB.*rowshear v Multiply row j by n and add to row i
NB. form: (i,j,n) rowshear M
NB. or: (+/@(1&,@{:@[ * (}:@[) { ]))`({.@[)`]}
rowshear=: 4 : 0
'i j n'=. x
((i{y) + n * j{y) i } y
)
