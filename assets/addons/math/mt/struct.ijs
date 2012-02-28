NB. Structure handlers
NB.
NB. c         Columns in noun
NB. trace     Matrix trace
NB. ct        Conjugate transpose
NB. cp        Conjugate pertranspose
NB. fp        Full (symmetric) permutation
NB. p2P       Transform permutation vector to permutation
NB.           matrix
NB. ip2P      Transform inversed permutation vector to
NB.           permutation matrix
NB. rt        Restrained Take
NB. icut      Inversed cut
NB.
NB. upd       Adv. to update subarray by a monad
NB. appendx   Enhance built-in Append verb (,)
NB. stitchx   Enhance built-in Stitch verb (,.)
NB.
NB. diag      Return a solid part of diagonal
NB. setdiag   Assign value[s] to a solid part of diagonal
NB. upddiag   Template adv. to make verbs to update a solid
NB.           part of diagonal
NB.
NB. bdlpick   Zeroize elements outside lower bidiagonal part
NB.           of the matrix
NB. bdupick   Zeroize elements outside upper bidiagonal part
NB.           of the matrix
NB. hslpick   Zeroize elements outside lower Hessenberg part
NB.           of the matrix
NB. hsupick   Zeroize elements outside upper Hessenberg part
NB.           of the matrix
NB. gtpick    Zeroize elements outside tridiagonal part of
NB.           the matrix
NB. trlpick   Zeroize elements outside lower triangular part
NB.           of the matrix
NB. trupick   Zeroize elements outside upper triangular part
NB.           of the matrix
NB.
NB. idmat     Make identity matrix with units on solid part
NB.           of diagonal
NB. diagmat   Make diagonal matrix
NB. trl       Extract lower triangular (trapezoidal) matrix
NB. tru       Extract upper triangular (trapezoidal) matrix
NB. trl0      Extract strictly lower triangular (trapezoidal)
NB.           matrix
NB. tru0      Extract strictly upper triangular (trapezoidal)
NB.           matrix
NB. trl1      Extract unit lower triangular (trapezoidal)
NB.           matrix
NB. tru1      Extract unit upper triangular (trapezoidal)
NB.           matrix
NB. tr2he     Make Hermitian (symmetric) matrix from
NB.           triangular one
NB. he        Make Hermitian (symmetric) matrix from lower
NB.           triangle of general square one
NB. po        Make Hermitian (symmetric) positive definite
NB.           matrix from general square invertible one
NB.
NB. Version: 0.7.0 2011-08-06
NB.
NB. Copyright 2007-2011 Oleg Kobchenko, Roger Hui, Igor Zhuravlov
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
NB. Miscellaneous

NB. convert table y to table of diagonals
t2td=: 1 : '({. u/&i. {:)@$'

NB. template conj. to extract matrix circumscribing the
NB. triangular (trapezoidal) matrix
NB. starting from diagonal number x in the matrix y
trcut=: 2 : '((m&*)@:(<./"1)@v $) {. ]'

NB. extract upper triangular (trapezoidal) matrix
trucut=: 1 _1 trcut (] ,. (-~ {:))

NB. extract lower triangular (trapezoidal) matrix
trlcut=: _1 1 trcut ((+ {.) ,. ])

NB. template conj. to extract triangular (trapezoidal)
NB. matrix starting from diagonal number x in the
NB. circumscribing matrix y
tr=: 2 : '0&$: : ([ (] * (u~ (-~ t2td))) v)'

NB. ---------------------------------------------------------
NB. mxbstencil
NB.
NB. Description:
NB.   Template adv. to make verbs returning
NB.   [multi-][anti-]band stencil for matrix
NB.
NB. Syntax:
NB.   vapp=. vmix mxbstencil
NB. where
NB.   vmix - dyad to mix lIOS x and y, is either (-~) for
NB.          band, or (+) for anti-band stencils, is called
NB.          as:
NB.            mix=. lIOrow vmix lIOcolumn
NB.   vapp - dyad to make multi-[anti-]band stencil, is
NB.          called as:
NB.            s=. bs vapp A
NB.   bs   - k×2-matrix of (b)s, or single b, or d, defines
NB.          [anti-]bands to stencil
NB.   b    - 2-vector (h,t), defines one [anti-]band to
NB.          stencil
NB.   h    - integer in range [-∞,t], lIO head of
NB.          [anti-]diagonal
NB.   t    - integer in range [h,+∞], lIO tail of
NB.          [anti-]diagonal
NB.   d    - integer in range [-∞,+∞], lIO single
NB.          [anti-]diagonal to stencil
NB.   A    - m×n-matrix
NB.   s    - m×n-matrix, boolean, having 1s on [anti-]band[s]
NB.
NB. Examples:
NB. - see mbstencil, mabstencil

