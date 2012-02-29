NB. actfnsm - annuity functions that calculates modal values by
NB. adjusting annual values by (m-1)%2*m  (Woolhouse's method)
NB.
NB. Indexed and temporary annuities are not supported.
NB.
NB. annxm  - cover for annx
NB.
NB. In general, it is better to have annx calculate modal values
NB. directly using mortality interpolation.

NB. =========================================================
NB. annxm
annxm=: 3 : 0
NB. single life annuities
NB. see annx for description
0 1 annxm y
:
r=. 0
if. 5 ~: #y do.
  'ages (imm dfd gtd ben frq) int ndx qx' return. end.

opt=. 2{.x,(#x)}.0 1
('age val int ndx qx')=. y
't d g n f'=. val

if. 0 +./ .~: ndx do.
  'Woolhouse''s method not supported for indexed annuities'
  return. end.

if. n ~: 0 do.
  'Woolhouse''s method not supported for temporary annuities' return.
  return. end.

int=. int,(d+g)${:int=. intrep int

if. d ~: 0 do.
  r=. (({.opt),1) annxm (age+d);(t,g,0,0,f);(d}.int);0;qx
  r=. r*opt annx age;(0,d,0,1,1);int;0;qx
  r=. r+annt g;(t,d,f);int;0

elseif. g ~: 0 do.
  r=. annt g;(t,0,f);int;0
  r=. r+(({.opt),1) annxm age;(t,g,0,0,f);int;0;qx

elseif. 1 do.
  r=. opt annx age;(t,0 0 0 1);int;0;qx
  r=. r+(t{_1 1)*0.5*1-%f
end.

($>0{y)$r
)
