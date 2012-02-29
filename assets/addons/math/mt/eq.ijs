NB. Eigenvalues and Schur form
NB.
NB. hgexxe    Eigenvalues of pair of structured matrices
NB. hgexxs    Eigenvalues and the Schur form of pair of
NB.           structured matrices
NB.
NB. testhgeq  Test hgexxxxx by general matrices given
NB. testeq    Adv. to make verb to test hgexxxxx by matrices
NB.           of generator and shape given
NB.
NB. Version: 0.8.0 2011-10-29
NB.
NB. Copyright 2011 Igor Zhuravlov
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
NB. Name: laqr1
NB. Description: 1st column of (H-s1*I)*(H-s2*I)
NB. Syntax: vK=. (s1,s2) laqr1 H
NB. where   H - 2×2-matrix or 3×3-matrix
NB. TODO: tacit
NB. Notes: implements LAPACK's xLAQR1

laqr1=: 4 : 0
  's1 s2'=. x
  ((-&s1 upddiag ]) (mp (% norm1t)) ((-&s2 updl 0) {."1 ])) y
)

NB. ---------------------------------------------------------
NB. hgexxeo
NB.
NB. Description:
NB.   Compute generalized eigenvalues of hs-segment
NB.
NB. Syntax:
NB.   'HTupd signbc'=. hs hgexxeo H ,: T
NB. where
NB.   hs    - 2-vector of integers (h,s) 'head' and 'size',
NB.           defines eigenvalues range
NB.   H     - n×n-matrix, either lower or upper Hessenberg
NB.           inside the submatrix H[h:h+s-1,h:h+s-1], and
NB.           lower or upper triangular outside
NB.   T     - n×n-matrix, either lower or upper triangular
NB.   HTupd -: Hupd ,: Tupd
NB.   Hupd  - n×n-matrix, being H with hs-segment of diagonal
NB.           replaced by alpha (see hgexx)
NB.   Tupd  - n×n-matrix, being T with hs-segment of diagonal
NB.           replaced by beta (see hgexx)
NB.   signbc - s-vector, scaling factors to form Q,Z later

hgexxeo=: 4 : 0
  'Hd Td'=. (0 , x) diag"2 y
  absb=. | Td
  'signbc Td'=. (,:~ FP_SFMIN < absb) } 1 0 2 |: (1 ,: + * Td) ,: (0 ,: absb)
  ((((Hd * signbc) ,: Td) (;"1) 0 , x) setdiag"1 2 y) ; signbc
)

NB. ---------------------------------------------------------
NB. hgezqso
NB. hgeqzso
NB.
NB. Description:
NB.   Compute generalized eigenvalues of hs-segment and
NB.   reduce corresponding rows (hgezqso) or columns
NB.   (hgeqzso) to generalized Schur form
NB.
NB. Syntax:
NB.   'HTupd signbc'=. hs hgexxso H ,: T
NB. where
NB.   hs    - 2-vector of integers (h,s) 'head' and 'size',
NB.           defines eigenvalues range
NB.   H     - n×n-matrix, either lower (hgezqso) or upper
NB.           (hgeqzso) Hessenberg inside the submatrix
NB.           H[h:h+s-1,h:h+s-1], and lower (hgezqso) or
NB.           upper (hgeqzso) triangular outside
NB.   T     - n×n-matrix, either lower (hgezqso) or upper
NB.           (hgeqzso) triangular
NB.   HTupd -: Hupd ,: Tupd
NB.   Hupd  - n×n-matrix, being H with rows (hgezqso) or
NB.           columns (hgeqzso) from hs-segment transformed
NB.           to Shur form
NB.   Tupd  - n×n-matrix, being T with rows (hgezqso) or
NB.           columns (hgeqzso) from hs-segment transformed
NB.           to Shur form
NB.   signbc - s-vector, scaling factors to form Q,Z later

hgezqso=: 4 : 0
  lios=. dhs2lios x
  'y signbc'=. x hgexxeo y
  subHT=. lios {"2 y
  (((,:~ lios >/ (i. c y)) } subHT ,: subHT *"2 signbc) lios }"2 y) ; signbc
)

hgeqzso=: 4 : 0
  lios=. dhs2lios x
  'y signbc'=. x hgexxeo y
  subHT=. lios {"1 y
  (((,:~ (i. c y) </ lios) } subHT ,: subHT *"1 signbc) lios }"1 y) ; signbc
)

NB. ---------------------------------------------------------
NB. hgezq
NB. hgeqz
NB.
NB. Description:
NB.   Adv. to make verbs to find eigenvalues of either lower
NB.   (hgezq) or upper (hgeqz) Hessenberg-triangular pair
NB.   (H,T) and, optionally, to reduce this pair to
NB.   generalized Schur form
NB.
NB. Syntax:
NB.   vapp=. hgexxxo`init`reset`step hgexx
NB. where
NB.   hgexxxo - monad to compute generalized eigenvalues of
NB.             hs-segment and, optionally, to reduce
NB.             corresponding columns to generalized Schur
NB.             form, is either hgezqso (hgezq only), hgeqzso
NB.             (hgeqz only) or hgexxeo, is called as:
NB.               'HTupd signbc'=. hgexxxo hs ; HT
NB.   init    - dyad to initialize counters, is called as:
NB.               'ifrstm ilastm'=. (h , ilast) init (0 , n-1)
NB.   reset   - dyad to reset counters optionally, is called
NB.             as:
NB.               'ifrstm ilastm'=. (h , ilast) reset (ifrstm , ilastm)
NB.   step    - monad to change counter optionally, is
NB.             called as:
NB.               ifrstm=. ifirst step ifrstm
NB.   vapp    - dyad to find eigenvalues of lower (upper)
NB.             Hessenberg-triangular pair (H,T) and,
NB.             optionally, to reduce this pair to
NB.             generalized Schur form, is called as:
NB.               'HTupd dQ1 dZ1'=. hs vapp HT
NB.             see hgeqzxxxx
NB.
NB. Notes:
NB. - non-converged eigenvalues are set to NaN

hgezq=: 1 : 0
:
  '`hgezqxo init reset step'=. m
  e=. +/ 'h s'=. x
  dQ1=. dZ1=. 0 4 $ 0
  abnorm=. (0 2 ,. ,.~ x) norms"2 ;. 0 y
  'atol btol'=. abtol=. FP_SFMIN >. FP_PREC * abnorm
  'ascale bscale'=. abscale=. % FP_SFMIN >. abnorm
  'y signbc'=. ((c y) (] , -) e) hgezqxo y  NB. process eigenvalues (columns) h+s:n-1
  dZ1=. dZ1 , 4 {."1 signbc ,. (c y) th2lios e

  NB. Eigenvalues h+s:n-1 have been found.

  NB. Initialize dynamic indices
  ilast=. <: e
  'ifrstm ilastm'=. (h , ilast) init (0 , <: c y)
                  NB. ifrstm - the column of the last
                  NB.          splitting column to the left
                  NB.          of the column ilast, this is
                  NB.          always at least h
  iiter=. 0       NB. counts iterations since the last
                  NB. eigenvalue was found, to tell when to
                  NB. use an extraordinary shift
  eshift=. 0
  maxit=. 30 * s  NB. the maximum number of ZQ sweep allowed
  jiter=. 0

  NB. Main ZQ iteration loop
  NB. Row operations modify columns ifrstm:*
  NB. Column operations modify rows *:ilastm
  while. jiter < maxit do.
    goto60=. 1  NB. set default branching
    NB. split the matrix if possible, by two tests:
    NB.   1. H[j-1,j]=0 OR j=h
    NB.   2. T[j,j]=0
    if. ilast ~: h do.
      if. atol < sorim (< 0 , ilast - 1 0) { y do.
        if. btol < | (< 1 , ,~ ilast) { y do.
          NB. general case: j < ilast
          j=. <: ilast
          while. j >: h do.
            NB. test 1: H[j-1,j]=0 OR j=h
            if. j = h do.
              ilazro=. 1
            elseif. atol >: sorim (< 0 , j - 1 0) { y do.
              y=. 0 (< 0 , j - 1 0) } y
              ilazro=. 1
            elseif. do.
              ilazro=. 0
            end.
            NB. test 2: T[j,j]=0
            if. btol > | (< 1 , ,~ j) { y do.
              y=. 0 (< 1 , ,~ j) } y
              NB. test 2a: check for 2 consecutive small
              NB, superdiagonals in H
              ilazr2=. 0
              if. -. ilazro do.
                'Hj1j Hjj1 Hjj'=. sorim ((<"1) 0 ,. (_1 0,0 1,:0 0) + j) { y
                if. 0 >: (Hj1j , Hjj) mp (ascale * (Hjj1 , -atol)) do.
                  ilazr2=. 1
                end.
              end.
              NB. If both tests (1 & 2) pass, i.e., the
              NB. leading diagonal element of T in the block
              NB. is zero, then split a 1x1 block off at the
              NB. left, i.e. at the j-th row/column. The
              NB. leading diagonal element of the remainder
              NB. can also be zero, so this may have to be
              NB. done repeatedly.
              if. ilazro +. ilazr2 do.
                jch=. j
                lios=. (>: ilastm) th2lios j
                while. jch < ilast do.
                  'y cs'=. rot&.|: rotga y ; (< 0 ; lios ; (jch + 0 1)) ; 0
                  lios=. }. lios
                  y=. (< 1 ; lios ; (jch + 0 1)) cs&(rot&.|:) upd y
                  dZ1=. dZ1 , (+ cs) , jch + 0 1
                  if. ilazr2 do.
                    y=. (< 0 , jch - 1 0) *&({. cs) upd y
                    ilazr2=. 0
                  end.
                  if. btol <: sorim (< 1 , jch + 1 1) { y do.
                    if. ilast > >: jch do.
                      ifirst=. >: jch
                      goto60=. 0
                    end.
                    goto_l60.
                  end.
                  y=. 0 (< 1 , jch + 1 1) } y
                  jch=. >: jch
                end.
              else.
                NB. Only test 2 passed - chase the zero to
                NB. T[ilast,ilast], then process as in the
                NB. case T[ilast,ilast]=0
                jch=. j
                liosr=. (>: ilastm) th2lios <: j
                liosc=. (2 + j) th2lios ifrstm
                while. jch < ilast do.
                  'y cs'=. rot&.|: rotga y ; (< 1 ; (2 }. liosr) ; (jch + 0 1)) ; 0
                  y=. (< 0 ; liosr ; (jch + 0 1)) cs&(rot&.|:) upd y
                  dZ1=. dZ1 , (+ cs) , jch + 0 1
                  'y cs'=. rot rotga y ; (< 0 ; (jch - 0 1) ; liosc) ; < < a: ; _1
                  y=. (< 1 ; (jch - 0 1) ; (_2 }. liosc)) cs&rot upd y
                  dQ1=. dQ1 , cs , jch - 0 1
                  liosr=. }. liosr
                  liosc=. liosc , 2 + jch
                  jch=. >: jch
                end.
              end.
              goto_l50.
            elseif. ilazro do.
              ifirst=. j
              goto60=. 0
              goto_l60.
            end.
            j=. <: j
          end.
          NB. drop-through is impossible
          ((< _.) setdiag"2 y) ; ,~ a:  NB. set all eigenvalues to NaN
          return.
        else.
          y=. 0 (< 1 , ,~ ilast) } y
        end.
        label_l50.
        NB. T[ilast,ilast]=0 - clear H[ilast-1,ilast] to
        NB. split off a 1x1 block
        lios=. (>: ilast) th2lios ifrstm
        'y cs'=. rot rotga y ; (< 0 ; (ilast - 0 1) ; lios) ; < < a: ; _1
        y=. (< 1 ; (ilast - 0 1) ; (}: lios)) cs&rot upd y
        dQ1=. dQ1 , cs , ilast - 0 1
      else.
        y=. 0 (< 0 , ilast - 1 0) } y
      end.
    end.
    label_l60.
    if. goto60 do.
      NB. H[ilast-1,ilast]=0 - standartize B, set alpha and
      NB. beta
      'y signbc'=. (ilast , 1) hgezqxo y  NB. process ilast-th eigenvalue (column)
      dQ1=. dQ1 , 4 {."1 signbc ,. ilast
      NB. goto next block - exit if finished
      ilast=. <: ilast
      if. ilast < h do.
        NB. normal exit
        'y signbc'=. (0 , 0 >. <: h) hgezqxo y  NB. process eigenvalues (columns) 0:h-1
        dQ1=. dQ1 , 4 {."1 signbc ,. i. 0 >. <: h
        y ; dQ1 ; dZ1
        return.
      end.
      NB. reset counters
      iiter=. 0
      eshift=. 0
      'ifrstm ilastm'=. (h , ilast) reset (ifrstm , ilastm)
    else.
      NB. ZQ step
      NB. This iteration only involves rows/columns
      NB. ifirst:ilast. We assume ifirst<ilast, and that the
      NB. diagonal of B is non-zero
      iiter=. >: iiter
      ifrstm=. ifirst step ifrstm
      NB. Compute the shift.
      NB. At this point, ifirst<ilast, and the diagonal
      NB. elements of T[ifirst:ilast,ifirst:ilast] are larger
      NB. than btol in magnitude
      if. 10 | iiter do.
        NB. The Wilkinson shift, i.e., the eigenvalues of the
        NB. bottom-right 2x2 block of T^_1*H which is nearest
        NB. to the bottom-right element.
        NB. We factor T as D*L, where L is unit lower
        NB. triangular, and compute L^_1*(D^_1*H)
        'L21 DA11 DA12 DA21 DA22'=. %/ (6 0 1 2 3 ,: 7 4 4 7 7) ({,) abscale * ((< a: ; ;~ ilast - 1 0) { y)
        IBA22=. DA22 - L21 * DA12
        t1=. -: DA11 + IBA22
        rtdisc=. %: (t1 , DA21 , -DA11) mp (t1 , DA12 , DA22)
        temp=. +/ (*/) +. rtdisc , t1 - IBA22
        shift=. t1 - temp negneg rtdisc
      else.
        NB. Exceptional shift. Chosen for no paticularly good
        NB. reason
        eshift=. eshift + + %/ abscale * (;/ 0 1 ,. (0 _1 ,: _1 _1) + ilast) { y
        shift=. eshift
      end.
      NB. now check for two consecutive small subdiagonals
      HTd=. (0 1 ,"0 1 ilast (] , -) ifirst) diag"1 2/ y
      ctemp=. (- (shift&*))/ abscale * {. HTd
      temp=. (sorim }."1 ctemp) ,: ascale * sorim (< 1 ; 0 ; <<0) { HTd
      tempr=. >./ temp
      temp=. temp %"1 ((0 , 1 - FP_EPS) I. tempr) } 1 , tempr ,: 1
      'istart ctemp'=. (+&ifirst , {&ctemp) (ilast - ifirst) | >: (>:/ temp * atol ,: sorim (< 1 ; 0 ; <<_1) { HTd) i: 1
      NB. do an implicit-shift ZQ sweep
      NB. initial Z
      cs=. lartg ctemp , ascale * (< 0 , istart + 0 1) { y
      NB. sweep
      j=. istart
      liosr=. (>: ilastm) th2lios j
      liosc=. (j + 2) th2lios ifrstm
      while. j < ilast do.
        lios=. j + 0 1
        NB. is a first iteration?
        if. j = istart do.
          y=. (< a: ; liosr ; lios) cs&(rot&.|:)"2 upd y
        else.
          'y cs'=. rot&.|: rotga y ; (< 0 ; liosr ; lios) ; 0
          liosr=. }. liosr
          y=. (< 1 ; liosr ; lios) cs&(rot&.|:) upd y
        end.
        dZ1=. dZ1 , (+ cs) , lios
        lios=. j + 1 0
        'y cs'=. rot rotga y ; (< 1 ; lios ; liosc) ; < < a: ; _1
        NB. isn't a last iteration?
        if. j < <: ilast do.
          liosc=. liosc , j + 2
        end.
        y=. (< 0 ; lios ; liosc) cs&rot upd y
        dQ1=. dQ1 , cs , lios
        j=. >: j
      end.
    end.
    jiter=. >: jiter
  end.
  NB. drop-through means non-convergence, set incorrect eigenvalues 0:ilast to NaN
  ((_. ; 0 0 , >: ilast) setdiag"2 y) ; dQ1 ; dZ1
)

hgeqz=: 1 : 0
:
  '`hgeqzxo init reset step'=. m
  e=. +/ 'h s'=. x
  dQ1=. dZ1=. 0 4 $ 0
  abnorm=. (0 2 ,. ,.~ x) norms"2 ;. 0 y
  'atol btol'=. abtol=. FP_SFMIN >. FP_PREC * abnorm
  'ascale bscale'=. abscale=. % FP_SFMIN >. abnorm
  'y signbc'=. ((c y) (] , -) e) hgeqzxo y  NB. process eigenvalues (columns) h+s:n-1
  dZ1=. dZ1 , 4 {."1 signbc ,. (c y) th2lios e

  NB. Eigenvalues h+s:n-1 have been found.

  NB. Initialize dynamic indices
  ilast=. <: e
  'ifrstm ilastm'=. (h , ilast) init (0 , <: c y)
                  NB. ifrstm - the row of the last splitting
                  NB.          row above row ilast, this is
                  NB.          always at least h
  iiter=. 0       NB. counts iterations since the last
                  NB. eigenvalue was found, to tell when to
                  NB. use an extraordinary shift
  eshift=. 0
  maxit=. 30 * s  NB. the maximum number of QZ sweep allowed
  jiter=. 0

  NB. Main QZ iteration loop
  NB. Column operations modify rows ifrstm:*
  NB. Row operations modify columns *:ilastm
  while. jiter < maxit do.
    goto60=. 1  NB. set default branching
    NB. split the matrix if possible, by to tests:
    NB.   1. H[j,j-1]=0 OR j=h
    NB.   2. T[j,j]=0
    if. ilast ~: h do.
      if. atol < sorim (< 0 , ilast - 0 1) { y do.
        if. btol < | (< 1 , ,~ ilast) { y do.
          NB. general case: j < ilast
          j=. <: ilast
          while. j >: h do.
            NB. test 1: H[j,j-1]=0 OR j=h
            if. j = h do.
              ilazro=. 1
            elseif. atol >: sorim (< 0 , j - 0 1) { y do.
              y=. 0 (< 0 , j - 0 1) } y
              ilazro=. 1
            elseif. do.
              ilazro=. 0
            end.
            NB. test 2: T[j,j]=0
            if. btol > | (< 1 , ,~ j) { y do.
              y=. 0 (< 1 , ,~ j) } y
              NB. test 2a: check for 2 consecutive small
              NB. subdiagonals in H
              ilazr2=. 0
              if. -. ilazro do.
                'Hjj1 Hj1j Hjj'=. sorim ((<"1) 0 ,. (0 _1,1 0,:0 0) + j) { y
                if. 0 >: (Hjj1 , Hjj) mp (ascale * (Hj1j , -atol)) do.
                  ilazr2=. 1
                end.
              end.
              NB. If both tests (1 & 2) pass, i.e., the
              NB. leading diagonal element of T in the block
              NB. is zero, then split a 1x1 block off at the
              NB. top, i.e. at the j-th row/column. The
              NB. leading diagonal element of the remainder
              NB. can also be zero, so this may have to be
              NB. done repeatedly.
              if. ilazro +. ilazr2 do.
                jch=. j
                lios=. (>: ilastm) th2lios j
                while. jch < ilast do.
                  'y cs'=. rot rotga y ; (< 0 ; (jch + 0 1) ; lios) ; < < a: ; 0
                  lios=. }. lios
                  y=. (< 1 ; (jch + 0 1) ; lios) cs&rot upd y
                  dQ1=. dQ1 , (+ cs) , jch + 0 1
                  if. ilazr2 do.
                    y=. (< 0 , jch - 0 1) *&({. cs) upd y
                    ilazr2=. 0
                  end.
                  if. btol <: sorim (< 1 , jch + 1 1) { y do.
                    if. ilast > >: jch do.
                      ifirst=. >: jch
                      goto60=. 0
                    end.
                    goto_u60.
                  end.
                  y=. 0 (< 1 , jch + 1 1) } y
                  jch=. >: jch
                end.
              else.
                NB. Only test 2 passed - chase the zero to
                NB. T[ilast,ilast], then process as in the
                NB. case T[ilast,ilast]=0
                jch=. j
                liosc=. (>: ilastm) th2lios <: j
                liosr=. (2 + j) th2lios ifrstm
                while. jch < ilast do.
                  'y cs'=. rot rotga y ; (< 1 ; (jch + 0 1) ; (2 }. liosc)) ; < < a: ; 0
                  y=. (< 0 ; (jch + 0 1) ; liosc) cs&rot upd y
                  dQ1=. dQ1 , (+ cs) , jch + 0 1
                  'y cs'=. rot&.|: rotga y ; (< 0 ; liosr ; (jch - 0 1)) ; _1
                  y=. (< 1 ; (_2 }. liosr) ; (jch - 0 1)) cs&(rot&.|:) upd y
                  dZ1=. dZ1 , cs , jch - 0 1
                  liosc=. }. liosc
                  liosr=. liosr , 2 + jch
                  jch=. >: jch
                end.
              end.
              goto_u50.
            elseif. ilazro do.
              ifirst=. j
              goto60=. 0
              goto_u60.
            end.
            j=. <: j
          end.
          NB. drop-through is impossible
          ((< _.) setdiag"2 y) ; ,~ a:  NB. set all eigenvalues to NaN
          return.
        else.
          y=. 0 (< 1 , ,~ ilast) } y
        end.
        label_u50.
        NB. T[ilast,ilast]=0 - clear H[ilast,ilast-1] to
        NB. split off a 1x1 block
        lios=. (>: ilast) th2lios ifrstm
        'y cs'=. rot&.|: rotga y ; (< 0 ; lios ; (ilast - 0 1)) ; _1
        y=. (< 1 ; (}: lios) ; (ilast - 0 1)) cs&(rot&.|:) upd y
        dZ1=. dZ1 , cs , ilast - 0 1
      else.
        y=. 0 (< 0 , ilast - 0 1) } y
      end.
    end.
    label_u60.
    if. goto60 do.
      NB. H[ilast,ilast-1]=0 - standartize B, set alpha and
      NB. beta
      'y signbc'=. (ilast , 1) hgeqzxo y  NB. process ilast-th eigenvalue (column)
      dZ1=. dZ1 , 4 {."1 signbc ,. ilast
      NB. goto next block - exit if finished
      ilast=. <: ilast
      if. ilast < h do.
        NB. normal exit
        'y signbc'=. (0 , 0 >. <: h) hgeqzxo y  NB. process eigenvalues (columns) 0:h-1
        dZ1=. dZ1 , 4 {."1 signbc ,. i. 0 >. <: h
        y ; dQ1 ; dZ1
        return.
      end.
      NB. reset counters
      iiter=. 0
      eshift=. 0
      'ifrstm ilastm'=. (h , ilast) reset (ifrstm , ilastm)
    else.
      NB. QZ step
      NB. This iteration only involves rows/columns
      NB. ifirst:ilast. We assume ifirst<ilast, and that the
      NB. diagonal of B is non-zero
      iiter=. >: iiter
      ifrstm=. ifirst step ifrstm
      NB. Compute the shift.
      NB. At this point, ifirst<ilast, and the diagonal
      NB. elements of T[ifirst:ilast,ifirst:ilast] are larger
      NB. than btol in magnitude
      if. 10 | iiter do.
        NB. The Wilkinson shift, i.e., the eigenvalues of the
        NB. bottom-right 2x2 block of H*T^_1 which is nearest
        NB. to the bottom-right element.
        NB. We factor T as U*D, where U is unit upper
        NB. triangular, and compute (H*D^_1)*U^_1
        'U12 AD11 AD21 AD12 AD22'=. %/ (5 0 2 1 3 ,: 7 4 4 7 7) ({,) abscale * ((< a: ; ;~ ilast - 1 0) { y)
        ABI22=. AD22 - U12 * AD21
        t1=. -: AD11 + ABI22
        rtdisc=. %: (t1 , AD12 , -AD11) mp (t1 , AD21 , AD22)
        temp=. +/ (*/) +. rtdisc , t1 - ABI22
        shift=. t1 - temp negneg rtdisc
      else.
        NB. Exceptional shift. Chosen for no paticularly good
        NB. reason
        eshift=. eshift + + %/ abscale * (;/ 0 1 ,. (_1 0 ,: _1 _1) + ilast) { y
        shift=. eshift
      end.
      NB. now check for two consecutive small subdiagonals
      HTd=. (0 _1 ,"0 1 ilast (] , -) ifirst) diag"1 2/ y
      ctemp=. (- (shift&*))/ abscale * {. HTd
      temp=. (sorim }."1 ctemp) ,: ascale * sorim (< 1 ; 0 ; <<0) { HTd
      tempr=. >./ temp
      temp=. temp %"1 ((0 , 1 - FP_EPS) I. tempr) } 1 , tempr ,: 1
      'istart ctemp'=. (+&ifirst , {&ctemp) (ilast - ifirst) | >: (>:/ temp * atol ,: sorim (< 1 ; 0 ; <<_1) { HTd) i: 1
      NB. do an implicit-shift QZ sweep
      NB. initial Q
      cs=. lartg ctemp , ascale * (< 0 , istart + 1 0) { y
      NB. sweep
      j=. istart
      liosc=. (>: ilastm) th2lios j
      liosr=. (j + 2) th2lios ifrstm
      while. j < ilast do.
        lios=. j + 0 1
        NB. is a first iteration?
        if. j = istart do.
          y=. (< a: ; lios ; liosc) cs&rot"2 upd y
        else.
          'y cs'=. rot rotga y ; (< 0 ; lios ; liosc) ; < < a: ; 0
          liosc=. }. liosc
          y=. (< 1 ; lios ; liosc) cs&rot upd y
        end.
        dQ1=. dQ1 , (+ cs) , lios
        lios=. j + 1 0
        'y cs'=. rot&.|: rotga y ; (< 1 ; liosr ; lios) ; _1
        NB. isn't a last iteration?
        if. j < <: ilast do.
          liosr=. liosr , j + 2
        end.
        y=. (< 0 ; liosr ; lios) cs&(rot&.|:) upd y
        dZ1=. dZ1 , cs , lios
        j=. >: j
      end.
    end.
    jiter=. >: jiter
  end.
  NB. drop-through means non-convergence, set incorrect eigenvalues 0:ilast to NaN
  ((_. ; 0 0 , >: ilast) setdiag"2 y) ; dQ1 ; dZ1
)

NB. ---------------------------------------------------------
NB. hgezqe
NB. hgezqs
NB. hgeqze
NB. hgeqzs
NB.
NB. Description:
NB.   Shortcuts, see hgeqzxxxx
NB.
NB. Syntax:
NB.   'HTupd dQ1 dZ1'=. hs hgexxx HT

hgezqe=: hgexxeo`[`(2 1&{@,`[@.((<{:)~{.))`[ hgezq
hgezqs=: hgezqso`]`]                      `] hgezq

hgeqze=: hgexxeo`[`(2 1&{@,`[@.((<{:)~{.))`[ hgeqz
hgeqzs=: hgeqzso`]`]                      `] hgeqz

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. hgezqenn
NB. hgezqenv
NB. hgezqevn
NB. hgezqevv
NB. hgezqsnn
NB. hgezqsnv
NB. hgezqsvn
NB. hgezqsvv
NB.
NB. Description:
NB.   Compute eigenvalues (hgezqxxx) and reduce to
NB.   generalized Schur form (hgezqsxx):
NB.     dQ1^H * S * dZ1 = H
NB.     dQ1^H * P * dZ1 = T
NB.   the generalized lower Hessenberg form (H,T) using
NB.   single-shift ZQ method. Matrix pairs of this type are
NB.   produced by the reduction to generalized lower
NB.   Hessenberg form of a matrix pair (A,B):
NB.     Q1^H * H * Z1 = A
NB.     Q1^H * T * Z1 = B
NB.   as computed by gghrdlxx. The unitary (orthogonal)
NB.   matrices dQ1 and dZ1 may either be formed explicitly,
NB.   or they may be postmultiplied by input matrices Q1 and
NB.   Z1, so that:
NB.     (dQ1*Q1)^H * S * (dZ1*Z1) = Q1^H * H * Z1
NB.     (dQ1*Q1)^H * P * (dZ1*Z1) = Q1^H * T * Z1
NB.   To avoid overflow, eigenvalues of the matrix pair (H,T)
NB.   (equivalently, of (A,B)) are computed as a pair of
NB.   values. Each i-th eigenvector (row) from L and
NB.   R has a corresponding eigenvalue represented as a pair
NB.   of i-th elements from vectors e1 and e2:
NB.     E1=. diagmat e1=. diag S
NB.     E2=. diagmat e2=. diag P
NB.   If E2 is nonsingular then:
NB.     E=. diagmat e1%e2
NB.   is a diagonal matrix of eigenvalues, and GNEP can be
NB.   expressed as:
NB.     L * A = E * L * B
NB.     A * R^H = B * R^H * E
NB.   and if E1 is nonsingular then:
NB.     E=. diagmat e2%e1
NB.   is a diagonal matrix of eigenvalues, and GNEP can be
NB.   expressed as:
NB.     E * L * A = L * B
NB.     A * R^H * E = B * R^H * E
NB.
NB. Syntax:
NB.   e1e2=.        hs hgezqenn H ,: T
NB.   'e1e2 Z2'=.   hs hgezqenv H , T ,: Z1
NB.   'e1e2 Q2'=.   hs hgezqevn H , T ,: Q1
NB.   'e1e2 Q2Z2'=. hs hgezqevv H , T , Q1 ,: Z1
NB.   'S P'=.       hs hgezqsnn H ,: T
NB.   'S P Z2'=.    hs hgezqsnv H , T ,: Z1
NB.   'S P Q2'=.    hs hgezqsvn H , T ,: Q1
NB.   'S P Q2 Z2'=. hs hgezqsvv H , T , Q1 ,: Z1
NB. where
NB.   hs   - 2-vector of integers (h,s) 'head' and 'size',
NB.          defines submatrices H11 and T11 position in H
NB.          and T, respectively, see ggballp and gehrdl
NB.   H    - n×n-matrix, lower Hessenberg inside the
NB.          submatrix H[h:h+s-1,h:h+s-1], and lower
NB.          triangular outside
NB.   T    - n×n-matrix, lower triangular
NB.   e1e2 - 2×n-matrix of eigenvalues e1 and e2:
NB.            e1e2 -: e1 ,: e2
NB.   Q1   - n×n-matrix, the unitary (orthogonal)
NB.   Q2   - n×n-matrix, the unitary (orthogonal)
NB.   Z1   - n×n-matrix, the unitary (orthogonal)
NB.   Z2   - n×n-matrix, the unitary (orthogonal)
NB.   Q2Z2 -: Q2 ,: Z2
NB.   S    - n×n-matrix, lower triangular
NB.   P    - n×n-matrix, lower triangular
NB.
NB. Notes:
NB. - non-converged eigenvalues are set to NaN
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   e1e2     -: diag"2 (S ,: P)
NB.   Q2       -: dQ1 mp Q1
NB.   Z2       -: dZ1 mp Z1
NB.   (H ,: T) -: dQ1 (mp~ ct)~"2 (S ,: P) mp"2 dZ1
NB.   (C ,: D) -: Q2 (mp~ ct)~"2 (S ,: P) mp"2 Z2
NB. where
NB.   C - n×n-matrix, general
NB.   D - n×n-matrix, general
NB.   n=. # C
NB.   hs=. 0 , n
NB.   I=. idmat n
NB.   'B Z0'=. (trl@:(}:"1) ,: unglq)@gelqf D
NB.   A=. C (mp ct) Z0
NB.   'H T Q1 Z1'=. hs gghrdlvv A , B , I ,: Z0
NB.   e1e2=. hs hgezqenn H ,: T
NB.   'S P Q2 Z2'=. hs hgezqsvv H , T , Q1 ,: Z1
NB.   'S P dQ1 dZ1'=. hs hgezqsvv H , T , ,:~ I
NB.
NB. Application:
NB. - detect case of non-convergence (0=converged,
NB.   1=non-converged), any of:
NB.     128!:5 < e1e2
NB.     128!:5 < S,:P         NB. too expensive, use the next
NB.     128!:5 < diag"2 S,:P

hgezqenn=:            diag"2@(0 {::                            hgezqe     )
hgezqenv=: (2 {  ]) ((diag"2@(0 {:: ])) ; (rotscll  2&{::  )) (hgezqe 2&{.)
hgezqevn=: (2 {  ]) ((diag"2@(0 {:: ])) ; (rotscll  1&{::  )) (hgezqe 2&{.)
hgezqevv=: (2 }. ]) ((diag"2@(0 {:: ])) ; (rotscll"2&.:> }.)) (hgezqe 2&{.)

hgezqsnn=:                    0 {::                            hgezqs
hgezqsnv=: (2 {  ]) ((       (0 {:: ])) , (rotscll  2&{::  )) (hgezqs 2&{.)
hgezqsvn=: (2 {  ]) ((       (0 {:: ])) , (rotscll  1&{::  )) (hgezqs 2&{.)
hgezqsvv=: (2 }. ]) ((       (0 {:: ])) , (rotscll"2&: > }.)) (hgezqs 2&{.)

NB. ---------------------------------------------------------
NB. hgeqzenn
NB. hgeqzenv
NB. hgeqzevn
NB. hgeqzevv
NB. hgeqzsnn
NB. hgeqzsnv
NB. hgeqzsvn
NB. hgeqzsvv
NB.
NB. Description:
NB.   Compute eigenvalues (hgeqzxxx) and reduce to
NB.   generalized Schur form (hgeqzsxx):
NB.     dQ1 * S * dZ1^H = H
NB.     dQ1 * P * dZ1^H = T
NB.   the generalized upper Hessenberg form (H,T) using
NB.   single-shift QZ method. Matrix pairs of this type are
NB.   produced by the reduction to generalized upper
NB.   Hessenberg form of a matrix pair (A,B):
NB.     Q1 * H * Z1^H = A
NB.     Q1 * T * Z1^H = B
NB.   as computed by gghrduxx. The unitary (orthogonal)
NB.   matrices dQ1 and dZ1 may either be formed explicitly,
NB.   or they may be premultiplied by input matrices Q1 and
NB.   Z1, so that:
NB.     (Q1*dQ1) * S * (Z1*dZ1)^H = Q1 * H * Z1^H
NB.     (Q1*dQ1) * P * (Z1*dZ1)^H = Q1 * T * Z1^H
NB.   To avoid overflow, eigenvalues of the matrix pair (H,T)
NB.   (equivalently, of (A,B)) are computed as a pair of
NB.   values. Each i-th eigenvector (column) from L and
NB.   R has a corresponding eigenvalue represented as a pair
NB.   of i-th elements from vectors e1 and e2:
NB.     E1=. diagmat e1=. diag S
NB.     E2=. diagmat e2=. diag P
NB.   If E2 is nonsingular then:
NB.     E=. diagmat e1%e2
NB.   is a diagonal matrix of eigenvalues, and GNEP can be
NB.   expressed as:
NB.     L^H * A = E * L^H * B
NB.     A * R = B * R * E
NB.   and if E1 is nonsingular then:
NB.     E=. diagmat e2%e1
NB.   is a diagonal matrix of eigenvalues, and GNEP can be
NB.   expressed as:
NB.     E * L^H * A = L^H * B
NB.     A * R * E = B * R * E
NB.
NB. Syntax:
NB.   e1e2=.        hs hgeqzenn H ,: T
NB.   'e1e2 Z2'=.   hs hgeqzenv H , T ,: Z1
NB.   'e1e2 Q2'=.   hs hgeqzevn H , T ,: Q1
NB.   'e1e2 Q2Z2'=. hs hgeqzevv H , T , Q1 ,: Z1
NB.   'S P'=.       hs hgeqzsnn H ,: T
NB.   'S P Z2'=.    hs hgeqzsnv H , T ,: Z1
NB.   'S P Q2'=.    hs hgeqzsvn H , T ,: Q1
NB.   'S P Q2 Z2'=. hs hgeqzsvv H , T , Q1 ,: Z1
NB. where
NB.   hs   - 2-vector of integers (h,s) 'head' and 'size',
NB.          defines submatrices H11 and T11 position in H
NB.          and T, respectively, see ggbalup and gehrdu
NB.   H    - n×n-matrix, upper Hessenberg inside the
NB.          submatrix H[h:h+s-1,h:h+s-1], and upper
NB.          triangular outside
NB.   T    - n×n-matrix, upper triangular
NB.   e1e2 - 2×n-matrix of eigenvalues e1 and e2:
NB.            e1e2 -: e1 ,: e2
NB.   Q1   - n×n-matrix, the unitary (orthogonal)
NB.   Q2   - n×n-matrix, the unitary (orthogonal)
NB.   Z1   - n×n-matrix, the unitary (orthogonal)
NB.   Z2   - n×n-matrix, the unitary (orthogonal)
NB.   Q2Z2 -: Q2 ,: Z2
NB.   S    - n×n-matrix, upper triangular
NB.   P    - n×n-matrix, upper triangular
NB.
NB. Notes:
NB. - non-converged eigenvalues are set to NaN
NB. - hgeqzenn models LAPACK's xHGEQZ('E','N','N')
NB. - hgeqzenv models LAPACK's xHGEQZ('E','N','V')
NB. - hgeqzevn models LAPACK's xHGEQZ('E','V','N')
NB. - hgeqzevv models LAPACK's xHGEQZ('E','V','V')
NB. - hgeqzsnn models LAPACK's xHGEQZ('S','N','N')
NB. - hgeqzsnv models LAPACK's xHGEQZ('S','N','V')
NB. - hgeqzsvn models LAPACK's xHGEQZ('S','V','N')
NB. - hgeqzsvv models LAPACK's xHGEQZ('S','V','V')
NB.
NB. Assertions (with appropriate comparison tolerance):
NB.   e1e2     -: diag"2 (S ,: P)
NB.   Q2       -: Q1 mp dQ1
NB.   Z2       -: Z1 mp dZ1
NB.   (H ,: T) -: dQ1 mp"2 (S ,: P) (mp ct)"2 dZ1
NB.   (C ,: D) -: Q2 mp"2 (S ,: P) (mp ct)"2 Z2
NB. where
NB.   C - n×n-matrix, general
NB.   D - n×n-matrix, general
NB.   n=. # C
NB.   hs=. 0 , n
NB.   I=. idmat n
NB.   'Q0 B'=. (ungqr ,: tru@}:)@geqrf D
NB.   A=. Q0 (mp~ ct)~ C
NB.   'H T Q1 Z1'=. hs gghrduvv A , B , Q0 ,: I
NB.   e1e2=. hs hgeqzenn H ,: T
NB.   'S P Q2 Z2'=. hs hgeqzsvv H , T , Q1 ,: Z1
NB.   'S P dQ1 dZ1'=. hs hgeqzsvv H , T , ,:~ I
NB.
NB. Application:
NB. - model LAPACK's xHGEQZ('E','N','I'):
NB.     NB. 'e1e2 dZ1'=. hs hgeqzeni H ,: T
NB.     hgeqzeni=: hgeqzenv (, idmat@c)
NB. - model LAPACK's xHGEQZ('E','I','N'):
NB.     NB. 'e1e2 dQ1'=. hs hgeqzein H ,: T
NB.     hgeqzein=: hgeqzevn (, idmat@c)
NB. - model LAPACK's xHGEQZ('E','I','I'):
NB.     NB. 'e1e2 dQ1dZ1'=. hs hgeqzeii H ,: T
NB.     hgeqzeii=: hgeqzevv (,~^:2~ idmat@c)
NB. - model LAPACK's xHGEQZ('E','I','V'):
NB.     NB. 'e1e2 dQ1Z2'=. hs hgeqzeiv H , T ,: Z1
NB.     hgeqzeiv=: hgeqzevv (1&A.@, idmat@c)
NB. - model LAPACK's xHGEQZ('E','V','I'):
NB.     NB. 'e1e2 Q2dZ1'=. hs hgeqzevi H , T ,: Q1
NB.     hgeqzevi=: hgeqzevv (, idmat@c)
NB. - model LAPACK's xHGEQZ('S','N','I'):
NB.     NB. 'S P dZ1'=. hs hgeqzsni H ,: T
NB.     hgeqzsni=: hgeqzsnv (, idmat@c)
NB. - model LAPACK's xHGEQZ('S','I','N'):
NB.     NB. 'S P dQ1'=. hs hgeqzsin H ,: T
NB.     hgeqzsin=: hgeqzsvn (, idmat@c)
NB. - model LAPACK's xHGEQZ('S','I','I'):
NB.     NB. 'S P dQ1 dZ1'=. hs hgeqzsii H ,: T
NB.     hgeqzsii=: hgeqzsvv (,~^:2~ idmat@c)
NB. - model LAPACK's xHGEQZ('S','I','V'):
NB.     NB. 'S P dQ1 Z2'=. hs hgeqzsiv H , T ,: Z1
NB.     hgeqzsiv=: hgeqzsvv (1&A.@, idmat@c)
NB. - model LAPACK's xHGEQZ('S','V','I'):
NB.     NB. 'S P Q2 dZ1'=. hs hgeqzsvi H , T ,: Q1
NB.     hgeqzsvi=: hgeqzsvv (, idmat@c)
NB. - detect case of non-convergence (0=converged,
NB.   1=non-converged), any of:
NB.     128!:5 < e1e2
NB.     128!:5 < S,:P         NB. too expensive, use the next
NB.     128!:5 < diag"2 S,:P
NB.
NB. References:
NB. [1] C.B. Moler & G.W. Stewart, "An Algorithm for
NB.     Generalized Matrix Eigenvalue Problems",
NB.     SIAM J. Numer. Anal., 10(1973), pp. 241-256.

hgeqzenn=:            diag"2@(0 {::                            hgeqze     )
hgeqzenv=: (2 {  ]) ((diag"2@(0 {:: ])) ; (rotsclu  2&{::  )) (hgeqze 2&{.)
hgeqzevn=: (2 {  ]) ((diag"2@(0 {:: ])) ; (rotsclu  1&{::  )) (hgeqze 2&{.)
hgeqzevv=: (2 }. ]) ((diag"2@(0 {:: ])) ; (rotsclu"2&.:> }.)) (hgeqze 2&{.)

hgeqzsnn=:                    0 {::                            hgeqzs
hgeqzsnv=: (2 {  ]) ((       (0 {:: ])) , (rotsclu  2&{::  )) (hgeqzs 2&{.)
hgeqzsvn=: (2 {  ]) ((       (0 {:: ])) , (rotsclu  1&{::  )) (hgeqzs 2&{.)
hgeqzsvv=: (2 }. ]) ((       (0 {:: ])) , (rotsclu"2&: > }.)) (hgeqzs 2&{.)

NB. =========================================================
NB. Test suite

NB. ---------------------------------------------------------
NB. testhgeq
NB.
NB. Description:
NB.   Test ZQ and QZ algorithms hgexxxxx by general matrices
NB.   given
NB.
NB. Syntax:
NB.   testhgeq AB
NB. where
NB.   AB - 2×n×n-report
NB.
NB. Formula:
NB.   berr := max(berr0,berr1,berr2,berr3)
NB. where
NB.   ||M|| := max(||M||_1 , FP_SFMIN)
NB.   'S P dQ1 dZ1'=. (0,n) hgexxsvv H , T , ,:~ I
NB.   - hgezqxxx:
NB.       berr0 := ||H - dQ1^H * S * dZ1|| / (FP_PREC * ||H|| * n)
NB.       berr1 := ||T - dQ1^H * P * dZ1|| / (FP_PREC * ||T|| * n)
NB.       berr2 := ||I - dQ1^H * dQ1|| / (FP_PREC * n)
NB.       berr3 := ||I - dZ1^H * dZ1|| / (FP_PREC * n)
NB.   - hgeqzxxx:
NB.       berr0 := ||H - dQ1 * S * dZ1^H|| / (FP_PREC * ||H|| * n)
NB.       berr1 := ||T - dQ1 * P * dZ1^H|| / (FP_PREC * ||T|| * n)
NB.       berr2 := ||I - dQ1 * dQ1^H|| / (FP_PREC * n)
NB.       berr3 := ||I - dZ1 * dZ1^H|| / (FP_PREC * n)

testhgeq=: 3 : 0
  prep=. (,~ <@(2&{.))~ _2&(<\)                                                                   NB. L,R: 'HT SP dQ1dZ1'=. (H,T,I,:I) prep (S,P,dQ1,:dZ1)
  safenorm=. FP_SFMIN >. norm1"2                                                                  NB. compute 1-norm safely: ||M|| := max(||M||_1 , FP_SFMIN)
  cdiff1=: 2 : '(0&{::) safenorm@:- ((((u@{.@]) mp"2 (mp"2 (v@{:)))&>/)@}.)'                      NB. L: (ct cdiff1 ]) : ||H - dQ1^H * S * dZ1|| , ||T - dQ1^H * P * dZ1||
                                                                                                  NB. R: (] cdiff1 ct) : ||H - dQ1 * S * dZ1^H|| , ||T - dQ1 * P * dZ1^H||
  adiff2=: 1 : '(safenorm@(<: upddiag)@(u ct)"2)@(2&{::)'                                         NB. L: (mp~ adiff2) : ||I - dQ1^H * dQ1|| , ||I - dZ1^H * dZ1||
                                                                                                  NB. R: (mp  adiff2) : ||I - dQ1 * dQ1^H|| , ||I - dZ1 * dZ1^H||
  denom1=. safenorm@(0&{::)                                                                       NB. ||H|| , ||T||
  getn=. c@(0&{::)                                                                                NB. n
  safediv=. ((({:<.(%/@}:))`((<./@(}:*(1,{:)))%(1&{))@.(1>(1&{)))`(%/@}:)@.(</@}:))%(FP_PREC*{:)  NB. compute u%d safely: u_by_d=. safediv (u,d,n)
  cberr01=. 2 : 'safediv"1@:((u cdiff1 v) ,. denom1 ,. getn)'                                     NB. L: (ct cberr01 ]) : (berr0 , berr1) for L
                                                                                                  NB. R: (] cberr01 ct) : (berr0 , berr1) for R
  aberr23=. 1 : '((<. (u adiff2))~ % (FP_PREC * ])) getn'                                         NB. L: (mp~ aberr23) : (berr2 , berr3) for L
                                                                                                  NB. R: (mp  aberr23) : (berr2 , berr3) for R
  vberrl=: (>./@((ct cberr01 ]) , (mp~ aberr23))@prep) f.
  vberru=: (>./@((] cberr01 ct) , (mp  aberr23))@prep) f.

  I=. idmat c y
  HTl=. (gghrdlnn~ (0,c))@((,: trl)/) y
  HTu=. (gghrdunn~ (0,c))@((,: tru)/) y
  rcondl=. <./ 0 1 (gecon1&.{.)`(trlcon1&.{.) ag HTl
  rcondu=. <./ 0 1 (gecon1&.{.)`(trucon1&.{.) ag HTu

  ('hgezqenn' tdyad ((0,c)`]`]`(rcondl"_)`(_."_)`(_."_))) HTl
  ('hgezqenv' tdyad ((0,c)`]`]`(rcondl"_)`(_."_)`(_."_))) HTl , I
  ('hgezqevn' tdyad ((0,c)`]`]`(rcondl"_)`(_."_)`(_."_))) HTl , I
  ('hgezqevv' tdyad ((0,c)`]`]`(rcondl"_)`(_."_)`(_."_))) HTl , ,:~ I
  ('hgezqsnn' tdyad ((0,c)`]`]`(rcondl"_)`(_."_)`(_."_))) HTl
  ('hgezqsnv' tdyad ((0,c)`]`]`(rcondl"_)`(_."_)`(_."_))) HTl , I
  ('hgezqsvn' tdyad ((0,c)`]`]`(rcondl"_)`(_."_)`(_."_))) HTl , I
  ('hgezqsvv' tdyad ((0,c)`]`]`(rcondl"_)`(_."_)`vberrl)) HTl , ,:~ I
  ('hgeqzenn' tdyad ((0,c)`]`]`(rcondu"_)`(_."_)`(_."_))) HTu
  ('hgeqzenv' tdyad ((0,c)`]`]`(rcondu"_)`(_."_)`(_."_))) HTu , I
  ('hgeqzevn' tdyad ((0,c)`]`]`(rcondu"_)`(_."_)`(_."_))) HTu , I
  ('hgeqzevv' tdyad ((0,c)`]`]`(rcondu"_)`(_."_)`(_."_))) HTu , ,:~ I
  ('hgeqzsnn' tdyad ((0,c)`]`]`(rcondu"_)`(_."_)`(_."_))) HTu
  ('hgeqzsnv' tdyad ((0,c)`]`]`(rcondu"_)`(_."_)`(_."_))) HTu , I
  ('hgeqzsvn' tdyad ((0,c)`]`]`(rcondu"_)`(_."_)`(_."_))) HTu , I
  ('hgeqzsvv' tdyad ((0,c)`]`]`(rcondu"_)`(_."_)`vberru)) HTu , ,:~ I

  erase 'cdiff1 adiff2 vberrl vberru'

  EMPTY
)

NB. ---------------------------------------------------------
NB. testeq
NB.
NB. Description:
NB.   Adv. to make verb to test hgexxxxx by matrices of
NB.   generator and shape given
NB.
NB. Syntax:
NB.   vtest=. mkmat testeq
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
NB.     ?@$&0 testeq_mt_ 150 150
NB. - test by random square real matrix with elements with
NB.   limited value's amplitude:
NB.     _1 1 0 4 _6 4&gemat_mt_ testeq_mt_ 150 150
NB. - test by random square complex matrix:
NB.     (gemat_mt_ j. gemat_mt_) testeq_mt_ 150 150

testeq=: 1 : 'EMPTY_mt_ [ testhgeq_mt_@u@(2&,)^:(=/)'
