NB. Eigenvalues and eigenvectors
NB.
NB. ggevxxx   Eigenvalues and, optionally, eigenvectors of
NB.           pair of matrices
NB.
NB. testgeev  Test geevxxx by general matrix given
NB. testheev  Test heevxx by Hermitian (symmetric) matrix
NB.           given
NB. testggev  Test ggevxxx by general matrices given
NB. testev    Adv. to make verb to test xxevxxx by matrices
NB.           of generator and shape given
NB.
NB. Version: 0.7.0 2011-08-06
NB.
NB. Copyright 2011 Igor Zhuravlev
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
NB. Constants

NB. Scaling limits
EVBIGNUM=: % EVSMLNUM=: (%: FP_SFMIN) % FP_PREC

NB. Scaling factors
EVSCL=: 1,EVSMLNUM,1,EVBIGNUM

NB. ---------------------------------------------------------
NB. ggevi
NB.
NB. Description:
NB.   Adv. to make verb to calculate initial parameters for
NB.   ggevxxx
NB.
NB. Syntax:
NB.   vapp=. ggbalp ggevi
NB. where
NB.   ggbalp  - monadic verb to permute matrix pair (A,B) to
NB.             isolate eigenvalues, is either ggballp or
NB.             ggbalup, is called as:
NB.               'CD plr hs'=. ggbalp AB
NB.   vapp    - monadic verb to calculate initial parameters
NB.             for ggevxxx, is called as:
NB.               'abnrmio ABupd plr hs'=. vapp AB
NB.   AB      - 2×n×n-matrix, matrix pair (A,B)
NB.   abnrmio -: abnrm ,. abio
NB.   abnrm   - 2-vector, norms of A and B
NB.   abio    - 2-vector of integers, defines both necessity
NB.             and value of scaling for A and B
NB.   ABupd   - 2×n×n-matrix, scaled and permuted A and B
NB.   plr     - 2×n-matrix of integers, permutations of A and
NB.             B, produced by ggbalp
NB.   hs      - 2-vector of integers, defines submatrices
NB.             position, produced by ggbalp

