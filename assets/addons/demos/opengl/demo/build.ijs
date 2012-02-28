NB. build.ijs

cocurrent 'base'

f=. 3 : 0
mkdir_j_ jpath '~addons/demos/opengl/demo/'
(jpath '~addons/demos/opengl/demo/',y) fcopynew ::] jpath '~Addons/demos/opengl/demo/',y
)

files=. cutopen 0 : 0
basic1.ijs
basic2.ijs
basic3.ijs
basic4.ijs
basic5.ijs
boys.ijs
braid.ijs
bucky.ijs
build.ijs
colored.ijs
crosscap.ijs
cups.ijs
demo.jproj
demo.txt
dini.ijs
drum.ijs
ennepers.ijs
frmount.ijs
gldemo.ijs
gldemrun.ijs
gledit.ijs
glview.ijs
glviews.ijs
helix.ijs
hypara.ijs
intsect1.ijs
jbox.ijs
jbw.bmp
klein.ijs
kuen.ijs
lissajou.ijs
maeder.ijs
model.ijs
moebius.ijs
roman.ijs
run.ijs
seashell.ijs
sellipse.ijs
soccer.ijs
solar.ijs
tank.ijs
teapot.ijs
test0.ijs
test.ijs
textb1.ijs
title.ijs
torus.ijs
trefoil.ijs
triangle.ijs
umbtorus.ijs
whitney.ijs
)

f each files
