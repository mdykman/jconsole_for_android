NB. math/misc/integrat
NB. Various methods for numeric integration
NB. version: 1.0.0

NB. integrate     Aitken extrapolation on Gauss integrals
NB. simpson       Simpson's method
NB. adapt         Adaptive Quadrature using Simpson's method
NB.
NB. intexample    example using each method

NB. =========================================================
NB.*integrate c Numeric integration by Aitken extrapolation on Gauss integrals
NB.
NB. form: verb integrate int
NB.   verb is the monadic function to be integrated.
NB.   int has 2 or 3 elements:
NB.     [0]  lower bound of interval
NB.     [1]  upper bound of interval
NB.     [2]  number of significant digits (s.d.) required, default 8
NB.
NB. result is:  integral, estimate of s.d. attained (max 14).
NB.
NB. method is Aitken extrapolation applied to Gauss approximate integrals.
NB. the interval is divided into at most 2^10 subintervals.
NB.
NB. this method has very rapid convergence.
NB.
NB. eg:   43.75 14 = ^&3 integrate 3 4
integrate=: 2 : 0
'lower upper sd'=. 3{.y,8
in=. 5
len=. 2^i.in
diff=. upper-lower
int=. 3 : ',(_1 1*r*3^_0.5)+/+/\r,}:y#+:r=.%+:y'
scale=. [: lower&+ diff&*
f=. diff&*@(+/)@:x@scale@int % +:
g=. f"0 len
whilst. 1 do.
  r=. g
  whilst. 1<#r do.
    t0=. _2}.iv=. r
    t1=. }.}:iv
    t2=. 2}.iv
    s=. t2+t0-+:t1
    r=. t2-(-.b)*(*:t2-t1)%s+b=. 0=s
  end.
  t=. <.-10^.1e_14>.(|-/_2{.iv)%{:iv
  if. (10<in) +. sd <: t do. r,t return. end.
  g=. g,f"0 [ 2^in,in+1
  in=. in+2
end.
)

NB. =========================================================
NB.*simpson c Numeric integration by Simpson's method
NB.
NB. form: verb simpson int
NB.   verb is the monadic function to be integrated.
NB.   int has 2 or 3 elements:
NB.     [0]  lower bound of interval
NB.     [1]  upper bound of interval
NB.     [2]  number of subintervals (default 128)
NB.
NB. result is the integral
NB.
NB. eg:   43.75 = ^&3 simpson 3 4
simpson=: 2 : 0
'lower upper int'=. 3{.y,128
size=. (upper-lower)%int
val=. x lower+size*i.>:int
size * +/val * 3%~ 1,((int-1)$4 2),1
)

NB. =========================================================
NB.*adapt c Numeric integration by adaptive quadrature
NB.
NB. form: verb adapt int
NB.   verb is the monadic function to be integrated.
NB.   int has 2 or 3 elements:
NB.     [0]  lower bound of interval
NB.     [1]  upper bound of interval
NB.     [2]  tolerance (default 1e_8)
NB.
NB. result is the integral
NB.
NB. eg: 43.75 = ^&3 adapt 3 4
adapt=: 2 : 0
'lb ub t'=. 3{.y,1e_8
a=. x simpson (lb,ub,8)
b=. x simpson (lb,ub,16)
if. (|a-b)<|b*t do. b return. end.
c=. -:lb+ub
(x adapt (lb,c,t)) + x adapt (c,ub,t)
)

NB. =========================================================
Note 'examples using each method'
fn=: 3 : '(y^8)+(1 o.y)-y^7'
r=. ''
r=. r, 98611112.950182 14 -: fn integrate 0 10 12
r=. r, 98611119 -: <.fn simpson 0 10 128
r=. r, 98611116 -: <.fn adapt 0 10 1e_6
)
