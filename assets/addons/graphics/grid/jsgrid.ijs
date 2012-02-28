coclass 'jsgrid'
coinsert 'jzgrid'

CELLEDIT=: 0
CELLCOLORS=: 0 0 0,255 255 255,255 255 255,51 102 204
CELLCOLOR=: 0
COLSCALE=: 1
GRIDSORT=: 1
GRIDROWMODE=: 1
HDRCOLALIGN=: 0
ifselectresult=: 3 : 0
3 = 4!:0 <'select_result__COCREATOR'
)
dblclick=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. (Row >: 0) *. ifselectresult'' do.
  select_result__COCREATOR Row
else.
  dblclickx''
end.
)
key=: 3 : 0
'Char Ctrl Shift'=: y
if. (Char = CR) *. ifselectresult'' do.
  select_result__COCREATOR {.CELLMARK
else.
  keyx''
end.
)
