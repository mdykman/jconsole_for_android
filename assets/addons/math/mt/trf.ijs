NB. Triangular factorization
NB.
NB. getrfxxxx  Triangular factorization with partial pivoting
NB.            of a general matrix
NB. hetrfpx    Triangular factorization with full pivoting of
NB.            a Hermitian (symmetric) matrix
NB. potrfx     Cholesky factorization of a Hermitian
NB.            (symmetric) positive definite matrix
NB. pttrfx     Triangular factorization of a Hermitian
NB.            (symmetric) positive definite tridiagonal
NB.            matrix
NB.
NB. testgetrf  Test getrfxxxx by general matrix given
NB. testhetrf  Test hetrfpx by Hermitian (symmetric) matrix
NB.            given
NB. testpotrf  Test potrfx by Hermitian (symmetric) positive
NB.            definite matrix given
NB. testpttrf  Test pttrfx by Hermitian (symmetric) positive
NB.            definite tridiagonal matrix given
NB. testtrf    Adv. to make verb to test xxtrfxxxx by matrix
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
NB. Blocked code constants

TRFNB=: 64  NB. block size limit, >0

NB. ---------------------------------------------------------
NB. lahefpl
NB.
NB. Description:
NB.   Partial triangular factorization of a Hermitian
NB.   (symmetric) matrix:
NB.     subP * subL1 * subT * subL1^H * subP^H = subA
NB.   using the combination of Parlett and Reid, and Aasen
NB.   methods [1].
NB.
NB. Syntax:
NB.   'ipo B lto t0o t1o'=. lahefpl ipi;subA;lti;t0i;t1i
NB. where
NB.   ipi       -: i. (n-i)
NB.   subA      - (n-i)×(n-i)-matrix to factorize, Hermitian
NB.               (symmetric), the bottom right part of A
NB.   lti       - (n-i)-vector, is defined as:
NB.                 lti=. ti 0 } li
NB.   t0i       - i-vector, float, leading elements of main
NB.               diagonal of T
NB.   t1i       - max(0,min(i,n-1))-vector, leading elements
NB.               of subdiagonal of T
NB.   ipo       - (n-i)-vector of integers, inversed full
NB.               permutation, corresponding to subP
NB.   B         - (n-i)×(n-i)-matrix, contains subL110,
NB.               subH10^H, strict lower triangle of subL100,
NB.               strict upper triangle of subH00^H, and
NB.               subA11upd (see layout 1 below)
NB.   lto       - max(0,n-i-TRFNB)-vector, aimed to be lti at
NB.               the next call from hetrfpl
NB.   t0o       - min(n,i+TRFNB)-vector, float, leading
NB.               elements of main diagonal of T
NB.   t1o       - min(n-1,i+TRFNB)-vector, leading elements
NB.               of subdiagonal of T
NB.   li        - (n-i)-vector, the 1st scaled column of
NB.               subL1, having 1 in the 1st element
NB.   ti        - scalar, the max from li before it was
NB.               scaled, can be any value when i=0
NB.   subL100   - min(TRFNB,n-i)×min(TRFNB,n-i)-matrix, unit
NB.               lower triangular, top left part of subL1
NB.   subL110   - max(0,n-i-TRFNB)×min(TRFNB,n-i)-matrix,
NB.               bottom left part of subL1
NB.   subH00    - min(TRFNB,n-i)×min(TRFNB,n-i)-matrix, lower
NB.               Hessenberg, top left part of subH
NB.   subH10    - max(0,n-i-TRFNB)×min(TRFNB,n-i)-matrix,
NB.               bottom left part of subH
NB.   subA11upd - max(0,n-i-TRFNB)×max(0,n-i-TRFNB), not yet
NB.               factored bottom right part of subA
NB.   subP      - (n-i)×(n-i)-matrix, boolean, full
NB.               permutation of subA
NB.   subL1     - (n-i)×(n-i)-matrix, unit lower triangular,
NB.               being columns i:min(i+TRFNB,n) of L1
NB.   subH      - (n-i)×(n-i)-matrix, lower Hessenberg, is
NB.               defined as:
NB.                 subH=. subL1 mp subT
NB.   subT      - (n-i)×(n-i)-matrix, Hermitian (symmetric)
NB.               tridiagonal, being bottom right part of T
NB.   i         - integer from set:
NB.                 {(0:⌈n/TRFNB⌉)*TRFNB} ,
NB.               lIO subA's 1st row and column within A
NB.   A         - n×n-matrix, Hermitian (symmetric)
NB.   L1        - n×n-matrix, unit lower triangular
NB.   T         - n×n-matrix, Hermitian (symmetric)
NB.               tridiagonal
NB.
NB. Storage layout 1 (assume TRFNB<n):
NB.   input subA:                      output B:
NB.     ( subA00 subA10^H ) TRFNB        ( subL100H00h subH10^H  ) TRFNB
NB.     ( subA10 subA11   ) n-i-TRFNB    ( subL110     subA11upd ) n-i-TRFNB
NB.       TRFNB  n-i-TRFNB                 TRFNB       n-i-TRFNB
NB. where
NB.   subL100H00h - TRFNB×TRFNB-matrix, combined strict lower
NB.                 triangle of L100, and strict upper
NB.                 triangle of subH00^H, diagonal is
NB.                 undefined
NB.
NB. Example for output B when TRFNB=2, n=5:
NB.   ( *    h00h h10h h10h h10h )
NB.   ( l100 *    h10h h10h h10h )
NB.   ( l110 l110 a11u a11u a11u )
NB.   ( l110 l110 a11u a11u a11u )
NB.   ( l110 l110 a11u a11u a11u )
NB. where
NB.   *         - value is undefined
NB.   l100,l110 - elements of 1st TRFNB columns of subL1
NB.   l100      - elements of subL100
NB.   l110      - elements of subL110
NB.   h00h,h10h - elements of 1st TRFNB rows of subH^H
NB.   h00h      - elements of subH00^H
NB.   h10h      - elements of subH10^H
NB.   a11u      - elements of subA11upd
NB.
NB. Storage layout 2 (assume TRFNB<n):
NB.   IOS from head:                 IOS from tail:
NB.     ipi      subA     lti          ipi          subA         lti
NB.     0        0                     -(n-i)       -(n-i)
NB.     ...      ...                   ...          ...
NB.   * j        j        0            -(n-i-j)     -(n-i-j)     -(n-i-j)
NB.     ...      ...      ...          ...          ...          ...
NB.   * j+p      j+p      p            p-(n-i-j)    p-(n-i-j)    p-(n-i-j)
NB.     ...      ...      ...          ...          ...          ...
NB.     n-i-1    n-i-1    n-i-j-1      -1           -1           -1
NB. where
NB.   ipi  - (n-i)-vector
NB.   subA - (n-i)×(n-i)-matrix
NB.   lti  - (n-i-j)-vector
NB.   j    - integer in range 0:TRFNB-1
NB.   *    - marked elements to be permuted
NB.
NB. Algorithm (assume 0<i<n-TRFNB):
NB.   In:
NB.     ipi  -: i. (n-i)
NB.     subA - A[i:n-1,i:n-1]
NB.     lti  -: ti 0 } li
NB.     t0i  - (T[0,0],T[1,1],...,T[i-1,i-1])
NB.     t1i  - (T[1,0],T[2,1],...,T[i,i-1])
NB.     li   - vector to write into subL1[0:n-i-1,0] i.e.
NB.            L1[i:n-1,i]
NB.     ti   - any scalar
NB.   Out:
NB.     ipo  - ip[i:n-1]
NB.     B    - see layout 1
NB.     lto  -: to 0 } lo
NB.     t0o  - (T[0,0],T[1,1],...,T[i+TRFNB-1,i+TRFNB-1]) =
NB.            (t0i[0],t0i[1],...,t0i[i-1],subT[0,0],subT[1,1],...,subT[TRFNB-1,TRFNB-1])
NB.     t1o  - (T[1,0],T[2,1],...,T[i+TRFNB,i+TRFNB-1]) =
NB.            (t1i[0],t1i[1],...,t1i[i-1],subT[1,0],subT[2,1],...,subT[TRFNB,TRFNB-1])
NB.     lo   - vector to write into subL1[TRFNB:n-i-1,TRFNB]
NB.            i.e. L1[i+TRFNB:n-1,i+TRFNB]
NB.     to   -: T[i+TRFNB+1,i+TRFNB]
NB.   1) count amount of iterations to do:
NB.        J := min(TRFNB,n-i)
NB.   2) do iterations j=0:J-1 :
NB.      2.1) reconstruct (subH[j:n-i-1,j])^H, the tail part
NB.           of conjugated j-th column of subH:
NB.             w := conj(subH[j:n-i-1,j]) :=
NB.               := subA[j,j:n-i-1] - subL1[j,0:j-1]*(subH[j:n-i-1,0:j-1])^H ,
NB.           note1: following omitted steps will reconstruct
NB.                  full subH[0:n-i-1,j] (for j>0 only):
NB.                    subH[0:j-2,j] := 0
NB.                    subH[j-1,j]   := subT[j,j-1]
NB.           note2: both vectors used are the only two parts
NB.                  of subA j-th row, matrix used is located
NB.                  above tail part
NB.      2.2) batch write w and lti into subA:
NB.             subA[j,j:n-i-1] := w
NB.             subA[j:n-i-1,j] := lti
NB.           note: heads of both w and lti will be writed in
NB.                 the same place in the subA main diagonal,
NB.                 so resulting value will be undefined, btw
NB.                 it won't be used
NB.      2.3) try to update w:
NB.             w    := w - subT[j,j-1] * conj(subL1[j:n-i-1,j-1])
NB.             w[0] := Re(w[0])
NB.           note: now w[0] contains T[j,j], which must be
NB.                 real
NB.           2.3.1) if failed (i.e. if j=0) then leave w
NB.                  unchanged:
NB.                    w := w - 0
NB.      2.4) build new non-transposed non-scaled lti:
NB.             lti := conj(w[1:]) - subL1[j+1:n-i-1,j]*T[j,j]
NB.      2.5) prepare non-standard transposition dip:
NB.           2.5.1) find lIO 1st element with max value:
NB.                    p := liofmax lti
NB.                  note: to force L1 to be truly diagonally
NB.                        dominant replace sorim by soris in
NB.                        liofmax definition
NB.           2.5.2) remap lIOS to measure from tail, making
NB.                  possible to apply the same dip to arrays
NB.                  of different lengths (see layout 2):
NB.                    dip := (-(n-i-j),p-(n-i-j))
NB.           note: don't waste time for standardizing the
NB.                 transposition, use Adverse (::) later
NB.                 instead
NB.      2.6) try to apply the transposition dip to ipi:
NB.             ipi[dip[0]] ↔ ipi[dip[1]]
NB.           2.6.1) if failed (i.e. if p=0), then leave ipi
NB.                  unchanged
NB.      2.7) try to apply the transposition dip to rows and
NB.           columns of subA:
NB.             subA[dip[0],:] ↔ subA[dip[1],:]
NB.             subA[:,dip[0]] ↔ subA[:,dip[1]]
NB.           2.7.1) if failed (i.e. if p=0), then leave subA
NB.                  unchanged
NB.      2.8) try to apply the transposition dip to lti:
NB.             lti[dip[0]] ↔ lti[dip[1]]
NB.           note: now lti[0] contains T[j+1,j]
NB.           2.8.1) if failed (i.e. if p=0), then leave lti
NB.                  unchanged
NB.      2.9) try to scale lti by head, leaving head itself
NB.           unchanged:
NB.             lti[1:] := lti / lti[0]
NB.           note: now lti[1:] contains subL1[j+1:n-i-1,j+1]
NB.                 i.e. L1[i+j+1:n-1,i+j+1]
NB.           2.9.1) if failed (i.e. if i+j=n-1 , the last
NB.                  iteration in the last partition takes
NB.                  place, and lti is empty vector), then
NB.                  leave lti unchanged
NB.      2.10) update t0i by appending subT[j,j]:
NB.              t0i := t0i , T[j,j]
NB.      2.11) try to update t1i by appending subT[j+1,j]):
NB.              t1i := t1i , T[j+1,j]
NB.            2.11.1) if failed (i.e. if i+j=n-1 , the last
NB.                    iteration in the last partition takes
NB.                    place, and lti is empty vector), then
NB.                    leave t1i unchanged
NB.      2.12) link modified arrays to form output of current
NB.            iteration and input for next one:
NB.              ipi ; subA ; lti ; t0i ; t1i
NB.   3) use output from the last iteration as algorithm's
NB.      output
NB.
NB. Notes:
NB. - for n>TRFNB is similar to LAPACK's DLASYF('L') and
NB.   ZLAHEF('L'), but uses another factorization
NB. - for n<:TRFNB is similar to LAPACK's DSYTF2('L') and
NB.   ZHETF2('L'), but uses another factorization
NB. - diagonals 0 and 1 of subH (main diagonal and
NB.   subdiagonal of subH^H) aren't reconstructed since
NB.   aren't used
NB.
NB. References:
NB. [1] Miroslav Rozloznik, Gil Shklarski, Sivan Toledo.
NB.     Partitioned triangular tridiagonalization.
NB.     26 September 2007.
NB.     http://www.cs.cas.cz/miro/rst08.pdf

lahefpl=: (3 : 0)^:(TRFNB<.#@(0&{::))
  'ip A lt t0 t1'=. y
  w=. lt ((-~&# { ]) ((}.~ #) - ({.~ #) mp ]) ((-~,-@[)&# {. ])) A
  A=. (w,:lt) ((0 liosE),:(0 liosS))&c } A
  w=. 0 (9&o.) upd w - lt (({.@[ * +@((_1 liosS)&# ({,) ])) :: 0:) A
  lt=. lt (+@}.@] - ((* }.)~ {.)) w
  dip=. (liofmax (-@] <@, -) #) lt
  ip=. dip C. :: ] ip
  A=. dip fp :: ] A
  lt=. dip C. :: ] lt
  lt=. 0 ({`[`(] % {))} :: ] lt
  t0=. t0 , {. w
  t1=. t1 , 0 { :: ] lt
  ip ; A ; lt ; t0 ; t1
)

NB. ---------------------------------------------------------
NB. lahefpu
NB.
NB. Description:
NB.   Partial triangular factorization of a Hermitian
NB.   (symmetric) matrix:
NB.     subP * subU1 * subT * subU1^H * subP^H = subA
NB.   using the combination of Parlett and Reid, and Aasen
NB.   methods, inspired by [1].
NB.
NB. Syntax:
NB.   'ipo B uto t0o t1o'=. lahefpu ipi;subA;uti;t0i;t1i
NB. where
NB.   ipi       -: i. (n+i+1)
NB.   subA      - (n+i+1)×(n+i+1)-matrix to factorize,
NB.               Hermitian (symmetric), the top left part of
NB.               A
NB.   uti       - (n+i+1)-vector, is defined as:
NB.                 uti=. ti _1 } ui
NB.   t0i       - (i+1)-vector, float, tail elements of main
NB.               diagonal of T
NB.   t1i       - max(0,min(i+1,n-1))-vector, tail elements
NB.               of superdiagonal of T
NB.   ipo       - (n+i+1)-vector of integers, inversed full
NB.               permutation, corresponding to subP
NB.   B         - (n+i+1)×(n+i+1)-matrix, contains subU101,
NB.               subH01^H, strict upper triangle of subU111,
NB.               strict lower triangle of subH11^H, and
NB.               subA00upd (see layout 1 below)
NB.   uto       - max(0,n+i+1-TRFNB)-vector, aimed to be uti
NB.               at the next call from hetrfpu
NB.   t0o       - min(n,i+1+TRFNB)-vector, float, tail
NB.               elements of main diagonal of T
NB.   t1o       - min(n-1,i+1+TRFNB)-vector, tail elements of
NB.               superdiagonal of T
NB.   ui        - (n+i+1)-vector, the last scaled column of
NB.               subU1, having 1 in the last element
NB.   ti        - scalar, the max from ui before it was
NB.               scaled, can be any value when i=_1
NB.   subU111   - min(TRFNB,n+i+1)×min(TRFNB,n+i+1)-matrix,
NB.               unit upper triangular, bottom right part of
NB.               subU1
NB.   subU101   - max(0,n+i+1-TRFNB)×min(TRFNB,n+i+1)-matrix,
NB.               top right part of subU1
NB.   subH11    - min(TRFNB,n+i+1)×min(TRFNB,n+i+1)-matrix,
NB.               upper Hessenberg, bottom right part of subH
NB.   subH01    - max(0,n+i+1-TRFNB)×min(TRFNB,n+i+1)-matrix,
NB.               top right part of subH
NB.   subA00upd - max(0,n+i+1-TRFNB)×max(0,n+i+1-TRFNB), not
NB.               yet factored top left part of subA
NB.   subP      - (n+i+1)×(n+i+1)-matrix, boolean, full
NB.               permutation of subA
NB.   subU1     - (n+i+1)×(n+i+1)-matrix, unit upper
NB.               triangular, being columns 0:n+i of U1
NB.   subH      - (n+i+1)×(n+i+1)-matrix, upper Hessenberg,
NB.               is defined as:
NB.                 subH=. subU1 mp subT
NB.   subT      - (n+i+1)×(n+i+1)-matrix, Hermitian
NB.               (symmetric) tridiagonal, being top left
NB.               part of T
NB.   i         - integer from set:
NB.                 {_1-(0:⌈n/TRFNB⌉)*TRFNB},
NB.               lIO subA's last row and column within A
NB.   A         - n×n-matrix, Hermitian (symmetric)
NB.   U1        - n×n-matrix, unit upper triangular
NB.   T         - n×n-matrix, Hermitian (symmetric)
NB.               tridiagonal
NB.
NB. Storage layout 1 (assume TRFNB<n):
NB.   input subA:                         output B:
NB.     ( subA00    subA10^H ) n+i-TRFNB    ( subA00upd subU101     ) n+i-TRFNB
NB.     ( subA10    subA11   ) TRFNB        ( subH01^H  subU111H11h ) TRFNB
NB.       n+i-TRFNB TRFNB                     n+i-TRFNB TRFNB
NB. where
NB.   subU111H11h - TRFNB×TRFNB-matrix, combined strict upper
NB.                 triangle of U111, and strict lower
NB.                 triangle of subH11^H, diagonal is
NB.                 undefined
NB.
NB. Example for output B when TRFNB=2, n=5:
NB.   ( a00u a00u a00u u101 u101 )
NB.   ( a00u a00u a00u u101 u101 )
NB.   ( a00u a00u a00u u101 u101 )
NB.   ( h01h h01h h01h *    u111 )
NB.   ( h01h h01h h01h h11h *    )
NB. where
NB.   *         - value is undefined
NB.   u101,u111 - elements of last TRFNB columns of subU1
NB.   u101      - elements of subU101
NB.   u111      - elements of subU111
NB.   h01h,h11h - elements of last TRFNB rows of subH^H
NB.   h01h      - elements of subH01^H
NB.   h11h      - elements of subH11^H
NB.   a00u      - elements of subA00upd
NB.
NB. Storage layout 2 (assume TRFNB<n):
NB.   IOS from head:
NB.     ipi      subA     uti
NB.     0        0        0
NB.     ...      ...      ...
NB.   * p        p        p
NB.     ...      ...      ...
NB.   * n-i-j-1  n-i-j-1  n-i-j-1
NB.     ...      ...
NB.     n-i-1    n-i-1
NB. where
NB.   ipi  - (n-i)-vector
NB.   subA - (n-i)×(n-i)-matrix
NB.   uti  - (n-i-j)-vector
NB.   j    - integer in range 0:TRFNB-1
NB.   *    - marked elements to be permuted
NB.
NB. Algorithm (assume TRFNB-n-1<i<-1):
NB.   In:
NB.     ipi  -: i. (n+i+1)
NB.     subA - A[0:n+i,0:n+i]
NB.     uti  -: ti _1 } ui
NB.     t0i  - (T[n+i+1,n+i+1],T[n+i+2,n+i+2],...,T[n-1,n-1])
NB.     t1i  - (T[n+i,n+i+1],T[n+i+1,n+i+2],...,T[n-2,n-1])
NB.     ui   - vector to write into subU1[0:n+i,n+i] i.e.
NB.            U1[0:n+i,n+i]
NB.     ti   - any scalar
NB.   Out:
NB.     ipo  - ip[0:n+i]
NB.     B    - see layout
NB.     uto  -: to _1 } uo
NB.     t0o  - (T[n+i-TRFNB+1,n+i-TRFNB+1],T[n+i-TRFNB+2,n+i-TRFNB+2],...,T[n-1,n-1]) =
NB.            (subT[0,0],subT[1,1],...,subT[TRFNB-1,TRFNB-1],t0i[0],t0i[1],...,t0i[-i-2])
NB.     t1o  - (T[n+i-TRFNB,n+i-TRFNB+1],T[n+i-TRFNB+1,n+i-TRFNB+2],...,T[n-2,n-1]) =
NB.            (subT[0,1],subT[1,2],...,subT[TRFNB-1,TRFNB],t1i[0],t1i[1],...,t1i[-i-2])
NB.     uo   - vector to write into subU1[0:n+i-TRFNB,n+i-TRFNB]
NB.            i.e. U1[0:n+i-TRFNB,n+i-TRFNB]
NB.     to   -: T[n+i-TRFNB-1,n+i-TRFNB]
NB.   1) count amount of iterations to do:
NB.        J := min(TRFNB,n+i+1)
NB.   2) do iterations j={n+i,n+i-1,...,n+i-J+1}:
NB.      2.1) reconstruct (subH[0:j,j])^H, the head part
NB.           of conjugated j-th column of subH:
NB.             w := conj(subH[0:j,j]) :=
NB.               := subA[j,0:j] - subU1[j,j+1:n-i]*(subH[0:j,j+1:n-i])^H ,
NB.           note1: following omitted steps will reconstruct
NB.                  full subH[0:n+i+1,j] (for j<n+i only):
NB.                    subH[j+1,j]       := subT[j-1,j]
NB.                    subH[j+2:n+i+1,j] := 0
NB.           note2: both vectors used are the only two parts
NB.                  of subA j-th row, matrix used is located
NB.                  below head part
NB.      2.2) batch write uti and w into subA:
NB.             subA[0:j,j] := uti
NB.             subA[j,0:j] := w
NB.           note: tails of both uti and w will be writed in
NB.                 the same place in the subA main diagonal,
NB.                 so resulting value will be undefined, btw
NB.                 it won't be used
NB.      2.3) try to update w:
NB.             w    := w - subT[j-1,j] * conj(subU1[0:j,j+1])
NB.             w[j] := Re(w[j])
NB.           note: now w[j] contains T[j,j], which must be
NB.                 real
NB.           2.3.1) if failed (i.e. if j=n+i-J) then leave w
NB.                  unchanged:
NB.                    w := w - 0
NB.      2.4) build new non-transposed non-scaled uti:
NB.             uti := conj(w[0:j-1]) - subU1[0:j-1,j]*T[j,j]
NB.      2.5) prepare non-standard transposition dip:
NB.           2.5.1) find lIO last element with max value:
NB.                    p := liolmax uti
NB.                  note: to force U1 to be truly diagonally
NB.                        dominant replace sorim by soris in
NB.                        liolmax definition
NB.           2.5.2) form lIOS to measure from head, making
NB.                  possible to apply the same dip to arrays
NB.                  of different lengths (see layout 2):
NB.                    dip := (n-i-j-1,p)
NB.           note: don't waste time for standardizing the
NB.                 transposition, use Adverse (::) later
NB.                 instead
NB.      2.6) try to apply the transposition dip to ipi:
NB.             ipi[dip[0]] ↔ ipi[dip[1]]
NB.           2.6.1) if failed (i.e. if p=n-i-j-1), then
NB.                  leave ipi unchanged
NB.      2.7) try to apply the transposition dip to rows and
NB.           columns of subA:
NB.             subA[dip[0],:] ↔ subA[dip[1],:]
NB.             subA[:,dip[0]] ↔ subA[:,dip[1]]
NB.           2.7.1) if failed (i.e. if p=n-i-j-1), then
NB.                  leave subA unchanged
NB.      2.8) try to apply the transposition dip to uti:
NB.             uti[dip[0]] ↔ uti[dip[1]]
NB.           note: now uti[j] contains T[j,j+1]
NB.           2.8.1) if failed (i.e. if p=n-i-j-1), then
NB.                  leave uti unchanged
NB.      2.9) try to scale uti by tail, leaving tail itself
NB.           unchanged:
NB.             uti[0:j-2] := uti / uti[j-1]
NB.           note: now uti[0:j-2] contains subU1[0:j-2,j-1]
NB.                 i.e. U1[0:j-2,j-1]
NB.           2.9.1) if failed (i.e. if j=0 , the last
NB.                  iteration in the last partition takes
NB.                  place, and uti is empty vector), then
NB.                  leave uti unchanged
NB.      2.10) update t0i by prepending subT[j,j]:
NB.              t0i := T[j,j] , t0i
NB.      2.11) try to update t1i by prepending subT[j,j+1]):
NB.              t1i := T[j,j+1] , t1i
NB.            2.11.1) if failed (i.e. if j=0 , the last
NB.                    iteration in the last partition takes
NB.                    place, and uti is empty vector), then
NB.                    leave t1i unchanged
NB.      2.12) link modified arrays to form output of current
NB.            iteration and input for next one:
NB.              ipi ; subA ; uti ; t0i ; t1i
NB.   3) use output from the last iteration as algorithm's
NB.      output
NB.
NB. Notes:
NB. - diagonals 0 and _1 of subH (main diagonal and
NB.   superdiagonal of subH^H) aren't reconstructed since
NB.   aren't used
NB.
NB. References:
NB. [1] Miroslav Rozloznik, Gil Shklarski, Sivan Toledo.
NB.     Partitioned triangular tridiagonalization.
NB.     26 September 2007.
NB.     http://www.cs.cas.cz/miro/rst08.pdf

lahefpu=: (3 : 0)^:(TRFNB<.#@(0&{::))
  'ip A ut t0 t1'=. y
  w=. ut ((<:@-&# { ]) (({.~ c) - (}.~ c) mp ]) ((-,[)&# {. ])) A
  A=. (ut,:w) ((0 liosN),:(0 liosW))&c } A
  w=. _1 (9&o.) upd w - ut (({:@[ * +@((1 liosN)&# ({,) ])) :: 0:) A
  ut=. ut (+@}:@] - ((* }:)~ {:)) w
  dip=. (<:@(1>.#) <@, liolmax) ut
  ip=. dip C. :: ] ip
  A=. dip fp :: ] A
  ut=. dip C. :: ] ut
  ut=. _1 ({`[`(] % {))} :: ] ut
  t0=. ({: w) , t0
  t1=. (_1 { :: ] ut) , t1
  ip ; A ; ut ; t0 ; t1
)

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. getrflu1p
NB.
NB. Description:
NB.   Triangular factorization with partial pivoting of a
NB.   general matrix:
NB.     L * U1 * P = A
NB.
NB. Syntax:
NB.     'ip LU1'=. getrflu1p A
NB. where
NB.   A   - m×n-matrix to factorize
NB.   ip  - n-vector, columns inversed permutation of A
NB.   LU1 - m×n-matrix, lower triangle contains L, and strict
NB.         upper triangle contains U1 without unit diagonal
NB.   P   - n×n-matrix, columns permutation of A
NB.   L   - m×min(m,n)-matrix, lower triangular
NB.   U1  - min(m,n)×n-matrix, unit upper triangular
NB.
NB. Storage layout:
NB.   A's partitioning:                       L's partitioning:
NB.     k   ( Aaa  Aab  ) := ( Aa  ) := A       k   ( Laa             ) := L
NB.     m-k ( Aba  Abb  )    ( Ab  )            m-k ( Lba     Lbb     )
NB.           k    n-k         n                      k       n-k
NB.   U1's partitioning:                      LU1's partitioning:
NB.     k   ( U1aa U1ab ) := ( U1a ) := U1      k   ( LaaU1aa U1ab    ) := LU1
NB.     m-k (      U1bb )    ( U1b )            m-k ( Lba     LbbU1bb )
NB.           k    n-k         n                      k       n-k
NB. where
NB.   LaaU1aa - combined Laa and U1aa, U1aa's unit diagonal
NB.             isn't stored
NB.   LbbU1bb - combined Lbb and U1bb, U1bb's unit diagonal
NB.             isn't stored
NB.
NB. Algorithm:
NB.   In: A
NB.   Out: ip LU1
NB.   1) acquire geometry of A:
NB.        sh := shape
NB.        m  := quantity of rows
NB.        n  := quantity of columns
NB.   2) if m=0 or n=0 then:
NB.      2.1) set output:
NB.             ip  := i. n
NB.             LU1 := A
NB.   3) elseif m=1 then:
NB.      3.1) prepare non-standard transposition dip:
NB.           3.1.1) find lIO 1st element with max value in
NB.                  1st row of A:
NB.                    p := liofmax A[0,:]
NB.                  note: to force U1 to be truly diagonally
NB.                        dominant replace sorim by soris in
NB.                        liofmax definition
NB.           3.1.2) compose non-standard transposition:
NB.                    dip := (0,p)
NB.           note: don't waste time for standardizing the
NB.                 transposition, use Adverse (::) later
NB.                 instead
NB.      3.2) prepare ip:
NB.           3.2.1) init ip:
NB.                    ip=. i. n
NB.           3.2.2) try to apply the transposition dip to
NB.                  ip:
NB.                    ip[0] ↔ ip[p]
NB.           3.2.3) if failed (i.e. if p=0), then leave ip
NB.                  unchanged
NB.      3.3) prepare LU1:
NB.           3.3.1) try to apply the transposition dip to
NB.                  columns of A:
NB.                    A[:,0] ↔ A[:,p]
NB.           3.3.2) if failed (i.e. if p=0), then leave A
NB.                  unchanged
NB.           3.3.3) factorize single row:
NB.                    L  := A[0,0]
NB.                    U1 := L^_1 * A
NB.   4) else:
NB.      4.1) find split point:
NB.             k := min(n,⌈m/2⌉)
NB.      4.2) factorize Aa recursively:
NB.             Laa * U1a * P = Aa
NB.           note1: P is represented by vector of inversed
NB.                 permutation ip
NB.           note2: Laa and U1a are stored in the same
NB.                  matrix LaaU1a, U1a's unit diagonal isn't
NB.                  stored
NB.      4.3) permute columns of Ab according to P^H :
NB.             Ab := Ab * P^H
NB.           note: purge original A, reuse name 'y' to
NB.                 store Ab
NB.      4.4) compute Lba:
NB.           4.4.1) extract LaaU1aa:
NB.                    LaaU1aa := LaaU1a[:,0:k-1]
NB.           4.4.2) extract Aba:
NB.                    Aba := Ab[:,0:k-1]
NB.           4.4.3) solve:
NB.                    Lba * U1aa = Aba
NB.      4.5) update and factorize Abb recursively:
NB.           4.5.1) extract Abb:
NB.                    Abb := Ab[k:n-1,:]
NB.           4.5.2) extract U1ab:
NB.                    U1ab := LaaU1a[k:n-1,:]
NB.           4.5.3) update Abb:
NB.                    Abb := Abb - Lba * U1ab
NB.           4.5.4) factorize Abb recursively:
NB.                    Lbb * U1bb * Pb = Abb
NB.                  note: Pb is represented by vector of
NB.                        inversed permutation ipb
NB.      4.6) prepare delta of inversed permutation dipb,
NB.           which defines inversed permutation of tail part
NB.      4.7) assemble output
NB.           4.7.1) permute tail part of ip according to
NB.                  Pb^H :
NB.                    ip[k:n-1] := Pb^H * ip[k:n-1]
NB.           4.7.2) permute columns of U1ab according to
NB.                  Pb^H :
NB.                    U1ab := U1ab * Pb^H
NB.           4.7.3) assemble triangular matrices L and U1
NB.
NB. Assertions:
NB.   P -: %. iP
NB.   P -: |: iP
NB.   P -: ip2P ip
NB.   A -: clean p {"1 L mp U1
NB.   A -: clean p C."1 L mp U1
NB.   A -: clean ip C.^:_1"1 L mp U1
NB.   A -: clean L mp U1 mp iP         NB. apply p to columns
NB. where
NB.   'ip LU1'=. getrflu1p A
NB.   p=. /: ip
NB.   iP=. p2P ip
NB.   P=. p2P p
NB.   L=. trl LU1
NB.   U1=. tru1 LU1

getrflu1p=: 3 : 0
  'm n'=. sh=. $ y
  if. 0 e. sh do.
    (i. n) ; y
  elseif. 1=m do.
    dip=. < 0 , liofmax {. y
    ip=. dip C. :: ] i. n
    y=. ((] 0:} %) 0&({,)) dip C."1 :: ] y
    ip ; y
  elseif. do.
    k=. n (<. >.@-:) m
    'ip LaaU1a'=. getrflu1p k {. y
    y=. ip (C."1) k }. y
    Lba=. LaaU1a trsmxu1&(k&({."1)) y
    'ipb LbbU1bb'=. getrflu1p y (- Lba&mp)&(k&(}."1)) LaaU1a
    dipb=. (i. k) , (k + ipb)
    (dipb C. ip) ; (dipb C."1 LaaU1a) , (Lba ,. LbbU1bb)
  end.
)

NB. ---------------------------------------------------------
NB. getrfpl1u
NB.
NB. Description:
NB.   Triangular factorization with partial pivoting of a
NB.   general matrix:
NB.     P * L1 * U = A
NB.
NB. Syntax:
NB.     'ip L1U'=. getrfpl1u A
NB. where
NB.   A   - m×n-matrix to factorize
NB.   ip  - m-vector, rows inversed permutation of A
NB.   L1U - m×n-matrix, upper triangle contains U, and strict
NB.         lower triangle contains L1 without unit diagonal
NB.   P   - n×n-matrix, rows permutation of A
NB.   L1  - m×min(m,n)-matrix, unit lower triangular
NB.   U   - min(m,n)×n-matrix, upper triangular
NB.
NB. Storage layout:
NB.   A's partitioning:                           U's partitioning:
NB.     k   ( Aaa  Aba  ) := ( Aa  Ab  ) := A       k   ( Uaa     Uba     ) := U
NB.     m-k ( Aab  Abb  )                           m-k (         Ubb     )
NB.           k    n-k         k   n-k                    k       n-k
NB.   L1's partitioning:                          L1U's partitioning:
NB.     k   ( L1aa      ) := ( L1a L1b ) := L1      k   ( L1aaUaa Uba     ) := L1U
NB.     m-k ( L1ab L1bb )                           m-k ( L1ab    L1bbUbb )
NB.           k    n-k         k   n-k                    k       n-k
NB. where
NB.   L1aaUaa - combined L1aa and Uaa, L1aa's unit diagonal
NB.             isn't stored
NB.   L1bbUbb - combined L1bb and Ubb, L1bb's unit diagonal
NB.             isn't stored
NB.
NB. Algorithm:
NB.   In: A
NB.   Out: ip L1U
NB.   1) acquire geometry of A:
NB.        sh := shape
NB.        m  := quantity of rows
NB.        n  := quantity of columns
NB.   2) if m=0 or n=0 then:
NB.      2.1) set output:
NB.             ip  := i. m
NB.             L1U := A
NB.   3) elseif n=1 then:
NB.      3.1) prepare non-standard transposition dip:
NB.           3.1.1) find lIO 1st element with max value in
NB.                  1st column of A:
NB.                    p := liofmax A[:,0]
NB.                  note: to force L1 to be truly diagonally
NB.                        dominant replace sorim by soris in
NB.                        liofmax definition
NB.           3.1.2) compose non-standard transposition:
NB.                    dip := (0,p)
NB.           note: don't waste time for standardizing the
NB.                 transposition, use Adverse (::) later
NB.                 instead
NB.      3.2) prepare ip:
NB.           3.2.1) init ip:
NB.                    ip=. i. m
NB.           3.2.2) try to apply the transposition dip to
NB.                  ip:
NB.                    ip[0] ↔ ip[p]
NB.           3.2.3) if failed (i.e. if p=0), then leave ip
NB.                  unchanged
NB.      3.3) prepare L1U:
NB.           3.3.1) try to apply the transposition dip to
NB.                  rows of A:
NB.                    A[0,:] ↔ A[p,:]
NB.           3.3.2) if failed (i.e. if p=0), then leave A
NB.                  unchanged
NB.           3.3.3) factorize single column:
NB.                    U  := A[0,0]
NB.                    L1 := U^_1 * A
NB.   4) else:
NB.      4.1) find split point:
NB.             k := min(m,⌈n/2⌉)
NB.      4.2) factorize Aa recursively:
NB.             P * L1a * Uaa = Aa
NB.           note1: P is represented by vector of inversed
NB.                 permutation ip
NB.           note2: L1a and Uaa are stored in the same
NB.                  matrix L1aUaa, L1a's unit diagonal isn't
NB.                  stored
NB.      4.3) permute rows of Ab according to P^H :
NB.             Ab := P^H * Ab
NB.           note: purge original A, reuse name 'y' to
NB.                 store Ab
NB.      4.4) compute Uab:
NB.           4.4.1) extract L1aaUaa:
NB.                    L1aaUaa := L1aUaa[0:k-1,:]
NB.           4.4.2) extract Aba:
NB.                    Aba := Ab[0:k-1,:]
NB.           4.4.3) solve:
NB.                    L1aa * Uba = Aba
NB.      4.5) update and factorize Abb recursively:
NB.           4.5.1) extract Abb:
NB.                    Abb := Ab[k:m-1,:]
NB.           4.5.2) extract L1ab:
NB.                    L1ab := L1aUaa[k:m-1,:]
NB.           4.5.3) update Abb:
NB.                    Abb := Abb - L1ab * Uba
NB.           4.5.4) factorize Abb recursively:
NB.                    Pb * L1bb * Ubb = Abb
NB.                  note: Pb is represented by vector of
NB.                        inversed permutation ipb
NB.      4.6) prepare delta of inversed permutation dipb,
NB.           which defines inversed permutation of tail part
NB.      4.7) assemble output
NB.           4.7.1) permute tail part of ip according to
NB.                  Pb^H :
NB.                    ip[k:m-1] := Pb^H * ip[k:m-1]
NB.           4.7.2) permute rows of L1ab according to
NB.                  Pb^H :
NB.                    L1ab := Pb^H * L1ab
NB.           4.7.3) assemble triangular matrices L1 and U
NB.
NB. Assertions:
NB.   P -: %. iP
NB.   P -: |: iP
NB.   P -: ip2P ip
NB.   A -: clean p { L1 mp U
NB.   A -: clean p C. L1 mp U
NB.   A -: clean ip C.^:_1 L1 mp U
NB.   A -: clean P mp L1 mp U
NB. where
NB.   'ip L1U'=. getrfpl1u A
NB.   p=. /: ip
NB.   iP=. p2P ip
NB.   P=. p2P p
NB.   L1=. trl1 L1U
NB.   U=. tru L1U
NB.
NB. Notes:
NB. - models LAPACK's xGETRF

getrfpl1u=: 3 : 0
  'm n'=. sh=. $ y
  if. 0 e. sh do.
    (i. m) ; y
  elseif. 1 = n do.
    dip=. < 0 , liofmax y
    ip=. dip (C. :: ]) i. m
    y=. ((] 0:} %) 0&({,)) dip (C. :: ]) y
    ip ; y
  elseif. do.
    k=. m (<. >.@-:) n
    'pi L1aUaa'=. getrfpl1u k {."1 y
    y=. pi C. k }."1 y
    Uab=. L1aUaa trsml1x&(k&{.) y
    'ipb L1bbUbb'=. getrfpl1u y (- mp&Uab)&(k&}.) L1aUaa
    dipb=. (i. k) , (k + ipb)
    (dipb C. pi) ; (dipb C. L1aUaa) ,. (Uab , L1bbUbb)
  end.
)

