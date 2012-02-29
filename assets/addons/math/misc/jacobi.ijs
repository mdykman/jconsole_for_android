NB. math/misc/jacobi
NB. Jacobi's method for eigenvalues and vectors
NB. version: 1.0.0

require 'math/misc/matutil'

NB. =========================================================
NB.*jacobi v Calculate eigenvalues and vectors using Jacobi's method
NB. applies to real symmetric matrices only
NB.
NB. form: [tolerance] jacobi mat
NB.
NB. default tolerance 1e_5
NB.
NB. returns: eigenvalues;eigenvectors
jacobi=: 3 : 0
1e_5 jacobi y
:

r=. y

'argument should be a matrix' assert 2=#$r
'argument should be symmetric' assert r -: |: r
'argument should be real' assert r -: + r

ir=. i.#r
q=. id=. =ir

diag=. (<0 1)&|:
len=. +/&.(*:"_)
imax=. i.>./
utm=. ,</~ir
mp=. +/ .*
ndx=. ,{;~ir
perm=. 0 0&{ ; ] ; |. ; 1 1&{
sign=. _1: ^ <&0

count=. 0

while.
  big=. imax utm * |,r
  ind=. big { ndx
  p=. -ind { r
  (x < |p) *. big > 0
do.
  u=. -: -/ (>ind) { diag r
  v=. len p,u
  cos=. %: (v+|u) % +:v
  sin=. (sign u) * p % +: v * cos
  s=. ((cos,-sin),sin,cos) (perm >ind) } id
  r=. s mp r mp |:s
  q=. q mp |:s
  count=. >:countW
end.

r=. diag r
inx=. \:r
(inx{r);inx{"1 q
)

NB. =========================================================
NB. Test for random matrices of size y (default 3)
testjacobi=: 3 : 0
r=. 2${.y,3
mat=. (+|:)?r$10
'x y'=. jacobi mat
a=. mat mp y
b=. x *"1 y
c=. a-b
d=. (det mat),det b
mat;d;clean each a;b;c
)

Note 'Example tests'
testjacobi ''
testjacobi 4 4
)