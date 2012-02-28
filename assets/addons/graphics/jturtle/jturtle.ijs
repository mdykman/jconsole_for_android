NB. built from project: ~Projects/turtle6/turtle6

require 'graph numeric plot trig validate'

Note 'Introduction'
JTurtle  - Draft  0.003  January 2006
Please send comments to  fraser.jackson@xtra.co.nz

'lines commencing with a quote are not yet implemented

This script contains verbs to reproduce some Logo
turtle geometry commands and assist in exploration
of geometry of the plane.

Turtle geometry is based on an incremental approach.
The turtle does not know its location, but can make
steps forward or backward, and can change the
direction it is facing.  We will call a series of
incremental steps a track.  We can use the steps in
a track to construct the sequence of points visited.

The points visited define lines in the plane if
the starting position of the turtle is given. A set
of points in a plane will be called a path.  A path
begins at the origin with the turtle facing North,
(the top of the screen) by default but any starting
point and heading can be chosen.

A track consists of 3 item components.  Each
specifies an action which will modify all further
steps along the track.  The components are
    xjy    an incremental movement
    ujv    a change in heading
    c      the action type

Complex numbers are used to represent both heading
and movements.  The action type is an integer. For
some action types, other information is stored in
the first two items.

To convert a  a noun track to a sequence of path
points we specify use a noun  startstate and use the
function render thus
    startstate  render  track
which has a result consisting of two boxed arrays.
The first contains the sequence of points visited,
the heading at each point and the actions.  The
second contains other information extracted from
the track to control the character of the drawing
of the path.

A set of show functions display the paths or
diagrams constructed.  They carry out all steps to
convert the track to a representation on the screen.

show   defaults to fill the form with the path
showf  uses a standard fixed WINDOW with default
       range (_100,100) for x and y coordinates.
showp  uses the standard plot package to display
       any lines or shapes, but does not use fill
       for any parts of the drawing
'showr  accepts as argument the rendered form of
'       a track or tracks
'showc  adds a track to an existing open window

Multiple graphs may be displayed by using the
a left argument to the show verbs.

By adding a set of functions which permit actions
involving specific movements in the cartesion
plane in addition to steps of a turtle track the
system beomes one which enables rapid drawing of
nearly all simple geometric constructions used in
K-12 mathematics courses.

'Isometries in the plane - the following is to
'be added
'Simple isometries of the plane can be explored
'by modifying paths. The functions available
'include
'   xjy translate path
'   x   reflectx  path
'   y   reflecty  path
'   xjy reflectxy path

Track steps

Apart from the basic verbs fd, bk, lt and
rt all track verbs are defined using a verb
to.  It has one or two boxed arguments.  If there
are two, the first specifies the name of the
new track function and its arguments, and the
second specifies how it is calculated.

The user can add new track verbs of arbitrary
complexity.  The single argument form uses
the argument to define the new verb name and
its arguments, and following lines specify
how the track vector is calculated. The final
line specifies the calculated track components
and the definition is closed with a right
parenthesis in the first position in a line.



The basic idea is to build a sequence of 'steps'
   with each turtlestep a forward or turn
   A forward turtlestep is of the form  (size,1,2)
   A turn turtlestep is of the form     (0,z,1)
       with z a complex number on the unit circle.
   A turtle track is a sequence of turtlesteps
   stored as a vector.
   A turtlestate is a vector (z0,z1,c) with
       z0 the complex number xjy for the position
       z1 the complex number ujv for the heading
       c  a scalar representing an action or state

)
  load '~addons/general/misc/fndef.ijs'
  cocurrent 'jturtle'
  load '~addons/general/misc/fndef.ijs'

Note 'Modified  15/2/04'

 Verbs to generate new verbs which maintain
 the conventions for a turtle track and
 for transmission of function parameters via
 a result vector of the form
 (function argument), track

 to 'functionname  arg1 arg2 arg3';'function definition '
 The arguments are a vector to the right of the function
 name.  The number of arguments is found, and the arguments
 are assigned the names.  The names are used in the
 function definition.  The remainder of the argument vector
 must be a turtle track.

(name arg0 arg1 ..argn) todo 'turtle track step definition'
Example
'spike s' todo 'fd s bk s'

)


todo =: 4 : 0
split  =. (dlb  x) i. ' '
fnam   =. split{.x
args   =. split}.x
nargs  =.  #;:args
nargsf =. ": nargs
if. nargs = 1
 do. s    =. '''',args,''' =.  ','{., y'
 else. s    =. '''',args,''' =.  ',nargsf,' {., y'
end.
s =. s,: '(',y,'),', nargsf,' }. ,y'
s =. s,' : '
s =. stZ =:  s,'x ,', fnam ,' y'
". fnam ,'=: 3 :  s'
)

Note  'Modified form'

To permit more extended sequence of J commands
with last line determining components of track.
For example

todo 'spike s'
fd s bk s
)

