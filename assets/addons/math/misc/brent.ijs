NB. math/misc/brent
NB. Brent's method in J
NB. (from J. Patrick Harrington)
NB. version: 1.0.0

NB.*brent a Adverb to solve  f(x) = y0  by Brent's method.
NB. form: f brent (a,b,tol,y0) gives x0 such that f(x0) = y0
NB. Root must lie between a & b; tol = soln. tolerance
NB. Adapted from 'Numerical Recipes', p 253
NB.
NB. For example, let f(x) = cos(x) - x
NB.     f=. 2&o. - ]
NB.     ]x0=. f brent 0 1 1e_10 0.2
NB.  0.616124
NB.     f x0
NB.  0.2
NB.     0.2 - f x0
NB.  _3.97182e_13
brent=: 1 : 0
itmax=. 100        NB. maximum iterations
eps=. 3e_14        NB. ~ floating point precision
abc=. ((0 1){y),0
tol=. 2{y
rr=. - 3{y
NB. Model of FORTRAN "SIGN(A,B)" function:
F_sign=. 4 : '(|x)*(1- +:(y<0))'
fabc=. rr + (u 0{abc),2#(u 1{abc)
if. (*/(0 1){fabc)>0 do.
  zb=. 'Root not in bounds!'
  return.
end.
while. 1<(itmax=. <: itmax) do.
  if. (*/(1 2){fabc)>0 do.
    abc=. (0 1 0){ abc
    fabc=. (0 1 0){ fabc
    e=. d=. -/(1 0){abc
  end.
  if. (</|(2 1){fabc) do.
    abc=. (1 2 1){ abc
    fabc=. (1 2 1){ fabc
  end.
  t1=. (2*eps*|1{abc)+(-:tol)
  xm=. -:-/(2 1){abc
  if. ((|xm)<:t1)+.(0 = 1{fabc) do.
    zb=. 1{abc
    return.
  end.
  if. ((|e)>:t1)*.(>/|(0 1){fabc) do.
    s=. %/(1 0){fabc
    if. =/(0 2){abc do.
      p=. 2*xm*s
      q=. 1 - s
    else.
      q=. %/(0 2){fabc
      r=. %/(1 2){fabc
      p=. s*((2*xm*q*(q-r))-((-/(1 0){abc)*(r-1)))
      q=. (q-1)*(r-1)*(s-1)
    end.
    if. p>0 do. q=. -q
    end.
    p=. |p
    if. (2*p)<((|e*q)<.((3*xm*q)-|t1*q)) do.
      e=. d
      d=. p%q
    else.
      e=. d=. xm
    end.
  else.
    e=. d=. xm
  end.
  abc=. (1 1 2){abc
  fabc=. (1 1 2){fabc
  if. (|d)>t1 do.
    abc=. abc + (0,d,0)
  else.
    abc=. abc + (0,(t1 F_sign xm),0)
  end.
  fabc=. (rr + u (1{abc)) (1)}fabc
end.
zb=. 'Too many iterations!'
)
