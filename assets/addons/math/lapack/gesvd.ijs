NB. gesvd  singular value decomposition (SVD) of a matrix

coclass 'jlapack'

NB. =========================================================
NB.*gesvd v singular value decomposition (SVD) of a M-by-N
NB.         matrix A: L*S*conjugate_transpose(R)=A
NB.
NB. syntax:
NB.   'L S R'=. [RMASK] gesvd A
NB. where
NB.   A     - M-by-N matrix
NB.   RMASK - values to return bit mask: each bit corresponds
NB.           to value should be returned: 2b100 means
NB.           "only L", 2b001 means "only R", 2b111 (default)
NB.           means "all", 2b000 is prohibited
NB.   L     - M-by-M matrix, the first min(M,N) columns of L
NB.           are the left singular vectors of A; if A is
NB.           complex, then L is unitary, otherwise it's
NB.           orthogonal
NB.   S     - M-by-N diagonal matrix, diagonal elements of S
NB.           are the singular values of A; they are real,
NB.           non-negative and have descending order
NB.   R     - N-by-N matrix, the first min(M,N) columns of R
NB.           are the right singular vectors of A; if A is
NB.           complex, then R is unitary, otherwise it's
NB.           orthogonal
NB.   M     >= 0
NB.   N     >= 0
NB.
NB. if:
NB.   'L S R'=. gesvd A
NB. then
NB.   A -: L mp S mp +|:R

gesvd=: (2b111&$: : (4 : 0)) " 0 2

y=. z2d y
ic=. iscomplex y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dgesvd' ,: 'zgesvd'
iox=. ic {:: 13 ; i.0

if. (-. 0 1 -: x I. 1 8) +. ((0 ~: #@$) +. (0 -: ]) +. (0 ~: L.)) x do.
  error routine;'RMASK should be an integer in range [1,7]'
end.

vmatrix y

sa=. |. 'm n'=. $y
mn=. m<.n
'isu isvt'=. isv=. 0 ~: 2b100 2b001 (17 b.) x
sui=. isu { 0 0 ,: m,m
svt=. isvt { 0 0 ,: n,n

'jobu jobvt'=. isv { 'NA'
a=. zero + |:y
lda=. ldu=. 1>.m
s=. mn$dzero
u=. sui$zero
vt=. svt$zero
ldvt=. 1>.n
lwork=. 1 >. ic { (((3*mn)+(m>.n))>.(5*mn)) , ((2*mn)+(m>.n))
work=. lwork$zero
rwork=. ((3*mn)>.(_4+5*mn))$dzero
info=. izero

arg=. iox xtoken 'jobu;jobvt;m;n;a;lda;s;u;ldu;vt;ldvt;work;lwork;rwork;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

u=. |:sui$u
vt=. +svt$vt
s=. (m-n) diagmat s

({. @: > ^: (1=#)) (I. _3 {. #: x) { u;s;vt
)

NB. =========================================================
NB.*tgesvd v test gesvd

tgesvd=: 3 : 0
match=. matchclean;;
smoutput 'y=' ; y
smoutput 'L S R'=. gesvd y
smoutput a=. y match clean L mp S mp +|:R
0 pick a
)

NB. =========================================================
NB. test matrices:

testgesvd=: 3 : 0
m0=. 0 0$0
m1=. ?.4 4$10
m2=. ?.4 6$10
m3=. ?.6 4$10
m4=. 0 0$zzero
m5=. j./ ?.2 4 4$10
m6=. j./ ?.2 4 6$10
m7=. j./ ?.2 6 4$10
tgesvd &> m0;m1;m2;m3;m4;m5;m6;m7
)
