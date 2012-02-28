NB. Inverse by triangular factorization
NB.
NB. trtrixx    Inverse triangular matrix
NB. getrixxxx  Inverse general matrix
NB. hetripx    Inverse Hermitian (symmetric) matrix
NB. potrix     Inverse Hermitian (symmetric) positive
NB.            definite matrix
NB. pttrix     Inverse Hermitian (symmetric) positive
NB.            definite tridiagonal matrix
NB.
NB. testtrtri  Test trtrixx by triangular matrix given
NB. testgetri  Test getrixxxx by general matrix given
NB. testhetri  Test hetripx by Hermitian (symmetric) matrix
NB.            given
NB. testpotri  Test potrix by Hermitian (symmetric) positive
NB.            definite matrix given
NB. testpttri  Test pttrix by Hermitian (symmetric) positive
NB.            definite tridiagonal matrix given
NB. testtri    Adv. to make verb to test xxtrixx by matrix of
NB.            generator and shape given
NB.
NB. Version: 0.8.1 2011-10-29
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

NB. ---------------------------------------------------------
NB. Blocked code constants

TRINB=: 64  NB. block size limit

NB. ---------------------------------------------------------
NB. getrilu1pstep
NB.
NB. Description:
NB.   Single step of non-blocked version of getrilu1p
NB.
NB. Syntax:
NB.   'pfxi1 sfxi1'=. getrilu1pstep (pfxi ; sfxi)
NB. where
NB.   pfxi  - (j+TRINB)×n-matrix after i-th step and before
NB.           (i+1)-th one, contains not yet processed part
NB.   sfxi  - (n-j-TRINB)×n-matrix after i-th step and before
NB.           (i+1)-th one, contains already processed part
NB.   pfxi1 - j×n-matrix, being pfxi after (i+1)-th step
NB.   sfxi1 - (n-j)×n-matrix, being sfxi after (i+1)-th step
NB.   j     = (I-(i+1))*TRINB
NB.   i     = 0:I-1
NB.   I     = ⌊n/TRINB⌋
NB.
NB. Algorithm:
NB.   In:
NB.     pfx(i) := A[0:j+TRINB-1,0:n-1]
NB.     sfx(i) := A[j+TRINB:n-1,0:n-1]
NB.   Out:
NB.     pfx(i+1) := A[0:j-1,0:n-1]
NB.     sfx(i+1) := A[j:n-1,0:n-1]
NB.   1) extract current diagonal block of A(i) from pfx(i):
NB.        U0i := A[j:j+TRINB-1,j:j+TRINB-1] ,
NB.      it contains merged current diagonal blocks of L^_1
NB.      and U1
NB.   2) extract current subdiagonal block row of U1 from
NB.      pfx(i):
NB.        U1i := A[j:j+TRINB-1,j+TRINB:n-1]
NB.   3) extract current block row of L^_1 from pfx(i):
NB.      3.1) extract current block row of A(i):
NB.             Ri := A[j:j+TRINB-1,0:n-1] ,
NB.           it contains merged current row blocks of
NB.           L^_1 and U1
NB.      3.2) zeroize in Ri elements behind the main diagonal
NB.   4) update Ri:
NB.      4.1) do:
NB.             Ri := Ri - U1i * sfx(i)
NB.      4.2) solve:
NB.             Riupd * U0i = Ri
NB.           for Riupd, where U0i is unit upper triangular
NB.   5) assemble output:
NB.      5.1) cut off current block row from pfx(i) to
NB.           produce pfx(i+1)
NB.      5.2) append sfx(i) to Riupd to produce sfx(i+1)
NB.      5.3) link sfx(i+1) to pfx(i+1)

getrilu1pstep=: 3 : 0
  'pfx sfx'=. y
  'j n'=. $ pfx
  j=. j - TRINB
  U0i=. (,.~ j , TRINB) ];.0 pfx
  U1i=. (- TRINB , # sfx) {. pfx
  Ri=. (-TRINB) {. pfx
  Ri=. ((i. TRINB) </ (i. n) - j) } Ri ,: 0  NB. spec code
  Ri=. Ri - U1i mp sfx
  Ri=. U0i trsmu1x Ri
  ((-TRINB) }. pfx) ; Ri , sfx
)

