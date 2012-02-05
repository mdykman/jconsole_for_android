NB. Solve linear monomial equation
NB.
NB. gesvxxx   Solve equation (op(A) * X = B) or
NB.           (X * op(A) = B), where A is a general matrix;
NB.           op(A) is either A itself, or A^T (the
NB.           transposition of A), or A^H (the conjugate
NB.           transposition of A); B is known right-hand side
NB.           (RHS), X is unknown solution
NB. hesvxxx   Solve equation (op(A) * X = B) or
NB.           (X * op(A) = B), where A is a Hermitian
NB.           (symmetric) matrix; op(A) is either A itself,
NB.           or A^T (the transposition of A); B is known
NB.           right-hand side (RHS), X is unknown solution
NB. posvxxx   Solve equation (op(A) * X = B) or
NB.           (X * op(A) = B), where A is a Hermitian
NB.           (symmetric) positive definite matrix; op(A) is
NB.           either A itself, or A^T (the transposition of
NB.           A); B is known right-hand side (RHS), X is
NB.           unknown solution
NB. ptsvxxx   Solve equation (op(A) * X = B) or
NB.           (X * op(A) = B), where A is a Hermitian
NB.           (symmetric) positive definite tridiagonal
NB.           matrix; op(A) is either A itself, or A^T (the
NB.           transposition of A); B is known right-hand side
NB.           (RHS), X is unknown solution
NB.
NB. testgesv  Test gesvxxx by general matrix given
NB. testhesv  Test hesvxxx by Hermitian (symmetric) matrix
NB.           given
NB. testposv  Test posvxxx by Hermitian (symmetric) positive
NB.           definite matrix given
NB. testptsv  Test ptsvxxx by Hermitian (symmetric) positive
NB.           definite tridiagonal matrix given
NB. testsv    Adv. to make verb to test xxsvxxx by matrix of
NB.           generator and shape given
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

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. Verb:          Solves:         Syntax:
NB. gesvax         A   * X = B     Xv=. A gesvax  Bv
NB. gesvahx        A^H * X = B     Xv=. A gesvahx Bv
NB. gesvatx        A^T * X = B     Xv=. A gesvatx Bv
NB. gesvxa         X * A   = B     Xh=. A gesvxa  Bh
NB. gesvxah        X * A^H = B     Xh=. A gesvxah Bh
NB. gesvxat        X * A^T = B     Xh=. A gesvxat Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with general matrix A
NB.   via triangular factorization:
NB.     L * U1 * P = A
NB. where:
NB.   A    - n×n-matrix
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   P    - n×n-matrix, columns permutation of A
NB.   L1   - n×n-matrix, unit lower triangular
NB.   U    - n×n-matrix, upper triangular
NB.   nrhs ≥ 0
NB.
NB. Notes:
NB. - gesvax implements LAPACK's xGESV

gesvax=:  (getrspl1ux ~ getrfpl1u)~
gesvahx=: (getrspl1uhx~ getrfpl1u)~
gesvatx=: (getrspl1utx~ getrfpl1u)~
gesvxa=:  (getrsxpl1u ~ getrfpl1u)~
gesvxah=: (getrsxpl1uh~ getrfpl1u)~
gesvxat=: (getrsxpl1ut~ getrfpl1u)~

NB. ---------------------------------------------------------
NB. Verb:          Solves:         Syntax:
NB. hesvax         A   * X = B     Xv=. A hesvax  Bv
NB. hesvatx        A^T * X = B     Xv=. A hesvatx Bv
NB. hesvxa         X * A   = B     Xh=. A hesvxa  Bh
NB. hesvxat        X * A^T = B     Xh=. A hesvxat Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with Hermitian
NB.   (symmetric) matrix A via triangular factorization:
NB.     P * L1 * T * L1^H * P^H = A
NB. where:
NB.   A    - n×n-matrix, Hermitian (symmetric)
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   P    - n×n-matrix, full permutation of A
NB.   L1   - n×n-matrix, unit lower triangular
NB.   T    - n×n-matrix, Hermitian (symmetric) tridiagonal
NB.   nrhs ≥ 0
NB.
NB. Notes:
NB. - implements LAPACK's DSYSV('L'), ZHESV('L')

hesvax=:  (hetrsplx ~ hetrfpl)~
hesvatx=: (hetrspltx~ hetrfpl)~
hesvxa=:  (hetrsxpl ~ hetrfpl)~
hesvxat=: (hetrsxplt~ hetrfpl)~

