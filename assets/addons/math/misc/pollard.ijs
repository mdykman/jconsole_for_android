NB. math/misc/pollard
NB. Pollard factorizations
NB. version: 1.0.0

NB. pollardrho       Pollard rho factorization
NB. pollardpm1       Pollard p-1 factorization
NB.
NB. examples:
NB.
NB.    ]x=. (,*/) x: p: 1e7 30101
NB. 179424691 351599 63085541930909
NB.    pollardpm1 {: x
NB. 351599 335
NB.
NB.    ]x=. (,pollardrho)  1 + 2 ^ 2 ^ 6x
NB. 18446744073709551617 274177 808
NB.    (0{x) % 1{x
NB. 67280421310721
NB. =========================================================

NB.*pollardrho v Pollard rho factorization
NB.
NB. form:   [m,[;poly]] pollardrho n
NB.    n      number to be factored
NB.    m      optional maximum iterations (default 10000)
NB.    poly   optional polynomial to be used (left argument to p.)
NB.           default 1 0 1 <> 1 + x^2
NB.
NB. returns:  res, count
NB.     where res is 0 = factor not found
NB.                 >0 = proper factor
NB.           count = number of iterations
pollardrho=: 3 : 0
'' pollardrho y
:
x=. boxxopen x
'm p'=. 2 {. x, (#x) }. 10000 ; 1 0 1
n=. x: y
f=. n&| @ (p&p.)
x1=. f 2x
x2=. f f 2x
c=. 0
while. c < m do.
  c=. >: c
  g=. n +. n | x2 - x1
  if. -. g e. 1, n do. g, c return. end.
  x1=. f x1
  x2=. f f x2
end.
0, c
)

NB.*pollardpm1 v Pollard p-1 factorizaton
NB. returns:  res, count
NB.     where res is 0 = factor not found
NB.                 >0 = proper factor
NB.           count = number of iterations
NB. x is: optional maximum iterations, default 10000
NB. y is: number to be factored
pollardpm1=: 3 : 0
10000 pollardpm1 y
:
n=. x: y
pwr=. n&| @ ^
b=. 1
p=. 2x
c=. 0
while. c < x do.
  c=. >: c
  b=. >: b
  p=. p pwr b
  g=. n +. p - 1
  if. -. g e. 1, n do. g, c return. end.
end.
0, c
)
