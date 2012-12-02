NB. Plot examples

coclass 'jdplot'

NB. include definitions from math/misc/trig
rfd=: *&(1p1%180)
sin=: 1&o.
cos=: 2&o.
sind=: sin @ rfd
cosd=: cos @ rfd

0!:0 <jpath '~addons/demos/wdplot/pldata.ijs'
DATHILO=: }. 'm' fread jpath '~addons/demos/wdplot/dm0396.txt'

NB. =========================================================
PLOTNAMES=: <;._2 (0 : 0)
JGRAPHICS
LINE
LINES
LINESTYLE
LINE2Y
LINEPATTERN
AREA
DOT
MARKER
SYMBOL
POLAR
STICK
BAR
BARS
HIST
ERRORBAR
HILO
PIE
PIEM
RADAR
POLY
CONTOUR
DENSITY
LINE3D
STICK3D
WIRE
SURFACE
SURFACEREV
SURFACES
SPHERE
SOLID
STELLATE
MULTI1
MULTI2
MULTI3
MULTI4
SAMPLER
RULE
KEYS
COLOR1
COLOR2
COLOR3
LOGS
LINE1
LINE2
CURVEFIT
LEGENDRE
PRIMERACE
CONTOUR1
PAT1
PAT2
WIRES
GAMMA
DRUM
SURFACE1
)

rand01=: ?@$ 0:

NB. =========================================================
NB. cubicspline        - calculate cubic spline
NB. y is a 2-row matrix x ,: f(x)
NB. result is x values;coefficient matrix,one row per interval.
cubicspline=: 3 : 0
diff=. }.-}:
'x y'=. y
h=. diff x
k=. diff y
w=. 3 * diff k % *: h
n=. +:(2}.x)-_2}.x
sm=. ,~_2+#x
m=. sm$}.,(sm+0 1){.(}:h),.n,.}.h
c=. 0,w %. m
a=. }:y
b=. (k%h) - h * ((+:c) + }.c,0) % 3
d=. (diff c,0) % 3 * h
(}:x);a,.b,.c,.d
)

NB. =========================================================
NB. interspline        - interpolate spline
NB. x is a result from cubicspline
NB. y is a set of x coordinates
NB. returns corresponding f(x) values
interspline=: 4 : 0
'i m'=. x
n=. <: +/ i <:/ y
(n{m) p. y-n{i
)

NB. =========================================================
legendre_pc=: 3 : 0
r=. 1 if. y=0 do. r return. end.
s=. 0 1 if. y=1 do. s return. end.
i=. 1
while. y >: i=. >:i do.
  p=. r
  r=. s
  s=. (((<:+:i)*0,r) - (<:i)*p,0 0 ) % i
end.
)

NB. =========================================================
NB. Bessel J2
BesselJ2=: 3 : 0
t=. 1r128p1 * i.129
r=. (cos +:t) * cos (sin t) */ y
(+/ r * 1,(127$4 2),1) % 384
)

normalrand=: 3 : '(2 o. +: o. rand01 y) * %: - +: ^. rand01 y'

NB. =========================================================
DAREA=: 0 : 0
year=.  1914 1928 1938 1948 1958 1964 1967
manu=.  125000 90700 89500 134400 94900 84900 83900
farm=.  57000 62439 39022 48252 40164 41563 37798
cler=.  3249 4558 4423 6120 6219 7395 8013
prof=.  4366 7729 11270 31636 32237 32035 33574
dat=.   100*|. (+/\  %"1  +/) prof, cler, farm,:manu
pd 'type area'
pd 'backcolor lightgray'
pd 'forecolor black'
pd 'gridcolor gray'
pd 'itemcolor blue,red,green,magenta'
pd 'xlabel ',":year
pd 'title Employment Trends by Percentage'
pd 'grids 1 0'
pd 'key Manufacturing Farming Clerical Professional'
pd 'keypos obr;keystyle h'
pd dat
)

NB. LegendText 'Professional';'Clerical';'Farming';'Manufacturing'

NB. =========================================================
DBAR=: 0 : 0
pd 'type bar'
pd 'axes 1 0'
pd 'xlabel ',":2001+i.6
pd 'title Bar Chart'
pd 0.6 0.8 1* _0.5+?.3#,:3 3 4 7 7 4
)

NB. =========================================================
DBARS=: 0 : 0
dat=. 0.6 0.8 1* >:?.3#,:3 3 4 7 7
xlab=. '"2001" "2002" "2003" "2004" "2005"'

pd 'sub 2 2'

pd 'new'
pd 'type bar'
pd 'ytic 1 0'
pd 'xlabel ',xlab
pd 'title Simple Bars'
pd {.dat

pd 'new'
pd 'type bar'
pd 'ytic 1 0'
pd 'xlabel ',xlab
pd 'title Grouped Bars'
pd dat

pd 'new'
pd 'type sbar'
pd 'ytic 2 0'
pd 'xlabel ',xlab
pd 'title Stacked Bars'
pd dat

pd 'new'
pd 'type fbar'
pd 'ytic 2 0'
pd 'xlabel ',xlab
pd 'title Floating Bars'
pd dat
)

