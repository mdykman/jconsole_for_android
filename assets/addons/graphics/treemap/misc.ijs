NB. misc

NB. =========================================================
initmisc=: 3 : 0
len=. $DATA
Colors=: _3 [\ ,COLORS
if. 0=#COLOR do.
  Color=: len $ i.#Colors
else.
  Color=: len $ COLOR
end.
Sort=: \: DATA
Data=: Sort{DATA
assert. 0 <: {: Data
Label=: Sort{LABEL
Color=: Sort{Color
if. len = #NOTE do.
  IfNote=: 1
  Note=: Sort{NOTE
else.
  IfNote=: 0
  Note=: ''
end.
)