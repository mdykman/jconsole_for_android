NB. order

NB. =========================================================
order=: 3 : 0
if. 0 = #CCS do.
  ORDER=: 0
else.
  ORDER=: -. ORDER
end.
SELECT=: $0
drawpaint ''
)

NB. =========================================================
order_select=: 3 : 0
sel=. hittest mousepos ''
if. isempty sel do. return. end.
msk=. (i.#CCS) ~: {. sel
if. ifctrlkey'' do.
  sortccs /: msk
  SELECT=: ,0
elseif. (#SELECT) *. ifshiftkey'' do.
  if. sel -: SELECT do. return. end.
  if. SELECT = <: #CCS do. return. end.
  new=. {. SELECT + 1
  sortccs /: (i.new), new + new }. msk
  SELECT=: , new
elseif. 1 do. return.
end.
drawpaint ''
)

NB. =========================================================
sortccs=: 3 : 0
ndx=. y
CCS=: ndx { CCS
CLS=: ndx { CLS
CPS=: ndx { CPS
IDS=: ndx { IDS
STY=: ndx { STY
SELECT=: ndx i. SELECT
)
