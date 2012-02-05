NB. Raise matrix to an integer power[s]
NB.
NB. gepow      Raise a general matrix to integer power[s]
NB. dipow      Raise a diagonalizable matrix to integer
NB.            power[s]
NB. hepow      Raise a Hermitian (symmetric) matrix to
NB.            integer power[s]
NB.
NB. testgepow  Test gepow by general matrix given
NB. testdipow  Test dipow by diagonalizable matrix given
NB. testhepow  Test hepow by Hermitian (symmetric) matrix
NB.            given
NB. testpow    Adv. to make verb to test xxpow by matrix of
NB.            generator and shape given
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

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. gepow
NB.
NB. Description:
NB.   Raise a general matrix A to integer power[s]
NB.
NB. Syntax:
NB.   P=. p gepow A
NB. where
NB.   A  - n×n-matrix, a general matrix
NB.   p  - sh-array of non-negative integers, power[s]
NB.   P  - sh×n×n-array if r>0, a matrix A in power[s] p
NB.        n×n-array    if r=0, a matrix A in power p
NB.   sh - r-vector of non-negative integers, the shape of p
NB.   r  ≥ 0, the rank of p
NB.
NB. References:
NB. [1] Linear Recurrences and Matrix Powers
NB.     Roger Hui, 2006-08-09 09:20:34
NB.     http://www.jsoftware.com/jwiki/Essays/Linear_Recurrences

