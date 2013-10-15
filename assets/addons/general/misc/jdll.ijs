NB. JDLL example
NB.
NB. This script gives examples of calling the J DLL from J. Similar
NB. routines may be written in other languages that can call DLLs.
NB.
NB. The internal representation used is that for intel machines.
NB.
NB. main definitions:
NB. jclear   clear J session
NB. jcmd     send sentence, return result
NB. jdo      send sentence to be executed
NB. jget     retrieve value of J noun
NB. jset     assign value to J noun
NB.
NB. utilities:
NB. jinit    initialize J instance
NB. jfree    free J instance
NB.
NB. Loading the script initializes a J instance, defining
NB. global pJ as the handle. Use jfree to free it.
NB.
NB. see examples at the end of the script, and the dictionary
NB. entry for the 3!: foreign conjunction.

require 'dll'

libj=: IFUNIX{::'j.dll';('Mac'-:UNAME){::'libj.so';'libj.dylib'
SZI=: IF64{4 8

NB. =========================================================
i2j=: (-2+IF64) & ic   NB. binary integer to J
f2j=: _2 & fc   NB. binary float to J
j2i=: (2+IF64) & ic    NB. J to binary integer
j2f=: 2 & fc    NB. J to binary float

NB. =========================================================
NB. write memory, return pointer
mwrite=: 3 : 0
p=. mema l=. #y
y memw p,0,l
p
)

NB. =========================================================
jclear=: 3 : 0
(libj,' JClear i x') cd pJ
)

NB. =========================================================
jcmd=: 3 : 0
jdo 'JDAT=: ',y
jget 'JDAT'
)

NB. =========================================================
jdo=: 3 : 0
(libj,' JDo i x *c') cd pJ, boxopen y
)

NB. =========================================================
NB. jfix
NB. form: trs jfix data_address
NB. trs=type,rank,shape_address
jfix=: 4 : 0
't r s'=. x
d=. y,0
len=. */p=. i2j memr s,0,r*SZI
if. t=1 do. p$ (1{a.)=memr d,len
elseif. t=2 do. p$ memr d,len
elseif. t=4 do. p$ i2j memr d,len*SZI
elseif. t=8 do. p$ f2j memr d,len*8
elseif. t=16 do. p$ _2 j./\ f2j memr d,len*16
elseif. t=32 do. p$ jgetobj &.> i2j memr d,len*SZI
elseif. t=64 do. p$ jgetext &> i2j memr d,len*SZI
elseif. 1 do. 'unrecognized datatype'
end.
)

NB. =========================================================
NB. jfree
jfree=: 3 : 0
(libj,'l JFree i x') cd pJ
)

NB. =========================================================
NB. jget
NB. form: jget 'name'
NB. return value of name
jget=: 3 : 0
cmd=. libj,' JGetM i x *c *x *x *x *x'
'e p n t r s d'=. cmd cd pJ,(,y);4#<,0
if. e do.
  smoutput 'error code: ',":e
  return.
end.
(t,r,s) jfix d
)

NB. =========================================================
NB. jgetobj
NB. form: jgetobj address
jgetobj=: 3 : 0
'p j j t c l r'=. i2j memr y,0, 7*SZI
(t,r,y+7*SZI) jfix y+p
)

NB. =========================================================
NB. jgetext
NB. form: jgetext address
jgetext=: 3 : 0
len=. i2j memr y,(7*SZI), SZI
10000 #. x: |. i2j memr y,(8*SZI),SZI*len
)

NB. =========================================================
NB. jinit
jinit=: (libj,' JInit x') & cd

NB. =========================================================
NB. jset
NB. form: 'name' jset data
NB. assign value to name
jset=: 4 : 0
rep=. 3!:1 y
assert. (225{a.) = {.rep NB. intel32
type=. 3!:0 y
if. type > 16 do.
  'boxed or other types > 16 not supported by jset' return.
end.
rank=. #$y
shape=. ((4*SZI) + i. rank*SZI){rep
val=. ((4*SZI) + rank*SZI)}.rep
ps=. mwrite shape
pv=. mwrite val
dat=. x;,each type;rank;ps;pv
e=. 0 pick (libj,' JSetM i x *c *x *x *x *x') cd pJ,dat
memf ps
memf pv
if. e do.
  smoutput 'error code: ',":e
end.
empty''
)

NB. =========================================================
NB. check DLL will work
3 : 0 ''

pJ=: jinit''
)

NB. =========================================================
dllexamples=: 0 : 0
jdo 'ABC=: i.2 3 4'
jget 'ABC'
'ABC' jset i.2 3 4
jcmd 'i.2 3 4'
jcmd '<"0 i.2 3 4'
jclear''
)

NB. =========================================================
dlltest=: 3 : 0
test '3 3 3 $''abcdef'''
test 'i.3 4'
test 'i.2 3 4'   NB. Difference in padding twixt even & odd ranks?
test '9e9*i.3 4' NB. Floats
test '1.1+i.3 4'
test '1j1+i.3 4' NB. complex
test '<"0[i.3 4' NB. Boxing cells
test '<"1[i.3 4' NB. Boxing lines
test '<"_[i.3 4' NB. Boxing all
test '''a'';<<"1[i.3 4' NB. Boxing various
test 'i. (999999$1)$ 4' NB. high rank odd
test 'i. (999998$1)$ 4' NB. high rank even
test 'i. (99$1)$ 4x' NB. high rank of extended
test 'i. 4x'
test '99^99x'
)

test=: 3 : 0
jdo 'ABC=:',y
smoutput y,~ ' : ',~ ": (".y)-:jget 'ABC'
''
)

NB. dlltest''