NB. ---------------------------------------------------------
NB. getripl1ustep
NB.
NB. Description:
NB.   Single step of non-blocked version of getripl1u
NB.
NB. Syntax:
NB.   'pfxi1 sfxi1'=. getripl1ustep (pfxi ; sfxi)
NB. where
NB.   pfxi  - n×(j+TRINB)-matrix after i-th step and before
NB.           (i+1)-th one, contains not yet processed part
NB.   sfxi  - n×(n-j-TRINB)-matrix after i-th step and before
NB.           (i+1)-th one, contains already processed part
NB.   pfxi1 - n×j-matrix, being pfxi after (i+1)-th step
NB.   sfxi1 - n×(n-j)-matrix, being sfxi after (i+1)-th step
NB.   j     = (I-(i+1))*TRINB
NB.   i     = 0:I-1
NB.   I     = ⌊n/TRINB⌋
NB.
NB. Algorithm:
NB.   In:
NB.     pfx(i) := A[0:n-1,0:j+TRINB-1]
NB.     sfx(i) := A[0:n-1,j+TRINB:n-1]
NB.   Out:
NB.     pfx(i+1) := A[0:n-1,0:j-1]
NB.     sfx(i+1) := A[0:n-1,j:n-1]
NB.   1) extract current diagonal block of A(i) from pfx(i):
NB.        L0i := A[j:j+TRINB-1,j:j+TRINB-1] ,
NB.      it contains merged current diagonal blocks of U^_1
NB.      and L1
NB.   2) extract current subdiagonal block column of L1 from
NB.      pfx(i):
NB.        L1i := A[j+TRINB:n-1,j:j+TRINB-1]
NB.   3) extract current block column of U^_1 from pfx(i):
NB.      3.1) extract current block column of A(i):
NB.             Ci := A[0:n-1,j:j+TRINB-1] ,
NB.           it contains merged current column blocks of
NB.           U^_1 and L1
NB.      3.2) zeroize in Ci elements under main diagonal
NB.   4) update Ci:
NB.      4.1) do:
NB.             Ci := Ci - sfx(i) * L1i
NB.      4.2) solve:
NB.             Ciupd * L0i = Ci
NB.           for Ciupd, where L0i is unit lower triangular
NB.   5) assemble output:
NB.      5.1) cut off current block column from pfx(i) to
NB.           produce pfx(i+1)
NB.      5.2) stitch sfx(i) to Ciupd to produce sfx(i+1)
NB.      5.3) link sfx(i+1) to pfx(i+1)
NB.
NB. References:
NB. [1] J. DuCroz, N. Higham. Stability of Methods for Matrix
NB.     Inversion, UT-CS-90-119, October, 1990.
NB.     LAPACK Working Note 27
NB.     http://www.netlib.org/lapack/lawns/downloads/

getripl1ustep=: 3 : 0
  'pfx sfx'=. y
  'n j'=. $ pfx
  j=. j - TRINB
  L0i=. (,.~ j , TRINB) ];.0 pfx
  L1i=. (- (c sfx),TRINB) {. pfx
  Ci=. (-TRINB) {."1 pfx
  Ci=. (((i. n) - j) >/ i. TRINB) } Ci ,: 0  NB. spec code
  Ci=. Ci - sfx mp L1i
  Ci=. L0i trsmxl1 Ci
  ((-TRINB) }."1 pfx) ; Ci ,. sfx
)

NB. ---------------------------------------------------------
NB. getripu1lstep
NB.
NB. Description:
NB.   Single step of non-blocked version of getripu1l
NB.
NB. Syntax:
NB.   'pfxi1 sfxi1'=. getripu1lstep (pfxi ; sfxi)
NB. where
NB.   pfxi  - n×j-matrix after i-th step and before
NB.           (i+1)-th one, contains already processed part
NB.   sfxi  - n×(n-j)-matrix after i-th step and before
NB.           (i+1)-th one, contains тще нуе processed part
NB.   pfxi1 - n×(j+TRINB)-matrix, being pfxi after (i+1)-th
NB.           step
NB.   sfxi1 - n×(n-j-TRINB)-matrix, being sfxi after (i+1)-th
NB.           step
NB.   j     = n-(I-i)*TRINB
NB.   i     = 0:I-1
NB.   I     = ⌊n/TRINB⌋
NB.
NB. Algorithm:
NB.   In:
NB.     pfx(i) := A[0:n-1,0:j-1]
NB.     sfx(i) := A[0:n-1,j:n-1]
NB.   Out:
NB.     pfx(i+1) := A[0:n-1,0:j+TRINB-1]
NB.     sfx(i+1) := A[0:n-1,j+TRINB:n-1]
NB.   1) extract current diagonal block of A(i) from sfx(i):
NB.        U0i := A[j:j+TRINB-1,j:j+TRINB-1] ,
NB.      it contains merged current diagonal blocks of L^_1
NB.      and U1
NB.   2) extract current superdiagonal block column of U1
NB.      from sfx(i):
NB.        U1i := A[0:j-1,j:j+TRINB-1]
NB.   3) extract current block column of L^_1 from sfx(i):
NB.      3.1) extract current block column of A(i):
NB.             Ri := A[0:n-1,j:j+TRINB-1] ,
NB.           it contains merged current column blocks of
NB.           L^_1 and U1
NB.      3.2) zeroize in Ci elements above the main diagonal
NB.   4) update Ci:
NB.      4.1) do:
NB.             Ci := Ci - sfx(i) * U1i
NB.      4.2) solve:
NB.             U0i * Ciupd = Ci
NB.           for Ciupd, where U0i is unit upper triangular
NB.   5) assemble output:
NB.      5.1) cut off current block column from sfx(i) to
NB.           produce sfx(i+1)
NB.      5.2) stitch Ciupd to pfx(i) to produce pfx(i+1)
NB.      5.3) link sfx(i+1) to pfx(i+1)

