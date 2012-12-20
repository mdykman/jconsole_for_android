NB. supports the isigraph control
NB.
NB. method:
NB.   gopen''      opens a graphics window
NB.   g...         fns to generate graphics
NB.   gshow''      show graphics
NB.
NB. points are plotted to pixels in a box with coordinates (0,0) at top left
NB.
NB. points should be given as a 2 element vector or 2 column matrix
NB. colors should be given as 3 numbers in range (0,255) for RGB,
NB. or as a single RGB number.
NB.
NB. see also isigutil.ijs for various supporting utilities.

NB. main functions:
NB. gbrush      set brush color
NB. gclear      clear graphics window (non-empty y is color)
NB. gfit        fit data to graphics window
NB. gopen       open graphics window
NB. glines      display lines
NB. gpolygon    display polygon given vertices
NB. gpen        set pen color and style
NB. gscale      scale from range (_1,1) to (0,1000)
NB. gshow       show graph
NB.

NB. =========================================================
NB.*gbrush v set brush color
gbrush=: glbrush_jgl2_ @: grgb

NB. =========================================================
NB.*gclear v clear graphics window
gclear=: 3 : 0
glclear_jgl2_''
if. #y do.
  gbrush y
  glrect_jgl2_ 0 0 1000 1000
end.
)

NB. =========================================================
NB.*gfit v fit data to graphics window
NB.
NB. scales each column of data independently to range (0,1000)
gfit=: 3 : 0
min=. <./y
max=. >./y
(y-"1 min)*"1 [ 1000%max-min
)

NB. =========================================================
NB.*glines v display line connecting points
NB.
NB. {color;width;style} glines points
NB.
NB. points should be a 2 column matrix of xy values
glines=: 3 : 0
gllines_jgl2_ y
:
glpen_jgl2_ x
gllines_jgl2_ y
)

NB. =========================================================
NB.*gopen v open graphics window
NB. y = controlname;parentname
NB.    if either empty, default to 'isigraph'
NB. e.g   gopen ''
NB.       gopen '';'J Graphics'
gopen=: 3 : 0
y=. 2{.}.0;y
'c n'=. (<'isigraph') (I. y=<'') }y
if. (<c) e. <;._2 wd 'qp;' do.
  wd 'psel ',c
  glclear_jgl2_''
else.
  wd 'pc ',c,' closeok;pn *',n
  wd 'xywh 0 0 150 150;cc g0 isigraph rightmove bottommove'
  wd 'pas 0 0;pcenter'
  fx=. 0 ". wd 'qformx'
  wd 'pmove 150 5 ',": 2 }. fx
  wd 'pshow;'
end.
)

NB. =========================================================
NB.*gpen v set pen color [;width,style]
NB. (default 1,0}
NB.
gpen=: 3 : 0
y=. boxopen y
'c ws'=. 2{. y,(#y)}.0 0 0;1 0
glpen_jgl2_ ws
grgb c
)

NB. =========================================================
NB.*gpolygon v draw polygon given points
NB. {color} gpolygon points
gpolygon=: 3 : 0
glpolygon_jgl2_ y
:
glbrush_jgl2_ grgb x
glpolygon_jgl2_ y
)

NB. =========================================================
NB.*grgb v set color values
grgb=: 3 : 0
clr=. y
if. 1=#clr do. clr=. 1 BGR`RGB@.RGBSEQ_j_ {.clr end.
glrgb_jgl2_ clr
)

NB. =========================================================
NB.*gscale v scale from (-1,1) to (0,1000)
gscale=: 500&* @ >:

NB. =========================================================
NB.*gshow v {parent} gshow graph
gshow=: 3 : 0
'isigraph' gshow y
:
wd 'psel ',x,';'
glpaint_jgl2_''
)