NB. =========================================================
DCOLOR1=: 0 : 0
pd 'axiscolor white'
pd 'backcolor purple'
pd 'itemcolor yellow,lime'
pd 'labelcolor white'
pd 'pensize 8'
pd 'key lemon apple'
pd 'keystyle o'
pd 2 3 5 7 11,:4 6 5 4 8
)

NB. =========================================================
DCOLOR2=: 0 : 0
mth=. '"" "Feb-2004" "May-2004" "Aug-2004" "Nov-2004" ""'
g=. 158 156 156 147 148 149 144 138 134 129 129 132 121 125 122 132
b=. 135 129 133 132 132 133 135 132 138 132 131 135 132 128 132 140
s=. 115 119 121 117 116 115 113 109 113 111 107 110 108 103 106 112
pd 'type line,marker'
pd 'graphbackcolor mediumgray'
pd 'gridcolor 230 230 230'
pd 'axes 1 0;axiscolor slategray'
pd 'color red,blue,green'
pd 'pensize 2;markersize 1.5'
pd 'key "Sumatra" "Blue Mountain" "Peaberry"'
pd 'keypos obr;keystyle h'
pd 'xticpos ',":steps 0 15 5
pd 'yint 130'
pd 'xlabel ',mth
pd g,s,:b
)

NB. =========================================================
DCOLOR3=: 0 : 0
'x y'=. |:GOLDFIX
bgn=. todayno 2004,.(1+i.12),.1
ndx=. (+/ x </ bgn),<:#x
'j m d'=. |:todate ndx { x
lab=. (":each d) ,each (m-1) { MTH3
pd 'title 2004 London Gold Fix USD'
pd 'xrange 0 ',":<:#x
pd 'xticpos ',":ndx
pd 'xlabel ',; ' ',each lab
pd 'xcaption Source: The London Bullion Market Association'
pd y
)

NB. =========================================================
DCONTOUR=: 0 : 0
pd 'type contour'
pd 'backcolor 222 222 206'
pd 'bandcolor rgbclr'
pd 'framebackcolor white'
pd 'title sin(x) * sin(y)'
pd (];];sin */ sin) steps _3 3 50
)

NB. =========================================================
DCONTOUR1=: 0 : 0
x=. y=. i:2j50
z=. 4 <. {."1 *. ^. x j./ y
pd 'textfont arial 17 bold'
pd 'textcolor darkslateblue'
pd 'textc 500 _10x re ln (x + iy)'
pd 'sub 0 0 1000 _40x'
pd 'sub 1 2'
pd 'type contour'
pd 'title contour'
pd 'aspect 1'
pd 'contourlevels 30'
pd x;y;z
pd 'new'
pd 'type density'
pd 'title density'
pd 'aspect 1'
pd x;y;z
)

NB. =========================================================
DCURVEFIT=: 0 : 0
NB. try changing y
y=. 3 2 5 7 6 5 7 4
x=. i.#y
dat=. x,:y
m=. cubicspline dat
x2=. steps 0,(<:#y),50
y2=. m interspline x2
y3=. (3 lsfit dat) p. x2
y4=. (5 lsfit dat) p. x2
pd 'title Spline vs Cubic vs Quintic'
pd 'backcolor lightgray'
pd 'type symbol'
pd x;y
pd 'type line'
pd x2;y2,y3,:y4
)

NB. =========================================================
DDENSITY=: 0 : 0
dat=. (;];*/&sin~) steps _2 3 100
pd 'new'
pd 'backcolor teal'
pd 'new 0 80 500 920'
pd 'type density'
pd 'mesh 0'
pd 'bandcolor grayscale'
pd 'titlefont arial 18 italic'
pd 'title Gray-Scale Density'
pd dat
pd 'new 500 80 1000 920'
pd 'mesh 0'
pd 'type density'
pd 'titlefont arial 18 italic'
pd 'title Color-Coded Density'
pd dat
)

NB. =========================================================
DDOT=: 0 : 0
pd 'type dot'
pd 'pensize 2'
pd 'backcolor white'
pd 'title Dot'
pd ({.;{:)|: +.(%: * r.) p: i.4000
)

NB. =========================================================
DDRUM=: 0 : 0
NB. Vibrating Drum
NB. try modifying z coordinate of viewsize
NB. e.g. viewsize 1 1 0.2
NB.      viewsize 1 1 0.01
R=. steps 0 1 53
T=. steps 0 2p1 80
X=. R */ cos T
Y=. R */ sin T
Z=. (BesselJ2 R*11.6) */ cos +:T
pd 'new'
pd 'backcolor black;textcolor teal'
pd 'textfont arial 18 italic'
pd 'textc 800 950 Vibrating Drum'
pd 'new 0 40 1000 840'
pd 'noaxes;type surface'
pd 'edgecolor 2{GRAYSCALE'
pd 'backcolor black;color rbclr'
pd 'viewpoint 3 3 1'
pd 'viewsize 1 1 0.05'
pd X;Y;Z
)

