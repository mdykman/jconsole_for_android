NB. test0

P=: jpath '~Addons/demos/opengl'

coinsert 'jgtk jzopenglutil'

dbg 1
dbstops''
NB. dbstops'gsdrawsurface'

load '~addons/demos/opengl/demo/gldemo.ijs'
smoutput GLDEMOSEL_jgldemo_
smoutput '   GLDEMOSEL_jgldemo_=: '''''
