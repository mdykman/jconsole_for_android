coclass 'jtgrid'
coinsert 'jzgrid jgl2'

CELLEDIT=: 0
CELLRANGE=: 100 100
GRIDVIRTUALMODE=: 1
XPRECISION=: 1
HDRCOL=: 0
HDRROW=: 0

VERB=: '+'
get=: 3 : 0
'rws cls'=. y
if. XPRECISION do.
  rws=. x: rws
  cls=. x: cls
end.
dat=. ". 'rws ',VERB,'/ cls'
CELLDATA=: ": each dat
set ''
0
)

