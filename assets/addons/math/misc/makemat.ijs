NB. math/misc/makemat
NB. Make various standard matrices
NB. version: 1.0.0

NB. bandmat       band matrix
NB. diagmat       diagonal matrix
NB. hilbertmat    Hilbert matrix
NB. jordanmat     Jordan matrix from matrix list
NB. idmat         identity matrix
NB. cidmat        counter identity matrix
NB. ltmat         lower triangular matrix (of 1's)
NB. utmat         upper triangular matrix (of 1's)

NB. =========================================================
NB.*bandmat v Band matrix in position x from diagonal y
NB. eg:
NB.     1 bandmat 3 5 7
NB.  0 3 0 0
NB.  0 0 5 0
NB.  0 0 0 7
NB.  0 0 0 0
NB. eg:
NB.     _1 bandmat 3 5 7
NB.  0 0 0 0
NB.  3 0 0 0
NB.  0 5 0 0
NB.  0 0 7 0
sh=. |. !. 0                  NB. shift in zeroes
sl=. [ + #@] * _1: ^ [ < 0:   NB. signed length
bandmat=: ((sl {. ]) * [ sh =@i.@sl) f.

NB. =========================================================
NB.*cidmat v Counter identity matrix of size y
NB. eg:
NB.    cidmat 3
NB. 0 0 1
NB. 0 1 0
NB. 1 0 0
cidmat=: ]\ (([: <: +:) {. - {. 1:)

NB. =========================================================
NB.*diagmat v Diagonal matrix with y on diagonal
NB. equivalent to 0&bandmat
NB. eg:
NB.     diagmat 3 5 7
NB.  3 0 0
NB.  0 5 0
NB.  0 0 7
diagmat=: * =@i.@#

NB. =========================================================
NB.*hilbertmat v Hilbert matrix of size y
NB. eg:
NB.     hilbertmat 3
NB.  1r1 1r2 1r3
NB.  1r2 1r3 1r4
NB.  1r3 1r4 1r5
hilbertmat=: ]\ % @ x: @ (i.&.<:) @ +:

NB. =========================================================
NB. idmat v Identity matrix of size y
NB. eg:
NB.     idmat 3
NB.  1 0 0
NB.  0 1 0
NB.  0 0 1
idmat=: =@i.

NB. =========================================================
NB. jordanmat v Create Jordan matrix from matrix list
NB. eg:
NB.     jordanmat (1: + [: i. ,~) each 2 1 3
NB.  1 2 0 0 0 0
NB.  3 4 0 0 0 0
NB.  0 0 1 0 0 0
NB.  0 0 0 1 2 3
NB.  0 0 0 4 5 6
NB.  0 0 0 7 8 9
jordanmat=: [: > ((+&$ {. [) + -@:(+&$) {. ]) each /

NB. =========================================================
NB.*ltmat v Lower triangular matrix (of 1's) of size y
ltmat=: {. >:/&i. {:

NB.*utmat v Upper triangular matrix (of 1's) of size y
NB. eg:
NB.    utmat 4 5
NB. 1 1 1 1 1
NB. 0 1 1 1 1
NB. 0 0 1 1 1
NB. 0 0 0 1 1
utmat=: {. <:/&i. {:
