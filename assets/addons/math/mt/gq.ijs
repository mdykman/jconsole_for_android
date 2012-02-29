NB. Generate matrix with orthonormal rows or columns from its
NB. factored form
NB.
NB. ungxx      Generate a matrix with orthonormal rows or
NB.            columns from output of gexxf
NB. unghrx     Generate an unitary (orthogonal) matrix which
NB.            is defined as the product of elementary
NB.            reflectors as returned by gehrdx
NB.
NB. testungq   Test ungxx by general matrix given
NB. testunghr  Test unghrx by square matrix given
NB. testgq     Adv. to make verb to test ungxxx by matrix of
NB.            generator and shape given
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

gqvberr=: 2 : '((norm1_mt_@(<: upddiag_mt_)@(u ct_mt_)) % (FP_EPS_mt_ * v))@]'  NB. conj. to form verb to calc. berr

NB. ---------------------------------------------------------
NB. Blocked code constants

GQNB=: 32   NB. block size limit
GQNX=: 128  NB. crossover point, GQNX ≥ GQNB

NB. ---------------------------------------------------------
NB. gqi
NB.
NB. Description: Number of iterations
NB. Syntax:      iters=. gqi k
NB. where        k = min(rows,columns)
NB. Formula:     iters = max(0,⌊(k+NB-NX-1)/NB⌋)
NB. Notes:       is memo, since repetitive calls are expected

gqi=: (0 >. <.@(GQNB %~ (_1+GQNB-GQNX)&+))M.

NB. ---------------------------------------------------------
NB. gqb
NB.
NB. Description: Size of submatrix processed by blocked algo
NB. Syntax:      size=. gqb k
NB. where        k = min(rows,columns)
NB. Formula:     size = min(k,NB*iters)
NB. Notes:       is memo, since repetitive calls are expected

gqb=: (<. (GQNB * gqi))M.

NB. ---------------------------------------------------------
NB. Description:
NB.   Single step of non-blocked version of algorithms
NB.
NB. Syntax:
NB.   eQi1=. (s;Qf) ungxxstep eQi
NB. where
NB.   eQi  - Qi augmented by trash vector
NB.   Qi   - Q(i), the matrix Q after i-th step and before
NB.          (i+1)-th one
NB.   Qf   - k×(n+1)-matrix for ungl2 and ungr2, or
NB.          (m+1)×k-matrix for ung2l and ung2r, unit
NB.          triangular, the Q's factored form
NB.   s    - integer in range either [0,n] for ungl2 and
NB.          ungr2 or [0,m] for ung2l and ung2r
NB.   eQi1 - Qi1 augmented by modified trash vector
NB.   Qi1  - Q(i+1), the matrix Q after (i+1)-th step
NB.   Q    - s×n-matrix for ungl2 and ungr2, or m×s-matrix
NB.          for ung2l and ung2r, with orthonormal
NB.          rows/columns which is defined as the first/last
NB.          rows/columns of a product of s elementary
NB.          reflectors (see corresp. ung{lq,ql,qr,rq})
NB.   k    = min(m,n)
NB.   i    - integer in range [0,k]
NB.
NB. Algorithm:
NB.   1) augment eQ(i) by zero vector
NB.   2) find rIOS of z(i) in Qf which describes a current
NB.      elementary reflector H(i)≡H(v(i),τ(i))
NB.   3) extract vector z(i) from Qf and ravel it
NB.   4) reconstruct an elementary reflector H(i) from z(i)
NB.   5) update augmented eQ(i) by H(i)
NB.   6) reconstruct vector subQ(i) from z(i)
NB.   7) merge subQ(i) with updated eQ(i) to produce eQ(i+1)
NB.
NB. Notes:
NB. - ung{l2,2l,2r,r2} and corresp. ung{lq,ql,qr,rq} are
NB.   topologic equivalents