NB. ---------------------------------------------------------
NB. getrfpu1l
NB.
NB. Description:
NB.   Triangular factorization with partial pivoting of a
NB.   general matrix:
NB.     P * U1 * L = A
NB.
NB. Syntax:
NB.     'ip U1L'=. getrfpu1l A
NB. where
NB.   ip  - m-vector, rows inversed permutation of A
NB.   A   - m×n-matrix to factorize
NB.   U1L - m×n-matrix, lower triangle contains L, and strict
NB.         upper triangle contains U1 without unit diagonal
NB.   P   - n×n-matrix, rows permutation of A
NB.   L   - m×min(m,n)-matrix, lower triangular
NB.   U1  - min(m,n)×n-matrix, unit upper triangular
NB.
NB. Storage layout:
NB.   A's partitioning:                           L's partitioning:
NB.     m-k ( Aaa  Aba  ) := ( Aa  Ab  ) := A       m-k ( Laa             ) := L
NB.     k   ( Aab  Abb  )                           k   ( Lab     Lbb     )
NB.           n-k  k           n-k k                      n-k     k
NB.   U1's partitioning:                          U1L's partitioning:
NB.     m-k ( U1aa U1ba ) := ( U1a U1b ) := U1      m-k ( U1aaLaa U1ba    ) := U1L
NB.     k   (      U1bb )                           k   ( Lab     U1bbLbb )
NB.           n-k  k           n-k k                      n-k       k
NB. where
NB.   U1aaLaa - combined U1aa and Laa, U1aa's unit diagonal
NB.             isn't stored
NB.   U1bbLbb - combined U1bb and Lbb, U1bb's unit diagonal
NB.             isn't stored
NB.
NB. Algorithm:
NB.   In: A
NB.   Out: ip U1L
NB.   1) acquire geometry of A:
NB.        sh := shape
NB.        m  := quantity of rows
NB.        n  := quantity of columns
NB.   2) if m=0 or n=0 then:
NB.      2.1) set output:
NB.             ip  := i. m
NB.             U1L := A
NB.   3) elseif n=1 then:
NB.      3.1) prepare non-standard transposition dip:
NB.           3.1.1) find lIO last element with max value in
NB.                  last column of A:
NB.                    p := liolmax A[:,_1]
NB.                  note: to force U1 to be truly diagonally
NB.                        dominant replace sorim by soris in
NB.                        liolmax definition
NB.           3.1.2) compose non-standard transposition:
NB.                    dip := (_1,p)
NB.           note: don't waste time for standardizing the
NB.                 transposition, use Adverse (::) later
NB.                 instead
NB.      3.2) prepare ip:
NB.           3.2.1) init ip:
NB.                    ip=. i. m
NB.           3.2.2) try to apply the transposition dip to
NB.                  ip:
NB.                    ip[_1] ↔ ip[p]
NB.           3.2.3) if failed (i.e. if p=m-1), then leave ip
NB.                  unchanged
NB.      3.3) prepare U1L:
NB.           3.3.1) try to apply the transposition dip to
NB.                  rows of A:
NB.                    A[_1,:] ↔ A[p,:]
NB.           3.3.2) if failed (i.e. if p=m-1), then leave A
NB.                  unchanged
NB.           3.3.3) factorize single column:
NB.                    L  := A[_1,_1]
NB.                    U1 := A * L^_1
NB.   4) else:
NB.      4.1) find split point:
NB.             k := min(m,⌈n/2⌉)
NB.      4.2) factorize Ab recursively:
NB.             P * U1b * Lbb = Ab
NB.           note1: P is represented by vector of inversed
NB.                 permutation ip
NB.           note2: Lbb and U1b are stored in the same
NB.                  matrix U1bLbb, U1b's unit diagonal isn't
NB.                  stored
NB.      4.3) permute rows of Aa according to P^H :
NB.             Aa := P^H * Aa
NB.           note: purge original A, reuse name 'y' to
NB.                 store Aa
NB.      4.4) compute Lab:
NB.           4.4.1) extract U1bbLbb:
NB.                    U1bbLbb := U1bLbb[m-k:m-1,:]
NB.           4.4.2) extract Aab:
NB.                    Aab := Aa[m-k:m-1,:]
NB.           4.4.3) solve:
NB.                    U1bb * Lab = Aab
NB.      4.5) update and factorize Aaa recursively:
NB.           4.5.1) extract Aaa:
NB.                    Aaa := Aa[0:m-k-1,:]
NB.           4.5.2) extract U1ba:
NB.                    U1ba := U1bLbb[0:m-k-1,:]
NB.           4.5.3) update Aaa:
NB.                    Aaa := Aaa - U1ba * Lab
NB.           4.5.4) factorize Aaa recursively:
NB.                    Pa * U1aa * Laa = Aaa
NB.                  note: Pa is represented by vector of
NB.                        inversed permutation ipa
NB.      4.6) prepare delta of inversed permutation dipa,
NB.           which defines inversed permutation of head part
NB.      4.7) assemble output
NB.           4.7.1) permute head part of ip according to
NB.                  Pa^H :
NB.                    ip[0:m-k-1] := Pa^H * ip[0:m-k-1]
NB.           4.7.2) permute rows of U1ba according to
NB.                  Pa^H :
NB.                    U1ba := Pa^H * U1ba
NB.           4.7.3) assemble triangular matrices U1 and L
NB.
NB. Assertions:
NB.   P -: %. iP
NB.   P -: |: iP
NB.   P -: ip2P ip
NB.   A -: clean p { U1 mp L
NB.   A -: clean p C. U1 mp L
NB.   A -: clean ip C.^:_1 U1 mp L
NB.   A -: clean P mp U1 mp L
NB. where
NB.   'ip U1L'=. getrfpu1l A
NB.   p=. /: ip
NB.   iP=. p2P ip
NB.   P=. p2P p
NB.   U1=. (tru1~ (-~/@$)) U1L
NB.   L=. (trl~ (-~/@$)) U1L

getrfpu1l=: 3 : 0
  'm n'=. sh=. $ y
  if. 0 e. sh do.
    (i. m) ; y
  elseif. 1 = n do.
    dip=. < _1 , liolmax y
    ip=. dip (C. :: ]) i. m
    y=. ((] _1:} %) _1&({,)) dip (C. :: ]) y
    ip ; y
  elseif. do.
    k=. m (<. >.@-:) n
    'ip U1bLbb'=. getrfpu1l (-k) {."1 y
    y=. ip C. (-k) }."1 y
    Lab=. U1bLbb trsmu1x&((-k)&{.) y
    'ipa U1aaLaa'=. getrfpu1l y (- mp&Lab)&((-k)&}.) U1bLbb
    dipa=. ipa , ((m-k) + i. k)
    (dipa C. ip) ; (U1aaLaa , Lab) ,. (dipa C. U1bLbb)
  end.
)

