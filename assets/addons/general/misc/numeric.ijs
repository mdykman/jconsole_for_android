NB. general/misc/numeric.ijs
NB. Various numeric utilities
NB. version: 1.0.0
NB.
NB.  baserep        y in base x
NB.  clean          clean y to tolerance of x (default 1e_10)
NB.  colsum         sum data columns of matrix by key
NB.  groupndx       group indices of y in x
NB.  int01          interval in n steps from 0 to 1 (= steps 0 1,n)
NB.  linsert        linear insert x (default 2) steps into y
NB.  randomize      sets a random value into random link
NB.  range          range from a to b [in steps of c]
NB.  recur          solves recurrence r(i)=a(i)+r(i-1)*m(i-1)
NB.  round          round y to nearest x (e.g. 1000 round 12345)
NB.  roundbanker    round y to nearest x with bankers rounding
NB.  rounddist      round y to nearest x preserving total
NB.  rounddown      round y down to nearest x
NB.  roundint       round to nearest integer
NB.  roundup        round y up to nearest x
NB.  steps          steps from a to b in c steps

cocurrent 'z'

NB.*baserep v y in base x
baserep=: (&#.) (^:_1)

NB.*int01 v interval in n steps from 0 to 1 (= steps 0 1,n)
int01=: i.@(+ *) % |

NB.*linsert v linear insert x (default 2) steps into y
linsert=: 2&$: : ([: +/\ {.@] , [ # (}. - }:)@] % [)

NB.*round v round y to nearest x (e.g. 1000 round 12345)
round=: [ * [: <. 0.5 + %~

NB.*rounddown v round y down to nearest x (e.g. 1000 round 12345)
rounddown=: [ * [: <. %~

NB.*roundint v round to nearest integer
roundint=: <.@:+&0.5

NB.*roundup v round y up to nearest x (e.g. 1000 round 12345)
roundup=: [ * [: >. %~

NB. =========================================================
NB.*clean v clean y to tolerance of x (default 1e_10)
NB. form: tolerance (default 1e_10) clean numbers
NB. sets values less than tolerance to 0
clean=: 1e_10&$: : (4 : 0)
if. L. y do.
  x clean each y
else.
  if. (3!:0 y) e. 16 16384 do.
    j./"1 y * x <: | y=. +.y
  else.
    y * x <: |y
  end.
end.
)

NB. =========================================================
NB.*colsum v sum data columns of matrix by key
NB. form: key colsum mat
NB. sum data columns of matrix on key columns
NB. e.g. if column 2 of mat is age, then
NB.    2 colsum mat
NB. sums the remaining columns by age
colsum=: 4 : 0
nub=. ~. key=. x{"1 y
nub /:~ nub x}"_1 1 key +//. y
)

NB. =========================================================
NB.*groupndx v group indices of y in x
NB. Return group indices of elements of y
NB. x is an integer vector of the starting numbers of each group,
NB. assumed to be in ascending order.
NB. e.g.  0 0 0 1 1 1 2 2  =  0 3 6 groupndx i.8
NB. i.e.  <:@(+/@(<:/))
NB. groupndx=: 4 : '<: (#x) }. (+/\r<#x) /: r=. /: x,y'
groupndx=: [: <: I. + e.~

NB. =========================================================
NB.*randomize v sets a random value into random link
randomize=: 3 : 0
 try.
   require 'guid'
   tmp=. _2 (3!:4) , guids 1
 catch.             NB. general/misc/guid.ijs not available
   tmp=. >:<.0.8*0 60 60 24 31#.0 0 0 0 _1+|.<.}.6!:0 ''
 end.
 ([ 9!:1) {.^:(2~:9!:42'') tmp    NB. set random initial random seed
)

NB. =========================================================
NB.*range v range from a to b [in steps of c]
NB. range a,b[,c] = range from a to b [in steps of c]
range=: 3 : 0
'x y n'=. 3{.y,1
s=. _1^y<x
x+s*n*i.>:<.n%~|y-x
)

NB. =========================================================
NB.*recur v solves recurrence r(i)=a(i)+r(i-1)*m(i-1)
NB. form: r = m recur a
NB.   r(0) = a(0)
NB.   r(i) = a(i)+r(i-1)*m(i-1)
NB. e.g    1.05 1.10 recur 100 100 100
NB.     100 205 325.5
recur=: 4 : 'r*+/\y%r=.*/\1,x$~<:#y'

NB. =========================================================
NB.*roundbanker v round y to nearest x with bankers rounding
NB.
NB. round y to nearest x
NB.
NB. if y is a mid point, it is rounded up if even, down if odd
NB.
NB.    0.1 roundbanker 1.23 2.15 2.25 2.35 2.45
NB. 1.2 2.2 2.2 2.4 2.4
roundbanker=: 4 : 0
rd=. <. d=. 0.5 + y % x
x * rd - (rd = d) > 0 = 2 | d
)

NB. =========================================================
NB.*rounddist v round y to nearest x preserving total
NB. distributive rounding
NB.
NB. round y to nearest x preserving total to nearest x
NB.
NB. e.g.
NB.    0.1 rounddist 6$0.45
NB. 0.5 0.4 0.5 0.4 0.5 0.4
rounddist=: 4 : 0
($y) $ x * (- 0 , }:) <. 0.5 + +/\ y % x
)

NB. =========================================================
NB.*steps v steps from a to b in c steps
NB. form: steps a,b,c
steps=: {. + (1&{ - {.) * (i.@>: % ])@{:
