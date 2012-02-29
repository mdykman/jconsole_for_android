NB. math/misc/rsa
NB. Examples of RSA encryption
NB. version: 1.0.0
NB.
NB. method:
NB.   P & Q are primes
NB.   E is exponent, relatively prime to (P-1)*(Q-1)
NB.   D is the inverse of E mod (P-1)*(Q-1)
NB.
NB. here:
NB.     the public key is:  PQ,E   (i.e. a pair of numbers)
NB.     the private key is: D
NB.
NB. then:
NB.   msg (PQ powermod) E   encodes msg
NB.   msg (PQ powermod) D   decodes msg

NB. =========================================================

require 'math/misc/primutil'

NB. example with small values for P and Q
t1=: 3 : 0

P=: 22307x
Q=: 78121x
E=: 46337x
D=: ((P-1) * Q-1) inversep E

PQ=: P*Q
encode=: PQ&|@^&E
decode=: PQ&|@^&D

PQ;E
)

NB. =========================================================
NB. example with big values for P and Q
t2=: 3 : 0

P=: 151 + 10^50x
Q=: 40 + 7^62x
E=: 9 + 10^49x
D=: ((P-1) * Q-1) inversep E

PQ=: P*Q
encode=: PQ&|@^&E
decode=: PQ&|@^&D

PQ;E
)
