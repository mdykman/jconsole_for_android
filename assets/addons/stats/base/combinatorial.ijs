NB. stats/base/combinatorial
NB. Sample design

NB. comb v         combinations of size x from i.y
NB. combrev v      comb in revolving door order
NB. perm v         permutations of size y
NB. steps v        steps from a to b in c steps

cocurrent 'z'

NB. =========================================================
NB.*comb v all combinations of size x from i.y
comb=: 4 : 0
k=. i.>:d=. y-x
z=. (d$<i.0 0),<i.1 0
for. i.x do. z=. k ,.&.> ,&.>/\. >:&.> z end.
; z
)

NB. =========================================================
NB.*combrev v comb in revolving door order
NB. combinations in what Knuth calls "revolving door order"
NB. such that any two adjacent combinations differ by a
NB. single element (Gray codes for combinations).
combrev=: 4 : 0
i=. 1+x
z=. 1 0$k=. i.#c=. 1,~(y-x)$0
while. i=. <:i do. z=. (c#k),.;(-c=. +/\.c)|.@{.&.><1+z end.
|.y-1+z
)

NB. =========================================================
NB.*perm v all permutations of size y
perm=: ! A.&i. ]

NB. =========================================================
NB.*steps v steps from a to b in c steps
NB. form: steps a,b,c
steps=: {. + (1&{ - {.) * (i.@>: % ])@{:
