NB. gels   solves overdetermined or underdetermined systems

coclass 'jlapack'

NB. =========================================================
NB.*gels v solves overdetermined or underdetermined linear
NB.        systems, using a QR or LQ factorization
NB.
NB. syntax:
NB.   X=. gels A;B
NB. where
NB.   A    - M-by-N matrix, assumed as having full rank
NB.   B    - M-by-NRHS matrix or N-vector
NB.   X    - has the shape of B
NB.   M    >= 0
NB.   N    >= 0
NB.   NRHS >= 0
NB.
NB. if:
NB.   X=. gels A;B
NB. then
NB.   B -: A mp X
NB.   X -: (%.A) mp B

gels=: (3 : 0) " 0 1

y=. z2d each y
ic=. +./ iscomplex &> y
zero=. ic {:: dzero ; zzero
routine=. ic { 'dgels' ,: 'zgels'
'ma mvb'=. y

vmatrix ma
vmatrixorvector mvb

'm n'=. $ma
if. m ~: #mvb do.
  error routine;'matrices should have the same number of rows'
end.

trans=. 'N'
nrhs=. {: 2 ($!.1)$mvb
a=. zero + |:ma
lda=. 1 >. m
ldb=. 1 >. m >. n
b=. zero + |: ldb {. mvb
lwork=. 10 * (m <. n) + (ldb >. nrhs)
work=. lwork$zero
info=. izero

sb=. $b

arg=. 'trans;m;n;nrhs;a;lda;b;ldb;work;lwork;info'

(cutarg arg)=. routine call , each ".arg

if. info~:0 do.
  error routine;'info result: ',":info return.
end.

n {. (|: @: (sb & $))^:(ismatrix mvb) b
)

NB. =========================================================
NB.*tgels v test gesvx

tgels=: 3 : 0
'a b'=. y
match=. matchclean;;
smoutput x=. gels y
smoutput r=. b match clean a mp x
0 pick r
)

NB. =========================================================
NB. test matrices:

testgels=: 3 : 0
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
tgels &> (< dma0;dmb0) , (< dma1;dmb1) , (< dma2;dmb2) , (< dma3;dvb3) , (< dma4;dvb4) , (< dma5;dvb5) , (< zma0;zmb0) , (< zma1;zmb1) , (< zma2;zmb2) , (< zma3;zvb3) , (< zma4;zvb4) , (< zma5;zvb5)
)

NB. least squares tests from http://www.nag.co.uk/lapack-ex/lapack-ex.html
NB.
NB.    dma=. 6 4 $ _0.57 _1.28 _0.39 0.25 _1.93 1.08 _0.31 _2.14 2.30 0.24 0.40 _0.35 _1.93 0.64 _0.66 0.08 0.15 0.30 0.15 _2.13 _0.02 1.03 _1.43 0.50
NB.    dvb=. _2.67 _0.55 3.34 _0.77 0.48 4.10
NB.    dvx=. 1.5339 1.8707 _1.5241 0.0392
NB.    tgels dma;dvb
NB. 1.53387 1.87075 _1.52407 0.039183
NB.
NB.    zma=. 6 4 $ 0.96j_0.81 _0.03j0.96 _0.91j2.06 _0.05j0.41 _0.98j1.98 _1.20j0.19 _0.66j0.42 _0.81j0.56 0.62j_0.46 1.01j0.02 0.63j_0.17 _1.11j0.60 _0.37j0.38 0.19j_0.54 _0.98j_0.36 0.22j_0.20 0.83j0.51 0.20j0.01 _0.17j_0.46 1.47j1.59 1.08j_0.28 0.20j_0.12 _0.07j1.23 0.26j0.26
NB.    zvb=. _2.09j1.93 3.34j_3.53 _4.94j_2.04 0.17j4.23 _5.19j3.63 0.98j2.53
NB.    zvx=. _0.5044j_1.2179 _2.4281j2.8574 1.4872j_2.1955 0.4537j2.6904
NB.    tgels zma;zvb
NB. _0.504365j_1.21788 _2.42815j2.85742 1.48717j_2.19548 0.453708j2.69041
