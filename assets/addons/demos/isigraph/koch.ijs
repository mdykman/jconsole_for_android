NB. Koch snowflake
NB.
NB. from Clifford Reiter's article in Vector Vol 11 #2

tri1=: 2r3&*@[ + 1r3&*@]
tri2=: 1r3&*@[ + 2r3&*@]
mid=: -:@+
nor=: 1 _1&*@|.
bulge=: mid + (%:%12)&*@nor@:-
segdiv=: [,tri1,bulge,:tri2
step=: ,/@(] segdiv"1 (1&|.))

w=. (2 3{GSIZE)%1000
P3=: w *"1 [ 200 300,500 820,:800 300
P4=: w *"1 [ 500 820,200 300,:800 300

r=. step^:4 P3
s=. step^:2 P4
t=. step^:4 P4
gback 0 128 255
255 0 0 gpolygon , roundint r
0 128 0 gpolygon , roundint s
255 255 0 gpolygon , roundint t