ggevi=: 1 : '(,.(0,(EVSMLNUM_mt_*1-FP_EPS_mt_),EVBIGNUM_mt_)&I.)@:(>./@,"2)@:| ([ ; u@:(scl_mt_^:((,{&EVSCL_mt_)/@[`({&0 1 0 1@{:@[)`])"1 2)) ]'

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. ggevlnn
NB. ggevlnv
NB. ggevlvn
NB. ggevlvv
NB.
NB. Description:
NB.   Generalized nonsymmetric eigenvalue problem (GNEP):
NB.   find eigenvalue vectors e1, e2 and, optionally, left
NB.   eigenvectors L:
NB.     E2 * L * A = E1 * L * B                           (1)
NB.   and/or right eigenvectors R:
NB.     A * R^H * E2 = B * R^H * E1                       (2)
NB.   of pair of matrices (A,B). To avoid overflow,
NB.   eigenvalues of the matrix pair (A,B) are computed as a
NB.   pair of values. Each i-th eigenvector (row) from L and
NB.   R has a corresponding eigenvalue represented as a pair
NB.   of i-th elements from e1 and e2:
NB.     E1=. diagmat(e1)
NB.     E2=. diagmat(e2)
NB.   If E2 is nonsingular then:
NB.     E=. diagmat(e1%e2)
NB.   is a diagonal matrix of eigenvalues, and GNEP (1), (2)
NB.   can be expressed as:
NB.     L * A = E * L * B                                 (3)
NB.     A * R^H = B * R^H * E                             (4)
NB.   and if E1 is nonsingular then:
NB.     E=. diagmat(e2%e1)
NB.   is a diagonal matrix of eigenvalues, and GNEP (1), (2)
NB.   can be expressed as:
NB.     E * L * A = L * B                                 (5)
NB.     A * R^H * E = B * R^H * E                         (6)
NB.   Eigenvectors are normalized to have taxicab-based
NB.   ∞-norm equal to 1
NB.
NB. Syntax:
NB.   e1e2=.      ggevlnn AB
NB.   'e1e2 R'=.  ggevlnv AB
NB.   'e1e2 L'=.  ggevlvn AB
NB.   'e1e2 LR'=. ggevlvv AB
NB. where
NB.   AB   - 2×n×n-matrix, matrix pair (A,B):
NB.            AB -: A ,: B
NB.   e1e2 - 2×n-matrix of eigenvalues e1 and e2:
NB.            e1e2 -: e1 ,: e2
NB.   L    - n×n-matrix. left eigenvectors (rows)
NB.   R    - n×n-matrix. right eigenvectors (rows)
NB.   LR   - 2×n×n-matrix. left and right eigenvectors:
NB.            LR -: L ,: R
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   (ggevlnn -:                           +@:ggevunn@:(ct"2) ) A ,: B
NB.   (ggevlnn -:&(/:~@(%/))                   ggevunn         ) A ,: B
NB.   (ggevlnv -: (0 1 (+&.>)`(ct&.>)       ag ggevuvn@:(ct"2))) A ,: B
NB.   (ggevlvn -: (0 1 (+&.>)`(ct&.>)       ag ggevunv@:(ct"2))) A ,: B
NB.   (ggevlvv -: (0 1 (+&.>)`(ct"2@:|.&.>) ag ggevuvv@:(ct"2))) A ,: B
NB.   (E2 mp L mp A) -: (E1 mp L mp B)
NB.   (A mp (ct R) mp E2) -: (B mp (ct R) mp E1)
NB. where
NB.   A - n×n-matrix, general
NB.   B - n×n-matrix, general
NB.   'e1e2 LR'=. ggevlvv A ,: B
NB.   'E1 E2'=. diagmat"1 e1e2
NB.   'L R'=. LR
NB.
NB. Application:
NB. - simulate LAPACK's xGEEV('N','N'):
NB.     NB. e=. geevxnn A
NB.     geevlnn=: {.@ggevlnn@(,:(idmat@c))
NB. - simulate LAPACK's xGEEV('N','V') (see notes):
NB.     NB. 'e R'=. geevxnv A
NB.     geevlnv=: 0 1 ({.&.>)`(((**@+@((i.>./)"1@sorim{"0 1]))%norms"1)      &.>)ag ggevlnv@(,:(idmat@c))
NB. - simulate LAPACK's xGEEV('V','N') (see notes):
NB.     NB. 'e L'=. geevxvn A
NB.     geevlvn=: 0 1 ({.&.>)`(((**@+@((i.>./)"1@sorim{"0 1]))%norms"1)      &.>)ag ggevlvn@(,:(idmat@c))
NB. - simulate LAPACK's xGEEV('V','V') (see notes):
NB.     NB. 'e LR'=. geevxvv A
NB.     geevlvv=: 0 1 ({.&.>)`(((**@+@((i.>./)"1@sorim{"0 1]))%norms"1)    "2&.>)ag ggevlvv@(,:(idmat@c))
NB. - simulate LAPACK's xHEEV('N'):
NB.     NB. e=. heevxn A
NB.     heevln=: 9 o.{.@ggevlnn@(,:(idmat@c))
NB. - simulate LAPACK's xHEEV('V') (see notes):
NB.     NB. 'e V'=. heevxv A
NB.     heevlv=: 0 1 ((9 o.{.)&.>)`((%  %:@diag@(mp ct))&.>)ag ggevlvn@(,:(idmat@c))
NB.
NB. Notes:
NB. - eigenvectors from LAPACK's xGEEV are normalized to have
NB.   Euclidean norm equal to 1 and largest component real
NB. - eigenvectors from LAPACK's xHEEV are orthonormal

ggevlnn=: 3 : 0
  'abnrmio y plr hs'=. ggballp ggevi y
  y=. (<0 1;;~dhs2lios hs) ([ ((gghrdlnn~0,c) upd) ((unmlqrc~,:trl@:(}:"1)@])gelqf)/@{`[`] }) y
  e1e2=. hs hgezqenn y
  e1e2=. abnrmio scl^:((,~{&EVSCL)/@[`({&0 1 0 1@{:@[)`])"1 1 e1e2
)

ggevlnv=: 3 : 0
  'abnrmio y plr hs'=. ggballp ggevi y
  y=. (0 1;(<i.{.hs);dhs2lios hs) ((unmlqrc~,(trl@:(}:"1),:unglq)@])gelqf)/@({~<)~`((<0 1 2)<@(0})[)`((, idmat@c)@]) } y
  y=. (gghrdlnv~0,c) y
  y=. hs hgezqsnv y
  e1e2=. 2 {. diag"2 y
  if. 128!:5 < e1e2 do.
    NB. non-converged
    e1e2 ; _. $~ 2 # c y
  else.
    y=. tgevclrb y
    y=. gebaklp y ; {: plr
    y=. (% (EVSMLNUM&>`(,:&1))}@:normitr) y
    e1e2=. abnrmio scl^:((,~{&EVSCL)/@[`({&0 1 0 1@{:@[)`])"1 1 e1e2
    e1e2 ; y
  end.
)

ggevlvn=: 3 : 0
  'abnrmio y plr hs'=. ggballp ggevi y
  y=. (<0 1;(<i.{.hs);dhs2lios hs) ((unmlqrc~,:trl@:(}:"1)@])gelqf)/@{`[`] } y
  y=. (((0,]) gghrdlvn (,idmat)) c) y
  y=. hs hgezqsvn y
  e1e2=. 2 {. diag"2 y
  if. 128!:5 < e1e2 do.
    NB. non-converged
    e1e2 ; _. $~ 2 # c y
  else.
    y=. tgevcllb y
    y=. gebaklp y ; {. plr
    y=. (% (EVSMLNUM&>`(,:&1))}@:normitr) y
    e1e2=. abnrmio scl^:((,~{&EVSCL)/@[`({&0 1 0 1@{:@[)`])"1 1 e1e2
    e1e2 ; y
  end.
)

ggevlvv=: 3 : 0
  'abnrmio y plr hs'=. ggballp ggevi y
  y=. (0 1;(<i.{.hs);dhs2lios hs) ((unmlqrc~,(trl@:(}:"1),:unglq)@])gelqf)/@({~<)~`((<0 1 3)<@(0})[)`((, ,:~@idmat@c)@]) } y
  y=. (gghrdlvv~0,c) y
  y=. hs hgezqsvv y
  e1e2=. 2 {. diag"2 y
  if. 128!:5 < e1e2 do.
    NB. non-converged
    e1e2 ; _. $~ 2 # c y
  else.
    y=. tgevclbb y
    y=. y gebaklp@;"2 1 plr
    y=. (% (EVSMLNUM&>`(,:&1))}@:normitr)"2 y
    e1e2=. abnrmio scl^:((,~{&EVSCL)/@[`({&0 1 0 1@{:@[)`])"1 1 e1e2
    e1e2 ; y
  end.
)

NB. ---------------------------------------------------------
NB. ggevunn
NB. ggevunv
NB. ggevuvn
NB. ggevuvv
NB.
NB. Description:
NB.   Generalized nonsymmetric eigenvalue problem (GNEP):
NB.   find eigenvalue vectors e1, e2 and, optionally, left
NB.   eigenvectors L:
NB.     E2 * L^H * A = E1 * L^H * B                       (7)
NB.   and/or right eigenvectors R:
NB.     A * R * E2 = B * R * E1                           (8)
NB.   of pair of matrices (A,B). To avoid overflow,
NB.   eigenvalues of the matrix pair (A,B) are computed as a
NB.   pair of values. Each i-th eigenvector (column) from L
NB.   and R has a corresponding eigenvalue represented as a
NB.   pair of i-th elements from e1 and e2:
NB.     E1=. diagmat(e1)
NB.     E2=. diagmat(e2)
NB.   If E2 is nonsingular then:
NB.     E=. diagmat(e1%e2)
NB.   is a diagonal matrix of eigenvalues, and GNEP (7), (8)
NB.   can be expressed as:
NB.     L^H * A = E * L^H * B                             (9)
NB.     A * R = B * R * E                                (10)
NB.   and if E1 is nonsingular then:
NB.     E=. diagmat(e2%e1)
NB.   is a diagonal matrix of eigenvalues, and GNEP (7), (8)
NB.   can be expressed as:
NB.     E * L^H * A = L^H * B                            (11)
NB.     A * R * E = B * R * E                            (12)
NB.   Eigenvectors are normalized to have taxicab-based
NB.   ∞-norm equal to 1
NB.
NB. Syntax:
NB.   e1e2=.      ggevunn AB
NB.   'e1e2 R'=.  ggevunv AB
NB.   'e1e2 L'=.  ggevuvn AB
NB.   'e1e2 LR'=. ggevuvv AB
NB. where
NB.   AB   - 2×n×n-matrix, matrix pair (A,B):
NB.            AB -: A ,: B
NB.   e1e2 - 2×n-matrix of eigenvalues e1 and e2:
NB.            e1e2 -: e1 ,: e2
NB.   L    - n×n-matrix. left eigenvectors (columns)
NB.   R    - n×n-matrix. right eigenvectors (columns)
NB.   LR   - 2×n×n-matrix. left and right eigenvectors:
NB.            LR -: L ,: R
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   (ggevunn -:                           +@:ggevlnn@:(ct"2) ) A ,: B
NB.   (ggevunn -:&(/:~@(%/))                   ggevlnn         ) A ,: B
NB.   (ggevunv -: (0 1 (+&.>)`(ct&.>)       ag ggevlvn@:(ct"2))) A ,: B
NB.   (ggevuvn -: (0 1 (+&.>)`(ct&.>)       ag ggevlnv@:(ct"2))) A ,: B
NB.   (ggevuvv -: (0 1 (+&.>)`(ct"2@:|.&.>) ag ggevlvv@:(ct"2))) A ,: B
NB.   (E2 mp (ct L) mp A) -: (E1 mp (ct L) mp B)
NB.   (A mp R mp E2) -: (B mp R mp E1)
NB. where
NB.   A - n×n-matrix, general
NB.   B - n×n-matrix, general
NB.   'e1e2 LR'=. ggevuvv A ,: B
NB.   'E1 E2'=. diagmat"1 e1e2
NB.   'L R'=. LR
NB.
NB. Application:
NB. - simulate LAPACK's xGEEV('N','N'):
NB.     NB. e=. geevxnn A
NB.     geevunn=: {.@ggevunn@(,:(idmat@c))
NB. - simulate LAPACK's xGEEV('N','V') (see notes):
NB.     NB. 'e R'=. geevxnv A
NB.     geevunv=: 0 1 ({.&.>)`(((**@+@((i.>./)"1@sorim{"0 1]))%norms"1)&.|:  &.>)ag ggevunv@(,:(idmat@c))
NB. - simulate LAPACK's xGEEV('V','N') (see notes):
NB.     NB. 'e L'=. geevxvn A
NB.     geevuvn=: 0 1 ({.&.>)`(((**@+@((i.>./)"1@sorim{"0 1]))%norms"1)&.|:  &.>)ag ggevuvn@(,:(idmat@c))
NB. - simulate LAPACK's xGEEV('V','V') (see notes):
NB.     NB. 'e LR'=. geevxvv A
NB.     geevuvv=: 0 1 ({.&.>)`(((**@+@((i.>./)"1@sorim{"0 1]))%norms"1)&.|:"2&.>)ag ggevuvv@(,:(idmat@c))
NB. - simulate LAPACK's xHEEV('N'):
NB.     NB. e=. heevxn A
NB.     heevun=: 9 o.{.@ggevunn@(,:(idmat@c))
NB. - simulate LAPACK's xHEEV('V') (see notes):
NB.     NB. 'e V'=. heevxv A
NB.     heevuv=: 0 1 ((9 o.{.)&.>)`((%"1%:@diag@(mp~ct))&.>)ag ggevunv@(,:(idmat@c))
NB.
NB. Notes:
NB. - ggevunn models LAPACK's xGGEV('N','N')
NB. - ggevunv models LAPACK's xGGEV('N','V')
NB. - ggevuvn models LAPACK's xGGEV('V','N')
NB. - ggevuvv models LAPACK's xGGEV('V','V')
NB. - eigenvectors from LAPACK's xGEEV are normalized to have
NB.   Euclidean norm equal to 1 and largest component real
NB. - eigenvectors from LAPACK's xHEEV are orthonormal

ggevunn=: 3 : 0
  'abnrmio y plr hs'=. ggbalup ggevi y
  y=. (<0 1;;~dhs2lios hs) ([ ((gghrdunn~0,c) upd) ((unmqrlc~,:tru@}:@])geqrf)/@{`[`] }) y
  e1e2=. hs hgeqzenn y
  e1e2=. abnrmio scl^:((,~{&EVSCL)/@[`({&0 1 0 1@{:@[)`])"1 1 e1e2
)

ggevuvn=: 3 : 0
  'abnrmio y plr hs'=. ggbalup ggevi y
  y=. (0 1;(dhs2lios hs);<<i.{.hs) ((unmqrlc~,(tru@}:,:ungqr)@])geqrf)/@({~<)~`((<0 1 2)<@(0})[)`((, idmat@c)@]) } y
  y=. (gghrduvn~0,c) y
  y=. hs hgeqzsvn y
  e1e2=. 2 {. diag"2 y
  if. 128!:5 < e1e2 do.
    NB. non-converged
    e1e2 ; _. $~ 2 # c y
  else.
    y=. tgevculb y
    y=. gebakup y ; {. plr
    y=. (%"1 (EVSMLNUM&>`(,:&1))}@:normitc) y
    e1e2=. abnrmio scl^:((,~{&EVSCL)/@[`({&0 1 0 1@{:@[)`])"1 1 e1e2
    e1e2 ; y
  end.
)

ggevunv=: 3 : 0
  'abnrmio y plr hs'=. ggbalup ggevi y
  y=. (<0 1;(dhs2lios hs);<<i.{.hs) ((unmqrlc~,:tru@}:@])geqrf)/@{`[`] } y
  y=. (((0,]) gghrdunv (,idmat)) c) y
  y=. hs hgeqzsnv y
  e1e2=. 2 {. diag"2 y
  if. 128!:5 < e1e2 do.
    NB. non-converged
    e1e2 ; _. $~ 2 # c y
  else.
    y=. tgevcurb y
    y=. gebakup y ; {: plr
    y=. (%"1 (EVSMLNUM&>`(,:&1))}@:normitc) y
    e1e2=. abnrmio scl^:((,~{&EVSCL)/@[`({&0 1 0 1@{:@[)`])"1 1 e1e2
    e1e2 ; y
  end.
)

ggevuvv=: 3 : 0
  'abnrmio y plr hs'=. ggbalup ggevi y
  y=. (0 1;(dhs2lios hs);<<i.{.hs) ((unmqrlc~,(tru@}:,:ungqr)@])geqrf)/@({~<)~`((<0 1 2)<@(0})[)`((, ,:~@idmat@c)@]) } y
  y=. (gghrduvv~0,c) y
  y=. hs hgeqzsvv y
  e1e2=. 2 {. diag"2 y
  if. 128!:5 < e1e2 do.
    NB. non-converged
    e1e2 ; _. $~ 2 # c y
  else.
    y=. tgevcubb y
    y=. y gebakup@;"2 1 plr
    y=. (%"1 (EVSMLNUM&>`(,:&1))}@:normitc)"2 y
    e1e2=. abnrmio scl^:((,~{&EVSCL)/@[`({&0 1 0 1@{:@[)`])"1 1 e1e2
    e1e2 ; y
  end.
)

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testgeev
NB.
NB. Description:
NB.   Test geev (math/lapack) by general matrix given
NB.
NB. Syntax:
NB.   testgeev A
NB. where
NB.   A - n×n-matrix
NB.
NB. Formula:
NB.   berr := max(berrL,berrR,berrl,berrr)
NB. where
NB.   ||A|| := max(||A||_1 , FP_SFMIN)
NB.   L - matrix of left eigenvectors
NB.   R - matrix of right eigenvectors
NB.   E - diagonal matrix of eigenvalues
NB.   - geev_jlapack_:
NB.       berrL := min((||L^H * A - E * L^H||_1 / max(||L||_1 , FP_PREC)) / ||A|| , 1) / FP_PREC
NB.       berrR := min((||A   * R - R * E  ||_1 / max(||R||_1 , FP_PREC)) / ||A|| , 1) / FP_PREC
NB.       if max(|Re(X[i,j])|) / max(|X[i,j]|) < 1 - 2*FP_PREC then
NB.         berrx := 1/FP_PREC
NB.       else
NB.         berrx := max(min(1/FP_PREC , | ||X[:,j]||_E - 1 |) / FP_PREC
NB.       endif
NB.       where berrx is either berrl or berrr, and corresponding X is either L or R

testgeev=: 3 : 0
  require :: ] '~addons/math/lapack/lapack.ijs'
  need_jlapack_ :: ] 'geev'

  rcond=. gecon1 y

  vberruL=: FP_PREC%~1<.norm1@[%~(((mp~ ct)~(1;0)&{::)normi@:-((0+@{::])*"1(1;0){::]))%(FP_PREC>.norm1@((1;0){::]))
  vberruR=: FP_PREC%~1<.norm1@[%~(( mp      (1;1)&{::)norm1@:-((0  {::])*"1(1;1){::]))%(FP_PREC>.norm1@((1;1){::]))
  vberrux=: 1(((%FP_PREC)>./"1@:<.FP_PREC%~|@:<:@:(norms"1@|:"2))([`((%FP_PREC)"_)@.])"0((1-+:FP_PREC)>(|@(9&o.))%&:(>./"1)|)@:(,"2))@{::]
  vberruvv=: >./@(vberruL,vberruR,vberrux)  NB. STUDYME: verb is invisible from base locale when erase below is commented out (???)

  ('geev_jlapack_' tmonad (]`(1&({::) ; (0,:2)&({::))`(rcond"_)`(_."_)`vberruvv)) y

  erase 'vberruL vberruR vberrux vberruvv'

  EMPTY
)

NB. ---------------------------------------------------------
NB. testheev
NB.
NB. Description:
NB.   Test heev (math/lapack) by Hermitian (symmetric) matrix
NB.   given
NB.
NB. Syntax:
NB.   testheev A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric)
NB.
NB. Formula:
NB.   berr := max(berr0,berr1)
NB. where
NB.   ||A|| := max(||A||_1 , FP_SFMIN)
NB.   V - matrix of eigenvectors
NB.   E - diagonal matrix of eigenvalues
NB.   - heev_jlapack_:
NB.       wnorm := ||A - V * E * V^H||_1
NB.       if ||A|| > wnorm then
NB.         berr0 := (wnorm / ||A||) / (FP_PREC * n)
NB.       elseif ||A|| < 1 then
NB.         berr0 := (min(wnorm , n * ||A||) / ||A||) / (FP_PREC * n)
NB.       else
NB.         berr0 := min(wnorm / ||A|| , n) / (FP_PREC * n)
NB.       endif
NB.       berr1 := min(||V * V^H - I||_1 , n) / (FP_PREC * n)

testheev=: 3 : 0
  require :: ] '~addons/math/lapack/lapack.ijs'
  need_jlapack_ :: ] 'heev'

  rcond=. hecon1 y

  vberru0=: [((((%~{.)<.1{])`(((0{])<.(*{:))%[)@.(1>[)`(%~{.)@.(>{.)%FP_PREC*1{])~(FP_SFMIN>.{.))~&(norm1,#)(-(]mp(*ct))&>/)
  vberru1=: 1((#<.norm1@(<:upddiag)@(mp ct))%(FP_PREC*#))@{::]
  vberruv=: vberru0>.vberru1

  ('heev_jlapack_' tmonad (]`]`(rcond"_)`(_."_)`vberruv)) y

  erase 'vberru0 vberru1 vberruv'

  EMPTY
)

NB. ---------------------------------------------------------
NB. testggev
NB.
NB. Description:
NB.   Test ggevxxx by general matrices given
NB.
NB. Syntax:
NB.   testggev AB
NB. where
NB.   AB - 2×n×n-report (A,:B)
NB.
NB. Formula:
NB.   berr := max(berr0,berr1)
NB. where
NB.   ||M|| := max(||M||_1 , FP_SFMIN)
NB.   ||v|| := max(|Re(v(i))|+|Im(v(i))|)
NB.   α(i)  - i-th eigenvalue, also i-th element on S
NB.           diagonal
NB.   β(i)  - i-th eigenvalue, also i-th element on P
NB.           diagonal
NB.   l(i)  - i-th left eigenvector
NB.   lb(i) - i-th back transformed left eigenvector
NB.   r(i)  - i-th right eigenvector
NB.   rb(i) - i-th back transformed right eigenvector
NB.   - ggevlvn:
NB.       berr0 := max(||l(i) * (β(i)*A - α(i)*B)  || / (FP_PREC * max(|| β(i)*A   ||,|| α(i)*B   ||)))
NB.       berr1 := max(| ||l(i)|| - 1 |) / (FP_PREC * n)
NB.   - ggevlnv:
NB.       berr0 := max(||r(i) * (β(i)*A - α(i)*B)^H|| / (FP_PREC * max(||(β(i)*A)^H||,||(α(i)*B)^H||)))
NB.       berr1 := max(| ||r(i)|| - 1 |) / (FP_PREC * n)
NB.   - ggevlvv:
NB.       berr0 := berr(ggevlvn)
NB.       berr1 := berr(ggevlnv)
NB.   - ggevuvn:
NB.       berr0 := max(||(β(i)*A - α(i)*B)^H * l(i)|| / (FP_PREC * max(||(β(i)*A)^H||,||(α(i)*B)^H||)))
NB.       berr1 := max(| ||l(i)|| - 1 |) / (FP_PREC * n)
NB.   - ggevunv:
NB.       berr0 := max(||(β(i)*A - α(i)*B)   * r(i)|| / (FP_PREC * max(|| β(i)*A   ||,|| α(i)*B   ||)))
NB.       berr1 := max(| ||r(i)|| - 1 |) / (FP_PREC * n)
NB.   - ggevuvv:
NB.       berr0 := berr(ggevuvn)
NB.       berr1 := berr(ggevunv)
NB.
NB. Notes:
NB. - berrxxx are non-iterative and are require O(N^3) RAM

testggev=: 3 : 0
  vberrlvn=:  (     normir@:((*"_ 1|:@|.@(0&{::))((  norm1r@:((mp"1 2 (-/"3))~     )                                           )      % (FP_PREC*(FP_SFMIN>.    (>./"1)@:( norm1       "2)@[)))(1 {:: ])))>.((     normir@:<:@:normitr%FP_PREC*c)@(1 {:: ]))
  vberrlnv=:  (     normir@:((*"_ 1|:@|.@(0&{::))((                                   norm1r@:((mp"2 1~(-/"3))~+    )          )      % (FP_PREC*(FP_SFMIN>.    (>./"1)@:(       normi "2)@[)))(1 {:: ])))>.((     normir@:<:@:normitr%FP_PREC*c)@(1 {:: ]))
  vberrlvv=:  (>./@:normir@:((*"_ 1|:@|.@(0&{::))((((norm1r@:( mp"1 2        ~   {.),:norm1r@:((mp"2 1       ) + @{:))~(-/"3))~)(>./@:%)(FP_PREC*(FP_SFMIN>.|:@:(>./"1)@:((norm1,normi)"2)@[)))(1 {:: ])))>.((>./@:normir@:<:@:normitr%FP_PREC*c)@(1 {:: ]))

  vberruvn=:  (     normir@:((*"_ 1|:@|.@(0&{::))((  norm1r@:((mp"1 2 (-/"3))~ct   )                                           )      % (FP_PREC*(FP_SFMIN>.    (>./"1)@:( normi       "2)@[)))(1 {:: ])))>.((     normir@:<:@:normitc%FP_PREC*c)@(1 {:: ]))
  vberrunv=:  (     normir@:((*"_ 1|:@|.@(0&{::))((                                   norm1r@:((mp"2 1~(-/"3))~|:   )          )      % (FP_PREC*(FP_SFMIN>.    (>./"1)@:(       norm1 "2)@[)))(1 {:: ])))>.((     normir@:<:@:normitc%FP_PREC*c)@(1 {:: ]))
  vberruvv=:  (>./@:normir@:((*"_ 1|:@|.@(0&{::))((((norm1r@:( mp"1 2        ~ct@{.),:norm1r@:((mp"2 1       ) |:@{:))~(-/"3))~)(>./@:%)(FP_PREC*(FP_SFMIN>.|:@:(>./"1)@:((normi,norm1)"2)@[)))(1 {:: ])))>.((>./@:normir@:<:@:normitc%FP_PREC*c)@(1 {:: ]))

  rcond=. <./ gecon1"2 y

  ('ggevlnn' tmonad (]`]`(rcond"_)`(_."_)`(_."_)  )) y
  ('ggevlnv' tmonad (]`]`(rcond"_)`(_."_)`vberrlnv)) y
  ('ggevlvn' tmonad (]`]`(rcond"_)`(_."_)`vberrlvn)) y
  ('ggevlvv' tmonad (]`]`(rcond"_)`(_."_)`vberrlvv)) y
  ('ggevunn' tmonad (]`]`(rcond"_)`(_."_)`(_."_)  )) y
  ('ggevunv' tmonad (]`]`(rcond"_)`(_."_)`vberrunv)) y
  ('ggevuvn' tmonad (]`]`(rcond"_)`(_."_)`vberruvn)) y
  ('ggevuvv' tmonad (]`]`(rcond"_)`(_."_)`vberruvv)) y

  erase 'vberrlnv vberrlvn vberrlvv vberrunv vberruvn vberruvv'

  EMPTY
)

NB. ---------------------------------------------------------
NB. testev
NB.
NB. Description:
NB.   Adv. to make verb to test ggevxxx by matrices of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testev
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
NB.     ?@$&0 testev_mt_ 150 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) testev_mt_ 150 150
NB. - test by random square complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testev_mt_ 150 150

testev=: 1 : 'EMPTY_mt_ [ (testggev_mt_ @ u @ (2&,) [ testheev_mt_ @ (u hemat_mt_) [ testgeev_mt_ @ u) ^: (=/)'
