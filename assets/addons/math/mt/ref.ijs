NB. Reflection
NB.
NB. larfx      Dyads to generate an elementary reflector
NB. larfxxx    Monads to generate an elementary reflector
NB. larftxx    Monads to form the triangular factor of a
NB.            block reflector
NB. larfxxxx   Dyads to apply an elementary reflector or its
NB.            transpose to a matrix from either the left or
NB.            the right
NB. larfbxxxx  Dyads to build a block reflector by larftxx
NB.            and to apply it or its transpose to a matrix
NB.            from either the left or the right
NB.
NB. testlarf   Test larfx by general vector given
NB. testlarft  Test larftxx by general matrix given
NB. testlarfb  Test larfbxxxx by general matrix given
NB. testref    Adv. to make verb to test larfxxxxx by matrix
NB.            of generator and shape given
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
NB. Constants

NB. Safe minimum
REFSAFMIN=: FP_SFMIN % FP_EPS

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. larfg
NB. larfp
NB.
NB. Description:
NB.   Generate an elementary reflector H of order n such that
NB.     H^H * (α,x) = (β,0),
NB.   where
NB.     H = I - (1,v) * τ * (1,v)^H,
NB.     H^H * H = I.
NB.   H is represented in factored form by n-vector (1,v) and
NB.   scalar τ.
NB.
NB. Syntax:
NB.   z=. ios larfg y
NB.   z=. ios larfp y
NB. where
NB.   ios - 2-vector of integers (ioa,iot)
NB.   ioa - lIO α in y
NB.   iot - lIO pre-allocated scalar in y
NB.   y   - (n+1)-vector having scalar α ∊ ℂ at index ioa,
NB.         any scalar at index iot, and vector x ∊ ℂ^(n-1)
NB.         in the rest elements, vector to reflect is:
NB.           (<<< iot) { y
NB.   z   - (n+1)-vector having scalar β ∊ ℝ (larfp [1]
NB.         provides β≥0) at index ioa, scalar τ ∊ ℂ at index
NB.         iot, and vector v ∊ ℂ^(n-1) in the rest elements,
NB.         reflected vector is:
NB.           beta ioa } n $ 0
NB.
NB. Application:
NB. - reflect vector (α,x) by larfg and store τ at tail:
NB.     z=. 0 _1 larfg (alpha , x , _.)
NB.     v=. (<<<0 _1) { z
NB.     'beta tau'=. 0 _1 { z
NB. - reflect vector (x,α) by larfp and store τ at head:
NB.     z=. _1 0 larfp (_. , x , alpha)
NB.     v=. (<<<_1 0) { z
NB.     'beta tau'=. _1 0 { z
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.    (n {. beta) -: H (mp~ ct)~ }: y
NB.    I           -:   (mp~ ct)~ H
NB. where
NB.   x     - (n-1)-vector
NB.   alpha - scalar
NB.   y=. alpha , x , _.
NB.   z=. 0 _1 larfg y
NB.   v=. (<<<0 _1) { z
NB.   'beta tau'=. 0 _1 { z
NB.   I=. idmat n
NB.   H=. I - tau (] */ (* +)) (1,v)
NB.
NB. References:
NB. [1] James W. Demmel, Mark Hoemmen, Yozo Hida, and E.
NB.     Jason Riedy. (2008) Non-Negative Diagonals and High
NB.     Performance on Low-Profile Matrices from Householder
NB.     QR. UCB/EECS-2008-76, May 30, 2008
NB.     LAPACK Working Note 203
NB.     http://www.netlib.org/lapack/lawns/downloads/
NB.
NB. Notes:
NB. - IEEE floating point configuration is encoded implicitly
NB. - larfg models LAPACK's xLARFG
NB. - larfp models LAPACK's xLARFP
NB. - larfp provides τ=2 ↔ ||x|| ≈ 0
NB. - not zeroing v in larfp in case τ=2 relies on fact:
NB.   'comparison tolerance tol>0'; otherwise (tol=0) x
NB.   would be filled by zeros

larfg=: 4 : 0
  'ioa iot'=. x
  alpha=. ioa{y
  y=. 0 iot} y                            NB. τ := 0
  ynorm=. norms y
  if. ynorm =!.0 | 9 o. alpha do.         NB. ||y|| == ||(α,x,0)|| == ||α|| and α ∊ ℝ ?
    y                                     NB. (α,0,0) i.e. H==I, τ==0, β==α, v==0
  else.
    if. REFSAFMIN>ynorm do.               NB. xnorm, β may be inaccurate; scale x and recompute them
      y=. y%REFSAFMIN                     NB. (α_scaled,x_scaled,0)
      beta=. (9 o. alpha) negpos norms y  NB. use Re(α) instead Re(α_ascaled) since sign(Re(α)) == sign(Re(α_scaled)); |β_scaled| ∊ [REFSAFMIN,1)
      dzeta=. beta-ioa{y                  NB. ζ := β_scaled-α_scaled
      tau=. dzeta%beta                    NB. τ := ζ/β_scaled
      beta=. REFSAFMIN*beta               NB. unscale β; if α is subnormal, it may lose relative accuracy
    else.
      beta=. (9 o. alpha) negpos ynorm    NB. β := -copysign(||y||,Re(α)), since ||y|| ≥ 0
      dzeta=. beta-alpha
      tau=. dzeta%beta
    end.
    y=. y%-dzeta                          NB. z := (trash,v,0)
    y=. (beta,tau)x}y                     NB. z := (β_scaled,v,τ)
  end.
)

larfp=: 4 : 0
  'ioa iot'=. x
  alpha=. ioa{y
  xnorm=. norms 0 x}y                               NB. ||x||
  if. 0 = xnorm do.
    y=. ((|,(1-*))alpha) x}y                        NB. replace in-place α by |β| and τ by (1-α/|α|)
  else.
    beta=. (9 o. alpha) negpos norms alpha,xnorm    NB. β := -copysign(||y||,Re(α))
    y=. (|beta) iot} y                              NB. write in-place |β|
    if. FP_SFMIN>|beta do.
      y=. y%FP_SFMIN                                NB. scale (α,x[1],...,x[n-1],|β|)
      xnorm=. xnorm%FP_SFMIN
    end.
    if. 0<:beta do.
      dzeta=. -/x{y                                 NB. ζ := α_scaled-|β_scaled|
      tau=. -dzeta%iot{y                            NB. τ := -ζ/|β_scaled|
    else.
      beta=. -beta                                  NB. |β_unscaled|
      'realpha imalpha'=. +.ioa{y                   NB. Re(α_scaled) , Im(α_scaled)
      gamma=. realpha+iot{y                         NB. γ := Re(α_scaled)+|β_scaled|
      delta=. (imalpha,xnorm) (-@(+/)@([*%)) gamma  NB. δ := -(Im(α_scaled)*(Im(α_scaled)/γ)+||x||*(||x||/γ))
      dzeta=. delta j. imalpha                      NB. ζ := δ+i*Im(α_scaled)
      tau=. -dzeta%iot{y                            NB. τ := -ζ/|β_scaled|
    end.
    y=. y%dzeta
    y=. (beta,tau)x}y                               NB. replace α_scaled by |β_unscaled| and |β_scaled| by τ
  end.
)

NB. ---------------------------------------------------------
NB. Verb:      Input:            Output:                  β:
NB. larfgf     (α x[1:n-1] 0)    (β v[1:n-1] τ)          ∊ℝ
NB. larfgfc    (α x[1:n-1] 0)    (β v[1:n-1] conj(τ))    ∊ℝ
NB. larfgb     (0 x[1:n-1] α)    (τ v[1:n-1] β)          ∊ℝ
NB. larfgbc    (0 x[1:n-1] α)    (conj(τ) v[1:n-1] β)    ∊ℝ
NB. larfpf     (α x[1:n-1] 0)    (β v[1:n-1] τ)          ≥0
NB. larfpfc    (α x[1:n-1] 0)    (β v[1:n-1] conj(τ))    ≥0
NB. larfpb     (0 x[1:n-1] α)    (τ v[1:n-1] β)          ≥0
NB. larfpbc    (0 x[1:n-1] α)    (conj(τ) v[1:n-1] β)    ≥0
NB.
NB. Description:
NB.   Monads to generate an elementary reflector, see larfg,
NB.   larfp for details.

larfgf=: 0 _1&larfg
larfgfc=: _1 + upd larfgf
larfgb=: _1 0&larfg
larfgbc=: 0 + upd larfgb

larfpf=: 0 _1&larfp
larfpfc=: _1 + upd larfpf
larfpb=: _1 0&larfp
larfpbc=: 0 + upd larfpb

NB. ---------------------------------------------------------
NB. larftbc
NB.
NB. Description:
NB.   Monad to form the triangular factor T of a block
NB.   reflector H:
NB.     H = H(k-1) * ... * H(1) * H(0) = I - V * T * V' ,
NB.   where T is lower triangular.
NB.
NB. Syntax:
NB.   T=. larftbc eV
NB. where
NB.   eV  - (m+1)×k-matrix (tau,V)
NB.   V   - m×k-matrix, unit upper triangular (trapezoidal)
NB.         with 1s on (k-m)-th diagonal and 0s below
NB.   tau - k-vector τ[0:k-1] corresp. to V
NB.   T   - k×k-matrix, lower triangular
NB.
NB. Storage layout:
NB.   (  T00       )  k
NB.   (  T10  T11  )  n-k
NB.       k   n-k
NB. where
NB.   T10 = - T11 * (Vr' * Vl) * T00
NB.   Vl  = V[0:m-1,0:k-1]
NB.   Vr  = V[0:m-1,k:n-1]

larftbc=: ( 1  1&{.)`(({."1 (0:`0:`(larftbc@[)`]`[`( mp~ ct@(0&( 0}))  )`[`(-@mp~)`(mp~)`(larftbc@])`(({."1~ c), ])`,.`]`[`0: fork5) }."1)~ (<.@-:@c))`(EMPTY"_)@.(*@<:@c)

NB. ---------------------------------------------------------
NB. larftbr
NB.
NB. Description:
NB.   Monad to form the triangular factor T of a block
NB.   reflector H:
NB.     H = H(k-1) * ... * H(1) * H(0) = I - V' * T * V ,
NB.   where T is lower triangular.
NB.
NB. Syntax:
NB.   T=. larftbr eV
NB. where
NB.   eV  - k×(n+1)-matrix (tau,.V)
NB.   V   - k×n-matrix, unit lower triangular (trapezoidal)
NB.         with 1s on (n-k)-th diagonal and 0s above
NB.   tau - k-vector τ[0:k-1] corresp. to V
NB.   T   - k×k-matrix, lower triangular
NB.
NB. Storage layout:
NB.   (  T00       )  k
NB.   (  T10  T11  )  m-k
NB.       k   m-k
NB. where
NB.   T10 = - T11 * (Vb * Vt') * T11
NB.   Vt  = V[0:k-1,0:n-1]
NB.   Vb  = V[k:m-1,0:n-1]

larftbr=: ( 1  1&{.)`(({.   (0:`0:`(larftbr@[)`]`[`((mp  (0&( 0}))@ct)~)`[`(-@mp~)`(mp~)`(larftbr@])`(({."1~ c), ])`,.`]`[`0: fork5) }.  )~ (<.@-:@#))`(EMPTY"_)@.(*@<:@#)

NB. ---------------------------------------------------------
NB. larftfc
NB.
NB. Description:
NB.   Monad to form the triangular factor T of a block
NB.   reflector H:
NB.     H = H(0) * H(1) * ... * H(k-1) = I - V * T * V' ,
NB.   where T is upper triangular.
NB.
NB. Syntax:
NB.   T=. larftfc eV
NB. where
NB.   eV  - (m+1)×n-matrix (V,tau)
NB.   V   - m×n-matrix, unit lower triangular (trapezoidal)
NB.         with 1s on 0-th diagonal and 0s above
NB.   tau - n-vector τ[0:n-1] corresp. to V
NB.   T   - n×n-matrix, upper triangular
NB.
NB. Storage layout:
NB.   (  T00  T01  )  k
NB.   (       T11  )  n-k
NB.       k   n-k
NB. where
NB.   T01 := - T00 * (Vl' * Vr) * T11
NB.   Vl  := V[0:m-1,0:k-1]
NB.   Vr  := V[0:m-1,k:n-1]
NB.   k   := ⌈n/2⌉
NB.
NB. References:
NB. [1] E. Elmroth, F. Gustavson. Applying Recursion to
NB.     Serial and Parallel QR Factorization Leads to Better
NB.     Performance. IBM J. Research & Development, Vol. 44,
NB.     No. 4, 2000, pp 605-624.
NB.     http://www.research.ibm.com/journal/rd/444/elmroth.pdf

larftfc=: (_1 _1&{.)`(({."1 (0:`0:`(larftfc@[)`]`[`((mp~ ct@(0&(_1})))~)`[`(-@mp )` mp  `(larftfc@])`(({.~   #),.])`, `]`[`0: fork5) }."1)~ (<.@-:@c))`(EMPTY"_)@.(*@<:@c)

NB. ---------------------------------------------------------
NB. larftfr
NB.
NB. Description:
NB.   Monad to form the triangular factor T of a block
NB.   reflector H:
NB.     H = H(0) * H(1) * ... * H(k-1) = I - V' * T * V ,
NB.   where T is upper triangular.
NB.
NB. Syntax:
NB.   T=. larftfr eV
NB. where
NB.   eV  - k×(n+1)-matrix (V,.tau)
NB.   V   - k×n-matrix, unit upper triangular (trapezoidal)
NB.         with 1s on 0-th diagonal and 0s below
NB.   tau - k-vector τ[0:k-1] corresp. to V
NB.   T   - k×k-matrix, upper triangular
NB.
NB. Storage layout:
NB.   (  T00  T01  )  k
NB.   (       T11  )  m-k
NB.       k   m-k
NB. where
NB.   T01 = - T00 * (Vt * Vb') * T11
NB.   Vt  = V[0:k-1,0:n-1]
NB.   Vb  = V[k:m-1,0:n-1]

larftfr=: (_1 _1&{.)`(({.   (0:`0:`(larftfr@[)`]`[`( mp  (0&(_1}))@ct  )`[`(-@mp )` mp  `(larftfr@])`(({.~   #),.])`, `]`[`0: fork5) }.  )~ (<.@-:@#))`(EMPTY"_)@.(*@<:@#)

NB. ---------------------------------------------------------
NB. Verb:      Action:  Side:   Tran:  Dir:  Layout:     eC:
NB. larflcbc   H' * C   left    ct     bwd   columnwise  0, C
NB. larflcbr   H' * C   left    ct     bwd   rowwise     0, C
NB. larflcfc   H' * C   left    ct     fwd   columnwise  C, 0
NB. larflcfr   H' * C   left    ct     fwd   rowwise     C, 0
NB. larflnbc   H  * C   left    none   bwd   columnwise  0, C
NB. larflnbr   H  * C   left    none   bwd   rowwise     0, C
NB. larflnfc   H  * C   left    none   fwd   columnwise  C, 0
NB. larflnfr   H  * C   left    none   fwd   rowwise     C, 0
NB. larfrcbc   C  * H'  right   ct     bwd   columnwise  0,.C
NB. larfrcbr   C  * H'  right   ct     bwd   rowwise     0,.C
NB. larfrcfc   C  * H'  right   ct     fwd   columnwise  C,.0
NB. larfrcfr   C  * H'  right   ct     fwd   rowwise     C,.0
NB. larfrnbc   C  * H   right   none   bwd   columnwise  0,.C
NB. larfrnbr   C  * H   right   none   bwd   rowwise     0,.C
NB. larfrnfc   C  * H   right   none   fwd   columnwise  C,.0
NB. larfrnfr   C  * H   right   none   fwd   rowwise     C,.0
NB.
NB. Description:
NB.   Dyads to apply an elementary reflector H or its
NB.   transpose H' to a matrix, from either the left or the
NB.   right. H is defined by pair (v,τ) .
NB.
NB. Syntax:
NB.   eCupd=. vtau larfxxxx eC
NB. where
NB.   eC    - matrix C to update, augmented by trash vector
NB.   vtau  - vector v augmented by scalar τ
NB.   eCupd - being updated matrix C , augmented by modified
NB.           trash vector
NB.   v     - vector with 1 at head (forward direction) or
NB.           tail (backward direction)
NB.
NB. Notes:
NB. - models LAPACK's xLARF
NB. - larfxxxx and larfbxxxx are topological equivalents
NB. - if τ=0 then v can have any element values

larflcbc=: ] - [ */ (mp~ +@(0&( 0 }) * {.))~    NB. C - v * ((v * τ)' * C)
larflcbr=: ] - +@(* {.)@[ */ (0 ( 0) } [) mp ]  NB. C - (τ * v)' * (v * C)
larflcfc=: ] - [ */ (mp~ +@(0&(_1 }) * {:))~    NB. C - v * ((v * τ)' * C)
larflcfr=: ] - +@(* {:)@[ */ (0 (_1) } [) mp ]  NB. C - (τ * v)' * (v * C)

larflnbc=: ] - [ */ (mp~ {. * +@(0&( 0 })))~    NB. C - v * ((τ * v') * C)
larflnbr=: ] - (+ * {.)@[ */ (mp~ 0&( 0 }))~    NB. C - (v' * τ) * (v * C)
larflnfc=: ] - [ */ (mp~ {: * +@(0&(_1 })))~    NB. C - v * ((τ * v') * C)
larflnfr=: ] - (+ * {:)@[ */ (mp~ 0&(_1 }))~    NB. C - (v' * τ) * (v * C)

larfrcbc=: ] - (mp 0&( 0 }))~ */ +@(* {.)@[     NB. C - (C * v) * (v * τ)'
larfrcbr=: ] - (mp +@({. * 0&( 0 })))~ */ [     NB. C - (C * (τ * v)') * v
larfrcfc=: ] - (mp 0&(_1 }))~ */ +@(* {:)@[     NB. C - (C * v) * (v * τ)'
larfrcfr=: ] - (mp +@({: * 0&(_1 })))~ */ [     NB. C - (C * (τ * v)') * v

larfrnbc=: ] - (mp 0&( 0 }) * {.)~ */ +@[       NB. C - (C * (v * τ)) * v'
larfrnbr=: ] - (mp +@(0&( 0 })) * {.)~ */ [     NB. C - (C * (v' * τ)) * v
larfrnfc=: ] - (mp 0&(_1 }) * {:)~ */ +@[       NB. C - (C * (v * τ)) * v'
larfrnfr=: ] - (mp +@(0&(_1 })) * {:)~ */ [     NB. C - (C * (v' * τ)) * v

NB. ---------------------------------------------------------
NB. Verb:      Action:  Side:   Tran:  Dir:  Layout:     eC:
NB. larfblcbc  H' * C   left    ct     bwd   columnwise  0, C
NB. larfblcbr  H' * C   left    ct     bwd   rowwise     0, C
NB. larfblcfc  H' * C   left    ct     fwd   columnwise  C, 0
NB. larfblcfr  H' * C   left    ct     fwd   rowwise     C, 0
NB. larfblnbc  H  * C   left    none   bwd   columnwise  0, C
NB. larfblnbr  H  * C   left    none   bwd   rowwise     0, C
NB. larfblnfc  H  * C   left    none   fwd   columnwise  C, 0
NB. larfblnfr  H  * C   left    none   fwd   rowwise     C, 0
NB. larfbrcbc  C  * H'  right   ct     bwd   columnwise  0,.C
NB. larfbrcbr  C  * H'  right   ct     bwd   rowwise     0,.C
NB. larfbrcfc  C  * H'  right   ct     fwd   columnwise  C,.0
NB. larfbrcfr  C  * H'  right   ct     fwd   rowwise     C,.0
NB. larfbrnbc  C  * H   right   none   bwd   columnwise  0,.C
NB. larfbrnbr  C  * H   right   none   bwd   rowwise     0,.C
NB. larfbrnfc  C  * H   right   none   fwd   columnwise  C,.0
NB. larfbrnfr  C  * H   right   none   fwd   rowwise     C,.0
NB.
NB. Description:
NB.   Dyads to build and apply a block reflector H or its
NB.   transpose H' to a matrix, from either the left or the
NB.   right. H is defined by pair (V,Τ) , where Τ is the
NB.   triangular factor produced from pair (V,tau) by
NB.   larftxx .
NB.
NB. Syntax:
NB.   eCupd=. Vtau larfbxxxx eC
NB. where
NB.   eC    - matrix C to update, augmented by trash vector
NB.   Vtau  - matrix V augmented by vector tau
NB.   eCupd - being updated matrix C , augmented by modified
NB.           trash vector
NB.   V     - unit triangular (trapezoidal) matrix
NB.   tau   - k-vector τ[0:k-1] corresp. to V
NB.
NB. Notes:
NB. - models sequence of calls to LAPACK's xLARFT and then
NB.   to xLARFB
NB. - larfxxxx and larfbxxxx are topological equivalents

larfblcbc=: ] - [ mp (mp~ ct@(0&( 0}) mp larftbc))~            NB. C - V * ((V * T)' * C)
larfblcbr=: ] - ct@(mp~ larftbr)@[ mp (0 (< a: ;  0)} [) mp ]  NB. C - (T * V)' * (V * C)
larfblcfc=: ] - [ mp (mp~ ct@(0&(_1}) mp larftfc))~            NB. C - V * ((V * T)' * C)
larfblcfr=: ] - ct@(mp~ larftfr)@[ mp (0 (< a: ; _1)} [) mp ]  NB. C - (T * V)' * (V * C)

larfblnbc=: ] - [ mp (mp~ larftbc mp ct@(0&( 0})))~            NB. C - V * ((T * V') * C)
larfblnbr=: ] - (ct mp larftbr)@[ mp (mp~ 0&((< a: ;  0)}))~   NB. C - (V' * T) * (V * C)
larfblnfc=: ] - [ mp (mp~ larftfc mp ct@(0&(_1})))~            NB. C - V * ((T * V') * C)
larfblnfr=: ] - (ct mp larftfr)@[ mp (mp~ 0&((< a: ; _1)}))~   NB. C - (V' * T) * (V * C)

larfbrcbc=: ] - (mp 0&(0}))~ mp ct@(mp larftbc)@[              NB. C - (C * V) * (V * T)'
larfbrcbr=: ] - (mp ct@(larftbr mp 0&((< a: ;  0)})))~ mp [    NB. C - (C * (T * V)') * V
larfbrcfc=: ] - (mp 0&(_1}))~ mp ct@(mp larftfc)@[             NB. C - (C * V) * (V * T)'
larfbrcfr=: ] - (mp ct@(larftfr mp 0&((< a: ; _1)})))~ mp [    NB. C - (C * (T * V)') * V

larfbrnbc=: ] - (mp 0&( 0}) mp larftbc)~ mp ct@[               NB. C - (C * (V * T)) * V'
larfbrnbr=: ] - (mp ct@(0&((< a: ;  0)})) mp larftbr)~ mp [    NB. C - (C * (V' * T)) * V
larfbrnfc=: ] - (mp 0&(_1}) mp larftfc)~ mp ct@[               NB. C - (C * (V * T)) * V'
larfbrnfr=: ] - (mp ct@(0&((< a: ; _1)})) mp larftfr)~ mp [    NB. C - (C * (V' * T)) * V

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testlarf
NB.
NB. Description:
NB.   Test larfx by general vector given
NB.
NB. Syntax:
NB.   testlarf ey
NB. where
NB.   ey - (n+1)-vector

testlarf=: 3 : 0
  ios=. (2 ?@$ <:@#) y

  ('larfg' tdyad ((0&{::)`(1&{::)`]`(_."_)`(_."_)`(_."_))) ios ; y
  ('larfp' tdyad ((0&{::)`(1&{::)`]`(_."_)`(_."_)`(_."_))) ios ; y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testlarft
NB.
NB. Description:
NB.   Test larftxx by general matrix given
NB.
NB. Syntax:
NB.   testlarft (A;trash)
NB. where
NB.   A - m×n-matrix, is used to get Qf

testlarft=: 3 : 0
  y=. 0 {:: y
  rcond=. (_."_)`gecon1@.(=/@$) y  NB. meaninigful for square matrices only

  ('larftbc' tmonad (geqlf`]`(rcond"_)`(_."_)`(_."_))) y
  ('larftbr' tmonad (gerqf`]`(rcond"_)`(_."_)`(_."_))) y
  ('larftfc' tmonad (geqrf`]`(rcond"_)`(_."_)`(_."_))) y
  ('larftfr' tmonad (gelqf`]`(rcond"_)`(_."_)`(_."_))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testlarfb
NB.
NB. Description:
NB.   Test larfbxxxx by general matrix given
NB.
NB. Syntax:
NB.   testlarfb (A;C)
NB. where
NB.   A - m×n-matrix, is used to get Qf
NB.   C - m×n-matrix, is used as multiplier

testlarfb=: 3 : 0
  'A C'=. y
  rcond=. gecon1 C
  'LQf QfL QfR RQf'=. (gelqf ; geqlf ; geqrf ; gerqf) A

  ('larfblcbc' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (QfL;(    C , ~0))
  ('larfblcbr' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (RQf;((ct C), ~0))
  ('larfblcfc' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (QfR;(    C ,  0))
  ('larfblcfr' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (LQf;((ct C),  0))

  ('larfblnbc' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (QfL;(    C , ~0))
  ('larfblnbr' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (RQf;((ct C), ~0))
  ('larfblnfc' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (QfR;(    C ,  0))
  ('larfblnfr' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (LQf;((ct C),  0))

  ('larfbrcbc' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (QfL;((ct C),.~0))
  ('larfbrcbr' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (RQf;(    C ,.~0))
  ('larfbrcfc' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (QfR;((ct C),. 0))
  ('larfbrcfr' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (LQf;(    C ,. 0))

  ('larfbrnbc' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (QfL;((ct C),.~0))
  ('larfbrnbr' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (RQf;(    C ,.~0))
  ('larfbrnfc' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (QfR;((ct C),. 0))
  ('larfbrnfr' tdyad ((0&({::))`(1&({::))`]`(rcond"_)`(_."_)`(_."_))) (LQf;(    C ,. 0))

  EMPTY
)

NB. ---------------------------------------------------------
NB. testref
NB.
NB. Description:
NB.   Adv. to make verb to test larfxxxxx by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testref
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
NB.     ?@$&0 testref_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testref_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testref_mt_ 150 200
NB.
NB. Notes:
NB. - non-blocked larfxxxx algos are tested implicitly in
NB.   testgq, testmq, testqf
NB. - larftxx and larfbxxxx are impractical for large
NB.   matrices

testref=: 1 : 'EMPTY_mt_ [ (testlarfb_mt_ [ testlarft_mt_)@(u ; u)^:(200 >: <./) [ testlarf_mt_@u@>:@{.'
