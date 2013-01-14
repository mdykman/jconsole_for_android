NB. text

NB. =========================================================
char=: 3 : 0
if. 0=#CARET do. return. end.
m=. 0 ". sysmodifiers
c=. {.sysdata
if. m do. charreset'' return. end.
if. c e. '0123456789' do.
  TEXT=: TEXT,c
else.
  if. c ~: 13{a. do.
    TEXT=: ''
  end.
  charset''
end.
draw''
)

NB. =========================================================
charset=: 3 : 0
BOARD=: ({. 0 ". TEXT) CARET} BOARD
CARET=: TEXT=: ''
)
