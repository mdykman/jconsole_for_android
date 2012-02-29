NB. example of mouse events
NB.
NB. draw with the mouse
NB. double-click toggles line style

REDFLAG=: 0

require 'gl2'

MOUSE=: 0 : 0
pc mouse closeok;
xywh 0 0 150 100;cc isigraph isigraph ws_border rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

mouse_run=: 3 : 0
wd MOUSE
mouse_isigraph_mbldbl''
wd 'pshow;'
)

mouse_isigraph_char=: 3 : 0
CHAR=: sysdata
)

mouse_isigraph_mbldbl=: 3 : 0
if. REDFLAG do.
  glrgb_jgl2_ 255 0 0
  glpen_jgl2_ 20 0
  REDFLAG=: 0
else.
  glrgb_jgl2_ 0 0 255
  glpen_jgl2_ 1 4
  REDFLAG=: 1
end.
)

mouse_isigraph_mbldown=: 3 : 0
d=. ". sysdata
x=. (0{d) * 1000 % (2{d)
y=. (1{d) * 1000 % (3{d)
glmove_jgl2_ x,y
)

mouse_isigraph_mmove=: 3 : 0
d=. ". sysdata
if. -.4{d do. return. end.
x=. (0{d) * 1000 % (2{d)
y=. (1{d) * 1000 % (3{d)
glline_jgl2_ x,y
glpaint_jgl2_''
)

mouse_isigraph_mbrdown=: 3 : 0
d=. ".sysdata
x=. (0{d) * 1000 % (2{d)
y=. (1{d) * 1000 % (3{d)
glellipse_jgl2_ (_20 _20 +x,y),40 40
glpaint_jgl2_''
)

mouse_close=: 3 : 0
wd 'pclose'
)

mouse_run''