NB. =========================================================
DERRORBAR=: 0 : 0
mid=. _5 + (?21#10) + 10*sin steps 0 3 20
hi=. mid+0.5+?21#5
lo=. mid-0.5+?21#5
pd 'title Error Bar'
pd 'titlefont arial 18 italic'
pd 'color blue'
pd 'type errorbar'
pd  hi,mid,:lo
)

NB. =========================================================
DGAMMA=: 0 : 0
gamma=. ! @ <:
real=. {. @ +.
x=. steps _3.5 4.5 60
y=. steps _1 1 60
z=. real gamma x j./ y
dat=. _3 >. 12 <. z
txt=. 'Gamma function near origin of complex plane'
pd 'new'
pd 'backcolor lightgray'
pd 'textfont arial 13 bold italic'
pd 'textr -50 70 ',txt
pd 'new 0 70 1000 930'
pd 'backcolor lightgray'
pd 'type surface'
pd 'color bgclr'
pd 'noaxes'
pd 'viewpoint _1 _1.5 0.5'
pd dat
pd'show'
)

NB. =========================================================
DGRID=: 0 : 0
dat=. (] ; sin@cos,:sin@*:) 0.05*i.80
pd 'backcolor white'
pd 'type line'
pd 'title Just Testing...'
pd dat
)

NB. =========================================================
DHILO=: 0 : 0
dat=. (-200 <.#DATHILO) {. DATHILO
dat=. ',' cut"1 dat
dat=. 2 3 4{"1 dat
dat=. |: ". &> dat
pd 'type hilo'
pd 'itemcolor darkblue'
pd 'title March 1996 Deutsche Mark Future'
pd 'titlefont arial 18'
pd dat
)

NB. =========================================================
DHIST=: 0 : 0
NB. redisplay to generate new random numbers
dat=. normalrand 1e5
bin=. +/ (i: 3j25) <:/ dat
val=. (#/.~ bin) (~.bin) } 27 $ 0
lab=. <;._1 ' -3 -2 -1 0 1 2 3'
lab=. lab (>:4*i.7) } 27 # <''
lab=. ;: ^:_1 '"' ,each lab ,each '"'
pd 'type hist'
pd 'title normalrand 1e5'
pd 'color red'
pd 'xlabel ',lab
pd val
)

NB. =========================================================
DJGRAPHICS=: 0 : 0
pd 'textfont arial 26 bold italic'
pd 'textcolor darkslateblue'
pd 'textc 500 _20x J Plot'
pd 'new 40x 20x -40x -70x'
pd 'title sin(exp) vs cos(exp)'
pd 'color red,green'
pd 'key sin(exp),cos(exp)'
x=. steps _1 2 100
pd x;sin ^x
pd x;cos ^x
)

NB. =========================================================
DKEYS=: 0 : 0
x=. steps _1 2 100
d1=. x;sin ^x
d2=. x;cos ^x

pd 'textfont arial 18 bold italic'
pd 'textcolor darkslateblue'
pd 'textc 500 _10x Key Styles'

pd 'sub 0 0 1000 _40x'
pd 'sub 2 2'

pd 'new'
pd 'color red,green'
pd 'keypos b'
pd 'key sin(exp),cos(exp)'
pd d1
pd d2

pd 'new'
pd 'color red,green'
pd 'keystyle o'
pd 'keypos r'
pd 'key sin(exp),cos(exp)'
pd d1
pd d2

pd 'new'
pd 'color red,green'
pd 'keystyle ho'
pd 'keypos bo'
pd 'key sin(exp),cos(exp)'
x=. steps _1 2 100
pd d1
pd d2

pd 'new'
pd 'color red,green'
pd 'keystyle hof'
pd 'keypos bro'
pd 'key sin(exp),cos(exp)'
pd d1
pd d2
)

NB. =========================================================
DLEGENDRE=: 0 : 0
x=. steps _1 1 100
y=. (legendre_pc"0 [ 2 4 6 8) p."1 x
pd 'type line'
pd 'pensize 2'
pd 'backcolor lightgray;'
pd 'color blue, red, darkgreen, magenta'
pd 'title Legendre Polynomials of order 2 4 6 8'
pd 'titlefont arial 15 italic'
pd x;y
)

NB. =========================================================
DLINE3D=: 0 : 0
u=. 0.5*steps 0 50p1 500
r=. sin steps (o. (,-.)0.1), 500
x=. r*sin u
y=. r*cos u
z=. 0.1*u
pd 'backcolor lightgray'
pd 'color red'
pd 'viewpoint 1.3 0.9 0.25'
pd 'viewsize 1'
pd x;y;z
)

NB. =========================================================
DLINE=: 0 : 0
x=. steps 0 360 60
lab=. ": steps 0 360 6
pd 'axes 1 0'
pd 'backcolor 222 222 206'
pd 'framebackcolor white'
pd 'key sin cos'
pd 'keycolor red,purple'
pd 'keypos tr'
pd 'xticpos ',lab
pd 'xlabel ',lab
pd 'type marker;color red'
pd x;sind x
pd 'type line,stick;color purple'
pd x;cosd x
)

NB. =========================================================
DLINES=: 0 : 0
opt=. 'type line;titlefont arial 13 italic'