Note 'todo1'
todo1  calls for input from the input device
and continues to accept lines until it reads
a right parenthesis in the first position of a line.

The result of the expression entered will be the
steps added to the track.  Note the definition of an
auxilliary function nameZZ  to generate and return
the track steps.

The common usage of this form is in the definition
of recursive functions.
)

todo1 =: 3 : 0
split  =. (dlb  y) i. ' '
fnam   =. split{.y
args   =. split}.y
nargs  =.  #;:args
nargsf =. ": nargs
if. nargs = 1
 do. s    =. '''',args,''' =.  ','{., y'
 else. s    =. '''',args,''' =.  ',nargsf,' {., y'
end.
g =. 0 : 0
s =. (,: s)
s1 =. (,s),  stoa g
". fnam,'ZZ =: 3 : s1'
s =. s, '(,',fnam,'ZZ y), ', nargsf,' }. ,y'
s =. s,' : '
s =. s,'x ,', fnam ,' y'
". fnam ,'=: 3 :  s'
)


to =: 3 : 0
if. 2=#y do.
'nom def' =. y
nom todo def
else.
nom =. >y
todo1 nom
end.
)




NB.  Set Globals
require 'validate color16'

COLOR0 =: 255 0 0
COLORS =. do toupper COLOR16_z_
LABELS =: 0
LABELLIST =:  0 3$a:
MX =: MY  =: 0  NB.  reset in scaling for plotting
PENCOLOR0 =: 255 0 0
PENSIZE =: 1
PENSTYLE =: 0
PEN0 =: 1 0
POINTS =: 0 3 $ 0   NB.  Actual coordinates
PPOINTS =:  0 3 $ 0   NB.  Plot coordinates
RANGE  =: 100  NB. reset in scaling for plotting
RANGEF =: 100
SHOWTURTLE =: 1
TS =: 0.12    NB.  Scale unit for turtles
ZERO =: 0 0j1 0   NB.  Start of default path



cs =: showf  NB.  For compatibility with LOGO only
css =: show  NB.  for better definition of drawings
csp =: showp NB.  uses J's plot functions
gdfn =: gdlines   NB.  Default graphics state

for =: 1 : 0
, u "_1 y
:
x, , u "_1 y
)
run =: 0!:0

to 'penup ';'0 1 41'
to 'pendown ';'0 1 42'
pu  =: penup
pdn =: pendown

to 'ht ';'(0$SHOWTURTLE =: 0),0  1 43'
to 'st' ;'(0$SHOWTURTLE =: 1),0  1 44'
hideturtle =: ht
showturtle =: st

to 'color r g b'; '(r j. g),b,51'
to 'pencolor r g b'; '(r j. g),b,52'
to 'penstyle psize pstyle';'psize,pstyle,53'

to 'line';'0 0j1 71'
to 'fill';'0 0j1 72'

NB.  label is not a path verb.  It creates a list of
NB.  labels to be attached to points identified in the
NB.  path.

label =: 3 : 0
if. (isempty y) +. 1 =#y
 do. LABELLIST =: 0 4$a:
     return.
end.
'pt align text' =. y
select. #pt
case. 1   do. loc =. 0 0
case. 3   do. loc =. (}.pt)
case.     do. 'Domain error in label'
end.

0 0$LABELLIST =: LABELLIST , ({.pt);loc;align;text
)

loclabel  =: 3 : 0
'pt loc assign text' =. y
gdtext (loc + getpxy pt);assign;text
)

addlabels =: 3 : 0
if. isempty y
 do.
  y =. 'graph'
end.
gdselect y
loclabel"1 LABELLIST
gdshow y
)

lastxy =: 3 : ' +. {. LASTXYH'
lasth  =: 3 : '-(360 * ({: *. 1{LASTXYH)%2p1)- 90'




NB.  'BASIC FUNCTIONS'

