Note 'Primitives and Translation  J7'

Names for primitives

Some users may prefer a more literate form of J using words instead
of the J primitives.  We call the words alpha primitives since they
use an alphabetic form rather than a graphic or inflected graphic to
represent them.  This script provides a means of doing this with
options for the form of the words used, and verbs to convert a script
in alpha form to a script in J primitives so there is no execution
time penalty.

The alphabetic form and the graphics form can be freely mixed in a script.

This script assigns names used in the Vocabulary and Dictionary.  The
default is to use lowercase names consistent with the practise in J libraries. 
The default order is to list a name for the dyadic form, then a name for the 
monadic form and finally some synonyms in the dictionary or common usage.

These notes use CamelCase, words beginning with capitals and no
spaces.  That is consistent with the previous 'primitives' script in
the distribution and helps avoid name conflicts.
To use CamelCase which helps treat primitive names as reserved names,
place NB. at the beginning of the line
    LIT =: tolower  each LIT
following the line
    tabpri ''

Words are generally not abbreviated unless it is to follow either the
Vocabulary or Dictionary head words. Names which are duplicated in either
source have been modified to give unique names.

Modifications are:
_:  InfiniteFunction
^   ToPower
\:  Sortdown  instead of Sort
]   Right for monadic case
&.: UnderInfinite    (the infinite rank case for right argument)
d.  Derivative0  (The left term is applied rank 0)


Some common abbreviations for relations and booleans have been
added and the names First and Last for Head and Tail.


Using lower case names means that verbs cut, sort and table in the standard
library  will be hidden, and new definitions used. No other standard library
verbs should be affected.  The verbs max, min, rotate and deal also differ
from verbs with these names in scripts 'stats','strings','isigraph' or 'random'.


Some examples of usage

0.  Using foreign language names, or your own names
Persons wishing to have a set of primitives with names in another
language merely need to replace the English names in the global
variable PRIMITIVES defined below with foreign language alternatives.

A user wishing to use their own names for primitives could
define them making replacements for the English names.

1.	To convert a script in literal form saved as a noun  myscript
to primitive form use

myscriptp =: toprimitives myscript

2.  Converting files from literal to script form

Suppose you have a script in file f written using the literal names and
would like to write it to file f1 using primitives to obtain
maximum execution speed.  The verb toprimitives has a dyadic form
which accepts as left argument the file name of a literate J script
and as right argument the file name for the same script converted to
J primitives.

f toprimitives f1

3.  To run a file in literal form.

If you have loaded this script, then use the Run menu or key shortcuts.
This will execute slower than than the options below, but given the speed
of most machines this will often not matter.

If you have saved the file with path and name f you can use
loada toload a script using alpha primitives
   loada  f

If you want to run the file and display the output use
   loadad f

3.  Conversion to literal

To convert a file using alpha primitives to the standard form is
a more complex task.  There is some excellent material on the
JWiki for this.  Look at Primitives to Mnemonics contributed
by Don Guin. 
)

cocurrent 'z'


