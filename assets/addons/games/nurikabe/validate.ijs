NB. validate

NB. =========================================================
NB. simple validations on starting board
NB. x:
NB.  0 = opening board (no negatives)
NB.  1 = board in play (includes _1 _2)
validate=: 4 : 0
board=. y

if. 2 ~: #$board do. info 'Board should be a matrix.'
  0 return.
end.

if. 1 e. 5 > $board do.
  info 'Board should be a matrix with sides length 5 or more.'
  0 return.
end.

board=. ,board
if. x do.
  if. 1 e. _2 > board do.
    info 'Board should only have _1 and _2 negative entries.'
    0 return.
  end.
else.
  if. 1 e. 0 > board do.
    info 'Board should have no negative entries.'
    0 return.
  end.
end.

if. *./0 = board do.
  info 'Board should have some positive entries.'
  0 return.
end.

if. -. board -: <. board do.
  info 'Board should have only integer entries'
  0 return.
end.

1
)

