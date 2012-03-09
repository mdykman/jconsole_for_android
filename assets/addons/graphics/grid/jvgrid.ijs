coclass 'jvgrid'
coinsert 'jzgrid jgl2'
DATANAME=: ''
GRIDVIRTUALMODE=: 1
HDRCOL=: 0
HDRROW=: 0
setnames=: 3 : 0
setnamesx y
DataName=: getdataname ''
CELLRANGE=: <: |. $ DataName~
)
getdataname=: 3 : 0
nam=. , DATANAME
if. -. 1 e. ('_' = {:nam),'__' E. nam do.
  nam,'__locP'
end.
)
get=: 3 : 0
'rws cls'=. y
dat=. DataName~
'r c'=. $ dat
rws=. rws #~ (rws >: 0) *. rws < r
cls=. cls #~ (cls >: 0) *. cls < c
CELLDATA=: (<rws;cls) { dat
set ''
0
)
change=: 4 : 0
Value=: x
Cell=: y
if. gridhandler 'change' do.
  new=. Value
  if. ischar new do. new=. <new end.
  (DataName)=: new (<Cell) } DataName~
  changex''
end.
)
