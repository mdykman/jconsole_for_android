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

NB. =========================================================
plotdemos_z_=: 3 : 0
cocurrent 'jdplotexam'

NB. TODO hack for qt
pd=: pd_jwplot_
cube=: cube_jwplot_
dodecahedron=: dodecahedron_jwplot_
icosahedron=: icosahedron_jwplot_
octahedron=: octahedron_jwplot_
tetrahedron=: tetrahedron_jwplot_
normalize=: normalize_jwplot_
stellate=: stellate_jwplot_
surfacerev=: surfacerev_jwplot_
cutxyz=: cutxyz_jwplot_
lsfit=: lsfit_jwplot_
int01=: int01_jwplot_
RED=: RED_jwplot_
GREEN=: GREEN_jwplot_
BLUE=: BLUE_jwplot_
FUCHSIA=: FUCHSIA_jwplot_
AQUA=: AQUA_jwplot_
YELLOW=: YELLOW_jwplot_
TEAL=: TEAL_jwplot_
BROWN=: BROWN_jwplot_

sel=. {.y,0
sel=. 0 >. sel <. <:#PLOTNAMES
cmd=. ". 'D',sel pick PLOTNAMES
0!:100 'pd ''reset''',LF,cmd,LF,'pd ''show'''
)
