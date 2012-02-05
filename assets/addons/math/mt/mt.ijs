NB. 'Matrix toolbox' addon's entry point
NB.
NB. TESTLOGFILE  a: to switch logging off or boxed logfile
NB.              name
NB. TESTLOG      Literal array, being formatted test log
NB. DEBUG        Debug level
NB. FP_BASE      Floating point base
NB. FP_ELEN      Exponent field length (bits)
NB. FP_FLEN      Fraction field length (bits)
NB. FP_IGUNFL    Is gradual underflow? (boolean)
NB. FP_EBIAS     Exponent bias for normalized numbers
NB. FP_EPS       Machine epsilon
NB. FP_PREC      Machine precision 
NB. FP_EMIN      Min exponent for normalized numbers
NB. FP_UNFL      Min normalized positive number
NB. FP_EMAX      Max exponent for normalized numbers
NB. FP_OVFL      Max normalized positive number
NB. FP_SFMIN     Safe min, such that 1/FP_SFMIN does not
NB.              overflow
NB. EMPTY        i. 0 0
NB.
NB. testlow      Adv. to make verb to test low-level
NB.              algorithms by matrix of generator and shape
NB.              given
NB. testmid      Adv. to make verb to test mid-level
NB.              algorithms by matrix of generator and shape
NB.              given
NB. testhigh     Adv. to make verb to test high-level
NB.              algorithms by matrix of generator and shape
NB.              given
NB. test         Adv. to make verb to test algorithms by
NB.              matrix of generator and shape given
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
NB. Interface

NB. ---------------------------------------------------------
NB. User config

NB. - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NB. Tests logging

TESTLOGFILE=: < jpath '~temp/mt.log'  NB. assign a: to switch off file logging
TESTLOG=: ''                          NB. literal array, being formatted test log

NB. - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NB. Debug level used by dbg conj., the atom:
NB.   0 - execute debuging verb transparently and silently
NB.   1 - show for debuging verb its rank and valency,
NB.       input's and output's shapes
NB.   2 - case (1) plus input's and output's values

DEBUG=: 2

NB. ---------------------------------------------------------
NB. System config

NB. - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NB. IEEE 754-1985 double-precision 64 bit floating point
NB. constants

NB. basic values
FP_BASE=: 2                                           NB. floating point base
FP_ELEN=: 11                                          NB. exponent field length (bits)
FP_FLEN=: 53                                          NB. fraction field length (bits)
FP_IGUNFL=: 1                                         NB. is gradual underflow? (boolean)

NB. derived values
FP_EBIAS=: (FP_BASE ^ (FP_ELEN - 1)) - 1              NB. exponent bias for normalized numbers = 1023
FP_EPS=: FP_BASE ^ (- FP_FLEN)                        NB. machine epsilon ε = 2^_53
FP_PREC=: FP_BASE * FP_EPS                            NB. machine precision β = 2^_52
FP_EMIN=: 1 - FP_EBIAS                                NB. min exponent for normalized numbers = _1022
FP_UNFL=: FP_BASE ^ FP_EMIN                           NB. min normalized positive number = 2^_1022
FP_EMAX=: ((FP_BASE ^ FP_ELEN) - FP_BASE) - FP_EBIAS  NB. max exponent for normalized numbers = 1023
FP_OVFL=: (FP_BASE - FP_PREC) * (FP_BASE ^ FP_EMAX)   NB. max normalized positive number = (1-ε)*2^1024
FP_SFMIN=: FP_BASE ^ (FP_EMIN >. (- FP_EMAX))         NB. safe min, such that 1/FP_SFMIN does not overflow

NB. ---------------------------------------------------------
NB. Constants

EMPTY=: i. 0 0

NB. =========================================================
NB. Includes

NB. ---------------------------------------------------------
NB. System definitions

require       '~addons/math/misc/mathutil.ijs'  NB. mp_mt_
require^:IFJ6 '~system/main/myutil.ijs'         NB. timespacex_z_ (J7: stdlib.ijs)

NB. ---------------------------------------------------------
NB. Addon definitions
NB.

NB. utilities
require '~addons/math/mt/dbg.ijs'     NB. Debug
require '~addons/math/mt/fork.ijs'    NB. Extended forks
require '~addons/math/mt/util.ijs'    NB. Utilities
require '~addons/math/mt/ios.ijs'     NB. IOS
require '~addons/math/mt/norm.ijs'    NB. Norms
require '~addons/math/mt/struct.ijs'  NB. Structure handlers
require '~addons/math/mt/rand.ijs'    NB. Random arrays
require '~addons/math/mt/test.ijs'    NB. Test

NB. low-level
require '~addons/math/mt/bak.ijs'     NB. Restore original eigenvectors
require '~addons/math/mt/bal.ijs'     NB. Balance
require '~addons/math/mt/cond.ijs'    NB. Condition number
require '~addons/math/mt/ref.ijs'     NB. Reflection
require '~addons/math/mt/rot.ijs'     NB. Rotation
require '~addons/math/mt/gq.ijs'      NB. Generate Q from its factored form
require '~addons/math/mt/mq.ijs'      NB. Multiply by Q represented in factored form
require '~addons/math/mt/scl.ijs'     NB. Scaling
require '~addons/math/mt/sm.ijs'      NB. Solve linear monomial equation with triangular matrix

NB. mid-level
require '~addons/math/mt/eq.ijs'      NB. Eigenvalues and Schur form
require '~addons/math/mt/evc.ijs'     NB. Eigenvectors
require '~addons/math/mt/hrd.ijs'     NB. Hessenberg reduction
require '~addons/math/mt/qf.ijs'      NB. Orthogonal factorization
require '~addons/math/mt/trf.ijs'     NB. Triangular factorization
require '~addons/math/mt/tri.ijs'     NB. Inverse by trf
require '~addons/math/mt/trs.ijs'     NB. Solve linear monomial equation by trf

