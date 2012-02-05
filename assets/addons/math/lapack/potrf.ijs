NB. potrf   Cholesky factorization of a symmetric (Hermitian)
NB.         positive definite matrix

coclass 'jlapack'

NB. =========================================================
NB.*potrf v Cholesky factorization of a symmetric (Hermitian)
NB.         positive definite matrix:
NB.         L*conjugate_transpose(L)=A
NB.
NB. syntax:
NB.   L=. potrf A
NB. where
NB.   A - N-by-N matrix, is Hermitian if complex, symmetric
NB.       otherwise
NB.   L - N-by-N lower triangular matrix, Cholesky factor
NB.   N >= 0
NB.
NB. if:
NB.   L=. potrf A
NB.   U=. potrf &. ((] ;. 0) :. (] ;. 0)) A
NB. then
NB.   A -: +|:A
NB.   0 < x mp A mp +x  NB. for any N-vector x
NB.   A -: L mp +|:L
NB.   A -: U mp +|:U
NB.   L -: ltri L
NB.   U -: utri U

potrf=: (3 : 0) " 2

y=. z2d y
ic=. iscomplex y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dpotrf' ,: 'zpotrf'

vsymposdef`vhermitian @. (ic"_) y

uplo=. 'L'
n=. #y
a=. zero + |:y
lda=. 1 >. n
info=. izero

arg=. 'uplo;n;a;lda;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

ltri |:(n,n)$a
)

NB. =========================================================
NB.*tpotrf v test potrf

tpotrf=: 3 : 0
match=. matchclean;;
smoutput L=. potrf y
smoutput a=. y match L mp +|:L
0 pick a
)

NB. =========================================================
NB. test matrices:

testpotrf=: 3 : 0
m0=. 0 0$0
m1=. (mp |:) ?.4 4$10
m2=. (mp |:) _25 + ?.10 10$100
m3=. 0 0$zzero
m4=. (mp (+ @ |:)) j./ ?.2 4 4$10
m5=. (mp (+ @ |:)) _25 + j./ ?.2 10 10$100
tpotrf &> m0;m1;m2;m3;m4;m5
)
