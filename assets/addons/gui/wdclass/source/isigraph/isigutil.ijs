NB. isigraph utilities
NB.
NB. use with isigraph.ijs
NB.
NB. points are a 2 element vector or 2 column matrix of x,y coordinates
NB. from (-1,-1) at bottom left, to (1,1) at top right.
NB.
NB. cile         x cile values of y
NB. fit01        fit values into range 0 1
NB. fit11        fit values into range _1 1
NB. fitrect01    fit rect values into range 0 1
NB. fitrect11    fit rect values into range _1 1
NB. grayscale    grayscale with values from 0 to 1
NB. hue          colors with values from 0 to 1
NB. hueRGB       variant of hue specifically for RGB colors
NB. polygon      vertices of regular polygon
NB. rotate       rotate points by angle
NB.
NB. HUES         standard color set

HUES=: 255*|."1#:7|3^i.7      NB. standard color set

NB. =========================================================
NB.*cile v x cile values of y
NB. example:
NB.    3 cile i.12
cile=: $@] $ ((* <.@:% #@]) /:@/:@,)

NB.*grayscale v generate grayscale
NB. example:
NB.   grayscale (i.%<:) 5
grayscale=: 3&#"0 @ >.@ (255&*)

NB. =========================================================
NB.*fit01 v fit data to range 0 1
NB. form: [anisotropic] fit data
NB.
NB. if left argument is 1, scales columns independently,
NB. otherwise applies same factors to all data,
fit01=: 3 : 0
0 fit01 y
:
dat=. y
s=. $dat
if. x=0 do. dat=. ,dat end.
min=. <./dat
max=. >./dat
s $ ,(dat -"1 min) %"1 max-min
)

NB. =========================================================
NB.*fit11 v fit data to range _1 1
fit11=: <: @: +: @: fit01

NB. =========================================================
NB.*fitrect01 v fit rectangle data to 0 1
NB. form: [anisotropic] fitrect01 data
NB.
NB. if left argument is 1, applies same factors to both columns
NB. otherwise, scales columns independently.
fitrect01=: 0&$: : (4 : 0)
s=. $y
'x y w h'=. |: _4[\ ,y
rx=. #x
d=. x fit01 (x,x+w) ,. y,y+h
'x xw'=. (2,rx)${."1 d
'y yh'=. (2,rx)${:"1 d
s $ , x,.y,.(xw-x),.yh-y
)

NB. =========================================================
NB.*fitrect11 v fit rectangle data to _1 1
fitrect11=: 3 : 0
s=. $y
'x y w h'=. |: _4[\ ,y
rx=. #x
d=. <: +: x fit01 (x,x+w) ,. y,y+h
'x xw'=. (2,rx)${."1 d
'y yh'=. (2,rx)${:"1 d
s $ , x,.y,.(xw-x),.yh-y
)

NB. ========================================================
NB.*hue v generate color from color set
NB. x is color set
NB. y is values from 0 to 1, selecting color
hue=: 4 : 0
y=. y*<:#x
b=. x {~ <.y
t=. x {~ >.y
k=. y-<.y
(t*k)+b*-.k
)

NB. ========================================================
NB.*hueRGB v generate color from RGB color se
NB. x is RGB color set (default HUES)
NB. y is values from 0 to 1, selecting color
hueRGB=: (HUES&$:) : (4 : 0)
<. 0.5 + x hue y
)

NB. ========================================================
NB.*polygon v vertices of a regular polygon
NB. y = number of points
NB. x = scale factor on angle 2p1%y  (default 1)
NB.
NB. e.g.   polygon 5 = pentagon
NB.      2 polygon 5 = 5 pointed star
polygon=: 1&$: : (4 : '|: clean 2 1 o./ (2p1*x%y)*i.>:y')

NB. ========================================================
NB.*rotate v rotate angle by given amount
NB.
NB. e.g. 0.5p1 rotate points = rotate clockwise a quarter turn
rotate=: 4 : 0
rot=. 2 2$1 1 _1 1*0 1 1 0{2 1 o. x
rot +/ . * "2 1 y
)