pd 'sub 2 2'
pd 'new'
pd opt
pd 'ytic 100 1'
pd 'xtic 40 1'
pd 'xcaption x1'
pd 'ycaption one'
pd 'title Simple Line'
pd  *: 0.1*i.160

pd 'new'
pd opt
pd 'xcaption x2'
pd 'ycaption two'
pd 'ticstyle out'
pd 'title x cos(x) vs x sin(x)'
pd ((* cos) ; (* sin)) range 0 8 0.1

fn=. (cos@+: * cos,sin) "0
dat=. ({.;{:) |: fn range 0 2p1 0.05
pd 'new'
pd opt
pd 'ytic 0.5 1'
pd 'xtic 0.5 1'
pd 'xcaption x3'
pd 'ycaption three'
pd 'framestyle in'
pd 'title r=cos 2t for t in [0, 2pi]'
pd dat

pd 'new'
pd opt
pd 'ytic 0.5 1'
pd 'xtic 0.5 1'
pd 'aspect 1'
pd 'xcaption x4'
pd 'ycaption four'
pd 'title sin vs cos, sin*cos, aspect=1'
pd (sin;cos,:sin*cos) range 1 7.5 0.05
)

NB. =========================================================
DLINESTYLE=: 0 : 0
dat=. ((* cos) ; (* sin@(1.1&*)) ,: (* sin)) range 0 8 0.1

opt=. 'color red,darkgreen;textcolor darkblue;type line'

pd 'sub 2 2'
pd 'new'
pd opt
pd 'title Default Options'
pd 'titlefont arial 13 italic'
pd dat

pd 'new'
pd opt
pd 'title With Axes, Frame In, Tics Out'
pd 'axes 1'
pd 'framestyle in'
pd 'ticstyle out'
pd 'titlefont arial 13 italic'
pd dat

pd 'new'
pd opt
pd 'title No Tics, Labels'
pd 'tics 0;labels 0'
pd 'titlefont arial 13 italic'
pd dat

pd 'new'
pd opt
pd 'axes 1'
pd 'frame 0'
pd 'grids 0'
pd 'xtic 2 4;ytic 4 0'
pd 'gridcolor gray'
pd 'title No Frame, No Grid, Specified Tics'
pd 'titlefont arial 13 italic'
pd dat
)

NB. =========================================================
NB. two y axes
DLINE2Y=: 0 : 0
dat=. i:2.2j60

pd 'title Second Y Axis'
pd 'color blue,red'
pd 'ycaption Y Caption'
pd 'key "sin (left axis)", "exp (right axis)"'
pd (; sin) dat
pd 'y2axis'
pd 'ycaption Y2 Caption'
pd (;^) dat
)

NB. =========================================================
DLINEPATTERN=: 0 : 0
dat=. (;(sin+cos),sin,cos,(sin@+:),:cos&+:) steps 0 4 50
pd'new'
pd 'penstyle 0 1 2 3 4'
pd 'pensize 2'
pd 'color green,red,blue,magenta,brown'
pd 'title Line Patterns'
pd dat
)

NB. =========================================================
DLINE1=: 0 : 0
pd 'sub 2 2'
pd 'color blue'
pd 'color red'
pd 'title cos x * 12r7'
pd 'polar 1'
pd (cos x*12r7);x=. steps 1 48 1000

pd 'new'
t=. i:16j1000
y=. (^ cos t) - (+: cos 4*t) - (sin t%12) ^ 5
pd 'color blue'
pd 'color purple'
pd 'title Butterfly'
pd 'polar 1'
pd y;t + 0.5p1

pd 'new'
dat=. (;*cos) range _400 800,(0.99*1p1)
dat=. (;*cos) range _400 800,(0.99*1p1)
pd 'type line'
pd 'color green'
pd 'title x * cos x'
pd dat

pd 'new'
dat=. ((*sin);(*cos)) range 0 600,0.99*1r2p1
pd 'type line'
pd 'color blue'
pd 'color brown'
pd 'title (*sin),(*cos)'
pd dat
)

NB. =========================================================
DLINE2=: 0 : 0
fib=: 3 : ';/|:+.(%:5)%~(p^y)-(-.p)^y[p=.-:>:%:5'

pd 'textfont arial 17 bold'
pd 'textcolor darkslateblue'
pd 'textc 500 _10x Complex plots of Binet''s Fibonacci formula'
pd 'sub 0 0 1000 _40x'
pd 'sub 2 2'

pd 'new'
pd 'titlefont arial 13 bold'
pd 'titlecolor darkslateblue'
pd 'title from -6 to 0'
pd 'color blue'
pd fib steps _6 0 200

pd 'new'
pd 'titlefont arial 13 bold'
pd 'titlecolor darkslateblue'
pd 'title from 0 to 6'
pd 'color red'
pd fib steps 0 6 200

pd 'new'
pd 'titlefont arial 13 bold'
pd 'titlecolor darkslateblue'
pd 'title from -6 to 6'
pd 'color green'
pd fib steps _6 6 200

pd 'new'
pd 'titlefont arial 13 bold'
pd 'titlecolor darkslateblue'
pd 'title from 6 to 12'
pd 'color magenta'
pd fib steps 6 12 200
)

