NB. script supporting the FFTW lab

require 'bmp'

real=: [: {."1 +.
imag=: [: {:"1 +.
reverse=: |.&.+.

HUES0=: ". ;._2 (0 : 0)
255   0   0
240 240   0
  0 255   0
  0 240 240
  0   0 255
240   0 240
255   0   0
)

HUES1=: ". ;._2 (0 : 0)
240 240   0
  0 255   0
  0 240 240
  0   0 255
240   0 240
240   0 120
255   0   0
)

HUES1=: ". ;._2 (0 : 0)
192 192   0
  0 255   0
  0 192 192
  0   0 255
192   64 192
224   64 64
255   0   0
)

phase=: 1: | ({:"1 @: *.) % 2p1"_

NB. temp fix for problem with *.
phase=: 3 : 0
'r i'=. |: +. y
s=. 0 > r
a=. _3 o. % %/"1 +. * y
n=. 1p1 -~ 2p1 | s # a
(i ~: 0) * n (I. s)} a
)

phase=: 3 : 0
shp=. $y
y=. ,y
'r i'=. |: +. y
s=. 0 > r
a=. _3 o. % %/"1 +. * y
n=. 1p1 -~ 2p1 | s # a
shp $ (i ~: 0) * n (I. s)} a
)

phase=: 3 : 0
shp=. $y
y=. ,y
'r i'=. |: +. y
s=. 0 > r
a=. _3 o. % %/"1 +. * y
n=. 1p1 -~ 2p1 | s # a
NB. t=. shp $ (i ~: 0) * n (I. s)} a
(y~:0) * shp $ n (I. s)} a
)


NB. =========================================================
NB.*colormat v create RGB color matrix from matrix argument
NB. x=0  amplitude=brightness, phase=hue
NB.    1  phase=brightness, amplitude=hue
colormat=: 0&$: : (4 : 0)
a=: (% >./ @: ,) | y
NB. b=: 1 | 2p1 %~ {:"1 *. y
b=: 1 | 2p1 %~ phase y
if. x do.
  siz=: b
  phs=: a
  hus=: HUES1 hue phs
  add=: ((1-siz) ^ 1.25) * 255 255 255 -"1 hus
else.
  siz=: a
  phs=: b
  hus=: HUES0 hue phs
  add=: ((1 - siz) ^ 1.25) * 255 255 255 -"1 hus
end.
(<. 0.5 + hus + add) +/ .* 1 256 65536
)

NB. =========================================================
NB.*hue v generate select color
NB. x is color set
NB. y is values from 0 to 1, selecting color
hue=: 4 : 0
y=. y*<:#x
b=. x {~ <.y
t=. x {~ >.y
k=. y-<.y
(t*k)+b*-.k
)

NB. =========================================================
view1=: (0&$:) : (4 : 0)
(x colormat y) writebmp jpath '~temp\ta.bmp'
if. wdisparent 'jbitmap' do. wd 'psel jbitmap' else.
  wd 'pc jbitmap closeok;pn View'
  wd 'xywh 0 0 100 100;cc g0 isipicture rightscale bottommove'
  wd 'pas 0 0;pcenter;'
end.
wd 'set g0 temp\ta.bmp'
wd 'pshow'
)

NB. =========================================================
view2=: (0&$:) : (4 : 0)
'a b'=. y
'c d'=. 2 $ x
(c colormat a) writebmp jpath '~temp\ta.bmp'
(d colormat b) writebmp jpath '~temp\tb.bmp'
if. wdisparent 'jbitmap' do. wd 'psel jbitmap' else.
  wd 'pc jbitmap closeok;pn View'
  wd 'xywh 0 0 100 100;cc g0 isipicture rightscale bottommove'
  wd 'xywh 101 0 100 100;cc g1 isipicture leftscale rightmove bottommove'
  wd 'pas 0 0;pcenter;'
end.
wd 'set g0 temp\ta.bmp'
wd 'set g1 temp\tb.bmp'
wd 'pshow;'
)

viewdemo=: 3 : 0
dat=. (j."1 0 |.) steps _1 1 50
0 1 view2 dat;dat
)

NB. B=: 21 21$22{.0 1
NB. 0 1 view2 B;B
NB. viewdemo''
