NB. actuarial misc utilities
NB.
NB. actable       read table from file
NB. agerated      rate qx table
NB. commfns       commutation functions
NB. dfi           dependent from independent rates
NB. explife       expectation of life
NB. exprate       experience rate qx table
NB. getage        return values for ages from table
NB. ifd           independent from dependent rates
NB. lfq           return lx from qx
NB. joint         calculate a joint life table
NB. lmodal        convert lx into modal rates
NB. qfl           return qx from lx
NB. qmodal        convert qx into modal rates
NB. qsurvivor     last survivor mortality from individual mortality
NB. ultpart       return ultimate part of select & ultimate table

NB. lfq
lfq=: */\@(1e8&,&:-.)

NB. qfl
qfl=: -.@(}.%}:)

NB. ultpart
NB. Returns ultimate part of a select & ultimate table.
ultpart=: (0&{ , }.@:(_1&{"1)) @ ,.

NB. actable
actable=: 3 : 0
NB. reads table file
'' actable y
:
file=. jpath '~addons/finance/actuarial/actables'
if. 0 e. #y do.
  kdir file
else.
  >kread file;y
end.
)

NB. agerated
agerated=: 3 : 0
NB. Rate actuarial qx table up or down yrs years.
NB.
NB. y is a vector or matrix
NB. x is either a singleton, or a vector of rates for each age,
NB. where the last rate given is applied thereafter.
NB.
NB. e.g. ((76#3),0) agerated QX
NB.           = 3 year age rating up to age 75, 0 rating 76 and up.
:
yrs=. x
tab=. y
if. 0 *./ .= yrs do. tab return. end.
if. yrs *./ .= {.yrs do.
  yrs=. {. yrs
  (-(#tab)+|0<.yrs){.tab=. (0>.yrs)}.tab
  return.
end.
fin=. 1= {: ,tab
if. 1=#$tab do.
  max=. (>./|yrs)+#,tab
  len=. >:>./yrs=. 0>.(i.max)+max{.yrs,max${:yrs
  (fin+tab i.1){.tab=. (yrs{len{.tab,len#1),1
else.
  len=. <:+/('rws';'cls')=. $tab
  rot=. |."0 1&.|:
  max=. cls+>./|yrs
  tab=. max}. (-i.cls) rot (max$,:0{tab),tab,(max,cls)$1
  yrs=. 0>.(i.len)+len{.yrs,len${:yrs
  tab=. (i.cls) rot yrs{tab
  (rws<.fin+(_1{"1 tab) i.1) {.tab
end.
)

NB. commfns
commfns=: 3 : 0
NB. return commutation functions:  D, N, C, M, and population L.
NB. each is a vector ending in 0.
NB.
NB.  y has 2 elements: int;qx
NB.   int  =  decimal interest rate
NB.   qx   =  ultimate qx mortality
NB.
NB.  x is optional, if = 1 calculate continuous values for M, N
NB.
NB. interest may be varying, but if so values only apply for initial
NB. age of table.
0 commfns y
:
('int';'qx')=. y
qx=. (>:qx i.1){.qx,1
l=. */\100000000,-.qx
int=. intrep int
v=. */\(#l) stretch %>:int
n=. +/\.d=. l*1,}:v
m=. +/\.c=. v*l-}.l,0
if. x=1 do.
  n=. n-0.5*d
  m=. +/\.c*(#l) stretch int%^.>:int
end.
d;n;c;m;l
)

NB. dfi
dfi=: 3 : 0
NB. return dependent rates from independent rates, assuming constant force
NB.
NB. tbl is an n-row matrix, each row being a set of independent rates
b=. 1> p=. */-. y
dep=. tbl=. b# |: y
b1=. 0< p=. b#p
t2=. b1#tbl
p=. b1#p
tmp=. (^.-.t2) * (-.p)%^.p
ndx=. (I. b1) { i.$dep
dep=. tmp ndx } dep
b1=. -. b1
tmp=. tmp % +/"1 tmp=. b1#tbl
ndx=. (I. b1) { i.$dep
dep=. tmp ndx } dep
($y) {. |: dep
)

NB. explife
explife=: 3 : 0
NB. curtate expectation of life
NB. syntax: ages explife qx
NB. (add 0.5 for complete expectation)
:
sl=. +/\. }.l=. */\1,-.y
(x{sl) % x{ l
)

NB. exprate
exprate=: 3 : 0
NB. rate exprate qx
NB. experience rate qx table (multiplicative load)
NB.
NB. If qx is 1 to start off with, it stays that way.
:
1<.(y=1)+x*y*y<1
)

NB. getage
getage=: 3 : 0
NB. return data for given age from actuarial table.
NB.
NB. syntax:  age getage table
NB.  age = one or more ages
NB.  tab = select or ultimate table
NB.
NB. Result is a vector if age a scalar, otherwise a matrix.
:
tab=. ,. y
age=. x
('rws';'cls')=. len=. $ tab
len=. <:+/len
ult=. (0{tab),ult,len${:ult=. 1}. _1{"1 tab
(age{tab),"1(age+/cls}.i.len-<./age){ult
)

NB. ifd
ifd=. 3 : 0
NB. return independent rates from dependent rates, assuming constant force
NB.
NB. tbl is an n-row matrix, each row being a set of dependent rates.
b=. *./\ 1 >: q=. +/y
tbl=. b#"1 y
q=. ($tbl)$ b#q
-. (-.q)^tbl%q
)

NB. joint
joint=: 3 : 0
NB. Calculate a joint life mortality table.
NB.
NB. y = boxed list of two or more qx tables (select or ultimate)
NB.
NB. e.g. joint (_3 agerated actable'GAM83F')(actable'GAM83M')
NB.        = joint female and male, females rated down 3 years.

if. 1=#y do.
  >y return. end.

if. 2<#y do.
  joint (<joint 2{.y),2}.y return. end.

('t0';'t1')=. -.&.>y

NB. both select:
if. (2=#$t0) *. 2=#$t1 do.
  c=. {:($t0)-$t1
  if. c < 1 do.
    ('t0';'t1')=. t1;t0
    c=. |c end.
  if. c do.
    rho=. c,#t1
    t1=. t1,.|:rho{.(>:i.c)|."0 1 (c#,:{:"1 t1),"1 c$0
  end.
  
else.
  if. (1=#$t0)*.2=#$t1 do.
    ('t0';'t1')=. t1;t0 end.
  if. 2=#$t0 do.
    rho=. (c=. <:{:$t0),#t1
    t1=. |:t1,rho{.(>:i.c)|."0 1 (c#,:t1),"1 c$0
  end.
end.

rho=. ($t0)<.$t1
-.(rho{.t0)*rho{.t1
)

NB. lmodal
lmodal=: 3 : 0
NB. converts an ultimate lx table into a modal table.
NB.
NB. y  = populations
NB. x  = optional 2 element vector
NB.   [0]  modal frequency, e.g. 12=monthly from annual (default)
NB.   [1]  interpolation 0=constant force (default)
NB.                      1=uniform distribution
NB.
NB. e.g.  lmodal lfq QX
NB.         = monthly table assuming constant force
12 0 lmodal y
:
('mode';'type')=: 2{.x,(#x)}.12 0
len=: #lx=: y
if. type=0 do.
  ({.lx) **/\1,}:mode#((}.lx,0)%lx)^%mode
else.
  ({.lx)-0,+/\}:mode#(lx-}.lx,0)%mode
end.
)

NB. qmodal
qmodal=: 3 : 0
NB. converts an ultimate qx table into a modal table.
NB.
NB. y  = rates
NB. x  = optional 2 element vector
NB.   [0]  modal frequency, e.g. 12=monthly from annual (default)
NB.   [1]  interpolation 0=constant force (default)
NB.                      1=uniform distribution
NB.
NB. e.g.  qmodal QX
NB.         = monthly table assuming constant force
12 0 qmodal y
:
('mode';'type')=. 2{.x,(#x)}.12 0
len=. mode*#qx=. ,y
rho=. #qx=. (qx i.1){.qx
if. type=0 do.
  qx=. mode#-.(-.qx)^%mode
else.
  qx=. rho$ .: mode#qx%mode
  qx=. ,qx%1-0,+\0 }:qx
end.
qx=. len{.qx,len#1
)

NB. qsurvivor
qsurvivor=: 3 : 0
NB. q1 qsurvivor q2
NB. last survivor mortality from individual mortality
:
len=. (#x)>.#y
lx=. len{.*/\-.x
ly=. len{.*/\-.y
lxy=. lx+ly-lx*ly
t0=. (lxy i.0){.lxy
-.($lxy){.t0%1,}:t0
)
