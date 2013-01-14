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