getripu1lstep=: 3 : 0
  'pfx sfx'=. y
  'n j'=. $ pfx
  U0i=. ((j , 0) ,: 2 # TRINB) ];.0 sfx
  U1i=. (j , TRINB) {. sfx
  Ci=. TRINB {."1 sfx
  Ci=. (((i. n) - j) </ i. TRINB) } Ci ,: 0  NB. spec code
  Ci=. Ci - pfx mp U1i
  Ci=. U0i trsmxu1 Ci
  (pfx ,. Ci) ; TRINB }."1 sfx
)

NB. ---------------------------------------------------------
NB. getriul1pstep
NB.
NB. Description:
NB.   Single step of non-blocked version of getriul1p
NB.
NB. Syntax:
NB.   'pfxi1 sfxi1'=. getristep (pfxi ; sfxi)
NB. where
NB.   pfxi  - j×n-matrix after i-th step and before
NB.           (i+1)-th one, contains already processed part
NB.   sfxi  - (n-j)×n-matrix after i-th step and before
NB.           (i+1)-th one, contains not yet processed part
NB.   pfxi1 - (j+TRINB)×n-matrix, being pfx(i) after (i+1)-th
NB.           step
NB.   sfxi1 - (n-j-TRINB)×n-matrix, being sfx(i) after
NB.           (i+1)-th step
NB.   j     = n-(I-i)*TRINB
NB.   i     = 0:I-1
NB.   I     = ⌊n/TRINB⌋
NB.
NB. Algorithm:
NB.   In:
NB.     pfx(i) := A[0:j-1,0:n-1]
NB.     sfx(i) := A[j:n-1,0:n-1]
NB.   Out:
NB.     pfx(i+1) := A[0:j+TRINB-1,0:n-1]
NB.     sfx(i+1) := A[j+TRINB:n-1,0:n-1]
NB.   1) extract current diagonal block of A(i) from sfx(i):
NB.        L0i := A[j:j+TRINB-1,j:j+TRINB-1] ,
NB.      it contains merged current diagonal blocks of U^_1
NB.      and L1
NB.   2) extract current subdiagonal block row of L1 from
NB.      sfx(i):
NB.        L1i := A[j:j+TRINB-1,0:j-1]
NB.   3) extract current block row of U^_1 from sfx(i):
NB.      3.1) extract current block row of A(i):
NB.             Ri := A[j:j+TRINB-1,0:n-1] ,
NB.           it contains merged current row blocks of U^_1
NB.           and L1
NB.      3.2) zeroize in Ri elements to the left of the main
NB.           diagonal
NB.   4) update Ri:
NB.      4.1) do:
NB.             Ri := Ri - L1i * pfx(i)
NB.      4.2) solve:
NB.             L0i * Riupd = Ri
NB.           for Riupd, where L0i is unit lower triangular
NB.   5) assemble output:
NB.      5.1) cut off current block row from sfx(i) to
NB.           produce sfx(i+1)
NB.      5.2) append Riupd to pfx(i) to produce pfx(i+1)
NB.      5.3) link sfx(i+1) to pfx(i+1)

getriul1pstep=: 3 : 0
  'pfx sfx'=. y
  'j n'=. $ pfx
  L0i=. ((0 , j) ,: 2 # TRINB) ];.0 sfx
  L1i=. (TRINB , j) {. sfx
  Ri=. TRINB {. sfx
  Ri=. ((i. TRINB) >/ (i. n) - j) } Ri ,: 0  NB. spec code
  Ri=. Ri - L1i mp pfx
  Ri=. L0i trsml1x Ri
  (pfx , Ri) ; TRINB }. sfx
)

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. Verb:        Syntax:
NB. trtril       iL=.  trtril  L
NB. trtril1      iL1=. trtril1 L1
NB. trtriu       iU=.  trtriu  U
NB. trtriu1      iU1=. trtriu1 U1
NB.
NB. Description:
NB.   Inverse triangular matrix
NB. where:
NB.   L   - n×n-matrix, lower triangular
NB.   iL  - n×n-matrix, lower triangular, an inversion of L
NB.   L1  - n×n-matrix, unit lower triangular (diagonal is
NB.         not saved)
NB.   iL1 - n×n-matrix, unit lower triangular (diagonal is
NB.         not saved), an inversion of L1
NB.   U   - n×n-matrix, upper triangular
NB.   iU  - n×n-matrix, upper triangular, an inversion of U
NB.   U1  - n×n-matrix, unit upper triangular (diagonal is
NB.         not saved)
NB.   iU1 - n×n-matrix, unit upper triangular (diagonal is
NB.         not saved), an inversion of U1
NB.
NB. Algorithm for trtriu:
NB.   In: U
NB.   Out: iU
NB.   1) if 1 < # U
NB.      1.1) then
NB.           1.1.1) form (#U)-vector fret:
NB.                    fret[:] := 0
NB.                    fret[0] := 1
NB.                    fret[k] := 1
NB.                  where k is splitting edge:
NB.                    k := ⌈n/2⌉
NB.           1.1.2) cut U by fret to block matrix bU:
NB.                    bU := (  U00       )  k
NB.                          (  U10  U11  )  n-k
NB.                             k    n-k
NB.           1.1.3) apply trtriu itself to U00 and U11:
NB.                    iU00 := U00^_1
NB.                    iU11 := U11^_1
NB.           1.1.4) replace U00 and U11 by iU00 and iU11,
NB.                  respectively, in bU
NB.           1.1.5) inverse U01:
NB.                    iU01 := - iU00 * U01 * iU11
NB.           1.1.6) replace U01 by iU01 in bU
NB.           1.1.7) assemble iU from block matrix:
NB.                    iU=. icut bU
NB.     1.2) else return reciprocal:
NB.            iU=. % U
NB.
NB. Notes:
NB. - unit diagonal is not referenced
NB. - models LAPACK's xTRTRI with following differences:
NB.   - blocked not partitioned algorithm is used
NB.   - opposite triangle must be zeroed
NB.
NB. TODO:
NB. - fret would be sparse

