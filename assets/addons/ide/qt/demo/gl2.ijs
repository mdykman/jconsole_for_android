NB. run

require 'gl2'

coclass 'm2'
coinsert 'jgl2'

NB. =========================================================
run=: 3 : 0
wd FORM
wd 'pmovex 0 0 450 350'
wd 'pshow'
EMPTY
)

FORM=: 0 : 0
pc demo closeok;pn "gl2 demo";
cc gs isigraph;
)

NB. =========================================================
NB. eric's demo
demo_gs_paint=: 3 : 0
'w h'=: glqwh''
NB. draw grid
glrgb 128 128 18
glpen 0 0
for_i. 50* i.>.h%50 do.
  gllines 0,i,w,i
end.
for_i. 50* i.>.w%50 do.
  gllines i,0,i,h
end.

glrgb 0 0 255
glpen 5 0
glrgb 120 120 120
glbrush''
glrect 0 50,w,20
glrgb 255 0 0
glpen 1 0
glrgb 0 0 255
glbrush''
glrect 10 10 5 5
glrect 15 15 5 5

NB. arc pie
glrgb 255 0 0
glpen 0 0
glrgb 0 0 255
glbrush''
glpie 40 140 60 60 200 70 70 0
glarc 100 100 160 160 300 170 170 0

NB. clip
glrgb 255 0 0
glpen 5 0
glrgb 0 0 255
glbrush''
glclip 40 40 200 100
glrect 20 20 200 200
glclipreset''
gllines 10 10 300 300

NB. text
glrgb 255 0 0
gltextcolor''
glfont '"courier new" 20'
gltextxy 150 150
glfontangle 450
gltext 'how now'

NB. polygon
glrgb 0 255 0
glpen 1 0
glbrush''
glpolygon 250 200 300 300 400 100 300 150

NB. ellipse
glellipse 200 200 200 100

NB. qpixels pixels
data=: glqpixels 200 200 40 40
smoutput 10{.data
glpixels 20 200 40 40,data
)

cocurrent 'base'
run_m2_''

