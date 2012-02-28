NB. Utilities
NB.
NB. sgn       Simplified signum
NB. negneg    Conditional negate
NB. negpos    Conditional negate
NB. copysign  Copy sign
NB. sorim     Sum of real and imaginary parts' modules
NB. soris     Sum of real and imaginary parts' squares
NB. fmtlog    Format log string
NB. ag        Adv. to apply successive verbs from gerund to
NB.           successive elements of list
NB. ms        Minimum in sum of vectors
NB.
NB. Version: 0.7.0 2011-08-06
NB.
NB. Copyright 2005-2011 Henry Rich, Igor Zhuravlov
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
NB. Miscellaneous

negneg=: -@]^:(0>[)                                             NB. if x<0 then -y else y endif
negpos=: -@]^:(0<:[)                                            NB. if x≥0 then -y else y endif

copysign=: -@]^:((=-)&*)                                        NB. if x<0 then -|y| else |y| endif

sorim=: +/"1@:| @:+.                                            NB. sum of real and imaginary parts' modules, |Re(y)| + |Im(y)|
soris=: +/"1@:*:@:+.                                            NB. sum of real and imaginary parts' squares, Re(y)^2 + Im(y)^2

fmtlog=: ;@:(26 17 17 17 17 _16&(({.{.@('d<n/a>'&(8!:2)))&.>))  NB. log string format

NB. ---------------------------------------------------------
NB. ag
NB.
NB. Description
NB.   Adv. to apply successive verbs from gerund to
NB.   successive elements of list
NB.
NB. Syntax:
NB.   vapp=: g ag
NB. where
NB.   g    - gerund u0`u1`... ; each monad ui is called as:
NB.            eiupd=. ui ei
NB.   vapp - monad to apply successive ui to successive ei;
NB.          is called as:
NB.             Eupd=. vapp E
NB.   E    = rank-1 array (e0,e1,...)
NB.   Eupd = rank-1 array (e0upd,e1upd,...)
NB.
NB. Application:
NB. - process each table in the report individually:
NB.     0 1 2 (+:&.+:)`(-:&.-:)`(*:&.+:) ag i. 3 4 4
NB.
NB. References:
NB. [1] [Jforum] gerund apply
NB.     Henry Rich, Sat Oct 22 06:37:12 HKT 2005
NB.     http://www.jsoftware.com/pipermail/general/2005-October/025450.html

ag=: /. (,/@)

NB. ---------------------------------------------------------
NB. ms
NB.
NB. Description: Minimum in [sum of] vector[s]
NB. Syntax:      k=. [(delta0,delta1,...)] ms (value0,value1,...)
NB. where        default deltai is 0
NB. Formula:     k = min(delta0+value0,delta1+value1,...)
NB. Notes:       is memo, since repetitive calls are expected

ms=: <./@:(] :+)M.