trtril=:  %     `(icut@(2:}~ <@:-@((1 1 {:: ]) mp (1 0 {:: ]) mp 0 0 {:: ]))@(<@$:`<`<;.1~ ;~@(1:`]`([ ($!.0) 1:)} (>.@-:))@#))@.(1 < #)
trtril1=: (1:"0)`(icut@(2:}~ <@:-@((1 1 {:: ]) mp (1 0 {:: ]) mp 0 0 {:: ]))@(<@$:`<`<;.1~ ;~@(1:`]`([ ($!.0) 1:)} (>.@-:))@#))@.(1 < #)
trtriu=:  %     `(icut@(1:}~ <@:-@((0 0 {:: ]) mp (0 1 {:: ]) mp 1 1 {:: ]))@(<@$:`<`<;.1~ ;~@(1:`]`([ ($!.0) 1:)} (>.@-:))@#))@.(1 < #)
trtriu1=: (1:"0)`(icut@(1:}~ <@:-@((0 0 {:: ]) mp (0 1 {:: ]) mp 1 1 {:: ]))@(<@$:`<`<;.1~ ;~@(1:`]`([ ($!.0) 1:)} (>.@-:))@#))@.(1 < #)

NB. ---------------------------------------------------------
NB. getrilu1p
NB.
NB. Description:
NB.   Inverse a general matrix A, represented in factored
NB.   form:
NB.     L * U1 * P = A
NB.
NB. Syntax:
NB.   iA=. getrilu1p LU1p
NB. where
NB.   LU1p - 3-vector of boxes, the output of getrflu1p, the
NB.          matrix A represented in factored form
NB.   iA   - n×n-matrix, an inversion of A
NB.   A    - n×n-matrix
NB.
NB. Algorithm:
NB.   In: LU1p
NB.   Out: iA
NB.   1) extract ip and LU1 from LU1p
NB.   2) acquire n, the size of A
NB.   3) extract L from LU1, inverse it and save L^_1 into y
NB.   4) copy U1 from LU1 into the strict upper triangle of y
NB.   5) calculate the number of iterations of partitioned
NB.      algorithm:
NB.        I := ⌊n/TRINB⌋
NB.      note: partitioned algorithm will be applied to the
NB.            first I*TRINB rows of y
NB.   6) invert A:
NB.      6.1) prepare suffix sfx from the last n%TRINB rows
NB.           of y, which won't be processed by partitioned
NB.           algorithm
NB.           6.1.1) extract last n%TRINB rows from L^_1:
NB.                    iLsfx := L^_1[I*TRINB:n-1,0:n-1]
NB.           6.1.2) extract unit upper triangular matrix
NB.                  from last n%TRINB rows of U1:
NB.                    U1sfx := U1[I*TRINB:n-1,I*TRINB:n-1]
NB.           6.1.3) solve system
NB.                    U1sfx * sfx = iLsfx
NB.                  for sfx, where
NB.                    sfx := A^_1[I*TRINB:n-1,0:n-1]
NB.                  is the last n%TRINB rows of A^_1
NB.      6.2) prepare prefix pfx - the 1st I*TRINB rows of y,
NB.           which will be processed by partitioned
NB.           algorithm:
NB.             pfx := A[0:I*TRINB-1,0:n-1]
NB.      6.3) do iterations i=0:I-1 :
NB.             'pfx sfx'=. getrilu1pstep^:I (pfx ; sfx)
NB.      6.4) extract sfx produced by the last iteration
NB.      6.5) apply permutation P to the rows of sfx by
NB.           obversed applying of inversed permutation P^H,
NB.           to produce final A^_1
NB.
NB. Assertions:
NB.   (%. -: (getrilu1p@getrflu1p)) A

getrilu1p=: 3 : 0
  'ip LU1'=. y
  n=. c LU1
  y=. trtril trl LU1
  y=. (</~ i. n) } y ,: LU1  NB. spec code
  I=. <. n % TRINB
  ip (C.^:_1) 1 {:: getrilu1pstep^:I (TRINB * I) ({. ; ([ (tru1 trsmu1x trl) }.)) y
)

NB. ---------------------------------------------------------
NB. getripl1u
NB.
NB. Description:
NB.   Inverse a general matrix A, represented in factored
NB.   form [1]:
NB.     P * L1 * U = A
NB.
NB. Syntax:
NB.   iA=. getripl1u pL1U
NB. where
NB.   pL1U - 3-vector of boxes, the output of getrfpl1u, the
NB.          matrix A represented in factored form
NB.   iA   - n×n-matrix, an inversion of A
NB.   A    - n×n-matrix
NB.
NB. Algorithm:
NB.   In: pL1U
NB.   Out: iA
NB.   1) extract ip and L1U from pL1U
NB.   2) acquire n, the size of A
NB.   3) extract U from L1U, inverse it and save U^_1 into y
NB.   4) copy L1 from L1U into the strict lower triangle of y
NB.   5) calculate the number of iterations of partitioned
NB.      algorithm:
NB.        I := ⌊n/TRINB⌋
NB.      note: partitioned algorithm will be applied to the
NB.            first I*TRINB columns of y
NB.   6) invert A:
NB.      6.1) prepare suffix sfx from the last n%TRINB columns
NB.           of y, which won't be processed by partitioned
NB.           algorithm
NB.           6.1.1) extract last n%TRINB columns from U^_1:
NB.                    iUsfx := U^_1[0:n-1,I*TRINB:n-1]
NB.           6.1.2) extract unit lower triangular matrix
NB.                  from last n%TRINB columns of L1:
NB.                    L1sfx := L1[I*TRINB:n-1,I*TRINB:n-1]
NB.           6.1.3) solve system
NB.                    sfx * L1sfx = iUsfx
NB.                  for sfx, where
NB.                    sfx := A^_1[0:n-1,I*TRINB:n-1]
NB.                  is the last n%TRINB columns of A^_1
NB.      6.2) prepare prefix pfx - the 1st I*TRINB columns of
NB.           y, which will be processed by partitioned
NB.           algorithm:
NB.             pfx := A[0:n-1,0:I*TRINB-1]
NB.      6.3) do iterations i=0:I-1 :
NB.             'pfx sfx'=. getripl1ustep^:I (pfx ; sfx)
NB.      6.4) extract sfx produced by the last iteration
NB.      6.5) apply permutation P to the columns of sfx by
NB.           obversed applying of inversed permutation P^H,
NB.           to produce final A^_1
NB.
NB. Assertions:
NB.   (%. -: (getripl1u@getrfpl1u)) A
NB.
NB. Notes:
NB. - implements LAPACK's xGETRI
NB.
NB. References:
NB. [1] J. DuCroz, N. Higham. Stability of Methods for Matrix
NB.     Inversion, UT-CS-90-119, October, 1990.
NB.     LAPACK Working Note 27
NB.     http://www.netlib.org/lapack/lawns/downloads/

getripl1u=: 3 : 0
  'ip L1U'=. y
  n=. # L1U
  y=. trtriu tru L1U
  y=. (>/~ i. n) } y ,: L1U  NB. spec code
  I=. <. n % TRINB
  ip (C.^:_1"1) 1 {:: getripl1ustep^:I (TRINB * I) ({."1 ; (-@[ (trl1 trsmxl1 tru) }."1)) y
)

NB. ---------------------------------------------------------
NB. getripu1l
NB.
NB. Description:
NB.   Inverse a general matrix A, represented in factored
NB.   form:
NB.     P * U1 * L = A
NB.
NB. Syntax:
NB.   iA=. getripu1l pU1L
NB. where
NB.   pU1L - 3-vector of boxes, the output of getrfpu1l, the
NB.          matrix A represented in factored form
NB.   iA   - n×n-matrix, an inversion of A
NB.   A    - n×n-matrix
NB.
NB. Algorithm:
NB.   In: pU1L
NB.   Out: iA
NB.   1) extract ip and U1L from pU1L
NB.   2) acquire n, the size of A
NB.   3) extract L from U1L, inverse it and save L^_1 into y
NB.   4) copy U1 from U1L into the strict upper triangle of y
NB.   5) calculate the number of iterations of partitioned
NB.      algorithm:
NB.        I := ⌊n/TRINB⌋
NB.      note: partitioned algorithm will be applied to the
NB.            last I*TRINB columns of y
NB.   6) invert A:
NB.      6.1) prepare prefix pfx from the 1st n%TRINB columns
NB.           of y, which won't be processed by partitioned
NB.           algorithm
NB.           6.1.1) extract 1st n%TRINB columns from L^_1:
NB.                    iLpfx := L^_1[0:n-1,0:n%TRINB-1]
NB.           6.1.2) extract unit upper triangular matrix
NB.                  from 1st n%TRINB columns of U1:
NB.                    U1pfx := U1[0:n%TRINB-1,0:n%TRINB-1]
NB.           6.1.3) solve system
NB.                    pfx * U1pfx = iLpfx
NB.                  for pfx, where
NB.                    pfx := A^_1[0:n-1,0:n%TRINB-1]
NB.                  is the 1st n%TRINB columns of A^_1
NB.      6.2) prepare suffix sfx - the last I*TRINB columns
NB.           of y, which will be processed by partitioned
NB.           algorithm:
NB.             sfx := A[0:n-1,n%TRINB:n-1]
NB.      6.3) do iterations i=0:I-1 :
NB.             'pfx sfx'=. getripu1lstep^:I (pfx ; sfx)
NB.      6.4) extract pfx produced by the last iteration
NB.      6.5) apply permutation P to the columns of pfx by
NB.           obversed applying of inversed permutation P^H,
NB.           to produce final A^_1
NB.
NB. Assertions:
NB.   (%. -: (getripu1l@getrfpu1l)) A

