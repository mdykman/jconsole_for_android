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
NB. Version: 0.8.1 2011-10-29
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

NB. Signum of float/complex/quaternion, monad, sgn(0)=1
sgn=: (1:^:(0&(=!.0))@(*!.0))`(1 0"_^:(0 0&(-:!.0))@qnsign)@.(2=#)

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. lartg
NB.
NB. Description:
NB.   Generate left multiplier cs to make plane rotation
NB.   from fg to r0:
NB.     r0 := cs * fg
NB.   such that cs's 1st Cayley-Dickson half is real; r0's
NB.   2nd Cayley-Dickson half is 0. fg, cs and r0 are of the
NB.   same type: either complex or quaternion.
NB.
NB. Formula:
NB.   cs := sgn(cd1st(fg)) * sgn(qnconik(fg))
NB. where
NB.   cd1st()   - extract 1st half from Cayley-Dickson pair:
NB.                 cd1st(a + b*i) = a
NB.                 cd1st(a + b*i + c*j + d*k) = a + b*i
NB.   qnconik() - conjugate i and k components:
NB.                 qnconik(a + b*i + c*j + d*k) = a - b*i + c*j - d*k
NB.   sgn(x)    = x/|x|, if x ≠ 0
NB.             = 1,     if x = 0
NB.
NB. Syntax:
NB.   cs=. lartg fg
NB. where
NB.   fg - 2-vector (f,g) to rotate
NB.   cs - 2-vector (c,s), the rotator, c is real
NB.   r0 - 2-vector (r,0), the rotated fg
NB.          r0 := cs * fg
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   (r,0) -: (c,s) rot (f,g)
NB.   (r,0) -: (f,g) (qnmul qnconj) (c,s)  NB. equiv. to (qnmul qnconij) since c is real
NB.   (0,r) -: (c,s) (rot~ qnconj)~ (g,f)  NB. equiv. to (rot~ qnconij)~ since c is real
NB.   (0,r) -: (g,f) qnmul (c,s)
NB.   (-: +) c
NB. where
NB.   'c s'=. lartg (f,g)
NB.   r=. (c,s) mp (f,g)
NB.
NB. Notes:
NB. - models LAPACK's xLARTG
NB. - [G]SEP requires plane rotation to be continuous [1]:
NB.     cs := sgn(cd1st(cd1st(fg))) * sgn(cd1st(fg)) * sgn(qnconik(fg))
NB.   To achieve this, use modified definition:
NB.     lartg=: {. (sgn@(9 o. [) * *&sgn) +
NB.
NB. References:
NB. [1] Anderson, Edward. (2000) Discontinuous Plane
NB.     Rotations and the Symmetric Eigenvalue Problem.
NB.     LAPACK Working Note 150, University of Tennessee,
NB.     UT-CS-00-454, December 4, 2000
NB.     http://www.netlib.org/lapack/lawns/downloads/

lartg=: {. *&sgn +

NB. ---------------------------------------------------------
NB. rot
NB.
NB. Description:
NB.   Applies a plane rotation cs to ixy:
NB.     oxy[i] := cs * ixy[i] for i=0:n-1
NB.
NB. Syntax:
NB.     oxy=. cs rot ixy
NB. where
NB.   ixy - 2-vector of Cayley-Dickson halves (ix,iy) or
NB.         2×n-matrix of stitched Cayley-Dickson halves
NB.         (ix[i],iy[i]), defines number[s] to rotate
NB.         (complex or quaternion)
NB.   cs  - 2-vector of Cayley-Dickson halves (c,s), defines
NB.         rotating number (complex or quaternion)
NB.   oxy - array of the same shape as ixy, the rotated
NB.         number[s]
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   cs (rot -: (qnmul qnconj)~) ixy
NB.
NB. Notes:
NB. - implements LAPACK's xROT

rot=: (mp~(,: (-@{: ,. {.)@:+))~

NB. ---------------------------------------------------------
NB. lartv
NB.
NB. Description:
NB.   Applies a plane rotations cs[i] to ixy:
NB.     oxy[i] := cs[i] * ixy[i] for i=0:n-1
NB.
NB. Syntax:
NB.   oxy=. cs lartv ixy
NB. where
NB.   ixy - 2-vector of Cayley-Dickson halves (ix,iy) or
NB.         n×2-matrix of laminated Cayley-Dickson halves
NB.         (ix[i],iy[i]), defines number[s] to rotate
NB.         (complex or quaternion)
NB.   cs  - array of the same shape as ixy, 2-vector of
NB.         Cayley-Dickson halves (c,s) or n×2-matrix of
NB.         laminated Cayley-Dickson halves (c[i],s[i]),
NB.         defines rotating number[s] (complex or
NB.         quaternion)
NB.   oxy - array of the same shape as ixy, the rotated
NB.         number[s]
NB.
NB. Notes:
NB. - implements LAPACK's xLARTV

lartv=: (mp"2 1~(,:"1 (-@:({:"1) ,. {."1)@:+))~

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
NB.               rot&.|:  NB. apply rotation to rows
NB.               rot      NB. apply rotation to columns
NB.   vapp    - monad to generate and apply rotation; is
NB.             called as:
NB.               'Aupd cs'=. vapp A ; iossubA ; iosfg
NB.   cs      - 2-vector (c,s), output of lartg, defines
NB.             rotation matrix
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

rotga=: 1 : 0
  'A iossubA iosfg'=. y
  subA=. iossubA { A
  cs=. lartg iosfg { subA
  ((cs u subA) iossubA } A) ; cs
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
NB.   cs      - 2-vector (c,s), output of lartg, defines
NB.             rotation matrix
NB.   iof,iog - IOS either rows (rotscll) or columns
NB.             (rotsclu) which contain 2-vectors (f,g) to
NB.             rotate, iof≠iog
NB.
NB. TODO:
NB. - aggregate non-intersecting groups of vectors to change
NB.   them simultaneously

rotscll=: 4 : 0
  i=. 0
  while. i < # y do.         NB. traverse dA rows down
    'cs iofg'=. _2 ]\ i { y
    if. 0 0 -: iofg do.
      if. -. 0 0 -: cs do.
        'm io'=. cs
        x=. io m&* upd x     NB. do scale
      end.
    else.
      x=. iofg cs&rot upd x  NB. do rotation
    end.
    i=. >: i
  end.
  x
)

rotsclu=: 4 : 0
  i=. 0
  while. i < # y do.                        NB. traverse dA rows down
    'cs iofg'=. _2 ]\ i { y
    if. 0 0 -: iofg do.
      if. -. 0 0 -: cs do.
        'm io'=. cs
        x=. (< a: ; io) m&* upd x           NB. do scale
      end.
    else.
      x=. (< a: ; iofg) cs&(rot&.|:) upd x  NB. do rotation
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
NB.   testlartg FG
NB. where
NB.   FG - n×2-matrix of laminated (f,g) pairs to test
NB.
NB. Algorithm for calculating backward error:
NB.   In:  FG, CS
NB.   where
NB.        CS=. lartg"1 FG
NB.        CS -: C ,. S
NB.   Out: maxberr
NB.   1) find R:
NB.        R=. CS mp"1 FG
NB.   2) find exact solution for each row by Algorithm 1 [1]:
NB.        CSexact=. algo1"1 FG
NB.      where
NB.        CSexact -: Cexact ,. Sexact
NB.   3) find Rexact:
NB.        Rexact=. CSexact mp"1 FG
NB.   4) combine R and Rexact:
NB.        Rboth=. R ,. Rexact
NB.   5) exclude rows containing NaNs:
NB.        Rboth=. xrNaN Rboth
NB.      note: J602 has a bug in (128!:5) [2], so the
NB.            following workaround:
NB.              j./"1@(128!:5)@:+.
NB.            must be used instead of:
NB.              128!:5
NB.   6) exclude rows containing ±∞:
NB.        Rboth=. xrInf Rboth
NB.   7) calculate backward error for each pair
NB.      (R[i],Rexact[i]) [1]:
NB.        BErr[i] := |R[i] - Rexact[i]| / max(FP_EPS * |Rexact[i]|, FP_SFMIN * FP_PREC)
NB.      where
NB.        R[i]      - approximation computed by lartg,
NB.                      |R[i] - Rexact[i]| ≤ FP_OVFL
NB.        Rexact[i] - exact value computed by Algorithm 1
NB.                    [1],
NB.                      |Rexact[i]| ≤ FP_OVFL
NB.   8) exclude +∞ from vector BErr:
NB.        BErr=. xrInf BErr
NB.   9) find backward error:
NB.        maxberr = max(BErr[:])
NB.
NB. References:
NB. [1] D. Bindel, J. Demmel, W. Kahan, O. Marques. (2001) On
NB.     Computing Givens rotations reliably and efficiently.
NB.     LAPACK Working Note 148, University of Tennessee,
NB.     UT-CS-00-449, January 31, 2001.
NB.     http://www.netlib.org/lapack/lawns/downloads/
NB. [2] [Jprogramming] 128!:5] 0j_.
NB.     Dan Bron, 2009-12-02 02:22:37
NB.     http://www.jsoftware.com/pipermail/programming/2009-December/017071.html

testlartg=: 3 : 0
  NB. implement Algorithm 1 [1]
  algo1=: 3 : 'if. 0 = {: y do. (sgn,0:) {. y elseif. 0 = {. y do. (0,sgn@+) {: y elseif. do. try. ((|f),((sgn f)*(+g))) % %: (+/) soris ''f g''=. y catch. 2 # _. end. end.'

  NB. exclude rows containing NaN from the table y
  xrNaN=: #~ -.@(+./^:2)@|:@(128!:5)@:+.

  NB. exclude rows containing ±∞ from the table y
  xrInf=: #~ -.@(+./)@|:@:(_=|)

  NB. exclude elements ±∞ from the table y
  xeInf=: #~ (_~:|)

  NB. backward error calculator:
  vberrlartg=: (mp algo1)"1@[ (|@:- >./@:xeInf@:% (FP_SFMIN * FP_PREC) >. FP_EPS * |@[)/@|:@xrInf@xrNaN@,. mp"1

  ('lartg"1' tmonad (]`]`(_."_)`(_."_)`vberrlartg)) y

  erase 'algo1 xrNaN xrInf xeInf vberrlartg'

  EMPTY
)

NB. ---------------------------------------------------------
NB. testrot
NB.
NB. Description:
NB.   Adv. to make verb to test rotation algorithms by matrix
NB.   of generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testrot
NB. where
NB.   mkmat - monad to generate a matrix; is called as:
NB.             mat=. mkmat (m,n)
NB.   vtest - monad to test algorithms by matrix mat; is
NB.           called as:
NB.             vtest (m,n)
NB.   (m,n) - 2-vector of integers, the shape of matrix mat
NB.
NB. Application:
NB. - test by 200 random real 2-vectors with elements
NB.   distributed uniformly with support (0,1):
NB.     ?@$&0 testrot_mt_ 200 150
NB. - test by 200 random real 2-vectors with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testrot_mt_ 200 200
NB. - test by 150 random complex 2-vectors:
NB.     (gemat_mt_ j. gemat_mt_) testrot_mt_ 150 200

testrot=: 1 : 'EMPTY_mt_ [ testlartg_mt_@u@({. , 2:)'
