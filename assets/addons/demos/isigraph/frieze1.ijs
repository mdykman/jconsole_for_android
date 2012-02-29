NB. Frieze Patterns
NB.
NB.

STEPS=: 100+i.20000
STEPS=: 100+i.5000

par=: 5 2 3$,".;._2 (0 : 0)
_0.23 0 _0.41 0 _0.49 0
0 _0.79 0 _0.46 0 0.83
0.46 0 0.23 0 _0.35 0
0 0.33 0 0.92 0 _0.15
_0.78 0 _0.76 0 _0.69 0
)

sin2=: sin@+:
cos2=: cos@+:
mp=: +/ . *

f1=: 1: , cos , cos2 , sin , sin2
f2=: ^&(i.3)
f3=: f1@{. mp par"_ mp f2@{:
f4=: f3 + {.,0:
fn=: 2p1 0&| @ f4 f.

xy=: fn ^: STEPS 0.1 0.2

shape=: 300 300
min=: <./xy
max=: >./xy
XY=: <. (xy -"1 min) *"1 (shape-1) % max-min
n=: ;/ ~.XY
freq=: #/.~XY
clr=: RGB 255 255 255,hueRGB int01 >./freq
b=: |: freq n } shape$0
clr vmat b,.b,.b
