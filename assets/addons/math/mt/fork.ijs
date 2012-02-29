NB. Extended forks
NB.
NB. fork3  Generalized fork with 3-depth execution graph
NB. fork4  Generalized fork with 4-depth execution graph
NB. fork5  Generalized fork with 5-depth execution graph
NB. fork6  Generalized fork with 6-depth execution graph
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
NB. fork2
NB.
NB. Description:
NB.   2-fork, the traditional fork with 2-depth execution
NB.   graph
NB.
NB. Syntax:
NB.   vapp=. a0`b0`a1 fork2
NB.   vapp=. a0`b0`a1`:6
NB.   vapp=. a0 b0 a1
NB. where
NB.   ax   - ambivalent verbs to define input nodes of
NB.          execution graph
NB.   b0   - dyad to define output node of execution graph
NB.   vapp - 2-fork, is called as:
NB.            out=.   vapp y
NB.            out=. x vapp y
NB.
NB. Execution graph:
NB.      b0
NB.     / \
NB.    a0  a1
NB.
NB. Notes:
NB. - included just to eludicate generalized forks idea

NB. fork2=: 1 : 0
NB.   '`a0 b0 a1'=. m
NB.   o0=.    a0 y
NB.   o1=.    a1 y
NB.   o0=. o0 b0 o1
NB. :
NB.   '`a0 b0 a1'=. m
NB.   o0=. x  a0 y
NB.   o1=. x  a1 y
NB.   o0=. o0 b0 o1
NB. )

NB. ---------------------------------------------------------
NB. fork3
NB.
NB. Description:
NB.   3-fork, generalized fork with 3-depth execution graph
NB.
NB. Syntax:
NB.   vapp=. a0`b0`a1`c0`b1`a2 fork3
NB. where
NB.   ax   - ambivalent verbs to define input nodes of
NB.          execution graph
NB.   bx   - dyads to define intermediate nodes of execution
NB.          graph
NB.   c0   - dyad to define output node of execution graph
NB.   vapp - 3-fork, is called as:
NB.            out=.   vapp y
NB.            out=. x vapp y
NB.
NB. Execution graph:
NB.       c0
NB.      / \
NB.     b0  b1
NB.    / \ / \
NB.   a0  a1  a2
NB.
NB. Notes:
NB. - local nouns are re-used to reduce memory consumption
NB. - another 2-fork compatible traverse order is possible:
NB.     a0 b0 c0 b1 a2 a1

fork3=: 1 : 0
  '`a0 b0 a1 c0 b1 a2'=. m
  o0=.    a0 y
  o1=.    a1 y
  o2=.    a2 y
  o0=. o0 b0 o1
  o1=. o1 b1 o2
  o2=. 0
  o0=. o0 c0 o1
:
  '`a0 b0 a1 c0 b1 a2'=. m
  o0=. x  a0 y
  o1=. x  a1 y
  o2=. x  a2 y
  o0=. o0 b0 o1
  o1=. o1 b1 o2
  o2=. 0
  o0=. o0 c0 o1
)

NB. ---------------------------------------------------------
NB. fork4
NB.
NB. Description:
NB.   4-fork, generalized fork with 4-depth execution graph
NB.
NB. Syntax:
NB.   vapp=. a0`b0`a1`c0`b1`a2`d0`c1`b2`a3 fork4
NB. where
NB.   ax    - ambivalent verbs to define input nodes of
NB.           execution graph
NB.   bx cx - dyads to define intermediate nodes of execution
NB.           graph
NB.   d0    - dyad to define output node of execution graph
NB.   vapp  - 4-fork, is called as:
NB.            out=.   vapp y
NB.            out=. x vapp y
NB.
NB. Execution graph:
NB.         d0
NB.        / \
NB.       c0  c1
NB.      / \ / \
NB.     b0  b1  b2
NB.    / \ / \ / \
NB.   a0  a1  a2  a3
NB.
NB. Notes:
NB. - local nouns are re-used to reduce memory consumption
NB. - another 2-fork compatible traverse order is possible:
NB.     a0 b0 c0 d0 c1 b2 a3 a1 b1 a2

fork4=: 1 : 0
  '`a0 b0 a1 c0 b1 a2 d0 c1 b2 a3'=. m
  o0=.    a0 y
  o1=.    a1 y
  o2=.    a2 y
  o3=.    a3 y
  o0=. o0 b0 o1
  o1=. o1 b1 o2
  o2=. o2 b2 o3
  o3=. 0
  o0=. o0 c0 o1
  o1=. o1 c1 o2
  o2=. 0
  o0=. o0 d0 o1
:
  '`a0 b0 a1 c0 b1 a2 d0 c1 b2 a3'=. m
  o0=. x  a0 y
  o1=. x  a1 y
  o2=. x  a2 y
  o3=. x  a3 y
  o0=. o0 b0 o1
  o1=. o1 b1 o2
  o2=. o2 b2 o3
  o3=. 0
  o0=. o0 c0 o1
  o1=. o1 c1 o2
  o2=. 0
  o0=. o0 d0 o1
)

