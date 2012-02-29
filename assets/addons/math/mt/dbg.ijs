NB. Debug
NB.
NB. dbg  Conj. to force verb to show debug info
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

gshapes=: $`($(;<)($ L: 0))@.(0 < L.)  NB. get shapes

NB. ---------------------------------------------------------
NB. dbg1
NB. dbg2
NB.
NB. Description:
NB.   Conj.s to equip verb by debug output
NB.
NB. Syntax:
NB.   vdbg1=. v dbg1 title
NB.   vdbg2=. v dbg2 title
NB. where
NB.   title - any literal to name v
NB.   v     - verb to switch to debug mode
NB.   vdbg1 - being verb v equipped by output of its rank
NB.           and valency, input's and output's shapes
NB.   vdbg2 - the same output as by vdbg1 plus input's and
NB.           output's values

dbg1=: 2 : 0
  smoutput 'dbg' ; (n , ' [MONAD] ' , (": u b. 0)) ; 'y' ; (gshapes_mt_ y)
  o=. u y
  smoutput 'dbg' ; (n , ' SUCCESS') ; (gshapes_mt_ o)
  o
:
  smoutput 'dbg' ; 'x' ; (gshapes_mt_ x) ; (n , ' [DYAD] ' , (": u b. 0)) ; 'y' ; (gshapes_mt_ y)
  o=. x u y
  smoutput 'dbg' ; (n , ' SUCCESS') ; (gshapes_mt_ o)
  o
)

dbg2=: 2 : 0
  smoutput 'dbg' ; (n , ' [MONAD] ' , (": u b. 0)) ; 'y' ; (gshapes_mt_ y) ; < y
  o=. u y
  smoutput 'dbg' ; (n , ' SUCCESS') ; (gshapes_mt_ o) ; < o
  o
:
  smoutput 'dbg' ; 'x' ; (gshapes_mt_ x) ; x ; (n , ' [DYAD] ' , (": u b. 0)) ; 'y' ; (gshapes_mt_ y) ; < y
  o=. x u y
  smoutput 'dbg' ; (n , ' SUCCESS') ; (gshapes_mt_ o) ; < o
  o
)

NB. =========================================================
NB. Interface

NB. ---------------------------------------------------------
NB. dbg
NB.
NB. Description:
NB.   Conj. to force verb to show debug info with verbosity
NB.   defined by noun DEBUG which is defined in mt.ijs
NB.
NB. Syntax:
NB.   vdbg=. v dbg title
NB. where
NB.   title - any literal to name v
NB.   v     - verb to switch to debug mode
NB.   vdbg  - being verb v equipped by output of debug info
NB.
NB. Application:
NB. - to debug verb '*' in verb (+/ .*) try:
NB.     C=. A (+/ .(* dbg_mt_ '*')) B

dbg=: 2 : 'u`(u dbg1_mt_ n)`(u dbg2_mt_ n)@.DEBUG_mt_'
