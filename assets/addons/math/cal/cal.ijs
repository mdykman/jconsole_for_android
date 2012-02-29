NB. CAL scientific calculator engine

coclass 'cal'
require 'plot files strings jmf numeric'

TTn=: ,:'tn'		NB. fwd-ref fixup
items=: 3 : 'i. #TTn'	NB. fwd-ref fixup
sess1=: sess
sess2=: sess
sess_arrowgen=: empty
sess_cal=: sess
sess_dirty=: sess
sess_ct=: sess
sess_ttappend=: sess
sess_ttload=: sess
sess_ttsave=: sess
sess_undo=: empty
ARROWCH0=: ' ┌│└┌├└├b→'
ARROWCH1=: ' ┌│└┌├└├b>'
ARROWCH2=: ' +|+++++b>'
ARROWCH=: ARROWCH1
DIRTY=: 0		NB. dirty-bit: ttable needs saving
LAST=: ''		NB. last argline (OLD syntax)
LASTINSTR=: ''		NB. last argline (new syntax)
MAXINVERT=: 30		NB. limits inversion cycles
PAD=: 10		NB. default pad
PFMT=: 'line'		NB. default plot format
RETURNED=: ''		NB. noun returned by i/f call
TOLERANCE=: 1.0e_9	NB. default tolerance for notional equality
TRACE=: 0		NB. controls: sess
TRACI=: 0		NB. controls: sesi (echoes instruction string)
VALUE=: 0		NB. retd noun >>> USED BY OLD I/F ONLY

NB. ========== MORE NOUNS ==========

ABTIME=: '2011-10-20  10:49:29'

ABOUT=: 0 : 0
CAL calculation-engine, written by Ian A Clark.
Serves all versions of TABULA scientific calculator.
User interface communicates with this engine via
a single interface verb: tabengine_cal_
The repertoire of CAL instructions are shown by:
   tabengine_cal_ 'QUER'
)

