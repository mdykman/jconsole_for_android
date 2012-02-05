NB. =======================================================
NB. stats/distribs/normal
NB. Functions for working with the Normal distribution
NB. These functions provide information about the 
NB. normal distribution for mean mu and standard deviation sigma.
NB. If mu or sigma are not specified they assume the 
NB. default values of 0 and 1 respectively.
NB.
NB. Ewart Shaw (Vector 18(4) and elsewhere), Fraser Jackson, 
NB. Ric Sherlock, Brian Schott, Devon McCormick, Roger Hui, 
NB. Zsban Ambrus and others (through the jprogramming forum) 
NB. contributed functions or concepts used in this script.)

coclass 'pdistribs'
NB. =========================================================
NB. Utilities

NB.*tomusigma v Converts from N[0,1] to N[mu,sigma]
NB. returns: rescaled numeric array adjusted by mean mu & 
NB.          stddev sigma
NB. y is: numeric array
NB. x is: 2-item numeric list
NB.     0{x desired mean adjustment for array
NB.     1{x desired stddev adjustment for array
tomusigma=: 4 : 0
  'mu sigma'=. x
  mu + sigma*y
)

NB.*tostd v Converts from N[mu,sigma] to N[0,1]
NB. returns: rescaled numeric array adjusted for mean mu & 
NB.          stddev sigma
NB. y is: numeric array
NB. x is: 2-item numeric list
NB.    0{x mean to adjust for
NB.    1{x stddev to adjust for
tostd=: 4 : 0
  'mu sigma'=. x
  (y-mu)%sigma
)

NB. runif01 v Uniform random deviates
runif01=: ?@$0:

NB. ---------------------------------------------------------
NB. Utils & Coefficients for qnorm01

NB. vftxt v numeric vector from text
vftxt=. 0". ];._2

NB. ratpoly c rational polynomial approximation
ratpoly=. 2 : 'm&p. % (1,n)&p.'

SPLIT1=: 0.425 [ SPLIT2=: 5.0
CONST1=. 0.180625 [ CONST2=. 1.6

NB. Coefficients for P close to 0.5
A=. vftxt 0 : 0
3.3871328727963666080
1.3314166789178437745e2
1.9715909503065514427e3
1.3731693765509461125e4
4.5921953931549871457e4
6.7265770927008700853e4
3.3430575583588128105e4
2.5090809287301226727e3
)

B=. vftxt 0 : 0
4.2313330701600911252e1
6.8718700749205790830e2
5.3941960214247511077e3
2.1213794301586595867e4
3.9307895800092710610e4
2.8729085735721942674e4
5.2264952788528545610e3
)

ratAB=. A ratpoly B

NB. Coefficients for P not close to 0, 0.5 or 1.
C=. vftxt 0 : 0
1.42343711074968357734
4.63033784615654529590
5.76949722146069140550
3.64784832476320460504
1.27045825245236838258
2.41780725177450611770e_1
2.27238449892691845833e_2
7.74545014278341407640e_4
)

D=. vftxt 0 : 0
2.05319162663775882187
1.67638483018380384940
6.89767334985100004550e_1
1.48103976427480074590e_1
1.51986665636164571966e_2
5.47593808499534494600e_4
1.05075007164441684324e_9
)

ratCD=. C ratpoly D

NB. Coefficients for P near 0 or 1.
E=. vftxt 0 : 0
6.65790464350110377720
5.46378491116411436990
1.78482653991729133580
2.96560571828504891230e_1
2.65321895265761230930e_2
1.24266094738807843860e_3
2.71155556874348757815e_5
2.01033439929228813265e_7
)

F=. vftxt 0 : 0
5.99832206555887937690e_1
1.36929880922735805310e_1
1.48753612908506148525e_2
7.86869131145613259100e_4
1.84631831751005468180e_5
1.42151175831644588870e_7
2.04426310338993978564e_15
)

ratEF=. E ratpoly F

qfp=: -&0.5
r1fq=. CONST1 - *:
r2fp=: [: %:@:-@:^. ] <. -.

nd1=: (] * ratAB@r1fq)@qfp f.
nd2fr=: (ratCD@-&CONST2) f.
nd3fr=: (ratEF@-&SPLIT2) f.

NB. ndx v calculates qnorm01 based on numerical category of ys
ndx=: 3 : 0
  s=. ($y)$0
  msk=. (SPLIT1 < |@qfp) y               NB. is y pretty close to 0 or 1?
  s=. (nd1 (-.msk)#y) (I.-.msk)}s          NB. no
  st=. r2fp msk#y                          NB. yes pretty close
  msk2=. st > SPLIT2                     NB. is y really close to 0 or 1?
  st=. (nd2fr (-.msk2)#st) (I. -.msk2)}st  NB. no
  st=. (nd3fr    msk2 #st)   (I. msk2)}st  NB. yes very close
  st=. (st * *@qfp) msk#y
  s=. st (I. msk)}s
)
NB. =========================================================
NB. Standard Normal distribution

NB. dnorm01 v Standard Normal PDF
dnorm01=: (% %: 2p1) * ^@:(_0.5 * *:)

NB. erf v error function
NB. ref Abramovitz and Stegum 7.1.21 (right)
erf=: (*&(%:4p_1)%^@:*:)*[:1 H. 1.5*:

NB. erfc v complementary error function
erfc=: >:@-@erf  

NB. erfinv v inverse of error function
erfinv =: (0,%%:2) qnorm 0.5 + -:

NB. pnormh v Standard Normal CDF
NB. slower but more accurate than pnorm01_f
NB. ref Abramovitz and Stegum 26.2.29 (solved for P)
pnormh=: (-: @: >: @ erf @ (%&(%:2))) f.

NB. pnorm01 v Standard Normal CDF
NB. uses more accurate pnormh for y values between _7 & 7.
NB. uses pnorm01_f for values outside that range where pnormh
NB. becomes unstable.
pnorm01=: 3 : 0
  z=. ,y
  msk=. (_7&<: *. 7&>:) z     NB. between _7 & 7
  n=. pnormh msk#z
  z=. n (I. msk)}z
  n=. pnorm01_f (-.msk)#z
  z=. n (I. -.msk)}z
  ($y)$z
)

NB. pnorm01_f v Standard Normal CDF
NB. ref Abramovitz and Stegum 26.2.17
pnorm01_f=: 3 : 0
  t=. %>:0.2316419*|y
  c=. %%:o.2
  z=. c*^--:*:y
  p=. 0 0.319381530 _0.356563782 1.781477937 _1.821255978 1.330274429
  p=. p p. t
  msk=. y>0
  nr=. -. r=. z*p
  r=. msk } r,:nr  NB. in-place assignment
)

NB. qnorm01 v Inverse of Standard Normal CDF (Quantile function)
NB. Z is accurate to about 1 part in 10^16.
NB. ref ALGORITHM AS241  APPL. STATIST. (1988) VOL. 37, NO. 3
qnorm01=: 3 : 0
  z=. ,y
  msk=. (0&< *. 1&>) z     NB. between 0 & 1
  assert. msk +. z e. 0 1  NB. y outside meaningful bounds
  z=. __ (I. z=0)} z
  z=. _ (I. z=1)} z
  n=. ndx msk#z
  z=. n (I. msk)}z         NB. amend values to z
  ($y)$z
)

NB. BM v Box-Mueller
BM=. ((2 1 o."0 1 (2p1) * runif01) *"1 [: %: _2&*@:^.@:runif01)

NB. rnorm01 v Random deviates from Standard Normal
NB. y is: shape of desired result array
rnorm01=: ] $ ,@BM@>.@-:@(*/) f.
NB. =========================================================
NB. General Normal distribution

NB.*dnorm v Normal probability density function
NB. returns: values (heights) of Normal PDF at y
NB. eg: 0.241971 = dnorm 1  and  0.241971 = 2 1 dnorm 3
NB. y is: numeric array of values to calculate Z(y) for.
NB. x is: optional 2-item numeric list (default is 0 1)
NB.    0{x is mean of popln from which y values were taken
NB.    1{x is stddev of popln from which y values were taken
dnorm=: 3 : 0
  dnorm01 y
  :
  (dnorm x tostd y) % {:x
)

NB.*pnorm v Normal cumulative distribution function
NB. returns: probability of value occuring below each y value
NB. eg: 0 = pnorm __   and 0.5 = pnorm 0
NB. y is: numeric array of values to calculate P(y) for.
NB. x is: optional 2-item numeric list (default is 0 1)
NB.    0{x is mean of popln from which y values were taken
NB.    1{x is stddev of popln from which y values were taken
NB. slower but more accurate than pnorm_f
pnorm=: 3 : 0
  pnorm01 y
  :
  pnorm x tostd y
)

NB.*pnorm_f v Normal cumulative distribution function
NB. see pnorm
NB. faster than pnorm but less accurate
NB. max absolute error < 7.46e_8 for range (_5,5)
NB. < 0.2 percent relative error.
pnorm_f=: 3 : 0
  pnorm01_f y
  :
  pnorm_f x tostd y
)

NB.*pnorm_ut v Upper Tail version of pnorm
NB. see pnorm but returns probability of a 
NB.   value occuring *above* each y value
NB. eg: 1 = pnorm_ut __ and 0.5 = pnorm_ut 0
pnorm_ut=: [: -. pnorm

NB.*qnorm v Quantile function for Normal distribution
NB. inverse of Normal CDF (pnorm)
NB. returns: values below which the probability of a value occuring are y
NB. eg: __ = qnorm 0  and  0 = qnorm 0.5
NB. y is: numeric array of probabilities from 0 to 1
NB. x is: optional 2-item numeric list (defaults to 0 1)
NB.     0{x desired mean of popln for results
NB.     1{x desired stddev of popln for results
qnorm=: 3 : 0
  qnorm01 y
  :
  x tomusigma qnorm y
)

NB.*qnorm_ut v Upper Tail version of qnorm
NB. see qnorm but returns values *above* which the probability of a value occuring are y
qnorm_ut=: [: - qnorm

NB.*rnorm v Generates random deviates from Normal distribution
NB. returns: shape y array of random deviates from normal distribution with mean & stddev x
NB. eg: 3 = $23.5 4.2 rnorm 3
NB. y is: numeric list specifying shape of result
NB. x is: optional 2-item numeric list (defaults to 0 1)
NB.     0{x desired mean of popln for results
NB.     1{x desired stddev of popln for results
rnorm=: 3 : 0
  rnorm01 y
  :
  x tomusigma rnorm y
)
NB. =========================================================
NB. Export to z locale

dnorm_z_=: dnorm_pdistribs_
pnorm_f_z_=: pnorm_f_pdistribs_
pnorm_z_=: pnorm_pdistribs_
pnorm_ut_z_=: pnorm_ut_pdistribs_
qnorm_z_=: qnorm_pdistribs_
qnorm_ut_z_=: qnorm_ut_pdistribs_
rnorm_z_=: rnorm_pdistribs_
tomusigma_z_=: tomusigma_pdistribs_
tostd_z_=: tostd_pdistribs_
