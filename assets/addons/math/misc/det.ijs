NB. math/misc/det
NB. Definitions for determinants
NB. version: 1.0.0

require 'math/misc/linear'

NB.*det v Determinants of a matrix by recursive expansion of minors
NB.  only efficient for small matrices 
det=: -/ .*

NB.*detm v Determinants of square matrix by Gauss elimination
NB. more efficient than det for larger matrices
detm=: 3 : 0
'm p s'=. gauss_elimination y
(*/ diag m) * _1 ^ #s
)
