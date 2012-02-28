NB. Condition number
NB.
NB. con     Conj. to make verb estimating the reciprocal of
NB.         the condition number of a matrix in a given norm
NB. xxconx  Calculate reciprocal of the condition number of a
NB.         matrix in a given norm
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
NB. con
NB.
NB. Description:
NB.   Conj. to make verb estimating the reciprocal of the
NB.   condition number of a matrix in a given norm
NB.
NB. Syntax:
NB.   vapp=. norm con inv
NB. where
NB.   norm - monadic verb to calculate norm of matrix, is
NB.          called as:
NB.            normA=. norm A
NB.   inv  - monadic verb to inverse square matrix, is called
NB.          as:
NB.            invA=. inv A
NB.   vapp - monadic verb to calculate the reciprocal of the
NB.          condition number of a matrix in a given norm, is
NB.          called as:
NB.            rcondA=. vapp A
NB.   A    - n×n-matrix
NB.
NB. TODO:
NB. - implement more practical norm-estimation approach

con=: 2 : '*&(%@u) v'

NB. ---------------------------------------------------------
NB. gecon1
NB. geconi
NB. hecon1
NB. heconi
NB. pocon1
NB. poconi
NB. ptcon1
NB. ptconi
NB. trl1con1
NB. trl1coni
NB. trlcon1
NB. trlconi
NB. tru1con1
NB. tru1coni
NB. trucon1
NB. truconi
NB. uncon1
NB.
NB. Description:
NB.   Calculate reciprocal of the condition number of a
NB.   matrix in a given norm
NB.
NB. Syntax:
NB.   normG=. geconx G
NB.   normH=. heconx H
NB.   normP=. poconx P
NB.   normT=. ptconx T
NB.   normR=. trxxconx R
NB.   normQ=. uncon1 Q
NB. where
NB.   G     - n×n-matrix of type: general, band,
NB.           tridiagonal, triangular or triangular band
NB.   normG ≥ 0, reciprocal of the condition number of G
NB.   H     - n×n-matrix of type: Hermitian (symmetric)
NB.   normH ≥ 0, reciprocal of the condition number of H
NB.   P     - n×n-matrix of type: Hermitian (symmetric)
NB.           positive definite
NB.   normP ≥ 0, reciprocal of the condition number of P
NB.   T     - n×n-matrix of type: Hermitian (symmetric)
NB.           positive definite tridiagonal
NB.   normT ≥ 0, reciprocal of the condition number of T
NB.   R     - n×n-matrix of type: triangular
NB.   normR ≥ 0, reciprocal of the condition number of R
NB.   Q     - n×n-matrix, unitary (orthogonal)
NB.   normQ ≥ 0, reciprocal of the condition number of Q in
NB.           1-norm
NB.
NB. Notes:
NB. - extraneous values in triangular, band matrices must be
NB.   zeroed
NB. - gecon1 simulates LAPACK's xGECON('1'), xGBCON('1'),
NB.   xGTCON('1'), xTBCON('1')
NB. - geconi simulates LAPACK's xGECON('i'), xGBCON('i'),
NB.   xGTCON('i'), xTBCON('i')
NB. - hecon1 simulates LAPACK's DSYCON('1'), ZHECON('1')
NB. - heconi simulates LAPACK's DSYCON('i'), ZHECON('i')
NB. - pocon1 simulates LAPACK's xPBCON('1'), xPOCON('1')
NB. - poconi simulates LAPACK's xPBCON('i'), xPOCON('i')
NB. - ptcon1 simulates LAPACK's xPTCON('1')
NB. - ptconi simulates LAPACK's xPTCON('i')
NB. - trl1con1 simulates LAPACK's xTRCON('1','L','U')
NB. - trl1coni simulates LAPACK's xTRCON('i','L','U')
NB. - trlcon1 simulates LAPACK's xTRCON('1','L','N')
NB. - trlconi simulates LAPACK's xTRCON('i','L','N')
NB. - tru1con1 simulates LAPACK's xTRCON('1','U','U')
NB. - tru1coni simulates LAPACK's xTRCON('i','U','U')
NB. - trucon1 simulates LAPACK's xTRCON('1','U','N')
NB. - truconi simulates LAPACK's xTRCON('i','U','N')

gecon1=: norm1 con (getrilu1p@getrflu1p)
geconi=: normI con (getrilu1p@getrflu1p)

hecon1=: norm1 con (hetripl@hetrfpl)
heconi=: normi con (hetripl@hetrfpl)

pocon1=: norm1 con (potril@potrfl)
poconi=: normi con (potril@potrfl)

ptcon1=: norm1 con pttril
ptconi=: normi con pttril

trl1con1=: norm1 con trtril1
trl1coni=: normi con trtril1
trlcon1=:  norm1 con trtril
trlconi=:  normi con trtril
tru1con1=: norm1 con trtriu1
tru1coni=: normi con trtriu1
trucon1=:  norm1 con trtriu
truconi=:  normi con trtriu

uncon1=: norm1 con ct
