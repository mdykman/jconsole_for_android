NB. formatting utilities

NB. center       width center text
NB. clipfmt      format data for clipboard
NB. clipunfmt    unformat data read from clipboard
NB. colhdr       column headers
NB. expandby     expand data with fit value
NB. expandn      expand data at every nth item
NB. flatten      flatten array to a character string
NB. fold         fold text to width
NB. hexdump      show text as hex and ascii characters
NB. nfmt         simple numeric formatter
NB. ruler        returns formatted ruler
NB. sqzint       squeeze list of positive integers into short form
NB. sqzrun       squeeze list of numbers into short form
NB. xfmt         format extended integers

cocurrent 'z'

NB. =========================================================
NB.*center v center text in given width
NB. form: width center text
center=: 4 : 0
rot=. +/ @ (*./\)"1 y = ' '
txt=. x {."1 rot |."0 1 y
rot=. - <. -: +/ @ (*./\.)"1 txt = ' '
rot |."0 1 txt
)

NB. =========================================================
NB.*clipfmt v format data for clipboard
NB. format array of rank 0 1 or 2 for clipboard.
NB. columns are separated by TAB, rows by CRLF.
clipfmt=: 3 : 0
if. 0 e. $y do. '' return. end.
t=. 3!:0 y
if. 2=t do.
  y=. ,y,"1 CRLF
elseif. 32<:t do.
  y=. ,&TAB @ ": &.>y
  y=. ;,&CRLF@}: &.><@;"1 y
elseif. 1 do.
  y=. ;,&CRLF @ ": &.><"1 y
  y=. '-' (I. y='_') } y
  y=. TAB (I. y=' ') } y
end.
y
)

NB. =========================================================
NB.*clipunfmt v unformat data read from clipboard
NB. returns boxed matrix from clipboard result,
NB. recognizing TAB and CRLF as separators.
NB. characters are not converted to numbers.
NB. e.g. try:  clipunfmt clipfmt i.5 6
clipunfmt=: 3 : 0
if. 0 e. $y do. 0 0 $ a: return. end.
(<;._2~ e.&(9 10{a.));.2 y,LF -. {:y=. toJ y
)

NB. =========================================================
NB.*colhdr v define column headers
NB. returns matrix of column headers.
NB.
NB. y = list with columns delimited by semicolons; and lines
NB.      in each column delimited by commas.
NB. x is wid or (wid;just), where:
NB.   wid  = column widths
NB.   just = a singleton or vector of:
NB.        0 = centre header, then right justify (default)
NB.        1 = center header in wid
NB.        2 = right justify
NB.        3 = left justify
NB.
NB. e.g.  hdr=. 'Number,of,employees;Total,salary;Monthly,net,payment'
NB.       (15 12 12;1) colhdr hdr
colhdr=: 4 : 0

('wid';'just')=. 2{.(boxopen x),<0
max=. >./wid=. (c=. >:+/y e.';')$wid

hdr=. ,/ ];._2@(,&',');._2 y,';'
rws=. #hdr
lns=. rws%c
hdr=. (rws,max){.hdr
len=. max-+/@(*./\)@|.@(e.&' ')"1 hdr
rot=. rws#0
just=. lns#c$just

if. 0 e. just do.
  ndx=. I. just=0
  cls=. >./"1(c,lns)$len
  j=. (lns#cls-wid)+0<.<.0.5*len-lns#cls
  rot=. (ndx{j) ndx } rot
end.

if. 1 e. just do.
  ndx=. I. just=1
  j=. 0<.<.0.5*len-lns#wid
  rot=. (ndx{j) ndx } rot
end.

if. 2 e. just do.
  ndx=. I. just=2
  j=. len-lns#wid
  rot=. (ndx{j) ndx } rot
end.

hdr=. rot |."0 1 hdr
hdr=. (lns,c*max)$,1 0 2|:(c,lns,max)$,hdr
(,wid >/ i.max)#"1 hdr
)

NB. =========================================================
NB.*expandby c expand data with a given value
NB. e.g.    0 1 0 0 1 expandby 99 [ 10 20
NB.      99 10 99 99 20
expandby=: 2 : 'm&# ^:_1 !. n'

NB. =========================================================
NB.*expandn v expand data at every nth item
NB. n expandn dat
NB. expand array at every nth cell.
NB. e.g. 'ABC DEF G' = 3 expandn 'ABCDEFG'
expandn=: 4 : 0
y #~ (#y)$>:(-x){.0j1
)

NB. =========================================================
NB.*flatten v flatten array to a character string
NB. flattens array to a character string with same display
flatten=: 3 : 0
dat=. ": y
select. # $ dat
case. 1 do.
case. 2 do.
  }. , LF ,. dat
case. do.
  dat=. 1 1}. _1 _1}. ": < dat
  }: (,|."1 [ 1,.-. *./\"1 |."1 dat=' ')#,dat,.LF
end.
)

NB. =========================================================
NB.*fold v fold text to width
NB. syntax:   {width} fold data
NB. data is character vector
NB. width defaults to screenwidth
fold=: 3 : 0
w=. {.wcsize''
w fold y
:
r=. i.0 0
x1=. >: x
txt=. y
while.
  r=. r, txt {.~ ndx=. x1 - >: x1 | ind=. ' ' i.~ |. x1{.txt
  #txt=. (ndx+ind<x1) }. txt
do.
end.
r
)

NB. =========================================================
NB.*hexdump v show text as hex and ascii characters
hexdump=: 3 : 0
val=. ,y
if. 0=#val do. i.0 0 return. end.
bar=. 9 { , 9!:6''
mav=. '.' ((i.32),128+i.128) } a.
hex=. '0123456789ABCDEF'
sep=. ' ';'-';' ';'  ';' ';'-';' ';'  '
sep=. 3 1 3 1 3 1 3 1 # sep
rws=. >. (#val) %16
wid=. >. 16^. rws
dat=. a. i. (rws*16) {. val
end=. 2+ (3*j) + 7<j=. 16 | <: #val
txt=. _16 [\ dat { mav
txt=. bar,.txt,.bar
dmp=. (16 16#: dat) { hex
dmp=. ;"1 (_16 [\ <"1 dmp) ,&.>"1 sep
dmp=. (}:dmp),end {. {: dmp
ind=. (((wid$16) #: i.rws){ hex),"1 '0  '
exp=. rws $ >: _8{. 0j1
exp # ind,.dmp,.txt
)

NB. =========================================================
NB.*nfmt v simple numeric formatter
NB. simple format of numeric vector or matrix in readable form.
NB. opt is optional, up to 3 elements:
NB.   0 = maximum decimal places, max 9  (4)
NB.   1 = minimum field width            (0)
NB.   2 = display width                  (screenwidth)
nfmt=: 3 : 0
'' nfmt y
:
('dp';'fw';'pw')=. x,(#x)}.4 0,{.wcsize''
x=. (<.0.5+j*y)%j=. 10^dp=. dp<.9
mat=. 2<:#shape=. $x
pw=. pw-6*mat
j=. 30>.fw
x=. ,x
d=. j+j.>./+/*(*/\1,dp#0.1) |/ x
x=. d ": ,.x
b=. (-j) {. (0>.fw-1)#1
x=. (b+.c+.1|.c=. ' '+./ .~:x) #"1 x
len=. <.pw%cls=. >:{:$x

if. mat do.
  'r c'=. shape
  j=. >.c%len
  exp=. (>:j.(j*len)-c) (<:c*>:i.r) } (#x)#1
  x=. exp#x
  b=. ' '={."1 ind=. ":,.i.r
  ind=. '[',"1 b|."0 1 ind,"1']'
  lab=. (>:j.j-1)#ind
end.

rws=. >.(#x)%len
r=. (rws,len*cls)$,((rws*len),cls){.x

if. mat do. r=. lab,.r end.
)

NB. =========================================================
NB.*ruler v formatted ruler
NB. returns a formatted ruler
NB. e.g.    ruler 75      horizontal
NB.       1 ruler 30      vertical
ruler=: 3 : 0
0 ruler y
:
j=. >. 0.2*len=. y
'a b c'=. 1 4 7 { , 9!:6''
if. x
do.
  r=. len # ,: b,'  ',b
  i=. 0,}. 5*i.j
  r=. b (<i;0 3) } r
  (2 ": ,.100|i) (<i;1 2) } r
else.
  r=. len #"1 ,. c,' ',a
  i=. }. 5*i.j
  r=. b (<0 2;0,i) } r
  r=. '0' (<1;0) } r
  if. len > 5 do.
    r=. (3 ": ,.i) (<1;i-/2 1 0) } r
  end.
end.
)

NB. =========================================================
NB.*sqzint v squeeze list of positive integers into short form
NB. Squeeze list of positive integers into short character list.
NB. If x = 1, sort y first.
NB. e.g.  sqzint 1 2 3 7 8 9 10  =  1-3,7-10
NB. see also <sqzrun>
sqzint=: 3 : 0
0 sqzint y
:
if. x = 1 do. n=. /:~ y else. n=. y end.
ndx=. ((1|.n) ~: >:n) # i.#n
a=. (0,}:>:ndx){n
b=. ndx{n
one=. (a=b)#i.#a
r=. (10":,.a),.'-',.10":,.b
ndx=. ((a=b)#i.#b) { i.$r
r=. (21":one{,.a) one } r
r=. ' ' -.~ }:,r,.','
)

NB. =========================================================
NB.*sqzrun v squeeze list of numbers into short form
NB. Squeeze list of numbers into short character list.
NB. e.g.  sqzrun 1.1 1.1 1.1 7 9 9 10.25 = 3#1.1,7,2#9,10.25
NB. See also <sqzint>.
sqzrun=: 3 : 0
y=. (b=. ((}.y) ~: }:y),1)#y
j=. j-_1,}: j=. I. b
c=. (":,.j),.'#'
c=. ' ' ((j=1)#i.#j) } c
' ' -.~ }.,',',.c,.":,.y
)

NB. =========================================================
NB.*xfmt v format extended integers
NB. form: [width] xfmt number
NB. groups in 3's up to 1e12, and 5's thereafter
xfmt=: 3 : 0
({.wcsize'') xfmt y
:
t=. ": x: y
c=. 1j1 1 1,(12<#t)#1 1
t=. (|.(#t)$c)#t
if. x>:<:#t do.
  }:t
else.
  (-<.x%6) ;\ <@(_6&{.) ;.2 t
end.
)