getripu1l=: 3 : 0
  'ip U1L'=. y
  n=. c U1L
  y=. trtril trl U1L
  y=. (</~ i. n) } y ,: U1L  NB. spec code
  I=. <. n % TRINB
  ip (C.^:_1"1) 0 {:: getripu1lstep^:I (TRINB | n) ((((2 # [) {. ]) trsmxu1 trl@:({."1)) ; }."1) y
)

NB. ---------------------------------------------------------
NB. getriul1p
NB.
NB. Description:
NB.   Inverse a general matrix A, represented in factored
NB.   form:
NB.     U * L1 * P = A
NB.
NB. Syntax:
NB.   iA=. getriul1p UL1p
NB. where
NB.   UL1p - 3-vector of boxes, the output of getrful1p, the
NB.          matrix A represented in factored form
NB.   iA   - n×n-matrix, an inversion of A
NB.   A    - n×n-matrix
NB.
NB. Algorithm:
NB.   In: UL1p
NB.   Out: iA
NB.   1) extract ip and UL1 from UL1p
NB.   2) acquire n, the size of A
NB.   3) extract U from UL1, inverse it and save U^_1 into y
NB.   4) copy L1 from UL1 into the strict lower triangle of y
NB.   5) calculate the number of iterations of partitioned
NB.      algorithm:
NB.        I := ⌊n/TRINB⌋
NB.      note: partitioned algorithm will be applied to the
NB.            last I*TRINB rows of y
NB.   6) invert A:
NB.      6.1) prepare prefix pfx from the 1st n%TRINB rows of
NB.           y, which won't be processed by partitioned
NB.           algorithm
NB.           6.1.1) extract 1st n%TRINB rows from U^_1:
NB.                    iUpfx := U^_1[0:n%TRINB-1,0:n-1]
NB.           6.1.2) extract unit lower triangular matrix
NB.                  from 1st n%TRINB rows of L1:
NB.                    L1pfx := L1[0:n%TRINB-1,0:n%TRINB-1]
NB.           6.1.3) solve system
NB.                    L1pfx * pfx  = iUpfx
NB.                  for pfx, where
NB.                    pfx := A^_1[0:n%TRINB-1,0:n-1]
NB.                  is the 1st n%TRINB rows of A^_1
NB.      6.2) prepare suffix sfx - the last I*TRINB rows of
NB.           y, which will be processed by partitioned
NB.           algorithm:
NB.             sfx := A[n%TRINB:n-1,0:n-1]
NB.      6.3) do iterations i=0:I-1 :
NB.             'pfx sfx'=. getriul1pstep^:I (pfx ; sfx)
NB.      6.4) extract pfx produced by the last iteration
NB.      6.5) apply permutation P to the rows of pfx by
NB.           obversed applying of inversed permutation P^H,
NB.           to produce final A^_1
NB.
NB. Assertions:
NB.   (%. -: (getriul1p@getrful1p)) A