gepow=: 4 : 0

  mpi3=. mp/ ^: (3 = (# @ $))       NB. apply mp/ only to 3-rank arrays (stiff rank)

  pl=. i. >: <. (2 & ^.) (>./) , x  NB. powers list: 2^i
  pc=. mp~ ^: pl y                  NB. powers cache: A^2^i
  pb=. (< @ I. @ (|. " 1) @ #:) x   NB. pl bits boxed array of shape sh

  pc (mpi3 @ ({~ >)) " 3 0 pb       NB. extract and mp A's powers for each pl atom
)

NB. ---------------------------------------------------------
NB. dipow
NB.
NB. Description:
NB.   Raise a diagonalizable matrix to integer power[s]
NB.
NB. Syntax:
NB.   P=. p dipow iLl ; vl ; Ll
NB.   P=. p dipow (ct Rl) ; vl ; ct iRl
NB.   P=. p dipow (ct iLu) ; vu ; ct Lu
NB.   P=. p dipow Ru ; vu ; iRu
NB. where
NB.   Ll  - n×n-matrix, rows are left eigenvectors of A,
NB.         output of geevlvx
NB.   Lu  - n×n-matrix, columns are left eigenvectors of A,
NB.         output of geevuvx
NB.   Rl  - n×n-matrix, rows are right eigenvectors of A,
NB.         output of geevlxv
NB.   Ru  - n×n-matrix, columns are right eigenvectors of A,
NB.         output of geevuxv
NB.   vl  - n-vector, eigenvalues of A, output of geevlxx
NB.   vu  - n-vector, eigenvalues of A, output of geevuxx
NB.   iLl -: Ll^_1
NB.   iLu -: Lu^_1
NB.   iRl -: Rl^_1
NB.   iRu -: Ru^_1
NB.   p   - sh-array of positive integers, power[s]
NB.   P   - sh×n×n-array if r>0,
NB.         n×n-array    if r=0, a matrix A in power[s] p
NB.   sh  - r-vector of non-negative integers, the shape of p
NB.   r   ≥ 0, the rank of p
NB.
NB. Assertions (with appropriate comparison tolerance):
NB. - lower case:
NB.   ((-: ~.) v) +. ((-: ct) A)  NB. A must be normal (diagonalizable)
NB.   (L mp A) -: V mp L          NB. verify...
NB.   (A mp ct R) -: (ct R) mp V  NB. ...eigendecomposition
NB.   W -: L mp (ct R)            NB. LAPACK doesn't guarantee (W -: idmat # A)
NB.   iL -: (ct R) %"1 w          NB. see [1]
NB.   (ct iR) -: L % w            NB. see [1]
NB.   A -: iL mp V mp L
NB.   A -: iL mp v * L
NB.   A -: (ct R) mp V mp ct iR
NB.   A -: (ct R) mp v * ct iR
NB.   F -: diagmat"1 f
NB.   P -: iL mp"2 F mp"2 L
NB.   P -: iL mp"2 f *"1 2 L
NB.   P -: (ct R) mp"2 F mp"2 ct iR
NB.   P -: (ct R) mp f *"1 2 ct iR
NB.   P -: p dipow iL ; v ; L
NB.   P -: p dipow (ct R) ; v ; (ct iR)
NB. where
NB.   'v LR'=. geevuvv A  NB. use definition from ggevuxx application notes
NB.   'L R'=. LR
NB.   iL=. %. L
NB.   iR=. %. R
NB.   V=. diagmat v
NB.   w=. (ct L) mp"1 |: R
NB.   W=. diagmat w
NB.   P=. p gepow A
NB.   f=. v ^1 0 p
NB.   F=. p gepow V
NB. - upper case:
NB.   ((-: ~.) v) +. ((-: ct) A)  NB. A must be normal (diagonalizable)
NB.   ((ct L) mp A) -: V mp ct L  NB. verify...
NB.   (A mp R) -: R mp V          NB. ...eigendecomposition
NB.   W -: (ct L) mp R            NB. LAPACK doesn't guarantee (W -: idmat # A)
NB.   (ct iL) -: R %"1 w          NB. see [1]
NB.   iR -: (ct L) % w            NB. see [1]
NB.   A -: (ct iL) mp V mp ct L
NB.   A -: (ct iL) mp v * ct L
NB.   A -: R mp V mp iR
NB.   A -: R mp v * iR
NB.   F -: diagmat"1 f
NB.   P -: (ct iL) mp"2 F mp"2 ct L
NB.   P -: (ct iL) mp"2 f *"1 2 ct L
NB.   P -: R mp"2 F mp"2 iR
NB.   P -: R mp f *"1 2 iR
NB.   P -: p dipow (ct iL) ; v ; ct L
NB.   P -: p dipow R ; v ; iR
NB. where
NB.   'v LR'=. geevuvv A  NB. use definition from ggevuxx application notes
NB.   'L R'=. LR
NB.   iL=. %. L
NB.   iR=. %. R
NB.   V=. diagmat v
NB.   w=. (ct L) mp"1 |: R
NB.   W=. diagmat w
NB.   P=. p gepow A
NB.   f=. v ^1 0 p
NB.   F=. p gepow V
NB.
NB. References:
NB. [1] http://icl.cs.utk.edu/lapack-forum/viewtopic.php?p=985#p985
NB.     LAPACK/ScaLAPACK Development ‹ DGEEVX and left eigenvectors
NB.     Julien Langou, Fri Dec 22, 2006 5:15 pm

dipow=: (0 {:: ]) mp"2 ([ ^"1 0~ 1 {:: ]) (*"1 2) 2 {:: ]

NB. ---------------------------------------------------------
NB. hepow
NB.
NB. Description:
NB.   Raise a Hermitian (symmetric) matrix to integer
NB.   power[s]
NB.
NB. Syntax:
NB.   P=. p hepow vl ; iRl
NB.   P=. p hepow vu ; Ru
NB. where
NB.   Rl  - n×n-matrix, rows are eigenvectors of A, output of
NB.         heevlv
NB.   Ru  - n×n-matrix, columns are eigenvectors of A, output
NB.         of heevuv
NB.   vl  - n-vector, eigenvalues of A, output of heevlx
NB.   vu  - n-vector, eigenvalues of A, output of heevux
NB.   iRl -: Rl^_1
NB.   p  - sh-array of positive integers, power[s]
NB.   P  - sh×n×n-array if r>0,
NB.        n×n-array    if r=0, a matrix A in power[s] p
NB.   sh - r-vector of non-negative integers, the shape of p
NB.   r  ≥ 0, the rank of p
NB.
NB. Assertions (with appropriate comparison tolerance):
NB. - lower case:
NB.   (-: ct) A           NB. A must be Hermitian (symmetric)
NB.   (R mp A) -: V mp R  NB. verify eigendecomposition
NB.   iR -: ct R
NB.   A -: iR mp V mp R
NB.   A -: iR mp v * R
NB.   F -: diagmat"1 f
NB.   P -: iR mp"2 F mp"2 R
NB.   P -: iR mp"2 f *"1 2 R
NB.   P -: p hepow v ; R
NB. where
NB.   'v R'=. heevlv A  NB. use definition from ggevlxx application notes
NB.   iR=. %. R
NB.   V=. diagmat v
NB.   P=. p gepow A
NB.   f=. v ^1 0 p
NB.   F=. p gepow V
NB. - upper case:
NB.   (-: ct) A           NB. A must be Hermitian (symmetric)
NB.   (A mp R) -: R mp V  NB. verify eigendecomposition
NB.   iR -: ct R
NB.   A -: R mp V mp iR
NB.   A -: R mp v * iR
NB.   F -: diagmat"1 f
NB.   P -: R mp"2 F mp"2 iR
NB.   P -: R mp"2 f *"1 2 iR
NB.   P -: p hepow v ; R
NB. where
NB.   'v R'=. heevuv A  NB. use definition from ggevuxx application notes
NB.   iR=. %. R
NB.   V=. diagmat v
NB.   P=. p gepow A
NB.   f=. v ^1 0 p
NB.   F=. p gepow V

hepow=: (1 {:: ]) mp"2 ([ ^"1 0~ 0 {:: ]) *"1 2 ct@(1 {:: ])

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testgepow
NB.
NB. Description:
NB.   Test gepow by general matrix given
NB.
NB. Syntax:
NB.   testgepow A
NB. where
NB.   A - n×n-matrix
NB.
NB. Notes:
NB. - fixed powers vector (p -: 5 7) is used

testgepow=: 3 : 0
  rcond=. gecon1 y

  ('5 7 & gepow' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testdipow
NB.
NB. Description:
NB.   Test dipow by diagonalizable matrix given
NB.
NB. Syntax:
NB.   testdipow A
NB. where
NB.   A - n×n-matrix, diagonalizable
NB.
NB. Notes:
NB. - fixed powers vector (p -: 5 7) is used

testdipow=: 3 : 0
  NB. use for a while the definition from ggevlxx application notes
  geevlvv=. 0 1 ({.&.>)`(((**@+@((i.>./)"1@sorim{"0 1]))%norms"1)"2&.>)ag ggevlvv@(,:(idmat@c))

  rcond=. gecon1 y
  try.
    'v LR'=. geevlvv y                 NB. eigendecomposition
    'L R'=. LR
    assert ((-: ~.) v) +. ((-: ct) y)  NB. A must be normal (diagonalizable)
    iRh=. L ([ % (mp"1 +)) R           NB. reconstruct R^_1^H , see [1] in dipow
  catch.
    R=. v=. iRh=. _.
  end.

  ('5 7 & dipow' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) (ct R) ; v ; iRh

  EMPTY
)

NB. ---------------------------------------------------------
NB. testhepow
NB.
NB. Description:
NB.   Test hepow by Hermitian (symmetric) matrix given
NB.
NB. Syntax:
NB.   testhepow A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric)

testhepow=: 3 : 0
  NB. use for a while the definition from ggevlxx application notes
  heevlv=. 0 1 ((9 o.{.)&.>)`((%%:@diag@(mp ct))&.>)ag ggevlvn@(,:(idmat@c))

  rcond=. hecon1 y
  try.
    'v R'=. heevlv y  NB. eigendecomposition
  catch.
    v=. R=. _.
  end.

  ('5 7 & hepow' tmonad (]`]`(rcond"_)`(_."_)`(_."_))) v ; ct R

  EMPTY
)

NB. ---------------------------------------------------------
NB. testpow
NB.
NB. Description:
NB.   Adv. to make verb to test xxpow by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testpow
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
NB.     ?@$&0 testpow_mt_ 150 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     (_1 1 0 4 _6 4 & gemat_mt_) testpow_mt_ 150 150
NB. - test by random square complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testpow_mt_ 150 150

testpow=: 1 : 'EMPTY_mt_ [ ((testhepow_mt_ @ (u hemat_mt_)) [ (testdipow_mt_ @ (u dimat_mt_ u)) [ (testgepow_mt_ @ u)) ^: (=/)'
