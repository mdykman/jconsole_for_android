NB. Matrix exponential
NB.
NB. geexp      Matrix exponential of a general matrix
NB. diexp      Matrix exponential of a diagonalizable matrix
NB. heexp      Matrix exponential of a Hermitian (symmetric)
NB.            matrix
NB.
NB. testgeexp  Test geexp by general matrix given
NB. testdiexp  Test diexp by diagonalizable matrix given
NB. testheexp  Test heexp by Hermitian (symmetric) matrix
NB.            given
NB. testexp    Adv. to make verb to test xxexp by matrix of
NB.            generator and shape given
NB.
NB. Version: 0.7.0 2011-08-06
NB.
NB. Copyright 2010-2011 Igor Zhuravlev
NB.
NB. This file is part of mt
NB.
NB. mt is free software: you can redistribute it and/or
NB. modify it under the terms of the GNU Lesser General
NB. Public License as published by the Free Software
NB. Foundation, either version 3 of the License, or (at your
NB. option) any later version.
NB.
NB. mt is distributed in the hope that it will be useful, but
NB. WITHOUT ANY WARRANTY; without even the implied warranty
NB. of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
NB. See the GNU Lesser General Public License for more
NB. details.
NB.
NB. You should have received a copy of the GNU Lesser General
NB. Public License along with mt. If not, see
NB. <http://www.gnu.org/licenses/>.

coclass 'mt'

NB. =========================================================
NB. Local definitions

NB. ---------------------------------------------------------
NB. sdiag
NB.
NB. Description:
NB.   Shift diagonal in each table of report y by corresp.
NB.   atom from x
NB.
NB. Syntax:
NB.   B=. s sdiag A
NB. where
NB.   A - n×n-matrix or m×n×n-report
NB.   s - scalar or m-vector, shift of diagonal[s] in A
NB.   B - array of the same shape as A, the shifted A:
NB.          B -: A + s (*"0 2) idmat n
NB.
NB. TODO:
NB. - generalize A shape

sdiag=: (,@:+ diag"2) ((i.@{. * */@}.)@(_3&({.!.1)) ,@:(+"0 1) (i. * >:)@{:)@$@]} ]

NB. ---------------------------------------------------------
NB. geexpm2r
NB.
NB. Description:
NB.   Find r_m(A) = [m/m] Padé approximant of general matrix
NB.
NB. Syntax:
NB.   r=. m geexpm2r A
NB. where
NB.   A - n×n-matrix
NB.   m ≥ 0, integer, approximant's degree
NB.   r - n×n-matrix, r_m(A)

