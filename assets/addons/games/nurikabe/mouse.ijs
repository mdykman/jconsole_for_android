NB. mouse handling

NB. =========================================================
mmove=: 3 : 0
if. DONE do. return. end.
hit=. gethit''
if. #CARET do.
  if. hit ~: CARET do. charset'' end.
end.
drawhigh hit
)

NB. =========================================================
mbldown=: 3 : 0
CARET=: TEXT=: ''
if. DONE do. return. end.
ndx=. gethit''
if. EDIT do. return. end.
if. ndx >: 0 do.
  val=. ndx{,BOARD
  if. val>0 do. return. end.
  BOARD=: (val { _1 0 _2) ndx} BOARD
  buffer''
end.
draw''
)

NB. =========================================================
mbldbl=: 3 : 0
if. -. EDIT do.
  mbldown'' return.
end.
ndx=. gethit''
BOARD=: 0 ndx} BOARD
CARET=: ndx
TEXT=: ''
wd 'setfocus g'
draw''
)

