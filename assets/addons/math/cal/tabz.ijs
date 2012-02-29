NB. ~user/tabula/tabz.ijs
NB. Utilities and data for TABULA to reside in z locale
NB. (adapted from old launcher: tabula.ijs)
NB. --IN THIS ADDONS EDITION: loaded by: cal.ijs

cocurrent 'z'

NB. =====================================
NB. zuv.ijs  zuvco.ijs  zuany.ijs
NB. =====================================

b2b=:	]
b2o=:	[: }. [: ; ' ' ,&.> ]
b2f=:	[: }. [: ; LF ,&.> ]
b2x=:	>

o2b=:	[: <;._1 ' ' , ]
o2o=:	]
o2f=:	3 : 'LF(I. y='' '')}y'
o2x=:	b2x@o2b f.

f2b=:	[: <;._1 LF , ]
f2o=:	3 : ''' ''(I. y=LF)}y'
f2f=:	]
f2x=:	b2x@f2b f.

x2b=:	[: (#~ ([: +./\. ' '&~:))&.> <"1
x2o=:	b2o@x2b f.
x2f=:	b2f@x2b f.
x2x=:	]

nul1=: 1 : 'if. 0=#y do. 0$0   else.   u y end.'
fix1=: 1 : 'if. 0=#y do. 0$0   else. >@u y end.'  NB. for: *2f
nul2=: 1 : 'if. 0=#y do. i.0 0 else.   u y end.'
fix2=: 1 : 'if. 0=#y do. i.0 0 else. >@u y end.'  NB. for: *2x

	NB. PATCHED interconversions of form: *2*
NB. b2f=:	(([: > [) , LF , [: > ]) / fix1   NB. old
b2x=:	> nul2

o2b=:	([: <;._1 SP , ])nul1
o2x=:	([: <;._1 SP , ]) fix2

f2b=:	([: <;._1 LF , ])nul1
f2x=:	([: <;._1 LF , ]) fix2

zutype=: 3 : 0
	NB. Returns scalar char showing what type of list y is...
	NB. 	'o'	-openlist
	NB. 	'b'	-boxed
	NB. 	'x'	-literal mx
	NB. 	'f'	-LF-separated
	NB. 	'n'	-empty (common to all types)
	NB. 	'-'	-not a valid zutype
if.	0=#y		do. 'n' return.
elseif. 32=z=. 3!:0 y	do. 'b' return.
elseif. 2~:z		do. '-' return.	NB. non-literal
elseif.	2=s=.#$y	do. 'x' return. NB. litmx
elseif.	0=s		do. 'o' return. NB. scalar char
elseif.	LF e. y		do. 'f' return. NB. LF-sep
elseif.	' ' e. y	do. 'o' return. NB. ' '-sep
elseif.	1=s		do. 'o' return. NB. scalar char
end.
'-'	NB. whatever remains is not a good zutype
)

	NB. Error verbs to return empty list of correct zutype
	NB. -called if verb *2* fails in: any2* ...
LL=: ''"_		NB. empty literal 1D list
MM=: (i.0 0)"_		NB. empty literal 2D list
BB=: LL			NB. (use as) empty boxed list also

	NB. Generic interconversions of form: any2*
any2b=:	3 : '". :: BB ''2b y'',~zutype y'
any2o=:	3 : '". :: LL ''2o y'',~zutype y'
any2x=:	3 : '". :: MM ''2x y'',~zutype y'
any2f=:	3 : '". :: LL ''2f y'',~zutype y'


NB. =====================================
NB. tabz.ijs
NB. =====================================

requirez=: empty
	NB. requirez is CURRENTLY USED ONCE ONLY in tab.ijs
	NB.	requirez 'zis zlogical'

COBZ=: ;:'base cal uu z zulu top'	NB. used by test utility: co

	NB. "Missing / corrupt values"
UNDEFINED=: _.	NB. should propagate in a formula
INVALID=: _.j_.	NB. should differ from UNDEFINED but propagate also

undefined=: (3 : 0)"0
	NB. test for presence of UNDEFINED
if. -. 128!:5 y do. 0 return. end.
'_.' -: 5!:6 <'y'
)

invalid=: (3 : 0)"0
	NB. test for presence of INVALID
if. -. 128!:5 y do. 0 return. end.
'_.j_.' -: 5!:6 <'y'
)

	NB. THE FOLLOWING IS CURRENTLY UNUSED
	NB. BUT MAY FIND A USE IN: uu/umake ...
eat=: 4 : 0
	NB. process list y line-by-line by proverb (x)
x apply ''	NB. init via x
j=. 0 [ le=. I. y=LF
for_i. le do.
  x apply j}. i{.y
  j=. i+1
end.
#le	NB. return # lines processed
)

default=: 3 : 0
	NB. noun: y created with value: x
0 default y	NB. x defaults to: 0
:
	NB. allow: MYVAR=: 99 default 'MYVAR'
	NB. -as well as:   99 default 'MYVAR'
if. 0<: 4!:0 <y do. ".y return. end.
". y , '=:x'
)

cmx=: [: > <;._2		NB. expects trailing LF

listnameswithprefix=: 0 1 2 3&$: :(] ((] -: ({.~ #))S:0 _ # [)~ a: , [ 4!:1~ [: {. ])


mt=: 0 e. $			NB. =1 iff y is empty
bh=:    ] }.~ [: >: ' ' i.~ ]	NB. behead y up to 1st SP
detb=: 3 : 'deb y rplc (9{a.) ; SP'		NB. c/f deb, but TAB-->SP
dtlf=: (#~) ([: ((+./)\.) ((10{a.)&~:))
boxvec=: [: dltb&.> <"1		NB. convert cmx-->boxed list

	NB. Diagnostics...
cx=: 3 : 0
	NB. check for complex nouns in given locale
loc=. >coname''
nocomplex=. 1
for_no. nl 0 do.  val=. ".nom=. >no
  if. 16=3!:0 val do.
    smoutput nb 'cx:' ; nom ; 'is complex'
    nocomplex=. 0
  end.
end.
NB. Suppress ok-confirmation...
NB. if. nocomplex do. smoutput 'cx: no nouns are complex in: ',loc end.
i.0 0
)

aann=: 4 : 0
	NB. Generate integer-suffixed id
	NB. eg pq012 from: 'pq000' aann 12
	NB. 0 can be replaced by 0-9
	NB. x is any valid (str) id
n=. -+/x e. '0123456789'  NB. n<0 -to count from end
(n}.x),n{.":100000000+y	  NB. re-fit suffix
)

isLen2=: 2 = #			NB. true: 2 = #y
isBools=: [: all 0 1 e.~ ]	NB. true: 0 | 1 | 0 1
isBool=: isBools *. isScalar	NB. true: 0 | 1
isaN=: isNum andnot NaN		NB. true: number, not NaN
isBoxed=: 32 = 3!:0		NB. true: any boxed y
isChar=: isLit *. isScalar	NB. true: any single char
isInf=: _ e. |			NB. true: contains _ or __
isFin=: isNum andnot isInf	NB. true: finite number
isGood=: isFin andnot NaN	NB. true: finite and determinate
isIno=: isInt *. isScalar	NB. true only if y is scalar integer
isInt=: 1 4   64     e.~ 3!:0	NB. true: any scalar | vector integer
isLit=: 2 2048 e.~ 3!:0		NB. true: '' | 'a' | 'ab'
isNul=: '' -: ]			NB. true: '' | i.0 | 0$0
isNum=: 1 4 8 64 128 e.~ 3!:0	NB. true: scalar | vector number
isNo=:  isNum *. isScalar	NB. true only if y is scalar number
isScalar=: [: {. 0 = [: $ $	NB. 13 : '{. 0=$$y'
isStr=: ([: -. '' -: ]) *. ] -: [: , ":	NB. (13 : '(-.isNul y)*.(y-:,":y)') f.

sub=:	4 : '({:x) (I.y={.x) } y'	NB. ' _'sub zuo
to=:    [ + [: i. [: >: -~	NB. eg: 3 to 5 <--> 3 4 5

az=: 'abcdefghijklmnopqrstuvwxyz'
AZ=: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
n9=: '0123456789'
SP=: ' '	NB. to avoid doubled-quotes in code strings
SL=: '/'	NB. mainly for tabula, c/f SP
UL=: '_'	NB. for locale-handling
CM=: ','	NB. comma
CO=: ':'	NB. common separator
SC=: ';'	NB. common separator
DT=: '.'	NB. file.ext separator
ST=: '*'	NB. star / asterisk
TB=: 9{a.	NB. the tab char, defined in stdlib as: TAB
MT=: ''		NB. to avoid repeated-quotes in code strings
QT=: ''''	NB. to avoid repeated-quotes in code strings
QQ=: '"'	NB. by analogy with QT

