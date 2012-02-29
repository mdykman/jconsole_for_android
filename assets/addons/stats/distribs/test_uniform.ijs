NB.  Tests for stats/distribs/uniform

Note 'To run all tests:'
  load 'stats/distribs/uniform'
  load 'stats/distribs/test_uniform'
)

Note 'Uniform distribution'
We use a and b to denote the minimum and maximum bounds.

1.	The bounds must be finite
2.	Density defined over the real line.
3.	Density has uniform value over closed interval [a,b]
4.	dunif is not defined if a = b
5.	punif is defined over the real line
6.	If a=b  For x<a  0=punif x  and  x>:a  1=punif x
7.  qunif only defined over the closed interval [0,1]
8.	runif will not generate the extreme values in the
    monadic case.  In the dyadic case some values
    very close to the extremes of the range may round to
    zero or 1 or possibly outside the range but very
    close to the bounds.

The following test these conditions other than 8.
)

NB. nouns for testing
  v0=: 0.1*i.11
  v1=: 0.1*>:i.9
  
  v00=: 10 10 10 $ 0.1*i.11
  v10=: 10 10 10 $ 0.1*>:i.9

test_uniform=: 3 : 0
  NB.  tests of monadic form
  assert. 1 = dunif v00
  assert. 0 0 1 1 0 0 = dunif __ _1 0 1 1.1 _
  assert. v00 = punif v00
  assert. 0 0 0 1 1 1 = punif __ _1 0 1 1.1 _
  assert. v00 = qunif v00

  NB.  tests of dyadic form
  assert. 0.1 = 2 12 dunif 2+10*v1
  assert. 0 0 0 1r3 1r3 1r3 1r3 0 0 = 2 5 dunif __ 0 1 2 3 4 5 6 __
  assert. v10 = 2 12 punif 2 + 10*v10
  assert. 0 0 0 0 1 1 1 = 2 5 punif __ _1 0 2 5 6 _
  assert. (2+i.11) = 2 12 qunif v0
  assert. (2 5 fromunif01_pdistribs_ v10) = 2 5 qunif v10
  assert. (v4 >: 2) *. v4 <: 5 [ v4=. 2 5 runif 10 10 10
  assert. 10 10 10 = $v4
  b4=. b3=. b2=. b1 =. 0 0
  try. b1 =. 2 5 qunif __  catch. b1 =. 1 1 end.
  assert. b1
  try. b2=. 2 5 qunif _0.5 catch. b2 =. 1 1 end.
  assert. b2
  try. b3 =. 2 5 qunif 1.4  catch. b3 =. 1 1 end.
  assert. b3
  try. b4 =. 2 5 qunif _  catch. b4 =. 1 1 end.
  assert. b4

  'stats/distribs/test_uniform passed'
)

smoutput test_uniform''
