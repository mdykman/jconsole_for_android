NB. System: jodtools  Author: John D. Baker  Email: bakerjd99@gmail.com
NB. Version: 0.9.7  Build Number: 8  Date: 16 Jan 2012 16:59:51
(9!:41)0
coclass'ajodtools'
coinsert'ajodutil'
AGEHEADER=:<;._1 '|Name|Date First put|Days from First put|Date Last put|Days from Last put'
CR=:13{a.
DOCUMENTMARK=:123 126 78 126 125 61 58 32 123 126 67 126 125 32 58 32 48 10 10 78 66 46 42 123 126 78 126 125 32 123 126 84 126 125 45 45 32 119 111 114 100 116 101 120 116 10 78 66 46 10 78 66 46 32 109 111 110 97 100 58 32 32 123 126 78 126 125 32 63 63 10 78 66 46 32 100 121 97 100 58 32 32 63 63 32 123 126 78 126 125 32 63 63 10 10 39 78 73 77 80 32 123 126 78 126 125 39 10 41{a.
ERR00400=:'load script is not unique - edit startup.ijs ->'
ERR00401=:'tag error in startup.ijs file ->'
ERR00402=:'cannot write/create startup.ijs file ->'
ERR00403=:'invalid make load script option (0 or 1)'
ERR00404=:'J script error in group ->'
ERR00405=:'words refer to objects/locales ->'
GROUPSUITES=:<;._1 ' Groups Suites'
IzJODtools=:<;._1 ' addgrp allnames allrefs delgrp fsen getrx hlpnl jodage lg locgrp ltx mg mj mls mt noexp notgrp nt nw obnames pr refnames revonex swex tt usedby'
JODLOADEND=:'NB.</JOD_Load_Scripts>'
JODLOADSTART=:'NB.<JOD_Load_Scripts>'
JODTOOLSVMD=:'0.9.7';8;'16 Jan 2012 16:59:51'
LF=:10{a.
OK00400=:'load script saved ->'
OK00401=:'file saved ->'
OK00402=:' added to ->'
OK00403=:' deleted from ->'
OK00404=:' group loaded'
OK00405=:' group loaded with postprocessor'
OK00406=:') words loaded into -> '
POSTAMBLEPFX=:'POST_'
TESTSTUB=:'teststub'
WARNING00400=:'NB. WARNING: JOD managed section do not edit!'
WORDTESTS=:<;._1 ' words tests'
addgrp=:4 :0
'b a'=.2{.(boxopen x),<2
d=.a grp b
if.0=>{.d do.d 
elseif.1=>{.d=.a grp(b;}.d),y =.boxopen y do.
c=.,>(a=2 3)#WORDTESTS
ok((":#y),' ',c,OK00402);b
elseif.do.d
end.
)
addloadscript=:4 :0
y=.jpathsep&.>y
if.1=x do.
f=.JODLOADSTART;JODLOADEND
if.fex<a=.jpath'~config/startup.ijs'do.
e=.read a
'p c'=.f betweenidx e
else.
p=.e=.''
end.
if.1=#p do.
if.badrc b =.(;p{c)addloadscript1 y do.b return.else.b =.>1{b end.
d=.toHOST;(<(LF}.~LF-:{.b),b)p}c
elseif.0=#p do.
b=.(0{f),(<LF,'buildpublic_j_ 0 : 0',LF),(0{y),(<'  '),(1{y),(<LF,')',LF),1{f
d=.toHOST e,(2#LF),WARNING00400,LF,;b
elseif.do.
(jderr ERR00401),<a return.
end.
if._1-:d(write ::_1:)a do.
(jderr ERR00402),<a return.
end.
y=.y,&.>'';IJS
if.wex<'Public_j_'do.Public_j_ =:Public_j_ updatepublic y
elseif.wex<'PUBLIC_j_'do.PUBLIC_j_ =:PUBLIC_j_ updatepublic y
end.
ok OK00400;1{y
elseif.0=x do.
ok OK00401;(1{y),&.><IJS
elseif.do.
jderr ERR00403
end.
)
addloadscript1=:4 :0
if.0=#x do.ok x return.end.
a=.<;._1((LF={.x)}.LF),x-.CR
b=.(' '&beforestr&.>a)e.0{y
if.1>:+/b do.
c=.<;(<'  ')(1)}1 0 1#^:_1 y
if.+./b do.
a=.c(I.b)}a
else.
b=.1,~-.(a-.&.>' ')e.<,')'
a=.c(I.-.b)}b#^:_1 a
end.
ok}.;LF,&.>a
else.
(jderr ERR00400),0{y
end.
)
allnames=:~.@('__'&beforestr&.>@obnames,refnames)
allrefs=:[:/:~[:~.],[:refnames 31&uses
betweenidx=:4 :0
if.#y do.
's e'=.x
assert.-.s-:e
a=.e E.y
f=.(-#s )|.!.0 s E.y
d=.+/f
assert.d=+/a
c=.(1 (0)}f+.a)<;.1 y
b=.1#~>:+:d
b=.(-.f{.;.1 a)(>:+:i.d)}b
c=.b#^:_1 c
((#i.@#)(#c)$0 1);<c
else.
(i.0);<y
end.
)
createjodtools=:3 :0
a=.0{y[jod=.1{y
ST=:ST__jod
MK=:MK__jod
UT=:UT__jod
SO=:SO__jod
JODEXT__jod=:JODEXT__jod,a
IZJODALL__jod=:IZJODALL__jod,IzJODtools,<'JODtools'
(i.0 0)"_".&.>a defzface IzJODtools
)
dayage=:3 :0
0 dayage y
:
if.x do.n=.today ~0 else.n=.today 0 end.
(x todayno n)-x todayno y
)
delgrp=:4 :0
'b a'=.2{.(boxopen x),<2
d=.a grp b
if.0=>{.d do.d 
elseif.1=>{.d=.a grp b;}.d-.y =.boxopen y do.
c=.,>(a=2 3)#WORDTESTS
ok((":#y),' ',c,OK00403);b
elseif.do.d
end.
)
firstcomment=:3 :0
a=.3}."1 ljust onlycomments];._2(y-.CR),LF
b=.+./"1((,:MONADMARK)E.a)+.(,:DYADMARK)E.a
a=.,' ',.a#~-.+./\b
a=.reb a{.~firstperiod a
if.#a do.
if.'*'={.,a do.
alltrim'--'afterstr a
end.
end.
)
firstperiod=:3 :0
y=.(500<.#y){.y
a=.;&.>,{(<<"0' ([{'),<;:'m. n. x. y. u. v. *.'
y=.' '(I._2(|.!.0)+./a E.&><y)}y
y i.'.'
)
fsen=:];[:firstcomment disp
getrx=:3 :0
'base'getrx y
:
if.badrc a=.31 uses y do.a
elseif.#b=.obnames a do.(jderr ERR00405),b
elseif.a=.~.({."1>{:a),refnames a
badrc b=.x get a do.b
elseif.do.
ok'(',(":#a),OK00406,x
end.
)
hlpnl=:3 :0
0 hlpnl y
:
if.empdnl y do.ok''
elseif.0=>{.a=.(x,EXPLAIN)get y do.a
elseif.do.
a=.>{:a
(>{."1 a);>{:"1 a
end.
)
jodage=:3 :0
0 jodage y
:
if.badil x do.jderr ERR001
elseif.y=.,boxopen y
badrc a=.(({.x),14)get y do.a
elseif.badrc b=.(({.x),13)get y do.b
elseif.do.
g=./:c=.<.,.1 dayage<.a=.rv a
d=.,.<.1 dayage<.b=.rv b
e=.AGEHEADER
ok<e,:(<g){&.>(>y);(,.b);d;(,.a);<c
end.
)
lg=:3 :0
2 lg y
:
if.x-:2 do.
b=.OK00404
t=.2 _2 make y
else.
b=.OK00405
t=.2 mls y
end.
'r s'=.2{.t
if.r do.
a=.18!:5''
18!:4<'base'
try.0 !:0 s
catchd.
18!:4 a
(jderr ERR00404),y;13!:12''
return.
end.
18!:4 a
ok(y),b
else.
t
end.
)
locgrp=:3 :0
b=.2 3 dnl&.><''
if.*./m=.;{.&>b do.
b=.}.&.>b
a=.2 3}.@:grp&.>&.>b
m=.a(+./@:e.)&>&.><<<,y
ok<GROUPSUITES,.m#&.>b
else.
>{.(-.m)#&.>b
end.
)
ltx=:];22"_;gt
mg=:2 _1&make
mj=:];21"_;gt
mls=:3 :0
1 mls y
:
v=.2 _2 make a=.y-.' '
'r s'=.2{.v
if.r do.
c=.POSTAMBLEPFX
if.badrc e =.4 dnl c do.e return.end.
if.(<d=.c,a)e.}.e do.
v=.4 get d
'r p'=.2{.v
if.r do.s=.s,(2#LF),(<0;2){::p else.v return.end.
end.
if.2-:x do.ok s
else.
pdo=.{:0{DPATH__ST__JODobj
b=.(SCR__pdo),a,IJS__JODobj
(toHOST s)write b
x addloadscript a;(SCR__pdo),a
end.
else.
v
end.
)
mt=:];25"_;gt
noexp=:3 :0
0 noexp y
:
if.badrc a=.x dnl y do.a
elseif.a:e.a do.ok''
elseif.badrc a =.(({.x),EXPLAIN)get}.a do.a 
elseif.0=#a =.rv a do.ok''
elseif.do.
ok(0=#&>{:"1 a)#{."1 a
end.
)
notgrp=:3 :0
GROUP notgrp y
:
if.badrc y =.checknames y do.y return.end.
y=.}.y
select.x
case.GROUP do.ok y-.;grp&.>}.GROUP dnl''
case.SUITE do.ok y-.;SUITE grp&.>}.SUITE dnl''
case.do.jderr ERR001
end.
)
nt=:3 :0
b=.y-.' '
'r s'=.2{.t=.1 get TESTSTUB
if.r do.
'a d'=.yyyymondd 0
c=.('/{~T~}/',b,'/{~created~}/',a,'/{~errortime~}/',a,' ',d)changestr>1{,s
b et c
else.
t
end.
)
nw=:3 :0
3 nw y
:
b=.y-.' '
if.-.x e.i.5 do.x =.3 end.
a=.x{'nacvv'
if.0=(4!:0)<'DOCUMENTCOMMAND'do.
d=.DOCUMENTMARK,LF,LF,DOCUMENTCOMMAND
else.
d=.DOCUMENTMARK
end.
c=.'/{~N~}/',(y-.' '),'/{~C~}/',(":x),'/{~T~}/',a
d=.c changestr d
b et d
)
obnames=:[:/:~[:~.[:;2:{"1[:>{:
onlycomments=:3 :0
c=.($y)$'NB.'E.,y
c=.-.+./\"1 c>~:/\"1 y e.''''
y=.,y
y=.' '((,c)#i.#y)}y
y=.y$~$c
y#~y+./ .~:' '
)
pr=:0&globs,:~put
refnames=:[:/:~[:~.[:;1:{"1[:>{:
revonex=:3 :0
/:~0 revonex y
:
if.badrc a=./:~x revo y do.a
elseif.a:e.a do.ok''
elseif.badrc a =.(({.x),EXPLAIN)get}.a do.a 
elseif.0=#a =.rv a do.ok''
elseif.do.
ok(0=#&>{:"1 a)#{."1 a
end.
)
swex=:0 8&put@:fsen
today=:3 :0
3&{.@(6!:0)''
:
0 100 100#.<.3&{.@(6!:0)''
)
todayno=:3 :0
0 todayno y
:
a=.y
if.x do.a =.0 100 100#:a end.
a=.((*/r=.}:$a),{:$a)$,a
'y m d'=.<"_1|:a
y=.0 100#:y-m<:2
n=.+/|:<.36524.25 365.25*"1 y
n=.n+<.0.41+0 30.6#.(12|m-3),"0 d
0>.r$n-657378
)
tt=:];gt
updatepublic=:4 :0
p=.(0{"1 x)i.0{y
if.p<#x do.
x=.y p}x
else.
x=.x,y
x=.(/:0{"1 x){x
end.
)
usedby=:4 :0
if.badrc c=.uses y do.c
else.
c=.>{:c
b=.boxopen x
a=.>:+./'_'&e.&>b
ok/:~({."1 c)#~;(a{"1 c)+./@e.&.><b
end.
)
yyyymondd=:3 :0
c=.'r<0>2.0'
e=._3[\'   janfebmaraprmayjunjulaugsepoctnovdec'
'h d b'=.3{.f=.6!:0''
a=.(":h),(d{e),,c(8!:2)b
g=.}.;':',&.>c(8!:0)_3{.f
a;g
)
(9!:41)1
cocurrent'base'
JODtools_ijod_=:conew'ajodtools'
(1!:2&2)createjodtools__JODtools JODtools,JODobj