NB. ---------------------------------------------------------
NB. fork5
NB.
NB. Description:
NB.   5-fork, generalized fork with 5-depth execution graph
NB.
NB. Syntax:
NB.   vapp=. a0`b0`a1`c0`b1`a2`d0`c1`b2`a3`e0`d1`c2`b3`a4 fork5
NB. where
NB.   ax       - ambivalent verbs to define input nodes of
NB.              execution graph
NB.   bx cx dx - dyads to define intermediate nodes of
NB.              execution graph
NB.   e0       - dyad to define output node of execution
NB.              graph
NB.   vapp     - 5-fork, is called as:
NB.                out=.   vapp y
NB.                out=. x vapp y
NB.
NB. Execution graph:
NB.           e0
NB.          / \
NB.         d0  d1
NB.        / \ / \
NB.       c0  c1  c2
NB.      / \ / \ / \
NB.     b0  b1  b2  b3
NB.    / \ / \ / \ / \
NB.   a0  a1  a2  a3  a4
NB.
NB. Notes:
NB. - local nouns are re-used to reduce memory consumption
NB. - another 2-fork compatible traverse order is possible:
NB.     a0 b0 c0 d0 e0 d1 c2 b3 a4 a1 b1 c1 b2 a3 a2

fork5=: 1 : 0
  '`a0 b0 a1 c0 b1 a2 d0 c1 b2 a3 e0 d1 c2 b3 a4'=. m
  o0=.    a0 y
  o1=.    a1 y
  o2=.    a2 y
  o3=.    a3 y
  o4=.    a4 y
  o0=. o0 b0 o1
  o1=. o1 b1 o2
  o2=. o2 b2 o3
  o3=. o3 b3 o4
  o4=. 0
  o0=. o0 c0 o1
  o1=. o1 c1 o2
  o2=. o2 c2 o3
  o3=. 0
  o0=. o0 d0 o1
  o1=. o1 d1 o2
  o2=. 0
  o0=. o0 e0 o1
:
  '`a0 b0 a1 c0 b1 a2 d0 c1 b2 a3 e0 d1 c2 b3 a4'=. m
  o0=. x  a0 y
  o1=. x  a1 y
  o2=. x  a2 y
  o3=. x  a3 y
  o4=. x  a4 y
  o0=. o0 b0 o1
  o1=. o1 b1 o2
  o2=. o2 b2 o3
  o3=. o3 b3 o4
  o4=. 0
  o0=. o0 c0 o1
  o1=. o1 c1 o2
  o2=. o2 c2 o3
  o3=. 0
  o0=. o0 d0 o1
  o1=. o1 d1 o2
  o2=. 0
  o0=. o0 e0 o1
)

NB. ---------------------------------------------------------
NB. fork6
NB.
NB. Description:
NB.   6-fork, generalized fork with 6-depth execution graph
NB.
NB. Syntax:
NB.   vapp=. a0`b0`a1`c0`b1`a2`d0`c1`b2`a3`e0`d1`c2`b3`a4`f0`e1`d2`c3`b4`a5 fork5
NB. where
NB.   ax          - ambivalent verbs to define input nodes of
NB.                 execution graph
NB.   bx cx dx ex - dyads to define intermediate nodes of
NB.                 execution graph
NB.   f0          - dyad to define output node of execution
NB.                 graph
NB.   vapp        - 6-fork, is called as:
NB.                   out=.   vapp y
NB.                   out=. x vapp y
NB.
NB. Execution graph:
NB.             f0
NB.            / \
NB.           e0  e1
NB.          / \ / \
NB.         d0  d1  d2
NB.        / \ / \ / \
NB.       c0  c1  c2  c3
NB.      / \ / \ / \ / \
NB.     b0  b1  b2  b3  b4
NB.    / \ / \ / \ / \ / \
NB.   a0  a1  a2  a3  a4  a5
NB.
NB. Notes:
NB. - local nouns are re-used to reduce memory consumption
NB. - another 2-fork compatible traverse order is possible:
NB.     a0 b0 c0 d0 e0 f0 e1 d2 c3 b4 a5 a1 b1 c1 d1 c2 b3 a4 a2 b2 a3

fork6=: 1 : 0
  '`a0 b0 a1 c0 b1 a2 d0 c1 b2 a3 e0 d1 c2 b3 a4 f0 e1 d2 c3 b4 a5'=. m
  o0=.    a0 y
  o1=.    a1 y
  o2=.    a2 y
  o3=.    a3 y
  o4=.    a4 y
  o5=.    a5 y
  o0=. o0 b0 o1
  o1=. o1 b1 o2
  o2=. o2 b2 o3
  o3=. o3 b3 o4
  o4=. o4 b4 o5
  o5=. 0
  o0=. o0 c0 o1
  o1=. o1 c1 o2
  o2=. o2 c2 o3
  o3=. o3 c3 o4
  o4=. 0
  o0=. o0 d0 o1
  o1=. o1 d1 o2
  o2=. o2 d2 o3
  o3=. 0
  o0=. o0 e0 o1
  o1=. o1 e1 o2
  o2=. 0
  o0=. o0 f0 o1
:
  '`a0 b0 a1 c0 b1 a2 d0 c1 b2 a3 e0 d1 c2 b3 a4 f0 e1 d2 c3 b4 a5'=. m
  o0=. x  a0 y
  o1=. x  a1 y
  o2=. x  a2 y
  o3=. x  a3 y
  o4=. x  a4 y
  o5=. x  a5 y
  o0=. o0 b0 o1
  o1=. o1 b1 o2
  o2=. o2 b2 o3
  o3=. o3 b3 o4
  o4=. o4 b4 o5
  o5=. 0
  o0=. o0 c0 o1
  o1=. o1 c1 o2
  o2=. o2 c2 o3
  o3=. o3 c3 o4
  o4=. 0
  o0=. o0 d0 o1
  o1=. o1 d1 o2
  o2=. o2 d2 o3
  o3=. 0
  o0=. o0 e0 o1
  o1=. o1 e1 o2
  o2=. 0
  o0=. o0 f0 o1
)