NB. high-level
require '~addons/math/mt/ev.ijs'      NB. Eigenvalues and eigenvectors
require '~addons/math/mt/exp.ijs'     NB. Matrix exponential
require '~addons/math/mt/pow.ijs'     NB. Raise matrix to an integer power[s]
require '~addons/math/mt/sv.ijs'      NB. Solve linear monomial equation

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testlow
NB.
NB. Description:
NB.   Adv. to make verb to test low-level algorithms by
NB.   matrix of generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkge testlow
NB. where
NB.   (m,n) - 2-vector of integers, shape of random matrices
NB.           to test algorithms; only algorithms which
NB.           accept m and n given will be tested
NB.   mkge  - monadic verb to generate random non-singular
NB.           general y-matrix (shape is taken from y)
NB.   vtest - verb to test algorithms; is called as:
NB.             vtest (m,n)
NB.
NB. Application:
NB. - test by random square integer matrix with elements
NB.   distributed uniformly with support [0,100):
NB.    ?@$&100 testlow_mt_ 10 10
NB. - test by random rectangular real matrix with elements
NB.   distributed uniformly with support (0,1):
NB.     ?@$&0 testlow_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) testlow_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testlow_mt_ 150 200

testlow=: 1 : 0
  (u testbak_mt_) y   NB. square matrices only
  (u testbal_mt_) y   NB. square matrices only
  (u testref_mt_) y   NB. matrices with min dimention ≤ 200 only
     testrot_mt_  ''  NB. fixed non-random test matrix is used
  (u testgq_mt_ ) y
  (u testmq_mt_ ) y
  (u testsm_mt_ ) y   NB. square matrices with size ≤ 500 only

  EMPTY_mt_
)

NB. ---------------------------------------------------------
NB. testmid
NB.
NB. Description:
NB.   Adv. to make verb to test mid-level algorithms by
NB.   matrix of generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkge testmid
NB. where
NB.   (m,n) - 2-vector of integers, shape of random matrices
NB.           to test algorithms; only algorithms which
NB.           accept m and n given will be tested
NB.   mkge  - monadic verb to generate random non-singular
NB.           general y-matrix (shape is taken from y)
NB.   vtest - verb to test algorithms; is called as:
NB.             vtest (m,n)
NB.
NB. Application:
NB. - test by random square integer matrix with elements
NB.   distributed uniformly with support [0,100):
NB.    ?@$&100 testmid_mt_ 10 10
NB. - test by random rectangular real matrix with elements
NB.   distributed uniformly with support (0,1):
NB.     ?@$&0 testmid_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) testmid_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testmid_mt_ 150 200

testmid=: 1 : 0
  (u testeq_mt_ ) y   NB. square matrices only
  (u testevc_mt_) y   NB. square matrices only
  (u testhrd_mt_) y   NB. square matrices only
  (u testqf_mt_ ) y
  (u testtrf_mt_) y
  (u testtri_mt_) y   NB. square matrices only
  (u testtrs_mt_) y   NB. square matrices only

  EMPTY_mt_
)

NB. ---------------------------------------------------------
NB. testhigh
NB.
NB. Description:
NB.   Adv. to make verb to test high-level algorithms by
NB.   matrix of generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkge testhigh
NB. where
NB.   (m,n) - 2-vector of integers, shape of random matrices
NB.           to test algorithms; only algorithms which
NB.           accept m and n given will be tested
NB.   mkge  - monadic verb to generate random non-singular
NB.           general y-matrix (shape is taken from y)
NB.   vtest - verb to test algorithms; is called as:
NB.             vtest (m,n)
NB.
NB. Application:
NB. - test by random square integer matrix with elements
NB.   distributed uniformly with support [0,100):
NB.    ?@$&100 testhigh_mt_ 10 10
NB. - test by random rectangular real matrix with elements
NB.   distributed uniformly with support (0,1):
NB.     ?@$&0 testhigh_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) testhigh_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testhigh_mt_ 150 200

testhigh=: 1 : 0
  (u testev_mt_ ) y   NB. square matrices only
  (u testexp_mt_) y   NB. square matrices only
  (u testpow_mt_) y   NB. square matrices only
  (u testsv_mt_ ) y   NB. square matrices only

  EMPTY_mt_
)

NB. ---------------------------------------------------------
NB. test
NB.
NB. Description:
NB.   Adv. to make verb to test algorithms by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkge test
NB. where
NB.   (m,n) - 2-vector of integers, shape of random matrices
NB.           to test algorithms; only algorithms which
NB.           accept m and n given will be tested
NB.   mkge  - monadic verb to generate random non-singular
NB.           general y-matrix (shape is taken from y)
NB.   vtest - verb to test algorithms; is called as:
NB.             vtest (m,n)
NB.
NB. Application:
NB. - test by random square integer matrix with elements
NB.   distributed uniformly with support [0,100):
NB.    ?@$&100 test_mt_ 10 10
NB. - test by random rectangular real matrix with elements
NB.   distributed uniformly with support (0,1):
NB.     ?@$&0 test_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) test_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) test_mt_ 150 200

test=: 1 : 0
  fmtlog_mt_ 'algorithm';'rcond';'rel fwd err';'rel bwd err';'time, sec.';'space, bytes'

  (u testlow_mt_ ) y  NB. low-level algorithms
  (u testmid_mt_ ) y  NB. mid-level algorithms
  (u testhigh_mt_) y  NB. high-level algorithms

  EMPTY_mt_
)
