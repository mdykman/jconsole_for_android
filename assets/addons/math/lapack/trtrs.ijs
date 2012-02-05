NB. trtrs   solves a triangular system A * X = B

coclass 'jlapack'

NB. =========================================================
NB.*trtrs v solves a triangular system A * X = B
NB.
NB. syntax:
NB.   X=. trtrs A;B
NB. where
NB.   A - N-by-N upper triangular matrix
NB.   B - N-by-NRHS matrix or N-vector
NB.   X - has the shape of B
NB.   N >= 0
NB.   NRHS >= 0
NB.
NB. if:
NB.   X=. trtrs A;B
NB. then
NB.   A -: utri A
NB.   B -: A mp X
NB.   X -: (%.A) mp B

trtrs=: (3 : 0) " 1

y=. z2d each y
ic=. +./ iscomplex &> y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dtrtrs' ,: 'ztrtrs'
'ma mvb'=. y

vsquare ma
vmatrixorvector mvb

n=. #ma
if. n ~: #mvb do.
  error routine;'arguments should match in length'
end.

uplo=. 'L'
trans=. 'T'
diag=. 'N'
nrhs=. {: 2 ($!.1) $mvb
lda=. ldb=. 1 >. n

a=. zero + ic (((9 & o.) @: ]) ^: (-. @: [)) ma
b=. zero + |: ic (((9 & o.) @: ]) ^: (-. @: [)) mvb

info=. izero

arg=. 'uplo;trans;diag;n;nrhs;a;lda;b;ldb;info'

(cutarg arg)=. routine call , each ". arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

(|: @: ((nrhs,n) & $))^:(ismatrix mvb) b

)

NB. =========================================================
NB.*ttrtrs v test trtrs

ttrtrs=: 3 : 0
'a b'=. y
match=. matchclean;;
smoutput x=. trtrs y
smoutput r=. b match clean a mp x
0 pick r
)

NB. =========================================================
NB. test matrices:

testtrtrs=: 3 : 0
ma0=. 0 0$0
mb0=. 0 0$0
ma1=. utri ? 10 10$100
mb1=. ? 10 5$50
ma2=. 0 0$zzero
mb2=. 0 0$zzero
ma3=. utri j./ ? 2 10 10$100
mb3=. j./ ? 2 10 5$50
ma4=. 0 0$0
vb4=. 0$0
ma5=. utri ? 10 10$100
vb5=. ? 10$50
ma6=. 0 0$zzero
vb6=. 0$zzero
ma7=. utri j./ ? 2 10 10$100
vb7=. j./ ? 2 10$50
ttrtrs &> (< ma0;mb0) , (< ma1;mb1) , (< ma2;mb2) , (< ma3;mb3) , (< ma4;vb4) , (< ma5;vb5) , (< ma6;vb6) , (< ma7;vb7)
)
