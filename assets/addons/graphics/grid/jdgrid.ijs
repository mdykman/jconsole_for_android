coclass 'jdgrid'
coinsert 'jzgrid jgl2'

DFLIP=: 0
HDRCOL2=: ''
setnames=: 3 : 0
setnamesx y
size=. $CELLDATA
CELLMASK=: |."1 ^: DFLIP (|.i.{.size) >:/ i.{:size
)
flip=: 3 : 0

DFLIP=: -. DFLIP

rot=. (_1^DFLIP) * 0 >. (Ccls-Crws) + i.Crws
flp=. rot & (|."0 1)
shp=. Crws,Ccls
f=. ]`flp @. ($ -: shp"_)

CELLALIGN=: f CELLALIGN
CELLCOLOR=: f CELLCOLOR
CELLDATA=: f CELLDATA
CELLDRAW=: f CELLDRAW
CELLFMT=: f CELLFMT
CELLFONT=: f CELLFONT
CELLMASK=: f CELLMASK
CELLOVERFLOW=: f CELLOVERFLOW
CELLTYPE=: f CELLTYPE
if. DFLIP do.
  if. #HDRCOL2 do.
    HDRCOL1=: HDRCOL
    HDRCOL=: HDRCOL2
  end.
else.
  if. #HDRCOL2 do.
    HDRCOL=: HDRCOL1
  end.
end.
if. #CELLMARK do.
  'x y'=. 2 {. CELLMARK
  y=. y + (_1^DFLIP=0) * 0 >. x - Crws - Ccls
  CELLMARK=: x,y
end.
refresh''
)
moveto=: 3 : 0
'row col'=. y
'rmk cmk'=. getmark''
if. DFLIP do.
  if. row > col + Crws - Ccls do.
    if. rmk = cmk do.
      if. col < cmk do.
        row=. col + Crws - Ccls
      else.
        col=. row + Ccls - Crws
      end.
    else.
      row=. row <. cmk
      col=. col >. rmk
    end.
  end.
else.
  if. Crws <: row + col do.
    if. Crws = rmk + cmk + 1 do.
      if. row > rmk do.
        col=. Crws - row + 1
      else.
        row=. Crws - col + 1
      end.
    else.
      row=. row <. Crws - cmk + 1
      col=. col <. Crws - rmk + 1
    end.
  end.
end.
movetocell row,col
)
