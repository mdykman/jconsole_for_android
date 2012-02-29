NB. Actuarial functions
NB.
NB. annx      single life annuity
NB. annxy     joint life annuity
NB. annjls    joint life & survivor annuity
NB. assx      single life insurances

NB. =========================================================
NB. annx
annx=: 3 : 0
NB. single life annuities
NB.
NB. y is a 5 element boxed list:
NB.   0  =  ages (numeric list)
NB.   1  =  5 element numeric list:
NB.        0  0=due, 1=immediate
NB.        1  deferred period
NB.        2  guaranteed period
NB.        3  benefit period  (0=for life)
NB.        4  payment frequency (e.g.  1=annual, 12=monthly)
NB.   2  =  interest rates (may be varying)
NB.   3  =  indexing factor (applied annually after first payment)
NB.   4  =  ultimate mortality table qx
NB.
NB. x is optional:
NB.   0  mortality interpolation 0 = constant force (default)
NB.                              1 = uniform distribution
NB.   1  deferral  0 = interest only
NB.                1 = interest and mortality (default)
NB.
NB.  e.g.
NB.    annx 60 61;0 0 5 0 12;0.065 5 0.05;0;QX
NB.        = annuities-due for ages 60 61
NB.          guaranteed 5 years, payable monthly
NB.          interest .065 for 5 years, .05 thereafter
NB.
0 1 annx y
:
if. 5 ~: #y do.
  'ages (imm dfd gtd ben frq) int ndx qx' return. end.

