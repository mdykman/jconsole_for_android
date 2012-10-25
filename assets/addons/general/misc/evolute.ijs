NB. evolute.ijs   - evolutes
NB.
NB. ref: Eugene McDonnell Vector Vol 13#2
NB.
NB. example:
NB.   evolute 10

cocurrent 'z'

NB.*evolute v generate evolute

e0=. }: @ (2: # >:@i.)
e1=. <: @ +: $ _1: , ] , 1: , -
e2=. _1 & |. @ (e0 # e1)

evolute=: ,~ $ /: @ (+/\) @ e2 f.
