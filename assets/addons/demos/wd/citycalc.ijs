NB. cities demo - calculations

NB. following supports DLL demo:

3 : 0 ''
NB. regular system:
if. 3 = 4!:0 <'jpath' do.
  FILE=: jpath '~addons/demos/wd/cities.dat'
NB. DLL:
else.
  FILE=: (_3 }. BINPATH),'~addons/demos/wd/cities.dat'
end.
)

NB. average earth radius (kilometers, miles):
RADIUS=: 6371.007 3958.760

sin=: 1&o.
cos=: 2&o.
arccos=: _2&o.

NB. =========================================================
cityread=: 3 : 0
dat=. CR -.~ 1!:1 <FILE
dat=. '_' (I. dat='-') } dat

dat=. ] ;._2 dat
hdr=. 3 {."1 dat
msk=. -. hdr e. 'NB.',:' '
dat=. msk # dat
i=. dat i."1 ':'
BNAMES=: i<@{."0 1 dat
ONAMES=: (>BNAMES),.' '
CNAMES=: ;,&LF &.> BNAMES

x=. ". ,' ',.(>:i)}."0 1 dat
pos=. ((#dat),4)$x

LAT=: 1r10800p1 * 60 #. 2{."1 pos
LON=: 1r10800p1 * 60 #. 2}."1 pos

SINLAT=: sin LAT
COSLAT=: cos LAT

empty''
)

NB. =========================================================
citydistance=: 3 : 0
arccos (SINLAT*y{SINLAT)+(COSLAT*y{COSLAT)*cos(y{LON)-LON
)

NB. cityfmt
NB. argument has 3 elements:
NB.    ifmiles
NB.    ifdistance
NB.    city index
NB. result is text to display
cityfmt=: 3 : 0
'm d n'=. y
rad=. m{RADIUS
msk=. n ~: i.#BNAMES
dist=. <.0.5+rad*msk#citydistance n
txt=. (msk#ONAMES),.(":,.dist),"1 '   '
if. d do. txt=. txt /: dist end.
72 list txt
)

NB. cityfmts
NB. as cityfmt, but accepting string argument
NB. e.g. cityfmts 'True False Antwerp'
NB. (required for VB demo)
cityfmts=: 3 : 0
m=. (<'True') = 2{.y=. cutopen y
n=. }:;,&' '&.>2}.y
x=. BNAMES i. <n
,CRLF ,"1~ cityfmt m,x
)
