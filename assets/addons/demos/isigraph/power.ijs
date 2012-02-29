NB. function power in generating a fractal
NB.
NB. specify function
NB. try also:  - + * +.

fn=: !

step=: 1 : ',"2 @ (,/) @ (0 2 1 3&|:) @ (x/~)'
times3=: ^: 3
X=: 2 1 ,: 2 2
vmat fn step times3 X
