NB. math/misc/primutil
NB. Primes    - prime testing programs
NB. version: 1.0.0

NB. main functions:
NB.
NB.  nextprime         next prime number
NB.  prevprime         previous prime number
NB.  primesto          primes up to n
NB.  primepowersto     prime powers up to n
NB.  primeq            test for prime
NB.
NB.  carmichaelq       test for carmichael number
NB.  mersenneq         test for mersenne prime
NB.
NB.  inversep          inverse mod p
NB.
NB.  smallprimefactors get small prime factors for number

NB. powermod           x (n powermod) y
NB. timesmod           x (n timesmod) y
NB. =========================================================

NB. powermod a   x (n powermod) y
powermod=: 1 : 'x&|@^'

NB. timesmod a   x (n timesmod) y
timesmod=: 1 : 'x&|@*'

NB.*prevprime v Previous prime number to y
prevprime=: _4 & p:

NB.*nextprime v Next prime number after y
nextprime=: 4 & p:

NB.*primeq v Test for prime
primeq=: 1 & p:

NB.*primesto v Primes up to y
primesto=: p: @ i. @ (_1 p: >:)

totient=: 5 & p:

NB. =========================================================
NB.*carmichaelq v Test composite for Carmichael number
NB. eg:
NB.     carmichaelq 41 * 61 * 101
NB.   1
NB.
NB. first few such are:
NB.     (#~ carmichaelq) (>:}.i.3000) -. primesto 3000
NB.   561 1105 1729 2465 2821
NB.
NB. returns: 1 for any prime argument
carmichaelq=: 3 : 0 "0
n=. (primesto y) -. q: y
*./ 1 = n (y powermod) y-1
)

NB. =========================================================
NB.*inversep v Inverse mod p
NB.
NB. form: p inversep a    where p is a prime
inversep=: 4 : 0
u=. 1 0,x: y
v=. 0 1,x: x
f=. <. @ (%&{:)
while.
  old=. v
  {: v=. u - v * u f v
do.
  u=. old
end.
x | {. old
)

NB. =========================================================
NB.*mersenneq v Test if prime p generates a mersenne prime
NB. i.e. _1+2^p is prime
NB. eg:
NB.      [x=. (#~ mersenneq) p: i.20
NB.   2 3 5 7 13 17 19 31 61
NB.      _1 + 2x ^ x
NB.   3x 7x 31x 127x 8191x 131071x 524287x 2147483647x 2305843009213693951x
NB.
NB. first few such primes are:
NB. 2 3 5 7 13 17 19 31 61 89 107 127 521 607 1279 2203 2281 3217 4253 4423
mersenneq=: 3 : 0 "0
if. y=2 do. 1 return. end.
m=. <:2^x:y
f=. m&| @ (-&2) @ *:
0 = f^:(y-2) 4
)

NB. =========================================================
NB.*primepowersto v Generate prime powers up to y
NB. eg:
NB.      primepowersto 50
NB.   32 27 25 49 11 13 17 19 23 29 31 37 41 43 47
primepowersto=: 3 : 0
p=. primesto y
s=. <.@%: y
p0=. (p <: s) # p
w=. p0 <.@^. y
p ^ 1 >. (#p) {. w
)

NB. =========================================================
NB.*smallprimefactors v Get small primefactors from number
NB. x is: # of small primes to use, default 1000
NB.
NB. returns: (small factor list);remaining number
NB.          as extended integers
NB. eg:
NB.    smallprimefactors */ p: 7x ^ 1 + i.5
NB. +-----------+----------+
NB. |19 229 2311|3973658267|
NB. +-----------+----------+
smallprimefactors=: 3 : 0
1000 smallprimefactors y
:
x=. x: p: i. x
p=. ''
while. 1 e. msk=. 0 = x | y do.
  x=. msk # x
  p=. p, x
  y=. y % */ x
end.
(/:~p);y
)

