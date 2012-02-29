NB. =========================================================
NB. stats/distribs/uniform
NB. Functions for working with the Uniform distribution
NB. These functions provide information about the 
NB. uniform distribution on the interval from min to max. 
NB. If min or max are not specified they assume the 
NB. default values of 0 and 1 respectively. 

NB. An assertion error is returned where an argument or part
NB. of an argument is out of range. Otherwise results are 
NB. comparable to those for R.

coclass 'pdistribs'

NB. =========================================================
NB. Utils

NB. fromunif01 v Converts from U[0,1] to U[min,max]
fromunif01 =: 4 : 0
  'min max'=. x
  assert. min <: max
  min + (max-min) * y
)

NB. tounif01 v Converts from U[min,max] to U[0,1]
tounif01=: 4 : 0
  'min max'=. x
  assert. min <: max
  (y - min) % max-min
)

NB. =========================================================
NB. Standard Uniform distribution

NB. dunif01 v PDF for U[0,1]
dunif01=: 0&<: *. <:&1

NB. punif01 v CDF for U[0,1]
punif01=: 0&>.@:(<.&1)

NB. qunif01 v Inverse of CDF for U[0,1] (Quantile function)
qunif01=: 3 : 0
  assert. dunif01 y
  punif01 y
)

NB. runif01 v Random deviates from U[0,1]
NB. y is: shape of desired result array
runif01=: ?@$0:

NB. =========================================================
NB. General Uniform distribution

NB.*dunif v  Uniform probability density function
NB. returns: values (heights) of Uniform PDF at y
NB. eg: 1 = dunif 0.3   and  0 = 3 4 dunif 5.3
NB. y is: numeric array of values to calculate Z(y) for.
NB. x is: optional 2-item numeric list (default is 0 1)
NB.       0{x min value of popln from which y values were taken
NB.       1{x max value of popln from which y values were taken
NB. dunif is not defined if min >: max
dunif=: 3 : 0
  dunif01 y
  :
  'min max'=. x
  assert. min < max
  t=. dunif x tounif01 y
  t % max - min
)

NB.*punif v Uniform cumulative distribution function
NB. (Probability integral of uniform distribution)
NB. returns: probability of value occuring below each y value
NB. eg: 0 = punif 0   and 0.5 = 2 4 punif 3
NB. y is: numeric array of values to calculate P(y) for.
NB. x is: optional 2-item numeric list (default is 0 1)
NB.       0{x min value of popln from which y values were taken
NB.       1{x max value of popln from which y values were taken
NB. If min=max  For y<min  0=punif y  and  y>:min  1=punif y
punif =: 3 : 0
  punif01 y
  :
  punif x tounif01 y
)

NB.*qunif v Quantile function for uniform distribution
NB. Inverse of Uniform CDF (punif)
NB. returns: values below which the probability of a value occuring are y
NB. eg: 0 = qunif 0  and  0.5 = qunif 0.5
NB. y is: numeric array of probabilities from 0 to 1
NB. x is: optional 2-item numeric list (default is 0 1)
NB.       0{x min value of result popln
NB.       1{x max value of result popln
NB. qunif is only defined over the closed interval [0,1]
qunif=: 3 : 0
  qunif01 y
  :
  x fromunif01 qunif y
)

NB.*runif v Generates random deviates from uniform distribution
NB. returns: shape y array of random deviates from uniform distribution.
NB. eg: 3 = $4 7 runif 3
NB. y is: numeric list specifying shape of result
NB. x is: optional 2-item numeric list (default is 0 1)
NB.       0{x min value of result popln
NB.       1{x max value of result popln
NB. runif will not generate the extreme values in the monadic case
NB. In the dyadic case some generated values very close to 
NB. the extremes of the range may round to 0 or 1.
runif =: 3 : 0
  runif01 y
  :
  x fromunif01 runif y
)

NB. =========================================================
NB. Export to z
dunif_z_ =: dunif_pdistribs_
punif_z_ =: punif_pdistribs_
qunif_z_ =: qunif_pdistribs_
runif_z_ =: runif_pdistribs_