NB. ---------------------------------------------------------
NB. Verb:          Solves:         Syntax:
NB. posvax         A   * X = B     Xv=. A posvax  Bv
NB. posvatx        A^T * X = B     Xv=. A posvatx Bv
NB. posvxa         X * A   = B     Xh=. A posvxa  Bh
NB. posvxat        X * A^T = B     Xh=. A posvxat Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with Hermitian
NB.   (symmetric) positive definite matrix A via Cholesky
NB.   factorization:
NB.     L * L^H = A
NB. where:
NB.   A    - n×n-matrix, Hermitian (symmetric) positive
NB.          definite
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   L    - n×n-matrix, lower triangular with positive
NB.          diagonal entries, Cholesky triangle
NB.   nrhs ≥ 0
NB.
NB. Notes:
NB. - implements LAPACK's xPOSV('L')

posvax=:  (potrslx ~ potrfl)~
posvatx=: (potrsltx~ potrfl)~
posvxa=:  (potrsxl ~ potrfl)~
posvxat=: (potrsxlt~ potrfl)~

NB. ---------------------------------------------------------
NB. Verb:          Solves:         Syntax:
NB. ptsvax         A   * X = B     Xv=. A ptsvax  Bv
NB. ptsvatx        A^T * X = B     Xv=. A ptsvatx Bv
NB. ptsvxa         X * A   = B     Xh=. A ptsvxa  Bh
NB. ptsvxat        X * A^T = B     Xh=. A ptsvxat Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with Hermitian
NB.   (symmetric) positive definite tridiagonal matrix A via
NB.   factorization:
NB.     L1 * D * L1^H = A
NB. where:
NB.   A    - n×n-matrix, Hermitian (symmetric) positive
NB.          definite tridiagonal
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   L1   - n×n-matrix, unit lower bidiangonal
NB.   D    - n×n-matrix, diagonal with positive diagonal
NB.          entries
NB.   nrhs ≥ 0
NB.
NB. Notes:
NB. - implements LAPACK's xPTSV

ptsvax=:  (pttrslx ~ pttrfl)~
ptsvatx=: (pttrsltx~ pttrfl)~
ptsvxa=:  (pttrsxl ~ pttrfl)~
ptsvxat=: (pttrsxlt~ pttrfl)~

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testgesv
NB.
NB. Description:
NB.   Test:
NB.   - %. (built-in)
NB.   - gesv (math/lapack addon)
NB.   - gesvxxx (math/mt addon)
NB.   by general matrix given
NB.
NB. Syntax:
NB.   testgesv (A;X)
NB. where
NB.   A - n×n-matrix
NB.   X - n×n-matrix, exact solution
NB.
NB. Formula:
NB.   ferr := max(||X - exactX|| / ||X||)
NB.   berr := max(||B - op(A) * X|| / (ε * ||op(A)|| * ||X||))

