NB. math/misc/svd
NB. Singular value decomposition
NB. version: 1.0.0
NB.
NB. for real matrices only

require 'math/misc/jacobi'

NB. =========================================================
NB.*svd v Singular value decomposition of matrix y
NB. returns:  left singular vectors;singular values;right singular vectors
svd=: 3 : 0
mat=. y
if. b=. </$mat do. mat=. |:mat end.
'r s'=. jacobi (|:mat) mp mat
t=. %:r
u=. (mat mp s) %"1 t
|.^:b u;t;s
)

NB. =========================================================
NB. test for random matrices of size y (default 3 3), or given matrix
NB. e.g. testsvd 4 5
testsvd=: 3 : 0
if. 2=#$y do. mat=. y
else. mat=. ? (2{.y,3 3) $ 10
end.
'x y z'=. svd mat
NB. mat should be:
t=. x mp (diagmat y) mp |: z
clean each mat;t;mat-t
)
