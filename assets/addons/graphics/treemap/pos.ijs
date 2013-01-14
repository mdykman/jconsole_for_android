NB. pos

NB. =========================================================
drawpos=: 3 : 0
xy=. Rx,Ry
wh=. Rw,Rh
off=. Boxoff + Bxm,Bym
glfont FONT
row=. 0, {: glqextent 'X'
dat=. rounddint (*/wh) * Data % +/ Data
clr=. Color
lab=. Label
if. GRIDSHOW do.
  glpen 1 0 [ glrgb GRIDCOLOR
  pen=. ]
else.
  pen=. glpen
end.
while. #dat do.
  b=. >/ wh
  a=. b { wh
  s=. *: +/\ dat
  p=. (>.%) s % dat * *: a
  len=. 1 + p i. <./ p
  rec=. len {. dat
  wid=. roundint (+/rec) % a
  hit=. rounddint a * rec % +/ rec
  if. b do.
    y=. ({:xy) + 0,+/\}:hit
    rect=. ({.xy),.y,.1+wid,.hit
  else.
    x=. ({.xy) + 0,+/\}:hit
    rect=. x,.({:xy),.1+hit,.wid
  end.
  Txywh=: Txywh,rect
  for_r. rect do.
    glbrush glrgb (r_index{clr) { Colors
    pen 1 0
    glrect r
    pos=. off + 2 {. r
    for_t. <;._1 LF,>r_index{lab do.
      gltextxy pos
      gltext >t
      pos=. pos + row
    end.
  end.
  wh=. wh - wid * b ~: 0 1
  xy=. xy + wid * b ~: 0 1
  dat=. len }. dat
  clr=. len }. clr
  lab=. len }. lab
end.
'Tx Ty Tw Th'=: |: Txywh
EMPTY
)