testgesv=: 3 : 0
  require :: ] '~addons/math/lapack/lapack.ijs'
  need_jlapack_ :: ] 'gesv'

  'A X'=. y
  'conA conAh conAt'=. gecon1"2 (] , ct ,: |:) A

  ('%.' tdyad ((mp & >/)`(0 & {::)`]`(conA "_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) y

  ('gesv_jlapack_' tmonad (((0 & {::);(mp & >/))`]`(conA"_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) y

  ('gesvax'  tdyad  (    (0 & {::) `(mp  & >/)`]`(conA "_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp  & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) y
  ('gesvahx' tdyad  ((ct@(0 & {::))`(mp  & >/)`]`(conAh"_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp  & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) ((ct A);X)
  ('gesvatx' tdyad  ((|:@(0 & {::))`(mp  & >/)`]`(conAt"_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp  & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) ((|: A);X)
  ('gesvxa'  tdyad  (    (0 & {::) `(mp~ & >/)`]`(conA "_)`(normi@(((- (% & normir) [) (1 & {::))~))`(normi@((norm1tr@(((mp~ & >/)@[) - (mp  (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tr@]))))))) y
  ('gesvxah' tdyad  ((ct@(0 & {::))`(mp~ & >/)`]`(conAh"_)`(normi@(((- (% & normir) [) (1 & {::))~))`(normi@((norm1tr@(((mp~ & >/)@[) - (mp  (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tr@]))))))) ((ct A);X)
  ('gesvxat' tdyad  ((|:@(0 & {::))`(mp~ & >/)`]`(conAt"_)`(normi@(((- (% & normir) [) (1 & {::))~))`(normi@((norm1tr@(((mp~ & >/)@[) - (mp  (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tr@]))))))) ((|: A);X)

  EMPTY
)

NB. ---------------------------------------------------------
NB. testhesv
NB.
NB. Description:
NB.   Test hesvxxx by Hermitian (symmetric) matrix given
NB.
NB. Syntax:
NB.   testhesv (A;X)
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric)
NB.   X - n×n-matrix, exact solution
NB.
NB. Formula:
NB. - ferr := max(||X - exactX|| / ||X||)
NB. - berr := max(||B - op(A) * X|| / (ε * ||op(A)|| * ||X||))

testhesv=: 3 : 0
  'A X'=. y
  'conA conAt'=. hecon1"2 (] ,: |:) A

  ('hesvax'  tdyad (    (0 & {::) `(mp  & >/)`]`(conA "_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp  & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) y
  ('hesvatx' tdyad ((|:@(0 & {::))`(mp  & >/)`]`(conAt"_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp  & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) ((|: A);X)
  ('hesvxa'  tdyad (    (0 & {::) `(mp~ & >/)`]`(conA "_)`(normi@(((- (% & normir) [) (1 & {::))~))`(normi@((norm1tr@(((mp~ & >/)@[) - (mp  (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tr@]))))))) y
  ('hesvxat' tdyad ((|:@(0 & {::))`(mp~ & >/)`]`(conAt"_)`(normi@(((- (% & normir) [) (1 & {::))~))`(normi@((norm1tr@(((mp~ & >/)@[) - (mp  (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tr@]))))))) ((|: A);X)

  EMPTY
)

NB. ---------------------------------------------------------
NB. testposv
NB.
NB. Description:
NB.   Test posvxxx by Hermitian (symmetric) positive definite
NB.   matrix given
NB.
NB. Syntax:
NB.   testposv (A;X)
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive definite
NB.   X - n×n-matrix, exact solution
NB.
NB. Formula:
NB. - ferr := max(||X - exactX|| / ||X||)
NB. - berr := max(||B - op(A) * X|| / (ε * ||op(A)|| * ||X||))

testposv=: 3 : 0
  'A X'=. y
  'conA conAt'=. pocon1"2 (] ,: |:) A

  ('posvax'  tdyad (    (0 & {::) `(mp  & >/)`]`(conA "_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp  & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) y
  ('posvatx' tdyad ((|:@(0 & {::))`(mp  & >/)`]`(conAt"_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp  & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) ((|: A);X)
  ('posvxa'  tdyad (    (0 & {::) `(mp~ & >/)`]`(conA "_)`(normi@(((- (% & normir) [) (1 & {::))~))`(normi@((norm1tr@(((mp~ & >/)@[) - (mp  (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tr@]))))))) y
  ('posvxat' tdyad ((|:@(0 & {::))`(mp~ & >/)`]`(conAt"_)`(normi@(((- (% & normir) [) (1 & {::))~))`(normi@((norm1tr@(((mp~ & >/)@[) - (mp  (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tr@]))))))) ((|: A);X)

  EMPTY
)

NB. ---------------------------------------------------------
NB. testptsv
NB.
NB. Description:
NB.   Test ptsvxxx by Hermitian (symmetric) positive definite
NB.   tridiagonal matrix given
NB.
NB. Syntax:
NB.   testptsv (A;X)
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive definite
NB.       tridiagonal
NB.   X - n×n-matrix, exact solution
NB.
NB. Formula:
NB. - ferr := max(||X - exactX|| / ||X||)
NB. - berr := max(||B - op(A) * X|| / (ε * ||op(A)|| * ||X||))

testptsv=: 3 : 0
  'A X'=. y
  'conA conAt'=. ptcon1"2 (] ,: |:) A

  ('ptsvax'  tdyad (    (0 & {::) `(mp  & >/)`]`(conA "_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp  & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) y
  ('ptsvatx' tdyad ((|:@(0 & {::))`(mp  & >/)`]`(conAt"_)`(normi@(((- (% & normic) [) (1 & {::))~))`(normi@((norm1tc@(((mp  & >/)@[) - (mp~ (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tc@]))))))) ((|: A);X)
  ('ptsvxa'  tdyad (    (0 & {::) `(mp~ & >/)`]`(conA "_)`(normi@(((- (% & normir) [) (1 & {::))~))`(normi@((norm1tr@(((mp~ & >/)@[) - (mp  (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tr@]))))))) y
  ('ptsvxat' tdyad ((|:@(0 & {::))`(mp~ & >/)`]`(conAt"_)`(normi@(((- (% & normir) [) (1 & {::))~))`(normi@((norm1tr@(((mp~ & >/)@[) - (mp  (0 & {::))~)) % (((FP_EPS*norm1@(0 {:: [))*(norm1tr@]))))))) ((|: A);X)

  EMPTY
)

NB. ---------------------------------------------------------
NB. testsv
NB.
NB. Description:
NB.   Adv. to make verb to test xxsvxxx by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testsv
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
NB.     ?@$&0 testsv_mt_ 150 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) testsv_mt_ 150 150
NB. - test by random square complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testsv_mt_ 150 150

testsv=: 1 : 'EMPTY_mt_ [ ((testptsv_mt_ @ ((u ptmat_mt_) ; u)) [ (testposv_mt_ @ ((u pomat_mt_) ; u)) [ ((testhesv_mt_ @ ((u hemat_mt_) ; u))) [ (testgesv_mt_ @ (u ; u))) ^: (=/)'
