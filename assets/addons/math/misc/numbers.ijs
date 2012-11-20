NB. math/misc/numbers
NB. Various number definitions (Stirling, Euler ...)
NB. version: 1.0.0

NB.  bell              Bell numbers
NB.  bernoulli         Bernoulli numbers
NB.  catalan           Catalan numbers
NB.  cycle             Stirling cycle numbers
NB.  cycles            Stirling cycle number table
NB.  euler             Euler numbers
NB.  eulers            Euler numbers table
NB.  fibonacci         Fibonacci numbers
NB.  lucas             Lucas numbers
NB.  subset            Stirling subset numbers
NB.  subsets           Stirling subset number table
NB.  tangent           tangent numbers

NB. =========================================================
NB.*bell v Number of ways of partitioning y things into subsets
bell=: 3 : 0
step=. (+/\) @ (,~ {:)
{. step ^: y 1x
)

NB.*bernoulli v Bernoulli numbers from 0 to y
NB. y is: a non-negative integer
bernoulli=: 3 : 0
t=. 1,}.}:tangent y
b=. _1,t*n*%(* <:)2x^n=. >:i.#t
b*(#b)$_1 _1 1 1
)

NB.*catalan v Catalan numbers
catalan=: (! +:) % >:

NB.*cycles v Table of Stirling cycle numbers (S1)
NB. y is: a non-negative integer
cycles=: 3 : 0
if. y=0 do. 1 1$1 return. end.
c,(0,~t*<:y) + 0,t=. {:c=. cycles <:y
)

NB.*cycle v Number of ways of partitioning n items into k cycles
NB. form: k cycle n  =  [n/k]
cycle=: 3 : 0
(i.>:>./y) cycle y
:
|:({y;x){ cycles >./y
)

NB.*eulers v Table of Eulerian numbers
NB. y is: a non-negative integer
eulers=: 3 : 0
if. y=0 do. 1 1$1 return. end.
s,(0,~t*i) + 0,(y-i=. >:i.y)*t=. {:s=. eulers <:y
)

NB.*euler v Number of permutations of size n with k ascents
NB. form: k euler n  =  <n/k>
euler=: 3 : 0
(i.>:>./y) euler y
:
|:({y;x){ eulers >./y
)

NB.*fermat v Fermat numbers
fermat=: 1 + 2 ^ 2 ^ x:

NB.*fibonacci v first y+1 Fibonacci numbers
fibonacci=: 3 : 'if. y do. (, +/@(_2&{.)) ^: (<:y) 0 1x else. 0 end.'

NB.*lucas v first y+1 Lucas numbers
lucas=: 3 : 'if. y do. (, +/@(_2&{.)) ^: (<:y) 2 1x else. 2 end.'

NB. table of first y+1 Fibonacci + Lucas numbers
NB. e.g. try
NB.   (i.@>: ,. fibonacci ,. lucas) 40
NB.   (fibonacci@+: =&{: fibonacci*lucas) 40

NB.*fibbinet v Calculates nth Fibonacci number using Binet formula
NB. but does not use extended precision (good to about fib 60)
fibbinet=: 3 : 0
p=. -: >: %: 5
(%:5) %~ (p^y) - (1-p)^y
)

NB.*subsets v Table of Stirling subset numbers (S2)
NB. y is: a non-negative integer
subsets=: 3 : 0
if. y=0 do. 1 1$1 return. end.
s,(0,~t*i.y) + 0,t=. {:s=. subsets <:y
)

NB.*subset v Number of ways of partitioning n items into k sets
NB. form: k subset n  =  {n/k}
subset=: 3 : 0
(i.>:>./y) subset y
:
|:({y;x){ subsets >./y
)

NB.*tangent v tangent numbers from 0 to y
NB. y is: a non-negative integer
NB. Tn+1(x)=(1+x^2)Tn'(x)
tangent=: 3 : 0
f=. [: +//. 1 0 1"_ */ [: }. [ * i.@#
{."1 f^:(i.>:y) 0 1x
)