ARGEXP=: 0 : 0
validbool  b=. _".yy
validnum   n=. _".yy
validitem  r=. {. _".yy
validnum   v=. 1{ _".yy
validnum   vr=. r{vquan
validrr    rr=. _".yy
validitems rrr=. _".yy
validrv    rv=. _".yy
validlit   yy
validlit   zz=. dropwd yy
)

CAL=: 0 : 0
Init void start''                  \(re-)start the engine
Repe void dummy''                  \repeat last action
Redo void undo 0                   \redo
Undo void undo 1                   \undo
ABOU void ABOUT                    \About the engine
ABTI void ABTIME                   \last-updated timestamp
CAPT void CAPT                     \window title -cf TITL
CTAB void ct''                     \ttable display: wide chars
CTBU void utf8 x2f ct''            \ttable display: utf-8
DEPE r    r{TD                     \dependents of item
DIRT void dirty''                  \flag: unsaved changes
FMLA r    dtb r{TTf                \formula of item
INFO void TTINFO                   \info about ttable
ITMS void }.items''                \list of non-0 item#s
NAME r    dtb r{TTn                \name of item
PLOT rzz  r plotz~ zz              \gen plot data with x-axis
QCMD yy   CCc e.~ <yy              \query valid command
QUER void querycal''               \query interface defn
TITF void dtb 0{TTf                \window title -from TTf
TITL void CAPT                     \window title -from CAPT
TITU void UNDEF_CAPT               \window title -undefined
TFIL void file                     \ttable file name
TFLU void UNDEF                    \ttable file name -undefined
TNAM void shortf file              \ttable file name-only
TNMX void tbx shortf file          \ttable file name.ext
UCOM r    docompatlist r           \item compat units
UNIS r    r{UNITS                  \units of item -SI
UNIT r    r{UNITN                  \units of item -nominal
VALU r    getvalue r               \value of item -corrected
VERS void VERSION                  \version of engine
absl r    r fnline~ 'abs'          \copy abs value of item
absv r    r setvalue~ |vr          \absolute value of r
addc rv   r fnline~ '*1+',":v%100  \copy item adding v%
addl rv   r fnline~ '+',":v        \copy item adding v
addp rv   r setvalue~ vr*1+v%100   \inc item by v%
addv rv   r setvalue~ vr+v         \inc item by v
appe yy   ttappend yy              \append named ttable
atto r    'a' scaleunits r         \atto- item
cent r    'c' scaleunits r         \centi- item
comp rrr  compare rrr              \checks items compatible
cons yy   ttauc yy                 \new const line
copy r    copyline r               \copy item exactly
cpyf rzz  r fnline~ zz             \copy line under fn
cbtl r    r fnline~ 'cubert'       \copy item cube-rooted
cbtv r    r setvalue~ cubert vr    \cube-root of r
cubl r    r fnline~ 'cube'         \copy item cubed
cubv r    r setvalue~ cube vr      \cubed value of r
cvsi r    siunits r                \convert to SI units
dbll r    r fnline~ 'dbl'          \copy item doubled
dblv r    r setvalue~ +:vr         \double value of r
deca r    'da' scaleunits r        \deca- item c/f deka
deci r    'd' scaleunits r         \deci- item
deka r    'da' scaleunits r        \deka- item c/f deca
dele rrr  ttdelete rrr             \delete items
divc rv   r fnline~ '%~',~":v%100  \copy item by v%
divi rr   '/'combine rr            \new quot of 2 items
divl rv   r fnline~ '%~',~":v      \copy item by v
divp rv   r setvalue~ vr%v%100     \divide item by v%
divv rv   r setvalue~ vr%v         \divide item by v
dupl r    duplicate r              \duplicate item
elog void enlog 0                  \restart log
equl r    r fnline~ '='            \copy item
exaa r    'E' scaleunits r         \exa- item
exch void uprates''                \update exchange rates
expl r    r fnline~ '^'            \copy exp(item)
expv r    r setvalue~ ^vr          \exponentiate item value
etwl r    r fnline~ '2^'           \copy 2^(item)
etwv r    r setvalue~ 2^vr         \2^(item value)
extl r    r fnline~ '10^'          \copy 10^(item)
extv r    r setvalue~ 10^vr        \10^(item value)
femt r    'f' scaleunits r         \femto- item
fmla rzz  r setfmla~ zz            \set formula of item
func yy   ttauf yy                 \new funct line
giga r    'G' scaleunits r         \giga- units
hect r    'h' scaleunits r         \hecto- item
hide rrr  hide rrr                 \hide items
hlvl r    r fnline~ 'hlv'          \copy item halved
hlvv r    r setvalue~ -:vr         \halve value of r
hold r    tranhold r               \toggle transient hold
holm r    mandhold r               \toggle mandatory hold
info yy   TTINFO=: yy              \set info about ttable
intl r    r fnline~ 'int'          \copy item integer value
intv r    r setvalue~ int vr       \integer value of r
invl r    r fnline~ '%'            \copy invt value of item
invv r    r setvalue~ %vr          \invert value of r
kilo r    'k' scaleunits r         \kilo- item
lnnl r    r fnline~ '^.'           \copy ln(item)
lnnv r    r setvalue~ ln vr        \natural log of r
ltnl r    r fnline~ 'log10'        \copy log10(item)
ltwl r    r fnline~ 'log2'         \copy log2(item)
ltnv r    r setvalue~ log10 vr     \log base-10 of r
ltwv r    r setvalue~ log2 vr      \log base-2 of r
load yy   ttload yy                \load named ttable
mega r    'M' scaleunits r         \mega- item
merg rr   merge rr                 \merge 2 lines
micr r    'mu' scaleunits r        \micro- item
mill r    'm' scaleunits r         \milli- item
minu rr   '-'combine rr            \new diff of 2 items
movd r    1 ttsort bubb r          \move item down
movu r    1 ttsort bubb -r         \move item up
mulc rv   r fnline~ '*',~":v%100   \copy item times v%
mull rv   r fnline~ '*',~":v       \copy item times v
mulp rv   r setvalue~ vr*v%100     \multiply item by v%
mult rrr  '*'combine rrr           \new product of items
mulv rv   r setvalue~ vr*v         \multiply item by v
name rzz  r relabel zz             \set name of item
nano r    'n' scaleunits r         \nano- item
negl r    r fnline~ '-'            \copy item negated
negv r    r setvalue~ -vr          \negate value of r
newt void ttnew''                  \new empty ttable
newu yy   ttadl 'unit';yy;1        \new item with units
noop void noop''                   \no-op
onen r    r setvalue~ _1           \set item to -1
onep r    r setvalue~ 1            \set item to 1
open yy   ttload yy                \load named ttable
orph r    orphan r                 \orphan item
peta r    'P' scaleunits r         \peta- item
pico r    'p' scaleunits r         \pico- item
pidl r    r fnline~ 'PI%~'         \copy item by PI
pidv r    r setvalue~ vr%PI        \item by PI
piml r    r fnline~ 'PI*'          \copy item times PI
pimv r    r setvalue~ vr*PI        \item times PI
plot rzz  r plotx~ zz              \setup plot with x-axis
plus rrr  '+'combine rrr           \new sum of items
powe rr   '^'combine rr            \new power of 2 items
prec n    setsig n                 \set places of decimals
ptdl r    r fnline~ 'PI2%~'        \copy item by 2*PI
ptdv r    r setvalue~ vr%PI2       \item divided-by 2*PI
ptml r    r fnline~ 'PI2*'         \copy item times 2*PI
ptmv r    r setvalue~ vr*PI2       \item times 2*PI
reca void empty CH=: recal 0       \recalculate
rplt rrr  replot rrr               \re-plot with items
rtol rv   r fnline~ '^~',~":v      \copy item ^v
rtov rv   r setvalue~ vr^v         \item ^v
save yy   ttsave yy                \save ttable as named
sort rrr  1 ttsort rrr             \sort by perm
sqrl r    r fnline~ 'sqr'          \copy item squared
sqrv r    r setvalue~ sqr vr       \squared value of r
sqtl r    r fnline~ 'sqrt'         \copy item square-rooted
sqtv r    r setvalue~ sqrt vr      \square-root of r
stpd r    _1 scaleunits r          \step down scaled units
stpu r    1 scaleunits r           \step up scaled units
subc rv   r fnline~ '*1-',":v%100  \copy item - v%
subl rv   r fnline~ '-~',~":v      \copy item - v
subp rv   r setvalue~ vr*1-v%100   \dec item by v%
subv rv   r setvalue~ vr-v         \dec item by v
tera r    'T' scaleunits r         \tera- item
titl yy   settitle yy              \set ttable caption
tnam yy   file=: yy                \set ttable file name
trac n    trace n                  \toggle TRACE
trai n    traci n                  \toggle TRACI
t1dl r    r fnline~ '10%~'         \copy item by 10
t1ml r    r fnline~ '10*'          \copy item times 10
t2dl r    r fnline~ '100%~'        \copy item by 100
t2ml r    r fnline~ '100*'         \copy item times 100
t3dl r    r fnline~ '1000%~'       \copy item by 1000
t3ml r    r fnline~ '1000*'        \copy item times 1000
unhi void hide 0                   \unhide all items
unit rzz  r changeunits~ zz        \set units of item
unsc r    '' scaleunits r          \unscaled units
valu rv   r setvalue~ v            \set value of item
yoct r    'y' scaleunits r         \yocto- item
yott r    'Y' scaleunits r         \yotta- item
zept r    'z' scaleunits r         \zepto- item
zero r    r setvalue~ 0            \set item to 0
zett r    'Z' scaleunits r         \zetta- item
)

CO=: ':'
CSEP=: '\'
DT=: '.'
SC=: ';'
SH=: '!'
SNAPSP=: 'vquan vsiqn vqua0 vsiq0 vfact vhidd vhold vmodl CH TD TTn TTu TTs TTf UNITN UNITS CAPT'
SP=: ' '
UNDEF=: 'undefined'
UNDEF_CAPT=: '<undefined caption>'

NB. ========== ADVERBS ==========

NB. ========== CONJUNCTIONS ==========

NB. ========== VERBS ==========

Cols=: 4 : 0
	NB. get multiple col-pairs
z=. 0$0
for_i. +:i.-:$y do. z=. z,to/(0 1+i){y end.
z{"1 x
)

acomb=: 3 : 0
NB. Combine lines sharing arrows to same items (=dependents)
y=. 1 acvt y	NB. convert to prime-based cell-codes
NB. smoutput 'acomb:' ; y
	NB. Detect columns with arrowheads (=dependent items)
s=. */y
z=. i.0 0
for_i. I. 0= 7 | s do.		NB. for each arrowhead i
  r=. I. (i&{"1) 0=7 | y	NB. row indexes sharing arrowhead
  t=. r{y			NB. rows of y to be combined
  c=. ;(*/@~.@q:)each */t	NB. the combined row
  z=. z,c			NB. accumulate it
end.
0 acvt z
)

acvt=: 4 : 0
	NB. Convert from arrowch cell-coding into (x=1
	NB. primes-based coding for acomb and back again(x=0)
	NB. y cells correspond to:
	NB.  0=space 1=top-corner 2-mid-line 3=bottom-arrow
	NB.  4=top-arrow  5=tee 6=bottom-corner 7=mid-arrow
	NB.  9=arrowpt
if. x do.
	NB.  sp tc ml ba ta te bc ma
	t0=. 0  1  2  3  4  5  6  7
	t1=.-1  3  2  35 21 15 5  105
	for_i. i.#t0 do. y=. y+ (y=i{t0)*i{t1-t0 end.
else.
	NB.  sp tc ml ba ta te bc ma te te
	t1=. 1  3  2  35 21 15 5  105 6 10
	t0=.-0  1  2  3  4  5  6  7   5 5
	for_i. i.#t1 do. y=. y+ (y=i{t1)*i{t0-t1 end.
end.
x: |y	NB. extended int to avoid overflow
)

adj=: adj_uu_

aheads=: 3 : 0
p=. 9		NB. arrowpt
z=. i.0 0 [ r=. }:$y
for_i. i.r do.
  iy=. i{y
  z=. (z , ((iy e. 3 4 7)*p)) , iy	NB. ,7 for mid-arrow bug
end.
)

ancestors=: 3 : '(>:I.}.y{(clos dpmx TD))-.hasfs 0'
andnot=: [ and [: not ]

appextn=: 3 : 0
'*' appextn y
:
	NB. append extn with units: x to bare formula: y
y_cal_=: y
sep=. ':'	NB. the one we are going to use
z=. ~. (;:y) -. (;:y)-. ,each az,AZ
z=. }: ; z ,each <'(',x,'),'
y,SP,sep,SP,z
)

ar=: 3 : 'SP ,.~ }.arrowch arrowgen SP'

archive=: 3 : 0
	NB. archive ttable: y (=bare name)
require'files'	NB. for: fcopynews
	NB. xtx appends correct .ext if none given
xtx=. tbx	NB. the correct extension for a ttable
sce=. TPATH_TTABLES, xtx y
	NB. Don't archive empty file, return _2 instead
if. 0=#z=.freads sce do. _2 return. end.
	NB. Don't archive absent file, return _3 instead
if. _1=z do. _3 return. end.
1!:5 <fld=. TPATH_ARCHIVE, 's',~ 6!:0 'YYYY-MM-DD-hhhmmmss'
tgt=. fld , SEP , xtx y
tgt fcopynews sce
)

arrowch=: 3 : 0
sess=. empty
NB. use as follows: arrowch arrowgen''
NB. y is arrowgen'' output
zz=. i.0 0
if. 0=#y do. i.0 0 return. end.
for_i. i.#y do.
'c b e'=. i{y [ rev=. 0
if. b>e do. 'e b rev'=. b ; e ; 1 end.
NB. --b e are top/bot corners, not source/target
z=. (#TTn) $ 0
z=. 2 (b to e) }z
if. rev do.	NB. identify upward arrow
  z=. 4 b }z
  z=. 6 e }z
else.		NB. it's a downward arrow
	NB.  1=top-corner 2-mid-line 3=bottom-arrow
	NB.  4=top-arrow  5=junction 6=bottom-corner
  z=. 1 b }z
  z=. 3 e }z
end.
zz=. zz,z
end.	NB. i
ZZ=: zz
	NB. Globalize these for debugging...
zz2=. |: |. aheads pack acomb zz
zz3=. zz2 <. #uarr=. uucp ARROWCH  NB. limit to #uarr
sess 'arrowch: codes used:' ; ~. ,zz2
zz3 { uarr,'?'
)

arrowgen=: 3 : 0
	NB. array of "arrow" args
a=. empty''
  c=. 0				NB. 1st arrow col to use
  for_i. }.items'' do.
    if. 0< +/r=. i{TD do.	NB. row i: any dependencies?
      for_j. r-.0 do.
        sess_arrowgen 'arrow ',(": c,j,i)
        a=. a,(c,j,i)
      end.
      c=. c+1			NB. next col
    end.			NB. inputs
  end.				NB. items
  a				NB. arrow args
)

baditem=: 3 : 0
	NB. 1 if y is bad item, and sets global: BADITEM
if. y e. }.items'' do.
  0 [ BADITEM=: ''
else.
  1 [ BADITEM=: nb 'not a valid item:' ; y
end.
)

baditems=: 3 : 0
	NB. 1 if y has bad items, and sets global: BADITEMS
	NB. c/f baditem
if. all z=. y e. }.items'' do.
  0 [ BADITEMS=: ''
else.
  1 [ BADITEMS=: nb 'not valid item(s):' ; (-.z)#y
end.
)

bcalc=: 3 : 0
	NB. break-back calculation, c/f fcalc
	NB. pivot=. y
	NB. returns full set of values for assigning to: vsiqn
	NB. Does NOT alter vsiqn itself
	NB. Assumes (c/f fcalc) that y{vsiqn has new given value already.
deltaz=. y{(vsiqn-vsiq0)	NB. the resulting change in y's value
deltaz beval y			NB. compute plausible inputs to y
	NB. beval returns an update for vsiqn (with altered ancestors y)
	NB. which may / may NOT recalc the existing y{z.
	NB. A further fcalc may be needed to enforce vsiqn integrity
	NB. but this may result in y{vsiqn changing (slightly)
)

beval=: 4 : 0
	NB. saddle to call: inversion
sess=. empty
	NB. y==pivot node
	NB. x==CHANGE in value of pivot node
	NB. returns updated values for vsiqn.
	NB. DOES NOT ALTER vsiqn
	NB. DOES get initial values from vsiqn
a=. ancestors y
r1=. r=. a{vsiqn   			NB. initial values of ancestors
sess 'beval: y=',(":y),' x=',(":x),' a=',(":a)
if. (0~:x)*.(hasf y) do.
  deltaz=. x  NB. the CHANGE in value of node y
NB.   amodel=: a{(model * -.holds'')	NB. global, for use by: inversion
  amodel=: a{(vmodl * -.holds'')	NB. global, for use by: inversion
  fwd=: ffwd&y				NB. fwd-transfer fn used by: inversion
    NB. (z+deltaz)<--fwd(r+deltar)
    NB. fn: inversion: r1(=r+deltar)<--fwd^_1(z+deltaz)
    NB. vmodl (global) is predetermined model to use (normally 1)
    NB. -the actual model used is: amodel, having 0 forced for each item "held".
    NB. >>>>> NEED TO CREATE TEMP FN: fwd (-as seq of exe-fns working on r only)
  r1=. r inversion deltaz		NB. updated values for ancestors
end.
sess 'beval: a=',(":a),' r=',(":r),' r1=',(":r1)
r1 a }vsiqn
  NB. Does NOT replace the pivot value (y{vsiqn) itself.
  NB. See how the calling fn (bcalc?) handles (y{vsiqn) and deltaz.
)

bubb=: 3 : 0
	NB. perm to move item y up or down(y<0)
z=. i.t=. #TTn
if. y e. (}.}:z),2}.-z do.
z+(-|y+y<0)|. t{.1 _1
end.
)

ceiling=: >.

changeunits=: 4 : 0
	NB. change the units of item: y to units: (str)x
if. -.y e. }.items'' do. ('bad item:' SP1 y) return. end.
'un0 cyc fac0'=. convert z=. >y{UNITN
'un1 cyc fac1'=. convert x0=. 0 ucode x
	NB. Accept incompats UNLESS y involved in a formula
if. (-. un0-:un1) *. ((hasdep y)+.(hasf y)) do.
  'incompatible units:' SP1 z SP1 'and:' SP1 x
  return.
else.
NB. 	smoutput 'changeunits:'
NB. 	smoutput z ,: ".each z=. ;: 'x0 un0 un1 fac0 fac1'
  UNITS=: (<un1) y}UNITS	NB. needed if (-. un0-:un1)
  UNITN=: (<x0) y}UNITN
  vfact=: fac1 y}vfact
  vsiq0=: vsiqn
  vqua0=: vquan
  vquan=: vsiqn % vfact
  TTs=: ('ts',>}.UNITS) ,. SP
  TTu=: ('tu',>}.UNITN) ,. SP
  'item' SP1 y SP2 '-- units changed from:' SP1 z SP1 'to:' SP1 x0
end.
)

clos=: dp2^:_

cmake=: 3 : 0
	NB. make the CAL-arrays
'CCc CCa CCx CCd'=: 4 # <''
for_li. f2b dtlf CAL do. lin=. >li
  CCc=: CCc,<4{.lin
  CCa=: CCa,<dtb 4{.5}.lin
  'x d'=. CSEP cut 10}.lin
  CCx=: CCx,<dtb x
  CCd=: CCd,<dtb d
end.
i.0 0
)

cnn=: 3 : 0
	NB. output re-inputtable num-vec: y
z=. y,'=: numvec 0 : 0'
for_n. ".y do.
  z=. z,LF,5!:6<,'n'
end.
z,LF,')'
)

cnvj=: cnvj_uu_
cols=: [: }. [ {"1~ [: to/ ]

combine=: 4 : 0
	NB. combine items: y under sign: x
	NB. Allocate lines: y the varname (=vn): a b c... in turn
y=. ,y			NB. in case there's only 1 item
fmla=. fixfmla ,|: x, ,:(#y){.az
vn=. ''	NB. the fmla "ext", describing the participating vars
for_i. i.#y do.
  d=. i{y		NB. the i'th item#
  vn=.vn, ',', (i{az), paren unit=.>d{UNITN	NB. the NOMINAL units of item d
  NB. choose appropriate units (-->unitf) for the result of the fmla...
  select. x
  fcase. '+' do.
  case.  '-' do.	NB. check units are compatible if "+" or '-'
    unitf=. unit	NB. use fmla unit as final unit
    if. i=0 do.		NB. at first pass, identify the prime unit: u0...
      d0=. d		NB. its item#
      u0=. unit		NB. ...and all subsequent: unit -must be compatible with it
    else.
      if. u0 incompat unit do.
      'incompatible units:' SP1 d0 SP0 (brack u0) SP1 d SP0 (brack unit) SP1 '-- no action'
      return.
      end.
    end.
  case. '*' do.
    if. 1=$y do.	unitf=. unit		NB. and that will be all.
    elseif. i=0 do.	unitf=. unit		NB. start the sequence...
    elseif. 1 do.	unitf=. unitf,SP,unit	NB. ...continue the sequence
    end.
  case. '/' do.
    if. 1=$y do.	unitf=. '' udiv unit	NB. and that will be all.
    elseif. i=0 do.	unitf=. unit		NB. start the sequence...
    elseif. 1 do.	unitf=. unitf udiv unit	NB. ...continue the sequence (usu. just 2)
    end.
  case. x do.		NB. catch-all to cover x='^' and any residual oddity
    if. i=0 do. unitf=. unit end.	NB. hazard a guess that just 1st unit will suffice
  end.	NB. (select.)
end.	NB. (for.)
if. 1<$y do. fmla=. }.fmla end.		NB. eg to drop leading '+' from: +a+b+c
fmla=. fmla, ': ', }.vn			NB. attach the fmla "ext".
  NB. Now compose a descriptive label...
if. 1=$y do. label=. x,brace y
else. label=. (SP;x)stringreplace }. ;SP,each brace each y
end.
ttafl label ; unitf ; (":y); fmla
'items:' SP1 y SP1 'combined under' SP1 brack x
)

compare=: 3 : 0
	NB. compare items: y
	NB. c/f: combine
VALUE=: 0		NB. init to: incompatible
y=. ,y			NB. in case there's only 1 item
for_d. y do.
  unit=. >d{UNITN
  if. d_index=0 do.	NB. at first pass, identify the prime unit: u0...
    d0=. d		NB. its item#
    u0=. unit		NB. ...and all subsequent: unit -must be compatible with it
  else.
    if. u0 incompat unit do.
    'incompatible units:' SP1 d0 SP0 (brack u0) SP1 d SP0 (brack unit)
    return.
    end.
  end.
end.
empty VALUE=: 1
)

compat=: compatible_uu_

compat_i=: 4 : 0
	NB. compatible? -item ids: x, y
(>x{UNITS) compat (>y{UNITS)
)

compatlist=: compatlist_uu_
convert=: convert_uu_

copyline=: 3 : 0
	NB. copy item: y
	NB. a very simple version of: combine
label=. '=',(brace y)			NB. e.g. '={2}'
unitn=. >y{UNITN
units=. >y{UNITS
	NB. fmla expects (a) in SI not nominal units
fmla=. 'a: a',paren units=.>y{UNITS	NB. e.g. 'a: a(m)'
ttafl label ; unitn ; (,":y); fmla
'item copied:' SP1 y
)

ct=: 3 : 0
	NB. 1 e. y -include SI units column
	NB. 3 e. y -include box-drawn arrows
	NB. 4 e. y -include "line 0" col-headers
if. 0=#y do. y=. ,3 end.	NB. the default display
	NB. return trivial display if no items...
if. 1=#items'' do. ,:CAPT return. end.
	NB. Use sP0 etc to stop reversion to utf-8
z=. ": ,. items''
z=. z ,.(SH fl vhold)	NB. marks "holds"
z=. z ,.('@'fl CH)	NB. marks altered values
z=. z sP1 UNITN nfx vquan
z=. z sP1(>ucods each UNITN)	NB. nominal units
if. 1 e. y do.
  z=. z sP1('j'nfx vsiqn) sP1(>ucods each UNITS)	NB. SI-units figures
  z=. z sP1 '*'		NB. to "symbolise" multiplication (by vfact)
  z=. z sP0('j'nfx vfact)
end.
z=. z sP2 TTn
if. (3 e. y) do.
  a=. arrowch arrowgen''
  if. a -: i.0 0 do.
    sess_ct 'ct: arrows n/a'
  else.
    try. z=. z sP1~ a
    catch. sess_ct 'ct: arrowch fail $z:' ; ($z) ; '$a:' ; ($a)
    end.
  end.
end.
if.-. 4 e. y do. z=. }.z end.	NB. drop "line 0"
z=. CAPT,z	NB. ALWAYS INCLUDED NOW <<<<<<<<
if. mt z do. z=. 1 1$SP end.	NB. to force panel-clear
z=. (-.vhidd) # z
)

cubert=: 3&%:

dadd=: 4 : 0
	NB. displace new y==TD by: x
z=. y>0
y+z*x
)

dbl=: +:
dec=: <:
descendants=: 3 : '(>:I.}.y{|:(clos dpmx TD))'

dirty=: 3 : 0
'' dirty y
:
	NB. Exclusively reads+sets: DIRTY
	NB. if 0<#x then x shows where set/reset
if. 0<#x do. sess_dirty nb 'dirty' ; y ; ' NB. called by:' ; x end.
select. y
case. '' do.	DIRTY return.
case. 0 do.	DIRTY=: 0
case. 1 do.	DIRTY=: 1
end.
i.0 0
)

disappears=: 4 : 0
	NB. =1 if numeric value y is "tolerably close" to 0
scale=. x	NB. floor-setter
y=. {. y % 1>.scale
TOLERANCE>:|y
)

dix=: 3 : 0
	NB. outputs dependency mx with ids in row/col 0
NB. this is a devt tool for display, not essential at runtime
NB. used: dix dpmx TD
z=. }.i.#y
(0,z),. z, }. }."1 y
)

docompatlist=: 3 : 0
	NB. build list of compatible units to item#: y
z=. >y{UNITN
VALUE=: compatlist_uu_ z
)

dp2=: ] +. +./ .*.~