geexpm2r=: 4 : 0
  rbyvs=. +/ @ (* " 3 1)        NB. multiply report x by each row of x, then sum reports
  b0b1=. ((0 0 ; 1 0) & {) @ ]  NB. extract (b[0] , b[1]) from y

  NB. b[i] coeffcients of degree 13 Padé approximant for V (1st row) and U (2nd row)
  bc=. _2 (|: @ (]\)) (>: x) {. 64764752532480000x 32382376266240000x 7771770303897600x 1187353796428800x 129060195264000x 10559470521600x 670442572800x 33522128640x 1323241920x 40840800x 960960x 16380x 182x 1x

  NB. U=. A*Σ(b[i+1]*(A^i),i=0,2,..,m-1)
  NB. V=.   Σ(b[i  ]*(A^i),i=0,2,..,m-1)
  if. x < 13 do.
    NB. A powers (2 [4 [6 [8]]]), shape: p×n×n
    pA=. (+: }. i. >. -: x) gepow y

    NB. - multiply each table in pA by corresp. atom b[i], output: report 2×p×n×n
    NB. - sum multiplied tables, output: report 2×n×n
    NB. - shift 1st table's diagonal by b[0], 2nd table's diagonal by b[1]
    'V U'=. pA (b0b1 sdiag (rbyvs (0 1 & }.))) bc
  else.
    NB. report of A powers (2 4 6)
    pA=. 2 4 6 gepow y

    NB. V=. (b[8]*(A^2)+b[10]*(A^4)+b[12]*(A^6)) * (A^6)
    NB. U=. (b[9]*(A^2)+b[11]*(A^4)+b[13]*(A^6)) * (A^6)
    NB. VU=. V ,: U
    VU=. pA (({: @ [) (mp " 2 2) (rbyvs (2 _3 & {.))) bc

    NB. V=.      V + b[6]*A6+b[4]*A4+b[2]*A2+b[0]*I
    NB. U=. A * (U + b[7]*A6+b[5]*A4+b[3]*A2+b[1]*I)
    'V U'=. VU + pA (b0b1 sdiag (rbyvs ((0 1 ,: 2 3) & (] ;. 0)))) bc
  end.
  U=. y mp U

  NB. find r_m(A) = [m/m] Padé approximant to A
  r=. V (- gesvax +) U
)

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. geexp
NB.
NB. Description:
NB.   Matrix exponential of a general matrix
NB.
NB. Syntax:
NB.   E=. geexp A
NB. where
NB.   A - n×n-matrix
NB.   E - n×n-matrix, matrix exponential e^A
NB.
NB. References:
NB. [1] N. J. Higham, The scaling and squaring method for the
NB.     matrix exponential revisited, SIAM J. Matrix Anal.
NB.     Appl. Vol. 26, No. 4, pp. 1179–1193

geexp=: 3 : 0
  vm=. 3 5 7 9 13                          NB. Padé approximant degrees m
  THETA=. 24774315513739r1656496414665010 2287286674603605r9007199254740992 1070075424639547r1125899906842624  1180983412074661r562949953421312 1512061155730925r281474976710656
                                           NB. θ[m] coeffcients

  NB. preprocess A
  mu=. (trace % #) y                       NB. calc shift value
  y=. (- mu) sdiag y                       NB. shift diagonal
  'y d'=. 0 3 { gebals (];(a:"_);(0,#)) y  NB. balance A to reduce 1-norm

  iom=. THETA I. normA=. norm1 y

  NB. find r_m(A) = [m/m] Padé approximant to A
  if. iom < # vm do.
    y=. (iom { vm) geexpm2r y              NB. use max m such that ||A|| <= θ[m]
  else.
    s=. >. 2 ^. normA % {: THETA           NB. find a minimal integer such that ||A/2^s||≤θ[13]
    y=. y % 2 ^ s                          NB. scaling
    y=. 13 geexpm2r y                      NB. use m=13
    y=. mp~ ^: s y                         NB. undo scaling
  end.
  (^ mu) *  y (] * (% " 1)) d              NB. undo preprocessing
)

NB. ---------------------------------------------------------
NB. diexp
NB.
NB. Description:
NB.   Matrix exponential of a diagonalizable matrix
NB.
NB. Syntax:
NB.   E=. diexp iLl ; vl ; Ll
NB.   E=. diexp (ct Rl) ; vl ; ct iRl
NB.   E=. diexp (ct iLu) ; vu ; ct Lu
NB.   E=. diexp Ru ; vu ; iRu
NB. where
NB.   Ll  - n×n-matrix, rows are left eigenvectors of A,
NB.         output of geevlvx
NB.   Lu  - n×n-matrix, columns are left eigenvectors of A,
NB.         output of geevuvx
NB.   Rl  - n×n-matrix, rows are right eigenvectors of A,
NB.         output of geevlxv
NB.   Ru  - n×n-matrix, columns are right eigenvectors of A,
NB.         output of geevuxv
NB.   vl  - n-vector, eigenvalues of A, output of geevlxx
NB.   vu  - n-vector, eigenvalues of A, output of geevuxx
NB.   iLl -: Ll^_1
NB.   iLu -: Lu^_1
NB.   iRl -: Rl^_1
NB.   iRu -: Ru^_1
NB.   E   - n×n-matrix, matrix exponential e^A
NB.
NB. Assertions (with appropriate comparison tolerance):
NB. - lower case:
NB.   ((-: ~.) v) +. ((-: ct) A)  NB. A must be normal (diagonalizable)
NB.   (L mp A) -: V mp L          NB. verify...
NB.   (A mp ct R) -: (ct R) mp V  NB. ...eigendecomposition
NB.   W -: L mp (ct R)            NB. LAPACK doesn't guarantee (W -: idmat # A)
NB.   iL -: (ct R) %"1 w          NB. see [1]
NB.   (ct iR) -: L % w            NB. see [1]
NB.   A -: iL mp V mp L
NB.   A -: iL mp v * L
NB.   A -: (ct R) mp V mp ct iR
NB.   A -: (ct R) mp v * ct iR
NB.   F -: diagmat f
NB.   E -: iL mp F mp L
NB.   E -: iL mp f * L
NB.   E -: (ct R) mp F mp ct iR
NB.   E -: (ct R) mp f * ct iR
NB.   E -: diexp iL ; v ; L
NB.   E -: diexp (ct R) ; v ; ct iR
NB. where
NB.   'v LR'=. geevlvv A  NB. use definition from ggevlxx application notes
NB.   'L R'=. LR
NB.   iL=. %. L
NB.   iR=. %. R
NB.   V=. diagmat v
NB.   w=. L mp"1 + R
NB.   W=. diagmat w
NB.   E=. geexp A
NB.   f=. ^ v
NB.   F=. geexp V
NB. - upper case:
NB.   ((-: ~.) v) +. ((-: ct) A)  NB. A must be normal (diagonalizable)
NB.   ((ct L) mp A) -: V mp ct L  NB. verify...
NB.   (A mp R) -: R mp V          NB. ...eigendecomposition
NB.   W -: (ct L) mp R            NB. LAPACK doesn't guarantee (W -: idmat # A)
NB.   (ct iL) -: R %"1 w          NB. see [1]
NB.   iR -: (ct L) % w            NB. see [1]
NB.   A -: (ct iL) mp V mp ct L
NB.   A -: (ct iL) mp v * ct L
NB.   A -: R mp V mp iR
NB.   A -: R mp v * iR
NB.   F -: diagmat f
NB.   E -: (ct iL) mp F mp ct L
NB.   E -: (ct iL) mp f * ct L
NB.   E -: R mp F mp iR
NB.   E -: R mp f * iR
NB.   E -: diexp (ct iL) ; v ; ct L
NB.   E -: diexp R ; v ; iR
NB. where
NB.   'v LR'=. geevuvv A  NB. use definition from ggevuxx application notes
NB.   'L R'=. LR
NB.   iL=. %. L
NB.   iR=. %. R
NB.   V=. diagmat v
NB.   w=. (ct L) mp"1 |: R
NB.   W=. diagmat w
NB.   E=. geexp A
NB.   f=. ^ v
NB.   F=. geexp V
NB.
NB. References:
NB. [1] http://icl.cs.utk.edu/lapack-forum/viewtopic.php?p=985#p985
NB.     LAPACK/ScaLAPACK Development ‹ DGEEVX and left eigenvectors
NB.     Julien Langou, Fri Dec 22, 2006 5:15 pm

diexp=: (0 & {::) mp (^ @: (1 & {::)) * (2 & {::)

NB. ---------------------------------------------------------
NB. heexp
NB.
NB. Description:
NB.   Matrix exponential of a Hermitian (symmetric) matrix
NB.
NB. Syntax:
NB.   E=. heexp vl ; iRl
NB.   E=. heexp vu ; Ru
NB. where
NB.   Rl  - n×n-matrix, rows are eigenvectors of A, output of
NB.         heevlv
NB.   Ru  - n×n-matrix, columns are eigenvectors of A, output
NB.         of heevuv
NB.   vl  - n-vector, eigenvalues of A, output of heevlx
NB.   vu  - n-vector, eigenvalues of A, output of heevux
NB.   iRl -: Rl^_1
NB.   E   - n×n-matrix, matrix exponential e^A
NB.
NB. Assertions (with appropriate comparison tolerance):
NB. - lower case:
NB.   (-: ct) A           NB. A must be Hermitian (symmetric)
NB.   (R mp A) -: V mp R  NB. verify eigendecomposition
NB.   iR -: ct R
NB.   A -: iR mp V mp R
NB.   A -: iR mp v * R
NB.   F -: diagmat f
NB.   E -: iR mp F mp R
NB.   E -: iR mp f * R
NB.   E -: heexp v ; iR
NB. where
NB.   'v R'=. heevlv A  NB. use definition from ggevlxx application notes
NB.   iR=. %. R
NB.   V=. diagmat v
NB.   E=. geexp A
NB.   f=. ^ v
NB.   F=. geexp V
NB. - upper case:
NB.   (-: ct) A           NB. A must be Hermitian (symmetric)
NB.   (A mp R) -: R mp V  NB. verify eigendecomposition
NB.   iR -: ct R
NB.   A -: R mp V mp iR
NB.   A -: R mp v * iR
NB.   F -: diagmat f
NB.   E -: R mp F mp iR
NB.   E -: R mp f * iR
NB.   E -: heexp v ; R
NB. where
NB.   'v R'=. heevuv A  NB. use definition from ggevuxx application notes
NB.   iR=. %. R
NB.   V=. diagmat v
NB.   E=. geexp A
NB.   f=. ^ v
NB.   F=. geexp V

heexp=: ([ mp ((* ct)~ ^))~ & >/

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testgeexp
NB.
NB. Description:
NB.   Test geexp by general matrix given
NB.
NB. Syntax:
NB.   testgeexp A
NB. where
NB.   A - n×n-matrix

testgeexp=: 3 : 0
  rcond=. gecon1 y

  ('geexp' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testdiexp
NB.
NB. Description:
NB.   Test diexp by diagonalizable matrix given
NB.
NB. Syntax:
NB.   testdiexp A
NB. where
NB.   A - n×n-matrix, diagonalizable

testdiexp=: 3 : 0
  NB. use for a while the definition from ggevlxx application notes
  geevlvv=. 0 1 ({.&.>)`(((**@+@((i.>./)"1@sorim{"0 1]))%norms"1)"2&.>)ag ggevlvv@(,:(idmat@c))

  rcond=. gecon1 y
  try.
    'v LR'=. geevlvv y                 NB. eigendecomposition
    'L R'=. LR
    v=. j./ (*"1 (-@*@{.)) |: +. v     NB. for each v[i] in v, flip sign of v[i] if Re(v[i])>0, to force
                                       NB. A to be negative definite, this will avoid NaN error in diexp
    assert ((-: ~.) v) +. ((-: ct) y)  NB. A must be normal (diagonalizable)
    iRh=. L ([ % (mp"1 +)) R           NB. reconstruct R^_1^H , see [1] in diexp
  catch.
    R=. v=. iRh=. _.
  end.

  ('diexp' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) (ct R) ; v ; iRh

  EMPTY
)

NB. ---------------------------------------------------------
NB. testheexp
NB.
NB. Description:
NB.   Test heexp by Hermitian (symmetric) matrix given
NB.
NB. Syntax:
NB.   testheexp A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric)

testheexp=: 3 : 0
  NB. use for a while the definition from ggevlxx application notes
  heevlv=. 0 1 ((9 o.{.)&.>)`((%%:@diag@(mp ct))&.>)ag ggevlvn@(,:(idmat@c))

  rcond=. hecon1 y
  try.
    'v R'=. heevlv y                NB. eigendecomposition
    v=. j./ (*"1 (-@*@{.)) |: +. v  NB. for each v[i] in v, flip sign of v[i] if Re(v[i])>0, to force
                                    NB. A to be negative definite, this will avoid NaN error in heexp
  catch.
    v=. R=. _.
  end.

  ('heexp' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) v ; ct R

  EMPTY
)

NB. ---------------------------------------------------------
NB. testexp
NB.
NB. Description:
NB.   Adv. to make verb to test xxexp by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testexp
NB. where
NB.   mkmat - monad to generate a matrix; is called as:
NB.             mat=. mkmat (m,n)
NB.   vtest - monad to test algorithms by matrix mat; is
NB.           called as:
NB.             vtest (m,n)
NB.   (m,n) - 2-vector of integers, the shape of matrix mat
NB.
NB. Application:
NB. - test by random square real matrix with elements
NB.   distributed uniformly with support (0,1):
NB.     ?@$&0 testexp_mt_ 150 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) testexp_mt_ 150 150
NB. - test by random square complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testexp_mt_ 150 150

testexp=: 1 : 'EMPTY_mt_ [ ((testheexp_mt_ @ (u hemat_mt_)) [ (testdiexp_mt_ @ (u dimat_mt_ u)) [ (testgeexp_mt_ @ u)) ^: (=/)'