NB. angles to radians  logo convention - clockwise
   ang =: [: r. [:-]*(2p1%360)"_
NB. angles to complex  e^i theta maths convention - anticlockwise
   tocis =: [: r. 2p1"_*]%360"_
NB.  convert cis to degrees		

todegrees =: 3 : 0
assert. 1 = |y
180 * (r.^:_1 y )% 1p1
)

NB.  Main movement functions

to 'fd s';'s,1 2'
to 'bk s';'(-s),1,2'
to 'rt deg';'0,(ang deg),1'
to 'lt deg';'0,(ang -deg),1'

forward =: fd
back =: bk
right =: rt
left =: lt

NB.  multiple sets of similar movements
NB.  convertpath in script stringinput

repeat =: 3 : 0
if. isboxed y
 do.
   'n path' =. y
   z =. ',',path
   ,(n,#z)$ z
   return.
 else.
n =. {.y
yt =. }. y
, (n,#yt)$yt
end.
:
if. (isnumeric x) *. (ischaracter y)+. isboxed y
 do. x, ". repeat y
     return.
end.
x, repeat y
)

rand =: 3 : 0
if. y<0
  do.   y*_0.5+?0
  else. y*?0
end.
)



Note 'convertpath'
Makes provision for string input to functions
show and repeat.  Treatment of CR and LF
to enable use of nouns describing a path being
defined in a script.

path1 =: noun define
fd 5
rt 90
fd 5 rt 90 fd 5 rt 90
lt 90
fd 5
)



delNB =: 3 : 0 "1
(#y){.(I. 'NB.' E. y) {. y
)

delCRLF =: 3 : 0
y =. ' ' (I. y e. CR,LF)}y
)

convertpath =: 3 : 0
if. ischaracter y
 do.
  if. ({:,y)=LF
    do. y =. stoa y
        y =. delNB y
  end.
  if. ismatrix y
    do. y =. ' ',.y
  end.
  y =. ". ,y
else.
  y
end.
)







NB.  Coordinates for drawing turtle

NB.
turtle =: function of 'arg size'
if. 1=#size
 do.
0 0j1 0  turtle  size
 else.
s =. 1{. size
0 0j1 0  turtle s,}.size
end.
:
s =. {.size
's1 s2'  =. s* 1,2 o. 5r6*0.5p1
arg,(rt _90 fd s2 rt 105 fd s1 rt 150 fd s1 rt 105 fd s2 rt 90),}.size
)



NB.  setfns
NB.  Start up position and heading
NB.  Standard start to new path

to 'init'; '0 0j1 0'

NB.  Incremental steps in turtle paths
to 'plusx a';'a,1 8'
to 'plusy a';'(j. a),1 9'
to 'plusxy a b';'plusx a j.b'

NB.  home in a path creates a
NB.  move to the origin.
to 'home' ; '0 0j1 5'

NB.  Use to set heading at beginning of path
to 'sethm deg';'0 ,(tocis deg),10'
to 'seth deg';'0 ,(0j1*tocis -deg), 11'
setheading =: seth

NB.  Absolute positions for turtle in x-y plane.
to 'setxy a b';'(a j. b),1 12'
to 'setx a';'a,1 13'
to 'sety b';'b,1 14'
to 'setxyh a b h';'(a j. b),(0j1*cis -h),15'

to 'goto n'; 'setxy getxy n'

setpos =: setxy

NB.  Modify the following
to 'sethtowards xx yy';'(xx j. yy), 1 6'
to 'fddistance xx yy';'(xx j. yy), 1 7'

NB.  Save locations

to 'point n';'n, 1 25'


NB.  To extract locations after rendering - a show call
NB.  Points are 'sticky' - they exist until reset by a
NB.  point verb