NB. =========================================================
DLOGS=: 0 : 0
x=. steps 1 3 30
y=. ^ x
pd 'textfont arial 17 bold italic'
pd 'textcolor darkslateblue'
pd 'textc 500 _20x Log Examples Y = exp (X)'
pd 'sub 5x 15x -5x -70x'
pd 'sub 1 3'
pd 'title Normal plot'
pd x;y
pd 'new'
pd 'title Y axis log scale'
pd 'ylog 1'
pd x;y
pd 'new'
pd 'title log (Y)'
pd x;10 ^. y
)

NB. =========================================================
DMARKER=: 0 : 0
len=. 100
x=. steps 0 3,len
y=. sin 1 2 3 4 5 6 */ x
m=. 0, len $ _10 {. 1
pd 'key one two three four five six'
pd 'keypos ro;keystyle c'
pd 'title Marker'
pd 'type line'
pd x;y
pd 'type marker'
pd (m#x);m #"1 y
)

NB. =========================================================
NB. simple multiplot example, no grouping
DMULTI1=: 0 : 0
pd 'multi 1 2,1 2 3'
pd 'title MultiPlot with no Grouping'
pd '';"1 |:(i.6) ^/ 1 + 0.2 * i.6
)

NB. =========================================================
NB. multiplot example
DMULTI2=: 0 : 0
pd 'multi 1 2,1 2 3'
pd 'title MultiPlot with Y Grouping'
pd 'ygroup 0 1'
pd '';"1 |: (i.6) ^/ 1 + 0.2 * i.6
)

NB. =========================================================
NB. multiplot example
DMULTI3=: 0 : 0
X=. i. each 6 + i.9
Y=. X ^ each 1 + 0.3 * i.9
pd 'multi 2 3 2,2 3 3'
pd 'title MultiPlot with Grouped Rows, Columns'
pd 'captionfont arial 13'
pd 'xcaption "col 1" "col 2" "col 3"'
pd 'ycaption "row 1" "row 2" "row 3"'
pd 'xgroup 0 1 2'
pd 'ygroup 0 1 2'
pd (<'type line'),. <"1 X,.Y
)

NB. =========================================================
NB. multiplot with various groupings
DMULTI4=: 0 : 0
p=. <"1 'type line';"1 |:(i.6) ^/ 1 + 0.2 * i.9
m=. 'type pie;color brown,red,green,purple;'
m=. (m,'keypos obr;keystyle of;key pecan cherry apple plum');p:i.4
n=. (4{p) , <'type line';<(p:i.8)
n=. (4 pick p) ,: 'type line,stick;color red';<(p:i.8)
s=. 'noaxes;textfont arial 16 bold;textcolor blue;textc 500 600 Grouped XY';''
p=. (m;n;<s) 4 5 8 } p
pd 'multi 2 3 2,2 3 2'
pd 'title Mixed MultiPlot'
pd 'captionfont arial 13'
pd 'xcaption "col 1" "col 2" "col 3"'
pd 'ycaption "row 1" "row 2" "row 3"'
pd 'xgroup 0 1 2 0 3 2 0 1 4'
pd 'ygroup 0 0 0 1 3 1 2 2 4'
pd p
)

NB. NB. =========================================================
NB. NB. simple subplot example (not multiplot)
NB. splot1=: 3 : 0
NB. pd 'reset'
NB. X=. i.6
NB. d=. |: X ^/ 1 + 0.2 * i.6
NB. pd 'sub 1 2,1 2 3'
NB. for_i. i.6 do.
NB.  pd 'new'
NB.  pd i{d
NB. end.
NB. pd 'show'
NB. )
NB.

NB. =========================================================
DPAT1=: 0 : 0
NB. try changing pqr
NB. e.g. 16 16 8
NB. e.g. 6 16 16
'p q r'=. 16 8 8
T=. steps 0 2p1 200
U=. T + (sin q*T)%p
V=. 2 + (sin r*T)%2
dat=. (V*cos U);V*sin U
pd 'noaxes'
pd 'backcolor darkblue;color red'
pd 'use 50 50 900 900'
pd 'pensize 1'
pd"1 (}.int01 30) *each / dat
)

NB. =========================================================
DPAT2=: 0 : 0
NB. try varying p1, p2, s:
NB. e.g. s=206, s=400, s=404
p1=. 101
p2=. 102 103
s=. 305
dat=. steps 0 2p1, s

pd 'noaxes'
pd 'pensize 1'
pd 'backcolor darkblue'
pd 'itemcolor magenta,red'
pd 'use 50 50 900 900'
pd (cos p1*dat);sin p2*/dat
)

NB. =========================================================
DPIE=: 0 : 0

pd 'backcolor lightgray'
pd 'textfont Arial 25 italic'
pd 'textcolor blue'
pd 'text 120 900 Elbow Room'

pd 'new 30 30 480 730'
pd 'clear 0'
pd 'titlefont Arial 16 italic'
pd 'title Population'
pd 'color red,blue,green,yellow,teal'
pd 'type pie'
pd  25 1008 684 117 229