dpmx=: 3 : 0
	NB. the dependency mx from y==TD
	NB. used: clos dmpx TD
z=. ,: 0*0,i=. }.i.#y	NB. vec of 0s for row 0
for_n. i do.  		NB. list: i is 1 2 3 ...
  z=. z, 0, i e. n{y	NB. build z row-by-row
end.
)

dropwd=: ] }.~ [: >: ' ' i.~ ]
dumbs=: }.@I.@(-.@hasfb)
dummy=: empty

duplicate=: 3 : 0
	NB. exactly duplicate item y
if. y e. }.items'' do.
  0 ttsort (items''),y		NB. x=0 does a blind-sort
  'item duplicated:' SP1 y
else.
  'cannot duplicate item:' SP1 y
end.
)

enlog=: 3 : 0
	NB. add y to log
fi=. <TPATH_CAL, 'cal.log'
if. y-:0 do.	NB. initialise log
  z=.(": 6!:0''),' start cal.log',LF
  z 1!:2 fi
else.
  (y,LF) 1!:3 fi
end.
)

exrate=: exrate_exch_
ext=: 4 : 'if. -. DT e. x do. x,DT,y else. x end.'

extunits=: 3 : 0
	NB. boxed units of item#: y
z=.i.0
'fmla extn'=. fmla_extn y
vc=. ','cut extn		NB. boxed list of varspecs
for_i. i.$vc do.		NB. for each varspec in turn
  v=. >i{vc			NB. the i-th varspec
  'n unit'=. '('cut detb v-.')'	NB. (n;unit) from: 'n(unit)'
  z=. z,<unit
end.
)

fcalc=: 3 : 0
	NB. forward calculation
	NB. pivot=. y
	NB. returns recalced values for assigning to: vsiqn
sess=. empty
z=. vsiqn  NB. >>>>> meant to supply values for items not in: xseq
if. 0<$xseq y do.
  sess 'fcalc: y=',(":y),' xseq=',(":xseq y)
  for_i. xseq y do.
    z=.(z feval i)i}z
  end.
end.
)