mxbstencil=: 1 : '(+./^:(_2 + #@$)@:((1=I.)"1 2)~ -&1 0"1)~ (u t2td)'

NB. ---------------------------------------------------------
NB. mbstencil
NB. mabstencil
NB.
NB. Description:
NB.   [Multi-]band and [multi-]anti-band stencils for matrix
NB.
NB. Syntax:
NB.   s=. bs mbstencil  A
NB.   s=. bs mabstencil A
NB. where
NB.   bs - k×2-matrix of (b)s, or single b, or d, defines
NB.        [anti-]bands to stencil
NB.   A  - m×n-matrix
NB.   s  - m×n-matrix, boolean, having 1s on [anti-]band[s]
NB.   b  - 2-vector (h,t), defines one [anti-]band to stencil
NB.   h  - integer in range [-∞,t], defines lIO head of
NB.        [anti-]diagonal
NB.   t  - integer in range [h,+∞], defines lIO tail of
NB.        [anti-]diagonal
NB.   d  - integer in range [-∞,+∞], defines one
NB.        [anti-]diagonal to stencil
NB.
NB. Examples:
NB.    1 mbstencil i. 3 5                    1 mabstencil i. 3 5
NB. 0 1 0 0 0                             0 0 0 1 0
NB. 0 0 1 0 0                             0 0 1 0 0
NB. 0 0 0 1 0                             0 1 0 0 0
NB.    2 3 mbstencil i. 3 5                  2 3 mabstencil i. 3 5
NB. 0 0 1 1 0                             0 1 1 0 0
NB. 0 0 0 1 1                             1 1 0 0 0
NB. 0 0 0 0 1                             1 0 0 0 0
NB.    (__ _1 ,: 2 3) mbstencil i. 3 5       (__ _1 ,: 2 3) mabstencil i. 3 5
NB. 0 0 1 1 0                             0 1 1 0 0
NB. 1 0 0 1 1                             1 1 0 0 1
NB. 1 1 0 0 1                             1 0 0 1 1

mbstencil=:                   -~ mxbstencil
mabstencil=: (|."1@:-~ <:@c) (+  mxbstencil) ]

NB. ---------------------------------------------------------
NB. diaglios
NB.
NB. Description:
NB.   Return lIOS of solid part of diagonal of matrix
NB.
NB. Syntax:
NB.   lios=. [(d[,h[,s]])] diaglios [m,]n
NB. where
NB.   m    ≥ 0, integer, optional rows in matrix, default is
NB.          n
NB.   n    ≥ 0, integer, columns in matrix
NB.   d    - integer in range [1-m,n-1], optional lIO
NB.          diagonal, default is 0 (main diagonal)
NB.   h    - integer in range [-S,S-1], optional lIO extreme
NB.          element of solid part of diagonal, default is 0
NB.          (take from head)
NB.   s    - integer in range [-S,S] or ±∞, optional size of
NB.          solid part of diagonal, default is +∞ (all
NB.          elements in forward direction)
NB.   lios - min(S,|s|)-vector of integers, lIOS solid
NB.          part of diagonal
NB.   S    ≥ 0, the length of diagonal
NB.
NB. Formulae:
NB. - the whole diagonal's lIO extreme element:
NB.     H := (d ≥ 0) ? d : (-n*d)
NB. - the whole diagonal's size:
NB.     S := max(0,min(m,n,⌊(n+m-|n-m-2*d|)/2⌋))
NB.
NB. Notes:
NB. - (h,s) pair defines raveled rIOS of solid part of
NB.   diagonal

diaglios=: (0 0 _&$:) :(4 : 0)
  'd h s'=. x=. ((i. 3) < (# x)) } 0 0 _ ,: x  NB. in-place op
  'm n'=. y=. 2 $ y
  H=. n (-@*^:(0 > ])) d
  S=. 0 >. <./ y , <. -: (n + m - | n - m + +: d)
  (h ,: (s <. S)) (] ;. 0) (>: n) dhs2lios H , S
)

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. Miscellaneous