pd 'new 510 200 960 900'
pd 'clear 0'
pd 'titlefont Arial 16 italic'
pd 'title Land Area'
pd 'color red,blue,green,yellow,teal'
pd 'type pie'
pd  9972 9587 3116 381 9160

pd 'new 500 0 1000 300'
pd 'clear 0'
pd 'color red,blue,green,yellow,teal'
pd 'key Canada China India Japan USA'
pd 'keystyle fo'
pd 'keypos br'
)

NB. =========================================================
DPIEM=: 0 : 0
pd 'title Multiple Pies'
pd 'type pie'
pd 'piepercent 1'
pd 'color red,blue,green,yellow'
pd 'keypos rmo'
pd 'keystyle b'
pd 'key red,blue,green,yellow'
pd 'captionfont arial 12 bold'
pd 'ycaption alpha,beta,gamma,delta,epsilon,zeta'
pd  1 + ?. 6 4$10
)

NB. =========================================================
DPOLAR=: 0 : 0
x1=. steps 0 20 1000
opt=. 'polar 1;color red,darkgreen;textcolor darkblue'
opt=. opt,';type line;titlefont arial 13 italic'

pd 'textfont arial 18 bold italic'
pd 'textcolor darkslateblue'
pd 'textc 500 _10x Polar Plots'

pd 'sub 0 0 1000 _40x'
pd 'sub 2 2'

pd 'new'
pd opt
pd 'title sin vs cos'
pd (sin;cos) x1

pd 'new'
pd opt
pd 'title sin @ (%&5)'
pd (sin @ (%&5) ; ]) x1

pd 'new'
pd opt
pd 'title r squared'
pd (*: ; ]) x1

pd 'new'
pd opt
pd 'title sin @ +:'
pd (sin@+: ; ]) x1
)

NB. =========================================================
DPOLY=: 0 : 0
reg=. +.@(_1:^2:*i.%])
triangulate=. [ (,"2) 2: ]\ ] , {.@]
det=. -/ . *
area=. det@border
border=. (,.%@!@{:@$)"2
treg=. 1r2 1r3 triangulate reg 4
dat=. ({."1;{:"1) treg

pd 'type poly'

pd 'backcolor lightgray'
pd 'itemcolor green, blue, red, yellow'
pd dat
)

NB. =========================================================
DPRIMERACE=: 0 : 0
NB. primes = 3 (mod 4) minus
NB. primes = 1 (mod 4)
NB. try: (begin,end) =       0, 100000
NB.             or      808000, 812000
primerace=: [: +/\ _2: + 4: | p:
begin=. 50000
end=. 52000
dat=. begin }.each (;primerace) i.end

pd 'title Prime Race'
pd 'backcolor lightgray'
pd 'color teal'
pd 'axes 1 0'
pd 'pensize 1'
pd dat
pd'show'
)

NB. =========================================================
DRADAR=: 0 : 0
j=. ,: 0.4 0.5 0.5 0.6 0.4
j=. j, 0.6 0.6 0.6 0.5 0.9
j=. j, 1 0.8 0.6 0.3 0.8
dat=. j

pd 'type radar'
pd 'title Radar Plot'
pd 'titlefont arial 18 italic'
pd 'backcolor lightgray'
pd 'gridcolor gray'
pd 'forecolor gray'
pd 'itemcolor red,blue,green'
pd 'axes 1'
pd 'grids 1'
pd 'pensize 2'
pd dat
)


NB. =========================================================
NB. Oleg's rule
DRULE=: 0 : 0
NB. Oleg's Rule Demo

DAT1=: 10?10
DAT2=: 4 4 4?10

pd 'sub 2 3'

NB. plot1
pd 'new'
pd 'sub 10x 0 _1x _10x'
pd 'textfont arial 13 bold underline'
pd 'text 0 _1x Simple Table'
pd 'textfont arial 10 bold'
pd 'text 0 _36x Variable'
pd 'text 100x _36x Value'

pd 'rulecolor gray;rulesize 1'
pd 'rule 0x _50x 205x _50x'

pd 'textfont arial 10'
pd 'text 0 _52x Key Styles'
pd 'text 0 _68x Key Styles'
pd 'text 0 _84x Key Styles'

pd 'text 100x _52x Key Styles 678'
pd 'text 100x _68x Key Styles'
pd 'text 100x _84x Key Styles 123'

pd 'endsub'

NB. plot2
pd 'new'
pd DAT1

NB. plot3
pd 'new'
pd 'sub 10x 0 _1x _10x'
pd 'textfont arial 13 bold underline'
pd 'text 0 _1x Fancy Table'
pd 'textfont arial 10 bold'
pd 'text 0 _36x Variable'
pd 'text 100x _36x Value'

pd 'rulecolor gray;rulesize 1'
pd 'rule 0x _34x 205x _34x'
pd 'rule 0x _50x 205x _50x'
pd 'rule 0x _100x 205x _100x'

pd 'textfont arial 10'
pd 'text 0 _52x Key Styles'
pd 'text 0 _68x Key Styles'
pd 'text 0 _84x Key Styles'

pd 'text 100x _52x Key Styles 678'
pd 'text 100x _68x Key Styles'
pd 'text 100x _84x Key Styles 123'

pd 'endsub'

NB. plot4
pd 'new'
pd 'type errorbar'
pd DAT2

NB. plot5
pd 'new'
pd 'sub 10x 0 _1x _10x'
pd 'textfont arial 13 bold underline'
pd 'text 0 _1x Full Table'
pd 'textfont arial 10 bold'
pd 'text 4x _36x Variable'
pd 'text 100x _36x Value'

pd 'rulecolor gray;rulesize 1'
pd 'rule 0x _34x 205x _34x'
pd 'rule 0x _50x 205x _50x'
pd 'rule 0x _100x 205x _100x'

pd 'rule 0x _34x 0x _100x'
pd 'rule 96x _34x 96x _100x'
pd 'rule 205x _34x 205x _100x'

pd 'textfont arial 10'
pd 'text 4x _52x Key Styles'
pd 'text 4x _68x Key Styles'
pd 'text 4x _84x Key Styles'

pd 'text 100x _52x Key Styles 678'
pd 'text 100x _68x Key Styles'
pd 'text 100x _84x Key Styles 123'

pd 'endsub'

NB. plot6
pd 'new'
pd 'type fbar'
pd DAT2
)

