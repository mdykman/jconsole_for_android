NB. draw controls

RCSIZE=: 12
CBSIZE=: 13

NB. =========================================================
RBHIGH=: ". ;._2 (0 : 0)
4 11
5 11
6 11
7 11
10 2
10 3
11 4
11 5
11 6
11 7
10 8
10 9
)

NB. =========================================================
RBLIGHT=: ". ;._2 (0 : 0)
9 3
10 4
10 5
10 6
10 7
9 8
2 9
3 9
8 9
9 9
4 10
5 10
6 10
7 10
)

NB. =========================================================
RBSHADOW=: ". ;._2 (0 : 0)
4 0
5 0
6 0
7 0
2 1
3 1
8 1
9 1
1 2
2 2
1 3
0 4
0 5
0 6
0 7
1 8
1 9
)

NB. =========================================================
RBDKSHADOW=: ". ;._2 (0 : 0)
4 1
5 1
6 1
7 1
2 2
3 2
8 2
9 2
2 3
1 4
1 5
1 6
1 7
2 8
)

NB. =========================================================
drawbox=: 4 : 0
glpen 1 0 [ glrgb x
glbrushnull''
glrect y
)

NB. =========================================================
drawbutton=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
r=. x + w
s=. y + h
x1=. x + 1
y1=. y + 1
r1=. r - 1
s1=. s - 1
glpen 1 0 [ glrgb HIGH
glbrush glrgb FACE
glrect x,y,w,h
glpen 1 0 [ glrgb LIGHT
gllines x1,y1,r,y1
gllines x1,y1,x1,s
glpen 1 0 [ glrgb SHADOW
gllines r1,y1,r1,s1
gllines x1,s1,r,s1
glpen 1 0 [ glrgb DKSHADOW
gllines x,s,r,s
gllines r,y,r,s+1
n=. n, (0=#n) # d
'nx ny'=. glqextent n
tx=. x + -: w - nx
ty=. (y + 2) >. y + -: h - ny
glclip 2 2 _3 _3 + x,y,w,h
gltextxy tx,ty
gltext n
glclipreset''
)

NB. =========================================================
drawcheckbox=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
glbrush glrgb FACE
if. 1 e. 'ws_border' E. s do.
  glpen 1 0 [ glrgb TEXT
  glrect x,y,w,h
  'x y w h'=. 1 1 _2 _2 + p
else.
  glpen 0 0 [ glrgb FACE
  glrect x,y,w,h
end.
y=. y + <. -: 0 >. h - RCSIZE
h=. RCSIZE
lt=. 1 e. 'bs_lefttext' E. s
x=. x + lt * w - h + 1
r=. x + h
s=. y + h
x1=. x + 1
y1=. y + 1
r1=. r - 1
s1=. s - 1
glpen 1 0 [ glrgb SHADOW
glbrush glrgb HIGH
glrect x,y,h,h
glpen 1 0 [ glrgb DKSHADOW
gllines x1,y1,r,y1
gllines x1,y1,x1,s
glpen 1 0 [ glrgb LIGHT
gllines r1,y1,r1,s1
gllines x1,s1,r,s1
glpen 1 0 [ glrgb HIGH
gllines x,s,r,s
gllines r,y,r,s+1
'x y w h'=. p
n=. n, (0=#n) # d
'nx ny'=. glqextent n
x=. x + 3 + RCSIZE * lt=0
w=. w - 3 + RCSIZE
tx=. x + 2
ty=. <: y + <. -: h - ny
glclip x,y,w,h
gltextxy tx,ty
gltext n
glclipreset''
)

NB. =========================================================
drawcombobox=: 3 : 0
'' drawinput y
'd s n c p'=. y
'x y w h'=. p
y=. y + CBSIZE*GSCALE
r=. x + w
x1=. x + 1
r1=. r - 1
glpen 1 0 [ glrgb LIGHT
gllines x1,y,r1,y
glpen 1 0 [ glrgb HIGH
gllines x,(y+1),r,y+1
glpen 1 0 [ glrgb SHADOW
gllines x,(y+2),r,y+2
glpen 1 0 [ glrgb DKSHADOW
gllines x1,(y+3),r1,y+3
)

NB. =========================================================
drawcombodrop=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
'' drawinput d;s;n;c;x,y,w,h

h=. h - 4
y=. y + 2
r=. x + w - 1
s=. y + h
x=. r - h + 1
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,h,h

glpen 1 0 [ glrgb HIGH
gllines 1 + x,y,(r-1),y
gllines 1 + x,y,x,s-1

glpen 1 0 [ glrgb SHADOW
gllines (x+1),(s-1),(r-2),s-1
gllines (r-2),(y+1),(r-2),s

glpen 1 0 [ glrgb DKSHADOW
gllines x,s,r,s
gllines (r-1),y,(r-1),s

w=. <. 0.25 * _2 + {. h
xy=. (x + >.-: h - +:w),y + <. -: h - w
glbrush glrgb TEXT
glpen 1 0
glpolygon (6$"1 xy) +"1/ 0 0,w,w,+:w,0
)

NB. =========================================================
drawgroupbox=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
y=. y + 5
h=. h - 5
HIGH drawbox (1+x,y),w,h
glpixel (x,y+h),:(x+w),y
SHADOW drawbox x,y,w,h
n=. n, (0=#n) # d
'w h'=. 4 0 + glqextent n
x=. x + 6
y=. y + 5 - -: h
glpen 0 0 [ glbrush glrgb FACE
glrect x,y,w,h
gltextxy (x+2),y
gltext n
)

NB. =========================================================
drawinput=: 4 : 0
'd s n c p'=. y
n=. (0 < #x) # d,' ',x
'x y w h'=. p
r=. x + w
s=. y + h
x1=. x + 1
y1=. y + 1
r1=. r - 1
s1=. s - 1
glpen 1 0 [ glrgb SHADOW
glbrush glrgb HIGH
glrect x,y,w,h
glpen 1 0 [ glrgb DKSHADOW
gllines x1,y1,r,y1
gllines x1,y1,x1,s
glpen 1 0 [ glrgb LIGHT
gllines r1,y1,r1,s1
gllines x1,s1,r,s1
glpen 1 0 [ glrgb HIGH
gllines x,s,r,s
gllines r,y,r,s+1
glclip 2 2 _3 _3 + x,y,w,h
gltextxy (2*IFJAVA) + 3 2 + x,y
gltext n
glclipreset''
)

NB. =========================================================
drawocx=: 3 : 0
'ocx' drawinput y
)

NB. =========================================================
drawprogress=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
SHADOW drawbox p
DKSHADOW drawbox p + 1 1 _2 _2
glpen 1 0 [ glrgb HIGH
gllines (x+w-1),y,(x+w-1),y+h
gllines x,(y+h-1),(x+w),y+h-1
)

NB. =========================================================
drawradiobutton=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
glbrush glrgb FACE
if. 1 e. 'ws_border' E. s do.
  glpen 1 0 [ glrgb TEXT
  glrect x,y,w,h
  'x y w h'=. 1 1 _2 _2 + p
else.
  glpen 1 0 [ glrgb FACE
  glrect x,y,w,h
end.
y=. y + <. -: 0 >. h - RCSIZE
h=. RCSIZE
lt=. 1 e. 'bs_lefttext' E. s
x=. x + lt * w - h
r=. x + h
s=. y + h
x1=. x + 1
y1=. y + 1
r1=. r - 1
s1=. s - 1
xy=. x,y
glbrush glrgb HIGH
glpen 1 0 [ glrgb FACE
glrect 1 1 _2 _1 + x,y,h,h
glpen 1 0 [ glrgb SHADOW
glpixel xy +"1 RBSHADOW
glpen 1 0 [ glrgb DKSHADOW
glpixel xy +"1 RBDKSHADOW
glpen 1 0 [ glrgb LIGHT
glpixel xy +"1 RBLIGHT
glpen 1 0 [ glrgb HIGH
glpixel xy +"1 RBHIGH
'x y w h'=. p
n=. n, (0=#n) # d
'nx ny'=. glqextent n
x=. x + 3 + RCSIZE*lt=0
w=. w - 3 + RCSIZE
tx=. x + 2
ty=. <: y + <. -: h - ny
glclip x,y,w,h
gltextxy tx,ty
gltext n
glclipreset''
)

NB. =========================================================
drawscrollbar=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
t=. h
s=. y + t - 1
x1=. x + 1
y1=. y + 1
xm=. x+t
xw=. x+w-t
xmt=. xm+t

NB. ---------------------------------------------------------
NB. total area
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,w,t

NB. ---------------------------------------------------------
NB. highlight
glpen 1 0 [ glrgb HIGH
gllines x1,y1,(xm-1),y1
gllines x1,y1,x1,s
gllines (x1+t),y1,(xmt-1),y1
gllines (x1+t),y1,(x1+t),s
gllines (xw+1),y1,(x+w-1),y1
gllines (xw+1),y1,(xw+1),s

NB. ---------------------------------------------------------
NB. shadow
glpen 1 0 [ glrgb SHADOW
gllines (xm-1),y1,(xm-1),s
gllines x1,(s-1),xm,s-1
gllines (xmt-1),y1,(xmt-1),s
gllines (x1+t+1),(s-1),(xmt),s-1
gllines (x+w-2),y1,(x+w-2),s
gllines (xw+1),(s-1),(x+w-2),s-1

NB. ---------------------------------------------------------
NB. dark shadow
glpen 1 0 [ glrgb DKSHADOW
gllines xm,y,xm,s+1
gllines x,s,xm,s
gllines xmt,y,xmt,s+1
gllines (x+t),s,xmt,s
gllines (x+w-1),y,(x+w-1),s
gllines xw,s,(x+w),s

glbrush glrgb HIGH
glpen 1 0
glrect (xmt+1),y,(w-1+3*t),t
glbrush glrgb HIGH
glpen 1 0 [ glrgb FACE
glpixel ((xmt+1),y) +"1 makedots (w-1+3*t),t

NB. ---------------------------------------------------------
h=. <. 0.25 * _2 + t
x=. x + <. -: t - h
y=. y + >.-: t - +:h
glbrush glrgb TEXT
glpen 1 0
glpolygon (x+h),y,x,(y+h),(x+h),y++:h
x=. x + w - t
glpolygon x,y,(x+h),(y+h),x,y++:h
)

NB. =========================================================
drawscrollbarv=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
t=. w
r=. x + t - 1
x1=. x + 1
y1=. y + 1
ym=. y + t
yh=. y + h - t
ymt=. ym + t

NB. ---------------------------------------------------------
NB. total area
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,t,h

NB. ---------------------------------------------------------
NB. highlight
glpen 1 0 [ glrgb HIGH
gllines x1,y1,x1,ym-1
gllines x1,y1,r,y1
gllines x1,(y1+t),x1,ym+t-1
gllines x1,(y1+t),r,y1+t
gllines x1,(yh+1),x1,y+h-1
gllines x1,(yh+1),r,(yh+1)

NB. ---------------------------------------------------------
NB. shadow
glpen 1 0 [ glrgb SHADOW
gllines x1,(ym-1),r,(ym-1)
gllines (r-1),y1,(r-1),ym
gllines x1,(ymt-1),r,(ymt-1)
gllines (r-1),(y1+t+1),(r-1),ymt
gllines x1,(y+h-2),r,(y+h-2)
gllines (r-1),(yh+1),(r-1),(y+h-2)

NB. ---------------------------------------------------------
NB. dark shadow
glpen 1 0 [ glrgb DKSHADOW
gllines x,ym,(r+1),ym
gllines r,y,r,ym
gllines x,ymt,(r+1),ymt
gllines r,(y+t),r,ymt
gllines x,(y+h-1),r,y+h-1
gllines r,yh,r,y+h

NB. ---------------------------------------------------------
glbrush glrgb HIGH
glpen 1 0
glrect x,(ymt+1),t,h-1+3*t
glpen 1 0 [ glrgb FACE
glpixel (x,ymt+1) +"1 makedots t,h-1+3*t

NB. ---------------------------------------------------------
w=. <. 0.25 * _2 + t
x=. x + >.-: t - +:w
y=. y + 1 + <. -: t - w
glbrush glrgb TEXT
glpen 1 0
glpolygon x,(y+w),(x+w),y,(x++:w),y+w
y=. y + h - t + 1
glpolygon x,y,(x+w),(y+w),(x++:w),y
)

NB. =========================================================
drawspin=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
x1=. x + 1
y1=. y + 1
w2=. >. -: w
w=. +: w2
r=. x+w
s=. y+h

NB. ---------------------------------------------------------
NB. total area
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,w,h

NB. ---------------------------------------------------------
NB. highlight
glpen 1 0 [ glrgb HIGH
glbrushnull''
glrect p + 1 1 _1 _1
gllines (x+w2+2),y1,(x+w2+2),s

NB. ---------------------------------------------------------
NB. shadow
glpen 1 0 [ glrgb SHADOW
gllines (r-1),y1,(r-1),s
gllines x1,(s-1),r,s-1
gllines (x+w2-1),y1,(x+w2-1),s

NB. ---------------------------------------------------------
NB. splitter
glpen 1 0 [ glrgb LIGHT
gllines (x+w2+1),y1,(x+w2+1),s

NB. ---------------------------------------------------------
NB. dark shadow
glpen 1 0 [ glrgb DKSHADOW
gllines r,y,r,s+1
gllines x,s,r,s
gllines (x+w2),y,(x+w2),s

NB. ---------------------------------------------------------
d=. <. 0.25 * _2 + w2 <. h
x=. x + <. -: w2 - d
y=. y + >.-: h - +:d
glbrush glrgb TEXT
glpen 1 0
glpolygon (x+d),y,x,(y+d),(x+d),y++:d
x=. x + w2
glpolygon x,y,(x+d),(y+d),x,y++:d
)

NB. =========================================================
drawspinv=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
x1=. x + 1
y1=. y + 1
h2=. >. -: h
h=. +: h2
r=. x+w
s=. y+h

NB. ---------------------------------------------------------
NB. total area
glbrush glrgb FACE
glpen 1 0 [ glrgb LIGHT
glrect x,y,w,h

NB. ---------------------------------------------------------
NB. highlight
glpen 1 0 [ glrgb HIGH
glbrushnull''
glrect p + 1 1 _1 _1
gllines x1,(y+h2+2),r,y+h2+2

NB. ---------------------------------------------------------
NB. shadow
glpen 1 0 [ glrgb SHADOW
gllines (r-1),y1,(r-1),s
gllines x1,(s-1),r,s-1
gllines x1,(y+h2-1),r,y+h2-1

NB. ---------------------------------------------------------
NB. splitter
glpen 1 0 [ glrgb LIGHT
gllines x1,(y+h2+1),r,y+h2+1

NB. ---------------------------------------------------------
NB. dark shadow
glpen 1 0 [ glrgb DKSHADOW
gllines r,y,r,s+1
gllines x,s,r,s
gllines x,(y+h2),r,y+h2

NB. ---------------------------------------------------------
d=. <. 0.25 * _2 + h2 <. w
x=. x + >. -: w - +:d
y=. y + <. -: h2 - d
glbrush glrgb TEXT
glpen 1 0
glpolygon x,(y+d),(x+d),y,(x++:d),y+d
y=. y + h2
glpolygon x,y,(x+d),(y+d),(x++:d),y
)

NB. =========================================================
drawstatic=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
glpen 0 0 [ glbrush glrgb FACE
glrect x,y,w,h
glclip 2 2 _3 _3 + x,y,w,h
gltextxy (2*IFJAVA) + 3 2 + x,y
n=. n, (0=#n) # d
gltext n
glclipreset''
)

NB. =========================================================
drawstaticbox=: 3 : 0
'd s n c p'=. y
DKSHADOW drawbox p
)

NB. =========================================================
NB. note this drawn like a group box with empty inside
drawtab=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
HIGH drawbox (1+x,y),w,h
glpixel (x,y+h),:(x+w),y
SHADOW drawbox x,y,w,h
)

NB. =========================================================
drawtrackbar=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
wb=. 11
w=. w >. wb
hb=. 8 >. 22 <. h
h2=. <. -: hb-6
glbrush glrgb FACE
glpen 1 0
glrect p
glbrush glrgb LIGHT
glpen 1 0 [ glrgb HIGH
glrect (x+wb),(y+h2-2),(w-wb),4
gllines x,y,(x+wb+1),y
gllines x,y,x,y+hb-6
xy=. (x+1+i.6),.(y+hb-6)+i.6
glpixel xy
glpen 1 0 [ glrgb LIGHT
gllines (x+1),(y+1),(x+1),y+hb-6
gllines (x+1),(y+1),(x+wb-1),y+1
glpixel 1 0 +"1 xy
glpen 1 0 [ glrgb SHADOW
xy=. (x+wb-i.6),.(y+hb-7)+i.6
gllines (x+wb),(y+1),(x+wb),y+hb-6
gllines (x+wb+1),(y+h2-1),(x+w-2),y+h2-1
glpixel xy
glpen 1 0 [ glrgb DKSHADOW
glpixel 0 1 +"1 xy
gllines (x+wb+1),y,(x+wb+1),y+hb-6
gllines (x+wb+1),(y+h2-2),(x+w-1),y+h2-2
glpen 1 0 [ glrgb TEXT
gllines (x+6),(y+hb+1),(x+6),y+hb+5
gllines (x+w-6),(y+hb+1),(x+w-6),y+hb+5
)

NB. =========================================================
drawtrackbarv=: 3 : 0
'd s n c p'=. y
'x y w h'=. p
hb=. 11
h=. h >. hb
wb=. 8 >. 22 <. w
w2=. <. -: wb-6
glbrush glrgb FACE
glpen 1 0
glrect p
glbrush glrgb LIGHT
glpen 1 0 [ glrgb HIGH
glrect (x+w2-2),(y+hb),4,h-hb
gllines x,y,x,y+hb+1
gllines x,y,(x+wb-6),y
xy=. (x+1+i.6),.(y+hb-6)+i.6
xy=. (x+wb-6-i.6),.y+1+i.6
glpixel xy
glpen 1 0 [ glrgb LIGHT
gllines (x+1),(y+1),(x+wb-6),y+1
gllines (x+1),(y+1),(x+1),y+hb-1
glpixel 0 _1 +"1 xy
glpen 1 0 [ glrgb SHADOW
xy=. (x+wb-i.6),.(y+hb-7)+i.6
xy=. (x+wb-7-i.6),.y+hb-i.6
gllines (x+1),(y+hb),(x+wb-6),y+hb
gllines (x+w2-2),(y+hb+1),(x+w2-2),y+h-1
glpixel xy
glpen 1 0 [ glrgb DKSHADOW
glpixel 1 0 +"1 xy
gllines (x+w2-1),(y+hb+1),(x+w2-1),y+h-2
gllines x,(y+hb+1),(x+wb-6),y+hb+1
glpen 1 0 [ glrgb TEXT
gllines (x+wb+1),(y+6),(x+wb+5),y+6
gllines (x+wb+1),(y+h-6),(x+wb+5),y+h-6
)

NB. =========================================================
drawcombolist=: drawcombodrop
drawedit=: 'edit' & drawinput
draweditm=: 'editm' & drawinput
drawisigraph=: 'isigraph' & drawinput
drawlistbox=: drawcombobox
drawrichedit=: 'richedit' & drawinput
drawricheditm=: 'richeditm' & drawinput
