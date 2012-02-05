NB. getrf LU factorization of a general M-by-N matrix

coclass 'jlapack'

NB. =========================================================
NB.*getrf v LU factorization of a general M-by-N matrix
NB.         using partial pivoting with row interchanges:
NB.         P*L*U=A
NB.
NB. syntax:
NB.   'L U IPIV'=. [RMASK] getrf A
NB. where
NB.   A     - M-by-N matrix
NB.   RMASK - values to return bit mask: each bit corresponds
NB.           to value should be returned: 2b100 means
NB.           "only L", 2b001 means "only I", 2b111 (default)
NB.           means "all", 2b000 is prohibited
NB.   L     - M-by-min(M,N) lower triangular matrix with unit
NB.           diagonal elements (lower trapezoidal if M > N)
NB.   U     - min(M,N)-by-N upper triangular matrix (upper
NB.           trapezoidal if M < N)
NB.   IPIV  - min(M,N)-vector, pivot indices from the
NB.           factorization P*L*U=A
NB.   M     >= 0
NB.   N     >= 0
NB.
NB. if:
NB.   'L U IPIV'=. getrf A
NB. then
NB.   A -: P mp L mp U
NB.   A -: IPIV invperm~ L mp U
NB. where
NB.   P =. makepermat IPIV

getrf=: (2b111&$: : (4 : 0)) " 0 2

y=. z2d y
ic=. iscomplex y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dgetrf' ,: 'zgetrf'

if. (-. 0 1 -: x I. 1 8) +. ((0 ~: #@$) +. (0 -: ]) +. (0 ~: L.)) x do.
  error routine;'RMASK should be an integer in range [1,7]'
end.

vmatrix y

si=. |. 'm n'=. s=. $y
mn=. m <. n
lda=. 1 >. m
a=. zero + |:y
ipiv=. mn$izero
info=. izero

arg=. 'm;n;a;lda;ipiv;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

u=. l=. izero

if. 2b110 (17 b.) x do.
  a=. |:si$a
  if. 2b100 (17 b.) x do.
    l=. (idmat s) + sltri a
    if. m < n do.
      l=. (_,mn) {. l
    end.
  end.
  if. 2b010 (17 b.) x do.
    u=. utri a
    if. m > n do.
      u=. (mn,_) {. u
    end.
  end.
end.

({. @: > ^: (1=#)) (I. _3 {. #: x) { l;u;ipiv
)

NB. =========================================================
NB.*tgetrf v test getrf

tgetrf=: 3 : 0
match=. matchclean;;
smoutput 'L U IPIV'=. getrf y
smoutput a=. y match IPIV invperm~ L mp U
0 pick a
)

NB. =========================================================
NB. test matrices:

testgetrf=: 3 : 0
m0=. 0 0$0
m1=. ?.4 6$10
m2=. ?.6 4$10
m3=. ?.6 6$10
m4=. 0 0$zzero
m5=. j./ ?. 2 4 6$10
m6=. j./ ?.2 6 4$10
m7=. j./ ?.2 6 6$10
tgetrf &> m0;m1;m2;m3;m4;m5;m6;m7
)
