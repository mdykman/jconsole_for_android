NB. Solve linear monomial equation with triangular matrix
NB.
NB. trsmxxxx  Solve equation (op(A) * X = B) or
NB.           (X * op(A) = B), where A is either unit or
NB.           non-unit, either lower or upper, triangular
NB.           matrix; op(A) is either A itself, or A^T, the
NB.           transposition of A, or A^H, the conjugate
NB.           transposition of A; B is known right-hand side
NB.           (RHS), X is unknown solution
NB.
NB. testtrsm  Test trsmxxxx by triangular matrix given
NB. testsm    Adv. to make verb to test trsmxxxx by matrix of
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

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. Verb:          Solves:           Syntax:
NB. trsmlx         L    * X = B      Xv=. A trsmlx   Bv
NB. trsml1x        L1   * X = B      Xv=. A trsml1x  Bv
NB. trsml1hx       L1^H * X = B      Xv=. A trsml1hx Bv
NB. trsml1tx       L1^T * X = B      Xv=. A trsml1tx Bv
NB. trsmlhx        L^H  * X = B      Xv=. A trsmlhx  Bv
NB. trsmltx        L^T  * X = B      Xv=. A trsmltx  Bv
NB. trsmux         U    * X = B      Xv=. A trsmux   Bv
NB. trsmu1x        U1   * X = B      Xv=. A trsmu1x  Bv
NB. trsmu1hx       U1^H * X = B      Xv=. A trsmu1hx Bv
NB. trsmu1tx       U1^T * X = B      Xv=. A trsmu1tx Bv
NB. trsmuhx        U^H  * X = B      Xv=. A trsmuhx  Bv
NB. trsmutx        U^T  * X = B      Xv=. A trsmutx  Bv
NB. trsmxl         X * L    = B      Xh=. A trsmxl   Bh
NB. trsmxl1        X * L1   = B      Xh=. A trsmxl1  Bh
NB. trsmxl1h       X * L1^H = B      Xh=. A trsmxl1h Bh
NB. trsmxl1t       X * L1^T = B      Xh=. A trsmxl1t Bh
NB. trsmxlh        X * L^H  = B      Xh=. A trsmxlh  Bh
NB. trsmxlt        X * L^T  = B      Xh=. A trsmxlt  Bh
NB. trsmxu         X * U    = B      Xh=. A trsmxu   Bh
NB. trsmxu1        X * U1   = B      Xh=. A trsmxu1  Bh
NB. trsmxu1h       X * U1^H = B      Xh=. A trsmxu1h Bh
NB. trsmxu1t       X * U1^T = B      Xh=. A trsmxu1t Bh
NB. trsmxuh        X * U^H  = B      Xh=. A trsmxuh  Bh
NB. trsmxut        X * U^T  = B      Xh=. A trsmxut  Bh
NB.
NB. Description:
NB.   Solve linear monomial equation with triangular matrix
NB. where:
NB.   A    - n×n-matrix, containing either U, U1, L or L1
NB.   U    - n×n-matrix, upper triangular
NB.   U1   - n×n-matrix, unit upper triangular (diagonal is
NB.          not saved)
NB.   L    - n×n-matrix, lower triangular
NB.   L1   - n×n-matrix, unit lower triangular (diagonal is
NB.          not saved)
NB.   Bv   - n-vector or n×nrhs-matrix, the RHS
NB.   Bh   - n-vector or nrhs×n-matrix, the RHS
NB.   Xv   - same shape as Bv, the solution
NB.   Xh   - same shape as Bh, the solution
NB.   nrhs ≥ 0
NB.
NB. Notes:
NB. - opposite triangle is not referenced
NB. - unit diagonal is not referenced
NB. - model BLAS's xTRSV for vector RHS
NB. - model BLAS's xTRSM for matrix RHS with following
NB.   difference: alpha parameter is assumed to be always
NB.   equal to 1; to workaround this limitation use the
NB.   following pattern:
NB.     X=. A trsmxxxx alpha*B
NB.
NB. TODO:
NB. - replace column-wise algos by row-wise

