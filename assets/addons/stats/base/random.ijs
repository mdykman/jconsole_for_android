NB. stats/base/random
NB. Random number generation

NB.*setrl v       set random link
NB.
NB.*rand01 v      generate y random numbers in interval (0,1)
NB.*rand11 v      generate y random numbers in interval (_1,1)
NB.*randomize v   sets a random value into random link
NB.
NB.*deal v        deal x items from y (no repetition)
NB.*dealx v       deal x indices from shape y (no repetition)
NB.*toss v        pick x items from y (with repetition)
NB.*tossx v       pick x indices from shape y (with repetition)
NB.
NB. betarand        v random numbers in a beta distribution
NB. binomialrand    v random numbers 0 and 1 in binomial distribution
NB. cauchyrand      v random numbers in a cauchy distribution
NB. discreterand    v random numbers in a discrete distribution
NB. exponentialrand v random numbers in an exponential distribution
NB. gammarand       v random numbers in a gamma distribution
NB. normalrand      v random numbers in a standard normal distribution,
NB. poissonrand     v random numbers in a poisson distribution
NB.
NB. note: y for deal is data
NB.       y for dealx is $data
NB.
NB. similarly for toss and tossx

NB. ---------------------------------------------------------
NB. examples:
NB.
NB.    p=. ;: 'anne dave mary tom'
NB.    words=: ;: inverse
NB.
NB.    words deal p
NB. mary anne dave tom
NB.
NB.    words 3 deal p
NB. tom dave mary
NB.
NB.    words 6 toss p
NB. mary mary dave dave mary tom
NB.
NB.    dealx 2 3
NB. 0 1
NB. 1 1
NB. 0 2
NB. 1 2
NB. 0 0
NB. 1 0
NB.
NB.    3 dealx 3 5 7
NB. 2 4 6
NB. 1 0 6
NB. 2 4 5
NB.
NB.    4 tossx 2 3
NB. 0 2
NB. 1 2
NB. 1 1
NB. 0 2

cocurrent 'z'

setrl=: 9!:1                NB. set random link

deal=: (# ? #) : (? #) { ]  NB. deal x items from y (no repetition)
dealx=: ] #: ?~ : ? & (*/)  NB. deal x items from shape y (no repetition)
toss=: ? @ (# #) { ]        NB. pick x items from y (with replacement)
tossx=: ] #: (?@# */)       NB. pick x items from shape y (with replacement)
rand01=: ?@$ 0:             NB. generate y random numbers in interval (0,1)
rand11=: <: @: +: @: rand01  NB. generate y random numbers in interval (_1,1)

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
NB.*betarand v random numbers in a beta distribution
NB. y has 3 elements p,q,n
NB.   0 = power parameter
NB.   1 = power parameter
NB.   2 = number of trials
betarand=: 3 : 0
'p q n'=. y
if. (1>p) *. 1>q do.
  b=. n#1
  r=. n#0
  whilst. 1 e. b do.
    m=. +/b
    x=. (rand01 m)^%p
    y=. x+(rand01 m)^%q
    t=. 1>:y
    z=. (t#x)%t#y
    i=. t#b#i.#b
    b=. 0 i } b
    r=. (z+i{r) i } r
  end.
else.
  s%(gammarand q,n)+s=. gammarand p,n
end.
)

NB. =========================================================
NB.*binomialrand v random numbers 0 and 1 in binomial distribution
NB.
NB. y has 2 elements:
NB.  0  =  probability of success in one trial
NB.  1  =  number of trials
binomialrand=: 3 : 0
'p n'=. y
r=. 2147483647
s=. <:p*r
s>?n#<:r
)

NB. =========================================================
NB.*cauchyrand v random numbers in a cauchy distribution
NB. with F(x)=0.5+(arctan x)%o.1
NB.
NB. y  =  number of trials
cauchyrand=: 3 : 0
3 o. o. _0.5+rand01 y
)

NB. =========================================================
NB.*discreterand v random numbers in a discrete distribution
NB. y has two elements
NB.   0 =  2-row matrix: 0 =  discrete values
NB.                      1 =  corresponding probabilities
NB.   1 =  number of trials
discreterand=: 3 : 0
'm n'=. y
'v p'=. m
f=. 0,+/\p%+/p
l=. #f
r=. /:f,rand01 n
s=. +/\l>r
r=. s r } r
v {~ <:l}.r
)

NB. =========================================================
NB.*exponentialrand v random numbers in an exponential distribution
NB. with mean=1. F(x)=1-^-x
NB.
NB. y  =  number of trials
exponentialrand=: 3 : 0
-^.rand01 y
)

NB. =========================================================
NB.*gammarand v random numbers in a gamma distribution
NB. y has 2 elements p,n
NB.   0 = power parameter
NB.   1 = number of trials
NB.
NB. if p=1 this is the exponential distribution
gammarand=: 3 : 0
'p n'=. y
r=. n#0
k=. p-i=. <.p
if. k do.
  r=. betarand k,(-.k),n
  r=. r * -^.rand01 n
end.
if. i do.
  r-^.*/rand01 i,n
end.
)

NB. =========================================================
NB.*normalrand v random numbers in a standard normal distribution,
NB. with  mean=0, standard deviation=1.
NB. y  = number of trials.
normalrand=: 3 : 0
(2 o. +: o. rand01 y) * %: - +: ^. rand01 y
)

NB. =========================================================
NB.*poissonrand v random numbers in a poisson distribution
NB.
NB. y has 2 elements:
NB.   0  = mean of distribution (=variance)
NB.   1  = number of trials
poissonrand=: 3 : 0
'm n'=. y
roll=. -@^.@rand01
r=. b=. m >: t=. roll n
i=. i.n
while. #i=. b#i do.
  b=. m >: t=. (b#t) + roll #i
  r=. (b + i{r) i } r
end.
r
)
