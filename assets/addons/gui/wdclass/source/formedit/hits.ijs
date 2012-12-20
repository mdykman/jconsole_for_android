NB. hits

NB. =========================================================
NB. test controls for box
boxtest=: 3 : 0
if. isempty CCX do. '' return. end.
bb=. 2 {. y
be=. bb + 1 + 2 }. y
bc=. 2 {."1 CCX
ec=. bc + 2 }."1 CCX
ndx=. I. *./"1 (bb <: "1 bc) ,. be >: "1 ec
ndx /: (ndx { CLS) = <'groupbox'
)

NB. =========================================================
NB. test controls for hit
hittest=: 3 : 0
best=. ''
for_i. i.#CCX do.
  if. y rtest i{CCX do.
    if. #best do.
      old=. 2{.best{CCX
      new=. 2{.i{CCX
      old=. +/y-old
      new=. +/y-new
      if. new<old do. best=. i end.
    else.
      best=. i
    end.
  end.
end.
, best
)

NB. =========================================================
NB. ab rtest xywh
rtest=: 4 : 0
xy=. 2{.y
wh=. xy+2}.y
*./(x>:xy),x<:wh
)
