NB. ~user/tabula/tabmath.ijs

NB. Mathematical functions exposed to user
NB. These fns are accepted in formulas.
NB. This script should be loaded by: start_tab_
NB. -to overwrite all z-definitions lurking elsewhere

NB. PUT THESE IN THE DEFN OF: EXCLUDE IN: cal etc
NB. sqr sqrt cube
NB. PI PI2 PI4 PIb3 PI4b3 RT2 RT3
NB. sin cos tan sinh cosh tanh
NB. arcsin arccos arctan arcsinh arccosh arctanh
NB. pi dfr rfd
NB. abs exp div int mod times choice

cocurrent 'z'

sqr=: *:
sqrt=: %:
cube=: 3 ^~ ]

	NB. Used in UUC & UUF formulas and many ttables ...
PI=:	o.1		NB. π
PI2=:	o.2		NB. 2π
PI4=:	o.4		NB. 4π
PIb3=:	o.1r3		NB. π/3
PI4b3=:	o.4r3		NB. 4π/3
RT2=:	2^0.5		NB. root-2
RT3=:	3^0.5		NB. root-3

NB. =========================================================

abs=: |
avg=: +/ % #
exp=: ^
div=: %
int=: [: <. ] + 0 > ]
mod=: |~
times=: *

choice=: 4 : '((0>.1<.x)){y'

NB. =========================================================
NB. FROM trig.ijs

sin=: 1&o.
cos=: 2&o.
tan=: 3&o.

sinh=: 5&o.
cosh=: 6&o.
tanh=: 7&o.

arcsin=: _1&o.
arccos=: _2&o.
arctan=: _3&o.

arcsinh=: _5&o.
arccosh=: _6&o.
arctanh=: _7&o.

pi=: 1p1

dfr=: *&(180%pi)
rfd=: *&(pi%180)

NB. =========================================================