NB. =========================================================
DSAMPLER=: 0 : 0
pd 'sub 4 5'

pd 'new;type area'
pd  _6[\ 78 73 71 85 123 67 52 50 57 65 83 46 20 30 22 35 44 31

pd 'new;type bar'
pd  _6[\ 19 55 45 43 64 69 28 45 63 26 30 83 65 40 99 36 86 22

pd 'new;type density'
pd  ?6 6$100

pd 'new;type dot'
pd 'pensize 4'
pd  (sin,:cos) steps 0 5 8

pd 'new;type errorbar'
mid=. _5 + (?8#10) + 10*sin steps 0 3 7
pd mid +"1 [ _1 0 1 * 0.5 + ? 3 8 $ 5

pd 'new;multi 2 2;pensize 2;ygroup 0'
pd 'labels 0';"1 (sin,cos,(sin*cos),:cos@^@(%&2.5)) steps 0 6 20

pd 'new;type line,marker'
pd  cos 1.5 2 3 */ steps 1 3 7

pd 'new;type fbar'
pd  ?4 6$100

pd 'new;type line'
pd  ((sin+1:),:^%3:) i:2.2j60

pd 'new;type poly'
pd _5 [ \89 3 43 96 55 23 70 59 45 33

pd 'new'
pd 'sub 100 100 900 900'
pd 'type pie'
pd 'color red,blue,green,fuchsia,teal'
pd 7 2 5 3 5
pd 'endsub'

pd 'new;type line,stick;axes 1 0'
pd (;(*cos)) steps _3 7.8 30

pd 'new;type line;color red'
pd (sin;1:+2:*sin*cos) steps 0 10 100

pd 'new;type radar;pensize 2'
pd 5 + ? 1 + i.3 6

pd 'new;type surface;labels 0'
pd sin */~ steps 0 3 30

pd 'new;type line;polar 1'
t=. i:4j1000
y=. (^ cos t) - (+: cos 4*t) - (sin t%12) ^ 5
pd y;t + 0.5p1

pd 'new'
pd 'sub 100 100 900 900'
pd 'type poly;aspect 1;noaxes;viewsize 0.5 0.5 0.5'
pd 'color red,blue,yellow,green,fuchsia,teal'
pd <"2 @ (0 1&|:) dodecahedron_jzplot_''
pd 'endsub'

pd 'new'
pd 'sub 50 50 950 950'
pd 'type wire;noaxes;color teal'
pd 'viewpoint 1.5 3 1'
x=. | steps _8 8 19
d=. % + 0: = ]
pd (sin d ]) (+/&.*:)/~x
pd 'endsub'

pd 'new;type contour'
x=. range 0.4 1.4 0.025
pd x;x;+/~*:<:*:x

pd 'new;type hist;color red'
pd 3 2 5 8 10 5 12 4
)

NB. =========================================================
DSOLID=: 0 : 0
cut=. <"2 @ (0 1&|:)
CLR=: RED,GREEN,BLUE,FUCHSIA,AQUA,YELLOW,TEAL,BROWN

pd 'backcolor lightgray'
pd 'use 50 600 300 950;clear 0'
pd 'type poly;color clr'
pd 'noaxes;viewsize 1 1 1'
pd  cut cube''
pd 'use 700 600 950 950'
pd  cut tetrahedron''
pd 'use 50 50 300 400'
pd  cut octahedron''
pd 'use 700 50 950 400'
pd  cut dodecahedron''
pd 'use 288 180 700 800'
pd  cut icosahedron''
)

NB. =========================================================
DSPHERE=: 0 : 0
P=. steps 0 1p1 30
T=. steps 0 2p1 40
X=. (sin P) */ cos T
Y=. (sin P) */ sin T
Z=. (cos P) +/ T*0

pd 'backcolor blue'
pd 'new 150 0 850 1000'
pd 'clear 0'
pd 'type surface'
pd 'noaxes;viewpoint 2 2 1.5;color grayscale'
pd X;Y;Z
)

