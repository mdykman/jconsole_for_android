NB. gesvx   solves the system A * X = B

coclass 'jlapack'

NB. =========================================================
NB.*gesvx v for the system A * X = B:
NB. - equilibrate system (optionally)
NB. - factorize the matrix A: P*L*U=A
NB. - estimate the condition number of the matrix A
NB. - solve system for X
NB. - refine iteratively to improve solution X and calculate
NB.   error bounds and backward error estimates for it
NB. - post-process X if A was equilibrated
NB.
NB. syntax:
NB.   'X AE L U IPIV EQUED R C BE RCOND FERR BERR ABYU'=. [RMASK] gesvx A;B
NB. where
NB.   A     - N-by-N matrix
NB.   B     - N-by-NRHS matrix or N-vector
NB.   RMASK - values to return bit mask: each bit corresponds to
NB.           value should be returned: 2b1000000000000 (default)
NB.           means "only X", 2b0000000000001 means "only ABYU",
NB.           2b1111111111111 means "all", 2b0000000000000 is
NB.           prohibited
NB.   X     - has the shape of B
NB.   AE    - N-by-N matrix, equilibrated or unchanged matrix A
NB.   L     - N-by-N lower triangular matrix with unit
NB.           diagonal elements, factor from the factorization
NB.           P*L*U=AE
NB.   U     - N-by-N upper triangular matrix, factor from the
NB.           factorization P*L*U=AE
NB.   IPIV  - N-vector, pivot indices from the factorization
NB.           P*L*U=AE
NB.   EQUED - 'N','R','C' or 'B' - the form of equilibration
NB.           that was done
NB.   R     - N-vector, the row scale factors for A
NB.   C     - N-vector, the column scale factors for A
NB.   BE    - N-by-NRHS matrix or N-vector, equilibrated
NB.           or unchanged matrix/vector B
NB.   RCOND - the estimate of the reciprocal condition number
NB.           of the matrix AE
NB.   FERR  - NRHS-vector or scalar, the estimated forward
NB.           error bound for each column of X
NB.   BERR  - NRHS-vector or scalar, the componentwise
NB.           relative backward error for each column of X
NB.   ABYU  - the reciprocal pivot growth factor norm(A)/norm(U)
NB.   N     >= 0
NB.   NRHS  >= 0
NB.
NB. if:
NB.   'X AE L U IPIV EQUED R C BE RCOND FERR BERR ABYU'=. 2b111111111111 gesvx A;B
NB. then
NB.   B    -: A mp X
NB.   X    -: (%.A) mp B
NB.   BE   -: AE mp XE
NB.   BE   -: (diag R) mp B
NB.   AE   -: (diag R) mp A mp (diag C)
NB.   AE   -: P mp L mp U
NB.   AE   -: IPIV invperm~ L mp U
NB.   FERR >: X ((>./ @ | @ -) % (>./ @ | @ [)) XTRUE
NB.   BERR -: >./ (| B - A mp X) % ((|B) + (|A) mp (|X))
NB.   ABYU -: A (% & (>./^:2 @: |)) U
NB. where
NB.   XE   =. (%. diag C) mp X
NB.   XE   -: (%.AE) mp BE
NB.   P    =. makepermat IPIV
NB.   XTRUE - true solution of the system A * X = B

gesvx=: (2b1000000000000&$: : (4 : 0)) " 0 1

y=. z2d each y
ic=. +./ iscomplex &> y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dgesvx' ,: 'zgesvx'
iox=. ic { 21 20
rmask=. x
'ma mvb'=. y

if. (-. 0 1 -: x I. 1 8192) +. ((0 ~: #@$) +. (0 -: ]) +. (0 ~: L.)) rmask do.
  error routine;'RMASK should be an integer in range [1,8191]'
end.

vsquare ma
vmatrixorvector mvb

n=. #ma
if. n ~: #mvb do.
  error routine;'matrices should have the same number of rows'
end.

sa=. |.$ma
sb=. |.$mvb

fact=. (0 ~: 2b010011110000 (17 b.) rmask) { 'NE'
trans=. 'N'       NB. TODO: 'T' to aviod transposition
nrhs=. {: 2 ($!.1) $mvb
a=. zero + |:ma
lda=. ldaf=. ldb=. ldx=. 1 >. n
af=. sa$zero
ipiv=. n$izero
equed=. ' '
r=. c=. n$dzero
b=. zero + |:mvb
x=. sb$zero
rcond=. dzero
ferr=. berr=. nrhs$dzero
if. ic do.
  work=. (2*n)$zero
  rwork=. (2*n)$dzero
else.
  work=. (4*n)$zero
  iwork=. n$izero
end.
info=. izero

arg=. iox xtoken 'fact;trans;n;nrhs;a;lda;af;ldaf;ipiv;equed;r;c;b;ldb;x;ldx;rcond;ferr;berr;work;iwork;rwork;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

u=. l=. izero

if. 2b1000000000000 (17 b.) rmask do.
  x=. (|: @: (sb & $))^:(ismatrix mvb) x
end.
if. 2b0100000000000 (17 b.) rmask do.
  a=. |:sa$a
end.
if. 2b0011000000000 (17 b.) rmask do.
  af=. |:sa$af
  if. 2b0010000000000 (17 b.) rmask do.
    l=. (idmat sa) + sltri af
  end.
  if. 2b0001000000000 (17 b.) rmask do.
    u=. utri af
  end.
end.
if. 2b0000000010000 (17 b.) rmask do.
  b=. (|: @: (sb & $))^:(ismatrix mvb) b
end.
if. ic do.
  abyu=. {. rwork
else.
  abyu=. {. work
end.

({. @: > ^: (1=#)) (I. _13 {. #: rmask) { x;a;l;u;ipiv;equed;r;c;b;rcond;ferr;berr;abyu
)

NB. =========================================================
NB.*tgesvx v test gesvx

tgesvx=: 3 : 0
'a b'=. y
match=. matchclean;;
smoutput x=. gesvx y
smoutput r=. b match clean a mp x
0 pick r
)

NB. =========================================================
NB. test matrices:

testgesvx=: 3 : 0
ma0=. 0 0$0
mb0=. 0 0$0
ma1=. ? 10 10$100
mb1=. ? 10 5$50
ma2=. 0 0$zzero
mb2=. 0 0$zzero
ma3=. j./ ? 2 10 10$100
mb3=. j./ ? 2 10 5$50
ma4=. 0 0$0
vb4=. 0$0
ma5=. ? 10 10$100
vb5=. ? 10$50
ma6=. 0 0$zzero
vb6=. 0$zzero
ma7=. j./ ? 2 10 10$100
vb7=. j./ ? 2 10$50
tgesvx &> (< ma0;mb0) , (< ma1;mb1) , (< ma2;mb2) , (< ma3;mb3) , (< ma4;vb4) , (< ma5;vb5) , (< ma6;vb6) , (< ma7;vb7)
)