savepoints =: 3 : 0
v     =. I. 25 ={:"1 zzG
if. isempty v do. return. end.
ptsn  =. v{ 0{"1 zzG
ptsloc=. v{ 0 1{"1 zzN
ptsall=. ptsloc,.ptsn
ptn   =. {:"1 POINTS
repp  =. ptsn e. ptn
repval=. repp#  ptsall
POINTS=: repval (ptn i. (repp#ptsn)) }POINTS
POINTS=: POINTS,(-.	repp)#ptsall
)

getxyh =: 3 : 0
n =. ({:"1 POINTS) i. y
xyh   =. n{POINTS
'x y' =. +.{.xyh
h     =. -(360 * ( {:*. 1{xyh)%2p1)- 90
x,y,h
)

getx  =: 0  {  getxyh
gety  =: 1  {  getxyh
getxy =: 0 1{  getxyh
geth  =: 2  {  getxyh

getppoints =: 3 : 0
gxy =. ((getxy y) - MX,MY)%RANGE
)

getpx  =: 0  {  getppoints
getpy  =: 1  {  getppoints
getpxy =: 0 1{  getppoints


Note 'render'
[x] render y
Constructs passing arguments to renders
x  is start location and heading (xjy cis function)
y  is a path, a boxed path, or a list of boxed paths
)

NB.  Convert vector of triples to (n3,3) array
array3 =: 3 : 0
n =. # y
n3 =. <. n%3
d =. (n3,3)$y
)

dochar =: 3 : 0
if. ischaracter y
  do. ".y
  else. y
end.
)


render =: 3 : 0
'' render y
:
if. isboxed y
 do. y =. (dochar&.> ) "_1 y
end.
if. ischaracter x do. x =. dochar x end.

if. isboxed y do.
x renders  , > ,&.>/ y
else.
x renders ,y
end.
)

addh =: 3 : '0 0j_1 0, ,y'

renders =: 3 : 0
0 0j1 0 renders ,y
:
if. isempty x do.  x =. 0 0j1 0 end.
 a =. x
if. isempty y do.
Z  =. array3   x , fd 0
else.
Z  =.   array3 (, x),,y
end.
zN =: ($Z)$0
zN =: x 0}zN
zG =: ($zN)$0      NB.  array for other info
if. (2{0{Z) = 51
  do. 'inc dth c' =. 0{Z
      zG =:  ((+.inc),dth) 0}zG
end.
for_i.
  >: i. <: #Z
do.
  res =. commands i,(i{Z) ,(i-1){zN
  zN =: res i } zN
end.
zN;zG
)



NB.  core central functionality for converting
NB.  from incremental form to ptspath form

commands =: 3 : 0
'i inc dth c1 xy h c2' =. y
select. c1
case.  0 do. inc,dth,0
case.  1 do. (xy+inc*h),(dth*h),c1
case.  2 do. (xy+inc*h),(dth*h),c1

case.  5 do.  0j0 0j1 5
case.  8 do. (xy+inc),h,c1
case.  9 do. (xy+inc),h,c1

case. 10   do. xy,dth,c1
case. 11   do. xy,dth,c1
case. 12   do. inc,h,c1
case. 13   do. (inc j. {: +. xy),h,c1
case. 14   do. (({. +. xy) j. inc),h,c1
case. 15   do. inc,dth,c1

case. 20   do. zG =: (inc,1,20) i}zG
               0 0$". 'point',(":inc),'=: (+.xy),(180%1p1)*{:*.h'
               xy,h, 20
case. 21   do. zG =: (inc,1, 21) i}zG
               xy,h, 21
case. 22   do. zG =: (inc,1 22) i}zG
               xy,h, 22
case. 23   do. zG =: (inc,1 23) i}zG
               xy,h, 23
case. 24   do. zG =: (inc,1 24) i}zG
               xy,h, 24
case. 25   do. zG =: (inc,1 25) i}zG
               xy,h, 25
case. 41   do. xy,h,c1
case. 42   do. xy,h,c1
case. 43   do. xy,h,c1
case. 44   do. xy,h,c1
case. 51   do. zG =: ((+.inc),dth) i}zG   NB.  Save colors
               xy,h,c1
case. 52   do. zG =: ((+.inc),dth) i}zG   NB.  Save colors
               xy,h,c1
case. 53   do.  zG =: (inc,dth,c1) i}zG   NB.  save pensize & style
               xy,h,c1
case. 71   do. xy,h,c1
case. 72   do. xy,h,c1
end.
)



NB.  isometries

NB.  xjy translate  pointspath

translate =: 4 : 0
t =. x
'zn zg' =. y
tn =. |: zn
tn =. (t+0{tn) 0 } tn
(|:tn);zg
)

NB.  rotate

rotate =: 4 : 0
r =. x
'zn zg' =. y
tn =. |:zn
tn =. (r*1{tn) 1 } tn
(|: tn);zg
)

reflectx  =: 4 : 0
assert. x = +x
m =. x
'zn zg' =. y
tn =. |:zn
'x y' =. +. 0{tn
tn =. (((2*x)-m) j. y) 1 } tn
(|: tn);zg
)

reflecty  =: 4 : 0
assert. x = +x
m =. x
'zn zg' =. y
tn =. |:zn
'x y' =. +. 0{tn
tn =. (x j.  (2*m)-x ) 1 } tn
(|: tn);zg
)

NB.  Following function  template only
reflectxy  =: 4 : 0
'xa ya' =. x
'zn zg' =. y
tn =. |:zn
'x y' =. +. 0{tn
tn =. (((2*x)-m) j. y) 1 } tn
(|: tn);zg
)


Note 'Scaling'
This function is to scale the data prior to
passing to the plotting functions.  It is not
required if using  showp.

It scales the data to plot in a window from
(_1,1) and uses 95 percent of the window area
so all lines are inside the frame.
)

