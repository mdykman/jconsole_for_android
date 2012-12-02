NB. Plasma Cloud
NB.
NB. try adjusting STEPS, MAT, FE

STEPS=. 8
MAT=. 2 2$0
FE=. 0.85

randsn=. $ normalrand@(*/)
randadd=. ] + [ * randsn@$@]
ira=. [ randadd linsert@(linsert"1@])
irfa=. (%@<:@#@] ^ [) ira ]

vmat 11 cile FE&irfa^:STEPS MAT