NB. =========================================================
DSTELLATE=: 0 : 0

pd 'backcolor lightgray'
pd 'use 25 50 375 550'
pd 'type poly;noaxes'
pd 'viewsize 1 1 1'
pd 'viewpoint 1 2 1'
pd cutxyz ,/0.3 stellate dodecahedron ''
pd 'use 350 150 950 900'
pd cutxyz ,/0.6 stellate icosahedron ''
)

NB. =========================================================
DSTICK=: 0 : 0
pd 'type line,stick'
pd 'color blue'
pd 'title Line,Stick'
pd 'axes 1 0'
pd (;(*cos)) steps _4 7.8 150
)

NB. =========================================================
DSTICK3D=: 0 : 0
u=. steps 0 6.5 150
r=. sin steps (o. (,-.)0.1), <:#u
x=. r*cos u
y=. r*(sin*cos) u
z=. 0.1*u

pd 'type stick'
pd 'backcolor lightgray'
pd 'color darkblue'
pd 'viewpoint _1 2 1'
pd 'viewsize 1 1 0.75'
pd x;y;z
)

NB. =========================================================
DSURFACE=: 0 : 0
dat=. (];];sin@*/~) i:2j70
pd 'type surface'
pd 'edgecolor 64 64 64'
pd 'backcolor lightgray'
pd dat
)

NB. =========================================================
DSURFACEREV=: 0 : 0
X=. steps _2 1.9 50
dat=. cutxyz 40 surfacerev (2+*:X);X
CLR=: (RED,:YELLOW) hue _8}.8}.int01 32

pd 'backcolor teal;color CLR'
pd 'edgecolor 64 64 64'
pd 'type surface'
pd dat
)

NB. =========================================================
DSURFACE1=: 0 : 0
NB. example of polar vs cartesian coordinates
NB. default polar coordinates (much better for this plot)
NB. uncomment second dat for cartesian coordinates
T=. steps 0 2p1 60
R=. steps 0.1 2 15
dat=. R ((*/cos);(*/sin);sin@+:@]) T
X=. steps _2 2 40
NB. dat=. (*%+&*:)"0/~X

pd 'backcolor black'
pd 'new 100 0 800 1000'
pd 'type surface'
pd 'color rbclr;backcolor black'
pd 'noaxes;viewpoint 2 4 1.5'
pd dat
)

NB. =========================================================
DSURFACE2=. 0 : 0
t=. steps 0 15 60
u=. steps _1 1 60
pd 'type surface'
pd 'backcolor lightgray'
pd 'viewpoint 4 4 2'
pd 'viewsize 1 1 2'
pd (u */ sin t);(u */ cos t);(#t)#,:t
)

NB. =========================================================
DSURFACES=: 0 : 0

pd 'sub 2 2'

pd 'new'
pd 'boxed 0'
pd 'viewpoint 0 _2 1.75'
pd 'viewsize 1'
pd 'type surface'
pd (];];^@-@+/&:*:)~steps _2 2 40

T=. steps 0 2p1 30
U=. steps _1p1 1p1 30
X=. (cos T)*/>:0.2*sin U
Y=. (sin T)*/>:0.2*sin U
Z=. 0.2*(sin T)*/cos U
pd 'new'
pd 'type surface'
pd 'backcolor black'
pd 'boxed 0'
pd 'bandcolor bgclr'
pd 'viewpoint 3 3 2.5'
pd X;Y;Z

C=. 0,.(255<.8*i.33),.64
T=. steps 0 2p1 50
X=. (sin T) */ 5+sin T
Y=. (cos T) */ 5+sin T
Z=. cos T

pd 'new'
pd 'backcolor darkblue'
pd 'new 70 70 930 930'
pd 'clear 0'
pd 'boxed 0'
pd 'mesh 0'
pd 'bandcolor ',":,C
pd 'type surface'
pd 'viewpoint 3 3 1.5'
pd 'viewsize 1 1 0.1'
pd  X;Y;Z

pd 'new'
pd 'type surface'
pd 'viewpoint 2 _1.2 1.5'
pd (];sin@];cos@*/)~ steps 0 3 40
)

NB. =========================================================
DSYMBOL=: 0 : 0
NB. displays lines and symbols
f=. ;(sin*cos),sin,:cos

pd 'title Symbol'
pd 'type line'
pd f steps _1 3 60
pd 'type symbol'
pd f steps _1 3 8
)

NB. =========================================================
DWIRE=: 0 : 0
x=. | steps _8 8 60
d=. % + 0: = ]
x=. (sin d ]) (+/&.*:)/~x
pd 'boxed 0'
pd 'type wire'
pd 'backcolor lightgray'
pd 'bandcolor darkblue'
pd 'title (sin x) % x'
pd 'viewpoint 2.5 3 0.75'
pd x
)

NB. =========================================================
DWIRES=: 0 : 0
dat=. (] % ^@+&*:)"0/~ steps _2.4 2.4 61
pd 'boxed 0'
pd 'type wire'
pd 'backcolor black'
pd 'bandcolor |.bgclr'
pd 'viewpoint 2 _5 0.7'
pd 'viewsize 1 1 0.5'
pd dat
)