getriul1p=: 3 : 0
  'ip UL1'=. y
  n=. # UL1
  y=. trtriu tru UL1
  y=. (>/~ i. n) } y ,: UL1  NB. spec code
  I=. <. n % TRINB
  ip (C.^:_1) 0 {:: getriul1pstep^:I (TRINB | n) ((((2 # [) {. ]) trsml1x tru@{.) ; }.) y
)

NB. ---------------------------------------------------------
NB. Verb:    Factorization used:            Syntax:
NB. hetripl  P * L1 * T * L1^H * P^H = A    iA=. hetripl pL1T
NB. hetripu  P * U1 * T * U1^H * P^H = A    iA=. hetripu pU1T
NB.
NB. Description:
NB.   Inverse Hermitian (symmetric) matrix A, represented in
NB.   factored form
NB. where
NB.   A    - n×n-matrix, Hermitian (symmetric)
NB.   pL1T - 3-vector of boxes, the output of hetrfpl, the
NB.          matrix A represented in factored form
NB.   pU1T - 3-vector of boxes, the output of hetrfpu, the
NB.          matrix A represented in factored form
NB.   iA   - n×n-matrix, an inversion of A
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   iA -: %. A
NB. where
NB.   iA=. hetripl hetrfpl A
NB.   or
NB.   iA=. hetripu hetrfpu A
NB.
NB. Notes:
NB. - is similar to LAPACK's DSYTRI and ZHETRI, but uses
NB.   another factorization, see hetrfx
NB. - calls to pttril and pttriu are interchangeable here

hetripl=: (/:@(0&{::)) fp pttril@(2&{::) (ct@] mp mp) trtril1@(1&{::)
hetripu=: (/:@(0&{::)) fp pttril@(2&{::) (ct@] mp mp) trtriu1@(1&{::)

NB. ---------------------------------------------------------
NB. Verb:     Factorization used:          Syntax:
NB. potril    L * L^H = A                  iA=. potril L
NB. potriu    U * U^H = A                  iA=. potriu U
NB.
NB. Description:
NB.   Inverse Hermitian (symmetric) positive definite matrix
NB.    A, represented in factored form
NB. where
NB.   A  - n×n-matrix, Hermitian (symmetric) positive
NB.        definite
NB.   L  - n×n-matrix, the output of potrfl, lower
NB.        triangular Cholesky factor
NB.   U  - n×n-matrix, the output of potrfu, upper
NB.        triangular Cholesky factor
NB.   iA - n×n-matrix, an inversion of A
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   iA -: %. A
NB. where
NB.   iA=. potril potrfl A
NB.   or
NB.   iA=. potriu potrfu A
NB.
NB. Notes:
NB. - potril models LAPACK's xPOTRI('L'), but uses direct,
NB.   not iterative matrix product

potril=: (mp~ ct)@trtril
potriu=: (mp~ ct)@trtriu

NB. ---------------------------------------------------------
NB. Verb:     Factorization used:         Syntax:
NB. pttril    L1 * D * L1^H = A           iA=. [L1D] pttril A
NB. pttriu    U1 * D * U1^H = A           iA=. [U1D] pttriu A
NB.
NB. Description:
NB.   Inverse Hermitian (symmetric) positive definite
NB.   tridiagonal matrix A, represented in factored form
NB. where
NB.   A   - n×n-matrix, Hermitian (symmetric) positive definite
NB.         tridiagonal
NB.   L1D - 2-vector of boxes, the output of pttrfl, the
NB.         matrix A represented in factored form, optional
NB.   U1D - 2-vector of boxes, the output of pttrfu, the
NB.         matrix A represented in factored form, optional
NB.   iA  - n×n-matrix, inversion of A
NB.
NB. Algorithm for pttril [1]:
NB.   In:  A and, optionally, L1D
NB.   Out: iA
NB.   1) if called monatically then:
NB.      1.1) factorize A:
NB.             L1D=. pttrfl A
NB.      1.2) call itself dyadically:
NB.             iA=. L1D $: A
NB.   2) else:
NB.      2.1) calculate Y:
NB.           2.1.1) extract 1st subdiagonal e from L1 and
NB.                  main diagonal d from D:
NB.           2.1.2) prepare iA[:,n-1]:
NB.                    q := conj(e) , 1/d[n-1]
NB.           2.1.3) update q by running products:
NB.                    q[j] := Π{q[j],j=n-1-j:n-1}
NB.                  via reversed infix scan
NB.           2.1.4) negate each q[j] for either even j
NB.                  if n is even, or odd j if n is odd:
NB.                    q[j] := q[j] * (-1)^(n+j+1)
NB.                  by negating each even element of
NB.                  reversed q[j]
NB.           2.1.5) stitch q, work around issue [2] for
NB.                  empty vector, to produce Y = iA[:,n-1]
NB.      2.2) calculate I:
NB.             I := max(0,n-1)
NB.      2.3) calculate X:
NB.           2.3.1) extract 1st subdiagonal a and main
NB.                  diagonal b from A
NB.           2.3.2) form X:
NB.                         (  conj(a[  0])  -b[  1]  -a[  1]  )
NB.                         (  conj(a[  1])  -b[  2]  -a[  2]  )
NB.                    X := (  ...           ...      ...      )
NB.                         (  conj(a[n-3])  -b[n-2]  -a[n-2]  )
NB.                         (  conj(a[n-2])  -b[n-1]  0        )
NB.      2.4) do iterations i=1:I by Power (^:):
NB.             iA=. X step^:I Y
NB.           each iteration takes iA[:,n-i:n-1] and produces
NB.           iA[:,n-i-1:n-1]
NB.           2.4.1) find io:
NB.                    io := -i
NB.           2.4.2) find pi:
NB.                    pi := X[io,:]
NB.           2.4.3) calculate iA[:,n-i-1:n-1]
NB.                  2.4.3.1) find new column iA[:,n-i-1]
NB.                  2.4.3.2) stitch iA[:,n-i:n-1] to
NB.                           iA[:,n-i-1]
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   iA -: %. A
NB. where
NB.   iA=. pttril pttrfl A
NB.
NB. References:
NB. [1] Moawwad El-Mikkawy, El-Desouky Rahmo. A new recursive
NB.     algorithm for inverting general tridiagonal and
NB.     anti-tridiagonal matrices.
NB.     Applied Mathematics and Computation 204 (2008) 368-372
NB.     http://dx.doi.org/10.1016/j.amc.2008.06.053
NB. [2] [Jprogramming] ravel items (,.) of empty list (i.0)
NB.     Igor Zhuravlov, 2010-06-05 10:08:56
NB.     http://jsoftware.com/pipermail/programming/2010-June/019617.html
NB.
NB. TODO:
NB. - pttriu
NB. - A should be sparse

