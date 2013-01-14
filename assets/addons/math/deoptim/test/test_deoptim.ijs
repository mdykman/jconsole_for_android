NB. test math/deoptim addon

Note 'To run all tests:'
  load 'math/deoptim'
  load 'math/deoptim/test/test_deoptim'
)

NB. =========================================================
NB. create nouns and verbs for testing

NB. ---------------------------------------------------------
NB. Problem 0: Rosenbrock function
NB. find minimum value of Rosenbrock function
NB. http://en.wikipedia.org/wiki/Rosenbrock_function
NB. The Objective is simply the function itself.
Rosenbrock=: 3 : 0
  'x y'=. 2{. y
  (100 * *:(y - *:x)) + *:(1 - x)
)
Rosenbrock=:  *:@(1-[) + 100 * *:@(- *:)~/
Rosenbrock=: *:@:-.@{. + 100 * *:@({: - *:@{.) NB. Rosenbrock x,:y

NB. ---------------------------------------------------------
NB. Problem 1: Fitting Chebychev polynomial
NB. Use deoptim to find the coefficients for Chebychev polynomial of degree 8 (T8)
NB. For the interval _1 <: x <: 1 all of the extrema of 
NB. Chebychev polynomials are either _1 or 1, 
NB. i.e. 1 is the maximum absolute value of the polynomial 
NB. for the interval _1 <: x <: 1.
T8=: 1 0 _32 0 160 0 _256 0 128   NB. Actual coefficients for T8

lowerlimit=: T8 p. 1.2            NB. calc lower limit at 1.2

NB. Objective function (measure of solution's fitness) is:
NB. sum of squared residuals outside _1,1 for a selection of 
NB. points sampled in the interval _1 <: x <: 1
NB.     plus
NB. sum of squared residuals below lowerlimit at _1.2 and 1.2.
objfn=: 3 : 0
  res=. +/ *: (-. * 1 < |) 2}.y           NB. between _1 & 1
  res + +/ *: (#~ 0 > -&lowerlimit) 2{. y NB. _1.2 & 1.2
)

xVect=: ((],-)1.2) ,(%~i:) 300            NB. points to sample at

ChebchevPoly=: objfn@:p.&xVect            NB.Verb for evaluating set of possible coefficients


NB. ---------------------------------------------------------
NB. Problem 2: Find root with constraints
NB. The following cubic has 3 roots (2 positive, 1 negative)
NB. Use deoptim to find a root
NB. Use constraints for test values to find negative root
cubiccoeffs=: 48 8 _20 3

cubic=: [: ,/ [: | cubiccoeffs&p.    NB. absolute residuals of cubic evaluated at test value

cubicconstr=: [: ,/ 0 >: ]           NB. test values for root must be less than or equal to zero

Note 'Explore Cubic'
plot _2 8;'cubiccoeffs&p. y'         NB. plot cubic
p. cubiccoeffs                       NB. find roots directly
)

NB. ---------------------------------------------------------
NB. Different Control options

  NB.vtr genmax npop f cr popln strategy refresh digits reeval
Control=: 1e_6;1000;10;0.8;0.9;'';1;0;4;0
ControlT=: makeTable 'vtr';1e_6;'genmax';1000;'strategy';3;'refresh';100

Note 'commands to try'
 cntrl=: 1e_6;1000;10;0.8;0.9;'';1;10;4;0    NB. potential left args
 cntrl=: 1e_6;13000;10;0.7;0.5;'';2;10;4;0
 cntrl=: 1e_6;1000;10;0.8;0.9;'';3;10;4;0
 cntrl=: 1e_6;1000;10;0.5;0.9;'';4;10;4;0
 cntrl=: 0;5000;10;0.8;0.9;'';3;10;4;0
 res=: deoptim 'ChebchevPoly_base_';(|:((#T8),2)$_1000 1000)
 plot _1.01 1.01;'(0{::res) p. y'
 res=: cntrl deoptim 'ChebchevPoly_base_';(|:((#T8),2)$_1000 1000)
 plot _1.01 1.01;'(0{::res) p. y'
)

NB. =========================================================
NB. Actual tests

test=: 3 : 0
  evalfunc=. 'Rosenbrock_',(>coname''),'_'
  bounds=. |:2 2$_10 10
  tmp=. deoptim evalfunc;bounds
  tmp=. Control deoptim evalfunc;bounds
  tmp=. getDEoptim evalfunc;bounds
  tmp=. (,:'strategy';1) getDEoptim evalfunc;bounds
  tmp=. (makeTable 'strategy';2;'refresh';0) getDEoptim evalfunc;bounds
  tmp=. (makeTable 'strategy';3;'refresh';0) getDEoptim evalfunc;bounds
  tmp=. (makeTable 'strategy';4;'refresh';0) getDEoptim evalfunc;bounds
  cntrl=. ('reeval';1),('refresh';0),('strategy';2),:'genmax';200
  tmp=. cntrl getDEoptim evalfunc;bounds
  cntrl=. ('refresh';0),('strategy';2),:'genmax';200
  tmp=. cntrl getDEoptim evalfunc;bounds
  assert. 101<#'BestValbyGen' pget tmp
  assert. +./0 200 = >{:"1 'BestVal Generations' psel tmp
  cntrl=. (('popln';'Popln' pget tmp),:'refresh';50) pset cntrl
  tmp2=. cntrl getDEoptim evalfunc;bounds NB. give starting popln

  evalfunc=. 'ChebchevPoly_',(>coname''),'_'
  bounds=. |:9 2$_1000 1000
  assert. 0 = ChebchevPoly T8
  tmp=. Control  deoptim evalfunc;bounds
  tmp=. Control  getDEoptim evalfunc;bounds
  tmp=. ControlT getDEoptim evalfunc;bounds

  evalfunc=. 'cubic_',(>coname''),'_'
  bounds=. ,. _10 10
  constrfunc=. 'cubicconstr_',(>coname''),'_'
  cntrl=. makeTable 'vtr';1e_12;'genmax';1000;'strategy';3;'refresh';500
  tmp=. cntrl getDEoptim evalfunc;bounds
  assert. ('BestVars' pget tmp) e. 1{:: p. cubiccoeffs
  tmp=. cntrl getDEoptim evalfunc;bounds
  assert. ('BestVars' pget tmp) e. 1{:: p. cubiccoeffs
  tmp=. cntrl getDEoptim evalfunc;bounds
  assert. ('BestVars' pget tmp) e. 1{:: p. cubiccoeffs
  tmp=. cntrl getDEoptim evalfunc;bounds;constrfunc
  assert. ('BestVars' pget tmp) = (1;2){:: p. cubiccoeffs
  tmp=. cntrl getDEoptim evalfunc;bounds;constrfunc
  assert. ('BestVars' pget tmp) = (1;2){:: p. cubiccoeffs
  tmp=. cntrl getDEoptim evalfunc;bounds;constrfunc
  assert. ('BestVars' pget tmp) = (1;2){:: p. cubiccoeffs

  'test_deoptim passed'
)

smoutput test''
