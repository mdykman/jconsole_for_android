NB. math/misc/mean
NB. Various means
NB. version: 1.0.0

NB. arithmean   arithmetic mean
NB. geomean     geometric mean
NB. harmean     harmonic mean
NB. commonmean  common mean

NB.*arithmean v Arithmetic mean of y
arithmean=: +/ % #

NB.*geomean v Geometric mean of y
geomean=: # %: */

NB.*harmean v Harmonic mean of y
harmean=: arithmean &. (%"_)

NB.*commonmean v Common mean of y
commonmean=: {. @ ((geomean,arithmean) ^: _)
