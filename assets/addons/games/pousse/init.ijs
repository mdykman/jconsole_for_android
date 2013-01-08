NB. init for pousse

require 'droidwd gtkwd gl2 text'

coclass 'pousse'
coinsert 'jgl2 wdbase'
droidwd_run=: pousse

IFTEST=: 0

WHITE=: 255 255 255
BLACK=: 0 0 0
RED=: 224 0 0
GREEN=: 0 192 0

COLORS=: WHITE, BLACK, GREEN ,: RED
NB.       empty   grid   0      X

3 : 0 ''
if. IFTEST do.
  DEFSIZE=: 3
  IFAUTO=: 0
  IFTWO=: 1
else.
  DEFSIZE=: 4
  IFAUTO=: 1
  IFTWO=: 0
end.
)

IFGREENMOVE=: 0

PRED=: 'X'
PGREEN=: 'O'