scalej =: 3 : 0
'x y' =. |: +. y
rx =.  (>./,<./)x
ry =.  (>./,<./)y
RANGE  =: (20%19)* -: >./ (-/rx),-/ry
MX =: -: +/rx [ MY =: -: +/ry
((x - MX) j. (y - MY) )%RANGE
)

Note 'Scaling rendered object'
The function scalejr takes the result of
render and converts the positions to positions
on a plotting frame from (_1,1) for each
variable.  Note aspect ratio is preserved.
)

scalejr =: 3 : 0
'zn zg' =. y
zn =.|:(scalej 0{"1 zn) 0}|: zn
zn;zg
)

Note 'Plots on a fixed scale'
When using a fixed size box, all scaling
needs to use the same factors.  Note that
with a fixed box centered at the zero.  This
scaling is controled by global RANGE. Default
values is 100.
)

scalefr =: 3 : 0
'zn zg' =. y
RANGE =: RANGEF
MX =: MY =: 0
zn =. |:((0{"1 zn)%RANGEF) 0}|:zn
zn;zg
)






NB.  Some more graphics using cartesians
NB.  These functios reset the start location
NB.  for paths.
NB.

startpos =: 4 : '< init penup setpos x pendown,>y'

start =: 4 : 0
xy =. x
if. isboxed xy do. xy =. > ,xy end.
if. iscomplex xy do. xy =. +. ,xy end.
y =. y

if. -. isboxed y
 do. y =. < y
end.
y =. convertpath each y
if. -. 2=#$xy
 do. xy =. array2 xy
end.
if. 1=#y
 do.  xy startpos"1 _ y
 else. xy startpos"1 0 (#xy)$y
end.
)



NB.  File operations

NB.  Save plot as file

save =: 3 : 0
'' save y
:
if. isempty x
  do.
   gdselect 'graph'
  else.
   gdselect x
end.
if. isempty y
  do.
   gdbmp jpath '~temp/graph.bmp'
  else.
   gdbmp y
end.
)

NB.  Save plot to clipboard.
NB.  argument  x y w h   if required
clip =: 3 : 0
if. isempty y
 do.  gdclip''
 else. gdclip y
end.
)



NB.  Showa adverb - requires scaling function
NB.  as verb argument.
NB.  Defines graph form

NB.   show0 is inner verb for showa
NB.  Detailed handling of graphics


NB.  y is a boxed array of graphic segments

show0 =: 3 : 0
'zn zg' =: y
gdpen  PEN =: PEN0
gdcolor COLOR =: COLOR0
gdpencolor PENCOLOR =: PENCOLOR0
gdfn =: gdlines
for_i.
   i.#zn