feval=: 4 : 0
	NB. return updated value of item: y
 sess=. empty
 NB. x is up-to-date state of vsiqn, don't use vsiqn directly
 z=. y{x	NB. the existing value of item: y
 fn=.'exe',":y	NB. name of the exe<n> verb (if present)
 if. hasf y do.
   if. -.ifdefined fn do. genexe y end.
   NB. >>> MAKE exe LOCAL WHEN CODE IS STABLE
   ". 'exe=:',fn  NB. now (global)exe is: exe<y>
   NB. In case exe contains a bad fmla...
   try. z=. exe x  [z0=. z
   catch. z=. INVALID
   end.
   sess (brack y),(":z0),TAB,(":z),' from ',fn,'(',(":x),')'
 else.	NB. just return existing value
   sess (brack y),(":z),' unchanged'
 end.
 z	NB. return value of item y whether updated or not
)

fexp=: 3 : 0
	NB. verb-ready expression from formula of item# y
	NB. This version of fexp applies to formulas
	NB. separated by ':', valid in SI units.
select. fmlatyp y
case. 0 do. fexp_virtual y return.
case. 1 do. fexp_siunits y return.
case. 2 do. fexp_nominal y return.
end.
NB. else return a notionally bad formula:
'INVALID'
)

fexp1=: 3 : 0
	NB. verb-ready expression from formula of item# y
	NB. This version of fexp applies to formulas
	NB. separated by ':', valid in SI units.
select. fmlatyp y
case. 0 do. fexp_virtual y return.
case. 2 do. fexp_nominal y return.
end.
NB. else assume (fmlatyp y) is 1 (':'-separated)
sess=. empty
dep=. 0-.~y{TD
'fmla extn'=. fmla_extn y
	NB. ASSUME dependent units given explicitly ...
vc=. ','cut extn		NB. boxed spec for each dependent var
tmp=. '  [<n>=. <fac> * <idp>{y'	NB. input data phrase template
for_i. i.$dep do.			NB. scan dep units
  v=. >i{vc				NB. the i-th spec
  'n unit'=. '('cut detb v-.')'		NB. (n;unit) from: 'n(unit)'
  idp=. ": i{dep			NB. the i-th dependency (=id)
  fac=. % >{: convert unit		NB. conversion factor
	sess nb 'fac=' ; fac ; 'unit=' ; unit
  fmla=. fmla , tmp rplc '<n>';n; '<idp>';idp; '<fac>';":fac
end.
fmla
)

fexp_nominal=: 3 : 0
	NB. verb-ready expression from formula of item# y
	NB. This version of fexp applies to formulas
	NB. separated by ';', valid only in nominal units.
	NB. Serves: fexp
sess=. empty
assert 2=fmlatyp y	NB. else should not be called
dep=. 0-.~y{TD		NB. dependencies
'fmla extn'=. fmla_extn y
Unit=. rslt y		NB. result units
Fac=. >{: convert Unit	NB. Back-conv-factor
	NB. ASSUME dependent units given explicitly ...
vc=. ','cut extn		NB. boxed spec for each dependent var
tmp=. ' [<n>=. <fac> * <idp>{y'	NB. input data phrase template
z=. nb Fac ; ST ; paren fmla	NB. start building expr
for_i. i.$dep do.		NB. scan dependencies
  v=. >i{vc			NB. the i-th spec
  'n unit'=. '('cut detb v-.')'	NB. (n;unit) from: 'n(unit)'
  idp=. ": i{dep		NB. the i-th dependency (=id)
  fac=. % >{: convert unit	NB. var conv-factor
	sess nb 'fac=' ; fac ; 'unit=' ; unit
  z=. z , tmp rplc '<n>';n; '<idp>';idp; '<fac>';":fac
end.
)

fexp_siunits=: 3 : 0
	NB. verb-ready expression from formula of item# y
	NB. This version of fexp applies to formulas
	NB. separated by ':', valid in SI units.
	NB. Serves: fexp
assert 1=fmlatyp y	NB. else should not be called
sess=. empty
dep=. 0-.~y{TD
'fmla extn'=. fmla_extn y
	NB. ASSUME dependent units given explicitly ...
vc=. ','cut extn		NB. boxed spec for each dependent var
tmp=. ' [<n>=. <idp>{y'		NB. input data phrase template
z=. fmla			NB. start building expr
for_i. i.$dep do.		NB. scan dep units
  v=. >i{vc			NB. the i-th spec
  'n unit'=. '('cut detb v-.')'	NB. (n;unit) from: 'n(unit)'
  idp=. ": i{dep		NB. the i-th dependency (=id)
  z=. z , tmp rplc '<n>'; n; '<idp>'; idp
end.
)

fexp_virtual=: 3 : 0
	NB. verb-ready expression from formula of item# y
	NB. This version of fexp applies to formulas
	NB. with no extn, assumed valid in SI units.
	NB. Serves: fexp
sess=. empty
dep=. 0-.~y{TD
'fmla extn'=. fmla_extn y
	NB. Use dep alone to fetch reqd values: a, b,...
tmp=. ' [<n>=. <idp>{y'	NB. input data phrase template
z=. fmla		NB. start building expr
for_i. i.$dep do.	NB. scan dep units
	NB. MUST ASSUME a, b,... have been used in turn
  n=. i{az		NB. 'a' for 1st dependency, etc
  idp=. ": i{dep	NB. the i-th dependency (=id)
  z=. z , tmp rplc '<n>';n; '<idp>';idp
end.
)

ffwd=: 4 : 0
	NB. fwd saddle --> fwd=. ffwd&y
	NB. y==pivot node
	NB. x==ancestors' trial values
a=. ancestors y  NB. ancestors' line numbers
vsiqn=: x a}restore=.vsiqn  NB. temp alter the GLOBAL vsiqn
z=. y{fcalc y  NB. return (updated) result
vsiqn=: restore
z
)

fixfmla=: ('/';'%') rplc~ ]

fixttf=: 3 : 0
	NB. reverse fmla if SWAPPED
NB. y is formula table: TTf
if. -.SWAPPED do. y return. end.
z=. ,:'tf'
for_i. }.items'' do.
  'vn fmla'=. detb each 2{.':'cut i{y
  sep=. (-.mt fmla)#' :'
  z=.z,fmla,sep,vn
end.
)

fixtthdr=: 3 : '(-#TTn){.y'
fl=: 4 : ',.y{ _2{.x'
flags=: ] + 0 * items
floor=: <.

fmla_extn=: 3 : 0
	NB. (fmla ; extn) of full formula string: y
	NB. y can also be item#
	NB. fmla is "fixed": / --> %
	NB. (SWAPPED formulas are corrected on loading)
if. isNum y do. z=. formula y else. z=.y end.
if. 0=#z do. ('';'') return. end.
z=. '[' taketo z	NB. drop result-units if present
sep=. 1 goodfmla z
fmla=. fixfmla dtb sep taketo z
extn=. dltb }. sep dropto z
NB. 	smoutput zz ,: ".each zz=. ;:'y z sep fmla extn'
fmla ; extn
)

fmlatyp=: 3 : 0
	NB. type of formula of item# y
if. 0=#z=. formula y do. 3 return. end.
if. ':' e. z do. 1 return. end.
if. ';' e. z do. 2 return. end.
0 return.
)

fnline=: 4 : 0
	NB. fn: x of item: y
	NB. c/f copyline
label=. x,(brace y)	NB. e.g. 'f{2}'
unitn=. >y{UNITN	NB. nominal units of item: y
units=. >y{UNITS	NB. SI units of item: y
unitu =. unitn		NB. default: same nominal units
	NB. CONSULT: tabfun.ijs -for correct treatment
if.     (,x)-:,'=' do.	NB. item equated
  label=. '=',(brace y)
  fmla=. ,'a'
elseif. (,x)-:,'-' do.	NB. item negated
  fmla=. '-a'
elseif. +./x E. 'abs int dbl hlv' do.	NB. preserve units
  fmla=. x,' a'
elseif. (,x)-:,'%' do.	NB. item inverted
  unitu=. SL,unitn
  label=. '/',brace y	NB. e.g. '/{2}'
  fmla=. '%a: a',(paren unitn),SP,(brack unitu)
	NB. e.g. '% a: a(h) [/h]'
elseif. x-:'sqr ' do.	NB. item squared
  unitu=. unitn,SP,unitn
  label=. x,(brace y)	NB. e.g. 'sqr {2}'
  fmla=. x,'a: a',(paren unitn),SP,(brack unitu)
	NB. e.g. 'a^2: a(h) [h h]'
elseif. x-:'cube ' do.	NB. item cubed
  unitu=. unitn,SP,unitn,SP,unitn
  label=. x,(brace y)	NB. e.g. 'cube {2}'
  fmla=. x,'a: a',(paren unitn),SP,(brack unitu)
	NB. e.g. 'a^3: a(h) [h h h]'
elseif. '*' e. x do.	NB. simple factor
  fmla=. x,' a'		NB. e.g. '2* a'
elseif. '%~' -: (_2{.x) do.	NB. simple divisor
  label=. (brace y) ,SL, }:}:x
	NB. e.g. '{2}/0.5'
  fmla=. x,' a'		NB. e.g. '2%~ a'
elseif. do.		NB. all else: units not preserved
  unitu=. SL		NB. result is DIMENSIONLESS
  fmla=. x,' a: a',(paren unitn),SP,(brack unitu)
	NB. e.g. '0.5^~ a: a(m) [/]'
end.
NB.	smoutput x ; 'fnline' ; y ; '==' ; fmla
ttafl label ; unitu ; (,":y); fmla
'item' SP1 y SP1 'copied under fn:' SP1 x
)

forcefloat=: 3 : '($y)$,y,1.1'
format=: format_uu_
formula=: 3 : 'if. ({.y) e. }.items'''' do. deb ({.y){TTf else. '''' end.'
fwd=: ffwd&6

g=: 3 : 0
	NB. g: d1X --> d2X --> d3X --> ...
	NB. d1X comes in as: y, d2X gets returned. Then...
	NB. d2X comes in as: y, d3X gets returned ...
	NB. d2X <--   d1X   *   dY   %   d1Y	-from above analysis
	NB. d2X <-- (X1-X0) * (Y-Y0) % (Y1-Y0)
	NB. Of these work-vars (kept as globals)...
	NB.  Y0(=f X0), dY stay the same
	NB.  d1Y --> d2Y must be recalculated. Call it: d_Y
	NB. Thus the only global wk-vars needed are: X0 dY d_Y
d_X=. y * dY%d_Y	NB. not needed as a global
d_X=. d_X * amodel	NB. apply holds, preventing 0-elements changing
	NB. for next pass, d1Y must be replaced by d2Y
d_Y=:	(fwd X0+d_X) -(fwd X0)
d_X	NB. ...returned value, becomes input to the next pass
)

genexe=: 3 : 0
	NB. generate the exe-verb for item: y
nom=. 'exe',":y
(nom)=: 3 : (fexp y)
nom
)

getvalue=: 3 : 0
	NB. get the value of item y (adjusted)
if. y e. }.items'' do.
  unit=. >y{UNITN
  unit adj y{vquan	NB. adjust value
else.
  '>>> not a valid item:' SP1 y
end.
)

go=: 3 : '3 scaleunits 1'

goodfmla=: 3 : 0
0 goodfmla y
:
	NB. validate fmla: y (serves: ttauf)
	NB. x -: 1 returns sep else typ
NB.	┌───┬───┬────────┐
NB.	│typ│sep│ nature │
NB.	├───┼───┼────────┤
NB.	│0  │(:)│no extn │
NB.	├───┼───┼────────┤
NB.	│1  │ : │SI-based│
NB.	├───┼───┼────────┤
NB.	│2  │ ; │nominal │
NB.	├───┼───┼────────┤
NB.	│3  │ ? │bad fmla│
NB.	└───┴───┴────────┘
typ=. #. ';:' e. y
sep=. typ { '::;' , bad=.'?'	NB. YES: :; is right order
	NB. chars should never occur in: fmla itself,
	NB. or formula will get munged !!
	NB. typ=0 --> fmla is the whole of y
 if. 0 do.	NB. HARD-CODED CHOOSER...
fmla=. dtb sep taketo y
extn=. dltb '[' taketo z=. dlb }. sep dropto y
unit=. ']' taketo '[' takeafter z
vc=. ','cut extn	NB. boxed spec for each dependent var
NB.	smoutput 'goodfmla:'
NB.	smoutput zz ,: ".each zz=. ;:'y typ sep fmla extn unit vc'
for_i. i.$vc do.		NB. scan dep units
  v=. >i{vc			NB. the i-th spec
  'n unit'=. '('cut detb v-.')'	NB. (n;unit) from: 'n(unit)'
end.
 end.		NB. ...HARD-CODED CHOOSER
if. x do. sep else. typ end.
)

gooditem=: 3 : 0
	NB. empty'' if y is good item, else message
if. y e. }.items'' do.
  empty''
else.
  nb 'not a valid item:' ; y
end.
)

half=: 2 %~ ]
hasdep=: 3 : 'y e. ,TD'
hasf=: 3 : 'y{ hasfb 0'
hasfb=: 3 : '0< +/"1 TD'
hasfs=: I.@hasfb
hcols=: [ {"1~ [: to/ ]
hdd=: 3 : '(i.#y),.y=.(>:i.}.$y),y'

hide=: 3 : 0
	NB. set hide flags of item(s) y
if. y-:0 do.
  vhidd=: flags 0
  'no lines are now hidden'
elseif. all y e. items'' do.
  vhidd=: 1 y}vhidd
  nb 'item(s) newly hidden:' ; y
elseif.  do.
  nb '>>> invalid items:' ; (y -. items'')
end.
)

hlv=: -:
holds=: 3 : 'vhold +. +./"1 SH= TTn'

id=: 3 : 0
z=. ": (|: ,: i.#y)
z ,. SP ,. ":y
)

ijs=: ext&'ijs'"_
inc=: >:
incompat=: -.@compat
incompat_i=: -.@compat_i

info=: 3 : 0
	NB. access the info stored for current ttable
NB. used by topend
TTINFO
:
TTINFO=: y			NB. call: 1 info <updated_info>
)

inv_prober=: 4 : 0
rr=. $r=. x	NB. r==values of the (rr) leaf-nodes
i=. y		NB. index of element r[i] being probed
z=. 1e_10	NB. low but not low enough to cause underflow
(i=i.rr)*z*(1>.r)
)

invalexe=: 3 : 'erase listnameswithprefix ''exe'''
invalinfo=: empty

inver=: 3 : 0
	NB. change the inversion method# y
select. y
case. 0 do.	inversionX=: inversionA		NB. old method ported from APL
case. 1 do.	inversionX=: inversionB		NB. NEW METHOD using ^:_
case. do.	smoutput '>>> unknown inversion arg:' SP1 y
end.
empty''
)

inversion=: 4 : 0
	NB. saddle for calling inversionX (vectored)
NB. r1=. r inversion deltaz --the way it's called
NB.  where: deltaz (=y here) is dY in inversionB
NB.  and r is values of ancestors of pivot item# (fwd acts on this vec)
X=. x inversionX y
sess1 'inversion_saddle: y=' SP0 y
sess1 (>'amodel:' ; 'x:' ; 'X:') SP0 ":(amodel,:x),X
X
)

inversionA=: 4 : 0
	NB. === DIFFERENTIAL INVERTER ===
	NB. accepts vector of leaf-item values: x --giving: (z ; DELTAz), where:
	NB.   (z=.fwd r=.x) ; (DELTAz=.y)
	NB. Iterates to find progressively better DELTAr (the change in r) such that:
	NB.   (z+DELTAz) --> fwd (r+DELTAr);  DELTA being their difference (to be minimised).
	NB. Estimates DELTAr from: DELTAz*(Dtr%Dtz) -- derivatives of r and z respectively.
rr=. $r=. x			NB. r is vector of values of the (rr) leaf-items
DELTAz=. y			NB. the CHANGE in value of the pivot item
errno=. 0			NB. error number, 0 if unchanged (no error)
for_t. i.MAXINVERT do.		NB. max iterations, may need to vary this
  tt=. >:t			NB. tt is for inspection after loop exits (t vanishes)
  scale=. 1>.|{.z=. fwd r	NB. <<<<< TRY TO ELIMINATE scale!
  Dz=. 0$0			NB. begin compute partial derivatives of z
  for_i. i.rr do.		NB. estimate partial derivative[i] by probing each i{r
    p=. r inv_prober i		NB. only i{p is non-zero
    if. DELTAz>0 do.
      Dz=. Dz,(z-~fwd r+p)%i{p  NB. variation Dz+
    else.
      Dz=. Dz,-(z-~fwd r-p)%i{p	NB. variation Dz- (other way)
    end.
     sess1 'inversion: i=' SP0 i SP2 'p=' SP0 p SP2 'Dz=' SP0 Dz
  end.
  Dtr=. r*amodel		NB. amodel is a global created in: beval
  				NB. originally: Dtr=. r inv_apply_g model
   sess1 'inversion: z=' SP0 z SP2 'r=' SP0 r SP2 'scale=' SP0 scale SP2 'amodel=' SP0 amodel 
   sess1 'inversion: Dz=' SP0 Dz SP2 'Dtr=' SP0 Dtr SP2 'Dtz=' SP0 Dtz
  Dtz=. +/Dz*Dtr		NB. Total derivative
  if. 0=Dtz do. sess2 'inversion: MAXMIN error' [errno=.1 break. end.
  DELTAr=. DELTAz * Dtr%Dtz
  if. scale disappears DELTA=. (z+DELTAz) - fwd(r+DELTAr) do. break. end.	NB. it's close enough!
   sess1 'inversion',(brack t),' DELTA=' SP0 DELTA SP2 'DELTAz=' SP0 DELTAz
   sess2 'DELTAr=' SP0 DELTAr
   sess2 'Dtr=' SP0 Dtr SP2 'Dtz=' SP0 Dtz SP2 'Dz=' SP0 Dz
  if. DELTAz=DELTA do. sess2 'inversion: NOCONVERGE error' [errno=.2 break. end.
  DELTAz=.DELTA [ r=.r+DELTAr	NB. consolidate the working values for another loop
end.				NB. ends t/MAXINVERT loop -- drops thru after MAXINVERT passes
if. tt=MAXINVERT do. sess2 'inversion: MAXINVERT error' [errno=.3 end.
if. errno~:0 do. x [ sess2 'inversion ERROR: errno=' SP0 errno	NB. return input values: x
else. 		 r+DELTAr end.	NB. else return adjusted input values: (r+DELTAr)
)

inversionB=: 4 : 0
	NB. === NEWTON-RAPHSON INVERTER ===
X0=: x	NB. the values of the pivot node ancestors
dY=: y	NB. the increment to the pivot node value
	NB. Initialise work-var d_Y for: g, the guessing fn
	NB. d1Y = Y1-Y0
	NB.	= (fwd X1)	-(fwd X0)
	NB.	= (fwd X0+d1X)	-(fwd X0)
d1X=: 1			NB. arbitrary value for the first guess
d_Y=: (fwd X0+d1X) -(fwd X0)
dX=: g^:(_) d1X		NB. the limiting case of d_X
X=: X0+dX		NB. the target X such that Y = fwd X
)

inversionX=: inversionA
isBool=: isBools *. isScalar
isBools=: [: all 0 1 e.~ ]
isFNo=: isFin and isScalar
isFNum=: isFin and isScalar
isFin=: isNum andnot NaN or isInf

isInf=: 3 : 0
	NB. =1 iff isNum and contains _ or __
if. -. isNum y do. 0 return. end.
_ e. |y
)

isItem=: 3 : 'y e. }.items 0'
isItems=: 3 : 'all y e. }.items 0'
isNum=: ([: 1: 0 + ]) ::0:
isnums=: [: *./ '0123456789' e.~ ]
items=: 3 : 'i. #TTn'
ln=: ^.
log10=: 10&^.
log2=: 2&^.

mandhold=: 3 : 0
	NB. [re]set/toggle mandatory hold on item y
_1 mandhold y		NB. default x=_1 -means: toggle the setting
:
	NB. x e. (_1 0 1)
if. notitem y do. 'invalid item:' SP1 y return. end.
lab=. (dtb y{TTn)-.SH	NB. new label without: SH
held=. SH e. y{TTn
select. x
case. _1 do. (-.held)mandhold y return.	NB. toggle the setting
case.  1 do. y relabel lab,SH
case.  0 do. y relabel lab
end.
'manhold' dirty 1
)

merge=: 3 : 0
	NB. arg cover for: ttmerge
	NB. y is pair of item numbers
({.y) ttmerge {:y
)

nfx=: 3 : 0
'' nfx y
:
	NB. format numbers y into col using formats: x
f=. (#y)$ boxopen x	NB. formats for each element of y
z=. i.0 0
for_i. i.#y do.
  z=. z , (>i{f) format i{y
end.
pad rjust z
)

nochange=: empty
noop=: empty
notitem=: ([: -. ] e. [: }. items) ::1:
numvec=: 3 : '". (LF,SP) sub y'
nxt=: 'ZN0000'&aann

nxx=: 4 : 0
	NB. step exponent: y by: x -within acceptable range
NB. smoutput nb x ; 'nxx' ; y
if. y e. i:2 do. i=. x else. i=. 3*x end.
_24 >. (y+i) <. 24
)

ornot=: [ +. [: -. ]

orphan=: 3 : 0
	NB. convert item y to dumb item
TD =: 0 y}TD			NB. remove dependencies of item y
TTf=: SP y}TTf			NB. remove fmla of item y
'item orphaned:' SP1 y
)

pack=: 3 : 0
smoutput=. empty
smoutput y
'e h'=. 3 4	NB. arrowhead, arrow-point-char
z=. ,:0{y [ r=. }:$y
for_i. }. i.r do.
iy=. i{y
smoutput i ; iy
NB. Try to fit iy into z earlier
nofit=. 1
for_j. i.#z do.
  smoutput j ; (*j{z) ; *iy
  t=. (*j{z) + *iy
  if. -. 2 e. t do.
    smoutput j ; (j{z) ;'replace by:' ; x=. iy + (j{z)
    z=. x j } z
    nofit=. 0
    break.
  end.
end.	NB. j
if. nofit do. z=. z,iy end.
end.	NB. i
z
)

pad=: 3 : 0
	NB. pad cmx: y to minimum width: PAD
z=. - ($y) max 0,PAD
z{.y
)

plotx=: 4 : 0
	NB. OLD FACILITY (plots directly)
	NB. plot ttable using vec input to item: x
	NB. y is item ID, x is X-data (J-expression)
vals=. ".x	NB. assume x is validated: num vec exprn
snapshot''
for_v. vals do.
  v setvalue y
  if. 0=v_index do. z=. vquan
  else. z=. z ,. vquan
  end.
end.
i=. y -.~ }.items''	NB. rows to be plotted
PFMT plot DATA=: (y{z) ; (i{z)
)

plotz=: 4 : 0
	NB. plot ttable using vec input to item: x
	NB. y is item ID, x is X-data (J-expression)
vals=. ".x	NB. assume x is validated: num vec exprn
snapshot''
for_v. vals do.
  v setvalue y
  if. 0=v_index do. z=. vquan
  else. z=. z ,. vquan
  end.
end.
NB. i=. y -.~ }.items''	NB. rows to be plotted
NB. PFMT plot DATA=: (y{z) ; (i{z)
z	NB. simply return the generated array
)

pretty=: 3 : 0
	NB. pretty-up (but not convert) units: y
	NB. Mainly serves: ttafl
	NB. IN TIME... this to be moved to loc: uu
if. 0=#z=.deb y do. ,SL return. end.
if. z-: ,SL do. ,SL return. end.
	NB. WARNING: SP are meaningful (c/f SL)
	NB. "star" units eat all other units...
if. ST e. z do. (,ST) return. end.
	NB. Remove trailing slash ...
if. SL={:z do. z=. }:z end.
	NB. Do some simple cancelling-out...
NB. (NOT-IMPLEMENTED YET)
,z
)

promo=: 4 : 'x,y-.x'
querycal=: 3 : 'x2f (>CCc) SP2 (>CCa) SP2 >CCd'
quoted=: quoted_exch_

recal=: 3 : 0
	NB. Recalculate (Ancill: cal)
	NB. y is the pivot node and is the arg for: xseq
	NB. if pivot no importance, call: recal 0
	NB. assumes proffered changes have been made by recal to vquan (only)
vsiq0=: vfact*vqua0	NB. follows nominal values, not internal ones
vsiqn=: vfact*vquan
if. hasf y do. vsiqn=: bcalc y end.
vsiqn=: fcalc y		NB. fwd after break-back to recalc all descendants
vquan=: vsiqn*(%vfact)	NB. update the nominal values
	NB. if undefined units, vsiqn%vfact --> |NaN error
vquan~:vqua0		NB. =1 where the item has changed
)

reformCAL=: 3 : 0
	NB. re-form CAL
CAL=: ''
for_i. /:CCc do.
  LINE=: (>i{CCc),SP,(5{.>i{CCa),(25{.>i{CCx),CSEP,(>i{CCd)
  CAL=: CAL,LINE,LF
end.
)

relabel=: 4 : 0
	NB. relabel row x as: y
if. notitem x do. return. end.
i=. (#TTn)x}items''
TTn=: i{TTn,y
'relabel' dirty 1
)

repeat=: 3 : 0
	NB. repeat last action
r=. cali LAST		NB. ret'd value r is msg string
if. -. c e. '.:' do. snapshot'' end.	NB. not wanted for undo/redo
r  NB. pass-thru cali returned string...
)

repeatable=: [: *./ 'abcdefghijklmnopqrstuvwxyz0123456789' e.~ ]

replot=: 3 : 0
	NB. replot DATA
try. PFMT plot DATA
catch.
end.
)

reselect=: empty

rpln=: 4 : 0
	NB. replace 0{y with 1{y in numx: x
	NB. c/f rplc, but acts on a numx not a cmx
'p q'=. 2{.y		NB. only 1 replacement pair at a time
n=. -. e=. x=p		NB. complementary bitmaps
(x*n)+(q*e)		NB. zero p's and add-in replacement q's
)

rslt=: 3 : 0
	NB. result units of item# y
	NB. if not in formula then use nominal units
z=. formula y
if. '[' e. z do.
  '[]' -.~ '['dropto z
else.
  > y { UNITN
end.
)

sP0=: 4 : 'x,.y'
sP1=: 4 : '(x,.SP),.y'
sP2=: 4 : '((x,.SP),.SP),.y'

scaleunits=: 4 : 0
	NB. re-scale the units of item: y by scale-exp: x
		NB. TESTER is in: temp 719
	NB. eg x= 3(k); _3(m); 6(M); _6(mu) ...
	NB. MOD: ACCEPT THE ACTUAL PREFIX eg 'k' 'M' as: x
x_cal_=:x
if. 'literal'-:datatype y do.	NB. y is the actual units to be scaled [TEST ONLY]
  un0=. y
  y=. 0		NB. nominal item# (invalid, for test-only)
else.		NB. ASSUME y is item# in ttable...
  if. -.y e. }.items'' do. ('bad item:' SP1 y) return. end.
  un0=. >y{UNITN
end.
'a f0 un2 b'=. cnvj un0		NB. f0: scale factor, un2: unscaled units, a b: discarded
sp=. ;:'= da h k ? ? M ? ? G ? ? T ? ? P ? ? E ? ? Z ? ? Y   y ? ? z ? ? a ? ? f ? ? p ? ? n ? ? mu ? ? m  c  d' 
NB.     0 1  2 3 4 5 6 7 8 9    12    15    18    21    24 _24   _21   _18   _15   _12    _9    _6     _3 _2 _1 
NB. no valid scale-prefix for 10^4 etc, so these have: ? in: sp
	NB. Assign p (scale-prefix) ...
if. 'literal'-:datatype x do.	NB. x is the literal prefix required
  p=. x
elseif. x e. i:3 do.		NB. ASSUME x is step#
  z=. x nxx <. 10^.f0		NB. step existing exponent within acceptable values
NB.   z=. _24 >. (z+x) <. 24	NB. cannot advance beyond end-stops
  p=. '=' -.~ >z{sp
elseif. t=<.t=. 10^.x do.	NB. IF x is the power-of-10 factor itself
  p=. '=' -.~ >t{sp
end.
un3=. p,un2			NB. new units
NB. 	smoutput z ,: ".each z=. ;:'x y un0 un2 un3 f0 fx p'
un3 changeunits y
nb 'item' ; y ; '-units changed from:' ; un0 ; 'to:' ; un3
  NB. Scaling prefixes recognised above:
  NB.	------------------------------------------------------------------------------
  NB. 	deca- 	hecto- 	kilo- 	mega- 	giga- 	tera- 	peta- 	exa- 	zetta- 	yotta-
  NB. 	da 	h 	k 	M 	G 	T 	P 	E 	Z 	Y
  NB. 	10^1 	10^2 	10^3 	10^6 	10^9 	10^12 	10^15 	10^18 	10^21 	10^24
  NB.	------------------------------------------------------------------------------
  NB. 	deci- 	centi- 	milli- 	micro- 	nano- 	pico- 	femto- 	atto- 	zepto- 	yocto-
  NB. 	d 	c 	m 	µ 	n 	p 	f 	a 	z 	y
  NB. 	10^−1 	10^−2 	10^−3 	10^−6 	10^−9 	10^−12 	10^−15 	10^−18 	10^−21 	10^−24
  NB.	------------------------------------------------------------------------------
)

scriptof=: 3 : 0
	NB. find full pathname of ttable id in various forms
if. 0=#y do. y=. '$$' end.
if. y-: '$$' do.	TPATH_SAMPLES, ijs 'SAMPLE'
elseif. isnums y do.	TPATH_SAMPLES, ijs 'SAMPLE',y
elseif. isNo {.y do.	TPATH_SAMPLES, ijs 'SAMPLE',":y
elseif. '~'={.y do.	dtb jpath y
elseif. '/'={.y do.	y	NB. assume y is fullpath (MAC/Unix only)
elseif. do.		TPATH_TTABLES, ijs dtb y
end.
)

selrow=: empty
seltext=: empty
sesi=: 3 : 'if. TRACI do. smoutput y else. i.0 0 end.'
sess=: 3 : 'if. TRACE do. smoutput y else. i.0 0 end.'
sess1=: sess
sess2=: sess
set_ucase=: set_ucase_uu_

setcols=: 4 : 0
	NB. create field-args for: cols
i=. I. x=c=. 0{y
d=. (|.2,$i)$ }.(2#i),$c  NB. 2-col array
(c)=: <"1 (($d)$0 1)-~d
'assigned: ',": deb c
)

setcwd=: 1!:44

setfmla=: 4 : 0
	NB. set x as the new formula of item y
	NB. This does NOT alter dependencies
if. baditem y do. BADITEM return. end.
select. typ=. goodfmla x
case. 0 do.
case. 1 do.
case. 2 do.
case. do. nb 'setfmla: item:' ; y ; '-bad:' ; x return.
end.
	NB. rely on: goodfmla to evaluate fmla: x
TTf=: > (<x) y} x2b TTf
genexe y
empty CH=: recal 0
nb 'item:' ; y ; 'new formula:' ; x
)

setparam=: empty
setsig=: setsig_uu_

settitle=: 3 : 0
	NB. set the ttable caption
CAPT=: y
'settitle' dirty 1
)

setvalue=: 4 : 0
	NB. set x as the value of item y
if. y e. }.items'' do.
  unit=. '_',>y{UNITN	NB. prefix '_' works adj in reverse
  x=. unit adj x	NB. adjust value of x
  vqua0=: vquan
  vquan=: x y}vquan
  CH=: recal y
  if. y{CH do.
    'item:' SP1 y SP1 'accepts value:' SP1 x
  else.
    'item:' SP1 y SP1 'resists value:' SP1 x
  end.
else.
  '>>> not a valid item:' SP1 y
end.
)

shortf=: 3 : 0
	NB. short-form (no ext) of: y (=file) for message output
DT taketo |. SEP taketo |. y
)

showing=: empty

siunits=: 3 : 0
	NB. convert item y to SI units
si=. y{UNITS	NB. the SI units
UNITN=: si y}UNITN
vquan=: (y{vsiqn) y}vquan
vqua0=: (y{vsiq0) y}vqua0
vfact=: 1 y}vfact
CH=: recal 0
'siunits' dirty 1
'item' SP1 y SP1 'is now in units:' SP1 (>si)
)

snapshot=: 3 : 0
	NB. snapshot/restore the values of SNAPSP vars
	NB. x(given) is snapshot# to be restored, x(absent) means new snapshot
	NB. y-:0 resets the record
	NB. y-:'' takes next snapshot
ZNN=: 1 + 1 default 'ZNN'
if. y-:0 do.				NB. restart ZZN series
  erase listnameswithprefix '0'-.~nxt 0	NB. destroy snapshots
  ZNN=: 1
end.
nom=. nxt ZNO=: ZNN
(nom)=: ". SNAPSP rplc SP ; SC
'snapped: ',nom
:
nom=. nxt x
(SNAPSP)=: ".nom
'restored: ',nom
)

sor=: 3 : 0
	NB. permutation to rt-justify the 1's in closure of dependency mx y
y=. 1 1 }.y  NB. drop the row+col headers of dependency mx y
	NB. return the perm of rows floating items with fewest 1's
>: /: y	NB. strip hdr, sort rows, return io=1 row-perm
)

sortTD=: 4 : 0
	NB. sorts TD by perm: x
	NB. usage: t sortTD TD
sess=. empty
t=. 0 promo x		NB. ensure perm: t doesn't move (hdr) item 0
z=. t{TD
sess w=. w,: ".each w=. ;: 'z t taz' [taz=. t{az
  NB. RATIONALE:
  NB.         a b c d e f g h
  NB. if  i=. 0 1 2 3 4 5 6 7
  NB.     t=. 0 5 2 1 4 3 6 7
  NB. -->     a f c b e d g h
  NB. so: t{'abcdefgh' --> 'afcbedgh'
  NB. hence what was 5 in z must be replaced with new id: 1,
  NB. ditto what was 1 in z must be replaced with new id: 3, etc
for_i. i.$t do.
  if. i~: i{t do.
    z=. z rpln (i{t),-i	NB. (-i) not i, to stop change being changed again
  end.
end.
|z
)

start=: 3 : 0
	NB. start the engine
load :: 0: TPATH_CAL,'manifest.ijs'	NB. sets VERSION
enlog 0		NB. start a new log file
	NB. create folders if absent ...
try. 1!:5 < TPATH_TTABLES catch. end.
try. 1!:5 < TPATH_ARCHIVE catch. end.
	NB. RELOAD general math fns ...
load TPATH_CAL, ijs'tabmath'
	NB. ENSURE up-to-date currency conversion table ...
NB. load TPATH_CAL, ijs'exch'
NB. start_exch_''
ARGS=: targs ARGEX=: <;._2 ARGEXP	NB. i/f args-table
cmake''		NB. build the i/f tables
ttload ''	NB. load SAMPLE ttable
)

suits=: 1:

tabengine=: 3 : 0
	NB. TABULA engine interface
if. isBoxed y do. y=. nb y end.
sesi 'tabengine ',(quote y),TAB,'NB. TRACI_cal_'
enlog y
	NB. y (trimmed) is instruction string: inst
	NB.   <cmd> <arg> <data>
	NB.   <cmd> (always 4 chars) chooses: arg, exp
	NB.   <arg> (max 4 chars) is a pattern to tell
	NB.	how <data> goes into arg-caches:
	NB.	n r rr rrr rv rzz
	NB.	for use inside: ".exp
if. 'Repe'-: dltb y do. y=. LASTINSTR end.
cmd=. 4{. instr=. dltb y	NB. the command
yy=: dlb 4}. instr		NB. the following text
	NB. First handle special (cmd) cases ...
	NB.	These appear in CAL too
	NB.	but only for use by: QUER
select. cmd
case. 'Init' do. start'' return.
case. 'QCMD' do. CCc e.~ <yy return.
case. 'Undo' do. undo 1 return.
case. 'Redo' do. undo 0 return.
case.        do. 		NB. other (cmd)
  if. repeatable cmd do. LASTINSTR=: instr end.
end.
if. 0>nc<'CCc' do.
  z=. '>>> CAL not initialized: ' ; instr
  z return.
end.
icmd=. CCc i. <cmd	NB. index# of (cmd)
if. icmd=#CCc do. '>>> bad instruction:' ; instr return. end.
exp=. > icmd { CCx	NB. expression to execute
	NB. Fill discretionary arg caches ...
	NB. to evaluate within: exp
af=. (bf=. ARGS e. ;: exp) # ARGS	NB. args found in exp
  sess exp ; af
tests=. ; ".each (I.bf) { ARGEX
	NB. TEST OUTPUT of broken-out args
NB. for_k. af do. ko=. >k
NB.   if. 0=nc<ko do.
NB.     sess ko,'=',q ".ko
NB.   else.
NB.     sess ko,' unset'
NB.   end.
NB. end.
if. -.all tests do. nb 'bad:' ; (nb af) ; 'in:' ; yy return. end.
	NB. Execute: exp ...
	NB. lowercase (cmd) return error/confirm-message
	NB. uppercase (cmd) return data-noun
RETURNED=: ".exp
	NB. snapshot ttable ONLY if lowcase (cmd)
	NB. This excludes: Init, Undo, Redo,
	NB.  and cmds that return a data-noun.
if. all cmd e. az do. snapshot'' end.
RETURNED
)

targs=: [: {. [: }. [: |: [: ;: any2x
tbx=: ijs

testvs=: 3 : 0
	NB. test fn: show 'v' values
i=. items''			NB. to index the columns
l=. >z=. cut'i vhidd vmodl vhold vfact vqua0 vquan vsiq0 vsiqn'	NB. alter to suit
l SP1 >".each z
)

title=: 3 : 0
	NB. access the title stored for current ttable
NB. used by topend
CAPT
:
CAPT=: y			NB. call: 1 title <updated_title>
)

trace=: 3 : 0
	NB. set/toggle TRACE -controls sess
if. (y=.{.y) e. 0 1 do.
  TRACE=: y
else.
  TRACE=: -. TRACE
end.
)

traci=: 3 : 0
	NB. set/toggle TRACI -controls sesi
	NB. (used to echo instruction string)
if. (y=.{.y) e. 0 1 do.
  TRACI=: y
else.
  TRACI=: -. TRACI
end.
)

tranhold=: 3 : 0
_1 tranhold y		NB. default x=_1 -means: toggle the setting
:
NB. x e. (_1 0 1)
if. y=0 do. vhold=: flags 0 end.	NB. 'item 0' means clear all holds
if. notitem y do. 'invalid item:' SP1 y return. end.
select. x
case. _1 do. vhold=: (-.y{vhold) y}vhold
case.  1 do. vhold=: 1 y}vhold
case.  0 do. vhold=: 0 y}vhold
end.
empty''
)

ttadl=: 3 : 0
	NB. add a new "dumb" line to TT
	NB. eg: ttadl 'a:Distance to fall' ; 'km' ; 1
'ytn ytu yvalu'=. y
'yts cyc fac'=. convert ytu
	NB. (check cyc~:0 at this point)
	NB. See: TTlist for vars comprising the ttable to be adjusted
TTn=: TTn,ytn
TTu=: TTu,ytu
TTs=: TTs,yts
TD=: TD,0	NB. dumb line
TTf=: TTf,SP	NB. dumb line
UNITN=: UNITN,<ytu
UNITS=: UNITS,<yts
vquan=: vquan,yvalu
vfact=: vfact,fac
ttfix''
	NB. (c/f ttafl, no need to recal here)
'ttadl' dirty 1
)

ttafl=: 3 : 0
	NB. add a new fmla line to ttable
	NB. eg: ttafl 'label'; 'cm'; '1 2'; 'a+b: a(m),b(cm)'
'ytn ytu ytd ytf'=. y
'yts cyc fac'=. convert ytu=. pretty ytu
	NB. check cyc~:0 at this point? <<<<<<<<<<<
	NB. See: TTlist for vars comprising the ttable
	NB. to be adjusted
TTn=: TTn,,ytn
TTu=: TTu,,ytu
TTs=: TTs,,yts
TD=: TD,,".ytd
	NB. Type 2 needs results units from orig formula
	NB. to correctly specify back-conversion
if. 2=fmlatyp ytf do.
  ytf=. ytf,SP,brack ytu	NB. suffix result units
end.
TTf=: TTf,,ytf
UNITN=: UNITN,<,ytu
UNITS=: UNITS,<,yts
vquan=: vquan,0		NB. placeholder, to be recomputed
vfact=: vfact,fac
ttfix''
invalexe''
CH=: recal 0
'ttafl' dirty 1
)

ttappend=: 3 : 0
	NB. append the chosen ttable to the one loaded
sess_ttappend 'y:' ; y
invalexe''			NB. existing 'exe' verbs are invalid
SWAPPED=: 0			NB. fmla order (overridden by ttable .ijs)
file1=: scriptof y		NB. y is generalised file descriptor
if. mt file1 do.
  'no file specified'
  return.
elseif. -.fexist file1 do.
  'file not found:' SP1 file1
  return.
end.
	NB. keep ttable parts cos these will change
CAPTsav=. CAPT
vquanS=. vquan
vfactS=. vfact
vmodlS=. vmodl
vhiddS=. vhidd
UNITSsav=. UNITS
UNITNsav=: UNITN
vhidd=: vmodl=: _
load file1
CAPT=: CAPTsav	NB. discard new caption and retain old one
if. TAB e. TT do. sess '>>> WARNING: TT CONTAINS TABCHAR' end.
	NB. Separate out TT fields...
empty 't' setcols TT	NB. to set: tn tu ts td tf
nt0=. #TTn	NB. remember the last TT size
TTn=: TTn, debc TT cols tn
nt1=. #TTn	NB. the current TT size
TTu=: TTu, TTu2=. debc TT cols tu
TTs=: TTs, debc TT cols ts
z=. ". debc TT cols td
if. 1=$$z do. z=. |: ,:z end.	NB. >>>>>>>>> fix for munged 1-col TD
TD=: TD , (<:nt0) dadd z
TTf=: TTf, fixttf TT cols tf
erase 'TT'			NB. delete TT as a redundant cache
	NB. re-create vfact and the units cols
NB. z=. convert each UNITN=: boxvec TTu  NB. nominal units
NB. UNITS=: (>&{.) each z	NB. SI-units
NB. vfact=: >(>&{:) each z	NB. (*vfact): {UNITN}-->{UNITS}
NB. vfact=: 0,}.vfact		NB. cos convert munges 0
z=. convert each UNITN2=: boxvec TTu2
UNITN=: UNITNsav,UNITN2		NB. nominal units
UNITS=: UNITSsav,(>&{.) each z	NB. SI-units
vfact=: vfactS, >(>&{:) each z
	NB. REsetup work flags
CH=:    flags 0		NB. "Changed" flags
vhold=: flags 0		NB. TEST ONLY >>>>> default==no holds for TT
if. 1=#vhidd do. vhidd=: nt1 {. vhiddS
else.		 vhidd=: vhiddS, }.vhidd 
end.
if. 1=#vmodl do. vmodl=: vmodlS, (nt1-nt0)#1
else.		 vmodl=: vmodlS, }.vmodl
end.
vqua0=: vquan=: vquanS, }.vquan
vsiq0=: vsiqn=: vquan*vfact
	NB. 'exe' fns may be appended to the ttable
	NB. but replace them anyway
genexe each I. hasfb''
tag=. SWAPPED#'\'	NB. indicator: needs saving in cleaned-up form
reselect 0
CH=: recal 0
'ttappend' dirty 1
tag,'appended: ',file1
)

ttauc=: 3 : 0
	NB. add line from consts table to ttable
  ttadl udumb USAV=: 0 udat y	NB. y is seltext''
)

ttauf=: 3 : 0
	NB. add line from functs table to ttable
'label unitf fext'=. 1 udat y	NB. y is text selected
select. sep=. 1 goodfmla fext
case. '*' do. fext=. '*' appextn fext
case. ';' do. fext=. fext,SP,brack unitf
case. ':' do.
case. do. nb 'ttauf:' ; 'bad funct line' ; y return.
end.
'fmla extn'=. fmla_extn fext
vc=. ','cut extn		NB. boxed spec for each dependent var
deps=. ":(#TTn)+i.$vc		NB. dependencies on feeders
for_i. i.$vc do.		NB. scan dep units
  v=. >i{vc			NB. the i-th spec
  'n unit'=. '('cut detb v-.')'	NB. (n;unit) from: 'n(unit)'
  desc=. n,':','feeder'		NB. label for the feeder line
  ttadl desc ; unit ; 1		NB. append a dumb feeder line
end.
ttafl label; unitf; deps; fext	NB. now append the fmla line
)

ttdelete=: 3 : 0
	NB. delete 1 or more items: y
  nd=. i.0		NB. init items not deleted
  for_i. |.y=.,y do.	NB. delete highest row#s first
    if. hasdep i do.
      nd=. nd,i
    else.
      reselect i
      ttdelete_one i
    end.
  end.
  yd=. y -. nd		NB. items deleted
  if. mt nd do.
    'ttdelete' dirty 1
    reselect 0
    'deleted:' SP1 yd
  elseif. mt yd do.
    'cannot delete:' SP1 nd
  elseif. 1 do.
    'deleted:' SP1 yd SP2 '-- cannot delete:' SP1 nd
  end.
)

ttdelete_one=: 3 : 0
	NB. delete (scalar row#) y
1 ttsort {.y
)

ttfix=: 3 : 0
	NB. fixup the tt-vars after line addition/del
	NB. assume TTn is up-to-date
t=. #TTn		NB. id of new last item of ttable
	NB. extend by overtake ({.) all TT-compatibles to accommodate t
vqua0=: vquan=: t{.vquan
vsiq0=: vsiqn=: vquan*vfact
vhold=: t{.vhold
CH=:    t{.CH
vmodl=: t{.vmodl,100#1		NB. additional items are assigned model: 1
vhidd=: t{.vhidd
TD=:	t{.TD
'ttfix' dirty 1
)

ttload=: 3 : 0
	NB. load the chosen ttable
snapshot 0		NB. to recover space (done again later)
invalexe''		NB. existing 'exe' verbs are invalid
invalinfo''		NB. existing  info display is invalid
TTINFO=:''		NB. create defaulted
SWAPPED=: 0		NB. fmla order (overridden by ttable .ijs)
file=: scriptof y	NB. y is generalised file descriptor
if. mt file do.
  'no file specified'
  return.
elseif. -.fexist file do.
  'file not found:' SP1 file
  return.
end.
vhidd=: vmodl=: _
load file
if. TAB e. TT do. sess '>>> WARNING: TT CONTAINS TABCHAR' end.
	NB. Separate out TT fields...
empty 't' setcols TT	NB. to set: tn tu ts td tf
TTn=: debc TT hcols tn
TTu=: debc TT hcols tu
TTs=: debc TT hcols ts
TD=: 0,". debc TT cols td
if. 1=$$TD do. TD=:|:,:TD end.	NB. >>>>>>>>> fix for munged 1-col TD
TTf=: fixttf TT hcols tf
erase 'TT'				NB. delete TT as a redundant cache
	NB. re-create vfact and the units cols
z=. convert each UNITN=: boxvec TTu  NB. nominal units
UNITS=: (>&{.) each z		NB. SI-units
vfact=: 0,>(>&{:) each }.z	NB. (*vfact): {UNITN}-->{UNITS}
	NB. Fixup the table just loaded
NB. vquan=: fixtthdr vquan
NB. vfact=: fixtthdr vfact
NB. UNITN=: fixtthdr UNITN
NB. UNITS=: fixtthdr UNITS
	NB. setup work flags
CH=:    flags 0		NB. "Changed" flags
if. 1=#vhidd do. vhidd=: flags 0 end.	NB. =1 if row is hidden when displayed
if. 1=#vmodl do. vmodl=: flags 1 end.	NB. The break-back model to be used
vhold=: flags 0		NB. TEST ONLY >>>>> default==no holds saved in ttable
vqua0=: vquan
vsiq0=: vsiqn=: vquan*vfact
	NB. 'exe' fns may be appended to the ttable
	NB. but replace them anyway
genexe each I. hasfb''
tag=. SWAPPED#'\'	NB. indicator: needs saving in cleaned-up form
settitle CAPT
reselect 0
CH=: recal 0
snapshot 0
dirty 0			NB. refreshes dirty-bit
warnplex''
tag,'loaded: ',fprefix file
)

ttmerge=: 4 : 0
	NB. delete target item y after pointing its descendants to item x
if. y incompat_i x do.
  'items' SP1 x SP1 y SP1 'are incompatible -- cannot merge'
  return.
end.
select. z=.hasf x,y
case. 0 0 do.
NB. 	smoutput 'neither has formula:' SP1 x SP1 y
	if. x>y do. 'x y'=. y;x end.
case. 0 1 do.
NB. 	smoutput 'y=' SP0 y SP1 'has formula but not x=' SP0 x
	'x y'=. y;x
case. 1 0 do.
NB. 	smoutput 'x=' SP0 x SP1 'has formula but not y=' SP0 y
case. 1 1 do.
	'items:' SP1 x SP1 y SP1 'both have formulas -- cannot merge'
	return.
end.
NB. smoutput 'x=' SP0 x SP2 'y=' SP0 y
invalexe''		NB. existing 'exe' verbs are invalid
TD=: TD rpln (y,x)	NB. subst x for y in TD
NB. smoutput 'deleting:' SP1 y
ttdelete_one y		NB. lastly, delete y
CH=: recal 0
'ttmerge' dirty 1
'old item:' SP1 y SP1 'merged with item:' SP1 x
)

ttnames=: 3 : 0
	NB. TEST: the various forms of ttable name
for_no. ;:'CAPT TITF TITL TITU TFIL TFLU TNAM TNMX' do.
  nom=. ,>no
  smoutput nom,': ',tabengine nom
end.
)

ttnew=: 3 : 0
	NB. empty the ttable
snapshot 0			NB. to recover space (done again later)
invalexe''			NB. existing 'exe' verbs are invalid
invalinfo''			NB. existing  info display is invalid
TTINFO=:''			NB. create defaulted
TTn=: ,:'tn'
TTu=: ,:'tu'
TTs=: ,:'ts'
TD=: 1 1$0
TTf=: ,:'tf'
UNITN=: UNITS=: ,<'??'
vfact=: vquan=: ,0
CH=:    flags 0		NB. "Changed" flags
vhold=: flags 0		NB. TEST ONLY >>>>> default==no holds for TT
vmodl=: flags 1		NB. The break-back model to be used
vhidd=: flags 0		NB. =1 if row is hidden when displayed
vqua0=: vquan
vsiq0=: vsiqn=: vquan*vfact
file=:	UNDEF
settitle CAPT=: UNDEF_CAPT
reselect 0
snapshot 0
dirty 0			NB. refreshes dirty-bit
'new empty calculator'
)

ttsave=: 3 : 0
	NB. save the ttable
sess_ttsave 'ttsave' ; y	NB. the ijs name
	NB. if y is not empty, accept filename y as new: file
	NB. else use the existing: file -as set by: ttload.
if. 0<#y do.
  if. SEP e. y do. file=: dtb y else. file=: scriptof y end.
end.
	NB. Rebuild TT from fields...
TT=:  TTn SP1 TTu SP1 TTs SP1 ('td',":}.TD) SP1 TTf
empty 't' setcols TT
z=. crr'CAPT'
z=. z,LF2,'TT=: cmx 0 : 0',(,LF,.TT),LF,')'
z=. z,LF2,(cnn'vquan'),LF2,(cnn'vfact'),LF
if. any vhidd do.	z=. z,LF,(crr 'vhidd'),LF end.
if. any vmodl~:1 do.	z=. z,LF,(crr 'vmodl'),LF end.
for_no. (<'exe') -.~ listnameswithprefix 'exe' do.
  z=. z,LF,(crr >no)
end.
if. 0<$TTINFO do.
  z=. z,LF2,'TTINFO=: 0 : 0',LF,TTINFO,LF,')'
end.
if. file-: UNDEF do. 'not saved: (provide a name)' return. end.
retco=. archive shortf file
data=: z	NB. DIAGNOSTIC TO ACCOMPANY: file
bytes=. z fwrite file
sess_ttsave 'written:' SP1 bytes SP1 'to:' SP1 file
erase 'TT'		NB. delete TT as a redundant cache
if. bytes>0 do.
  dirty 0
  nb 'saved ttable:' ; (shortf file) ; (brack nb bytes ; 'bytes')
else.
  zz=. nb '>>> ttable NOT SAVED' ; (shortf file)
  zz [ sess_ttsave zz
end.
)

ttsort=: 4 : 0
	NB. sort the lines of ttable by selection: y
	NB. (Bool)x: 1=adjust dependencies, 0=blind-sort (used by: duplicate)
t=. items''		NB. commence with all available items
if. 1=$y=.,y do.	NB. 1-element y: treat as deletion
  t=. t-.y
elseif. 0=$y do.	NB. refuse to delete last remaining row
  'last remaining row not deleted'
  return.
elseif. 1 do.
  t=. y
end.
t=. 0 promo t		NB. ensure t doesn't move (hdr) item 0
t=. t-.t-.(items'')	NB. remove bad ids
invalexe''		NB. existing 'exe' verbs are invalid
TTn=: t{TTn
TTu=: t{TTu
TTs=: t{TTs
if. x do.
  TD=: t sortTD TD	NB. correctly displace the dependencies
else.
  TD=: t{TD		NB. a blind-sort by t (when x=0)
end.
TTf=: t{TTf
UNITN=: t{UNITN
UNITS=: t{UNITS
vfact=: t{vfact
vqua0=: vquan=: t{vquan
vsiq0=: vsiqn=: t{vsiqn
vhold=: t{vhold
vmodl=: t{vmodl
vhidd=: t{vhidd
CH=: flags 0
'ttsort' dirty 1
'sorted by:' SP1 t
)

txt=: ext&'txt'"_
ucode=: ucode_uu_
ucods=: ucods_uu_
udat=: udat_uu_
udiv=: udiv_uu_
udumb=: udumb_uu_

undo=: 3 : 0
	NB. y=1(undo) y=0(redo)
invalexe''
if. y do.
  tag=. 'undo'
  if. 1=ZNN do. '>>> cannot undo any more' return. end.
  ZNN=: 1>.ZNN-1
else.
  tag=. 'redo'
  if. ZNO=ZNN do. '>>> cannot redo any more' return. end.
  ZNN=: ZNO<.ZNN+1
end.
sess_undo tag SP1 'ZNN:' SP1 ZNN SP2 'ZNO:' SP1 ZNO
ZNN snapshot''
)

uprates=: 3 : 0
	NB. update any exchange rates in ttable
start_exch_''	NB. get current rates
	NB. NOT STARTED AUTOMATICALLY AT STARTUP
	NB. AS THIS CAN HANG THE APP IF NO NET CONNECTION
vf=. vfact	NB. save original
ch=. 0		NB. "factor to be changed" flag
z=. 0	NB. accumulate factors
for_i. }.items'' do.
  unitn=. >i{UNITN
  units=. >i{UNITS
NB.	smoutput nb 'Line' ; i ; 'UNITN' ; unitn ; 'UNITS' ; units
  if. (units-:'eur')*.(quoted unitn) do.
    ch=. 1
    z=. z, %exrate unitn
  else.
    z=. z, i{vfact	NB. keep existing factor
  end.
end.
if. ch do.
  vfact=: z
  recal 0
  '+++ exchange rates updated'
else.
  '>>> no action -- no quoted currencies'
end.
)

uurowsc=: uurowsc_uu_
uurowsf=: uurowsf_uu_
validbool=: isBool
validitem=: 3 : 'y e. }.items 0'
validitems=: 3 : 'all y e. }.items 0'
validlit=: isLit
validnum=: isNo
validrr=: validitems *. isLen2
validrv=: isLen2 *. ([: isItem {.) *. [: isFNo {:

warnplex=: 3 : 0
	NB. warning if any v-buffer is complex
z=. ;:'vfact vhidd vhold vmodl vqua0 vquan vsiq0 vsiqn'
for_no. z do.
  if. 'complex' -: datatype ".>no do.
	wdinfo (>no),' is COMPLEX!',LF,'Check for INVALIDs'
	return.
  end.
end.
i.0 0
)

xseq=: 3 : 'sor clos dpmx TD'

NB. ========== z-LOCALE ==========

cocurrent 'z'

TPATH_CAL=: 3 : 0 ''
	NB. returns directory containing this script
	NB. also assigns global: WHEREAMI -the folder in question
	NB. plus SEP -the platform-dependent path-separator.
ws=. [: 'Not from script'"_`({ 4!:3@(0&$))@.(0&<:) [: 4!:4 [: < >
WHEREAMI=: '<UNSET>'	NB. needed for ws to work with
z=. >ws 'WHEREAMI'
SEP=: '/\' {~ '\' e. z
WHEREAMI=: (>: z i: SEP) {.z
)

TPATH_SAMPLES=: TPATH_CAL
TPATH_TTABLES=: jpath '~user/tabula-user/'	NB. folder of user ttables
TPATH_ARCHIVE=: jpath '~temp/ttarchive/'	NB. users ttable archive folder

tabengine=: tabengine_cal_
ijs=: ],'.ijs' #~ [: -. '.' e. ]
tbx=: ijs					NB. tbx: ext for ttables (if ever changes)
ot=: 3 : 'TPATH_CAL,ijs y'

load TPATH_CAL, ijs 'tabz'

	NB. Load: uu -by looking for sibling folder
load (TPATH_CAL,'cal.ijs') rplc ;:'cal uu'

NB. DO NOT CALL start_cal_ HERE: CAL DOES NOT SELF-START.
