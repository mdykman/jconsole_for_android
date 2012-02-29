NB. math/misc/matfacto
NB. Matrix factorization
NB. version: 1.0.0

NB. choleski        Choleski decomposition
NB. lud             LU decomposition of matrix
NB. qrd             QR decomposition of matrix

require 'math/misc/linear'

NB. =========================================================
NB.*choleski v Choleski decomposition of matrix y
NB. a = l x +|:l=. choleski x
NB. a =: a +/ .*
choleski=: 3 : 0
mp=. +/ .*
n=. #a=. y
if. 1>:n do.
  13!:8(,(a=|a)>0=a)}.12
  %:a
else.
  p=. >.n%2 [ q=. <.n%2
  x=. (p,p){.a [ y=. (p,-q){.a [ z=. (-q,q){.a
  l0=. choleski x
  l1=. choleski z-(t=. (+|: y) mp %.x) mp y
  l0,(t mp l0),.l1
end.
)

NB. =========================================================
NB.*lud v LU decomposition of matrix y
NB. returns 3 elements: L U P where
NB.   L is lower triangular
NB.   U is upper triangular
NB.   P is a permutation of the identity matrix,
NB.     that gives the pivoting used.
NB. The original matrix is: (L mp U) %. P
lud=: 3 : 0
r=. #y
ir=. idmat r
'a b'=. 2 {. gauss_elimination y,.ir
u=. clean (r,r){.a
f=. (0,r)}.a
l=. clean b{%.f
p=. b{ir
l;u;p
)

NB. =========================================================
NB.*qrd v QR decomposition of matrix y
NB. result has 2 elements: Hermitian matrix;square upper triangular matrix
qrd=: 128!:0
