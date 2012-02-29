NB. Orthogonal factorization
NB.
NB. gelqf     LQ factorization of a general matrix
NB. geqlf     QL factorization of a general matrix
NB. geqrf     QR factorization of a general matrix
NB. gerqf     RQ factorization of a general matrix
NB.
NB. testgeqf  Test gexxx by general matrix given
NB. testqf    Adv. to make verb to test gexxx by matrix of
NB.           generator and shape given
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

NB. ---------------------------------------------------------
NB. Blocked code constants

QFNB=: 32   NB. block size limit
QFNX=: 128  NB. crossover point, QFNX ≥ QFNB

NB. ---------------------------------------------------------
NB. qfi
NB.
NB. Description: Number of iterations
NB. Syntax:      iters=. ungi k
NB. where        k = min(rows,columns)
NB. Formula:     iters = max(0,⌊(k+NB-NX-1)/NB⌋)
NB. Notes:       is memo, since repetitive calls are expected

qfi=: (0 >. <.@(QFNB %~ (_1+QFNB-QFNX)&+))M.

NB. ---------------------------------------------------------
NB. gelq2
NB.
NB. Description:
NB.   LQ-factorization of the augmented input matrix by
NB.   non-blocked version of algorithm
NB.
NB. Syntax:
NB.   LQf=. gelq2 eA
NB. where
NB.   eA  - m×(n+1)-matrix, being A augmented by trash vector
NB.   A   - m×n-matrix, the input to factorize
NB.   LQf - m×(n+1)-matrix, combined lower triangular
NB.         m×k-matrix L and unit upper triangular
NB.         k×(n+1)-matrix Qf (unit diagonal not stored)
NB.   Qf  - the matrix Q represented in factored form
NB.   Q   - matrix with orthonormal rows which is defined as
NB.         the product of k elementary reflectors
NB.   k   = min(m,n)
NB.
NB. Storage layout:
NB.   input:                output:
NB.   (  pfx sfxT  ) k      (  pfx   sfxT    ) k+nb
NB.   (  pfx sfxB  ) m-k    (  pfx   sfxB    ) m-k-nb
NB.      k   n+1-k             k+nb  n+1-k-nb
NB.
NB. Notes:
NB. - models LAPACK's xGELQ2
NB. - gelq2 and gelqf are topologic equivalents
NB. - if triangular matrix diagonal's non-negativity is
NB.   required, then larfg* should be replaced by larfp*

