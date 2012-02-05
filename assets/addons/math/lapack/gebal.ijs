NB. gebal  balances a general square matrix

coclass 'jlapack'

NB. =========================================================
NB.*gebal v balances a general square matrix. This involves,
NB.         first, permuting; and second, applying a diagonal
NB.         similarity transformation to rows and columns.
NB.
NB. syntax:
NB.   'B ILO IHI SCALE'=. [RMASK] gebal A
NB. where
NB.   A       - N-by-N matrix
NB.   RMASK   - values to return bit mask: each bit corresponds
NB.             to value should be returned: 2b1000 means
NB.             "only B", 2b0001 means "only SCALE", 2b1111
NB.             (default) means "all", 2b0000 is prohibited
NB.   B       - N-by-N balanced matrix
NB.   ILO,IHI - integers such that on exit A(i,j) = 0 if
NB.             i > j and j = 1,...,ILO-1 or I = IHI+1,...,N
NB.   SCALE   - N-vector, details of the permutations and
NB.             scaling factors applied to A. If P(j) is the
NB.             index of the row and column interchanged
NB.             with row and column j and D(j) is the
NB.             scaling factor applied to row and column j,
NB.             then
NB.               SCALE(j) = P(j)    for j = 1,...,ILO-1
NB.                        = D(j)    for j = ILO,...,IHI
NB.                        = P(j)    for j = IHI+1,...,N.
NB.             The order in which the interchanges are made
NB.             is N to IHI+1, then 1 to ILO-1.
NB.   N       >= 0
NB.
NB. notes:
NB. - JOB assigned to value 'B'
NB. - the order in which the interchanges are made is
NB.   undefined, but it works
NB.
NB. if:
NB.   'B ILO IHI SCALE'=. gebal A
NB. then
NB.    B -: (T1 ,. XD ,. Y) , (Z10 ,. iDBD ,. iDZ) , (Z20 ,. Z21 ,. T2)
NB. where
NB.    dlen=. >: IHI-ILO                 NB. scaling vector length
NB.    IOSdinp=. (<: ILO) + i. dlen      NB. IOS d items in SCALE
NB.    p=. (>: IOSdinp) IOSdinp } SCALE  NB. permutation vector
NB.    P=. makepermat p                  NB. permutation matrix
NB.    iP=. |: P                         NB. (%. P) -: (|: P)
NB.    PAiP=. P mp A mp iP
NB.    bcut=. 1 (0) } ((<: ILO) , IHI) e.~ i. (#A)          NB. split bits
NB.    'T1 X Y Z10 B Z Z20 Z21 T2'=. , (;~ bcut) <;.1 PAiP  NB. split matrix PAiP on 3-by-3 submatrices
NB.    d=. IOSdinp { SCALE               NB. scaling vector
NB.    D=. diagmat d                     NB. scaling matrix
NB.    iD=. diagmat % d                  NB. iD -: %. D
NB.    XD=. X mp D
NB.    iDBD=. iD mp B mp D
NB.    iDZ=. iD mp Z
NB.    Z10 Z20 Z21 are zero matrices of appropriate sizes

gebal=: (2b1111&$: : (4 : 0)) " 0 2

y=. z2d y
ic=. iscomplex y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dgebal' ,: 'zgebal'

if. (-. 0 1 -: x I. 1 16) +. ((0 ~: #@$) +. (0 -: ]) +. (0 ~: L.)) x do.
  error routine;'RMASK should be an integer in range [1,15]'
end.

vsquare y

job=. 'B'
n=. #y
a=. zero + |:y
lda=. 1 >. n
ilo=. izero
ihi=. izero
scale=. n $ dzero
info=. izero

arg=. 'job;n;a;lda;ilo;ihi;scale;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

if. 2b1000 (17 b.) x do.
  a=. |: (2$n)$a
end.
if. 2b0100 (17 b.) x do.
  ilo=. {. ilo
end.
if. 2b0010 (17 b.) x do.
  ihi=. {. ihi
end.

({. @: > ^: (1=#)) (I. _4 {. #: x) { a;ilo;ihi;scale
)

NB. =========================================================
NB.*tgebal v test gebal

tgebal=: 3 : 0
match=. matchclean;;
smoutput 'AB ILO IHI SCALE'=. gebal y
n=. #y
if. 0<n do.
  dlen=. >: IHI-ILO
  IOSdinp=. (<: ILO) + i. dlen
  p=. (>: IOSdinp) IOSdinp } SCALE
  P=. makepermat p
  iP=. |: P
  PAiP=. P mp y mp iP
  if. dlen -: n do.
    'T1 X Y Z10 B Z Z20 Z21 T2'=. 0 1 0 2 3 2 0 1 0 { (0 0 $ 0) ; ((0,n) $ 0) ; ((n,0) $ 0) ; y
  else.
    bcut=. 1 (0) } ((<: ILO) , IHI) e.~ i. n
    'T1 X Y Z10 B Z Z20 Z21 T2'=. , (;~ bcut) <;.1 PAiP
  end.
  d=. IOSdinp { SCALE
  D=. diagmat d
  iD=. diagmat % d
  XD=. X mp D
  iDBD=. iD mp B mp D
  iDZ=. iD mp Z
  smoutput a=. AB match (T1 ,. XD ,. Y) , (Z10 ,. iDBD ,. iDZ) , (Z20 ,. Z21 ,. T2)
else.
  smoutput a=. AB match 0 0$0
end.
0 pick a
)

NB. =========================================================
NB. test matrices:

testgebal=: 3 : 0
m0=. 0 0$0
m1=. 7 7 $ 6 0 0 0 0 1 0 0 4 0 0.00025 0.0125 0.02 0.125 1 128 64 0 0 _2 16 0 16384 0 1 _400 256 _4000 _2 _256 0 0.0125 2 2 32 0 0 0 0 0 0 0 0 8 0 0.004 0.125 _0.2 3
m2=. 0 0$zzero
m3=. 6 6 $ 1j1 1j1 0 1j1 1j1 1j1 1j1 1j1 0 1j1 1j1 1j1 1j1 1j1 1j1 1j1 1j1 1j1 0 0 0 1j1 0 0 1j1 1j1 0 1j1 1j1 1j1 1j1 1j1 0 1j1 1j1 1j1
tgebal &> m0;m1;m2;m3
)
