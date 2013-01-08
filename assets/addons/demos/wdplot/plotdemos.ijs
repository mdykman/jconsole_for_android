NB. plotdemos
NB.
NB. run plot demos in session

3 : 0''
if. -.IFJ6 do.
  require 'droidwd gtkwd trig plot'
else.
  require 'dates files isigraph numeric plot'
end.
''
)

load '~addons/demos/wdplot/plexam.ijs'

coinsert_jdplot_ 'jzplot'

NB. =========================================================
plotdemos_z_=: 3 : 0
cocurrent 'jdplot'
sel=. {.y,0
sel=. 0 >. sel <. <:#PLOTNAMES
cmd=. ". 'D',sel pick PLOTNAMES
0!:100 'pd ''reset''',LF,cmd,LF,'pd ''show'''
)
