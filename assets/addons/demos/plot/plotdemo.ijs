NB. plotdemo.ijs   - plot demos
NB.
NB. uses locale jdplot

3 : 0''
if. -.IFJ6 do.
  if. IFJHS do. 13!:8[3 end.
  require 'plot numeric trig'
else.
  require 'dates files isigraph numeric trig plot'
end.
''
)

path=. jpath '~Demos/plot/'
files=. path&,@(,&'.ijs') each ;: 'plexam plotdwin pledit plview'
coclass 'jdplot'
coinsert 'jgtk jzplot jafm jgl2'
load files

plotdemo_run_jdplot_''
