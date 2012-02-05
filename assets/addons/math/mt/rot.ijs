NB. Rotation
NB.
NB. lartg      Generates a plane rotation of a 2-vector
NB. rot        Applies a plane rotation[s] to a 2-vector[s]
NB. rotga      Adv. to make verb to get and apply rotation
NB. rotsclx    Update array by rotations and scalings
NB.            accumulated
NB.
NB. testlartg  Test lartg by vectors given
NB. testrot    Test rotation algorithms by predefined matrix
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
NB. Constants

NB. Effective thresholds if there is a gradual underflow
NB.   Z_4  =  z^_4   =  2^_1020
NB.   Z_3  =  z^_3   =  2^ _765
NB.   Z_2  =  z^_2   =  2^ _510
NB.   Z_1  =  z^_1   =  2^ _255
NB.   Z0h  =  z^1r2  =  2^  255r2
NB.   Z01  =  z^ 1   =  2^  255
NB.   Z02  =  z^ 2   =  2^  510
NB.   Z03  =  z^ 3   =  2^  765
NB.   Z04  =  z^ 4   =  2^ 1020

'ROTZ04 ROTZ03 ROTZ02 ROTZ01 ROTZ_1 ROTZ_2 ROTZ_3 ROTZ_4'=: (<<<4) { ROTSCL20=: FP_BASE ^ (i: 4) * ROTPOW=: >. 1r4 * FP_BASE ^. FP_SFMIN

NB. Miscellaneous

ROTSQRTEPS=: %: FP_EPS
ROTZ0h=: %: ROTZ01

NB. Intervals
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

ROTINT0=: (ROTZ_2*(1-FP_EPS)) , ROTZ02
ROTINT1=: (ROTZ_3*(1-FP_EPS)) , (ROTZ_1*(1-FP_EPS)) , ROTZ01 , ROTZ03
ROTINT2=: (ROTZ_4*(1-FP_EPS)) , (ROTZ_3*(1-FP_EPS)) , (ROTZ_2*(1-FP_EPS)) , (ROTZ_1*(1-FP_EPS)) , ROTZ0h , ROTZ02 , ROTZ03 , ROTZ04

NB. Scale vectors of corresponding intervals

ROTSCL00=: ROTZ04 , 1 , ROTZ_4
ROTSCL01=: |. ROTSCL00
ROTSCL10=: ROTZ04 , ROTZ02 , 1 , ROTZ_2 , ROTZ_4
ROTSCL11=: 1 , ROTZ_2 , ROTZ_4 , 0 0  NB. ROTZ_1^6 = 0, ROTZ_1^8 = 0
ROTSCL12=: |. ROTSCL10
ROTSCL21=: |. ROTSCL20

NB. ---------------------------------------------------------
NB. Miscellaneous

morim=: >./"1 @: | @: +.  NB. monad: max of real and imaginary parts' modules, max(|Re(y)|,|Im(y)|)
sgn=: (*!.0)`1:@.(0&=)    NB. monad: (if y<0 then -1 else 1 endif), for reals equiv. to: (0&(<:->))

NB. ---------------------------------------------------------
NB. lartgc1
NB. algorithm 3 for case 1: f≠0, g≠0, neither f nor g too big
NB. or small, minimal work

lartgc1=: 3 : 0
  'f2 g2'=. soris 'f g'=. y
  d1=. % %: f2 * fg2=. f2 + g2
  fd1=. f * d1
  (f2 * d1) , (fd1 * + g) , (fd1 * fg2)
)

NB. ---------------------------------------------------------
NB. perm
NB.
NB. Description:
NB.   Generate all [x-]permutations of size x from the set y
NB.
NB. Syntax:
NB.   p=. [k] perm v
NB. where
NB.   v - n-vector
NB.   k ≥ 0, optional size of generated permutations, default
NB.       is n
NB.   p - (n^k)×k-matrix, k-permutations
NB.
NB. Notes:
NB. - extends perm from system/packages/stats/statfns.ijs
NB. - see also [1]
NB.
NB. References:
NB. [1] [Jprogramming] Choosing k items out of n
NB.     R.E. Boss, Sat Aug 2 13:49:59 HKT 2008
NB.     http://www.jsoftware.com/pipermail/programming/2008-August/011576.html

perm=: (! A.&i. ]) :(((# #: i.@<.@(^~)) #) { ])

NB. ---------------------------------------------------------
NB. rottestmat
NB.
NB. Description:
NB.   Generate matrix to test lartg
NB.
NB. Syntax:
NB.   m=. rottestmat y
NB. where
NB.   y - any noun
NB.   m - (29^4)×2-matrix, each row is (f,g) pair of complex
NB.       numbers to test
NB.
NB. Notes:
NB. - niladic verb
NB. - is called each time when there is a need to have test
NB.   array, to reduce memory consumption (32Mb)
NB. - numbers are selected to force lartg to go through all
NB.   code branches, see LAWN148

rottestmat=: j./"1@(_2&(]\"1))@(4 perm (2 ^ ROTPOW * _ 3 _3 1.5 _1.5 0.5 _0.5 3.5 3.5 2.5 2.5 1.5 1.5 0.5 0.5 0.1 _0.1 _0.5 _0.5 _1.5 _1.5 _2.5 _2.5 _3.5 _3.5 0 3 _3 3)&[)

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. lartg
NB.
NB. Description:
NB.   Generates a plane rotation of 2-vector:
NB.     (  c       s ) * ( f ) = ( r )
NB.     ( -conj(s) c )   ( g )   ( 0 )
NB. where
NB.   c^2 + |s|^2 = 1
NB.
NB. Syntax:
NB.   'c s r'=. lartg (f,g)
NB. where
NB.   (f,g) - 2-vector to rotate
NB.   c s   - representation of 2×2 unutary (orthogonal)
NB.           rotation matrix
NB.   r     - representation of rotated 2-vector (r,0)
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   (r,0) -: G1 mp (f,g)
NB.   (r,0) -: (f,g) mp G2
NB.   (0,r) -: G2 mp (g,f)
NB.   (0,r) -: (g,f) mp G1
NB. where
NB.   'c s r'=. lartg (f,g)
NB.   G1=. 2 2 $ c , s , (- + s) , c
NB.   G2=. |: G1
NB.
NB. Notes:
NB. - models LAPACK's xLARTG described in [1]
NB.
NB. TODO:
NB. - make version with continuous plane rotations [2] for
NB.   [G]SEP
NB.
NB. References:
NB. [1] D. Bindel, J. Demmel, W. Kahan, O. Marques. (2001) On
NB.     Computing Givens rotations reliably and efficiently.
NB.     LAPACK Working Note 148, University of Tennessee,
NB.     UT-CS-00-449, January 31, 2001
NB.     http://www.netlib.org/lapack/lawns/downloads/
NB. [2] Anderson, Edward. (2000) Discontinuous Plane
NB.     Rotations and the Symmetric Eigenvalue Problem.
NB.     LAPACK Working Note 150, University of Tennessee,
NB.     UT-CS-00-454, December 4, 2000
NB.     http://www.netlib.org/lapack/lawns/downloads/

lartg=: 3 : 0
  'f g'=. y
  'scalef scaleg'=. scalefg=. morim y

  if. scaleg = 0 do.
    NB. algorithm 2E for case g=0, f may be 0
    'c s r'=. 1 0,f

  elseif. scalef = 0 do.
    NB. algorithm 2E for case f=0, g≠0
    NB. optionally scale g by z^(±4) so that z^_2 ≤ ||g|| ≤ z^2
    ios=. ROTINT0 I. scaleg
    gs=. g * ios { ROTSCL00
    d1=. | gs
    c=. 0
    s=. + gs % d1
    r=. d1 * ios { ROTSCL01

  elseif. (scalef <: ROTZ01) *. (scalef >: ROTZ_1) *. (scaleg <: ROTZ01) do.
    NB. algorithm 3 for case 1: f≠0, g≠0, neither f nor g too big or small, minimal work
    lartgc1 y
    return.

  elseif. scaleg < ROTSQRTEPS * scalef do.
    NB. algorithm 6 for case 2: f≠0, g≠0, |f|^2 + |g|^2 rounds to |f|^2
    iog=. {: iofg=. ROTINT0 I. scalefg  NB. io{f,g}={scalef,-scaleg}={{_1,0,1},{_1,0,1}}, pair {_1,_1} never takes place
    dscalefg=. iofg { ROTSCL00
    'fs gs'=. y * dscalefg
    c=. 1
    s=. (iog { ROTSCL01) * ({. dscalefg) * (fs * + gs) % soris fs
    r=. f

  elseif. scalef < ROTSQRTEPS * scaleg do.
    NB. algorithm 7 for case 3: f≠0, g≠0, |f|^2 + |g|^2 rounds to |g|^2
    iofg=. ROTINT1 I. scalefg                  NB. io{f,g} = count{f,g}+2 = {_2,_1,0,1,2}+2 = {0,1,2,3,4}
    'f2 g2'=. soris 'fs gs'=. y * iofg { ROTSCL10
    d1=. % %: f2 * g2
    c=. ((-~/ iofg) { ROTSCL11) * d1 * f2      NB. (countf-countg)≤0 => form non-neg. io={0,1,2,3,4}, c *=  (z^2)^(countf-countg)
    s=. d1 * fs * + gs
    r=. (({: iofg) { ROTSCL12) * fs * d1 * g2  NB. r *= (z^2)^countg

  elseif. do.
    NB. algorithm 8 for case 4: f≠0, g≠0, scale f and g up or down and use formula from case 1
    iof=. ROTINT2 I. scalef
    'c s r'=. lartgc1 y * iof { ROTSCL20
    r=. r * iof { ROTSCL21

  end.

  c , s , r
)

NB. ---------------------------------------------------------
NB. rot
NB.
NB. Description:
NB.   Applies a plane rotation[s] to a 2-vector[s]:
NB.     ( x[i] ) :=  ( c[j]        s[j] ) * ( x[i] )
NB.     ( y[i] )     ( -conj(s[j]) c[j] )   ( y[i] )
NB.
NB. Syntax:
NB.   oxy=. cs rot ixy
NB. where
NB.   ixy - 2-vector of scalars (x,y) or n×2-matrix of
NB.         laminated vectors (x[i],y[i]), staff to rotate
NB.   cs  - 2-vector of scalars (c,s) or n×2-matrix of
NB.         laminated vectors (c[i],s[i]), defines rotation
NB.         matrix(-ces)
NB.   oxy - array of the same shape as input array of max
NB.         rank (either ixy or cs), the rotated staff
NB.
NB. Notes:
NB. - for 1-rank cs implements LAPACK's xROT
NB. - for 2-rank cs implements LAPACK's xLARTV

rot=: (mp"2 1~ (,:"1 ((-@+@:({:"1)) ,. {."1)))~

NB. ---------------------------------------------------------
NB. rotga
NB.
NB. Description:
NB.   Adv. to make verb to get and apply rotation
NB.
NB. Syntax:
NB.   vapp=. vrota rotga
NB. where
NB.   vrota   - dyad to apply rotation; is called as:
NB.               subAupd=. cs vrota subA
NB.             and is any of:
NB.               rot        NB. apply rotation to rows
NB.               rot &. |:  NB. apply rotation to columns
NB.   vapp    - monad to generate and apply rotation; is
NB.             called as:
NB.               'Aupd cs'=. vapp A ; iossubA ; iosfg
NB.   cs      - 2-vector (c,s), curtailed output of lartg,
NB.             defines rotation matrix
NB.   A       - n×n-matrix to update
NB.   Aupd    - n×n-matrix, updated A, being A with subA
NB.             replaced by subAupd
NB.   subA    - 2×any-matrix or any×2-matrix, array of
NB.             2-vectors to apply rotation
NB.   subAupd - matrix of the same shape as subA, the rotated
NB.             subA
NB.   iossubA - ios of subA (subAupd) within A (Aupd)
NB.   iosfg   - ios within subA of 2-vector (f,g) which
NB.             defines rotation
NB.
NB. Notes:
NB. - rotated 2-vector (r,0) is written into subA explicitely
NB.   to avoid lartg roundoff errors

rotga=: 1 : 0
  'A iossubA iosfg'=. y
  subA=. iossubA { A
  csr=. lartg iosfg { subA
  (((({: csr) , 0) iosfg } (}: csr) u subA) iossubA } A) ; (}: csr)
)

NB. ---------------------------------------------------------
NB. rotscll
NB. rotsclu
NB.
NB. Description:
NB.   Update A by rotations and scalings accumulated in dA
NB.
NB. Syntax:
NB.   Aupd=. A rotsclx dA
NB. where
NB.   dA      - any×4-matrix, where each row is 4-vector of
NB.             values, either:
NB.               0 0 0 0         NB. no action
NB.             or:
NB.               m , io , 0 0    NB. defines scaling
NB.             or:
NB.               cs , iof , iog  NB. defines rotation
NB.             accumulates scalings and rotations
NB.   A       - n×n-matrix or (i.0)
NB.   Aupd    - either (i.0) when A -: (i.0) , or n×n-matrix
NB.             (A*dA) otherwise
NB.   m       - multiplier to scale either row (rotscll) or
NB.             column (rotsclu)
NB.   io      - IO either row (rotscll) or column (rotsclu)
NB.             to scale
NB.   cs      - 2-vector (c,s), curtailed output of lartg,
NB.             defines rotation matrix
NB.   iof,iog - IOS either rows (rotscll) or columns
NB.             (rotsclu) which contain 2-vectors (f,g) to
NB.             rotate, iof≠iog
NB.
NB. TODO:
NB. - aggregate non-intersecting groups of vectors to change
NB.   them simultaneously

rotscll=: (4 : 0)
  i=. 0
  while. i < # y do.                    NB. traverse dA rows down
    'cs iofg'=. _2 ]\ i { y
    if. 0 0 -: iofg do.
      if. -. 0 0 -: cs do.
        'm io'=. cs
        x=. io (m&*) upd x             NB. do scale
      end.
    else.
      x=. iofg (cs&(rot &. |:)) upd x  NB. do rotation
    end.
    i=. >: i
  end.
  x
)

rotsclu=: (4 : 0)
  i=. 0
  while. i < # y do.                    NB. traverse dA rows down
    'cs iofg'=. _2 ]\ i { y
    if. 0 0 -: iofg do.
      if. -. 0 0 -: cs do.
        'm io'=. cs
        x=. (< a: ; io) (m&*) upd x     NB. do scale
      end.
    else.
      x=. (< a: ; iofg) (cs&rot) upd x  NB. do rotation
    end.
    i=. >: i
  end.
  x
)

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testlartg
NB.
NB. Description:
NB.   Test lartg by vectors given
NB.
NB. Syntax:
NB.   testlartg A
NB. where
NB.   A - n×2-matrix, each row is (f,g) pair of complex
NB.       numbers to test
NB.
NB. Algorithm for calculating backward error:
NB.   In:  A, CSR
NB.   where
NB.        A -: F ,. G
NB.        CSR=. lartg"1 A
NB.        CSR -: C ,. S ,. R
NB.   Out: maxberr
NB.   1) find exact solution for each row by Algorithm 1
NB.        CSRexact=. algo1"1 A
NB.      where
NB.        CSRexact -: Cexact ,. Sexact ,. Rexact
NB.   2) combine CSR and CSRexact:
NB.        CSRboth=. CSR ,. CSRexact
NB.   3) exclude rows containing NaNs:
NB.        CSRboth=. xrNaN CSRboth
NB.      note: J602 has a bug in (128!:5) [1], so the
NB.            following workaround:
NB.              j./"1@(128!:5)@:+.
NB.            must be used instead of:
NB.              128!:5
NB.   4) exclude rows containing ±∞:
NB.        CSRboth=. xrInf CSRboth
NB.   5) extract vectors R and Rexact from CSRboth:
NB.        R      := [R[0],      R[1],      ...] := CSRboth[:,2]
NB.        Rexact := [Rexact[0], Rexact[1], ...] := CSRboth[:,5]
NB.   6) calculate backward error for each pair
NB.      (R[i],Rexact[i]):
NB.        BErr[i] := ||R[i]| - |Rexact[i]|| / max(ε * |Rexact[i]|, SDN)
NB.      where
NB.        SDN       = FP_SFMIN * FP_PREC, the smallest
NB.                    denormalized number
NB.        R[i]      - approximation computed by lartg,
NB.                      |R[i] - Rexact[i]| ≤ FP_OVFL
NB.        Rexact[i] - exact value computed by algorithm 1
NB.                    (see LAWN148),
NB.                      |Rexact[i]| ≤ FP_OVFL
NB.      note: comparing to LAWN148, a different formula is
NB.            used here due to necessity to eliminate sign
NB.            changes in R. This changes are implemented
NB.            according to LAWN150. An original formula can
NB.            be used if rottestmat generates all f only
NB.            such that sgn(Re(f))=1
NB.   7) exclude +∞ from vector of BErr:
NB.        BErr=. xrInf BErr
NB.   8) find backward error:
NB.        maxberr = max(BErr[:])
NB.
NB. References:
NB. [1] [Jprogramming] 128!:5] 0j_.
NB.     Dan Bron, 2009-12-02 02:22:37
NB.     http://www.jsoftware.com/pipermail/programming/2009-December/017071.html

testlartg=: 3 : 0
  NB. implement algorithm 1
  algo1=. 3 : 'if. 0 = {: y do. (sgn,0:,]) {. y elseif. 0 = {. y do. (0,(sgn@+),|) {: y elseif. do. try. ((d*|f),(sgnf*(+g)*d),(sgnf % d)) [ sgnf=. sgn f [ d=. % %: (+/) soris ''f g''=. y catch. 3 # _. end. end.'

  NB. exclude rows containing NaN from the table y
  xrNaN=. #~(-.@(+./)@|:@:(j./"1@(128!:5)@:+.))

  NB. exclude rows containing ±∞ from the table y
  xrInf=. #~(-.@(+./)@|:@:(_=|))

  NB. backward error calculator:
  vberr=. ((|@:(-&:|) >./@:xrInf@:% (FP_SFMIN * FP_PREC) >. FP_EPS * |@])/@(2 5&{)@|:@xrInf@xrNaN@,. algo1"1)~

  ('lartg"1' tmonad (]`]`(_."_)`(_."_)`(vberr f.))) y  NB. fix vberr to allow trans-locale calling

  EMPTY
)

NB. ---------------------------------------------------------
NB. testrot
NB.
NB. Description:
NB.   Test rotation algorithms by predefined matrix
NB.
NB. Syntax:
NB.   testrot y
NB. where
NB.   y - any noun
NB.
NB. Notes:
NB. - niladic verb

testrot=: EMPTY [ testlartg @ rottestmat
