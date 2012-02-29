NB. life util

fix=: 0: ". ];._2
info=: mbinfo @ ('Life'&;)
ischar=: 2 = 3!:0
isempty=: 0 e. $
pack=: [: (,. ".&.>) ;: ::]
pdef=: 3 : '0 0$({."1 y)=: {:"1 y'

NB. =========================================================
bufinit=: 3 : 0
BUF=: MAXBUF # a:
HASBUF=: 0
)

NB. =========================================================
buffer=: 3 : 0
BUF=: }. BUF, <STATE
HASBUF=: 1
)

NB. =========================================================
enableback=: 3 : 'setenable stepback,y'

NB. =========================================================
fmtsize=: 3 : 0
'r c'=. y
(":r),' x ',":c
)

NB. =========================================================
iscolor=: 3 : 0
*./ (3=#y), y e. i. 256
)

NB. =========================================================
lifetimer=: 3 : 0
if. y do.
  sys_timer_z_=: life_timex~
  settimer y
else.
  sys_timer_z_=: 0:
end.
0
)
  
NB. =========================================================
NB. put
NB.
NB. put life form on board
put=: 3 : 0
'board pos new'=. y
ndx=. ($board) | each pos +each i.each $new
new (<ndx) } board
)

NB. =========================================================
NB. set form size
setformsize=: 3 : 0
gtk_widget_set_size_request canvas__locGB,SCALE*|.BOARD
)

NB. =========================================================
setlabsize=: 3 : 0
setlabel labSize;(":{.BOARD),'x',":{:BOARD
)

NB. =========================================================
setpattern=: 3 : 0
runinit y
glsel locGB
paint''
glpaintx''
)
