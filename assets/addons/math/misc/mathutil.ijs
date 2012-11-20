NB. math/misc/mathutil
NB. Math utilities
NB. version: 1.0.0

NB. det           determinant of matrix y
NB. mp            M mp N  = matrix product of M and N
NB. powermod      x (n powermod) y computes n|x^y
NB. randomint     random integer in range 0, <: 10^y
NB. randomintd    random integer with y digits
NB. timesmod      x (n timesmod) y computes n|x*y

require 'numeric'

NB.*det v Determinant of matrix y
det=: -/ .*

NB.*mp v Matrix product of x and y
mp=: +/ .*

NB.*powermod a x (n powermod) y computes n|x^y
powermod=: 1 : 'x&|@^'

NB.*randomint v Random integer in range 0, <: 10^y
randomint=: 3 : '10 #. ? y $ 10x'

NB.*randomintd v Random integer with y digits
randomintd=: 3 : '10 #. (y{.1) + ? 10x - y{.1'

NB.*timesmod a x (n timesmod) y computes n|x*y
timesmod=: 1 : 'x&|@*'

