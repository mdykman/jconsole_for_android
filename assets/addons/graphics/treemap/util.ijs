NB. util

EMPTY=: i.0 0
SPARSETYPE=: 1024 2048 4096 8192 16384 32768

citemize=: ,:^:(2 > #@$)
index=: #@[ (| - =) i.
rounddint=: [: (- 0 , }:) ([: <. 0.5 + +/\)
roundint=: <.@:+&0.5

NB. =========================================================
getxywhx=: 0 0,glqwh

NB. =========================================================
gridfocus=: 3 : 0
if. IFUNIX >: ID -: sysfocus__locP do.
  wd 'setfocus ',ID
end.
)

NB. =========================================================
NB. inrect v test rectangles for hit
NB. form: pos inrect rects
NB. returns success flag
inrect=: 4 : 0
if. 0 = # y do. 0 return. end.
'px py'=. x
'x y w h'=. |: y
1 e. (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
)

NB. =========================================================
NB. inrectx v get index of hit in rectangles
NB. form: pos inrectx rects
inrectx=: 4 : 0
if. 0 = #y do. 0 return. end.
'px py'=. x
'x y w h'=. |: y
1 i.~ (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
)

NB. =========================================================
ispk=: 3 : 0
select. L. y
case. 0 do. 0
case. 1 do.
  if. 2 ~: {:$y do. 0 return. end.
  1 < >./ #@$ each y
case. do. 1
end.
)

NB. =========================================================
NB. readloc
NB.
NB. locale readloc namelist
readloc=: 4 : 0
nms=. y
if. 0 = L. nms do.
  nms=. ;: toupper nms
end.
nms=. nms -. <,LF
cnm=. nms ,each <'__x'
msk=. 0 = 4!:0 cnm
nms=. msk # nms
cnm=. msk # cnm
res=. nms
spx=. I. (3!:0@". &> cnm) e. SPARSETYPE
if. #spx do.
  for_s. spx do.
    (s{nms)=: ". > s{cnm
  end.
  spx=. <<<spx
  cnm=. spx{cnm
  nms=. spx{nms
end.
(nms)=: ". each cnm
res
)

NB. =========================================================
NB. define namelist or package from creator:
setnamesx=: 3 : 0
if. 0=#y do. return. end.
if. L. y do.
  unpack y
else.
  locP readloc y
end.
)

setnames=: setnamesx

NB. =========================================================
NB. shrinkrect
NB.
NB. form: rect shrinkrect xywh
shrinkrect=: 4 : 0
x + , 1 _1 * +/\ _2 [\ 4 $ y
)

NB. =========================================================
rectindex=: 3 : 0
'px py'=. y
m=. (px >: Tx) *. (px <: Tx + Tw) *. (py >: Ty) *. py <: Ty + Th
m index 1
)

NB. =========================================================
tmindex=: 3 : 0
(rectindex y) { Sort,_1
)

NB. =========================================================
unpack=: 3 : 0
if. 0 e. $y do. '' return. end.
y=. citemize y
nms=. toupper each {."1 y
(nms)=: {:"1 y
nms
)
