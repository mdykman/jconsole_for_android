NB. math/misc/contfrac
NB. Continued fraction utilities
NB. version: 1.0.0
NB. 
NB. contfrac    create continued fraction
NB. contfracx   expand continued fraction

NB. =========================================================
NB.*contfrac v create continued fraction
NB. form: [max_steps] contfrac number
NB.
NB. the iteration ends when the representation is exact, or when
NB. the optional maximum number of steps has been completed.
NB.
NB. max_steps defaults to 100
NB.
NB. example: 7 contfrac o.1
NB.          contfrac 55r34

contfrac=: 3 : 0
100 contfrac y
:
r=. ''
t=. y
c=. 0
while. c < x do.
  r=. r, q=. <. t
  if. 0 = t=. t - q do. break. end.
  t=. %t
  c=. >: c
end.
r
)

NB. =========================================================
NB.*contfracx v expand continued fraction
contfracx=: [: (+%) /\ x:
