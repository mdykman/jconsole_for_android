NB. Balance a matrix or pair of matrices
NB.
NB. gebalxp    Isolate eigenvalues of a general square matrix
NB. gebalxs    Make the rows and columns of a general square
NB.            matrix as close in 1-norm as possible
NB. gebalx     Balance a general square matrix
NB.
NB. ggbalxp    Isolate eigenvalues in a pair of general
NB.            square matrices
NB. ggbals     Make the rows and columns in a pair of general
NB.            square matrices as close in 1-norm as possible
NB. ggbalx     Balance a pair of general square matrices
NB.
NB. testgebal  Test gebalx by general matrix given
NB. testggbal  Test ggbalx by pair of general square matrices
NB.            given
NB. testbal    Adv. to make verb to test gxbalx by
NB.            matrix(-ces) of generator and shape given
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
NB. Scaler constants

GEBALSCLFAC=:  2
GEBALFACTOR=:  0.95
GEBALESFMIN1=: FP_EMIN + FP_FLEN - 1  NB. _1022 + 53 - 1 = _970 , CHECKME: for no gradual underflow case only
GEBALESFMAX1=: - GEBALESFMIN1
GEBALSFMIN1=: GEBALSCLFAC ^ GEBALESFMIN1
GEBALSFMAX1=: GEBALSCLFAC ^ GEBALESFMAX1
GEBALSFMIN2=: GEBALSFMIN1 * GEBALSCLFAC
GEBALSFMAX2=: GEBALSFMAX1 % GEBALSCLFAC

GGBALSCLFAC=: 10

NB. Vector of values:
NB.   GEBALSFMIN2 * GEBALSCLFAC^i
NB. where
NB.   i = {0,1,...,z}
NB.   z = ⌈log_{GEBALSCLFAC}(GEBALSFMAX2)⌉

GEBALPOWMIN=: GEBALSFMIN2 * GEBALSCLFAC ^ i.  1 + >. GEBALSCLFAC ^. GEBALSFMAX2

NB. Vector of values:
NB.   GEBALSFMAX2 / GEBALSCLFAC^(z-i)
NB. where
NB.   i = {0,1,...,z}
NB.   z = ⌈log_{GEBALSCLFAC}(GEBALSFMAX2)⌉

GEBALPOWMAX=: GEBALSFMAX2 % GEBALSCLFAC ^ i. _1 - >. GEBALSCLFAC ^. GEBALSFMAX2

NB. ---------------------------------------------------------
NB. gebalxp1d
NB.
NB. Description:
NB.   Adv. to make verb to traverse single direction
NB.   (rowwise or columnwise) within gebalxp process
NB.
NB. Syntax:
NB.   vapp=. ioz`getv`mkt`dhs gebalxp1d
NB. where
NB.   ioz  - dyad to scan vector, either (i.) or (i:), is
NB.          called as:
NB.            io=. (ioz & 0) vector
NB.   getv - dyad to extract vector from matrix, is either
NB.          ({) or ({"1), is called as:
NB.            vector=. iovector getv matrix
NB.   mkt  - dyad to prepare index for transposition, is
NB.          either (+ <:) or ([), is called as:
NB.            io=. h mkt s
NB.   dhs  - monad to reduce submatrix B11 by excluding row
NB.          and column which are intersecting in the element
NB.          with IO either (<0 0) or (<_1 _1), is either
NB.          (+&0 _1) or (+&1 _1), is called as:
NB.            hs=. dhs hs
NB.   vapp - dyad to traverse single direction, is
NB.          called as:
NB.            'p hs'=. A vapp (p ; hs ; nz)
NB.   nz   - n-vector of non-negative integers, count of
NB.          non-zero elements in rows (columns) of A
NB.   A    - n×n-matrix
NB.   p    - n-vector, full permutation of A
NB.   hs   - 2-vector of integers (h,s) 'head' and 'size',
NB.          defines submatrix B11 position in B
NB.
NB. Algorithm:
NB.   In: A, p, hs, nz
NB.   Out: p, hs
NB.   1) extract verbs ioz, getv, mkt, dhs from u
NB.   2) extract p, hs, nz from y
NB.   3) extract h, s from hs
NB.   4) while there are zeros in nz fragment with rIOS
NB.      (,.hs), traverse direction:
NB.      4.1) find nz amendment (nza) after vectors swapping
NB.           (indirect zi because vector zi may be swapped
NB.           before)
NB.      4.2) prepare index for transposition:
NB.             io=. h mkt s
NB.      4.3) compose non-standard transposition nst
NB.      4.4) try to adjust p by nst
NB.           4.4.1) if failed (i.e. if zi=io), then leave p
NB.                  unchanged
NB.      4.5) adjust nz: try to move zero found in (4) to
NB.           edge, apply all permutations to nza, then amend
NB.           nz by excluded vector
NB.           4.5.1) if failed (i.e. if zi=io), then leave nz
NB.                  unchanged
NB.      4.6) adjust hs to exclude leading (tail) row and
NB.           column
NB.   5) assemble output

gebalxp1d=: 1 : 0
:
  '`ioz getv mkt dhs'=. u
  'p hs nz'=. y
  'h s'=. hs
  while.
    zi=. h + (h ,: s) (ioz & 0 ;. 0) nz
    zi < h + s
  do.
    nza=. (zi { p) (0:`[`(0 ~: getv)) } x
    nst=. < (h mkt s) , zi
    p=. nst C. :: ] p
    nz=. (nst C. :: ] nz) - (p { nza)
    'h s'=. dhs (h , s)
  end.
  p ; (h , s)
)

