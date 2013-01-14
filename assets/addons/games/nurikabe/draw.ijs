NB. draw

EDITON=: ;:'editcancel editok'
EDITOFF=: ;:'undo redo hint check'
j=. ;:'newboard openboard saveboard saveboardas'
EDITENABLE=: j, (<'board') ,each ": each 1 + i.9

COLORS=: 3 #&> 255 0 128
HIGHCOLOR=: 192 0 0
GRIDCOLOR=: 3 # 112
CARETCOLOR=: 216 216 255

FONT=: IFUNIX pick 'Arial';'SansSerif'

NB. =========================================================
draw=: 3 : 0
drawit''
glpaint''
)

NB. =========================================================
drawit=: 3 : 0
if. EDIT do.
  DONE=: 0
  drawboard'' return.
end.
if. -.DONE do.
  DONE=: checkdone 0
end.
drawboard''
if. DONE=1 do.
  glpaint''
  finished''
  DONE=: 2
end.
)

NB. =========================================================
NB. drawboard
drawboard=: 3 : 0
rc=. */'r c'=. SHAPE
glsel 'g'
'wid hit'=. _1 + glqwh''
x=. <. 0.5 + wid * (i.c) % c
w=. 1 + (}.x,wid) - x
y=. <. 0.5 + hit * (i.r) % r
h=. 1 + (}.y,hit) - y
POS=: (rc$x),.(c#y),.(rc$w),.c#h
clr=. (| 0 <. BOARD){COLORS
clr=. CARETCOLOR CARET} clr
glpen 1 0 [ glrgb GRIDCOLOR
POS drawrect"1 clr
glfont FONT,' ',":<. 0.45 * <./w,h
ndx=. I. 0 < ,BOARD
if. #ndx do.
  (ndx{POS) drawtext"1 0 ndx{BOARD
end.
if. DONE < HIGH >:0 do.
  glbrushnull''
  if. EDIT do.
    glpen 2 0 [ glrgb HIGHCOLOR
    glrect 1 1 _2 _2 + HIGH{POS
  else.
    glpen 1 0 [ glrgb HIGHCOLOR
    glrect HIGH{POS
  end.
end.
if. EDIT do. return. end.
if. DONE do.
  wd 'setenable undo 0'
  wd 'setenable redo 0'
  wd 'setenable hint 0'
  wd 'setenable check 0'
else.
  len=. #BUF
  wd 'setenable restart ',":len > 1
  wd 'setenable undo ',":BUFPOS > 0
  wd 'setenable redo ',":BUFPOS < len-1
  wd 'setenable hint 1'
  wd 'setenable check 1'
end.
)

NB. =========================================================
drawsetedit=: 3 : 0
wd 'psel ',":HWNDP
EDIT=: y
wd ;(<';setshow '), each EDITON ,each <' ',":EDIT
wd ;(<';setshow '), each EDITOFF ,each <' ',":-.EDIT
wd ;(<';setenable '), each EDITENABLE ,each <' ',":-.EDIT
)

NB. =========================================================
NB. draw highlight as mouse moves
drawhigh=: 3 : 0
if. HIGH -: y do. return. end.
HIGH=: y
drawboard''
glpaint''
)

NB. =========================================================
drawrect=: glrect@[ glbrush@glrgb

NB. =========================================================
drawtext=: 4 : 0
txt=. ":y
'wid hit'=. glqextent txt
'x y w h'=. x
gltextxy <.(x + -:w-wid),y+-:h-hit
gltext txt
)
