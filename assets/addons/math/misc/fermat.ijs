NB. math/misc/fermat
NB. Fermat factorization
NB. version: 1.0.0

NB.*fermatfactor v Find factor of n near square root of n using Fermat's method
NB. eg:  fermatfactor */ x: p:11000 12000
NB. x is: optional maximum iterations, default 10000
NB. y is: number to be factored
NB.
NB. starts with x=. >.%:n, and increments by 2 until done
NB.
NB. efficient only where there is a factor near the square root
NB.
NB. returns:  res, count
NB. where res is 0 = factor not found
NB.             >0 = proper factor
NB. count = number of iterations
NB.
NB. looks for a,b where n is (a^2) - b^2
fermatfactor=: 3 : 0
10000 fermatfactor y
:
x=. >.@%: x: y
u=. >:+:x
v=. 1
r=. (*:x)-y
c=. 0
while. c < x do.
  c=. >: c
  while. r>0 do.
    r=. r-v
    v=. v+2
  end.
  while. r<0 do.
    r=. r+u
    u=. u+2
  end.
  if. r=0 do. (-: u-v), c return. end.
end.
0, c
)