NB. ---------------------------------------------------------
NB. gebalxp2d
NB.
NB. Description:
NB.   Adv. to make verb to traverse both directions (rowwise
NB.   and columnwise) within gebalxp process
NB.
NB. Syntax:
NB.   vapp=. getv0`getv1 gebalxp2d
NB. where
NB.   getv0 - dyad to extract vector (either row or column)
NB.           from matrix, is either ({) or ({"1), is called
NB.           as:
NB.             vector=. iovector getv matrix
NB.   getv1 - dyad to extract vector (either column or row)
NB.           from matrix, of direction opposite to getv0, is
NB.           either ({) or ({"1), is called as:
NB.             vector=. iovector getv matrix
NB.   vapp  - dyad to traverse both directions, is called as:
NB.             'p hs'=. A vapp (nz0 ,: nz1)
NB.   nz0   - n-vector of non-negative integers, count of
NB.           non-zero elements in either rows or columns
NB.           excluding diagonal
NB.   nz1   - n-vector of non-negative integers, count of
NB.           non-zero elements in either columns or rows
NB.           excluding diagonal, opposite to nz0
NB.   A     - n×n-matrix
NB.   p     - n-vector, full permutation of A
NB.   hs    - 2-vector of integers (h,s) 'head' and 'size',
NB.           defines submatrix B11 position in B
NB.
NB. Algorithm:
NB.   In: A, nz0, nz1
NB.   Out: p, hs
NB.   1) initialize p, hs so that B = B11 = A
NB.   2) extract nz0, which defines 1st traverse direction
NB.      (rowwise or columnwise), from y
NB.   3) use A, p, hs, nz0 to traverse A through the 1st
NB.      direction to accumulate permutations and to reduce
NB.      B11
NB.   4) extract nz1, which defines 2nd traverse direction
NB.      (rowwise or columnwise), opposite to nz0, from y,
NB.      then apply p to nz1
NB.   5) use A, p, hs, nz1 to traverse A through the 2nd
NB.      direction to accumulate permutations and to further
NB.      reduce B11
NB.   6) return p, hs

gebalxp2d=: 1 : 0
:
  n=. # x
  'p hs'=. x i:`(({.u)`:6)`(+ <:)`(+&0 _1) gebalxp1d ((i. n) ; (0,n) ;       ({. y) )
  'p hs'=. x i.`(({:u)`:6)`[     `(+&1 _1) gebalxp1d (p      ; hs    ; (p C. ({: y)))
)

NB. ---------------------------------------------------------
NB. gebalsf
NB.
NB. Description:
NB.   Calculate scaling factor for gebals process
NB.
NB. Syntax:
NB.   f=. gebalsf a,b,c,d,e
NB. where
NB.   a - scalar to scale up
NB.   b = 1, scalar to scale up
NB.   c - scalar to scale down
NB.   d - scalar to control overflow
NB.   e - scalar to control underflow
NB.   f = GEBALSCLFAC^min(i,j,k)
NB.   i = ⌈log_{GEBALSCLFAC}(c/a)⌉, i.e. maximal integer
NB.       safisfying:
NB.         a*f < c/f
NB.   j = ⌈log_{GEBALSCLFAC}(GEBALSFMAX2/d)⌉, i.e. maximal
NB.       integer safisfying:
NB.         d*f < GEBALSFMAX2
NB.   k = ⌈log_{GEBALSCLFAC}(e/GEBALSFMIN2)⌉, i.e. maximal
NB.       integer safisfying:
NB.         e/f > GEBALSFMIN2
NB.
NB. Note:
NB. - conventional (closed) insertion point is calculated by:
NB.     c=. x I. y
NB.   and provides:
NB.     y <: c { x
NB. - alternative (open) insertion point is calculated by:
NB.     o=. x I. (1 + FP_PREC) * y
NB.   or:
NB.     o=. ((1 - FP_EPS) * x) I. y
NB.   and provides:
NB.     y < o { x

gebalsf=: GEBALPOWMAX {~ (GEBALPOWMAX i. (1 { (GEBALSCLFAC ^ 1 1 _1) & ((*^:(({.<{:)@])^:_) (3&{.)))) <. (GEBALESFMAX1 - GEBALPOWMAX I. (1+FP_PREC)*(3{])) <. (GEBALPOWMIN I. (4{]))

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. geballp
NB. gebalup
NB.
NB. Description:
NB.   Permute a general square matrix A by a similarity
NB.   transformation to isolate eigenvalues:
NB.     B = P * A * P
NB.
NB. Syntax:
NB.   'B p hs'=. gebalxp A
NB. where
NB.   A  - n×n-matrix
NB.   B  - n×n-matrix with isolated eigenvalues, being A
NB.        with permuted rows and columns, see storage
NB.        layout
NB.   p  - n-vector, full permutation of A
NB.   hs - 2-vector of integers (h,s) 'head' and 'size',
NB.        defines submatrix B11 position in B
NB.
NB. Algorithm:
NB.   In: A
NB.   Out: B, p, hs
NB.   1) count non-zeros in rows (nzr) and columns (nzc) of A
NB.      without diagonal, then laminate vectors derived:
NB.        nz=. nzc ,: nzr  NB. geballp
NB.        nz=. nzr ,: nzc  NB. gebalup
NB.   2) traverse A's columns from right to left, then rows
NB.      from top to bottom (geballp), or rows from bottom to
NB.      top, then columns from left to right (gebalup), to
NB.      produce p, hs
NB.   3) apply full permutation p to A to produce B:
NB.        B=. p fp A
NB.   7) link B, p, hs to assemple output
NB.
NB. Storage layout:
NB.   geballp:                    gebalup:
NB.         ( Bl00          )         ( Bu00 B01 B02  )
NB.     B = ( B10  B11      )     B = (      B11 B12  )
NB.         ( B20  B21 Bl22 )         (          Bu22 )
NB. where
NB.   Bl00 Bl22 - square lower triangular matrices with
NB.               isolated eigenvalues in diagonal
NB.   Bu00 Bu22 - square upper triangular matrices with
NB.               isolated eigenvalues in diagonal
NB.
NB. Assertions:
NB.   Pinv -: |: P
NB.   B -: P mp A mp Pinv          NB. apply p to rows and columns of A
NB.   B -: p fp A
NB.   B11 -: (,.~ hs) ] ;. 0 B
NB. where
NB.   'B p hs'=. gebalxp A
NB.   P=. p2P p
NB.   Pinv=. %. P
NB.
NB. Notes:
NB. - gebalup models LAPACK's xGEBAL('P')
NB.
NB. References:
NB. [1] Kressner, D. 2004. Numerical methods and software for
NB.     general and structured eigenvalue problems. Ph.D.
NB.     thesis, TU Berlin, Institut für Mathematik, Berlin,
NB.     Germany.

geballp=: [ ((fp~ (0 & {::)) ; ]) (({`({"1) gebalxp2d) (((+/,:(+/"1)) (-"1) diag)@:(0&~:)))
gebalup=: [ ((fp~ (0 & {::)) ; ]) ((({"1)`{ gebalxp2d) (((+/"1,:(+/)) (-"1) diag)@:(0&~:)))

NB. ---------------------------------------------------------
NB. gebals
NB.
NB. Description:
NB.   Apply a diagonal similarity transformation:
NB.     C = D^_1 * B * D
NB.   to make the 1-norms of each row of B11 and its
NB.   corresponding column as close as possible
NB.
NB. Syntax:
NB.   'C p hs d'=. gebals B ; p ; hs
NB. where
NB.   B  - n×n-matrix with isolated eigenvalues, the output
NB.        of gebalxp
NB.   p  - some not changing parameter, the output of gebalxp
NB.   hs - 2-vector of integers (h,s) 'head' and 'size',
NB.        defines submatrix B11 position in B, the output of
NB.        gebalxp
NB.   C  - n×n-matrix, scaled version of B
NB.   d  - n-vector, diagonal of scaling matrix D
NB.
NB. Algorithm:
NB.   In: B, p, hs
NB.   Out: C, d
NB.   1) extract B, p, h and s from y
NB.   2) initialize d (D's diagonal), bt (1st lIO behind
NB.      tail), rios (rIOS of B11 row/column within B
NB.      row/column)
NB.   3) do...:
NB.      3.1) mark scaling process as converged
NB.      3.2) traverse B11, for each i-th pair of row and
NB.           corresp. column:
NB.           3.2.1) extract them and laminate into rc, then
NB.                  replace diagonal elements by zeros
NB.           3.2.2) calculate r and c, the norm1t of row and
NB.                  column
NB.           3.2.3) calculate ra and ca, the magnitudes of
NB.                  largest element in row and column
NB.           3.2.4) calculate
NB.                    fup := GEBALSCLFAC^i
NB.                  where i is mininal integer safisfying:
NB.                    (c*fup) >= (r/(fup*GEBALSCLFAC))
NB.                  or
NB.                    max(fup,c*fup,ca*fup) >= GEBALSFMAX2
NB.                  or
NB.                    min(r/(fup*GEBALSCLFAC),ra/fup) <= GEBALSFMIN2
NB.           3.2.5) scale up c and ca, scale down r and ra:
NB.                    c  := c  * fup
NB.                    ca := ca * fup
NB.                    r  := r  / fup
NB.                    ra := ra / fup
NB.           3.2.6) calculate
NB.                    fdn := GEBALSCLFAC^i
NB.                  where i is mininal integer safisfying:
NB.                    (r*fdn) >= (c/(fdn*GEBALSCLFAC))
NB.                  or
NB.                    max(r*fdn,ra*fdn) >= GEBALSFMAX2
NB.                  or
NB.                    min(fdn,c/(fdn*GEBALSCLFAC),ca/fdn) <= GEBALSFMIN2
NB.           3.2.7) scale down c and scale up r:
NB.                    c := c / fdn
NB.                    r := r * fdn
NB.           3.2.8) calculate scale factor:
NB.                    f := fup / fdn
NB.           3.2.9) if r and c are changed by f
NB.                  considerably, and the following holds:
NB.                    f >= 1 OR d[i] >= 1 OR f*d[i] > GEBALSFMIN1
NB.                  and
NB.                    f <= 1 OR d[i] <= 1 OR d[i] < GEBALSFMAX1/GEBALSCLFAC
NB.                  then:
NB.                  3.2.9.1) scale d[i] by f up
NB.                  3.2.9.2) scale B[i,:] by f down
NB.                  3.2.9.3) scale B[:,i] by f up
NB.                  3.2.9.4) mark scaling process as not
NB.                           yet converged
NB.      ...while not converged
NB.   4) link B, p, hs and d to produce output
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   Dinv -: diagmat % d
NB.   C -: Dinv mp B mp D
NB.   C -: B (*"1 % ]) d
NB. where
NB.   'C p hs d'=. gebals B ; p ; hs
NB.   D=. diagmat d
NB.   Dinv=. %. D
NB.
NB. Application:
NB. - scale non-permuted matrix A (default p and hs),
NB.   i.e. balance without eigenvalues isolating step:
NB.   'C p hs d'=. gebals (];(a:"_);(0,#)) A
NB.
NB. Notes:
NB. - models LAPACK's xGEBAL('S'), with following difference:
NB.   ra and ca never get value from diagonal element
NB.
NB. References:
NB. [1] Kressner, D. 2004. Numerical methods and software for
NB.     general and structured eigenvalue problems. Ph.D.
NB.     thesis, TU Berlin, Institut für Mathematik, Berlin,
NB.     Germany.

gebals=: 3 : 0
  'B p hs'=. y
  'h s'=. hs
  d=. (# B) $ 1
  bt=. h + s
  rios=. ,. hs
  whilst. noconv do.
    noconv=. 0
    i=. <: h
    while. bt > i=. >: i do.
      rc=. rios (] ;. 0)"2 1 i ([ 0:`[`]}"1 { ,: {"1) B
      'r c'=. norm1tr rc
      if. r (*. & (0&~:)) c do.
        'ra ca'=. |@(liofmax { ])"1 rc
        sum=. r + c
        g=. r % GEBALSCLFAC
        fup=. gebalsf c,1,g,(1>.c>.ca),(ra<.g)
        c=. c * fup
        g=. c % GEBALSCLFAC
        r=. r % fup
        fdn=. gebalsf r,1,g,(r>.ra%fup),(fup<.g<.ca*fup)
        f=. fup % fdn
        c=. c % fdn
        r=. r * fdn
        if. (r+c) < GEBALFACTOR*sum do.
          di=. i { d
          if. f (*. & (<&1)) di do.
            if. GEBALSFMIN1 >: f*di do. continue. end.
          end.
          if. f (*. & (>&1)) di do.
            if. di >: GEBALSFMAX1%f do. continue. end.
          end.
          d=. (di*f) i } d
          B=. i  (%&f) upd    B
          B=. i ((*&f) upd)"1 B
          noconv=. 1
        end.
      end.
    end.
  end.
  B ; p ; hs ; d
)

NB. ---------------------------------------------------------
NB. geball
NB. gebalu
NB.
NB. Description:
NB.   Balance a general square matrix A. This involves,
NB.   first, isolating eigenvalues (see gebalxp):
NB.     B = P * A * P
NB.   and second, making the rows and columns of B11 as close
NB.   in 1-norm as possible (see gebals):
NB.     C = D^_1 * B * D
NB.
NB. Syntax:
NB.   'C p hs d'=. gebalx A
NB. where
NB.   A  - n×n-matrix
NB.   C  - n×n-matrix, balanced version of A
NB.   p  - n-vector, full permutation of A
NB.   hs - 2-vector of integers (h,s) 'head' and 'size',
NB.        defines submatrix B11 position in B (see gebalxp)
NB.   d  - n-vector, diagonal of scaling matrix D (see
NB.        gebals)
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   p -: pp
NB.   hs -: hsp
NB.   Pinv -: |: P
NB.   Dinv -: diagmat % d
NB.   B -: P mp A mp Pinv          NB. apply p to rows and columns of A
NB.   B -: p fp A
NB.   C -: Dinv mp B mp D
NB.   C -: B (*"1 % ]) d
NB.   B11 -: (,.~ hs) (] ;. 0) B
NB.   C11 -: (,.~ hs) (] ;. 0) C
NB. where
NB.   'B pp hsp'=. gebalxp A
NB.   'C p hs d'=. gebalx A
NB.   P=. p2P p
NB.   Pinv=. %. P
NB.   D=. diagmat d
NB.   Dinv=. %. D
NB.
NB. Notes:
NB. - gebalu models LAPACK's xGEBAL('B')

geball=: gebals @ geballp
gebalu=: gebals @ gebalup

NB. ---------------------------------------------------------
NB. ggballp
NB. ggbalup
NB.
NB. Description:
NB.   Permute general square matrices A and B by a similarity
NB.   transformation to isolate eigenvalues:
NB.     C = Pl * A * Pr
NB.     D = Pl * B * Pr
NB.
NB. Syntax:
NB.   'CD plr hs'=. ggbalxp AB
NB. where
NB.   AB  -: A ,: B
NB.   CD  -: C ,: D
NB.   A,B - n×n-matrix
NB.   C,D - n×n-matrix with isolated eigenvalues, being A and
NB.          B with permuted rows and columns, for storage
NB.          layout see gebalxp
NB.   plr -: pl ,: pr
NB.   pl  - n-vector, rows permutation of A and B
NB.   pr  - n-vector, columns permutation of A and B
NB.   hs  - 2-vector of integers (h,s) 'head' and 'size',
NB.         defines submatrices C11 and D11 position in C and
NB.         D, respectively
NB.
NB. Assertions:
NB.   Prinv -: |: Pr
NB.   CD -: Pl mp"2 AB mp"2 Prinv             NB. apply pr to columns of A and B
NB.   CD -: AB ((C."2~ {.) (C."1~ {:) ]) plr
NB.   CD11 -: (0 2 ,. ,.~ hs) ] ;. 0 CD
NB. where
NB.   'CD plr hs'=. ggbalxp AB
NB.   'Pl Pr'=. p2P"1 plr
NB.   Prinv=. %. Pr
NB.
NB. Notes:
NB. - ggbalup implements LAPACK's xGGBAL('P')

ggballp=: 3 : 0
  s=. n=. c y
  h=. 0
  pl=. pr=. i. n
  j=. h+s-1
  while. j >: h do.
    v=. (0 2 ,. (h,s) ,. (j,1)) ,@(+./)@:(0&~:) ;. 0 y
    lios=. I. 0 ~: v
    select. # lios
      fcase. 1 do.
        nst=. < j , (h+s-1)
        pr=. nst C. :: ] pr
        y=. nst C."1 :: ] y
      case. 0 do.
        nst=. < (h + {. lios) , (h+s-1)
        pl=. nst C. :: ] pl
        y=. nst C."2 :: ] y
        s=. <: s
        j=. h+s-1
      case. do.
        j=. <: j
    end.
  end.
  i=. h
  while. i < (h+s) do.
    v=. (0 2 ,. (i,1) ,. (h,s)) ,@(+./)@:(0&~:) ;. 0 y
    lios=. I. 0 ~: v
    select. # lios
      fcase. 1 do.
        nst=. < i , h
        pl=. nst C. :: ] pl
        y=. nst C."2 :: ] y
      case. 0 do.
        nst=. < (h + {. lios) , h
        pr=. nst C. :: ] pr
        y=. nst C."1 :: ] y
        i=. h=. >: h
        s=. <: s
      case. do.
        i=. >: i
    end.
  end.
  y ; (pl ,: pr) ; (h , s)
)

