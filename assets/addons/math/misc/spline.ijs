NB. math/misc/spline
NB. Spline utilities
NB. version: 1.0.0

NB. =========================================================
NB.*cubicspline v Calculate cubic spline
NB.
NB. y is: 2-row matrix  x ,: f(x)
NB.
NB. result: x values;coefficient matrix,one row per interval.
cubicspline=: 3 : 0
diff=. }.-}:
'x y'=. y
h=. diff x
k=. diff y
w=. 3 * diff k % *: h
n=. +:(2}.x)-_2}.x
sm=. ,~_2+#x
m=. sm$}.,(sm+0 1){.(}:h),.n,.}.h
c=. 0,w %. m
a=. }:y
b=. (k%h) - h * ((+:c) + }.c,0) % 3
d=. (diff c,0) % 3 * h
(}:x);a,.b,.c,.d
)

NB. =========================================================
NB.*interspline v Interpolate spline
NB.
NB. x is: result from cubicspline
NB. y is: set of x coordinates
NB.
NB. returns: corresponding f(x) values
interspline=: 4 : 0
'i m'=. x
n=. <: +/ i <:/ y
(n{m) p. y-n{i
)

NB. examples:
NB. H=: 1 2 4 5 8 10 ,: 2 1.5 1.25 1.2 1.125 1.1
NB. H=: (i.6) ,: (i.6)^3
NB. H, (cubicspline H) interspline {.H

NB. =========================================================
NB.*freespline v Calculate spline
NB.
NB. y is: 2-row matrix x ,: f(x)
NB.
NB. result: x values;coefficient matrix1;coefficient matrix2
freespline=: 3 : 0
diff=. }.-}:
'x y'=. y
h=. diff x
dy=. diff y
b=. 6*diff dy%h
n=. +:(}.h)+}:h    NB. diagonal elements
sm=. ,~<:$h        NB. dim. of final matrix
t=. (}:h),.n,.}.h  NB. stitched up elements of final matrix
tm=. (sm+(0 1)){.t NB. adds needed zeros to rows!!
m=. sm$}.,tm       NB. checked
y2nd=. 0,(b%.m),0
a=. ($h)#0
d=. (}.y2nd)%h*6
b2=. ((}.y)%h)-(}.y2nd)*h%6
coeffs1=. a,.b2,.a,.d    NB. stitch up coefficients for poly 1
d1=. (}:y2nd)%h*6
b1=. ((}:y)%h)-(}:y2nd)*h%6
coeffs2=. a,.b1,.a,.d1   NB. stitch up coefficients for poly 2
x;coeffs1;coeffs2  NB. oldx and 2 tables of coefficients
)

NB. =========================================================
NB.*aprxspline v Approximate by spline
NB.
NB. x is: output from freespline
NB. y is: pt at which to interpolate
NB. k below picks out row of table to use for poly coeffs
aprxspline=: 4 : 0
'oldx coeffs1 coeffs2'=. x
k=. _1++/(y>:/oldx)
k=. k<.(_2+$oldx) NB. This is to remedy a counting error at end
((k{coeffs1) p. y-k{oldx)+(k{coeffs2) p. ((k+1){oldx)-y
)
