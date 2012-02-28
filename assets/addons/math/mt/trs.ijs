NB. Solve linear monomial equation by triangular
NB. factorization
NB.
NB. getrsxxxxxx  Solve equation (op(A) * X = B) or
NB.              (X * op(A) = B), where A is a general
NB.              matrix, represented in factored form; op(A)
NB.              is either A itself, or A^T (the
NB.              transposition of A), or A^H (the conjugate
NB.              transposition of A); B is known right-hand
NB.              side (RHS), X is unknown solution
NB. hetrsxxxx    Solve equation (op(A) * X = B) or
NB.              (X * op(A) = B), where A is a Hermitian
NB.              (symmetric) matrix, represented in factored
NB.              form; op(A) is either A itself, or A^T (the
NB.              transposition of A); B is known right-hand
NB.              side (RHS), X is unknown solution
NB. potrsxxx     Solve equation (op(A) * X = B) or
NB.              (X * op(A) = B), where A is a Hermitian
NB.              (symmetric) positive definite matrix,
NB.              represented in factored form; op(A) is
NB.              either A itself, or A^T (the transposition
NB.              of A); B is known right-hand side (RHS), X
NB.              is unknown solution
NB. pttrsxxx     Solve equation (op(A) * X = B) or
NB.              (X * op(A) = B), where A is a Hermitian
NB.              (symmetric) positive definite tridiagonal
NB.              matrix, represented in factored form; op(A)
NB.              is either A itself, or A^T (the
NB.              transposition of A); B is known right-hand
NB.              side (RHS), X is unknown solution
NB.
NB. testgetrs    Test getrsxxxxxx by general matrix given
NB. testhetrs    Test hetrsxxxx by Hermitian (symmetric)
NB.              matrix given
NB. testpotrs    Test potrsxxx by Hermitian (symmetric)
NB.              positive definite matrix given
NB. testpttrs    Test pttrsxxx by Hermitian (symmetric)
NB.              positive definite tridiagonal matrix given
NB. testtrs      Adv. to make verb to test xxtrsxxx by matrix
NB.              of generator and shape given
NB.
NB. Version: 0.7.0 2011-08-06
NB.
NB. Copyright 2010-2011 Igor Zhuravlov
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
NB. Verb:           Solves:         Syntax:
NB. getrslu1px      A   * X = B     Xv=. LU1p getrslu1px  Bv
NB. getrslu1phx     A^H * X = B     Xv=. LU1p getrslu1phx Bv
NB. getrslu1ptx     A^T * X = B     Xv=. LU1p getrslu1ptx Bv
NB. getrsxlu1p      X * A   = B     Xh=. LU1p getrsxlu1p  Bh
NB. getrsxlu1ph     X * A^H = B     Xh=. LU1p getrsxlu1ph Bh
NB. getrsxlu1pt     X * A^T = B     Xh=. LU1p getrsxlu1pt Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with general square
NB.   matrix A, represented in factored form:
NB.     L * U1 * P = A
NB. where:
NB.   A    - n×n-matrix
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   LU1p - 2-vector of boxes, the output of getrflu1p, the
NB.          matrix A represented in factored form
NB.   nrhs ≥ 0, number of RHSs
NB.
NB. Assertions:
NB.   Xv -: clean LU1p getrslu1px      A  mp  Xv
NB.   Xv -: clean LU1p getrslu1phx (ct A) mp  Xv
NB.   Xv -: clean LU1p getrslu1ptx (|: A) mp  Xv
NB.   Xh -: clean LU1p getrsxlu1p      A  mp~ Xh
NB.   Xh -: clean LU1p getrsxlu1ph (ct A) mp~ Xh
NB.   Xh -: clean LU1p getrsxlu1pt (|: A) mp~ Xh
NB. where
NB.   LU1p=. getrflu1p A