pttril=: ($:~ pttrfl) : ((4 : 0)^:(((0:`(+@])`(_1&diag)`,.`((-@,. 1&(|.!.0))~ }.)`diag fork3)@])`(0>.<:@#@])`(EMPTY"_`,.@.(0<#)@((]`- ag)@(*/\)&.|.)@(((, %@(_1&{ :: ]))~ +)~&>/)@((_1&diag&.>)`(diag&.>) ag)@[)))
  io=. -c y
  pi=. io { x
  ((io (>: upd) +/"1 (}. pi) *"1 (2 {."1 y)) % {. pi) ,. y
)

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testtrtri
NB.
NB. Description:
NB.   Test:
NB.   - 128!:1 (built-in)
NB.   - trtrixx (math/mt addon)
NB.   by triangular matrix given
NB.
NB. Syntax:
NB.   testtrtri A
NB. where
NB.   A - n×n-matrix, lower triangular
NB.
NB. Formula:
NB.   berr := ||I - A * A^_1|| / (FP_EPS * ||A|| * ||A^_1|| * n)

testtrtri=: 3 : 0
  L1=. |: U1=. tru1 U=. |: y
  rcondL=.  trlcon1  y
  rcondL1=. trl1con1 L1
  rcondU=.  trucon1  U
  rcondU1=. tru1con1 U1

  ('128!:1'  tmonad (]`]`(rcondU "_)`(_."_)`(norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]))) U

  ('trtril'  tmonad (]`]`(rcondL "_)`(_."_)`(norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]))) y
  ('trtril1' tmonad (]`]`(rcondL1"_)`(_."_)`(norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]))) L1
  ('trtriu'  tmonad (]`]`(rcondU "_)`(_."_)`(norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]))) U
  ('trtriu1' tmonad (]`]`(rcondU1"_)`(_."_)`(norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]))) U1

  EMPTY
)

NB. ---------------------------------------------------------
NB. testgetri
NB.
NB. Description:
NB.   Test getrixxxx by general matrix given
NB.
NB. Syntax:
NB.   testgetri A
NB. where
NB.   A - n×n-matrix
NB.
NB. Formula:
NB.   berr := ||I - A * A^_1|| / (FP_EPS * ||A|| * ||A^_1|| * n)

testgetri=: 3 : 0
  rcond=. gecon1 y

  ('%.'        tmonad (] `]`(rcond"_)`(_."_)`(           norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]   )))               y

  ('getrilu1p' tmonad (}.`]`(rcond"_)`(_."_)`((0 {:: [) (norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]) ]))) (; getrflu1p) y
  ('getripl1u' tmonad (}.`]`(rcond"_)`(_."_)`((0 {:: [) (norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]) ]))) (; getrfpl1u) y
  ('getripu1l' tmonad (}.`]`(rcond"_)`(_."_)`((0 {:: [) (norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]) ]))) (; getrfpu1l) y
  ('getriul1p' tmonad (}.`]`(rcond"_)`(_."_)`((0 {:: [) (norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]) ]))) (; getrful1p) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testhetri
NB.
NB. Description:
NB.   Test hetripx by Hermitian (symmetric) matrix given
NB.
NB. Syntax:
NB.   testhetri A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric)
NB.
NB. Formula:
NB.   berr := ||I - A * A^_1|| / (FP_EPS * ||A|| * ||A^_1|| * n)

testhetri=: 3 : 0
  rcond=. hecon1 y

  ('hetripl' tmonad (}.`]`(rcond"_)`(_."_)`((0 {:: [) (norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]) ]))) (; hetrfpl) y
  ('hetripu' tmonad (}.`]`(rcond"_)`(_."_)`((0 {:: [) (norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]) ]))) (; hetrfpu) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testpotri
NB.
NB. Description:
NB.   Test hetripx by Hermitian (symmetric) positive definite
NB.   matrix given
NB.
NB. Syntax:
NB.   testpotri A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive definite
NB.
NB. Formula:
NB.   berr := ||I - A * A^_1|| / (FP_EPS * ||A|| * ||A^_1|| * n)

testpotri=: 3 : 0
  rcond=. pocon1 y

  ('potril' tmonad ((1&{::)`]`(rcond"_)`(_."_)`((0 {:: [) (norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]) ]))) (; potrfl) y
  ('potriu' tmonad ((1&{::)`]`(rcond"_)`(_."_)`((0 {:: [) (norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]) ]))) (; potrfu) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testpttri
NB.
NB. Description:
NB.   Test pttri by Hermitian (symmetric) positive definite
NB.   tridiagonal matrix given
NB.
NB. Syntax:
NB.   testpttri A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive
NB.       definite tridiagonal
NB.
NB. Formula:
NB.   berr := ||I - A * A^_1|| / (FP_EPS * ||A|| * ||A^_1|| * n)

testpttri=: 3 : 0
  rcond=. ptcon1 y

  ('pttril' tdyad ((pttrfl@])`]`]`(rcond"_)`(_."_)`(norm1@(<: upddiag)@mp % FP_EPS * *&norm1 * #@]))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testtri
NB.
NB. Description:
NB.   Adv. to make verb to test triangular inversion
NB.   algorithms by matrix of generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testtri
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
NB.     ?@$&0 testtri_mt_ 150 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testtri_mt_ 150 150
NB. - test by random square complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testtri_mt_ 150 150

testtri=: 1 : 'EMPTY_mt_ [ (testpttri_mt_@(u ptmat_mt_) [ testpotri_mt_@(u pomat_mt_) [ testhetri_mt_@(u hemat_mt_) [ testgetri_mt_@u [ testtrtri_mt_@(u trlmat_mt_))^:(=/)'