do.
  y =. >i{zn
  g =. >i{zg
  c =. 2{"1 y
  if. 41 e. c do. continue. end.
  if. 43 e. c do. SHOWTURTLE =: 0 end.
  if. 44 e. c do. SHOWTURTLE =: 1 end.
  if. 51 e. c  do. COLOR =:roundint ,{."1 +. z1 =:  (I. c=51) {g
                   gdcolor COLOR
  end.
  if. 52 e. c  do. PENCOLOR =:  roundint ,{."1 +. z2 =:  (I. c=52){g
                   gdpencolor PENCOLOR
  end.
  if. 53 e. c  do. gdpen PEN =:  ,{. "1 +. 2 {. , (I.c=53){ g
  end.
  if. 72 e. c do. gdfn =: gdpolygon end.
  if. 71 e. c do. gdfn =: gdlines end.

 gdfn zzz=: getxyvals y
end.
if. SHOWTURTLE do.
    if. 1 = #$y
      do. yt =: ,: y
      else. yt =: y
    end.

       yt =: (2{. {:yt),0
 NB.       tn =: yt renders yt  turtle TS
       tn =.    yt renders yt turtle TS
       gdpencolor 0 128 128
       gdlines , +. 0{"1  >0{tn
  end.

if. LABELS>0
 do.
  for_i.
     i. #LABELLIST
  do.
     'pnum tex loc' =. i{LABELLIST
     xytex =. getpxy pnum
     gdtext xytex ;tex;loc
  end.
end.

gdpencolor PENCOLOR
)

showa  =: 2 : 0
0 0j1 0 u  showa v  y
:
if. isboxed y
 do. y =. convertpath each y
 else. y =. convertpath y
end.

if. isboxed x
 do. 'gname startloc' =. x
     gdopen gname
  if. isempty startloc
    do. startloc =. 0 0j1 0
  end.
 else.
  if. ischaracter x
    do. gdopen x
        startloc =. 0 0j1 0
  end.
  if. (isnumeric x ) *. -. isempty x
    do. gdopen''
        startloc =. x
  end.
  if. isempty x
    do. gdopen''
        startloc =. 0 0j1 0
  end.
end.
ytemp     =. v y
'zzN zzG' =: ytemp
savepoints''
LASTXYH   =: {: zzN
show0   toboxseg WISI =: u  UNSPATH =: startloc v  y
gdshow''
)

show   =: scalejr showa render
showf  =: scalefr showa render

showr  =: scalejr showa ]
showfr =: scalefr showa ]

Note 2

Utility to extract path from and construct
argument for gdlines
)

getxyvals =: 3 : 0
y =. >y
if. 1 = #$y  do. return. end.
c =. 2{"1 y
if. 41 e. c do. return. end.
, +. 0{"1  y
)




Note 0
pr is a test function to examine behaviour
or the rendering function
)

pr =: 3 : 0
'' pr y
:
plot 0{"1 x render y
)


Note 1
boxseg converts rendered data to a set of
boxes each of which is independently drawn
since it they have different graphics
settings.
)

toboxseg =: 3 : 0
'zn zg' =. y
c =. 2{"1 zn
z =.  +/\ c e. 0 41 42 43 44 51 52 53 61 71 72
znb =. ,z < /. zn
zgb =. ,z < /. zg
znb ;<zgb
)

Note '1a'
toboxsegg generates the same boxing for zG as for the
location data
)


Note 2
toplot converts a boxed item to
a data statement for the std plot function
and is a test interface for showp
Needs additional work for wider use.
)

toplot =: 3 : 0
y =.  y
if. 1 = #$y  do. return. end.
c =. 2{"1 y
if. 41 e. c do. return. end.
pd ({.;{:)@|: +. 0{"1 y
)

showp =: 3 : 0
'' showp y
:
if. ischaracter y  do.  y  =. ". y  end.
y =. >{. toboxseg render y
pd 'reset'
pd x
pd 'color RED'
toplot each y
pd 'show'
)




NB.  Some graphics defined using the verb  to
NB.  each of these graphics can be used in any path expression.


to 'poly side angle' ; 'repeat ((360*.angle)%angle) fd side rt angle'
to 'polyn side n' ; 'repeat n fd side rt 360%n'
to 'sq side'; 'repeat 4 fd side rt 90'
to 'sqc s'; 'penup bk s2 lt 90 fd s2 rt 90 pendown sq s pu rt 90 fd s2 lt 90 fd (s2 =.  s%2) pendown rt 0'
to 'rect h w';'repeat 2 fd h rt 90 fd w rt 90'
to 'thing s';'fd s rt 90 fd s rt 90 fd s2 rt 90 fd s2 rt 90 fd s rt 90 fd (s%4) rt 90 fd (s%4) rt 90 fd s2=.s%2'
to 'thing1 s';'repeat 4 thing s'
to 'petal rad deg';'arcr(rad,deg)rt (180-deg)arcr(rad,deg) rt 180-deg'
to 'flower rad deg angle';'repeat ((360*.angle)%angle) petal(rad,deg) rt angle'
to 'circle r'; 'repeat 2 fd d ,(repeat 179 rt 1 fd (2*d)),rt 1  fd (d =.r*sin 1p1%360)'
to 'circlec r'; 'penup seth 0 plusx (-r)pendown circle r pu plusx ( r)pendown rt 0'
to 'inscribe r d';'rt (d%2),(repeat (360%d) fd (2*r*cos 0.5p1* 1-d%180 ) rt d),rt (d%2)'

to 'polysn s n'; 'repeat n fd (s*1p1%n) rt 360%n'
to 'rowsquares s n'; '(repeat n sq s rt 90 fd s lt 90) fd s lt 90 fd n rt 90'
to 'colsquares s n';'repeat n sq  s penup fd 1 pendown '''''
to 'blocksquares s r n';'repeat r rowsquares s ,n'
to 'arrow s';'rt 155 fd s bk s lt 310 fd s bk s rt 155'
to 'arrow1 s';'rt 155 fd s rt 115 fd (2*s*cos 1p1*65%180)rt 115 fd s lt 25'
to 'solida s';'fill arrow1 s line'''' '
to 'arcr r deg';'rt 0.5 fd d,(repeat (deg-1) fd (2*d) rt 1) fd (d =.r*sin 1p1%360) rt 0.5'
to 'arcl r deg';'lt 0.5 fd d,(repeat (deg-1) fd (2*d) lt 1) fd (d =.r*sin 1p1%360) lt 0.5'

to 'hundreds r'
(repeat r pendown blocksquares 1 10 10 penup fd 1)penup bk (r*11)
)
to 'tens r'
(repeat r pendown blocksquares 1 10 1 penup fd 1) penup bk (r*11)
)
to 'units r'
(repeat r pendown sq 1 penup fd 11 ) penup bk (r*11)
)
hide =: 3 : 'penup y pendown'''''

to 'num n'
b =. 10&#.
pv =. b^:_1
'h t u' =: _3{. pv n
assert. 3>:#cn
d1 =. hundreds h rt 90 fd 15 lt 90
d2 =. tens t  rt 90 fd 5 lt 90
d3 =. units u  rt 90 fd 5 lt 90
,d1,d2,d3
)





NB.  Calculation of plotting data from input stream

NB.  preprocess

Note 1
Cases
0    init
1    rt lt
2    fd bk

5    home
6    sethtowards newpos  ( moves heading to face newpos)
7    fddistance newpos  (moves distance to newpos on current heading)
8    plusx
9    plusy

Set
10   sethm
11   seth
12   setxy
13   setx
14   sety
15   setxyh



Queries
21   heading
22   xyval
23   xval
24   yval
25   xyhval


Controls
41   penup
42   pendown
43   hide turtle
44   show turtle

45   pen size      n a.

51   color
52   pen color     n a.
53   pen size, pen style  n a.

61   glcall        n a.
71   line
72   fill
)








help =: 3 : 0
require 'jview'
wdview TURTLEDOC
)

TURTLEDOC =: 0 : 0
TURTLE GEOMETRY FUNCTIONS

Contents:
1.  Turtle paths
2.  Numeric path verbs
3.  Path Verbs to control path character and
    information
4.  Verbs to report path information
5.  Show verbs and labels
6.  Saving Graphs to file and clipboard
7.  Verb definition
8.  Global nouns
9.  Utility verbs and some path functions

1.	TURTLE PATHS

A turtle path is a noun, and can be either
a numeric or character vector. If it is a numeric
vector it is a path which consists of a set of
fixed actions.  If it is a character vector it
is evaluated when it is to be displayed.

A path can include movements, changes of direction,
and actions which will modify how the path is
represented in a diagram.

Path verbs are designed to assist in constructing
turtle paths by putting a step on the beginning
of a path.  They should not be used in other contexts.


turtle_path  =. path_verb arguments, turtle_path

To simplify building a sequence of steps the
dyadic form

arguments1 path_verb arguments0, turtle_path

returns the right argument of a path verb which
will be executed with arguments1.  The left argument
may be a path


Each path verb reads its right
argument have a right argument which is
a path, and for those below with x, y or d a
single number prior to the remaining path.

x and y represent distances, d degrees,
p a path, s  a string and n an integer

Synonyms are shown in parentheses at the right
of a line.


2.	NUMERIC PATH VERBS

Basic Movements

fd x          Move turtle forward x   (forward)

bk x          Move turtle back x  (back)

rt d          turn turtle right d degrees  (right)

lt d          turn turtle left d degrees   (left)

repeat n      repeat the following path n times
              There is also a version with two boxed
              arguments, the first listing the number
              of repetitions and the second the path
              in character form.
              repeat 6 ; '(repeat 3 fd 1 rt 120) fd 1 rt 30'
              and
              repeat 6 ,(repeat 3 fd 1 rt 120) fd 1 rt 30
              generate identical results

Movements from current position leaving heading unchanged

plusx x       move turtle in xdirection x

plusy x       move turtle in ydirection x

plusxy x,y    moves turtle in both x and y directions

Setting position and heading
These change only the item specified

seth d        set heading from North d degrees
              positive values clockwise    (setheading)
              (The turtle geometry convention)

sethm d       set heading from East d degrees
              positive values anticlockwise
              (The standard mathematical convention)

setxy (x,y)   set position (x,y)             (setpos)

setx  x       set position x leaving y unchanged

sety  y       set position y leaving x unchanged

home          set position to origin and heading North


3.  PATH VERBS TO CONTROL CHARACTER AND INFORMATION

color rgb     set fill color to values of rgb vector (3 items)

fill p        fill the polygon defined by points on path

hide p        encloses a path with penup and pendown
              Use within parentheses within a path

hideturtle p  sets global to hide turtle on graph  (ht)
ht p

line p        draw a line through points on path

pencolor rgb  sets pen color values (3 items)

pendown p     set pen down (pdn)

penstyle s,t  sets size(s) and type (t)  limited range

penup p       set pen up  (pu)
              path can be empty    penup''

point n       save (x,y,h) at point on path with reference call n

rand x        generates a random number as an argument for
              a path function.  If x>0 in interval (0,x)
              and if x,0  in interval  (_1 1)* x%2

showturtle p  sets global to show turtle on graph  (st)
st p

start         use as  (x,y) start p  to place a path p with
              starting position (x,y)  Used for boxed paths
              x j. y values are also valid in left argument.
              The left argument may have many start points.
              If the right argument is a boxed list it uses
              items from the list for successive points.



4.  VERBS TO REPORT PATH INFORMATION

These verbs cannot be used in a path.  They require
global variables generated during execution of a show verb.

getxxx        verbs give values for the last displayed path
              After a show verb they will change  if the
              path is changed.

getx n        Returns x coordinate at point n
gety n        Returns y coordinate at point n
getxy n       Returns the (x,y) coordinates at point n
geth n        Returns the heading at point n

getpxxx       verbs give plot points for the last displayed path
              After a show verb they will change if the path is
              changed.

getpx n       Returns plot x coordinate at point n
getpy n       Returns plot y coordinate at point n
getpxy n      Returns plot (x,y) coordinates at point n
getph n       Returns the heading at point n

lastxy ''     query last position of a path after calls to
              either process or show a path

lasth''       query the last heading of a path after calls to
              either process or show a path



5.  SHOW VERBS AND LABELS

show          show a path.  Valid right arguments are
              an unboxed path (vector or array)
              a boxed path
              a list of boxed paths
              a character string whose execution generates
               a path
              a boxed character string or list of boxed
               character strings

              A character left argument defines a name for
              the plot form.

showf         The same as show but with a window size
              fixed by WINSIZE

showp         Shows a single path using the plot class.
              A left argument is treated as plotting options.

label		  label 0   resets LABELLIST to empty
label pxy l t defines a label and enters it in LABELLIST	
			  The arguments are
              pxy   if a single integer, point n
                    if a vector of 3 numbers, the point number
                    plus deltax and deltay in plot coordinates
                    Note plot coordinates are in the interval
                    (_1,1) so a characteristic delta is 0.06
              l    location  0  to right, 1 centred, 2 to left
              t    the text
              Examples:  label 0;0;'A'
                         label 2 0.06 0;0;'Wow'

addlabels g   Addlabels to displayed to graph g.  If g is empty
              it defaults to 'graph'.  addlabels uses the
              points from the most recently drawn graph.


6.  SAVING GRAPHS TO FILES AND CLIPBOARD

save f        save displayed graph with file name f
              (for windows use a full path name and type .wmf)

clip''        clip display to clipboard. (Note caution in Lab)

You can use any of the graph utilities (See Lab Graph utilities).

To select a named graph for further operations use
              gdselect 'name'


7.  VERB DEFINITION  (See Lab for details)

Use  to  to generate path verbs.  Standard J definitions can
used for other verbs.

to s;s        definition of simple path functions.

to s          definition of conditional path functions.

of            definition for monadic and dyadic functions


8.  GLOBAL NOUNS

SHOWTURTLE =: 1
TS         =: 0.12    NB.  Scale unit for turtles
COLOR      =: RED
WINSIZE    =: 200

TURTLECOLOR=: TEAL

The following globals may be useful after using a show verb.

LASTXYH       set by program after a show call - gives last
              point on path in original coordinates and heading
              both as complex numbers

zzN and zzG   rendered path and controls in original coordinates

WISI          rendered path and controls in isigraph coordinates (_1,1)



9.  UTILITY VERBS AND SOME PATH FUNCTIONS

Path functions:

arcr r,d   arc right on a circle radius r for d degrees

arcl r,d   arc left on a circle radius r for d degrees

arrow x    place an arrow length x on the path at the
           current position (See also solida below)

circle r   draw a circle of radius r

circlec r  draw a circle radius r about the current
           position

poly s,d   draw a polygon with side length s and
           exterior angle d

polyrd r,d draw an inscribed polygon with exterior angle
           d in a circle of radius r   Tangent at start
           position

polyrn r,n draw an inscribed polygon with n sides
           in a circle of radius r   Tangent at start
           position

solida x   place a solid arrow of length x on the path
           at the current position.

sq  s      draw a square of side s

sqc s      draw a square of side s centred on the current
           position

Utilities

for        adverb   "_1  applies verb to items in list
           use with parentheses in path structures

run        executes a script stored as a noun or as a file.
           If a file the file name must be boxed.

)


cocurrent 'base'
('jturtle';'jgl2';'z') copath 'base'
