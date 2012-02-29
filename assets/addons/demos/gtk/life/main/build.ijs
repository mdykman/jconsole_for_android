NB. build

mkdir_j_ jpath '~Demos/gtk/life/release/'
dat=. readsourcex_jp_ '~Demos/gtk/life/main'
dat=. dat, readsourcex_jp_ '~Demos/gtk/life/config'
dat fwrites jpath '~Demos/gtk/life/release/life.ijs'
