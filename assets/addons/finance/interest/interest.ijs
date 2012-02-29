NB. interest functions
NB.
NB. Note on interest rates:
NB.
NB.  The utilities here assume effective rates of interest, e.g.
NB.  $100 invested at 10% accumulates to $110 at year end,
NB.  irrespective of the frequency with which interest is paid.
NB.
NB.  Many financial programs use nominal rates, e.g. $100 invested
NB.  at 10% nominal compounded monthly accumulates to 110.471 =
NB.  100*(1+0.10%12)^12
NB.
NB.  Convert nominal to effective using verb <effnom>, e.g.
NB.    amort 12 0.08 15               amortization at 8% effective
NB.    amort 12,(12 effnom 0.08),15   amortization at 8% nominal
NB.
NB. Definitions:
NB.
NB.   drn accint    intlist    accumulate intlist for duration
NB.   frq effnom    intrate    return effective from nominal
NB.       intexpand intlist    expand modal intlist
NB.   frq intm      intrate    convert single intrate to modal
NB.   frq intrep    intlist    expand intlist
NB.   frq vrep      intlist    expand intlist to discount rates
NB.   len stretch   list       stretch list to length len
NB.
NB.       accpay    dat        accumulate payments
NB.   opt accndx    dat        accumulate indexed payments.
NB.
NB.       amort     dat        calculate amortization table
NB.       annt      dat        annuities certain
NB.   opt irr       cf         internal rate of return
NB.       npv       dat        net present value
NB.       osb       dat        outstanding loan balance
NB.       ruleof78  term       outstanding balance on rule of 78
NB.   int vt        term       v to the power t
NB.   opt xirr       cf        as irr but with non-periodic payments
NB.
NB. where:
NB.   <intlist>  is an interest list, e.g. 0.09 5 0.08 3 0.075
NB.   <intrate>  is a single interest rate, e.g. 0.075

effnom=: [: <: ([: >: ] % [) ^ [
intexpand=: 1&>.@(#~ 1&|.@(1&>)) # (#~ 1&>)
intm=: <: @ ((^%)~ >:)
stretch=: [ $ ] , ($ ,: @ {:)
accint=: */\ @ (1&,) @ (stretch >: @ intexpand)

NB. =========================================================
intrep=: 3 : 0
NB. returns modal interest rates from annual rates which may
NB. contain integer replication factors following each rate.
NB. all rates must be >:0 and <1
NB. the last rate is not replicated
1 intrep y
:
int=. <:(>:y)^(-.b)+(b=. y<1)%x
if. 1<#int do.
  int=. ((}:x*1>.(1|.b)#int),1)#b#int
end.
)

vrep=: % @ >: @ intrep

NB. =========================================================
NB. accndx
accndx=: 3 : 0
NB. accumulate indexed payments
NB. initial payment rate is 1 per annum.
NB.    dat=  imm  0=advance, 1=arrears
NB.          frq  payment frequency 12=monthly
NB.          int  annual interest rate
NB.          yrs  number of years
NB.          ndx  indexation rate (annual increases)
NB.    opt=  0   return end year values only (default)
NB.          1   return all values
NB.
NB. e.g. accndx 1;12;0.10 5 0.09;24;0.025
NB.      = 24 years payments of 1 indexed at 2.5%
NB.        payable monthly in arrears
NB.        interest 10% for 5 years, 9% thereafter
0 accndx y
:
if. 5 ~: #y do.
  'imm frq int yrs ndx' return. end.
'm f i y n'=. y
len=. f*y
n=. y$0,n,y${:n
i=. f intrep i
i=. len$i,len${:i
p=. f#(%f)**/\1+n
j=. */\len$1+i
r=. j*+/\p%m}.1,(<:m)}.j
(len$x>.(-f){.1)#r
)

NB. =========================================================
NB. accpay
accpay=: 3 : 0
NB.    dat= imm  0=advance, 1=arrears
NB.         frq  payment frequency 12=monthly
NB.         int  annual interest rate
NB.         pay  payments per annum
NB.
NB. e.g. accpay 1;12;0.10 5 0.09;24#1
NB.      = 24 years payments of 1 payable monthly in arrears
NB.        interest 10% for 5 years, 9% thereafter
if. 4 ~: #y do.
  'imm frq int pay' return. end.
'm f i p'=. y
len=. $p=. f#p%f
j=. }. len accint f intrep i
r=. j*+/\p%m}.1,(m-1)}.j
(len$(-f){.1)#r
)

NB. =========================================================
NB. amort
amort=: 3 : 0
NB. Generates an amortization table for loan of 1.
NB. payments are assumed to be made in arrears.
NB.
NB. y has 3 elements:
NB.   frq  =  payment frequency (e.g. 1=annual, 12=monthly)
NB.   int  =  decimal interest rate per annum.
NB.   yrs  =  number of years of loan
NB.
NB. result is a matrix:  pay osb ip pp
NB.   psy  =  level payment necessary to amortize the loan
NB.   osb  =  outstanding balance before each payment
NB.   ip   =  interest portion of each payment
NB.   pp   =  principal portion of each payment
NB.
NB. e.g  amort 12;0.125;25
NB.      = 25 year loan payable monthly at 12.5%
if. 3 ~: #y do.
  'frq int yrs' return. end.
'f i y'=. y
len=. f*y
i=. <:(>:i)^%f
vn=. */\1,len$%>:i
osb=. osb%{.osb=. |.-.}.vn
pay=. %+/}.vn
pp=. pay-ip=. osb*i
pay,.osb,.ip,.pp
)

