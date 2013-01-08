NB. stats/base/distribution
NB. Statistical distributions

NB. discrete:
NB. binomialdist v  discrete values for binomial distribution
NB. binomialprob v  probability of success in binomial distribution
NB. poissondist v   discrete values for poisson distribution
NB. poissonprob v   probability of success in poisson distribution
NB.
NB. continuous:
NB. chisqcdf v      chi squared CDF
NB. normalcdf v     normal distribution (0,1) CDF
NB. normalprob v    probability of success in normal distribution

cocurrent 'z'

NB. =========================================================
NB.*binomialdist v discrete values for binomial distribution
NB. y has 2 elements p,n:
NB.  0  =  probability of success in one trial
NB.  1  =  number of trials
NB.
NB. E=n*p, var=n*p*-.p
NB.
NB. e.g.  binomialdist 0.25 5  ...distribution of results from 0 to 5
binomialdist=: 3 : 0
'p n'=. y
if. b=. p<:0.5 do. p=. -. p end.
q=. -.p
r=. }.i.>:n
r=. (q^n)**/\1,(p%q)*(>:n-r)%r
if. b do. |. r end.
)

NB. =========================================================
NB.*binomialprob v probability of success in binomial distribution
NB. y has 3 or 4 elements:
NB.   0  =  probability of success in one trial
NB.   1  =  number of trials
NB.   2  =  minimum number of successes
NB.  {3} =  maximum number of successes
NB.
NB. e.g.  binomialprob 0.25 100 30 40    ...probability that there are
NB. between 30 and 40 successes in 100 trials, where probability = 0.25
binomialprob=: 3 : 0
'p n s'=. 3{.y
m=. >:3{y,n
+/ s}.m{.binomialdist p,n
)

NB. =========================================================
NB.*chisqcdf v  chi squared CDF
NB. chi squared cumulative distribution function
NB. see wiki Essays/Chi_Squared_CDF
gamma=. ! & <:
ig0=. 4 : '(1 H. (1+x) % x&((* ^) * (^ -)~)) y'
incgam=. ig0 % gamma@[  NB. incomplete gamma
chisqcdf=: incgam&-: f.

NB. =========================================================
NB.*normalcdf  v normal distribution (0,1) CDF
NB. normal(0,1) cumulative distribution function
NB. see wiki Essays/Normal_CDF
NB.
NB. the following are equivalent, but normalcdf more accurate:
NB.   normalcdf X
NB.   1 - normalprob 0 1, X
erf=. (1 H. 1.5)@*: * 2p_0.5&* % ^@:*:
normalcdf=: -: @ >: @ erf @ %&(%:2) f.

NB. =========================================================
NB.*normalprob v probability of success in normal distribution
NB. y has 3 or 4 elements:
NB.   0  =  mean of distribution
NB.   1  =  standard deviation
NB.   2  =  minimum result
NB.  {3} =  maximum result
NB.
NB. e.g.  normalprob 0 1 2    ...probability that result will be
NB. greater than 2, where mean = 0, standard deviation 1
NB.
NB. Result is rounded to 7 decimal places
NB. Algorithm has accuracy ~ 7.5*1e_8
normalprob=: 3 : 0
'm s'=. 2{.y
x=. s %~ m -~ 2}.y
sgn=. *x
x=. |x
b=. 0.31938153 _0.356563782 1.781477937 _1.821255978 1.330274429
p=. 0.2316419
r=. ((2p1)^_0.5)*^_0.5**:x
r=. r*b+/ .**/\5#(1,#x)$%>:p*x
r=. -/|(sgn=_1)-r
(<.0.5+r*c)%c=. 1e7
)

NB. =========================================================
NB.*poissondist v discrete values for poisson distribution
NB. y has 2 elements:
NB.   0 = mean of distribution
NB.   1 = maximum value to show
NB.
NB. e.g.  poissondist 2 10
NB.       = list of probabilities of values from 0 to 10
NB.         in poisson distribution of mean 2
poissondist=: 3 : 0
'm n'=. y
(^-m)**/\1,m%}.i.>:n
)

NB. =========================================================
NB.*poissonprob v probability of success in poisson distribution
NB. y has 2 or 3 elements:
NB.  0   =  mean of distribution
NB.  1   =  minimum number of successes
NB.  {2} =  maximum number of successes
NB.
NB. e.g.
NB.   poissonprob 5 4 7    ...probability that result will be
NB.         between 4 and 7 inclusive, where mean result is 5.
NB.   poissonprob 5 6 6    ...probability that result will be
NB.         exactly 6, where mean result is 5.
poissonprob=: 3 : 0
m=. {.y
s=. }.y
b=. 1=#s
'x y'=. _2{.0,s-b
if. 0>y do. 1 return. end.
|b-(^-m)*+/x}.*/\1,m%}.i.>:y
)