gelq2=: (0&{:: stitcht 1&{::)@((3 : 0)^:((0 _1&(ms $))`(0&({."1) ; 0&{. ; ])))
  'pfx sfxT sfxB'=. y
  z=. larfgfc {. sfxB
  sfxT=. sfxT , z
  sfxB=. (1 (0}) z) larfrnfr }. sfxB
  (pfx ,. (sfxT ,&:({."1) sfxB)) ; (sfxT ;&:(}."1) sfxB)
)

NB. ---------------------------------------------------------
NB. geql2
NB.
NB. Description:
NB.   QL-factorization of the augmented input matrix by
NB.   non-blocked version of algorithm
NB.
NB. Syntax:
NB.   QfL=. geql2 eA
NB. where
NB.   eA  - (m+1)×n-matrix, being A augmented by trash vector
NB.   A   - m×n-matrix, the input to factorize
NB.   QfL - (m+1)×n-matrix, combined unit upper triangular
NB.         (m+1)×k-matrix Qf (unit diagonal not stored) and
NB.         lower triangular k×n-matrix L
NB.   Qf  - the matrix Q represented in factored form
NB.   Q   - matrix with orthonormal columns which is defined
NB.         as the product of k elementary reflectors
NB.   k   = min(m,n)
NB.
NB. Storage layout:
NB.   input:                   output:
NB.   (  pfxL pfxR  ) m+1-k    (  pfxL    pfxR  ) m+1-k-nb
NB.   (  sfx  sfx   ) k        (  sfx     sfx   ) k+nb
NB.      n-k  k                   n-k-nb  k+nb
NB.
NB. Notes:
NB. - models LAPACK's xGEQL2
NB. - geql2 and geqlf are topologic equivalents
NB. - if triangular matrix diagonal's non-negativity is
NB.   required, then larfg* should be replaced by larfp*

geql2=: (1&{:: appendr 2&{::)@((3 : 0)^:((_1 0&(ms $))`(] ; 0&({."1) ; 0&{.)))
  'pfxL pfxR sfx'=. y
  z=. larfgb {:"1 pfxL
  pfxR=. z ,. pfxR
  pfxL=. (1 (_1}) z) larflcbc }:"1 pfxL
  (pfxL ;&}: pfxR) , < ((pfxL ,&{: pfxR) , sfx)
)

NB. ---------------------------------------------------------
NB. geqr2
NB.
NB. Description:
NB.   QR-factorization of the augmented input matrix by
NB.   non-blocked version of algorithm
NB.
NB. Syntax:
NB.   QfR=. geqr2 eA
NB. where
NB.   eA  - (m+1)×n-matrix, being A augmented by trash vector
NB.   A   - m×n-matrix, the input to factorize
NB.   QfR - (m+1)×n-matrix, combined unit lower triangular
NB.         (m+1)×k-matrix Qf (unit diagonal not stored) and
NB.         upper triangular k×n-matrix R
NB.   Qf  - the matrix Q represented in factored form
NB.   Q   - matrix with orthonormal columns which is defined
NB.         as the product of k elementary reflectors
NB.   k   = min(m,n)
NB.
NB. Storage layout:
NB.   input:                    output:
NB.   (  pfx   pfx   ) k        (  pfx   pfx   ) k+nb
NB.   (  sfxL  sfxR  ) m+1-k    (  sfxL  sfxR  ) m+1-k-nb
NB.      k     n-k                 k+nb  n-k-nb
NB.
NB. Notes:
NB. - models LAPACK's xGEQR2
NB. - gerq2 and geqrf are topologic equivalents
NB. - if triangular matrix diagonal's non-negativity is
NB.   required, then larfg* should be replaced by larfp*

geqr2=: (0&{:: , 1&{::)@((3 : 0)^:((_1 0&(ms $))`(0&{. ; 0&({."1) ; ])))
  'pfx sfxL sfxR'=. y
  z=. larfgf {."1 sfxR
  sfxL=. sfxL ,. z
  sfxR=. (1 (0}) z) larflcfc }."1 sfxR
  (pfx , (sfxL ,&{. sfxR)) ; (sfxL ;&}. sfxR)
)

NB. ---------------------------------------------------------
NB. gerq2
NB.
NB. Description:
NB.   RQ-factorization of the augmented input matrix by
NB.   non-blocked version of algorithm
NB.
NB. Syntax:
NB.   RQf=. gerq2 eA
NB. where
NB.   eA  - m×(n+1)-matrix, being A augmented by trash vector
NB.   A   - m×n-matrix, the input to factorize
NB.   RQf - m×(n+1)-matrix, combined upper triangular
NB.         m×k-matrix R and unit lower triangular
NB.         k×(n+1)-matrix Qf (unit diagonal not stored)
NB.   Qf  - the matrix Q represented in factored form
NB.   Q   - matrix with orthonormal rows which is defined as
NB.         the product of k elementary reflectors
NB.   k   = min(m,n)
NB.
NB. Storage layout:
NB.   input:                  output:
NB.   (  pfxT   sfx  ) m-k    (  pfxT      sfx  ) m-k-nb
NB.   (  pfxB   sfx  ) k      (  pfxB      sfx  ) k+nb
NB.      n+1-k  k                n+1-k-nb  k+nb
NB.
NB. Notes:
NB. - models LAPACK's xGERQ2
NB. - gerq2 and gerqf are topologic equivalents
NB. - if triangular matrix diagonal's non-negativity is
NB.   required, then larfg* should be replaced by larfp*

gerq2=: (1&{:: stitchb 2&{::)@((3 : 0)^:((0 _1&(ms $))`(] ; 0&{. ; 0&({."1))))
  'pfxT pfxB sfx'=. y
  z=. larfgbc {: pfxT
  pfxB=. z , pfxB
  pfxT=. (1 (_1}) z) larfrnbr }: pfxT
  (pfxT ;&:(}:"1) pfxB) , < ((pfxT ,&:({:"1) pfxB) ,. sfx)
)

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. gelqf
NB.
NB. Description:
NB.   LQ factorization of a general matrix
NB.
NB. Syntax:
NB.   LQf=. gelqf A
NB. where
NB.   A   - m×n-matrix, the input to factorize
NB.   LQf - m×(n+1)-matrix, combined L and Qf (unit
NB.         diagonal not stored)
NB.   L   - m×k-matrix, lower triangular
NB.   Qf  - k×(n+1)-matrix, unit upper triangular, the Q
NB.         represented in factored form
NB.   Q   - k×n-matrix with orthonormal rows, which is
NB.         defined as the first k rows of a product of m
NB.         elementary reflectors of order n:
NB.           Q = Π{H(i)',i=m-1:0}
NB.         where
NB.           H(m-1:k)≡H(v(m-1:k),τ(m-1:k))=H(0,0)=I
NB.   k   = min(m,n)
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   Q -: unglq LQf
NB.   I -: po Q
NB.   A -: L mp Q
NB.   (] -: ((         trl   @:(}:"1)) mp  unglq)@gelqf) A
NB. where
NB.   LQf=. gelqf A
NB.   L=. (trl@:(}:"1)) LQf
NB.   Q=. unglq LQf
NB.
NB. Notes:
NB. - models LAPACK's xGELQF

gelqf=: (0&{:: ,. 1&{:: , gelq2@(2&{::))@((3 : 0)^:((qfi@(0 _1&(ms $)))`((0&({."1));(0&{.);])))@(,.&0)
  'pfx sfxT sfxB'=. y
  nb=. QFNB <. k=. <./ 0 _1 ms $ sfxB
  Z=. gelq2 nb {. sfxB
  sfxT=. sfxT , Z
  sfxB=. (tru1 Z) larfbrnfr nb }. sfxB
  (pfx ,. (sfxT ,&:(nb&({."1)) sfxB)) ; (sfxT ;&:(nb&(}."1)) sfxB)
)

NB. ---------------------------------------------------------
NB. geqlf
NB.
NB. Description:
NB.   QL factorization of a general matrix
NB.
NB. Syntax:
NB.   QfL=. geqlf A
NB. where
NB.   A   - m×n-matrix, the input to factorize
NB.   QfL - (m+1)×n-matrix, combined Qf (unit diagonal not
NB.         stored) and L
NB.   Qf  - (m+1)×k-matrix, unit upper triangular, the Q
NB.         represented in factored form
NB.   L   - k×n-matrix, lower triangular
NB.   Q   - m×k-matrix with orthonormal columns, which is
NB.         defined as the last k columns of a product of n
NB.         elementary reflectors of order m:
NB.           Q = Π{H(i),i=n-1:0}
NB.         where
NB.           H(n-1:k)≡H(v(n-1:k),τ(n-1:k))=H(0,0)=I
NB.   k   = min(m,n)
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   Q -: ungql QfL
NB.   I -: (mp~ ct) Q
NB.   A -: Q mp L
NB.   (] -: ((((-~/@$) trl ])@  }.   ) mp~ ungql)@geqlf) A
NB. where
NB.   QfL=. geqlf A
NB.   Q=. ungql QfL
NB.   L=. (((-~/@$) trl ])@}.) QfL
NB.
NB. Notes:
NB. - models LAPACK's xGEQLF

geqlf=: ((geql2@(0&{::) ,. 1&{::) , 2&{::)@((3 : 0)^:((qfi@(_1 0&(ms $)))`(] ; 0&({."1) ; 0&{.)))@(0&,)
  'pfxL pfxR sfx'=. y
  nnb=. - QFNB <. k=. <./ _1 0 ms $ pfxL
  Z=. geql2 nnb {."1 pfxL
  pfxR=. Z ,. pfxR
  pfxL=. ((tru1~ -~/@$) Z) larfblcbc nnb }."1 pfxL
  (pfxL ;&(nnb&}.) pfxR) , < ((pfxL ,.&(nnb&{.) pfxR) , sfx)
)

NB. ---------------------------------------------------------
NB. geqrf
NB.
NB. Description:
NB.   QR factorization of a general matrix
NB.
NB. Syntax:
NB.   QfR=. geqrf A
NB. where
NB.   A   - m×n-matrix, the input to factorize
NB.   QfR - (m+1)×n-matrix, combined Qf (unit diagonal not
NB.         stored) and R
NB.   Qf  - (m+1)×k-matrix, unit lower triangular, the Q
NB.         represented in factored form
NB.   R   - k×n-matrix, upper triangular
NB.   Q   - m×k-matrix with orthonormal columns, which is
NB.         defined as the first k columns of a product of n
NB.         elementary reflectors of order m:
NB.           Q = Π{H(i),i=0:n-1}
NB.         where
NB.           H(k:n-1)≡H(v(k:n-1),τ(k:n-1))=H(0,0)=I
NB.   k   = min(m,n)
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   Q -: ungql QfR
NB.   I -: (mp~ ct) Q
NB.   A -: Q mp R
NB.   (] -: ((         tru   @  }:   ) mp~ ungqr)@geqrf) A
NB. where
NB.   QfR=. geqrf A
NB.   Q=. ungqr QfR
NB.   R=. tru }: QfR
NB.
NB. Notes:
NB. - models LAPACK's xGEQRF

geqrf=: (0&{:: , 1&{:: ,. geqr2@(2&{::))@((3 : 0)^:((qfi@(_1 0&(ms $)))`(0&{. ; 0&({."1) ; ])))@(,&0)
  'pfx sfxL sfxR'=. y
  nb=. QFNB <. k=. <./ _1 0 ms $ sfxR
  Z=. geqr2 nb {."1 sfxR
  sfxL=. sfxL ,. Z
  sfxR=. (trl1 Z) larfblcfc nb }."1 sfxR
  (pfx , (sfxL ,.&(nb&{.) sfxR)) ; (sfxL ;&(nb&}.) sfxR)
)

NB. ---------------------------------------------------------
NB. gerqf
NB.
NB. Description:
NB.   RQ factorization of a general matrix
NB.
NB. Syntax:
NB.   RQf=. gerqf A
NB. where
NB.   A   - m×n-matrix, the input to factorize
NB.   RQf - m×(n+1)-matrix, combined R and Qf (unit diagonal
NB.         not stored)
NB.   R   - m×k-matrix, upper triangular
NB.   Qf  - k×(n+1)-matrix, unit lower triangular, the Q
NB.         represented in factored form
NB.   Q   - k×n-matrix with orthonormal rows, which is
NB.         defined as the last k rows of a product of m
NB.         elementary reflectors of order n:
NB.           Q = Π{H(i)',i=0:m-1}
NB.         where
NB.           H(k:m-1)≡H(v(k:m-1),τ(k:m-1))=H(0,0)=I
NB.   k   = min(m,n)
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   Q -: ungrq RQf
NB.   I -: po Q
NB.   A -: R mp Q
NB.   (] -: ((((-~/@$) tru ])@:(}."1)) mp  ungrq)@gerqf) A
NB. where
NB.   RQf=. gerqf A
NB.   R=. (((-~/@$) tru ])@:(}."1)) RQf
NB.   Q=. ungrq RQf
NB.
NB. Notes:
NB. - models LAPACK's xGERQF

gerqf=: ((gerq2@(0&{::) , 1&{::) ,. 2&{::)@((3 : 0)^:((qfi@(0 _1&(ms $)))`(] ; 0&{. ; 0&({."1))))@(0&,.)
  'pfxT pfxB sfx'=. y
  nnb=. - QFNB <. k=. <./ 0 _1 ms $ pfxT
  Z=. gerq2 nnb {. pfxT
  pfxB=. Z , pfxB
  pfxT=. ((trl1~ -~/@$) Z) larfbrnbr nnb }. pfxT
  (pfxT ;&:(nnb&(}."1)) pfxB) , < ((pfxT ,&:(nnb&({."1)) pfxB) ,. sfx)
)

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testgeqf
NB.
NB. Description:
NB.   Test orthogonal factorization algorithms:
NB.   - 128!:0 (built-in)
NB.   - gelqf geqlf geqrf gerqf (math/lapack addon)
NB.   - gelqf geqlf geqrf gerqf (math/mt addon)
NB.   by general matrix given
NB.
NB. Syntax:
NB.   testgeqf A
NB. where
NB.   A - m×n-matrix
NB.
NB. Formula:
NB. - LQ: berr := ||L - A * Q^H|| / (FP_EPS * n * ||A||)
NB. - QL: berr := ||L - Q^H * A|| / (FP_EPS * m * ||A||)
NB. - QR: berr := ||R - Q^H * A|| / (FP_EPS * m * ||A||)
NB. - RQ: berr := ||R - A * Q^H|| / (FP_EPS * n * ||A||)
NB. where
NB.   matrix product is done indirectly via unmxxxx

testgeqf=: 3 : 0
  require :: ] '~addons/math/lapack/lapack.ijs'
  need_jlapack_ :: ] 'gelqf geqlf geqrf gerqf'

  rcond=. (_."_)`gecon1@.(=/@$) y  NB. meaninigful for square matrices only

  ('128!:0' tmonad (]`]`(rcond"_)`(_."_)`((norm1@(- (mp&>/)))%(FP_EPS*(#*norm1)@[)))) y

  ('2b1110&gelqf_jlapack_' tmonad (]`({. , ,. &.>/@}.)`(rcond"_)`(_."_)`(norm1@(- ((mp  unglq)&>/)) % (FP_EPS*c*norm1)@[))) y
  ('2b0111&geqlf_jlapack_' tmonad (]`({: , ,~ &.>/@}:)`(rcond"_)`(_."_)`(norm1@(- ((mp~ ungql)&>/)) % (FP_EPS*#*norm1)@[))) y
  ('2b0111&geqrf_jlapack_' tmonad (]`({: , ,  &.>/@}:)`(rcond"_)`(_."_)`(norm1@(- ((mp~ ungqr)&>/)) % (FP_EPS*#*norm1)@[))) y
  ('2b1110&gerqf_jlapack_' tmonad (]`({. , ,.~&.>/@}.)`(rcond"_)`(_."_)`(norm1@(- ((mp  ungrq)&>/)) % (FP_EPS*c*norm1)@[))) y

  ('gelqf' tmonad (]`]`(rcond"_)`(_."_)`(norm1@( trl        @:(}:"1)@] - ((   <./ @$@]) {."1 unmlqrc)~) % (FP_EPS*c*norm1)@[))) y
  ('geqlf' tmonad (]`]`(rcond"_)`(_."_)`(norm1@((trl~ -~/@$)@  }.   @] - ((-@(<./)@$@]) {.   unmqllc)~) % (FP_EPS*#*norm1)@[))) y
  ('geqrf' tmonad (]`]`(rcond"_)`(_."_)`(norm1@( tru        @  }:   @] - ((   <./ @$@]) {.   unmqrlc)~) % (FP_EPS*#*norm1)@[))) y
  ('gerqf' tmonad (]`]`(rcond"_)`(_."_)`(norm1@((tru~ -~/@$)@:(}."1)@] - ((-@(<./)@$@]) {."1 unmrqrc)~) % (FP_EPS*c*norm1)@[))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testqf
NB.
NB. Description:
NB.   Adv. to make verb to test gexxx by matrix of generator
NB.   and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testqf
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
NB.     ?@$&0 testqf_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testqf_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testqf_mt_ 150 200

testqf=: 1 : 'EMPTY_mt_ [ testgeqf_mt_@u'
