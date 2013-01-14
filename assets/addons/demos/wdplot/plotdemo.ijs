NB. plotdemo.ijs   - plot demos
NB.
NB. uses locale jdplot

3 : 0''
if. -.IFJ6 do.
NB.   GTKOUTPUT_jzplot_=: 'isi'
NB.   CONSOLEOUTPUT_jzplot_=: 'isi'
  require 'droidwd gtkwd graphics/plot'
else.
  require 'dates files isigraph numeric graphics/plot'
end.
''
)

path=. jpath '~addons/demos/wdplot/'
files=. path&,@(,&'.ijs') each ;: 'plexam plotdwin pledit plview'
coclass 'jdplot'
coinsert 'jzplot jafm jgl2 wdbase'
droidwd_run=: plotdemo_run

load files

plotdemo_run_jdplot_`start_droidwd_jdplot_@.(('Android'-:UNAME)>IFQT) 'jdplot'