NB. ---------------------------------------------------------
NB. getrful1p
NB.
NB. Description:
NB.   Triangular factorization with partial pivoting of a
NB.   general matrix:
NB.     U * L1 * P = A
NB.
NB. Syntax:
NB.     'ip UL1'=. getrful1p A
NB. where
NB.   A   - m×n-matrix to factorize
NB.   ip  - n-vector, columns inversed permutation of A
NB.   UL1 - m×n-matrix, upper triangle contains U, and strict
NB.         lower triangle contains L1 without unit diagonal
NB.   P   - n×n-matrix, columns permutation of A
NB.   L1  - m×min(m,n)-matrix, unit lower triangular
NB.   U   - min(m,n)×n-matrix, upper triangular
NB.
NB. Storage layout:
NB.   A's partitioning:                       U's partitioning:
NB.     m-k ( Aaa  Aab  ) := ( Aa  ) := A       m-k ( Uaa     Uab     ) := U
NB.     k   ( Aba  Abb  )    ( Ab  )            k   (         Ubb     )
NB.           n-k  k           n                      n-k     k
NB.   L1's partitioning:                      UL1's partitioning:
NB.     m-k ( L1aa      ) := ( L1a ) := L1      m-k ( UaaL1aa Uab     ) := UL1
NB.     k   ( L1ba L1bb )    ( L1b )            k   ( L1ba    UbbL1bb )
NB.           n-k  k           n                      n-k     k
NB. where
NB.   UaaL1aa - combined Uaa and L1aa, L1aa's unit diagonal
NB.             isn't stored
NB.   UbbL1bb - combined Ubb and L1bb, L1bb's unit diagonal
NB.             isn't stored
NB.
NB. Algorithm:
NB.   In: A
NB.   Out: ip UL1
NB.   1) acquire geometry of A:
NB.        sh := shape
NB.        m  := quantity of rows
NB.        n  := quantity of columns
NB.   2) if m=0 or n=0 then:
NB.      2.1) set output:
NB.             ip  := i. n
NB.             UL1 := A
NB.   3) elseif m=1 then:
NB.      3.1) prepare non-standard transposition dip:
NB.           3.1.1) find lIO last element with max value in
NB.                  1st row of A:
NB.                    p := liolmax A[0,:]
NB.                  note: to force L1 to be truly diagonally
NB.                        dominant replace sorim by soris in
NB.                        liolmax definition
NB.           3.1.2) compose non-standard transposition:
NB.                    dip := (_1,p)
NB.           note: don't waste time for standardizing the
NB.                 transposition, use Adverse (::) later
NB.                 instead
NB.      3.2) prepare ip:
NB.           3.2.1) init ip:
NB.                    ip=. i. n
NB.           3.2.2) try to apply the transposition dip to
NB.                  ip:
NB.                    ip[n-1] ↔ ip[p]
NB.           3.2.3) if failed (i.e. if p=n-1), then leave ip
NB.                  unchanged
NB.      3.3) prepare UL1:
NB.           3.3.1) try to apply the transposition dip to
NB.                  columns of A:
NB.                    A[:,n-1] ↔ A[:,p]
NB.           3.3.2) if failed (i.e. if p=n-1), then leave A
NB.                  unchanged
NB.           3.3.3) factorize single row:
NB.                    U  := A[0,n-1]
NB.                    L1 := U^_1 * A
NB.   4) else:
NB.      4.1) find split point:
NB.             k := min(n,⌈m/2⌉)
NB.      4.2) factorize Ab recursively:
NB.             Ubb * L1b * P = Ab
NB.           note1: P is represented by vector of inversed
NB.                 permutation ip
NB.           note2: L1b and Ubb are stored in the same
NB.                  matrix UbbL1b, L1b's unit diagonal isn't
NB.                  stored
NB.      4.3) permute columns of Aa according to P^H :
NB.             Aa := Aa * P^H
NB.           note: purge original A, reuse name 'y' to
NB.                 store Aa
NB.      4.4) compute Uab:
NB.           4.4.1) extract UbbL1bb:
NB.                    UbbL1bb := UbbL1b[:,n-k:n-1]
NB.           4.4.2) extract Aab:
NB.                    Aab := Aa[:,n-k:n-1]
NB.           4.4.3) solve:
NB.                    Uab * L1bb = Aab
NB.      4.5) update and factorize Aaa recursively:
NB.           4.5.1) extract Aaa:
NB.                    Aaa := Aa[:,0:n-k-1]
NB.           4.5.2) extract L1ba:
NB.                    L1ba := UbbL1b[:,0:n-k-1]
NB.           4.5.3) update Aaa:
NB.                    Aaa := Aaa - Uab * L1ba
NB.           4.5.4) factorize Aaa recursively:
NB.                    Uaa * L1aa * Pa = Aaa
NB.                  note: Pa is represented by vector of
NB.                        inversed permutation ipa
NB.      4.6) prepare delta of inversed permutation dipa,
NB.           which defines inversed permutation of head part
NB.      4.7) assemble output
NB.           4.7.1) permute head part of ip according to
NB.                  Pa^H :
NB.                    ip[0:k-1] := Pa^H * ip[0:k-1]
NB.           4.7.2) permute columns of L1ba according to
NB.                  Pa^H :
NB.                    L1ba := L1ba * Pa^H
NB.           4.7.3) assemble triangular matrices L1 and U
NB.
NB. Assertions:
NB.   P -: %. iP
NB.   P -: |: iP
NB.   P -: ip2P ip
NB.   A -: clean p {"1 U mp L1
NB.   A -: clean p C."1 U mp L1
NB.   A -: clean ip C.^:_1"1 U mp L1
NB.   A -: clean U mp L1 mp iP         NB. apply p to columns
NB. where
NB.   'ip UL1'=. getrful1p A
NB.   p=. /: ip
NB.   iP=. p2P ip
NB.   P=. p2P p
NB.   U=. (tru~ (-~/@$)) UL1
NB.   L1=. (trl1~ (-~/@$)) UL1

getrful1p=: 3 : 0
  'm n'=. sh=. $ y
  if. 0 e. sh do.
    (i. n) ; y
  elseif. 1 = m do.
    dip=. < _1 , liolmax {. y
    ip=. dip (C. :: ]) i. n
    y=. ((] _1:} %) _1&({,)) dip (C."1 :: ]) y
    ip ; y
  elseif. do.
    k=. n (<. >.@-:) m
    'ip UbbL1b'=. getrful1p (-k) {. y
    y=. ip (C."1) (-k) }. y
    Uab=. UbbL1b trsmxl1&((-k)&({."1)) y
    'ipa UaaL1aa'=. getrful1p y (- Uab&mp)&((-k)&(}."1)) UbbL1b
    dipa=. ipa , ((n-k) + i. k)
    (dipa C."1 ip) ; (UaaL1aa ,. Uab) , (dipa C."1 UbbL1b)
  end.
)

NB. ---------------------------------------------------------
NB. hetrfpl
NB.
NB. Description:
NB.   Triangular factorization of a Hermitian (symmetric)
NB.   matrix:
NB.     P * L1 * T * L1^H * P^H = A
NB.   using the combination of Parlett and Reid, and Aasen
NB.   methods [1].
NB.
NB. Syntax:
NB.     'ip L1 T'=. hetrfpl A
NB. where
NB.   A  - n×n-matrix, Hermitian (symmetric)
NB.   ip - n-vector of integers, full inversed permutation of
NB.        A
NB.   L1 - n×n-matrix, unit lower triangular
NB.   T  - n×n-matrix, Hermitian (symmetric) tridiagonal
NB.   P  - n×n-matrix, full permutation of A
NB.
NB. Algorithm (assume TRFNB<n-i):
NB.   In: A
NB.   Out: ip L1 T
NB.   1) count n, the size of A
NB.   2) form initial ip L1 t0 t1
NB.   3) count amount of iterations to do:
NB.        I=. ⌈n/TRFNB⌉
NB.   4) do iterations i={0,TRFNB,2*TRFNB,...,(I-1)*TRFNB}:
NB.      4.1) call lahefpl to reconstruct current block of L1
NB.           and T, delta permutation ipi dictated by
NB.           current block's factorization, the 1st column
NB.           lt for next subL1 having T[j+1,j] in head
NB.           instead of 1
NB.      4.2) prepare delta of inversed permutation dip for
NB.           tail part of ip
NB.      4.3) update ip by dip
NB.      4.4) extract subL1
NB.      4.5) permute rows of L1 according to dip, stitch
NB.           subL1 to it
NB.      4.6) do rank-(TRFNB+1) update of
NB.           A[i+TRFNB:n-1,i+TRFNB:n-1]:
NB.           4.6.1) extract subL110:
NB.                    subL110 := subL1[TRFNB:n-i-1,0:TRFNB-1]
NB.           4.6.2) extract subH10^H:
NB.                    subH10h := (subH[TRFNB:n-i-1,0:TRFNB-1])^H
NB.           4.6.3) form rank-TRFNB update:
NB.                    Arku := subL110 * subH10h
NB.           4.6.4) extract last column of subL1 and
NB.                  conjugate it:
NB.                    cl0 := conj(subL1[TRFNB:n-1,TRFNB-1])
NB.           4.6.5) restore 1st column of next subL1 and try
NB.                  to multiply it by T[j+1,j]:
NB.                    ml1 := subL1[TRFNB:n-1,TRFNB] * subT[j+1,j]
NB.           4.6.6) form rank-1 update:
NB.                    Ar1u := ml1 * cl0
NB.           4.6.7) update subA:
NB.                    subA := subA - (Arku + Ar1u)
NB.                  note: sum of rank updates is Hermitian
NB.                        (symmetric), so subA will have
NB.                        kept symmetry after update
NB.   5) form T from t0 t1
NB.   6) return
NB.        ip ; L1 ; T
NB.
NB. FLOPs [1]:
NB.   1/3 * (1 + 1/TRFNB) * n^3 + O(n^2 * k)
NB.
NB. Assertions:
NB.   P -: %. iP
NB.   P -: |: iP
NB.   A -: clean (/: ip) fp L1 (mp mp ct@[) T
NB.   A -: clean P (mp mp |:@[) L1 (mp mp ct@[) T
NB. where
NB.   'ip L1 T'=. hetrfpl A
NB.   iP=. p2P ip
NB.   P=. ip2P ip
NB.
NB. Notes:
NB. - is similar to LAPACK's DSYTRF and ZHETRF, but uses
NB.   another factorization
NB.
NB. References:
NB. [1] Miroslav Rozloznik, Gil Shklarski, Sivan Toledo.
NB.     Partitioned triangular tridiagonalization.
NB.     26 September 2007.
NB.     http://www.cs.cas.cz/miro/rst08.pdf
NB.
NB. TODO:
NB. - T would be sparse

hetrfpl=: 3 : 0
  n=. # y
  ip=. i. n
  L1=. 0 {."1 y
  lt=. n # 0
  t0=. t1=. i. 0
  i=. 0
  while. i < n do.
    'ipi y lt t0 t1'=. lahefpl (i. # lt) ; y ; lt ; t0 ; t1
    dip=. i (i.@[ , +) ipi
    ip=. dip C. ip
    subL1=. trl1 (_,TRFNB) rt y
    L1=. (dip C. L1) stitchb subL1
    y=. ((2 # TRFNB) }. y) - (((TRFNB }. subL1) mp (TRFNB ((((0<.-)#),[) }. ]) y)) + ((0 { :: ] lt) * (1 (0}) :: ] lt)) */ + (lt ((_1 liosS)&# ({,) ]) y))
    i=. TRFNB + i
  end.
  T=. t1 (((setdiag~ ;&_1) (setdiag~ + ; 1:) ])~ diagmat) t0
  ip ; L1 ; T
)

NB. ---------------------------------------------------------
NB. hetrfpu
NB.
NB. Description:
NB.   Triangular factorization of a Hermitian (symmetric)
NB.   matrix:
NB.     P * U1 * T * U1^H * P^H = A
NB.   using the combination of Parlett and Reid, and Aasen
NB.   methods, inspired by [1].
NB.
NB. Syntax:
NB.     'ip U1 T'=. hetrfpu A
NB. where
NB.   A  - n×n-matrix, Hermitian (symmetric)
NB.   ip - n-vector of integers, full inversed permutation of
NB.        A
NB.   U1 - n×n-matrix, unit upper triangular
NB.   T  - n×n-matrix, Hermitian (symmetric) tridiagonal
NB.   P  - n×n-matrix, full permutation of A
NB.
NB. Algorithm (assume TRFNB<n+i+1):
NB.   In: A
NB.   Out: ip U1 T
NB.   1) count n, the size of A
NB.   2) form initial ip U1 t0 t1
NB.   3) count amount of iterations to do:
NB.        I=. ⌈n/TRFNB⌉
NB.   4) do iterations i={_1,_1-TRFNB,_1-2*TRFNB,...,_1-(I-1)*TRFNB}:
NB.      4.1) call lahefpu to reconstruct current block of U1
NB.           and T, delta permutation ipi dictated by
NB.           current block's factorization, the last column
NB.           ut for next subU1 having T[j,j+1] in head
NB.           instead of 1
NB.      4.2) prepare delta of inversed permutation dip for
NB.           head part of ip
NB.      4.3) update ip by dip
NB.      4.4) extract subU1
NB.      4.5) permute rows of U1 according to dip, and stitch
NB.           it to subU1
NB.      4.6) do rank-(TRFNB+1) update of
NB.           A[0:n+i-TRFNB,0:n+i-TRFNB]:
NB.           4.6.1) extract subU101:
NB.                    subU101 := subU1[0:n+i-TRFNB+1,n+i-TRFNB+1:n+i]
NB.           4.6.2) extract subH01^H:
NB.                    subH01h := (subH[0:n+i-TRFNB+1,n+i-TRFNB+1:n+i])^H
NB.           4.6.3) form rank-TRFNB update:
NB.                    Arku := subU101 * subH01h
NB.           4.6.4) extract 1st column of subU1 and
NB.                  conjugate it:
NB.                    cu0 := conj(subU1[0:n+i-TRFNB,n+i-TRFNB+1])
NB.           4.6.5) restore last column of next subU1 and try
NB.                  to multiply it by T[j,j+1]:
NB.                    mu1 := subU1[0:n+i-TRFNB,n+i-TRFNB] * subT[j,j+1]
NB.           4.6.6) form rank-1 update:
NB.                    Ar1u := mu1 * cu0
NB.           4.6.7) update subA:
NB.                    subA := subA - (Arku + Ar1u)
NB.                  note: sum of rank updates is Hermitian
NB.                        (symmetric), so subA will have
NB.                        kept symmetry after update
NB.   5) form T from t0 t1
NB.   6) return
NB.        ip ; U1 ; T
NB.
NB. FLOPs [1]:
NB.   1/3 * (1 + 1/TRFNB) * n^3 + O(n^2 * k)
NB.
NB. Assertions:
NB.   P -: %. iP
NB.   P -: |: iP
NB.   A -: clean (/: ip) fp U1 (mp mp ct@[) T
NB.   A -: clean P (mp mp |:@[) U1 (mp mp ct@[) T
NB. where
NB.   'ip U1 T'=. hetrfpu A
NB.   iP=. p2P ip
NB.   P=. ip2P ip
NB.
NB. References:
NB. [1] Miroslav Rozloznik, Gil Shklarski, Sivan Toledo.
NB.     Partitioned triangular tridiagonalization.
NB.     26 September 2007.
NB.     http://www.cs.cas.cz/miro/rst08.pdf
NB.
NB. TODO:
NB. - T would be sparse

hetrfpu=: 3 : 0
  n=. # y
  ip=. i. n
  U1=. 0 {."1 y
  ut=. n # 0
  t0=. t1=. i. 0
  i=. _1
  while. i >: -n do.
    'ipi y ut t0 t1'=. lahefpu (i. # ut) ; y ; ut ; t0 ; t1
    dip=. i (],((+(i.@(_1&-)))~#)) ipi
    ip=. dip C. ip
    subU1=. (tru1~ -~/@$) (_,-TRFNB) rt y
    U1=. subU1 stitcht (dip C. U1)
    y=. ((2 # -TRFNB) }. y) - ((((-TRFNB) }. subU1) mp ((-TRFNB) ((((0>.+)#),[) }. ]) y)) + ((_1 { :: ] ut) * (1 (_1}) :: ] ut)) */ + (ut ((1 liosN)&# ({,) ]) y))
    i=. i - TRFNB
  end.
  T=. t1 (((setdiag~ ;&1) (setdiag~ + ; _1:) ])~ diagmat) t0
  ip ; U1 ; T
)

NB. ---------------------------------------------------------
NB. potrfl
NB.
NB. Description:
NB.   Cholesky factorization of a Hermitian (symmetric)
NB.   positive definite matrix:
NB.     L * L^H = A
NB.
NB. Syntax:
NB.   L=. potrfl A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive definite
NB.   L - n×n-matrix, lower triangular with positive diagonal
NB.       entries, Cholesky triangle
NB.
NB. Algorithm:
NB.   In: A
NB.   Out: L
NB.   1) acquire n, the size of A
NB.   2) if n>1 then:
NB.      2.1) partition A
NB.           2.1.1) prepare fret, the n-vector of zeros with
NB.                  two units in positions 0 and ⌈n/2⌉
NB.           2.1.2) partition A according to fret:
NB.                    ⌈n/2⌉   ( A00   A01 ) := A
NB.                    n-⌈n/2⌉ ( A01^H A11 )
NB.                              ⌈n/2⌉ n-⌈n/2⌉
NB.      2.2) recursively factorize A00:
NB.             L00 := potrfl A00
NB.      2.3) find L10^H:
NB.             L10h := L00 trsmlx A01
NB.           via solving:
NB.             L00 * (L10^H) = A01
NB.      2.4) find L10:
NB.             L10 := L10h^H
NB.      2.5) update A11 and recursively factorize it to find
NB.           L11:
NB.             L11 := potrfl A11 - L10 * L10h
NB.      2.6) assemble L:
NB.             L := ( L00       ) ⌈n/2⌉
NB.                  ( L10   L11 ) n-⌈n/2⌉
NB.                    ⌈n/2⌉ n-⌈n/2⌉
NB.   3) else:
NB.        L := sqrt(A)
NB.
NB. Assertions:
NB.   A -: clean po L
NB. where
NB.   L=. potrfl A
NB.
NB. Notes:
NB. - models LAPACK's xPOTRF('L'), but uses blocked, not
NB.   partitioned algorithm