getrslu1px=:  (0 {:: [) C.^:_1   ((] trsmu1x  trsmlx ~) 1&{::)~
getrsxlu1ph=: (0 {:: [) C.^:_1"1 ((] trsmxu1h trsmxlh~) 1&{::)~
getrsxlu1pt=: (0 {:: [) C.^:_1"1 ((] trsmxu1t trsmxlt~) 1&{::)~

getrslu1phx=: (1 {:: [) ([ trsmlhx trsmu1hx) ((0 {:: [) C.   ])
getrslu1ptx=: (1 {:: [) ([ trsmltx trsmu1tx) ((0 {:: [) C.   ])
getrsxlu1p=:  (1 {:: [) ([ trsmxl  trsmxu1 ) ((0 {:: [) C."1 ])

NB. ---------------------------------------------------------
NB. Verb:           Solves:         Syntax:
NB. getrspl1ux      A   * X = B     Xv=. pL1U getrspl1ux  Bv
NB. getrspl1uhx     A^H * X = B     Xv=. pL1U getrspl1uhx Bv
NB. getrspl1utx     A^T * X = B     Xv=. pL1U getrspl1utx Bv
NB. getrsxpl1u      X * A   = B     Xh=. pL1U getrsxpl1u  Bh
NB. getrsxpl1uh     X * A^H = B     Xh=. pL1U getrsxpl1uh Bh
NB. getrsxpl1ut     X * A^T = B     Xh=. pL1U getrsxpl1ut Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with general square
NB.   matrix A, represented in factored form:
NB.     P * L1 * U = A
NB. where:
NB.   A    - n×n-matrix
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   pL1U - 2-vector of boxes, the output of getrfpl1u, the
NB.          matrix A represented in factored form
NB.   nrhs ≥ 0, number of RHSs
NB.
NB. Assertions:
NB.   Xv -: clean pL1U getrspl1ux      A  mp  Xv
NB.   Xv -: clean pL1U getrspl1uhx (ct A) mp  Xv
NB.   Xv -: clean pL1U getrspl1utx (|: A) mp  Xv
NB.   Xh -: clean pL1U getrsxpl1u      A  mp~ Xh
NB.   Xh -: clean pL1U getrsxpl1uh (ct A) mp~ Xh
NB.   Xh -: clean pL1U getrsxpl1ut (|: A) mp~ Xh
NB. where
NB.   pL1U=. getrfpl1u A
NB.
NB. Notes:
NB. - implements LAPACK's xGETRS

getrspl1ux=:  (1 {:: [) ([ trsmux  trsml1x ) ((0 {:: [) C.   ])
getrsxpl1uh=: (1 {:: [) ([ trsmxuh trsmxl1h) ((0 {:: [) C."1 ])
getrsxpl1ut=: (1 {:: [) ([ trsmxut trsmxl1t) ((0 {:: [) C."1 ])

getrspl1uhx=: (0 {:: [) C.^:_1   ((] trsml1hx trsmuhx~) 1&{::)~
getrspl1utx=: (0 {:: [) C.^:_1   ((] trsml1tx trsmutx~) 1&{::)~
getrsxpl1u=:  (0 {:: [) C.^:_1"1 ((] trsmxl1  trsmxu ~) 1&{::)~

NB. ---------------------------------------------------------
NB. Verb:           Solves:         Syntax:
NB. getrspu1lx      A   * X = B     Xv=. pU1L getrspu1lx  Bv
NB. getrspu1lhx     A^H * X = B     Xv=. pU1L getrspu1lhx Bv
NB. getrspu1ltx     A^T * X = B     Xv=. pU1L getrspu1ltx Bv
NB. getrsxpu1l      X * A   = B     Xh=. pU1L getrsxpu1l  Bh
NB. getrsxpu1lh     X * A^H = B     Xh=. pU1L getrsxpu1lh Bh
NB. getrsxpu1lt     X * A^T = B     Xh=. pU1L getrsxpu1lt Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with general square
NB.   matrix A, represented in factored form:
NB.     P * U1 * L = A
NB. where:
NB.   A    - n×n-matrix
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   pU1L - 2-vector of boxes, the output of getrfpu1l, the
NB.          matrix A represented in factored form
NB.   nrhs ≥ 0, number of RHSs
NB.
NB. Assertions:
NB.   Xv -: clean pU1L getrspu1lx      A  mp  Xv
NB.   Xv -: clean pU1L getrspu1lhx (ct A) mp  Xv
NB.   Xv -: clean pU1L getrspu1ltx (|: A) mp  Xv
NB.   Xh -: clean pU1L getrsxpu1l      A  mp~ Xh
NB.   Xh -: clean pU1L getrsxpu1lh (ct A) mp~ Xh
NB.   Xh -: clean pU1L getrsxpu1lt (|: A) mp~ Xh
NB. where
NB.   pU1L=. getrfpu1l A

getrspu1lx=:  (1 {:: [) ([ trsmlx  trsmu1x ) ((0 {:: [) C.   ])
getrsxpu1lh=: (1 {:: [) ([ trsmxlh trsmxu1h) ((0 {:: [) C."1 ])
getrsxpu1lt=: (1 {:: [) ([ trsmxlt trsmxu1t) ((0 {:: [) C."1 ])

getrspu1lhx=: (0 {:: [) C.^:_1   ((] trsmu1hx trsmlhx~) 1&{::)~
getrspu1ltx=: (0 {:: [) C.^:_1   ((] trsmu1tx trsmltx~) 1&{::)~
getrsxpu1l=:  (0 {:: [) C.^:_1"1 ((] trsmxu1  trsmxl ~) 1&{::)~

NB. ---------------------------------------------------------
NB. Verb:           Solves:         Syntax:
NB. getrsul1px      A   * X = B     Xv=. UL1p getrsul1px  Bv
NB. getrsul1phx     A^H * X = B     Xv=. UL1p getrsul1phx Bv
NB. getrsul1ptx     A^T * X = B     Xv=. UL1p getrsul1ptx Bv
NB. getrsxul1p      X * A   = B     Xh=. UL1p getrsxul1p  Bh
NB. getrsxul1ph     X * A^H = B     Xh=. UL1p getrsxul1ph Bh
NB. getrsxul1pt     X * A^T = B     Xh=. UL1p getrsxul1pt Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with general square
NB.   matrix A, represented in factored form:
NB.     U * L1 * P = A
NB. where:
NB.   A    - n×n-matrix
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   UL1p - 2-vector of boxes, the output of getrful1p, the
NB.          matrix A represented in factored form
NB.   nrhs ≥ 0, number of RHSs
NB.
NB. Assertions:
NB.   Xv -: clean UL1p getrsul1px      A  mp  Xv
NB.   Xv -: clean UL1p getrsul1phx (ct A) mp  Xv
NB.   Xv -: clean UL1p getrsul1ptx (|: A) mp  Xv
NB.   Xh -: clean UL1p getrsxul1p      A  mp~ Xh
NB.   Xh -: clean UL1p getrsxul1ph (ct A) mp~ Xh
NB.   Xh -: clean UL1p getrsxul1pt (|: A) mp~ Xh
NB. where
NB.   UL1p=. getrful1p A

getrsul1px=:  (0 {:: [) C.^:_1   ((] trsml1x  trsmux ~) 1&{::)~
getrsxul1ph=: (0 {:: [) C.^:_1"1 ((] trsmxl1h trsmxuh~) 1&{::)~
getrsxul1pt=: (0 {:: [) C.^:_1"1 ((] trsmxl1t trsmxut~) 1&{::)~

getrsul1phx=: (1 {:: [) ([ trsmuhx trsml1hx) ((0 {:: [) C.   ])
getrsul1ptx=: (1 {:: [) ([ trsmutx trsml1tx) ((0 {:: [) C.   ])
getrsxul1p=:  (1 {:: [) ([ trsmxu  trsmxl1 ) ((0 {:: [) C."1 ])

NB. ---------------------------------------------------------
NB. Verb:           Solves:         Syntax:
NB. hetrsplx        A   * X = B     Xv=. pL1T hetrsplx  Bv
NB. hetrspltx       A^T * X = B     Xv=. pL1T hetrspltx Bv
NB. hetrsxpl        X * A   = B     Xh=. pL1T hetrsxpl  Bh
NB. hetrsxplt       X * A^T = B     Xh=. pL1T hetrsxplt Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with Hermitian
NB.   (symmetric) matrix A, represented in factored form:
NB.     P * L1 * T * L1^H * P^H = A
NB. where:
NB.   A    - n×n-matrix, Hermitian (symmetric)
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   pL1T - 3-vector of boxes, the output of hetrfpl, the
NB.          matrix A represented in factored form
NB.   nrhs ≥ 0, number of RHSs
NB.
NB. Assertions:
NB.   Xv -: clean pL1T hetrsplx      A  mp  Xv
NB.   Xv -: clean pL1T hetrspltx (|: A) mp  Xv
NB.   Xh -: clean pL1T hetrsxpl      A  mp~ Xh
NB.   Xh -: clean pL1T hetrsxplt (|: A) mp~ Xh
NB. where
NB.   pL1T=. hetrfpl A
NB.
NB. Notes:
NB. - is similar to LAPACK's DSYTRS('L') and ZHETRS('L'), but
NB.   uses another factorization, see hetrfx

hetrsplx=:   (0 {:: [)    C.^:_1    (1 {:: [) trsml1hx pttrfl@(2 {:: [) pttrslx (1 {:: [) trsml1x  (0 {:: [) C.   ]
hetrspltx=: ((0 {:: [) +@(C.^:_1  ) (1 {:: [) trsml1hx pttrfl@(2 {:: [) pttrslx (1 {:: [) trsml1x  (0 {:: [) C.   ]) +
hetrsxpl=:   (0 {:: [)    C.^:_1"1  (1 {:: [) trsmxl1  pttrfl@(2 {:: [) pttrsxl (1 {:: [) trsmxl1h (0 {:: [) C."1 ]
hetrsxplt=: ((0 {:: [) +@(C.^:_1"1) (1 {:: [) trsmxl1  pttrfl@(2 {:: [) pttrsxl (1 {:: [) trsmxl1h (0 {:: [) C."1 ]) +

NB. ---------------------------------------------------------
NB. Verb:           Solves:         Syntax:
NB. hetrspux        A   * X = B     Xv=. pU1T hetrspux  Bv
NB. hetrsputx       A^T * X = B     Xv=. pU1T hetrsputx Bv
NB. hetrsxpu        X * A   = B     Xh=. pU1T hetrsxpu  Bh
NB. hetrsxput       X * A^T = B     Xh=. pU1T hetrsxput Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with Hermitian
NB.   (symmetric) matrix A, represented in factored form:
NB.     P * U1 * T * U1^H * P^H = A
NB. where:
NB.   A    - n×n-matrix, Hermitian (symmetric)
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   pU1T - 3-vector of boxes, the output of hetrfpu, the
NB.          matrix A represented in factored form
NB.   nrhs ≥ 0
NB.
NB. Assertions:
NB.   Xv -: clean pU1T hetrspux      A  mp  Xv
NB.   Xv -: clean pU1T hetrsputx (|: A) mp  Xv
NB.   Xh -: clean pU1T hetrsxpu      A  mp~ Xh
NB.   Xh -: clean pU1T hetrsxput (|: A) mp~ Xh
NB. where
NB.   pU1T=. hetrfpu A

hetrspux=:   (0 {:: [)    C.^:_1    (1 {:: [) trsmu1hx pttrfu@(2 {:: [) pttrsux (1 {:: [) trsmu1x  (0 {:: [) C.   ]
hetrsputx=: ((0 {:: [) +@(C.^:_1  ) (1 {:: [) trsmu1hx pttrfu@(2 {:: [) pttrsux (1 {:: [) trsmu1x  (0 {:: [) C.   ]) +
hetrsxpu=:   (0 {:: [)    C.^:_1"1  (1 {:: [) trsmxu1  pttrfu@(2 {:: [) pttrsxu (1 {:: [) trsmxu1h (0 {:: [) C."1 ]
hetrsxput=: ((0 {:: [) +@(C.^:_1"1) (1 {:: [) trsmxu1  pttrfu@(2 {:: [) pttrsxu (1 {:: [) trsmxu1h (0 {:: [) C."1 ]) +

NB. ---------------------------------------------------------
NB. Verb:           Solves:         Syntax:
NB. potrslx         A   * X = B     Xv=. L potrslx  Bv
NB. potrsltx        A^T * X = B     Xv=. L potrsltx Bv
NB. potrsxl         X * A   = B     Xh=. L potrsxl  Bh
NB. potrsxlt        X * A^T = B     Xh=. L potrsxlt Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with Hermitian
NB.   (symmetric) positive definite matrix A, represented in
NB.   factored form:
NB.     L * L^H = A
NB. where:
NB.   A    - n×n-matrix, Hermitian (symmetric) positive
NB.          definite
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   L    - n×n-matrix, lower triangular with positive
NB.          diagonal entries, Cholesky triangle, the output
NB.          of potrfl, the matrix A represented in factored
NB.          form
NB.   nrhs ≥ 0, number of RHSs
NB.
NB. Assertions:
NB.   Xv -: clean L potrslx      A  mp  Xv
NB.   Xv -: clean L potrsltx (|: A) mp  Xv
NB.   Xh -: clean L potrsxl      A  mp~ Xh
NB.   Xh -: clean L potrsxlt (|: A) mp~ Xh
NB. where
NB.   L=. potrfl A
NB.
NB. Notes:
NB. - implements LAPACK's xPOTRS('L')

potrslx=:   [   trsmlhx trsmlx
potrsltx=: ([ +@trsmlhx trsmlx ) +
potrsxl=:   [   trsmxl  trsmxlh
potrsxlt=: ([ +@trsmxl  trsmxlh) +

NB. ---------------------------------------------------------
NB. Verb:           Solves:         Syntax:
NB. potrsux         A   * X = B     Xv=. U potrsux  Bv
NB. potrsutx        A^T * X = B     Xv=. U potrsutx Bv
NB. potrsxu         X * A   = B     Xh=. U potrsxu  Bh
NB. potrsxut        X * A^T = B     Xh=. U potrsxut Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with Hermitian
NB.   (symmetric) positive definite matrix A, represented in
NB.   factored form:
NB.     U * U^H = A
NB. where:
NB.   A    - n×n-matrix, Hermitian (symmetric) positive
NB.          definite
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   U    - n×n-matrix, upper triangular with positive
NB.          diagonal entries, Cholesky triangle, the output
NB.          of potrfu, the matrix A represented in factored
NB.          form
NB.   nrhs ≥ 0, number of RHSs
NB.
NB. Assertions:
NB.   Xv -: clean U potrsux      A  mp  Xv
NB.   Xv -: clean U potrsutx (|: A) mp  Xv
NB.   Xh -: clean U potrsxu      A  mp~ Xh
NB.   Xh -: clean U potrsxut (|: A) mp~ Xh
NB. where
NB.   U=. potrfu A

potrsux=:   [   trsmuhx trsmux
potrsutx=: ([ +@trsmuhx trsmux ) +
potrsxu=:   [   trsmxu  trsmxuh
potrsxut=: ([ +@trsmxu  trsmxuh) +

NB. ---------------------------------------------------------
NB. Verb:           Solves:         Syntax:
NB. pttrslx         A   * X = B     Xv=. L1D pttrslx  Bv
NB. pttrsltx        A^T * X = B     Xv=. L1D pttrsltx Bv
NB. pttrsxl         X * A   = B     Xh=. L1D pttrsxl  Bh
NB. pttrsxlt        X * A^T = B     Xh=. L1D pttrsxlt Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with Hermitian
NB.   (symmetric) positive definite tridiagonal matrix A,
NB.   represented in factored form [1]:
NB.     L1 * D * L1^H = A
NB. where:
NB.   A    - n×n-matrix, Hermitian (symmetric) positive
NB.          definite tridiagonal
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   L1D  - 2-vector of boxes, the output of pttrfl, the
NB.          matrix A represented in factored form
NB.   nrhs ≥ 0
NB.
NB. Algorithm for pttrslx:
NB.   In:  L1 D Bv
NB.   Out: Xv
NB.   1) extract main diagonal d from D and subdiagonal e
NB.      from L1
NB.   2) prepare input:
NB.        be=. Bv ,. (0,e)
NB.   3) do iterations k=1:n-1 by reversed suffix scan:
NB.        btrash=. u/\.&.|. be
NB.      to find :
NB.        b[k] := b[k] - b[k-1]*e[k-1]
NB.      for non-empty be only
NB.   4) cut off trash column to extract updated Bv:
NB.        b=. (}:"1) btrash
NB.   5) prepare intermediate input:
NB.        bde=. ((}: b) , (({: b) % ({: d))) ,. d ,. ((conj(e),0)
NB.   6) do iterations k=n-2:0 by suffix scan:
NB.        btrash=. u/\. bde
NB.      to find :
NB.        b[k] := b[k]/d[k] - b[k+1]*conj(e[k])
NB.   7) cut off two last columns of trash to extract raw Xv
NB.      and re-shape to Bv's shape:
NB.        Xv=. ($ Bv) ($,) _2 }."1 btrash
NB.
NB. Assertions:
NB.   Xv -: clean L1D pttrslx Bv
NB. where
NB.   L1D=. pttrfl A
NB.   Bv=. A mp Xv
NB.
NB. Notes:
NB. - implements LAPACK's xPTTS2(0)
NB. - if A is singular then solution Xx will be wrong
NB. - if A is indefinite then solution Xx may be wrong
NB.
NB. References:
NB. [1] G. H. Golub and C. F. Van Loan, Matrix Computations,
NB.     Johns Hopkins University Press, Baltimore, Md, USA,
NB.     3rd edition, 1996, p. 157
NB.
NB. TODO:
NB. - L1 and D would be sparse

pttrslx=:  $@] ($,) (_2 }."1 ((diag@(1 {:: [))`(stitcht +)`(_1   diag (0 {:: [))`((((_2 (}.%{)[)(-,0 0"_)((* {:)~ _2&}.))/\.    @(_2  ({:@] % ({,))`_1:`]} ,.~))^:(0<#@]))`(}:"1@((}:@[(-,0:)((* {:)~ }:))/\.&.|.)@stitchb~)`] fork3))
pttrsltx=: $@] ($,) (_2 }."1 ((diag@(1 {:: [))`(stitcht +)`(_1 +@diag (0 {:: [))`((((_2 (}.%{)[)(-,0 0"_)((* {:)~ _2&}.))/\.    @(_2  ({:@] % ({,))`_1:`]} ,.~))^:(0<#@]))`(}:"1@((}:@[(-,0:)((* {:)~ }:))/\.&.|.)@stitchb~)`] fork3))
pttrsxl=:  |:@(pttrsltx |:)
pttrsxlt=: |:@(pttrslx  |:)

NB. ---------------------------------------------------------
NB. Verb:           Solves:         Syntax:
NB. pttrsux         A   * X = B     Xv=. U1D pttrsux  Bv
NB. pttrsutx        A^T * X = B     Xv=. U1D pttrsutx Bv
NB. pttrsxu         X * A   = B     Xh=. U1D pttrsxu  Bh
NB. pttrsxut        X * A^T = B     Xh=. U1D pttrsxut Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with Hermitian
NB.   (symmetric) positive definite tridiagonal matrix A,
NB.   represented in factored form, based on [1]:
NB.     U1 * D * U1^H = A
NB. where:
NB.   A    - n×n-matrix, Hermitian (symmetric) positive
NB.          definite tridiagonal
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   U1D  - 2-vector of boxes, the output of pttrfu, the
NB.          matrix A represented in factored form
NB.   nrhs ≥ 0
NB.
NB. Algorithm for pttrsux:
NB.   In:  U1 D Bv
NB.   Out: Xv
NB.   1) extract main diagonal d from D and superdiagonal e
NB.      from U1
NB.   2) prepare input:
NB.        be=. Bv ,. (e,0)
NB.   3) do iterations k=n-2:0 by suffix scan:
NB.        btrash=. u/\. be
NB.      to find :
NB.        b[k] := b[k] - b[k+1]*e[k]
NB.      for non-empty be only
NB.   4) cut off trash column to extract updated Bv:
NB.        b=. (}:"1) btrash
NB.   5) prepare intermediate input:
NB.        bde=. ((({. b) % ({. d)) , (}. b)) ,. d ,. ((0,conj(e))
NB.   6) do iterations k=1:n-1 by reversed suffix scan:
NB.        btrash=. u/\.&.|. bde
NB.      to find :
NB.        b[k] := b[k]/d[k] - b[k-1]*conj(e[k-1])
NB.   7) cut off two last columns of trash to extract raw Xv
NB.      and re-shape to Bv's shape:
NB.        Xv=. ($ Bv) ($,) _2 }."1 btrash
NB.
NB. Assertions:
NB.   Xv -: clean U1D pttrsux Bv
NB. where
NB.   U1D=. pttrfu A
NB.   Bv=. A mp Xv
NB.
NB. Notes:
NB. - if A is singular then solution Xx will be wrong
NB. - if A is indefinite then solution Xx may be wrong
NB.
NB. References:
NB. [1] G. H. Golub and C. F. Van Loan, Matrix Computations,
NB.     Johns Hopkins University Press, Baltimore, Md, USA,
NB.     3rd edition, 1996, p. 157
NB.
NB. TODO:
NB. - U1 and D would be sparse

pttrsux=:  $@] ($,) (_2 }."1 ((diag@(1 {:: [))`(stitchb +)`( 1   diag (0 {:: [))`((((_2 (}.%{)[)(-,0 0"_)((* {:)~ _2&}.))/\.&.|.@(c@[ ({.@] % ({,))` 0:`]} ,.~))^:(0<#@]))`(}:"1@((}:@[(-,0:)((* {:)~ }:))/\.    )@stitcht~)`] fork3))
pttrsutx=: $@] ($,) (_2 }."1 ((diag@(1 {:: [))`(stitchb +)`( 1 +@diag (0 {:: [))`((((_2 (}.%{)[)(-,0 0"_)((* {:)~ _2&}.))/\.&.|.@(c@[ ({.@] % ({,))` 0:`]} ,.~))^:(0<#@]))`(}:"1@((}:@[(-,0:)((* {:)~ }:))/\.    )@stitcht~)`] fork3))
pttrsxu=:  |:@(pttrsutx |:)
pttrsxut=: |:@(pttrsux  |:)

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testgetrs
NB.
NB. Description:
NB.   Test getrsxxx by general matrix given
NB.
NB. Syntax:
NB.   testgetrs (A;X)
NB. where
NB.   A - n×n-matrix
NB.   X - n×n-matrix, exact solution
NB.
NB. Formula:
NB.   ferr := max(||X - exactX|| / ||X||)
NB.   berr := max(||B - op(A) * X|| / (FP_EPS * ||op(A)|| * ||X||))

testgetrs=: 3 : 0
  'A X'=. y
  'conA conAh conAt'=. gecon1"2 (] , ct ,: |:) A
  'LU1ip ipL1U ipU1L UL1ip'=. (getrflu1p ; getrfpl1u ; getrfpu1l ; <@getrful1p) A

  ('getrslu1px'  tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;LU1ip)
  ('getrslu1phx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAh"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((ct A);X;LU1ip)
  ('getrslu1ptx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;LU1ip)
  ('getrsxlu1p'  tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;LU1ip)
  ('getrsxlu1ph' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAh"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((ct A);X;LU1ip)
  ('getrsxlu1pt' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;LU1ip)

  ('getrspl1ux'  tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;ipL1U)
  ('getrspl1uhx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAh"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((ct A);X;ipL1U)
  ('getrspl1utx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;ipL1U)
  ('getrsxpl1u'  tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;ipL1U)
  ('getrsxpl1uh' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAh"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((ct A);X;ipL1U)
  ('getrsxpl1ut' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;ipL1U)

  ('getrspu1lx'  tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;ipU1L)
  ('getrspu1lhx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAh"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((ct A);X;ipU1L)
  ('getrspu1ltx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;ipU1L)
  ('getrsxpu1l'  tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;ipU1L)
  ('getrsxpu1lh' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAh"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((ct A);X;ipU1L)
  ('getrsxpu1lt' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;ipU1L)

  ('getrsul1px'  tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;UL1ip)
  ('getrsul1phx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAh"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((ct A);X;UL1ip)
  ('getrsul1ptx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;UL1ip)
  ('getrsxul1p'  tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;UL1ip)
  ('getrsxul1ph' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAh"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((ct A);X;UL1ip)
  ('getrsxul1pt' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;UL1ip)

  EMPTY
)

NB. ---------------------------------------------------------
NB. testhetrs
NB.
NB. Description:
NB.   Test hetrsxxx by Hermitian (symmetric) matrix given
NB.
NB. Syntax:
NB.   testhetrs (A;X)
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric)
NB.   X - n×n-matrix, exact solution
NB.
NB. Formula:
NB.   ferr := max(||X - exactX|| / ||X||)
NB.   berr := max(||B - op(A) * X|| / (FP_EPS * ||op(A)|| * ||X||))

testhetrs=: 3 : 0
  'A X'=. y
  'conA conAt'=. hecon1"2 (] ,: |:) A
  'ipL1D ipU1D'=. (hetrfpl ; <@hetrfpu) A

  ('hetrsplx'  tdyad ((_3&{.)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;ipL1D)
  ('hetrspltx' tdyad ((_3&{.)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;ipL1D)
  ('hetrsxpl'  tdyad ((_3&{.)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;ipL1D)
  ('hetrsxplt' tdyad ((_3&{.)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;ipL1D)

  ('hetrspux'  tdyad ((_3&{.)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;ipU1D)
  ('hetrsputx' tdyad ((_3&{.)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;ipU1D)
  ('hetrsxpu'  tdyad ((_3&{.)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;ipU1D)
  ('hetrsxput' tdyad ((_3&{.)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;ipU1D)

  EMPTY
)

NB. ---------------------------------------------------------
NB. testpotrs
NB.
NB. Description:
NB.   Test potrsxxx by Hermitian (symmetric) positive
NB.   definite matrix given
NB.
NB. Syntax:
NB.   testpotrs (A;X)
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive definite
NB.   X - n×n-matrix, exact solution
NB.
NB. Formula:
NB.   ferr := max(||X - exactX|| / ||X||)
NB.   berr := max(||B - op(A) * X|| / (FP_EPS * ||op(A)|| * ||X||))

testpotrs=: 3 : 0
  'A X'=. y
  'conA conAt'=. pocon1"2 (] ,: |:) A
  'L U'=. (potrfl ,: potrfu) A

  ('potrslx'  tdyad ((2&{::)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;L)
  ('potrsltx' tdyad ((2&{::)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;L)
  ('potrsxl'  tdyad ((2&{::)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;L)
  ('potrsxlt' tdyad ((2&{::)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;L)

  ('potrsux'  tdyad ((2&{::)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;U)
  ('potrsutx' tdyad ((2&{::)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;U)
  ('potrsxu'  tdyad ((2&{::)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;U)
  ('potrsxut' tdyad ((2&{::)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;U)

  EMPTY
)

NB. ---------------------------------------------------------
NB. testpttrs
NB.
NB. Description:
NB.   Test pttrsxxx by Hermitian (symmetric) positive
NB.   definite tridiagonal matrix given
NB.
NB. Syntax:
NB.   testpttrs (A;X)
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive definite
NB.       tridiagonal
NB.   X - n×n-matrix, exact solution
NB.
NB. Formula:
NB.   ferr := max(||X - exactX|| / ||X||)
NB.   berr := max(||B - op(A) * X|| / (FP_EPS * ||op(A)|| * ||X||))
NB.
NB. TODO:
NB. - A should be sparse

testpttrs=: 3 : 0
  'A X'=. y
  'conA conAt'=. ptcon1"2 (,: |:) A
  'L1D U1D'=. (pttrfl ; <@pttrfu) A

  ('pttrslx'  tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;L1D)
  ('pttrsltx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;L1D)
  ('pttrsxl'  tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;L1D)
  ('pttrsxlt' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;L1D)

  ('pttrsux'  tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conA "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (    A ;X;U1D)
  ('pttrsutx' tdyad ((_2&{.)`(mp &>/@(2&{.))`]`(conAt"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(mp &>/@(2 {. [) - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) ((|: A);X;U1D)
  ('pttrsxu'  tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conA "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (    A ;X;U1D)
  ('pttrsxut' tdyad ((_2&{.)`(mp~&>/@(2&{.))`]`(conAt"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(mp~&>/@(2 {. [) - (mp  0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) ((|: A);X;U1D)

  EMPTY
)

NB. ---------------------------------------------------------
NB. testtrs
NB.
NB. Description:
NB.   Adv. to make verb to test xxtrsxxx by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testtrs
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
NB.     ?@$&0 testtrs_mt_ 150 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testtrs_mt_ 150 150
NB. - test by random square complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testtrs_mt_ 150 150

testtrs=: 1 : 'EMPTY_mt_ [ (testpttrs_mt_@((u ptmat_mt_) ; u) [ testpotrs_mt_@((u pomat_mt_) ; u) [ (testhetrs_mt_@((u hemat_mt_) ; u)) [ testgetrs_mt_@(u ; u))^:(=/)'