bents=:	1 |. '><' , ":	NB. layout tool for message string ->'<y>'
brack=:	1 |. '][' , ":	NB. layout tool for message string ->'[y]'
brace=:	1 |. '}{' , ":	NB. layout tool for message string ->'{y}'
paren=:	1 |. ')(' , ":	NB. layout tool for message string ->'(y)'

nb=: [: ([: }. [: ; ' ' ,&.> ]) ":&.>	NB. embed nums in string
ifdefined=: 0 <: [: 4!:0 <

bmp=: ],'.bmp' #~ [: -. '.' e. ]	NB. conditionally append ext
ijs=: ],'.ijs' #~ [: -. '.' e. ]	NB. conditionally append ext
jmf=: ],'.jmf' #~ [: -. '.' e. ]	NB. conditionally append ext
txt=: ],'.txt' #~ [: -. '.' e. ]	NB. conditionally append ext
htm=: ],'.htm' #~ [: -. '.' e. ]	NB. conditionally append ext

fprefix=: '*' -.~ ([: >: '/' i:~ ]) }. ] {.~ '.' i.~ ]

and=: *.
or=:  +.
not=: -.
neq=: ~:

all=: *./
any=: +./

max=: ($:/) : (>.)		NB. max z=:?10#100
min=: ($:/) : (<.)		NB. min z=:?10#100
NaN=: 1 e. [: ; 128!:5		NB. y has _. in it

log=: [: ": ;: ,. [: ".&.> ;:	NB. displays (global) vars

sees=: 3 : 0
for_lo. (coname''),(copath >coname'') do.
  if. (<y) e. nl__lo'' do. y,'_',~'_',>lo return. end.
end.
i.0
)

reset=: 13!:0	NB. turn on suspension: reset 1
si=:    13!:1	NB. display stack after suspended

SPX=: adverb define	NB. verb-generator for: SP0 SP1 SP2
(u#' '),":y	NB. needs monadic case to make the defn work
:
NB. u (noun) is number of spaces to separate {.y and {:y
try.
if. 0=$$x do. x=. ,x end.	NB. scalar-char->string
if. 0=$$y do. y=. ,y end.	NB. scalar-char->string
select. cas=. u,($$x=.":x),($$y=.":y)
 case. 0 1 1 do. x      ,y
 case. 1 1 1 do. x   ,SP,y
 case. 2 1 1 do. x,SP,SP,y
 case. 0 1 2 do. (((#y),#x){. ,:x) ,.y
 case. 1 1 2 do. (((#y),#x){. ,:x) ,.SP ,.y
 case. 2 1 2 do. (((#y),#x){. ,:x) ,.SP ,.SP ,.y
 case. 0 2 1 do. x           ,.(((#x),#y){. ,:y)
 case. 1 2 1 do. x      ,.SP ,.(((#x),#y){. ,:y)
 case. 2 2 1 do. x ,.SP ,.SP ,.(((#x),#y){. ,:y)
 case. 0 2 2 do. |: (|:x)         ,(|:y)
 case. 1 2 2 do. |: (|:x)     ,' ',(|:y)
 case. 2 2 2 do. |: (|:x) ,' ',' ',(|:y)
end.
catch.
 '??? SPX FAILED cas:',":cas	NB. default value returned
end.
)

SP0=: 0 SPX
SP1=: 1 SPX
SP2=: 2 SPX

cr=: [: 5!:6 boxopen		NB. paren repn of id: y
crr=: > , '=: ' , cr		NB. re-inputtable line

q=: 3 : 0
QQQ_z_=: y	NB. cr needs a global!
QQ_z=. cr 'QQQ_z_'
erase 'QQQ_z_'
QQ_z
)

	NB. quote and dquote are standard names in: strings.ijs
	NB. However older versions of strings.ijs do not contain them.
	NB. Include them here...
quote=: ''''&,@(,&'''')@(#~ >:@(=&''''))
dquote=: '"'&,@(,&'"')@(#~ >:@(=&'"'))

