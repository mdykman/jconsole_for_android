NB. math/misc/poly
NB. Polynomial functions
NB. version: 1.0.0

NB. chebyshev_tp      - explicit form of Chebyshev T polynomial
NB. chebyshev_up      - explicit form of Chebyshev U polynomial
NB.
NB. chebyshev_tpc     - coefficients of Chebyshev T polynomial
NB. chebyshev_upc     - coefficients of Chebyshev U polynomial
NB.
NB. legendre_pc       - coefficients of Legendre polynomial
NB. =========================================================

require 'trig'

NB.*chebyshev_tp v Evaluate Chebyshev T polynomial of order n at x
NB. form:  n chebyshev_tp x
chebyshev_tp=: cos @ (*arccos)

NB.*chebyshev_up v Evaluate Chebyshev U polynomial of order n at x
NB. form: n chebyshev_up x
chebyshev_up=: ((*>:)~ %&sin ]) arccos

NB. =========================================================

NB.*chebyshev_tpc v Returns coefficients of Chebyshev T polynomial of order n
NB. eg: (chebyshev_tpc 8)&p. = Chebyshev T polynomial of order 8
NB.
NB. or list coefficients to order n+1:
NB.  T=. , <@(+:@(0&,)@>@{: - >@(_2&{) , 0 0"_)
NB.  T ^: n [ 1;0 1
chebyshev_tpc=: 3 : 0
r=. 1 if. y=0 do. r return. end.
s=. 0 1 if. y=1 do. s return. end.
while. y=. <:y do.
  p=. r
  r=. s
  s=. (+:0,r) - p,0 0
end.
)

NB.*chebyshev_upc v Returns coefficients of Chebyshev U polynomial of order n
NB. eg: (chebyshev_upc 8)&p. = Chebyshev U polynomial of order 8
chebyshev_upc=: 3 : 0
r=. 1 if. y=0 do. r return. end.
c=. 0 2 if. y=1 do. c return. end.
s=. 0 1
while. y=. <:y do.
  p=. r
  r=. s
  s=. (+:0,r) - p,0 0
  c=. s + 0,c
end.
)

NB. =========================================================
NB.*legendre_pc v Returns coefficients of legendre polynomial of order n
NB. eg: (legendre_pc 8)&p.  =  Legendre polynomial of order 8
NB.
NB. or list coefficients to order n+1:
NB.  T=. , <@(+:@(0&,)@>@{: - >@(_2&{) , 0 0"_)
NB.  T ^: n [ 1;0 1
legendre_pc=: 3 : 0
r=. 1 if. y=0 do. r return. end.
s=. 0 1 if. y=1 do. s return. end.
i=. 1
while. y >: i=. >:i do.
  p=. r
  r=. s
  s=. (((<:+:i)*0,r) - (<:i)*p,0 0 ) % i
end.
)
