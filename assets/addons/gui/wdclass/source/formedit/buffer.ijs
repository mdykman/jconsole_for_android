NB. buffer

NB. =========================================================
bufsnap=: 3 : 0
NB. drop off undone buffer:
if. #BUF do.
  BUF=: (1 + POS) {. BUF
end.
BUF=: BUF, (<CCS;CLS;CPS;IDS;STY;SELECT) -. _1 {. BUF
POS=: <: # BUF
selectdesign''
wd 'setenable undo ',": * POS
wd 'setenable redo 0'
)

NB. =========================================================
bufredo=: 3 : 0
if. POS < <: # BUF do.
  old=. IDS
  POS=: POS + 1
  'CCS CLS CPS IDS STY SELECT'=: POS pick BUF
  drawpaint ''
  design_enable''
  selectdesign''
  wd 'setenable undo 1'
  wd 'setenable redo ', ": POS < <: # BUF
end.
)

NB. =========================================================
bufundo=: 3 : 0
if. POS > 0 do.
  old=. IDS
  POS=: POS - 1
  'CCS CLS CPS IDS STY SELECT'=: POS pick BUF
  drawpaint ''
  design_enable''
  selectdesign''
  wd 'setenable redo 1'
  wd 'setenable undo ', ": POS > 0
end.
)