ungl2step=: ((1 _ ,:~ (0 {:: [) <:@-  #@]) (,;.0) 1 {:: [) (((>:@]  0} *) +@-@{:)@[ ,   larfrcfr) 0 ,.  ]
ung2lstep=: ((_ 1 ,:~ (0 {:: [)    -~ c@]) (,;.0) 1 {:: [) (((>:@] _1} *)   -@{.)@[ ,.~ larflnbc) 0 , ~ ]
ung2rstep=: ((_ 1 ,:~ (0 {:: [) <:@-  c@]) (,;.0) 1 {:: [) (((>:@]  0} *)   -@{:)@[ ,.  larflnfc) 0 ,   ]
ungr2step=: ((1 _ ,:~ (0 {:: [)    -~ #@]) (,;.0) 1 {:: [) (((>:@] _1} *) +@-@{.)@[ , ~ larfrcbr) 0 ,.~ ]

NB. ---------------------------------------------------------
NB. Description:
NB.   Reconstruct matrix Q, augmented by trash vector, from
NB.   its elementary reflectors. Non-blocked version of
NB.   algorithms
NB.
NB. Syntax:
NB.   eQ=. s ungxx Qf
NB. where
NB.   Qf - k×(n+1)-matrix for ungl2 and ungr2, or
NB.        (m+1)×k-matrix for ung2l and ung2r, unit
NB.        triangular, the Q's factored form
NB.   s  - integer in range either [0,n] for ungl2 and ungr2
NB.        or [0,m] for ung2l and ung2r
NB.   eQ - Q augmented by trash vector
NB.   Q  - s×n-matrix for ungl2 and ungr2, or m×s-matrix for
NB.        ung2l and ung2r, with orthonormal rows/columns
NB.        which is defined as the first/last rows/columns of
NB.        a product of s elementary reflectors (see corresp.
NB.        ung{lq,ql,qr,rq})
NB.   k  = min(m,n)
NB.
NB. Algorithm:
NB.   1) form eQ(0) as unit matrix of proper size
NB.   2) do iterations: eQ=. (s;Qf) (ungxxstep^:k) eQ0
NB.
NB. Assertions:
NB.   (] -: clean@((         trl   @:(}:"1)) mp  ((}:"1)@(# ungl2 ])@         tru1   @(  k & {.   )))@gelqf) A
NB.   (] -: clean@((((-~/@$) trl ])@: }.   ) mp~ ( }.   @(c ung2l ])@((-~/@$) tru1 ])@((-k)&({."1))))@geqlf) A
NB.   (] -: clean@((         tru   @: }:   ) mp~ ( }:   @(c ung2r ])@         trl1   @(  k &({."1))))@geqrf) A
NB.   (] -: clean@((((-~/@$) tru ])@:(}."1)) mp  ((}."1)@(# ungr2 ])@((-~/@$) trl1 ])@((-k)& {.   )))@gerqf) A
NB. where
NB.   k=. <./ $ A
NB.
NB. Notes:
NB. - ungl2 implements LAPACK's DORGL2, ZUNGL2
NB. - ung2l implements LAPACK's DORG2L, ZUNG2L
NB. - ung2r implements LAPACK's DORG2R, ZUNG2R
NB. - ungr2 implements LAPACK's DORGR2, ZUNGR2
NB.
NB. TODO:
NB. - case s<k must be allowed, too

ungl2=: ungl2step^:(;`(#@])`( idmat        @((,  c)-#@])))
ung2l=: ung2lstep^:(;`(c@])`((idmat~ (-~/))@((,~ #)-c@])))
ung2r=: ung2rstep^:(;`(c@])`( idmat        @((,~ #)-c@])))
ungr2=: ungr2step^:(;`(#@])`((idmat~ (-~/))@((,  c)-#@])))

NB. ---------------------------------------------------------
NB. Description:
NB.   Single step of algorithms
NB.
NB. Syntax:
NB.   eQi1=.    Qf  ungxxstep eQi         NB. unglq,ungqr
NB.   eQi1=. (s;Qf) ungxxstep eQi         NB. ungql,ungrq
NB. where
NB.   eQi  - Qi augmented by trash vector
NB.   Qi   - Q(i), the matrix Q at i-th step and before
NB.          (i+1)-th one
NB.   Qf   - k×(n+1)-matrix for unglq and ungrq, or
NB.          (m+1)×k-matrix for ungql and ungqr, unit
NB.          triangular, the Q's factored form
NB.   s    - integer in range either [0,n] for unglq and
NB.          ungrq or [0,m] for ungql and ungqr
NB.   eQi1 - Qi1 augmented by modified trash vector
NB.   Qi1  - Q(i+1), the matrix Q after (i+1)-th step
NB.   Q    - s×n-matrix for unglq and ungrq, or m×s-matrix
NB.          for ungql and ungqr, with orthonormal
NB.          rows/columns which is defined as the first/last
NB.          rows/columns of a product of s elementary
NB.          reflectors (see corresp. ung{lq,ql,qr,rq})
NB.   k    = min(m,n)
NB.   i    - integer in range [0,gqi(k)]
NB.
NB. Algorithm:
NB.   1) augment eQ(i) by zero block
NB.   2) find rIOS of Z(i) in Qf which describes a current
NB.      block reflector H(i)≡H(V(i),Τ(i))
NB.   3) extract matrix Z(i) from Qf
NB.   4) reconstruct a block reflector H(i) from Z(i)
NB.   5) update augmented eQ(i) by H(i)
NB.   6) reconstruct matrix subQ(i) from Z(i) by non-blocked
NB.      version of algorithm
NB.   7) merge subQ(i) with updated eQ(i) to produce eQ(i+1)
NB.
NB. Notes:
NB. - ung{l2,2l,2r,r2} and corresp. ung{lq,ql,qr,rq} are
NB.   topologic equivalents

unglqstep=: ((((GQNB, _),:~(-&c))                       (] ;. 0)       [) (((ungl2~ #)@[) ,   larfbrcfr) ]) ({."1~ ((-GQNB)-c))
ungqrstep=: ((((GQNB,~_),:~(-&#))                       (] ;. 0)       [) (((ung2r~ c)@[) ,.  larfblnfc) ]) ({.  ~ ((-GQNB)-#))

ungqlstep=: ((((GQNB,~_),:~(0 {:: [) ((GQNB-1)+-~) c@]) (] ;. 0) 1 {:: [) (((ung2l~ c)@[) ,.~ larfblnbc) ]) ({.  ~ (  GQNB +#))
ungrqstep=: ((((GQNB, _),:~(0 {:: [) ((GQNB-1)+-~) #@]) (] ;. 0) 1 {:: [) (((ungr2~ #)@[) , ~ larfbrcbr) ]) ({."1~ (  GQNB +c))

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. unglq
NB.
NB. Description:
NB.   Generate a matrix with orthonormal rows from output of
NB.   gelqf
NB.
NB. Syntax:
NB.   Q=. [s] unglq LQf
NB. where
NB.   LQf - m×(n+1)-matrix, the output of gelqf
NB.   Q   - s×n-matrix with orthonormal rows, which is
NB.         defined as the first s rows of a product of m
NB.         elementary reflectors of order n:
NB.           Q = Π{H(i)',i=m-1:0}
NB.         where
NB.           H(m-1:s)≡H(v(m-1:s),τ(m-1:s))=H(0,0)=I
NB.   s   - integer in range [0,n], default is k
NB.   k   = min(m,n)
NB.
NB. Algorithm:
NB.   1) extract Qf from LQf selecting only first min(s,k)
NB.      rows
NB.   2) make Qf the unit upper triangular
NB.   3) call ungl2, the non-blocked version of algorithm,
NB.      with arguments supplied: adjusted s, and Qf with
NB.      part intended for blocked algorithm being excluded,
NB.      to produce eQ(0)
NB.   4) find iters, the number of iterations
NB.   5) do iterations:
NB.        eQ=.    Qf  (unglqstep^:iters) eQ0
NB.   6) cut off last column from eQ to produce Q
NB.
NB. Storage layout:
NB.   example for m=4, n=5:       example for m=5, n=4:
NB.   (  l  v0 v0 v0 v0 τ0  )     (  l  v0 v0 v0 τ0  )
NB.   (  l  l  v1 v1 v1 τ1  )     (  l  l  v1 v1 τ1  )
NB.   (  l  l  l  v2 v2 τ2  )     (  l  l  l  v2 τ2  )
NB.   (  l  l  l  l  v3 τ3  )     (  l  l  l  l  τ3  )
NB.                               (  l  l  l  l  *   )
NB. where
NB.   l         - elements of m×k-matrix L, lower triangular
NB.   (1,vi,τi) - vector z(i) which defines an elementary
NB.               reflector H(i) (unit is not stored, v(i)
NB.               may be empty)
NB.   *         - any value, is not used
NB.
NB. Assertions:
NB.   (idmat@ms@$ -: clean@(mp  ct)) Q
NB. where
NB.   Q=. unglq gelqf A
NB.
NB. Notes:
NB. - implements LAPACK's DORGLQ, ZUNGLQ
NB. - straightforward O(k*m^3) code:
NB.   Q=. k {. mp/ (idmat n) -"2 |. (+ {:"1 Qf) * (* +)"0/~"1 + }:"1 Qf

unglq=: ($:~ ( 0 _1&(ms $))) : ( 0 _1 }. ([ (unglqstep^:(]`(gqi@#@])`((-(gqb@#)) ungl2 ((}.~ (2 # (  gqb@#)))@])))) ( tru1            @((   <. ( 0 _1&(ms $)) ) {.   ]))))

NB. ---------------------------------------------------------
NB. ungql
NB.
NB. Description:
NB.   Generate a matrix with orthonormal columns from output
NB.   of geqlf
NB.
NB. Syntax:
NB.   Q=. [s] ungql QfL
NB. where
NB.   QfL - (m+1)×n-matrix, the output of geqlf
NB.   Q   - m×s-matrix with orthonormal columns, which is
NB.         defined as the last s columns of a product of n
NB.         elementary reflectors of order m:
NB.           Q = Π{H(i),i=n-1:0}
NB.         where
NB.           H(n-1:s)≡H(v(n-1:s),τ(n-1:s))=H(0,0)=I
NB.   s   - integer in range [0,m], default is k
NB.   k   = min(m,n)
NB.
NB. Algorithm:
NB.   1) extract Qf from QfL selecting only last min(s,k)
NB.      columns
NB.   2) make Qf the unit upper triangular
NB.   3) call ung2l, the non-blocked version of algorithm,
NB.      with arguments supplied: adjusted s, and Qf with
NB.      part intended for blocked algorithm being excluded,
NB.      to produce eQ(0)
NB.   4) find iters, the number of iterations
NB.   5) do iterations:
NB.        eQ=. (s;Qf) (ungqlstep^:iters) eQ0
NB.   6) cut off first row from eQ to produce Q
NB.
NB. Storage layout:
NB.   example for m=4, n=5:       example for m=5, n=4:
NB.   (  *  τ1 τ2 τ3 τ4  )        (  τ0 τ1 τ2 τ3  )
NB.   (  l  l  v2 v3 v4  )        (  v0 v1 v2 v3  )
NB.   (  l  l  l  v3 v4  )        (  l  v1 v2 v3  )
NB.   (  l  l  l  l  v4  )        (  l  l  v2 v3  )
NB.   (  l  l  l  l  l   )        (  l  l  l  v3  )
NB.                               (  l  l  l  l   )
NB. where
NB.   l         - elements of k×n-matrix L, lower triangular
NB.   (1,vi,τi) - vector z(i) which defines an elementary
NB.               reflector H(i) (unit is not stored, v(i)
NB.               may be empty)
NB.   *         - any value, is not used
NB.
NB. Assertions:
NB.   (idmat@ms@$ -: clean@(mp~ ct)) Q
NB. where
NB.   Q=. ungql geqlf A
NB.
NB. Notes:
NB. - implements LAPACK's DORGQL, ZUNGQL
NB. - straightforward O(k*m^3) code:
NB.   Q=. (-k) {."1 mp/ (idmat m) -"2 |. ({. Qf) * (* +)"0/~"1 |: }. Qf

ungql=: ($:~ (_1  0&(ms $))) : ( 1  0 }. ([ (ungqlstep^:(;`(gqi@c@])`((-(gqb@c)) ung2l ((}.~ (2 # (-@gqb@c)))@])))) ((tru1~ (-~/@$))@((-@(<. (_1  0&(ms $)))) {."1 ]))))

NB. ---------------------------------------------------------
NB. ungqr
NB.
NB. Description:
NB.   Generate a matrix with orthonormal columns from output
NB.   of geqrf
NB.
NB. Syntax:
NB.   Q=. [s] ungqr QfR
NB. where
NB.   QfR - (m+1)×n-matrix, the output of geqrf
NB.   Q   - m×s-matrix with orthonormal columns, which is
NB.         defined as the first s columns of a product of n
NB.         elementary reflectors of order m:
NB.           Q = Π{H(i),i=0:n-1}
NB.         where
NB.           H(s:n-1)≡H(v(s:n-1),τ(s:n-1))=H(0,0)=I
NB.   s   - integer in range [0,m], default is k
NB.   k   = min(m,n)
NB.
NB. Algorithm:
NB.   1) extract Qf from QfR selecting only first min(s,k)
NB.      columns
NB.   2) make Qf the unit lower triangular
NB.   3) call ung2r, the non-blocked version of algorithm,
NB.      with arguments supplied: adjusted s, and Qf with
NB.      part intended for blocked algorithm being excluded,
NB.      to produce eQ(0)
NB.   4) find iters, the number of iterations
NB.   5) do iterations:
NB.        eQ=.    Qf  (ungqrstep^:iters) eQ0
NB.   6) cut off last row from eQ to produce Q
NB.
NB. Storage layout:
NB.   example for m=4, n=5:       example for m=5, n=4:
NB.   (  u  u  u  u  u  )         (  u  u  u  u   )
NB.   (  v0 u  u  u  u  )         (  v0 u  u  u   )
NB.   (  v0 v1 u  u  u  )         (  v0 v1 u  u   )
NB.   (  v0 v1 v2 u  u  )         (  v0 v1 v2 u   )
NB.   (  τ0 τ1 τ2 τ3 *  )         (  v0 v1 v2 v3  )
NB.                               (  τ0 τ1 τ2 τ3  )
NB. where
NB.   u         - elements of k×n-matrix R, upper triangular
NB.   (1,vi,τi) - vector z(i) which defines an elementary
NB.               reflector H(i) (unit is not stored, v(i)
NB.               may be empty)
NB.   *         - any value, is not used
NB.
NB. Assertions:
NB.   (idmat@ms@$ -: clean@(mp~ ct)) Q
NB. where
NB.   Q=. ungqr geqrf A
NB.
NB. Notes:
NB. - implements LAPACK's DORGQR, ZUNGQR
NB. - straightforward O(k*m^3) code:
NB.   Q=. k {."1 mp/ (idmat m) -"2 ({: Qf) * (* +)"0/~"1 |: }: Qf

ungqr=: ($:~ (_1  0&(ms $))) : (_1  0 }. ([ (ungqrstep^:(]`(gqi@c@])`((-(gqb@c)) ung2r ((}.~ (2 # (  gqb@c)))@])))) ( trl1            @((   <. (_1  0&(ms $)) ) {."1 ]))))

NB. ---------------------------------------------------------
NB. ungrq
NB.
NB. Description:
NB.   Generate a matrix with orthonormal rows from output of
NB.   gerqf
NB.
NB. Syntax:
NB.   Q=. [s] ungrq RQf
NB. where
NB.   RQf - m×(n+1)-matrix, the output of gerqf
NB.   Q   - s×n-matrix with orthonormal rows, which is
NB.         defined as the last s rows of a product of m
NB.         elementary reflectors of order n:
NB.           Q = Π{H(i)',i=0:m-1}
NB.         where
NB.           H(s:m-1)≡H(v(s:m-1),τ(s:m-1))=H(0,0)=I
NB.   s   - integer in range [0,n], default is k
NB.   k   = min(m,n)
NB.
NB. Algorithm:
NB.   1) extract Qf from RQf selecting only last min(s,k)
NB.      rows
NB.   2) make Qf the unit lower triangular
NB.   3) call ungr2, the non-blocked version of algorithm,
NB.      with arguments supplied: adjusted s, and Qf with
NB.      part intended for blocked algorithm being excluded,
NB.      to produce eQ(0)
NB.   4) find iters, the number of iterations
NB.   5) do iterations:
NB.        eQ=. (s;Qf) (ungrqstep^:iters) eQ0
NB.   6) cut off first column from eQ to produce Q
NB.
NB. Storage layout:
NB.   example for m=4, n=5:       example for m=5, n=4:
NB.   (  τ0 v0 u  u  u  u  )      (  *  u  u  u  u  )
NB.   (  τ1 v1 v1 u  u  u  )      (  τ1 u  u  u  u  )
NB.   (  τ2 v2 c2 v2 u  u  )      (  τ2 v2 u  u  u  )
NB.   (  τ3 v3 v3 v3 v3 u  )      (  τ3 v3 v3 u  u  )
NB.                               (  τ4 v4 v4 v4 u  )
NB. where
NB.   u         - elements of m×k-matrix R, upper triangular
NB.   (1,vi,τi) - vector z(i) which defines an elementary
NB.               reflector H(i) (unit is not stored, v(i)
NB.               may be empty)
NB.   *         - any value, is not used
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   (idmat@ms@$ -: clean@po) Q
NB. where
NB.   Q=. ungrq gerqf A
NB.
NB. Notes:
NB. - implements LAPACK's DORGRQ, ZUNGRQ
NB. - straightforward O(k*m^3) code:
NB.   Q=. (-k) {. mp/ (idmat n) -"2 (+ {."1 Qf) * (* +)"0/~"1 + }."1 Qf

ungrq=: ($:~ ( 0 _1&(ms $))) : ( 0  1 }. ([ (ungrqstep^:(;`(gqi@#@])`((-(gqb@#)) ungr2 ((}.~ (2 # (-@gqb@#)))@])))) ((trl1~ (-~/@$))@((-@(<. ( 0 _1&(ms $)))) {.   ]))))

NB. ---------------------------------------------------------
NB. unghrl
NB.
NB. Description:
NB.   Generate an unitary (orthogonal) matrix Q which is
NB.   defined as the product of elementary reflectors of
NB.   order n, as returned by gehrdl:
NB.     Q = Π{H(i)',i=f+s-2:f} .
NB.
NB. Syntax:
NB.   Q=. unghrl HQf
NB. where
NB.   HQf - n×(n+1)-matrix with packed H and Qf (see gehrdl)
NB.   Q   - n×n-matrix, an unitary (orthogonal)
NB.
NB. Notes:
NB. - instead of using f and s parameters, the following
NB.   product is really calculating:
NB.     Q = Π{H(i)',i=n-1:0} ,
NB.   where
NB.     H(0:f-1) = H(f+s-1:n-1) = I .
NB.   This approach delivers excessive calculations in rare
NB.   case ((f>0) OR (f+s<n)).

unghrl=: unglq@(|.!.0) : [:

NB. ---------------------------------------------------------
NB. unghru
NB.
NB. Description:
NB.   Generate an unitary (orthogonal) matrix Q which is
NB.   defined as the product of elementary reflectors of
NB.   order n, as returned by gehrdu:
NB.     Q = Π{H(i),i=f:f+s-2} .
NB.
NB. Syntax:
NB.   Q=. unghru HQf
NB. where
NB.   HQf - (n+1)×n-matrix with packed H and Qf (see gehrdu)
NB.   Q   - n×n-matrix, an unitary (orthogonal)
NB.
NB. Notes:
NB. - models LAPACK's DORGHR, ZUNGHR
NB. - instead of using f and s parameters, the following
NB.   product is really calculating:
NB.     Q = Π{H(i),i=0:n-1} ,
NB.   where
NB.     H(0:f-1) = H(f+s-1:n-1) = I .
NB.   This approach delivers excessive calculations in rare
NB.   case ((f>0) OR (f+s<n)).

unghru=: ungqr@(0 _1&(|.!.0)) : [:

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testungq
NB.
NB. Description:
NB.   Test Q generation algorithms by general matrix given
NB.
NB. Syntax:
NB.   testungq A
NB. where
NB.   A - m×n-matrix
NB.
NB. Formula:
NB. - for unglq, ungrq:
NB.     berr := ||Q * Q^H - I|| / (FP_EPS * n)
NB. - for ungql, ungqr:
NB.     berr := ||Q^H * Q - I|| / (FP_EPS * m)

testungq=: 3 : 0
  rcond=. (_."_)`gecon1@.(=/@$) y  NB. meaninigful for square matrices only

  ('unglq' tmonad (gelqf`]`(rcond"_)`(_."_)`(mp  gqvberr c))) y
  ('ungql' tmonad (geqlf`]`(rcond"_)`(_."_)`(mp~ gqvberr #))) y
  ('ungqr' tmonad (geqrf`]`(rcond"_)`(_."_)`(mp~ gqvberr #))) y
  ('ungrq' tmonad (gerqf`]`(rcond"_)`(_."_)`(mp  gqvberr c))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testunghr
NB.
NB. Description:
NB.   Test Q generation algorithms by square matrix given
NB.
NB. Syntax:
NB.   testunghr A
NB. where
NB.   A - n×n-matrix
NB.
NB. Formula:
NB. - for unghrl:
NB.     berr := ||Q * Q^H - I|| / (FP_EPS * n)
NB. - for ungql, ungqr :
NB.     berr := ||Q^H * Q - I|| / (FP_EPS * m)

testunghr=: 3 : 0
  ('unghrl' tmonad ((gehrdl~ (0,#))`]`(uncon1@])`(_."_)`(mp  gqvberr c))) y
  ('unghru' tmonad ((gehrdu~ (0,#))`]`(uncon1@])`(_."_)`(mp~ gqvberr #))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testgq
NB.
NB. Description:
NB.   Adv. to make verb to test ungxxx by matrix of generator
NB.   and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testgq
NB. where
NB.   mkmat - monad to generate a matrix; is called as:
NB.             mat=. mkmat (m,n)
NB.   vtest - monad to test algorithms by matrix mat; is
NB.           called as:
NB.             vtest (m,n)
NB.   (m,n) - 2-vector of integers, the shape of matrix mat
NB.
NB. Application:
NB. - test by random rectangular real matrix with elements
NB.   distributed uniformly with support (0,1):
NB.     ?@$&0 testgq_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testgq_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testgq_mt_ 150 200

testgq=: 1 : 'EMPTY_mt_ [ (testunghr_mt_^:(=/@$) [ testungq_mt_)@u'
