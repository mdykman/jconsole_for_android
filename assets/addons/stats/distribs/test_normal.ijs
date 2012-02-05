NB. Tests for stats/distribs/normal

Note 'To run all tests:'
  load 'stats/distribs/normal'
  load 'stats/distribs/test_normal'
)

require 'stats/base/univariate'

NB. make nouns for testing
  NB. from Handbook of Mathematical Functions by Abramowitz and Stegun, Table 26.1 and Table 7.1. 
   t26d1=: 0 0.5 0.9 1 1.34 1.96 2 2.58 3.25 4.45 5
  pt26d1=: 0.5 0.691462461274013 0.815939874653241 0.841344746068543 0.909877327535548 0.97500210485178 
  pt26d1=: pt26d1, 0.977249868051821 0.99505998424223 0.9994229750 0.9999957065 0.9999997133
  zt26d1=: 0.398942280401433 0.352065326764299 0.266085249898755 0.241970724519143 0.162555055225534 0.058440944333451
  zt26d1=: zt26d1,0.053990966513188 0.014305108994150 0.002029048057 0.00001999179671 0.00000148619515
  t7d1=: 0 0.8427007929 0.9953222650 0.9944262755

  musd=: 4 7 NB. mean & stddev of three poplns

NB. test verb here
test=: 3 : 0
  assert. 1e_9 > |zt26d1 - dnorm t26d1
  assert. 1e_9 > |zt26d1 - dnorm -t26d1
  assert. 1e_10 > |pt26d1 - pnorm t26d1
  assert. 1e_10 > |(-.pt26d1) - pnorm -t26d1

  assert. 1e_10 > |pt26d1 - pnorm01_pdistribs_ t26d1
  assert. 1e_7 > |pt26d1 - pnorm01_f_pdistribs_ t26d1
  assert. 1e_10 > | t7d1 - erf_pdistribs_ 0 1 2 1.96

  assert. 1e_10 > |(qnorm@pnorm - ]) t26d1

  assert. 0.02 >|0 1 - (mean , stddev) ,rnorm 3 10000

  NB. check general properties and inclusion of __ 0 1 _ in
  NB. array arguments.  Larger range than above.
  z =. (0.5 * i.13),_
  p =. 0.01 * i.101
  NB. test converstions
  assert.  z = 1 2 tostd 1 2 tomusigma z

  assert. (dnorm z) = dnorm -z
  assert. (dnorm __ 0 _) = 0 0.398942280401433 0
  assert. (pnorm z) = 1 - pnorm -z
  assert. (pnorm z) + pnorm_ut z
  assert. (qnorm p) =  - qnorm 1-p
  assert.  1e_7 > (}:z) - qnorm pnorm }:z
  assert.  1e_14 > p - pnorm qnorm p

  NB. check that shape of y is retained in results for dnorm, pnorm, qnorm
  assert. ($w) = $dnorm w =. 2 2 2 2 2$ z,-z
  assert. ($w) = $pnorm w 
  assert. ($w) = $qnorm w =. 2 5 11$p

  NB. check that $ of result = y for rnorm 
  assert. 3 10000 = $ rnorm 3 10000

  NB. test dyadic pnorm dnorm qnorm
  assert. (1 2 dnorm z) = 2 %~ dnorm 1 2 tostd z
  assert. (1 2 pnorm z) = pnorm 1 2 tostd z
  assert. (1 2 qnorm p) = 1 2 tomusigma qnorm p

  NB. test dyadic rnorm
  NB. take 20 samples of size 10000 from a population with mean & stddev of musd
  NB. calculate mean & stddev of each sample
  NB. check that means of means & stddevs differs from musd by less than 0.1
  assert. 0.1 >|musd - mean (mean , stddev)"1 (20#,:musd) rnorm"1 ] 10000

  NB. check that atomic y work.
  assert. _ = qnorm 1
  assert. __ = qnorm 0
  assert. 1 = pnorm _
  assert. 0 = pnorm __
  assert. 0 = dnorm __

  'stats/distribs/test_normal passed'
)

smoutput test''
