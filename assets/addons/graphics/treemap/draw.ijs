NB. draw

NB. =========================================================
NB. drawbox
drawbox=: 3 : 0
'pxy txt'=. y
txt=. txt, LF
glfont FONT
w=. >./ glqextentw txt
h=. {: glqextent 'X'
txt=. <;._2 txt
wid=. w + +: Bxm
hit=. (h*#txt) + +: Bym
pxy=. pxy <. (Sw,Sh) - wid,hit
box=. pxy,wid,hit
res=. box, glqpixels box
glbrush glrgb 1 { BoxColor
glpen 1 0 [ glrgb 0 { BoxColor
glrect box
pos=. pxy + Bxm,Bym
step=. 0,h
for_t. txt do.
  gltextxy pos
  gltext >t
  pos=. pos + step
end.
res
)

NB. =========================================================
drawmap=: 3 : 0
drawinit''
drawback''
drawpos''
glpaint''
)

NB. =========================================================
drawback=: 3 : 0
glbrush glrgb BackColor
glpen 1 0
glrect Sxywh
)

NB. =========================================================
drawinit=: 3 : 0
glsel Hwndc
glclear''
glcursor IDC_ARROW
Txywh=: i.0 4
Hdef=: ''
Hndx=: _1
)
