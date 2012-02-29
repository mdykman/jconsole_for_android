NB. Orthogonal factorization with pivoting
NB.
NB. gelpf     LQ factorization with row pivoting of a general
NB.           matrix
NB. geplf     QL factorization with column pivoting of a
NB.           general matrix
NB. geprf     QR factorization with column pivoting of a
NB.           general matrix
NB. gerpf     RQ factorization with row pivoting of a general
NB.           matrix
NB.
NB. testgepf  Test gexxf by general matrix given
NB. testpf    Adv. to make verb to test gexxf by matrix of
NB.           generator and shape given
NB.
NB. Version: 0.8.0 2011-10-29
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
NB. gepr2
NB.
NB. Description:
NB.   QR-factorization with column pivoting of the block
NB.   A(offset+1:m,1:n). The block A(1:offset,1:n) is
NB.   accordingly pivoted, but not factorized
NB.
NB. Syntax:
NB.   'eA jpvt vn'=. gepr2 eApfx;eAsfx;jpvt;vn
NB. where#############
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
NB. Storage layout:############
NB.   input:                    output:
NB.   (  pfx   pfx   ) k        (  pfx   pfx   ) k+nb
NB.   (  sfxL  sfxR  ) m+1-k    (  sfxL  sfxR  ) m+1-k-nb
NB.      k     n-k                 k+nb  n-k-nb
NB.
NB. Notes:
NB. - models LAPACK's xLAQP2

gepr2=: 3 : 0
  'eApfx eAsfx jpvt vn'=. y
  i=. 0
  while. i < n <. # eAsfx do.
    NB. determine i-th pivot column and swap if necessary
    pvt=. liofmax i }. {."1 vn
    if. 0 ~: pvt do.
      eApfx=. (< i + 0,pvt) C."1 eApfx
      eAsfx=. (< i + 0,pvt) C."1 eAsfx
      jpvt=. (< i + 0,pvt) C. jpvt
      vn=. (i { vn) (pvt + i) } vn          NB. vn=. (< i + 0,pvt) C. vn
    end.
    eAsfx=. ({: eApfx) , eAsfx
    eApfx=. }: eApfx
    NB. generate elementary reflector H(i)
  end.
  sfxL=. sfxL ,. z
  sfxR=. (1 (0}) z) larflcfc }."1 sfxR
  eA;jpvt;vn
)

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. geprf
NB.
NB. Description:
NB.   QR factorization of a general matrix
NB.
NB. Syntax:
NB.   QfR=. geprf A
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
NB.   (] -: ((         tru   @  }:   ) mp~ ungqr)@geprf) A
NB. where
NB.   QfR=. geprf A
NB.   Q=. ungqr QfR
NB.   R=. tru }: QfR
NB.
NB. Notes:
NB. - models LAPACK's xGEQRF

geprf=: (0&{:: , 1&{:: ,. geqr2@(2&{::))@((3 : 0)^:((qfi@(_1 0&(ms $)))`(0&{. ; 0&({."1) ; ])))@(,&0)
  'pfx sfxL sfxR'=. y
  nb=. PFNB <. k=. <./ _1 0 ms $ sfxR
  Z=. geqr2 nb {."1 sfxR
  sfxL=. sfxL ,. Z
  sfxR=. (trl1 Z) larfblcfc nb }."1 sfxR
  (pfx , (sfxL ,.&(nb&{.) sfxR)) ; (sfxL ;&(nb&}.) sfxR)
)

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testgepf
NB.
NB. Description:
NB.   Test orthogonal factorization algorithms:
NB.   - geqp3 (math/lapack addon)
NB.   - gelpf geplf geprf gerpf (math/mt addon)
NB.   by general matrix given
NB.
NB. Syntax:
NB.   testgepf A
NB. where
NB.   A - m×n-matrix
NB.
NB. Formula:############
NB. - LQ: berr := ||L - A * Q^H|| / (FP_EPS * n * ||A||)
NB. - QL: berr := ||L - Q^H * A|| / (FP_EPS * m * ||A||)
NB. - QR: berr := ||R - Q^H * A|| / (FP_EPS * m * ||A||)
NB. - RQ: berr := ||R - A * Q^H|| / (FP_EPS * n * ||A||)
NB. where
NB.   matrix product is done indirectly via unmxxxx

testgepf=: 3 : 0
  require :: ] '~addons/math/lapack/lapack.ijs'
  need_jlapack_ :: ] 'geqp3'

  rcond=. (_."_)`gecon1@.(=/@$) y  NB. meaninigful for square matrices only

  ('2b0111&geqp3_jlapack_' tmonad (]`({: , ,  &.>/@}:)`(rcond"_)`(_."_)`(norm1@(- ((mp~ ungqr)&>/)) % (FP_EPS*#*norm1)@[))) y

  ('gelpf' tmonad (]`]`(rcond"_)`(_."_)`(norm1@( trl        @:(}:"1)@] - ((   <./ @$@]) {."1 unmlqrc)~) % (FP_EPS*c*norm1)@[))) y
  ('geplf' tmonad (]`]`(rcond"_)`(_."_)`(norm1@((trl~ -~/@$)@  }.   @] - ((-@(<./)@$@]) {.   unmqllc)~) % (FP_EPS*#*norm1)@[))) y
  ('geprf' tmonad (]`]`(rcond"_)`(_."_)`(norm1@( tru        @  }:   @] - ((   <./ @$@]) {.   unmqrlc)~) % (FP_EPS*#*norm1)@[))) y
  ('gerpf' tmonad (]`]`(rcond"_)`(_."_)`(norm1@((tru~ -~/@$)@:(}."1)@] - ((-@(<./)@$@]) {."1 unmrqrc)~) % (FP_EPS*c*norm1)@[))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testpf
NB.
NB. Description:
NB.   Adv. to make verb to test gexxx by matrix of generator
NB.   and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testpf
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
NB.     ?@$&0 testpf_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testpf_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testpf_mt_ 150 200

testpf=: 1 : 'EMPTY_mt_ [ testgepf_mt_@u'