NB. =========================================================
NB. annt
annt=: 3 : 0
NB. annuity certain.
NB.
NB. y is a 4 element vector:
NB.    0  =  durations (numeric list)
NB.    1  =  3 element vector:
NB.        0  0=due, 1=immediate
NB.        1  deferred period (not included in durations)
NB.        2  payment frequency (e.g. 1=annual, 12=monthly)
NB.    2  =  interest rates (may be varying)
NB.    3  =  indexing factor (applied annually after first payment)
NB.
NB. e.g.
NB.     annt 10 20 30;0 0 12;0.065 5 0.05;0
NB.        = monthly annuities due certain for durations 10 20 30
NB.          interest .065 for 5 years, .05 thereafter.
NB.
if. 4 ~: #y do.
  'drns (imm dfd frq) int ndx' return. end.
'n i x'=. 0 2 3 {y
't d f'=. >1{y

r=. s=. n*0
n=. (msk=. n>0)#n
if. 0=#n do. msk return. end.

i=. intrep i
x=. intrep x

ben=. (len=. >.>./n)#1
if. 1 e. x > 0 do.
  ben=. */\len stretch 1, >:x end.

d=. d*f [ n=. n*f
if. -. 1 e. *i do.
  (n{0,+/\f#ben)%f return. end.

n=. n+d=. d+t
v=. f#(>:i)^-%f
ben=. (d$0),f#ben
len=. $ben
v=. */\len stretch 1,v
s=. (n{0,+/\v*ben)%f
r=. s (I. msk) } r
($>0{y)$r
)

NB. =========================================================
NB. irr
NB.
NB. internal rate of return by newton-raphson iteration.
NB.
NB. form: t irr cf
NB.   t  = optional initial trial value (decimal rate)
NB.   cf = cash flow starting at time 0
NB.
NB. tolerance 1e_5, max iterations 15
NB.
NB. result is decimal interest rate, or error message
NB.
NB. see also xirr for non-periodic payments
irr=: 3 : 0
0 irr y
:
t=. %>:x
cf=. ,y
tol=. 1e_5
max=. 15
if. 2>#cf do. 'cash flow must have at least two elements' return. end.
if. -. *./_1 1 e.*cf do. 'no sign change in cash flow' return. end.
cf=. (|.cf),:|.1|.cf*i.#cf
while. tol<|t-r=. t-%/t#.cf do. t=. r
  if. 0=max=. <:max do. 'iterations exceeded' return. end.
end.
<:%r
)

NB. =========================================================
NB. npv
NB. Net present values
NB. y has 4 elements:
NB.   imm  =  0=advance, 1=arrears
NB.   frq  =  payment frequency (e.g. 1=annual, 12=monthly)
NB.   int  =  annual earned interest rate
NB.   pay  =  payments per annum
NB.
NB. e.g. npv 1;12;0.10 5 0.09;24#1
NB.      = 24 years payments of 1 payable monthly in arrears
NB.        interest 10% for 5 years, 9% thereafter
npv=: 3 : 0
if. 4 ~: #y do.
  'imm frq int pay' return. end.
'm f i p'=. y
len=. $p=. f#p%f
i=. len$i,len${:i=. f intrep i
+/p*m}.1,(<:m)}.*/\len$%>:i
)

NB. =========================================================
NB. osb
NB. Outstanding balances on loan repaid by level instalments
NB. y = int,yrs
osb=: 3 : 0
if. 2 ~: #y do.
  'int yrs' return. end.
'i y'=. y
if. 0=i
do. (|. i. >:y)%y
else. (%{.)|.-.*/\1,y$%>:i
end.
)

NB. =========================================================
NB. ruleof78
NB. Generates outstanding balances on rule of 78
ruleof78=: (% {.) @ (|.@(+/\)@i.@>:)

NB. =========================================================
NB. vt
NB. int vt t
NB. v to the power t
NB.   t   =  durations
NB.   int =  interest rate
NB.
NB. e.g. 0.065 5 0.05 vt 5 6 7 8
NB.      = discount at durations 5 6 7 8
NB.        interest 6.5% for 5 years, 5% thereafter
vt=: 4 : 0
if. 1=#x do.
  r=. y^~%>:x
else.
  i=. intexpand x
  len=. >:>.>./t=. ,y
  v=. 1,*/\len$v,len${:v=. %>:i
  r=. (w=. <.t) { v
  if. 1 e. *f=. t-w do.
    r=. r* f^~w{ (}.%}:)v end.
end.
($y)$r
)

NB. =========================================================
NB. xirr
NB.
NB. internal rate of return by newton-raphson iteration.
NB.
NB. form: t xirr cf
NB.   t  = optional initial trial value (decimal rate)
NB.   cf = cash flow as 2 row table:
NB.         time
NB.         payment
NB.
NB. tolerance 1e_5, max iterations 15
NB.
NB. result is decimal interest rate, or error message
NB.
NB. see also irr for period payments
NB.
NB. example:
NB.
NB.    time=. 0 1.2 4.7 5
NB.    pay=. _100 10 8 120
NB.    [x=. 0 xirr time,:pay
NB. 0.0713808
NB.    +/ pay * (1+x) ^ -time
NB. 1.45661e_12
xirr=: 3 : 0
0 xirr y
:
t=. %>:x
'time cf'=. |."1 y
tol=. 1e_5
max=. 15
if. 2>#cf do. 'cash flow must have at least two elements' return. end.
if. -. *./_1 1 e.*cf do. 'no sign change in cash flow' return. end.
df=. cf * time
mp=. +/ . *
while.
  r=. t - (cf mp t ^ time) % df mp t ^ time - 1
  tol < |t-r do.
  t=. r
  if. 0=max=. <:max do. 'iterations exceeded' return. end.
end.
<:%r
)

