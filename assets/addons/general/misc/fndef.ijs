NB.  This script is to help begining users write J code
NB.  using a more literate style
NB.
NB.  It is assumed users have stdlib.ijs available
NB.
NB.  function         3   a synonym for verb

NB.  By                   Stitch
NB.  first                first item in list
NB.  second               second item from list
NB.  last                 last item in list
NB.  FN                   utility to insert x and y in a script
NB.  of                   conjunction for function definition
NB.  On                   laminates two vectors otherwise uses join
NB.  product              the product of items in a list
NB.  run                  run a noun script
NB.  stoa                 script to array
NB.  sum                  the sum of items in a list
NB.  torow                modifies a row of a table or matrix
NB.  tocol                modifies a column of a table or matrix
NB.  wordsin              Word formation  ;:

cocurrent 'z'

NB. =============================================================
NB. *function n integer 3
function =: 3

NB. =============================================================
NB. *By v name for stitching two arrays
By =: ,.

NB. *first v name for {.
first =: {.
NB. *second v  extracts second item from list
second   =: 1&{
NB. *last v alternate name for {:
last =: {:


NB.  *FN v  dyadic, left argument is script, right argument character.
NB.  If right argument is a single word then it inserts a line
NB.  replacing the placeholder y as for a monadic function,
NB.  if the argument is two words it inserts lines for
NB.  placeholders x and y for a dyadic function.  If the
NB.  definition permits both, monadic and dyadic forms are included.
NB.  If two arguments are supplied, the first is the left and the
NB.  second is the right.  If the argument is empty no line is inserted.

FN   =: 4 : 0
z =. #;: y  NB.  Number of arguments must be one or two
w =: stoa x
select. z
case. 0 do. w
case. 1 do.
   if. ':' e. 0{"1 w  do. 'Domain error' return.
                       else. ( y,'=.y'),w
   end.
case. 2 do.
   x =. >{.;: y
   y =. >{:;: y
   s1 =.   y,'=.y'
   s2 =.   x,'=.x'
   if. ':' e. 0{"1 w  do.
      if. 0 = (0{"1 w) i. ':'
             do.  NB.  dyadic only
                  ': ',s1,s2,}.w
             else.  NB. Ambivalent case
                  s  =.   s1,w                NB. Monadic case
                  n  =.   (0{"1 s) i. ':'
                  ((n+1){.s), s1,s2,(n+1)}.s  NB. Dyadic case
      end.
                       else.
                  ': ',s1,s2,w                NB. Dyadic only
   end.
end.
)

NB. *of c  noun noun
NB.  the left argument is a name class for the item to be defined
NB.  and the right argument is the names of the verb arguments.
NB.  of is a conjunction which defines new verbs, adverbs and
NB.  conjunctions.

NB.  For example the following defines a function trianglearea

NB.  trianglearea =: function of 'base height'
NB.  0.5 * base * height
NB.  )

NB.  In defining adverbs and conjunctions the usual place holders
NB.  u v m n are required.
of  =: 2  : 'm : (((0 : 0) FN n))'


NB. *On v laminates two vectors otherwise uses join
On =: 4 : 0
ondim =. [: # $
if. (1 >: ondim x) *. 1 >: ondim y
  do. x,:y
  else.  x,y
end.
)

NB. *product v forms product of a right numeric argument
product =: */

NB. *run  v  executes a noun script
run  =: 0!:1
rund =: 0!:101

NB. *stoa  v  argument script
NB.  stoa converts any character vector to an array using
NB.  the last item as 'fret'.  The characteristic use - from
NB.  a string to array gives the name  stoa
stoa =: 3 : 0
> < ;._2 y
)

NB. *sum v sums a right numeric argument
sum =: +/

NB.  Amendment for matrices
NB.  *ToRow c   data ToRow rownum  matrix
NB.  *ToCol c   data ToCol columnum matrix
torow =: 2 : 'm n } y'
tocol =: 2 : '|: m n}|: y'

NB. *words v argument is string
wordsin =: ;:

cocurrent 'base'
