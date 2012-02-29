NB. evolute of integers up to 33,489 (=183^2)
NB.
NB. evolute defined in: system\packages\misc\evolute.ijs
NB.
NB. experiment with different values for f

f=. ]            NB. shows evolute
f=. # @ q:       NB. count (of prime factors)
f=. (1:=#) @ q:  NB. 1 if prime

vmat f 1+evolute 183
