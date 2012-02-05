NB. gelqf  LQ factorization of a M-by-N matrix

coclass 'jlapack'

NB. =========================================================
NB.*gelqf v LQ factorization of a M-by-N matrix A: L * Q = A
NB.
NB. syntax:
NB.   'L H TAU Q'=. [RMASK] gelqf A
NB. where
NB.   A     - M-by-N matrix
NB.   RMASK - values to return bit mask: each bit corresponds
NB.           to value should be returned: 2b1000 means
NB.           "only L", 2b0001 means "only Q", 2b1111 means
NB.           "all", 2b0000 is prohibited, 2b1001 is default
NB.   L     - M-by-K lower trapezoidal matrix L (L is lower
NB.           triangular if M <= N)
NB.   H     - K-by-N matrix of the elementary reflectors
NB.           H(i), stored columnwise
NB.   TAU   - K-vector, scalar factors of the elementary
NB.           reflectors
NB.   Q     - K-by-N matrix. If A is complex, then Q is
NB.           unitary, otherwise it's orthogonal
NB.   K     = min(M,N)
NB.   M     >= 0
NB.   N     >= 0
NB.
NB. if:
NB.   K=. <./ 'M N'=. $ A
NB.   'L H TAU Q'=. 2b1111 gelqf A
NB. then
NB.   Q -: K {. mp/ (idmat N) -"2 |. (+ TAU) * (* +)"0/~"1 + H
NB.   A -: L mp Q

gelqf=: (2b1001&$: : (4 : 0)) " 0 2

y=. z2d y
ic=. iscomplex y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dgelqf' ,: 'zgelqf'

if. (-. 0 1 -: x I. 1 16) +. ((0 ~: #@$) +. (0 -: ]) +. (0 ~: L.)) x do.
  error routine;'RMASK should be an integer in range [1,15]'
end.

vmatrix y

'm n'=. $y
k=. m <. n
a=. zero + |:y
lda=. 1 >. m
tau=. k $ zero
lwork=. 1 >. 10 * m >. n
work=. lwork$zero
info=. izero

arg=. 'm;n;a;lda;tau;work;lwork;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

q=. h=. l=. izero

if. 2b1101 (17 b.) x do.
  val=. |: (n,m) $a
  if. 2b1000 (17 b.) x do.
    l=. (m,k) {. ltri val
  end.
  if. 2b0101 (17 b.) x do.
    h=. (k,n) {. (idmat m,n) + sutri val
  end.
  if. 2b0001 (17 b.) x do.
    q=. k {. mp/ (idmat n) -"2 |. (+ tau) * (* +)"0/~"1 + h
  end.
end.

({. @: > ^: (1=#)) (I. _4 {. #: x) { l;h;tau;q
)

NB. =========================================================
NB.*tgelqf v test gelqf

tgelqf=: 3 : 0
match=. matchclean;;
smoutput 'L Q'=. gelqf y
smoutput a=. y match L mp Q
0 pick a
)

NB. =========================================================
NB. test matrices:

testgelqf=: 3 : 0
m0=. 0 0$0
m1=. ?.4 6$10
m2=. ?.6 4$10
m3=. ?.6 6$10
m4=. 0 0$zzero
m5=. j./ ?. 2 4 6$10
m6=. j./ ?.2 6 4$10
m7=. j./ ?.2 6 6$10
tgelqf &> m0;m1;m2;m3;m4;m5;m6;m7
)
