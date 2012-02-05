NB. Eigenvalues and eigenvectors of structured matrix
NB.
NB. hseqr  Eigenvalues and, optionally, the Schur decomposition
NB.        of a Hessenberg matrix
NB. pteqr  Eigenvalues and, optionally, eigenvectors of a
NB.        symmetric positive definite tridiagonal matrix
NB. steqr  Eigenvalues and, optionally, eigenvectors of a
NB.        symmetric tridiagonal matrix
NB.
NB. Version: 0.6.6 2010-06-22
NB.
NB. Copyright 2010 Igor Zhuravlov
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
  (((-&s1) upddiag ]) (mp (% norm1t)) (((-&s2) updl 0) {."1 ])) y
)

NB. =========================================================
NB. Interface

NB. =========================================================
NB. Test suite