c=: {:!.1@$      NB. Columns in noun

trace=: +/@diag  NB. Matrix trace

ct=: +@:|:       NB. Conjugate transpose
cp=: ct&.|.      NB. Conjugate pertranspose

fp=: [ C."1 C.   NB. Full (symmetric) permutation

NB. Transform permutation vector to permutation matrix, to
NB. permute rows by y or columns by (/:y)
p2P=:  {    =

NB. Transform inversed permutation vector to permutation
NB. matrix, or permutation vector to inversed permutation
NB. matrix, to permute rows by (/:y) or columns by y
ip2P=: {^:_1=

NB. ---------------------------------------------------------
NB. icut
NB.
NB. Description:
NB.   Inversed cut to model <;.1^:_1
NB.
NB. Syntax:
NB.   A=. icut bA
NB. where
NB.   bA - block array
NB.   A  - sh-array
NB.
NB. Assertions:
NB.   A -: icut fret <;.1 A
NB. where
NB.   A    - some array
NB.   fret - some fret
NB.
NB. References:
NB. [1] JWiki/Essays/ Block Matrix Inverse
NB.     Roger Hui, 2005-11-24 03:53:19
NB.     http://www.jsoftware.com/jwiki/Essays/Block%20Matrix%20Inverse
NB.
NB. TODO:
NB. - fret should be sparse

icut=: [: > 3 : ',"(#$y)&.>/y'^:(#@$)

NB. ---------------------------------------------------------
NB. rt
NB.
NB. Description:
NB.   Restrained Take. Just like built-in Take verb ({.), but
NB.   without overtake feature. Overtaking value means "all
NB.   elements along this axis".
NB.
NB. Examples:
NB.    2 rt i. 3 4                  _2 rt i. 3 4
NB. 0 1 2 3                      4 5  6  7
NB. 4 5 6 7                      8 9 10 11
NB.    2 30 rt i. 3 4               2 _ rt i. 3 4
NB. 0 1 2 3                      0 1 2 3
NB. 4 5 6 7                      4 5 6 7
NB.    20 3 rt i. 3 4               _ 3 rt i. 3 4
NB. 0 1  2                       0 1  2
NB. 4 5  6                       4 5  6
NB. 8 9 10                       8 9 10
NB.    _2 _30 rt i. 3 4             _2 __ rt i. 3 4
NB. 4 5  6  7                    4 5  6  7
NB. 8 9 10 11                    8 9 10 11
NB.    _20 _3 rt i. 3 4             __ _3 rt i. 3 4
NB. 1  2  3                      1  2  3
NB. 5  6  7                      5  6  7
NB. 9 10 11                      9 10 11

rt=: (*@[ * |@[ <. (({.~ #)~ $)) {. ]

NB. ---------------------------------------------------------
NB. upd
NB.
NB. Description:
NB.   Adv. to update subarray by a monad
NB.
NB. Syntax:
NB.   vapp=. u upd
NB. where
NB.   u    - monad to update subA; is called as:
NB.            subAupd=. u subA
NB.   vapp - verb to update A; is called as:
NB.            Aupd=. ios vapp A
NB.   ios  - IOS of subA in the A
NB.   subA - subarray in the A
NB.   A    - array
NB.   Aupd - A with subA being replaced by subAupd
NB.
NB. Assertions:
NB.   Aupd -: ios vapp A
NB. where
NB.   vapp=. u upd
NB.   subA=. ios { A
NB.   subAupd=. u subA
NB.   Aupd=. subAupd ios } A
NB.
NB. Examples:
NB.    1 ('*'"_ upd) 4 5$'-'             1 2 ('*'"_ upd) 4 5$'-'
NB. -----                             -----
NB. *****                             *****
NB. -----                             *****
NB. -----                             -----
NB.    (<1 2) ('*'"_ upd) 4 5$'-'        (1 2;2 3) ('*'"_ upd) 4 5$'-'
NB. -----                             -----
NB. --*--                             --*--
NB. -----                             ---*-
NB. -----                             -----
NB.
NB. References:
NB. [1] [Jprogramming] Transform to Amend
NB.     Oleg Kobchenko, 2007-03-02 22:15:54
NB.     http://www.jsoftware.com/pipermail/programming/2007-March/005415.html

upd=: (@:{) (`[) (`]) }

NB. ---------------------------------------------------------
NB. appendl
NB. appendr
NB.
NB. Description:
NB.   Enhance built-in Append verb (,)
NB.
NB. Syntax:
NB.   B=. A0 appendx A1
NB.
NB. Examples:
NB.    (3 3$3) appendl (2 2$2)      (3 3$3) appendr (2 2$2)
NB. 3 3 3                        3 3 3
NB. 3 3 3                        3 3 3
NB. 3 3 3                        3 3 3
NB. 2 2 0                        0 2 2
NB. 2 2 0                        0 2 2
NB.    (2 2$2) appendl (3 3$3)      (2 2$2) appendr (3 3$3)
NB. 2 2 0                        0 2 2
NB. 2 2 0                        0 2 2
NB. 3 3 3                        3 3 3
NB. 3 3 3                        3 3 3
NB. 3 3 3                        3 3 3
NB.
NB. Notes:
NB. - at most one of A0, A1 can be 1-rank array (i.e. vector)

appendl=: , `([, ({."1~   c)~)`(({."1~   c), ])@.(*@-&c)
appendr=: , `([, ({."1~ -@c)~)`(({."1~ -@c), ])@.(*@-&c)

NB. ---------------------------------------------------------
NB. stitcht
NB. stitchb
NB.
NB. Description:
NB.   Enhance built-in Stitch verb (,.)
NB.
NB. Syntax:
NB.   B=. A0 stitchx A1
NB.
NB. Examples:
NB.    (3 3$3) stitcht (2 2$2)      (3 3$3) stitchb (2 2$2)
NB. 3 3 3 2 2                    3 3 3 0 0
NB. 3 3 3 2 2                    3 3 3 2 2
NB. 3 3 3 0 0                    3 3 3 2 2
NB.    (2 2$2) stitcht (3 3$3)      (2 2$2) stitchb (3 3$3)
NB. 2 2 3 3 3                    0 0 3 3 3
NB. 2 2 3 3 3                    2 2 3 3 3
NB. 0 0 3 3 3                    2 2 3 3 3
NB.
NB. Notes:
NB. - 1-rank arrays (i.e. vectors) are also acceptable

stitcht=: ,.`([,.({.  ~   #)~)`(({.  ~   #),.])@.(*@-&#)
stitchb=: ,.`([,.({.  ~ -@#)~)`(({.  ~ -@#),.])@.(*@-&#)

NB. ---------------------------------------------------------
NB. diag
NB.
NB. Description:
NB.   Return a solid part of diagonal of matrix
NB.
NB. Syntax:
NB.   e=. [(d[,h[,s]])] diag A
NB. where
NB.   A - m×n-matrix
NB.   d - integer in range [1-m,n-1], optional lIO diagonal,
NB.       default is 0 (main diagonal)
NB.   h - integer in range [-S,S-1], optional lIO extreme
NB.       element of solid part of diagonal, default is 0
NB.       (take from head)
NB.   s - integer in range [-S,S] or ±∞, optional size of 
NB.       solid part of diagonal, default is +∞ (all elements
NB.       in forward direction)
NB.   e - min(S,|s|)-vector, elements from the solid part of
NB.       diagonal
NB.   S ≥ 0, the length of diagonal

diag=: ((<0 1)&|:) :((diaglios $) ({,) ])

NB. ---------------------------------------------------------
NB. setdiag
NB.
NB. Description:
NB.   Assign value[s] to a solid part of diagonal
NB.
NB. Syntax:
NB.   Aupd=. (e;[d[,h[,s]]]) setdiag A
NB. where
NB.   A    - m×n-matrix to change
NB.   e    - {0,1}-rank array, value[s] to assign
NB.   d    - integer in range [1-m,n-1], optional lIO
NB.          diagonal, default is 0 (main diagonal)
NB.   h    - integer in range [-S,S-1], optional lIO extreme
NB.          element of solid part of diagonal, default is 0
NB.          (take from head)
NB.   s    - integer in range [-S,S] or ±∞ when e is scalar,
NB.          or any from set {±k,±∞} when e is vector;
NB.          optional size of solid part of diagonal, default
NB.          is +∞ (all elements in forward direction)
NB.   Aupd - m×n-matrix A with value[s] e assigned to solid
NB.          part of d-th diagonal
NB.   S    ≥ 0, the length of d-th diagonal
NB.   k    ≤ S, the length of vector e
NB.
NB. Examples:
NB. 
NB.    (2;a:) setdiag 4 4 $ 0          (2;_1 1 1) setdiag 4 4 $ 0
NB. 2 0 0 0                         0 0 0 0
NB. 0 2 0 0                         0 0 0 0
NB. 0 0 2 0                         0 2 0 0
NB. 0 0 0 2                         0 0 0 0
NB.    (2;_1) setdiag 4 4 $ 0          (1 2 3;_1) setdiag 4 4 $ 0
NB. 0 0 0 0                         0 0 0 0
NB. 2 0 0 0                         1 0 0 0
NB. 0 2 0 0                         0 2 0 0
NB. 0 0 2 0                         0 0 3 0
NB.    (2;_1 1) setdiag 4 4 $ 0        (1 2 3;_1 _1 _3) setdiag 4 4 $ 0
NB. 0 0 0 0                         0 0 0 0
NB. 0 0 0 0                         3 0 0 0
NB. 0 2 0 0                         0 2 0 0
NB. 0 0 2 0                         0 0 1 0

setdiag=: 4 : 0
  'e dhs'=. x
  dhs=. ((i. 3) < (# dhs)) } 0 0 _ ,: dhs  NB. assign defaults, in-place op
  lios=. dhs diaglios $ y
  e (lios"_) } y
)

NB. ---------------------------------------------------------
NB. upddiag
NB.
NB. Description:
NB.   Template adv. to make verbs to update a solid part of
NB.   diagonal
NB.
NB. Syntax:
NB.   vapp=. u upddiag
NB. where
NB.   u    - monad to change elements; is called as:
NB.            eupd=. u e
NB.   vapp - ambivalent verb to update a solid part of
NB.          diagonal of matrix A by monad u; is called
NB.          as:
NB.             Aupd=. [(d,[h[,s]])] vapp A
NB.   d    - integer in range [1-m,n-1], optional lIO
NB.          diagonal, default is 0 (main diagonal)
NB.   h    - integer in range [-S,S-1], optional lIO extreme
NB.          element of solid part of diagonal, default is 0
NB.          (take from head)
NB.   s    - integer in range [-S,S] or ±∞, optional size of
NB.          solid part of diagonal, default is +∞ (all
NB.          elements in forward direction)
NB.   A    - m×n-matrix to update
NB.   Aupd - m×n-matrix A with solid part of d-th diagonal
NB.          being updated by monad u
NB.   S    ≥ 0, the length of d-th diagonal
NB.
NB. TODO:
NB. - [Jgeneral] duce/fold in J as an adverb or conjuction
NB.   Henry Rich, Sun Nov 25 14:07:46 HKT 2007
NB.   http://www.jsoftware.com/pipermail/general/2007-November/031233.html

upddiag=: 1 : 0
  lios=. diaglios_mt_ $ y
  e=. lios ({,) y
  (u e) (lios"_) } y
:
  lios=. x diaglios_mt_ $ y
  e=. lios ({,) y
  (u e) (lios"_) } y
)

NB. ---------------------------------------------------------
NB. bdlpick
NB.
NB. Description:
NB.   Zeroize elements outside lower bidiagonal part of the
NB.   matrix
NB.
NB. Syntax:
NB.   B=. bdlpick A
NB. where
NB.   A - m×n-matrix, contains B
NB.   B - m×n-matrix, lower bidiagonal
NB.
NB. TODO:
NB. - B would be sparse

bdlpick=: * _1 0&mbstencil

NB. ---------------------------------------------------------
NB. bdupick
NB.
NB. Description:
NB.   Zeroize elements outside upper bidiagonal part of the
NB.   matrix
NB.
NB. Syntax:
NB.   B=. bdupick A
NB. where
NB.   A - m×n-matrix, contains B
NB.   B - m×n-matrix, upper bidiagonal
NB.
NB. TODO:
NB. - B would be sparse

bdupick=: * 0 1&mbstencil

NB. ---------------------------------------------------------
NB. hslpick
NB.
NB. Description:
NB.   Zeroize elements outside lower Hessenberg part of the
NB.   matrix
NB.
NB. Syntax:
NB.   B=. hslpick A
NB. where
NB.   A - m×n-matrix, contains B
NB.   B - m×n-matrix, lower Hessenberg

hslpick=: * __ 1&mbstencil

NB. ---------------------------------------------------------
NB. hsupick
NB.
NB. Description:
NB.   Zeroize elements outside upper Hessenberg part of the
NB.   matrix
NB.
NB. Syntax:
NB.   B=. hsupick A
NB. where
NB.   A - m×n-matrix, contains B
NB.   B - m×n-matrix, upper Hessenberg

hsupick=: * _1 _&mbstencil

NB. ---------------------------------------------------------
NB. gtpick
NB.
NB. Description:
NB.   Zeroize elements outside tridiagonal part of the matrix
NB.
NB. Syntax:
NB.   B=. gtpick A
NB. where
NB.   A - m×n-matrix, contains B
NB.   B - m×n-matrix, tridiagonal
NB.
NB. TODO:
NB. - B would be sparse

gtpick=: * _1 1&mbstencil

NB. ---------------------------------------------------------
NB. trlpick
NB.
NB. Description:
NB.   Zeroize elements outside lower triangular part of the
NB.   matrix
NB.
NB. Syntax:
NB.   B=. [d] trlpick A
NB. where
NB.   A - m×n-matrix, contains B
NB.   d - integer in range [-∞,+∞], lIO last non-zero
NB.       diagonal
NB.   B - m×n-matrix, lower triangular

trlpick=: (0&$:) : (((__ , [) mbstencil ]) * ])

NB. ---------------------------------------------------------
NB. trupick
NB.
NB. Description:
NB.   Zeroize elements outside upper triangular part of the
NB.   matrix
NB.
NB. Syntax:
NB.   B=. [d] trupick A
NB. where
NB.   A - m×n-matrix, contains B
NB.   d - integer in range [-∞,+∞], lIO first non-zero
NB.       diagonal
NB.   B - m×n-matrix, upper triangular

trupick=: (0&$:) : (((_ ,~ [) mbstencil ]) * ])

NB. ---------------------------------------------------------
NB. idmat
NB.
NB. Description:
NB.   Make identity matrix with units on solid part of
NB.   diagonal
NB.
NB. Syntax:
NB.   I=. [(d[,h[,s]])] idmat [m,]n
NB. where
NB.   m ≥ 0, integer, optional rows in matrix I, default is n
NB.   n ≥ 0, integer, columns in matrix I
NB.   d - integer in range [1-m,n-1], optional lIO diagonal,
NB.       default is 0 (main diagonal)
NB.   h - integer in range [-S,S-1], optional lIO extreme
NB.       element of solid part of diagonal, default is 0
NB.       (take from head)
NB.   s - integer in range [-S,S] or ±∞, optional size of
NB.       solid part of diagonal, default is +∞ (all elements
NB.       in forward direction)
NB.   I - m×n-matrix of zeros with unit assigned to solid
NB.       part of d-th diagonal
NB.   S ≥ 0, the length of d-th diagonal
NB.
NB. Examples:
NB.    idmat 3                      idmat 3 4
NB. 1 0 0                        1 0 0 0
NB. 0 1 0                        0 1 0 0
NB. 0 0 1                        0 0 1 0
NB.    1 idmat 3 4                  _1 idmat 3 4
NB. 0 1 0 0                      0 0 0 0
NB. 0 0 1 0                      1 0 0 0
NB. 0 0 0 1                      0 1 0 0
NB.
NB. TODO:
NB. - I would be sparse

idmat=: (a:&$:) :((1;[) setdiag (0 $~ 2 $ ]))

NB. ---------------------------------------------------------
NB. diagmat
NB.
NB. Description:
NB.   Make diagonal matrix
NB.
NB. Syntax:
NB.   D=. [(h,t)] diagmat e
NB. where
NB.   e - S-vector, new values for diagonal
NB.   h - integer in range [1-m,n-1], lIO diagonal of v's
NB.       head, relatively to top left corner, default is 0
NB.   t - integer in range [1-m,n-1], lIO diagonal of v's
NB.       tail, relatively to bottom right corner, default is
NB.       0
NB.   D - m×n-matrix of zeros with vector e assigned to h-th
NB.       diagonal
NB.   S ≥ 0, the length of h-th diagonal
NB.
NB. Algorithm:
NB.   1) find D shape
NB.   2) generate lIO h-th diagonal
NB.   3) write e into matrix of zeros
NB.
NB. Examples:
NB.    diagmat 3 5 7                0 0 diagmat 3 5 7
NB. 3 0 0                        3 0 0
NB. 0 5 0                        0 5 0
NB. 0 0 7                        0 0 7
NB.    1 0 diagmat 3 5 7            _1 0 diagmat 3 5 7
NB. 0 3 0 0                      0 0 0
NB. 0 0 5 0                      3 0 0
NB. 0 0 0 7                      0 5 0
NB.                              0 0 7
NB.    0 1 diagmat 3 5 7            0 _1 diagmat 3 5 7
NB. 3 0 0                        3 0 0 0
NB. 0 5 0                        0 5 0 0
NB. 0 0 7                        0 0 7 0
NB. 0 0 0
NB.
NB. TODO:
NB. - D would be sparse

diagmat=: (0 0&$:) :((; {.)~ setdiag ((0 $~ (+ (2&(|.@}. - {.)@(0&(<. , >.)))))~ #))

NB. ---------------------------------------------------------
NB. trl
NB.
NB. Description:
NB.   Extract lower triangular (trapezoidal) matrix with
NB.   optional shrinking
NB.
NB. Examples:
NB.    trl >: i. 3 4                0 trl >: i. 3 4
NB. 1  0  0                      1  0  0
NB. 5  6  0                      5  6  0
NB. 9 10 11                      9 10 11
NB.    1 trl >: i. 3 4              _1 trl >: i. 3 4
NB. 1  2  0  0                   5  0
NB. 5  6  7  0                   9 10
NB. 9 10 11 12
NB.    1 trl >: i. 4 3              _1 trl >: i. 4 3
NB.  1  2  0                      4  0  0
NB.  4  5  6                      7  8  0
NB.  7  8  9                     10 11 12
NB. 10 11 12

trl=: (>:~ 0&>.) tr trlcut

NB. ---------------------------------------------------------
NB. tru
NB.
NB. Description:
NB.   Extract upper triangular (trapezoidal) matrix with
NB.   optional shrinking
NB.
NB. Examples:
NB.    tru >: i. 3 4                0 tru >: i. 3 4
NB. 1 2  3  4                    1 2  3  4
NB. 0 6  7  8                    0 6  7  8
NB. 0 0 11 12                    0 0 11 12
NB.    1 tru >: i. 3 4              _1 tru >: i. 3 4
NB. 2 3  4                       1  2  3  4
NB. 0 7  8                       5  6  7  8
NB. 0 0 12                       0 10 11 12
NB.    1 tru >: i. 4 3              _1 tru >: i. 4 3
NB. 2 3                          1 2  3
NB. 0 6                          4 5  6
NB.                              0 8  9
NB.                              0 0 12

tru=: (<:~ 0&<.) tr trucut

NB. ---------------------------------------------------------
NB. trl0
NB.
NB. Description:
NB.   Extract strictly lower triangular (trapezoidal) matrix
NB.   with optional shrinking
NB.
NB. Examples:
NB.    trl0 >: i. 4 3               0 trl0 >: i. 4 3
NB.  0  0  0                      0  0  0
NB.  4  0  0                      4  0  0
NB.  7  8  0                      7  8  0
NB. 10 11 12                     10 11 12
NB.    1 trl0 >: i. 4 3             _1 trl0 >: i. 4 3
NB.  1  0  0                      0  0 0
NB.  4  5  0                      7  0 0
NB.  7  8  9                     10 11 0
NB. 10 11 12
NB.    1 trl0 >: i. 3 4             _1 trl0 >: i. 3 4
NB. 1  0  0 0                    0 0
NB. 5  6  0 0                    9 0
NB. 9 10 11 0

trl0=: (>~ 0&>.) tr trlcut

NB. ---------------------------------------------------------
NB. tru0
NB.
NB. Description:
NB.   Extract strictly upper triangular (trapezoidal) matrix
NB.   with optional shrinking
NB.
NB. Examples:
NB.    tru0 >: i. 3 4               0 tru0 >: i. 3 4
NB. 0 2 3  4                     0 2 3  4
NB. 0 0 7  8                     0 0 7  8
NB. 0 0 0 12                     0 0 0 12
NB.    1 tru0 >: i. 3 4             _1 tru0 >: i. 3 4
NB. 0 3 4                        1 2  3  4
NB. 0 0 8                        0 6  7  8
NB. 0 0 0                        0 0 11 12
NB.    1 tru0 >: i. 4 3             _1 tru0 >: i. 4 3
NB. 0 3                          1 2 3
NB. 0 0                          0 5 6
NB.                              0 0 9
NB.                              0 0 0

tru0=: (<~ 0&<.) tr trucut

NB. ---------------------------------------------------------
NB. trl1
NB.
NB. Description:
NB.   Extract unit lower triangular (trapezoidal) matrix with
NB.   optional shrinking
NB.
NB. Examples:
NB.    trl1 >: i. 4 3               0 trl1 >: i. 4 3
NB.  1  0  0                      1  0  0
NB.  4  1  0                      4  1  0
NB.  7  8  1                      7  8  1
NB. 10 11 12                     10 11 12
NB.    1 trl1 >: i. 4 3             _1 trl1 >: i. 4 3
NB.  1  1  0                      1  0 0
NB.  4  5  1                      7  1 0
NB.  7  8  9                     10 11 1
NB. 10 11 12
NB.    1 trl1 >: i. 3 4             _1 trl1 >: i. 3 4
NB. 1  1  0 0                    1 0
NB. 5  6  1 0                    9 1
NB. 9 10 11 1

trl1=: (0&$:) :([ trl (1;[) setdiag ])

NB. ---------------------------------------------------------
NB. tru1
NB.
NB. Description:
NB.   Extract unit upper triangular (trapezoidal) matrix with
NB.   optional shrinking
NB.
NB. Examples:
NB.    tru1 >: i. 3 4               0 tru1 >: i. 3 4
NB. 1 2 3  4                     1 2 3  4
NB. 0 1 7  8                     0 1 7  8
NB. 0 0 1 12                     0 0 1 12
NB.    1 tru1 >: i. 3 4             _1 tru1 >: i. 3 4
NB. 1 3 4                        1 2  3  4
NB. 0 1 8                        1 6  7  8
NB. 0 0 1                        0 1 11 12
NB.    1 tru1 >: i. 4 3             _1 tru1 >: i. 4 3
NB. 1 3                          1 2 3
NB. 0 1                          1 5 6
NB.                              0 1 9
NB.                              0 0 1

tru1=: (0&$:) :([ tru (1;[) setdiag ])

NB. ---------------------------------------------------------
NB. tr2he
NB.
NB. Description:
NB.   Make Hermitian (symmetric) matrix from lower or upper
NB.   triangular one
NB.
NB. Syntax:
NB.   H=. tr2he T
NB. where
NB.   T - n×n-matrix, lower or upper triangular
NB.   H - n×n-matrix, Hermitian (symmetric)

tr2he=: (-: upddiag)@(+ ct)

NB. ---------------------------------------------------------
NB. he
NB.
NB. Description:
NB.   Make Hermitian (symmetric) matrix from lower triangle
NB.   of general square one
NB.
NB. Syntax:
NB.   H=. he G
NB. where
NB.   G - n×n-matrix
NB.   H - n×n-matrix, Hermitian (symmetric)

he=: tr2he@trl

NB. ---------------------------------------------------------
NB. po
NB.
NB. Description:
NB.   Make Hermitian (symmetric) positive definite matrix
NB.   from general square invertible one
NB.
NB. Syntax:
NB.   P=. po G
NB. where
NB.   G - n×n-matrix, invertible
NB.   H - n×n-matrix, Hermitian (symmetric)

po=: mp ct