trsmlx=:   ((((    #@]  {   (1 {:: [)) - ] mp~ (( 1 liosW)&# 0&{::)~   ({,) 0 {:: [) % (    (*>:) &# 0&{::)~   ({,) 0 {:: [) ,    ~ ])^:(;`(#@])`(0 {.   ]))  NB. lios(li)=(1 dhs2lios (   i*n,i)), lio(lii)=   i*(n+1)
trsml1x=:  ( ((    #@]  {   (1 {:: [)) - ] mp~ (( 1 liosW)&# 0&{::)~   ({,) 0 {:: [                                        ) ,    ~ ])^:(;`(#@])`(0 {.   ]))  NB. lios(li)=(1 dhs2lios (   i*n,i))
trsml1hx=: ( (((_1-#@]) {   (1 {:: [)) - ] mp~ ((_1 liosS)&# 0&{::)~ +@({,) 0 {:: [                                        ) ,      ])^:(;`(#@])`(0 {.   ]))  NB. lios(li)=(n dhs2lios (-1-i  ,i))
trsml1tx=: ( (((_1-#@]) {   (1 {:: [)) - ] mp~ ((_1 liosS)&# 0&{::)~   ({,) 0 {:: [                                        ) ,      ])^:(;`(#@])`(0 {.   ]))  NB. lios(li)=(n dhs2lios (-1-i  ,i))
trsmlhx=:  (((((_1-#@]) {   (1 {:: [)) - ] mp~ ((_1 liosS)&# 0&{::)~ +@({,) 0 {:: [) % ((_1-(*>:))&# 0&{::)~ +@({,) 0 {:: [) ,      ])^:(;`(#@])`(0 {.   ]))  NB. lios(li)=(n dhs2lios (-1-i  ,i)), lio(lii)=-1-i*(n+1)
trsmltx=:  (((((_1-#@]) {   (1 {:: [)) - ] mp~ ((_1 liosS)&# 0&{::)~   ({,) 0 {:: [) % ((_1-(*>:))&# 0&{::)~   ({,) 0 {:: [) ,      ])^:(;`(#@])`(0 {.   ]))  NB. lios(li)=(n dhs2lios (-1-i  ,i)), lio(lii)=-1-i*(n+1)
trsmux=:   (((((_1-#@]) {   (1 {:: [)) - ] mp~ ((_1 liosE)&# 0&{::)~   ({,) 0 {:: [) % ((_1-(*>:))&# 0&{::)~   ({,) 0 {:: [) ,      ])^:(;`(#@])`(0 {.   ]))  NB. lios(ui)=(1 dhs2lios (-1-i*n,i)), lio(lii)=-1-i*(n+1)
trsmu1x=:  ( (((_1-#@]) {   (1 {:: [)) - ] mp~ ((_1 liosE)&# 0&{::)~   ({,) 0 {:: [                                        ) ,      ])^:(;`(#@])`(0 {.   ]))  NB. lios(ui)=(1 dhs2lios (-1-i*n,i))
trsmu1hx=: ( ((    #@]  {   (1 {:: [)) - ] mp~ (( 1 liosN)&# 0&{::)~ +@({,) 0 {:: [                                        ) ,    ~ ])^:(;`(#@])`(0 {.   ]))  NB. lios(ui)=(n dhs2lios (   i  ,i))
trsmu1tx=: ( ((    #@]  {   (1 {:: [)) - ] mp~ (( 1 liosN)&# 0&{::)~   ({,) 0 {:: [                                        ) ,    ~ ])^:(;`(#@])`(0 {.   ]))  NB. lios(ui)=(n dhs2lios (   i  ,i))
trsmuhx=:  ((((    #@]  {   (1 {:: [)) - ] mp~ (( 1 liosN)&# 0&{::)~ +@({,) 0 {:: [) % (    (*>:) &# 0&{::)~ +@({,) 0 {:: [) ,    ~ ])^:(;`(#@])`(0 {.   ]))  NB. lios(ui)=(n dhs2lios (   i  ,i)), lio(lii)=   i*(n+1)
trsmutx=:  ((((    #@]  {   (1 {:: [)) - ] mp~ (( 1 liosN)&# 0&{::)~   ({,) 0 {:: [) % (    (*>:) &# 0&{::)~   ({,) 0 {:: [) ,    ~ ])^:(;`(#@])`(0 {.   ]))  NB. lios(ui)=(n dhs2lios (   i  ,i)), lio(lii)=   i*(n+1)
trsmxl=:   (((((_1-c@]) {"1 (1 {:: [)) - ] mp  ((_1 liosS)&c 0&{::)~   ({,) 0 {:: [) % ((_1-(*>:))&c 0&{::)~   ({,) 0 {:: [) ,"0 1  ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(n dhs2lios (-1-i  ,i)), lio(lii)=-1-i*(n+1)
trsmxl1=:  ( (((_1-c@]) {"1 (1 {:: [)) - ] mp  ((_1 liosS)&c 0&{::)~   ({,) 0 {:: [                                        ) ,"0 1  ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(n dhs2lios (-1-i  ,i))
trsmxl1h=: ( ((    c@]  {"1 (1 {:: [)) - ] mp  (( 1 liosW)&c 0&{::)~ +@({,) 0 {:: [                                        ) ,"1 0~ ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(1 dhs2lios (   i*n,i))
trsmxl1t=: ( ((    c@]  {"1 (1 {:: [)) - ] mp  (( 1 liosW)&c 0&{::)~   ({,) 0 {:: [                                        ) ,"1 0~ ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(1 dhs2lios (   i*n,i))
trsmxlh=:  ((((    c@]  {"1 (1 {:: [)) - ] mp  (( 1 liosW)&c 0&{::)~ +@({,) 0 {:: [) % (    (*>:) &c 0&{::)~ +@({,) 0 {:: [) ,"1 0~ ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(1 dhs2lios (   i*n,i)), lio(lii)=   i*(n+1)
trsmxlt=:  ((((    c@]  {"1 (1 {:: [)) - ] mp  (( 1 liosW)&c 0&{::)~   ({,) 0 {:: [) % (    (*>:) &c 0&{::)~   ({,) 0 {:: [) ,"1 0~ ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(1 dhs2lios (   i*n,i)), lio(lii)=   i*(n+1)
trsmxu=:   ((((    c@]  {"1 (1 {:: [)) - ] mp  (( 1 liosN)&c 0&{::)~   ({,) 0 {:: [) % (    (*>:) &c 0&{::)~   ({,) 0 {:: [) ,"1 0~ ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(n dhs2lios (   i  ,i)), lio(lii)=   i*(n+1)
trsmxu1=:  ( ((    c@]  {"1 (1 {:: [)) - ] mp  (( 1 liosN)&c 0&{::)~   ({,) 0 {:: [                                        ) ,"1 0~ ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(n dhs2lios (   i  ,i))
trsmxu1h=: ( (((_1-c@]) {"1 (1 {:: [)) - ] mp  ((_1 liosE)&c 0&{::)~ +@({,) 0 {:: [                                        ) ,"0 1  ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(1 dhs2lios (-1-i*n,i))
trsmxu1t=: ( (((_1-c@]) {"1 (1 {:: [)) - ] mp  ((_1 liosE)&c 0&{::)~   ({,) 0 {:: [                                        ) ,"0 1  ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(1 dhs2lios (-1-i*n,i))
trsmxuh=:  (((((_1-c@]) {"1 (1 {:: [)) - ] mp  ((_1 liosE)&c 0&{::)~ +@({,) 0 {:: [) % ((_1-(*>:))&c 0&{::)~ +@({,) 0 {:: [) ,"0 1  ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(1 dhs2lios (-1-i*n,i)), lio(lii)=-1-i*(n+1)
trsmxut=:  (((((_1-c@]) {"1 (1 {:: [)) - ] mp  ((_1 liosE)&c 0&{::)~   ({,) 0 {:: [) % ((_1-(*>:))&c 0&{::)~   ({,) 0 {:: [) ,"0 1  ])^:(;`(c@])`(0 {."1 ]))  NB. lios(li)=(1 dhs2lios (-1-i*n,i)), lio(lii)=-1-i*(n+1)

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testtrsm
NB.
NB. Description:
NB.   Test:
NB.   - trtrs (math/lapack addon)
NB.   - trsmxxxx (math/mt addon)
NB.   by triangular matrix given
NB.
NB. Syntax:
NB.   testtrsm (A;X)
NB. where
NB.   A - n×n-matrix, triangular
NB.   X - n×n-matrix, exact solution
NB.
NB. Formula:
NB.   ferr := max(||X - exactX|| / ||X||)
NB.   berr := max(||B - op(A) * X|| / (FP_EPS * ||op(A)|| * ||X||))

testtrsm=: 3 : 0
  require :: ] '~addons/math/lapack/lapack.ijs'
  need_jlapack_ :: ] 'trtrs'

  'A X'=. y
  'L L1 U U1'=. bT=. (trl ; trl1 ; tru ; tru1) A
  'conL conL1 conU conU1'=. ((trlcon1&.>)`(trl1con1&.>)`(trucon1&.>)`(tru1con1&.>)) ag bT

  ('trtrs_jlapack_' tmonad (({.,(mp&.>/))`]`(conU "_)`(normi@(((- %&normic [) 1&{::)~))`(normi@(norm1tc@((mp&>/)@[ - (mp~ 0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (U;X)

  ('trsmlx'   tdyad ((0&{::)`( mp      &>/)`]`(conL "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(( mp      &>/)@[ - ( mp~     0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (L ;X)
  ('trsml1x'  tdyad ((0&{::)`( mp      &>/)`]`(conL1"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(( mp      &>/)@[ - ( mp~     0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (L1;X)
  ('trsml1hx' tdyad ((0&{::)`((mp~ ct)~&>/)`]`(conL1"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(((mp~ ct)~&>/)@[ - ((mp~ ct) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tc@])))) (L1;X)
  ('trsml1tx' tdyad ((0&{::)`((mp~ |:)~&>/)`]`(conL1"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(((mp~ |:)~&>/)@[ - ((mp~ |:) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tc@])))) (L1;X)
  ('trsmlhx'  tdyad ((0&{::)`((mp~ ct)~&>/)`]`(conL "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(((mp~ ct)~&>/)@[ - ((mp~ ct) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tc@])))) (L ;X)
  ('trsmltx'  tdyad ((0&{::)`((mp~ |:)~&>/)`]`(conL "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(((mp~ |:)~&>/)@[ - ((mp~ |:) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tc@])))) (L ;X)
  ('trsmux'   tdyad ((0&{::)`( mp      &>/)`]`(conU "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(( mp      &>/)@[ - ( mp~     0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (U ;X)
  ('trsmu1x'  tdyad ((0&{::)`( mp      &>/)`]`(conU1"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(( mp      &>/)@[ - ( mp~     0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tc@])))) (U1;X)
  ('trsmu1hx' tdyad ((0&{::)`((mp~ ct)~&>/)`]`(conU1"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(((mp~ ct)~&>/)@[ - ((mp~ ct) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tc@])))) (U1;X)
  ('trsmu1tx' tdyad ((0&{::)`((mp~ |:)~&>/)`]`(conU1"_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(((mp~ |:)~&>/)@[ - ((mp~ |:) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tc@])))) (U1;X)
  ('trsmuhx'  tdyad ((0&{::)`((mp~ ct)~&>/)`]`(conU "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(((mp~ ct)~&>/)@[ - ((mp~ ct) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tc@])))) (U ;X)
  ('trsmutx'  tdyad ((0&{::)`((mp~ |:)~&>/)`]`(conU "_)`(normi@((- %&normic [) 1&{::)~)`(normi@(norm1tc@(((mp~ |:)~&>/)@[ - ((mp~ |:) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tc@])))) (U ;X)
  ('trsmxl'   tdyad ((0&{::)`( mp~     &>/)`]`(conL "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(( mp     ~&>/)@[ - ( mp      0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (L ;X)
  ('trsmxl1'  tdyad ((0&{::)`( mp~     &>/)`]`(conL1"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(( mp     ~&>/)@[ - ( mp      0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (L1;X)
  ('trsmxl1h' tdyad ((0&{::)`((mp  ct)~&>/)`]`(conL1"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(((mp  ct)~&>/)@[ - ((mp  ct) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tr@])))) (L1;X)
  ('trsmxl1t' tdyad ((0&{::)`((mp  |:)~&>/)`]`(conL1"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(((mp  |:)~&>/)@[ - ((mp  |:) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tr@])))) (L1;X)
  ('trsmxlh'  tdyad ((0&{::)`((mp  ct)~&>/)`]`(conL "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(((mp  ct)~&>/)@[ - ((mp  ct) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tr@])))) (L ;X)
  ('trsmxlt'  tdyad ((0&{::)`((mp  |:)~&>/)`]`(conL "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(((mp  |:)~&>/)@[ - ((mp  |:) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tr@])))) (L ;X)
  ('trsmxu'   tdyad ((0&{::)`( mp~     &>/)`]`(conU "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(( mp     ~&>/)@[ - ( mp      0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (U ;X)
  ('trsmxu1'  tdyad ((0&{::)`( mp~     &>/)`]`(conU1"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(( mp     ~&>/)@[ - ( mp      0&{::)~) % (FP_EPS*norm1@(0 {:: [))*norm1tr@])))) (U1;X)
  ('trsmxu1h' tdyad ((0&{::)`((mp  ct)~&>/)`]`(conU1"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(((mp  ct)~&>/)@[ - ((mp  ct) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tr@])))) (U1;X)
  ('trsmxu1t' tdyad ((0&{::)`((mp  |:)~&>/)`]`(conU1"_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(((mp  |:)~&>/)@[ - ((mp  |:) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tr@])))) (U1;X)
  ('trsmxuh'  tdyad ((0&{::)`((mp  ct)~&>/)`]`(conU "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(((mp  ct)~&>/)@[ - ((mp  ct) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tr@])))) (U ;X)
  ('trsmxut'  tdyad ((0&{::)`((mp  |:)~&>/)`]`(conU "_)`(normi@((- %&normir [) 1&{::)~)`(normi@(norm1tr@(((mp  |:)~&>/)@[ - ((mp  |:) 0&{::)~) % (FP_EPS*normi@(0 {:: [))*norm1tr@])))) (U ;X)

  EMPTY
)

NB. ---------------------------------------------------------
NB. testsm
NB.
NB. Description:
NB.   Adv. to make verb to test trsmxxxx by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testsm
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
NB.     ?@$&0 testsm_mt_ 150 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testsm_mt_ 150 150
NB. - test by random square complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testsm_mt_ 150 150
NB.
NB. Notes:
NB. - trsmxxxx are impractical for large matrices

testsm=: 1 : 'EMPTY_mt_ [ testtrsm_mt_@(u ; u)^:(=/ *. 500 >: {.)'