ggbalup=: 3 : 0
  s=. n=. c y
  h=. 0
  pl=. pr=. i. n
  i=. h+s-1
  while. i >: h do.
    v=. (0 2 ,. (i,1) ,. (h,s)) ,@(+./)@:(0&~:) ;. 0 y
    lios=. I. 0 ~: v
    select. # lios
      fcase. 1 do.
        nst=. < i , (h+s-1)
        pl=. nst C. :: ] pl
        y=. nst C."2 :: ] y
      case. 0 do.
        nst=. < (h + {. lios) , (h+s-1)
        pr=. nst C. :: ] pr
        y=. nst C."1 :: ] y
        s=. <: s
        i=. h+s-1
      case. do.
        i=. <: i
    end.
  end.
  j=. h
  while. j < (h+s) do.
    v=. (0 2 ,. (h,s) ,. (j,1)) ,@(+./)@:(0&~:) ;. 0 y
    lios=. I. 0 ~: v
    select. # lios
      fcase. 1 do.
        nst=. < j , h
        pr=. nst C. :: ] pr
        y=. nst C."1 :: ] y
      case. 0 do.
        nst=. < (h + {. lios) , h
        pl=. nst C. :: ] pl
        y=. nst C."2 :: ] y
        j=. h=. >: h
        s=. <: s
      case. do.
        j=. >: j
    end.
  end.
  y ; (pl ,: pr) ; (h , s)
)

