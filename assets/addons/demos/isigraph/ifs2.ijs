NB. iterated function system
NB.
NB. uses matrix product on binary reps from 0 to 255
NB. try the different examples f1 - f5

X=: #: i. 256

f1=. +/ . * |:
f2=. >: @ (4&*)
f3=. (*/ . + |:) @ (6&+)
f4=. (*./ . + |:) @ (3&+)
f5=. (+/ . * |:) @: >:

vmat f1 X
