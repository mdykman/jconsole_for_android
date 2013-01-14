NB. mouse

NB. =========================================================
click=: 3 : 0
'Mx My Index Ctrl Shift'=: y
tmaphandler 'click'
)

NB. =========================================================
rclick=: 3 : 0
'Mx My Index Ctrl Shift'=: y
tmaphandler 'rclick'
)

NB. =========================================================
NB. mousexy
NB.
NB. returns xy position of mouse
mousexy=: 3 : '2 {. 0 ". sysdata__locP'

NB. =========================================================
NB. mousext
NB.
mousext=: 3 : '0 1 6 7 { 0 ". sysdata__locP'

NB. =========================================================
mbldown=: 3 : 0
'x y ctrl shift'=. mousext ''
ndx=. tmindex x,y
click x,y,ndx,ctrl,shift
)

NB. =========================================================
mbrdown=: 3 : 0
'x y ctrl shift'=. mousext ''
ndx=. tmindex x,y
rclick x,y,ndx,ctrl,shift
)

NB. =========================================================
mmove=: 3 : 0
xy=. mousexy''
if. xy inrect Sxywh do.
  showhover rectindex xy
else.
  clearhover''
end.
)

NB. =========================================================
rclick=: 3 : 0
'Mx My Index Ctrl Shift'=: y
tmaphandler 'rclick'
)
