NB. build.ijs

cocurrent 'base'

f=. 3 : 0
mkdir_j_ jpath '~addons/demos/opengl/simple/'
(jpath '~addons/demos/opengl/simple/',y) fcopynew ::] jpath '~Addons/demos/opengl/simple/',y
)

files=. cutopen 0 : 0
bitmap.ijs
blend.ijs
build.ijs
cube.ijs
curve.ijs
fog2.ijs
fog.ijs
font3d.ijs
font.ijs
gldemos.ijs
lookat.ijs
nurbs.ijs
pickcube.ijs
pick.ijs
red.ijs
redlit.ijs
run.ijs
select.ijs
simple.jproj
simple.txt
sphere.ijs
surface.ijs
test.ijs
texture.ijs
wire.ijs
)

f each files
