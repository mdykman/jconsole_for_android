NB. Scaling
NB.
NB. scl  Try to scale without overflow or underflow
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
NB. scl
NB.
NB. Description:
NB.   Try to scale a noun without overflow or underflow
NB.
NB. Syntax:
NB.   B=. (f,t) scl A
NB. where
NB.   A - r-rank array
NB.   f ≠ 0, numeric scalar
NB.   t - numeric scalar
NB.   B - r-rank array, being A scaled by ratio (t/f) without
NB.       under- or overflow, if possible
NB.   r ≥ 0, integer
NB.
NB. Formula:
NB.   if |(f*FP_SFMIN)*FP_SFMIN| > |t|
NB.     B := (t/((f*FP_SFMIN)*FP_SFMIN))*((A*FP_SFMIN)*FP_SFMIN)
NB.   elseif |f*FP_SFMIN| > |t|
NB.     B := (t/(f*FP_SFMIN))*(A*FP_SFMIN)
NB.   elseif |(t/FP_SFMAX)/FP_SFMAX| > |f|
NB.     B := (((t/FP_SFMAX)/FP_SFMAX)/f)*((A*FP_SFMAX)*FP_SFMAX)
NB.   elseif |t/FP_SFMAX| > |f|
NB.     B := ((t/FP_SFMAX)/f)*(A*FP_SFMAX)
NB.   else
NB.     B := (t/f)*A
NB.   endif
NB. where
NB.   FP_SFMAX := 1/FP_SFMIN
NB.
NB. Algorithm:
NB.   In: A f t
NB.   Out: B
NB.   1) find lIOS |f| and |t| in scale vector (1,1,FP_SFMIN)
NB.      1.1) form vector (|f|,|t|)
NB.      1.2) form matrix:
NB.             ( |t|*FP_SFMIN*FP_SFMIN  |t|*FP_SFMIN )
NB.             ( |f|*FP_SFMIN*FP_SFMIN  |f|*FP_SFMIN )
NB.      1.3) form 2-vector:
NB.             ioft -: iof,iot
NB.           where
NB.             iof == (|t|*FP_SFMIN*FP_SFMIN,|t|*FP_SFMIN) I. |f|
NB.             iot == (|f|*FP_SFMIN*FP_SFMIN,|f|*FP_SFMIN) I. |t|
NB.   2) find io:
NB.        io := iof-iot
NB.   3) scale A
NB.      3.1) find scaled ratio (f/t)
NB.           3.1.1) form scaling vector
NB.                    ftscl := ioft { (1,1,FP_SFMIN)
NB.           3.1.2) scale (f,t) down by ftscl
NB.                    (f,t) := ftscl (*^:|io|) (f,t)
NB.           3.1.3) find scaled ratio
NB.                    ft := f/t
NB.      3.2) scale A up or down
NB.             B := FP_SFMIN (*^:io) A
NB.      3.3) scale A by ratio
NB.             B := ft * B
NB.
NB. Notes:
NB. - models LAPACK's xLASCL('G'), when A is a matrix
NB. - models LAPACK's xDRSCL, when A is a vector and t=1

scl=: 4 : 0
  ioft=. ((FP_SFMIN |:@:(*^:2 1) |.) I."1 0 ]) | x
  io=. -/ ioft
  (%~/ (ioft { (1 1,FP_SFMIN)) *^:(| io) x) * (FP_SFMIN&*^:io y)
)
NB. scl=: ((],(0>:-),(0&>:))@(-&2)@((I.~(FP_SFMIN&*^:2 1 _1 _2))/)@:|@[) ((*&>)`(%&>)/@:((FP_SFMIN&*@[&0&.>)"0)) ((;(;~/))~)
