NB. run
NB.
NB. nurikabe/run argument is either:
NB.   board  (integer matrix)
NB.   name;board
NB.   filename

NB. =========================================================
run=: 3 : 0
name=. file=. ''
if. 0=#y do.
  demoboard 1 return.
end.
if. L.y do.
  'name board'=. y
  if. 0=#board do.
    demoboard 1 return.
  end.
elseif. ischar y do.
  if. 0 = openboard y do.
    nk_close''
  end.
  return.
elseif. do.
  board=. y
end.
if. -.0 validate board do. nk_close'' return. end.
dat=. init board
SHAPE=: $dat
BOARD=: ,dat
FILE=: file
NAME=: name
CARET=: ''
nk_run 0
evtloop^:(-.IFJ6)''
)

NB. =========================================================
nurikabe_z_=: 3 : 0
a=. conew 'pnurikabe'
run__a y
)
