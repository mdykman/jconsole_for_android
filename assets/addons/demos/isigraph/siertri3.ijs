NB. Sierpinksi Triangle by Pascal's Triangle mod p
NB.
NB. Neat but inefficient.
NB.
NB. Experiment with different p and size
NB. e.g p=5, size=71

p=. 3
size=. 54
clr=. BLACK,RED,BLUE,GREEN,YELLOW

clr vmat p|!~/~ i.x:size