potrfl=: %:`((0:`0:`0:`]`]`(potrfl@(0 0&{::))`,`(ct@])`trsmlx`(0 1&{::)`[`mp`[`]`(1 1&{::)`stitchb`(potrfl@:-~)`]`[`0:`0: fork6)@(<;.1~ (;~@((0) 1:`(, >.@-:)`(#~)} #))))@.(1<#)

NB. ---------------------------------------------------------
NB. potrfu
NB.
NB. Description:
NB.   Cholesky factorization of a Hermitian (symmetric)
NB.   positive definite matrix:
NB.     U * U^H = A
NB.
NB. Syntax:
NB.   U=. potrfu A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive definite
NB.   U - n×n-matrix, upper triangular with positive diagonal
NB.       entries, Cholesky triangle
NB.
NB. Algorithm:
NB.   In: A
NB.   Out: U
NB.   1) acquire n, the size of A
NB.   2) if n>1 then:
NB.      2.1) partition A
NB.           2.1.1) prepare fret, the n-vector of zeros with
NB.                  two units in positions 0 and ⌈n/2⌉
NB.           2.1.2) partition A according to fret:
NB.                    ⌈n/2⌉   ( A00   A10^H ) := A
NB.                    n-⌈n/2⌉ ( A10   A11 )
NB.                              ⌈n/2⌉ n-⌈n/2⌉
NB.      2.2) recursively factorize A11:
NB.             U11 := potrfu A11
NB.      2.3) find U01^H:
NB.             U01h := U11 trsmux A10
NB.           via solving:
NB.             U11 * (U01^H) = A10
NB.      2.4) find U01:
NB.             U01 := U01h^H
NB.      2.5) update A00 and recursively factorize it to find
NB.           U00:
NB.             U00 := potrfu A00 - U01 * U01h
NB.      2.6) assemble U:
NB.             U := ( U00   U01 ) ⌈n/2⌉
NB.                  (       U11 ) n-⌈n/2⌉
NB.                    ⌈n/2⌉ n-⌈n/2⌉
NB.   3) else:
NB.        U := sqrt(A)
NB.
NB. Assertions:
NB.   A -: clean po U
NB. where
NB.   U=. potrfu A

potrfu=: %:`((0:`0:`0:`]`]`(potrfu@(1 1&{::))`(,~)`(ct@])`trsmux`(1 0&{::)`[`mp`[`]`(0 0&{::)`(stitcht~)`(potrfu@:-~)`]`[`0:`0: fork6)@(<;.1~ (;~@((0) 1:`(, >.@-:)`(#~)} #))))@.(1<#)

NB. ---------------------------------------------------------
NB. pttrfl
NB.
NB. Description:
NB.   Triangular factorization of a Hermitian (symmetric)
NB.   positive definite tridiagonal matrix [1]:
NB.     L1 * D * L1^H = A
NB.
NB. Syntax:
NB.   'L1 D'=. pttrfl A
NB. where
NB.   A  - n×n-matrix, Hermitian (symmetric) positive
NB.        definite tridiagonal
NB.   L1 - n×n-matrix, unit lower bidiangonal
NB.   D  - n×n-matrix, diagonal with positive diagonal
NB.        entries
NB.
NB. Algorithm:
NB.   In:  A
NB.   Out: L1 D
NB.   1) extract main diagonal d and subdiagonal e from A
NB.   2) prepare input:
NB.        dee2 := d ,. (0,e) ,. (0,|e|^2)
NB.   3) do iterations k=1:n-1 by reversed suffix scan:
NB.        de=. u/\.&.|. dee2
NB.      to find :
NB.        d[k] := d[k] - |e[k-1]|^2 / d[k-1]
NB.        e[k-1] := e[k-1] / d[k-1]
NB.      for non-empty dee2 only
NB.   4) extract d - D's main diagonal, and e - L1's
NB.      subdiagonal from de:
NB.        d=. {."1 de
NB.        e=. }. 1 {"1 de
NB.   5) form output matrices:
NB.        L1=. (e;_1) setdiag idmat $ A
NB.        D=. diagmat d
NB.   6) link matrices L1 and D to form output:
NB.        L1 ; D
NB.
NB. Assertions:
NB.   A -: clean L1 (mp mp ct@[) D
NB. where
NB.   'L1 D'=. pttrfl A
NB.
NB. Notes:
NB. - implements LAPACK's xPTTRF
NB. - if A is indefinite then factors may have unacceptably
NB.   large elements
NB.
NB. References:
NB. [1] G. H. Golub and C. F. Van Loan, Matrix Computations,
NB.     Johns Hopkins University Press, Baltimore, Md, USA,
NB.     3rd edition, 1996, p. 157
NB.
NB. TODO:
NB. - L1 and D would be sparse

pttrfl=: ({."1 (((setdiag idmat@#)~ ;&_1) ; diagmat@[) }.@(1&({"1)))@(({.@] ((- {:) , {.@]) ((%  {.)~ }.))~/\.^:(0<#)&.|.)@(diag (stitchb (,. soris)) _1&diag)

NB. ---------------------------------------------------------
NB. pttrfu
NB.
NB. Description:
NB.   Triangular factorization of a Hermitian (symmetric)
NB.   positive definite tridiagonal matrix, based on [1]:
NB.     U1 * D * U1^H = A
NB.
NB. Syntax:
NB.   'U1 D'=. pttrfu A
NB. where
NB.   A  - n×n-matrix, Hermitian (symmetric) positive
NB.        definite tridiagonal
NB.   U1 - n×n-matrix, unit upper bidiangonal
NB.   D  - n×n-matrix, diagonal with positive diagonal
NB.        entries
NB.
NB. Algorithm:
NB.   In:  A
NB.   Out: U1 D
NB.   1) extract main diagonal d and superdiagonal e from A
NB.   2) prepare input:
NB.        dee2 := d ,. (e,0) ,. ((|e|^2),0)
NB.   3) do iterations k=n-2:0 by suffix scan:
NB.        de=. u/\. dee2
NB.      to find :
NB.        d[k] := d[k] - |e[k]|^2 / d[k+1]
NB.        e[k] := e[k] / d[k+1]
NB.      for non-empty dee2 only
NB.   4) extract d - D's main diagonal, and e - L1's
NB.      subdiagonal from de:
NB.        d=. {."1 de
NB.        e=. }: 1 {"1 de
NB.   5) form output matrices:
NB.        U1=. (e;1) setdiag idmat $ A
NB.        D=. diagmat d
NB.   6) link matrices U1 and D to form output:
NB.        U1 ; D
NB.
NB. Assertions:
NB.   A -: clean U1 (mp mp ct@[) D
NB. where
NB.   'U1 D'=. pttrfu A
NB.
NB. Notes:
NB. - if A is indefinite then factors may have unacceptably
NB.   large elements
NB.
NB. References:
NB. [1] G. H. Golub and C. F. Van Loan, Matrix Computations,
NB.     Johns Hopkins University Press, Baltimore, Md, USA,
NB.     3rd edition, 1996, p. 157
NB.
NB. TODO:
NB. - U1 and D would be sparse

pttrfu=: ({."1 (((setdiag idmat@#)~ ;& 1) ; diagmat@[) }:@(1&({"1)))@(({.@[ ((- {:) , {.@]) ((%~ }.)~ {.)) /\.^:(0<#)    )@(diag (stitcht (,. soris))  1&diag)

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testgetrf
NB.
NB. Description:
NB.   Test:
NB.   - lud (math/misc)
NB.   - getrf (math/lapack)
NB.   - getrfxxxx (math/mt)
NB.   by general matrix given
NB.
NB. Syntax:
NB.   testgetrf A
NB. where
NB.   A - m×n-matrix
NB.
NB. Formula:
NB. - for L * U1 * P = A :
NB.     berr := ||L * U1 * P - A|| / (FP_EPS * ||A|| * m)
NB. - for P * L1 * U = A :
NB.     berr := ||P * L1 * U - A|| / (FP_EPS * ||A|| * n)
NB. - for P * U1 * L = A :
NB.     berr := ||P * U1 * L - A|| / (FP_EPS * ||A|| * n)
NB. - for U * L1 * P = A :
NB.     berr := ||U * L1 * P - A|| / (FP_EPS * ||A|| * m)
NB.
NB. Notes:
NB. - use temporary locale mttmp to avoid mt's names
NB.   redefinition

testgetrf=: 3 : 0
  load_mttmp_ :: ] '~addons/math/misc/makemat.ijs'   NB. FIXME: ...
  load_mttmp_ :: ] '~addons/math/misc/matutil.ijs'   NB.   ... J doesn't ...
  load_mttmp_ :: ] '~addons/math/misc/linear.ijs'    NB.   ... execute 'require' ...
  load_mttmp_ :: ] '~addons/math/misc/matfacto.ijs'  NB.   ... recursively
  require :: ] '~addons/math/lapack/lapack.ijs'
  need_jlapack_ :: ] 'getrf'

  rcond=. (_."_)`gecon1@.(=/@$) y  NB. meaninigful for square matrices only

  ('lud_mttmp_'     tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- (mp&>/@}: %. 2&{::)) % FP_EPS*(norm1*c)@[))) y

  ('getrf_jlapack_' tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- (mp&>/@}: invperm_jlapack_ 2&{::)) % FP_EPS*(norm1*c)@[))) y

  ('getrflu1p'      tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- (0&{:: C.^:_1"1 ( trl          mp  tru1        )@(1&{::))) % FP_EPS*(norm1*#)@[))) y
  ('getrfpl1u'      tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- (0&{:: C.^:_1   ( trl1         mp  tru         )@(1&{::))) % FP_EPS*(norm1*c)@[))) y
  ('getrfpu1l'      tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- (0&{:: C.^:_1   ((tru1~ -~/@$) mp (trl ~ -~/@$))@(1&{::))) % FP_EPS*(norm1*c)@[))) y
  ('getrful1p'      tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- (0&{:: C.^:_1"1 ((tru ~ -~/@$) mp (trl1~ -~/@$))@(1&{::))) % FP_EPS*(norm1*#)@[))) y

  coerase <'mttmp'

  EMPTY
)

NB. ---------------------------------------------------------
NB. testhetrf
NB.
NB. Description:
NB.   Test hetrfpx by Hermitian (symmetric) matrix given
NB.
NB. Syntax:
NB.   testhetrf A
NB. where
NB.   A - n×n-matrix, Hermitian
NB.
NB. Formula:
NB. - for P * L1 * T * L1^H * P^H = A :
NB.     berr := ||P * L1 * T * L1^H * P^H - A|| / (FP_EPS * ||A|| * n)
NB. - for P * U1 * T * U1^H * P^H = A :
NB.     berr := ||P * U1 * T * U1^H * P^H - A|| / (FP_EPS * ||A|| * n)

testhetrf=: 3 : 0
  rcond=. hecon1 y

  ('hetrfpl' tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- ((mp mp ct@[)&>/@}. (fp~ /:) 0&({::))) % FP_EPS*(norm1*c)@[))) y
  ('hetrfpu' tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- ((mp mp ct@[)&>/@}. (fp~ /:) 0&({::))) % FP_EPS*(norm1*#)@[))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testpotrf
NB.
NB. Description:
NB.   Test:
NB.   - choleski (math/misc addon)
NB.   - potrf (math/lapack addon)
NB.   - potrfx (math/mt addon)
NB.   by Hermitian (symmetric) positive definite matrix given
NB.
NB. Syntax:
NB.   testpotrf A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive
NB.       definite
NB.
NB. Formula:
NB. - for L * L^H = A :
NB.     berr := ||L * L^H - A|| / (FP_EPS * ||A|| * n)
NB. - for U * U^H = A :
NB.     berr := ||U * U^H - A|| / (FP_EPS * ||A|| * n)
NB.
NB. Notes:
NB. - use temporary locale mttmp to avoid mt's names
NB.   redefinition

testpotrf=: 3 : 0
  load_mttmp_ :: ] '~addons/math/misc/matfacto.ijs'
  require :: ] '~addons/math/lapack/lapack.ijs'
  need_jlapack_ :: ] 'potrf'

  rcond=. pocon1 y

  ('choleski_mttmp_' tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- po) % FP_EPS*(norm1*c)@[))) y

  ('potrf_jlapack_'  tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- po) % FP_EPS*(norm1*c)@[))) y

  ('potrfl'          tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- po) % FP_EPS*(norm1*c)@[))) y
  ('potrfu'          tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- po) % FP_EPS*(norm1*#)@[))) y

  coerase <'mttmp'

  EMPTY
)

NB. ---------------------------------------------------------
NB. testpttrf
NB.
NB. Description:
NB.   Test pttrfpx by Hermitian (symmetric) positive definite
NB.   tridiagonal matrix given
NB.
NB. Syntax:
NB.   testpttrf A
NB. where
NB.   A - n×n-matrix, Hermitian (symmetric) positive
NB.       definite tridiagonal
NB.
NB. Formula:
NB. - for L1 * D * L1^H = A :
NB.     berr := ||L1 * D * L1^H - A|| / (FP_EPS * ||A|| * n)
NB. - for U1 * D * U1^H = A :
NB.     berr := ||U1 * D * U1^H - A|| / (FP_EPS * ||A|| * n)
NB.
NB. TODO:
NB. - A should be sparse

testpttrf=: 3 : 0
  rcond=. ptcon1 y

  ('pttrfl' tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- ((mp mp ct@[)&>/)) % FP_EPS*(norm1*c)@[))) y
  ('pttrfu' tmonad (]`]`(rcond"_)`(_."_)`(norm1@(- ((mp mp ct@[)&>/)) % FP_EPS*(norm1*#)@[))) y

  EMPTY
)

NB. ---------------------------------------------------------
NB. testtrf
NB.
NB. Description:
NB.   Adv. to make verb to test xxtrfxxxx by matrix of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testtrf
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
NB.     ?@$&0 testtrf_mt_ 200 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testtrf_mt_ 200 200
NB. - test by random rectangular complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testtrf_mt_ 150 200

testtrf=: 1 : 'EMPTY_mt_ [ (testpttrf_mt_@(u ptmat_mt_) [ testpotrf_mt_@(u pomat_mt_) [ testhetrf_mt_@(u hemat_mt_))^:(=/) [ testgetrf_mt_@u'
