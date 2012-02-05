NB. gesv   solves the system A * X = B

coclass 'jlapack'

NB. =========================================================
NB.*gesv v for the system A * X = B:
NB. - factorize the matrix A: P*L*U=A
NB. - solve system for X
NB.
NB. syntax:
NB.   'X L U IPIV'=. [RMASK] gesv A;B
NB. where
NB.   A     - N-by-N matrix
NB.   B     - N-by-NRHS matrix or N-vector
NB.   RMASK - values to return bit mask: each bit corresponds
NB.           to value should be returned: 2b1000 (default)
NB.           means "only X", 2b0001 means "only IPIV",
NB.           2b1111 means "all", 2b0000 is prohibited
NB.   X     - has the shape of B
NB.   L     - N-by-N lower triangular matrix with unit
NB.           diagonal elements, factor from the
NB.           factorization P*L*U=A
NB.   U     - N-by-N upper triangular matrix, factor from the
NB.           factorization P*L*U=A
NB.   IPIV  - N-vector, pivot indices from the factorization
NB.           P*L*U=A
NB.   N     >= 0
NB.   NRHS  >= 0
NB.
NB. if:
NB.   'X L U IPIV'=. 2b1111 gesv A;B
NB. then
NB.   B -: A mp X
NB.   X -: (%.A) mp B
NB.   A -: P mp L mp U
NB.   A -: IPIV invperm~ L mp U
NB. where
NB.   P =. makepermat IPIV

gesv=: (2b1000&$: : (4 : 0)) " 0 1

y=. z2d each y
ic=. +./ iscomplex &> y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dgesv' ,: 'zgesv'
rmask=. x
'ma mvb'=. y

if. (-. 0 1 -: x I. 1 16) +. ((0 ~: #@$) +. (0 -: ]) +. (0 ~: L.)) rmask do.
  error routine;'RMASK should be an integer in range [1,15]'
end.

vsquare ma
vmatrixorvector mvb

n=. #ma
if. n ~: #mvb do.
  error routine;'matrices should have the same number of rows'
end.

sa=. |.$ma
sb=. |.$mvb

nrhs=. {: 2 ($!.1) $mvb
a=. zero + |:ma
lda=. ldb=. 1 >. n
ipiv=. n$izero
b=. zero + |:mvb
info=. izero

arg=. 'n;nrhs;a;lda;ipiv;b;ldb;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

u=. l=. izero

if. 2b1000 (17 b.) rmask do.
  b=. (|: @: (sb & $))^:(ismatrix mvb) b
end.
if. 2b0110 (17 b.) x do.
  a=. |:sa$a
  if. 2b0100 (17 b.) x do.
    l=. (idmat sa) + sltri a
  end.
  if. 2b0010 (17 b.) rmask do.
    u=. utri a
  end.
end.

({. @: > ^: (1=#)) (I. _4 {. #: rmask) { b;l;u;ipiv
)

NB. =========================================================
NB.*tgesv v test gesv

tgesv=: 3 : 0
'a b'=. y
match=. matchclean;;
smoutput x=. gesv y
smoutput r=. b match clean a mp x
0 pick r
)

NB. =========================================================
NB. test matrices:

testgesv=: 3 : 0
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
tgesv &> (< ma0;mb0) , (< ma1;mb1) , (< ma2;mb2) , (< ma3;mb3) , (< ma4;vb4) , (< ma5;vb5) , (< ma6;vb6) , (< ma7;vb7)
)
