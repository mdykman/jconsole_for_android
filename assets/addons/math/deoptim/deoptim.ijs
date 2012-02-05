NB. =========================================================
NB. math/deoptim
NB. J implementation of Differential Evolution algorithm
NB. http://www.icsi.berkeley.edu/~storn/code.html

coclass 'pdeoptim'
NB. =========================================================
NB. utils for Differential Evolution addon

NB.*getSampleNR v Sample from array without replacement
NB. y is array to sample
NB. x is optional number and size of samples
NB.      defaults to 1 sample of same size as y
NB. getSampleNR=: ((1 , #) $: ]) : (] {~ {:@[ ? {.@[ $ #@])
getSampleNR=: 3 : 0
  (1 , #y) getSampleNR y
:
  'num sz'=. x
  (sz ? num $ #y){y
)

NB.*getSampleR v Sample from array with replacement
NB. y is array to sample
NB. x is optional number and size of samples
NB.      defaults to 1 sample of same size as y
NB. getSampleR=: ((1 , #) $: ]) : (] {~ [ ?@$ #@])
getSampleR=: 3 : 0
  (1 , #y) getSampleR y
:
  (x ?@$ #y){y
)
NB. =========================================================
NB. Differential Evolution algorithm

NB.*getDEoptim v Calls deoptim but allows 2-col table input & output
getDEoptim=: 3 : 0
  '' getDEoptim y
  :
  args=. ;:'vtr genmax npop   f     cr   popln'
  defs=.     0 ;  100  ; 10 ; 0.8 ; 0.9 ; ''
  args=. args,;:'strategy refresh digits reeval' NB. parameters
  defs=. defs,     3     ;   50   ; 4   ;  0     NB. default values
  (args)=. defs                                  NB. set defaults
  (args)=. {:"1 args getArgs x                   NB. update defaults
  res=. (".&.> args) deoptim y
  nmes=.;:'BestVars BestVal nFEval Generations BestVarsbyGen BestValbyGen Popln'
  nmes,.res
)

NB.*deoptim v Optimize using Differential Evolution
NB. result is: 2-item list of boxed arguments
NB.         0{ bestvars - best set of variables found
NB.         1{ bestval - value of func corresponding to bestmem
NB.         2{ nfeval - number of func evaluations
NB.         3{ gen - number of procedure generations
NB.         4{ bestvarsbygen - best set of variables found at each generation
NB.         5{ bestvalbygen - best values of func corresponding to bestvarsbygen
NB.         6{ popln - the last generated population of variable sets
NB.         7{ bounds - lower & upper boundaries
NB. y is: 2-item list of boxed arguments
NB.      0{ func - String naming a function f(x,y) to minimize, with first argument 
NB.              the vector of variables over which minimization is to take place. 
NB.              It should return a scalar result. Empty values are not allowed.
NB.      1{ bounds - 2 by nvar table describing the lower ({.) and upper ({:) bounds on the variables
NB.      2{ constr - optional string naming a function that tests variables to see if they meet constraints
NB.              Use for constraints more complex than just bounds.
NB.              Members for popln generated until NP*nVar members generated that meet all constraints
NB.              Defaults to ''
NB. x is: optional list of boxed control parameters
NB.      0{ vtr - "Value To Reach". Defaults to __
NB.      1{ genmax - max number of generations. Defaults to 100
NB.      2{ npop - number of population members per variable. Defaults to 10 (i.e popsize = 10*nvars)
NB.      3{ f - Stepsize from interval[0,2]. Defaults to 0.8
NB.      4{ cr - Crossover probability from interval [0,1]. Default to 0.9.
NB.      5{ popln - an initial population used as a starting popln. Default empty
NB.      6{ strategy - defines the binomial DE-strategy used in the optim procedure
NB.                  1 - Best1 (classical version of DE)
NB.                  2 - Rand1 (classical version of DE)
NB.                  3 - RandToBest1 (One of best versions)
NB.                  4 - Best2  (One of best versions)
NB.      7{ refresh - frequency of reports. Defaults to every 50 generations
NB.      8{ digits  - The number of digits to print when printing numeric 
NB.                   vals at each generation. Defaults to 4.
NB.      9{ reeval  - Boolean controlling whether the current best popln member
NB.                   is reevaluated each generation. Defaults to 0.
NB.                   Useful for stochastic evaluation functions.
deoptim=: 3 : 0
  '' deoptim y
:
  defs=. 0;100;10;0.8;0.9;'';3;50;4;0
  'vtr genmax npop f cr pop strategy refresh digits reeval'=. x,(#x)}.defs
  'func bounds constr'=. 3{. boxopen y
  nvar=. {:$bounds             NB. number of variables (loci)

  NB. check input vars
  assert. *#func               NB. function must be specified
  assert. *#bounds             NB. bounds must be specified
  assert. </ bounds            NB. lower bounds must be less than upper bounds
  assert. genmax > 0 
  assert. (f >: 0) *. f <: 2   NB. f must be between 0 & 2
  assert. (cr >: 0) *. cr <:1  NB. cr must be between 0 & 1
  assert. strategy e. 1 2 3 4 5
  refresh=. <.refresh          NB. ensure integer

  NB. Initialize population
  if. #pop do.                 NB. initial population provided
    assert. nvar = {:$ pop     NB. popln & bounds have same nCols
    npop=. #pop
  else.                        NB. generate initial population
    npop=. npop*nvar
    pop=. (npop,nvar)?@$0      NB. uniform random [0,1]
    pop=. ({.bounds) +"1 pop *"1 -~/bounds
    if. #constr do.
      while. 0< nbad=. +/isbad=. -.constr~"1 pop do. NB. generate new solns until all meet constraints
        newsolns=. (nbad,nvar)?@$0
        newsolns=. ({.bounds) +"1 newsolns *"1 -~/bounds
        pop=. newsolns (I.isbad)}pop
      end.
    end.
  end.
  vals=. func~"1 pop                     NB. evaluate initial popln
  nfeval=. npop
  bestvalbygen=. bestval=. <./ vals
  bestvarsbygen=. ,:bestvars=. (vals i. bestval) { pop
  gen=. 0

  NB. Differential Evolution algorithm
  while. (gen < genmax) *. bestval > vtr do.
    gen=. >:gen                          NB. increment generation
    NB. create trial popln
    trialpop=. (4,npop) getSampleNR pop  NB. 4 samples of size npop without replacement
    trialpop=. strategy mutateTrial f;trialpop;bestvars;pop
    co=. (cr > (npop,nvar)?@$0)          NB. randomize crossover
    trialpop=.  co} pop ,: trialpop      NB. crossover

    if. #constr do.                      NB. check that vars meet constraints
      while. 0< nbad=. +/isbad=. -.constr~"1 trialpop do.
        tmptp=. (4,nbad) getSampleNR pop NB. sample without replacement
        tmpp=. isbad#pop
        tmptp=. strategy mutateTrial f;tmptp;bestvars;tmpp
        co=. (cr > (nbad,nvar)?@$0)      NB. randomize crossover
        tmptp=.  co} tmpp ,: tmptp       NB. crossover
        trialpop=. tmptp (I.isbad)}trialpop  NB. replace "bad" members of trialpop
      end.
    end.

    trialvals=. func~"1 trialpop         NB. evaluate trial popln

    if. reeval do.                       NB. option to re-evaluate current best member
      bval=. func~ bestvars
      vals=. bval (vals i. bestval)} vals NB. replace old evaluation
      nfeval=. >:nfeval
    end.

    NB. update current population
    idx=. I. trialvals < vals            NB. which challengers better
    pop=.  (idx{trialpop)  idx} pop      NB. replace beaten members 
    vals=. (idx{trialvals) idx} vals     NB. replace beaten evaluations
    
    NB. update results
    nfeval=. nfeval + npop
    bestval=. <./ vals
    bestvalbygen=. bestvalbygen , bestval
    bestvars=. (vals i. bestval) { pop
    bestvarsbygen=. bestvarsbygen , bestvars

    NB. report progress
    if. (refresh > 0) *. (gen = 1) +. 0 = refresh | gen do.
      reportProgress bestvars;bestval;gen;digits
    end.
  end.

  NB. Return Results.
  if. (refresh > 0) *. 0 ~: refresh | gen do.
    reportProgress bestvars;bestval;gen;digits
  end.
  bestvars;bestval;nfeval;gen;bestvarsbygen;bestvalbygen;pop
)


reportProgress=: 3 : 0
  'bestvars bestval gen digits'=. 4{.y
  smoutput '======================'
  smoutput 'Generation: ',":gen
  smoutput 'Best Value: ', (0 j. digits) ": bestval
  smoutput 'Best Var set: '
  smoutput (0 j. digits) ": bestvars
)
NB. =========================================================
NB. strategies to mutate trial population

Note '4 DEBest2Bin & DEBest2Exp'
One of the best strategies.
F=0.5 is often appropriate.
)

Note '3 DERandToBest1Bin & DERandToBest1Exp'
This strategy seems to be one of the best strategies.
Try F=0.85 and CR=1. If you get misconvergence try to
increase NP. If this does not help you should play
around with all three control variables.
)

Note '2 DERand1Bin & DERand1Exp'
Perhaps the most universally applicaple strategy, but
not always the fastest one. Still this is one of my
favourite strategies. It works especially well when
the "Best" schemes experience mis-convergence.
Try e.g. F=0.7 and CR=0.5 as a first guess.
)

Note '1 DEBest1Bin & DEBest1Exp'
The classic strategy. However, we have found several
optimization problems where misconvergence occurs.
)

NB. only binary crossover implemented
NB. "The crossover method is not so important although Ken
NB. Price claims that binomial is never worse than exponential."

NB. y is: list of boxed f;trialpop;bestvars;pop
NB. x is: strategy. Defaults to 3

NB.*mutateTrial v Strategies for mutating new trial population
mutateTrial=: 3 : 0
  3 mutateTrial y
  :
  'f tpop bestmem pop'=. 4{.y
  select. x                 NB. choose mutation strategy
    case. 1 do.             NB. DEBest1
      tpop=. bestmem +"1 f * -/ 1 2{tpop
    case. 2 do.             NB. DERand1
      tpop=. (0{tpop) + f * -/ 1 2{tpop
    case. 3 do.             NB. DERandToBest1
      tpop=. pop + f * (bestmem -"1 pop)+ -/ 1 2{tpop
    case. 4 do.             NB. DEBest2
      tpop=. bestmem +"1 f * (-/0 1{tpop) + -/ 2 3{tpop
  end.
)
NB. =========================================================
NB. Verbs exported to z locale

getDEoptim_z_=: getDEoptim_pdeoptim_
deoptim_z_=: deoptim_pdeoptim_
NB. =========================================================
NB. Utilities for working with verbs with multiple arguments
NB.  * can specify default values for args
NB.  * arguments given as name-value pairs in 2-col table
NB.  * allows list of first n args in expected order
NB.  * verb user cannot define un-expected arg names

require 'pack'

coclass 'pargs'

NB.*makeTable v Reshape y as 2-column table
NB. use to coerce list of boxes to 2-column table
makeTable=: _2 [\ ,

NB.*isList v Is y less than rank 2?
isList=: 2 > #@$@]

NB.*paramListToTable v Stiches on the first N parameter names to the input list
NB. adapted from Dan Brons parameterized_verbs script.
paramListToTable=: (([: ({."1@:[ ,. ,@:])&>/ <.&# {.&.> ,&<) boxxopen)^:isList

NB.*packarg v Package namelist
NB. result: 2-column table of boxed name-value pairs
NB. Similar to pack from pack.ijs but doesn't sort names
NB. eg: packargs 'imm frq int pay'
packargs=: [: (, ,&< ".)&> ;:@] :: ]

NB.*getArgs v Resolves defaults and specified parameters as table of 2-col name-value pairs
NB. result: 2-column table of name-value pairs
NB. used at start of multi-param verb to override default values
NB. y is: list of boxed parameter values in expected order
NB.       or 2-column table of name-value pairs in any order
NB. x is: list of argument names in expected order (boxed or space-delimited string)
NB. Names in x must have already been defined (default values)
getArgs=: ([ psel packargs@[ pset~ packargs@[ paramListToTable ]) f.

NB. =========================================================
NB. Export to z locale
makeTable_z_=: makeTable_pargs_
getArgs_z_=: getArgs_pargs_

NB. =========================================================
NB. Example usage

Note 'example usage in verb definition'

NB. version of npv with imm and frq set to defaults
NB. y is a list of name/value pairs or a table of same
npv=: 3 : 0
  args=.  'imm frq    int          pay'
  (args)=.  0 ; 12 ;0.10 5 0.09 ; (12#1) 
  (args)=. {:"1 args getArgs y         NB. update defaults
...
)   NB. remove this comment to finish verb

npv makeTable 'pay';(24#1);'int';0.10 5 0.09


getWeaned=: 3 : 0
  args=. ;: 'ndams weanrate sexratio'  NB. Parameters
  (}. args)=.         1.2     0.5      NB. default values
  (args)=. {:"1 args getArgs y         NB. update defaults
  ((] , -.) sexratio) * weanrate * ndams
) NB. remove this comment to finish verb

NB. use all defaults
getWeaned ''

NB. use list of boxed params
getWeaned 300;1.2;0.5

NB. use partial list of boxed params
getWeaned 300;1.2

NB. use name-value pairs
getWeaned (;:'weanrate ndams sexratio'),.1.3;300;0.55
NB. OR
getWeaned makeTable 'weanrate';1.3;'ndams';300;'sexratio';0.55

NB. use partial list of name-value pairs
getWeaned (;:'weanrate ndams'),.1.2;300
)

