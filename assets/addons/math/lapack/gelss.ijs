NB. gelss   computes the minimum norm solution to a linear
NB.         least squares problem using the SVD

coclass 'jlapack'

NB. =========================================================
NB.*gelss v computes the minimum norm solution to a linear
NB.         least squares problem:
NB.           Minimize 2-norm(| b - A*x |).
NB.         using the singular value decomposition (SVD) of A
NB.
NB. syntax:
NB.   'X S R RANK'=. [RMASK] gelss A;B
NB. where
NB.   A     - M-by-N matrix, assumed as having full rank
NB.   B     - M-by-NRHS matrix or N-vector
NB.   RMASK - values to return bit mask: each bit corresponds
NB.           to value should be returned: 2b1000 (default)
NB.           means "only X", 2b0001 means "only RANK",
NB.           2b1111 means "all", 2b0000 is prohibited
NB.   X     - has the shape of B
NB.   S     - min(M,N)-vector, the singular values of A; they
NB.           are real, non-negative and have descending
NB.           order; the condition number of A in the 2-norm
NB.           = S(1)/S(min(M,N)).
NB.   R     - N-by-N matrix, the first min(M,N) columns of R
NB.           are the right singular vectors of A; if A is
NB.           complex, then R is unitary, otherwise it's
NB.           orthogonal
NB.   RANK  - the effective rank of A, i.e., the number of
NB.           singular values which are greater than
NB.           (1e-10)*S(1)
NB.   M    >= 0
NB.   N    >= 0
NB.   NRHS >= 0
NB.
NB. notes:
NB. - RCOND assigned to value 1e_10
NB.
NB. if:
NB.   X=. gelss A;B
NB. then
NB.   B -: A mp X
NB.   X -: (%.A) mp B

gelss=: (2b1000&$: : (4 : 0)) " 0 1

y=. z2d each y
ic=. +./ iscomplex &> y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dgelss' ,: 'zgelss'
iox=. ic {:: 12 ; i.0
'ma mvb'=. y

if. (-. 0 1 -: x I. 1 16) +. ((0 ~: #@$) +. (0 -: ]) +. (0 ~: L.)) x do.
  error routine;'RMASK should be an integer in range [1,15]'
end.

vmatrix ma
vmatrixorvector mvb

'm n'=. $ma
if. m ~: #mvb do.
  error routine;'matrices should have the same number of rows'
end.

mn=. m<.n

nrhs=. {: 2 ($!.1)$mvb
a=. zero + |:ma
lda=. 1 >. m
ldb=. 1 >. m >. n
b=. zero + |: ldb {. mvb
s=. mn$dzero
rcond=. 1e_10
rank=. izero
lwork=. 1 >. ic { ((3*mn)+((2*mn)>.(m>.n)>.nrhs)) , ((2*mn)+(m>.n>.nrhs))
work=. lwork$zero
rwork=. (5*mn)$dzero
info=. izero

sa=. $a
sb=. $b

arg=. iox xtoken 'm;n;nrhs;a;lda;b;ldb;s;rcond;rank;work;lwork;rwork;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

if. 2b1000 (17 b.) x do.
  b=. n {. (|: @: (sb & $))^:(ismatrix mvb) b
end.
if. 2b0010 (17 b.) x do.
  a=. mn ({."1) +sa$a
end.

({. @: > ^: (1=#)) (I. _4 {. #: x) { b;s;a;rank
)

NB. =========================================================
NB.*tgelss v test gesvx

tgelss=: 3 : 0
'a b'=. y
match=. matchclean;;
smoutput x=. gelss y
smoutput r=. b match clean a mp x
0 pick r
)

NB. =========================================================
NB. test matrices:

testgelss=: 3 : 0
dma0=. 0 0$0
dmb0=. 0 0$0
dma1=. ? 10 5$100          NB. match fails for this pair since solution is least squares
dmb1=. ? 10 3$50
dma2=. ? 5 10$100
dmb2=. ? 5 3$50
dma3=. 0 0$0
dvb3=. 0$0
dma4=. ? 10 5$100          NB. match fails for this pair since solution is least squares
dvb4=. ? 10$50
dma5=. ? 5 10$100
dvb5=. ? 5$50
zma0=. 0 0$zzero
zmb0=. 0 0$zzero
zma1=. j./ ? 2 10 5$100    NB. match fails for this pair since solution is least squares
zmb1=. j./ ? 2 10 3$50
zma2=. j./ ? 2 5 10$100
zmb2=. j./ ? 2 5 3$50
zma3=. 0 0$zzero
zvb3=. 0$zzero
zma4=. j./ ? 2 10 5$100    NB. match fails for this pair since solution is least squares
zvb4=. j./ ? 2 10$50
zma5=. j./ ? 2 5 10$100
zvb5=. j./ ? 2 5$50
tgelss &> (< dma0;dmb0) , (< dma1;dmb1) , (< dma2;dmb2) , (< dma3;dvb3) , (< dma4;dvb4) , (< dma5;dvb5) , (< zma0;zmb0) , (< zma1;zmb1) , (< zma2;zmb2) , (< zma3;zvb3) , (< zma4;zvb4) , (< zma5;zvb5)
)

NB. least squares tests from http://www.nag.co.uk/lapack-ex/lapack-ex.html
NB.
NB.    dma=. 6 4 $ _0.57 _1.28 _0.39 0.25 _1.93 1.08 _0.31 _2.14 2.30 0.24 0.40 _0.35 _1.93 0.64 _0.66 0.08 0.15 0.30 0.15 _2.13 _0.02 1.03 _1.43 0.50
NB.    dvb=. _2.67 _0.55 3.34 _0.77 0.48 4.10
NB.    dvx=. 1.5339 1.8707 _1.5241 0.0392
NB.    tgelss dma;dvb
NB. 1.53387 1.87075 _1.52407 0.039183
NB.
NB.    zma=. 6 4 $ 0.96j_0.81 _0.03j0.96 _0.91j2.06 _0.05j0.41 _0.98j1.98 _1.20j0.19 _0.66j0.42 _0.81j0.56 0.62j_0.46 1.01j0.02 0.63j_0.17 _1.11j0.60 _0.37j0.38 0.19j_0.54 _0.98j_0.36 0.22j_0.20 0.83j0.51 0.20j0.01 _0.17j_0.46 1.47j1.59 1.08j_0.28 0.20j_0.12 _0.07j1.23 0.26j0.26
NB.    zvb=. _2.09j1.93 3.34j_3.53 _4.94j_2.04 0.17j4.23 _5.19j3.63 0.98j2.53
NB.    zvx=. _0.5044j_1.2179 _2.4281j2.8574 1.4872j_2.1955 0.4537j2.6904
NB.    tgelss zma;zvb
NB. _0.504365j_1.21788 _2.42815j2.85742 1.48717j_2.19548 0.453708j2.69041