PRIMITIVES =: noun define
=  Equal  SelfClassify
<  LessThan  Box LT 
<. LesserOf  Floor Min 
<: LessOrEqual LessThanOrEqual LE  Decrement
>  LargerThan Open GT
>. LargerOf Ceiling Max  
>: LargerOrEqual Increment GE 
_  Infinity
_. Indeterminate
_: InfinityVerb
+  Plus  Conjugate
+. GCD  RealImaginary Or
+: NotOr  Double  Nor 
*  Times Signum
*. LengthAngle And LCM
*: NotAnd Square Sq Nand 
-  Minus Negate
-. Less Not
-: Match Halve
%  Divide Reciprocal DividedBy 
%. MatrixDivide  MatrixInverse
%: Root  SquareRoot  Sqrt
^  ToPower Exp Exponential
^. Logarithm NaturalLogarithm Log
^: Power
$  Shape  ShapeOf
$. Sparse
$: SelfReference
~  Evoke Reflex Passive Reflexive 
~. Nub
~: NotEqual  NubSieve NE 
|  Residue  Magnitude
|. Rotate Reverse Shift 
|: Transpose Transpose
..  DotProduct Determinant
.. Even
.: Odd
:  MonadDyad  ExplicitDefinition  Explicit
:. Obverse
:: Adverse
,  Append Ravel
,. Stitch  RavelItems
,: Laminate Itemize  
;  Link  Raze
;. Cut
;: SequentialMachine Words FSM
#  Copy  Tally
#. Base  Base2  BaseTwo
#: Antibase  Antibase2 AntibaseTwo
!  Combinations  Factorial OutOf
!. Customize  Fit
!: Foreign
/  Table Insert
/. Key Oblique
/: SortUp  GradeUp
\  Infix  Prefix
\. Outfix  Suffix
\: SortDown  GradeDown
[  Left Same
[: Cap
]  Right Right
{  From  Catalogue
{. Take  Head First
{: Tail Last
{:: Fetch  Map
}  Amend  ItemAmend
}. Drop  Behead
}: Curtail
"  Rank
". Numbers  Do
": Format   DefaultFormat
`  Tie
`: EvokeGerund
@  Atop
@. Agenda
@: At
&  Compose  Bond
&. Dual  Under
&.: UnderInfinite
&: Appose
?  Deal  Roll
?. DealFixed  RollFixed
a. Alphabet
a: Ace
A. Anagram  AnagramIndex
b. Basic  Boolean
C. Permute Direct Cycle
d. Derivative0
D. Derivative
D: SecantSlope
e. In MemberIn RazeIn
E. MemberOfInterval
f. Fix
H. Hypergeometric
i. IndexOf  Integers
i: IndexOfLast IntegerRange Steps
I. IntervalIndex Indices
j. Complex  Imaginary
L. LevelOf
L: LevelAt
M. Memo
o. CircleFunction Circular PiTimes
p. Polynomial  Roots
p.. PolyIntegral PolyDeriv
p: Primes
q: PrimeExponents PrimeFactors
r. Polar Angle
s: Symbol
S: Spread
t. TaylorCoefficient  
t: WeightedTaylor
T. TaylorApproximation
u: Unicode
x: NumDenom ExtendedPrecision 
)


NB.  Function to construct definitions for inverse transform of a
NB.  script from literate to primitives.
require 'files'

topri0 =: 3 : 0
y =. >y
v =. {. y
vt =. }. y
<vt,.v
)

NB.  utility from  'system\packages\misc\fndef.ijs'
NB. *stoa  v  argument script
NB.  stoa converts any character vector to an array using
NB.  the last item as 'fret'.  The characteristic use - from
NB.  a string to array gives the name  stoa
stoa =: 3 : 0
> < ;._2 y
:
assert. 1=#x
stoa y,x
)

NB.  Establish globals required for translation

tabpri =: 3 : 0
u1 =. > ,&.> / topri0"0  ([: (<@;:)"1 stoa) PRIMITIVES
LIT =: 0{"1 u1
PRI =: 1{"1 u1
)

tabpri''    NB.  constructs global translation tables
NB.  Place  NB. on next line to have CamelCase form
LIT =: tolower each LIT

definealpha =: 4 : 0
pri =. >x
lit =. >y
0$". lit,' =: ',pri
)

NB.  setup all verb names

0 0$PRI definealpha "0 0 LIT

NB.  Function to convert scripts to primitives
NB.  The monadic form converts a noun script to primitives
NB.  The dyadic form writes thefile named in the left argument
NB.  to the file named in the right argument after conversion
NB.  of the script to primitives.

toprimitives =: 3 : 0
b =. ;: y
sb =. $b
b =. ,b
u =. I. b e. LIT
ui =. LIT i. u{b
NB. >  ,&.>/ "1 gg =: sb$ (ui{PRI) u } b
hh =: (;:^:_1) "1 gg =: sb$ (ui{PRI) u } b
:
(((  toprimitives 'm' fread x),.CR),.LF) fwrite y
)


NB.  function to load an alpha primitives J script

loada =: 3 : 0
y toprimitives jpath '~temp/zzzzzzz.ijs'
0!:000 <jpath '~temp/zzzzzzz.ijs'
ferase jpath '~temp/zzzzzzz.ijs'
)

NB.  load and display
loadad =: 3 : 0
y toprimitives jpath '~temp/zzzzzzz.ijs'
0!:001 <jpath '~temp/zzzzzzz.ijs'
ferase jpath '~temp/zzzzzzz.ijs'
)

cocurrent 'base'
