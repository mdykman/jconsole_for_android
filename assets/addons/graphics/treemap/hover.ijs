NB. hover
NB.
NB. Hdef  - hover definition
NB. Hndx  - hover index

NB. =========================================================
clearhover=: 3 : 0
if. #Hdef do.
  glpixels Hdef
  glpaint''
  Hdef=: ''
  Hndx=: _1
end.
)

NB. =========================================================
NB. showhover
showhover=: 3 : 0
if. Hndx = y do. return. end.
clearhover''
Hndx=: y
hover Hndx { Sort,_1
)

NB. =========================================================
NB. hover event handler
NB. Index is location of mouse in source data, or _1 if not in window
hover=: 3 : 0
Index=: y
if. 1 = tmaphandler 'hover' do.
  hoverx''
end.
)

NB. =========================================================
hoverx=: 3 : 0
if. _1 = Hndx do. return. end.
showhoverdo ''
glpaint''
)

NB. =========================================================
showhoverdo=: 3 : 0
txt=. Hndx pick Note
'x y w h'=. Hndx { Txywh
pos=. (x,y) + Boxoff <. w,h
Hdef=: drawbox pos ; txt
)