opt=. 2{. x,(#x)}.0 1
'age int inx qx'=. 0 2 3 4 {y
't d g n f'=. >1{y

int=. intrep int
inx=. intrep inx

lfq=. */\@(1&,)@:-.

r=. i. i=. 0
rage=. #age=. age-b=. <.<./age
qx=. b}.qx
len=. (>.t+d+g+>./age)>.$qx
qx=. len{.!.1 qx

if. 1 e. *inx do.
  inx=. (j$1),*/\(len-j=. <.>:d) stretch >: inx end.

if. f > 1 do.
  age=. f*age
  'd g n'=. f*d,g,n
  int=. f# <:(>:int)^%f
  if. 0 ~: {.opt do.
    lx=. lfq qx
    lx=. ({.lx)-0,+/\}:f#(lx-1}.lx,0)%f
  else.
    lx=. lfq f#1-(1-qx)^%f
  end.
else.
  lx=. lfq qx
end.

dt=. d+t
g=. g+dt
n=. n+dt**n
n=. n+(n=0)*$lx
v=. */\n stretch 1,v=. %>:int
dage=. age-iage=. <.age

if. 1 e. *inx do.
  v=. v*($v){.(t#t),f#inx end.

while. rage > i do.
  l=. n{.(i{iage)}.lx
  if. 0 ~: j=. i{dage do.
    l=. (l*1-j)+j*n{.(>:i{iage)}.lx end.
  li=. (d*0={: opt){l
  l=. li (i.g) } l
  l=. 0 (i.dt) } l
  r=. r,(+/l*v)%li+li=0
  i=. >:i
end.

($>{.y)$r%f
)

NB. =========================================================
NB. annxy
annxy=: 3 : 0
NB. joint life annuities
NB.
NB. dat is a 6 element vector:
NB.   0  =  ages (2 element vector, or 2 column matrix of age pairs)
NB.   1  =  5 element vector:
NB.       0  0=due, 1=immediate
NB.       1  deferred period
NB.       2  guaranteed period
NB.       3  benefit period  (0=for life)
NB.       4  payment frequency (e.g.  1=annual, 12=monthly)
NB.   2  =  interest rates (may be varying)
NB.   3  =  indexing factor (applied annually after first payment)
NB.   4  =  ultimate mortality table qx
NB.   5  =  ultimate mortality table qy
NB.
NB. x is one or more options:
NB.   0  mortality interpolation 0 = constant force (default)
NB.                              1 = uniform distribution
NB.   1  deferral  0 = interest only
NB.                1 = interest and mortality (default)
NB.
NB.  e.g.
NB.   annxy 60 61;0 0 5 0 12;0.065 5 0.05;0;qx;qy
NB.        =  joint life annuity-due for ages 60 61
NB.           guaranteed 5 years, payable monthly
NB.           interest .065 for 5 years, .05 thereafter
0 1 annxy y
:
if. -. (6 = #y) *. 5 = #>1{2{. y do.
  'agepairs (imm dfd gtd ben frq) int ndx qx qy'
  return. end.

'age int inx qx qy'=. 0 2 3 4 5 {y
't d g n f'=. >1{y

if. 0 e. $age do. i.0 return. end.

lfq=. */\@(1&,)@:-.

r=. i. i=. 0
age=. age-b=. <.<./age
qx=. b}.qx
qy=. b}.qy
len=. (>.t+d+g+>./age)>.(#qx)>.#qy
qx=. len{.qx,len$1
qy=. len{.qy,len$1
rage=. #age=. _2[\age

int=. intrep int
inx=. intrep inx

if. -. *./ 0=inx do.
  inx=. (j$1),*/\(len-j)$1+inx,(len-j=. <.d+1)${:inx
end.

if. f > 1 do.
  age=. f*age
  'd g n'=. f*d,g,n
  int=. f# <:(>:int)^%f
  if. 0 ~: {.x do.
    lx=. lfq qx
    lx=. ({.lx)-0,+/\}:f#(lx-1}.lx,0)%f
    ly=. lfq qy
    ly=. ({.ly)-0,+/\}:f#(ly-1}.ly,0)%f
  else.
    lx=. lfq f#1-(1-qx)^%f
    ly=. lfq f#1-(1-qy)^%f
  end.
else.
  lx=. lfq qx
  ly=. lfq qy
end.

dt=. d+t
g=. g+dt
n=. n+dt**n
n=. n+(n=0)*(#lx)<.#ly
v=. */\n stretch 1,v=. %>:int
dage=. age-iage=. <.age

if. 1 e. *inx do.
  v=. v*(#v){.(t#t),f#inx end.

while. rage > i do.
  
  'x y'=. i{iage
  
  tx=. n{.x}.lx
  if. 0 ~: j=. {.i{dage do.
    tx=. (tx*1-j)+j*n{.(>:x)}.tx end.
  
  ty=. n{.y}.ly
  if. 0 ~: j=. {:i{dage do.
    ty=. (ty*1-j)+j*n{.(>:y)}.ty end.
  
  l=. tx*ty
  li=. (d*0={: x){l
  l=. li (i.g) } l
  l=. 0 (i.dt) } l
  r=. r,(+/l*v)%li+li=0
  
  i=. >:i
end.

rnk=. 2<$,>{.y
(rnk#$r)$r%f
)

NB. =========================================================
NB. annjls
annjls=: 3 : 0
NB. joint life last survivor annuities
NB.
NB. dat is a 6 element vector:
NB.   0  =  ages (2 element vector, or 2 column matrix of age pairs)
NB.   1  =  8 element vector:
NB.       0  amount guaranteed
NB.       1  continuation to primary (death of secondary)
NB.       2  continuation to secondary (death of primary)
NB.       3  0=due, 1=immediate
NB.       4  deferred period
NB.       5  guaranteed period, after deferred period
NB.       6  benefit period, after deferred period (0=for life)
NB.       7  payment frequency (e.g.  1=annual, 12=monthly)
NB.   2  =  interest rates (may be varying)
NB.   3  =  indexing factor (applied annually after first payment)
NB.   4  =  ultimate mortality table qx
NB.   5  =  ultimate mortality table qy
NB.
NB. x is one or more options:
NB.   0  mortality interpolation 0 = constant force (default)
NB.                              1 = uniform distribution
NB.   1  deferral  0 = interest only
NB.                1 = interest and mortality (default)
NB.                2 = payable only on survivorship of primary life
NB.                    no mortality for secondary life
NB. e.g.
NB.     annjls 65 62;1 1 0.6 0 0 5 0 12;0.07;0;qx;qy
NB.        =  joint life last survivor annuity due
NB.           primary 65, secondary 62,
NB.           100% guaranteed for 5 years
NB.           100% continuation to primary
NB.           60% continuation to secondary
NB.           payable monthly, 7% interest.
0 1 annjls y
:
if. -. (6 = #y) *. 8 = #>1{2{. y do.
  'agepairs (gtfact psfact ssfact imm dfd gtd ben frq) int ndx qx qy'
  return. end.

'age int inx qx qy'=. 0 2 3 4 5 {y
'gtd prm sec t d g n f'=. >1{y

if. 0 e. $age do. i.0 return. end.

lfq=. */\@(1&,)@:-.

r=. i. i=. 0
age=. age-b=. <.<./age
qx=. b}.qx
qy=. b}.qy
len=. (>.t+d+g+>./age)>.(#qx)>.#qy
qx=. len{.qx,len$1
qy=. len{.qy,len$1
rage=. #age=. _2[\age

mix=. j,gtd-+/j=. gtd<.prm,sec
mix=. mix,j,1-gtd++/j=. 0>.(prm,sec)-gtd
mix=. (msk=. mix~:0)#mix

int=. intrep int
inx=. intrep inx

if. -. *./ 0=inx do.
  inx=. (j$1),*/\(len-j)$1+inx,(len-j=. <.d+1)${:inx
end.

if. f > 1 do.
  age=. f*age
  'd g n'=. f*d,g,n
  int=. f# <:(>:int)^%f
  if. 0 ~: {.x do.
    lx=. lfq qx
    lx=. ({.lx)-0,+/\}:f#(lx-1}.lx,0)%f
    ly=. lfq qy
    ly=. ({.ly)-0,+/\}:f#(ly-1}.ly,0)%f
  else.
    lx=. lfq f#1-(1-qx)^%f
    ly=. lfq f#1-(1-qy)^%f
  end.
else.
  lx=. lfq qx
  ly=. lfq qy
end.

dt=. d+t
g=. g+dt
n=. n+dt**n
n=. n+(n=0)*(#lx)<.#ly
v=. */\n stretch 1,v=. %>:int
dage=. age-iage=. <.age

if. 1 e. *inx do.
  v=. v*(#v){.(t#t),f#inx end.

while. rage > i do.
  
  'cx cy'=. i{iage
  
  tx=. n{.cx}.lx
  if. 0 ~: j=. {.i{dage do.
    tx=. (tx*1-j)+j*n{.(>:cx)}.tx end.
  
  ty=. n{.cy}.ly
  if. 0 ~: j=. {:i{dage do.
    ty=. (ty*1-j)+j*n{.(>:cy)}.ty end.
  
  tp=. tx,ty,:tx*ty
  li=. (d*(1{x)e. 0 2){"1 tp
  tp=. tp,tp
  tp=. tp*(2=1{x){1,%/(d,0){tx
  tp=. (g#"1 ,.li) (<0 1 2;i.g) }tp
  tp=. 0 (<(i.6);i.dt) }tp
  tp=. msk#tp
  j=. +/"1 tp*"1 v
  j=. +/mix*j%msk#6$li+li=0
  r=. r,j
  
  i=. >:i
end.

rnk=. 2<$,>{.y
(rnk#$r)$r%f
)

NB. =========================================================
NB. assx
assx=: 3 : 0
NB. single life assurances
NB.
NB. dat is a 4 element vector:
NB.   0  =  ages (integer list)
NB.   1  =  0-4 element vector (default is first example):
NB.       0  0=term (or life), 1=endowment, 2=pure endowment
NB.       1  payment period (0=for life, 1=single premium, -ve=to age)
NB.       2  benefit period (0=for life, -ve=to age)
NB.       3  premium frequency (e.g. 1=annual, 12=monthly)
NB.   2  =  interest rates (may be varying)
NB.   3  =  mortality table qx (select or ultimate)
NB.
NB.  e.g.
NB.    assx 50 51;0 1 _65;0.065 5 0.05;QX
NB.        =  single premium for temporary assurance
NB.           ages 50 51
NB.           term to age 65
NB.           calculated annually
NB.           interest 6.5% for 5 years, 5% thereafter
NB.
if. (-. (,4) -: $y) do.
  'ages (type pay ben frq) int qx' return. end.

'age opt int qx'=. y
't p n f'=. opt,($opt)}.0 0 0 1

if. f < 1 do.
  'premium frequency must be at least 1' return. end.

if. 0 e. rage=. $age=. ,age do. '' return. end.

int=. intrep int

p=. (|p)-age*p<0
n=. (|n)-age*n<0

if. (n ~: 0) *. p>n do.
  'premium payment period must not exceed benefit period'
  return. end.

qx=. qx,1

if. 1=#rho=. $qx do.
  qx=. (age+/i.rho-<./age){qx,rho$1
else.
  cls=. {:rho
  len=. <:+/rho
  ult=. ({.qx),ult,len${:ult=. 1}.{:"1 qx
  qx=. (age{qx),.(age+/cls}.i.len-<./age){ult
end.

n=. n+(n=0)*{:$qx
p=. f*p+(p=0)*n
max=. (>./n)>.{:$qx
v=. vf=. */\max stretch %>:int

if. f > 1 do.
  vf=. */\(f*max) stretch f#(>:int)^-%f
end.

r=. i. i=. 0
while. rage > i
do.
  q=. (i{n){.i{qx
  d=. (1,*/\-.q)*j,{:j=. ($q){.v
  
  if. t=0 do. val=. +/d*q,0
  elseif. t=1 do. val=. +/d*q,1
  elseif. t=2 do. val=. {:d
  end.
  
  if. f>1 do.
    q=. f#-.(-.q)^%f
  end.
  
  if. 1~:i{p do.
    val=. val*f%+/(i{p){.(1,*/\-.q)*1,($q){.vf
  end.
  
  r=. r,val
  i=. >: i
end.
r
)