NB. ---------------------------------------------------------
NB. ggbals
NB.
NB. Description:
NB.   Apply a diagonal similarity transformation:
NB.     E = Dl * C * Dr
NB.     F = Dl * D * Dr
NB.   to make the 1-norms of each row of E11 (F11) and its
NB.   corresponding column as close as possible
NB.
NB. Syntax:
NB.   'EF plr hs dlr'=. ggbals CD ; plr ; hs
NB. where
NB.   CD  -: C ,: D
NB.   C,D - n×n-matrix with isolated eigenvalues, the output
NB.        of ggbalxp
NB.   plr - some not changing parameter, the output of
NB.         ggbalxp
NB.   hs  - 2-vector of integers (h,s) 'head' and 'size',
NB.         defines submatrices E11 and F11 position in E and
NB.         F, respectively, the output of ggbalxp
NB.   EF  -: E ,: F
NB.   E   - n×n-matrix, scaled version of C
NB.   F   - n×n-matrix, scaled version of D
NB.   dlr -: dl ,: dr
NB.   dl  - n-vector, diagonal of scaling matrix Dl
NB.   dr  - n-vector, diagonal of scaling matrix Dr
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   EF -: Dl mp"2 CD mp"2 Dr
NB.   EF -: CD ((*"2~ {.) (*"1 {:) ]) dlr
NB.   EF11 -: (0 2 ,. ,.~ hs) ] ;. 0 EF
NB. where
NB.   'EF plr hs dlr'=. ggbals CD ; plr ; hs
NB.   'Dl Dr'=. diagmat"1 dlr
NB.
NB. Application:
NB. - scale non-permuted matrices A and B (default plr and
NB.   hs), i.e. balance without eigenvalues isolating step:
NB.     'EF plr hs dlr'=. ggbals (];(a:"_);(0,c)) AB
NB.
NB. Notes:
NB. - ggbals implements LAPACK's xGGBAL('S')

ggbals=: 3 : 0
  m3x=. - 3&*
  mix=. ((* +/@:(+/"1))~ {.) + ((+/@:(+/@#"1)) {:)

  'CD plr hs'=. y
  nzCDcut=. 0 ~: CDcut=. (0 2 ,. ,.~ hs) ] ;. 0 CD
  'h s'=. hs
  w10=. w23=. dlr=. (2 , s) $ 0

  NB. compute RHS vector in resulting linear equations
  w45=. (+/"1,:(+/)) - (+/) GGBALSCLFAC ^. sorim nzCDcut } 1 ,: CDcut
  coef5=. -: coef2=. *: coef=. % +: s
  beta=. k=. 0
  NB. start generalized conjugate gradient iteration
  while. k < s + 2 do.
    gamma=. (+&(mp~))/ w45
    ewewc=. +/"1 w45
    gamma=. (coef , - coef2 , coef5) mp (gamma , (((+&*:),(*:@-))/ ewewc))
    if. gamma = 0 do. break. end.
    if. k ~: 0 do. beta=. gamma % pgamma end.
    w10=. (beta * w10) + (coef * w45) + (coef5 * ((m3x~,m3x)/ ewewc))
    NB. apply matrix to vector
    w23=. nzCDcut (mix ,: ((mix~ (|:"2))~ |.)) w10
    alpha=. gamma % (+/) w10 mp"1 w23
    NB. determine correction to current iteration
    aw10=. alpha * w10
    dlr=. dlr + aw10
    cmax=. normi , aw10
    if. cmax < 0.5 do. break. end.
    w45=. w45 - alpha * w23
    pgamma=. gamma
    k=. >: k
  end.
  NB. end generalized conjugate gradient iteration
  lsfmin=. >. >: GGBALSCLFAC ^.   FP_SFMIN
  lsfmax=. <.    GGBALSCLFAC ^. % FP_SFMIN
  irab=. h + (0 2 ,. hs ,. (h , _)) liofmax"1 ;. 0 CD
  icab=. (0 2 ,. (0 , (h + s)) ,. hs) liofmax"1@:(|:"2) ;. 0 CD
  rab=. >./ | (<"1 irab ,.~"1 (dhs2lios hs)) {"1 2 CD
  cab=. >./ | (<"1 icab ,. "1 (dhs2lios hs)) {"1 2 CD
  lxab=. >.`<.@.(0&<:)"0 >: GGBALSCLFAC ^. FP_SFMIN + rab ,: cab
  dlr=. GGBALSCLFAC ^ lsfmax <. (lsfmax - lxab) <. lsfmin >. <. 0.5 + dlr
  dlr=. (-h) |."1 (c CD) {.!.1"1 dlr  NB. adjust dlr's shape
  CD=. ({. dlr) *"1 2 CD              NB. row scaling of matrices C and D
  CD=. ({: dlr) *"1 1 CD              NB. column scaling of matrices C and D
  CD ; plr ; hs ; dlr
)

NB. ---------------------------------------------------------
NB. ggball
NB. ggbalu
NB.
NB. Description:
NB.   Balance a general square matrices A abd B. This
NB.   involves, first, isolating eigenvalues (see ggbalxp):
NB.     C = Pl * A * Pr
NB.     D = Pl * B * Pr
NB.   and second, making the rows and columns of E11 (F11) as
NB.   close in 1-norm as possible (see ggbals):
NB.     E = Dl * C * Dr
NB.     F = Dl * D * Dr
NB.
NB. Syntax:
NB.   'EF plr hs dlr'=. ggbalx AB
NB. where
NB.   AB  -: A ,: B
NB.   EF  -: E ,: F
NB.   plr -: pl ,: pr
NB.   hs  - 2-vector of integers (h,s) 'head' and 'size',
NB.         defines submatrices E11 and F11 position in E and
NB.         F, respectively (see ggbalxp)
NB.   dlr -: dl ,: dr
NB.   A,B - n×n-matrix
NB.   E   - n×n-matrix, balanced version of A
NB.   F   - n×n-matrix, balanced version of B
NB.   pl  - n-vector, rows permutation of A and B
NB.   pr  - n-vector, columns permutation of A and B
NB.   dl  - n-vector, diagonal of scaling matrix Dl
NB.   dr  - n-vector, diagonal of scaling matrix Dr
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   plr -: plrp
NB.   hs -: hsp
NB.   Prinv -: |: Pr
NB.   CD -: Pl mp"2 AB mp"2 Prinv             NB. apply pr to columns of A and B
NB.   CD -: AB ((C."2~ {.) (C."1~ {:) ]) plr
NB.   EF -: Dl mp"2 CD mp"2 Dr
NB.   EF -: CD ((*"2~ {.) (*"1 {:) ]) dlr
NB.   CD11 -: (0 2 ,. ,.~ hs) ] ;. 0 CD
NB.   EF11 -: (0 2 ,. ,.~ hs) ] ;. 0 EF
NB. where
NB.   'CD plrp hsp'=. ggbalxp AB
NB.   'EF plr hs dlr'=. ggbalx AB
NB.   'Pl Pr'=. p2P"1 plr
NB.   Prinv=. %. Pr
NB.   'Dl Dr'=. diagmat"1 dlr
NB.
NB. Notes:
NB. - ggbalu implements LAPACK's xGGBAL('B')

ggball=: ggbals @ ggballp
ggbalu=: ggbals @ ggbalup

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testgebal
NB.
NB. Description:
NB.   Test:
NB.   - gebal (math/lapack)
NB.   - gebalx (math/mt)
NB.   by general matrix given
NB.
NB. Syntax:
NB.   testgebal A
NB. where
NB.   A - n×n-matrix
NB.
NB. TODO:
NB. - consider [1]
NB.
NB. References:
NB. [1] Michael H. Schneider, Stavros A. Zenios. A
NB.     Comparative Study of Algorithms for Matrix Balancing.
NB.     Operations Research. Vol. 38. No. 3. May-June 1990

testgebal=: 3 : 0
  require :: ] '~addons/math/lapack/lapack.ijs'
  need_jlapack_ :: ] 'gebal'

  rcond=. gecon1 y

  ('gebal_jlapack_' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) y

  ('geball' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) y
  ('gebalu' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testggbal
NB.
NB. Description:
NB.   Test ggbalx by pair of general matrices given
NB.
NB. Syntax:
NB.   testggbal (A ,: B)
NB. where
NB.   A,B - n×n-matrix

testggbal=: 3 : 0
  rcond=. <./ gecon1"2 y

  ('ggball' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) y
  ('ggbalu' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testbal
NB.
NB. Description:
NB.   Adv. to make verb to test gxbalx by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testbal
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
NB.     ?@$&0 testbal_mt_ 150 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) testbal_mt_ 150 150
NB. - test by random square complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testbal_mt_ 150 150

testbal=: 1 : 'EMPTY_mt_ [ (testggbal_mt_ @ (u spmat_mt_ 0.25) @ (2&,) ^: (=/)) [ (testgebal_mt_ @ (u spmat_mt_ 0.25) ^: (=/))'
