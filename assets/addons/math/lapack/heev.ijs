NB. heev   eigenvalues and eigenvectors of a square matrix

coclass 'jlapack'

NB. =========================================================
NB.*heev v eigenvalues and eigenvectors of a Hermitian
NB.        (symmetric) matrix
NB.
NB. syntax:
NB.   'V R'=. [RMASK] heev A
NB. where
NB.   A     - N-by-N matrix, is Hermitian if complex,
NB.           symmetric otherwise
NB.   RMASK - values to return bit mask: each bit corresponds
NB.           to value should be returned: 2b10 means
NB.           "only V", 2b01 means "only R", 2b11 (default)
NB.           means "all", 2b00 is prohibited
NB.   V     - N-vector, eigenvalues in ascending order
NB.   R     - N-by-N matrix, orthonormal eigenvectors
NB.   N     >= 0
NB.
NB. if:
NB.   'V R'=. heev A
NB. then
NB.   A         is  (+@|:) A
NB.   (A mp R)  is  (V *"1 R)  is  (R mp (diag V))

heev=: (2b11&$: : (4 : 0)) " 0 2

y=. z2d y
ic=. iscomplex y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dsyev' ,: 'zheev'
iox=. ic {:: 8 ; i.0

if. (-. 0 1 -: x I. 1 4) +. ((0 ~: #@$) +. (0 -: ]) +. (0 ~: L.)) x do.
  error routine;'RMASK should be an integer in range [1,3]'
end.

vhermitian y

isv=. 0 ~: 2b01 (17 b.) x
sv=. isv { 0 0 ,: ($y)

jobz=. isv { 'NV'
uplo=. 'U'
n=. #y
a=. zero + |:y
lda=. 1 >. n
w=. n$dzero
lwork=. 1 >. _1+3*n
work=. lwork$zero
if. ic do.
  rwork=. lwork $ dzero
end.
info=. izero

arg=. iox xtoken 'jobz;uplo;n;a;lda;w;work;lwork;rwork;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

v=. |:sv$a

({. @: > ^: (1=#)) (I. _2 {. #: x) { w;v
)

NB. =========================================================
NB.*theev v test heev

theev=: 3 : 0
match=. matchclean;;
smoutput 'V R'=. heev y
smoutput a=. (clean y mp R) match (clean V *"1 R)
(0 pick a)
)

NB. =========================================================
NB. test matrices:

testheev=: 3 : 0
m0=. 0 0$0
m1=. (+ |:) ?.6 6$10
m2=. 0 0$zzero
m3=. (+ (+@|:)) j./ ?.2 6 6$10
theev &> m0;m1;m2;m3
)
